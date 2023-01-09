Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1102661F53
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 08:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjAIHhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 02:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbjAIHhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41ACE00
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 23:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673249778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3pRRcbAJr9FBmhMCHXLl4cGEBukXZQYCmqCCYZCpshc=;
        b=a4szKYkHnnRyFvQWiHdIksWAaEci92n4iRZEZNXi3CwHPLnzTC7lVw+nW2z3Jjnx3hJc07
        fFCo+3tW2q7o3gjPTXZCnqZ3uCVCaldena0MN7vhjSfZ2u7vA0r+fB/RgULgE7XyNzmRFN
        ezZeqJyf2Vl8ozvthaqzsdIqXb3AZw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-6SgBgRqnOwOUnSLWDuvUaQ-1; Mon, 09 Jan 2023 02:36:15 -0500
X-MC-Unique: 6SgBgRqnOwOUnSLWDuvUaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1DF7101A521;
        Mon,  9 Jan 2023 07:36:14 +0000 (UTC)
Received: from localhost (ovpn-12-124.pek2.redhat.com [10.72.12.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96EB3492B00;
        Mon,  9 Jan 2023 07:36:12 +0000 (UTC)
Date:   Mon, 9 Jan 2023 15:36:09 +0800
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
Subject: Re: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7vD6bm9xy9uyvRD@fedora>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
 <20230105151709.1845-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105151709.1845-8-eric.devolder@oracle.com>
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

On 01/05/23 at 10:17am, Eric DeVolder wrote:
......
> @@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
>  	if (ret)
>  		return ret;
>  
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
> +
> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
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

Logic of pnum calculating is a little confusing to me. If I only enable
one of CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG, is it OK? Say I
only enable CONFIG_HOTPLUG_CPU and CONFIG_SMP, on x86_64,
CONFIG_NR_CPUS_DEFAULT will be 64. pnum will be 64, is it OK. Am I miss
anything?

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
>  
> -	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +454,67 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */

