Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A61654668
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLVTPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLVTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:15:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE327CD8;
        Thu, 22 Dec 2022 11:15:15 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3f:d076:4da6:b729:f032:ed0a])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C1F7471;
        Thu, 22 Dec 2022 20:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671736512;
        bh=YxPVSern8c6BOEbRmDUoR5qKPKTaeKpaIusaimppST4=;
        h=From:To:Cc:Subject:Date:From;
        b=WLz96d20tboBXh4/SZ/mHDETiyar8Zei97l2GZiDWT7ud/bfHm0LqXhECgTmRGMUH
         HITUHkf9W54ihP0lIBKDgsVM9aPgTJVu65qxQqPb9n83lJDgJmQpMSu3KqOttrFl3k
         VdAQ5qRiJDzYFoCRGzk0E7pIK9OfljNF6YEHWaCA=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/4] staging: vchiq: Rework child platform device (un)register
Date:   Fri, 23 Dec 2022 00:44:56 +0530
Message-Id: <20221222191500.515795-1-umang.jain@ideasonboard.com>
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

V2 series for addressing the TODO item:
        "Get rid of all non essential global structures and create a proper
         per device structure"
This series:
- Fixes a platform device leak (1/4)
- Simplifies vchiq_register_child (2/4 and 3/4)
- drops global references for child platform devices and prepares for
  addition of new child devices in future (4/4)

v1: https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/

Umang Jain (4):
  staging: vc04_services: Stop leaking platform device on error path
  staging: vchiq: Do not assign default dma_mask explicitly
  staging: vchiq: Simplify platform devices registration
  staging: vchiq: Rework child platform device (un)register

 .../interface/vchiq_arm/vchiq_arm.c           | 40 ++++++++++---------
 1 file changed, 21 insertions(+), 19 deletions(-)

-- 
2.38.1

