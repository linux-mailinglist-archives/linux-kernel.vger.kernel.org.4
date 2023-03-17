Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DEA6BEA0B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCQN0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCQN02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:26:28 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7920689;
        Fri, 17 Mar 2023 06:26:27 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f16so5050261ljq.10;
        Fri, 17 Mar 2023 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pGNDOUSIZjgiyVjq87r5QmGbQRnWMC0m6iyydmLqryU=;
        b=mkHuchepj0zLmze2dZfSAf1mLfWxJf7Qamuu/Yp8cK4IDIAQkrPTQj41PXJ4pupk3X
         Q9pEaWQYr3RwGnVXxL+gKdPixn63CY5MJQ/shA8aR2UI7CiKj7pkizbFkxZ15qQLdj/L
         cFMQwSH2ZKlwfGndSkifXCcy4O9YuIQr1ZyiNIaJ+smolL9mWEJwE8WMLREsOYkYsC2e
         yVU86YJZV8sx3u/AoBihp11FOYUy//DqU7pHlOyc7iaOuSDddamhyGpaZbZrF25Cvs6V
         QvMXzY1fDR8n0WTx8VNtPlSwrl3DPCxB1+TOYocAOjAbme9/5mgtWsthYrlzGejHpaF+
         PLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pGNDOUSIZjgiyVjq87r5QmGbQRnWMC0m6iyydmLqryU=;
        b=5n1cGAoHPapqLVbE3h7RmKmAoYXJUkZj9O46TwDFfUvvP3b69R6dp3lrztiQnTMdxY
         y0+mZLbp7E5l1KBLb19vqWGHa0ZZMW1dOce+WOEe3AYLkaxMTSSFghVYOPSjqF2umMAY
         bETXBPneOWgmn2oAQ4+f5jl2txvHZoApQJ8d6RtSWoh77QM6xBGtOU7GX5w5/4G+YKiL
         ESYt3ciN4Fi4IcMtiXdBU8gGQVZDNoWu6KCUuilJMX5PRaxbR2Dr/zswzMAn9Yp54sVM
         fHP1PrmP1b3j0Ub3cjprTR3UQyIvOpi92XK4/5nYHLIagCoDE6SLAftIN5jI9wzRkXuj
         78Jg==
X-Gm-Message-State: AO0yUKVIbcgOPT4PYUfiPyeeoTS85L01CAJuTF4AosBhl5Ux7FJ0+c9T
        IbmYSyAHt15D5NHD4q8eLmb3v4hlkJ4=
X-Google-Smtp-Source: AK7set80wYvC0wfOMtO+mf+zTXGX4Mn3CY5iIWpdb4mreKqFB32G9vpdESkulCsO55T2/mqwrx9yuQ==
X-Received: by 2002:a05:651c:304:b0:295:a613:7436 with SMTP id a4-20020a05651c030400b00295a6137436mr3104194ljp.30.1679059585349;
        Fri, 17 Mar 2023 06:26:25 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b00295b588d21dsm411083ljc.49.2023.03.17.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:26:24 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 0/4] nvmem: add fixed cells layout
Date:   Fri, 17 Mar 2023 14:26:16 +0100
Message-Id: <20230317132620.31142-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVMEM bindings received a new feature recently: layouts. They allow 
defining NVMEM device content in a separated DT node named 
"nvmem-layout". That improvement results in cleaner and more generic
bindings.

New bindings & drivers should use layouts design. If possible we should
also try converting existing bindings & drivers to layouts.

This patchset allows defining NVMEM cells in a new way (using NVMEM
layout feature).

This deprecates support for defining NVMEM cells as direct DT device
node subnodes but IT DOESN'T drop support for that.

PLEASE understand what this patchset handles. It adds new & preferred
way of defining NVMEM cells. It is NOT meant to:
1. Convert ALL existing bindings or drivers
2. Add support for new extra features (like multiple layouts)
3. Break any backward compatibility (it WON'T happen)

Note: this is based on top of the:
[PATCH 1/4] nvmem: Add macro to register nvmem layout drivers

Rafał Miłecki (4):
  dt-bindings: nvmem: layouts: add fixed-layout
  dt-bindings: nvmem: convert base example to use NVMEM fixed cells
    layout
  nvmem: core: export nvmem_add_cells_from_of()
  nvmem: layouts: add fixed cells layout

 .../bindings/nvmem/layouts/fixed-cell.yaml    | 31 ++++++++++
 .../bindings/nvmem/layouts/fixed-layout.yaml  | 49 +++++++++++++++
 .../bindings/nvmem/layouts/nvmem-layout.yaml  |  5 +-
 .../devicetree/bindings/nvmem/nvmem.yaml      | 61 ++++++++-----------
 drivers/nvmem/core.c                          |  7 ++-
 drivers/nvmem/layouts/Kconfig                 |  8 +++
 drivers/nvmem/layouts/Makefile                |  1 +
 drivers/nvmem/layouts/fixed.c                 | 41 +++++++++++++
 include/linux/nvmem-provider.h                |  7 +++
 9 files changed, 168 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/fixed-layout.yaml
 create mode 100644 drivers/nvmem/layouts/fixed.c

-- 
2.34.1

