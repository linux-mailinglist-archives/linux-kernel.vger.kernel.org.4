Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A26C53C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjCVSd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:33:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B2D132E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D50ECE1D2E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBFAC433EF;
        Wed, 22 Mar 2023 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679510001;
        bh=8sgbiQ5GWQMIb7f1SUhqvJcyq2pw/WxgGPM5+WJNN90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjk8xzpSudwSb3umMZyFNtnq+zAtHui6AzDhkWQenYYn9f3WkUIoKOMDWXBe2765M
         GHl+dTopZ8A/Rmhg+mb33Ww7v+eDrx2y8SWgDGwSC/i/jo+nA5gT194Gn4eA29FzZw
         vqT2JOxAwCAwh59yhe1S8qwIffFuZXoLkBon9WyydSCJAgWee6lk9vUbBan66f2LLv
         rdMyds1OHOiOGM63Z8T9S9aHfBxy/Cm3JHJdGwlIRsnv2UVR275JNHAQhJKgKbTukY
         Ir6tgwTHnzggPbclqAoIC0BngMZPRloVfVAywH8dwFsuHeHhJ66xuW1eJsKvbzSvie
         o0ANA4NX1qyQA==
Date:   Wed, 22 Mar 2023 11:33:18 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/11] arm64/static_call: Fix static call CFI
 violations
Message-ID: <20230322183318.pqu2jjmi33j4an33@treble>
References: <cover.1679456900.git.jpoimboe@kernel.org>
 <3d8c9e67a7e29f3bed4e44429d953e1ac9c6d5be.1679456900.git.jpoimboe@kernel.org>
 <CABCJKuf5hsddHpnON5q9LpAXr-8s=5dL0iTpRD-hFzcBynB+Gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKuf5hsddHpnON5q9LpAXr-8s=5dL0iTpRD-hFzcBynB+Gw@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 11:07:21AM -0700, Sami Tolvanen wrote:
> > +/*
> > + * Make a dummy reference to a function pointer in C to force the compiler to
> > + * emit a __kcfi_typeid_ symbol for asm to use.
> > + */
> > +#define GEN_CFI_SYM(func)                                              \
> > +       static typeof(func) __used __section(".discard.cfi") *__UNIQUE_ID(cfi) = func
> 
> Couldn't we just use __ADDRESSABLE instead of adding a separate macro?
> The type of the variable shouldn't matter here, as long as we take the
> address of func.

Oh I did pretty much reimplement __ADDRESSABLE didn't I ;-)

-- 
Josh
