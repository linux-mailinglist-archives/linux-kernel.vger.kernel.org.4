Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09462717FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjEaMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbjEaMWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:22:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1949A123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6d38a140bso7309005e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685535753; x=1688127753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/HhFmPmul6kpLeOXCt1vDNBUi7OtQU+2Tn8rlEkX0Y=;
        b=wvIjFtIkWWyHchXZS3I4dg62o4VNM/zGhx4fPwwT3TXzeHfnAOzpqFRRunHH0P41X1
         d3T3l45uKHfMc5W+hgS9Z5tEX3AcQePFgxZLgPwsqfhgpOVnrtuNOiGjWYYbGD/4F4D9
         mdWpSOZ5cfr6fXMLxSZX8zrFv0d3x+zXvh91Pz0jtzKrKD5f+RdymmynKsgOZ9t8EWjb
         8YAQhOwQlZti2LbHR4wQ3PS1zfxXp5u7Q1VpQJlNQrlcYAu8toMqVEdGQUh5sNwb5lbS
         MnY9ZkcGrNqIn2biMUWx8lp4I0rDbXM3oNw0Y4ZZdMKOSGFPLpyYK2CWIS90bR0S/S38
         3TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685535753; x=1688127753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/HhFmPmul6kpLeOXCt1vDNBUi7OtQU+2Tn8rlEkX0Y=;
        b=TEyT0wLJTU6ERnMzdWFSK7quiZqP0A/X8/kq55M/EXURuyRl5CnzI3nccSv5fHIBhU
         J7ITuYRWXXO9UtKad2X8Xyq6DAhYxEWyFZPoGDgnWTrYj2G8xkHhkxlkj71f8PhdgfDi
         VUL4Tl7KTGWh13ZEkNAt3RtruBpmCiHYxiBJfIceW515FRV73UgX0nESOYdmMywANlmy
         qEHJLvJlB3EgQcxy5PGgqrUBFGelQChQuhBjjl6df7fsuX1tkg2lr0+1At1MOF4bh4jy
         8gpIVkzMwtWaJ1WvfNgXmIsA1Xn01zd7Gb/K53iQcPq3AvGEdumKpygBM12xjcUgqv1P
         ZzAA==
X-Gm-Message-State: AC+VfDylnYRNJ6Klfwo48u/SS2fDvR+k1yaFAh84pLrAaV5qvmV0u46t
        xHZK61oKWpYM96GTBCy20aYJTg==
X-Google-Smtp-Source: ACHHUZ4cLbNZd24u4D/Eb0QWLtG3HBdOAaQ0Qev6Obh4WgQ2BVSaswQebfdMBYQMi4LFxTa2aFibQg==
X-Received: by 2002:a05:600c:19ca:b0:3f7:2da:8fb4 with SMTP id u10-20020a05600c19ca00b003f702da8fb4mr6645152wmq.17.1685535753592;
        Wed, 31 May 2023 05:22:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe347000000b00309382eb047sm6637954wrj.112.2023.05.31.05.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 05:22:33 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 31 May 2023 14:22:26 +0200
Subject: [PATCH v2 3/4] arm64: dts: qcom: pmk8550: always enable RTC PMIC
 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-3-a3b890604c49@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v2-0-a3b890604c49@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=pzxFgRK8I6xGu1EGZNlQ5Bkt0F3pVahVPMOiUtbgB5w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkdzwFHN2gE5xkI2jE0d+qBjvBa8hrpxeJAXh4r2r4
 51NNHGKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHc8BQAKCRB33NvayMhJ0QiNEA
 C72jf6Nbdw+qytGDOzyf+gytxOKf+kar4kIziyjHQylxr+ZiScnkMfT/pm6HWKInbGKlPuAOisRMlC
 Wwa7FBNN0gn26qMVIFNa6eli97gDDy8y+eLPjdZXb8mDrEdssTgJ3SNQK8ythj8qcQA+I3/jzfu0EP
 1AFsefs4EkfxNQHQdJ2YKu8lAuRsYA4/egoZ1MSlYEO1aZZQrs+XVtJ0nBXswhPYiDhapGK6MGdf8H
 55iZflvfJzc2SHG2WH77tLdXTur1r9f1IYN1Pf3P8tGRZjYoWjF6VPhJvxpicWRGIvx341zvYj7FRx
 +VnOvAniswJ7ZB3xHPw9XhsfwrgzU9BLwcERZTsqBLkObYwY/FdQtojjEXrWtwKC7BYzKkaTzJsTpi
 UcC83Oq/AiihieQt1ID9He56s3KEULF5vsT1FecbKM/fpCWsMxajK5Pez9XYxo7BjUui6X01XXyxxv
 SswiqcdcKKnhpovkNNU5xuCLZT5BXL2PxsFZV8Cf8CGu5j7UtiZmGtIWzpKoFZamvHVHQAoQJ33Bsr
 sUBuiNOkgHK7dfs82RnjVYmCpfaNy2tIHX5vazEPzlT/mXbcd9SscE6F4liY6Qb30X6sQ6Yp1nbSuf
 xNZc6o9RT8gEv0n/QAPWtqLXlwiU2aREi7KXYuyUi1V3IVBuB7xVnIcvGetg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason to keep the RTC disabled, it has been tested
and is functional on the SM8550 QRD and MTP boards.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
index 8c897d4fee29..c7ac9b2eaacf 100644
--- a/arch/arm64/boot/dts/qcom/pmk8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -49,7 +49,6 @@ pmk8550_rtc: rtc@6100 {
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
 			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
-			status = "disabled";
 		};
 
 		pmk8550_sdam_2: nvram@7100 {

-- 
2.34.1

