Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41DC70AA2A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjETSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjETSYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75A61BDB;
        Sat, 20 May 2023 11:24:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3BAB60F97;
        Sat, 20 May 2023 18:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5BAC433D2;
        Sat, 20 May 2023 18:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606987;
        bh=IxY9yD28x09t6EP3qwL6MxSZUKwa8NFQn8cpurereZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eimFAZ5tETb9nxsw1Nwjk4sMj1O6+Mg0tUWm2hagTKKgz/JUR4vA6ZB9+3XEEMa7g
         x7/RgQr+25xhKQ1N7nZVhITJCtDe6l2rejI2IctLDTobm/hMO2OiPBYCUA8NR8cFen
         wVCAnoNNkj3JNsvRm31m6KzXWX12C499WtlCGL+uIZZA+iWa0MO2QdMFzAtnSzMjdH
         dxqBdFBBcHoqFcPo8XsxoiaSmgSCrybKDGK7Ndia5hMeiMTKVJCd1JrgCEnt7s/P/O
         e+sQhMm3//LayUlkdKGZiFHX2zL+4wp9AUjDIuOtcoGaf86K8pfb0+HA5oKCNvTRHd
         ULz4kER0NI73Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        James.Bottomley@HansenPartnership.com,
        linux-parisc@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 09/11] fbdev: stifb: Fix info entry in sti_struct on error path
Date:   Sat, 20 May 2023 14:22:12 -0400
Message-Id: <20230520182215.845131-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182215.845131-1-sashal@kernel.org>
References: <20230520182215.845131-1-sashal@kernel.org>
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

