Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298406C39FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCUTKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCUTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:09:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AAC1EBF5;
        Tue, 21 Mar 2023 12:09:57 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIxbq4008225;
        Tue, 21 Mar 2023 19:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=L1Qe1vNPvKWd5cR+Cfarcd9j1YdNXKNpcIxzLqrIqts=;
 b=mt0doSB2R08g8sgloVaEeMWHNhlgiKxvJ9PcMa+ciR8unJ7Jc1VS+ViGAd5Gzmw6acrB
 fTaOoRpFzC9uFIJgvv6kP0taPwumOAvQLUjniAesqFYuQ8i8osx3KEkp0QwhLLhP604r
 3Y4x4FxUIs8hT9K0x4wXrt7qsgGmyi9k78Iw56nmLt+AJvu6G/1xvlQH13Cs+7fn7erR
 mUFY4GxzfGZwvuAhIVFNu8wQEovJGJxysg/okPo2iULjOZ86NPWBdcSi9OPODxQw7ifW
 JSTrLH0YB6ZLEvDqbb7+wrRgIwikc4eRR0F9vEcU7AddZFNcr6a0+C+WcO876Fbr3ino xw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfjbn07av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:33 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LHKu7C021504;
        Tue, 21 Mar 2023 19:09:32 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3pd4x74abc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:32 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LJ9ULV31457854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 19:09:30 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 760CE58052;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66BCB58067;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 0DE1674A47B; Tue, 21 Mar 2023 14:09:30 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v3 0/5] hwmon: (pmbus/acbel-fsg032) Add Acbel power supply
Date:   Tue, 21 Mar 2023 14:09:09 -0500
Message-Id: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i4UyQuLvflPLCObpkFja6jGsAdcxruSO
X-Proofpoint-ORIG-GUID: i4UyQuLvflPLCObpkFja6jGsAdcxruSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 mlxlogscore=772 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding new acbel,fsg032 driver and documentation updates.

Changes since V2:
- Changed the driver name to acbel-fsg032.
- Fix warnings in acbel-fsg032 driver.
- Fix warnings in acbel-fsg032.rst and updated the index.
- Fix comments in trivial-devices.yaml.
- Fix commit message for dts changes.
- Updated the commit messages with new driver name.

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

