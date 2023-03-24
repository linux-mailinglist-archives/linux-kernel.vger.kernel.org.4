Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007686C86EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjCXUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjCXUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:38:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1E1E291;
        Fri, 24 Mar 2023 13:38:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bc12so2977747plb.0;
        Fri, 24 Mar 2023 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679690318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L17oQFBwh960wPlLJy74rPkpUlCRFoXdnkcNVNHA6eI=;
        b=gQpaDzq1CFFUBBp90qms3uD/42u984iIFwH72tEbcEq6/kKgT0l3q/SXCTsISKXEil
         OXFmQsMl77VA7tOetyHiKgOwLFewnFXrtrAFbymcQoN1dFSjvpzUbscIULh31bZAB2vz
         LaEUyGc5E6Zq4pGT7cU2NFkUYbuQbOdmQln9uJUQn80Gu8Lt5h3YjXI9FC/13d6bst69
         cm6Q97eFWZ6sGwgviLFyS59bNtriUvdDxYBm4+zZVkSyJ/LCMLiLxvkvWz1Pb/xVh0+I
         4N9bBcHdIAykN8oIvbH/K7Q1EjzN8QHx8zbedqDKVbrZT+AKl+UiterEBXy67FLcmNol
         Uvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L17oQFBwh960wPlLJy74rPkpUlCRFoXdnkcNVNHA6eI=;
        b=hL1uUqhQc+93R+uvnhh76l1jyiQcsunyx7XaLkHyCxz2N+2rohWQ0HLM2GKrBTYXaY
         HTCw0AOgfWKK/OFcWwLmzluXqSPMg0C7iKaYrotbLgYJY0J6nE+mHbT5f2DTO0kLMq7U
         oh4AdJgNrWnJve54Iw5FXqU/3FBZdFHiFs8DMaruihpSiC15lyWb6w7gsWGoQdweus2b
         rbW/w7xs6lw3nTPdUEaMJD04WVzaQTOxos1JgzVjOdYWYpIHDwxMIKg81zD4NoaMdC9M
         SUtpTUfT8xVuEzLCwADRWJEAeMjdDt/D7pXkVyL7d+/4tu5KopB5NGFqK+DHrFMgvjlB
         OcYg==
X-Gm-Message-State: AAQBX9cem5wAkSJ0IRDS6eGqHmmkJw0mEQ89mEzOrslQ8fJU75/KjVVq
        NdZwfoLktllPTCj+q8DzAHh45AfIF7w=
X-Google-Smtp-Source: AKy350ZLs+tUkVMrVQO98521NjftswQW+dxjR/12EQrJsxqezKyUVNmiz/ZJVfNBzmHRxcjs7qR4oA==
X-Received: by 2002:a17:902:dac2:b0:1a1:cef2:acd1 with SMTP id q2-20020a170902dac200b001a1cef2acd1mr4641819plx.17.1679690318572;
        Fri, 24 Mar 2023 13:38:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b001966d94cb2esm14503431plr.288.2023.03.24.13.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:38:38 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Matthew Lear <matthew.lear@broadcom.com>
Subject: [PATCH v2 1/2] dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
Date:   Fri, 24 Mar 2023 13:38:32 -0700
Message-Id: <20230324203833.3540187-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324203833.3540187-1-f.fainelli@gmail.com>
References: <20230324203833.3540187-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO IR receiver can be used as a wake-up source for the system,
document that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
index 61072745b983..008c007ed702 100644
--- a/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
+++ b/Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml
@@ -23,6 +23,9 @@ properties:
     description: autosuspend delay time in milliseconds
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  wakeup-source:
+    description: IR receiver can wake-up the system.
+
 required:
   - compatible
   - gpios
-- 
2.34.1

