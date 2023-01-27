Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1C767E313
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjA0LUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjA0LTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:19:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3222714E92
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m7so4654322wru.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=k6CpWKL8Li/xXlrtbqaG3uY8yTEK0RCEq/Kg4sWxFi/DxsZ9wpggC7+WrA3swdAcs6
         5/dihwoMhMOmufmZcTWfANCzDKtXMEHzEoJ2+1RJ7NZzeMtuyVet5FJ6UPNAZeWXIcp5
         EBXKb1ZImVhYVe8Q0IJ1AAefnBTF22gwMwvStZWKXNW/pcrNIgVswfBm35IPUAZFL/2+
         rojM1S9D/BPVFEl4iqqHjMzF2k0x+4F0OgxLxh2b6Kxrm0n4EDBFnGBLB04vw5ZfAziE
         F6loqv6Xv0x6LF+5bNZaTf5pHRNjadS4Y0S8WaRATngT4s5xBI5SRHATHIwRIHJW8pbp
         fA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=tPbvgQFFBLw1H/NvjzTF3TJkAsv/f/+icUPUJS/s2ghEHsMOjqXlI8cioMaquyK/71
         DmOvmxorpbIFbZ+t+m/s0a+YAQaSG5QxDCU5yvE9WuWYaZnyg5p9KyIh65NYiQa7bUaU
         xJDUlac+SDF0yhAcMjmDKMdZiaPN5K483qbRvGElAfaWcsB9oVl9rmbcRR77iD7mQ6x6
         FN7qwLUQLLiosrXrxk/Zbbe6qlAnPQMN49lGzN531DYDJxvHPjRkXkqqs/dYTfueZQ4g
         GVN5EeUi6HYBiGbeE8rA+i8LdPqw5e7vSH39u+JkkXqy5/wb91UIwigayBVeSxfxyvDL
         vrrw==
X-Gm-Message-State: AFqh2koZuYSJ69cj1SaecOCIrvh2CUKhRdCzuPyaj/b3pbZChOtMaJuN
        rdBNWBi+qNSPi9gm5KPOti31oQ==
X-Google-Smtp-Source: AMrXdXs6U3fOEkhWOQEpKlC4f8ScKoM5dbX1AmlvDGV8bsp2uxVFOUlGL6TJ1+rl9Bavnw/S4HpTNg==
X-Received: by 2002:adf:e48e:0:b0:2bd:ed75:808c with SMTP id i14-20020adfe48e000000b002bded75808cmr44322532wrm.38.1674818307568;
        Fri, 27 Jan 2023 03:18:27 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:18:26 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 35/37] nvmem: qcom-spmi-sdam: register at device init time
Date:   Fri, 27 Jan 2023 11:16:03 +0000
Message-Id: <20230127111605.25958-36-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

There are currently no in-tree users of the Qualcomm SDAM nvmem driver
and there is generally no point in registering a driver that can be
built as a module at subsys init time.

Register the driver at the normal device init time instead and let
driver core sort out the probe order.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8499892044b7..f822790db49e 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -175,18 +175,7 @@ static struct platform_driver sdam_driver = {
 	},
 	.probe		= sdam_probe,
 };
-
-static int __init sdam_init(void)
-{
-	return platform_driver_register(&sdam_driver);
-}
-subsys_initcall(sdam_init);
-
-static void __exit sdam_exit(void)
-{
-	return platform_driver_unregister(&sdam_driver);
-}
-module_exit(sdam_exit);
+module_platform_driver(sdam_driver);
 
 MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

