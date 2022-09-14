Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A945B8CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiINQWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:22:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A1CDB
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:22:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n23-20020a17090a091700b00202a51cc78bso13302524pjn.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=vSqGkij0iJ02LNmcxwO+X24LzA4vRR84QlahoRcoEUk=;
        b=qDwmnr7yOYUEPiNILJjSYsaLa30cmMbxBEJSZzRMbMx5G0/4KajA69yKmAVfQp+Tmx
         VEppdYXx2ij+1vOMreanK3SjSXs6Znqne8dN1Drd7f40qsSpbIoUpSNajl7FgM/vUrx+
         /BMAHez+1J6GkqSA4A+glx2JfnNKOYvdls4OnCW1pBxYID09/vN7MHEasrQ2Q9BBPgf8
         KSW+UC4hFxNSiy3o1hrOMYX6KbaLgtk+k/f5Y3AS4Nw3pCRncSeiBLo9ldFO50squcez
         NYiDT5Ctf3kwOIVngBQKi8sqkXXWgULy6VGmlpHgIDtPQLa1oQCj1wdo/KZYilqpJaV6
         ftoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=vSqGkij0iJ02LNmcxwO+X24LzA4vRR84QlahoRcoEUk=;
        b=hS2ydUi02oUTTDzH4rOjUkbSg+eKfFy/9UYOmz/RJ3EWSsNivSsnlSb7iGtDDIgboN
         1IAvNnMxWdQgvYx3ftS4xY7GS/f41O/iNnZSVzIvdxAFEZBrj/Ss7BGsHlQyOCEqRIiD
         ezvCCnkn5qbYebGVWJ2nqHaqWBOtPm3eL4Y7OIL2dfCdVbONneE4KjOfb/HZTGgGq5Pi
         pGzufI6u6phE94UOQMbejTNcSYeKkWakVn0QkwfqKtqKP1tSF/ZdTMa3Zmk5yz9LYjKC
         weGn7YD61pOG5mZ0SlVOc2cZkKkVY0SrMRN/ZRQ4B87zZmxvS7H8CZC80th6pdN9S9px
         9qVQ==
X-Gm-Message-State: ACgBeo2XPc94HIUXgejA/vaLG9QABNR7lId5ABKP46Ijc05fZQqrTXKs
        mNKFc7fHnUIhdEjaOMEiqgN+wA==
X-Google-Smtp-Source: AA6agR6rRu5Esr/QftLs4NgvC2oASCOgWLDyAbveVyj+N+p6xnapdY9Xw5HMK9dDqvSwfRgWL69VgQ==
X-Received: by 2002:a17:902:8486:b0:171:48cd:1356 with SMTP id c6-20020a170902848600b0017148cd1356mr35858433plo.153.1663172536881;
        Wed, 14 Sep 2022 09:22:16 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a318800b002005114fbf5sm5302312pjb.22.2022.09.14.09.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:22:16 -0700 (PDT)
Date:   Wed, 14 Sep 2022 16:22:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Peter Gonda <pgonda@google.com>, Adam Dunlap <acdunlap@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
Message-ID: <YyH/tOqrl8pZmoub@google.com>
References: <20220812183501.3555820-1-acdunlap@google.com>
 <20220908170456.3177635-1-acdunlap@google.com>
 <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
 <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2625dbfa-434c-7d55-6469-9d9e89397e8f@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022, Dave Hansen wrote:
> On 9/14/22 04:13, Peter Gonda wrote:
> > On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
> >> Previously, when compiled with clang, native_apic_mem_read gets inlined
> >> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> >> run in a VM with SEV-ES enabled, it attempts to emulate this
> >> instruction, but the emulator does not support it. Instead, use inline
> >> assembly to force native_apic_mem_read to use the mov instruction which
> >> is supported by the emulator.
> > This seems to be an issue with the SEV-ES in guest #VC handler's
> > "emulator" right?
> 
> No.
> 
> It's not just an SEV-ES thing.  It's a problem for TDX and _probably_ a
> problem for normal virtualization where it's a host-side issue.  Kirill
> wrote a lot of great background information in here:
> 
> > https://lore.kernel.org/all/164946765464.4207.3715751176055921036.tip-bot2@tip-bot2/
> 
> So, the question is not "should we extend the MMIO instruction decoders
> to handle one more instruction?".  It is "should we extend the MMIO
> decoders to handle *ALL* memory read instructions?"
> 
> That's an even more emphatic "NO".

+1, keep the guest-side decoding as simple as possible.

> readl() seems to be the right thing to do.  Also, Dear TDX, SEV and virt
> folks: please look for more of these.  They're going to bite you sooner
> or later.  You should have caught this one before now.
