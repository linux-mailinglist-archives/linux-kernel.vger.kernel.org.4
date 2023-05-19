Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA6709D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjESREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjESREJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:04:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE2B9;
        Fri, 19 May 2023 10:04:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-969f90d71d4so538374766b.3;
        Fri, 19 May 2023 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684515847; x=1687107847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dVkVm60owDC6JSzPARMnl+gul/1/pxMfMjEQitNv9I=;
        b=I6BX/OCq0V/akGco+l/0H4GeaSh7ChmeYNKOuUp7wIaW2ZO3Nir/gbUo34ov/BbbNA
         s346zCmhh1Qt0CzHHcao4ykKmigfv3kSh+20tYSasmtTOdlyyU9mL1szZNCBXH8It6mK
         fba2vffHbKsDiZsqxchLCiYFAV9ccD21h+a6aUtmus21pA8ZxVVSDx+IMxp2wRRoRbMb
         3YGa9jSfX8P2143/jgIXUngL0hl2GmRKZlf0jYW8VumyzOD8xpdA33TafTP+SmLLMZlY
         TrZONhgWwqdInP/HM3bSQzyqZoMDcKG+MvLj/AVwU8qetrUp7NyBy4w+OIJzim+s6ro0
         rcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684515847; x=1687107847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dVkVm60owDC6JSzPARMnl+gul/1/pxMfMjEQitNv9I=;
        b=Gj56lLb8u7vcWGDpdo0hk6eppYwnb4NVLe9iRXcwqdYathxRhx6l0q1G6qh/uS5/UH
         ghE1KBzgfFVPTeFwa5yxE7afEm3jomQ0QkRHhwjuTQl0J4g5D3oENPtA/H7dqdvBArzK
         oaM42nAs/VLTU7aUVuuKQ+mzabDQ744jIckhKrh9hcui79WTTEYadzTdxHhFZ/tLGi3S
         HJ0EoNE4s86M+qHHwYl4P/XC8x79/sWmgHKCC0uMBUC7u7YThw0MhfI/FNmtkSlUPEC8
         kFNGoDc+vbTFedzn91BKnEmmD+xJ5EU1mfGBi3G1dVLhrT8OHLb4Jyg5FFqGtN6MKtpZ
         6LNg==
X-Gm-Message-State: AC+VfDxwjTkDyuY3LKor8EiQr8CPqVA2yHD5GCjv8oPXuyPDc0ISEDUO
        Q95ecFUv4bSTjgb//B7a9SSq/vtOvA4=
X-Google-Smtp-Source: ACHHUZ6+1t44ouGqhWp4W8tIAhR1PIcUO/ZWAT95WAs0wVjJJ2TAyw92KSvswc70U/jJMKs3pYqr6w==
X-Received: by 2002:a17:907:7f8c:b0:94b:d57e:9d4b with SMTP id qk12-20020a1709077f8c00b0094bd57e9d4bmr3007224ejc.2.1684515846457;
        Fri, 19 May 2023 10:04:06 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id mf13-20020a170906cb8d00b00965ffb8407asm2489988ejb.87.2023.05.19.10.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 10:04:06 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v5 3/3] MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver
Date:   Fri, 19 May 2023 19:03:54 +0200
Message-Id: <20230519170354.29610-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519170354.29610-1-aweber.kernel@gmail.com>
References: <20230519170354.29610-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add myself as maintainer of the Samsung S6D7AA0 panel driver.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 402e26d0cdbc..7cc2bfa4af6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6663,6 +6663,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.yaml
 F:	drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
 
+DRM DRIVER FOR SAMSUNG S6D7AA0 PANELS
+M:	Artur Weber <aweber.kernel@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+
 DRM DRIVER FOR SITRONIX ST7703 PANELS
 M:	Guido Günther <agx@sigxcpu.org>
 R:	Purism Kernel Team <kernel@puri.sm>
-- 
2.40.1

