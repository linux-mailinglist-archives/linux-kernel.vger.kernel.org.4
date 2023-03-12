Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118E36B6A23
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCLSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjCLSfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:35:06 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615412CC1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:33:07 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn21so10054567edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645920;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=JdIjlxxDYdrHfoYxFwNIaefVmyUgzPG0N2cG0mDR/Di5MsrLJxO4RrdTtrsbcc5u2k
         po8XtO5BHhdXZ3+UrY6PWpJC4Ahh2xLrOlxa+InTzn7x8kNw0wq2S6yBzKPjxxk08w5z
         i/diX5Er/sbfdRynF7wcen4cCxmJLP1ELDFUoDw/z7t9BhlfsP3wQCsuje6IUDf9mdDy
         Wf0PLceYNME9k56CFPNPoqzw+iweAGeK3La71fTdTsP0yOffAJpnAm+5R6PY8VqQCkp4
         Oqi5SdrbEf4ZUeJMuFJD/kR+RmK8+/AI2jXXlGTHZ6fL2hklY+0vfkYl7wYQtQxIAnMR
         RCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645920;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=HC4bZpPTkpk5Rb597+F2+5T7rUJCSGhqnf+mw5dTye5xI82OnP1TFdlu+00+QW/moV
         NIpGhTAuF/CWhqd4pccjgF5UqBPaifWTYvnN8MQ8yLxpRc7weV5I9vgOnMv4grSS1V+M
         bLGvZgt47XIwX/cTEJHeARWH7wwUArCPp2T2J8fdGeqRN9ePtHx9wQx4DHMQS60V/y2f
         0J9eHL3zTMv0zNWuD7SRNA7fOTHRBi/fpgrSHjA2jrVOVNqensaru8xoYXrmldJaM8ol
         G7sL2v7/xS/JseP/hY92mryz1HaueDVeh3O/JUuv47VGPdDtRXijustOUHmre+gxh1Tu
         zvgA==
X-Gm-Message-State: AO0yUKWXnq2mhkc94LsvQpjzUiAldX/MZvhE4w/ia9t4IkCGibdEPS8O
        SNIAOeMxZvAELnEu3Vg5uArap1dZ02kCiDtf
X-Google-Smtp-Source: AK7set9IK5iBHGKPEkvDEy6FSHq4N7To13kM5Npy6CAUnEV1dhGVUTcJlQwsx/LlZWnADH3PXusRJQ==
X-Received: by 2002:a19:750a:0:b0:4e1:fa71:f187 with SMTP id y10-20020a19750a000000b004e1fa71f187mr8072498lfe.3.1678644274501;
        Sun, 12 Mar 2023 11:04:34 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25306000000b004a2c447598fsm713621lfh.159.2023.03.12.11.04.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:04:34 -0700 (PDT)
Message-ID: <640e1432.c20a0220.c98ba.1a8f@mx.google.com>
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


