Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950747404D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF0US3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjF0USP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:18:15 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA512D78;
        Tue, 27 Jun 2023 13:17:57 -0700 (PDT)
Received: from umang.jainideasonboard.com (85-160-38-115.reb.o2.cz [85.160.38.115])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 762DA558;
        Tue, 27 Jun 2023 22:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687896954;
        bh=TIFiNJEDvQFSgG2MNZKI8qDDNZkiyZVpQNwFUn17Ctg=;
        h=From:To:Cc:Subject:Date:From;
        b=tK53ar5zjb/pr4JJGvg/7QweqXo0DQWVymyT02CjARQTSN4TBGrhkBE21SHigYx3p
         5AmjWePQzH9Wyv3XiE+GMAaWJHaShEk+jF43opmUQNNR7YMe0OA8MxAlIYZMMxd3o3
         aB7RausGhbTjaisFKeoN6m8mcI/FlNnNPkyMRI9Q=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v8 0/5] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Tue, 27 Jun 2023 22:16:23 +0200
Message-Id: <20230627201628.207483-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series added a new bus type vchiq_bus_type and registers
child devices in order to move them away from using platform
device/driver.

Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
interface

Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
to the new bus respectively

Patch 5/5 removes a platform registeration helper which is no
longer required.

Changes in v8:
- Drop dual licensing. Instead use GPL-2.0 only for patch 1/5

Changes in v7:
(5 out of 6 patches from v6 merged)
- Split the main patch (6/6) as requested.
- Use struct vchiq_device * instead of struct device * in
  all bus functions.
- Drop additional name attribute displayed in sysfs (redundant info)
- Document vchiq_interface doesn't enumerate device discovery
- remove EXPORT_SYMBOL_GPL(vchiq_bus_type)

Changes in v6:
- Split struct device and struct driver wrappers in vchiq_device.[ch]
- Move vchiq_bus_type definition to vchiq_device.[ch] as well
- return error on bus_register() failure
- drop dma_set_mask_and_coherent
- trivial variable name change

Changes in v5:
- Fixup missing "staging: " in commits' subject line
- No code changes from v4

Changes in v4:
- Introduce patches to drop include directives from Makefile

Changes in v3:
- Rework entirely to replace platform devices/driver model

-v2:
https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/

-v1:
https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/


Umang Jain (5):
  staging: vc04_services: vchiq_arm: Add new bus type and device type
  staging: vc04_services: vchiq_arm: Register vchiq_bus_type
  staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
  staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
  staging: vc04_services: vchiq_arm: Remove vchiq_register_child()

 drivers/staging/vc04_services/Makefile        |  1 +
 .../vc04_services/bcm2835-audio/bcm2835.c     | 17 ++--
 .../bcm2835-camera/bcm2835-camera.c           | 16 ++--
 .../interface/vchiq_arm/vchiq_arm.c           | 56 +++++++------
 .../interface/vchiq_arm/vchiq_device.c        | 78 +++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        | 43 ++++++++++
 6 files changed, 165 insertions(+), 46 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h

-- 
2.39.1

