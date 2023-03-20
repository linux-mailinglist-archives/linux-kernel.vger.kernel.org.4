Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAD6C226D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjCTUTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCTUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:19:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E846910EE;
        Mon, 20 Mar 2023 13:19:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83AB721972;
        Mon, 20 Mar 2023 20:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679343584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7ucnq/15x0Rp5y93lmb1JxxHhCgn0FI/1MqBXviDdYc=;
        b=DOXtZuIVccyZaRhxA73eVSlad8fdHLPJfr2kZztTvM1xKfX1WjG5kvtwwpanJxT77cZdFH
        E9+Mf9ZOG4EgEXVgS0BpBzX+GecwKEd0d7UjiaN2qHLVE0zC7P6HpC/5/VxuktkCghmrj+
        Bdq6CxAaTjjnt1qyIbk6txfx8x+0t3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679343584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7ucnq/15x0Rp5y93lmb1JxxHhCgn0FI/1MqBXviDdYc=;
        b=crtaprWVbsl8tnFtDT6lz5ogviRpiqtcUqYIZ78+qWdjBes3waaBVPPIXNXZLZRPnRIaX8
        vmdVjcL1GbIjjxCQ==
Received: from bernhard.suse.de (bernhard.suse.de [10.160.4.191])
        by relay2.suse.de (Postfix) with ESMTP id 5F60B2C141;
        Mon, 20 Mar 2023 20:19:44 +0000 (UTC)
Received: by bernhard.suse.de (Postfix, from userid 16894)
        id 49ADAE0EDD; Mon, 20 Mar 2023 21:19:44 +0100 (CET)
From:   "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: [PATCH] perf jevents: Sort list of input files
Date:   Mon, 20 Mar 2023 21:18:41 +0100
Message-Id: <20230320201841.1133-1-bwiedemann@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this, pmu-events.c would be generated with variations in ordering
depending on non-deterministic filesystem readdir order.

I tested that pmu-events.c still has the same number of lines
and that perf list output works.

This patch was done while working on reproducible builds for openSUSE,
but also solves issues in Debian [1] and other distributions.

[1] https://tests.reproducible-builds.org/debian/rb-pkg/unstable/i386/linux.html

Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
CC: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07ce609f..f06e1abac7c7 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -381,10 +381,13 @@ def read_json_events(path: str, topic: str) -> Sequence[JsonEvent]:
 
   return events
 
+def sorted_scandir(path: str) -> list[os.DirEntry]:
+  return sorted(os.scandir(path), key=lambda e: e.name)
+
 def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
-  for item in os.scandir(archpath):
+  for item in sorted_scandir(archpath):
     if item.is_file() and item.name.endswith('.json'):
       for event in read_json_events(item.path, topic=''):
         if event.name:
@@ -497,7 +500,7 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
   def is_leaf_dir(path: str) -> bool:
-    for item in os.scandir(path):
+    for item in sorted_scandir(path):
       if item.is_dir():
         return False
     return True
@@ -889,7 +892,7 @@ def main() -> None:
   def ftw(path: str, parents: Sequence[str],
           action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
     """Replicate the directory/file walking behavior of C's file tree walk."""
-    for item in os.scandir(path):
+    for item in sorted_scandir(path):
       if _args.model != 'all' and item.is_dir():
         # Check if the model matches one in _args.model.
         if len(parents) == _args.model.split(',')[0].count('/'):
@@ -930,7 +933,7 @@ struct compact_pmu_event {
 
 """)
   archs = []
-  for item in os.scandir(_args.starting_dir):
+  for item in sorted_scandir(_args.starting_dir):
     if not item.is_dir():
       continue
     if item.name == _args.arch or _args.arch == 'all' or item.name == 'test':
-- 
2.35.3

