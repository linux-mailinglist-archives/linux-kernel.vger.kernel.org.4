Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035495B8715
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiINLNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINLNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:13:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3045E643
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:13:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a8so24545434lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hynKxUpBmUZLP/FxLm3hy+mBVxBV89eC7WIYWyCM4RA=;
        b=hZw5FTpSo/DvWzG5Z8akdgKlNmWcIBgk9FqFOjXpNCPbFWMeU9DHijYmxVQ9vrYa7B
         lEIrqpitm5cSCpF4IzYUD2/a8r+TwA3d2wh/+zrJ7nDatXOINTlwIq645fxCvSM8uPay
         kN3eEVOuAsX7uFZMy51wU5aXXsHqhI82pXonFguyOHp0X/otg7DIliqbx5HoQHaqmnt7
         P/PHBLyf1ub5NsxkNAAIN5Q6UXSO0JIcUVCUHDvw83ss0+aeAul58s+U11XYePyJqLlx
         /dM5jMxp2Dexplk3w1tOMf+Y0Pa9gBoGUhFHuoEUSw+ZNXFGZs9+BzS2W65b22DQWR4S
         YeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hynKxUpBmUZLP/FxLm3hy+mBVxBV89eC7WIYWyCM4RA=;
        b=Bh5uAAoonOgddajKK+4FXu3lMUO0khNDR5BBavwD0pQmpH90gwtS6KE/QFWH+RqsQ1
         mG6fIRdU6JpHdrCDh6wX+1p2ykN5NbWPOuO41u4QYC67injlNeL4naBBlCD0g3OfNRCw
         4Cl3KXEv62I2X0C8uIXquJ2YA0MgQHJofM+8wcTJuugeBdiAUJ0xyt5IMaYoGuvE+XVS
         fbWHch3zHuqeyb0ro9Wt+jzgk+aIJDcRqBAI1VghszaF6ZUyjPoEu++6q11CsRIseZRK
         0TkIpr0enHf5+0HDx2u1S44GwXoCGR/1o4/vGMsZl13LYtd6LBN+x6Sw/a/28a/I9xrF
         jcEA==
X-Gm-Message-State: ACgBeo1j+AqEjU8ZmGT6xo0HFgvhcO9lXN4cr8DuBOUBGki4C4mutUOo
        YxFVuHblemVawTFECQlo7Pin6cJX1/+H6PBVuUMJaw==
X-Google-Smtp-Source: AA6agR5eUjGtOI405CJb9XChyUwKm/4kQXMJttGfYrSvJ6A0BGMzTPRery1kUYItV6X7QUdtyypHG9wVI9IegfnCB0w=
X-Received: by 2002:a05:6512:2382:b0:494:9d44:a5fd with SMTP id
 c2-20020a056512238200b004949d44a5fdmr11814198lfv.494.1663153995919; Wed, 14
 Sep 2022 04:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220812183501.3555820-1-acdunlap@google.com> <20220908170456.3177635-1-acdunlap@google.com>
In-Reply-To: <20220908170456.3177635-1-acdunlap@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 14 Sep 2022 12:13:04 +0100
Message-ID: <CAMkAt6qUs526FCq26Ht48c2KVZWe=QcNds6_LE6JJbs-7Hzk+g@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] x86/asm: Force native_apic_mem_read to use mov
To:     Adam Dunlap <acdunlap@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Jacob Xu <jacobhxu@google.com>,
        Alper Gun <alpergun@google.com>, Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Sep 8, 2022 at 6:05 PM Adam Dunlap <acdunlap@google.com> wrote:
>
> Previously, when compiled with clang, native_apic_mem_read gets inlined
> into __xapic_wait_icr_idle and optimized to a testl instruction. When
> run in a VM with SEV-ES enabled, it attempts to emulate this
> instruction, but the emulator does not support it. Instead, use inline
> assembly to force native_apic_mem_read to use the mov instruction which
> is supported by the emulator.

This seems to be an issue with the SEV-ES in guest #VC handler's
"emulator" right?

If that's the case I think this should be fixed in the #VC handler
instead of fixing the code that is failing to be emulated. What if
there are other places where a testl is used and our tests have not
caught them.
