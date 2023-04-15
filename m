Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FD16E30DD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjDOKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDOKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:48:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC8AF19;
        Sat, 15 Apr 2023 03:47:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id gc14so6756387ejc.5;
        Sat, 15 Apr 2023 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681555624; x=1684147624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pUd8DFQ/mMGaJuS7CXpgBKGgZF1BMCPB7h8W33HCwg=;
        b=n5tydzgrJ8BvqSB5++nyIu0SF8/YOb1MSjRmH8/IFtW5mQWsPuRdyIOra6V10T6FZV
         hGgTYwMF+lx8KLw1plktt251TOYSkKZ9vv5zpyJ8NQF1MJjbBbQA4mpO6bcHTyRnBRMm
         nS9OooZA+VKqtHhBWUP8wUwCmNH8wJhM/7icFMUGeecgrDfxtMBRJ58l5wAPAU3I3F4v
         T1xy306yEAhHINS82+ZJAiM9qUo2CN03M4jNl7fH2SsfQN8YfnvNJR4nx2PLNSpX4TUK
         g1Aeo04jMyInkcrxEsesYnIRVLdVKQOoC8/C5jvr1FocICGeaq03k4eS7wodptjJP17R
         NSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681555624; x=1684147624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9pUd8DFQ/mMGaJuS7CXpgBKGgZF1BMCPB7h8W33HCwg=;
        b=Iix+PbmE3aXg8q9FzFjpGmg2yPMGXGV51xPA7YUDL5R0mXrzDX10BCASB43YV0yQIc
         WzVI4t7Xc5UvTZMnq9Ak/bzJms+EZWTPxZZMV4c2/urt1BgQ+kLD+dvCWda/KIzKH1FF
         63AcFBepFKkWIzUhXbnBrfmAHeyctsc0PDJ2t5vX4lnfjxlQEqa5tphjgHA2tlcVLJ3l
         zlI4nvyy4l9pKv1NlXyrGJEcEZy+AmCh8/sRhdF8Irz/PMYT8erWeUcypQsjLWJrpEzL
         743rV/Vf4A5hmwximYdflc3riwsU0jCC+9GeCfhALNLOxfXBXHDSmIuTRn9IJWHG6HhU
         bDdw==
X-Gm-Message-State: AAQBX9cKHdgZhnYNbc4HudmmFzxD+CTFvzbE3xQHgv1qnshR7hubRG0k
        ySyyvPQbi9HTDtYwTejXweTAHsKsWNniz0W2
X-Google-Smtp-Source: AKy350aJNghSC5CfNyPgKkWXs0FMN8fkENsNCl8unVGCaGJStsvyvk7XtDGK5pCnk/0RAbSApiKWog==
X-Received: by 2002:a17:906:2a45:b0:94f:1a23:2f1b with SMTP id k5-20020a1709062a4500b0094f1a232f1bmr1247720eje.24.1681555624222;
        Sat, 15 Apr 2023 03:47:04 -0700 (PDT)
Received: from localhost.localdomain (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id m15-20020a170906720f00b00947ab65d932sm3607034ejk.83.2023.04.15.03.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 03:47:03 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/3] dt-bindings: display: synopsys,dw-hdmi: Add property for disabling CEC
Date:   Sat, 15 Apr 2023 12:46:11 +0200
Message-Id: <20230415104613.61224-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230415104613.61224-1-jernej.skrabec@gmail.com>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
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

Even though some DW-HDMI controllers have perfectly usable HDMI-CEC
implementation, some boards might prefer not to use it or even use
software implementation instead.

Add property for disabling CEC so driver doesn't expose unused CEC
interface, if CEC pin isn't connected anywhere.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
index 4b7e54a8f037..624d32c024f6 100644
--- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
@@ -48,6 +48,11 @@ properties:
   interrupts:
     maxItems: 1
 
+  snps,disable-cec:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Disable HDMI-CEC.
+
 additionalProperties: true
 
 ...
-- 
2.40.0

