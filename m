Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A62462D78C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiKQJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiKQJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:55:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEE077221
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:28 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a14so2880062wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oY8oYo0J2WCfjABGKVsTvkXLjzVmSdzWanTinZnS2yQ=;
        b=CNxJMfcYaLTqxRf8f8dPKq4eOgNemQipmzPq65IOpab5yzDrsRgh7fLSwmx0JeU+2M
         IjaYo8xje7qIPA4DTeniUaKKitHwLD8OBqeCHRCA2MFLTO4UKO3HFdMA6P7eDy7UUg4u
         0V5tJLwBw2JT6IN4sk7X4ec9ucxmQ34ub/qjNa7jgJtr9nYhkttW5q0iRvb3XXh3bXdM
         Bo6pBvzMkv9hnqt15PPKB7gHJc4cwQOAYQI2J/lY5ZMsZrzawT5/TL1XoFLlRGdpo1XV
         9IWI4KgD/1snoa8j3SVIdVSo6HaLr3OnRMegGAo5H26H6jtOC9LRqft9DZxCdoEuO8M8
         fTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oY8oYo0J2WCfjABGKVsTvkXLjzVmSdzWanTinZnS2yQ=;
        b=d0vWkGhqHrJ6rtKZmEWQ3iHPROK0Eh7v/8RzI9k6uynXk2l4G0+TxtoBFZhQtPPBg6
         rqAJ7Omu55uk64yLKXVszGfXpyB7bNVVJb4+sG1LPcOM3G52EGCuclGTMoiYu2srWpoF
         RKF2zdd5VnkZuelbD4HZA9FsOPP9cmA8b9szQwgbibSx2/zczM1qiXc5DgTCMGXTPqCw
         DSH1jK7Y91LP4C6w7crQQppSFRAZLppCiRREIvsmgkFoMzZxjfSZO/k+n00MuAKjx1iE
         6rcumB/rt7GLWU4Rg2REbimEeJj+XSFUcAN4ZLr7w6rIWaMyPFVpJrfE69Uc6y+iSTff
         ueIg==
X-Gm-Message-State: ANoB5pkwfpkAAT8cGMOU/NxQXOrzSm0stZ3oXC+bMH2JdB2by4vvczZ7
        YcSLHQXNltdZd7835MdUbi560g==
X-Google-Smtp-Source: AA0mqf6S0L3qmno4fvZJevVrOQJzy7nE/zgJMRoucaSwvKRt0OMNCZVcKOXPmahLQ+c+J5ARm5G9Ug==
X-Received: by 2002:adf:e94c:0:b0:236:6d79:b312 with SMTP id m12-20020adfe94c000000b002366d79b312mr943646wrn.699.1668678867223;
        Thu, 17 Nov 2022 01:54:27 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:9287:74a3:4740:e7a0])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b00236e834f050sm497021wrt.35.2022.11.17.01.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 01:54:26 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v6 0/2] soc: ti: k3-socinfo: Add module build support to the k3 socinfo driver
Date:   Thu, 17 Nov 2022 10:54:17 +0100
Message-Id: <20221117095419.171906-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the TI K3 SoC info driver to be built as a module, the
following changes have been made:
- Converted memory allocations to devm and added the remove callback
- Added necessary code to build the driver as a module

v2->v3:
dropped module conversion part of this series while other driver
dependencies on socinfo are worked out.
A dependency issue is introduced by changing subsys_initcall()
to module_platform_driver(). Some drivers using the socinfo information
probe before the socinfo driver itself and it makes their probe fail.

v3->v4:
reintegrated the module build support and added patches for udma and mdio
drivers to allow for deferred probe if socinfo hasn't probed yet.

v4->v5:
Remove the k3 udma and mdio patches from this series and sent them
individually

v5->v6:
Add k3-socinfo to the subject

Nicolas Frayer (2):
  soc: ti: k3-socinfo: Convert allocations to devm
  soc: ti: k3-socinfo: Add module build support

 arch/arm64/Kconfig.platforms |  1 -
 drivers/soc/ti/Kconfig       |  3 ++-
 drivers/soc/ti/k3-socinfo.c  | 47 +++++++++++++++++++++++-------------
 3 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.25.1

