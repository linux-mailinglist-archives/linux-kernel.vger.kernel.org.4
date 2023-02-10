Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BAA691EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBJMRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjBJMRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:17:41 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DC6E578;
        Fri, 10 Feb 2023 04:17:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so5346805wmp.1;
        Fri, 10 Feb 2023 04:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iAq1Y15dNDe23a7+ggQXaAwsjH6+BmLH7b26udO+js=;
        b=XLZLhg9MahUcvhUYp+OMOVmOx3yquF29MiBO1HJJdg39QTDimNxnNh4+T35D5yXwHr
         Lc2g+XDBEZ05+pzHujhA3QYe4MDzrvtbeZNWA+ReMhYmaFk3z7oiijNE1kNajA9NNt+h
         Zj/2xRq0qGQCguRRlV2UpTQFffp5ALDy8FRDn5lDJQzr279mm0PuS02k1JlYvsHWcO/3
         YcIdSFJTzZDhzA5rVlkaHX8mCARDMFZB2ZWlSSprWUz7PI8KnU8qLNPHJ0M1+tKyZwp+
         YKQBAAACZ12TQrWlUvLUMNRhOSIGAbcJRI5DUR4nbNAfVLeRAxcljlU55oZTKMtwuXHD
         QYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7iAq1Y15dNDe23a7+ggQXaAwsjH6+BmLH7b26udO+js=;
        b=1zBTVJE/1dg2kHzI2aTkjTCom729PO9m6ZOjsDcj9CjKhmzVfVFJmj1rsAquwYyTpX
         s00zdHRT+B9GQZe8gY59QUFQ06hfot5/xN6mnk97E67pwzuZSxGwe6sMf+57mhab05vQ
         6DKSbZZPrgt4jhwB/eiI+5vKxJrcHe1OXLWlD3HrSIJkhJvjIrRy8/ceM1ugton4kMti
         VSzAlxy8WWF7ZcF2mIA++99EqhMAAtwTeTqzdsn/BEgjfdVPIMDWjmdRPtnCifIh/2qE
         iMjVUT7lpqRnn365KL72Y0irYbUopK+G51pmq2k3mON6E/lrRv1IuZeLSCQfZZV+vrDO
         gf+w==
X-Gm-Message-State: AO0yUKUKNnl5JWLZxb6txQgFG+esvL6HZ7cks0VGIDq6QNjdQfpPazzI
        +rSxd3HvpeeVwJ4e1Pz4AccnBDHEtoA=
X-Google-Smtp-Source: AK7set+kmIYCGxAp6RnznShw26E0vfGxQ7sS/CEH+BApiEkE4cpiryC2AZOwvyW/0Ddn4KmrQ0bx9Q==
X-Received: by 2002:a05:600c:1708:b0:3de:e8c5:d826 with SMTP id c8-20020a05600c170800b003dee8c5d826mr12737533wmn.28.1676031458715;
        Fri, 10 Feb 2023 04:17:38 -0800 (PST)
Received: from localhost.localdomain (23.red-88-10-60.dynamicip.rima-tde.net. [88.10.60.23])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b003e001afa274sm5359820wmo.2.2023.02.10.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:17:38 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, tsbogend@alpha.franken.de,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: watchdog: mt7621-wdt: add phandle to access system controller registers
Date:   Fri, 10 Feb 2023 13:17:32 +0100
Message-Id: <20230210121735.639089-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
References: <20230210121735.639089-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7621 SoC provides a system controller node for accessing to some registers.
Add a phandle in this node to avoid using MIPS related arch operations and
includes in watchdog driver code.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
index b2b17fdf4..cc701e920 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
@@ -19,6 +19,12 @@ properties:
   reg:
     maxItems: 1
 
+  ralink,sysctl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to system controller 'sysc' syscon node which
+      controls system registers
+
 required:
   - compatible
   - reg
@@ -30,4 +36,5 @@ examples:
     watchdog@100 {
       compatible = "mediatek,mt7621-wdt";
       reg = <0x100 0x100>;
+      ralink,sysctl = <&sysc>;
     };
-- 
2.25.1

