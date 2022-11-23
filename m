Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E4D636819
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbiKWSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbiKWSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:21 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EF87540;
        Wed, 23 Nov 2022 10:02:19 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 14C8B230D;
        Wed, 23 Nov 2022 19:02:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669226538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=c9X0aB1MOfJDBZBFwBnnPi+xIrZAxMTEG5SibnL5psE=;
        b=cE6N5p06b4eXElJvKMcOsnqMBfFTyvxPn9X6OvCEx8qFtPtMSdaZQISto3AnUq614/o3wJ
        Dr78xxIcn6TnKQxLFaslbk/HtaXCLk1XyDOiPuVrEAxxCviv8e4k02rpQYIyB9ptWw9lug
        8igjCV6MynDtgh57H3u3w75TA2qokcC8R8wydGuBdXU6eH7kEmevKVVTAW7JLB1QFrJiM3
        m9LFO5MTrbDvM/9PhLNt66pgBn+DaTpZ0aGfv6IE53Ie28hKGcg5Fwaq99+Y4Iu/uhalbW
        yUK4nvxjT1OUquNAd5SBxhrIfGu9wkqugJSsz2cwp25hrWE+QLt0njpQDp9UNQ==
From:   Michael Walle <michael@walle.cc>
To:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 00/20] nvmem: core: introduce NVMEM layouts
Date:   Wed, 23 Nov 2022 19:01:31 +0100
Message-Id: <20221123180151.2160033-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now the third attempt to fetch the MAC addresses from the VPD
for the Kontron sl28 boards. Previous discussions can be found here:
https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/


NVMEM cells are typically added by board code or by the devicetree. But
as the cells get more complex, there is (valid) push back from the
devicetree maintainers to not put that handling in the devicetree.

Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
can add cells during runtime. That way it is possible to add more complex
cells than it is possible right now with the offset/length/bits
description in the device tree. For example, you can have post processing
for individual cells (think of endian swapping, or ethernet offset
handling).

The imx-ocotp driver is the only user of the global post processing hook,
convert it to nvmem layouts and drop the global post pocessing hook.

For now, the layouts are selected by the device tree. But the idea is
that also board files or other drivers could set a layout. Although no
code for that exists yet.

Thanks to Miquel, the device tree bindings are already approved and merged.

NVMEM layouts as modules?
While possible in principle, it doesn't make any sense because the NVMEM
core can't be compiled as a module. The layouts needs to be available at
probe time. (That is also the reason why they get registered with
subsys_initcall().) So if the NVMEM core would be a module, the layouts
could be modules, too.

Michael Walle (18):
  net: add helper eth_addr_add()
  of: base: add of_parse_phandle_with_optional_args()
  of: property: make #.*-cells optional for simple props
  of: property: add #nvmem-cell-cells property
  nvmem: core: fix device node refcounting
  nvmem: core: add an index parameter to the cell
  nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
  nvmem: core: drop the removal of the cells in nvmem_add_cells()
  nvmem: core: add nvmem_add_one_cell()
  nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: provide own priv pointer in post process callback
  nvmem: layouts: add sl28vpd layout
  MAINTAINERS: add myself as sl28vpd nvmem layout driver

Miquel Raynal (2):
  nvmem: layouts: Add ONIE tlv layout driver
  MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer

 Documentation/driver-api/nvmem.rst |  15 ++
 MAINTAINERS                        |  12 ++
 drivers/nvmem/Kconfig              |   4 +
 drivers/nvmem/Makefile             |   1 +
 drivers/nvmem/core.c               | 285 ++++++++++++++++++++++-------
 drivers/nvmem/imx-ocotp.c          |  34 ++--
 drivers/nvmem/layouts/Kconfig      |  23 +++
 drivers/nvmem/layouts/Makefile     |   7 +
 drivers/nvmem/layouts/onie-tlv.c   | 244 ++++++++++++++++++++++++
 drivers/nvmem/layouts/sl28vpd.c    | 153 ++++++++++++++++
 drivers/of/property.c              |   6 +-
 include/linux/etherdevice.h        |  14 ++
 include/linux/nvmem-consumer.h     |  17 +-
 include/linux/nvmem-provider.h     |  95 +++++++++-
 include/linux/of.h                 |  25 +++
 15 files changed, 836 insertions(+), 99 deletions(-)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c

-- 
2.30.2

