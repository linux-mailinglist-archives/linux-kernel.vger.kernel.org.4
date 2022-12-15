Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84264D7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiLOIYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLOIYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:24:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E9303DF;
        Thu, 15 Dec 2022 00:24:21 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o12so9691802pjo.4;
        Thu, 15 Dec 2022 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=KShrVmgODIuJtcKknJKb+Pf0pSk+VqLQolsKht9ge8cZaz8itKhomuwlUliumJq4ck
         /Apz8qaj5shUWlDuslUNunbrjRlRFLZ9fEALxeAMyzigGCKtPOyX/8iykKjxRrHH4NYO
         j0yL4oeqEF9bK5JCGXgDZjCVeBQDcDqsIfVzwplAx2Is+cqOJYnKwFU6WJ30UrJixkAf
         UHoGPsOodG683vHjRFKOLq5ZDpFRGmnYl4B5HWEm7ux2YPx18r7pzemdKo7RMbQspoMk
         w7Td822C9PjCGnVktFeon/nUdgaHRT/MAYG0IqMNJ7H2m+Du6+D0M+drEYVEaqnTmLU2
         7agA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ztdTBdFFzUgQtkWJUCxW6jiR87PJzZ+mXWctPgKolvM=;
        b=VquEs1tYsD4g3qgMU/N/ZvnTloncfDD6Y4dM27W4+9Zil+E4++XwTsYsp7PyJLevgE
         OoKc75e1IXfktjNLkgxbRQqzdtTIfz8sYTHNET+P3s6+0Iek4JXHekA8GaE4M4JJNDL9
         FKZ1NYOjMmCoOizCLYnqGO3PT8aD8ndfph+7AUxMuYkQbPiZq62W5M1DVB7aiQj3/8gP
         F7QDyTog/LFy9ortAXCEJ3ejkBVgB92SclTZus1HGW4dAAGhjnD9zeA8L24VQeZRklAI
         rAWtM4RCj26S4t4yJ6EwyqHBcY/HcoG6ra0RfU/6Gcqn44GwfHWyCWmpA3S9VXSTWicq
         +5cA==
X-Gm-Message-State: AFqh2kpTbven8vUTRq5iVn2nPzGfSs3BmjW1qJaFZGitavwCEPrvlf/b
        I5XYmDf099hINKbVrzJkRGRHwEstIAgROQ==
X-Google-Smtp-Source: AMrXdXuUVBt9ZrR1cJfNwk0YD8K0kj98/hE7ImHfbVfnVQrT5isZOcf8OPg0oOc9X4Ny37nYnNJcgQ==
X-Received: by 2002:a17:90b:2493:b0:223:4958:8dda with SMTP id nt19-20020a17090b249300b0022349588ddamr2384507pjb.7.1671092660883;
        Thu, 15 Dec 2022 00:24:20 -0800 (PST)
Received: from localhost.localdomain ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k14-20020a17090a404e00b0020aacde1964sm2594606pjg.32.2022.12.15.00.24.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:24:20 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, krzk@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lh.kuo@sunplus.com, Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v14 0/2] Add thermal control driver for Sunplus SoC
Date:   Thu, 15 Dec 2022 16:23:48 +0800
Message-Id: <cover.1665990345.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus
  dt-bindings: thermal: Add Sunplus schema

 .../bindings/thermal/sunplus,sp7021-thermal.yaml   |  43 +++++++
 MAINTAINERS                                        |   7 ++
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 130 +++++++++++++++++++++
 5 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus,sp7021-thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

