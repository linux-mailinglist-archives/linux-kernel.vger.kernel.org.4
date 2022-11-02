Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC477616396
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKBNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKBNP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:15:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D32233B6;
        Wed,  2 Nov 2022 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667394927; x=1698930927;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6iK9mY5qqDaeZWS9d2Uy0TPR3A7tuD5t2+NlvJr7Z1A=;
  b=QkZZGfrtm4ZOAhkOOY4OlevxqJmO6D4hAlSPCe1+u2FqRCqr3Tr9ufbP
   PHOZWjuYDAAMqhUOradFJRaocO7XzDL9hf8eA0Fws20LjMcxFv54WFmxO
   LWpfK4nknveJpt7TcpNFAD7E2NlB1ArmtV7CGwqI0mk5q79U7GwrTuV5+
   Sh4sIA26PSA/KR5v7iWTF4xxjsqpNRceIB3fXns84SRqO3kEJZ/qcbHYB
   il/ouYGkIGNGrocm5mHU+B7cGoIIzzl9V8tczl+DKg6vbt+Mcj5DQnzBH
   rP6BV389d5sgetO5uBqlNX56l5pZECN0f10bTwEcdETVGrHysTQLC3q6N
   w==;
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="187289360"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2022 06:15:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 2 Nov 2022 06:15:25 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 2 Nov 2022 06:15:23 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v11 0/6] media: atmel: atmel-isc: driver redesign
Date:   Wed, 2 Nov 2022 15:14:54 +0200
Message-ID: <20221102131500.476024-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is a continuation of the series that converts the atmel-isc driver
to media controller paradigm:
https://lore.kernel.org/lkml/20220503095127.48710-1-eugen.hristev@microchip.com/T/#mccad96a3122f2817bf1ae1db7eddf1a8cecb2749

As discussed on ML, the current Atmel ISC driver is moved to staging to keep the
existing users happy, and readded to platform/microchip under a different
Kconfig symbol and with the new media controller support which was reviewed in
v10.
I kept the original v10 patches on top of the movement of the driver
to make it more clear what the conversion to media controller brings.

Please let me know if this is okay or acceptable to take as it is,
and if it complies with the requirements for the subsystem/ABI breakage, etc.

Thanks to everyone for reviewing and helping in the discussions !

PLEASE NOTE: the series depends on the patch:
vb2: add support for (un)prepare_streaming queue ops
by Hans Verkuil

I have a different patch as the last in the series that uses the new callbacks
(and only that patch is dependant on the
vb2: add support for (un)prepare_streaming queue ops
)

Eugen

Changes in v11:
- moved atmel isc to staging
- created platform/microchip to host the new MICROCHIP_ISC driver
- it was natural to move the MICROCHIP_CSI2DC here
- on top, add the patches that move to media controller

Full series history:

Changes in v10:
-> split the series into this first fixes part.
-> moved IO_MC addition from first patch to the second patch on the driver changes
-> edited commit messages
-> DT nodes now disabled by default.

Changes in v9:
-> kernel robot reported isc_link_validate is not static, changed to static.

Changes in v8:
-> scaler: modified crop bounds to have the exact source size

Changes in v7:
-> scaler: modified crop bounds to have maximum isc size
-> format propagation: did small changes as per Jacopo review


Changes in v6:
-> worked a bit on scaler, added try crop and other changes as per Jacopo review
-> worked on isc-base enum_fmt , reworked as per Jacopo review

Changes in v5:
-> removed patch that removed the 'stop' variable as it was still required
-> added two new trivial patches
-> reworked some parts of the scaler and format propagation after discussions with Jacopo


Changes in v4:
-> as reviewed by Hans, added new patch to remove the 'stop' variable and reworked
one patch that was using it
-> as reviewed by Jacopo, reworked some parts of the media controller implementation


Changes in v3:
- change in bindings, small fixes in csi2dc driver and conversion to mc
for the isc-base.
- removed some MAINTAINERS patches and used patterns in MAINTAINERS

Changes in v2:
- integrated many changes suggested by Jacopo in the review of the v1 series.
- add a few new patches

Eugen Hristev (6):
  media: atmel: atmel-isc: move to staging
  media: atmel: move microchip_csi2dc to dedicated microchip platform
  media: microchip: re-add ISC driver as Microchip ISC
  media: microchip: microchip-isc: prepare for media controller support
  media: microchip: microchip-isc: implement media controller
  media: microchip: microchip-isc: move media_pipeline_* to (un)prepare
    cb

 MAINTAINERS                                   |    8 +-
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/atmel/Kconfig          |   51 -
 drivers/media/platform/atmel/Makefile         |    7 -
 drivers/media/platform/microchip/Kconfig      |   61 +
 drivers/media/platform/microchip/Makefile     |    9 +
 .../{atmel => microchip}/microchip-csi2dc.c   |    0
 .../platform/microchip/microchip-isc-base.c   | 2040 +++++++++++++++++
 .../microchip-isc-clk.c}                      |    4 +-
 .../platform/microchip/microchip-isc-regs.h   |  413 ++++
 .../platform/microchip/microchip-isc-scaler.c |  267 +++
 .../media/platform/microchip/microchip-isc.h  |  400 ++++
 .../microchip/microchip-sama5d2-isc.c         |  683 ++++++
 .../microchip/microchip-sama7g5-isc.c         |  646 ++++++
 drivers/staging/media/Kconfig                 |    2 +
 drivers/staging/media/Makefile                |    1 +
 drivers/staging/media/atmel/Kconfig           |   40 +
 drivers/staging/media/atmel/Makefile          |    8 +
 .../media}/atmel/atmel-isc-base.c             |   20 +-
 drivers/staging/media/atmel/atmel-isc-clk.c   |  311 +++
 .../media}/atmel/atmel-isc-regs.h             |    0
 .../media}/atmel/atmel-isc.h                  |   16 +-
 .../media}/atmel/atmel-sama5d2-isc.c          |   18 +-
 .../media}/atmel/atmel-sama7g5-isc.c          |   18 +-
 25 files changed, 4926 insertions(+), 99 deletions(-)
 create mode 100644 drivers/media/platform/microchip/Kconfig
 create mode 100644 drivers/media/platform/microchip/Makefile
 rename drivers/media/platform/{atmel => microchip}/microchip-csi2dc.c (100%)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-base.c
 rename drivers/media/platform/{atmel/atmel-isc-clk.c => microchip/microchip-isc-clk.c} (99%)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-regs.h
 create mode 100644 drivers/media/platform/microchip/microchip-isc-scaler.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc.h
 create mode 100644 drivers/media/platform/microchip/microchip-sama5d2-isc.c
 create mode 100644 drivers/media/platform/microchip/microchip-sama7g5-isc.c
 create mode 100644 drivers/staging/media/atmel/Kconfig
 create mode 100644 drivers/staging/media/atmel/Makefile
 rename drivers/{media/platform => staging/media}/atmel/atmel-isc-base.c (99%)
 create mode 100644 drivers/staging/media/atmel/atmel-isc-clk.c
 rename drivers/{media/platform => staging/media}/atmel/atmel-isc-regs.h (100%)
 rename drivers/{media/platform => staging/media}/atmel/atmel-isc.h (96%)
 rename drivers/{media/platform => staging/media}/atmel/atmel-sama5d2-isc.c (97%)
 rename drivers/{media/platform => staging/media}/atmel/atmel-sama7g5-isc.c (97%)

-- 
2.25.1

