Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E16BB507
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjCONqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjCONpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:45:50 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423A388EE9;
        Wed, 15 Mar 2023 06:45:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x16-20020a9d6d90000000b0069aa2f33789so715940otp.4;
        Wed, 15 Mar 2023 06:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678887925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3zPTmMSigH4zCpLbxZwF96+6D9FBn+T3fklI431Xv3c=;
        b=qUnn/B8plVaCz3cFDgWQptSnqfXUYFCAqKVU8of/b+rz8+8SWLBOmDvhk/qMwZ/l4w
         WPqdNLPjCYEKei+hRg2L8VDjAFARbxZYhEfgl6W2co05mF5c2eL6oP9IJ0WL/S7yf+pF
         aebJGQFTlc9n1luOBel0MFl64a7aGvBEqsjRg4vURB7+emlwYvbMVMVRCp/kDcQ3Nx8f
         gqLyO42yRK59yQ38x7aXPSobKVf7OCZxtZLWNBGzSJPA4VlPgQhAmQJGWzLV4XyWejS1
         hiXJfTa4124CIerOrUIey98lmH/63ejKeiU9XoLZE4TQx1gK22XUbPegP9UyNwpkfa4g
         HE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zPTmMSigH4zCpLbxZwF96+6D9FBn+T3fklI431Xv3c=;
        b=jeKDa4nRLqbdnN63oyyBfpX/zQVe/gNtYplbwIqnblPVmiUAyMtsZXuDBsneogn0xv
         LSHPZOX0BOfunz2KnnkIuzDO3z5V1FmleycyFiRoryFPcSAUPPEd/EAVECi/7EOyLj7B
         T4mgqRf41vvVsbPx7R+Pd9ri+z3J/SD+5IVWDwBuMalVVUmon4Xed8BDs3GIFWAKFora
         OUVG2MAy3gc4MNlk88poUoFmWiK9VAeW0F1hHqTArP51SZhbcG0Hze/3bp28og+pQ52i
         fdhom12GBJD3vA6MPkLsUCKxh9+Za81crKxdRgNoy4bP2NDk2afuVnJ9JfGFgJ7XIZNP
         vebw==
X-Gm-Message-State: AO0yUKVZkEHwDHoVpQyUS8Ji0WuFL1hNO8+Fg/AFLZCUplX+dB2DIxQ6
        XD6QsMl5xQuMJNL0fNII/1mmfUk3j9JwrepG
X-Google-Smtp-Source: AK7set+qBqS3qPT1Oh9d0cmDvZHGAKH00ajqglYX5d4net8biEhJsdkDQT3W/e0bK61tWsm3QgfBLg==
X-Received: by 2002:a9d:610:0:b0:694:359e:b9c8 with SMTP id 16-20020a9d0610000000b00694359eb9c8mr21048309otn.22.1678887925063;
        Wed, 15 Mar 2023 06:45:25 -0700 (PDT)
Received: from chcpu13.cse.ust.hk (191host119.mobilenet.cse.ust.hk. [143.89.191.119])
        by smtp.gmail.com with ESMTPSA id r189-20020a4a4ec6000000b004a3d98b2ccdsm2194108ooa.42.2023.03.15.06.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:45:24 -0700 (PDT)
From:   Wei Chen <harperchen1110@gmail.com>
To:     serjk@netup.ru
Cc:     aospan@netup.ru, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wei Chen <harperchen1110@gmail.com>
Subject: [PATCH] media: netup_unidvb: Register the irq at the end of probe
Date:   Wed, 15 Mar 2023 13:45:18 +0000
Message-Id: <20230315134518.1074497-1-harperchen1110@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ handler netup_spi_interrupt() takes spinlock spi->lock. The lock
is initialized in netup_spi_init(). However, irq handler is registered
before initializing the lock.

Spinlock dma->lock and i2c->lock suffer from the same problem.

Fix this by registering the irq at the end of probe.

Signed-off-by: Wei Chen <harperchen1110@gmail.com>
---
 .../media/pci/netup_unidvb/netup_unidvb_core.c  | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index 8287851b5ffd..751a954baf65 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -887,12 +887,7 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		ndev->lmmio0, (u32)pci_resource_len(pci_dev, 0),
 		ndev->lmmio1, (u32)pci_resource_len(pci_dev, 1),
 		pci_dev->irq);
-	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
-			"netup_unidvb", pci_dev) < 0) {
-		dev_err(&pci_dev->dev,
-			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
-		goto irq_request_err;
-	}
+
 	ndev->dma_size = 2 * 188 *
 		NETUP_DMA_BLOCKS_COUNT * NETUP_DMA_PACKETS_COUNT;
 	ndev->dma_virt = dma_alloc_coherent(&pci_dev->dev,
@@ -933,6 +928,14 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 		dev_err(&pci_dev->dev, "netup_unidvb: DMA setup failed\n");
 		goto dma_setup_err;
 	}
+
+	if (request_irq(pci_dev->irq, netup_unidvb_isr, IRQF_SHARED,
+			"netup_unidvb", pci_dev) < 0) {
+		dev_err(&pci_dev->dev,
+			"%s(): can't get IRQ %d\n", __func__, pci_dev->irq);
+		goto dma_setup_err;
+	}
+
 	dev_info(&pci_dev->dev,
 		"netup_unidvb: device has been initialized\n");
 	return 0;
@@ -951,8 +954,6 @@ static int netup_unidvb_initdev(struct pci_dev *pci_dev,
 	dma_free_coherent(&pci_dev->dev, ndev->dma_size,
 			ndev->dma_virt, ndev->dma_phys);
 dma_alloc_err:
-	free_irq(pci_dev->irq, pci_dev);
-irq_request_err:
 	iounmap(ndev->lmmio1);
 pci_bar1_error:
 	iounmap(ndev->lmmio0);
-- 
2.25.1

