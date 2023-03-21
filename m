Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3056C2A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCUGb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCUGbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:31:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC05C13D59;
        Mon, 20 Mar 2023 23:31:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE2EC219FD;
        Tue, 21 Mar 2023 06:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679380304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPpSKZ08TiQ5CY24CMegu8MbGYAXhgPh9c17MzcAKiU=;
        b=VnBHQuvYB2sfXkar8m/clGmf0fhDCH7Cs/M6YDKGABhx4D/7Jx4hYw0Dr3xk0Vw87wnTbB
        MLXv+xaeBWM/IPrphny4h4Md+KIIwKulr9yg7VEDTS6lN3agrvSZiPXsPkBAfLpjFDte64
        o9AA6Q9s3e80xEWHanA/qwmaXV0/1U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679380304;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPpSKZ08TiQ5CY24CMegu8MbGYAXhgPh9c17MzcAKiU=;
        b=BaARQpir7qpkJrcN/wGrCJYJ2Z0eOzizTgp83Se7bFaNQwawx0PRgHX+9ObMG8v/rzC+Nh
        GfKrhI9J4ZU4nzCA==
Received: from bernhard.suse.de (bernhard.suse.de [10.160.4.191])
        by relay2.suse.de (Postfix) with ESMTP id A034D2C141;
        Tue, 21 Mar 2023 06:31:44 +0000 (UTC)
Received: by bernhard.suse.de (Postfix, from userid 16894)
        id 8D3D6E061D; Tue, 21 Mar 2023 07:31:44 +0100 (CET)
From:   "Bernhard M. Wiedemann" <bwiedemann@suse.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Subject: [PATCH] perf jevents: Sort list of input files
Date:   Tue, 21 Mar 2023 07:30:32 +0100
Message-Id: <20230321063032.19804-1-bwiedemann@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ZBjdIbF7BDphCH+k@kernel.org>
References: <ZBjdIbF7BDphCH+k@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2bcd07ce609f..736ee0a75cf8 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -889,7 +889,7 @@ def main() -> None:
   def ftw(path: str, parents: Sequence[str],
           action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
     """Replicate the directory/file walking behavior of C's file tree walk."""
-    for item in os.scandir(path):
+    for item in sorted(os.scandir(path), key=lambda e: e.name):
       if _args.model != 'all' and item.is_dir():
         # Check if the model matches one in _args.model.
         if len(parents) == _args.model.split(',')[0].count('/'):
-- 
2.35.3

