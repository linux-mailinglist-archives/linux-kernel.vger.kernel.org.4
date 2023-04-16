Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C96E36E2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjDPKCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDPKBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:01:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DA32D42;
        Sun, 16 Apr 2023 03:01:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c9so17895613ejz.1;
        Sun, 16 Apr 2023 03:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639307; x=1684231307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS+Nk5tohYdjt0M+Lv5Edd8xQcZQmX7f5b7WTtVtHzg=;
        b=RuEfaLXciTcAZlv5u4MJtuL2VgOZ49Wdk/1vl86tSwFdXqfjiltwWMwo8uvtnc0ho1
         bufJbRYn9hMHXwbO7uJ/BoOuEy5dP2PhGYyYrybgWwHH3JBP5IYvvWxDNdPbVaCoxYEe
         ZszvpLPCZ6gSt9tceHdv8CxNhW61IxKZg/DisecM+uy4hHVjijoClEnPXJpEIAwZSwR0
         kGTPhgI31i3yARXH3AhqoDuPlVG2DbIYmjn53BIBDsoiWe3gEL3J5v1rWOwT7W49HmxI
         MoNbkh6iDVlDOegG9xTAiilRW/vNWXvwStWC3VfI1Ul223w0g54tFzdpInX8qSQd04Rh
         dTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639307; x=1684231307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS+Nk5tohYdjt0M+Lv5Edd8xQcZQmX7f5b7WTtVtHzg=;
        b=TheTzdoNFeplXH2znBw0GG90A2UZ4CnknSQO/1RQVhzmhrbFG2br/aNfyQhOI5fFVd
         RLrRIu/GRyNl3Gso6lW/atwnAE9h8tfDnLlDaZTNhbv/KC3iYLOQedxeM7J8QVg6Eoff
         V1N4TNJZ5+KXA2yN63TUhz8uj80/BSc6iqALJbhYxuztxA1BZnmTGDU5UIorlZISmQk7
         GJyc+hz71FXL85PTt7jGfjZRWDAOtN746gN8EVOsBeKOg2KeFyDm4CKXvPxWKnc3CcLN
         rpbElm4RCTpEawvs0gtD1BZh71Zx8KQWgn9DfmwUQkwX37S5w/9IHE7H09gjxVMgjMKN
         7DUQ==
X-Gm-Message-State: AAQBX9fyg5FlWoFEsyNWd9jDmmsJ+7kItNsTS/6M64RkD3Hlbv4ekN10
        vsDMWtb+O6+djQq9ukC5kWQ=
X-Google-Smtp-Source: AKy350Zsxh+KLSNWSgLa2gYb4NYNfxQubU3xCOln1931vfBIF0m0uS+s3t5u+AG6G6D2YvI1PIuNkw==
X-Received: by 2002:a17:907:a074:b0:94e:bede:6d2a with SMTP id ia20-20020a170907a07400b0094ebede6d2amr4503207ejc.24.1681639307530;
        Sun, 16 Apr 2023 03:01:47 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0094f6bf5ac9asm145232ejb.22.2023.04.16.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:01:47 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 3/3] MAINTAINERS: Add myself as Samsung S6D7AA0 panel driver maintainer
Date:   Sun, 16 Apr 2023 12:01:39 +0200
Message-Id: <20230416100139.13741-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230416100139.13741-1-aweber.kernel@gmail.com>
References: <20230416100139.13741-1-aweber.kernel@gmail.com>
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

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6a55e6e3ac59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6623,6 +6623,12 @@ S:	Maintained
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
2.40.0

