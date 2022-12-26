Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B9656072
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiLZGgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiLZGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:36:40 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9551016
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:36:38 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt4so9982087pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 22:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QyEqd2PVsLQtBlO0g1CJLpuYJZzPUU1GAxcKYIzhawY=;
        b=EdxnySLRFTX3rqNJ/4GMnwbtg/1RaMLcV2mZTGeRNdlwywweKSeD5eDmbqA9jOU3QX
         aDrvmExpKF0MDmSVQONxbVtNCV+mNw84AQlq2967G6P31rpiUZQrYp89q+YtXGxL7b5V
         VHpktZo3tiOC0wmqkUp/I98/Epx70QYt2nfgnDwo1HfsoKDWSKUFZKrwqU0zHwwN8qTN
         kpbG6MdgRpxlSuuNvvWJRpLIIFgBLyeEbxTZON1oUa2zHvnrXsdCjLInCwZgVooy5Pb3
         fQQQQM3+YvIV7VqFlODx2+pOCfHffH3kiLREPsTHTI0nHaeMHyefWO7MVim6754f8jb+
         Hppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyEqd2PVsLQtBlO0g1CJLpuYJZzPUU1GAxcKYIzhawY=;
        b=Adp+5sEDAkxXZDnBPf5K+lJpJhd7j6SjHMY6YWylY2L/sOAdFfZmcclFnubwGF9xck
         HcIyYJ26AQalE52fmFaWenr9R5eu9vxT/qkxbg9tQDq0+MWJ99iMwenGcJOfoZjeCJu6
         gWbIArsMNvXtOwaHMwFmj9OhwDndIO1yJjqLEzo1LVLMf5anHUNwD9Gc9z/CS6MUYCuh
         fktA2bL+rlXfbn41/GPWc/yTQ/PV++zLPyt8lhFHj7YMjGhriz3/sCOqKcEJrm0CqPU4
         wcfw+VVpqPGseAUk/1abea+AOFcNMiQe5tu4tYZQEl2sZDet8Kno0kLUPFcBZoC8Xwcc
         74Kg==
X-Gm-Message-State: AFqh2kohrDMbWLYjT6pc607DB2op0CnMyvw+TPkPO8aJ15QAiL/iws8W
        s0W/yyOwmWuxVLxBlkJU1mDbJQ==
X-Google-Smtp-Source: AMrXdXvgSx1AaYCgFjX1t5DhrtDXePyDgmbNAy5h5LshIAGiVY96/pgizVT4a00Ryoh0kJTExtlL4A==
X-Received: by 2002:a05:6a20:4985:b0:ac:a2bb:96e6 with SMTP id fs5-20020a056a20498500b000aca2bb96e6mr18549643pzb.56.1672036598255;
        Sun, 25 Dec 2022 22:36:38 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id 31-20020a63145f000000b0047048c201e3sm5730659pgu.33.2022.12.25.22.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 22:36:37 -0800 (PST)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 linux-next 1/4] dt-bindings: net: rockchip-dwmac: fix rv1126 compatible warning
Date:   Mon, 26 Dec 2022 06:36:19 +0000
Message-Id: <20221226063625.1913-1-anand@edgeble.ai>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
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

