Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AB661E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 06:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjAIFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 00:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjAIFGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 00:06:40 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7309B4B8
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 21:06:39 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3091KX6n016282;
        Mon, 9 Jan 2023 05:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sCmzyO/A+/VtN9phnvgN5fqL7RVQRlkbQx78TjSitUo=;
 b=YdiO4igTUpV0ohUun5PfTguo4zpEXvfi1D3pmz6D/xrNyD3VCxiJcu1AhyMbUdSKDawn
 4CuZ59mCBOi4zwfRHS7LGC0FbMs/agXCKOvsaZzaPthFCCHA9kGANUiM9a7MhlOogqGJ
 tScfs4xGcmYKgf9VAfyXkqsT9FUEwNASfnFRGldKhjXp+0I+iGKdyglDireel8ZPvCt2
 dUTt63O0z4qJflaHU7nvxRmxaeOlwPHWhfrqPqIZd565EjFnIMqsGTUkwoyyfXyJ/usQ
 BYNj1ovfxYPUzqcJeSCA7t/nfnvBE0EMpRzqBH5mJspzaVUZMoxsZu7c/ZU/0mPK0y99 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6j4ge1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 05:05:56 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3094snke005857;
        Mon, 9 Jan 2023 05:05:55 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3myj6j4gd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 05:05:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3084bCw1004282;
        Mon, 9 Jan 2023 05:05:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3my0c69q0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 05:05:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30955oeG45678886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Jan 2023 05:05:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D73620040;
        Mon,  9 Jan 2023 05:05:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB7492004E;
        Mon,  9 Jan 2023 05:05:46 +0000 (GMT)
Received: from [9.43.40.56] (unknown [9.43.40.56])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  9 Jan 2023 05:05:46 +0000 (GMT)
Message-ID: <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
Date:   Mon, 9 Jan 2023 10:35:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20221209153656.3284-2-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PxamSnO6fknmEdZDFOCyAvOwlbEPEvtL
X-Proofpoint-GUID: OgT072Px9f10qZfhXo8usZTICEM_1fef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-08_19,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/12/22 21:06, Eric DeVolder wrote:
> At the outcome of this patch set, the crash_prepare_elf64_headers()
> is utilized on both the kexec_file_load() and kexec_load() paths. As
> such, need to move this function out of kexec_file.c and into a
> common location crash_core.c.
>
> No functionality change.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>   kernel/kexec_file.c |  99 -------------------------------------------
>   2 files changed, 100 insertions(+), 99 deletions(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a0eb4d5cf557..46c160d14045 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -10,6 +10,7 @@
>   #include <linux/utsname.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sizes.h>
> +#include <linux/kexec.h>
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>   }
>   early_param("crashkernel", parse_crashkernel_dummy);
>   
> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> +			  void **addr, unsigned long *sz)
> +{
> +	Elf64_Ehdr *ehdr;
> +	Elf64_Phdr *phdr;
> +	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> +	unsigned char *buf;
> +	unsigned int cpu, i;
> +	unsigned long long notes_addr;
> +	unsigned long mstart, mend;
> +
> +	/* extra phdr for vmcoreinfo ELF note */
> +	nr_phdr = nr_cpus + 1;
> +	nr_phdr += mem->nr_ranges;
> +
> +	/*
> +	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> +	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
> +	 * I think this is required by tools like gdb. So same physical
> +	 * memory will be mapped in two ELF headers. One will contain kernel
> +	 * text virtual addresses and other will have __va(physical) addresses.
> +	 */
> +
> +	nr_phdr++;
> +	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
> +	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
Seems like above function is out of CONFIG_KEXEC_FILE but some of the
structure/attributes like crash_mem and ELF_CORE_HEADER_ALIGN are
still defined under CONFIG_KEXEC_FILE (look for include/linux/kexec.h).

This leads to kernel build issue when CONFIG_KEXEC_FILE is disabled.

Thanks,
Sourabh Jain
