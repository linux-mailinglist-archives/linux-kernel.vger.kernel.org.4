Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D623C655047
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiLWMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiLWMYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:24:23 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6CCE73;
        Fri, 23 Dec 2022 04:24:22 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:cd5d:4e48:3b91:9262:9565])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9A863492;
        Fri, 23 Dec 2022 13:24:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671798259;
        bh=YEyh1mjeF/yH078C3+GtKZk8cKm2HekK3uLm+cREVqY=;
        h=From:To:Cc:Subject:Date:From;
        b=O0DLmbnit8zZneZ8oY/ZSRJf7VdAiaUhT9xOB9hlHm3TxnNT5u/ZVodABQd8eoRZR
         glgtr48RP10g7BJhi5qdtu3u5by7DViUHYCl0WW+f1P1QZrXE+X1bM7MVquy83icp8
         swT0rDnxORHdGQgcsRUUYX+ius2JfR8y0QR/fpBo=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v3 0/7] staging: vc04_services: Remove custom return values
Date:   Fri, 23 Dec 2022 17:53:57 +0530
Message-Id: <20221223122404.170585-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
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

The series removes the custom return values from functions
and replaces them with linux error codes. This address the TODO
 vchiq interface:
* Get rid of custom function return values

Changes in v3:
- Drop fixes tag for 5/7 as suggested in review
- Add Tested-by: by Stefan Wahren to the series

Changes in V2:
- Patch 3/7 now reports for specific errors like -ENOMEM, -EHOSTDOWN
- Patch 5/7 reports -ENOTCONN instead of -EINVAL and adds a "Fixes" tag

Umang Jain (7):
  staging: vc04_services: Replace vchiq_status return type to int
  staging: vc04_services: Drop VCHIQ_SUCCESS usage
  staging: vc04_services: Drop VCHIQ_ERROR usage
  staging: vc04_services: Drop VCHIQ_RETRY usage
  vc04_services: vchiq_arm: Drop VCHIQ_RETRY usage on disconnect
  staging: vc04_services: Drop enum vchiq_status remnants
  staging: vc04_services: vchiq: Drop custom return values from TODO

 .../bcm2835-audio/bcm2835-vchiq.c             |  12 +-
 .../include/linux/raspberrypi/vchiq.h         |  65 +++---
 drivers/staging/vc04_services/interface/TODO  |   5 -
 .../interface/vchiq_arm/vchiq_arm.c           | 124 +++++-----
 .../interface/vchiq_arm/vchiq_arm.h           |  12 +-
 .../interface/vchiq_arm/vchiq_core.c          | 216 +++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          |  18 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  36 +--
 .../interface/vchiq_arm/vchiq_ioctl.h         |   8 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  11 +-
 10 files changed, 246 insertions(+), 261 deletions(-)

-- 
2.38.1

