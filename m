Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9A761038B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiJ0U5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiJ0U5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:57:00 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9ADA473
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:49:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12c8312131fso3889549fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gMhKdjIcVkb7+wRScD/tsvQKFhD8+gTEKVp7SkZezo=;
        b=lGZ+sBWRnyP5BGvyPx980rEGmYXua8iPzcBs7NJCcTrsuEavACBGAq7SxHpre+xhwB
         NztLWDYEDq2GIRAASFC4OzKhYSDVZIQceLIwTUidhX3y5jHv7eBdgwRG3cLS27JibyaF
         i3nQ9qUnJd2zw0o/XaAd8L3zXzCSt6gEGNM/viJs9e82PrBPppfcHOshS7GHVmy44Thq
         yXRdl9iIA9s86i4oCt2g/CiI9F2+8Wn0TmbxPcev6YNu8Bf1oVOAWX+1IYrPaZIcGFGT
         XjR/4CsQlemlAjvu6L8SD4v/MRCDVMUFIMIAgik7/8k92VO9lejaZiiz0+5utiVfPZMP
         LISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gMhKdjIcVkb7+wRScD/tsvQKFhD8+gTEKVp7SkZezo=;
        b=C+MCJHn0n3fnRF91VkX5zNqOcnu25UNh42hTPPyTcpKk9qBfOEIzwW9g4lSTokRQ67
         cuyqn++JsaOYpPxsLBJ4la9c1DiIGuwVUpa4k3AhAy+mLGptNbjFb42/A1gyjjL2zQvT
         EREx6iV+j46zT2b+IUaUd0M+EDNlNwMdvmgWIIQfx2LfZ1n45f48xyg28KF0gwniFaFB
         +x+Wes14C/aAw+AePWl9q78Ghe0Ty0uiElQUMqVT/9db1i+WH8MC15YRbLc3wVVsTXvy
         QqdrXI9LKAsJkFydEG4koV9a1WwFTDZNkNnWNU/ZH8JV5Q8krAfhv6jqxIxxBDx/qDYZ
         U9gw==
X-Gm-Message-State: ACrzQf1Exm4GT1PRPXqpbDG7oC4hjBuiQwmgMFS81KNQdGRAk1HYOb45
        uxcSDBAVFSGrsALeZz0cWPwJq8SvywagGdXbx5c=
X-Google-Smtp-Source: AMsMyM5edfi5XwySLJEj0tekv6YB1g1njior10MpJLQfO4dBgONxmY9fPrcnsyP1WHmdzHFdW9n+uRQ3Dlm2hUmjLsM=
X-Received: by 2002:a05:6870:c182:b0:12a:e54e:c6e8 with SMTP id
 h2-20020a056870c18200b0012ae54ec6e8mr6661840oad.207.1666903772503; Thu, 27
 Oct 2022 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <c124467c401e9d44dd35a36fdae1c48e4e505e9e.1666901317.git.andreyknvl@google.com>
 <20221027134433.61c0d75246cc68455ea6dfd2@linux-foundation.org>
In-Reply-To: <20221027134433.61c0d75246cc68455ea6dfd2@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 27 Oct 2022 22:49:21 +0200
Message-ID: <CA+fCnZfKmy1TTFEodbPG52ktXk819_zo4S5e6rcLyfQYJDPjWg@mail.gmail.com>
Subject: Re: [PATCH] kasan: allow sampling page_alloc allocations for HW_TAGS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:44 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Thu, 27 Oct 2022 22:10:09 +0200 andrey.konovalov@linux.dev wrote:
>
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Add a new boot parameter called kasan.page_alloc.sample, which makes
> > Hardware Tag-Based KASAN tag only every Nth page_alloc allocation.
> >
> > As Hardware Tag-Based KASAN is intended to be used in production, its
> > performance impact is crucial. As page_alloc allocations tend to be big,
> > tagging and checking all such allocations introduces a significant
> > slowdown in some testing scenarios. The new flag allows to alleviate
> > that slowdown.
> >
> > Enabling page_alloc sampling has a downside: KASAN will miss bad accesses
> > to a page_alloc allocation that has not been tagged.
> >
>
> The Documentation:
>
> > --- a/Documentation/dev-tools/kasan.rst
> > +++ b/Documentation/dev-tools/kasan.rst
> > @@ -140,6 +140,10 @@ disabling KASAN altogether or controlling its features:
> >  - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
> >    allocations (default: ``on``).
> >
> > +- ``kasan.page_alloc.sample=<sampling frequency>`` makes KASAN tag only
> > +  every Nth page_alloc allocation, where N is the value of the parameter
> > +  (default: ``1``).
> > +
>
> explains what this does but not why it does it.
>
> Let's tell people that this is here to mitigate the performance overhead.
>
> And how is this performance impact observed?  The kernel just gets
> overall slower?
>
> If someone gets a KASAN report using this mitigation, should their next
> step be to set kasan.page_alloc.sample back to 1 and rerun, in order to
> get a more accurate report before reporting it upstream?  I'm thinking
> "no"?
>
> Finally, it would be helpful if the changelog were to give us some
> sense of the magnitude of the impact with kasan.page_alloc.sample=1.
> Does the kernel get 3x slower?  50x?

Hi Andrew,

I will add explanations for all these points in v2.

Thank you!
