Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A66C6A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCWN6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjCWN57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:57:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5023393E3;
        Thu, 23 Mar 2023 06:57:58 -0700 (PDT)
Received: from koko.localdomain ([89.1.213.94]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdNPq-1qEg7Z3cnY-00ZLEr; Thu, 23 Mar 2023 14:52:45 +0100
From:   Maximilian Weigand <mweigand@mweigand.net>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Maximilian Weigand <mweigand@mweigand.net>,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 0/6] Small fixes to the cyttsp5 touchscreen driver
Date:   Thu, 23 Mar 2023 14:51:59 +0100
Message-Id: <20230323135205.1160879-1-mweigand@mweigand.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JOAqyRTVG5uDiEIeXH/4dCz/MkWByUALV6oyJfiU5CzPIBn5XK+
 e9Ux4T5lUNqYnx6Q658/Gu3c1+SlMfdMq1QPyxOxhrpu/ceEqv5Ox9hesRy1cu3Wj3s7zv+
 MZo9/PnIl/LRf3pzRCwd6vXwQKAG6KXdJJZqPEbhShxD6x5Rz5LSb1CTlAENgLfAcuurgDm
 YDqx2NSgal95zEB80+Q4w==
UI-OutboundReport: notjunk:1;M01:P0:bprECCQxY0w=;NgAleBBDWDAR8yoqUSGi3AdAy+E
 0p3CINEFazWUNbK//03G5dKunXePXVRnsCaFNMC1eUf/26LJtlUky9XX/lvmXvM3wiYenFkP2
 0Ns1gDg6jUYzOLY1JQMrySOBk1sXqM4MSmIvC5X1B9ieLFcFVLbMki1PEMCSgplCVZUQzd+DY
 QnDUvV6Icbn4sNkjm3F8umGK5SHmhOcp1+EoGZbP92WQlV3tiK7sTOmSgyLB3jy0I0T/dqYPd
 NS3hIkVj7tfeQo87lFQM8f4fFYyqHg1PBT026inZ8ZdgNLvIsxKx0w1A+7ZpCibATEDP3iVw4
 cgKoWQYaLWM7NP6g2UY2NMgivRgWaNcm05UpR0flJOi9yO6dl089PBY3Dx72/2LEcuUL8zMCN
 3Z7AaQhx2/gKUtHTXzxboFfD8gxu+Sju8P1Jy03E7ufwaCUcy/oRE9dX7i7YXqb54m542rX2B
 VPWCCA2f4nsnPe+EXrR2qeN/aEkxGoL5DajrGE9++0ImOgg7r2zHgNQ40ue766SCxA+xj7Zw5
 2OyG7+Yy6n01r0nyqf9EDKivOGBuvwpfbQnWV63ZOJuaT/NWUkwZtCUQgIx8APxxm12HOVxLY
 7vslXpHvHuzSk163FfWQbnzkyE92OgBqr1cLl7O5mOrqMP5z+upgGE70351VrCGhbvPqlvRiC
 Y7lGHU2etsPjxARQ7pjfSpoo6/ZpMhk36L50MHu7HQ==
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some intermittent module-loading problems of the
cyttsp5 module on the Pine64 PineNote it was found that the device tree
example of the cypress,tt21000 was in error regarding the interrupt
type (IRQ_TYPE_EDGE_FALLING should be used instead of IRQ_TYPE_LEVEL_LOW).

This lead to the proper implementation of device sleep states, which is
required to ensure proper functioning of the touchscreen after resume
when the correct interrupt type IRQ_TYPE_FALLING_EDGE is used. Sleep and
wakeup commands to the touchscreen were derived from the GPL-2 android
driver by Cypress Semiconductor (copyright note for Cypress
Semiconductor is already in the current driver).

The first two patches fix small issues with the code found during
development of the suspend functionality.


Maximilian Weigand (6):
  Input: cyttsp5: fix array length
  Input: cyttsp5: remove unused code
  devicetree: input: cypress,tt21000: fix interrupt type in dts example
  Input: cyttsp5: properly initialize the device as a pm wakeup device
  devicetree: input: cypress,tt21000: add wakeup-source entry to
    documentation
  Input: cyttsp5: implement proper sleep and wakeup procedures

 .../input/touchscreen/cypress,tt21000.yaml    |   4 +-
 drivers/input/touchscreen/cyttsp5.c           | 138 +++++++++++++++++-
 2 files changed, 136 insertions(+), 6 deletions(-)

--
2.39.2

