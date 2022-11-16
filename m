Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D255E62CAB6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiKPUWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiKPUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:22:29 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0746363166
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:22:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b62so17828869pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LYQkdPPYclVVL0mv9lfUFrLftkqNX02YsTqGcI/i4s=;
        b=mYpsnOr/EviedU0QTHToHpyNTjNV1Hk2bgkyfpy6F919jZVMSEj1B4cRKwO2wmMRsh
         Fdh18hNmFxnTbS+JnTnC8Ct+VkUqUM3I2j1fI7z6TSvYH01xVLlx0hrxNIl78cuQP2DX
         sylayksZBCUnCz2qIq/zHfOETtZJBJDbuVop8oqEGhCXw43cgTQRhGHPBce/pPn2sK7n
         t5RBFy7D2XvHiBjPXe9Jx02ItOLbmQkZzTtts8g6xfBr4XqCPv/82c290UXH2xB1bm2U
         fb6wnJXEVbOqPawzL4YaWJ61x3M5r2EB9MtOEnjxUx8JGjAtUp4oawTZh4jIrQKW0U0p
         8FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LYQkdPPYclVVL0mv9lfUFrLftkqNX02YsTqGcI/i4s=;
        b=GDM9m+7SNibAD7j8rhxATrwPm0kXC/Ra1ASLv4UfArcXMIOGQWHOEcTp6nV2C6Yww5
         NIaGX25m6GxgL0zsz3ovq2q1pUWX6kxYOl/8Zn34dq8WOcHIaVlVeu08pIskbzHi9606
         hOwGOW2UeB7c3qTVi6r/bF7bVXBtoX9aPUcPrJS7tYlClMVVoWX1HITPK3pVPH+DqhAi
         1GypvCBjA4Tgo3ZC3PvbW7dkOQUNqfXjFCpM34zolCuCIh2R9dpnlSfn5ALM9KAj7AiR
         SK1UGCpc+Rw+NwUnh+UPhtxorMbpY3oO6pkk4/hjWQWoacSKhp8YhJDzKxH8MBUZSSeb
         nS2A==
X-Gm-Message-State: ANoB5pkj62e4W0IDoUlFxfpmMAMkTOph5akuKiqVuP2VuufaiNJXZXf5
        RcyjH8qL2k5ZVfxQ8argv+K1PA==
X-Google-Smtp-Source: AA0mqf5y4iEpzUBnDzzes8Cbrw1PLU42nl76HNcYIJNlTxb/BSYtwsbBOqALTB/fDZOpR1CW4mLNLQ==
X-Received: by 2002:a63:f80b:0:b0:476:f69c:2304 with SMTP id n11-20020a63f80b000000b00476f69c2304mr2175184pgh.77.1668630147417;
        Wed, 16 Nov 2022 12:22:27 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w193-20020a627bca000000b00571bdf45888sm10255955pfc.154.2022.11.16.12.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:22:26 -0800 (PST)
Date:   Wed, 16 Nov 2022 20:22:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kim Phillips <kim.phillips@amd.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/cpufeatures: Add support for cpuid leaf
 80000021/EAX (FeatureExt2Eax)
Message-ID: <Y3VGf8WsvxZ/S1aI@google.com>
References: <20221104213651.141057-1-kim.phillips@amd.com>
 <20221104213651.141057-2-kim.phillips@amd.com>
 <Y2WIy2A1RuQE/9SK@zn.tnic>
 <c00b1a65-c885-c874-79cb-16011ac82eb3@amd.com>
 <Y3TQsUmTieC4NnO/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TQsUmTieC4NnO/@zn.tnic>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022, Borislav Petkov wrote:
> On Tue, Nov 15, 2022 at 05:10:50PM -0600, Kim Phillips wrote:
> > When trying to wire up a scattered host AUTOIBRS version up to
> > kvm, I couldn't get past all the reverse_cpuid_check()
> > BUILD_BUGs demanding exclusivity between h/w and "Linux"
> > (s/w) FEATUREs.

FWIW, it's not exclusivity per se, it's to ensure that any CPUID bits KVM wants
to advertise to userspace uses the architectural definition and not the kernel's
software defined info.  This allows KVM to do things like

	if (guest_cpuid_has(X86_FEATURE_AUTOIBRS))

and guarantee that the lookup on guest CPUID, which follows the architectural
layout, will look at the correct leaf+subleaf+reg+bit.

> I guess something like below.
> 
> Sean, can you pls check the KVM bits whether I've done them all right?

Looks correct.
