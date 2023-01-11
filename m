Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCD6651CB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjAKCa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjAKCaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:30:22 -0500
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F536454;
        Tue, 10 Jan 2023 18:30:20 -0800 (PST)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 30B2TwA1014498; Wed, 11 Jan 2023 11:29:58 +0900
X-Iguazu-Qid: 34tKr4VoAszAJdXoLR
X-Iguazu-QSIG: v=2; s=0; t=1673404198; q=34tKr4VoAszAJdXoLR; m=8bLtgqRNkgqg8tD6WUM2OdKLS0pEeVAkXVzkZ+M1QOI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 30B2TuUW031688
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Jan 2023 11:29:56 +0900
X-SA-MID: 52825668
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v5 0/6] Add Toshiba Visconti Video Input Interface driver
Date:   Wed, 11 Jan 2023 11:24:27 +0900
X-TSB-HOP2: ON
Message-Id: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v4 patchset was sent with an incomplete recipient list.
Please ignore the v4 patchset.

This series is the Video Input Interface driver
for Toshiba's ARM SoC, Visconti[0].
This provides DT binding documentation,
device driver, documentation and MAINTAINER files.

A visconti VIIF driver instance exposes
1 media control device file and 3 video device files
for a VIIF hardware. 
Detailed HW/SW are described in documentation directory.
The VIIF hardware has CSI2 receiver,
image signal processor and DMAC inside.
The subdevice for image signal processor provides
vendor specific V4L2 controls.

The device driver depends on two other drivers under development;
clock framework driver and IOMMU driver.
Corresponding features will be added later.

Best regards,
Yuji

Changelog v2:
- Resend v1 because a patch exceeds size limit.

Changelog v3:
- Add documentation to describe SW and HW
- Adapted to media control framework
- Introduced ISP subdevice, capture device
- Remove private IOCTLs and add vendor specific V4L2 controls
- Change function name avoiding camelcase and uppercase letters

Changelog v4:
- Split patches because a patch exceeds size limit
- fix dt-bindings document
- stop specifying ID numbers for driver instance explicitly at device tree
- use pm_runtime to trigger initialization of HW
  along with open/close of device files.
- add a entry for a header file at MAINTAINERS file

Changelog v5:
- Fix coding style problem in viif.c (patch 2/6)

Yuji Ishikawa (6):
  dt-bindings: media: platform: visconti: Add Toshiba Visconti Video
    Input Interface bindings
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver user interace
  media: platform: visconti: Add Toshiba Visconti Video Input Interface
    driver v4l2 controls handler
  documentation: media: add documentation for Toshiba Visconti Video
    Input Interface driver
  MAINTAINERS: Add entries for Toshiba Visconti Video Input Interface

 .../bindings/media/toshiba,visconti-viif.yaml |   98 +
 .../driver-api/media/drivers/index.rst        |    1 +
 .../media/drivers/visconti-viif.rst           |  455 +++
 MAINTAINERS                                   |    4 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/visconti/Kconfig       |    9 +
 drivers/media/platform/visconti/Makefile      |    9 +
 drivers/media/platform/visconti/hwd_viif.c    | 1690 ++++++++++
 drivers/media/platform/visconti/hwd_viif.h    |  710 +++++
 .../media/platform/visconti/hwd_viif_csi2rx.c |  610 ++++
 .../platform/visconti/hwd_viif_internal.h     |  340 ++
 .../media/platform/visconti/hwd_viif_l1isp.c  | 2674 ++++++++++++++++
 .../media/platform/visconti/hwd_viif_reg.h    | 2802 +++++++++++++++++
 drivers/media/platform/visconti/viif.c        |  545 ++++
 drivers/media/platform/visconti/viif.h        |  203 ++
 .../media/platform/visconti/viif_capture.c    | 1201 +++++++
 .../media/platform/visconti/viif_controls.c   | 1153 +++++++
 drivers/media/platform/visconti/viif_isp.c    |  848 +++++
 include/uapi/linux/visconti_viif.h            | 1724 ++++++++++
 20 files changed, 15078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
 create mode 100644 Documentation/driver-api/media/drivers/visconti-viif.rst
 create mode 100644 drivers/media/platform/visconti/Kconfig
 create mode 100644 drivers/media/platform/visconti/Makefile
 create mode 100644 drivers/media/platform/visconti/hwd_viif.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_csi2rx.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_internal.h
 create mode 100644 drivers/media/platform/visconti/hwd_viif_l1isp.c
 create mode 100644 drivers/media/platform/visconti/hwd_viif_reg.h
 create mode 100644 drivers/media/platform/visconti/viif.c
 create mode 100644 drivers/media/platform/visconti/viif.h
 create mode 100644 drivers/media/platform/visconti/viif_capture.c
 create mode 100644 drivers/media/platform/visconti/viif_controls.c
 create mode 100644 drivers/media/platform/visconti/viif_isp.c
 create mode 100644 include/uapi/linux/visconti_viif.h

-- 
2.25.1


