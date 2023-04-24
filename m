Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D66ECCAE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjDXNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjDXNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8C49D0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 06:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B94612CA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 13:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE442C433EF;
        Mon, 24 Apr 2023 13:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682341817;
        bh=ptsUwxDmDFB9kUORGXpqRskpK+VBWczscm00zzcvs+A=;
        h=From:To:Cc:Subject:Date:From;
        b=SgkPaei3mbN+wePLz3i6H2kEV4w+EbxIu0+PT+qKEoKIetmxw8bOd0MnZCchsYjwP
         HkdKMj2IVW+AYlbnjCeWN0UvIKCtmU5Dw3rQh4065r4yImvzDnt7O6LM7BaYR96Zw3
         b14RjVDkdh5JCvGPgvNhjCYunHk+f+UhORNJAsIwz6IIUB3cF7QTwV9MFQefvBOYX3
         zEooXxWVzavVBB7twtG540lMaea3rlo/NCv2Yuqa+Wuimd4z04RO2tOVHRYRQ6435K
         0LK2phbbMWJxNxYBUQEYNU9pnherb2E9hF/NZ2qQDvB6Om8WtreTu0ECvr7CWloEJu
         pJAtlCSeJpbyQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v6.4
Date:   Mon, 24 Apr 2023 14:10:05 +0100
Message-Id: <20230424131016.DE442C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.4

for you to fetch changes up to 4a670ac3e75e517c96cbd01ef870dbd598c3ce71:

  regmap: allow upshifting register addresses before performing operations (2023-04-07 17:28:19 +0100)

----------------------------------------------------------------
regmap: Updates for v6.4

This is a much bigger change for regmap than is normal, the main things
being the addition of some KUnit coverage and a maple tree based
register cache which longer term is likely to replace the rbtree cache
except possibly for very small register maps.  While it's complete
overkill for most applications the code for maple trees is there and
there are some larger, sparser devices where the data structure is a
better fit.

The maple tree support is still a work in progress but already useful,
there's some conversions of drivers ready to go after the merge window.

 - Support for shifting register addresses up as well as down, there's a
   use cases with memory mapped MDIO.
 - Refactoring of the type configuration in regmap-irq to allow access
   to driver data in the handler, needed by some GPIO devices.
 - Some initial KUnit coverage, the bulk of the driver facing API is
   covered but there's holes and things like the data marshalling for
   bytestream buses are just not covered in the slightest.
 - Removal of the compressed cache type, it had zero users and was
   getting in the way of KUnit.
 - Addition of a maple tree based register cache, there's more work to
   do but it's already useful for some devices with a flatter data
   structure than rbtree and getting to use all the optimisation work
   Liam is doing.

----------------------------------------------------------------
Alexander Stein (2):
      regmap: cache: Return error in cache sync operations for REGCACHE_NONE
      regmap: cache: Silence checkpatch warning

Andy Shevchenko (1):
      regmap-irq: Place kernel doc of struct regmap_irq_chip in order

Charles Keepax (1):
      regmap: sdw: Update misleading comment

Lucas Tanure (1):
      regmap: sdw: Remove 8-bit value size restriction

Mark Brown (15):
      Minor SoundWire Regmap Tweaks
      regmap: Add support for devices with no interrupt readback
      Merge tag 'v6.3-rc2' into regmap-6.4 to fix clock related boot issues
      Introduce a helper to translate register addresses
      regmap: Handle sparse caches in the default sync
      regmap: Clarify error for unknown cache types
      regmap: Support paging for buses with reg_read()/reg_write()
      regmap: Removed compressed cache support
      regmap: Add RAM backed register map
      regmap: Add some basic kunit tests
      regmap: Factor out single value register syncing
      regmap: Add maple tree based register cache
      regmap: Fix double unlock in the maple cache
      regmap: Use mas_walk() instead of mas_find()
      Migrate the PCIe-IDIO-24 and WS16C48 GPIO drivers

Maxime Chevallier (2):
      regmap: add a helper to translate the register address
      regmap: allow upshifting register addresses before performing operations

William Breathitt Gray (2):
      regmap-irq: Add no_status support
      regmap: Pass irq_drv_data as a parameter for set_type_config()

 drivers/base/regmap/Kconfig          |  13 +-
 drivers/base/regmap/Makefile         |   5 +-
 drivers/base/regmap/internal.h       |  24 +-
 drivers/base/regmap/regcache-lzo.c   | 368 -----------------
 drivers/base/regmap/regcache-maple.c | 279 +++++++++++++
 drivers/base/regmap/regcache.c       |  56 ++-
 drivers/base/regmap/regmap-irq.c     |  30 +-
 drivers/base/regmap/regmap-kunit.c   | 739 +++++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-ram.c     |  85 ++++
 drivers/base/regmap/regmap-sdw.c     |  41 +-
 drivers/base/regmap/regmap.c         |  53 ++-
 drivers/mfd/ocelot-spi.c             |   2 +-
 include/linux/regmap.h               |  36 +-
 13 files changed, 1284 insertions(+), 447 deletions(-)
 delete mode 100644 drivers/base/regmap/regcache-lzo.c
 create mode 100644 drivers/base/regmap/regcache-maple.c
 create mode 100644 drivers/base/regmap/regmap-kunit.c
 create mode 100644 drivers/base/regmap/regmap-ram.c
