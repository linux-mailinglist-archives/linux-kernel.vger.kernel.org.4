Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B56511FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiLSScg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbiLSSbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:31:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E428271C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:31:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so13964615pje.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=ISZcvgYc9T6FYAb2s2G8VhkcsIW+gZf6wwrWxwJTuadTmL8/UwfEsuKZXpfLjT+5aS
         9pJQGDzTUqhpIvbASUxiNlkCL7gmxXL5k4xgdrMABF84r2Bs2xV5ZimoEX4bU+faWkqv
         lbilaaI22QvcUgKQDFzzDaZXiUYDpcbVQ7nIILI7SHaIxA/p1RenEKqVDDxJNNQ8KQTR
         YzZI/R1dEsYcNqM2tMTwUSFyWGt/b7PSNDnS4FCEaOOShqQ13SDxbPNPolH73sjkhUSj
         B/CN9eEZejSIprUHRBfYV+b6o7gCKfcJ+xd2zea0dUmHnvjz5JjQ4jW0BtTd8OQPuDEo
         2OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMev9I+ZdryrTBjzJ8tiTgJp1UwzDLK7UbgCFoQvzyA=;
        b=We2tAu6rfm1uJfVdT4ZbMayeudCRvx0AtjSMZHswwrgO8iEVicbNhGkLNkMsVjVRXK
         PvdAIw837zjlwo386b7hMEwuKlF6MS3ySAmqXdB+ldOqolIUQckbWmSW1CeqaVU149DZ
         lETMGzAduOBM3HIlcc/ojyqKqFViAw0dzMwGbpluJHYZfjbJuVNVYpPLO2h0ZOeyS5Ty
         YUKRPPK+7gU/xF5bEUOiFfeVHPxaCia7po3ELfAev1MVjM6aGnT8feQKffFZiSuwniNB
         0nFLHagqNUNGABdwiBiUoFiqWRw/pXEHqESrtfGE4y2THN8TGW6QoPk6lC5HWq0QK4Yh
         ZrBA==
X-Gm-Message-State: ANoB5pnBKaf5BTx2YwWQU6rWAd9bMjXYTF0ncUdXGTAVwIWasRW2pJYo
        t2PVi0Gqhw46EXH8vAJ/ezNp
X-Google-Smtp-Source: AA0mqf7OeNd+vaSQ7kwiTMRnGFUztWZu465KTvzxOsKQ7TuZ4d9JATNY/D5bXSxfHat8beCw82gKFA==
X-Received: by 2002:a17:902:c206:b0:18f:6b2b:e88d with SMTP id 6-20020a170902c20600b0018f6b2be88dmr37998172pll.36.1671474676773;
        Mon, 19 Dec 2022 10:31:16 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.17])
        by smtp.gmail.com with ESMTPSA id d2-20020a170903230200b00186e34524e3sm7480979plh.136.2022.12.19.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:31:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bp@alien8.de,
        tony.luck@intel.com
Cc:     quic_saipraka@quicinc.com, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, quic_ppareek@quicinc.com,
        luca.weiss@fairphone.com, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 09/15] arm64: dts: qcom: sm8350: Fix the base addresses of LLCC banks
Date:   Mon, 19 Dec 2022 23:59:52 +0530
Message-Id: <20221219182958.476231-10-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
References: <20221219182958.476231-1-manivannan.sadhasivam@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 245dce24ec59..836732d16635 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2513,8 +2513,11 @@ gem_noc: interconnect@9100000 {
 
 		system-cache-controller@9200000 {
 			compatible = "qcom,sm8350-llcc";
-			reg = <0 0x09200000 0 0x1d0000>, <0 0x09600000 0 0x50000>;
-			reg-names = "llcc_base", "llcc_broadcast_base";
+			reg = <0 0x09200000 0 0x58000>, <0 0x09280000 0 0x58000>,
+			      <0 0x09300000 0 0x58000>, <0 0x09380000 0 0x58000>,
+			      <0 0x09600000 0 0x58000>;
+			reg-names = "llcc0_base", "llcc1_base", "llcc2_base",
+				    "llcc3_base", "llcc_broadcast_base";
 		};
 
 		usb_1: usb@a6f8800 {
-- 
2.25.1

