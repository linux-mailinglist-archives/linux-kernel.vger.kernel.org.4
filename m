Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AD86DD5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjDKIed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjDKIe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:34:27 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E2A1701
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:24 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5047074939fso15379140a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681202062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkdKJwaH8L7z7o46mK/fJ3bKpTFQDoczm/fDDv32BWM=;
        b=kDBjzCWlO8C/XcnyEYsdgK0t/5VFh2Jgaq7UjvB+Xfq71ZcADJM3snbi7bu4zLuhh0
         SCYRWfkQyPCHe36Ts6WuQ7CFIxVT4ZSePqlnJy8AwD8VRubFmUqpazdmYaoi/N53oKUT
         jFbb4AL3frmxa0oqvR6GeyDPaDnqUCvSO3WgH342IfJD0fsvM5Dc7eBEhwF2th/5/9e2
         dV1oXx4Av2sVJx6i0rPkJnqYGcUdrdGpZeY7VP0x3/0WXjrdywtOulpwb1q8OVFN8gys
         vROsYOJAbTSxreAxh7V+Rbgf7iBdIWyVcpjJXhalvynci8gDB2iL1vM18W77wpmFaAdr
         XWCg==
X-Gm-Message-State: AAQBX9fF17N53lJl6NkpCk6hgl9gzJF/dvtFAf5n7H2r4MJf1RFCuTmo
        a+HrtM7o8HHNBWoBsG/+RmY=
X-Google-Smtp-Source: AKy350a3//WZrCCXvKNWsS/l73pBPtH0fMz+KS0kn1G20uavjz8H39WJ8vw08lpH+26XzsMlJGi2WA==
X-Received: by 2002:a05:6402:42d4:b0:502:1d1b:5bef with SMTP id i20-20020a05640242d400b005021d1b5befmr18383779edc.14.1681202062528;
        Tue, 11 Apr 2023 01:34:22 -0700 (PDT)
Received: from localhost.localdomain (aftr-82-135-86-174.dynamic.mnet-online.de. [82.135.86.174])
        by smtp.googlemail.com with ESMTPSA id v13-20020a50954d000000b004fc649481basm5683178eda.58.2023.04.11.01.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 01:34:21 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     JoseJavier.Rodriguez@duagon.com, Jorge.SanjuanGarcia@duagon.com,
        linux-kernel@vger.kernel.org,
        Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>,
        Javier Rodriguez <josejavier.rodriguez@duagon.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 2/3] mcb-pci: Reallocate memory region to avoid memory overlapping
Date:   Tue, 11 Apr 2023 10:33:28 +0200
Message-Id: <20230411083329.4506-3-jth@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411083329.4506-1-jth@kernel.org>
References: <20230411083329.4506-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodríguez Barbarin, José Javier <JoseJavier.Rodriguez@duagon.com>

mcb-pci requests a fixed-size memory region to parse the chameleon
table, however, if the chameleon table is smaller that the allocated
region, it could overlap with the IP Cores' memory regions.

After parsing the chameleon table, drop/reallocate the memory region
with the actual chameleon table size.

Co-developed-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/mcb/mcb-pci.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mcb/mcb-pci.c b/drivers/mcb/mcb-pci.c
index dc88232d9af8..53d9202ff9a7 100644
--- a/drivers/mcb/mcb-pci.c
+++ b/drivers/mcb/mcb-pci.c
@@ -31,7 +31,7 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct resource *res;
 	struct priv *priv;
-	int ret;
+	int ret, table_size;
 	unsigned long flags;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct priv), GFP_KERNEL);
@@ -90,7 +90,30 @@ static int mcb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret < 0)
 		goto out_mcb_bus;
 
-	dev_dbg(&pdev->dev, "Found %d cells\n", ret);
+	table_size = ret;
+
+	if (table_size < CHAM_HEADER_SIZE) {
+		/* Release the previous resources */
+		devm_iounmap(&pdev->dev, priv->base);
+		devm_release_mem_region(&pdev->dev, priv->mapbase, CHAM_HEADER_SIZE);
+
+		/* Then, allocate it again with the actual chameleon table size */
+		res = devm_request_mem_region(&pdev->dev, priv->mapbase,
+						table_size,
+						KBUILD_MODNAME);
+		if (!res) {
+			dev_err(&pdev->dev, "Failed to request PCI memory\n");
+			ret = -EBUSY;
+			goto out_mcb_bus;
+		}
+
+		priv->base = devm_ioremap(&pdev->dev, priv->mapbase, table_size);
+		if (!priv->base) {
+			dev_err(&pdev->dev, "Cannot ioremap\n");
+			ret = -ENOMEM;
+			goto out_mcb_bus;
+		}
+	}
 
 	mcb_bus_add_devices(priv->bus);
 
-- 
2.39.2

