Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154C46C1A36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjCTPts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjCTPtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0943238468;
        Mon, 20 Mar 2023 08:40:56 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFBrOt032652;
        Mon, 20 Mar 2023 15:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+oDfw6Mvr0wKvxX614yC01eUxBJ7vNlpY3tgso6PD0o=;
 b=YGjZHsQzfHiXytdfDyuMX3jbCpFHSQa8mA8wVBtDvKFwfLYkcE7tOmJYrPxzbLkClRKB
 pow4HkvfPqdIn2e1uBJr5rRmLX+qbYZjMU21TXh1hdOsi0cgACpL0x+mJI6vSTZAVZ+y
 auTLGOQmAeNe+1CJw7rcsRlphxFHvzSD6+Z55Z4LzUsi1k2C98GelB9kAQpeK+RvWyeu
 5O+oGWwxhwohAHJQwO1L0RB8LZy25Nv5soUTMzjS7CYmV8dSP7lU7se8kWVXkbxh/Tgx
 fhl/5uVEQGDJkoULTZXa5xNEbGxQttYUNe6yIbwZZbY+1KxpdCEeYt+O1fCv6rdk5Dr3 Gw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3per8vc618-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:34 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KEb7P0020743;
        Mon, 20 Mar 2023 15:40:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pd4x70vk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 15:40:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32KFeVom49479942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Mar 2023 15:40:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8231258061;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7385F5805A;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 20 Mar 2023 15:40:31 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 0D97374A47B; Mon, 20 Mar 2023 10:40:31 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v2 0/5] hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
Date:   Mon, 20 Mar 2023 10:40:14 -0500
Message-Id: <20230320154019.1943770-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SbK7iQFwdb6SfQbYG9MrFth5Jgaz4ypR
X-Proofpoint-ORIG-GUID: SbK7iQFwdb6SfQbYG9MrFth5Jgaz4ypR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_12,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=708 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303200128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new acbel,crps driver and documentation updates.

Changes since V1:
- New patch added for documentation.
- Fix acbel,crps drives as per review comments.

Lakshmi Yadlapati (5):
  dt-bindings: vendor-prefixes: Add prefix for acbel
  dt-bindings: trivial-devices: Add acbel,crps
  hwmon: (pmbus/acbel-crps) Add Acbel CRPS power supply driver
  docs: hwmon: Add documenttaion for acbel-crps PSU
  ARM: dts: aspeed: p10bmc: Change power supply info

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/hwmon/acbel-crps.rst            |  81 ++++++++++++++
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  |  12 +--
 drivers/hwmon/pmbus/Kconfig                   |  10 ++
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/acbel-crps.c              | 102 ++++++++++++++++++
 7 files changed, 204 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/hwmon/acbel-crps.rst
 create mode 100644 drivers/hwmon/pmbus/acbel-crps.c

-- 
2.37.2

