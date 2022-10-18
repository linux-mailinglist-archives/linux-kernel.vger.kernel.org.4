Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522C6020AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 03:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJRB4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 21:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJRB4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 21:56:48 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F938B2F2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:56:43 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-132af5e5543so15325085fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlcMb8NP4ByzZ5xxQdi+RApgp0lnGjEclJOQtrYpowg=;
        b=kHu/TbwHapINRT4A7qHEgd/WGT+uK7TvCEabH3dY+2DhcxpoafL9jcBDz7Vi/Vg+bl
         PPMncB1gzNQlunRcDJIuMxA6CwmFyU+f64to7Od7+SS8QWAbRk1KAtjaiThTChOMVLpo
         jrZJJS/87YNmtYi1DArPT8gidrB4fmQ6LEr6Fd4nw0LSd4CebTrLJpVTOSEHe4CN1+R6
         PIVvM+xPgU81HZogitG3EXEx1nXJA6IBL/UXKKpvIcKAYeez/nMHxksRhqt/YhCi7cVU
         GR4dPv4XY43ffc54UY6e0m10BrRY7df6g9+FoR8KKztQpyRfP4cAool6V7IrdXAJW6bK
         PPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlcMb8NP4ByzZ5xxQdi+RApgp0lnGjEclJOQtrYpowg=;
        b=63s5DSqE8Z+mzmAtyYMSOsGQQ5D+WcIgz1otZcrharoNISxiCAzYkFHB7t4KwmLBKO
         ZLFZMbjw/jsn6kHFMRQ/+idZJFxgInve53+W8Rwb1Kkw7ssTJGLpqXc4UVI+7S+s/o7q
         TKgBGGatoTCDpyndlFEYg51CkUPBQMu+Px2udq9m1C6POd83jDSjpwmvRavBA2yYdHk6
         rmqzREiiYD1qNl5M1Sf9X68xq4HqOkxIga27/qTADeJ4WdzunsyhBhbYMFBzhJfpu6OV
         vXTpRmJJKviX8VrbPLj34E3UmZrpUk3GNWRsoOVIqFDRbZPWOpAdoRP19wUTM1PsDmHf
         DdpA==
X-Gm-Message-State: ACrzQf3i/ZDWlBTK+164395xSBMwPrioozbfg5AdIVnuCFf5wOxwiJBT
        Aq3q13kf8MC2IRG7wutMOhE1GCBWMXB1Og==
X-Google-Smtp-Source: AMsMyM6r4g2wk9yzI92DebI7qCJ1ckHh4oi3GhwdCcC2AKuqo9jIvtGfTk7t/MaTvFg/JFHbe04EsA==
X-Received: by 2002:a05:6871:7a7:b0:125:5c0d:de5d with SMTP id o39-20020a05687107a700b001255c0dde5dmr339413oap.297.1666058201717;
        Mon, 17 Oct 2022 18:56:41 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:1855:b6d2:d55:b2d8:b57d])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d734f000000b00661a05f2a97sm5426069otk.61.2022.10.17.18.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 18:56:41 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] virt: sev-guest: Remove unnecessary free in init_crypto()
Date:   Mon, 17 Oct 2022 22:54:25 -0300
Message-Id: <20221018015425.887891-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

If the memory allocation for the auth tag fails, then there is no need to
free it.

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index f422f9c58ba7..e9704aecd7ee 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -152,12 +152,10 @@ static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *k
 	crypto->a_len = crypto_aead_authsize(crypto->tfm);
 	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
 	if (!crypto->authtag)
-		goto e_free_auth;
+		goto e_free_iv;
 
 	return crypto;
 
-e_free_auth:
-	kfree(crypto->authtag);
 e_free_iv:
 	kfree(crypto->iv);
 e_free_crypto:
-- 
2.34.1

