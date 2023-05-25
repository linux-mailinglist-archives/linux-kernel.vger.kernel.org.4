Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C946C710316
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjEYCu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236074AbjEYCux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:50:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA2189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:50:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-253724f6765so871287a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684983048; x=1687575048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEBP16jDdKfZXyVFFhpDGWBgOGBnuO/n8Kvdd4MlHEQ=;
        b=wXCi/TRKvMtzbjDGaWKOKeQXcGf2XiOm9fRspq5kk19SJ+7DgxjloFXfsRQWVERmOy
         lWv1DSveaakkvFL3nbuaUiMBvvDG1Ja1MeWwPq8ftuK2618qtLHsKj6rKeqA9ZhqiXct
         Sl2i1rORnzO/l2mwletBdLFLLaH4XlT6PxN3r6V7PE73dLMpUFBZLGb9yjalpyGgX4Rf
         2k2pnHcSxdGhgzOFjGMgo2cjxwc0vnHT93lV2365I1CQyDCHlkkQIqBqBLzcIZVdZDOy
         Wf+CnWCU2qASt9O/COEbPEKNjeURBoFICed8qBMhpzE/gvd5WqK3PJLTJXJ/Tz/px+Sf
         v+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684983048; x=1687575048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEBP16jDdKfZXyVFFhpDGWBgOGBnuO/n8Kvdd4MlHEQ=;
        b=XFkD8eh0babqyrWdHw0NWFD6wownA59/xDZ5PX9XTafGWgSqTG3qCKjDSqh9Wt1x/g
         altQA1I+RdowfLrUnSmOuh2szRYxZOyVqsOiQNCFn4Z2UTL/LQh6582GoDzAyefUBEf0
         lxGrF9KhFsFCxsWHhCWR9YZf9Eb6yCqlaaEslxWldVg79tC+s7a7nHflguOUXOlv6NAX
         /Avga/TIw4TioSi/1eRC4umvCrB1JPEKxqoCy7gUB9zwrBMDtCYhrk4ZsY8tz8v7bj7Q
         8Hf40094o/0s5UhVx32T5gk9u1I218fUys7EBWdVMLDOIutejLEx93HjUKQtXsuP1kqe
         jvtw==
X-Gm-Message-State: AC+VfDxcm3zR1Rnqei4x5u+CazuxzY7Nl2k4wQj0C32TpZ7JGG++TzQH
        MyvrKO6+ZRxHA+ySOlEgp46NXw==
X-Google-Smtp-Source: ACHHUZ46Ks8ON/dKygzdKENi8wUoeHdEYjocv/L6LED/yPfARc0TnBardJYDQamt6YsLc/o9PwNGdw==
X-Received: by 2002:a17:90b:fc9:b0:253:9478:5da6 with SMTP id gd9-20020a17090b0fc900b0025394785da6mr108527pjb.15.1684983048151;
        Wed, 24 May 2023 19:50:48 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a734600b00253239144c5sm171815pjs.42.2023.05.24.19.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 19:50:47 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@chromium.org
Cc:     airlied@gmail.com, conor+dt@kernel.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hsinyi@google.com, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        robh+dt@kernel.org, sam@ravnborg.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [v3 3/4] dt-bindings: display: panel: Add compatible for Starry ili9882t
Date:   Thu, 25 May 2023 10:49:59 +0800
Message-Id: <20230525025000.3692510-4-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230525025000.3692510-1-yangcong5@huaqin.corp-partner.google.com>
References: <CAD=FV=XUuzjjLq3YP3683jOd06odwk5Dox5MS8oY8goB-_8T5w@mail.gmail.com>
 <20230525025000.3692510-1-yangcong5@huaqin.corp-partner.google.com>
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

The STARRY ili9882t is a 10.51" WUXGA TFT LCD panel,
which fits in nicely with the existing panel-boe-tv101wum-nl6
driver. Hence, we add a new compatible with panel specific config.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
index 28a7beeb8f92..906ef62709b8 100644
--- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
+++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml
@@ -34,6 +34,8 @@ properties:
       - starry,2081101qfh032011-53g
         # STARRY himax83102-j02 10.51" WUXGA TFT LCD panel
       - starry,himax83102-j02
+        # STARRY ili9882t 10.51" WUXGA TFT LCD panel
+      - starry,ili9882t
 
   reg:
     description: the virtual channel number of a DSI peripheral
-- 
2.25.1

