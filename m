Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E976D9BED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjDFPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239711AbjDFPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:14:47 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3883A8D;
        Thu,  6 Apr 2023 08:14:46 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so5983947wmb.3;
        Thu, 06 Apr 2023 08:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794084; x=1683386084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MH9oWkxfP8GAyXFIF9/QFL+IZc89otUoWrSEvAQa11k=;
        b=lWgDXxrUNjn6sBpurC89atZIKEsQAhR6j9sz6Jdn45gU8Yo+QoTWcQ2QE/8HIAv9Un
         8URQpxF9YoGUoG2an/KYsc0rKAmkdsZ9yVnT1v0MZ5W3H45Z3i1UWRpmY914bdTeJnIQ
         xkTJOS3tMPRbbqd6v++JPbcoXbBmbyPkb879UM/Xr9d5eAifzfw/6Dxipz+3/zI1Emjz
         DFsnKCdTBtAvQZhylrMaCtQWeRj8kwvEciMDqZTSgh6O5qSzMU7TX+zLSzyc34Lu7ud7
         Ed5+Vyo9oj/MZJn+i/SdzD5LCe/r+19K3yNoIPUQufZYPdIXVHenc8sm7JJVLxilUjkL
         /cqg==
X-Gm-Message-State: AAQBX9eSpcJkVjGEZpnGSrSs7tSalOQcY65nLYXol5psf1axmlaKxn77
        flBcCMlwWJTFB4/BAd44JpI=
X-Google-Smtp-Source: AKy350YgRUPGytR5NW4IoBgt4yI4NZ227JtpkW/Y7mwBewRsPkwEuCA7waIjVK/gM2Q+9su0MqWk+A==
X-Received: by 2002:a05:600c:24c:b0:3eb:2da4:f304 with SMTP id 12-20020a05600c024c00b003eb2da4f304mr7209338wmj.17.1680794084541;
        Thu, 06 Apr 2023 08:14:44 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5560213wmb.13.2023.04.06.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:14:44 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch, Lucas Tanure <tanure@linux.com>
Subject: [PATCH 0/2] Fix Random Kernel panic from when fail to reserve memory
Date:   Thu,  6 Apr 2023 16:14:27 +0100
Message-Id: <20230406151429.524591-1-tanure@linux.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to fix an issue where the kernel panics randomly on my Vim3 board.
The issue happens when the ARM Trusted Firmware memory is not removed from the
available ram.

This happens because my u-boot provides this region as a /memreserve/, but it
doesn't flag it as nomap. And the kernel can't map as nomap as the region is
already reserved.
My proposal here is to allow the kernel to mark as nomap if the region from
the device tree and FDT have the same base and size.

arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:
	/* 3 MiB reserved for ARM Trusted Firmware (BL31) */
	secmon_reserved: secmon@5000000 {
		reg = <0x0 0x05000000 0x0 0x300000>;
		no-map;
	};

Previos Threads:
#regzbot link: https://lore.kernel.org/linux-arm-kernel/40ca11f84b7cdbfb9ad2ddd480cb204a@agner.ch/#regzbot
#regzbot link: https://lore.kernel.org/all/CAJX_Q+1Tjc+-TjZ6JW9X0NxEdFe=82a9626yL63j7uVD4LpxEA@mail.gmail.com/

Lucas Tanure (2):
  memblock: Differentiate regions overlap from both regions being the
    same
  of: fdt: Allow the kernel to mark nomap regions received from fdt

 drivers/of/fdt.c         | 10 ++++++----
 include/linux/memblock.h | 18 +++++++++++++++---
 mm/memblock.c            | 37 ++++++++++++++++++++++++-------------
 3 files changed, 45 insertions(+), 20 deletions(-)

-- 
2.40.0

