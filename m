Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962675F163F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiI3Wl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiI3Wlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:41:50 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D31A10BC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:49 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j7so6243859vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=AGnCUhObyAs+aeXv2qqaXVm6E/cs1VKMwUjNiODprek=;
        b=TJfYkfZ5X1OkrS6rhM1Cs0Vs4JEJJplOh1+QX1ZrDMlGRRZETosztECCQL0cNJDmRd
         B2PfR8tLUY3p4NmpupYOv1RMdC7UOkxcN/SEsdVn+Vp+kSGI4LAzeqGziFXvUKgRZpQm
         k+z93SEI4KDpSesvuq1t1ivUitYcghxLJI4SXsRx21aNs/rjbcoaVrrFH0XFkB0vHeO6
         Mmo5mvHDZNdEnWM3ODSwmfG0us9oseZeXMTI/agDjVyPChDzy/GrEBpDBzXXZqwyRclR
         lSrWw645z4uh+9U1flHpXiCRGnELrdH1XgN03s0Txkot4LreZgVu/Jkb6Y4jK9q+fYT6
         8i4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AGnCUhObyAs+aeXv2qqaXVm6E/cs1VKMwUjNiODprek=;
        b=s21G3SA3VK3M3tF8FD7vawx9PcpZjoxpDRVSUq++90G6FoaldAlSokUA3Axnfg5Xgs
         dTULIqkEelT0JL/qH/wCoDI51S6NKs/58wvhGqCuQqsL3TMoViewJy1Izoxza3VCaacr
         9jrDBqGOzf+rwckRDiwvdw3xnbXGSoDOh+ccv6yw9QvE8OYJPJTydUVZi1aTbC7U+ru+
         Am3JRgHy76mN002mZSK0+EXOWXwjKEHHezoCDb8Wq/DLqnUHPL7uDBNkwz0d526iACOl
         BGX1ZXsdEX/UJeDSABdlVY/02nYEc7DqQ+yokS7m0vEtepfluzO8lGFIZj/OifQinJcP
         cJUA==
X-Gm-Message-State: ACrzQf003J3m+Me1PZliGgDvKvppXqFXIVdUWn1d8Ln5HPZGGa+y4XIn
        ubp8sKTjFEitusknk4S69do=
X-Google-Smtp-Source: AMsMyM7TD5A7+lh9kc6ZHN1NY2EN5nFUFDoDrq90snKdLzHa8afkLO40vzJPffDkqQ1VYQvMg6TH3A==
X-Received: by 2002:a67:eec1:0:b0:3a6:3b38:6b88 with SMTP id o1-20020a67eec1000000b003a63b386b88mr157482vsp.8.1664577708561;
        Fri, 30 Sep 2022 15:41:48 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:d13c:46d7:2f3e:5663:520a])
        by smtp.gmail.com with ESMTPSA id t12-20020ab0688c000000b0039f94d9d39fsm2445973uar.6.2022.09.30.15.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:41:48 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "Hans J. Koch" <hjk@hansjkoch.de>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] uio: uio_dmem_genirq: Use non-atomic bit operations in irq config and handling
Date:   Fri, 30 Sep 2022 19:40:59 -0300
Message-Id: <20220930224100.816175-4-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930224100.816175-1-rafaelmendsr@gmail.com>
References: <20220930224100.816175-1-rafaelmendsr@gmail.com>
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

This finishes the port of the irq configuration and handling from
"uio_pdrv_genirq" to "uio_dmem_genirq". It changes the atomic
bit-manipulation routines to their non-atomic counterparts as we are
already guarding the code by spinlock.

Split out from commit 34cb27528398 ("UIO: Fix concurrency issue").

Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/uio/uio_dmem_genirq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 792c3e9c9ce5..5313307c2754 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -41,6 +41,11 @@ struct uio_dmem_genirq_platdata {
 	unsigned int refcnt;
 };
 
+/* Bits in uio_dmem_genirq_platdata.flags */
+enum {
+	UIO_IRQ_DISABLED = 0,
+};
+
 static int uio_dmem_genirq_open(struct uio_info *info, struct inode *inode)
 {
 	struct uio_dmem_genirq_platdata *priv = info->priv;
@@ -111,7 +116,7 @@ static irqreturn_t uio_dmem_genirq_handler(int irq, struct uio_info *dev_info)
 	 */
 
 	spin_lock(&priv->lock);
-	if (!test_and_set_bit(0, &priv->flags))
+	if (!__test_and_set_bit(UIO_IRQ_DISABLED, &priv->flags))
 		disable_irq_nosync(irq);
 	spin_unlock(&priv->lock);
 
@@ -133,10 +138,10 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	if (irq_on) {
-		if (test_and_clear_bit(0, &priv->flags))
+		if (__test_and_clear_bit(UIO_IRQ_DISABLED, &priv->flags))
 			enable_irq(dev_info->irq);
 	} else {
-		if (!test_and_set_bit(0, &priv->flags))
+		if (!__test_and_set_bit(UIO_IRQ_DISABLED, &priv->flags))
 			disable_irq_nosync(dev_info->irq);
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
2.34.1

