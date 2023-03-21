Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50466C39FF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjCUTKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCUTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:09:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE51E5EC;
        Tue, 21 Mar 2023 12:09:58 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIVZEW013763;
        Tue, 21 Mar 2023 19:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=c1DB9Q+Cek+iqDACVGLynf6pmu9TXXNVC26gWlakK7A=;
 b=Qzd7i1UhNP8hwDKLS5J9c6WdhZKtLu4NQ/lbjRbCFX5tbqHvvJKDcKfBTy7WPw90S/bO
 r5AuGKB4cQV4s/e6wUtw04IlnSxN/n9U10391OYn9SBQmHCOlEFFnZ2/OVeylZ+lylaO
 1fAJvLKD1Sl967VZYkC5IPm4jT21aYHLc7HF2Mtzquu8JtP7ezjeSkwUmuKo/Qimy58E
 33+kX1b45HHPHqIO85ObFcnTYiW6Dbr79YmruuSrlVqQQYkcjSjodaGIYrs9pALYCdSp
 gHfmqoWwYwAsZL/5UjsV+qEb3kc4OAUSkh8yImzYbmPkwThDLvyTeAoHyES5RIMgvOZu ng== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pfhxh11cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:33 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LHJIXR014726;
        Tue, 21 Mar 2023 19:09:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3pd4x799q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 19:09:32 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LJ9UKe37290634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 19:09:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BB0A58055;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C73558043;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 19:09:30 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id 2F1FD74A47F; Tue, 21 Mar 2023 14:09:30 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v3 4/5] docs: hwmon: Add documentaion for acbel-fsg032 PSU
Date:   Tue, 21 Mar 2023 14:09:13 -0500
Message-Id: <20230321190914.2266216-5-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0i95fRNdJELZoyzZd_jpwLUiXfQAdtrj
X-Proofpoint-ORIG-GUID: 0i95fRNdJELZoyzZd_jpwLUiXfQAdtrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=943 priorityscore=1501
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303210152
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation changes for acbel-fsg032 psu

Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
---
 Documentation/hwmon/acbel-fsg032.rst | 80 ++++++++++++++++++++++++++++
 Documentation/hwmon/index.rst        |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/hwmon/acbel-fsg032.rst

diff --git a/Documentation/hwmon/acbel-fsg032.rst b/Documentation/hwmon/acbel-fsg032.rst
new file mode 100644
index 000000000000..f1684b95e103
--- /dev/null
+++ b/Documentation/hwmon/acbel-fsg032.rst
@@ -0,0 +1,80 @@
+Kernel driver acbel-fsg032
+==========================
+
+Supported chips:
+
+  * ACBEL FSG032-00xG power supply.
+
+Author: Lakshmi Yadlapati <lakshmiy@us.ibm.com>
+
+Description
+-----------
+
+This driver supports ACBEL FSG032-00xG Power Supply. This driver
+is a client to the core PMBus driver.
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices.rst for
+details.
+
+Sysfs entries
+-------------
+
+The following attributes are supported:
+
+======================= ======================================================
+curr1_crit              Critical maximum current.
+curr1_crit_alarm        Input current critical alarm.
+curr1_input             Measured output current.
+curr1_label             "iin"
+curr1_max               Maximum input current.
+curr1_max_alarm         Maximum input current high alarm.
+curr1_rated_max         Maximum rated input current.
+curr2_crit              Critical maximum current.
+curr2_crit_alarm        Output current critical alarm.
+curr2_input             Measured output current.
+curr2_label             "iout1"
+curr2_max               Maximum output current.
+curr2_max_alarm         Output current high alarm.
+curr2_rated_max         Maximum rated output current.
+
+
+fan1_alarm              Fan 1 warning.
+fan1_fault	        Fan 1 fault.
+fan1_input	        Fan 1 speed in RPM.
+fan1_target             Set fan speed reference.
+
+in1_alarm               Input voltage under-voltage alarm.
+in1_input               Measured input voltage.
+in1_label               "vin"
+in1_rated_max           Maximum rated input voltage.
+in1_rated_min           Minimum rated input voltage.
+in2_crit                Critical maximum output voltage.
+in2_crit_alarm          Output voltage critical high alarm.
+in2_input               Measured output voltage.
+in2_label               "vout1"
+in2_lcrit               Critical minimum output voltage.
+in2_lcrit_alarm         Output voltage critical low alarm.
+in2_rated_max           Maximum rated output voltage.
+in2_rated_min           Minimum rated output voltage.
+
+power1_alarm            Input fault or alarm.
+power1_input            Measured input power.
+power1_label            "pin"
+power1_max              Input power limit.
+power1_rated_max        Maximum rated input power.
+power2_crit             Critical output power limit.
+power2_crit_alarm       Output power crit alarm limit exceeded.
+power2_input            Measured output power.
+power2_label            "pout"
+power2_max              Output power limit.
+power2_max_alarm        Output power high alarm.
+power2_rated_max        Maximum rated output power.
+
+temp[1-3]_input         Measured temperature.
+temp[1-2]_max           Maximum temperature.
+temp[1-3]_rated_max     Temperature high alarm.
+======================= ======================================================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index f1fe75f596a5..dc4ebed13617 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -23,6 +23,7 @@ Hardware Monitoring Kernel Drivers
    abituguru
    abituguru3
    acpi_power_meter
+   acbel-fsg032
    ad7314
    adc128d818
    adm1021
-- 
2.37.2

