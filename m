Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BB76382B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 04:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKYD16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 22:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiKYD1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 22:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302C233AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 19:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669346824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JwS+i6RHG4xio2GVK1XiM/i9nFbjB+wVt/xavPQmn3c=;
        b=OzSloXY0dPSrpbOnXEPgh0zSdhRpKLAGAKQe95DDY/XctkTcf9wo9O89mKqu68WwZ42ZHS
        5+HtFKdvRb3oy22v5Isb2wIGNFp0nDNZyXcONI47gtpxvR9zbJJ1o1iYfcaJLJ/fdsbL4v
        Tn9Pn8kd5P8g4hNisFlKOMCDp5p6zq8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-BDApgZi3M5KZkQ13ZWGYHQ-1; Thu, 24 Nov 2022 22:27:00 -0500
X-MC-Unique: BDApgZi3M5KZkQ13ZWGYHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521AC3804507;
        Fri, 25 Nov 2022 03:26:59 +0000 (UTC)
Received: from localhost (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5DF540C6DC7;
        Fri, 25 Nov 2022 03:26:57 +0000 (UTC)
Date:   Fri, 25 Nov 2022 11:26:53 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116214643.6384-4-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 at 04:46pm, Eric DeVolder wrote:
......
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ebf46c3b8f8b..b4dbc21f9081 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
>  #include <linux/compat.h>
>  #include <linux/ioport.h>
>  #include <linux/module.h>
> +#include <linux/highmem.h>
>  #include <asm/kexec.h>
>  
>  /* Verify architecture specific macros are defined */
> @@ -374,6 +375,13 @@ struct kimage {
>  	struct purgatory_info purgatory_info;
>  #endif
>  
> +#ifdef CONFIG_CRASH_HOTPLUG

This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
it in the previous patch, not sure if this is acceptable.

> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;
> +#endif
> +
>  #ifdef CONFIG_IMA_KEXEC
>  	/* Virtual address of IMA measurement buffer for kexec syscall */
>  	void *ima_buffer;
> @@ -503,6 +511,34 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>  static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>  #endif
>  
> +#ifndef arch_map_crash_pages
> +/*
> + * NOTE: The addresses and sizes passed to this routine have
> + * already been fully aligned on page boundaries. There is no
> + * need for massaging the address or size.
> + */
> +static inline void *arch_map_crash_pages(unsigned long paddr,
> +					unsigned long size)
> +{
> +	if (size > 0)
> +		return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
> +	else
> +		return NULL;
> +}
> +#endif
> +
> +#ifndef arch_unmap_crash_pages
> +static inline void arch_unmap_crash_pages(void *ptr)
> +{
> +	if (ptr)
> +		kunmap_local(ptr);
> +}
> +#endif
> +
> +#ifndef arch_crash_handle_hotplug_event
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
> +#endif
> +
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
>  struct task_struct;
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 8c648fd5897a..4e7221226976 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
>  #include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -18,6 +20,7 @@
>  #include <crypto/sha1.h>
>  
>  #include "kallsyms_internal.h"
> +#include "kexec_internal.h"
>  
>  /* vmcoreinfo stuff */
>  unsigned char *vmcoreinfo_data;
> @@ -612,3 +615,139 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +/*
> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
> + * is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories.
> + *
> + * In order to make changes to elfcorehdr, two conditions are needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources; the elfcorehdr memory size
> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + */
> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (kexec_trylock()) {
> +
> +		/* Check kdump is loaded */
> +		if (kexec_crash_image) {
> +			struct kimage *image = kexec_crash_image;
> +
> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +			else
> +				pr_debug("hp_action %u\n", hp_action);
> +
> +			/*
> +			 * When the struct kimage is allocated, it is wiped to zero, so
> +			 * the elfcorehdr_index_valid defaults to false. Find the
> +			 * segment containing the elfcorehdr, if not already found.
> +			 * This works for both the kexec_load and kexec_file_load paths.
> +			 */
> +			if (!image->elfcorehdr_index_valid) {
> +				unsigned long mem, memsz;
> +				unsigned char *ptr;
> +				unsigned int n;
> +
> +				for (n = 0; n < image->nr_segments; n++) {
> +					mem = image->segment[n].mem;
> +					memsz = image->segment[n].memsz;
> +					ptr = arch_map_crash_pages(mem, memsz);
> +					if (ptr) {
> +						/* The segment containing elfcorehdr */
> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +							image->elfcorehdr_index = (int)n;
> +							image->elfcorehdr_index_valid = true;
> +						}
> +					}
> +					arch_unmap_crash_pages((void *)ptr);
> +				}
> +			}
> +
> +			if (!image->elfcorehdr_index_valid) {
> +				pr_err("unable to locate elfcorehdr segment");
> +				goto out;
> +			}
> +
> +			/* Needed in order for the segments to be updated */
> +			arch_kexec_unprotect_crashkres();
> +
> +			/* Flag to differentiate between normal load and hotplug */
> +			image->hotplug_event = true;
> +
> +			/* Now invoke arch-specific update handler */
> +			arch_crash_handle_hotplug_event(image);
> +
> +			/* No longer handling a hotplug event */
> +			image->hotplug_event = false;
> +
> +			/* Change back to read-only */
> +			arch_kexec_protect_crashkres();
> +		}
> +
> +out:
> +		/* Release lock now that update complete */
> +		kexec_unlock();
> +	}
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> +						   "crash/cpuhp",
> +						   crash_cpuhp_online,
> +						   crash_cpuhp_offline);
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> -- 
> 2.31.1
> 

