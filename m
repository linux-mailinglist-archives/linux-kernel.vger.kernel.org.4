Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779B070AA6F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjETS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjETS1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6646F107;
        Sat, 20 May 2023 11:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D4160BC9;
        Sat, 20 May 2023 18:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1296BC433D2;
        Sat, 20 May 2023 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607067;
        bh=aSN0lbtzXMXs/1vWBSvYzOfemNma3YUjOg7pNQEdPKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qvrh4RtWoYfYVdpdqgDnBq44T47aZNk8u6O9QafB3Bip2VD945RQbHiXcQ8ZnlGOX
         VzpFb+cgrYZIJuOW3YIQ43pP/6kzsjmIlZznhXO/XMzJC934AfNkyjMv7ir5D/6BYL
         0jaVgjEmjLA5fB+8dHF9+FRLt4/xXehZVhX+DKbQGnYCf9vQHV4B0Za/NCmmVsVLtv
         6VNAIDY2hbxcAWeUTLBbG4ZlhMyVaoUFlRSMMb5fFVUdoB93nAKBrC/t7d234dMFop
         BRXvunEV0q0PWA5BdvnBsoJ93IgKvt8tbQ1F8n7YeNZJRsbn9S+mW9mzZtst/lDhdB
         S8SV60bdM6sBA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 4/5] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Sat, 20 May 2023 14:24:08 -0400
Message-Id: <20230520182412.860973-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182412.860973-1-sashal@kernel.org>
References: <20230520182412.860973-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index e606fc7287947..9c2be08026514 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1371,6 +1371,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2

