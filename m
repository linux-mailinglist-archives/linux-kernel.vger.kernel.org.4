Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDA6FE165
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbjEJPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbjEJPP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:15:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59E019A6;
        Wed, 10 May 2023 08:15:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f42d937d61so16314935e9.3;
        Wed, 10 May 2023 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731748; x=1686323748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJwZXQFjVpMj2S27IS+ax8WA5RmmDUnh26i6v4v3GNA=;
        b=DOs5iepZj6CS5TDUGq5CFHgkXWFpiNAeUOHOxPkeznNHoOzC2NajlszLqZTY54BOHS
         Ast+IVEzDC+52+KF+lBtUHe5o7Io2TwGA0vCs0kR/3GbSa+BmKacL90xin92w0FGwZ5+
         nIfPs3n6Ga7raD7WA6TZGWRYw0RkwjMnpxGZLLb7T68NBIlUd0hiEd6cot3mxi2t90zJ
         Butoegi2cgoSbKNMxvVoT0TAgQ3vetT0f4yE/X4G/QLvnwj2lj+QXdRQuLnd5t2DpcPU
         G1WtTALvYKmy3dWc0VN1K78TP3B9IwEoP99C66EwDjxVVzjPqhuGoIxUJjxQkk8iLERh
         xLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731748; x=1686323748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJwZXQFjVpMj2S27IS+ax8WA5RmmDUnh26i6v4v3GNA=;
        b=QPxux/5AGQ5gWFEo6sNf81ukgV1CH7dm9DR/V748P4jB1d3gGUO/1Oe/Y94r+Bg8Oe
         vBmYlIrw6R4uGAk8lr7tP1jZpomYa1hcGnWI7wivr8kmOVYHO7EpPkZsjpf8vLU0mxOM
         jZJnaYbbrOZuNaxoIiV/ke9SyijkFOQC9U4rXkjWXrwAY8n7wRXYRvR89Gr4qFxX5MDs
         oPZQ0RKQvWp/zIDLO4ZVhM/szEGC30tOmO0qpC+lzlbrRIU4PUacnTHp22ZzTQLBWdhY
         Y6u0g5vOn62XQ+S87sx34r3cMZ1g/IMNrWIOOQSSzfryu8qlXp0G8r9cJXA01qYhVEoK
         SVnQ==
X-Gm-Message-State: AC+VfDw7cfDUMEp3KWJk2n71/lA4IG/m9nPBqfG2aWSUd4sAJKzHYq54
        RD8A63zKvJ6z7omJVQv8AUE=
X-Google-Smtp-Source: ACHHUZ5TunqlvNfMozGWZM6C3uiUnbrnkWSegZveLI2WoxqAaAqnYwmQLBuC4cgcIo5PSi85aVXkZQ==
X-Received: by 2002:a7b:cb58:0:b0:3ee:b3bf:5f7c with SMTP id v24-20020a7bcb58000000b003eeb3bf5f7cmr12765651wmj.23.1683731748058;
        Wed, 10 May 2023 08:15:48 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003f195d540d9sm22822499wme.14.2023.05.10.08.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:15:47 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: mfd: add bindings for AXP192 MFD device
Date:   Wed, 10 May 2023 16:15:42 +0100
Message-Id: <20230510151542.312588-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230510151542.312588-1-aidanmacdonald.0x0@gmail.com>
References: <20230510151542.312588-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP192 is another X-Powers PMIC similar to the existing ones.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index f7f0f2c0421a..9ad55746133b 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -90,6 +90,7 @@ properties:
     oneOf:
       - enum:
           - x-powers,axp152
+          - x-powers,axp192
           - x-powers,axp202
           - x-powers,axp209
           - x-powers,axp221
-- 
2.39.2

