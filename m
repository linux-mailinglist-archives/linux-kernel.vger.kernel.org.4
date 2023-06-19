Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E50735018
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFSJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjFSJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:28:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3E35B1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:27:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-987a977f62aso206882966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687166865; x=1689758865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svU69Ew57Xfle/xIRnYJHjwQ/Cr4wmX9tz165FRycWs=;
        b=wvqYuZaB5ca1vjq5S2aqa1LAEvRYnArRCq/6LebFSu1mfx1hl0d94TYjRMb2QfqnkZ
         Q+OwX9s1IzNO60CzHgAPoOyBQyLPLtbi7XcbOz3MRWVCDzapdizxF6gNawW571nnEtrJ
         0cfvpujETVJB2OZM9Z+0omINCTcTpIh+m9nG4WA05qWkHSjmBpbcYFJY7y4+iOIf89WR
         oww0oS3Oybze1aBQGzFmaJLlx4bp6cAF2HUu6NqDlHVxFVbzcAeGH6fmA+scC/PoLvJ4
         +0I4fq91EtCsRvR/3+Xi56PnJH2dIUWHkCni+yNbm+11C68IkLoAoJ6upAbtlO+hNuQp
         jeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166865; x=1689758865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svU69Ew57Xfle/xIRnYJHjwQ/Cr4wmX9tz165FRycWs=;
        b=iCPw97+8BUrbdmamG014rx+tH8Ld5sfdvw1P1IzqU6vu8pd5YQYeEdUpo9rhGzit/I
         CP01sMHOsFfS6JxVj/ib6e36qp+lthAXy6qjJX2Qg6x12tPg2syEa1QVWVxA7Z/gamN/
         uHgoDSECkEuZr/ZKJSNlDYiFiPcX93mO3H2WtdDXEGviRUN5eBsMJRiL4bisNzd+xcI4
         PFAHm6ciF4buc1eQ306prMF/1v0XwRGfrolMp/wg8hZkggWnjc+UoOWOPxFjXyMtLcQJ
         VXZjnKE8Nb6zaZ8wItQODo/UDet7RKbgjI+RbMYSsf4zdgJVdvASch/PX34xIVCBB9z4
         Wdpg==
X-Gm-Message-State: AC+VfDy7GB5e7TMPhugHE/slyQOhn/g4aPp1k0W7CVUI1DQ5QN9eDxlr
        8ck1ut8q1ImZdCqudc579b0m7YIV6ZaYyZ/AMMI=
X-Google-Smtp-Source: ACHHUZ5aVA22BWULJT+mapNrH3Xpe/4h+2f+voEsc0N/o7LxeS1bDtvZ37XCqoWGgmKrE5wFMSc6fA==
X-Received: by 2002:a17:906:6a27:b0:982:a3c8:4126 with SMTP id qw39-20020a1709066a2700b00982a3c84126mr7786798ejc.73.1687166864976;
        Mon, 19 Jun 2023 02:27:44 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id si1-20020a170906cec100b00988c0c175c6sm857994ejb.189.2023.06.19.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:27:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: defconfig: enable Qualcomm SM8350 LPASS pinctrl
Date:   Mon, 19 Jun 2023 11:27:35 +0200
Message-Id: <20230619092735.20323-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
References: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
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

Enable the Qualcomm SM8350 LPASS TLMM pin controller driver for
providing GPIOs/pins for audio block on SM8350 based boards (e.g.
HDK8350).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>

---

Changes in v2:
1. Add Ack
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 57c6b7bb88d4..b7b2b51a4251 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -593,6 +593,7 @@ CONFIG_PINCTRL_SM8150=y
 CONFIG_PINCTRL_SM8250=y
 CONFIG_PINCTRL_SM8250_LPASS_LPI=m
 CONFIG_PINCTRL_SM8350=y
+CONFIG_PINCTRL_SM8350_LPASS_LPI=m
 CONFIG_PINCTRL_SM8450=y
 CONFIG_PINCTRL_SM8450_LPASS_LPI=m
 CONFIG_PINCTRL_SC8280XP_LPASS_LPI=m
-- 
2.34.1

