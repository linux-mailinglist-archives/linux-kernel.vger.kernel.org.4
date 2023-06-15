Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB4731B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbjFOO1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241308AbjFOO1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:27:20 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FBD2704
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:27:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-66643830ab3so1893746b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686839238; x=1689431238;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx/MdSHrygrfEupx7fTJALuFQUBdMezRza5vPp79ZkY=;
        b=cRJMxBwFjT6tpqn0cHuWuzLwWGZ6XxpeFtiKltWubxfumAn3MQknDaIO2bpeJviJIP
         Myxw86vLE/iHzzEOvzOl6ZbjsFvVCOCc141lF0pa1y+tQoXVfO9Ru0ausAvlueYeT7vO
         151VMNn28Pu8ppWqauTvZbyhYmWT05ybgn9UY7HXZ+H8YIjhRLxyjjS+mrP2sq5n+Jvv
         LkN9xtjoVF4HHJpYoaE4DnyORPj6xUKufyatUXQs+kT2slLhO9LxcFVhHBAQPOz6QsdM
         ROdTv7Am2hbUJ32IX8jnbLeYD8GCkky1KmScdkWxtuFfhs3sds20bNS+0sx1UQPbLUbU
         vrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686839238; x=1689431238;
        h=content-transfer-encoding:author:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fx/MdSHrygrfEupx7fTJALuFQUBdMezRza5vPp79ZkY=;
        b=JZEiQGrU2CTyVdlR4swvvyL4+btbLQhPl4Rys3D317xnKT98nXGyF11Eis92sa/yBd
         YQkHAxyXtkzP/gjc9V7nVnJnz9tBiF9NY4x3qgBhX75pRRXo1iYcoIE14gLA6J9iutMF
         mTIF8nUYClEDAiSWSINE9kp8iyDCLZND3l5YoXqNDhPa8DNTltquf4JDI8nYZ0Rr4NQ3
         DYAhIYxRsAaOtGXv+m6v31ATMsHY0OGNLEUjnaw3nkkqoT3c6JOGaa1oS8Dk1jTc9BvY
         TAkjBfqwhLx5HcFO9ocfoUGv4yZNgX/COomxvjmpndhAY0lD9NhWQIyEDYg2vICC33Um
         9rAw==
X-Gm-Message-State: AC+VfDwMLnj7CAf8R8RjJmYXgqqmKYFA1zswL44rTV5z3yX15KEx+qun
        7OjVThcDkxxfnOElrtgibOwL9Q==
X-Google-Smtp-Source: ACHHUZ6cBthXcPeaMlmqQaMPOJfo1WlbQqotxd59hdZakq6AXsSziHWknx0+CFlx/FoZf2AvGjjFBg==
X-Received: by 2002:a05:6a20:7d94:b0:10b:8221:3348 with SMTP id v20-20020a056a207d9400b0010b82213348mr6100156pzj.50.1686839237796;
        Thu, 15 Jun 2023 07:27:17 -0700 (PDT)
Received: from localhost.localdomain ([49.207.50.231])
        by smtp.gmail.com with ESMTPSA id y9-20020a655a09000000b005287a0560c9sm11931577pgs.1.2023.06.15.07.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 07:27:17 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory region as reserved
Date:   Thu, 15 Jun 2023 19:57:11 +0530
Message-Id: <20230615142711.2994811-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Author: Amit Pundir <amit.pundir@linaro.org>
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding a reserved memory region for the framebuffer memory
(the splash memory region set up by the bootloader).

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v2: Updated commit message.

There was some dicussion on v1 but it didn't go anywhere,
https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u.
The general consensus is that this memory should be freed and be
made resuable but that (releasing this piece of memory) has been
tried before and it is not trivial to return the reserved memory
node to the system RAM pool in this case.

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index e14fe9bbb386..10a06ee8e262 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -101,6 +101,14 @@ hdmi_con: endpoint {
 		};
 	};
 
+	reserved-memory {
+		/* Cont splash region set up by the bootloader */
+		cont_splash_mem: framebuffer@9d400000 {
+			reg = <0x0 0x9d400000 0x0 0x2400000>;
+			no-map;
+		};
+	};
+
 	lt9611_1v8: lt9611-vdd18-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "LT9611_1V8";
-- 
2.25.1

