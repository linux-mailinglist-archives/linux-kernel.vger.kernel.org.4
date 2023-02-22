Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307F169FD73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjBVVFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBVVFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:05:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E7457F3;
        Wed, 22 Feb 2023 13:04:52 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ee7so20683408edb.2;
        Wed, 22 Feb 2023 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbt3aJeEOkgWRPa3MfKpp7LuHfzCeFjCJvJNJi9PM8Q=;
        b=QpTl01PM3tuyIi8wIIDCzQPYzGp1nAZs0O0EnPXT/GiPYtbwLditEfKYj9I0HsqJcl
         edm5/RfJugSH+PjhnpHHCVpx1idH/Bw9ekKGG07QLwYpzGzEFjNPGxgBhwW2Cpl/+/wo
         fkPu6sUamnyY1HZsgcs0aE4AILYO1e7Vr6KIbNbPqdL9hNkAGMUu5JhuWrYR69prldVx
         UPfvGbyx/Dh3Ha6IngzXd/wIm5ABBhV9snWFshC3WKSE7f9gqBPAUIIjcL9avrSLyBvC
         H5ghH1xAtaONTJCsGIurtakAjTg7oP/fNQBYV5bI9aIFSGOVUlqu4hcIU63OPhtZdEhu
         dHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbt3aJeEOkgWRPa3MfKpp7LuHfzCeFjCJvJNJi9PM8Q=;
        b=RDW1j9HU8CsKyWvKWA+8z2cUhgwmFtJxQUHHtUXyoXPkQduA2Z/uU9s6ARUPnP6Y46
         LL+nlQXIW7D6cuhkRMdjXZJ28fMK1yrz/HckWf/6wp5xlzH0DPdWq7sPj1RftFcuu+ux
         5xp4VTmmEQqMcDkaiNf4vT9WOvlUhnr4FcaKE0g3FciHX8FDDPPyfu2IK7HyJhzFG2Il
         ylJ1kTBpWF9WmsG8hk9qBROSPm6f9iJctwUJuSvcPeVaoS8pAyfbIkHgdzIlncg8rNYs
         jndMrBbX1sbWjairEOTkDFuxkir1TW9jQ5qvzh8oGFe+1WUW4g9znx0epua0RRLN0NHk
         GqiA==
X-Gm-Message-State: AO0yUKVaisZO8Zka7VGxbVjSThuDYKSE/K38LXicODwHF/FPm+73YrKB
        C8Pe46fxsVyAHQdkWiDbVeOf0769BR0mBA==
X-Google-Smtp-Source: AK7set9KkALgBRDZV1vi9ZyBe4G0fUEyBTMSKdxvwQ0WW8i5WiG/vA6Zu7t5NqcQWHOSyhAAg54Ozg==
X-Received: by 2002:aa7:c552:0:b0:4a0:e305:a0de with SMTP id s18-20020aa7c552000000b004a0e305a0demr10644977edr.19.1677099880648;
        Wed, 22 Feb 2023 13:04:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-76c9-eb00-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:76c9:eb00::e63])
        by smtp.googlemail.com with ESMTPSA id m17-20020a50c191000000b004af6a840f21sm209208edf.15.2023.02.22.13.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:04:40 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jirislaby@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 RFC 1/3] dt-bindings: serial: amlogic,meson-uart: Add compatible string for G12A
Date:   Wed, 22 Feb 2023 22:04:23 +0100
Message-Id: <20230222210425.626474-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
References: <20230222210425.626474-1-martin.blumenstingl@googlemail.com>
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

Amlogic G12A SoCs gained a new "divide XTAL by 2" bit. Everything else
(we know about) is identical to the UART IP on GX (GXBB/GXL/GXM) SoCs.
Add a new compatible string for this SoC so this new bit can be managed
accordingly.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Why am I sending this as RFC? The last change in this series means
that the resulting .dtbs are not compatible with old kernels anymore.
My understanding is that this is fine and only the opposite case (using
old .dtbs on new kernels) has to be supported (which is still the case
with this series). I'd like to get some confirmation for this.


 .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 7822705ad16c..3d9d51389171 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -29,6 +29,7 @@ properties:
               - amlogic,meson8-uart
               - amlogic,meson8b-uart
               - amlogic,meson-gx-uart
+              - amlogic,meson-g12a-uart
               - amlogic,meson-s4-uart
           - const: amlogic,meson-ao-uart
       - description: Everything-Else power domain UART controller
@@ -37,6 +38,7 @@ properties:
           - amlogic,meson8-uart
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
+          - amlogic,meson-g12a-uart
           - amlogic,meson-s4-uart
 
   reg:
-- 
2.39.2

