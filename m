Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7564D1A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 22:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLNVMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 16:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiLNVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 16:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F831EE4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671052311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TSz/PgjD23JYZUEwUZKhlqGEr6/v6TI6lxpkBzb4/nA=;
        b=MFC2/tVIJP/5o/cB7C77QJ0Nd6DptVKNlVz/cRqGKaV+oAWZSmigPcLlwcKqwVMhMxL4W8
        JDGqr+SVkWUGhQm6f0oRLh18IqoIBitbiiW4yrs2hs7BSwIIKqFAgCutugJG9BVoJEBerc
        cpPdSodmXlA8xtZ8tVkJ2x4z3bqQnZI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-zSiBb-P7NXuvayySdbub1g-1; Wed, 14 Dec 2022 16:10:52 -0500
X-MC-Unique: zSiBb-P7NXuvayySdbub1g-1
Received: by mail-qt1-f198.google.com with SMTP id hg24-20020a05622a611800b003a66175d924so3219708qtb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 13:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSz/PgjD23JYZUEwUZKhlqGEr6/v6TI6lxpkBzb4/nA=;
        b=hFjVo4e/JdozWz9jQtz/nqFHtbF+wpEhMsF7YL2BDve0W8DSKGVJ3U00iU9Qp3zpsJ
         id+TkPMSPERWLMbawOT2kx1I4dcRc8llwXFiwxqUS0dffVur46C4dep/c4BhHyR/SJxD
         usa5Kx8P2OfKxyKl4kyTCDIYU4ev8JvPeTL6qc78A+1lz1DBLutb5otb1cdHAhbvoWde
         ylnK4lki2DclBPnAHHERNn6aMJExjfogiyTKemHs7uBxplCjNfERZZU0J2l0kq571aI6
         jVq0iP1wiVmHzSRrED1ZC+vFwLWQZhZRB3zrK7G+AjEqxrVCgk7xd0m2yvPcStmAr/Ep
         IIlQ==
X-Gm-Message-State: ANoB5pljp3Vzao51UZQ0uKt1808Unz1n15omKDxz5bVGnrN3kas/XxH2
        UH8mN2tTJTbNnC7P0sFarcC++ugkmp+jtANWrD9L0aXSg5JTHSl2llZVAwidMeEn+E6Rms+P1GS
        Li0QKV1TKx6eNp9cguKNXv1TJ
X-Received: by 2002:ac8:67d5:0:b0:3a6:46b4:2a6b with SMTP id r21-20020ac867d5000000b003a646b42a6bmr30959252qtp.27.1671052250460;
        Wed, 14 Dec 2022 13:10:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4S2E0HvCIJs1npjyTP0+FxeBR1jIWod47l+DgBW/7PchMqUrHqEm/2Mth6sLMeDAPoCyfFMQ==
X-Received: by 2002:ac8:67d5:0:b0:3a6:46b4:2a6b with SMTP id r21-20020ac867d5000000b003a646b42a6bmr30959237qtp.27.1671052250278;
        Wed, 14 Dec 2022 13:10:50 -0800 (PST)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b22-20020ac87fd6000000b003a6a4744432sm2391060qtk.87.2022.12.14.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:10:49 -0800 (PST)
From:   Eric Chanudet <echanude@redhat.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>
Subject: [PATCH v2 1/3] arm64: dts: qcom: pm8450a: add rtc node
Date:   Wed, 14 Dec 2022 16:09:06 -0500
Message-Id: <20221214210908.1788284-1-echanude@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rtc block on pm8450a first pmic to enable the rtc for
sa8540p-ride.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 arch/arm64/boot/dts/qcom/pm8450a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8450a.dtsi b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
index 34fc72896761..c9b8da43b237 100644
--- a/arch/arm64/boot/dts/qcom/pm8450a.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
@@ -13,6 +13,14 @@ pm8450a: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+			wakeup-source;
+		};
+
 		pm8450a_gpios: gpio@c000 {
 			compatible = "qcom,pm8150-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
-- 
2.38.1

