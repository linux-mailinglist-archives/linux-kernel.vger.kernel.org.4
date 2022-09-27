Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1355ECEAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiI0Ugf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiI0UgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:36:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D85808A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:36:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm5so10076423plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=nyIWb4q49IeRBcTdaBjFbYmydjE1/zTC63oz1D9JAPw=;
        b=D9gQBmNQxGxcJOTmKOJ6kVMZFCat4w9oz+/TgZOTgP6RLidu+QNs96yw4wo1nU9LIZ
         MwgougQ2dAsE432LNtdp5lTY9XjiD3QB9TsieStF5Z47LwLvjJzCGuHkABhr4fmKRMFa
         +1RATpr78eb95vQbWQFgjhqPh5bgKqaUdfOEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nyIWb4q49IeRBcTdaBjFbYmydjE1/zTC63oz1D9JAPw=;
        b=cPUJzTuCx6bdd4l16VUnbBchg7TQBbe1OI/X+7/YbpLspuZw1gVGdXwyJ7/LVG+jhg
         6lBsFxKjNlAOkkPpvZV4XjHsKWvuLLW2ejARXqykdv9wGy+k36tl8P/rw9StFCTe3q3z
         vh3g4KZh1N4oZdWaeSgGNiSMLPwYty/kOAw7APBYXk51BznjHAnPJYeK9B+fqaojsV2d
         VuquMMkwFWFaR14FwueNabtIiILzpcMHSovloeZ0hWN6mCkN9Xk6A9KvSuhxLLn4wxtN
         5WByyJVPI62f3GkEXCKJ0o2CP71h8mLy+jpYIJxQx5mKjiCyFevcOY+j3tMar5QhHlut
         BNVA==
X-Gm-Message-State: ACrzQf2Yav8OamLhN+WNzP2ey1D1eoqZ8lgzGnxXLs6Jc/0ElqdiPcF9
        rnY+ocfUt57U8lMr7vJ62S1jtU2PjIZTWQ==
X-Google-Smtp-Source: AMsMyM4/besCCSzwpapZhfgCreYILpz2wG59A5E6/aSquAbWLFKw/y3HhPXq4IFXjBsBBepUb0cQTQ==
X-Received: by 2002:a17:90a:e513:b0:200:2275:2d27 with SMTP id t19-20020a17090ae51300b0020022752d27mr6483019pjy.162.1664310970338;
        Tue, 27 Sep 2022 13:36:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902f38900b001783f964fe3sm1941280ple.113.2022.09.27.13.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:36:09 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:36:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86, mem: move memmove to out of line assembler
Message-ID: <202209271333.10AE3E1D@keescook>
References: <CAKwvOd=a+0VNP-d=mHnbM4ujdtPrujru4dxHtfDo+EEM+b6deg@mail.gmail.com>
 <20220927172839.3708280-1-ndesaulniers@google.com>
 <202209271143.7B7D15D@keescook>
 <CAKwvOdk1QM4iZqEVj5MzTW3jMr1FiD_0C065Kub=EHKnH+xNaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdk1QM4iZqEVj5MzTW3jMr1FiD_0C065Kub=EHKnH+xNaw@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:01:35PM -0700, Nick Desaulniers wrote:
> > Found it (need to use %di instead of %dx). With this changed, the kunit
> > test passes again:
> >
> 
> That was stupid of me, I updated the scratch register operand in the
> instruction 2 before the one at issue and forgot to update the operand
> for the register in question, breaking the swap.

No worries! It meant I got to do a very careful review of the port. :)

> Off thread, can you show me how to run the kunit tests, please?

It's literally just what I put in the original email. KUnit is super
easy to use. In the root of the kernel source tree, just run:

	./tools/testing/kunit/kunit.py run --arch=i386 memcpy

Without --arch, it'll default to um.

-- 
Kees Cook
