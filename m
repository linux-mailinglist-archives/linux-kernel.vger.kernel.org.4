Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42067F0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjA0WO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjA0WOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:14:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA384942;
        Fri, 27 Jan 2023 14:14:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 933BF61DA1;
        Fri, 27 Jan 2023 22:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024A6C433D2;
        Fri, 27 Jan 2023 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674857663;
        bh=o/wZZ1uzmJ7qFEw1pt+mcU/ptJZ13hgGGF/CULyoMJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=mLoGepRJuyf4fEgFO26waiEfOSuAf6TdWVpNp3P2k9Gc2tm2E3uR46Xo/hjAvRSet
         3/zhelAgl+1nCivDb+TKA7OZqmbagmtWbCHwESGfWG3n6+6mPt3Y41FkJzxMH/y4i6
         7R5cvH3+cCuaZFsIzs9zYOaayHTfpDbb3GGIAmlyJNQ4Nu3GmPEnSL1vSMF3yZt5Ca
         PFtEYg4t2SqqTqfrm/8ZNtyys6xN4qqm3mQZN6v75bG26CdYnVl2TeLfkTZjvXrvJc
         giocRsVf3XzUHNtQbHmKuK8DvM1Ek1/x5K0wyYtasolTEg7/2qB6aGjQp00vFKNL5Y
         zt+Sp8L7RVdGg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] gpu: host1x: fix uninitialized variable use
Date:   Fri, 27 Jan 2023 23:14:00 +0100
Message-Id: <20230127221418.2522612-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The error handling for platform_get_irq() failing no longer
works after a recent change, clang now points this out with
a warning:

drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
        if (syncpt_irq < 0)
            ^~~~~~~~~~

Fix this by removing the variable and checking the correct
error status.

Fixes: 625d4ffb438c ("gpu: host1x: Rewrite syncpoint interrupt handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/host1x/dev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 4872d183d860..aae2efeef503 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -487,7 +487,6 @@ static int host1x_get_resets(struct host1x *host)
 static int host1x_probe(struct platform_device *pdev)
 {
 	struct host1x *host;
-	int syncpt_irq;
 	int err;
 
 	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
@@ -517,8 +516,8 @@ static int host1x_probe(struct platform_device *pdev)
 	}
 
 	host->syncpt_irq = platform_get_irq(pdev, 0);
-	if (syncpt_irq < 0)
-		return syncpt_irq;
+	if (host->syncpt_irq < 0)
+		return host->syncpt_irq;
 
 	mutex_init(&host->devices_lock);
 	INIT_LIST_HEAD(&host->devices);
-- 
2.39.0

