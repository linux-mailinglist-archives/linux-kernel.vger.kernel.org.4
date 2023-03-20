Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19CD6C0BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCTIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCTIOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F204359B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679299990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tBzMw9tBuAmm9CF1nE8dcERwEMEX881hULtl8Hi/03I=;
        b=M3lpmXLA8P6P3GOCk8fXVcxla8YGojiFBqSF2EeTcY8MzR3G7I8wiqatTD02oMZgKV+OyV
        6jER6M4Io4BzcJ+jxB+JpApJNcmZ6rsYdXTOY90StUbzOljXKn/BtXJjiBakC9RvlomGqa
        hMCW1wvJuzVGd12WrtgphncT+5X8wns=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-tDKyxIHCOP2r6Xwq_li6tQ-1; Mon, 20 Mar 2023 04:13:07 -0400
X-MC-Unique: tDKyxIHCOP2r6Xwq_li6tQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E0903813F25;
        Mon, 20 Mar 2023 08:13:06 +0000 (UTC)
Received: from localhost (ovpn-13-195.pek2.redhat.com [10.72.13.195])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7258F4021B1;
        Mon, 20 Mar 2023 08:13:05 +0000 (UTC)
Date:   Mon, 20 Mar 2023 16:13:02 +0800
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
Subject: Re: [PATCH v20 2/8] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBgVjjZdiEA5YxQX@MiWiFi-R3L-srv>
References: <20230317212128.21424-1-eric.devolder@oracle.com>
 <20230317212128.21424-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317212128.21424-3-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17/23 at 05:21pm, Eric DeVolder wrote:
......
> @@ -697,3 +700,137 @@ static int __init crash_save_vmcoreinfo_init(void)
>  }
>  
>  subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +/*
> + * To accurately reflect hot un/plug changes of cpu and memory resources
> + * (including onling and offlining of those resources), the elfcorehdr
> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
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
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	/* Obtain lock while changing crash information */
> +	if (!kexec_trylock())
> +		return;
> +
> +	/* Check kdump is loaded */
> +	if (kexec_crash_image) {

Here, what I mean is:

	/* Obtain lock while changing crash information */
	if (!kexec_trylock())
		return;

	/*If kdump is not loaded*/
	if (!kexec_crash_image)
		goto out;	

Then we reduce one tab of indentation for the following code block, e.g
the for loop block will have smaller pressure on breaking the 80 chars
limitation.

> +		struct kimage *image = kexec_crash_image;
> +
> +		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +			pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +		else
> +			pr_debug("hp_action %u\n", hp_action);
> +
> +		/*
> +		 * When the struct kimage is allocated, the elfcorehdr_index
> +		 * is set to -1. Find the segment containing the elfcorehdr,
> +		 * if not already found. This works for both the kexec_load
> +		 * and kexec_file_load paths.
> +		 */
> +		if (image->elfcorehdr_index < 0) {
> +			unsigned long mem;
> +			unsigned char *ptr;
> +			unsigned int n;
> +
> +			for (n = 0; n < image->nr_segments; n++) {
> +				mem = image->segment[n].mem;
> +				ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +				if (ptr) {
> +					/* The segment containing elfcorehdr */
> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
> +						image->elfcorehdr_index = (int)n;
> +					kunmap_local(ptr);
> +				}
> +			}
> +		}
> +
> +		if (image->elfcorehdr_index < 0) {
> +			pr_err("unable to locate elfcorehdr segment");
> +			goto out;
> +		}
> +
> +		/* Needed in order for the segments to be updated */
> +		arch_kexec_unprotect_crashkres();
> +
> +		/* Differentiate between normal load and hotplug update */
> +		image->hp_action = hp_action;
> +
> +		/* Now invoke arch-specific update handler */
> +		arch_crash_handle_hotplug_event(image);
> +
> +		/* No longer handling a hotplug event */
> +		image->hp_action = KEXEC_CRASH_HP_NONE;
> +		image->elfcorehdr_updated = true;
> +
> +		/* Change back to read-only */
> +		arch_kexec_protect_crashkres();
> +	}
> +
> +out:
> +	/* Release lock now that update complete */
> +	kexec_unlock();
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
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
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
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
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
> +			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
> +	}
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 3d578c6fefee..8296d019737c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
>  	/* Initialize the list of unusable pages */
>  	INIT_LIST_HEAD(&image->unusable_pages);
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	image->hp_action = KEXEC_CRASH_HP_NONE;
> +	image->elfcorehdr_index = -1;
> +	image->elfcorehdr_updated = false;
> +#endif
> +
>  	return image;
>  }
>  
> -- 
> 2.31.1
> 

