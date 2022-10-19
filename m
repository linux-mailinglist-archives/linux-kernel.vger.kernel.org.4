Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE8F603803
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJSC0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJSC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:26:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321D6D54A;
        Tue, 18 Oct 2022 19:26:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h12so15823851pjk.0;
        Tue, 18 Oct 2022 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=er/1qGyGPvy6leNV/3q4zAE8W98J7263JUcIKC3pW08=;
        b=kGTujcOB3B+7jMN5o1Z99H9KU3GHkeaI9cm8VoIcbyq2/AO6Qc6EA2YrA24w+7YQ2Z
         twmL8+DIJycKjL5ZmO9D/Zi5SzxfKKJK2Oz6IyftXGFLD/Pl3pKqCz85Y366E7VH8Yf8
         adXGCEHt5eyafr3niacj1kpwnnBluq72pG5eda2vjXp6/bx22V1U7uakYwH73YArQ/nJ
         8CZf3oKvqEiWRgRtQxifyvJ3EWNtt3ikzMlvYqnC08a6FVJ34YToX2AL8XQ92+X5G89P
         FhhvK1PCCTmUyoOvLLFazppu2D3kYRdes33+qT23DYlAnSSOntlZa/Gp6B+ZE/NKxegw
         tGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=er/1qGyGPvy6leNV/3q4zAE8W98J7263JUcIKC3pW08=;
        b=rw30vO825f6KE0NzMmZqOqAW8EE2RUpMVyLoos1Hq6zYb6jv0mSYfqCpCefTilbYz7
         vEDHBBbytcG9LNU1yD3Ff98KwD6yNxZUey2GcfvKabyWCzvDA8FI0ixMZ1rbNPOS5J/2
         heCCKgeP32O4A274yz6TZdjeMnkaZwGMmVhtIUdy+QL67Ov3clFmSvjgYrLrK/NaM3C6
         VCckJvoZGasko/WY4bYHyG2AIj5B5H5QG65S9wTh+iDbT8hJx+4Eil2FVYYZcKe/XKr4
         0z1f+CX9ClGywyJYERdQjEpel4/f9tda2z5ihKl00IOkp+v50AsEBLrpvqMzr1syHS8/
         kPeg==
X-Gm-Message-State: ACrzQf06hj3GnDK70tO46JMb9uCgdNeWjmKfntNkWJECzYlxfNjMV7xN
        FMGI0QmUuTLDBUciOn2PA5HA3ll+hjFI
X-Google-Smtp-Source: AMsMyM7Yurvg98ZqCVYDyHQO86dBDHZRnNHEf77YxFX38kvUJi7qaSIEHQwsDWnCc3YMDOZ5kQtC9w==
X-Received: by 2002:a17:903:2c2:b0:182:df88:e6d3 with SMTP id s2-20020a17090302c200b00182df88e6d3mr5980937plk.81.1666146370650;
        Tue, 18 Oct 2022 19:26:10 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00562a526cd2esm9855880pfb.55.2022.10.18.19.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:26:10 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH 0/5] Add support control UP board CPLD/FPGA pin control
Date:   Wed, 19 Oct 2022 10:24:45 +0800
Message-Id: <20221019022450.16851-1-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UP board <http://www.upboard.com> is the computer board for 
Professional Makers and Industrial Applications. We want to upstream 
the UP board 40-pin GP-bus Kernel driver for giving the users better 
experience on the software release. (not just download from UP board 
github)

These patches are generated from the Linux kernel mainline tag v6.0.

(1) PATCH 1 (mfd: Add support for UP board CPLD/FPGA)
We did git send-email this patch to maintainer on 2022/10/11 for reviewing.

(2) PATCH 2 (regmap: Expose regmap_writable function to check if a register is
    writable)
The regmap patch expose the regmap_writeable function for pinctrl-upboard 
reference.

(3) PATCH 3 (ACPI: acpi_node_add_pin_mapping added to header file)
Declare acpi_node_add_pin_mapping added in header file.

(4) PATCH 4 (GPIO ACPI: Add support to map GPIO resources to ranges)
Add a pin mapping for named GPIO resources for pinctrl-upboard 
reference.

(3) PATCH 5 (pinctrl: Add support pin control for UP board CPLD/FPGA)
The UP board implements certain features (pin control) through an on-board CPLD.
** This patch depends on PATCH 1 (mfd: Add support for UP board CPLD/FPGA).
** This patch depends on PATCH 2 to refer to regmap_writeable function.
** This patch depends on PATCH 3 and PATCH 4 to refer to acpi_node_add_pin_mapping 
function.

chengwei (5):
  mfd: Add support for UP board CPLD/FPGA
  regmap: Expose regmap_writeable function to check if a register is
    writable
  ACPI: acpi_node_add_pin_mapping added to header file
  GPIO ACPI: Add support to map GPIO resources to ranges
  pinctrl: Add support pin control for UP board CPLD/FPGA

 drivers/base/regmap/internal.h    |    5 -
 drivers/base/regmap/regmap.c      |    5 +
 drivers/gpio/gpiolib-acpi.c       |   88 ++-
 drivers/mfd/Kconfig               |   12 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/upboard-fpga.c        |  482 ++++++++++++++
 drivers/pinctrl/Kconfig           |   15 +
 drivers/pinctrl/Makefile          |    1 +
 drivers/pinctrl/pinctrl-upboard.c | 1003 +++++++++++++++++++++++++++++
 include/linux/acpi.h              |   14 +
 include/linux/mfd/upboard-fpga.h  |   49 ++
 include/linux/regmap.h            |    6 +
 12 files changed, 1659 insertions(+), 22 deletions(-)
 create mode 100644 drivers/mfd/upboard-fpga.c
 create mode 100644 drivers/pinctrl/pinctrl-upboard.c
 create mode 100644 include/linux/mfd/upboard-fpga.h


base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f
-- 
2.17.1

