Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EAB6C435C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCVGkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVGkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:40:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E1532A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h25so10392468lfv.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679467237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1iYp4UG4GMTK4dV58emsPNn1cJbQnTLnJ1m9QiHq4Q=;
        b=oVPBv0nfiGcz1Mz1QHwYjIqddtk9mdP1g6mDNvft/d4vd+5Oh6TcJDcl8OLZYX3VUQ
         /Mo5Pvg1u9mgWFFThPgsCI2rTqm1pMCKUvAEI3DkZH+p7P5F9PkoYbBut2eJgyIaQqJo
         n+xPQhIKZYNfnOLw80yE61AYAYSLpfYdC/nOtM7IvTw8oLmF7TlK3qtm/ERYEQftpvDk
         yEJyD4PuNhdHIvvJ6eMrrmLBBzemiEFcGvCZrxq4HpguCbFaRvN86n32fO98n6I9o4kM
         PgvGN75tAFTJkWZQl+HYz7UTIQY+f381mDlbXjcVqmSVfNkeYOoKda7MVRfuoDUbYHO7
         9PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679467237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1iYp4UG4GMTK4dV58emsPNn1cJbQnTLnJ1m9QiHq4Q=;
        b=aid3/9BqAKKoSSpqZu1T3bGPl25K/GN7GBcicvPMQP6pkxz0y840IVEAsVMQKWqiHA
         whck2kKlZ9aGjFBv3g6AFfuoKeUiC8W7zrV4Ft8I+PGPtvbihCEIQP34WjVDrhCIAjCb
         pze+mvaQT+YEPmCxewkRhcDj1FQPqaAmCOrSKbK7E57E68Q+cSGljMxHmI1k50e5uRYp
         1odYGIK1cWlX0khVWY6W6XjEV4z5oJDvL9u/yBjtr8hvvvvWtfLlOJaM57LI7nlfrvRl
         ik3S8kJdn3EDC8b+z0zCSnRjSx03hPyf6n20y/0N+dQwHxh9Eri7tSuccsgQkHcFMAh3
         9/Hw==
X-Gm-Message-State: AO0yUKULXxhKV8jh3Ciocs0j6W/KeNGMXkus+Ds15c1md5exGiGiAaeb
        SFDcIMZSyvwrGg1UKb1rfwmu5tP5JnBy7JtpC5M=
X-Google-Smtp-Source: AK7set+MMv93QezuXA8oiWNP7p/rZYXq7UdPRafaFjMM68cyrkAZdVBDMTT/FhwQPysiuhWt+FL0gQ==
X-Received: by 2002:ac2:5dc7:0:b0:4e8:43e2:a8 with SMTP id x7-20020ac25dc7000000b004e843e200a8mr1727406lfq.8.1679467237489;
        Tue, 21 Mar 2023 23:40:37 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id n20-20020ac242d4000000b004dafde0e7b7sm2462255lfl.279.2023.03.21.23.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 23:40:37 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     michael@walle.cc, pratyush@kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at,
        Takahiro.Kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 00/11] mtd: spi-nor: Address mode discovery (BFPT method & current address mode)
Date:   Wed, 22 Mar 2023 06:40:22 +0000
Message-Id: <20230322064033.2370483-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version of the following patch sets:
https://lore.kernel.org/linux-mtd/20220411125346.118274-1-tudor.ambarus@microchip.com/
https://lore.kernel.org/linux-mtd/20230315034004.5535-1-Takahiro.Kuwano@infineon.com/

Changes in v4:
- consider the BFPT retrieved address mode as an enumeration,
  manufacturers could support different methods at the same time
- split renaming of set_4byte_addr_mode methods in several patches for
  better clarity
- have initializations in a single line, even if bypasses the 80 chars
  limit, as they are < 100 chars anyway
- new patches that introduce spi_nor_set_4byte_addr_mode() and handle
  spi_nor_restore()
- clean Takahiro's patch

Takahiro Kuwano (1):
  mtd: spi-nor: spansion: Determine current address mode

Tudor Ambarus (10):
  mtd: spi-nor: core: Move generic method to core -
    micron_st_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    micron_st_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    spansion_set_4byte_addr_mode
  mtd: spi-nor: core: Update name and description of
    spi_nor_set_4byte_addr_mode
  mtd: spi-nor: core: Make spi_nor_set_4byte_addr_mode_brwr public
  mtd: spi-nor: Parse BFPT to determine the 4-Byte Address Mode methods
  mtd: spi-nor: Favor the BFPT-parsed set_4byte_addr_mode method
  mtd: spi-nor: Stop exporting spi_nor_restore()
  mtd: spi-nor: core: Update flash's current address mode when changing
    address mode
  mtd: spi-nor: core: Introduce spi_nor_set_4byte_addr_mode()

 Documentation/driver-api/mtd/spi-nor.rst |   3 -
 drivers/mtd/spi-nor/core.c               |  85 +++++++++++++--
 drivers/mtd/spi-nor/core.h               |   4 +
 drivers/mtd/spi-nor/macronix.c           |   8 +-
 drivers/mtd/spi-nor/micron-st.c          |  30 +-----
 drivers/mtd/spi-nor/sfdp.c               |  11 ++
 drivers/mtd/spi-nor/sfdp.h               |  28 +++++
 drivers/mtd/spi-nor/spansion.c           | 131 ++++++++++++++++++++++-
 drivers/mtd/spi-nor/winbond.c            |  13 ++-
 include/linux/mtd/spi-nor.h              |   6 --
 10 files changed, 267 insertions(+), 52 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

