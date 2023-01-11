Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A16654CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 07:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjAKGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjAKGsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 01:48:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15E5FCEF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:48:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bj3so11684048pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOW8QelbsetPaHwWo+Ef2/hNHiC4Lmgaa/4OXCs14ak=;
        b=FYK9Tf0ShQColaigpcJHOo7vFiMPFrdVqQnpDLTxcUh4Xiw5b+yQrfLKNI+aJt8WjO
         5ARpsUqtaSG1xKKo0UtTbatYGpQA0mjHwYwtKQc22FtK9+z2rQjDDN/3FSHmPgfwvAH3
         xaDw/EgKu0vB2GriFiDeWrPFRj3baJj/VLuNcsb7VoFFjaohvC2UX8TR5W2V+HesZZBe
         /AQLQyP3CndA8SZopFkNjQD1ZyHih7NB0ClwyevKstmyQz3mOuRDZWiSwL4tRn1Fw0U/
         ROh4d/UBy67bWvZZt3E6IM9gIGR0kFyc28NUMF542nowL4zXOXZzcifx2SOcxiF5bva6
         QcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pOW8QelbsetPaHwWo+Ef2/hNHiC4Lmgaa/4OXCs14ak=;
        b=S77U6AcPK+HGDdHWmgazbyCPcqAyQvvfH4Zbw2gle/zFoGufSSBEyEvinvbJmbYBqU
         MWPKplK5Mrwn+adQvR+bDcTGtq03ylMIgTYHElor1PQqZUUoG5alIy+ZPxcwLyg2I7wh
         5+Pwg9IRgYnabmcH8nClhb3J7hd6l6EMM0MuNrhiGULE2u/Px/7FjudIJkwmuZj1HPzf
         GusNCbBHZ4oKcdKrRLMG/gb3s952wdola9GDZPMj+SAMV32joM5Oy7femWvgNDIAj6Yb
         yoP6f+Ey8GvOuZv0acsOWtWtjdVbcetSOVWudG52lYCvM/j57VC+C8lBprVRmY4LAI9+
         p21g==
X-Gm-Message-State: AFqh2kq6f8IW6uxxnIixnZuXuLNBz3lfNBUK5K1PoV8nxpNXuzekXuD3
        4CfRJADyucvzkYrAzUIETHKLdw==
X-Google-Smtp-Source: AMrXdXuCGS2rYDB4jzJwTRppDihHyZElNqI24UqbsbR5HEpYSYpKgg00nyJo/KMf86fnvwCjNZiaAQ==
X-Received: by 2002:a05:6a20:4b28:b0:aa:7d04:109b with SMTP id fp40-20020a056a204b2800b000aa7d04109bmr1480250pzb.40.1673419733390;
        Tue, 10 Jan 2023 22:48:53 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b001930e89f5f6sm9301861plx.98.2023.01.10.22.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 22:48:52 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4 linux-next 1/4] dt-bindings: net: rockchip-dwmac: fix rv1126 compatible warning
Date:   Wed, 11 Jan 2023 06:48:36 +0000
Message-Id: <20230111064842.5322-1-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compatible string for RV1126 gmac, and constrain it to
be compatible with Synopsys dwmac 4.20a.

fix below warning
$ make CHECK_DTBS=y rv1126-edgeble-neu2-io.dtb
arch/arm/boot/dts/rv1126-edgeble-neu2-io.dtb: ethernet@ffc40000:
		 compatible: 'oneOf' conditional failed, one must be fixed:
        ['rockchip,rv1126-gmac', 'snps,dwmac-4.20a'] is too long
        'rockchip,rv1126-gmac' is not one of ['rockchip,rk3568-gmac', 'rockchip,rk3588-gmac']

Fixes: b36fe2f43662 ("dt-bindings: net: rockchip-dwmac: add rv1126 compatible")
Reviewed-by: Jagan Teki <jagan@edgeble.ai>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
v4: none
v3: added Ack and Rev from Rob and Jagan.
v2: drop SoB of Jagan Teki
    added Fix tags and update the commit message of the warning.
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index 42fb72b6909d..04936632fcbb 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -49,11 +49,11 @@ properties:
               - rockchip,rk3368-gmac
               - rockchip,rk3399-gmac
               - rockchip,rv1108-gmac
-              - rockchip,rv1126-gmac
       - items:
           - enum:
               - rockchip,rk3568-gmac
               - rockchip,rk3588-gmac
+              - rockchip,rv1126-gmac
           - const: snps,dwmac-4.20a
 
   clocks:
-- 
2.39.0

