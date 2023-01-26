Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41367D87B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjAZWda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjAZWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:32:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3AF728E7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:31 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d13so2587021qvj.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlgJAvEkxbhhdbp3uu9+lWHtfcFwlocAfS6RLhi2B3k=;
        b=mT/ufr4G73UuIeie3utMHAeoQ+z9zmYRgkQgaLFdHEFErxqGa+40raWQ02BdISm+Q7
         aw7jMlVwoqdta6ZGsBNXwLg0NdjhlUA1JPoyWlQ8EJMR+QeGttil0fYJd8rtBjNgGobS
         k9x6qTNK7zjl8bXyb7FLwl0qoLwBE1O4SmuZh76Yd8ndk43ScY33lNt+93W9vXBWyuQB
         fJWtUHAArrcuNo5pAI1DtGLcBUS0NrqA11XQXKRHscUTsitukwj6Kadqqi7a82AVpyM1
         fWgXJ49XVk//zGvPkPJBjnuDh4cHgVZO6guW+TBMfuLk4u8yLP+C/jS66q6kMO4jRtE1
         +vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlgJAvEkxbhhdbp3uu9+lWHtfcFwlocAfS6RLhi2B3k=;
        b=SMH230o5glZyV3atEbaQg+Ei9kw1eCEhoFlKqs3g+KZMtaV/1j00JNfF4gQiaWwf6h
         8npTQGdLYSmsUhA5MwDfCE8U2Iz3XOh8oXasUxXFPUhXU9qjiJK7n8j0GwDW71Fsmw+n
         Ml2pfeeCviX3mg6eRsd+Lja/mycWUxQ0xcSIjYq+z5Fo/RqajUhxOb+ai4TwNuTvHclm
         fKsVKb6OOxDDmO/9oSsSntAMNs6DqBZJrek3sAZUOrcO72GiEZ/owcXd+cWTNBAGev4/
         yNjuxnb6YCC4/hFzjGL14RyAbazvLBQqNkDvWJk6SqrJP38NxLwZLNlyNNvEQQeCfq1R
         rSlA==
X-Gm-Message-State: AFqh2krjhCD61By9V/P2a2r5ul0NNDk76yflTFpX53aIelCf9AEBPMXP
        awEhk9HVblc5k2V34hrFhETGLg==
X-Google-Smtp-Source: AMrXdXswtksS87z+wKAojoUFgd3Nv8zRGClxzKUFC/+fjkmlOEVmTBk+1kHsWA7F7LG5JVy15APQRQ==
X-Received: by 2002:a05:6214:803:b0:532:d34:5aaa with SMTP id df3-20020a056214080300b005320d345aaamr58644565qvb.11.1674772350870;
        Thu, 26 Jan 2023 14:32:30 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a220700b006ff8a122a1asm1723091qkh.78.2023.01.26.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:32:30 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:32:25 -0500
Subject: [PATCH v4 3/5] hwmon: ltc2945: Handle error case in
 ltc2945_value_store
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230126-b4-ltc2945_shunt_resistor-v4-3-bb913470d8da@criticallink.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=SzzENIrGiaejxh+uQZSs7e+ccCHGcUqjL1/OnwF5OmY=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0v96I9AKEpN83mKapP1hTRkeYHRy84kppIwH+CdQ
 eL5pKQiJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9L/egAKCRDc1/0uCzbrqudhEA
 CuNh+CQew2a5gTfSFibY46D0O2N0QAEvr3Rsa0msLInZGzGb/Q37NW4Bek/e1UDQ9akNCC5edWUmSV
 leReoDCSY5V6auNoZggWimfdebz5pXtmZMoci4TLpq9opdQZ7M9ZR2yu50sPMN25UX+U+fSdjPJ/9F
 ZcOFS8a9dhWg9E40XXJdAqo3GjZG9+REU/Amh1e4I3JX4QZwHgxLgiVvhPuVW0A8p8TJRStovoi/4c
 m1l0sz3XYRhtQeEpuw1Kp5BVpG3s1ZVRQSLU2qVPs6/+myvT55V01RoDUkWmq98y0EzhAoKPVmHQ03
 gF04Un76awayLjOYjEMUlKLAXPqnq32cwHLqCrmWN6OFO6cx+ckxI6OvlNQ08g+MrnrxPJfk+afSRl
 tjJZXx9rMNAHw5ZJi7dzOlBqrZivp4qVViLKPDWWdA2iXTpnInPf1IgZc7eKX+s1JPc6y00U4V4pTm
 +QCYQROzi/dRarcDB+FjkTUG0AaXG8Oa6mCIiIMfOvf7tzKfv2UbXUmgXRRx4pBWdc4U+UlTfT8toO
 yso+VmuZTXHJv3HaVHkUWSftvvh3SnofhhoR/O7WVXuIQKLQR731wF5y8WfuJmTMyTZ4QFPS+hVLC7
 HRbEe8dV9CvuZ+iyYrOf+y184YJzZks7H1NN/4zLU0ze7gofQsjfp+XEVSIQ==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltc2945_val_to_reg errors were not being handled
which would have resulted in register being set to
0 (clamped) instead of being left alone.

Fixes: 6700ce035f83 ("hwmon: Driver for Linear Technologies LTC2945")

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/hwmon/ltc2945.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 9af3e3821152..ac15298a6558 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -254,6 +254,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
 
 	/* convert to register value, then clamp and write result */
 	regval = ltc2945_val_to_reg(dev, reg, val);
+	if (regval < 0)
+		return regval;
 	if (is_power_reg(reg)) {
 		regval = clamp_val(regval, 0, 0xffffff);
 		regbuf[0] = regval >> 16;

-- 
2.25.1

