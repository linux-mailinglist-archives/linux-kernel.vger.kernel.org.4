Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40886F5C64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjECRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjECRDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:03:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3E10F1;
        Wed,  3 May 2023 10:03:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343GLZTU031407;
        Wed, 3 May 2023 17:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=y8nhUca5/jXytqEZLC1ft88NVgxYtp+AuBfD2huFXQk=;
 b=bPfvs9dcOWuNEGQ9v2MQ0bjkHTyuFxjuWzq2YTJKRi7PFEVXU0vtfOhjZax859d9v/Ym
 /Cjqw1BcRIT9pE2Ehb+8IF5nysy0Irl5frAp/DakI1Pq3Pkjd4Gto8XDio1XFlzZc7gY
 cWxlnsRrWMJoJt4WMLQarTvEwceLjnyaLRdoki+Rsqk1xLEMNZPDovlyCguIVxbGU87N
 4DQW1v2v08U3sUZGhqUZcSZQV6SRul8usyvFXtU2jkSMjH6duL/J52UAE85QSntiuMLx
 KE7PcCCj+U5bAUfHUNVgHUzvtD+PjK+49E02XBqhvYAw5hg6NQd5M1yStwUgbkXhevTw JQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qb4e9b5wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:02:50 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 343H2nG7000325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 17:02:49 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 3 May 2023 10:02:43 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v3 00/18] Add basic Minidump kernel driver support
Date:   Wed, 3 May 2023 22:32:14 +0530
Message-ID: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SvRd_yi7ZP4GM4OvtMKgPEiZy-L_VoeU
X-Proofpoint-ORIG-GUID: SvRd_yi7ZP4GM4OvtMKgPEiZy-L_VoeU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_12,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minidump is a best effort mechanism to collect useful and predefined data
for first level of debugging on end user devices running on Qualcomm SoCs.
It is built on the premise that System on Chip (SoC) or subsystem part of
SoC crashes, due to a range of hardware and software bugs. Hence, the
ability to collect accurate data is only a best-effort. The data collected
could be invalid or corrupted, data collection itself could fail, and so on.

Qualcomm devices in engineering mode provides a mechanism for generating
full system ramdumps for post mortem debugging. But in some cases it's
however not feasible to capture the entire content of RAM. The minidump
mechanism provides the means for selecting which snippets should be
included in the ramdump.

The core of minidump feature is part of Qualcomm's boot firmware code.
It initializes shared memory (SMEM), which is a part of DDR and
allocates a small section of SMEM to minidump table i.e also called
global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
their own table of segments to be included in the minidump and all get
their reference from G-ToC. Each segment/region has some details like
name, physical address and it's size etc. and it could be anywhere
scattered in the DDR.

Existing upstream Qualcomm remoteproc driver[1] already supports minidump
feature for remoteproc instances like ADSP, MODEM, ... where predefined
selective segments of subsystem region can be dumped as part of
coredump collection which generates smaller size artifacts compared to
complete coredump of subsystem on crash.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142

In addition to managing and querying the APSS minidump description,
the Linux driver maintains a ELF header in a segment. This segment
gets updated with section/program header whenever a new entry gets
registered.

Patch 1/18 is very trivial change.
Patch 2/18 moves the minidump specific data structure and macro to
 qcom_minidump.h so that (4/18) qcom minidump driver can use.
Patch 3/18 documents qualcomm minidump guide for users.
Patch 4/18 implements qualcomm minidump kernel driver and exports
 symbol which other minidump kernel client can use.
Patch 5/18 add pending region support for the clients who came for
registration before minidump.
Patch 6/18 add update region support for registered clients.
Patch 7/18 enables the qualcomm minidump driver.
Patch 8/18 Use the exported symbol from minidump driver in qcom_common
 for querying minidump descriptor for a subsystem.
Patch 9-13 add qcom dynamic ramoops region support via a driver which
 adds ramoops platform device and also register existing pstore
 frontend regions.
Patch 14-18 are not new and has already been through 6 versions and
reason of adding here is for minidump testing purpose and it will be rebased
automatically along with new version of minidump series.

Testing of the patches has been done on sm8450 target after enabling config like
CONFIG_PSTORE_RAM and CONFIG_PSTORE_CONSOLE and once the device boots up.
Try crashing it via devmem2 0xf11c000(this is known to create xpu violation and
and put the device in download mode) on command prompt.

I have added download patch here numbered from 14/18 to 18/18
Earlier download mode setting patches were sent separately
https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/

Default storage type is set to via USB, so minidump would be downloaded with the
help of x86_64 machine (running PCAT tool) attached to Qualcomm device which has
backed minidump boot firmware support (more can be found patch 3/18)

Below patch [1] is to warm reset Qualcomm device which has upstream qcom
watchdog driver support.

After applying all patches, we can boot the device and can execute
following command.

echo mini > /sys/module/qcom_scm/parameters/download_mode
echo c > /proc/sysrq-trigger

This will make the device go to download mode and collect the minidump on to the
attached x86 machine running the Qualcomm PCAT tool(This comes as part Qualcomm
package manager kit).
After that we will see a bunch of predefined registered region as binary blobs files
starts with md_* downloaded on the x86 machine on given location in PCAT tool from
the target device.

A sample client example to dump a linux region has been given in patch 3/18 and as
well as can be seen in patch 12/18.

[1]
--------------------------->8-------------------------------------

commit f1124ccebd47550b4c9627aa162d9cdceba2b76f
Author: Mukesh Ojha <quic_mojha@quicinc.com>
Date:   Thu Mar 16 14:08:35 2023 +0530

    do not merge: watchdog bite on panic

    Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 0d2209c..767e84a 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/of_device.h>
+#include <linux/panic.h>

 enum wdt_reg {
        WDT_RST,
@@ -114,12 +115,28 @@ static int qcom_wdt_set_pretimeout(struct watchdog_device *wdd,
        return qcom_wdt_start(wdd);
 }

+static void qcom_wdt_bite_on_panic(struct qcom_wdt *wdt)
+{
+       writel(0, wdt_addr(wdt, WDT_EN));
+       writel(1, wdt_addr(wdt, WDT_BITE_TIME));
+       writel(1, wdt_addr(wdt, WDT_RST));
+       writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
+
+       wmb();
+
+       while(1)
+               udelay(1);
+}
+
 static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
                            void *data)
 {
        struct qcom_wdt *wdt = to_qcom_wdt(wdd);
        u32 timeout;

+       if (in_panic)
+               qcom_wdt_bite_on_panic(wdt);
+
        /*
         * Trigger watchdog bite:
         *    Setup BITE_TIME to be 128ms, and enable WDT.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 979b776..f913629 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -22,6 +22,7 @@ extern int panic_on_oops;
 extern int panic_on_unrecovered_nmi;
 extern int panic_on_io_nmi;
 extern int panic_on_warn;
+extern bool in_panic;

 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
diff --git a/kernel/panic.c b/kernel/panic.c
index 487f5b0..714f7f4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -65,6 +65,8 @@ static unsigned int warn_limit __read_mostly;

 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
+bool in_panic = false;
+EXPORT_SYMBOL_GPL(in_panic);

 #define PANIC_PRINT_TASK_INFO          0x00000001
 #define PANIC_PRINT_MEM_INFO           0x00000002
@@ -261,6 +263,7 @@ void panic(const char *fmt, ...)
        int old_cpu, this_cpu;
        bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;

+       in_panic = true;
        if (panic_on_warn) {
                /*
                 * This thread may hit another WARN() in the panic path.
--------------------------------------------------------------------------

Changes in v3:
 - Addressed most of the comments by Srini on v2 and refactored the minidump driver.
    - Added platform device support
    - Unregister region support.
 - Added update region for clients.
 - Added pending region support.
 - Modified the documentation guide accordingly.
 - Added qcom_pstore_ramdump client driver which happen to add ramoops platform
   device and also registers ramoops region with minidump.
 - Added download mode patch series with this minidump series. 
    https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/

Changes in v2: https://lore.kernel.org/lkml/1679491817-2498-1-git-send-email-quic_mojha@quicinc.com/
 - Addressed review comment made by [quic_tsoni/bmasney] to add documentation.
 - Addressed comments made by [srinivas.kandagatla]
 - Dropped pstore 6/6 from the last series, till i get conclusion to get pstore
   region in minidump.
 - Fixed issue reported by kernel test robot.

Changes in v1: https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/


Mukesh Ojha (18):
  remoteproc: qcom: Expand MD_* as MINIDUMP_*
  remoteproc: qcom: Move minidump specific data to qcom_minidump.h
  docs: qcom: Add qualcomm minidump guide
  soc: qcom: Add Qualcomm minidump kernel driver
  soc: qcom: minidump: Add pending region registration support
  soc: qcom: minidump: Add update region support
  arm64: defconfig: Enable Qualcomm minidump driver
  remoterproc: qcom: refactor to leverage exported minidump symbol
  soc: qcom: Add qcom's pstore minidump driver support
  dt-bindings: reserved-memory: Add qcom,ramoops-minidump binding
  arm64: dts: qcom: sm8450: Add Qualcomm ramoops minidump node
  soc: qcom: Register pstore frontend region with minidump
  arm64: defconfig: Enable Qualcomm pstore minidump client driver
  firmware: qcom_scm: provide a read-modify-write function
  pinctrl: qcom: Use qcom_scm_io_update_field()
  firmware: scm: Modify only the download bits in TCSR register
  firmware: qcom_scm: Refactor code to support multiple download mode
  firmware: qcom_scm: Add multiple download mode support

 Documentation/admin-guide/qcom_minidump.rst        | 246 +++++++
 .../reserved-memory/qcom,ramoops-minidump.yaml     |  69 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  11 +
 arch/arm64/configs/defconfig                       |   2 +
 drivers/firmware/Kconfig                           |  11 -
 drivers/firmware/qcom_scm.c                        |  88 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  11 +-
 drivers/remoteproc/qcom_common.c                   |  75 +--
 drivers/soc/qcom/Kconfig                           |  25 +
 drivers/soc/qcom/Makefile                          |   2 +
 drivers/soc/qcom/qcom_minidump.c                   | 724 +++++++++++++++++++++
 drivers/soc/qcom/qcom_pstore_minidump.c            | 194 ++++++
 drivers/soc/qcom/smem.c                            |   8 +
 include/linux/firmware/qcom/qcom_scm.h             |   2 +
 include/soc/qcom/qcom_minidump.h                   | 130 ++++
 15 files changed, 1503 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,ramoops-minidump.yaml
 create mode 100644 drivers/soc/qcom/qcom_minidump.c
 create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

-- 
2.7.4

