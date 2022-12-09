Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325CE647B0B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 01:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLIA4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 19:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLIA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 19:56:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF561A4309
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 16:56:21 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 142so2529306pga.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 16:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOs4C6BBma642P6OMMzRiIsIhDlU2b6iXgXp4qHQDzo=;
        b=f11nxtxN8hrAGBuAtH/s266yjx8WyVzDoE7wWwPoHxUHnzNcDfxYfirHZo4YxfgnYS
         VEf78bwhI5ybygthnEPqJ5iDhaaPqsWfNVnDRt7JR7KETO3XWUcqCebHg5anE6o08LeG
         KzmZlFlcWFhrVSRoVuMXZDyOJw/lA56z/UaZ5WmzwLsSYWvUuJghgrAy946YfNIUchno
         HB5SqwNXgW7Sl+sWYzfkBtGBcTxytTY2vkAbdQ3YqFPEonW7lurYtT9HozBifV56bgA6
         Ratt0yhywNs3NhJNLc5xp4ZjM5kV/6FgzLFyLxlF1RDs4Pi0f29/gfa7jD9bC1M86OdU
         SCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOs4C6BBma642P6OMMzRiIsIhDlU2b6iXgXp4qHQDzo=;
        b=k+oKTqlbADGduMfCgtCQtbrlphQZNTkzI5gUU9IYDTcxJginm/CHuT87XmO6IwtFYa
         7u+87i9QftoQ/eYhzDcEM+Ktbz/Qja1fF3kQAOmgbSGu3MibcNk+tLkpfvuXlwbkmwuQ
         bzRfqPvfaAw2Vjy79W9ct0Dtq2g/PUln02haSp9nCbIG2SvjwyETFC/hChG2ruW/h1ox
         B55Ns8rhrWAXgK9tZc1K69B3ukHl+SzknDa3+E415OFcNUBx4/F5lkQmS5+nHLHOddHa
         9Eo63ula4qsFCHjixnRSgfU1kvajY6KhKyaelXK/11CIQRvWbKXVYnbQPmdfjm2JVwsy
         O/hg==
X-Gm-Message-State: ANoB5plvi5uttFxkzQ0L+CfDoHvbs+5hqSWRqOhhnsCqTKM9kVHzxj9i
        24dBJHDjc1NyMnCAPiQO4JceELPLP4nShA0z
X-Google-Smtp-Source: AA0mqf7I9fjvyqQmNK0n3BjA7Te2K3XSrNeQRcs8VYDmM6mOWiUJtY4GV7TjXIXOBWChQEK8m78ytw==
X-Received: by 2002:a62:e718:0:b0:577:36ba:6a86 with SMTP id s24-20020a62e718000000b0057736ba6a86mr1125144pfh.1.1670547381215;
        Thu, 08 Dec 2022 16:56:21 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 23-20020a621917000000b005748029bab8sm96462pfz.156.2022.12.08.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:56:20 -0800 (PST)
Date:   Fri, 9 Dec 2022 00:56:17 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v4 24/32] KVM: x86: Inhibit APICv/AVIC if the optimized
 physical map is disabled
Message-ID: <Y5KHsdsA/T/gaswC@google.com>
References: <20221001005915.2041642-1-seanjc@google.com>
 <20221001005915.2041642-25-seanjc@google.com>
 <6de0c4fd228055840648452bd5a3b4955f70d881.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de0c4fd228055840648452bd5a3b4955f70d881.camel@redhat.com>
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

On Thu, Dec 08, 2022, Maxim Levitsky wrote:
> On Sat, 2022-10-01 at 00:59 +0000, Sean Christopherson wrote:
> > Inhibit APICv/AVIC if the optimized physical map is disabled so that KVM
> > KVM provides consistent APIC behavior if xAPIC IDs are aliased due to
> > vcpu_id being truncated and the x2APIC hotplug hack isn't enabled.  If
> > the hotplug hack is disabled, events that are emulated by KVM will follow
> > architectural behavior (all matching vCPUs receive events, even if the
> > "match" is due to truncation), whereas APICv and AVIC will deliver events
> > only to the first matching vCPU, i.e. the vCPU that matches without
> > truncation.
> > 
> > Note, the "extra" inhibit is needed because  KVM deliberately ignores
> > mismatches due to truncation when applying the APIC_ID_MODIFIED inhibit
> > so that large VMs (>255 vCPUs) can run with APICv/AVIC.
> > 
> > Fixes: TDB
> Do you mean Trade & Development Bank of Mongolia ? ;-)

Heh, this fixes a patch/commit earlier in the series, hence the placeholder.

> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h |  6 ++++++
> >  arch/x86/kvm/lapic.c            | 13 ++++++++++++-
> >  arch/x86/kvm/svm/avic.c         |  1 +
> >  arch/x86/kvm/vmx/vmx.c          |  1 +
> >  4 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index ac28bbfbf0e3..171e38b94c89 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1104,6 +1104,12 @@ enum kvm_apicv_inhibit {
> >  	 */
> >  	APICV_INHIBIT_REASON_BLOCKIRQ,
> >  
> > +	/*
> > +	 * APICv is disabled because not all vCPUs have a 1:1 mapping between
> > +	 * APIC ID and vCPU, _and_ KVM is not applying its x2APIC hotplug hack.
> > +	 */
> > +	APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED,
> > +
> >  	/*
> >  	 * For simplicity, the APIC acceleration is inhibited
> >  	 * first time either APIC ID or APIC base are changed by the guest
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > index 340c2d3e781b..f6f328d36ae2 100644
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> > @@ -381,6 +381,16 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
> >  		cluster[ldr] = apic;
> >  	}
> >  out:
> > +	/*
> > +	 * The optimized map is effectively KVM's internal version of APICv,
> Nitpick: APICv/AVIC?

Hmm.  I think my preference for common code that doesn't need to differentiate
between Intel and AMD (or AVIC vs. x2AVIC) is to use just APICv.  "APICv" is a
mostly a KVM term, e.g. Intel uses "APIC-virtualization" as an umbrella term for
a massive pile of features, so I think bending the term to cover Intel+AMD is ok?

Typing APICv/AVIC everywhere will get tedious and creates its own flavor of
confusion, e.g. the inhibits all use APICV.
