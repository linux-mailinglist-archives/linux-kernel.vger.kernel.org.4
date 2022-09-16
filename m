Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B795BB468
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIPWdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIPWdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:33:37 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FCBBBA58
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:33:33 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so1082045pjk.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 15:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=X+LRZqDz1dM1ikkJpj6s9P06Sn/K9RMRujpxY1K7mfc=;
        b=m/hxBLUW6m21rY+fn3nYtSa5UCmdVT5rdAbzuJFo8RS0OVFSIq8qt9/Dz/Pio5yJcm
         pYLNfMR5jFn7NitK5tsoFZ9zMEf6edYnhLl+MXG0//KDZLR7hrzhUMQzPaziNm+9s7da
         dS7WSGjNvACSOII98uSYwgNeZP5g5bfvWXLGhX7x7lVwM3tvuQNYjXF4cLhhmKpsH3Yu
         pZVGneqk5cOTQtTEPHSlM51f8yX+Fv1kKm0ldfCbQs+SaeKCcNFye0jBO8aNfGleLEaq
         0pLGkCsu0Go+hWwgQkYF8f1R14Om8DK/XMAPq4wsljN8BlFgvBdhsm9ggICYviHDnpWW
         eoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=X+LRZqDz1dM1ikkJpj6s9P06Sn/K9RMRujpxY1K7mfc=;
        b=QD59aNRQNKEpN7iwbSgCSUh2MgSG6ymxM3bMK0RdP7G0hUvJJQqpMvlrrwdD5zaBqy
         F1W03YXaULMZp9b1+OvcPXHYvAvMrlkCm2Alu7itYad84o0VBYi1sf5sH/9Hg0gxbb0C
         BOb5vOr5EDCkunQ8LoMB6A2Se0sX/M4aLR/kN58G46oDQHKqm9tFsoGZANiqKMFIFJY7
         3CVvZCtDoSeVfN+aO45M3KER2uRM2xu3olWBqJMTFBh4DxovZM7S42AM/+T43v5/NVXV
         a9yUjSHZAHJ+B+Gcub2uD5P3h2rnrPMbPXc7SlCFDtMxkSbZUhV0uzePTFwZkNctfKN3
         0dfg==
X-Gm-Message-State: ACrzQf16dNDqIdAaTqZXbTQZbu2Um+IVrpLt9c7HLhJTo+3nsimrcr0G
        GkUsjsn0qFakwXDddhNMh3iqVw==
X-Google-Smtp-Source: AMsMyM7otmxjlL+HbRpsBaFrebRBRastUN+qypag5BcLdN+DEwzxf2D6KGUTtBuVJ7lLYbQqYbtbcw==
X-Received: by 2002:a17:902:ecc6:b0:178:3c7c:18ad with SMTP id a6-20020a170902ecc600b001783c7c18admr1997766plh.112.1663367613165;
        Fri, 16 Sep 2022 15:33:33 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090a0ad600b0020061adf86asm1980120pje.56.2022.09.16.15.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:33:32 -0700 (PDT)
Date:   Fri, 16 Sep 2022 22:33:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jim Mattson <jmattson@google.com>, Avi Kivity <avi@redhat.com>,
        Babu Moger <babu.moger@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <joerg.roedel@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wyes Karny <wyes.karny@amd.com>, x86@kernel.org
Subject: Re: [PATCH 2/5] KVM: svm: Disallow EFER.LMSLE on hardware that
 doesn't support it
Message-ID: <YyT5uW8bjXae2c4l@google.com>
References: <20220916045832.461395-1-jmattson@google.com>
 <20220916045832.461395-3-jmattson@google.com>
 <YyTZFzaDOufASxqd@google.com>
 <CALMp9eQXroxQYiWUCejd0Cj7kD5g5navWY_E2O_vzbVAQjLyNg@mail.gmail.com>
 <YyT0G9y0RRyBDiPD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyT0G9y0RRyBDiPD@zn.tnic>
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

On Sat, Sep 17, 2022, Borislav Petkov wrote:
> On Fri, Sep 16, 2022 at 02:00:26PM -0700, Jim Mattson wrote:
> > It's possible that SLES11 Xen 4.0 sets the bit, but never actually
> > uses truncated segments in 64-bit mode. In any case, according to the
> > original commit, it won't boot if setting EFER.LMSLE is not allowed.
> 
> How is SLE11 at all relevant to the upstream kernel?

Yeah, I'm inclined to revert the original commit and advertise NO_LSMLE unconditionally.
I don't like the idea of knowingly ignoring the fact that KVM doesn't correctly
virtualize LMSLE.

Xen itself already does exactly this:

  commit 23ccf530431561268b0190f0f1b740b618771b7b
  Author: Andrew Cooper <andrew.cooper3@citrix.com>
  Date:   Fri Apr 2 14:10:25 2021 +0100

    x86/cpuid: Advertise no-lmsl unilaterally to hvm guests
    
    While part of the original AMD64 spec, Long Mode Segment Limit was a feature
    not picked up by Intel, and therefore didn't see much adoption in software.
    AMD have finally dropped the feature from hardware, and allocated a CPUID bit
    to indicate its absence.
    
    Xen has never supported the feature for guests, even when running on capable
    hardware, so advertise the feature's absence unilaterally.
    
    There is nothing specifically wrong with exposing this bit to PV guests, but
    the PV ABI doesn't include a working concept of MSR_EFER in the first place,
    so exposing it to PV guests would be out-of-place.
    
    Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
    Reviewed-by: Jan Beulich <jbeulich@suse.com>

because as noted in commit f2c6084442 ("x86/SVM: correct boot time cpu_data[] handling"),
Xen broke detection of LMSLE support shortly after it was added in 2010, presumably
before any official release.  "Support" was added for HVM guests in by commit 

  727bc17d20 ("svm: support EFER.LMSLE for guests")

and then broken a few weeks later by commit
 
  566ddbe833 ("x86: Fail CPU bringup cleanly if it cannot initialise HVM.")

Note that Xen did a "safe" WRMSR+RDMSR to detect LMSLE, so either someone added
extra out-of-tree code that caused Xen to fail to boot, or "necessary ... to boot
with nested svm" only meant being able to expose SVM to L2.

Either way, KVM appears to be carrying a half-baked "fix" for a buggy guest that's
long since gone.  So like we did in commit 8805875aa473 ("Revert "KVM: nVMX: Do not
expose MPX VMX controls when guest MPX disabled""), I think we should just revert
the "fix".
