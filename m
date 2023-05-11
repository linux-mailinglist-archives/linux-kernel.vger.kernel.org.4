Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A56FF74D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbjEKQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjEKQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB119B7
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965e4be7541so1459821366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822599; x=1686414599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EYOWcd2IcetwoVsS4nntw9yoShUHzHzbCdiQYPACYvQ=;
        b=ZF9H/wJcUTYOsPZAliicRUc2hsbwwvgP5Qr5cEGUu1insHuerQcBU8SH0FTChxAO2w
         IhHO4VCitosRKoY8VL4KvNnwE7aCJFd21v0mBLNC9/GVuhHEZraqYLC4RAT/zqbXBPSZ
         DUouMrdouZ9uKyXEiMjY062MI4XWaY4oaKERBLgRVAxlOMX2rA7pKljmNEOd2Chv5oWu
         eoH14uw1YfmbfuQdKNjuS7wXpnFQjpaXrL5eRZytVm+PdUbxfkf42yNbxEZq5W9dkz5M
         /OnLW59L8abxiJsDrpkBJHrJfyh7mJQKsU/gCC6vPUPQuVCKzCM8ggLmIx3Zbi4Hwuua
         nFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822599; x=1686414599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYOWcd2IcetwoVsS4nntw9yoShUHzHzbCdiQYPACYvQ=;
        b=I+kaJdI7u9NLEekIejc6GmyHtjwBV7eCDTueAOvh9nZiqmKAPi7R/UDIDguML/3pAc
         72CvfNNLQLZhT99RhjHuY2SZ3qW9+7eKcWhNJo7OTHasJu4okXbuIjH7StGATXxbHyVf
         8bFmV72COAP5Uo3orK9hlajztBQhuEafy+I94qnUI/oaQJA4rIIbQeZCfB8n9pVUKXE/
         YxDAl/z1SFzyNGScQ9xuBNNUoUvEPFeVAl0/FFlL1Pu4+9kvVJEfcjuOctXbPbNOAoH0
         vyCwsRh0eKVYPXHkL00h1G5FEQBII2BoYcLMLbZJJObM9TWpIlNKLXwpZOgFlIL0FO2B
         QrwQ==
X-Gm-Message-State: AC+VfDyRgBdh+dwL7TzxC1je+kIsY0SwutP9lTQaec89ovymFNj2IBXO
        OkYZjzn+Y31Moi91xBgLzzt+etH3r1ErytxnjkE=
X-Google-Smtp-Source: ACHHUZ79EAj3WuEGlCvYgbOla4gcw7B6Z/enxW/Cr/EEA8IMPElYOLh8UszbcXKyN6DTr8kBvg/H4Q==
X-Received: by 2002:a17:906:5d09:b0:968:c3b5:8b92 with SMTP id g9-20020a1709065d0900b00968c3b58b92mr11798509ejt.57.1683822599655;
        Thu, 11 May 2023 09:29:59 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:29:59 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 11 May 2023 18:29:21 +0200
Subject: [PATCH v7 01/11] arm64: defconfig: enable MT6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-1-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=793; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=WTUqVHBR4HvQxOd4r/5AfIRd2ez+/KjC4aOa4tZxgIk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgE5cCRtuzrGfFZ/Qr8kg9BPfvi6jZ8Gy8XTJn5
 pRDvFXmJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHURTJID/
 0di662itmNlbKs6Yl//j80WfpsNpJ8cPea0z/HfM6Djf8G199KCC73u7VOs0VJMTHrt1svIoHaiOBp
 iB5yXTNt9UY3RBsnKJxtR1N/0QKVWGKzzLy2p6LO7PyJqapU9FejGrfOGEz/l++hGKQVUqiFrtjozP
 Jt/CnDQHQJwfoR5ga9qQMJ1ax64mulMS8ubrByPdbhGCZJVOVlCvTf6Y/48kZmlPfxUkIytfE6Yo8o
 KjQLsXtuwHtn89zGNyR4QAZLMH7g23K/m8Em2KJD7LOqfG7hJeWF2PmTdNSPg0AMMCqN1HISfAFqn6
 zJB13cI+XYVlMCoyfu3MRNeBjkPx75Bl3E7K97uhbiigq1Y+Y3HDOMWTDOvOZQxPf65nBZXuZ2/Tqc
 i0jyjXqAOJPiQpr8unFGIhl8rtBgPfENQ5PV2E3AyIR9LlVzoaNZVfXwagW8fS8mXDqOg+jn7mm003
 /gDJQkvj+V6nVXz1pymWbwn4p2xEads55yhXiSmvfVR9Zbd+svylywPiemJvxjh7jnXf4+ZUMqsIYs
 BTLBJTjN9ooSsUmEJ2eDHQLn7l7kuVKfirGm2FtXG5firM4+8KVboLVpqBZD3aTrdz6HuKbehi8wlL
 F3cqXy6lYJtjaobTsCTqgYF/iIEncaTfxmXAHqmp/txHgS4W4xPKSypTdoRQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the power regulator support of MediaTek MT6357 PMIC. This driver
supports the control of different power rails of device through
regulator interface.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a24609e14d50..ed3fca298314 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -708,6 +708,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
+CONFIG_REGULATOR_MT6357=y
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6360=y

-- 
2.25.1

