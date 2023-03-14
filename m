Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB596B9074
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCNKpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCNKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D9F8C5A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678790613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2qaqlNY6k4SWQVNT90AfT4Sxk3NbeQfevvHYqeFvtY=;
        b=TY7ihTc0NH7AtB7q9AtOoeNmQfXoxCrc9/LYGH/CIYKN7J8hoHt//+w16VRayND4yJYPS+
        VvrhQv6SuoURKAQ7N1EZUBtf8skpaDXTnRFEJUVe+UPTjfjkVoSrOAt5aviGWhwaDkuLOo
        KyM65WuZDux+LWi6xWRgqnv0EHrdD08=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-EAvHKNpsN9CxgMptaQqMfg-1; Tue, 14 Mar 2023 06:43:30 -0400
X-MC-Unique: EAvHKNpsN9CxgMptaQqMfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2D062810C08;
        Tue, 14 Mar 2023 10:43:28 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFBE9400F55;
        Tue, 14 Mar 2023 10:43:27 +0000 (UTC)
Date:   Tue, 14 Mar 2023 18:43:24 +0800
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
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306162228.8277-3-eric.devolder@oracle.com>
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

On 03/06/23 at 11:22am, Eric DeVolder wrote:
......
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
> +	if (kexec_trylock()) {
> +
> +		/* Check kdump is loaded */
> +		if (kexec_crash_image) {

If the above check failed, I would directly return or jump out becuase
one indentation can be reduced.

> +			struct kimage *image = kexec_crash_image;
> +
> +			if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +				hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +				pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +			else
> +				pr_debug("hp_action %u\n", hp_action);
> +
> +			/*
> +			 * When the struct kimage is allocated, the elfcorehdr_index
> +			 * is set to -1. Find the segment containing the elfcorehdr,
> +			 * if not already found. This works for both the kexec_load
> +			 * and kexec_file_load paths.
> +			 */
> +			if (image->elfcorehdr_index < 0) {
> +				unsigned long mem;
> +				unsigned char *ptr;
> +				unsigned int n;
> +
> +				for (n = 0; n < image->nr_segments; n++) {
> +					mem = image->segment[n].mem;
> +					ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +					if (ptr) {
> +						/* The segment containing elfcorehdr */
> +						if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
> +							image->elfcorehdr_index = (int)n;
> +						}
> +						kunmap_local(ptr);
> +					}
> +				}
> +			}
> +
> +			if (image->elfcorehdr_index < 0) {
> +				pr_err("unable to locate elfcorehdr segment");
> +				goto out;
> +			}
> +
> +			/* Needed in order for the segments to be updated */
> +			arch_kexec_unprotect_crashkres();
> +
> +			/* Differentiate between normal load and hotplug update */
> +			image->hp_action = hp_action;
> +
> +			/* Now invoke arch-specific update handler */
> +			arch_crash_handle_hotplug_event(image);
> +
> +			/* No longer handling a hotplug event */
> +			image->hp_action = KEXEC_CRASH_HP_NONE;
> +			image->elfcorehdr_updated = true;
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

Because for_each_possible_cpu() is taken in
crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
hotplug or doesn't do anything with this patchset. This cpu part in
infrastructure is only for the later powerpc usage, right?

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
> index 969e8f52f7da..f2f9d41ce5df 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -276,6 +276,11 @@ struct kimage *do_kimage_alloc_init(void)
>  	/* Initialize the list of unusable pages */
>  	INIT_LIST_HEAD(&image->unusable_pages);
>  
> +#ifdef CONFIG_CRASH_HOTPLUG
> +    image->elfcorehdr_index = -1;
> +    image->elfcorehdr_updated = false;
> +#endif
> +
>  	return image;
>  }
>  
> -- 
> 2.31.1
> 

