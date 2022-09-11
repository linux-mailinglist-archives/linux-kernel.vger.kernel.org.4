Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286165B50B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 20:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiIKSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIKSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:43:00 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792C27FDD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:42:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id t6-20020a17090a950600b0020063f8f964so2820411pjo.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YZrA6XzEaX2qx7yboUN8/9Ckbgkolmt2PEVyb9iYMqU=;
        b=yV81eCHvUCXfra/+Icv6KqndFpw1EV2Qvf/CmYAH38oYDN7rvvEmKIyCTViCh1bJCB
         NYwLyw/1ZPagd8AFhV8XB/y64vLoFgHfG/lWliHrWTGqyJ/9WGBEB9LKItgMyJCMvq7P
         JAeSOT5T1om3nMi+uxg9I0rBO3B4V39kDHOdQCyMjMcnH0ifqDZTCVOzldripalyZxW/
         OCb7oPOtWDTsdlBP15L0hI2xeuzrYxhOlwkVVXKppU7Mq+aAR4fv09aQ2sPJ8M+0OBaL
         o+Xr8yjpykowfE33GCIMY6sQyMSIDxNtWR3l6Hb+b6TXS8lnG8bPurnpOzdOSeNSVaHH
         y7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YZrA6XzEaX2qx7yboUN8/9Ckbgkolmt2PEVyb9iYMqU=;
        b=WmwMyL/5X1cL+XsdZ3qVc5Q2jPpVdTHW1nDsxLTYRYCHeSKGRE389TaJ96nyrIk0I0
         0B1A2m/kKnP92b5FalrjXy1Iyd2dzjngx4P9dAr4zWm+owPuc6S7hbEO9XSx0Z8eXHte
         DfH/Qg4CUgPg42tcqp8L3sqfwmzF7bHvVkSCA3Qbc9HEw9VhGNDCHjJfFMSaGZzF0RuR
         9QNzLki2c7s+KarfDHolcPbsJDauFHhiMDDc5SvSAI0Z3n9iqW+ok0o2BihPSjUdC8mv
         Cmz2hPb1XU7/+vj0ghaWwGqJZVEBYPELxfO+zkEIdHT6AsAW/dy5A6MQoYoB3arwERDp
         3jLw==
X-Gm-Message-State: ACgBeo3XM1oVV1rCyuVZW9sz8YlrF6sdsDJ24nCbZSCrg553T9YHDxCJ
        vQ/Ka9rbwTQhGeSa7FwrUfIBlYQJ/TUQnA==
X-Google-Smtp-Source: AA6agR4DGE0f6mLn7AqygXZMBngqx5b/Nv4JFwhYnxYkVisK3vDqpthyH6zt7+OqTD9X6DZGJdAY6w==
X-Received: by 2002:a17:90a:8585:b0:202:ab9f:6ebe with SMTP id m5-20020a17090a858500b00202ab9f6ebemr8005010pjn.175.1662921779402;
        Sun, 11 Sep 2022 11:42:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001754cfb5e21sm4216417pln.96.2022.09.11.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 11:42:58 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        andersson@kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Update Qualcomm Thermal Driver entry
Date:   Mon, 12 Sep 2022 00:12:32 +0530
Message-Id: <20220911184232.3198957-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there are several Qualcomm Thermal drivers now available
(for e.g. LMH, SPMI PMICs and TSENS) inside 'drivers/thermal/qcom'
directory, so it makes sense to list all the supported dt-bindings
YAML files here.

Also, the entry header is updated to better reflect the same.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9475aa701a3f..4dbf82d3b775 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17057,12 +17057,16 @@ F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
 F:	drivers/net/ethernet/qualcomm/rmnet/
 F:	include/linux/if_rmnet.h
 
-QUALCOMM TSENS THERMAL DRIVER
+QUALCOMM THERMAL DRIVERS (TSENS, LMH and SPMI PMIC)
 M:	Amit Kucheria <amitk@kernel.org>
 M:	Thara Gopinath <thara.gopinath@gmail.com>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/qcom,spmi-temp-alarm.yaml
+F:	Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+F:	Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+F:	Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
 F:	Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
 F:	drivers/thermal/qcom/
 
-- 
2.37.1

