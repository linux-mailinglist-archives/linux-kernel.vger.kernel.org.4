Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACA2694DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBMRIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBMRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:08:16 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55E1719
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:08:15 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so911435pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIaGUtbeO8Q7szzkbT5AZaxmbn8CnzWe0QnRDCPq2y4=;
        b=q8fPlS/mNqdp3PZY1TlJUMjzRv1Vxy6Op+nl/B8neh82/SCpGtho983BJMHEiZ2oq/
         kgHGCKjMIgdYhu716bQyh4EN4MTu7InR0nZUmdEeM+sRpth+T/B34ocx4QyiguRjycZA
         CHm1tErT+v8SgDt5sJZrOh4K7RiniauB9HXm+AIOTO2uapvtqcKFFva9fOm0+aUzEHLB
         foZ7tQASaOOlo+kS3zPfa72/BcrBK3laYNf1aNMrkAi05XPCRfdDx0nurYYygfTkXnHT
         UC77EGb4itQValxcVP0wqKCVUNo5ulzopsUEHZ7Jmm2Ow+X8tpqYkeoJtT91+GyftVFO
         rVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIaGUtbeO8Q7szzkbT5AZaxmbn8CnzWe0QnRDCPq2y4=;
        b=G/f9eiJTjVzxkrg0mwcRNDYoP6w8hHgYPP8CeiIbFtO+Cp5BdxLrk5zF7fnNbJ4ThR
         X20gbAD9JNgB9ITOsSU3cjQuXajr9IV8iZ9qel3YxjOOD17YhU2gX9gTet9UA6hDHfkf
         lL8RRS2pwSnbPtmFFlFgrZ8hFsfnocdScrO99m6AOkqnAfpl1BMn3cvGaHw9Q8tj9YMs
         9lf0cN1jcJ20NlVj56Q7s2TcgK2hxy/PeeeOQ+p3pHqQfP/1u7Ufz5jy6tSJwEj92d0y
         BnPsXEDdhw50rMM9nSR+797PosfeqjlIGdDiayqzhYkqddHR4dv2RmZNH6XC7T2y2Mpq
         eBKA==
X-Gm-Message-State: AO0yUKWXALFkw/iiXdpBSQu3qR77P+l9jM0OAfYVaRWpM3CYLEg1fGrb
        Swq8VbsxHlMDu0UzGo/uhMUDlw==
X-Google-Smtp-Source: AK7set9bUuPo/nw2A9uQk6PdwuO0lt/JoXEl3LcQZpislsQ0DH3OyqHIHBGc7e8U0ZkpJceMEldOFA==
X-Received: by 2002:a17:902:f816:b0:198:af4f:de0f with SMTP id ix22-20020a170902f81600b00198af4fde0fmr443754plb.15.1676308094629;
        Mon, 13 Feb 2023 09:08:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m16-20020aa79010000000b005a8c0560074sm1637098pfo.129.2023.02.13.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 09:08:14 -0800 (PST)
Date:   Mon, 13 Feb 2023 17:08:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/5] KVM: Shrink struct kvm_mmu_memory_cache
Message-ID: <Y+puefrgtqf430fs@google.com>
References: <20230213163351.30704-1-minipli@grsecurity.net>
 <20230213163351.30704-4-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213163351.30704-4-minipli@grsecurity.net>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023, Mathias Krause wrote:
> Move the 'capacity' member around to make use of the padding hole on 64
> bit systems instead of introducing yet another one.
> 
> This allows us to save 8 bytes per instance for 64 bit builds of which,
> e.g., x86's struct kvm_vcpu_arch has a few.
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
>  include/linux/kvm_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> index 76de36e56cdf..8e4f8fa31457 100644
> --- a/include/linux/kvm_types.h
> +++ b/include/linux/kvm_types.h
> @@ -92,10 +92,10 @@ struct gfn_to_pfn_cache {
>   */
>  struct kvm_mmu_memory_cache {
>  	int nobjs;
> +	int capacity;
>  	gfp_t gfp_zero;
>  	gfp_t gfp_custom;
>  	struct kmem_cache *kmem_cache;
> -	int capacity;
>  	void **objects;

If we touch this, I vote to do a more aggressive cleanup and place nobjs next
to objects, e.g.

struct kvm_mmu_memory_cache {
	gfp_t gfp_zero;
	gfp_t gfp_custom;
	struct kmem_cache *kmem_cache;
	int capacity;
	int nobjs;
	void **objects;
};
