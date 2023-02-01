Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711ED67E2EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjA0LRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjA0LRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6219ECC35
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id h16so4626980wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=EBZDDjwooIVTTh/zBNI7rZw/dz2/LT5bnihVYlnTbBZ6w3b7Iw+wCsdfnX9rW8aMRm
         pp7eF/CIcLZX7wxoAd9VGR1FY/o3Ix4DSqqjhW3FQCio3bmQe05elzRDXqq5ZK0ooVwO
         0P7olNtON+dnEp6bCU6UIAvE/s7BNz0WInv8M15lusPIuF/TaQNFTvR5BHjd6a7og+W7
         TSPTjgruVbyA6qTgGW7+rQRamDJe/o0hek/Wiw/wz4/eBCGj3L8XAakMQRjqfu0kOKuG
         9/vCcIGJgr+K6lT06RuwhAasF2Q2Jqh8Ah/Ro8c5/nMXrpwmhfv2jz9IB2M751vHXG+j
         63oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=EDAjKpRdNP371K9EsMck5NReCxDOF78UpaEJ4UEgR3yhnKN6koX1+1G/s6KhvMvkx9
         isSE7m7cOmf4suLEHVnvOIwYiFDAbh3Q2dJKGXRBxjhPapPpjJ+0R8o2M8+KTLJmhq+A
         BK9aPmhHqbwdx/7AG+NRETUXL/ZHwVkCNUfYta/34M5yxjgKAhm+JjUO7TnDwmD5OzK8
         pl6aVIwkSsNejTXUtAcRGZa6qfpa1Xsbqit666aguRvbNzbiYo2Ov3wcSgw7UxfwUWIk
         k15Fxxq3L1Mlko14mRGy+ajZ6nOqknJ6VUvj5tgXOw01xKOJqNrLPmFHA/V/3ONiF7NL
         xXhg==
X-Gm-Message-State: AFqh2ko6V6AD50yiFjDhyedFZSca71kiCFUP6hiahyQ3ttkXEkBjMJvu
        iVTQNNU3fIUIloiPscFjrx0SFg==
X-Google-Smtp-Source: AMrXdXtWKBM4VpKFRlAD5F1fZKN6Tt85rTrwd6VLmXut3mBV3ST7qNL6ihfZkc+YZjFKCwO6nWpXZg==
X-Received: by 2002:a5d:52ca:0:b0:2be:579b:1668 with SMTP id r10-20020a5d52ca000000b002be579b1668mr24280818wrv.1.1674818261913;
        Fri, 27 Jan 2023 03:17:41 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/37] nvmem: sunxi_sid: Drop the workaround on A64
Date:   Fri, 27 Jan 2023 11:15:29 +0000
Message-Id: <20230127111605.25958-2-srinivas.kandagatla@linaro.org>
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

From: Samuel Holland <samuel@sholland.org>

Now that the SRAM readout code is fixed by using 32-bit accesses, it
always returns the same values as register readout, so the A64 variant
no longer needs the workaround. This makes the D1 variant structure
redundant, so remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 92dfe4cb10e3..a970f1741cc6 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -197,15 +197,9 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
-static const struct sunxi_sid_cfg sun20i_d1_cfg = {
-	.value_offset = 0x200,
-	.size = 0x100,
-};
-
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
-	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
@@ -218,7 +212,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
-	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun20i_d1_cfg },
+	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
-- 
2.25.1

