Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACD6183D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiKCQI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiKCQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:08:02 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2298186CE;
        Thu,  3 Nov 2022 09:08:00 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3G58fH032335;
        Thu, 3 Nov 2022 16:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=+aiS1pjwEHcEX1Zp6i3H1B9SfrKa5wgk5D2pcFH54k4=;
 b=SwRTk503W29eD7VvZMX4b2OHMxVTTbXun9r6c20s3m2cD1hWFLOvH15RTvnrysEu/Wnz
 UM24MW54ePBsyLaJSKyD8Wz+koNRjr9P2rMduab8apR21T2gXpdkdTLBj3cgQYcKHMCk
 6buvzCA+E8H3FD1lSxg4il5ykXXS9k+yJOD6GCJK8EuOGDUSxsoytxejEcizrAddGvMb
 uRJYjTAB15QX6w6omVcpaXamA3YeKJFpzsoKWW27eoa9y2RVVzOWCG6+Su0Fvtx5pEPH
 H2y8AqApSf4SvodSx87Gmc6eeKYJqMCVzy33sO2Nd8wqK7mbjWES1EAe8Uh3Ppdj4bmu MA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kmg470byu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:07:33 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CAFA5295B6;
        Thu,  3 Nov 2022 16:07:32 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id DE4448036BB;
        Thu,  3 Nov 2022 16:07:31 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, richard.yu@hpe.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        balbi@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/7] Add USB Driver for HPE GXP Architecture
Date:   Thu,  3 Nov 2022 11:06:18 -0500
Message-Id: <20221103160625.15574-1-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: bZl2FMsLGf_4V0Yh9k8kVtQo6Fqi2g3Z
X-Proofpoint-ORIG-GUID: bZl2FMsLGf_4V0Yh9k8kVtQo6Fqi2g3Z
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=417
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030107
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

The GXP vEHCI controller presents an 8 port EHCI compatible PCI function
to host software. Each EHCI port is logically connected to a
corresponding set of virtual device registers.

Richard Yu (7):
  usb: gadget: udc: gxp_udc: add gxp USB support
  dt-bindings: usb: hpe,gxp-udc: Add binding for gxp gadget
  dt-bindings: usb: hpe,gxp-udcg: Add binding for gxp gadget group
  dt-bindings: usb: hpe,gxp-vuhc: add binding for gxp vEHCI
  ARM: dts: hpe: Add UDC nodes
  ARM: configs: multi_v7_defconfig: Enable HPE GXP USB Driver
  MAINTAINERS: add USB support to GXP

 .../devicetree/bindings/usb/hpe,gxp-udc.yaml  |   57 +
 .../devicetree/bindings/usb/hpe,gxp-udcg.yaml |   34 +
 .../devicetree/bindings/usb/hpe,gxp-vuhc.yaml |   34 +
 MAINTAINERS                                   |    5 +
 arch/arm/boot/dts/hpe-gxp.dtsi                |   30 +
 arch/arm/configs/multi_v7_defconfig           |    1 +
 drivers/usb/gadget/udc/Kconfig                |    6 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/gxp_udc.c              | 1300 +++++++++++++++++
 9 files changed, 1468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udc.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-vuhc.yaml
 create mode 100644 drivers/usb/gadget/udc/gxp_udc.c

-- 
2.17.1

