Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A7769C180
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBSRDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjBSRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:03:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D15493CA;
        Sun, 19 Feb 2023 09:03:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c17so528535wrx.0;
        Sun, 19 Feb 2023 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi6mjK4iZxCVQ7lT9tGEBDzWniBtxTza3Fk0r2m7+vc=;
        b=pCkKym5yYs+gphFEQFs6OBj5625Jj5kSh9M5/g6wvsABP7L95rBtIPUtcoQjLOdDyn
         RbdNB0IFJhhKOYE2nVr2GeKO7126wZWE6cWhw3uSOhdFmVa+ikC1Bfs8n05y46Iv8lWn
         uJKly0q9LOCCqw2lWJI1MyPPmqov/wYmAw+ke+bQv27x3IkT0dMV/vqpU8OTJYYjeBVA
         DiLvC5NS6oBjbbULlh0vkK4R1nPVhREprftSZ7HjCszvmfyd79rDj+d6F/f4/df+3Pkx
         /svAPfJ7k1i1A8qZ82YxwkD7njJqtcpWdelFnxDXIA2ZZO3lAhQuonyv/XfA7FZeueE/
         aoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi6mjK4iZxCVQ7lT9tGEBDzWniBtxTza3Fk0r2m7+vc=;
        b=TlvPZPihfjy4C3g3YzmkncMLDuhgASyEWFqXJ4EB2mid4QWWoFqYHOmdqHfD8SV4aa
         BOqT2G+TlzoGQ8YV/YoXRtajdpowP6q3A61cnORkflc/T/UZ6kuucTYyLNpR3wkAq0/o
         aH6BmKfwywGmVOfLsLNEpMC/IYn3wVg56i4oIpxOs5Km699irHJQgzKGzzCkj1b6Ik7x
         wBqgsIA/o0ZBXLDZ4lpip+yO4im+uXvIqoZQGQJsz2oTDh3Z4qs7ZyyEJdi7LryhA6ny
         a8pbRqWkBgf48jCBXZicF8WvYS+uPtMLUyM5w2fDPTBDQ16NMKahS4MjW9U0Oof+opsj
         VdWw==
X-Gm-Message-State: AO0yUKUgLUZGmnmXi/j1mhIRVf36ORaDw1vA+0klelv4+qT6Zs8sexrR
        GsPk13kql5aAJhEqIyPBf3oWS3o8trI=
X-Google-Smtp-Source: AK7set8cZwVQFMJLWXHvEHGXeSvPr4BmqdrWIIDSEB7+/alrxcXYIhvT6Us3hAOFsjsi++NsJTyZSw==
X-Received: by 2002:adf:ff85:0:b0:2c6:5972:cd13 with SMTP id j5-20020adfff85000000b002c65972cd13mr1911479wrr.26.1676826215429;
        Sun, 19 Feb 2023 09:03:35 -0800 (PST)
Received: from localhost.localdomain (6.red-83-37-22.dynamicip.rima-tde.net. [83.37.22.6])
        by smtp.gmail.com with ESMTPSA id m11-20020a5d6a0b000000b002c55ec7f661sm9918548wru.5.2023.02.19.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 09:03:35 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandru Lazar <alazar@startmail.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] iio: pressure: Kconfig: Delete misleading I2C reference on bmp280 title
Date:   Sun, 19 Feb 2023 18:03:03 +0100
Message-Id: <d26fe292164ca80685f080101122b5beb564d7db.1676823250.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676823250.git.ang.iglesiasg@gmail.com>
References: <cover.1676823250.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Title entry for BMP280 called the driver an I2C implementation, when the
driver supports both I2C and SPI.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index c9453389e4f7..cec4b429cd64 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -17,7 +17,7 @@ config ABP060MG
 	  will be called abp060mg.
 
 config BMP280
-	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor I2C driver"
+	tristate "Bosch Sensortec BMP180/BMP280/BMP380 pressure sensor driver"
 	depends on (I2C || SPI_MASTER)
 	select REGMAP
 	select BMP280_I2C if (I2C)
-- 
2.39.2

