Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71D66E4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjAQRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjAQRSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:18:31 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB4B4C6CE;
        Tue, 17 Jan 2023 09:17:09 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HEDddV012339;
        Tue, 17 Jan 2023 09:17:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=QPocXsN0YQ0WwsUk6Qr09CNN0rMBP8kKjtIb1brAwbE=;
 b=HjkXP2l/3ghREQZ6RwprDPm/f4ZMaEh5fn4IOZGTVVzHYcx1yW0vJ3wKwNTlxgLKPDaS
 jbB+VInx3HiZ4NCsp67Y0xuQtsYXP4oQuQVJeR+KBGfRz+NWjXX1P9XlJtegtFGc8bNI
 oF6NNlEZlx2RDIhWZ5cfMgIdXo+/W2u3p7pj4SRTPnfhpBApk7mCytEM2Q7Tw99XG4L/
 ZV/bq7GWSPHpQJiTS0DZPRAbU5/9uCawwomdNj1OKol4Tl7ofFtB5cUc1hEDpg3CROOh
 0nEKLZI28WK/mJkHAkhNBluTMPdg4wZkB5giRpSwdA4mxjBC4J3yABq4XBlPhMO6R9Lq Vg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3n5by4uud4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:17:00 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 17 Jan
 2023 09:16:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Tue, 17 Jan 2023 09:16:58 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 4EC2B3F704C;
        Tue, 17 Jan 2023 09:16:58 -0800 (PST)
From:   Wojciech Zmuda <wzmuda@marvell.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <sgoutham@marvell.com>,
        <devicetree@vger.kernel.org>, Wojciech Zmuda <wzmuda@marvell.com>
Subject: [PATCH v4 0/2] Add support for Marvell MHU on OcteonTX and OcteonTX2
Date:   Tue, 17 Jan 2023 09:16:33 -0800
Message-ID: <20230117171635.16739-1-wzmuda@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WgOqHXn6WkwMhcBd_H1EYy6xHAhHY3Kw
X-Proofpoint-ORIG-GUID: WgOqHXn6WkwMhcBd_H1EYy6xHAhHY3Kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support ARM SCMI for the Marvell OcteonTX and OcteonTX2 SoC,
add a generic platform MHU driver based loosely on arm_mhu.c and pcc.c.

There is deliberately no interrupt in DT because interrupts are not
configurable on the device level. This is the responsibility of the
PCIe ECAM, since the MHU is a PCIe device.

v3->v4:
- Fix DT bindings to make dt_binding_check happy
- Shorten driver's commit message 

v2->v3:
- Unify SoC naming used throughout the patch set
- Drop 'driver' from patches titles and use correct prefix for bindings
- Add detailed and extensible compatible matching (with SoC models)
- Rename driver from mvl-mhu to marvell-mhu
- DT bindings:
  - Fix typos, indentation, reorder properties, use lowercase hex
  - Drop usage example in the firmware/scmi node

v1->v2:
- Clean up
- Rebase on 6.1
- Remove PCI interrupts

Wojciech Bartczak (1):
  mailbox: marvell-mhu: add Marvell MHU

Wojciech Zmuda (1):
  dt-bindings: mailbox: add Marvell MHU

 .../bindings/mailbox/marvell,mhu.yaml         |  62 ++++
 MAINTAINERS                                   |   9 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/marvell_mhu.c                 | 295 ++++++++++++++++++
 5 files changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mhu.yaml
 create mode 100644 drivers/mailbox/marvell_mhu.c

-- 
2.17.1

