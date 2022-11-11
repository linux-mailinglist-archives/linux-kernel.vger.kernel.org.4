Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2323625D52
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKKOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiKKOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:46 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BC65870
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:30 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n12so12942164eja.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUDZC72vgUX/+mjOceon1Lp8omkXG06DLgI5cBosnQ=;
        b=iFvwZclfbIiKwXP++pqGCXBltsjAlYxG6Eg2T2fA6LMnFCV5dUD1qVPwaeCSWErf33
         ekEzJFjqde0fdpIQCgmDy2gvE8PG82AcoO12V0spWo0LUtjPIH7vdyx9dsRZoPmkZNYf
         604eIeEENYz2NPWEJYYEBCQKKihY8U4xDLRDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUDZC72vgUX/+mjOceon1Lp8omkXG06DLgI5cBosnQ=;
        b=MeaRanbZ5dmVZEcr7uMA93xraNjcSokRrTGNNLwx3Dt9q8+I4K1iSF6WyY/Nb+bWXI
         Sb+eNKyhXhaJl3NpqoP41YcIE+Gd0olvArosX4DwW5o1IhUUDvqPUkGTPega8533pxuE
         7cNUlvqjp44Bcv1h+ApglhLW+vc95tKwRXe5p9sW77fLiaqmY9bfmqfyTnpv7jXtg5mA
         90qAZn+EfZiYD8+FM+0l9otB76JNdq9ZF7q67ZFOuZOXr8IIqnCU7FYPEVJ+jQ7vsTBm
         z3jOzCNf2hyC92mFeHaq81RPNit4Pv+GDIBn23nkM2eZTfE2fGAsXDfL+A1BBvxMcNkQ
         Hykw==
X-Gm-Message-State: ANoB5pnRiSP/rpqnDHVEtHepKewIceK2FSLPaoEL8ZZgpt/YLEyFtyE/
        UbSkhnK8W0VljKCkgpav58Q1DA==
X-Google-Smtp-Source: AA0mqf5iH//Tm204ldnCOaAvtZbOZb56fKbSpew5u5OxZ4DlhaeYDYvvxEZ6X1G7mx9HpGdqjUNu1A==
X-Received: by 2002:a17:906:3d52:b0:7ae:44b2:cb7f with SMTP id q18-20020a1709063d5200b007ae44b2cb7fmr1982156ejf.437.1668177568980;
        Fri, 11 Nov 2022 06:39:28 -0800 (PST)
Received: from prevas-ravi.tritech.se ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id jt4-20020a170906dfc400b007a1d4944d45sm945886ejc.142.2022.11.11.06.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 06:39:28 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: iio: ad74413r: add optional reset-gpios
Date:   Fri, 11 Nov 2022 15:39:20 +0100
Message-Id: <20221111143921.742194-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ad74412 and ad74413 devices have an active-low reset pin. Add a
binding allowing one to specify a gpio tied to that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index e954d5ae4f4f..70f82cc716ae 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -51,6 +51,9 @@ properties:
       Shunt (sense) resistor value in micro-Ohms.
     default: 100000000
 
+  reset-gpios:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.2

