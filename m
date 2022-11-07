Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDF61F5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiKGOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiKGOXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:23:18 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9EE1DDCB;
        Mon,  7 Nov 2022 06:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1667830741; x=1699366741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yDK/Vb+LhFqHhr75U15YJEc8D800niwmg+d808R1TtY=;
  b=nteKGCJXWRQJ8xlTjvuc41jZDfTCawsvkqdIWW+HqCCHEHlY4Dx5G81L
   mH1v4bjcMSZv6Zh1dV4/O9OYl7a/1vPTQslzhhFFei8wBj1enCrdVCTTv
   F6TyujI9J6wlNm7abkfk0cz5/cEPfSYp85/Kfr5/TwRsPLMUeUk3yRLIL
   LlqWQ3aIYuNHFCf43BpmyfBzifeUg5/p9CeYLCcajwUMJy9KYUOxt2Jxl
   P7DUWU9VqrKhhNIZq0leiIuc2gnNTDTlio8FX/vPXlbpAyfxnLHiho7XK
   4tIGd1XvmjMEJ9FiqxMBWQiKxNnBJBi9wfZHLeQH8eS1a991BOUQqhaVc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="122165280"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Nov 2022 07:18:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 7 Nov 2022 07:18:27 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 7 Nov 2022 07:18:26 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <jacopo@jmondi.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v12 0/6] media: atmel: atmel-isc: driver redesign
Date:   Mon, 7 Nov 2022 16:18:12 +0200
Message-ID: <20221107141818.104937-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v12:
- moved patch 'move to staging' as last patch in the series
- renamed exported symbols by Microchip ISC by adding prefix microchip_
- added TODO in staging dir
- make old ISC kconfigs dependant to !VIDEO_MICROCHIP_ISC_BASE
- move to staging deprecated dir

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
  media: atmel: move microchip_csi2dc to dedicated microchip platform
  media: microchip: add ISC driver as Microchip ISC
  media: microchip: microchip-isc: prepare for media controller support
  media: microchip: microchip-isc: implement media controller
  media: microchip: microchip-isc: move media_pipeline_* to (un)prepare
    cb
  media: atmel: atmel-isc: move to staging

 MAINTAINERS                                   |    8 +-
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/atmel/Kconfig          |   51 -
 drivers/media/platform/atmel/Makefile         |    7 -
 drivers/media/platform/microchip/Kconfig      |   61 +
 drivers/media/platform/microchip/Makefile     |    9 +
 .../{atmel => microchip}/microchip-csi2dc.c   |    0
 .../platform/microchip/microchip-isc-base.c   | 2040 +++++++++++++++++
 .../platform/microchip/microchip-isc-clk.c    |  311 +++
 .../platform/microchip/microchip-isc-regs.h   |  413 ++++
 .../platform/microchip/microchip-isc-scaler.c |  267 +++
 .../media/platform/microchip/microchip-isc.h  |  400 ++++
 .../microchip/microchip-sama5d2-isc.c         |  683 ++++++
 .../microchip/microchip-sama7g5-isc.c         |  646 ++++++
 drivers/staging/media/Kconfig                 |    1 +
 drivers/staging/media/Makefile                |    1 +
 .../staging/media/deprecated/atmel/Kconfig    |   48 +
 .../staging/media/deprecated/atmel/Makefile   |    8 +
 drivers/staging/media/deprecated/atmel/TODO   |   34 +
 .../media/deprecated}/atmel/atmel-isc-base.c  |   20 +-
 .../media/deprecated}/atmel/atmel-isc-clk.c   |    8 +-
 .../media/deprecated}/atmel/atmel-isc-regs.h  |    0
 .../media/deprecated}/atmel/atmel-isc.h       |   16 +-
 .../deprecated}/atmel/atmel-sama5d2-isc.c     |   18 +-
 .../deprecated}/atmel/atmel-sama7g5-isc.c     |   18 +-
 26 files changed, 4969 insertions(+), 101 deletions(-)
 create mode 100644 drivers/media/platform/microchip/Kconfig
 create mode 100644 drivers/media/platform/microchip/Makefile
 rename drivers/media/platform/{atmel => microchip}/microchip-csi2dc.c (100%)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-base.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-clk.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-regs.h
 create mode 100644 drivers/media/platform/microchip/microchip-isc-scaler.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc.h
 create mode 100644 drivers/media/platform/microchip/microchip-sama5d2-isc.c
 create mode 100644 drivers/media/platform/microchip/microchip-sama7g5-isc.c
 create mode 100644 drivers/staging/media/deprecated/atmel/Kconfig
 create mode 100644 drivers/staging/media/deprecated/atmel/Makefile
 create mode 100644 drivers/staging/media/deprecated/atmel/TODO
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-base.c (99%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-clk.c (97%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc-regs.h (100%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-isc.h (96%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-sama5d2-isc.c (97%)
 rename drivers/{media/platform => staging/media/deprecated}/atmel/atmel-sama7g5-isc.c (97%)

-- 
2.25.1

