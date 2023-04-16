Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D436E388F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDPNQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDPNQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:16:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BDF211B;
        Sun, 16 Apr 2023 06:16:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504e232fe47so4178049a12.2;
        Sun, 16 Apr 2023 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681650998; x=1684242998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CG6bCloxRF63LINwsV/S6++Cq8kHn62f+t1mJDbwRK0=;
        b=WXFFpsaEeQMYaSn0v/zrfFpyjWKoQioMpl8FyBtcvwM/W+CH3eQ+FO8fDo4YaSPbqC
         IBR4fvHDQFglnsUsuGDL9btHT7rzgxknyMVD8vTPCfdzkSoD9OpN8e/0qHNlEtLtPnna
         n8Wj0hynb/1Snkic/6YiPhC3tUkSx+ly+h1qYOrElXpFKddIjGlVH5U/mmCRnbijh9vJ
         ZEqJnPJ/11Q/ZClWyCxatUVsjtlwtMkJGtOFVBqYpefMS0frrrjxK2+2ltAvy180okSB
         fRcerp0pe6CHkmBii7OxVvmPyc0Q5kaLQgMUNyWXjmKjOzqcvNgTxzpnPnxefUNIzq17
         /27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681650998; x=1684242998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CG6bCloxRF63LINwsV/S6++Cq8kHn62f+t1mJDbwRK0=;
        b=gJQGUDB3mrRksT6nGbBIAmiOJuDX9TORQNvOUAXorsUFsGtfAuchSeO3oNq1F5e9bn
         vXgkyt2bMr3GKPSom7ukQWn2DsgLZ9vjqJ8CuuP0iaU9sMdxtqpKq7J1fCO3MzzzQqvJ
         WtprdQR8FF5PtQ44jswM3R1AUYK/mTP+Y5D4GisVFEzWXhSaEBqJjz7wKudVh+mClkfY
         LJ51cxTXiimv8ICOIYF+BHU7a6Lxu05z14rO1w7rDFDycLS5++ER8bljFU5WszxKboLH
         lWG4y92xCZkooFn6k6wp81LjPvEqpThSI4YDKJpxX+EVLnSGj56uycnWN48+eZ6G8+/g
         UNJA==
X-Gm-Message-State: AAQBX9eObdqy09c0RmMbk9I1BbkYU74m0D/Svx55f+eV/Hxbcoug6P1j
        f5CvJc5yVHe2nUb+kN2sFYo=
X-Google-Smtp-Source: AKy350ZcY3oLmiF4wDab6nhMKU9+AzhQFiWjQFrMeN775fJZ9qEf5nnH8cHD0k8y0tiEK1CJCRb2Ag==
X-Received: by 2002:aa7:d04e:0:b0:505:7d54:db93 with SMTP id n14-20020aa7d04e000000b005057d54db93mr11408339edo.21.1681650997751;
        Sun, 16 Apr 2023 06:16:37 -0700 (PDT)
Received: from localhost.my.domain (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id n9-20020a05640204c900b005068d7ccfb0sm2396594edw.83.2023.04.16.06.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 06:16:37 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v3 0/3] Add Samsung S6D7AA0 panel controller driver
Date:   Sun, 16 Apr 2023 15:16:29 +0200
Message-Id: <20230416131632.31673-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
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

This patchset adds initial support for Samsung S6D7AA0-based panels.
Currently, only the S6D7AA0-LSL080AL02 panel used in the Samsung
Galaxy Tab 3 8.0 family of tablets is supported; other panels can be
added in the future.

Changed in v2:
 - Added commit messages for dt-bindings and MAINTAINERS entry commits
 - dt-bindings: Applied suggestions from Krzysztof Kozlowski
 - driver: Removed unused panel_name property from desc struct

Changed in v3:
 - Correctly applied patch for dt-bindings

Artur Weber (3):
  dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
  drm/panel: Add Samsung S6D7AA0 panel controller driver
  MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver

 .../display/panel/samsung,s6d7aa0.yaml        |  52 +++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 395 ++++++++++++++++++
 5 files changed, 461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c

-- 
2.40.0

