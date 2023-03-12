Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988F6B6624
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjCLNK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCLNKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:10:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE546143
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:10:22 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j11so12402098lfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678626621;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2tChENWyDZGQKa5Zk1lhzLBop14+1J962hBMY2G3xM=;
        b=c9teDkYV9vZJtIrT75kg/CtINZNaIWkOdPiDnrWus0BcQSelYgwkEgBhEGM32B6hre
         TThdYQGKyRJzxth8zP+5CSWAof5a7Scqcfprh7Dlrc688dy8N65oJyaRIKayelxaoRmo
         UlzhtjR1u3mrPyQjJDNUv2aj3pS6BxRANoBUA6oggx1aV+tDS5QAqXlFc/xnMygg3vbL
         qK5yXDX9zDHgrJCxZUii2SrHmuNFKpB8f+7tev4cVQsCs7zgv+jznKDKYDxmpLlRUjdr
         /dSHkWyyKCCb8VcIkKSB6U+Mpg8FrPlpi+dnmPznPzVmesl3dYjKrVDw1iV6svNeLmBv
         I0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626621;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2tChENWyDZGQKa5Zk1lhzLBop14+1J962hBMY2G3xM=;
        b=WMBRS8/QKh2TrhqDfjl3TvHHXzEbyq/gtL8LVFIWd1IfWn31s4dKibDZZd2ymUkkUL
         UXN2MALscsx0Yhrw7q6utJBOnzqI+tgK4kX7h/7C8h4SbBx1KB7yyUd4kUp+o4CHUeXj
         GTd/rUsLliF+FtKuIUXH3ZmZ9on/VIJYTpnPEwGk1SqBu0w469ifTaKmVP8AqAuUyLUb
         n+OehCDTa/BVzRlo90qm4VqFtQfwbdN3agcPThaSc8GqFJLbat/lR7Pj+L7QXTgNcpFE
         My8yRm2hJpUMzvJlallJ6rm00mkaudCo1XItxmAHWH4FHAgo26RD/JkR8Vxp0J+tPmOw
         D8oQ==
X-Gm-Message-State: AO0yUKVgzj4ITZsUaTXy4bF9zuQf5ngvEIRAFtaZFmGpxyyO2G5sdJyx
        1uGyAxrIFsqqSHTyOmjMesdoLUapBR1V4v4G
X-Google-Smtp-Source: AK7set8y9gAEfFlHbH+347ZfF9qAWfWBb6qMTBn1iIO0wKTx8lVtCSyYl2t8hz8TBFdVAVaDkr82nw==
X-Received: by 2002:ac2:4c06:0:b0:4e0:6e01:7d28 with SMTP id t6-20020ac24c06000000b004e06e017d28mr8288988lfq.60.1678626620827;
        Sun, 12 Mar 2023 06:10:20 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id f13-20020a19ae0d000000b004db45096c99sm647651lfc.85.2023.03.12.06.10.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:10:20 -0700 (PDT)
Message-Id: <1678626510.1783316-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 16:03:15 +0300
Subject: [PATCH v3 0/2] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems 
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs 64-bit
accesses is the FIFO. The symptom is that the DW MMC core never receives a read
on the second half of the register, does not register the datum as being read,
and thus not advancing its internal FIFO pointer, breaking further reads. It
also seems that this FIFO is only used for small (less than 16 bytes)
transfers, which probably means that only some SDIO cards are affected.

Changelog:

v3:
- removed "fifo-access-32bit" devicetree property
- added "samsung,exynos78xx-dw-mshc" compatible string
- added "samsung,exynos78xx-dw-mshc-smu" compatible string

v2:
- added commit messages

v1:
- added "fifo-access-32bit" devicetree property
- added DW_MMC_QUIRK_FIFO64_32
- added new dw_mci_{pull,push}_data* variants (...-data64_32)

Sergey Lisov (2):
  dt-bindings: exynos-dw-mshc-common: add exynos78xx variants
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  41 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.38.3


