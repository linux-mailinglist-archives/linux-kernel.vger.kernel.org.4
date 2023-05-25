Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35557108F0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjEYJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240519AbjEYJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:32:21 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0398E45
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:32:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d2da69fdfso2266650b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1685007137; x=1687599137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpwfMsZIM/RuZJMwhQTZ2UB3MwnIPR30emTjY22XhF0=;
        b=YODftMtCx9uwB5NjamP2TP5L2qJofq4MS1ZlFGhfW9lUXWd+dicouiuAHpZNoLfYIh
         bJ22CCVZaMsYs4/QIHz49ALzlCyBSCKBhHw6avwE4UERTCmh4fygGkquFTKK539VPIqM
         yudYF46RoaAEI8KAdpPQU6HhYxDUK5A9vpnsgiAAn0PkBV+y6+L06RNjoKvhlfMvLaEB
         BmtuqDPt85iXkAHhK4LeqEmIdaUsESbfvtbA58EVQeapArQlPEf3dLby0+9Zrd83OhEN
         bKxi7q4djuqlbG4yMFaSnAP9jK2/DkTa52KZMP/VsHRegALHpPPUR2pyXq/Oba32n2fR
         GHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685007137; x=1687599137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpwfMsZIM/RuZJMwhQTZ2UB3MwnIPR30emTjY22XhF0=;
        b=HV5OcSEiiKAlC8wUwmvVKQ61nkxls8JxaEY2E9yBDo9Jh6Ai8PCBQmSBCVcWc4E6CA
         eNJx2EYrfmzOslLxm1zm9gxnPmwutfBZUXCU5qyRCyCcUBKxIS7TpTPwkfyWbl/jfCdk
         wCcfObACnCRsj5hpPFH5H78M0HmlpVMJwhrnQ2ZABANOL7hXNXAcovGg9hUXmhy7o5DP
         75Jc8AFYIxAe3o5qEuae+1R5S6UyWAGKoWVLyi+EtK45kyWhjAUMLOoTBVQeelFLEmQ7
         Quadv+bAGQUwW4UM+WhZ5Mdzs1w0jSw8+OBv1uXQ5YyaL73n9kcyYKrBmATlz7Tl6f0N
         jpEw==
X-Gm-Message-State: AC+VfDwGyY8tHyIisq/VpAIf2PiBOhQHoe/eXqn4wDHk4El0Sax/wzhJ
        qbiUPVXFjE4oC3OL9GlOKtXJ/w==
X-Google-Smtp-Source: ACHHUZ4PsP1YhFzW1Rb8FuG3MDQwgJg2KBTAJfdbMXk08lNzo/GQzI8Arcj86IXuO2BBTtDIGK29GA==
X-Received: by 2002:a17:902:8498:b0:1af:bb99:d590 with SMTP id c24-20020a170902849800b001afbb99d590mr969735plo.7.1685007136825;
        Thu, 25 May 2023 02:32:16 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001afa7040a70sm951039plf.276.2023.05.25.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:32:16 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@google.com, daniel@ffwll.ch, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hsinyi@google.com,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [v4 1/4] dt-bindings: display: panel: Add compatible for Starry himax83102-j02
Date:   Thu, 25 May 2023 17:31:48 +0800
Message-Id: <20230525093151.2338370-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
References: <1adda828-cf35-fb2c-6db5-f9ca91b5b62a@linaro.org>
 <20230525093151.2338370-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STARRY himax83102-j02 is a 10.51" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index aed55608ebf6..28a7beeb8f92 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -32,6 +32,8 @@ properties:
       - innolux,hj110iz-01a
         # STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
       - starry,2081101qfh032011-53g
+        # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
+      - starry,himax83102-j02
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1

