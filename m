Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0364D6EC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLOHFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiLOHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:04:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69575FB9A;
        Wed, 14 Dec 2022 22:59:10 -0800 (PST)
Received: from umang.jainideasonboard.com (unknown [IPv6:2401:4900:1f3e:7d24:3f0:3e81:fb16:ab4d])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 312A44D5;
        Thu, 15 Dec 2022 07:59:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671087548;
        bh=RngX/iK1q3MPQdqSLGAYLK2c1bMLyu75yAOqBHRU8M4=;
        h=From:To:Cc:Subject:Date:From;
        b=Cp1vE3QHXqJpFku2pW2wJl4PZN985abL3hJ1u4/MM5RgsalktePX1s2v/xcGl8Rfq
         E4YQXklqSG/fKt/w0+EbqkGsSzDfOxTXpj/Jsyxdbk+Ra4nA3RMGJ238RlJK98+tmQ
         jsrpwEOiUghhHgL5t0nD9Ym9X7z37fC+1/glC4Bg=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
Subject: [PATCH 0/7] staging: vc04_services: Remove custom return values
Date:   Thu, 15 Dec 2022 12:28:46 +0530
Message-Id: <20221215065853.34477-1-umang.jain@ideasonboard.com>
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
 .../interface/vchiq_arm/vchiq_arm.c           | 122 +++++-----
 .../interface/vchiq_arm/vchiq_arm.h           |  12 +-
 .../interface/vchiq_arm/vchiq_core.c          | 216 +++++++++---------
 .../interface/vchiq_arm/vchiq_core.h          |  18 +-
 .../interface/vchiq_arm/vchiq_dev.c           |  36 +--
 .../interface/vchiq_arm/vchiq_ioctl.h         |   8 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |  11 +-
 10 files changed, 245 insertions(+), 260 deletions(-)

-- 
2.38.1

