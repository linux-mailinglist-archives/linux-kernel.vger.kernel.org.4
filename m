Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C0A6251BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiKKDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKDgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:36:08 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B4532EB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:36:04 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13b103a3e5dso4305578fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DLwFbcaXxTI8kikK3HOdCc4Gv3JptkdKvwplZAgy8k=;
        b=OYIyNKzRqiJ/IBm8jZEy1s86exNHopq9GLHeciOSXKsdvehkCc8rSKpiF5j26lRNzV
         wi4KrlsK09NARYT1dUkCG3vjOSa/2PLVbszy+5yt38Oa3/AqUUllaY5LECI55EC7l3Uz
         vtZEvB9GmAuQGXDjKQt52o9BIMvAGfHCaShiLzpEB9PlMuiYEniy+5zJElpjT6GeFxLQ
         fYJw0cOTdNJ+kqYaboV8hg5tXKkL7ykXTHejmprag7k5wUHPYhls2eD12EINTBzeG1Fs
         wvC8VabL9eVdqNn6cilcR+SR/58QfqBe7llnHnqJbLuyGlMKHNXRxPyuD7Tyli3M2vpV
         8HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DLwFbcaXxTI8kikK3HOdCc4Gv3JptkdKvwplZAgy8k=;
        b=aYHFZ1JRj04PWVtYBDDrjd5oJk8XLPwbS8EWelBQJUh4pFPTSXOHgjjN0VrsenaKz6
         PP/Mh8fhsxuOV0CQoxZUjpXLgRTZmUV3eCQwnu50ECw505a3mT84G253OYYGS9ncMUYh
         pP9995OeMt5w+UwBrEQkvh/x7V8vrYYmnL7z20PDbEPVUhKHTZbZCLiyER2bALvwRq5W
         e3XSojQRkksJyjc3IpcTBEKHyF2M4dzWtO85wbHhVrvWQTig1znpgixo3XjEZGXecCsL
         hGYgTGmsZ8YzwCCDhPRto3PPK3xy9ZlxlpdSH4NA2Oqq4vyJBuRTLlYGObwbe0+PfcW1
         aLYg==
X-Gm-Message-State: ACrzQf1XU16xMhP1j3lwy0s7xZryFl62nFpfzdLwlqhdJKl+urv2eFDR
        xz7unC7W8H7aAJp0Y2qTMD8=
X-Google-Smtp-Source: AMsMyM6xUVKjYV9avOHlFJglZ7Y6zjTj1Snpe5pE9oJ3XB087NLGOAAOX7OfDjtllBmrcuuYjpQakQ==
X-Received: by 2002:a05:6870:2a43:b0:13b:c2c7:8c54 with SMTP id jd3-20020a0568702a4300b0013bc2c78c54mr2732710oab.242.1668137763127;
        Thu, 10 Nov 2022 19:36:03 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id h24-20020a9d6f98000000b00661b46cc26bsm578495otq.9.2022.11.10.19.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 19:36:02 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:36:01 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v1 2/2] x86/asm/bitops: Use __builtin_clz*() to evaluate
 constant expressions
Message-ID: <Y23DIRG60iaei7Ft@yury-laptop>
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr>
 <20221106095106.849154-3-mailhol.vincent@wanadoo.fr>
 <CAKwvOdmN2==9tG0fxRO8K-eAJudeemaKUuhJEAuGHc=P8GpGwA@mail.gmail.com>
 <CAMZ6RqKRP3cp=FhpA6DkKNKjgRV2ak18k=Ad-mnBPkT++gARCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqKRP3cp=FhpA6DkKNKjgRV2ak18k=Ad-mnBPkT++gARCA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:57:17AM +0900, Vincent MAILHOL wrote:
> On Fri. 11 Nov. 2022 at 04:01, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > On Sun, Nov 6, 2022 at 1:51 AM Vincent Mailhol
> > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > >  #ifdef CONFIG_X86_64
> > > -static __always_inline int fls64(__u64 x)
> > > +static __always_inline int constant_fls64(u64 x)
> > > +{
> > > +       BUILD_BUG_ON(sizeof(unsigned long long) != sizeof(x));
> >
> > Thanks for the patches! They LGTM; but why do we need this BUILD_BUG_ON here?
> 
> There is no absolute need for sure.
> 
> Call this a paranoiac check and you will be correct. My reasoning for still
> using it is that:
> 
>   1/ It is a compile time check, so no runtime penalty.
>   2/ Strictly speaking, the C standard doesn't guarantee 'u64' and
>      'unsigned long long int' to be the same (and you can argue that in clang
>      and gcc long long is always 64 bits on all platforms and one more time
>      you will be correct).
>   3/ It serves as a documentation to say: "hey I am using the clz long long
>      version on a u64 and I know what I am doing."
> 
> If you want me to remove it, OK for me. Let me know.

In fact, compiler's typecheck would be more strict than your BUG().
For example, your check allows pointers, but compiler will complain.
