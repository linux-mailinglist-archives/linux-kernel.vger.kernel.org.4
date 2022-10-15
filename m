Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930045FFB5B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 19:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJORFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJORE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 13:04:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699D24BE4;
        Sat, 15 Oct 2022 10:04:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s30so10723095eds.1;
        Sat, 15 Oct 2022 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhI+hlPFB1VmnftZiBxf9R+xZVV23cThttepsCBJepo=;
        b=D7RzF3t/EWVqoB7nziHldVdy/u1JR9lhj4bboxXOSosBovIY22BJCEdFgVTaSyo1c8
         eQTsqz4lEI3XcvYXXQs/9k0CTH+A0XFJHi45rOjlC8NlUnl+N8J7KGV9YESaF2Q6NFVD
         LKh3GQ6AHaXnFRgrUQIKSwtdCnRbFOehuyea8TwqyGfh9H+xqU5ftCAoSbGsJkJ5mJ9A
         9wWUpglUu6zJpnfqwJFubZhCI+prpJX9Ftya55nysdS197/M5BraomZieUBjNMFBNK+z
         1hKaolSAmUVIc730RftdNh/oeKa10j/lBnlMdJxJfs7kiy89H5Df0tg0iP9Nnaj2f1kJ
         DbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhI+hlPFB1VmnftZiBxf9R+xZVV23cThttepsCBJepo=;
        b=xjKRIQ+0TRqRozlama8D2wMlVsqcugll4VZSqASjsUbLB3+e3pSN5PaVjyBWv3MrnJ
         +4OGV9/ic6A33WIwG04NuP+M+gLsisI9UUl9Tf0FfQVmLr4DUwonmv6KJ1M5Z+lHK3tN
         4CuVYLXuRl9Li0TQYWm2AVgopBczuTPtWSSbUwcMft+D7mQoOqP+ERFjrA/7FJx3UMaZ
         MUj61PKJNtnrA+eeX9as1M+lk/AHO6XBEkcwup/EktHXx0riR/2AZAWGmSTdA5pTqHfw
         qfgZnG9vzR3cYhkbOtelB316o1d30NifhDXLHgHtKcoqFA6/WuD/e4wpGTgD5EYqVWNh
         MTMQ==
X-Gm-Message-State: ACrzQf1dabj6dD4KJb1TW07QzSOLMZQ2nvNSYGoKH2FWWrazJBwOHehe
        B7kU+SfRS2vUNIOS3Dn9ODk=
X-Google-Smtp-Source: AMsMyM6m9cRsVKns8lyjcAFDMk8qF1xJyJ8u2gOZQiJ4QjKIP4K1ErxBq8eX1lmLlp0OmKrln/cFig==
X-Received: by 2002:aa7:de10:0:b0:458:e101:fe54 with SMTP id h16-20020aa7de10000000b00458e101fe54mr2953882edv.80.1665853494105;
        Sat, 15 Oct 2022 10:04:54 -0700 (PDT)
Received: from localhost.localdomain ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906701300b0078d25e0f74bsm3362484ejj.46.2022.10.15.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 10:04:53 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Sat, 15 Oct 2022 20:04:25 +0300
Message-Id: <20221015170425.83233-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221015170425.83233-1-clamor95@gmail.com>
References: <20221015170425.83233-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accelerometer mount matrix used in tf101 downstream is inverted.
This new matrix was generated on actual device using calibration
script, like on other transformers.

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 455f7e621c02..83262c790058 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -591,9 +591,9 @@ accelerometer@f {
 					vdd-supply = <&vdd_1v8_sys>;
 					vddio-supply = <&vdd_1v8_sys>;
 
-					mount-matrix =	 "1",  "0",  "0",
-							 "0",  "1",  "0",
-							 "0",  "0",  "1";
+					mount-matrix =	"-1",  "0",  "0",
+							 "0", "-1",  "0",
+							 "0",  "0", "-1";
 				};
 			};
 		};
-- 
2.34.1

