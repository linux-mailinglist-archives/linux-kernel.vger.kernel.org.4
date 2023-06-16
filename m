Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A617326D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjFPFvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPFvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:51:16 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089F270C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:51:15 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11E502006E5;
        Fri, 16 Jun 2023 07:43:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7A1A20029D;
        Fri, 16 Jun 2023 07:43:01 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D5891820F57;
        Fri, 16 Jun 2023 13:43:00 +0800 (+08)
From:   Alison Wang <alison.wang@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     leoyang.li@nxp.com, xuelin.shi@nxp.com, xiaofeng.ren@nxp.com,
        feng.guo@nxp.com
Subject: [PATCH 0/8] ethosu: Add Arm Ethos-U driver 
Date:   Fri, 16 Jun 2023 13:59:05 +0800
Message-Id: <20230616055913.2360-1-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.

Ethos-U Linux driver is to provide an example of how a rich operating
system like Linux can dispatch inferences to an Arm Cortex-M subsystem,
consisting of an Arm Cortex-M and an Arm Ethos-U NPU.

----------------------------------------------------------------
Alison Wang (8):
      ethosu: Add Arm Ethos-U driver
      ethosu: Use RPMsg messaging protocol based on i.MX Rpmsg implementation
      ethosu: Add inference type option for model and op
      ethosu: Add suspend/resume power management
      ethosu: Use ids for identifying messages sent to Ethos-U firmware
      ethosu: Add core message about network info
      ethosu: Add core message about inference cancellation
      ethosu: Add rwlock when alloc and remove msg id

 drivers/firmware/Kconfig                          |   1 +
 drivers/firmware/Makefile                         |   1 +
 drivers/firmware/ethosu/Kconfig                   |  24 ++++
 drivers/firmware/ethosu/Makefile                  |  31 +++++
 drivers/firmware/ethosu/ethosu_buffer.c           | 319 +++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_buffer.h           | 106 +++++++++++++++
 drivers/firmware/ethosu/ethosu_cancel_inference.c | 185 +++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_cancel_inference.h |  55 ++++++++
 drivers/firmware/ethosu/ethosu_capabilities.c     | 157 ++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_capabilities.h     |  47 +++++++
 drivers/firmware/ethosu/ethosu_core_interface.h   | 276 ++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_device.c           | 404 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_device.h           |  81 +++++++++++
 drivers/firmware/ethosu/ethosu_driver.c           | 201 +++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_inference.c        | 529 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_inference.h        | 125 +++++++++++++++++
 drivers/firmware/ethosu/ethosu_network.c          | 229 +++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_network.h          |  84 ++++++++++++
 drivers/firmware/ethosu/ethosu_network_info.c     | 184 +++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_network_info.h     |  56 ++++++++
 drivers/firmware/ethosu/ethosu_rpmsg.c            | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ethosu/ethosu_rpmsg.h            | 155 +++++++++++++++++++++
 drivers/firmware/ethosu/uapi/ethosu.h             | 285 +++++++++++++++++++++++++++++++++++++++
 23 files changed, 3949 insertions(+)
 create mode 100644 drivers/firmware/ethosu/Kconfig
 create mode 100644 drivers/firmware/ethosu/Makefile
 create mode 100644 drivers/firmware/ethosu/ethosu_buffer.c
 create mode 100644 drivers/firmware/ethosu/ethosu_buffer.h
 create mode 100644 drivers/firmware/ethosu/ethosu_cancel_inference.c
 create mode 100644 drivers/firmware/ethosu/ethosu_cancel_inference.h
 create mode 100644 drivers/firmware/ethosu/ethosu_capabilities.c
 create mode 100644 drivers/firmware/ethosu/ethosu_capabilities.h
 create mode 100644 drivers/firmware/ethosu/ethosu_core_interface.h
 create mode 100644 drivers/firmware/ethosu/ethosu_device.c
 create mode 100644 drivers/firmware/ethosu/ethosu_device.h
 create mode 100644 drivers/firmware/ethosu/ethosu_driver.c
 create mode 100644 drivers/firmware/ethosu/ethosu_inference.c
 create mode 100644 drivers/firmware/ethosu/ethosu_inference.h
 create mode 100644 drivers/firmware/ethosu/ethosu_network.c
 create mode 100644 drivers/firmware/ethosu/ethosu_network.h
 create mode 100644 drivers/firmware/ethosu/ethosu_network_info.c
 create mode 100644 drivers/firmware/ethosu/ethosu_network_info.h
 create mode 100644 drivers/firmware/ethosu/ethosu_rpmsg.c
 create mode 100644 drivers/firmware/ethosu/ethosu_rpmsg.h
 create mode 100644 drivers/firmware/ethosu/uapi/ethosu.h



