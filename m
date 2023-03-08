Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2636AFD3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCHDJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCHDJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:09:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4829BE31
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 19:09:17 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32820hUv027174;
        Wed, 8 Mar 2023 03:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Cm4/YaW6tbebmiCcKpHg8QPcUJVbMCJup3R/0NWWCvA=;
 b=F4Ev91cLz9dwebW4aLPb6zL+V7mPb9gFztyFT1ccUBMZzqcGGJEXp+q1eNsYsIaf2aRE
 WJaVaHMcMkJBr38+JpuTW0eUuvmlIij5VPL+XaSHU0GvlnlBYc+guwYWARQ3SA9CSSaP
 utvddEK2wq5F1nXtMzy6z30v+DHJEtN9aQypLYX6xEWoU+7YF7r9CET+LREDLoDls+8B
 fc7wRtyrqiY2Y7ou7C1dkG4DkYqUZ1ElqzC8oM3YmKHPKkmsW360Mqbr8Q3xJiG5eZz1
 VXaZWLeh+MeTdo9uMW+0vDNAhrp8ejc8dhgOFv2Rf2As2h5Ps9aJqyPndY7F3z+NqxXy yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6h711560-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 03:08:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3282kdNY019801;
        Wed, 8 Mar 2023 03:08:47 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6h711554-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 03:08:47 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3280chTg003036;
        Wed, 8 Mar 2023 03:08:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3p6g0jg38m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 03:08:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32838gRZ64618848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Mar 2023 03:08:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E3E20040;
        Wed,  8 Mar 2023 03:08:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C6020043;
        Wed,  8 Mar 2023 03:08:37 +0000 (GMT)
Received: from [9.43.78.163] (unknown [9.43.78.163])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  8 Mar 2023 03:08:37 +0000 (GMT)
Message-ID: <93ee2841-1e97-4c44-3691-a8031e1db3b5@linux.ibm.com>
Date:   Wed, 8 Mar 2023 08:38:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v19 5/7] x86/crash: add x86 crash hotplug support
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
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-6-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230306162228.8277-6-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xMSkGJB5VeODvLdE45ozu7EQ5jik4_pv
X-Proofpoint-GUID: IgHq6noN-DiXVdtnrI8L9elE-phYqvMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080025
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/03/23 21:52, Eric DeVolder wrote:
> When CPU or memory is hot un/plugged, or off/onlined, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
>
> The segment containing the elfcorehdr is identified at run-time
> in crash_core:crash_handle_hotplug_event(), which works for both
> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
> is generated from the available CPUs and memory into a buffer,
> and then installed over the top of the existing elfcorehdr.
>
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
>
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
> only on the kexec_file_load() syscall; for kexec_load() userspace
> will need to size the segment similarly.
>
> To accommodate kexec_load() syscall in the absence of
> kexec_file_load() syscall support, and with CONFIG_CRASH_HOTPLUG
> enabled, it is necessary to move prepare_elf_headers() and
> dependents outside of CONFIG_KEXEC_FILE.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   arch/x86/Kconfig             |  13 ++++
>   arch/x86/include/asm/kexec.h |  15 +++++
>   arch/x86/kernel/crash.c      | 119 ++++++++++++++++++++++++++++++++---
>   3 files changed, 140 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3604074a878b..2ca5e19b8f19 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2119,6 +2119,19 @@ config CRASH_DUMP
>   	  (CONFIG_RELOCATABLE=y).
>   	  For more details see Documentation/admin-guide/kdump/kdump.rst
>   
> +config CRASH_HOTPLUG
> +	bool "Update the crash elfcorehdr on system configuration changes"
> +	default n

How about enabling this by default?

- Sourabh
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	help
> +	  Enable direct update to the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions to be dumped upon a crash)
> +	  in response to hot plug/unplug or online/offline of CPUs or
> +	  memory. This is a much more advanced approach than userspace
> +	  attempting that.
> +
> +	  If unsure, say Y.
> +
>   config KEXEC_JUMP
>   	bool "kexec jump"
>   	depends on KEXEC && HIBERNATION
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index a3760ca796aa..1bc852ce347d 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -212,6 +212,21 @@ typedef void crash_vmclear_fn(void);
>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>   extern void kdump_nmi_shootdown_cpus(void);
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +void arch_crash_handle_hotplug_event(struct kimage *image);
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
> +#endif
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _ASM_X86_KEXEC_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 305514431f26..c9aaec9de775 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -42,6 +42,21 @@
>   #include <asm/crash.h>
>   #include <asm/cmdline.h>
>   
> +/*
> + * For the kexec_file_load() syscall path, specify the maximum number of
> + * memory regions that the elfcorehdr buffer/segment can accommodate.
> + * These regions are obtained via walk_system_ram_res(); eg. the
> + * 'System RAM' entries in /proc/iomem.
> + * This value is combined with NR_CPUS_DEFAULT and multiplied by
> + * sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
> + * segment size.
> + * The value 8192, for example, covers a (sparsely populated) 1TiB system
> + * consisting of 128MiB memblocks, while resulting in an elfcorehdr
> + * memory buffer/segment size under 1MiB. This represents a sane choice
> + * to accommodate both baremetal and virtual machine configurations.
> + */
> +#define CRASH_MAX_MEMORY_RANGES 8192
> +
>   /* Used while preparing memory map entries for second kernel */
>   struct crash_memmap_data {
>   	struct boot_params *params;
> @@ -173,8 +188,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>   	crash_save_cpu(regs, safe_smp_processor_id());
>   }
>   
> -#ifdef CONFIG_KEXEC_FILE
> -
>   static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
>   {
>   	unsigned int *nr_ranges = arg;
> @@ -246,7 +259,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>   
>   /* Prepare elf headers. Return addr and size */
>   static int prepare_elf_headers(struct kimage *image, void **addr,
> -					unsigned long *sz)
> +					unsigned long *sz, unsigned long *nr_mem_ranges)
>   {
>   	struct crash_mem *cmem;
>   	int ret;
> @@ -264,6 +277,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>   	if (ret)
>   		goto out;
>   
> +	/* Return the computed number of memory ranges, for hotplug usage */
> +	*nr_mem_ranges = cmem->nr_ranges;
> +
>   	/* By default prepare 64bit headers */
>   	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>   
> @@ -272,6 +288,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>   	return ret;
>   }
>   
> +#ifdef CONFIG_KEXEC_FILE
>   static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
>   {
>   	unsigned int nr_e820_entries;
> @@ -386,18 +403,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
>   int crash_load_segments(struct kimage *image)
>   {
>   	int ret;
> +	unsigned long pnum = 0;
>   	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
>   				  .buf_max = ULONG_MAX, .top_down = false };
>   
>   	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
> +	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
>   	if (ret)
>   		return ret;
>   
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/*
> +	 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +	 * Account for VMCOREINFO and kernel_map and maximum CPUs.
> +	 */
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
> +	else
> +		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
> +
> +	if (pnum < (unsigned long)PN_XNUM) {
> +		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> +		kbuf.memsz += sizeof(Elf64_Ehdr);
> +
> +		image->elfcorehdr_index = image->nr_segments;
> +
> +		/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +		image->elf_headers_sz = kbuf.memsz;
> +	} else {
> +		pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +	}
> +#endif
>   
> -	kbuf.memsz = kbuf.bufsz;
>   	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>   	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>   	ret = kexec_add_buffer(&kbuf);
> @@ -410,3 +451,67 @@ int crash_load_segments(struct kimage *image)
>   	return ret;
>   }
>   #endif /* CONFIG_KEXEC_FILE */
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: the active struct kimage
> + *
> + * The new elfcorehdr is prepared in a kernel buffer, and then it is
> + * written on top of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image)
> +{
> +	void *elfbuf = NULL, *old_elfcorehdr;
> +	unsigned long nr_mem_ranges;
> +	unsigned long mem, memsz;
> +	unsigned long elfsz = 0;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
> +		pr_err("unable to prepare elfcore headers");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Obtain address and size of the elfcorehdr segment, and
> +	 * check it against the new elfcorehdr buffer.
> +	 */
> +	mem = image->segment[image->elfcorehdr_index].mem;
> +	memsz = image->segment[image->elfcorehdr_index].memsz;
> +	if (elfsz > memsz) {
> +		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> +	 */
> +	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +	if (!old_elfcorehdr) {
> +		pr_err("updating elfcorehdr failed\n");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Temporarily invalidate the crash image while the
> +	 * elfcorehdr is updated.
> +	 */
> +	xchg(&kexec_crash_image, NULL);
> +	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
> +	xchg(&kexec_crash_image, image);
> +	kunmap_local(old_elfcorehdr);
> +	pr_debug("updated elfcorehdr\n");
> +
> +out:
> +	vfree(elfbuf);
> +}
> +#endif
