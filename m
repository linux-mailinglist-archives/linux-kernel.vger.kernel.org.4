Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB099672801
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjARTSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjARTS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:18:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B8A38B45;
        Wed, 18 Jan 2023 11:18:28 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2405:204:820c:4b28:9aaf:3c:ef34:ecdd])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 823C61056;
        Wed, 18 Jan 2023 20:18:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674069506;
        bh=NUtoaUOXXBCb4O4OISOp0RPw4+o1avzzrDCkBQ+9ZBk=;
        h=From:To:Cc:Subject:Date:From;
        b=Xwl+sGMSXaw5AKSwfNyDNLMS7RWfe/vUf/AdKIbGtO12dte3Mh4Na4roSMe6eOvRv
         a/Wcj0Ry+svv2WUlDw+mBwgirt9ATalFLus0IAqXuMzO//K0bm505Ik4IkUOfyqrdP
         Kpcw5YjNHoI/4rD5ihNus1mbDtp6FnYEzNcafuFk=
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
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v4 0/6] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Thu, 19 Jan 2023 00:48:05 +0530
Message-Id: <20230118191811.208552-1-umang.jain@ideasonboard.com>
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

The main patch (6/6) is laregly unchanged from v3.
Specific details are elaborated in its commit message.

This series just introduces five extra patches for dropping include
directives from Makefiles (suggested by Greg KH) and rebased.

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
  vc04_services: bcm2835-audio: Drop include Makefile directive
  vc04_services: bcm2835-camera: Drop include Makefile directive
  vc04_services: vchiq-mmal: Drop include Makefile directive
  vc04_services: interface: Drop include Makefile directive
  staging: vc04_services: vchiq: Register devices with a custom bus_type

 drivers/staging/vc04_services/Makefile        |   2 -
 .../vc04_services/bcm2835-audio/Makefile      |   2 -
 .../vc04_services/bcm2835-audio/bcm2835.c     |  19 ++-
 .../vc04_services/bcm2835-audio/bcm2835.h     |   3 +-
 .../vc04_services/bcm2835-camera/Makefile     |   5 -
 .../bcm2835-camera/bcm2835-camera.c           |  27 ++--
 .../vc04_services/bcm2835-camera/controls.c   |   6 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 121 +++++++++++++++---
 .../interface/vchiq_arm/vchiq_arm.h           |   1 +
 .../interface/vchiq_arm/vchiq_core.h          |   2 +-
 .../interface/vchiq_arm/vchiq_ioctl.h         |   3 +-
 .../staging/vc04_services/vchiq-mmal/Makefile |   5 -
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   2 +-
 13 files changed, 131 insertions(+), 67 deletions(-)

-- 
2.39.0

