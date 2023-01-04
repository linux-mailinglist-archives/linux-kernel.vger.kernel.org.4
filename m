Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538265CF3C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbjADJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjADJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:09:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A8D1C11D
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672823349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WN89MJjCwknaqCXAnQNz+cH4SbGTgMKetTVEG8R1/tI=;
        b=dran5fSGkDVZ1UPZ/GeIUg3ybaPD0HFhLO3nrzlQkWMWl+9LUZat5rtOUoO+GQLMEMzK+K
        kd8/9Q3IzzT5Klp+UQ/dLZTm+91anrzincM6av4TQ5TEr3GM9qTlo1NQve6Kxeoyv5gBgJ
        iaefAnjB6yuZJqYEWtyPTeoh1CvAAag=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-6Jg9EXBaO52_gmnY01AXbQ-1; Wed, 04 Jan 2023 04:09:06 -0500
X-MC-Unique: 6Jg9EXBaO52_gmnY01AXbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F5283C0E441;
        Wed,  4 Jan 2023 09:09:06 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3B31121314;
        Wed,  4 Jan 2023 09:09:04 +0000 (UTC)
Date:   Wed, 4 Jan 2023 17:08:55 +0800
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
Subject: Re: [PATCH v15 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7VCJ4QvBIYNnF0b@MiWiFi-R3L-srv>
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209153656.3284-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/22 at 10:36am, Eric DeVolder wrote:
...... snip out
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 9ceb93c176a6..5186df48ce6c 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -42,6 +42,21 @@
>  #include <asm/crash.h>
>  #include <asm/cmdline.h>
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
>  /* Used while preparing memory map entries for second kernel */
>  struct crash_memmap_data {
>  	struct boot_params *params;
> @@ -394,10 +409,39 @@ int crash_load_segments(struct kimage *image)
>  	if (ret)
>  		return ret;
>  
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {

Do I miss anything important during reviewing? I can't see why memory
hotplug is also relying on HOTPLUG_CPU.

> +		/*
> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +		 * Start with VMCOREINFO and kernel_map.
> +		 */
> +		unsigned long pnum = 2;
> +
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +			pnum += CONFIG_NR_CPUS_DEFAULT;
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +			pnum += CRASH_MAX_MEMORY_RANGES;
> +
> +		if (pnum < (unsigned long)PN_XNUM) {
> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> +			kbuf.memsz += sizeof(Elf64_Ehdr);
> +
> +			image->elfcorehdr_index = image->nr_segments;
> +			image->elfcorehdr_index_valid = true;
> +
> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +			image->elf_headers_sz = kbuf.memsz;
> +		} else {
> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +		}
> +	}
> +#endif
>  
> -	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +456,67 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */
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
> + * To accurately reflect hot un/plug changes, the new elfcorehdr
> + * is prepared in a kernel buffer, and then it is written on top
> + * of the existing/old elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image)
> +{
> +	void *elfbuf = NULL, *old_elfcorehdr;
> +	unsigned long mem, memsz;
> +	unsigned long elfsz = 0;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
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
> +	if (old_elfcorehdr) {
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
> -- 
> 2.31.1
> 

