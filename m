Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23BE6B6885
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCLRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCLRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:02:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5C39B9C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n2so12815390lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640538;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UV8fqbjOdVKsnwcy5S2/ICsUmjKXmCtfZ/sJfhZkPI=;
        b=OwOn2546tK2dkyp0L5DXf/qVcvFuRvKNNKuseGwdXDnjI0+eGO0fNVrh1KTugEto5q
         RE1P9VaNBTJ8VuYS7FeOO+3934cLOGmAqpPl1MRpH9P4MBAtiILNQwL2o3a8g6rA8+Lc
         SDuBj3v7TtEFhRLiV8rhMYiJbCKcIZMOHFU/ehePJL1591Nhxb3ABQOAM1lkODwo5dbw
         l/1Ta3NA8b8K87vT8xAfusO4zrxE9lqINnUAOf8KS1ZprW5LqBv13v48wdgmwKyv6a+0
         HfurHf1kolAuQvM+LOJcbM8SaZQYPi3/mIY7KQVUCJRWQ9mSv7plO8lHyDJknbnuQ6Lf
         3a3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640538;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UV8fqbjOdVKsnwcy5S2/ICsUmjKXmCtfZ/sJfhZkPI=;
        b=P6B73TdLqy3cY8LW41HQF1uiWeKK7BXkXtVpSPjlZsBraXLxhsiq+Uhq49bj9bX0pN
         9JjeVh60DaMOkvP45fXDXG5W0JJDOn+kfo/Bb3tZowpGDo1G0efiFtJ6L7TIyORE/YK1
         KN/nlEYt26wTvZFHxiwwx266sJA1GxABd3YRPYSvauVUcjM4hluIjQq+z28TaKLXxOAL
         1ljQh/iwnWGQrnb00gIbTMRElgJY3cE0pKO3cpdELSDYAHeWr484QLzJarnntK5zpvza
         aKPSQj/1ZwrwndZIZAxE3yUAG1yhn+6O1XNPUc/qBZkZuIaaAwgRh8+85auA6zpSavHQ
         458A==
X-Gm-Message-State: AO0yUKXawohwgi0AJsZhXfxKc9A5m/Js76ObM3KdW74qDBuGgjXmbbVK
        0UEIm1r3cxwPVBWUhkN18cfhuPbZixqh9+yo
X-Google-Smtp-Source: AK7set8tNynsQWvmO9BX5UZVzM+FsQRTDCpuVpmwVhFtRoHfkn7xFbBa0zfycetWQODMQxUEgpTm0Q==
X-Received: by 2002:ac2:5332:0:b0:4dd:a7ab:b148 with SMTP id f18-20020ac25332000000b004dda7abb148mr9175625lfh.49.1678640537900;
        Sun, 12 Mar 2023 10:02:17 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id h20-20020ac25974000000b004db3e08c8a4sm692578lfp.70.2023.03.12.10.02.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:02:17 -0700 (PDT)
Message-Id: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:30 +0300
Subject: [PATCH v4 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems 
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

v4:
- split dt-bindings and dts update into separate commits
- add an explanation why it'ss necessary to change the compatible string

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

Sergey Lisov (3):
  dt-bindings: exynos-dw-mshc-common: add exynos78xx variants
  arm64: dts: exynos: fix wrong mmc compatible in exynos7885.dtsi
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  41 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.38.3


