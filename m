Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627FA675EB2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjATULV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjATULU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:11:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D233B2D01;
        Fri, 20 Jan 2023 12:11:19 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.251.226.6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89C13514;
        Fri, 20 Jan 2023 21:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674245476;
        bh=rV0RzFrPgZZu5H2m9myQYMHozrqwVyb+7LNA1fbwCZY=;
        h=From:To:Cc:Subject:Date:From;
        b=Hzgs14ikjisQdQx+Ia/rqr24jn+6b6OjhM9FEmAz+1geSWGMcFlX0MgE9abFe7dhF
         YOTbmdbATXHDXMA/3CBB50gOWKYkzFaoSiVYhE9IJVKf3FPu8SiBfZ3w1NfwFoqf/n
         iJPj3FKGX2lRMlbnZuGyMRQN5dTECB59tQNYplFA=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v6 0/6] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Sat, 21 Jan 2023 01:40:58 +0530
Message-Id: <20230120201104.606876-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series just introduces five extra patches for dropping include
directives from Makefiles (suggested by Greg KH) and rebased.

The main patch (6/6) removes platform device/driver abuse and moves
things to standard device/driver model using a custom_bus. Specific
details are elaborated in the commit message.

The patch series is based on top of d514392f17fd (tag: next-20230120)
of linux-next.

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

Umang Jain (6):
  staging: vc04_services: Drop __VCCOREVER__ remnants
  staging: vc04_services: bcm2835-audio: Drop include Makefile directive
  staging: vc04_services: bcm2835-camera: Drop include Makefile
    directive
  staging: vc04_services: vchiq-mmal: Drop include Makefile directive
  staging: vc04_services: interface: Drop include Makefile directive
  staging: vc04_services: vchiq: Register devices with a custom bus_type

 drivers/staging/vc04_services/Makefile        |   3 +-
 .../vc04_services/bcm2835-audio/Makefile      |   2 -
 .../vc04_services/bcm2835-audio/bcm2835.c     |  27 +++--
 .../vc04_services/bcm2835-audio/bcm2835.h     |   3 +-
 .../vc04_services/bcm2835-camera/Makefile     |   5 -
 .../bcm2835-camera/bcm2835-camera.c           |  35 +++---
 .../vc04_services/bcm2835-camera/controls.c   |   6 +-
 .../interface/vchiq_arm/vchiq_arm.c           |  52 +++++----
 .../interface/vchiq_arm/vchiq_core.h          |   2 +-
 .../interface/vchiq_arm/vchiq_device.c        | 102 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        |  39 +++++++
 .../interface/vchiq_arm/vchiq_ioctl.h         |   3 +-
 .../staging/vc04_services/vchiq-mmal/Makefile |   5 -
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   2 +-
 14 files changed, 206 insertions(+), 80 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h

-- 
2.39.0

