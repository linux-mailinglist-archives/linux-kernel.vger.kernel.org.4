Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5A671C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjARMfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjARMe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:34:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCE298F1;
        Wed, 18 Jan 2023 03:58:22 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [103.86.18.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 408671643;
        Wed, 18 Jan 2023 12:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674043099;
        bh=4ZkEehY0EKcMSSK/FWZM4yQ45U26CQ/uPHxtUY8/+Kw=;
        h=From:To:Cc:Subject:Date:From;
        b=mr0XK0dJNxcu3fFvP7C+BBGG9i618Wp2a6bHZ4j0KZhNxdYBGNuju4tgCE/dVaS5x
         vPradXpHtzLbV0a8YcUOCmv/JXCNWzYeUqGHYLkRfxp+CZoi9WUk3T7oNYeY+3lL//
         Zyx45aew3KRMeYAPPkqHCT1swWhfj2xxzQgXBMJw=
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
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [RFC PATCH 0/4] Drop custom logging
Date:   Wed, 18 Jan 2023 17:28:06 +0530
Message-Id: <20230118115810.21979-1-umang.jain@ideasonboard.com>
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

Drop custom logging from the vchiq interface.
Mostly of them are replaced with dev_dbg and friends
and/or pr_info and friends. 

The debugfs log levels (in 4/4) are mapped to kernel
logs levels (coming from include/linux/kern_levels.h)
Would like some thoughts on it as I am not sure (hence
marking this is RFC)

From drivers/staging/vc04_services/interface/TODO:

"""
* Cleanup logging mechanism

The driver should probably be using the standard kernel logging mechanisms
such as dev_info, dev_dbg, and friends.
"""

Umang Jain (4):
  staging: vc04_services: vchiq_core: Drop custom logging
  staging: vc04_services: vchiq_arm: Drop custom logging
  staging: vc04_services: Drop custom logging
  staging: vc04_services: Drop remnants of custom logging

 .../interface/vchiq_arm/vchiq_arm.c           | 151 +++---
 .../interface/vchiq_arm/vchiq_connected.c     |   5 +-
 .../interface/vchiq_arm/vchiq_core.c          | 479 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.h          |  39 --
 .../interface/vchiq_arm/vchiq_debugfs.c       |  26 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  78 ++-
 6 files changed, 329 insertions(+), 449 deletions(-)

-- 
2.39.0

