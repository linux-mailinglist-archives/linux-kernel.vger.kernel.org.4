Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3A46C262D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCUADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCUADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1F8303F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679356948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oaxgoRknGgdRu4OK8QweJTWsOvaKVFDsJ1zcV4NK7y0=;
        b=QK83AGd/Wdyk0EYx59/rsCZEDSKBwHuZBd3kbFS3eufd0GWPdYMKyWjH4tHzobLH2wW3Ws
        ZXePiPrUd+G/sMrjVdAQ7//ra0R/3BwGj8d5BsiJVj5ujeXWgJ+yUI6YWDJAvC/y/VQ4U8
        4NfhODo1tCf1nkPzZN8+mXO3xw0ev4k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-z-lxhaPoNpqeb_YeLPyBWg-1; Mon, 20 Mar 2023 20:02:25 -0400
X-MC-Unique: z-lxhaPoNpqeb_YeLPyBWg-1
Received: by mail-qv1-f69.google.com with SMTP id v8-20020a0ccd88000000b005c1927d1609so4187134qvm.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaxgoRknGgdRu4OK8QweJTWsOvaKVFDsJ1zcV4NK7y0=;
        b=fRpPEClNSO6Wp7Y1RxJRcOrjQyMDCV33WUATmnKaqEBkkMdsyEFMNYhY4KDRJw4MkE
         TLuIkHvaIuQgOmFGEUpYBa2UQIcH+hoSk3nYg3oA7yOOy0L7ZbVNFpjY/ssN69kNsBgA
         fX8qOXxfHzCgV0QLcfptrYTQ6b4+TAtX3pO104MNyhBJ30Lz+E+44TE+UBRuvH/o2+jV
         xkmHCPzdVlVfiVKyXOfPlyzHcprgq9jh+D8OpKfYLLj7bI+5UCQ2vrtoDF+L3Amak2Z3
         jc2ES0GRJ4G92PPgXXj8AwnW29kHQ+upMkGW2Y3ZOE4FHzk/8HpYphNMhFPXro7m0pd2
         kyQw==
X-Gm-Message-State: AO0yUKU4wrnRFGWYFD4DQyS7q7AnG4xME7V+bqzJAnwCcOa+kdrMrdBc
        p64Bev4VK/VRo3ttBmkXWfd1x6EmpfS92XjXIc7uitdzhOilnE16qoPsWhcv2YyYF+Zkhkw8mdQ
        Mp5W29ux1IIffCp/TCKUsCQhZ
X-Received: by 2002:a05:6214:e4f:b0:56e:a88f:70ef with SMTP id o15-20020a0562140e4f00b0056ea88f70efmr1086852qvc.23.1679356944980;
        Mon, 20 Mar 2023 17:02:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set/vloqXuJHQb4gmhNtaN2vQNHHdc+vDhwBC/G6wQnC0xCCyIgIxZN3YzPPHshhTFFZCEA5/0g==
X-Received: by 2002:a05:6214:e4f:b0:56e:a88f:70ef with SMTP id o15-20020a0562140e4f00b0056ea88f70efmr1086833qvc.23.1679356944683;
        Mon, 20 Mar 2023 17:02:24 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y3-20020a37f603000000b0074382b756c2sm8287715qkj.14.2023.03.20.17.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 17:02:24 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, skhan@linuxfoundation.org,
        bhelgaas@google.com, linux@rempel-privat.de
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] misc: alcor_pci: remove unused alcor functions
Date:   Mon, 20 Mar 2023 20:02:03 -0400
Message-Id: <20230321000203.1730802-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/misc/cardreader/alcor_pci.c:98:20: error: unused function
  'alcor_mask_sd_irqs' [-Werror,-Wunused-function]
static inline void alcor_mask_sd_irqs(struct alcor_pci_priv *priv)
                   ^
drivers/misc/cardreader/alcor_pci.c:103:20: error: unused function
  'alcor_unmask_sd_irqs' [-Werror,-Wunused-function]
static inline void alcor_unmask_sd_irqs(struct alcor_pci_priv *priv)
                   ^
drivers/misc/cardreader/alcor_pci.c:111:20: error: unused function
  'alcor_mask_ms_irqs' [-Werror,-Wunused-function]
static inline void alcor_mask_ms_irqs(struct alcor_pci_priv *priv)
                   ^
drivers/misc/cardreader/alcor_pci.c:116:20: error: unused function
  'alcor_unmask_ms_irqs' [-Werror,-Wunused-function]
static inline void alcor_unmask_ms_irqs(struct alcor_pci_priv *priv)
                   ^
These functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/misc/cardreader/alcor_pci.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 5b637171c46c..0142c4bf4f42 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -95,29 +95,6 @@ u32 alcor_read32be(struct alcor_pci_priv *priv, unsigned int addr)
 }
 EXPORT_SYMBOL_GPL(alcor_read32be);
 
-static inline void alcor_mask_sd_irqs(struct alcor_pci_priv *priv)
-{
-	alcor_write32(priv, 0, AU6601_REG_INT_ENABLE);
-}
-
-static inline void alcor_unmask_sd_irqs(struct alcor_pci_priv *priv)
-{
-	alcor_write32(priv, AU6601_INT_CMD_MASK | AU6601_INT_DATA_MASK |
-		  AU6601_INT_CARD_INSERT | AU6601_INT_CARD_REMOVE |
-		  AU6601_INT_OVER_CURRENT_ERR,
-		  AU6601_REG_INT_ENABLE);
-}
-
-static inline void alcor_mask_ms_irqs(struct alcor_pci_priv *priv)
-{
-	alcor_write32(priv, 0, AU6601_MS_INT_ENABLE);
-}
-
-static inline void alcor_unmask_ms_irqs(struct alcor_pci_priv *priv)
-{
-	alcor_write32(priv, 0x3d00fa, AU6601_MS_INT_ENABLE);
-}
-
 static int alcor_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
-- 
2.27.0

