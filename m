Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE84651285
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiLSTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiLSTM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738111A27
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671477127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OIdwR+qvjuKwdLoe3e5YFQ/t6daZrSiNt47lDk8vL4k=;
        b=eeEKz0NEinFSOp2wZuS4kzNX+KukUztBn1oJ9NYnod6uw4COdMnHNEnzYZ99kBkOxvX+9y
        cRUxoSKuHsT/42iy7W+rYFMFofvYLY9qFqt6QWt242gUc2bkvlHltv2sKpdqyTwN6S8isE
        Br0xiMooDIYDhdSOqmSgUyxTDgSX9Q8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-DuqArXkfNnyF36qo9rQNWg-1; Mon, 19 Dec 2022 14:12:05 -0500
X-MC-Unique: DuqArXkfNnyF36qo9rQNWg-1
Received: by mail-qv1-f70.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so6058831qvb.20
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIdwR+qvjuKwdLoe3e5YFQ/t6daZrSiNt47lDk8vL4k=;
        b=ZK9r20mKNaxa6Pd29zkpeTYZPqvT3JEihYdvDEUon6GtmE91pWSwoyoh5571d1nvw1
         bXVHjBk35occ6bs+RjyXpuy34g/5DuvKp7VUmc2F4AohhEO6cBKKO1LiLzL5J38VxWB9
         keMFWNt2iSvbGYkE8ltmh9SwwHT4T1lOgNuKxQ4CPIekn+DACrrNOFFX5V6aDOuo+cme
         TTVAndkfyiOo0Jj4bS2yLPV9rp742dqAeYZ1o2MtSm6Nf1RK69iMhVUUut1A9IzabCNf
         S8jMLbmf6LW3qTg+hNxTPfO7gAnHbx+kKe8glZg4GFPtfI3JmBHWg1OzjzY1uqcgnblc
         puGw==
X-Gm-Message-State: ANoB5plJyjIsWKVvxTwrL3ALowkVK0iHUzQF8F1BjYqcHgEKlMHvroxK
        8x0hBhf/3G2K6/uYF0Qdfsrdln3aeMBZvTKiVsI3hxgOtH/ejQZs1vz5v2bDYnF3wByLL+GsThR
        Kcyb64TnnCh/ElYeTTr6YSpE7
X-Received: by 2002:a05:622a:242:b0:3a5:467b:c1d0 with SMTP id c2-20020a05622a024200b003a5467bc1d0mr82719783qtx.18.1671477124909;
        Mon, 19 Dec 2022 11:12:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7O2YefxePKoJwTUXuIPiBA7nNAECGHZpF9m3+9R83hpsnY8mCSL2vmHY5jCgQlVc414BYjwA==
X-Received: by 2002:a05:622a:242:b0:3a5:467b:c1d0 with SMTP id c2-20020a05622a024200b003a5467bc1d0mr82719753qtx.18.1671477124696;
        Mon, 19 Dec 2022 11:12:04 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id w7-20020ac843c7000000b003a8163c1c96sm6344207qtn.14.2022.12.19.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:12:04 -0800 (PST)
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
Subject: [PATCH v4 2/4] arm64: dts: qcom: sa8450p-pmics: add rtc node
Date:   Mon, 19 Dec 2022 14:09:59 -0500
Message-Id: <20221219191000.2570545-3-echanude@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221219191000.2570545-1-echanude@redhat.com>
References: <20221219191000.2570545-1-echanude@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rtc block on the first pmic to enable the rtc for sa8540p-ride.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
index 34fc72896761..c9b8da43b237 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p-pmics.dtsi
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

