Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3BC5F5D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJEXRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJEXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:17:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FDE857F8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:17:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso2745056pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P75Ww099jv9Om8MvN0r9mkkJ/YLMTXxMDNssXHfPeTs=;
        b=Ybuf2pqfOwKO8dsPs7+4fy9VtKnrA5sy7q6SMqwQY7JSoYV3nH38VyFBbXxzP1lIjZ
         N1Ug5aKLpaeYKGNe/ccQ/LiJL22vvFff83/VnHK7lREOW7WodXTSjEIiE4FWjwsBSjf5
         LiCAhVGnPvxey8DWHe9voGZ2E0bBxmqHASAafOgURFunJlOxtKERdBzVIbDVEVhYXRLi
         sFpnsVaFOqP5FiD9ki8kjBhaxGah1iCz87cjzfaMeHDBYlFIaK/GD9HtvFVlDgRygkUj
         h19gRSXN2KX4veb+lB4qS3H4eMd65GwaQtDWH5dTcdUsO3kBEt/Q5GWZaO2oUFFqh+bL
         n81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P75Ww099jv9Om8MvN0r9mkkJ/YLMTXxMDNssXHfPeTs=;
        b=O9zoucWLUb5VDdzBBQJv5mS1UhCu3bjSQDdcdS5Muv+R2AG00kqY1xtz4mVkHMCSvY
         /J8/5hT25QDes8lwYSfywmqA3r44BSs/fuxlGr4s1AvEiAwo8jiXZudH9G+kJp+8i80a
         e8qkthFdGI6Go/AAMuaPYCsUcLr2KGghWadqvItBokfu/YiII+hdcYDXkde5zYr1Gs2x
         Lso9foQFVoYHlbrVZiFqai6iekxcN4tO1RmRao0XONXG+0xgy+ThF3rAvyv7UXL5bp+J
         iFphLTJxLRqpzE+Hox0qZfKlsm8bfcIdsMtKyrvR1fXJG+WZil5RPVvQfZqcH/rdGIIQ
         JVMA==
X-Gm-Message-State: ACrzQf3bzPxMgnrKCKuyVIwZqAVCioBxx+vZvbpmVxrrS9xDIEUKL0hK
        m3BJ/KnlD/v6JLAWQHDM3P/PzA==
X-Google-Smtp-Source: AMsMyM5nR/ndnwW6VOCqawZxdmxfVnDGGFFfLAOceafLdHT1ZLCZNC3bCof7tEuiKgWHNYFSvr68wg==
X-Received: by 2002:a17:902:834a:b0:17f:8514:ceec with SMTP id z10-20020a170902834a00b0017f8514ceecmr1590640pln.81.1665011856070;
        Wed, 05 Oct 2022 16:17:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090302ce00b0017a09ebd1e2sm10926068plk.237.2022.10.05.16.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 16:17:35 -0700 (PDT)
Date:   Wed, 5 Oct 2022 23:17:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: use helper macro SPTE_ENT_PER_PAGE
Message-ID: <Yz4Qi7cn7TWTWQjj@google.com>
References: <20220913085452.25561-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913085452.25561-1-linmiaohe@huawei.com>
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

On Tue, Sep 13, 2022, Miaohe Lin wrote:
> Use helper macro SPTE_ENT_PER_PAGE to get the number of spte entries
> per page. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 858bc53cfab4..45c532d00f78 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1645,7 +1645,7 @@ static int is_empty_shadow_page(u64 *spt)
>  	u64 *pos;
>  	u64 *end;
>  
> -	for (pos = spt, end = pos + PAGE_SIZE / sizeof(u64); pos != end; pos++)
> +	for (pos = spt, end = pos + SPTE_ENT_PER_PAGE; pos != end; pos++)

This is buried under MMU_DEBUG, and turning that on to compile test, which requires
manually changing kernel code to enable, results in some minor warnings.  Given the
existence of CONFIG_KVM_WERROR=y, I think it's safe to say this code hasn't been
exercised in a very long time.  E.g. this is literally the first time I've actually
enabled MMU_DEBUG.

This particular check seems like it would be quite useful, but the pgprintk() and
rmap_printk() hooks, not so much.  E.g. the knob is too coarse grained, and many
of the prints now have tracepoints.

So, unless someone actually actively uses MMU_DEBUG+dbg, I'm inclined to just delete
pgprintk() and rmap_printk(), and then rename MMU_WARN_ON => KVM_MMU_WARN_ON and
add a Kconfig for that, e.g. CONFIG_KVM_PROVE_MMU.

Hmm, and maybe clean up this helper too, e.g. get rid of the pointer arithmetic,
and take the full kvm_mmu_page so that the error message can print out things like
the gfn (a host kernel pointer is going to be useless for debug).

Thoughts?  Objections?
