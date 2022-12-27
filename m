Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E23656996
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiL0KtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiL0Ks6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:48:58 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2B3A1B1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:48:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl4so6628606plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 02:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTKLuzkwLj+Q2/P4X0bnHmkwF9FCPAj0tHenrsB64MU=;
        b=hdFU7UXge7DZPRpCdlZ8nglNVWmcOuTR2FjkeOANwBgCZ3F2DESNTF/GibvEPWTshz
         rCxGwmtIDPTCanOxY+lBsSBOUx55E7Y/Z0ztWDxDr0y+DSaXqDu/ml2lityYuemQ5FMK
         +ELaseW7KSyLBb4l9lagFg3yv+USCXdbjxOJ+iVYPhEFnRSJ5zN2TuodEiaVQVg9qczr
         aF0n4D8xHKdRabMDdMjalIdYSSR3O0nW00ctJqVZa7EJUB9YzrPbbUioz2RdOuC333de
         bz9pbG4v5sDZVTsaRWo/sA2v5kEquJeqzmHaNJb9i99HkNCdua5gOnQxOK+dv1Wf7Jcv
         g/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTKLuzkwLj+Q2/P4X0bnHmkwF9FCPAj0tHenrsB64MU=;
        b=3ESAY9Fa2UEsmD1aK1I74o4fwJUlZit5ptyl/ZWzBpCnHqrHWI7KzuhtQNSZ/E5Y+O
         Ew8os0l+LVlswyChsfP9kBIkxeN+2gS9LxLbyBJDWim5JBOCZlZuPELVTmOaAp/WJEIc
         lGklCRFscCV4O+uNTKQXYo0dKf24c54rH2Uu4vC4JT9YRtjG7KAw3Chh/9XJFS2by398
         TIhywNubm+y0Yb5Ixo96DqTRmpzF7Db+MA4FBLrmjmQ5ko6kE7PIvcW/FiNMFyDV3tKk
         tJGzZh8mCJjxlbPfsy+Y8hBct7YHtJxluRJhpyTUCOdE1yo8tPylkORL2DQCwJS5f0Oa
         5fww==
X-Gm-Message-State: AFqh2kpFQfi8qZunxUVwxc27b8mW7rv0aqaL4d4R7Vxc4lRL31P1QJnS
        gaI9X4uNTU8v4DhW5zzelcUz+A==
X-Google-Smtp-Source: AMrXdXv1Z/aYGHPnuLv8/usCVi6UgfeoQF9PF5KxPbvZs2FqfHDvdi7G9dC66WbevOL9lCCZDwjOwQ==
X-Received: by 2002:a05:6a20:2a87:b0:b1:dd00:eb05 with SMTP id v7-20020a056a202a8700b000b1dd00eb05mr33626652pzh.26.1672138137218;
        Tue, 27 Dec 2022 02:48:57 -0800 (PST)
Received: from archl-hc1b.. ([45.112.3.26])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm194809pfj.112.2022.12.27.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 02:48:56 -0800 (PST)
From:   Anand Moon <anand@edgeble.ai>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        David Wu <david.wu@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>, Anand Moon <anand@edgeble.ai>
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 linux-next 1/4] dt-bindings: net: rockchip-dwmac: fix rv1126 compatible warning
Date:   Tue, 27 Dec 2022 10:48:31 +0000
Message-Id: <20221227104837.27208-1-anand@edgeble.ai>
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
Reviewed-by: Jagan Teki <jagan@edgeble.ai>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
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

