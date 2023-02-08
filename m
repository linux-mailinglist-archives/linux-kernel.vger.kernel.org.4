Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FAC68E53F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBHBHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBHBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:07:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDDA2C67E;
        Tue,  7 Feb 2023 17:07:18 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317NxCih016065;
        Wed, 8 Feb 2023 01:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A/rUYM7Oy2gqIk2+4nucnYXjlkyZyJwm07fM+yH74bw=;
 b=Nia7wKTo3rOuq+4tzTl1MYUVWArR711UjFbPVAhVTtNK32mdlkDWgAASWSQ9X4MUlGce
 LYCeQSO6F07xBoK43xjWywO2Nnr9vQ2jP9dkdRVw+VCS4U/LiwaxNWi4qrC2rVyifIOW
 ZvK67IUZYw5TknGs9DlqsOYNpkne9Msktq7djw/4tHuhENx1jF2R63uiLoGKCLCf0t/p
 89AGCayZe7UpSoCp4QNnrxOCsfzQBuwaKCf5a+RBYMVGhx039EFpPGXLcCDjqMgbIoIb
 lo23F/KhQfr97Um62jVPQj0LkUsqtx+zqHxlPRJA5Inm5C1NUWR1x4PtMkMorjL7hW2U zw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkeny2qhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Feb 2023 01:06:58 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31816vrA011215
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Feb 2023 01:06:57 GMT
Received: from [10.134.67.48] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 17:06:57 -0800
Message-ID: <f862ff1a-d363-894e-eedf-e33dde6ebf34@quicinc.com>
Date:   Tue, 7 Feb 2023 17:06:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 18/27] firmware: qcom_scm: Register Gunyah platform ops
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230120224627.4053418-1-quic_eberman@quicinc.com>
 <20230120224627.4053418-19-quic_eberman@quicinc.com>
 <5564746d-2221-8c3e-0c81-b320716ad114@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <5564746d-2221-8c3e-0c81-b320716ad114@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YGZHJBdOSvu19cF_7VjgrvQHYmGGwXHs
X-Proofpoint-ORIG-GUID: YGZHJBdOSvu19cF_7VjgrvQHYmGGwXHs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_15,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080009
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/7/2023 3:52 AM, Srinivas Kandagatla wrote:
> 
> 
> On 20/01/2023 22:46, Elliot Berman wrote:
>> Qualcomm platforms have a firmware entity which performs access control
>> to physical pages. Dynamically started Gunyah virtual machines use the
>> QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
>> to the memory used by guest VMs. Gunyah doesn't do this operation for us
>> since it is the current VM (typically VMID_HLOS) delegating the access
>> and not Gunyah itself. Use the Gunyah platform ops to achieve this so
>> that only Qualcomm platforms attempt to make the needed SCM calls.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/firmware/Kconfig    |   2 +
>>   drivers/firmware/qcom_scm.c | 100 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 102 insertions(+)
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index b59e3041fd62..b888068ff6f2 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -214,6 +214,8 @@ config MTK_ADSP_IPC
>>   config QCOM_SCM
>>       tristate
>> +    select VIRT_DRIVERS
>> +    select GUNYAH_PLATFORM_HOOKS
> 
> So far SCM usage has been as library of functions to talk to Secure 
> world, now why is this selecting GUNYAH, it should be other way round.
> 

Gunyah runs on platforms other than Qualcomm hardware (QEMU is real, 
existing example). The SCM calls needed on Qualcomm platforms aren't 
needed/available on QEMU and would error out there.

I tried avoiding the "select" and even "depends on", but I was facing 
issues when QCOM_SCM=y and GUNYAH=m. When this happens, 
GUNYAH_PLATFORM_HOOKS should be =y, and the only way I could figure out 
to ensure that happens was by selecting it from QCOM_SCM.

> 
>>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>>       bool "Qualcomm download mode enabled by default"
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 92763dce6477..20a1434087eb 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/arm-smccc.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>>   #include "qcom_scm.h"
>> @@ -27,6 +28,9 @@ module_param(download_mode, bool, 0);
>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>   #define SCM_HAS_BUS_CLK        BIT(2)
>> +#define QCOM_SCM_RM_MANAGED_VMID    0x3A
>> +#define QCOM_SCM_MAX_MANAGED_VMID    0x3F
>> +
>>   struct qcom_scm {
>>       struct device *dev;
>>       struct clk *core_clk;
>> @@ -1292,6 +1296,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
>> payload_reg, u32 payload_val,
>>   }
>>   EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
>> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
> why can't this be an exported function like other scm interfaces?
> 
> We do not need a redirection here tbh.
> 
> That will also remove the need of gunyah_platform_hooks.c altogether, 
> and you could call scm functions directly.
> Correct me if this is not the case.
> 
> 

Same as above comment about running on QEMU.

Thanks,
Elliot

> 
>> +{
>> +    struct qcom_scm_vmperm *new_perms;
>> +    u64 src, src_cpy;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms = kcalloc(mem_parcel->n_acl_entries, 
>> sizeof(*new_perms), GFP_KERNEL);
>> +    if (!new_perms)
>> +        return -ENOMEM;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            new_perms[n].vmid = vmid;
>> +        else
>> +            new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_READ;
>> +    }
>> +
>> +    src = (1ull << QCOM_SCM_VMID_HLOS);
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        src_cpy = src;
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, mem_parcel->n_acl_entries);
>> +        if (ret) {
>> +            src = 0;
>> +            for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +                vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +                if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +                    src |= (1ull << vmid);
>> +                else
>> +                    src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
>> +            }
>> +
>> +            new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
>> +
>> +            for (i--; i >= 0; i--) {
>> +                src_cpy = src;
>> +                ret = qcom_scm_assign_mem(
>> +                        
>> le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, 1);
>> +                WARN_ON_ONCE(ret);
>> +            }
>> +            break;
>> +        }
>> +    }
>> +
>> +    kfree(new_perms);
>> +    return ret;
>> +}
>> +
>> +static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    struct qcom_scm_vmperm new_perms;
>> +    u64 src = 0;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +    new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | 
>> QCOM_SCM_PERM_READ;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            src |= (1ull << vmid);
>> +        else
>> +            src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
>> +    }
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src, &new_perms, 1);
>> +        WARN_ON_ONCE(ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static struct gunyah_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
>> +    .pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
>> +    .post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
>> +};
>> +
>>   static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>>   {
>>       struct device_node *tcsr;
>> @@ -1414,6 +1511,9 @@ static int qcom_scm_probe(struct platform_device 
>> *pdev)
>>       if (download_mode)
>>           qcom_scm_set_download_mode(true);
>> +    if (gh_rm_register_platform_ops(&qcom_scm_gh_rm_platform_ops))
>> +        dev_warn(__scm->dev, "Gunyah RM platform ops were already 
>> registered\n");
>> +
>>       return 0;
>>   }
