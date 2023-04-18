Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05986E5E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbjDRKTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjDRKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:19:35 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75569034
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=WYNEh7cNmGtax43oDrfN3nLtG1zDVb6WEjNGyKiMTc0=; b=we
        ZRTMjYAeJ0/QMCQjdZaCMe/UWmjYfDF2EKQDxK+Xsl5pw6fJkDBx6Y1LzpxqT0nxzPnSrvEbeT/Vr
        Y8H5IZbv4imivNBs5N3DwMKD9BDQf9WBP4P4U0bZfXX2ytUp2kV9MpE3+fDa4FD9wzTwst2LZEhIw
        jXuDYdORlqfr4Njb/1J8YmZu9nKqDVNeIyRXzKga4vmdhWMOVA1usx7muxiIFPy3aG/qZT4NVa7Fn
        94Co4U24Gf+rwpN68X+UTSUHt9d/GHYA02H1bekhht0Vd3Itso0HKi/AopiOrZiNP4Moc4vJ4ja6p
        5fBP+i4Dd05nO2ssaPCQZMWLI6a6eTHg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1poiQZ-0006Qi-BC;
        Tue, 18 Apr 2023 11:19:12 +0100
From:   John Keeping <john@metanate.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     John Keeping <john@metanate.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: shrinkers: fix debugfs file permissions
Date:   Tue, 18 Apr 2023 11:19:05 +0100
Message-Id: <20230418101906.3131303-1-john@metanate.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permissions for the files here are swapped as "count" is read-only
and "scan" is write-only.  While this doesn't really matter as these
permissions don't stop the files being opened for reading/writing as
appropriate, they are shown by "ls -l" and are confusing.

Signed-off-by: John Keeping <john@metanate.com>
---
 mm/shrinker_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index fdd155fd35ed..3f83b10c5031 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -189,9 +189,9 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	}
 	shrinker->debugfs_entry = entry;
 
-	debugfs_create_file("count", 0220, entry, shrinker,
+	debugfs_create_file("count", 0440, entry, shrinker,
 			    &shrinker_debugfs_count_fops);
-	debugfs_create_file("scan", 0440, entry, shrinker,
+	debugfs_create_file("scan", 0220, entry, shrinker,
 			    &shrinker_debugfs_scan_fops);
 	return 0;
 }
-- 
2.40.0

