Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B1652702
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiLTTaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiLTT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5A1D0D6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671564555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ecs0/8gH1scEMeIme5t6fO1yMGgoodnS/vov5q84tRw=;
        b=dmjl5jNVqL4ShvoCDOvE/0l3ABx29Q/xfpq219T1q8hLH5Pd/wQ7/+oZDCFN1F3ABe+AL/
        fE6hejfUa7uYTIZyLn2QS4y/1KxAxNbKo0m377TOS6cOaKYRfWOm/wsTZtKtgKRZje2obu
        x1HdyUSd7ZQKwqfgEg3wR2JEtrKZSfM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-263-iW6VLAtsN8iqCsPZpsABGA-1; Tue, 20 Dec 2022 14:29:14 -0500
X-MC-Unique: iW6VLAtsN8iqCsPZpsABGA-1
Received: by mail-qt1-f197.google.com with SMTP id bb12-20020a05622a1b0c00b003a98dd528f0so2527675qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ecs0/8gH1scEMeIme5t6fO1yMGgoodnS/vov5q84tRw=;
        b=Pjh6rvBaWXi3Yw2IDVy+fsV+Jw55uMf88nX6dtsV+6vfgjkG5Z18XCQxbBlWboMQ4C
         /uN40jawA/OWfZnAmSit7P5Lk8lvVx/0jgfnmeP/bvCcnRihyYc5nSFaI/VaVLn7TyYo
         Zz9KcNJq4RDytUphV3VvUm22eyR09vblRpnrjH1o87Lq5jzqpyMenIuHiehpewkYutOi
         2IsTc19brGZ5IBmyTQgpikRowXL1N6D+2nXxdDSlotVdDkLO2JDCG3sVJ2Nqa85QrNb9
         veCmTCZ9rc+eH3nTi7dRpwaDRLkkcVG/Cvi2YxLJm4iGll096ewskUzgdx4dDyJthFZo
         9eSg==
X-Gm-Message-State: ANoB5pnrjNVbUI4WToqyt8fDom+JtsjXMBATzg5CaWHab+KYoQyCUVUE
        hVp3PtjGo5pwoU0BtV1TgYgdGoRIf5YBGCjF4yzLB+/Y+C8i0IjzShSVxnhnZYHy48mcd3+CSHS
        T0UGX/8OfTO+xyiJ7ApxLnM+s
X-Received: by 2002:ac8:409c:0:b0:3a7:e1d5:3429 with SMTP id p28-20020ac8409c000000b003a7e1d53429mr70867692qtl.22.1671564553693;
        Tue, 20 Dec 2022 11:29:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4GKVILLxTyjNI2fMC1r5Q2z5HoeC9HtLC0jziqMaxlNF9RToh9O46Khi3OzGsyiVdZQmbEug==
X-Received: by 2002:ac8:409c:0:b0:3a7:e1d5:3429 with SMTP id p28-20020ac8409c000000b003a7e1d53429mr70867672qtl.22.1671564553450;
        Tue, 20 Dec 2022 11:29:13 -0800 (PST)
Received: from x1.redhat.com (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id gd15-20020a05622a5c0f00b003a82ca4e81csm744348qtb.80.2022.12.20.11.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:29:12 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: [PATCH v3 7/7] arm64: dts: qcom: sc8280xp: add rng device tree node
Date:   Tue, 20 Dec 2022 14:28:54 -0500
Message-Id: <20221220192854.521647-8-bmasney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220192854.521647-1-bmasney@redhat.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
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

Add the necessary device tree node for qcom,prng-ee so we can use the
hardware random number generator. This functionality was tested on a
SA8540p automotive development board using kcapi-rng from libkcapi.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Changes from v2 to v3:
- Correctly sort node by MMIO address

Patch introduced in v2

 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 4591d411f5fb..6c2cae83dac6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1602,6 +1602,13 @@ spi15: spi@a9c000 {
 			};
 		};
 
+		rng: rng@10d3000 {
+			compatible = "qcom,prng-ee";
+			reg = <0 0x010d3000 0 0x1000>;
+			clocks = <&rpmhcc RPMH_HWKM_CLK>;
+			clock-names = "core";
+		};
+
 		pcie4: pcie@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sc8280xp";
-- 
2.38.1

