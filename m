Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7118268E5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBHBzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBHBzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:55:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7313DEC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:55:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j1so11039292pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 17:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFAeINwYtb2cLRVJgVtc+kWYFXCI8f2NbANQERXXFd0=;
        b=JkO4G2i5cU/E6yafLtwtlFjL7+8wulry7a3Ey9V3mhwaVhE5SCUWQDoZVhZPaJxlGI
         W7d/w1XtEKV7IhqrixH+q71lyrUCd8HJl3B1ld0dIhUjEdwxgt3fFM20XarQ1VkKO68i
         9i/rKN56pXvZLCaBQyFAMpCf+59UHwOB4r0b/+K3XrymyynR9/FfXqj9Yjbx7MwmAcFH
         lUmt0Te8AJSpvDmDxzZmo5tvAucslU2O8+4fKnourd8kcCtO//6Yj6ESjtdIMXQUhd37
         j5cJnwVsAZWJJbRYLXcDvSWPhMMUSTPCa/Vje6uZyqu6YN5P5QfJQgrNvgX53OlNUlZW
         gMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFAeINwYtb2cLRVJgVtc+kWYFXCI8f2NbANQERXXFd0=;
        b=pPxJDDJO1dUeCkWkchP4fvKmxW3NMNopeE2hHFZwciHgnm+qUsI+zCP8Hd0XdzFDqT
         5p+WEPG0rf/ghgBfeUQzNGnCc+mBUEATp98ecVFqR/ZvDrpdqaSP5C8RCl8g+CUkuTJl
         P5eUJXsu41Xx9zDGojFRtmB26MqFTWtv7JnXyNyJ+KzxkQwhKlfVa5nB/0PzYUFQ2gmx
         TYLvVx43w3vR73Sm8q241YCh6jNuu9Gr1nGsBtYI7KrHEKKsiToy49oey2p2XyvwO+T2
         yBwlzN1v1quQce3uDRlgL3K9DLeDOjMeKNclTBtw2kxKxilfztd/pblqioIxRILHIsLD
         hiaw==
X-Gm-Message-State: AO0yUKXBceQWO9WANSS4qmJ5UjYdfAtdjz41Wwb4AJt9KNvcpPS6rbSR
        pY8ERoEfGN4AUEkMwwZyGKE=
X-Google-Smtp-Source: AK7set9mvmEYqv3hl2OrC0zKo+qq3fUo4V5nX2RfOnU0+7cYrKdJNxD+cYH5ETHUyGXyK29itm5v/w==
X-Received: by 2002:a05:6a20:8e08:b0:be:abb2:66ff with SMTP id y8-20020a056a208e0800b000beabb266ffmr6740582pzj.60.1675821302133;
        Tue, 07 Feb 2023 17:55:02 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id q20-20020a638c54000000b004eecc3080f8sm8635372pgn.29.2023.02.07.17.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:54:59 -0800 (PST)
Date:   Wed, 8 Feb 2023 01:54:47 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4 5/7] mm: replace vma->vm_flags indirect modification
 in ksm_madvise
Message-ID: <Y+MA5wUYgtq6Ll++@localhost>
References: <20230126193752.297968-1-surenb@google.com>
 <20230126193752.297968-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126193752.297968-6-surenb@google.com>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:37:50AM -0800, Suren Baghdasaryan wrote:
> Replace indirect modifications to vma->vm_flags with calls to modifier
> functions to be able to track flag changes and to keep vma locking
> correctness.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 6 +++++-
>  arch/s390/mm/gmap.c                | 6 +++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 1d67baa5557a..709ebd578394 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -393,6 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  {
>  	unsigned long gfn = memslot->base_gfn;
>  	unsigned long end, start = gfn_to_hva(kvm, gfn);
> +	unsigned long vm_flags;
>  	int ret = 0;
>  	struct vm_area_struct *vma;
>  	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
> @@ -409,12 +410,15 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  			ret = H_STATE;
>  			break;
>  		}
> +		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
> +		vm_flags = vma->vm_flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -			  merge_flag, &vma->vm_flags);
> +			  merge_flag, &vm_flags);
>  		if (ret) {
>  			ret = H_STATE;
>  			break;
>  		}
> +		vm_flags_reset(vma, vm_flags);
>  		start = vma->vm_end;
>  	} while (end > vma->vm_end);
>  
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index ab836597419d..5a716bdcba05 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2587,14 +2587,18 @@ int gmap_mark_unmergeable(void)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	unsigned long vm_flags;
>  	int ret;
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	for_each_vma(vmi, vma) {
> +		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
> +		vm_flags = vma->vm_flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -				  MADV_UNMERGEABLE, &vma->vm_flags);
> +				  MADV_UNMERGEABLE, &vm_flags);
>  		if (ret)
>  			return ret;
> +		vm_flags_reset(vma, vm_flags);
>  	}
>  	mm->def_flags &= ~VM_MERGEABLE;
>  	return 0;
> -- 

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 2.39.1
> 
> 
