Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335A770A048
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjESUFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjESUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:05:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2A1A8
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:05:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so23054955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1684526735; x=1687118735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhk36Zm9kcZS6s/7QkUBwDpZCpJODd1UkmAk+ko7ofs=;
        b=lFddv1Xx7+aPZjnuJK/BNYdmR8nlXfjsnu2AfYrhh7BYshp1lzes5QgQmT8Nhc/gBL
         KCc6xtnn/dDsF6gi7C6YIJROVs7pvOVZnvCZejZ7ey69pbvMzBs0EhpaXbM5AmCGUnb5
         gGH8L5TA3JLdPqgiLlxcIegGfCFQaMOyh3YSCRjWpGi8bmeJ9J7C5rYazwbHsPAQMTtr
         w7Qde26UkLiaeMT93GpPAhIOQ20R39oN+YLgF0h5UYtM/AOcigpxfR8LCo1xVORSNXKI
         2GgcpH9pjx4n4PdWkfJoO8bs8I5D/YPUTpaXrVJRRGHV6ZZRLa1EL8ph1Yhfc9FLOvq0
         w6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526735; x=1687118735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dhk36Zm9kcZS6s/7QkUBwDpZCpJODd1UkmAk+ko7ofs=;
        b=Izpb249acUYzQvjQImJf21Ryn+V6gXcYzSSiSo0AN+Z6XJRkLlc6kBUDdZG8qy9Hqg
         tOpPLy60yyUbjHu6SN3XLXm967WkIA1zTLMLDsKPnd6THQAWElOjazH4R70dE66k2yGG
         2yJRyLCocDEy3CysQJuzwY5v73gLJMYaZfKtCqk6F84QF+vDlatI6jS7Wpvkwy+bUkkc
         E36gFk46+1kk+/9E2LY+G5quy6GAeAAWCbdnPdYKmgEJc6PkZ0SW8elr1t24iv/gBruz
         Yw8PcJfgcTvYXqGYH3Ahrshlyp7vnqH6PbsUpoRzTiIFwQLera1j+KTC8rGLOBRobK1/
         BTQw==
X-Gm-Message-State: AC+VfDx7E5gABQfcob/DK08RTXmuO7Supjb74QBKFc3FDDj+JgS3hK88
        Ajp2ILAupakxaiWF+r3hOgLuYQ==
X-Google-Smtp-Source: ACHHUZ7/5/41nm0I7TwCks1heDFNmOyLJILcAtVDJl+PWPTeQg8QiNNU9BXxnomI8I+UZzBMfl7Fcg==
X-Received: by 2002:a05:6000:c3:b0:304:6762:2490 with SMTP id q3-20020a05600000c300b0030467622490mr2871230wrx.3.1684526735223;
        Fri, 19 May 2023 13:05:35 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.2])
        by smtp.gmail.com with ESMTPSA id q3-20020adfea03000000b002fe96f0b3acsm6220329wrm.63.2023.05.19.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:05:34 -0700 (PDT)
From:   Alexandru Ardelean <alex@shruggie.ro>
To:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH 2/2] dt-bindings: backlight: document new property default-brightness-level
Date:   Fri, 19 May 2023 23:05:20 +0300
Message-Id: <20230519200520.10657-2-alex@shruggie.ro>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519200520.10657-1-alex@shruggie.ro>
References: <20230519200520.10657-1-alex@shruggie.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Fertre <yannick.fertre@foss.st.com>

Add documentation for new default-brightness-level property.

Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>
Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
---

Link to original patch:
  https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98

 .../bindings/leds/backlight/gpio-backlight.yaml          | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
index 584030b6b0b9..b96c08cff0f0 100644
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -23,6 +23,15 @@ properties:
     description: enable the backlight at boot.
     type: boolean
 
+  default-brightness-level:
+    description:
+      The default brightness level (index into the array defined by the
+      "brightness-levels" property).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+dependencies:
+  default-brightness-level: [ "brightness-levels" ]
+
 required:
   - compatible
   - gpios
-- 
2.40.1

