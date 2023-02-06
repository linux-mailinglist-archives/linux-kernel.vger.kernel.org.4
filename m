Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B36C68BE98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjBFNpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBFNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:45:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6422684A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8819795wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=DZVOjt6JrW+BSaV8Hww4zpACnfSHvJSsz1Sgpy5QblmshgOig6+mGSlZc8VZ2I+MOD
         ippN+leCi9AhBCgLtGPwxhxDnH8Beu/GDIMFQTlgkYJzJAtpZn+6Ai15jRVw2e0Gx0cf
         Dzp/510+SY3ADA9nyor7w6Kdjq+xx/AdI7DdyJznCJIakgy2o0QXSjcwFiWstc+h13EO
         OG/spUAKAs15x9D4jxI5ISXo09CYCFz+Yf0xAxiVr5t0T1fpMGju4KUG1Gg2Hd82N7Gs
         /PluAhFsCFCE81jcYiGzfmkxC45QTh7sEs34+dQZNfebbTxURAzvGixkG8snWIwctpxc
         e7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0RAZYB/XfMSgNVeIjbEr49M4Q3OadQw/L8K9G9Uq8k=;
        b=edASnTZBmGuPXj80NPEeMAzqtuOZbyUht4DUnaxzfoqO/tb52WbE84hd4pqWsL4MUi
         WBQqMFY0ywXQ9Z5Zk3Y6CQRwwBZIubLyRm7udX9Kd9OFaXxDQNlKF1TTrjO6tTo5ZZlS
         ctb6aDQbk4K9GtdPq3kE4Gm4AagQdztZOcU+wFfDwz9hbnjsJBV6IaUP0mirTkJSB54g
         AvmsrvjBj0Y9EzaX7hbvF2zI1+wAqfLuzlDtDeRPjiXMLNN5BRW39UatVcVQyB4r2d7R
         sVZbDED9ifBz89AzatA6tl4ki2Q51ZTsfucrVr2+lp813jmzQNmVmKTTQ5uqBy6EzsGx
         ZWLA==
X-Gm-Message-State: AO0yUKWIDsqYkzeNjD2ZzmPnyozUSMKZ+64Ta8paxfBRS7Z6J9GEfVkp
        ZFMeBL8Ly5KgBgR3RA33p69LHA==
X-Google-Smtp-Source: AK7set+rahsuZZNNf1RmoP8TEb+S2VlcLpKi4wsi0ZDh0RU8+5W+OPTdwnXbusPBzKnCqfJHZqJqtA==
X-Received: by 2002:a05:600c:1e0c:b0:3df:d8c5:ec18 with SMTP id ay12-20020a05600c1e0c00b003dfd8c5ec18mr15120490wmb.13.1675691072612;
        Mon, 06 Feb 2023 05:44:32 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 20/22] nvmem: qcom-spmi-sdam: register at device init time
Date:   Mon,  6 Feb 2023 13:43:54 +0000
Message-Id: <20230206134356.839737-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
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

