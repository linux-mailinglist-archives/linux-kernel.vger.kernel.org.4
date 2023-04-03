Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0570F6D4DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjDCQ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjDCQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:26:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A218171C;
        Mon,  3 Apr 2023 09:26:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333EUBEt022589;
        Mon, 3 Apr 2023 16:26:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZmFvuCrKRi6qXSK9G1ra3ki/FkMe5vXp6BX6wDMROKk=;
 b=fW29PkUhWctUz1miJvjLp777znUY0BK7JGu5QCjcY5U2tJ7IGEDgPG76GRA76/EKezk+
 EgKEt1vmrbRgMz6ZxclWNMY3a/QkMBR2pPco9MfmlQ8Fc6TLNLvjIUuqKv19YboNZNrk
 082mJ1OW37GoBwNcVAqtHueIzvijnabgpxoDEy5ho8VGEuQW38USfPXUyTqr6e92QcuR
 wwsWekK7Gm6HEaTw2BGPeRhn/UtiTzHYf3U7TCR1XssaCI/3XTzOs1qudEXQTvHFcvfg
 0glHCAZhONJp7kcNXvVoR29HU/OIDkRL/b0hnXsLwC4JDzIFLFDOlumt7fs3a7VS7MoS 4w== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtee99p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 16:26:05 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333GQ4t9023358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 16:26:04 GMT
Received: from [10.216.35.203] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 09:25:59 -0700
Message-ID: <714c239d-5813-5333-9267-9684ec1b0f4d@quicinc.com>
Date:   Mon, 3 Apr 2023 21:55:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/6] Add basic Minidump kernel driver support
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eDDI_nNXMOH3ZtYpt3kal14_qzpDdwVo
X-Proofpoint-ORIG-GUID: eDDI_nNXMOH3ZtYpt3kal14_qzpDdwVo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_13,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030122
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping;

-Mukesh

On 3/22/2023 7:00 PM, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined data
> for first level of debugging on end user devices running on Qualcomm SoCs.
> It is built on the premise that System on Chip (SoC) or subsystem part of
> SoC crashes, due to a range of hardware and software bugs. Hence, the
> ability to collect accurate data is only a best-effort. The data collected
> could be invalid or corrupted, data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for generating
> full system ramdumps for post mortem debugging. But in some cases it's
> however not feasible to capture the entire content of RAM. The minidump
> mechanism provides the means for selecting which snippets should be
> included in the ramdump.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of SMEM to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump and all get
> their reference from G-ToC. Each segment/region has some details like
> name, physical address and it's size etc. and it could be anywhere
> scattered in the DDR.
> 
> Existing upstream Qualcomm remoteproc driver[1] already supports minidump
> feature for remoteproc instances like ADSP, MODEM, ... where predefined
> selective segments of subsystem region can be dumped as part of
> coredump collection which generates smaller size artifacts compared to
> complete coredump of subsystem on crash.
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/remoteproc/qcom_common.c#n142
> 
> In addition to managing and querying the APSS minidump description,
> the Linux driver maintains a ELF header in a segment. This segment
> gets updated with section/program header whenever a new entry gets
> registered.
> 
> Patch 1/6 is very trivial change.
> Patch 2/6 moves the minidump specific data structure and macro to
>   qcom_minidump.h so that (4/6) minidump driver can use.
> Patch 3/6 documents qualcomm minidump guide for users.
> Patch 4/6 implements qualcomm minidump kernel driver and exports
>   symbol which other minidump kernel client can use.
> Patch 5/6 enables the qualcomm minidump driver.
> Patch 6/6 Use the exported symbol from minidump driver in qcom_common
>   for querying minidump descriptor for a subsystem.
> 
> Testing of the patches has been done on sm8450 target with the help
> of out of tree patch which helps to set the download mode and storage
> type and to warm reset the device.
> 
> Download mode setting patches are floating here,
> https://lore.kernel.org/lkml/1679070482-8391-1-git-send-email-quic_mojha@quicinc.com/
> 
> Default storage type is set to via USB, so minidump would be
> downloaded with the help of x86_64 machine running PCAT attached
> to Qualcomm device which has backed minidump boot firmware
> support(more can be found patch 3/6)
> 
> Below patch [1] is to warm reset Qualcomm device which has upstream qcom
> watchdog driver support.
> 
> After applying all patches, we can boot the device and can execute
> following command.
> 
> echo mini > /sys/module/qcom_scm/parameters/download_mode
> echo c > /proc/sysrq-trigger
> 
> This will make the device go to download mode and collect the
> minidump on to the attached x86 machine running the Qualcomm
> PCAT tool.
> 
> We will see a bunch of predefined registered region as binary
> blobs starts with md_*. A sample client example to dump a linux
> region has been given in 3/6.
> 
> [1]
> --------------------------->8-------------------------------------
> 
> commit f1124ccebd47550b4c9627aa162d9cdceba2b76f
> Author: Mukesh Ojha <quic_mojha@quicinc.com>
> Date:   Thu Mar 16 14:08:35 2023 +0530
> 
>      do not merge: watchdog bite on panic
> 
>      Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index 0d2209c..767e84a 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -12,6 +12,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/watchdog.h>
>   #include <linux/of_device.h>
> +#include <linux/panic.h>
> 
>   enum wdt_reg {
>          WDT_RST,
> @@ -114,12 +115,28 @@ static int qcom_wdt_set_pretimeout(struct watchdog_device *wdd,
>          return qcom_wdt_start(wdd);
>   }
> 
> +static void qcom_wdt_bite_on_panic(struct qcom_wdt *wdt)
> +{
> +       writel(0, wdt_addr(wdt, WDT_EN));
> +       writel(1, wdt_addr(wdt, WDT_BITE_TIME));
> +       writel(1, wdt_addr(wdt, WDT_RST));
> +       writel(QCOM_WDT_ENABLE, wdt_addr(wdt, WDT_EN));
> +
> +       wmb();
> +
> +       while(1)
> +               udelay(1);
> +}
> +
>   static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>                              void *data)
>   {
>          struct qcom_wdt *wdt = to_qcom_wdt(wdd);
>          u32 timeout;
> 
> +       if (in_panic)
> +               qcom_wdt_bite_on_panic(wdt);
> +
>          /*
>           * Trigger watchdog bite:
>           *    Setup BITE_TIME to be 128ms, and enable WDT.
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 979b776..f913629 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -22,6 +22,7 @@ extern int panic_on_oops;
>   extern int panic_on_unrecovered_nmi;
>   extern int panic_on_io_nmi;
>   extern int panic_on_warn;
> +extern bool in_panic;
> 
>   extern unsigned long panic_on_taint;
>   extern bool panic_on_taint_nousertaint;
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 487f5b0..714f7f4 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -65,6 +65,8 @@ static unsigned int warn_limit __read_mostly;
> 
>   int panic_timeout = CONFIG_PANIC_TIMEOUT;
>   EXPORT_SYMBOL_GPL(panic_timeout);
> +bool in_panic = false;
> +EXPORT_SYMBOL_GPL(in_panic);
> 
>   #define PANIC_PRINT_TASK_INFO          0x00000001
>   #define PANIC_PRINT_MEM_INFO           0x00000002
> @@ -261,6 +263,7 @@ void panic(const char *fmt, ...)
>          int old_cpu, this_cpu;
>          bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
> 
> +       in_panic = true;
>          if (panic_on_warn) {
>                  /*
>                   * This thread may hit another WARN() in the panic path.
> --------------------------------------------------------------------------
> 
> Changes in v2:
>   - Addressed review comment made by [quic_tsoni/bmasney] to add documentation.
>   - Addressed comments made by [srinivas.kandagatla]
>   - Dropped pstore 6/6 from the last series, till i get conclusion to get pstore
>     region in minidump.
>   - Fixed issue reported by kernel test robot.
> 
> 
> Changes in v1: https://lore.kernel.org/lkml/1676978713-7394-1-git-send-email-quic_mojha@quicinc.com/
> 
> Mukesh Ojha (6):
>    remoteproc: qcom: Expand MD_* as MINIDUMP_*
>    remoteproc: qcom: Move minidump specific data to qcom_minidump.h
>    docs: qcom: Add qualcomm minidump guide
>    soc: qcom: Add Qualcomm minidump kernel driver
>    arm64: defconfig: Enable Qualcomm minidump driver
>    remoterproc: qcom: refactor to leverage exported minidump symbol
> 
>   Documentation/admin-guide/qcom_minidump.rst | 240 +++++++++++++
>   arch/arm64/configs/defconfig                |   1 +
>   drivers/remoteproc/qcom_common.c            |  75 +---
>   drivers/soc/qcom/Kconfig                    |  14 +
>   drivers/soc/qcom/Makefile                   |   1 +
>   drivers/soc/qcom/qcom_minidump.c            | 537 ++++++++++++++++++++++++++++
>   include/soc/qcom/minidump.h                 |  40 +++
>   include/soc/qcom/qcom_minidump.h            |  88 +++++
>   8 files changed, 927 insertions(+), 69 deletions(-)
>   create mode 100644 Documentation/admin-guide/qcom_minidump.rst
>   create mode 100644 drivers/soc/qcom/qcom_minidump.c
>   create mode 100644 include/soc/qcom/minidump.h
>   create mode 100644 include/soc/qcom/qcom_minidump.h
> 
