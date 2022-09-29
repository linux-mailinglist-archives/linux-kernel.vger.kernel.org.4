Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B512E5EFBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiI2R0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiI2R0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:26:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E7140F12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:26:42 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v1so1820862plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hp5MQIBdOQ5Xk6FQmwC1/qIjFwJwbOcf9xoZvfBFSSs=;
        b=RyAGnpmVQ7MHTy3FCbwhx+2SCA1IVKkyCDgY5S0n/JQkX7ciyU6WlRztNvL4tNYrWY
         P8yeb9atgz7sJsNunvKwjSto1jvT288QBV6GYqC7mDy3SZwOfgTA5t2FFXRx+RY8vD1K
         prK2Vz3hNVAMyJWXzGokK3qlkKIop5mkwV5XeVXDK9D8JowjYfW2wPcbAXwbOtCYcci0
         wpJJ4cwbTD8ShNL1hy5MkbWLlI5g2YJ3Hze+RsckkZqZfGsUhNdyzO3PbImn4y+OfjdG
         qSqThRukWMKgvEj4MkvYX/UUXLkN4msLyzS2iZukUZ1wsy+oAQDEztxkF5S0D94S0938
         CskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hp5MQIBdOQ5Xk6FQmwC1/qIjFwJwbOcf9xoZvfBFSSs=;
        b=tkyuby+Mn55xRVMRaM+L7+Q8ap4jDpjDU5VDpA0XaAP8XKpEUSKzMmloNSFStcsy6Y
         NrBiEU2YyTymeGVe/8fu1DexFmlD5pr2Vz5g6765A5GqAXWGh0Hna2tKLJc0gHFwqtIJ
         Ix8VxSqWtCad8oJwC3NagmCMJO2untkZZ+UzFH5d0oDChMZqvHC+fCBLY3Ofgv0JEFnH
         ayuKIlIfPiMhTsbihys6yUKgCsf5VHbqwUYZxoZoKqrJGJ+fMI9jfdeKw+YWS2nDQQE0
         479IYHwUDQqbbud1ZBCSp6SZWRvKH8Y2ln18Qyr9CEY5aeyWmkIzMa8zeBIxIbRvma7V
         EiGg==
X-Gm-Message-State: ACrzQf2hpFQsBWWQ3Th12OIBfOfpdiW0SD+gF5lZmsol/h03PzYxaQt/
        fWVTw5KZzVweiJN0pbuqJRIPiwaYbqHBLZm4aqPmGA==
X-Google-Smtp-Source: AMsMyM6PcJA6nad6z96ctWkFUw7ZK/KRKkinRUcyyms0OiRxIbikPJZ4kvR4bJl/I/IumZ6cAydMH85aCXmtXaokv7o=
X-Received: by 2002:a17:90b:1d0f:b0:202:be3e:a14a with SMTP id
 on15-20020a17090b1d0f00b00202be3ea14amr17447921pjb.102.1664472401750; Thu, 29
 Sep 2022 10:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdkaKTa2aiA90VzFrChNQM6O_ro+b7VWs=op70jx-DKaXA@mail.gmail.com>
 <20220928210512.642594-1-ndesaulniers@google.com> <YzVRJ3NY2w1NSoM2@gmail.com>
In-Reply-To: <YzVRJ3NY2w1NSoM2@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Sep 2022 10:26:29 -0700
Message-ID: <CAKwvOdk4bbwy6mb+uxO1BUCz5=0K7t1Xa899WnZS1VY5Sdhqkg@mail.gmail.com>
Subject: Re: [PATCH v4] x86, mem: move memmove to out of line assembler
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        llvm@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

On Thu, Sep 29, 2022 at 1:02 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Yeah, so you did various whitespace & indentation cleanups, and I think if
> we are touching trivialities we might as well fix/improve the documentation
> of this function too...

Yes, these are all wonderful suggestions.  My hope is to also improve
the readability of the implementation. I will incorporate your
suggestions into a v5 and credit you with a suggested-by tag.

> calling standards details. If we want to mention it to make it clear what
> we are saving on the stack and what not, the best description is the one
> from calling.h:
>
>    x86 function calling convention, 32-bit:
>    ----------------------------------------
>     arguments         | callee-saved        | extra caller-saved | return
>    [callee-clobbered] |                     | [callee-clobbered] |
>    -------------------------------------------------------------------------
>    eax edx ecx        | ebx edi esi ebp [*] | <none>             | eax

Oh! Perfect! I'm so glad this table exists!

> Feel free to carry these changes over into your patch.

Will do, thanks.
-- 
Thanks,
~Nick Desaulniers
