Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E4638456
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 08:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKYHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 02:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKYHOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 02:14:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E72CC94
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d1so5406228wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 23:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8x/qcH2Ax/NV41rma6S5DWR5/Gpf7+0Ad2wDhdXWRWE=;
        b=wzYydV7MQYroCBgdEtrGVpr2BurCP+OxhxKQeSKsGqv7AwTD9XpyN+OdlrrvNexWdg
         ttXbMXEQ0DQIb2lELXIvvS/G6dP40MhCbw2STSA0pz7vsDQSC5dy2+mLXake1H1ZjhD5
         jvWg6PhnGvEJKFQ34jr4/kN06sGYDv8JhX08x0SgYZviN97rjhKdZ4b47DoWbw3gIFEz
         +ekQYoxcE3elcsF3ivdWD/8hFrIIbWawPo6ISnaf/KFoOzlHXTsXLZrBnl2gkkW1LPoF
         is57CNLoBUAn4IJ45wt7noy9T2nAG2q8znVikfJ4sgI7eyTIznMF6JOXmB6jIDPy8EfP
         nbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8x/qcH2Ax/NV41rma6S5DWR5/Gpf7+0Ad2wDhdXWRWE=;
        b=jfF3tdwMx1yHMZjfS3pWIFTEl13hPBpetxUoymn0KXrQ5czK0qV1SjfqFlC1FlDdUh
         q93U+sxZvPBVNe69xo1U6mFd2TPeK4MXEH7lJE5FW5dwrnSLsbB5F4jjvt2gq/zg0+I+
         0JhiGbAxOIwV9oJDTnerPt5bKuf8QXo31k4MrF/vVK3zu4O6Ad8WTycGsmMKeDG+inM3
         avYLFhSqhVD0k7eEjRb/n4l3KsqZeSGq7xOhllORayShiaHaO/O533w66hVEUuUg8a+0
         9qjss5CtRRovIdLDnjHcDZcuIrxpbhZRosNPSXHYrMkDiIDHgNFdXCDBPTaMieBC11xM
         35LA==
X-Gm-Message-State: ANoB5pk8hp1XkwPx/jKQoNC4k9B/g1wGfUPGnfNVQ0fEfB5OolKDv1VW
        ss7ZypnjG/gu6hNtGExrhcl/oQ==
X-Google-Smtp-Source: AA0mqf7nR92lgBfv9mRm7YBz4KCWFyPQ/5vZGz/ZQ1NsGiWj2MiTJqm9oHB4e0WAbkAhE/VDquM0Ew==
X-Received: by 2002:a5d:510b:0:b0:241:fe9d:fbf4 with SMTP id s11-20020a5d510b000000b00241fe9dfbf4mr3484593wrt.412.1669360486785;
        Thu, 24 Nov 2022 23:14:46 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm9108444wmq.1.2022.11.24.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:14:45 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 03/10] misc: fastrpc: Add reserved mem support
Date:   Fri, 25 Nov 2022 07:13:58 +0000
Message-Id: <20221125071405.148786-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
References: <20221125071405.148786-1-srinivas.kandagatla@linaro.org>
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

From: Abel Vesa <abel.vesa@linaro.org>

The reserved mem support is needed for CMA heap support, which will be
used by AUDIOPD.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.25.1

