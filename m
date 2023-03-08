Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FC6B0CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCHPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjCHPcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:07 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B8ED08D2;
        Wed,  8 Mar 2023 07:32:04 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85DEDFF80B;
        Wed,  8 Mar 2023 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FwO2zlWObkQcohsTankX+8VhI452lIAhVfKscDEj0uo=;
        b=lUcVVGwWezei7P+WTOSOzVnm29voph2nQSGHK1CcFmrm0FoE0yandRI9dj8XdeFZcrmFlI
        xod0L3DxK++0afQ1x3S+tES51F5D7Y3XEO08VxwR5cKBzTMJqTQWOKVxg+oBPj2qfCiFWT
        6JL1cD8mZOs26M1tR2+F30m9YTg0536ekBrS6ngJ32eucomeMGfxaNwUtkF/HBj56Pukho
        X+aLcjfG/MXm7+VSh4bT3tX6vMxXD6BeqrY6xTkNOR5WLI2kpgUc2DZDpufsok7QRbMtJU
        8ZuDLj3yxEM6/6RoQY95m8gm3z77yLNL1zI/Ve8a/VVuPMf/WehdZVhRFD0CIg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v3 00/20] [PATCH v3 00/20] nvmem: Layouts support
Date:   Wed,  8 Mar 2023 16:31:40 +0100
Message-Id: <20230308153200.682248-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a fully featured series with hopefully all what is needed for
upstream acceptance, ie:
* A bit of OF cleanup
* Full nvmem layout support merging Michael's and my patches
* Only the fixes not applying to this series have been kept "un merged"
* Support for SL28 VPD and ONIE TLV table layouts
* Layouts can be compiled as modules

A linux-0day branch for kernel test robot has been pushed to get wider
testing.

In order for this series to work out-of-the-box it requires to be
applied on top of Michael Walle's mtd fixes series. There is an
immutable tag on the mtd repository available:

----------------------------------------------------------------
The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/core-fixes-before-nvmem-layouts-for-6.4

for you to fetch changes up to 281f7a6c1a33fffcde32001bacbb4f672140fbf9:

  mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER (2023-03-08 14:31:49 +0100)
----------------------------------------------------------------

So to summarize:
* Rob's feedback is welcome on the remaining un-acked OF patche
* Greg's and Srinivas feedback is welcome on the nvmem patches
* If everybody agrees I expect the full series to be applied rather
  early by Srinivas on top of the -rc he wants.
* Once time for the final PR I expect Greg to merge the immutable tag
  above with Michael's patches before taking this series in.

Thanks,
Miquèl

Changes in v3:
* Rebased on top of nvmem-next and handled a few conflicts.
* Minor changes in the OF commit logs.
* Fixed a missing header reported by kernel test robot.
* Mention immutable tag.
* Collected more tags.
* Fix of/module.c license.

Changes in v2:
* Included all initial core nvmem changes.
* Merged all the relevant fixes.
* Updated the commit logs of the Fixes tag when relevant.
* Followed Rob advises to migrate the module related helpers into
  of/module.c and get the useless helpers out of of_device.c
* Added my Signed-off-by when relevant.
* Collected tags.

Colin Ian King (1):
  dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"

Michael Walle (8):
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: provide own priv pointer in post process callback
  nvmem: layouts: sl28vpd: Add new layout driver
  MAINTAINERS: add myself as sl28vpd nvmem layout driver

Miquel Raynal (11):
  of: Fix modalias string generation
  of: Update of_device_get_modalias()
  of: Rename of_modalias_node()
  of: Move of_modalias() to module.c
  of: Move the request module helper logic to module.c
  usb: ulpi: Use of_request_module()
  of: device: Kill of_device_request_module()
  nvmem: core: handle the absence of expected layouts
  nvmem: core: request layout modules loading
  nvmem: layouts: onie-tlv: Add new layout driver
  MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer

 .../nvmem/layouts/onie,tlv-layout.yaml        |   2 +-
 Documentation/driver-api/nvmem.rst            |  15 +
 MAINTAINERS                                   |  12 +
 drivers/acpi/bus.c                            |   7 +-
 drivers/gpu/drm/drm_mipi_dsi.c                |   2 +-
 drivers/hsi/hsi_core.c                        |   2 +-
 drivers/i2c/busses/i2c-powermac.c             |   2 +-
 drivers/i2c/i2c-core-of.c                     |   2 +-
 drivers/nvmem/Kconfig                         |   4 +
 drivers/nvmem/Makefile                        |   1 +
 drivers/nvmem/core.c                          | 160 ++++++++++-
 drivers/nvmem/imx-ocotp.c                     |  30 +-
 drivers/nvmem/layouts/Kconfig                 |  23 ++
 drivers/nvmem/layouts/Makefile                |   7 +
 drivers/nvmem/layouts/onie-tlv.c              | 257 ++++++++++++++++++
 drivers/nvmem/layouts/sl28vpd.c               | 165 +++++++++++
 drivers/of/Makefile                           |   2 +-
 drivers/of/base.c                             |  18 +-
 drivers/of/device.c                           |  75 +----
 drivers/of/module.c                           |  74 +++++
 drivers/spi/spi.c                             |   4 +-
 drivers/usb/common/ulpi.c                     |   2 +-
 include/linux/nvmem-consumer.h                |   7 +
 include/linux/nvmem-provider.h                |  66 ++++-
 include/linux/of.h                            |  18 +-
 include/linux/of_device.h                     |   6 -
 26 files changed, 851 insertions(+), 112 deletions(-)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/of/module.c

-- 
2.34.1

