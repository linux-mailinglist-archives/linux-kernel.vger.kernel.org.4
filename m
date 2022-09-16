Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1C5BB06A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIPPld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIPPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:41:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B745AB188
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a26so21588462ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=9HAW4NExDmyEYbCWPAgk73QCsbSp2/UVcS9ZvV1e16c=;
        b=ybwVe03y/wFA3XUgSppl+Ngo068sW5+w6rrcf9UveIz5Uk5oY2GbZbbOHBnTqwF+/g
         QWRbTfLYnkLjUhv2rLvjNJOo9MVf/YVpdEok/gv84DohK4wyChM1wYhWCUnQMZeejCmI
         dgtgD1HMrkfcd5+ff1Ihe/FvEaYWhsL4ieJUNReLY9/Kk7rn5UwLORRiz/iScafMMaK9
         7IOIm9D8TQzwCRGbvnZ98n7wAP0LwSBxzO3iR+l1jedvFkJzkXEHW1/HL6ipW3rp564r
         Y51hnJKpDQfXSdBYTJAeuDZWcoPUFtaqP07vsChQbxmCmZNf7oC4lGD0o+ymDvcqiX0f
         2rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9HAW4NExDmyEYbCWPAgk73QCsbSp2/UVcS9ZvV1e16c=;
        b=iTKDbCJN9sETZwR9yALsdEj8K+ETcuxcp6yuqKpiRn0JBQRVDQbDuUrbSvPZKcL/EC
         ppu9jxOEQzp/EF+sG67TaMxr+rnI8uDFKqZBUccJRCdi3sEfqS79wh7Tvn12hM0Ku1vN
         7uIvUngjnhQ1l4pYQ8EUmBvs9BHwV7hyzU/IYGzyllnmMqL4a8kLMW1levxfNc4x0OBz
         q4SUElUEnqaA/qhK5WyVFoT7JtmjkHUzLnAEC6+0jbgtVuogX1XUkw26Pow6Cy8SVHtD
         JDf20xyANggG91fDtqetDbhum/baseY81TG0t7I122N/sFz5uxAcotOtS714RquNVKYC
         IEEw==
X-Gm-Message-State: ACrzQf0rCzjQ3tKwnJkmHsB44aJh7zmj8Lp0ysr2c6Ows88UYEAIuFft
        vZslUD1JyKwQdtdW68ri5KX74A==
X-Google-Smtp-Source: AMsMyM4U2TCsiPZOhS//A3TntB938R34O5xc1QmRZ7f3H15RjuxJtc0iSD35iQcl3V7+j/ya+XmZoA==
X-Received: by 2002:a17:906:6a0f:b0:779:2fc:9a51 with SMTP id qw15-20020a1709066a0f00b0077902fc9a51mr4056084ejc.101.1663342876489;
        Fri, 16 Sep 2022 08:41:16 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0073d638a7a89sm10567707ejh.99.2022.09.16.08.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 08:41:15 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/9] misc: fastrpc: Add reserved mem support
Date:   Fri, 16 Sep 2022 18:40:55 +0300
Message-Id: <20220916154102.1768088-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220916154102.1768088-1-abel.vesa@linaro.org>
References: <20220916154102.1768088-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved mem support is needed for CMA heap support, which will be
used by AUDIOPD.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f80a00e9f508..395036a10e15 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
+#include <linux/of_reserved_mem.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -2068,6 +2069,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
+	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
+
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
 				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
 	if (vmcount < 0)
-- 
2.34.1

