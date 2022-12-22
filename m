Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B016541B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 14:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235681AbiLVNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 08:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235572AbiLVNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 08:18:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1954A2B27B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:20 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5659695pje.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 05:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WUljA05hxjrMgWInu+aANTEuP2TXhzChwqlFzG2wks=;
        b=C6UEEu2cv9HWmh2bzqVBHeQNYzwhh1L9U41oaFA6os6JZIvt0qOms7EsWan5cEV7G8
         qsqXREDB3CHZbzOCiJBLqi+fXZTtfzBsk4cLkQLICCPN5ELJM2O4eZQdxJnKWrWekIrG
         Cdl+6PhS6yrwZoCPgec0sAfNU/Lz4Z9OaL1GXz+MgxOIgxkIL5pIC2dRDIATEQyzfuq3
         +D9Ep3r9hv4cZKTwNmtK+WPgoD6mU32mkblcraTyNqu1woMe80CkJJt95f0Gdt2fFgvO
         qHQHrtlUG1k8WwTDlZWoj8h16PiKr9rqRyymr04KacTDb2OIZuTjTbLumfQvjQ/wuJOU
         slPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WUljA05hxjrMgWInu+aANTEuP2TXhzChwqlFzG2wks=;
        b=mrwtsAjKUox1itV/c/rtRN6DtFHQutuyT3qUub6iXajGbtJv2ZTrnaqDZeq0rhQ2qc
         oX/rn2AVYjf3z4ujiNWpDHxAjxp6xuVTXxTcojP9Oy1Al8B8VVOluQwAU5E89csAKpBj
         jI/Ef2KZlrNHOGbod9mgXaWglQ6/gcSX6UkDLgUQbgzdnLXAqbJM6CNL8PC0Cg14/yB2
         cgzFgoZFfEMebLuPrJLCDIEfzPnY3eKedp5VlF5ZTkMSziAPelpc9VpjbxX+EJfSQtU9
         Un1OdgvxiuHQq/SF32qYmuWb8bQLubB7OSJWjsz8u6ed0HoVxZXRAy3fBTTFK1OX/Vkf
         cExQ==
X-Gm-Message-State: AFqh2ko8vYS9y10lMB7ZZNwHJV81Dc+b+NXREtFnT24+VfK2hE7Pan4H
        zbNfaXloi/qIQSXqT8a+sKtq
X-Google-Smtp-Source: AMrXdXsCzWm9VWW8TILq8RHEyV9mJ8/MU3x52JiKXifwS6CTKL1XVbjr8B9n0QsLNCyD0eS8wukUMQ==
X-Received: by 2002:a17:902:c612:b0:192:511e:b9ab with SMTP id r18-20020a170902c61200b00192511eb9abmr3162310plr.21.1671715099601;
        Thu, 22 Dec 2022 05:18:19 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902fe0c00b001896040022asm491570plj.190.2022.12.22.05.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:18:18 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com, steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 07/16] arm64: dts: qcom: sm8150: Fix the base addresses of LLCC banks
Date:   Thu, 22 Dec 2022 18:46:47 +0530
Message-Id: <20221222131656.49584-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
References: <20221222131656.49584-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LLCC block has several banks each with a different base address
and holes in between. So it is not a correct approach to cover these
banks with a single offset/size. Instead, the individual bank's base
address needs to be specified in devicetree with the exact size.

Reported-by: Parikshit Pareek <quic_ppareek@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a0c57fb798d3..7fd2291b2638 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1762,8 +1762,11 @@ mmss_noc: interconnect@1740000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8150-llcc";
-			reg = <0 0x09200000 0 0x200000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x50000>, <0 0x09280000 0 0x50000>,
+			      <0 0x09300000 0 0x50000>, <0 0x09380000 0 0x50000>,
+			      <0 0x09600000 0 0x50000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.25.1

