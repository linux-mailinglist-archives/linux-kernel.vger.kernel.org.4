Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9776767D1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjAUR5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjAUR5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA27252A1;
        Sat, 21 Jan 2023 09:57:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so7065914pjg.2;
        Sat, 21 Jan 2023 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/VSKDQbMfKNc4vbTKN5x3k2QwZYoCdcG6c1F2hh6IQ=;
        b=N/OIx3z9t4Uo5fQPEj9bdg0ERvScU+q6xoE8zCh20plLzYMf/9mTCvczSMgf1Khowl
         D5oxQJjdnSAR9nLO7b9k4CIRgjjscXzMl8LGbuFhen1oHkGcz+fe+yu8meWpsexNJtRZ
         ijac1+HzMQ7dCjqMcbtaYU54aqUXGQPsqsp89inHtgc/RZzp6bDh7hP0148iWyrL93I/
         fLp0j8pz3h1StWibXfIzaSCBMmOc3v/usQPsHlVjGge3iNiBuVjtOp17Hm4AAl1IA00C
         GP7eBNc0RcVt+TkCmwEPzI0m9/rvS4q53BF4hRDTk7MXCLCW+4rit5dtqLF+xmxy2fph
         a7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/VSKDQbMfKNc4vbTKN5x3k2QwZYoCdcG6c1F2hh6IQ=;
        b=k/+lJtFvdu/BE9ZnQeAga+pHdGtQ0i3to0r56+NHZ5LbTT7i34cG0QTfLdhYeb4DLy
         6g89hP5+Cz1aMxn2O+JHlLtaPK2Py+9LCxMVVgNsdJl82vBZNeS8aRx3Dnp/uBUz8huR
         fVcaA72ICF3IoQcYw6Zv0RuTrWhUdRJbEZo93DWoUMr89lTG7ER8LTqr7E0mKL4Zzhms
         dYK2HIF/zMCQP4wysZd1ZtEArAiz8LldXAdUjqUw9noNduO4w3ElK59c2I808QN+OjfS
         vMQySxrs+/UiJ8+zXXTFeGZWptD1i0Mi9wz4caEfeDzez7cR5Chv3gb36Yk+Lm2uMqJz
         c3xQ==
X-Gm-Message-State: AFqh2kql5aunxUe3GNVviQhsnef4fzGg0MQsG6Tc4hGZFifMERDqFcx2
        mz5nAIgYYpXwv3StvPt58duV5KWQrks=
X-Google-Smtp-Source: AMrXdXvALVURNZxMQoC6IgksCohu866TAnJyj6gUBO2UILqIXRqop3UNiLxFR7pIWHZBawt/TaiS2w==
X-Received: by 2002:a17:90b:1652:b0:22b:b6b0:788f with SMTP id il18-20020a17090b165200b0022bb6b0788fmr6011515pjb.14.1674323820858;
        Sat, 21 Jan 2023 09:57:00 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:00 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: usb: Add device id for Genesys Logic hub controller
Date:   Sat, 21 Jan 2023 17:56:29 +0000
Message-Id: <20230121175639.12818-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
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

Add usb hub device id for Genesys Logic, Inc. GL852G Hub USB 2.0
root hub.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: - add Ack of Krzysztof
v2: - drop the vendor name from compatible string.
    - drop the -OTG and -QFN76 suffix from commit message.
    - drop the GL3523 USB 3.1 root hub device id.
---
 Documentation/devicetree/bindings/usb/genesys,gl850g.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
index a9f831448cca..cc4cf92b70d1 100644
--- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
+++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - usb5e3,608
+      - usb5e3,610
 
   reg: true
 
-- 
2.38.1

