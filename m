Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED7B5FF937
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiJOIv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJOIvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:51:50 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36E454651;
        Sat, 15 Oct 2022 01:51:48 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id A38AEC024; Sat, 15 Oct 2022 10:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823908; bh=1euOEtvAzngNi5tOEtHvU2g07zt8twsjbJseQrxw3/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2na0Z7O6DDAL/XJhG3/mZoVkgInovy0aoYr2M4VJJ3+lT+sL2d+2CPNrzt0Kdr41Y
         b9A4YBiJ1XpfAxIzZXM7GddWeA1P0krGTy+M7mCAwUtdKFBSy3aXTtfinZwXI799FC
         JARlCN0aUzf2nxIJMtEh4DtaEBf8FeC5SSRH7AdP49E4sdWG7hdqJ6gwzPYlH/Zc+D
         fhgqqtI4BYs7d+/LrMx3gvDOzbl0nY5SvEoS+lBsWu1rW6cpMATAEBv7U//BBAn8Xi
         09mH+TC3pzHC8vjFYXHYl2lwYwfQwSRbGrIhOqHUXg7fVyp8wbMmeV7j9+W64Y/7tI
         G4EEg31SwFhZQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id BDBC5C020;
        Sat, 15 Oct 2022 10:51:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823907; bh=1euOEtvAzngNi5tOEtHvU2g07zt8twsjbJseQrxw3/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnq4vPZ/QmSAyLR+yquu4pQ8U/uTET7ndaoLMTwFIdzKRCSoxXv0ibIfppZ5g/6Lb
         jNQFKZVkYvAGr+fAFrqN+dpN+fX8fWKZ7tFBsO3z6AR5SBGIpudVDJkozm8V+rcsEE
         M1uohDVFjbjzqghnjECTMOmMxeNzG1N8dLoHjyuzlIVaupFdo9kSt9ABm7O6bxrZuN
         QULIjhTrlut5vqHtFYt8v7VHrzSJUE45oEUAL369f3CySjQ+hi8mqT1osQpZtG/hpV
         hcO3SEFtitYETkStLDAVo0p/eFWJksaEB8KnjrR4tFPivIr22wPRytYKHQRhy/oqUy
         EvKSvjlRfO5gA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id cd04f15d;
        Sat, 15 Oct 2022 08:51:38 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH v2 3/3] perf parse-events: Allow names to start with digits
Date:   Sat, 15 Oct 2022 17:48:13 +0900
Message-Id: <20221015084810.2114158-3-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221015084810.2114158-1-asmadeus@codewreck.org>
References: <20221015084810.2114158-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracepoints can start with digits, although we don't have many of these:

$ rg -g '*.h' '\bTRACE_EVENT\([0-9]'
net/mac802154/trace.h
53:TRACE_EVENT(802154_drv_return_int,
...

net/ieee802154/trace.h
66:TRACE_EVENT(802154_rdev_add_virtual_intf,
...

include/trace/events/9p.h
124:TRACE_EVENT(9p_client_req,
...

Just allow names to start with digits too so e.g. perf probe -e '9p:*'
works

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Changelog:
 v1 at https://lkml.kernel.org/r/20220612061508.1449636-1-asmadeus@codewreck.org
 v1->v2: add extra test now it doesn't break for everyone else :)

Ian suggested simplifying the name regex to:  [a-zA-Z0-9_*?\[\]!]+
but that:
- breaks probe names with a dot; or if we add a dot allows them to start
  with one
- also allows probes to start with !

I don't think that'd break anything if we allow .! as leading character
but it doesn't really make much difference to me either so I kept the
patch minimal: please say if you have an opinion.


 tools/perf/tests/parse-events.c | 5 +++++
 tools/perf/util/parse-events.l  | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a8b5a570aaf6..0dc1fbc80447 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1941,6 +1941,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__exclusive_group,
 		/* 7 */
 	},
+	{
+		.name  = "9p:9p_client_req",
+		.check = test__checkevent_tracepoint,
+		/* 8 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 3a9ce96c8bce..360f3c5de4fd 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -211,7 +211,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
+name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
 name_tag	[\'][a-zA-Z_*?\[\]][a-zA-Z0-9_*?\-,\.\[\]:=]*[\']
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
-- 
2.37.3

