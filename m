Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B46DEAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjDLFXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLFXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:23:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC31FFB;
        Tue, 11 Apr 2023 22:23:38 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C3tlCW039830;
        Wed, 12 Apr 2023 05:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=c1DB9Q+Cek+iqDACVGLynf6pmu9TXXNVC26gWlakK7A=;
 b=gs4oOCkiYfQvxAhdEQyIqMFseCWqBr6c0qJmAPgYNU/uo6oN703JBlq4JYMKo5cdG2HC
 SgGFkk1jskEMNI9AwXLkPNLF0VoW/8BksOkipIxxPBjeQxzzaX8Bt8rLpNOKBeev/k4R
 xUQdK7sX+eWDlJ6oLNlvwWxa8gF+LwD2aHc/6rvW63dmwfUhdLQXle50aehOcLkfGToe
 40zVX3Q4VtDCfHSslXnmFS9t1GKAdaovV8uDtlbTJBacIel+9OC0WsHkEn3xhXBsz4o0
 6trCCM3TmkPSI0a0RIWrqZIzI0HqGHo1QKQ/jI+4hNo83j3gu6g+5T4LxINscZtyXUhz Ww== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwn5gah9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33C3QYeB013554;
        Wed, 12 Apr 2023 05:23:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3pu0m6m2xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 05:23:10 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33C5N9HL10682900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 05:23:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423AA5806B;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B1858062;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: from gfwa600.aus.stglabs.ibm.com (unknown [9.3.84.101])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Apr 2023 05:23:09 +0000 (GMT)
Received: by gfwa600.aus.stglabs.ibm.com (Postfix, from userid 181152)
        id A87F774514F; Wed, 12 Apr 2023 00:23:08 -0500 (CDT)
From:   Lakshmi Yadlapati <lakshmiy@us.ibm.com>
To:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Lakshmi Yadlapati <lakshmiy@us.ibm.com>
Subject: [PATCH v6 4/5] docs: hwmon: Add documentaion for acbel-fsg032 PSU
Date:   Wed, 12 Apr 2023 00:23:04 -0500
Message-Id: <20230412052305.1369521-5-lakshmiy@us.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
References: <20230412052305.1369521-1-lakshmiy@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aaRv3EnYOC0WOPRxAU-Y1Pc44YkJBZer
X-Proofpoint-GUID: aaRv3EnYOC0WOPRxAU-Y1Pc44YkJBZer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 impostorscore=0 spamscore=0 mlxlogscore=930
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120044
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

