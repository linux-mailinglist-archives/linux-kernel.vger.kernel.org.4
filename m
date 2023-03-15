Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09826BBB13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjCORlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCORlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:41:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D75D77D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:41:00 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FGgCDX023685
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=epm1+1DDOXVk+ZIm2pMODSagDpdfV7R0PSx0CR3k1aM=;
 b=s7S/mDTR6/QJk7uDxgYf7W4BRMb3ZZalMuvC1BMWt7Dz1l1/6ERD+bi2CmGDY9+UYcP1
 CmkhASPmOTauaqHn5YWjzY2ZXGYdWc2+o3mC3u57Nimr6Qi8wfEKsL/wjFtc1r5Vtgr9
 hHHsPv5d6joHeHGS0vh0uiujBu8tcVdkrvD2EqkDnJCcGYdB5GUmT3U2RzL10+O4qJIe
 ymTp4Tm8D0CDgG53/uUzIYSqSEZ2cJ71aGBAvrGhZt8q5kqi38w30hlOvAGhH7Ckgd9r
 DgHYteofkWhir47vGjzR48OMgMCD/VfBmy0ihbIV3rlS68+EGPvoy+UGSg3B2W2p5qN9 Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02tdat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:40:59 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32FGgOFY024273
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 17:40:59 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pbh02tdaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:40:59 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32FHBuUR019893;
        Wed, 15 Mar 2023 17:40:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pb29svg64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:40:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32FHeuaX46334526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 17:40:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F7695805E;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5153658059;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 17:40:56 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id B6F9974A47B; Wed, 15 Mar 2023 12:40:55 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>, ylakshmi@yahoo.com
Subject: [PATCH 0/4] Review request for Acbel PSU driver
Date:   Wed, 15 Mar 2023 12:40:23 -0500
Message-Id: <20230315174027.3540015-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O-qSnzkBLY63yRtYEZammVd54GC4H8Z0
X-Proofpoint-GUID: G5ycemIFnt9W3zFQRx9rVCqkM1B9bO5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_08,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=664 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150142
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Acbel PSU driver for Power Supply. Update the device tree with correct
device address.

Lakshmi Yadlapati (4):
  dt-bindings: vendor-prefixes: Add prefix for acbel
  dt-bindings: trivial-devices: Add acbel,crps
  hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
  ARM: dts: aspeed: p10bmc: Change power supply info

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  |  12 +-
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/acbel-crps.c              | 311 ++++++++++++++++++
 6 files changed, 331 insertions(+), 6 deletions(-)
 create mode 100644 drivers/hwmon/pmbus/acbel-crps.c

-- 
2.37.2

