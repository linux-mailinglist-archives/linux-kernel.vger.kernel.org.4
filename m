Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2364F52E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLPXex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPXeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:34:36 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9782BF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:34:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 17so3839415pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aNmp5R9aYWU+X+cAxrdxt5x6qwJlFdL+7iXiUiJStnY=;
        b=Yhgu/0+5OnKvrUwXgql+vqsihjeUyqSPqwfBmamumWXAqCcrqj4qe/+IktT2gwsjtt
         Cj5jLGSQ783yc3LDBaCM1uW2rawPwXkjfjdsgTqiFmrG5FCtzKjheOfXPnzrrOxLmKDO
         wP7LA9291wd7IO4H0PbAG6wEu1hAUaVeAJ3bVtYigmJpCt9daPgKV+hzI6jayjABpGp3
         J25IQg2O+fH73yI4vkJzRZ08J4bMMbirpqfC5Uh53eACgWVziMxikwe4zN4ogK9QBZIM
         N1ulGINrpg5UqeFGSBNUizmNLAMFYqSFFq3cQu2G4e1kwVECvn4gmyOq3GYZPn+MBA5g
         FuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNmp5R9aYWU+X+cAxrdxt5x6qwJlFdL+7iXiUiJStnY=;
        b=exx1wUBqau2Shdt0yUDEhpA6bHHyjfkIC95FIHU4zYP3VZmHTDJCMRpNAII81WtxuX
         yrh52qqBLM/uVSJ3vZx0i7FrZG1QD2j3LQgbrP0FfFt34vQtaDijwX3SHRMoX4NDG5ND
         4FBQo6xr4o5sIBUzfTxQqL82dhCaeR/Ccsnxa0I58vAjEC68B0Yv8FnaDTfoKOjEJXms
         xr0AWCtfSFj2wExHIAsCYqSLmdq8YsphvvTWSznzqjXSqsJYAgeySwpzlSnTdRHRWqbR
         MUy+pql6OT06Tuvz0tHVBi/vNxbwcCPQI00I8H30pOytcgY7s29d08/Piy1+7pGbFw9g
         lsRg==
X-Gm-Message-State: AFqh2kosFr1Qb7dt1n3uTtI0JgMP9b2UiC56e1TtyqKnmYmCjTMkGrs0
        31OxhytAqvxnYsMaUB26/8dXSw==
X-Google-Smtp-Source: AMrXdXsbV5eF1KnqYXiM6Ly4/bDhPXcX9X5rD8A/TiyIYpmCSk7E/WOXnvUHJud557GK+TJYxILLEg==
X-Received: by 2002:a17:903:41c9:b0:189:858f:b5c0 with SMTP id u9-20020a17090341c900b00189858fb5c0mr799408ple.0.1671233673895;
        Fri, 16 Dec 2022 15:34:33 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902d4c400b00187022627d7sm2184471plg.36.2022.12.16.15.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:34:32 -0800 (PST)
Date:   Fri, 16 Dec 2022 23:34:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 19/32] KVM: x86: Explicitly track all possibilities
 for APIC map's logical modes
Message-ID: <Y50AhU1UwocNE/+M@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-20-seanjc@google.com>
 <96c369fb2042e8722256d36c9b2ccf4a930752d1.camel@redhat.com>
 <Y5y7VK9yk5qbfKVN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5y7VK9yk5qbfKVN@google.com>
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

On Fri, Dec 16, 2022, Sean Christopherson wrote:
> On Thu, Dec 08, 2022, Maxim Levitsky wrote:

...

> > > @@ -282,7 +291,8 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
> > >  		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
> > >  			new->phys_map[xapic_id] = apic;
> > >  
> > > -		if (!kvm_apic_sw_enabled(apic))
> > > +		if (new->logical_mode == KVM_APIC_MODE_MAP_DISABLED ||
> > > +		    !kvm_apic_sw_enabled(apic))
> > >  			continue;
> > Very minor nitpick: it feels to me that code that updates the logical mode of the
> > map, might be better to be in a function, or in 'if', like
> 
> An if-statement would be rough due to the indentation.  A function works well
> though, especially if both the physical and logical chunks are put into helpers.
> E.g. the patch at the bottom (with other fixup for this patch) yields:
> 
> 	new->max_apic_id = max_id;
> 	new->logical_mode = KVM_APIC_MODE_SW_DISABLED;
> 
> 	kvm_for_each_vcpu(i, vcpu, kvm) {
> 		if (!kvm_apic_present(vcpu))
> 			continue;
> 
> 		if (kvm_recalculate_phys_map(new, vcpu, &xapic_id_mismatch)) {
> 			kvfree(new);
> 			new = NULL;
> 			goto out;
> 		}
> 
> 		kvm_recalculate_logical_map(new, vcpu);
> 	}
> 
> I'll tack that patch on at the end of the series if it looks ok.

...

> +static void kvm_recalculate_logical_map(struct kvm_apic_map *new,
> +					struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_lapic *apic = vcpu->arch.apic;
> +	enum kvm_apic_logical_mode logical_mode;
> +	struct kvm_lapic **cluster;
> +	u16 mask;
> +	u32 ldr;
> +
> +	if (new->logical_mode == KVM_APIC_MODE_MAP_DISABLED)
> +		return;
> +
> +	if (kvm_apic_sw_enabled(apic))

"minor" detail, this is inverted.
