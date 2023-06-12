Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE572C84B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjFLOYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjFLOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:24:08 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8081717;
        Mon, 12 Jun 2023 07:22:36 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b1b30445cfso52395101fa.1;
        Mon, 12 Jun 2023 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579752; x=1689171752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fhxfo9jubdaq6rreLjK9+w/KO2DLgEBFFR+q3ArG03U=;
        b=FiiK9bmK66Iw/mpParxnMkjQqkclvlfkvieuK+0KhErTJPvSqmxsMxP1XuEDTEYG5E
         a14M1UZbO7IhcLGrYw7LTf/iQOsxHYy5Cua+1/7GZh7AJQCU15yyIVJ0LyrTWzptvy/q
         P/Xz0UQvCBzfkVLNPvzrVvQk/HEhJzJ0yLCCmkAWARJ9Ggtg5Hc3qafpDd4BlVf4e52t
         MoNrcK56F2Zt/w/1bdDs8FPlc0vzIU+P9x28AAn1nLJZvakdosZi4D4K/tFwAoxG2bLB
         2X5pR5o3V85tc0BoNWxJBcWRpT2NEgB8RJ349Qf80xzpQd81H6GYc7vjcHxIWSRLT9Lt
         x9RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579752; x=1689171752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fhxfo9jubdaq6rreLjK9+w/KO2DLgEBFFR+q3ArG03U=;
        b=dfPdqZG3Hpnt1JwYR3cSoFwLwlGKujIv4q/mqvf4YKUKo7Dx7pTVYPWCqivyD8j2ui
         2C+/8F+aGBe4kKR8MrkzgUW9GAdeedmPDaU0X0QFFMl359xqHL4EEanOYSN5BQe5oZEs
         J0r0xFm/pYgx4mc8Aaw7M8PWAwpdDS64VlYQ31ngQ2P9qVD1b/LpK29NVPSpDBcSqV9E
         t3uCd8LpuIEbLbJVDFXyspsvjJc2HB1ADtlfEFj/cawyzGE4NU3m05Rpl2NA6Tw9iK9G
         5t0etkmRZYDFxVqWR3HI31KdvVsoiWiXb36I8jz1e80uqGMl2XRqote4LAKiY/Kxtnbx
         JwmA==
X-Gm-Message-State: AC+VfDwawXKoL1Dn06j+h0jvuFMcfs1fxqia08NlxgNPvLIKKXAKH9/1
        eCkH6k/xlznwteBf0jNm1bA=
X-Google-Smtp-Source: ACHHUZ46V9DWgi1CkRSWD/jiEdN3EM4O1BVDuc89JzvP40jOO8zvaaLioycyPqYo890k6VICCjXwQw==
X-Received: by 2002:a2e:3c10:0:b0:2b1:fda8:e653 with SMTP id j16-20020a2e3c10000000b002b1fda8e653mr2506642lja.27.1686579752215;
        Mon, 12 Jun 2023 07:22:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::d8a0])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090671c800b009659fa6eeddsm5262528ejk.196.2023.06.12.07.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 07:22:31 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v5 3/7] iio: accel: kionix-kx022a: Warn on failed matches and assume compatibility
Date:   Mon, 12 Jun 2023 16:22:06 +0200
Message-Id: <2c69e918cb6dfab663bb62952c554b6b72f58390.1686578554.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1686578553.git.mehdi.djait.k@gmail.com>
References: <cover.1686578553.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid error returns on a failure to match and instead just warn with
assumption that we have a correct dt-binding telling us that
some new device with a different ID is backwards compatible.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v5:
v4:
- no changes

v3:
- changed from 'unsupported' to 'unknown'
- removed the opening bracket

v2:
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index ff8aa7b9568e..494e81ba1da9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -1036,10 +1036,8 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
-		dev_err(dev, "unsupported device 0x%x\n", chip_id);
-		return -EINVAL;
-	}
+	if (chip_id != KX022A_ID)
+		dev_warn(dev, "unknown device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-- 
2.30.2

