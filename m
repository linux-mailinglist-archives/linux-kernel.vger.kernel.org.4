Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27BF5FE862
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJNFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJNFWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:22:09 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3217FD50
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:22:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b25so1825850qkk.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fusetak.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xvq6COBVSTfbYZTgM9nsSbGTWL8sS0GZEuGYYpV920s=;
        b=C5BAcB6hRyfeZGtyZ3xYtRxwpMYeB9CCY4IznSecTW8CPhxLu8RVWEYIcGzG38ys+A
         B08xdDkUR87ajPHyENWg8dyabJwP2Qh9ejPV9aMeTlpSlJlPuIFw8Ku9Dgd52AELleOa
         ulT8pTgNSz7XX5w5wdBuenlu0wszMPB6me3+Vh8WrRLoscOEE8uSAWrDv2MsLHZVOpLB
         Grr7s+6T3QP2mf6Ce3+9gw53wsMBefDFEFl1qEEmWEV9vSeVMDhxCaJJonLG18krGRi7
         BTWMhZe3Mf+x06cm7eDsgApRmd9WFlpFsDEewV5ATpR6Q3U6HzPOZRMHJfXuY4ncvoB/
         nVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvq6COBVSTfbYZTgM9nsSbGTWL8sS0GZEuGYYpV920s=;
        b=BhG5NLLL9eD4vizpmZvQFqorTC/GbQDNo0l0q3AmSFQNxf4vHTnoCLlaKkiuYYugd5
         6XazWVWsvNkLw2goiRXijRHSDNf1b5+E7teUOpT+MBGcKON4oKu2Y37MQtz7FSeF4dKe
         /C/JqAE+vxpXRYOL8AbxmVg+Psvz5XcwvCiML2IE9u4/O7WqQMPH+KeXiBQHcHT94G6g
         e7YImNHwI1kYAnE+pp7TepnAQwhvqKXUOfGdUBnjRMCq56TzxcNsl41cS/tar0T28aYS
         iuMRzvIRguFTmUtWjbaV1LTwKNlxxcSzLfGN0TmM+jR7J6mddXlDRH/X02aWXKRxq7S3
         xhRQ==
X-Gm-Message-State: ACrzQf2Uvmf0727PB2CPZasHLEhYbMH7j64cSMUF3b/f19ykc5+SGarc
        P6NSEA06MBx/P39FMH4UJwY3eA==
X-Google-Smtp-Source: AMsMyM4ZULZXmb5y3yKXQ8CdN+TYbBcMboZ2GEqmSF/vVh415/CbjOmzz5XMPHRGtT0VLrooMUPvUg==
X-Received: by 2002:ae9:ef04:0:b0:6ea:adcf:4c02 with SMTP id d4-20020ae9ef04000000b006eaadcf4c02mr2501199qkg.779.1665724927271;
        Thu, 13 Oct 2022 22:22:07 -0700 (PDT)
Received: from fusetakDesktop.internal.fusetak.net (cpef81d0f843c33-cmf81d0f843c30.cpe.net.fido.ca. [72.140.107.91])
        by smtp.gmail.com with ESMTPSA id r20-20020ae9d614000000b006ce2c3c48ebsm1541519qkk.77.2022.10.13.22.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 22:22:06 -0700 (PDT)
From:   Tamim Khan <tamim@fusetak.com>
To:     linux-acpi@vger.kernel.org
Cc:     lenb@kernel.org, rafael@kernel.org, linux-kernel@vger.kernel.org,
        Tamim Khan <tamim@fusetak.com>, Dzmitry <wrkedm@gmail.com>
Subject: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA
Date:   Fri, 14 Oct 2022 01:19:31 -0400
Message-Id: <20221014051931.155483-1-tamim@fusetak.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the Asus Vivobook K3402ZA/K3502ZA/S5402ZA Asus Vivobook S5602ZA
has an ACPI DSDT table the describes IRQ 1 as ActiveLow while the kernel
overrides it to Edge_High. This prevents the keyboard on this laptop
from working. To fix this add this laptop to the skip_override_table so
that the kernel does not override IRQ 1.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216579
Tested-by: Dzmitry <wrkedm@gmail.com>
Signed-off-by: Tamim Khan <tamim@fusetak.com>
---
This patch is similar to e12dee3736731e24b1e7367f87d66ac0fcd73ce7
(ACPI: resource: Skip IRQ override on Asus Vivobook K3402ZA/K3502Z) and
6e5cbe7c4b41824e500acbb42411da692d1435f1 (ACPI: resource: Add ASUS model
S5402ZA to quirks) and just adds another Asus Vivobook that has the
same IRQ override problem

 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 6f9489edfb4e..0270421d12db 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -425,6 +425,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
 		},
 	},
+	{
+		.ident = "Asus Vivobook S5602ZA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
+		},
+	},
 	{ }
 };
 
-- 
2.37.2

