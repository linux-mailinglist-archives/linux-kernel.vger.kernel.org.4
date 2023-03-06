Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D436AC34C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCFOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCFObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741CC31E18
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678112952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1f7BkqHsqYuuBJD//EQRq+OWvr3phzSas2ytUULbFM=;
        b=f8g6fPE9zuzjIftmE2knvIpeJWNstZeDEe04nd/3gdy/U1/bGrTwDmljKbwqFFfQ9E/FEc
        iGOgyZUtpgVPGP5m2FCo+K57FgcFbL/1rQZZ66eJue47/BByoLvwh2VnG5VMfJtLPQVOKP
        j65ncYsQxjn0eHf5Zq2SMQD0tNUPCHo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-cpRk2oe3P_i3sL6_s_SYAA-1; Mon, 06 Mar 2023 09:07:29 -0500
X-MC-Unique: cpRk2oe3P_i3sL6_s_SYAA-1
Received: by mail-wr1-f71.google.com with SMTP id r14-20020a0560001b8e00b002cdb76f7e80so1513907wru.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111648;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y1f7BkqHsqYuuBJD//EQRq+OWvr3phzSas2ytUULbFM=;
        b=Pb/R6jVuXPHOD7BO0NbhOiTmxnbwo/i72bnCZNi6e6pn9S95bI1e/Xoz0Jiz0GalGv
         ExHppVIqmYizv+PtQltVFCg0I+M1EcLqSevMOC/iQT49QrsdLbwsUZsq0VCJXxfMW4SN
         NEGK1grHNRSVdASeLTtufelXwYDLuT7Pre/Mu4Gup3TeuXiMoi3W9V/LPMasJxwehkfs
         YO46r4hCLfXb6NT88AN2vZbNSvCmcAlj56vGIBLqibnqvR727QGDfa4Qt5UHc1pO67Yk
         k0BRMgBT2MskHU2bUOFHIAMskL6k5aoriNAjOyLtDPrij4+y7msXpX0M24fcjWEE120c
         MJZg==
X-Gm-Message-State: AO0yUKX7A2Vjc23M4GZ7Rj1L+vk0NK/OrPOij9B/XVT3nDbrk55NXBN0
        6Y29Cur2+2BS5VjbWbWhqY7S6gDEZzL8r22lGzfTl/zq4h4M1DmLIxUtG9Mbs8iXeqewdWgqPXB
        FlE0pRdsZ0AOgMy7UZ1RM85IA
X-Received: by 2002:a5d:634f:0:b0:2bf:f4f7:be9c with SMTP id b15-20020a5d634f000000b002bff4f7be9cmr6987957wrw.14.1678111648532;
        Mon, 06 Mar 2023 06:07:28 -0800 (PST)
X-Google-Smtp-Source: AK7set9zQx0DQ7OFEY5rXzIBR9BgwoqiDbJm4GwjhVCPZ3OJTonv+Bu/TB7sGcLdUCIOC1uneLB/IQ==
X-Received: by 2002:a5d:634f:0:b0:2bf:f4f7:be9c with SMTP id b15-20020a5d634f000000b002bff4f7be9cmr6987936wrw.14.1678111648145;
        Mon, 06 Mar 2023 06:07:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:3500:b8a3:191c:eae:cc05? (p200300cbc7043500b8a3191c0eaecc05.dip0.t-ipconnect.de. [2003:cb:c704:3500:b8a3:191c:eae:cc05])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d4688000000b002c5544b3a69sm10081903wrq.89.2023.03.06.06.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:07:27 -0800 (PST)
Message-ID: <7161f75e-9f40-f881-84b8-1eaaec0b0e3f@redhat.com>
Date:   Mon, 6 Mar 2023 15:07:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] powerpc/mm: fix mmap_lock bad unlock
Content-Language: en-US
To:     Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230306135520.4222-1-ldufour@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230306135520.4222-1-ldufour@linux.ibm.com>
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

On 06.03.23 14:55, Laurent Dufour wrote:
> When page fault is tried holding the per VMA lock, bad_access_pkey() and
> bad_access() should not be called because it is assuming the mmap_lock is
> held.
> In the case a bad access is detected, fall back to the default path,
> grabbing the mmap_lock to handle the fault and report the error.
> 
> Fixes: 169db3bb4609 ("powerc/mm: try VMA lock-based page fault handling first")
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/linux-mm/842502FB-F99C-417C-9648-A37D0ECDC9CE@linux.ibm.com
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>   arch/powerpc/mm/fault.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index c7ae86b04b8a..e191b3ebd8d6 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -479,17 +479,13 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
>   
>   	if (unlikely(access_pkey_error(is_write, is_exec,
>   				       (error_code & DSISR_KEYFAULT), vma))) {
> -		int rc = bad_access_pkey(regs, address, vma);
> -
>   		vma_end_read(vma);
> -		return rc;
> +		goto lock_mmap;
>   	}
>   
>   	if (unlikely(access_error(is_write, is_exec, vma))) {
> -		int rc = bad_access(regs, address);
> -
>   		vma_end_read(vma);
> -		return rc;
> +		goto lock_mmap;
>   	}
>   
>   	fault = handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LOCK, regs);

IIUC, that commit is neither upstream not in mm-stable -- it's unstable. 
Maybe raise that as a review comment in reply to the original patch, so 
we can easily connect the dots and squash it into the original, 
problematic patch that is still under review.

-- 
Thanks,

David / dhildenb

