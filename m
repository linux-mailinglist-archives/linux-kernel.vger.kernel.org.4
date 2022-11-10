Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DA6247A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKJQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiKJQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:54:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714B18E19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:54:24 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id k5so1998383pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHqQ+ifPyyH+ZRpAz+8Vn63wx+9QCN4RV/rN7j1mLd4=;
        b=MsNnIC49TneR2S8d2YQaAthhjkheZcZYGvqeOL3CGrtumuM0GMydnbjeyPpt+zqJT4
         a0qb3TfPH2hDIzfQJlRstWyorDex9BxGHlpjKfuxTnRkBbeE5Dz0tXmggzK9S3de7pWI
         FIWRXvDmgaCOGD9CfvPbyq+euxTtemx2i8alqAVpwH3C/mNWqTDxZLfKpgks3xNBIGz2
         FuN01Zh9mL+B1+ePuSDMJaj2PLUTL6+40/6S7mujLwHpPR5BMBGkZHLlOEskW7pNRkYC
         JqTKzez76eVI17sB4AGaRy+HDpNiWCRY2uFqRN2naIUq/QKp29XgxTBqQVZ8gEsMTNrv
         o3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHqQ+ifPyyH+ZRpAz+8Vn63wx+9QCN4RV/rN7j1mLd4=;
        b=d8joHK3gW1Df3sQriFGLsVZH7AFbPvIT81q26xPcWeLJOEr70sMlj/DjvtJdOPPJIB
         oDkwQCMnEsRO7r4ydNA7MhDItcSgex29QINxwXoGAsID7fPSTSo2lMzhXQ3nTtdx+w6x
         f+NYF0Nv+yj1htd73voDOinpsVGq6UGpipU3xLam/ekXBsMJ5eVqUKwAqtMlvAPTNW9k
         fNaxN7PzJyTvPAo/7bAE6gbRbvnR9Ro6iLhvBcBPxNRxPQZM/JB9wbHfIvO5IXhSbFUO
         iQ2ViYwW3t2i6+q94bdzFNQkrygpMAAZE7R56YZuEkbXd+Drfo9DjA8KjF+8xqgx8iuM
         uNIA==
X-Gm-Message-State: ACrzQf0DfmUHpnRXSIyjuydIWswebGH44Y6r0HNtcohYjETO1Ykisj3n
        bUz47a8NSBEhf0DrRdK0WRhqQQ==
X-Google-Smtp-Source: AMsMyM7Gjon1TAgMXyfnJCAD/JqeM6dxubIZGmQGn6GXSBI6FxpyqDVr1dxTgHn8k9i/0IX5fhsz5g==
X-Received: by 2002:a17:902:f252:b0:186:9efb:7203 with SMTP id j18-20020a170902f25200b001869efb7203mr64076647plc.12.1668099264125;
        Thu, 10 Nov 2022 08:54:24 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a764a00b0020ad26fa65dsm14455pjl.56.2022.11.10.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:54:23 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:54:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com
Subject: Re: [PATCH] KVM: x86/mmu: avoid accidentally go to shadow path for 0
 count tdp root
Message-ID: <Y20svCKydu/iS0TY@google.com>
References: <20221110034122.9892-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110034122.9892-1-yan.y.zhao@intel.com>
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

On Thu, Nov 10, 2022, Yan Zhao wrote:
> kvm mmu uses "if (is_tdp_mmu(vcpu->arch.mmu))" to choose between tdp mmu
> and shadow path.
> If a root is a tdp mmu page while its root_count is 0, it's not valid to
> go to the shadow path.
> 
> So, return true and add a warn on zero root count.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  arch/x86/kvm/mmu/tdp_mmu.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
> index c163f7cc23ca..58b4881654a9 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.h
> +++ b/arch/x86/kvm/mmu/tdp_mmu.h
> @@ -74,6 +74,7 @@ static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
>  {
>  	struct kvm_mmu_page *sp;
>  	hpa_t hpa = mmu->root.hpa;
> +	bool is_tdp;
>  
>  	if (WARN_ON(!VALID_PAGE(hpa)))
>  		return false;
> @@ -84,7 +85,10 @@ static inline bool is_tdp_mmu(struct kvm_mmu *mmu)
>  	 * pae_root page, not a shadow page.
>  	 */
>  	sp = to_shadow_page(hpa);
> -	return sp && is_tdp_mmu_page(sp) && sp->root_count;
> +	is_tdp = sp && is_tdp_mmu_page(sp);
> +	WARN_ON(is_tdp && !refcount_read(&sp->tdp_mmu_root_count));
> +
> +	return is_tdp;

I have a series/patch that drops this code entirely, I would rather just go that
route directly.

https://lore.kernel.org/all/20221012181702.3663607-9-seanjc@google.com
