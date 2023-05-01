Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC606F364A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEASvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjEASvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:51:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA41FC6;
        Mon,  1 May 2023 11:51:16 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-95f4c5cb755so570817566b.0;
        Mon, 01 May 2023 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967075; x=1685559075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ia4S9+YQp0hX054SmvRAd0/GGyvsyhJekQtGvFs9lZQ=;
        b=TSMtVM/KcrRmtF+UDxEuIC3kVv5dfOap7UT9r3zRPlFcA+h72j/j/Nc9iPmrFTgwC4
         a26u3Wi3qOxAPcAdj4/2G2PQ3mi2ww1HPFwAbKUYsevdjTjlgnOcPZQbnnnuoGtHyq3x
         k5eWdaF9hVazYrs3m/stejdLIdcwY0d+1JQhclT3Qc3vVKxTeyVf047r2r/ytwjkAwe9
         D3NStU3JSnMeOEPKrGmXWEJNnZX2acAw8IeEWYFnWbWUSodaSKAsm1poDdqiJG8ZGA73
         4tfbjqcKBNPypqKUi+4JIc+DWk1I1k3LwNfiTDGqEKhNFysG0UFBJcVlHajqH3Ga+uhl
         3fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967075; x=1685559075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ia4S9+YQp0hX054SmvRAd0/GGyvsyhJekQtGvFs9lZQ=;
        b=EPOnuzBg0oUn4SLrcbai/wQ4/MBk0uvW8x/89Qbs7FZPX4yu4OrOdBp1XkBoEPJs4s
         zfTEMIB4+FE0fKOS4e3CElv6JXDuf+Z6TcuNfQ6jFMpgwyFBNrwtBP3nD9177P1PFWL/
         QXYGff0N/Ts9qYqKxoX8JJCNCHO8T+r7Ihx+jsz4A9EDIE8WBNttaL4z2ak/Kw4uSRMH
         LzDcIilqclPARCwJlrlb4PGITprtPZhqTZXYkBH1gK3y7UcQE/gI08K2i7O0ETQFMDs1
         q4Dc/qsLhCHx9uleaP96m9wyI4bYcJvodD+QDf4NGgCOU7gLbRpP8fMlTJIvMDR7A/T+
         6SAg==
X-Gm-Message-State: AC+VfDz1GtAFQEndJHGsOq7uEnQsoLWtxu9LpAsfBY/g+0C0gTlSLmz4
        DU7qeaXx4LnaTzxtBWE8O80=
X-Google-Smtp-Source: ACHHUZ5KFqi8j+53PjOE4k7tKQLtJogIZF5Gqg6aaMT6dnsZEF7Xh6DD+ZHgPQq+bJFOLMCR32oL1Q==
X-Received: by 2002:a17:907:2681:b0:94a:682f:7744 with SMTP id bn1-20020a170907268100b0094a682f7744mr13675993ejc.16.1682967075013;
        Mon, 01 May 2023 11:51:15 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906594a00b008cecb8f374asm15028335ejr.0.2023.05.01.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:51:14 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v4 3/3] MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver
Date:   Mon,  1 May 2023 20:51:03 +0200
Message-Id: <20230501185103.25939-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230501185103.25939-1-aweber.kernel@gmail.com>
References: <20230501185103.25939-1-aweber.kernel@gmail.com>
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
index 59a9a22a69fc..d1bc2f8b6e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6641,6 +6641,12 @@ S:	Maintained
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

