Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D667D875
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjAZWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjAZWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:52 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F9728C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:30 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id x18so2617423qvl.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4xEhI3axOJYS2dd9mxNrX3agzmt2SZlxn5ns5AzUH58=;
        b=cEzkNNjy9xdn2V+pJO12CL+zMeml5aYU0d5MSRymk3vzhECNfnAxv1i6QuiVcSung9
         HKYXTxKhnCqIQpI5WID+qZM4HBfq75uXYeRVOoN7J9VOOhb2MbC8GUJ8z/vwK6MgWhH7
         l8zzsyqzuNrtLFoh3MogI7R9KgSFwfyb4ysrZsOHEm/e3CaNdURMwSmuG0z3LXh9UuMv
         SIFOhIVuYksdSG/fttoK7FrudzTxSUuMREd/wnDFhDhCeb2LyBH+0i1AtDuYb+rPg1hK
         vwF81gE0fo/5zvsSrS9iRVv3ZT/m0zAGoqQCLHd+YqYcyJ+Jm6FRe2j8+3DYT0RorNsL
         cyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xEhI3axOJYS2dd9mxNrX3agzmt2SZlxn5ns5AzUH58=;
        b=JfbfRDonb7kB+2lMmghxTPVsvmeZgGH4X+LLDQw03a1o79iQ0yA5LBwmYEX67De6kP
         oTYrGufMjuKvwDjOu08axc7QG8WfhnusqgQLJoqPngp9foUmtN19C4fjblzlvjOYrUYL
         tceD8K9X0JA/BQncPBeYcTMUCOQ6mEJ8MpcPCSKhEvCnxkboPayTMqNrWtN729aPvqnw
         zOWsW7o3vnlEmh0zxJTA60zGh7up4JA4VH06rzUtPOXFVJTD+JJaTPoJG0Sb52OD1H5k
         NB1lsybSLjQOsqu4hHtbcDguhrqMOGPs6EcHptboSL5xfqAJFElWZ0FLc/DNxE6gLVVW
         Rmgg==
X-Gm-Message-State: AFqh2koTby+YvdC4qx23B5+YPOyXl3Mp0IvmkBly3I93b8Lla4TmWvIn
        Wmcqq44qN/JQv+WoSgDvpOS0kQ==
X-Google-Smtp-Source: AMrXdXuzBOyI5/KyWaygGhCjxZsF6FqdobUQud3r/7841g2Ny78wWU6KYvEP1doyOL2yMhzPTNjRZA==
X-Received: by 2002:a05:6214:4287:b0:535:2d28:bf1d with SMTP id og7-20020a056214428700b005352d28bf1dmr61600177qvb.33.1674772349768;
        Thu, 26 Jan 2023 14:32:29 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a220700b006ff8a122a1asm1723091qkh.78.2023.01.26.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:32:29 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:32:24 -0500
Subject: [PATCH v4 2/5] hwmon: ltc2945: Add devicetree match table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-ltc2945_shunt_resistor-v4-2-bb913470d8da@criticallink.com>
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
In-Reply-To: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=Ko4/DNeywEIQUpedzI15zf/CLimbk3xwVSNJ1d5SvMM=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0v967dbZK3pTHY2jf3XbNoFu7verxjCaGB5B9/94
 99Zfs7eJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9L/egAKCRDc1/0uCzbrqqUfD/
 4oWWVTbKPgDKGULT2hNoHx/PX85X3YWhcjEp1/ZPPYjIXrqO/Fbu0x3mXg1ki52jK7s5bqdjxPn8Im
 br2YFa9GAiX7kRSE8JQqtsypb7cD8SP6WhXEftP8I7jJMDINzWkIrqrguLlxnk+gdypv4jydKPb0Sv
 h91mCNu/hc2Zs6uV/+P9Yozh71LK9r7uVB4Sk9OSag6Ld2cYmHDVoVl5cNZmOvFxrQEjbn1nGvsfpl
 VJbMZ4sALN8wX0MJ05ISUf8+Py9fq9Cto+cwPAkKo5CemIGoGf5renPvPLgWQMyJiY/PyTDCeM+S4P
 GRY1r5KsOBsCEc++b2riR7Shjy72oQZY+j9XAXs39vSZrY9/0+xfmbjDkBWEtP8mHzzbIeeYpe43Ir
 fAWhkbJP+VW7ZfKmOCw2TbgYeBf/2fD7/3vAro2ZBE6PMu1+yqIEHZ3tWwelW2PmfsddvgchoruM1j
 aaxlCeHlG8xjOdiNXiWuTFzPtnXup5a/aiBrCJG3ftT45xtRDwTFIosHRp7ZrCXcUVhB09JAqysPM3
 9XWaKXRjz9NkYdTN/BVbhpPyVXvG9DCmkw1lUTUEhQKU26Bnr96fBrMydOF4vbeEpdXO0T2F82QrDI
 zCnCXAq2Q4Od6fA9XDEVplrpnl6Ahc38XDbOMbvuDxyefknFaNMlJxFIWkUw==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adi,ltc2945 compatible

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9adebb59f604..9af3e3821152 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -58,6 +58,12 @@
 #define CONTROL_MULT_SELECT	(1 << 0)
 #define CONTROL_TEST_MODE	(1 << 4)
 
+static const struct of_device_id __maybe_unused ltc2945_of_match[] = {
+	{ .compatible = "adi,ltc2945" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ltc2945_of_match);
+
 static inline bool is_power_reg(u8 reg)
 {
 	return reg < LTC2945_SENSE_H;
@@ -475,8 +481,9 @@ MODULE_DEVICE_TABLE(i2c, ltc2945_id);
 
 static struct i2c_driver ltc2945_driver = {
 	.driver = {
-		   .name = "ltc2945",
-		   },
+		.name = "ltc2945",
+		.of_match_table = of_match_ptr(ltc2945_of_match),
+	},
 	.probe_new = ltc2945_probe,
 	.id_table = ltc2945_id,
 };

-- 
2.25.1

