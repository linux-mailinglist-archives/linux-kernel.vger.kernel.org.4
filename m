Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DAB621D7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKHUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKHUQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:16:30 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F735D6A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:16:29 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id n191so12362188iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iZL9srUYm8qmU4/FGTGof/OySI+4UbOQj7L2fQbN1sI=;
        b=CDFFxztqq6mhzCPdtfW4JJg3QOm7EMi6hGG5Yry3ADwdYoF2vO2TPDRnK66d/3116k
         nfbXDUrPdMPOynGMIG9tHOiEmt3ta+usBbTZ6WV+P+QS7Q2op2KuLPMPrIbkQgl47Y8r
         CcP34WQmJajuu7TBroN8BFLtr978c/1YYjEe5TOXEbtouP8Zg+tBqUlQ1XvaLEIC92Rg
         liwQkLASTMuzN+Ln+p3RmjZO6j6fylBFVKf7JUIf/gONAOhjMSLWRMwAPpxfkyLSzYzg
         q13k3eYjeRJ0GW+fn460z88GPR4DhtR/g1A+L+1W0ljPf9ultQOMByTk5xdhqeyNcOEd
         ZQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZL9srUYm8qmU4/FGTGof/OySI+4UbOQj7L2fQbN1sI=;
        b=DmA+kv2yYww6I6fk5VC5rUd7SoUFUhImmktXnWNQsbiPd6EjhjGO6OvC9aQtpieCEZ
         kDy3e4UgvVuppKa35cUDuPl54e9ocyZZpFQjaaDeBV6k0qCsLJtOC53kSgL3fU3d6u/a
         mYiWxRmDGHls0jrkFPxC4uf5OLpUJJ7RCoNnJNmGxO92diikITNI1o3Nn2tvoCh1jVDs
         fZGffX6IC9S43u6ayGuI0Xov3IWwMIQ5qDsobOhO6kDvbijdpwxaC+TINhSU+vWkjSxc
         b6FHwDaYXUJCMU+huWSb4MHmZ6otPSpZ34uWctsmEtS9FC4zB1NmVjoTzRDW7llHub1C
         mCfA==
X-Gm-Message-State: ACrzQf3CTfzoAfEY9VReCLCyPmlYLczdFqRbtAgvvhYphu9S2Jzlc3hE
        MtVPdnEYTT9SJK2EF7JfvcssBg==
X-Google-Smtp-Source: AMsMyM5zJHQuPeZjfXFFodGZ7T4ec0rBiVo+SMqROvXdTkdzlXO/khfbfd4fv0FPelgR+nGQ+m/xKQ==
X-Received: by 2002:a5e:9e0a:0:b0:6c0:dbd0:cfac with SMTP id i10-20020a5e9e0a000000b006c0dbd0cfacmr34479162ioq.106.1667938588762;
        Tue, 08 Nov 2022 12:16:28 -0800 (PST)
Received: from presto.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id m14-20020a0566022ace00b006c720d63356sm4646865iov.33.2022.11.08.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 12:16:28 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280-idp: don't modify &ipa twice
Date:   Tue,  8 Nov 2022 14:16:25 -0600
Message-Id: <20221108201625.1220919-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
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

In "sc7280-idp.dts", the IPA node is modified after being defined.
However that file includes "sc7280-idp.dtsi", which also modifies
the IPA node (in the same way).  This only needs to be done in
"sc7280-idp.dtsi".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 7559164cdda08..9ddfdfdd354ee 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -61,11 +61,6 @@ &bluetooth {
 	vddio-supply = <&vreg_l19b_1p8>;
 };
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &pmk8350_rtc {
 	status = "okay";
 };
-- 
2.34.1

