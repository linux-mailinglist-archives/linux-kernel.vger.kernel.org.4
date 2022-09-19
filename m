Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF65BC359
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiISHHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiISHHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:07:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5C15FC7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 00:07:03 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J44Ip4010901;
        Mon, 19 Sep 2022 07:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=apL1ap4jky84AethjsdOSKCPtGVBdqAWIK1p77PB8Sw=;
 b=famm+QqHa13DtIquwUd/XzIGpgoddseEqB3u5eI+9WmBrMrzEdINu1xKxepN1zObAuiC
 5dh+IYiOeMgAaBOpUvPLdnPem4XzEAYAUmixiuPGFrOWAY9eI+i7ymINo1BhVtJ+NU/k
 p6R9dvLYu9xPL+ip1HEeoAMrp/d5FabwvMn7ZLwA5zghTVSthn8Er6M62ptc1Rhr+S3I
 67iegYXw3GlgVn+qm3dwzSX4yZGQG0OBg8c8s3t+ICdTixcuU7iepC4kdwLqCEHmK3s4
 wLb5nhanp8J3E9LUPqFk+QXd2lRBrHSapu9pGbBvQg8FPTgK4pTmKfcY1ZJgc/3SROC/ 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jph30bs64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 07:06:28 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28J6HKLc009049;
        Mon, 19 Sep 2022 07:06:28 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jph30bs5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 07:06:28 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28J757xL006131;
        Mon, 19 Sep 2022 07:06:26 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 3jn5v91fwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 07:06:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28J76NPU43319734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 07:06:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA8BD42047;
        Mon, 19 Sep 2022 07:06:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24A2C42045;
        Mon, 19 Sep 2022 07:06:18 +0000 (GMT)
Received: from [9.43.61.137] (unknown [9.43.61.137])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 19 Sep 2022 07:06:17 +0000 (GMT)
Message-ID: <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
Date:   Mon, 19 Sep 2022 12:36:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220909210509.6286-8-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U2h9PPsJ5beRGFeCmQgsZkOg4m_EEH2L
X-Proofpoint-ORIG-GUID: JN_t5p287PK97cVCV0eUgWrWmT-IEx3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190046
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/09/22 02:35, Eric DeVolder wrote:
> For x86_64, when CPU or memory is hot un/plugged, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
>
> When loading the crash kernel via kexec_load or kexec_file_load,
> the elfcorehdr is identified at run time in
> crash_core:handle_hotplug_event().
>
> To update the elfcorehdr for x86_64, a new elfcorehdr must be
> generated from the available CPUs and memory. The new elfcorehdr
> is prepared into a buffer, and then installed over the top of
> the existing elfcorehdr.
>
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
>
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>
> With this change, crash hotplug for kexec_file_load syscall
> is supported. The kexec_load is also supported, but also
> requires a corresponding change to userspace kexec-tools.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   arch/x86/Kconfig             |  11 ++++
>   arch/x86/include/asm/kexec.h |  20 +++++++
>   arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>   3 files changed, 133 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index f9920f1341c8..cdfc9b2fdf98 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>   	  (CONFIG_RELOCATABLE=y).
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
> +config CRASH_MAX_MEMORY_RANGES
> +	depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	int
> +	default 32768
> +	help
> +	  For the kexec_file_load path, specify the maximum number of
> +	  memory regions, eg. as represented by the 'System RAM' entries
> +	  in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
> +	  This value is combined with NR_CPUS and multiplied by Elf64_Phdr
> +	  size to determine the final buffer size.
> +
>   config KEXEC_JUMP
>   	bool "kexec jump"
>   	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index a3760ca796aa..432073385b2d 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>   extern void kdump_nmi_shootdown_cpus(void);
>   
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
> +#define arch_map_crash_pages arch_map_crash_pages
> +
> +void arch_unmap_crash_pages(void **ptr);
> +#define arch_unmap_crash_pages arch_unmap_crash_pages
> +
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +		unsigned int hp_action);
> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static inline int crash_hotplug_cpu_support(void) { return 1; }
> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +static inline int crash_hotplug_memory_support(void) { return 1; }
> +#define crash_hotplug_memory_support crash_hotplug_memory_support
> +#endif
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_X86_KEXEC_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..8fc7d678ac72 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -25,6 +25,7 @@
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include <linux/memblock.h>
> +#include <linux/highmem.h>
>   
>   #include <asm/processor.h>
>   #include <asm/hardirq.h>
> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>   	image->elf_headers = kbuf.buffer;
>   	image->elf_headers_sz = kbuf.bufsz;
>   
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	/* Ensure elfcorehdr segment large enough for hotplug changes */
> +	kbuf.memsz =
> +		(CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
> +			sizeof(Elf64_Phdr);
> +	/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +	image->elf_headers_sz = kbuf.memsz;
> +	image->elfcorehdr_index = image->nr_segments;
> +	image->elfcorehdr_index_valid = true;
> +#else
>   	kbuf.memsz = kbuf.bufsz;
> +#endif
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>   	return ret;
>   }
>   #endif /* CONFIG_KEXEC_FILE */
> +
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> +{
> +	void *ptr = NULL;
> +
> +	if (size > 0) {
> +		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
> +
> +		ptr = kmap_local_page(page);
> +	}
> +
> +	return ptr;
> +}
> +
> +void arch_unmap_crash_pages(void **ptr)
> +{
> +	if (ptr) {
> +		if (*ptr)
> +			kunmap_local(*ptr);
> +		*ptr = NULL;
> +	}
> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + * @hp_action: the hot un/plug action being handled
> + *
> + * To accurately reflect hot un/plug changes, the new elfcorehdr
> + * is prepared in a kernel buffer, and then it is written on top
> + * of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image,
> +	unsigned int hp_action)
> +{
> +	struct kexec_segment *ksegment;
> +	unsigned char *ptr = NULL;
> +	unsigned long elfsz = 0;
> +	void *elfbuf = NULL;
> +	unsigned long mem, memsz;
> +
> +	/*
> +	 * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
> +	 */
> +	ksegment = &image->segment[image->elfcorehdr_index];
> +	mem = ksegment->mem;
> +	memsz = ksegment->memsz;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
> +		pr_err("crash hp: unable to prepare elfcore headers");
> +		goto out;

On PowerPC, while preparing the elf core header the memblock structure 
is used to prepare program header for memory regions of elfcorehdr. 
Since the above arch specific hotplug handler gets invoked when memory 
is marked offline (MEM_OFFLINE) which is before memblock structure gets 
updated so on PowerPC the above handler may not work for memory hotplug 
case.

Just wondering which data structure is used to get the list of memory 
regions while preparing program header for memory regions of elfcorehdr 
on other architectures?

Thanks,
Sourabh Jain
