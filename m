Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18E76B6A58
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCLSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLStz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:49:55 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B64A5F3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:49:53 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cy23so40228262edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646992;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=HdXoN0LZBPeppQRQvxhsgRDcLgoTjBZeBFc1YtBicTKO4Ry6ffMXIHQ59y5mVi1dnM
         LHZPeU0rSJn8k4ia9Zc0qNgB8kEhVKLa+9n3d0hj7Zm/zvPQe6wYuWuHds4FG0ADkpaN
         I4Tx5QXrvLBbbtAxAf+chcxDcnO+hJZXHyeES0s2oYrxxIR8xhsJVuK1xJf9Eu9pFI7Y
         tnSjQNCzlTv8E2k1q1p441dbNlbvDciiDqG3S2pTb5cknV6Z/urEqASgOypCK+LB3yQV
         xLRUoicxjgfBDhKDFFZDZ2KzO7dyvbf+Oc2zdaRe7ev9tkj1Xx3HBznFyLMjSUi+l0cJ
         I48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646992;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=f/WBkbYTQ/YVHm6DDdLdGVSy4mQsxPZPGKi6obcJOfTpO+wDCIUfrQAPMGhnDbf0Uv
         DMXTvE3Y9axiCgqPjjhy0jKKNHjK4v7f0/dzPVMSxYfdn0kMu0oKnA53hbldm0yyjuqu
         bOTOiEqjDV+1cEQLEJb/DDUCPH1Vt051StBH5p8KbFede6tMg0nZGb2jjjd3AndwwUvB
         rDpO3e4EAagIRUZz5qBq3ESmcnsKwxKuY21yFgOFnHK29ZStZ9tMUNo2xSL2kbmIfxCc
         NFUK8Pc3V7zHG1cef1tb+Je+obZyq27p4EUemDBvmTahUkIyPv2Y8FNHF8HeFpzaXcGO
         Mp1A==
X-Gm-Message-State: AO0yUKVqN8XKBZEFgtBz3fl/bliwQBzAsn0EdZwe9OJUzjI+ovqVZZhT
        BgG9QDzn7KszRMwb/5eoLKfZNprYTKdT1B6f
X-Google-Smtp-Source: AK7set/8IHLJDJpvfxNcT2e2rt1XwS/S6/6u01B6E+FOExI0gvyV6h9v3km52otzMxJ3EgdMl2Mw9w==
X-Received: by 2002:a2e:710b:0:b0:293:4ebc:98e0 with SMTP id m11-20020a2e710b000000b002934ebc98e0mr9215651ljc.17.1678644627888;
        Sun, 12 Mar 2023 11:10:27 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id l1-20020a2e8341000000b002934b8d115csm717271ljh.51.2023.03.12.11.10.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:10:27 -0700 (PDT)
Message-Id: <1678644516.665314-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
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

v5:
- rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"
- rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"

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
  dt-bindings: exynos-dw-mshc-common: add exynos7885 variants
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO
  arm64: dts: exynos: fix wrong mmc compatible in exynos7885.dtsi

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  43 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 167 insertions(+), 4 deletions(-)

-- 
2.38.3


