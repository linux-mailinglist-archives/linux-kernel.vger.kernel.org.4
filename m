Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63168BA15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBFK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjBFK2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:17 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A312F2F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10398373wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=VlcMT6L5u2sbpTqTSvr84Tp/Dxt8Vmtj1UFJ/L7vUi+I2aVS6gz53Er7ulAHoc/0Le
         JHro8lIslrBL9WHZxOum9VrQ4HPE0pYB8VwJywJfZycm7Czo0OazXxbvzimHfczvaLam
         ddhQYDA8dxggWIurr8schGAUd0VckMoJ2HS0U5W+pAM8Cu6pfnZmCbFnQ84BqmPkr6lK
         ja1TOnU7DFeWirqQtQGcQ85Y6GhioUgpaMRuQttOKf7fuQBdhHViEEjx9JFl06j3TFh/
         zn5FscyDjvaCsoZuCFOUDG+ossC3HRCGUUCn6fyx3IoQ6B/3YYFIgNMg8yuESLfKH52P
         9+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=543Vnf+gW1D0zXI3A5ylTGwr0xccCyQKsBLtsArFtXkM778BL/W2pv08Jr4pEKtBN+
         1P9NDiAZAqdKTaDPYMBYLhNV0azGizBsP7dgxYsDEXTbETUyEV3XjPNNLuQe8MVgwo65
         K93sfsg5D0xxs8UX8Mss59l5yISnF3cnZiK6bcU91+OMi6CpoHyS8Croh790JOy0DV/X
         VRhht/6IRe0E2GAkc4LtFOXQCgIUYxc2buUjRrub0mR6CoB+xTxBieYlM24T+nCPCUQY
         lWJByJu6ST2rydSQ9evsZt+/kFBRr3nRNn5shKTwHjxd5sH5P0FTHW9VQppBUtls7WQQ
         l5MQ==
X-Gm-Message-State: AO0yUKXtDmFTiNgHENIe/7GppKqkMwaeU8KIXhy5IiJoZ2s818wdXuAQ
        OD1d+JbHrd5MR63pwriZZP2yHx+PGhzma64E
X-Google-Smtp-Source: AK7set/E3mR2r8DcMeQh5JZu/tw+bPma7hMf9kDfIXdqJ1o2WjEVKtGjStpC8VTKIsaypu+eK7eU1Q==
X-Received: by 2002:a7b:c8ce:0:b0:3d9:ebf9:7004 with SMTP id f14-20020a7bc8ce000000b003d9ebf97004mr18003254wml.29.1675679294731;
        Mon, 06 Feb 2023 02:28:14 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 01/37] nvmem: sunxi_sid: Drop the workaround on A64
Date:   Mon,  6 Feb 2023 10:27:23 +0000
Message-Id: <20230206102759.669838-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

