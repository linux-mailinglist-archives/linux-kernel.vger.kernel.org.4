Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7687410FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjF1Mfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:35:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131]:17506 "EHLO
        mx0b-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbjF1Mfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:35:46 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBLbka003643;
        Wed, 28 Jun 2023 12:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Jbpoh+q999tZ+ReLB4QMfPjB4UjzDixh2Tp3MM4YOsE=;
 b=piHUTi7F8hLCWWD6yf8Y2FlDHDVnSC4+6vESK9IvP92cIROYdPm99g4qe9+WUoyWhgzJ
 i6IToZJd/KXerk4GPnpGpP3OvS/GOXv/TjRBzebzUFUhGWAWaCPRB6xXIML8E7qbnwOm
 l3aPZZyzdVQwAgFXyrami3FjtgusHBWVVirmHjvh03z9hlbbKQuMbubOEUEIZunGnt9x
 qBxi38BbZM8Cse4KwH1LMI64Vt99KycNxFdMeSfqWFqIdUHbb3QxPiQJ0tuxsVBuXUoD
 lRAfVfrMJOl0a6ShwxRNrHB1wRXodzTU9BY8Xg8+03OflvMr49jKXvk2kvnOX4KTujlj fA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rg9pb1er0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:07 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35SCZ6b9029893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 12:35:06 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 05:34:59 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>
Subject: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related support
Date:   Wed, 28 Jun 2023 18:04:27 +0530
Message-ID: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V9UZYviBDquQNpF4oYInuvhhK6o8l55A
X-Proofpoint-ORIG-GUID: V9UZYviBDquQNpF4oYInuvhhK6o8l55A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280111
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

Minidump kernel driver implementation is divided into two parts for
simplicity, one is minidump core which can also be called minidump
frontend(As API gets exported from this driver for registration with
backend) and the other part is minidump backend i.e, where the underlying
implementation of minidump will be there. There could be different way
how the backend is implemented like Shared memory, Memory mapped IO
or Resource manager(gunyah) based where the guest region information is
passed to hypervisor via hypercalls.

    Minidump Client-1     Client-2      Client-5    Client-n
             |               |              |             |
             |               |    ...       |   ...       |
             |               |              |             |
             |               |              |             |
             |               |              |             |
             |               |              |             |
             |               |              |             |
             |               |              |             |
             |           +---+--------------+----+        |
             +-----------+  qcom_minidump(core)  +--------+
                         |                       |
                         +------+-----+------+---+
                                |     |      |
                                |     |      |
                +---------------+     |      +--------------------+
                |                     |                           |
                |                     |                           |
                |                     |                           |
                v                     v                           v
     +-------------------+      +-------------------+     +------------------+
     |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
     |                   |      |                   |     |                  |
     +-------------------+      +-------------------+     +------------------+
       Shared memory              Memory mapped IO           Resource manager
        (backend)                   (backend)                   (backend)


Here, we will be giving all analogy of backend with SMEM as it is the
only implemented backend at present but general idea remains the same.

The core of SMEM based minidump feature is part of Qualcomm's boot
firmware code. It initializes shared memory (SMEM), which is a part of
DDR and allocates a small section of SMEM to minidump table i.e also
called global table of content (G-ToC). Each subsystem (APSS, ADSP, ...)
has their own table of segments to be included in the minidump and all
get their reference from G-ToC. Each segment/region has some details
like name, physical address and it's size etc. and it could be anywhere
scattered in the DDR.

Existing upstream Qualcomm remoteproc driver[1] already supports SMEM
based minidump feature for remoteproc instances like ADSP, MODEM, ...
where predefined selective segments of subsystem region can be dumped
as part of coredump collection which generates smaller size artifacts
compared to complete coredump of subsystem on crash.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142

In addition to managing and querying the APSS minidump description,
the Linux driver maintains a ELF header in a segment. This segment
gets updated with section/program header whenever a new entry gets
registered.


 docs: qcom: Add qualcomm minidump guide
  kallsyms: Export kallsyms_lookup_name
  soc: qcom: Add qcom_minidump_smem module
  soc: qcom: Add Qualcomm APSS minidump (frontend) feature support
  soc: qcom: Add linux minidump smem backend driver support
  soc: qcom: minidump: Add pending region registration support
  soc: qcom: minidump: Add update region support
  dt-bindings: reserved-memory: Add qcom,ramoops binding
  pstore/ram : Export ramoops_parse_dt() symbol
  soc: qcom: Add qcom's pstore minidump driver support
  soc: qcom: Register pstore frontend region with minidump
  remoteproc: qcom: Expand MD_* as MINIDUMP_*
  remoterproc: qcom: refactor to leverage exported minidump symbol
  MAINTAINERS: Add entry for minidump driver related support
  arm64: defconfig: Enable Qualcomm Minidump related drivers
  arm64: dts: qcom: sm8450: Add Qualcomm ramoops minidump node
  firmware: qcom_scm: provide a read-modify-write function
  pinctrl: qcom: Use qcom_scm_io_update_field()
  firmware: scm: Modify only the download bits in TCSR register
  firmware: qcom_scm: Refactor code to support multiple download mode
  firmware: qcom_scm: Add multiple download mode support

Patch 1/21 is qualcomm minidump document
Patch 2/21 will export kallsyms_lookup_name will be needed for minidump module
Patch 3/21 moves the minidump specific data structure and macro to
 qcom_minidump_smem.c and later 13/21 will use the API and remove
 minidump specific code to qcom_minidump_smem file.
Patch 4/21 is qualcomm minidump core(frontend) driver
Patch 5/21 implements qualcomm smem backend kernel driver
Patch 6/21 add pending region support for the clients who came for
 registration before minidump.
Patch 7/21 add update region support for registered clients.
Patch 8/21 Add dt-binding for qualcomm ramoops driver which is also a minidump client driver
Patch 9/21 exported symbol from ramoops driver to avoid copy of the code.
Patch 10/21 Add qcom's pstore minidump driver support which adds ramoops platform device
            and 11/21 register existing pstore frontend regions.
Patch 12/21 and 13/21 does some clean up and code reuse.
Patch 16/21 enable qcom_ramoops driver for sm8450
Patch 17-21 are not new and has already been through 6 versions and
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

Changes in v4:
 - Redesigned the driver and divided the driver into front end and backend (smem) so
   that any new backend can be attached easily to avoid code duplication.
 - Patch reordering as per the driver and subsystem to easier review of the code.
 - Removed minidump specific code from remoteproc to minidump smem based driver.
 - Enabled the all the driver as modules.
 - Address comments made on documentation and yaml and Device tree file [Krzysztof/Konrad]
 - Address comments made qcom_pstore_minidump driver and given its Device tree
   same set of properties as ramoops. [Luca/Kees]
 - Added patch for MAINTAINER file.
 - Include defconfig change as one patch as per [Krzysztof] suggestion.
 - Tried to remove the redundant file scope variables from the module as per [Krzysztof] suggestion.
 - Addressed comments made on dload mode patch v6 version 
   https://lore.kernel.org/lkml/1680076012-10785-1-git-send-email-quic_mojha@quicinc.com/

Changes in v3: https://lore.kernel.org/lkml/1683133352-10046-1-git-send-email-quic_mojha@quicinc.com/
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

Mukesh Ojha (21):
  docs: qcom: Add qualcomm minidump guide
  kallsyms: Export kallsyms_lookup_name
  soc: qcom: Add qcom_minidump_smem module
  soc: qcom: Add Qualcomm APSS minidump (frontend) feature support
  soc: qcom: Add linux minidump smem backend driver support
  soc: qcom: minidump: Add pending region registration support
  soc: qcom: minidump: Add update region support
  dt-bindings: reserved-memory: Add qcom,ramoops binding
  pstore/ram : Export ramoops_parse_dt() symbol
  soc: qcom: Add qcom's pstore minidump driver support
  soc: qcom: Register pstore frontend region with minidump
  remoteproc: qcom: Expand MD_* as MINIDUMP_*
  remoterproc: qcom: refactor to leverage exported minidump symbol
  MAINTAINERS: Add entry for minidump driver related support
  arm64: defconfig: Enable Qualcomm Minidump related drivers
  arm64: dts: qcom: sm8450: Add Qualcomm ramoops minidump node
  firmware: qcom_scm: provide a read-modify-write function
  pinctrl: qcom: Use qcom_scm_io_update_field()
  firmware: scm: Modify only the download bits in TCSR register
  firmware: qcom_scm: Refactor code to support multiple download mode
  firmware: qcom_scm: Add multiple download mode support

 Documentation/admin-guide/index.rst                |   1 +
 Documentation/admin-guide/qcom_minidump.rst        | 293 +++++++++++
 .../devicetree/bindings/soc/qcom/qcom,ramoops.yaml | 126 +++++
 MAINTAINERS                                        |  15 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  12 +
 arch/arm64/configs/defconfig                       |   4 +
 drivers/firmware/Kconfig                           |  11 -
 drivers/firmware/qcom_scm.c                        |  85 ++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  12 +-
 drivers/remoteproc/qcom_common.c                   | 142 +----
 drivers/soc/qcom/Kconfig                           |  39 ++
 drivers/soc/qcom/Makefile                          |   3 +
 drivers/soc/qcom/qcom_minidump.c                   | 582 +++++++++++++++++++++
 drivers/soc/qcom/qcom_minidump_internal.h          |  98 ++++
 drivers/soc/qcom/qcom_minidump_smem.c              | 387 ++++++++++++++
 drivers/soc/qcom/qcom_pstore_minidump.c            | 210 ++++++++
 drivers/soc/qcom/smem.c                            |   9 +
 fs/pstore/ram.c                                    |  26 +-
 include/linux/firmware/qcom/qcom_scm.h             |   2 +
 include/linux/pstore_ram.h                         |   2 +
 include/soc/qcom/qcom_minidump.h                   |  64 +++
 kernel/kallsyms.c                                  |   2 +-
 22 files changed, 1973 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/admin-guide/qcom_minidump.rst
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramoops.yaml
 create mode 100644 drivers/soc/qcom/qcom_minidump.c
 create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
 create mode 100644 drivers/soc/qcom/qcom_minidump_smem.c
 create mode 100644 drivers/soc/qcom/qcom_pstore_minidump.c
 create mode 100644 include/soc/qcom/qcom_minidump.h

-- 
2.7.4

