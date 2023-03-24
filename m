Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0716C86EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCXUil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjCXUii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:38:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177531E1C1;
        Fri, 24 Mar 2023 13:38:38 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso6199398pjb.3;
        Fri, 24 Mar 2023 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679690317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UpfYsPLth4MHWQZy4hoycC7tFlnErWweN4IdkgXtblQ=;
        b=dhSZUMs3WEMLMAiouToHsa6c1XEcau983DamW3FfSgP7i+RACbSvNKbhA2Cvjfn26/
         sopbbSpkqF3to1OxdDd7JZM/ie9IzJWoANyizZjLWHAl+PVttHTVK+04HROysUkB0Lee
         2vaaJJygJySloO/wpR2i3rRcXYrTrA7zBpmhIWCQ1FRpPEcGWCIyqEVYALmTsKWK71kj
         ZAc7IP0D38xkhPmYrf4ldrt9cXkDL+oCQVPrBeBGvVAd9IrMw0xzZ4+qrO3GahyWn0YD
         INZg05kse8JzXU3QPSRA6jDaI+ND4W9rgotf7hRjQmKVEqCw//nLb9TRz7+WF2buJh6B
         yvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UpfYsPLth4MHWQZy4hoycC7tFlnErWweN4IdkgXtblQ=;
        b=OENK52bHU8kM2F8AXAhUvWTDIxdmt8Qxma3yKPDLerixwPUuu4xrfHUFGSkqe7oUgx
         3tV5Tk3R/gDAMtNSRyr+M3ciBDTJEdwWuey9Rrk6TQKF+QADOTqU0+HY28V1JxGh1T9k
         dm0A8xRemFq9+XMhSlrD1G7IRzHbbLxwb/+LzAFC63IqGm1SETwXhkEewC6g/PncdJ2R
         ITFiCeh4FTXCIIpY+veFo/Qn37iTrEFiMAFAdm9DMgMeQ+fdp5FNbctcTTio0X8YL28K
         FsPf6aAdQgo/sop8sYRFoKvPePwYrCPuZxW1F8iuuymvthY/faYf4jR7QkEoWtHi3R7Q
         4/Xw==
X-Gm-Message-State: AAQBX9dkRChX1X6MtC3/tyGk/Am4NIj3MDkNKFx1g2A3b//VHh4CpgoT
        N8OMi9x0upvBe4uqIuEwZYJhmvgB0nE=
X-Google-Smtp-Source: AKy350Z6a6EpSZcpgWRYW72xNNVmQy0tgNvMAdFFnlz4s+uqNWeqXbqFINm/dVCXK9QpiYsE38rw1Q==
X-Received: by 2002:a17:903:684:b0:19d:297:f30b with SMTP id ki4-20020a170903068400b0019d0297f30bmr3336555plb.19.1679690317100;
        Fri, 24 Mar 2023 13:38:37 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ab9100b001966d94cb2esm14503431plr.288.2023.03.24.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:38:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Young <sean@mess.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), Matthew Lear <matthew.lear@broadcom.com>
Subject: [PATCH v2 0/2] Correct gpio-ir-recv wakeup capability
Date:   Fri, 24 Mar 2023 13:38:31 -0700
Message-Id: <20230324203833.3540187-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small patch series fixes the gpio-ir-recv binding and driver to
first indicate that it can be a wake-up source for the system, and
second actually make that happen.

Changes in v2:
- corrected the indentation of the description for "wakeup-source"

Florian Fainelli (2):
  dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
  media: rc: gpio-ir-recv: Fix support for wake-up

 Documentation/devicetree/bindings/media/gpio-ir-receiver.yaml | 3 +++
 drivers/media/rc/gpio-ir-recv.c                               | 2 ++
 2 files changed, 5 insertions(+)

-- 
2.34.1

