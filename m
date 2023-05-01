Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95276F3645
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjEASvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjEASvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:51:13 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC22B6;
        Mon,  1 May 2023 11:51:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc4d96e14so11571472a12.1;
        Mon, 01 May 2023 11:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682967071; x=1685559071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XXYNDfuK22xee9U1YJ5+QfMQLLMlc/YWcr8hr/XmrE=;
        b=JTE+nMeiXrEBmK6b6ca7iIUWxu4N1hoW58ICQbltZgwzCnuO+JBl5zCLrj8usm2asB
         PflGb3ymSYxog4V9KTm4LNh3RngboBo59/BE35JekpLKhWeJAoRPkaVKgsRD1nFA0LO5
         PsYl0ceCqi05FBMeJmdgiKIuhkt4y7eeaS8A5qamMQvWMsRgSwsbrtVWrQooI7WQsGXd
         FabVAaELtTkptC9EFQ7cOwWNjlt13VyQeO/dHGe6t2wddhMk0ycFLnFU/jJhivcvnu8P
         V7YPCFZTzufXdcwPpjjf9ATog5ZTr31O+aN7NxoqI4/ZR8hjzrALg/ET7LrNMVXc2psp
         jwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967071; x=1685559071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XXYNDfuK22xee9U1YJ5+QfMQLLMlc/YWcr8hr/XmrE=;
        b=CS3T18qiopuDRXvjcMtX+zkjqM8rIjO63fcMGfv6eGGm0OhSNbQyFAUOT4stJ337SP
         EYr5M+QPfY3SJNVe45vHSfLrjDerwVR7JSfsptvQfXJYvg53k0J5Q+ivJ/KQhpt7H387
         zr1zkcisbNtKUz6HeUuZHiwxO+AavVxReqYd9lTrioIaBUGbscuOSa2U6kR1EHR1U6XO
         PnqTPR1PjHy2BjHYFEpFZYuFpGoTCzJzn2t81TEPxgU3nYb+RPjbHeuNmS+ZrP3yYDar
         Tn8P/nU5KVkjy5I1R8MsBXR3bc/OdnQEv7VdaMfOrtw/wLkdKS7rZDTb8CmdGq0xOQOT
         kNGQ==
X-Gm-Message-State: AC+VfDwRgkhtGPLIRJHtncFeQjZaDvyYuIOHbf66bnS+TOzfF5tRqt7d
        hQcUZUMbr/VTSJYxvFxoP4A=
X-Google-Smtp-Source: ACHHUZ7ATh/b0KyAWXtQ+IaqPpPkys5spjADfJRhTldvk2ettaxUuN3dPUxInrA/94QBVnJsFMUuuw==
X-Received: by 2002:a17:907:6d19:b0:94f:511a:a183 with SMTP id sa25-20020a1709076d1900b0094f511aa183mr13144185ejc.36.1682967070908;
        Mon, 01 May 2023 11:51:10 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id g10-20020a170906594a00b008cecb8f374asm15028335ejr.0.2023.05.01.11.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:51:10 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add Samsung S6D7AA0 panel controller driver
Date:   Mon,  1 May 2023 20:51:00 +0200
Message-Id: <20230501185103.25939-1-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
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
Currently, the following panels are supported:

 - S6D7AA0-LSL080AL02 (Samsung Galaxy Tab 3 8.0)
 - S6D7AA0-LSL080AL03 (Samsung Galaxy Tab A 8.0 2015)
 - S6D7AA0-LTL101AT01 (Samsung Galaxy Tab A 9.7 2015)

Changed in v2:
 - Added commit messages for dt-bindings and MAINTAINERS entry commits
 - dt-bindings: Applied suggestions from Krzysztof Kozlowski
 - driver: Removed unused panel_name property from desc struct

Changed in v3:
 - Correctly applied patch for dt-bindings

Changed in v4:
 - Added support for LSL080AL03 and LTL101AT01 panels
 - Added DSI-controlled backlight support for panels that support it
 - Added vmipi-supply
 - Dropped s6d7aa0_bl_ctl_on function (not universal across all panels)
 - Removed MIPI_DSI_MODE_LPM flag

Artur Weber (3):
  dt-bindings: display: panel: Add Samsung S6D7AA0 LCD panel controller
  drm/panel: Add Samsung S6D7AA0 panel controller driver
  MAINTAINERS: Add entry for Samsung S6D7AA0 LCD panel controller driver

 .../display/panel/samsung,s6d7aa0.yaml        |  68 ++
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/panel/Kconfig                 |   7 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 585 ++++++++++++++++++
 5 files changed, 667 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c


base-commit: 9102d61886cb887b152f89c2481a6c17d1846fee
-- 
2.40.1

