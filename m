Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFC4624A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiKJTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKJTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:01:15 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5A31FB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:01:15 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e129so2535343pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ4iusZn3r+L1hT830DTYjpIyjYe1oSN3vop8euZ9js=;
        b=dX+k1YnOeAISPqobM+n+g0B46aJ5fAG0J2icXb75RVgG7m4M4JAPreDmVp9TF/QWCx
         SIYxqYixGj5DCJ6xRMUmqee0H6CdlOFz6QrWkpC8hOaHc43jy0B+bY2R7jhmFP6IOUjQ
         ZBCWl4wpzdiWXhB5fM0kK+rNoQ+eN33Dr39xn2rBc+htjyWsMzNQsbm4wgHWFhPbAp9v
         kjNlUwAYLJ5lAupS13Ed36qmjFUCvJki24AMPeH8mwZk+ryLrqd+XSY53Gjpge338tAM
         focXQhiB6s1N7m5+FGGICce46iDvv5MvpJfmOwJmmMcNN8wX2F0frI8KoPt4xc8vsFOS
         do/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQ4iusZn3r+L1hT830DTYjpIyjYe1oSN3vop8euZ9js=;
        b=N87Qstn9L/I81cdhJWXQ31LESPKn9eYi1c+1FywU3SIa6YEEN8Re+He1etpzWGsG8I
         eYVA7zwx+tbQJlwqHh28RBWtPTpqWWg6Gs75dp6phBs73ZdnK2J09+Q8/XEaIJNv2+4q
         bfEMculcsywkyE4f6ccjH9KF1Ppus6NRNNjYXKDNGZYLAflJLJx4c71rAA9KfLTO/HSJ
         mlbjqcoo+PkNeX0B5cm572h6BrQTKLq4oxYswlhO/Av/QHPTWnvR77zCLbRfd3bBkODy
         q5kTsw+GPA7m8yRubz1ElIRnLmG+iiTLNL1biE1XR0ZXJQy4bVKkY6/X+VPas7rtXhRu
         2JgQ==
X-Gm-Message-State: ACrzQf32OOJuPF4+AwKbZPDvPKPrvALoqRYg7CqaA0yyA7TjHiKkh4GE
        wPrNkyfm/5HMuSXkoyKLDybM9rDeI0NUq8SB5g7fgQ==
X-Google-Smtp-Source: AMsMyM6cMvQ+CdiTjFykH6PT7aBlUZq2UXynv4j2dxgS4TWMNFM/mgc0MVvi+yNwuV9l3w/SgxLXb/1R37Erlf0LIZw=
X-Received: by 2002:a63:586:0:b0:46f:75bb:cfc4 with SMTP id
 128-20020a630586000000b0046f75bbcfc4mr3099016pgf.403.1668106874281; Thu, 10
 Nov 2022 11:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr> <20221106095106.849154-3-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20221106095106.849154-3-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Nov 2022 11:01:02 -0800
Message-ID: <CAKwvOdmN2==9tG0fxRO8K-eAJudeemaKUuhJEAuGHc=P8GpGwA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] x86/asm/bitops: Use __builtin_clz*() to evaluate
 constant expressions
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Borislav Petkov <bp@suse.de>
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

On Sun, Nov 6, 2022 at 1:51 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
>  #ifdef CONFIG_X86_64
> -static __always_inline int fls64(__u64 x)
> +static __always_inline int constant_fls64(u64 x)
> +{
> +       BUILD_BUG_ON(sizeof(unsigned long long) != sizeof(x));

Thanks for the patches! They LGTM; but why do we need this BUILD_BUG_ON here?

> +
> +       if (!x)
> +               return 0;
> +
> +       return BITS_PER_TYPE(x) - __builtin_clzll(x);
> +}

-- 
Thanks,
~Nick Desaulniers
