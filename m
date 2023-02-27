Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7496A3D89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjB0IzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjB0Iyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:54:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D89244BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:47:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p20so4724994plw.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFpin/ECaOJex7YpZnFv6bGio0mg33EAQtvXgREUayQ=;
        b=K0762jnEJeB99RHRGn9nhBNoRCkFPx0Ljg3EZyQXsyQFII/I1EkFO5qgAOccMNyeD6
         UJiRPUyOF88EKQ64ReXpDogSAEzm1FhfT5k1GGBx9mn7HhitR+o37RAqUeuqWlQoOikt
         +7R+89Z+KoE/Ogow5wLHeo3vcvkfdxI5BB0JPnxpfd3IN7NCfNdGBGKkxhDyiFFlEQIl
         SVPrbPfz1t9hPC+p/lRJSXw2i2wdFlh8CDDiZrPYsE9aVljQ5XZOY3TgKeJeik8HLUzL
         pTiOS4BhrdtYCU67A7KUe4ppA7u80fNvJeQueGLVph63Z76f/+cezeihw8RdEVY9krcM
         XIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFpin/ECaOJex7YpZnFv6bGio0mg33EAQtvXgREUayQ=;
        b=sq1Dijrx2BogcbGxFMF2dcVOYR5J2GCs+lBW6skx2dH7piEqkysmDXwxyc+QRLJXy8
         QNdh7YtX+2Gye/9H2hAX28QDFDe25haeCVwhKqVsPKC0KHjftku17RmQCMFTPmwFrvpx
         TEKQ6v4gZZrH8TvSiN2FO8sRS9Sq618hiFbh1QOOF/Edat5wYfq+4seOwMx+JXbj4BQC
         sHFeVt3osMnOdg5O4dMNjJ8ixrMEhPok9BAZ6HbuB6Ore4eKD5OdhmH5y1qXsFNeOzNM
         p/wH5VIZJiAxSOhJJIE0P07Wrr3HY5aqq3aTEmyBoFHZFu87t56frb1dJTCbuX1EJHSm
         kEIQ==
X-Gm-Message-State: AO0yUKVkTEkLR+kfSQngSeLGhEfiXhAie3Xjr9Nivc6ke5zduIp+FN38
        kl+o+KyCT0/bNgbSjU2r8M0=
X-Google-Smtp-Source: AK7set8rUqbwDb6YN70TZCYUV86Ojz9rmvp/fH3/kyj5o5+FHv+eATzeub1Rvw+C1JsZIKHgA9XKnA==
X-Received: by 2002:a17:903:22c8:b0:192:4f85:b91d with SMTP id y8-20020a17090322c800b001924f85b91dmr27141271plg.46.1677487558137;
        Mon, 27 Feb 2023 00:45:58 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902ba8300b0019aa8fd9485sm4013688pls.145.2023.02.27.00.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 00:45:57 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: don't warn ztailpacking feature anymore
Date:   Mon, 27 Feb 2023 16:44:57 +0800
Message-Id: <20230227084457.3510-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

The ztailpacking feature has been merged for a year, it has been mostly
stable now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 19b1ae79cec4..733c22bcc3eb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -417,8 +417,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	/* handle multiple devices */
 	ret = erofs_scan_devices(sb, dsb);
 
-	if (erofs_sb_has_ztailpacking(sbi))
-		erofs_info(sb, "EXPERIMENTAL compressed inline data feature in use. Use at your own risk!");
 	if (erofs_is_fscache_mode(sb))
 		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
 	if (erofs_sb_has_fragments(sbi))
-- 
2.17.1

