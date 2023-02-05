Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29868AF9C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjBELx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 06:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBELxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 06:53:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25B619A
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 03:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 62A5CCE0AEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 11:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E786C433EF;
        Sun,  5 Feb 2023 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675597998;
        bh=qu0N+XJRO09N6J3ptsQ8QLa4iLGN00NoqKAMS8si4lU=;
        h=Date:From:To:Cc:Subject:From;
        b=ewYoJGPUDF8ToH5YR7Dt0RlIGaQiJwvZwESojG14e7H8aOThhFOov4b1errMWmj+g
         fzpDw9Pqjj9aujGKkW9jeg4FShKuosadejxtm3gqINWyrtSglee/75heT9vVC5CpMk
         EdzQHi7sHt1+Ir/lZojH2MvXUojuqcjjF9KdINkI=
Date:   Sun, 5 Feb 2023 12:53:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.2-rc7
Message-ID: <Y9+Yq7H4bnlWW+k3@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.2-rc7

for you to fetch changes up to d83d7ed260283560700d4034a80baad46620481b:

  kernel/irq/irqdomain.c: fix memory leak with using debugfs_lookup() (2023-02-03 07:45:46 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 6.2-rc7

Here are a number of small char/misc/whatever driver fixes for 6.2-rc7.
They include:
  - IIO driver fixes for some reported problems
  - nvmem driver fixes
  - fpga driver fixes
  - debugfs memory leak fix in the hv_balloon and irqdomain code
    (irqdomain change was acked by the maintainer.)

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andreas Kemnade (2):
      iio:adc:twl6030: Enable measurements of VUSB, VBAT and others
      iio:adc:twl6030: Enable measurement of VAC

Carlos Song (9):
      iio: imu: fxos8700: fix map label of channel type to MAGN sensor
      iio: imu: fxos8700: fix swapped ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix incomplete ACCEL and MAGN channels readback
      iio: imu: fxos8700: fix IMU data bits returned to user space
      iio: imu: fxos8700: fix ACCEL measurement range selection
      iio: imu: fxos8700: fix incorrect ODR mode readback
      iio: imu: fxos8700: fix failed initialization ODR mode assignment
      iio: imu: fxos8700: remove definition FXOS8700_CTRL_ODR_MIN
      iio: imu: fxos8700: fix MAGN sensor scale and unit

Dmitry Perchanov (2):
      iio: hid: fix the retval in accel_3d_capture_sample
      iio: hid: fix the retval in gyro_3d_capture_sample

Frank Li (1):
      iio: imx8qxp-adc: fix irq flood when call imx8qxp_adc_read_raw()

Greg Kroah-Hartman (4):
      Merge tag 'fpga-for-6.2-final' of git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga into char-misc-linus
      Merge tag 'iio-fixes-for-6.2a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next
      HV: hv_balloon: fix memory leak with using debugfs_lookup()
      kernel/irq/irqdomain.c: fix memory leak with using debugfs_lookup()

Ilpo Järvinen (1):
      fpga: m10bmc-sec: Fix probe rollback

Jiasheng Jiang (1):
      nvmem: brcm_nvram: Add check for kzalloc

Johan Hovold (1):
      nvmem: qcom-spmi-sdam: fix module autoloading

Kai-Heng Feng (1):
      iio: light: cm32181: Fix PM support on system with 2 I2C resources

Marco Pagani (1):
      iio: adc: xilinx-ams: fix devm_krealloc() return value check

Michael Walle (2):
      nvmem: core: fix device node refcounting
      nvmem: core: fix cell removal on error

Olivier Moysan (1):
      iio: adc: stm32-dfsdm: fill module aliases

Russell King (Oracle) (5):
      nvmem: core: initialise nvmem->id early
      nvmem: core: remove nvmem_config wp_gpio
      nvmem: core: fix cleanup after dev_set_name()
      nvmem: core: fix registration vs use race
      nvmem: core: fix return value

Samuel Holland (1):
      nvmem: sunxi_sid: Always use 32-bit MMIO reads

Vladimir Oltean (1):
      iio: imu: st_lsm6dsx: fix build when CONFIG_IIO_TRIGGERED_BUFFER=m

Xiongfeng Wang (1):
      iio: adc: berlin2-adc: Add missing of_node_put() in error path

Zheng Yongjun (1):
      fpga: stratix10-soc: Fix return value check in s10_ops_write_init()

 drivers/fpga/intel-m10-bmc-sec-update.c |  17 +++--
 drivers/fpga/stratix10-soc.c            |   4 +-
 drivers/hv/hv_balloon.c                 |   2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c |   1 +
 drivers/iio/adc/berlin2-adc.c           |   4 +-
 drivers/iio/adc/imx8qxp-adc.c           |  11 +++-
 drivers/iio/adc/stm32-dfsdm-adc.c       |   1 +
 drivers/iio/adc/twl6030-gpadc.c         |  32 +++++++++
 drivers/iio/adc/xilinx-ams.c            |   2 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c   |   1 +
 drivers/iio/imu/fxos8700_core.c         | 111 +++++++++++++++++++++++++-------
 drivers/iio/imu/st_lsm6dsx/Kconfig      |   1 +
 drivers/iio/light/cm32181.c             |   9 +--
 drivers/nvmem/brcm_nvram.c              |   3 +
 drivers/nvmem/core.c                    |  60 ++++++++---------
 drivers/nvmem/qcom-spmi-sdam.c          |   1 +
 drivers/nvmem/sunxi_sid.c               |  15 ++++-
 include/linux/nvmem-provider.h          |   2 -
 kernel/irq/irqdomain.c                  |   2 +-
 19 files changed, 207 insertions(+), 72 deletions(-)
