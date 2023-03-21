Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900F66C355B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjCUPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjCUPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:17:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB22DE75;
        Tue, 21 Mar 2023 08:17:09 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEgR3l030268;
        Tue, 21 Mar 2023 15:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QTxotmzrlXNRr8X9T7oj76bVx52qD66MadcVuPYWFSk=;
 b=tgAhISlZUuQl7jb6ePP5Ao1QCLF+FIpTo8MCQm4Yj5YA8ycncVK7Bz4t/nCsEi/Q/ipN
 Y1PgdpjKVOp4MOk5anstUVpLndCW92xOq0rG5U49XXA8zMdqmg26PX7KavlHSRpmVEEs
 E9P/6Cq9uk/4bV03TW/IMZNz1OvbsbMn2cg6h/Iz1osSVE3fUq7U2daofSSaPKpwfVdo
 /RU6Ttz/6SF6NKPnaG8I8tko25p+rNhCjer2b8Tl4OKMEwvzfUuOwARLzZRxxItzgIH2
 X05I/RmQj9ZjJt4PgvYVvm+rwhiTEvZgqiPHs4TahlRv1XFhOwBQahs9CnYX8yCq3S0+ mg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf85y394n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:50 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LE1a17000573;
        Tue, 21 Mar 2023 15:16:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7fync-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:16:49 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LFGlaf25559754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:16:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 989DE5804B;
        Tue, 21 Mar 2023 15:16:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B26558068;
        Tue, 21 Mar 2023 15:16:46 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.111.39])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 15:16:45 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 0/4] eeprom: ee1004: Enable devices on multiple busses
Date:   Tue, 21 Mar 2023 10:16:38 -0500
Message-Id: <20230321151642.461618-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mnS2_M6JxjQXPDdoywMzQCEA4PKjviAa
X-Proofpoint-GUID: mnS2_M6JxjQXPDdoywMzQCEA4PKjviAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=737 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210118
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver previously prevented probing devices on more than one
bus due to locking constraints with the special page addresses. This
constraint can be removed by allocating a reference-counted bus
structure containing the lock, rather than using global variables.
In addition, add devicetree bindings for the EE1004 driver for the
AT30TSE device and add the devices to the Bonnell BMC system.

Changes since v1:
 - Add the devicetree changes

Eddie James (4):
  eeprom: ee1004: Enable devices on multiple busses
  doc: Add Atmel AT30TSE serial eeprom
  eeprom: ee1004: Add devicetree binding
  ARM: dts: aspeed: bonnell: Add DIMM SPD

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  |  20 ++
 drivers/misc/eeprom/ee1004.c                  | 182 +++++++++++-------
 3 files changed, 135 insertions(+), 69 deletions(-)

-- 
2.31.1

