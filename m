Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E152637E97
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKXRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKXRvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:51:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B4F107E52
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s5so3483168wru.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5v771DEFc9rL1zQ1Yv2p2JInBg9pG0PvBjFvduECqo=;
        b=nl6Qpc9LUPQ1/U+y2XCzvo51QK9XwuwvEhKETGkJYvSmHGfJmLem2BjLxkPV81S6C8
         sflcIw+PJuN5V3OCspIoG5mfVv8g7kRbjarRhvx7R7EaS1Hrwmm7x4cNtu2lpqQ5iIEP
         +Gx/Cab+AyLnqnQkh+YRW9dtOhpKRrU+tOqw+Nw4HZ699yZ94aJcFPT3HzoL4DkxJN//
         upYqbp2nA+8RH0iLaRRAfbun+PczTc+5MP0lKhuvXSpKK7k9yG5/wiNqitXgit73TsNo
         FAhleGi8iV3rZ+t05LJj0oE8JBUbbIZacQnBd7yM2s2WJ6zvKm/QDSWFBv6/ItF7Bp2r
         aP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5v771DEFc9rL1zQ1Yv2p2JInBg9pG0PvBjFvduECqo=;
        b=yQY8kenFwDa7PUsihCnqs/QB1mSvO+UzFE8NnYFQgPhog3byx0pLnUwWQ81xmJ2i4b
         f2Lhopqora/m0HyEenR5jvkkvzZL0+BlrV70XpDyqXvk4FLt0ljfdKzIMhYLxAr5DDaE
         SzFkbHF66LNoqK5dPd/HTSpOfxyuGHj7vaY6sjCpMl6TTFXPHHXur826+1DnSXYMAhtK
         rvfBz92R8oqF8S4Se7hkAWFyYvwLY70ArKuXVj4IajBIwNeIyB5XtfB4YLEgc6S58PA7
         XL7eU43q1CUAe1ngrQSaf12xm546p40K/wV9Flc95FGakKTa41HIE090HepdmWFeJ11i
         A/+A==
X-Gm-Message-State: ANoB5pkwvrY4dOlKp0cB463sjgSzwIwc53fmBUJ5/JZhc/PXrS3MIOBU
        hKhBYGSRNg5Vv9avB8gzP0XV6g==
X-Google-Smtp-Source: AA0mqf6UKLk9Lk4qE9FWHgQJ14qRqLHCPhurA3KE5Y0uih28Sgoe+Tqt3S+qP2v8BXY2U8XPV4Zh0w==
X-Received: by 2002:a5d:6486:0:b0:241:ba9c:cc65 with SMTP id o6-20020a5d6486000000b00241ba9ccc65mr20343872wri.443.1669312302331;
        Thu, 24 Nov 2022 09:51:42 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b003c701c12a17sm6394192wmb.12.2022.11.24.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:51:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/11] misc: fastrpc: Add reserved mem support
Date:   Thu, 24 Nov 2022 17:51:18 +0000
Message-Id: <20221124175125.418702-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
References: <20221124175125.418702-1-srinivas.kandagatla@linaro.org>
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
index 545b7dea68bc..86d11ffadf29 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
+#include <linux/of_reserved_mem.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -2071,6 +2072,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

