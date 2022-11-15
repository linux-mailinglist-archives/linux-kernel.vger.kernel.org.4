Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016606291E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiKOGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiKOGgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:36:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870561D670
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id k5so12443834pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 22:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=;
        b=NwwCJKF+znEhRh360dhBKRYvY664rqbb3Q6CjoAruwbU0hB6fIx6iN40Hr23MLUIxx
         akhV7pXA0Lca6e5ZmWhsG+cCqLhXrgIapmOtSMTAx25jIf+N58eF9Vh3hkuHlgH8wTNU
         tR0YCeOQdmoMxw+rsRd346ey1quUzS/tif0sXPCWUiaTVM82mP2uNeFcginMnz/I3kPJ
         pGEsCnwk13uc7lRSsWP85Zp9XzMRFnEyC86lv4iwRE03JYmgHsIPjGvlvL2ajafLJXB4
         /zgF0XKBkDGOMoZomtMfQrACGtD/nPXqoiwm7sN8dzFI3c1RdPc04zolpw8Sy4bpg7Ay
         J+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=;
        b=HIcV+dRbzCwYAgB8lfzo6wgUZQfzD9pJZIGD5wVVkwJF2IrCk51oqlEHUhVW9XKkPi
         qNIENc9Wm4Rk6ZV8s8eJUZ2D2mDL3SR1bLxdLzmhl7r9scKFS+hNHPkjbcYFR7s36UVy
         o126yqk1B/k8gffO5iCQlnuYIRQq8WXERgz+LnGxhd2XJsXJHsabOoExMTb3NkzmZ8kM
         xkuPHSu1YGOcaifE7Jq7TTpYyNYBKsPLYOKh7iFuOeSi53qzkW3h2h6r5w1vZigvlzfK
         TPYgyP4xLdd1QYB5AN+acGNsxK2JmaVn5zxDf/T95xkxNpFg8+t9uYj5wJ5wN2MI+yrq
         uJxw==
X-Gm-Message-State: ANoB5plD6M50kI8AF4AKyZhfM9dEkAGeeoGv6yLKUYuAJ+Dy+k1HE4lg
        38fqvgpyt/AdzDmtLXSb3nI=
X-Google-Smtp-Source: AA0mqf6INrMbbMhJmIMiuKEwY0jkAMYYg22PKD/IRtv846IQRf7ALvYzhudqHBDl/oQRDcXRxPyAJA==
X-Received: by 2002:a17:90a:d517:b0:200:40a2:eaaa with SMTP id t23-20020a17090ad51700b0020040a2eaaamr764941pju.68.1668494160103;
        Mon, 14 Nov 2022 22:36:00 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001822121c45asm8767874pld.28.2022.11.14.22.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 22:35:59 -0800 (PST)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Subject: [PATCH v2 2/3] f2fs: cleanup for 'f2fs_tuning_parameters' function
Date:   Tue, 15 Nov 2022 14:35:36 +0800
Message-Id: <20221115063537.59023-3-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A cleanup patch for 'f2fs_tuning_parameters' function.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/super.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 17b9e70b8f32..3e974c003b77 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4060,13 +4060,11 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 
 static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
-
 	/* adjust parameters according to the volume size */
-	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
+	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
+			SM_I(sbi)->dcc_info->discard_granularity = 1;
+		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
 
-- 
2.34.1

