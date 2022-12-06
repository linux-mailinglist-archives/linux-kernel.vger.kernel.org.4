Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB726449F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiLFRIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiLFRIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:08:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874B817E1E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:08:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso18657108pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ov+WjnBNqjWs1af+hraj4YEzPtdcPglGlTeqAHbyJPo=;
        b=FHOo4H2DwPVm0CqEEA/q06AKzsUcuFmns83OwxgFGIlQelD4uW5LjTsSKxm0wDywSo
         CQLr7zoLiDaNDQqazIfwY0Y88qaUB3U9q+7hJQhgzGf+vTlbHUjOA53/5mmCLsvR5DFE
         CCg6uJg8vLWc65bLwJCwfbpJsQAjqbA69DON+HB5v/hGkMTFeFr7P0SsN2T9NbD1rt3A
         IQ12K15mbR5Ky+YEA4ynHwL/+b7LeHLPZR8rpGHMWFmABulKYekzfC8d1Yduo3GqmLHm
         PfEMqWu43iwjJe0PDy2epKU1ZPFRX2nclunN0Ae8b9SuFP6XROxonn9ANoLhBSZMEy/B
         wS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ov+WjnBNqjWs1af+hraj4YEzPtdcPglGlTeqAHbyJPo=;
        b=uYTlngEiZvhTnRfinSu+V7p/4IHfFNPjFLlpF88U3zqHKo4lTd0WHh+Ru/qqwEZjoL
         cPmooLdA3Q327DJElq5L1Tu5JdG6ErN3h7DX4/df/wSQ/P5k+j+JhUa6MqhYclN3eDYy
         OlQpu8+8HxdDJkuGx9t6FzHrGpFPLRY4YceUlAG8rFL7khoxHPkfSne+CC25zQGssK1E
         6Cp6GSQxB/FypIx1SGf+S6L7BUXAtP+KmGjSgH13fR0cQskDoCMbWJM5foQd2OZeoMen
         bciiRbuR+3Jqb0sIEr7LwoxnEmb9MnJzYUFqL7cDidmMMVAGiJ7AA7sPwUI+CEwYOopL
         ZSXQ==
X-Gm-Message-State: ANoB5pnL7zPA0n0YTYONNoIjd7XU2pNBbgTyfG+fKAUlP2Zt0sjkh8HP
        NzamZt7o3L9YclG39ooxtEDNhQ==
X-Google-Smtp-Source: AA0mqf7hA5/u0JLWZH7lY75a8vR5qIzNdl9UVLDNfusQbeAaUMqt7F4iCUyjLfDKe8ItbxVUl6QZuQ==
X-Received: by 2002:a17:902:c1ca:b0:189:e149:a1b2 with SMTP id c10-20020a170902c1ca00b00189e149a1b2mr7524064plc.17.1670346482909;
        Tue, 06 Dec 2022 09:08:02 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id p3-20020a1709026b8300b001898ee9f723sm12908572plk.2.2022.12.06.09.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 09:08:02 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:07:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Sterritt <sterritt@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH kernel 1/3] x86/amd/dr_addr_mask: Cache values in percpu
 variables
Message-ID: <Y4927u7hjK+REsNr@google.com>
References: <20221201021948.9259-1-aik@amd.com>
 <20221201021948.9259-2-aik@amd.com>
 <Y4jdIl1elcnL8JUU@google.com>
 <b28f0cb9-b321-cc55-db31-61296e1a494e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28f0cb9-b321-cc55-db31-61296e1a494e@amd.com>
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

On Tue, Dec 06, 2022, Alexey Kardashevskiy wrote:
> 
> On 2/12/22 03:58, Sean Christopherson wrote:
> > On Thu, Dec 01, 2022, Alexey Kardashevskiy wrote:
> > > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > > index cfdf307ddc01..c4324d0205b5 100644
> > > --- a/arch/x86/include/asm/debugreg.h
> > > +++ b/arch/x86/include/asm/debugreg.h
> > > @@ -127,6 +127,7 @@ static __always_inline void local_db_restore(unsigned long dr7)
> > >   #ifdef CONFIG_CPU_SUP_AMD
> > >   extern void set_dr_addr_mask(unsigned long mask, int dr);
> > > +extern unsigned long get_dr_addr_mask(int dr);
> > >   #else
> > >   static inline void set_dr_addr_mask(unsigned long mask, int dr) { }
> > 
> > KVM_AMD doesn't depend on CPU_SUP_AMD, i.e. this needs a stub.  Or we need to add
> > a dependency.
> 
> The new symbol is under CONFIG_CPU_SUP_AMD and so is its only user
> arch/x86/kernel/cpu/amd.c:
> 
> arch/x86/kernel/cpu/Makefile:
> obj-$(CONFIG_CPU_SUP_AMD)               += amd.o
> 
> 
> Is this enough dependency or we need something else? (if enough, I'll put it
> into the next commit log).

No, it's actually the opposite, the issue is precisely that the symbol is buried
under CPU_SUP_AMD.  KVM_AMD doesn't currently depend on CPU_SUP_AMD, and so the
usage in sev_es_prepare_switch_to_guest() fails to compile if CPU_SUP_AMD=n and
KVM_AMD={Y,M}.

  config KVM_AMD
	tristate "KVM for AMD processors support"
	depends on KVM

I actually just submitted a patch[*] to "fix" that since KVM requires the CPU vendor
to be AMD or Hygon at runtime.  Although that patch is buried in the middle of a
large series, it doesn't have any dependencies.  So, if this series is routed through
the KVM tree, it should be straightforward to just pull that patch into this series,
and whichever series lands first gets the honor of applying that patch.

If this series is routed through the tip tree, the best option may be to just add
a stub to avoid potential conflicts, and then we can rip the stub out later.

[*] https://lore.kernel.org/all/20221201232655.290720-12-seanjc@google.com
