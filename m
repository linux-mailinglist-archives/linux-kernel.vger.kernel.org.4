Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEAD7157AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjE3Hxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE3Hxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:53:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22ABBF;
        Tue, 30 May 2023 00:53:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f70fc4682aso1202395e9.1;
        Tue, 30 May 2023 00:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685433215; x=1688025215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79m/nLTn+NpENaFTAI+QR5GINZyts+HlG6WpZNU+yIw=;
        b=F5+vYVvaxjDo6inHzuMAL2MrxE+nEMCk+z9tMMKfMkiSuaCZrTZFRP0t59mWKWraYd
         qa1coa90wCL5s/0VX3Fk92oI0DDn8vHfZXVbShaA0JcJtYFmhxp1MD3MujagIfwRCKZg
         d3CdVqre2xpg8xFu6H1026eA771+DCRs/hw0/q9l+4juMCnDmOrZR/rYcSIOiBsz6QWW
         dq6HYvrsWNUlbQl6AhlGxKCUnfPcQ2RU82Qlv0zAD3EsIBLD6uG5I0NRr8kxVrAX/wAO
         XMzKH65MzQbx/QsQCv5PXKC1uTzZKnrcKsuUrHgriwofLv5md/ifahxjHnMS1NU3xFHV
         Mbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685433215; x=1688025215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79m/nLTn+NpENaFTAI+QR5GINZyts+HlG6WpZNU+yIw=;
        b=YqFodE5wxVRzDEitq4tzOU9XdooP+m7ZjpQHvDNmZja4hda/wxyTPLjNeR1KiGuhnC
         naSlO8gXzn4jVhOPkZx1JFbRATc/zNoIPoHGnV/4qaeV7qzVqVVMxvdoHvgusSBYqEri
         YrbnmO4g0WeGUXqiPbh/6YYaYqOMZTnE0sDOqRj30xp/EEJ683UPS/ijDHVoZhpyR1S4
         J8J56JE1JeDoPnYSn/QQinmf/mm4TKdRrf4EfBBMMNG7VeRnK5piOM2lUiT6KPp1dSY8
         6MgfiWD44tem+QUOqKQ+AIZzTT1Gx2EiEXfVsa9Vin1uD9BRy5XocJj3ooKQ94i3wlR9
         nqHw==
X-Gm-Message-State: AC+VfDxiNnOew4jSCKwF0zg4eKqEcOBZLliBEOuFjLQ2ZRKx/IDQG2t4
        VWOqFdMVXPKRWIjJCKDuwJ4=
X-Google-Smtp-Source: ACHHUZ4Y35lfWLKOd4KKI0PoPFjBl9+AUjECZdfIJVdTTvYrvnGiUJQgTkTqIxohRARimju72GCFpw==
X-Received: by 2002:a1c:7501:0:b0:3f7:5e3:c1f5 with SMTP id o1-20020a1c7501000000b003f705e3c1f5mr865894wmc.2.1685433215148;
        Tue, 30 May 2023 00:53:35 -0700 (PDT)
Received: from PC-UT2.ad.ennebielettronica.com ([78.152.97.130])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003f6041f5a6csm16561275wmj.12.2023.05.30.00.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 00:53:34 -0700 (PDT)
From:   fl.scratchpad@gmail.com
To:     jic23@kernel.org, Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: iio: ad7192: Add mandatory reference voltage source
Date:   Tue, 30 May 2023 09:53:10 +0200
Message-Id: <20230530075311.400686-5-fl.scratchpad@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530075311.400686-1-fl.scratchpad@gmail.com>
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

Add required reference voltage (VRef) supply regulator.

AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
(on REFINx pin pairs).

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index d521d516088b..16def2985ab4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -47,6 +47,9 @@ properties:
   avdd-supply:
     description: AVdd voltage supply
 
+  vref-supply:
+    description: VRef voltage supply
+
   adi,rejection-60-Hz-enable:
     description: |
       This bit enables a notch at 60 Hz when the first notch of the sinc
@@ -89,6 +92,7 @@ required:
   - interrupts
   - dvdd-supply
   - avdd-supply
+  - vref-supply
   - spi-cpol
   - spi-cpha
 
@@ -115,6 +119,7 @@ examples:
             interrupt-parent = <&gpio>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
 
             adi,refin2-pins-enable;
             adi,rejection-60-Hz-enable;
-- 
2.34.1

