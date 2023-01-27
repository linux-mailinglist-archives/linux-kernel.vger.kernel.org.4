Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BC367E1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjA0Kkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjA0Kki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:40:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DE323108
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso294778wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8JigJRkcBANuuqC9qhP9AGV2DKNCqyg3IFC5VkSl6g=;
        b=kXTmFXj0BWlK+pOfcdMieNrk/fikFXp4LSPc698F7/dzgahpbYjcCXxdqe5q8fNzkg
         fsm6dn7RBy7P2npJFiZoZdMxNZxoDje2cXTpHQI7McFTWqNmpcf5PUrDiOSI+foLWRUj
         h+OOHfib0gzsDr+KzrLm1eLHd0jlPEySomMRtj5mrOnwaluH5twe1f9zTRCxbjxvx2Sl
         klbs7k3Y+QSB8d8hrC+4Q5Je1Isfn9TcTR6Lc9a4nTbSCU0XpMKQcDIq0XbaWXTZVnFv
         Rs7NnqADz+oaEswOTEfyKfkJXBte5MjDj3croTgGItuNlzserPTADYwOJFLIjYT+MFuy
         4epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8JigJRkcBANuuqC9qhP9AGV2DKNCqyg3IFC5VkSl6g=;
        b=cKmwTWY6fsE/O5Qg+59eF2b7qDA6bAuiB1UAV8cVJG6mIZSpu+aP2AX2zDnyq/Pq4f
         +sZ1iThrPZ/+ALRUsHzw08Zu0n7Ye4vIMH7Qw9Wu3Bru4AHdrrYzi9MURqTv6zBrfybu
         +qzC89F6cP2IRYI8Vwj5FSV5FJ/W38cRRfeT04HudgpgUbO0h3oJMTR0c7FGxFGiHQiE
         /ZOWsrcIh/T1Rc7Nd92C5qxnRDFQIIANLNy1gRSnm51DI0FRFKnilAOywKItKg98siXE
         YeeaVzbCdleHbjFIIOjtXPbQADzGNEhvCng1hWASbNqlVLTgM6aQhWkwIm82H5ZWzVgk
         GwLw==
X-Gm-Message-State: AFqh2krmtAb5Nmm16wLsqmaMxdiqWRdYwAACf8VLfOixacqy6nkVG7IX
        uoAFLgzx/QtK/fuBPWZe0aDtrA==
X-Google-Smtp-Source: AMrXdXsllspl/clFU/ZTonPJMhLnvgGbawItS1vB789Gb13V7ttXlffW5WJtXZF8V/703exHgCr2pQ==
X-Received: by 2002:a05:600c:4ab0:b0:3da:f959:4737 with SMTP id b48-20020a05600c4ab000b003daf9594737mr40401330wmp.36.1674816024453;
        Fri, 27 Jan 2023 02:40:24 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003dc34edacf8sm1619787wmc.31.2023.01.27.02.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:40:23 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/10] nvmem: sunxi_sid: Always use 32-bit MMIO reads
Date:   Fri, 27 Jan 2023 10:40:07 +0000
Message-Id: <20230127104015.23839-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
References: <20230127104015.23839-1-srinivas.kandagatla@linaro.org>
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

From: Samuel Holland <samuel@sholland.org>

The SID SRAM on at least some SoCs (A64 and D1) returns different values
when read with bus cycles narrower than 32 bits. This is not immediately
obvious, because memcpy_fromio() uses word-size accesses as long as
enough data is being copied.

The vendor driver always uses 32-bit MMIO reads, so do the same here.
This is faster than the register-based method, which is currently used
as a workaround on A64. And it fixes the values returned on D1, where
the SRAM method was being used.

The special case for the last word is needed to maintain .word_size == 1
for sysfs ABI compatibility, as noted previously in commit de2a3eaea552
("nvmem: sunxi_sid: Optimize register read-out method").

Cc: stable@vger.kernel.org
Fixes: 07ae4fde9efa ("nvmem: sunxi_sid: Add support for D1 variant")
Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 5750e1f4bcdb..92dfe4cb10e3 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -41,8 +41,21 @@ static int sunxi_sid_read(void *context, unsigned int offset,
 			  void *val, size_t bytes)
 {
 	struct sunxi_sid *sid = context;
+	u32 word;
+
+	/* .stride = 4 so offset is guaranteed to be aligned */
+	__ioread32_copy(val, sid->base + sid->value_offset + offset, bytes / 4);
 
-	memcpy_fromio(val, sid->base + sid->value_offset + offset, bytes);
+	val += round_down(bytes, 4);
+	offset += round_down(bytes, 4);
+	bytes = bytes % 4;
+
+	if (!bytes)
+		return 0;
+
+	/* Handle any trailing bytes */
+	word = readl_relaxed(sid->base + sid->value_offset + offset);
+	memcpy(val, &word, bytes);
 
 	return 0;
 }
-- 
2.25.1

