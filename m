Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF816FBFBA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjEIG5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjEIG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:57:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B959C6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:57:04 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3496qFMY030519;
        Tue, 9 May 2023 06:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XhIo0OsMg4ceKF2snW4w2x8hd613vfNACssqdJ+xfBs=;
 b=n0nzeDRTI97+9Y6nnqeTgjWrkpFI5ki4m5h2gRR/Q6b6h2HAQI6sfK/jQLt83KnGlMUQ
 ippqyDom5GMDO4kgenccsBDNQJSQxOEkgge2YAw3xsl48c4xxdwz4z/GVroOT03qwRE6
 WqfsReK/S7uqhnXrTbXnaCe9PyEo/OhlO0RhKuixnfUwS/h5VPJnsFkk1UETyC3c8jnQ
 Y8e1B5nE8nZbDyBn6ijjrEwUYTMLvrtqtJ7hL4dvWG6NWFEhiolu01Fuia2Q4UhEFuH+
 DPwWZiBKMLzIgv/laC3TysT4A/nY4wg9Cm/NNq4PvTv1nOzmIAY0M+NfxH+iZxld5IAi qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfh9q84fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 06:56:34 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3496qYYG031346;
        Tue, 9 May 2023 06:56:33 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfh9q84f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 06:56:33 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 349509OP019749;
        Tue, 9 May 2023 06:56:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qf7mhg5xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 06:56:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3496uS1v9306754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 06:56:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ECFB20043;
        Tue,  9 May 2023 06:56:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E59822004E;
        Tue,  9 May 2023 06:56:23 +0000 (GMT)
Received: from [9.43.122.124] (unknown [9.43.122.124])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  9 May 2023 06:56:23 +0000 (GMT)
Message-ID: <7e9999c0-c6eb-d0a5-dd2f-7d38c7054ff8@linux.ibm.com>
Date:   Tue, 9 May 2023 12:26:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 6/8] crash: hotplug support for kexec_load()
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
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-7-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230503224145.7405-7-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h3gmUaW0QdtLPVugfohSqwtjNEd_XKqd
X-Proofpoint-ORIG-GUID: LOmadaAplNrE3XGGhmUKDFN5J_SH2nv8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305090051
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/23 04:11, Eric DeVolder wrote:
> The hotplug support for kexec_load() requires coordination with
> userspace, and therefore a little extra help from the kernel to
> facilitate the coordination.
>
> In the absence of the solution contained within this particular
> patch, if a kdump capture kernel is loaded via kexec_load() syscall,
> then the crash hotplug logic would find the segment containing the
> elfcorehdr, and upon a hotplug event, rewrite the elfcorehdr. While
> generally speaking that is the desired behavior and outcome, a
> problem arises from the fact that if the kdump image includes a
> purgatory that performs a digest checksum, then that check would
> fail (because the elfcorehdr was changed), and the capture kernel
> would fail to boot and no kdump occur.
>
> Therefore, what is needed is for the userspace kexec-tools to
> indicate to the kernel whether or not the supplied kdump image/
> elfcorehdr can be modified (because the kexec-tools excludes the
> elfcorehdr from the digest, and sizes the elfcorehdr memory buffer
> appropriately).
>
> To solve these problems, this patch introduces:
>   - a new kexec flag KEXEC_UPATE_ELFCOREHDR to indicate that it is
>     safe for the kernel to modify the elfcorehdr (because kexec-tools
>     has excluded the elfcorehdr from the digest).
>   - the /sys/kernel/crash_elfcorehdr_size node to communicate to
>     kexec-tools what the preferred size of the elfcorehdr memory buffer
>     should be in order to accommodate hotplug changes.
>   - The sysfs crash_hotplug nodes (ie.
>     /sys/devices/system/[cpu|memory]/crash_hotplug) are now dynamic in
>     that they examine kexec_file_load() vs kexec_load(), and when
>     kexec_load(), whether or not KEXEC_UPDATE_ELFCOREHDR is in effect.
>     This is critical so that the udev rule processing of crash_hotplug
>     indicates correctly (ie. the userspace unload-then-load of the
>     kdump of the kdump image can be skipped, or not).
>
> With this patch in place, I believe the following statements to be true
> (with local testing to verify):
>
>   - For systems which have these kernel changes in place, but not the
>     corresponding changes to the crash hot plug udev rules and
>     kexec-tools, (ie "older" systems) those systems will continue to
>     unload-then-load the kdump image, as has always been done. The
>     kexec-tools will not set KEXEC_UPDATE_ELFCOREHDR.
>   - For systems which have these kernel changes in place and the proposed
>     udev rule changes in place, but not the kexec-tools changes in place:
>      - the use of kexec_load() will not set KEXEC_UPDATE_ELFCOREHDR and
>        so the unload-then-reload of kdump image will occur (the sysfs
>        crash_hotplug nodes will show 0).
>      - the use of kexec_file_load() will permit sysfs crash_hotplug nodes
>        to show 1, and the kernel will modify the elfcorehdr directly. And
>        with the udev changes in place, the unload-then-load will not occur!
>   - For systems which have these kernel changes as well as the udev and
>     kexec-tools changes in place, then the user/admin has full authority
>     over the enablement and support of crash hotplug support, whether via
>     kexec_file_load() or kexec_load().
>
> Said differently, as kexec_load() was/is widely in use, these changes
> permit it to continue to be used as-is (retaining the current unload-then-
> reload behavior) until such time as the udev and kexec-tools changes can
> be rolled out as well.
>
> I've intentionally kept the changes related to userspace coordination
> for kexec_load() separate as this need was identified late; the
> rest of this series has been generally reviewed and accepted. Once
> this support has been vetted, I can refactor if needed.
>
> Suggested-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   arch/x86/include/asm/kexec.h | 11 +++++++----
>   arch/x86/kernel/crash.c      | 27 +++++++++++++++++++++++++++
>   include/linux/kexec.h        | 14 ++++++++++++--
>   include/uapi/linux/kexec.h   |  1 +
>   kernel/crash_core.c          | 31 +++++++++++++++++++++++++++++++
>   kernel/kexec.c               |  3 +++
>   kernel/ksysfs.c              | 15 +++++++++++++++
>   7 files changed, 96 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 9143100ea3ea..3be6a98751f0 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -214,14 +214,17 @@ void arch_crash_handle_hotplug_event(struct kimage *image);
>   #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> -static inline int crash_hotplug_cpu_support(void) { return 1; }
> -#define crash_hotplug_cpu_support crash_hotplug_cpu_support
> +int arch_crash_hotplug_cpu_support(void);
> +#define crash_hotplug_cpu_support arch_crash_hotplug_cpu_support
>   #endif
>   
>   #ifdef CONFIG_MEMORY_HOTPLUG
> -static inline int crash_hotplug_memory_support(void) { return 1; }
> -#define crash_hotplug_memory_support crash_hotplug_memory_support
> +int arch_crash_hotplug_memory_support(void);
> +#define crash_hotplug_memory_support arch_crash_hotplug_memory_support
>   #endif
> +
> +unsigned int arch_crash_get_elfcorehdr_size(void);
> +#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
>   #endif
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 0c9d496cf7ce..8064e65de6c0 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -442,6 +442,33 @@ int crash_load_segments(struct kimage *image)
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
>   
> +/* These functions provide the value for the sysfs crash_hotplug nodes */
> +#ifdef CONFIG_HOTPLUG_CPU
> +int arch_crash_hotplug_cpu_support(void)
> +{
> +	return crash_check_update_elfcorehdr();
> +}
> +#endif
> +
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int arch_crash_hotplug_memory_support(void)
> +{
> +	return crash_check_update_elfcorehdr();
> +}
> +#endif
> +
> +unsigned int arch_crash_get_elfcorehdr_size(void)
> +{
> +	unsigned int sz;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		sz = 2 + CONFIG_NR_CPUS_DEFAULT + CRASH_MAX_MEMORY_RANGES;
> +	else
> +		sz += 2 + CONFIG_NR_CPUS_DEFAULT;

If the sz holds the garbage value we have issues in else part. Or if you 
expecting
sz to be 0 then += is not needed in the else part.

How to doing this way?

unsigned int sz;

sz = 2 + CONFIG_NR_CPUS_DEFAULT;

if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
     sz += CRASH_MAX_MEMORY_RANGES


Thanks,
Sourabh Jain

> +	sz *= sizeof(Elf64_Phdr);
> +	return sz;
> +}
> +
>   /**
>    * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>    * @image: the active struct kimage
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 6a8a724ac638..050e20066cdb 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -335,6 +335,10 @@ struct kimage {
>   	unsigned int preserve_context : 1;
>   	/* If set, we are using file mode kexec syscall */
>   	unsigned int file_mode:1;
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	/* If set, allow changes to elfcorehdr of kexec_load'd image */
> +	unsigned int update_elfcorehdr:1;
> +#endif
>   
>   #ifdef ARCH_HAS_KIMAGE_ARCH
>   	struct kimage_arch arch;
> @@ -411,9 +415,9 @@ bool kexec_load_permitted(int kexec_image_type);
>   
>   /* List of defined/legal kexec flags */
>   #ifndef CONFIG_KEXEC_JUMP
> -#define KEXEC_FLAGS    KEXEC_ON_CRASH
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
>   #else
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
>   #endif
>   
>   /* List of defined/legal kexec file flags */
> @@ -501,6 +505,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
>   static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
>   #endif
>   
> +int crash_check_update_elfcorehdr(void);
> +
>   #ifndef crash_hotplug_cpu_support
>   static inline int crash_hotplug_cpu_support(void) { return 0; }
>   #endif
> @@ -509,6 +515,10 @@ static inline int crash_hotplug_cpu_support(void) { return 0; }
>   static inline int crash_hotplug_memory_support(void) { return 0; }
>   #endif
>   
> +#ifndef crash_get_elfcorehdr_size
> +static inline crash_get_elfcorehdr_size(void) { return 0; }
> +#endif
> +
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 981016e05cfa..01766dd839b0 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -12,6 +12,7 @@
>   /* kexec flags for different usage scenarios */
>   #define KEXEC_ON_CRASH		0x00000001
>   #define KEXEC_PRESERVE_CONTEXT	0x00000002
> +#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
>   #define KEXEC_ARCH_MASK		0xffff0000
>   
>   /*
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index ef6e91daad56..e05bfdb7eaed 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -704,6 +704,33 @@ subsys_initcall(crash_save_vmcoreinfo_init);
>   #ifdef CONFIG_CRASH_HOTPLUG
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
> +
> +/*
> + * This routine utilized when the crash_hotplug sysfs node is read.
> + * It reflects the kernel's ability/permission to update the crash
> + * elfcorehdr directly.
> + */
> +int crash_check_update_elfcorehdr(void)
> +{
> +	int rc = 0;
> +
> +	/* Obtain lock while reading crash information */
> +	if (!kexec_trylock()) {
> +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		return 0;
> +	}
> +	if (kexec_crash_image) {
> +		if (kexec_crash_image->file_mode)
> +			rc = 1;
> +		else
> +			rc = kexec_crash_image->update_elfcorehdr;
> +	}
> +	/* Release lock now that update complete */
> +	kexec_unlock();
> +
> +	return rc;
> +}
> +
>   /*
>    * To accurately reflect hot un/plug changes of cpu and memory resources
>    * (including onling and offlining of those resources), the elfcorehdr
> @@ -734,6 +761,10 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   
>   	image = kexec_crash_image;
>   
> +	/* Check that updating elfcorehdr is permitted */
> +	if (!(image->file_mode || image->update_elfcorehdr))
> +		goto out;
> +
>   	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>   		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>   		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 92d301f98776..60de64bd14b9 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -129,6 +129,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>   	if (flags & KEXEC_PRESERVE_CONTEXT)
>   		image->preserve_context = 1;
>   
> +	if (flags & KEXEC_UPDATE_ELFCOREHDR)
> +		image->update_elfcorehdr = 1;
> +
>   	ret = machine_kexec_prepare(image);
>   	if (ret)
>   		goto out;
> diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> index aad7a3bfd846..1d4bc493b2f4 100644
> --- a/kernel/ksysfs.c
> +++ b/kernel/ksysfs.c
> @@ -165,6 +165,18 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
>   }
>   KERNEL_ATTR_RO(vmcoreinfo);
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	unsigned int sz = crash_get_elfcorehdr_size();
> +
> +	return sysfs_emit(buf, "%u\n", sz);
> +}
> +KERNEL_ATTR_RO(crash_elfcorehdr_size);
> +
> +#endif
> +
>   #endif /* CONFIG_CRASH_CORE */
>   
>   /* whether file capabilities are enabled */
> @@ -255,6 +267,9 @@ static struct attribute * kernel_attrs[] = {
>   #endif
>   #ifdef CONFIG_CRASH_CORE
>   	&vmcoreinfo_attr.attr,
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	&crash_elfcorehdr_size_attr.attr,
> +#endif
>   #endif
>   #ifndef CONFIG_TINY_RCU
>   	&rcu_expedited_attr.attr,
