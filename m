Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB863FB90
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLAXER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLAXEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:04:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D7014010
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:04:11 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id k79so3288563pfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W7ijYylxUlOoeQtdtF6kT3zAM5GViSLLIl08bRLs7MM=;
        b=E3vRunbo0HgwDtwX7OVdTs6JFQl5ai1mZXR7yUYYEQthOtIOWOTpG7yAmuwUC2tENQ
         bvlHnfz+PfsTeILCC6wxbE3Flq+HUS3UkX4IhWhaL41M6WHvdOiKxFNFzRGAIFdtt4Y+
         rej5Pji19wjr/sC7AUZgSFQiXTjHma1kxIC/q+g3PYLqg5gx8ZqsiZb+BVlf88G4FJgH
         P/pcFUSZ7+MAL/ch/KCkmS02moTt4HE/kR9xAeCpJRDmZHJHTal7k3mFLGEX3M+H0mDm
         06c3Hbf2rqBLdGoVxS0kH5vqz1uN+dbCw+PDQ6Hx917LSSKvRwDBR66FzXdSnWhXSrv1
         L++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7ijYylxUlOoeQtdtF6kT3zAM5GViSLLIl08bRLs7MM=;
        b=YTyZKmVQDonkFr9IHI5feU40TWUP9XYlhDxmNEJo1gdjxhwPfZIS5mBocTLWjMH6PH
         fxe1w/W2HFNNBmTYRCTbXw89UIB3qgHIerWULDPstNpiHMN7T6oZlGT82RlXFfZxq/uc
         Q/BXRKN46ZqC0O+xwU7rfzdv0cn5yw0XPpbnki8EIAtEJRDilxlmdb7Y1IiGyV6+1QM5
         KzzpW9yBoUZXJmEqeLPPmIFdIz7T1atTGoqwIWCT7obpwXzczj7KQ62895GURTF8IzMM
         3CWDCW8XZ40UmHjjE9kLUj9ihPyfATWj1IHwmKn/aV1vPG+5v/B8LfzEbCBXxGpmVp/u
         qKkA==
X-Gm-Message-State: ANoB5pmFXOtVHAblUwjs8Ue9Pi1wlEvounTgyQYC3WSxXzPz/w7DPS24
        32larhDqovGi/CZqyQ2jfociuw==
X-Google-Smtp-Source: AA0mqf5y4C7UEUE7FQZWCrunBYgD49tkcMZZCJs0aHp0pTtDY+WJyxmiBfPo0JUsF5BMTOKxZzSdpg==
X-Received: by 2002:a62:33c4:0:b0:572:9681:1018 with SMTP id z187-20020a6233c4000000b0057296811018mr52855741pfz.39.1669935851002;
        Thu, 01 Dec 2022 15:04:11 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id cp6-20020a170902e78600b0018986ba1db9sm4129196plb.284.2022.12.01.15.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:04:10 -0800 (PST)
Date:   Thu, 1 Dec 2022 23:04:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "stable@vger.kernel" <stable@vger.kernel>
Subject: Re: [PATCH v4 2/4] x86/virt: Force GIF=1 prior to disabling SVM (for
 reboot flows)
Message-ID: <Y4ky5hFWvSc8Km78@google.com>
References: <20221130233650.1404148-1-seanjc@google.com>
 <20221130233650.1404148-3-seanjc@google.com>
 <eb226c49-9da3-ae11-071b-5474c2b64364@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb226c49-9da3-ae11-071b-5474c2b64364@citrix.com>
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

On Thu, Dec 01, 2022, Andrew Cooper wrote:
> On 30/11/2022 23:36, Sean Christopherson wrote:
> > diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
> > index 8757078d4442..0acb14806a74 100644
> > --- a/arch/x86/include/asm/virtext.h
> > +++ b/arch/x86/include/asm/virtext.h
> > @@ -126,7 +126,18 @@ static inline void cpu_svm_disable(void)
> >  
> >  	wrmsrl(MSR_VM_HSAVE_PA, 0);
> >  	rdmsrl(MSR_EFER, efer);
> > -	wrmsrl(MSR_EFER, efer & ~EFER_SVME);
> > +	if (efer & EFER_SVME) {
> > +		/*
> > +		 * Force GIF=1 prior to disabling SVM, e.g. to ensure INIT and
> > +		 * NMI aren't blocked.  Eat faults on STGI, as it #UDs if SVM
> > +		 * isn't enabled and SVM can be disabled by an NMI callback.
> 
> I'd be tempted to tweak this for clarity.
> 
> How about "We don't know the state of GIF, and if NMIs are enabled,
> there is a race condition where EFER.SVME can be cleared behind our
> back.  Ignore #UD, and force GIF=1 in case INIT/NMI are currently
> blocked."  ?
> 
> The STGI can't actually #UD on real hardware, because SKINIT and SVM
> exist in identical sets of parts, but it can #UD in principle in a VM
> which doesn't offer emulate SKINIT.

Ah, right, "may #UD", not "will #UD".  And despite writing this, I also keep
forgetting why forcing GIF is even necessary.  How about?

		/*
		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
		 * aren't blocked, e.g. if a fatal error occurred between CLGI
		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
		 * context between reading EFER and executing STGI.  In that
		 * case, GIF must already be set, otherwise the NMI would have
		 * been blocked, so just eat the fault.
		 */

> Given that we are in cpu_svm_disable(), there's also
> MSR_VM_CR.INIT_REDIRECTION to consider, but perhaps that's better left
> to the series which adds SKINIT support.
> 
> ~Andrew
