Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C161A71F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 04:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKEDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 23:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKEDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 23:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ECA419BA;
        Fri,  4 Nov 2022 20:01:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EA8662337;
        Sat,  5 Nov 2022 03:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22A2C433D6;
        Sat,  5 Nov 2022 03:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667617278;
        bh=XWBTGLGkXGLU+mCSt2cLIm7GsobSKxeFBJJ1G4ny2WA=;
        h=From:To:Cc:Subject:Date:From;
        b=pJLO5YjHw8ouJzmGFDcAsrpsp5fV2ZA8bc1w6djo1w/vhlPhSrpQbjQ45ChpGJJoW
         bwxmk6QobTDpSPZZNSad6ROf9CQNd4cwqBRTsOGUsdxrkRBhc9uM1+W99JrnKa7HSO
         CJ4wU3dFKsOQBnBnkR+krZ80Hf9oUK9JlO6BKoQjWDH8Uld4Cmb8+FiMZNGvm0NALR
         emPaPy5yMGk80Yr7ni2DCXJGKi3JpnCWRXMgb8V2qSXE7uhq9XbNrXp+YIUyJjO5pj
         zy6f8tXRDN96sBIZXoylugFmJgFiCUEPigGeiSxNQ3IJtuZog2in38QUw6zlELMZSk
         GPuiDx4IRe3mw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tools/perf: Fix to get the DW_AT_decl_file and DW_AT_call_file as unsinged data
Date:   Sat,  5 Nov 2022 12:01:14 +0900
Message-Id: <166761727445.480106.3738447577082071942.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Dwarf version 5 standard Sec 2.14 says that

  Any debugging information entry representing the declaration of an object,
  module, subprogram or type may have DW_AT_decl_file, DW_AT_decl_line and
  DW_AT_decl_column attributes, each of whose value is an unsigned integer
  constant.

So it should be an unsigned integer data. Also, even though the standard
doesn't clearly say the DW_AT_call_file is signed or unsigned, the
elfutils (eu-readelf) interprets it as unsigned integer data and it is
natural to handle it as unsigned integer data as same as DW_AT_decl_file.
This changes the DW_AT_call_file as unsigned integer data too.

Fixes: 3f4460a28fb2 ("perf probe: Filter out redundant inline-instances")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 30b36b525681..b07414409771 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -315,19 +315,6 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
 	return 0;
 }
 
-/* Get attribute and translate it as a sdata */
-static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
-			      Dwarf_Sword *result)
-{
-	Dwarf_Attribute attr;
-
-	if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
-	    dwarf_formsdata(&attr, result) != 0)
-		return -ENOENT;
-
-	return 0;
-}
-
 /**
  * die_is_signed_type - Check whether a type DIE is signed or not
  * @tp_die: a DIE of a type
@@ -467,9 +454,9 @@ int die_get_data_member_location(Dwarf_Die *mb_die, Dwarf_Word *offs)
 /* Get the call file index number in CU DIE */
 static int die_get_call_fileno(Dwarf_Die *in_die)
 {
-	Dwarf_Sword idx;
+	Dwarf_Word idx;
 
-	if (die_get_attr_sdata(in_die, DW_AT_call_file, &idx) == 0)
+	if (die_get_attr_udata(in_die, DW_AT_call_file, &idx) == 0)
 		return (int)idx;
 	else
 		return -ENOENT;
@@ -478,9 +465,9 @@ static int die_get_call_fileno(Dwarf_Die *in_die)
 /* Get the declared file index number in CU DIE */
 static int die_get_decl_fileno(Dwarf_Die *pdie)
 {
-	Dwarf_Sword idx;
+	Dwarf_Word idx;
 
-	if (die_get_attr_sdata(pdie, DW_AT_decl_file, &idx) == 0)
+	if (die_get_attr_udata(pdie, DW_AT_decl_file, &idx) == 0)
 		return (int)idx;
 	else
 		return -ENOENT;

