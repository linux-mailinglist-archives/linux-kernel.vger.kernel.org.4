Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C8613D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJaSk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJaSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:40:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27028DF77;
        Mon, 31 Oct 2022 11:40:49 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so2386703wmg.2;
        Mon, 31 Oct 2022 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=NmkDIJZq65rQJvt5Ev4NdpjlfKKdxZ/IctFvSe9k4vt08hZdRvmgF9h8r08T6mWpcp
         0UORsSn3m+6jeh6AOlb/wICwElmF+XXvG9ovSpulxf5co5XzMu+Bmh273IGFx763otai
         yL3ovhZgH6gDCp2ZnvtnKVz7IVqgKnPiCCYpML7+5Sv1Y8SoupeBZFxtmddqDqX8QIxp
         BtmRlBbBShHC6nnRFvLR0hTzEeGQAYVJ4/F0ZXBaUffxH6jW88WmHXaBhNOWHb2yfJBo
         e8rAPjBc5PF2BXgQa0zArBUIY/mIG1aDbi0yY5Rmw+7HP3A/Up1hXHjhnApbeTjfg3R+
         MRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf0wqcQ2vn6wyNNf67PgKqcbfJEkj1r+s1XXcU5BuM8=;
        b=i4Na0JKNWH+SKLP5ip/qvwRtMyquP9AH75EOcxeFUG7/BkFXLUSRskZitOe5gsaFg5
         +o8LSMRir4snpQ/KxrsVgc2cpcC0V5GWtwtmPNP5rqk/k8kzHakE4CkGYvXkbkXg14PX
         aI+2LHR06O78fZ2Q1ASHwW6MJm9ZkJMBsRd7kdwdTXb5jgWFxJi4sML4nOUUvj4y3LmT
         qwW+w86EtwxtwInHD6E3amFWKJzPjaHFjj1begD7NdgUnZI/FHnHPBE4tvVeH8aEsgKS
         N0/mWE72MSmFa8XAun/Q1Hnt3F4L1QKvW4lmNNAXV8v3A/T14dXQJe+heTtrGN+UMSYK
         WRCg==
X-Gm-Message-State: ACrzQf1RHnNMGCy4BzrrVaT3NkxtaI2YSPeYLXw3lnZSVxQBQW+Jy/12
        xWt7DI17tZRkKmKTNPa1wgM=
X-Google-Smtp-Source: AMsMyM5k5GhmO8jqFpWyZ6NdCr2JYaXaK42Du6mGoaJfiQzZWpnOkX+n0GyTkfrYg8uWLeUddg/KAg==
X-Received: by 2002:a7b:ce0e:0:b0:3cf:68e1:bd25 with SMTP id m14-20020a7bce0e000000b003cf68e1bd25mr8202966wmc.113.1667241647478;
        Mon, 31 Oct 2022 11:40:47 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c081200b003b4935f04a4sm8525887wmp.5.2022.10.31.11.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:40:47 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: serial: ingenic: Add support for the JZ4750/55 SoCs
Date:   Mon, 31 Oct 2022 21:40:39 +0300
Message-Id: <20221031184041.1338129-2-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221031184041.1338129-1-lis8215@gmail.com>
References: <20221031184041.1338129-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These SoCs UART block are the same as JZ4725b' one, the difference is
outside of the block - it is in the clock generation unit (CGU).
The difference requires to make a quirk for early console init.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 9ca7a18ec..315ceb722 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -20,6 +20,7 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4740-uart
+          - ingenic,jz4750-uart
           - ingenic,jz4760-uart
           - ingenic,jz4780-uart
           - ingenic,x1000-uart
@@ -31,6 +32,9 @@ properties:
       - items:
           - const: ingenic,jz4725b-uart
           - const: ingenic,jz4740-uart
+      - items:
+          - const: ingenic,jz4755-uart
+          - const: ingenic,jz4750-uart
 
   reg:
     maxItems: 1
-- 
2.36.1

