Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D964ACAE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiLMA6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiLMA6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A19317E39
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670893018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0G5DlIm/58n/d7ddm5UPOg5NB4JeT07TXknicvMHP1k=;
        b=h3GffPa6LmsxWVurgFMT3r0cTNjmgBfw84LliU+B5NfEnqHUWluBqlm0e7TICgR1xu7zdk
        7WMJ/zTrj6rW0wURCJtK75U9FpH2zulPLUdknSOZuEjOx1XIRP6g+RukW7N5ob7im+35I2
        r9PabI4W4iNay+DJAqOFJai8i37g138=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470--0cg3x5tOtia3z1FnEZkag-1; Mon, 12 Dec 2022 19:56:57 -0500
X-MC-Unique: -0cg3x5tOtia3z1FnEZkag-1
Received: by mail-qk1-f200.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso16023163qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0G5DlIm/58n/d7ddm5UPOg5NB4JeT07TXknicvMHP1k=;
        b=o+/O1EtiQ7J5qehSrqcBUC5nODpYmYFbbqvvfSudLA+iyaZJoB8Q1Df6qCJc80hzaR
         S9WHOjZVB/HrckanCLIJv1u1bn+pTNFE0FaCEs83P4eMBUax15EaL7PrKauTyOhylog1
         Mj9Te7W9yiz8ZQAj+H2aL9SC4QrrWmT2bu8N4VJuv7HzjgQox1EsgZXagudXtg3DjU6y
         kSbmRYxDQu91JONDm3M7P6uZlEdUz/KA0TJZbAhjkX4W0Tjf5ZiZagN4dvip5DasOtle
         CnquBIkvP5DIDHSjZwcgeL1/663C+c46I9sAcJcQonScMJ2kqikjgZhzgDUlrNvf5PAO
         pyfA==
X-Gm-Message-State: ANoB5pmmlEP8LBuVwYP5G5aTWEKXirm11XiT2VTrbOR7u91n0VtG7igQ
        BN8kr41yLm97aZWUSHDl3DbjtwD4c8MaWN4PNXLNvSnu6toKmEfr49w4dSUefzw0/WtVJif3s7c
        6zheuWtlon0HD94y2OVX4m/9o
X-Received: by 2002:a05:622a:90f:b0:3a6:2170:b0a1 with SMTP id bx15-20020a05622a090f00b003a62170b0a1mr28843450qtb.6.1670893016781;
        Mon, 12 Dec 2022 16:56:56 -0800 (PST)
X-Google-Smtp-Source: AA0mqf57KF3YeBbTEy7Dkoa9TaltSLBPrfm7oE/QdldhQVauvPAWddMoAiL9puqBl9a4SBUg1okGew==
X-Received: by 2002:a05:622a:90f:b0:3a6:2170:b0a1 with SMTP id bx15-20020a05622a090f00b003a62170b0a1mr28843427qtb.6.1670893016567;
        Mon, 12 Dec 2022 16:56:56 -0800 (PST)
Received: from localhost (pool-96-230-116-121.bstnma.fios.verizon.net. [96.230.116.121])
        by smtp.gmail.com with ESMTPSA id 195-20020a370ccc000000b006fb11eee465sm6747657qkm.64.2022.12.12.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 16:56:55 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: qcom: pm8450a: add rtc node
Date:   Mon, 12 Dec 2022 19:55:38 -0500
Message-Id: <20221213005539.1133443-1-echanude@redhat.com>
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
index 34fc72896761..af761dbfbc66 100644
--- a/arch/arm64/boot/dts/qcom/pm8450a.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8450a.dtsi
@@ -13,6 +13,14 @@ pm8450a: pmic@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
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

