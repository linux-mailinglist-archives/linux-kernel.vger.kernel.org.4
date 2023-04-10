Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE86DC262
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDJBpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjDJBpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:45:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5D42D6B;
        Sun,  9 Apr 2023 18:45:08 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33A00NfE016881;
        Mon, 10 Apr 2023 01:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/eDvJ3WwsVIP7TqIRtcgiu0u9rMhXfcn1cdYtBrkOOo=;
 b=hbYChiNaPLIB2CXyT8j6W+77vRKeFQX0veo225dL56KrEgPN8BAUvtRV70ZgV1KFMEu9
 3LpA90c+SnU050pAQtUsNRradq8cF2AzDHGJLgSKqan6/F3NN8nanUBH5svz3ANidHNs
 euAKmQXbfL7t9/vJaV73fVOAojbedihyjjyhtNb9N/k2QV+wB2cWW8/hgiAdyWz9g5iP
 70aNbBmkMtNPr8MOhVVZGbkf3ryMunQyiUlOF1YfkdbE0zAhzeyPh8L8DYPbx1mvIQfs
 ldCIkDe0yQGuA55Gvos7hybE5hJCs6f/MmQeFzhFz9KfuTdvbirP/OJQ7p6tWLnEQ3x/ tw== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3puj5m2nb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:04 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 339Nwavq012404;
        Mon, 10 Apr 2023 01:45:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3pu0f9gaep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 01:45:03 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33A1j2EV17760728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 01:45:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E764258059;
        Mon, 10 Apr 2023 01:45:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7E0258043;
        Mon, 10 Apr 2023 01:45:01 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Apr 2023 01:45:01 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 466CB74514B; Sun,  9 Apr 2023 20:45:01 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v5 0/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Sun,  9 Apr 2023 20:44:40 -0500
Message-Id: <20230410014445.458385-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0hGy1wwVuXqB8N3XHg25Lg7_1T_TPFo
X-Proofpoint-ORIG-GUID: C0hGy1wwVuXqB8N3XHg25Lg7_1T_TPFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-09_18,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=740 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304100011
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new acbel,fsg032 driver and documentation updates.

Changes since V4:
Removed unused structure acbel_fsg032 and psu allocation.

Lakshmi Yadlapati (5):
  dt-bindings: vendor-prefixes: Add prefix for acbel
  dt-bindings: trivial-devices: Add acbel,fsg032
  hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
  docs: hwmon: Add documentaion for acbel-fsg032 PSU
  ARM: dts: aspeed: p10bmc: Change power supply info

 .../devicetree/bindings/trivial-devices.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 Documentation/hwmon/acbel-fsg032.rst          | 80 +++++++++++++++++
 Documentation/hwmon/index.rst                 |  1 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  | 12 +--
 drivers/hwmon/pmbus/Kconfig                   |  9 ++
 drivers/hwmon/pmbus/Makefile                  |  1 +
 drivers/hwmon/pmbus/acbel-fsg032.c            | 85 +++++++++++++++++++
 8 files changed, 186 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/hwmon/acbel-fsg032.rst
 create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c

-- 
2.37.2

