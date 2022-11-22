Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2279E633746
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiKVIiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKVIiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3032C663
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669106222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLruKr0Jr2eahRROoPUxGVXkoCQ/kZQ9K7AIqvtY87M=;
        b=TjsRt3I/j0P59n2suUmMgjor4CuRMZufl+HBEKU55kCee41Q2WKkVoSdOeyTAQpXsIrEdG
        knjvg42OahMI60ukHMdlyhi5UDTqUTK/eEdDfoS1yOgW6bB6oAlliG1JuIDPlB+BXappfu
        mil83SzOqMQLwBPSnws2vUOyJb2vAyw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-s_tHI2zMOOi18XfjNTRNUA-1; Tue, 22 Nov 2022 03:37:00 -0500
X-MC-Unique: s_tHI2zMOOi18XfjNTRNUA-1
Received: by mail-wr1-f69.google.com with SMTP id u24-20020adfa198000000b00241da98e057so1531786wru.22
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLruKr0Jr2eahRROoPUxGVXkoCQ/kZQ9K7AIqvtY87M=;
        b=BTvzEnSOXarpHRM9p15oHW2EOGBiB1vtctCanf01isgk+ap74aeN19BRkyJk8+E9K/
         AhnJe9fMaq8rsL6cHxnAexxLlsYVimwP3F0qnxZyCXOG0cYLI+L8Atxq+xMSirNmWjGU
         FVKAvzcFU980JPOqjgL9PGSnUtmRS9t0oK322sZLY5dCZPbkrZkiwmGJOK/0FgNnXpjb
         CjUkc0aewDHX4+b5wPDfxI0CIVXkJr3e/vmO9u7ZHh1pi9yOE0DkpnnD4W6BR6aZ8hEm
         Lxc2vn0OjOYFU9/8bidRhbmpGLagiTRneQKSDt2rVoB9aseTXOTIjeSP55MzzbAEYMNS
         8d9g==
X-Gm-Message-State: ANoB5pmcICADJIOCwN0X0vHbc9lVB7ov7diEZ5tuAUQoSktLJuDay3mi
        O+gWC4rYnm33TcnKpM8fp6+CDPl0VLlhADCTEsv9c6btFLyIRMNAHJtDWhOCByOUitUQxBdwBXA
        CCESuZkEF4z1vyVCs6W+m7r6G
X-Received: by 2002:adf:f38a:0:b0:236:5270:7347 with SMTP id m10-20020adff38a000000b0023652707347mr13776274wro.35.1669106219572;
        Tue, 22 Nov 2022 00:36:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Jpq8EHSKME9hAJw0iZDI3FnUcjkLgwyOZsbm/iLUpg4dCKbX5r0QXPyxe27p+C7Ps22imIA==
X-Received: by 2002:adf:f38a:0:b0:236:5270:7347 with SMTP id m10-20020adff38a000000b0023652707347mr13776245wro.35.1669106219206;
        Tue, 22 Nov 2022 00:36:59 -0800 (PST)
Received: from [192.168.3.108] (p5b0c65c4.dip0.t-ipconnect.de. [91.12.101.196])
        by smtp.gmail.com with ESMTPSA id a5-20020adfe5c5000000b00241bc209ae0sm12955717wrn.32.2022.11.22.00.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:36:58 -0800 (PST)
Message-ID: <b1bc82e2-a789-85f4-d428-c5f1b451f4b7@redhat.com>
Date:   Tue, 22 Nov 2022 09:36:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: set the vma flags dirty before testing if it is
 mergeable
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Mel Gorman <mgorman@suse.de>, Peter Xu <peterx@redhat.com>,
        Andrei Vagin <avagin@gmail.com>, kernel@collabora.com,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20221122082442.1938606-1-usama.anjum@collabora.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221122082442.1938606-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.22 09:24, Muhammad Usama Anjum wrote:
> The VM_SOFTDIRTY should be set in the vma flags to be tested if new
> allocation should be merged in previous vma or not. With this patch,
> the new allocations are merged in the previous VMAs.
> 
> I've tested it by reverting the commit 34228d473efe ("mm: ignore
> VM_SOFTDIRTY on VMA merging") and after adding this following patch,
> I'm seeing that all the new allocations done through mmap() are merged
> in the previous VMAs. The number of VMAs doesn't increase drastically
> which had contributed to the crash of gimp. If I run the same test after
> reverting and not including this patch, the number of VMAs keep on
> increasing with every mmap() syscall which proves this patch.
> 
> The commit 34228d473efe ("mm: ignore VM_SOFTDIRTY on VMA merging")
> seems like a workaround. But it lets the soft-dirty and non-soft-dirty
> VMA to get merged. It helps in avoiding the creation of too many VMAs.
> But it creates the problem while adding the feature of clearing the
> soft-dirty status of only a part of the memory region.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: d9104d1ca966 ("mm: track vma changes with VM_SOFTDIRTY bit")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> We need more testing of this patch.
> 
> While implementing clear soft-dirty bit for a range of address space, I'm
> facing an issue. The non-soft dirty VMA gets merged sometimes with the soft
> dirty VMA. Thus the non-soft dirty VMA become dirty which is undesirable.
> When discussed with the some other developers they consider it the
> regression. Why the non-soft dirty page should appear as soft dirty when it
> isn't soft dirty in reality? I agree with them. Should we revert
> 34228d473efe or find a workaround in the IOCTL?
> 
> * Revert may cause the VMAs to expand in uncontrollable situation where the
> soft dirty bit of a lot of memory regions or the whole address space is
> being cleared again and again. AFAIK normal process must either be only
> clearing a few memory regions. So the applications should be okay. There is
> still chance of regressions if some applications are already using the
> soft-dirty bit. I'm not sure how to test it.
> 
> * Add a flag in the IOCTL to ignore the dirtiness of VMA. The user will
> surely lose the functionality to detect reused memory regions. But the
> extraneous soft-dirty pages would not appear. I'm trying to do this in the
> patch series [1]. Some discussion is going on that this fails with some
> mprotect use case [2]. I still need to have a look at the mprotect selftest
> to see how and why this fails. I think this can be implemented after some
> more work probably in mprotect side.
> 
> [1] https://lore.kernel.org/all/20221109102303.851281-1-usama.anjum@collabora.com/
> [2] https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/
> ---
>   mm/mmap.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f9b96b387a6f..6934b8f61fdc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1708,6 +1708,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>   		vm_flags |= VM_ACCOUNT;
>   	}
>   
> +	/*
> +	 * New (or expanded) vma always get soft dirty status.
> +	 * Otherwise user-space soft-dirty page tracker won't
> +	 * be able to distinguish situation when vma area unmapped,
> +	 * then new mapped in-place (which must be aimed as
> +	 * a completely new data area).
> +	 */
> +	vm_flags |= VM_SOFTDIRTY;
> +
>   	/*
>   	 * Can we just expand an old mapping?
>   	 */
> @@ -1823,15 +1832,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>   	if (file)
>   		uprobe_mmap(vma);
>   
> -	/*
> -	 * New (or expanded) vma always get soft dirty status.
> -	 * Otherwise user-space soft-dirty page tracker won't
> -	 * be able to distinguish situation when vma area unmapped,
> -	 * then new mapped in-place (which must be aimed as
> -	 * a completely new data area).
> -	 */
> -	vma->vm_flags |= VM_SOFTDIRTY;
> -
>   	vma_set_page_prot(vma);

vma_set_page_prot(vma) has to be called after adjusting vma->vm_flags.

Did not look into the details here, but that jumped at me.

-- 
Thanks,

David / dhildenb

