Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771936AB006
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCENqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 08:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCENqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 08:46:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7363582;
        Sun,  5 Mar 2023 05:45:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r18so6374557wrx.1;
        Sun, 05 Mar 2023 05:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Etz7w1zB4xD9fNNk3nsimSfalHBMwFfyAwByQKbyDeo=;
        b=DjOn5MokKm3n5yfsnns/kyuu0WwFtskQlH/NG0mmQaqbcfw9ZSi7XeNvaLVRSll0kl
         MmJK3SzkHh1eutpo9I4d7eaULrdnGJT4OvzmQVV25QlsdVy+yw59cVxDROnsG4moEKWH
         Q9Lw3cVK89AJh7Xp7Qv7HZyxEcqWmcENRXzUk/B2eiFZ4NEZktwmyfUjlen8QVK1LlYK
         aWS0nMTM9p3dkUTs1VllYaS9gpIrSz7zd5adiKNsNTUty6iWBTPQ5OqKE6gqm9MfhogL
         sn2G3b5N7goDU3QC4KdV+XqDd/iSbfBfL8j/IXnNoGYA9/yq0/sxujAkkEY4R8QnOk48
         dMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Etz7w1zB4xD9fNNk3nsimSfalHBMwFfyAwByQKbyDeo=;
        b=deOa2VtiamWxoRJK1cd3Mwi4+DsLSgz/h/V2DlOq5m/HETUOmKi1lyNUfY9zSuoKrZ
         kHCHrTtQcYLXYGzmPPNBL/iTrfJkaB6F7NoNSKNIn02LHwazmyo03jBs7eVS7WWaDv7o
         itmn/sEn8Z8Mr4xzKRDHBzIKILc74b1dp+3ZssePRzn8Q/yTYUOiQJVDfX1aV8Lr/SVs
         RtCxhsw0CjGC6EF8qr/Ie0S5LWlpiqNWQHQaMvf6otGhCe849e3W6cBaQ7ykiG4nYatK
         +wIf9mjazwQqRWAFv4+n1VfXEtVWGxbdnrK+mkYR3X7cBTT0gqCy7iyqw2k7175d/+LY
         Onkg==
X-Gm-Message-State: AO0yUKWL9pj+tycstROuLD+wp8lZDn0FHdSKqMFrfsPFca3ciamj2Raw
        wcLLJgMc0fRBMH/fgaNaWFFYUXIUbQkYow==
X-Google-Smtp-Source: AK7set+CiBAhHRWUIYNuzEQaEzY4YgkO2tfoyi3Y2gc3m1hr7KunYUyDzJlLraLRxENgsWnP696oMw==
X-Received: by 2002:a5d:5548:0:b0:2c7:2cf4:baff with SMTP id g8-20020a5d5548000000b002c72cf4baffmr5430761wrw.70.1678023919114;
        Sun, 05 Mar 2023 05:45:19 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d4f81000000b002c54e26bca5sm7421507wru.49.2023.03.05.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 05:45:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for BananaPi M2S variants
Date:   Sun,  5 Mar 2023 13:45:11 +0000
Message-Id: <20230305134512.1596572-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230305134512.1596572-1-christianshewitt@gmail.com>
References: <20230305134512.1596572-1-christianshewitt@gmail.com>
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

BananaPi M2S ships in two variants with Amlogic S922X or A311D chips.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..799a4bfff854 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -153,6 +153,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B A311D SoC
         items:
           - enum:
+              - bananapi,bpi-m2s
               - khadas,vim3
               - radxa,zero2
           - const: amlogic,a311d
@@ -164,6 +165,7 @@ properties:
               - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
+              - bananapi,bpi-m2s
               - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2l
-- 
2.34.1

