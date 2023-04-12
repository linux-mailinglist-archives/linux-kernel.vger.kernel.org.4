Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC86DEB01
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLFXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDLFXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFAF4206;
        Tue, 11 Apr 2023 22:23:38 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C56K4i008891;
        Wed, 12 Apr 2023 05:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FlveTLfKfAp3T97T+Uhfr6f+3ORbmr8oIGL9LArLs/I=;
 b=NF+fpGcYwg8EPrX7UwY6vSxU83tnTofA0WgY3HMm96DAi6/YEYM7PGSbt8PyFVO2+DCW
 Xv/qwhCbiQqlcIfYS3cqk9wxglZAYMElFXBPi4W6hofW7wdBpKSP+3JihCe2ysFjBuAL
 zf9dgNZnneJYd9WEp5Tb7YEMc5xVmdhngWuUJVKDeuv+S0ijt3AsMB7F4WIvxU3l1w5I
 hcAc9AkWZrWbH55dy/JD75k1eaBs+immzBy4erA0DBHsbZIfGYzXVwlz1f07O0qk4srO
 3AMFWGodI0WAlE/wyKuCHohUQL7dvkA6d7GIRmk6pq+zuxqze3VhPDKgbXOS0FcNpfiQ sA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwm3ymdkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C3StZ7028286;
        Wed, 12 Apr 2023 05:23:10 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3pu0fr4426-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:10 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N91W29033146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB47858063;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC6DF58056;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:08 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 94FE974514B; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v6 0/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Wed, 12 Apr 2023 00:23:00 -0500
Message-Id: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eh1mvIC-yqQJ3y1bklYNHhUJbH5PZ3ye
X-Proofpoint-GUID: eh1mvIC-yqQJ3y1bklYNHhUJbH5PZ3ye
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 mlxlogscore=674 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new acbel,fsg032 driver and documentation updates.

Changes since V5:
Add symlink from manufacturer serial number to ccin since ccin is not
available in acbel-fsg032 power supply driver.

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
 drivers/hwmon/pmbus/acbel-fsg032.c            | 95 +++++++++++++++++++
 8 files changed, 196 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/hwmon/acbel-fsg032.rst
 create mode 100644 drivers/hwmon/pmbus/acbel-fsg032.c

-- 
2.37.2

