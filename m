Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3F4608254
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 01:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJUX6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 19:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJUX6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 19:58:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D9A1B1C8;
        Fri, 21 Oct 2022 16:58:07 -0700 (PDT)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68EAE660252D;
        Sat, 22 Oct 2022 00:58:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666396685;
        bh=a3iEJRRx2i0AYVW3m+KefcvY47eYOOMzFjASGdT7sJU=;
        h=From:To:Cc:Subject:Date:From;
        b=XvdCipCdQYs286Okzi5yErxAbMs9XObpzYd2VBQmgjeRtUy1++WhIUJNlbI8qZ1cW
         4V933CLC1yqzuxZRKzwJcTdmfXr43L9n7oEWEDmaMyDH4y5LU3oHwqMy6Py2iLa+Fj
         8ANkXg9O+dtt2fPzeyYBohyTHTw0eG2acf1/mXmfMYWfuHSXamT9ldNfPpEmG2YDRV
         4fj52TStQgTEjfO3hfNbTVdC5K+j/8ghlsY/DReyUjxt8VooiiWuWSBcrYx7bRAUsG
         Fl2C9RwFQmaG/5CnHxz9SsXPtqVu/i0hv4C5lYfXNAKRmRnC3TzS1N7JiSSjhn6OtY
         uLkdncJ4V/XEQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com, nas.chung@chipsnmedia.com,
        hverkuil@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        linux-kernel@vger.kernel.org, nicolas.dufresne@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Subject: [PATCH v10 0/7] Wave5 codec driver
Date:   Sat, 22 Oct 2022 01:56:57 +0200
Message-Id: <20221021235704.219915-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wave5 codec driver is a stateful encoder/decoder.
It is found on the J721S2 SoC, JH7100 SoC, ssd202d SoC. Etc.
But current test report is based on J721S2 SoC and pre-silicon FPGA.

The driver currently supports V4L2_PIX_FMT_HEVC, V4L2_PIX_FMT_H264.

This driver has so far been tested on J721S2 EVM board and pre-silicon
FPGA.

Testing on J721S2 EVM board shows it working fine both decoder and
encoder.
The driver is successfully working with gstreamer v4l2 good-plugin
without any modification.

# v4l2-compliance -d0
Total for wave5-dec device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0

# v4l2-compliance -d1
Buffer ioctls:
		fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-buffers.cpp(610): q.reqbufs(node, 1)
	test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: FAIL
		fail: ../../../v4l-utils-1.18.1/utils/v4l2-compliance/v4l2-test-buffers.cpp(753): q.reqbufs(node, 2)
	test VIDIOC_EXPBUF: FAIL
	test Requests: OK (Not Supported)

Total for wave5-enc device /dev/video1: 44, Succeeded: 42, Failed: 2, Warnings: 2

changes since v9:

* Move from staging to the media directory
  * Move coda driver to sub-directory

* Fixes:
  * Use platform_get_irq instead of platform_get_resource to fetch the IRQ

* General cleanups:
  * Add missing error messages to error conditions
  * Improve messages/variable names/comments, align parameter names across the driver
  * Use macros instead of magic numbers in multiple occassions
  * Reduce code duplication in multiple places
  * Fix whitespace, newline and tab alignment issues
  * Remove unused struct fields & commented out code
  * Convert signed integers to unsigned if signed is not necessary
  * Convert int/unsigned int to s32/u32, when the variable is assigned to the
    return of a register read or provided as a parameter for a register write
    (and vice versa)
  * Fix incorrect bitwise operators where logical operators are appropriate
  * Multiple smaller changes

* Generalization:
  * Add new helper file providing generalized routines for vpu-dec & vpu-enc
  * Generalize luma & chroma table size calculation and stride calculation

* Resource cleanup and error handling:
  * Add error handling to all calls with ignored return codes
  * Handle DMA resource cleanup properly
  * Fix insufficient instance cleanup while opening dec/enc

changes since v8:

* add 'wave5' to DEV_NAME
* update to support Multi-stream
* update to support loop test/dynamic resolution change
* remove unnecessary memset, g_volatile, old version option

changes since v7:

* update v4l2-compliance test report
* fix build error on linux-kernel 5.18.0-rc4

changes since v6:

* update TODO file
* get sram info from device tree

changes since v5:

* support NV12/NV21 pixelformat for encoder and decoder
* handle adnormal exit and EOS

changes since v4:

* refactor functions in wave5-hw and fix bug reported by Daniel Palmer
* rename functions and variables to better names
* change variable types such as replacing s32 with u32 and int with bool
* as appropriate

changes since v3:

* Fixing all issues commented by Dan Carpenter
* Change file names to have wave5- prefix
* In wave5_vpu_probe, enable the clocks before reading registers, as
* commented from Daniel Palmer
* Add more to the TODO list,

changes since v2:

Main fixes includes:
* change the yaml and dirver code to support up to 4 clks (instead of
* one)
* fix Kconfig format
* remove unneeded cast,
* change var types
* change var names, func names
* checkpatch fixes

changes since v1:

Fix changes due to comments from Ezequiel and Dan Carpenter. Main fixes
inclueds:
* move all files to one dir 'wave5'
* replace private error codes with standard error codes
* fix extra spaces
* various checkpatch fixes
* replace private 'DPRINTK' macro with standard 'dev_err/dbg ..'
* fix error handling
* add more possible fixes to the TODO file

Dafna Hirschfeld (1):
  media: chips-media: wave5: Add the vdi layer

Nas Chung (3):
  media: chips-media: wave5: Add vpuapi layer
  media: chips-media: wave5: Add the v4l2 layer
  media: chips-media: wave5: Add TODO file

Robert Beckett (2):
  dt-bindings: media: wave5: add yaml devicetree bindings
  media: chips-media: wave5: Add wave5 driver to maintainers file

Sebastian Fricke (1):
  media: platform: chips-media: Move Coda to separate folder

 .../devicetree/bindings/media/wave5.yml       |   73 +
 MAINTAINERS                                   |   11 +-
 drivers/media/platform/chips-media/Kconfig    |   18 +-
 drivers/media/platform/chips-media/Makefile   |    6 +-
 .../media/platform/chips-media/coda/Kconfig   |   18 +
 .../media/platform/chips-media/coda/Makefile  |    6 +
 .../chips-media/{ => coda}/coda-bit.c         |    0
 .../chips-media/{ => coda}/coda-common.c      |    0
 .../chips-media/{ => coda}/coda-gdi.c         |    0
 .../chips-media/{ => coda}/coda-h264.c        |    0
 .../chips-media/{ => coda}/coda-jpeg.c        |    0
 .../chips-media/{ => coda}/coda-mpeg2.c       |    0
 .../chips-media/{ => coda}/coda-mpeg4.c       |    0
 .../platform/chips-media/{ => coda}/coda.h    |    0
 .../chips-media/{ => coda}/coda_regs.h        |    0
 .../chips-media/{ => coda}/imx-vdoa.c         |    0
 .../chips-media/{ => coda}/imx-vdoa.h         |    0
 .../platform/chips-media/{ => coda}/trace.h   |    0
 .../media/platform/chips-media/wave5/Kconfig  |   12 +
 .../media/platform/chips-media/wave5/Makefile |   10 +
 drivers/media/platform/chips-media/wave5/TODO |   25 +
 .../platform/chips-media/wave5/wave5-helper.c |  175 +
 .../platform/chips-media/wave5/wave5-helper.h |   28 +
 .../platform/chips-media/wave5/wave5-hw.c     | 3459 +++++++++++++++++
 .../chips-media/wave5/wave5-regdefine.h       |  654 ++++
 .../platform/chips-media/wave5/wave5-vdi.c    |  261 ++
 .../platform/chips-media/wave5/wave5-vdi.h    |   67 +
 .../chips-media/wave5/wave5-vpu-dec.c         | 1399 +++++++
 .../chips-media/wave5/wave5-vpu-enc.c         | 1454 +++++++
 .../platform/chips-media/wave5/wave5-vpu.c    |  362 ++
 .../platform/chips-media/wave5/wave5-vpu.h    |   72 +
 .../platform/chips-media/wave5/wave5-vpuapi.c | 1115 ++++++
 .../platform/chips-media/wave5/wave5-vpuapi.h | 1198 ++++++
 .../chips-media/wave5/wave5-vpuconfig.h       |   90 +
 .../chips-media/wave5/wave5-vpuerror.h        |  454 +++
 .../media/platform/chips-media/wave5/wave5.h  |   94 +
 36 files changed, 11040 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/wave5.yml
 create mode 100644 drivers/media/platform/chips-media/coda/Kconfig
 create mode 100644 drivers/media/platform/chips-media/coda/Makefile
 rename drivers/media/platform/chips-media/{ => coda}/coda-bit.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-common.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-gdi.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-h264.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-jpeg.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg2.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda-mpeg4.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/coda_regs.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.c (100%)
 rename drivers/media/platform/chips-media/{ => coda}/imx-vdoa.h (100%)
 rename drivers/media/platform/chips-media/{ => coda}/trace.h (100%)
 create mode 100644 drivers/media/platform/chips-media/wave5/Kconfig
 create mode 100644 drivers/media/platform/chips-media/wave5/Makefile
 create mode 100644 drivers/media/platform/chips-media/wave5/TODO
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-helper.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-hw.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-regdefine.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
 create mode 100644 drivers/media/platform/chips-media/wave5/wave5.h

-- 
2.25.1

