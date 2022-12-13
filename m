Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA2C64B2E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiLMJ7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiLMJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:59:36 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D161AF20;
        Tue, 13 Dec 2022 01:59:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h11so15007096wrw.13;
        Tue, 13 Dec 2022 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfgwlylZGLuox5/Dz+vzL4pB1hnDRyFnXfcqrpLAIUg=;
        b=GAn21B8uJjMASUbDS4KamVyglta0LeSGRm84I4CFGO0J/LpikYKXuR1DrFb/9f1AZs
         V6+5Wi3MuBVgAFLKFgmSfIZ0VebukK4GilkYc/tYbWGLhtf4GRIlmSuqjpBubSCRd5A9
         cFZeFqmIR/ux817JueyIPypCh/hkiHlwMVn2FaaIjqtAhPypLqeXr0Y3V85yezL1NhYx
         gSfj6BLtGdBWGVrwr+wECVYuJmfmoj/Bhyt5wB/+Hhqawb9NGarKrMP27tJfnVu8FQj8
         wWKOhoDXAVz7QSWiqOl5ZhlVBn/AiYy6I9ulFaeeE3z4OjSFjTYnh4FAxcwM97bY1AlJ
         S74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfgwlylZGLuox5/Dz+vzL4pB1hnDRyFnXfcqrpLAIUg=;
        b=a0I5tNa0gBp1HW3S03PEsLg7CBPVeuJYvw1uC1sLuarKijQaK8Vk7rugt1P9Ud1Whk
         tJvThs9gHamplaW1JWsMuncfXIliJyChFWMn0uGkxJeIYIEDq+9Ru/OOZE2lZH2DNjYH
         Izf3xiHmJQJE/VZfRWnIDEk6tj6QrAfVaKaylH7lSRkKmiwPfZP0QYGenyTf6YSr8kHq
         G4N1zTkAC4ZWSsvQnBLBLUvciuKuUEJFEeNqnIuBus1JJz8g/6YCCeZhiX809gW3jlfI
         IDiDRpr5kXU7Ngkfy1QX78DBjkNc2aGkEQ4jsrxg/QiFiZRo/mby93TOVwOYyz8bUTCp
         fu0Q==
X-Gm-Message-State: ANoB5pk2k+spOHMozpOeQk+X/WvZ0QIKnOLuyxHFoQVrxTH/qP4258Uo
        kuMEE9spBF9ufRHtZWulua0=
X-Google-Smtp-Source: AA0mqf5yLqgVqrzMgWgc/ReyJqThrVKNH4pHrF2eW8YH/etZD0SrsECd8ML+aASi6+NfHj9CEUQDzw==
X-Received: by 2002:adf:fa0c:0:b0:242:1a1e:e074 with SMTP id m12-20020adffa0c000000b002421a1ee074mr11922839wrr.61.1670925574522;
        Tue, 13 Dec 2022 01:59:34 -0800 (PST)
Received: from xeon.. ([188.163.112.59])
        by smtp.gmail.com with ESMTPSA id z5-20020adff1c5000000b002258235bda3sm11190053wro.61.2022.12.13.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:59:34 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Tue, 13 Dec 2022 11:59:05 +0200
Message-Id: <20221213095905.14042-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221213095905.14042-1-clamor95@gmail.com>
References: <20221213095905.14042-1-clamor95@gmail.com>
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
2.37.2

