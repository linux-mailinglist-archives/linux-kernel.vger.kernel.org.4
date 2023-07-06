Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41DC74A684
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGFWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGFWEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:04:01 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54818E1;
        Thu,  6 Jul 2023 15:04:00 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366IW2da030192;
        Thu, 6 Jul 2023 22:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=pbxXD15tS9VHaJWQvxuQ3WAQAm4H8Nd4pji2zUcKv28=;
 b=b+fQAu0h/ZaVsDMfTOqLwBCQC13bm9Hjm+IovN/Z6T9y3xsIpjghRfmwXqWkD4uBaesJ
 y+PGOGGmq0i1DJPyRTQtryGO9CAQCXOSIknhREKNTGR8mufqfert2HlzXtls9YCAlVVY
 8mPr5uCJhFEHEMSQks+1zplKvz/LUxgqf0m4VEACjHgute5O2i2XMQ4cntvdvq9lk5PP
 InwWLX939ajtt6q4iEQ2dW5sh3VeHJq7aHtwXgkyQQz7Hp7lhgzpMefCR3/hRxH99H8u
 5oOBZdZ9NfjVwTWHTBrVGGskimy+lIHGRoXJAfZEOdPZs88YIyjGoxyCIgZIVsL+V1XE hw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rp1qp1vdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 22:03:50 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 640CD8001AD;
        Thu,  6 Jul 2023 22:03:49 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A945E806B55;
        Thu,  6 Jul 2023 22:03:48 +0000 (UTC)
From:   richard.yu@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richard.yu@hpe.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Add USB driver for HPE GXP Architecture
Date:   Thu,  6 Jul 2023 16:59:07 -0500
Message-Id: <20230706215910.78772-1-richard.yu@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: U_aOznJ3rci9WXKjEcniat239OVZVlBl
X-Proofpoint-ORIG-GUID: U_aOznJ3rci9WXKjEcniat239OVZVlBl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=528 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307060193
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Yu <richard.yu@hpe.com>

The GXP vEHCI controller presents a four port EHCI compatible PCI function
to host software. Each EHCI port is logically connected to a
corresponding set of virtual device registers.

Richard Yu (3):
  dt-bindings: usb: Add HPE GXP UDCG Controller
  usb: gadget: udc: gxp-udc: add HPE GXP USB support
  MAINTAINERS: add USB support to GXP

 .../devicetree/bindings/usb/hpe,gxp-udcg.yaml |   70 +
 MAINTAINERS                                   |    2 +
 drivers/usb/gadget/udc/Kconfig                |    6 +
 drivers/usb/gadget/udc/Makefile               |    1 +
 drivers/usb/gadget/udc/gxp-udc.c              | 1401 +++++++++++++++++
 5 files changed, 1480 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/hpe,gxp-udcg.yaml
 create mode 100644 drivers/usb/gadget/udc/gxp-udc.c

-- 
2.17.1

