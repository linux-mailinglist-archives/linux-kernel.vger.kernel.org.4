Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E16C49A9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCVLsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjCVLrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:47:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF975F508;
        Wed, 22 Mar 2023 04:46:58 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MAsxwf002959;
        Wed, 22 Mar 2023 11:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=dZ+GWmu9cShh4GeksVkeA/F5IobOJwM8aSTseVzsKAk=;
 b=hAVcabN9HjaoGyza5gkminXPR/atzNCeYCxZF2bICe14DcC4NlIF2Zdy6zC3Vf3ucZj8
 m/GbJ7TfAsNx3Ar6wVsEu9HSbOfxBBtWCZ/CDktfCfubKo7CKDSTUxJh8IddCjwEuVoo
 D5IHoAuo3pAGRpfXb6RBf7q9q7YmyBE6YwjSEjSwYMz9O9i+8jaBkdR9Ec4CnhWzg/sJ
 aW5+QHgsAG9Plzii5qEWlRUpcnUlIIo0a/KILW6ulm96S2HFGKpk/nJaLjr2QUuGvDu8
 Ia3ZBBguwfqtBpp5VtMx89c5akxUD1DcCi/2spGl1KJLjD4EKkBeu2ieLGdTiQ7rex0x bA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg0bg18sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:32 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MBcwmr010269;
        Wed, 22 Mar 2023 11:46:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7dyx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:46:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MBkUV916188062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 11:46:30 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 203535805C;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 112C758051;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Mar 2023 11:46:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id C3A5C74A47B; Wed, 22 Mar 2023 06:46:29 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v4 0/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Wed, 22 Mar 2023 06:46:18 -0500
Message-Id: <20230322114623.2278920-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JMldajCU3-wha4aQ2cz1xSUh2i5qvhWS
X-Proofpoint-ORIG-GUID: JMldajCU3-wha4aQ2cz1xSUh2i5qvhWS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_08,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=648 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220082
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new acbel,fsg032 driver and documentation updates.

Changes since V3:
-Fixed trivial-devices.yaml 

Lakshmi Yadlapati (5):
  dt-bindings: vendor-prefixes: Add prefix for acbel
  dt-bindings: trivial-devices: Add acbel,fsg032
  hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
  docs: hwmon: Add documentaion for acbel-fsg032 PSU
  ARM: dts: aspeed: p10bmc: Change power supply info

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 Documentation/hwmon/acbel-fsg032.rst          | 80 ++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  | 12 +--
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/acbel-fsg032.c            | 96 +++++++++++++++++++
 8 files changed, 197 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/hwmon/acbel-fsg032.rst
 create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c

-- 
2.37.2

