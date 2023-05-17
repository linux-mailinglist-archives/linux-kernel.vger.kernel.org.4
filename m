Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE98706B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjEQOfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjEQOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:35:14 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649B6768C;
        Wed, 17 May 2023 07:35:13 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7703344e058so14938639f.1;
        Wed, 17 May 2023 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684334113; x=1686926113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfGmTy1Maki4xtZVouuZlj1F2V053DoDao48FuS24iM=;
        b=KEVLuHLi1w31UgTtIgo+DL04NJpQpVFTd6DjqSwbqVTrI5Z+0xWP4YmGstX2c6It70
         WbhSyPrksU3Soxf+GKtImETCiGQH2+3aA0FxA0hFAWg/dB+3Wto0BQc90qVLg5lIvtGo
         THavClK/tgcWhXeGoGNwUbRvdMbmCW5dn9WgkOlKUKXJ3hl6uehXUtybRjo9f0grDAzp
         mZoIQQM5ZvY5px9pLcIfyG9Kum7glQsEDO/yWniyRe4aEBaKQxWdYBjocmQuYpRmmBBC
         7j06DjwoOFQroNT0rMBuIyoYTI6vR2etsZXEMz3RzAsPv/kJzgy2wHSr48lHC6vep6Nh
         qsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334113; x=1686926113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfGmTy1Maki4xtZVouuZlj1F2V053DoDao48FuS24iM=;
        b=kGYdYNyk5XtJS3XnsYP63h0wJ6LvUA878NRmbdiVRemMjHR8KwORGa4h0yYfru10DX
         qcvZHiLcKRI4FLPbpfhh0z0CxRlAeNgbn44xPsKIgvu09wvaMhTNWLYAx0KVbDxm1AGw
         lVNVTbKGdEhzfQ9xf3dod5lRaqhJbtOhYwO2KJzJArRayB/NTxPGfx9/z2TH6sgWO5RL
         l/S5B2YzcTCPZ4XIetFg2fHvkNvbZAXe6//SR8nAE4aMCwYdVxiLSu7/DIPJWmoubz40
         SOaQIZC2gAvFI8DbNuAHb08ZRERZqcpfFq+QicReS97DH6STdDnaldByACsPuPmIklV/
         atRw==
X-Gm-Message-State: AC+VfDxETIHNcbA4MO23e7J2xDaUMDAgGkpSOYiekQXnhCl7m4rn3XOL
        1H6wNSyuq/IVCQyuHeWGRTXdhaU1DyF+Vw==
X-Google-Smtp-Source: ACHHUZ5/sN/5IpAdJIFSa25y2kgGt+NJGAwTrvDVHbzhwmPN0AQ1t5upGsOg1Uq35vk9u9TwS4l3zg==
X-Received: by 2002:a05:6602:221a:b0:766:48cf:6ca9 with SMTP id n26-20020a056602221a00b0076648cf6ca9mr4607845ion.12.1684334112615;
        Wed, 17 May 2023 07:35:12 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d9f4c000000b0076356c2d1acsm8203116iot.52.2023.05.17.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:35:12 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: qedi: Replace all non-returning strlcpy with strscpy
Date:   Wed, 17 May 2023 14:35:09 +0000
Message-ID: <20230517143509.1520387-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/scsi/qedi/qedi_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
index 45d359554182..450522b204d6 100644
--- a/drivers/scsi/qedi/qedi_main.c
+++ b/drivers/scsi/qedi/qedi_main.c
@@ -2593,7 +2593,7 @@ static int __qedi_probe(struct pci_dev *pdev, int mode)
 	sp_params.drv_minor = QEDI_DRIVER_MINOR_VER;
 	sp_params.drv_rev = QEDI_DRIVER_REV_VER;
 	sp_params.drv_eng = QEDI_DRIVER_ENG_VER;
-	strlcpy(sp_params.name, "qedi iSCSI", QED_DRV_VER_STR_SIZE);
+	strscpy(sp_params.name, "qedi iSCSI", QED_DRV_VER_STR_SIZE);
 	rc = qedi_ops->common->slowpath_start(qedi->cdev, &sp_params);
 	if (rc) {
 		QEDI_ERR(&qedi->dbg_ctx, "Cannot start slowpath\n");

