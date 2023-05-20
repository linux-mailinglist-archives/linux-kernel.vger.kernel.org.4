Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690770AA0E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjETSYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjETSX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6611982;
        Sat, 20 May 2023 11:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D7C60C16;
        Sat, 20 May 2023 18:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B279C433D2;
        Sat, 20 May 2023 18:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606929;
        bh=IxY9yD28x09t6EP3qwL6MxSZUKwa8NFQn8cpurereZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dg9CN/jMyU963Y7e3O1+ipWdE4sXJZjiwCq4lxY6Cu+Pc/KyTuKQ3NQGw5cr9q96m
         gqEGRDxWlUwEIusW9fetjUTCQTCx0Zx8oHP6t01rG1ru1GWCVN4OIt+/wRPnf2Q3tu
         xVounEyA83Y3/5dNbnn6JQqyOZh7A1puAvdBGHY+Nw/cNCQFbN2HotQTvWZdELJYWy
         uq2XBM+wDBQoGhA8vmIzwESurfm+vwzRIKoAFDNJFE5EKW+xSO5LRJwkKf3vOUcxuF
         ZZvg9+8D+x8fnOSQvZvRJpqmr7lyXWtGMWj5Wug34iIZ/HGwRbMtoLS+JRrPVKLiJB
         E3sLKgo/YUsaA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 12/14] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Sat, 20 May 2023 14:20:40 -0400
Message-Id: <20230520182044.836702-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit 0bdf1ad8d10bd4e50a8b1a2c53d15984165f7fea ]

Minor fix to reset the info field to NULL in case of error.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/stifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index ef8a4c5fc6875..63f51783352dc 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1413,6 +1413,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2

