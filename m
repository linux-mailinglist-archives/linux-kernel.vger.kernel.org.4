Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE7770AA75
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjETS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjETS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680FEE49;
        Sat, 20 May 2023 11:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB0E60ECC;
        Sat, 20 May 2023 18:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCE5C4339B;
        Sat, 20 May 2023 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684607083;
        bh=VkzKi7wqEKvjxhQtJcHeYKgd7dMVMtJz1Ug+wtlkdoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fy72TrvJ7J784cjRgxWA2SpvpOvsHX1sfYZtOmTTE8vbR38hne3SXsean/1ptmXQo
         2xWZXczujirZ1j1bq7Hdzyp8xrNBqaxa21c0df7V3a6oyrvhQrjdvbMDZJUu/0Xt8v
         Pbe8DCSvmrm5AzNyJDfkmyUd4808ZDfPTJQotDFmgDIfpqlxUMOxFbp2/KItmpTVoD
         LkCuLqhFtEgGp97NzMIzX3vn/zV1kW7noUtk8CJdeC7knGa3ZvS0HQKZguxW1i8aka
         supxom6QhVxO3oreMwtqVfe6KTU5Oi+/t24nFiw6/EJxnkv0KF3CmFL60I2bfsJzlR
         3iR4rT2XePYdw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 3/4] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Sat, 20 May 2023 14:24:28 -0400
Message-Id: <20230520182432.866012-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182432.866012-1-sashal@kernel.org>
References: <20230520182432.866012-1-sashal@kernel.org>
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
index 9313562e739e1..16eed250fd8f3 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -1373,6 +1373,7 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	iounmap(info->screen_base);
 out_err0:
 	kfree(fb);
+	sti->info = NULL;
 	return -ENXIO;
 }
 
-- 
2.39.2

