Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F768BE86
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBFNoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjBFNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:06 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A010F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d14so10386389wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=vzGnF6eTcIkKhAJpWbA6oDofeaYPzVss3CFVFeOB1iJ8DIqf0Cqz97sPpyUfKw/l6p
         eOGcb3TVoaczcrvlQMbUg+FmUUSttFrtjX8koKDkMYvsQORjvT/mXwnAtvX/cMy8Od02
         d2IbKUEFbx1G79TpsUexTwzWfnU+bZqqfd8PpAhFW1LA9XYVz7cuqsorTQUm6+WIEDSj
         toXE00nuVe7mNNOnvelne29+/wcLTGfI2XqhyzoY6hmZK+LBcE2GjahFRkyObAfumJhY
         ADJ+WBazhoQDVNA8+gyzUw7/C2LL2RjFP4QJkHpwNSvAL+d6s20IC29dvutstUFDg3h0
         GtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYkW6U+ZAL6IPEC3v84+mOvhpm/8I/o3t0bipCAwglk=;
        b=IVYeh5rkcFZ+gQQbG6lmzdoY/9YfpTj/eGBGLme6ONyKCU39jGRziHZj1rrcANodYU
         QkuUq2uGwFiPmOdf3XjYkZ9EhwgC5YHOUq6JwOGi0IkhBytYa7339vokL8klD+quFw87
         iOBZht/WuNd3N+LyX3ZmDFyryNvC4h8hCcoJNFyIq7elotBKiF5EC5o6Zgfo3kDDMTb8
         lREJ2f7M4GEtAVtLehjZqygSQ0ndR9TKbfZDvPjU86sgxy6U63Drd4mMMkVWKZW2N1k3
         sAkLec5LscbZx8WfmRyZFYujTyXjhY384TWDvQpJ30ifs4nZC0+gBkQq2BsMDiwKaaR7
         vS0A==
X-Gm-Message-State: AO0yUKX5SyeMt2Yg57dD50DSNptjzLBFHfL+5kSVJMxlE0s1JgsKDjBS
        xOyfFfpXNgcsUSVlKVDiPP/zaDCUSudQNzdA
X-Google-Smtp-Source: AK7set+qCFUgEh+bVwHGY/St4xMegpDUi//09r2x1k/PfLugJzYkyDeQ443vxhjaj9O6rsmpB1ooQg==
X-Received: by 2002:a5d:64e6:0:b0:2bf:b33b:fb7a with SMTP id g6-20020a5d64e6000000b002bfb33bfb7amr21463238wri.25.1675691043623;
        Mon, 06 Feb 2023 05:44:03 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:03 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 01/22] nvmem: sunxi_sid: Drop the workaround on A64
Date:   Mon,  6 Feb 2023 13:43:35 +0000
Message-Id: <20230206134356.839737-2-srinivas.kandagatla@linaro.org>
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

