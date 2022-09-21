Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977BA5C047B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIUQoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIUQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:43:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BDEA61CC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:32:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso4300707otb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=owGl3Io+npGkA8eaNCMVOu227jlJ2Vgtm7TTFjJLRxI=;
        b=HUjuRTVw6cNX0ZAtqowgeKvNX5zNo2mAw3inTtG6WnQ4k2Nnx1T0FdKt9PqUcyViaK
         CTSR1g03EVMJ8g0Z4wTWhWPlsG55xlH3rBQeAK5c10p9WvWl7Ed4gBog5Z5gluklPMsO
         +4tiXnwgTXxKkP2Ror0CdVYeMdReT8KyOg3IP6eDtJ35opJRfbAcD1eOb9CsEbvSEX+V
         9u8Vze2he8Xe8Ho8odXn7OfulB/HNplc4G5yPCWaMLRsYGMb0R5N4Qp2ZwCd4baJ3yiz
         qt60huPERI3Y44AzKBbpZo0FPzXQEW59JGclw4s0WHCmQv4GlepCXKNvwe8mzsIKvrPa
         VQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=owGl3Io+npGkA8eaNCMVOu227jlJ2Vgtm7TTFjJLRxI=;
        b=URPTzqLaBGBk37tn4z32vT8ldUeBSXX9EMExujas8Rq86EE4ICqhBhYuovFNayJgzs
         OlxH0Etdx2qPqCpfj1OfJb3spaKVgxNhmTAxv6S16xU2Vi5UwfMCSKoWbFP8GwAXuFG9
         l+ZQOqDLMECKhLIPtn2eB9bA757SkPb3U7DGKFncvcX39GXaPSAlusNSfM5HlVhPA78y
         U44XCjTCjHXAbhnzraEaz1XlGsRr3dYD4UO0yjYOpP9zdcJyB8syXHM2Gl9g75mxLPIz
         4NvkDgOF2uZl/0h7V61yuRqhY7wn9B6Zq3OU8ANMXg33k0ArEDrTeymdtMNQYs6a1R22
         DE+A==
X-Gm-Message-State: ACrzQf2YeFjLoqCiX3Qs9Gc/4g7BjV0PE2dVO8xWFlvn7fEQ7Ix9NSwF
        aDY7AA4e+gAtVisP07OyWfECMSJHI7AR7AKlHY1mOw==
X-Google-Smtp-Source: AMsMyM4PorEITJssr5Q8qYX2Dg72jU4UXiH+m4/+alkfdmgg42ZuaAwAPifTuaC2yMiE3fohhbyMW483+oym4qFQ4Ro=
X-Received: by 2002:a9d:6296:0:b0:656:761:28bc with SMTP id
 x22-20020a9d6296000000b00656076128bcmr12864376otk.14.1663777956576; Wed, 21
 Sep 2022 09:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220908114146.473630-1-kraxel@redhat.com> <YxoBtD+3sgEEiaFF@google.com>
 <20220909050224.rzlt4x7tjrespw3k@sirius.home.kraxel.org> <20220921134246.xibospqoktp4wjie@sirius.home.kraxel.org>
 <Yysm8/Nkt6EUI5+k@google.com>
In-Reply-To: <Yysm8/Nkt6EUI5+k@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Sep 2022 09:32:25 -0700
Message-ID: <CALMp9eRkXPPWbPfm16onV9+ondg0x7_RG5ku7hCpBAODLWpSgw@mail.gmail.com>
Subject: Re: [PATCH] kvm/x86: reserve bit KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID
To:     Sean Christopherson <seanjc@google.com>
Cc:     Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 21, 2022 at 8:00 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Sep 21, 2022, Gerd Hoffmann wrote:
> > On Fri, Sep 09, 2022 at 07:02:24AM +0200, Gerd Hoffmann wrote:
> > > On Thu, Sep 08, 2022 at 02:52:36PM +0000, Sean Christopherson wrote:
> > > > On Thu, Sep 08, 2022, Gerd Hoffmann wrote:
> > > > > -#define KVM_HINTS_REALTIME      0
> > > > > +#define KVM_HINTS_REALTIME                      0
> > > > > +#define KVM_HINTS_PHYS_ADDRESS_SIZE_DATA_VALID  1
> > > >
> > > > Why does KVM need to get involved?  This is purely a userspace problem.
> > >
> > > It doesn't.  I only need reserve a hints bit, and the canonical source
> > > for that happens to live in the kernel.  That's why this patch doesn't
> > > touch any actual code ;)
>
> The issue is that this "hint" effectively breaks other VMMs that already provide
> an accurate guest.MAXPHYADDR.

Any VMM that doesn't provide an accurate guest.MAXPHYADDR is broken.
Why do we need a "hint" that the virtual processor works?

> > > > E.g. why not use QEMU's fw_cfg to communicate this information to the
> > > > guest?
> > >
> > > That is indeed the other obvious way to implement this.  Given this
> > > information will be needed in code paths which already do CPUID queries
> > > using CPUID to transport that information looked like the better option
> > > to me.
> >
> > I'd like to move forward with this.
> >
> > So, any comment further comments and opinions?
> > Is it ok to grab a hints bit given the explanation above?
> > Or should I go for the fw_cfg approach?
>
> My strong preference is the fw_cfg approach, or if the guest side really wants to
> use CPUID, have QEMU define it's own CPUID signature and provide QEMU-specific
> hints/quirks that way.
