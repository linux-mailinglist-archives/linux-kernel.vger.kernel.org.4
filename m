Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84DC687037
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjBAU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjBAU40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:56:26 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88EB461
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:55:50 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-142b72a728fso25218220fac.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8njp51nuRtlO7Of7CeKyMB+B4IiW6XL4bE1shX39ZI=;
        b=ZrAB6sSTG08LxQMs74Fs94IvwbxtgBz3rYa3dZQtmFus6Fv4FrNGpjyFC6+qOTcdLv
         0uKu3QQnBa+K21JbpyHNE4AlQOvUp6MsB1jVwHjBsAtgQk7ZdrkSpWgUpeTvbTytIwDn
         SP9M3XEK7oONwGJUKlhb6scVn9KiVLR/M5JMLdsZSnfBnv+/KqXefPgNeq0UEFo3j6ck
         C3fXx7OaGOJVCs4RVXto4Rc0+ZN1MFdZeMEhiz8rMDDDEJpwXqQ8F4FizMKzk7m9adSj
         I3jr2sv5fgR4zckufj03bXHxyCDJl74HTx2fuXNxKCrXMHQw3aN0iYnWpXIjFwUr6hha
         s6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8njp51nuRtlO7Of7CeKyMB+B4IiW6XL4bE1shX39ZI=;
        b=GhAhPnGaZKPQNZplNs3f/FYrdIDj/dLpOFId9AzmUf8os5zU/Re5rNBdcQ1QPPdVun
         1URUS4jM5xYDVnlG4kk6XGAG6eVvXbxFswh7C1kB3iOveRr8y6p3PxwbMs1uh3f/POQ5
         /mtkg/TyMldouHUIuAJq3+mDQKtlCkzeVQVOuNne9i0t2xf7RbCjw+Ee5p8frzZwp9bo
         IZ5FPFXS4WivxOh4kMp0cj4lZhPBGsmJYRt5MOZJ9sBbsnQ8Ux/KBhpZnP82yRaAdguX
         Qvkq78NlVDTow1UArn9XnqYeXDKAIoIdc+t8oGqS8BfotJi9yWkJGoyo7JiD4Gze/AcI
         Uwew==
X-Gm-Message-State: AO0yUKVqxQO9USwavLZaZmtDw86W4NDxWcIsiasFNfoMwZYGEzqWgXLB
        fy+p9q+R4uQUGt6BRLotlYkVzu+XXPkQm3YF
X-Google-Smtp-Source: AK7set8kih1MG30YvRyHjNdBoBKSt2QKauDlODSe5wp8bgxQaE5Ba+dmGzd/hUH2FpiOs4nOCaYt5w==
X-Received: by 2002:a05:6871:6a3:b0:15e:efc5:35fc with SMTP id l35-20020a05687106a300b0015eefc535fcmr1962456oao.30.1675284948589;
        Wed, 01 Feb 2023 12:55:48 -0800 (PST)
Received: from fedora.. ([186.122.181.28])
        by smtp.gmail.com with ESMTPSA id n18-20020a056870971200b0014fe4867dc7sm8245908oaq.56.2023.02.01.12.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:55:48 -0800 (PST)
From:   Mauro Lima <mauro.lima@eclypsium.com>
To:     mika.westerberg@linux.intel.com
Cc:     broonie@kernel.org, alok.a.tiwari@oracle.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Lima <mauro.lima@eclypsium.com>
Subject: [PATCH v2 2/2] spi: intel: Add support for controllers
Date:   Wed,  1 Feb 2023 17:54:55 -0300
Message-Id: <20230201205455.550308-3-mauro.lima@eclypsium.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201205455.550308-1-mauro.lima@eclypsium.com>
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Device IDs to the module table for the following controllers:
	- 9da4  Cannon Lake 300 Series On-Package
	- a2a4  200 Series/Z370 Chipset Family SPI Controller
	- 9d24  Intel® 200 Series Chipset Family (Including Intel® X299),
		Intel® Z370 Intel® H310C,B365,
		also Intel® B460 and H410 Chipset Platform Controller Hub

Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
---
 drivers/spi/spi-intel-pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 10fa3a7fa4f5..4d69e320d018 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -75,9 +75,12 @@ static const struct pci_device_id intel_spi_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x7a24), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7aa4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0x7e23), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9d24), (unsigned long)&cnl_info },
+	{ PCI_VDEVICE(INTEL, 0x9da4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa0a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa1a4), (unsigned long)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0xa224), (unsigned long)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0xa2a4), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa324), (unsigned long)&cnl_info },
 	{ PCI_VDEVICE(INTEL, 0xa3a4), (unsigned long)&cnl_info },
 	{ },
-- 
2.39.1

