Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDDB6A8271
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCBMkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCBMkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:40:45 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4DE37720;
        Thu,  2 Mar 2023 04:40:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so11555845eda.1;
        Thu, 02 Mar 2023 04:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hn3uP3hG8mSuCgFEmDW7AQETpkM5xpSS4nxH3Vo41Mg=;
        b=F6yLifQw2+wSRFA91PWf6xiJWYz1XeiVirHLY3leajb9mvZxs8eyezgWF5WJa/LxJ3
         h1ExhzjjUVkUVBG+BSgjA0Q3dje326x6XI7LzWNt0z/zmN264oz0Enp8yfetTEYNvJqm
         sw1MReyZok/9+Sb0Q1judaERrI4HJFOf28jiQjsZa3theTfBBx8rANX73M+VDKje8NAC
         iTy5kp+DEbTpVTm1iMgIRvbl+q5bvkNkwOlchPhJpXL7FYKCJZWdvwCZm2bxktHskeVO
         THz9hYNt3zZyw/hKC81/QsU2tEg8kxwV+MY9mIGkjiYA8AjvorUStd6L5v7d4EWxW0AI
         yeEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn3uP3hG8mSuCgFEmDW7AQETpkM5xpSS4nxH3Vo41Mg=;
        b=1dxCVNyYpjvDnHaD29HKG+sIq/X+X+x0Qn4y59eCvrZcIt/dKNgPCRKakL5kRj+HFj
         WxE2BHyYvcgHngNgJ00o3DfUcbGBg42r0iUgIR2pp65xFQEMKk2Sr/uxd+83e/8C/pp3
         uxgrEoNIu0tJ4amhaE6Z4tvOUkBvnd9EBhqSEH9jS6Ct6VYImidO2W87E9QDJFjOFEfB
         ATpAZLpXfR8PIILcigFGBWwLUHeUwEZ7rGBCBgE+zG8oS3Do8T9UQ2rg2JMbU8r5dwoP
         5ZfJsm7BzRLwKVTbDCIjyGFZ1kO032FYxz+gTSkhWvKKVhyjLSbnp+iT8oprhXaBgLgo
         xNTw==
X-Gm-Message-State: AO0yUKWeRX0Us9Aom2/2XY+AJ+c4RfqHJ4ARyACwHphxiUb+mIh2uNxy
        QQw3er1wJFAnvTo0rM+mcPo=
X-Google-Smtp-Source: AK7set/eg1rJI3CgQygd7/y7nq7/G8E9a0Z+NUEzgN8bRJRpOn2n1NscB60sb28X6jp+i7qfk2Q3zA==
X-Received: by 2002:aa7:da4f:0:b0:4af:62af:460a with SMTP id w15-20020aa7da4f000000b004af62af460amr11488535eds.8.1677760842735;
        Thu, 02 Mar 2023 04:40:42 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id c22-20020a50f616000000b004c07b11deb8sm599036edn.64.2023.03.02.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:40:42 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] MediaTek MT6735 TOPRGU/WDT support
Date:   Thu,  2 Mar 2023 15:40:13 +0300
Message-Id: <20230302124015.75546-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds support for the top reset generation unit (TOPRGU) found on
the MediaTek MT6735 SoC. TOPRGU generates several reset signals and provides
watchdog timer functionality.

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (2):
  dt-bindings: reset: Add binding for MediaTek MT6735 TOPRGU/WDT
  watchdog: mtk_wdt: Add support for MT6735 WDT

 .../bindings/watchdog/mediatek,mtk-wdt.yaml     |  1 +
 drivers/watchdog/mtk_wdt.c                      | 12 ++++++++++++
 include/dt-bindings/reset/mediatek,mt6735-wdt.h | 17 +++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-wdt.h

-- 
2.39.2

