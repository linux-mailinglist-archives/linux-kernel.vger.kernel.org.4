Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EABF691109
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBITKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBITKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:10:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBB46A71E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 11:10:39 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319IwM5F005602;
        Thu, 9 Feb 2023 19:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y2ZHglWw7G7tbRjtiJIdp2eGpb0hW1RppOaLqJEepjU=;
 b=mwJrzuXUcZXpE3nQXPJGj97wx2m6OcTKqa56BaswSlS4GM8209Yyu0iQZ4Z7/1xVBCa8
 cC+K2Nfny2pWGUWVOBIOLpr4v6iXGDkCQGPU172g4tAA/bUEBT5c6iL+PA/ID9G90Ia6
 W76k9hFM8V7/BF8kkFiLSxgDghFm8yvnJdgl8xw7tm295KuatJjz17mvahSPlqa+lLmA
 T9Y8UAnYFfEpvM8Xv+v9okO0WB+OV+Qlf72d2Hwrc1gaOEHwB9ztGTRd6VXhswlwrt3J
 XxsL6poBn+XVylKlCbYxL1h//giXzWnmP+tN5gDwdttckdhQcSLrYj+vZwoejuhr34DV kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn6k2rmj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 19:10:25 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 319IxE1n011747;
        Thu, 9 Feb 2023 19:10:22 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nn6k2rmea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 19:10:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319BuYwt021077;
        Thu, 9 Feb 2023 19:10:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfpkwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 19:10:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319JAHud23986648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 19:10:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 179D62004D;
        Thu,  9 Feb 2023 19:10:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EC4A20040;
        Thu,  9 Feb 2023 19:10:12 +0000 (GMT)
Received: from [9.43.118.216] (unknown [9.43.118.216])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 19:10:11 +0000 (GMT)
Message-ID: <dee53091-3aff-29f5-c7da-510d315ddcf2@linux.ibm.com>
Date:   Fri, 10 Feb 2023 00:40:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-4-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230131224236.122805-4-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vKLk3AnVmyMBqFa7MNCz6_ArNqKTIrJK
X-Proofpoint-ORIG-GUID: ofAsB3Ra80aJ_ziqfp43sNTQy6dKQHB4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090179
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 01/02/23 04:12, Eric DeVolder wrote:
> To support crash hotplug, a mechanism is needed to update the crash
> elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
> onlining).
>
> To track CPU changes, callbacks are registered with the cpuhp
> mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
> crash hotplug elfcorehdr update has no explicit ordering requirement
> (relative to other cpuhp states), so meets the criteria for
> utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
> state and avoids the need to introduce a new state for crash
> hotplug. Also, this is the last state in the PREPARE group, just
> prior to the STARTING group, which is very close to the CPU
> starting up in an plug/online situation, or stopping in a unplug/
> offline situation. This minimizes the window of time during an
> actual plug/online or unplug/offline situation in which the
> elfcorehdr would be inaccurate.
>
> Note, that when a CPU is being unplugged/offlined, the CPU is still
> in the foreach_present_cpu() during the regeneration of the
> elfcorehdr. Thus there is a need to explicitly check and exclude
> the soon-to-be offlined CPU. See patch 'kexec: exclude hot remove
> cpu from elfcorehdr notes'.
>
> To track memory changes, a notifier is registered to capture the
> memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>
> The cpu callbacks and memory notifiers invoke handle_hotplug_event()
> which performs needed tasks and then dispatches the event to the
> architecture specific arch_crash_handle_hotplug_event() to update the
> elfcorehdr with the current state of CPUs and memory. During the
> process, the kexec_lock is held.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   include/linux/crash_core.h |   9 +++
>   include/linux/kexec.h      |  12 ++++
>   kernel/crash_core.c        | 139 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 160 insertions(+)
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..ed868d237c07 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_NONE			0
> +#define KEXEC_CRASH_HP_REMOVE_CPU		1
> +#define KEXEC_CRASH_HP_ADD_CPU			2
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY		3
> +#define KEXEC_CRASH_HP_ADD_MEMORY		4
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 27ef420c7a45..a52624ae4452 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
>   #include <linux/compat.h>
>   #include <linux/ioport.h>
>   #include <linux/module.h>
> +#include <linux/highmem.h>
>   #include <asm/kexec.h>
>   
>   /* Verify architecture specific macros are defined */
> @@ -371,6 +372,13 @@ struct kimage {
>   	struct purgatory_info purgatory_info;
>   #endif
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	int hp_action;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;

May be I am reiterating myself but I think we can manage without 
elfcorehdr_index_valid.

Here is how:
Initialize the elfcorehdr_index with a negative value in 
do_kimage_alloc_init
function (it is called for both kexec_load and kexec_file_load).

Now when the control reaches to handle_hotplug_event function and if 
elfcorehdr_index
has negative value find the correct index and re-initialize the 
elfcorehdr_index.

Thoughts?

Thanks,
Sourabh Jain

