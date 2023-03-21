Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B656C30C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCULtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjCULsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A8C468B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679399281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ymNZ6VwYV2ATvUKNgNsMq/UfCBI6C3UP9i+FWnYVIDA=;
        b=FnnFvCOt26nAn/vTY5dplKF6i6D0g6eVPKvy+gPDWFpdKsLA65SFoc8QkaZd7OuYX0nC1Q
        gvjBvNXtFrlwh3YnczLRqVtFNrrFoV5/6nZdva13c/fsbGUobkeanrAiEqTh9gF58R7xG+
        vKKOVrC/zV+V3j1ljnjRduvgZCRU7kk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ZJ66xL9cNSmobJ6j9MIb0g-1; Tue, 21 Mar 2023 07:46:42 -0400
X-MC-Unique: ZJ66xL9cNSmobJ6j9MIb0g-1
Received: by mail-qk1-f198.google.com with SMTP id ou5-20020a05620a620500b007423e532628so6800968qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymNZ6VwYV2ATvUKNgNsMq/UfCBI6C3UP9i+FWnYVIDA=;
        b=bZxDODG0r8ZDGrrugRlgcg8OkeUqzQWMc1tMfXLwZ5arhgThQdy96lUnWD/ZUDEfJx
         fzM1cV2o40ikzTodjYWfwZMM4lysL4/8Px90T5TU4TXCkUhJ+zFa5jFIHK2B1EbhNa9H
         TJrx7sh7Ds9TTMHXL3aVDAFi4RXkQRx4gCpR1GmGwX64pMHPg148iLXAnCSYtqJebet6
         F8fzckjIjLQzLNn4hdI1HYjbkPGUVAQDnt6zntFWFW9zUf6z2RRpm7Z+GS/W4/JN3pSy
         jfujo/sdhAvEqCaw5I516fOk8J+9UJJKBDIa8VDM6sXKsi5VAzKpCMdSHfClMW36onEB
         60qg==
X-Gm-Message-State: AO0yUKVRJf/BVVimlkWv6CVM6xOKqp1LxXmhfoUn+Qo06LLIgEzwpyzr
        Vi33z5jcFt3IneLNX7Rxw3X4V7hsrxsmjFLLTftHnksuUZTriHCRZ8ZHg/BwIDyKqe1u7hbKBUD
        cqeIKyVom//fbByrij0wPfjOv
X-Received: by 2002:a05:6214:404:b0:56b:377e:88a7 with SMTP id z4-20020a056214040400b0056b377e88a7mr3463929qvx.21.1679399201778;
        Tue, 21 Mar 2023 04:46:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set/fiAb6HEprEWi8AUt3xnbJCW2fUvHyYpabsY5bMNHiKBf3tCo9LT9+NAcbKM/NkXH6hE4cgg==
X-Received: by 2002:a05:6214:404:b0:56b:377e:88a7 with SMTP id z4-20020a056214040400b0056b377e88a7mr3463904qvx.21.1679399201529;
        Tue, 21 Mar 2023 04:46:41 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a040200b007468733cd1fsm3864969qkp.58.2023.03.21.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:46:41 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mtd: rawnand: remove unused is_imx51_nfc and imx53_nfc functions
Date:   Tue, 21 Mar 2023 07:46:38 -0400
Message-Id: <20230321114638.1782086-1-trix@redhat.com>
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
drivers/mtd/nand/raw/mxc_nand.c:1602:19: error: unused function
  'is_imx51_nfc' [-Werror,-Wunused-function]
static inline int is_imx51_nfc(struct mxc_nand_host *host)
                  ^
drivers/mtd/nand/raw/mxc_nand.c:1607:19: error: unused function
  'is_imx53_nfc' [-Werror,-Wunused-function]
static inline int is_imx53_nfc(struct mxc_nand_host *host)
                  ^
These functions are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index f6c96341b896..f61ffcbe57c8 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1599,16 +1599,6 @@ static inline int is_imx25_nfc(struct mxc_nand_host *host)
 	return host->devtype_data == &imx25_nand_devtype_data;
 }
 
-static inline int is_imx51_nfc(struct mxc_nand_host *host)
-{
-	return host->devtype_data == &imx51_nand_devtype_data;
-}
-
-static inline int is_imx53_nfc(struct mxc_nand_host *host)
-{
-	return host->devtype_data == &imx53_nand_devtype_data;
-}
-
 static const struct of_device_id mxcnd_dt_ids[] = {
 	{ .compatible = "fsl,imx21-nand", .data = &imx21_nand_devtype_data, },
 	{ .compatible = "fsl,imx27-nand", .data = &imx27_nand_devtype_data, },
-- 
2.27.0

