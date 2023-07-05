Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD327489F5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjGERPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGERPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:15:38 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE71990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:15:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977e0fbd742so816360766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688577330; x=1691169330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVbA+8Izu9ivmJZn/qB70KgKLBZPRbZJf6rvmQg+Ec4=;
        b=C1zCtkZe0cDfiF5Y3w7+zNdsQeOj8x8Z5PIsWL3IcPb8Iy+oz/p8plvukxsGIIs8+I
         cQXrNWnTp5T/i/SUzTOlVV/WrXM+5VXjU8IW664Ovk3TNnvSloHZty6gSD5BmhI1y/Nv
         QOzfGsziV/s7QshFwAwK4iMKLQi1Ttr5SFEhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577330; x=1691169330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVbA+8Izu9ivmJZn/qB70KgKLBZPRbZJf6rvmQg+Ec4=;
        b=j9MHWcFaYKrXRW7TnQ3r4yBA6ppDbmfcV58HE1HVNafoUh4qRY+eCBtljA8fSTdVZp
         aMqAIPrDUUvBprutbUlJTQfkxU0+vzOqrcZUDfWMoo0Y9Xs73BAkeOlvfFB6ftOyLQVC
         A95IqFevQoTYl6eRDaecdtfAdQDGovUYF1x7/pNeBavwxvokMSprwTfHMVm6EIwbLF09
         kz9Rpk44DR3vJkF/uRAWiigVNURcDRQRDYhfZFMo/NxICbvFIuwGn7SkdfbGJOwmOdDi
         XvLsqT6Tl1Ptc7jc9xgnMifxQxhedLNgXWapB0cPLry1RPzoN1jDg6VsYM6ze5KGD3ud
         XAFg==
X-Gm-Message-State: ABy/qLbOBQCG9TKWXo71mVzLtkamHv4UNgevK/7fRUCqr+cT92OEgGWn
        9a5NJf8HaHVeKnuTfFITwhvusuPMWmqKSsds0t0jmFoG
X-Google-Smtp-Source: APBJJlHqWuXaTRqiJxVA/IJTXJIfhSlybrbRjitYp040KjGCiYEzeIEeh9ecfgS1GCDRDev6Ywv5qw==
X-Received: by 2002:a17:906:72c3:b0:992:ab92:8d6d with SMTP id m3-20020a17090672c300b00992ab928d6dmr14998797ejl.74.1688577329711;
        Wed, 05 Jul 2023 10:15:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709060e5200b00993470682e5sm5396527eji.32.2023.07.05.10.15.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 10:15:29 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso6893833a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:15:29 -0700 (PDT)
X-Received: by 2002:aa7:d5c8:0:b0:51e:fb9:7f20 with SMTP id
 d8-20020aa7d5c8000000b0051e0fb97f20mr6131122eds.41.1688577328716; Wed, 05 Jul
 2023 10:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <202307041023.bcdbbfc0-oliver.sang@intel.com> <CAHk-=wi3Nb4t-JH6BGE5TOynik=-0kXyBGi3bLKTA85rvqHngQ@mail.gmail.com>
 <b57f35f9-53ae-5a99-d8b7-f1915c1cd1d0@nvidia.com> <CAHk-=wgi--892SZiqC8JWvF-vE7C+82X0VPHTCwbUpmbJWT0fw@mail.gmail.com>
In-Reply-To: <CAHk-=wgi--892SZiqC8JWvF-vE7C+82X0VPHTCwbUpmbJWT0fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jul 2023 10:15:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjieeCJd+XYWHs9bR_-Bcw_OJiHDtK8NKGDeA_C_SuBng@mail.gmail.com>
Message-ID: <CAHk-=wjieeCJd+XYWHs9bR_-Bcw_OJiHDtK8NKGDeA_C_SuBng@mail.gmail.com>
Subject: Re: [linus:master] [gup] a425ac5365: WARNING:at_mm/gup.c:#__get_user_pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 08:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll tighten it up, and switch the WARN_ON_ONCE() to just do a
> "dump_stack()" so that it won't cause problems with the syzbot tests
> either.

I pushed it out. It's based on the thing that Oliver already tested,
but expanded a bit from that (and with a better calling convention, so
that when we're done we can just delete the whole helper function and
replace it with "find_vma()" like it is supposed to just be).

It's lightly tested, but I no longer have any trivial ways to trigger
the warning, so the testing was literally "now it doesn't say anything
at all".

It should still trigger the warning by literally doing some direct-IO
GUP below the stack - but at least the obvious cases of false
positives hopefully don't trigger.

At least until somebody comes up with another obvious case that I
didn't think of ;)

               Linus
