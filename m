Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07670A149
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjESVJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjESVJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:09:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1CE40;
        Fri, 19 May 2023 14:09:18 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f27977aed6so4170557e87.2;
        Fri, 19 May 2023 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684530556; x=1687122556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PY7K+Wc9C9SveL+dDAKdoaLgLphQ7DgMN6a3z63rQuU=;
        b=LKmHBwGxWI2e09cQBEdIalT8kNEazvXf6/sq4Pz6CHy0z7r7x6dhfd3Zol5NiihUvI
         wBlTVeq5TbxSrcE/tBSBlLgfv5RDLXsgiHCmTUc30M2BDCqGPodAlqXBxgj9SqJ+ZYi/
         zk0qYqIWIzoAyP142RPRyMHE3YEGoMCC/8gF+VTRMESX2gFqbrwaohW29nsVzCDXA9Mq
         vlR3mJABSfkBQz8tOWpxxyK49WTzUc2FC5821zaLaukLO3Ttm7ikpG2Ruf/A7Sq4OfNG
         s39StZBQATfU3TdjKnEM3fijhA5Hfiw8qx/VRN+DdlH4LdomUASgtb+HisCgYTQ6+WCe
         5wyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530556; x=1687122556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PY7K+Wc9C9SveL+dDAKdoaLgLphQ7DgMN6a3z63rQuU=;
        b=Bdm84Jgmi/6DQnKSMGsy3UxSeiv+om+AIgZiI3XTh+0Iz8xST8Xceh7fkQqR1MBPwa
         mXSRU2zn+usCyf2gfxznwBXldgYyOfRFK6Fz9p9XYz2XOnUgVmfMXiG77frc7zLsjwmm
         dvH/BZxJ+R+ic9BXtlBeATEhi/2C/EnzJo9z01a5XWKHfQ3WPoZg2c8+nHD3BC/aSC0Z
         VmI77kvrrEoh1W0ihc6Whj202NIAjVW9juwGz/71cpr0+xgwGoIpjo5wrPiim34JJbAP
         anNac/nsO6tJ3TIw7H1tZ3mNn8MqEKlrtOU3Yz3XS2LqVSHl7N55CUInPLB3KW/FKRq4
         5RPQ==
X-Gm-Message-State: AC+VfDwekfilxmZByaiV+lTZK0OqMnM1hPo50e9Tti2f+NRPqgsHXvIq
        Br3xyJlsum32NSv5VAEI3Ic7PjVJuLtAWQ==
X-Google-Smtp-Source: ACHHUZ4togRiDLjA7kBuga8et76xuzt2G0RJ8LrQn4DwsKif6+uvGFnEJBi7EbuVrnBpeEXJIWducg==
X-Received: by 2002:a05:6512:945:b0:4f3:822a:786f with SMTP id u5-20020a056512094500b004f3822a786fmr1091578lft.57.1684530556618;
        Fri, 19 May 2023 14:09:16 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id i14-20020ac2522e000000b004f3945751b2sm30043lfl.43.2023.05.19.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 14:09:16 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ARM: dts: qcom: msm8226: Add rpm-stats device node
Date:   Sat, 20 May 2023 00:09:00 +0300
Message-Id: <20230519210903.117030-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device node for the rpm-stats pseudo device.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index e272a1e15b44..006263373348 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -597,6 +597,11 @@ frame@f9028000 {
 			};
 		};
 
+		sram@fc190000 {
+			compatible = "qcom,msm8226-rpm-stats";
+			reg = <0xfc190000 0x10000>;
+		};
+
 		rpm_msg_ram: sram@fc428000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0xfc428000 0x4000>;
-- 
2.34.1

