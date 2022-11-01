Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E73614C06
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKANtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKANsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AAA6140;
        Tue,  1 Nov 2022 06:48:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A040061455;
        Tue,  1 Nov 2022 13:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE4BC433D6;
        Tue,  1 Nov 2022 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667310524;
        bh=nd0dM0YiGevMBmIw3JCc/91WirhrGmiigVH7OCr9EG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qITFJWIw5nE67e/MvJ6BMM3CzhJhuhNuGzXbImQKrVLTjW1DVo16XYtnVhwFIWLv2
         QkOoTitJELopSzp9tpv3SyZVO4dskXfjpxZFl3U1tBJCc6rRZsWCLkzSayEbyci3Nv
         3o57qDMmUFlY29neDnE0gVwAlSp6QXycCuL8FVv8HuVHSdAVyMz+PzDGw4iY4Qfx4f
         NYxBh4wBKyWP9IJmE13zawMX+R3vBR83g+ROMugKdnBeHY0gyf4n13Z7kobJUR7F3N
         N1LMyweNgU4mD9CYrhGfDzrRnMLsqTjo/m80vWtvj6X5dihlsU8I/gRgbL9xtg4J/9
         bOEIVqbpjk9kA==
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
Subject: [PATCH v2 2/3] tools/perf: Fix to use dwarf_attr_integrate for generic attr accessor
Date:   Tue,  1 Nov 2022 22:48:39 +0900
Message-Id: <166731051988.2100653.13595339994343449770.stgit@devnote3>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <166731050151.2100653.8202870942871353491.stgit@devnote3>
References: <166731050151.2100653.8202870942871353491.stgit@devnote3>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use dwarf_attr_integrate() instead of dwarf_attr() for generic attribute
acccessor functions, so that it can find the specified attribute from
abstact origin DIE etc.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/perf/util/dwarf-aux.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 406b7bdc851a..216fc3d959e8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -308,7 +308,7 @@ static int die_get_attr_udata(Dwarf_Die *tp_die, unsigned int attr_name,
 {
 	Dwarf_Attribute attr;
 
-	if (dwarf_attr(tp_die, attr_name, &attr) == NULL ||
+	if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
 	    dwarf_formudata(&attr, result) != 0)
 		return -ENOENT;
 
@@ -321,7 +321,7 @@ static int die_get_attr_sdata(Dwarf_Die *tp_die, unsigned int attr_name,
 {
 	Dwarf_Attribute attr;
 
-	if (dwarf_attr(tp_die, attr_name, &attr) == NULL ||
+	if (dwarf_attr_integrate(tp_die, attr_name, &attr) == NULL ||
 	    dwarf_formsdata(&attr, result) != 0)
 		return -ENOENT;
 

