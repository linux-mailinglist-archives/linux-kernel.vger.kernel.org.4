Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522B4740670
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 00:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjF0W0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 18:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjF0W0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 18:26:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887481FF0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:02 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b6a662b9adso36653361fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687904760; x=1690496760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DCdqBe3aTwux/JUiLDaYO3Ghr3n8qWQivFNL+JPGJsg=;
        b=JYHeSgLYM1/RRDgrCEkp7y5sC21504qUofaA2YsGjXqnKIeBwSerqNu8MwOhgK1iAJ
         ksNsH4AT5oGghq80PpxV6FYOuBeibsQliZtOcXQdRYkDDpc06UOVpeoiWeD3XosUMoyy
         CebJg1In5JrlLP/WUB19mB8qFBZbdhEWRDMmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687904760; x=1690496760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCdqBe3aTwux/JUiLDaYO3Ghr3n8qWQivFNL+JPGJsg=;
        b=befeUZeOVcTLiA4xog0ey96vUHTwtPqYQiSFYgIjun4rIVnOAkByMML+Uk0uYbAnm+
         5S51klv3uQu1N8h79arON/p6ywdNTMygcxWH1yb3MIUBTGDAXeq+HerwMUFA1K6fXSyH
         r7dXhkW/XqK5XAHMdjRwWx0/1sdk/eIlXJJz/te/nabj+999T6AgC10zdtdsEwo0qaA4
         qee8iQr5TkybGKykcWc8WURSTLd4ktzNfhSi2yDTu4lG5vcAUwOxnMhIrhSJVsaOjQXx
         pA2fqn3PqmQAOynd99i4A5xrtzs4Qe35QH0HF9zljsoPxX0WqiKa7gRcgyzGDS/hzR6d
         8n5Q==
X-Gm-Message-State: AC+VfDzkMh4SONqElIqWpKyDkRIxkj2z/Ep7tGfHL5PmH8wJ8D4Xy2Jh
        NX4DFGyyPY0/oCo6/SAqsOK4QsSLUxH9mU0dSkzLwu3S
X-Google-Smtp-Source: ACHHUZ4s3mJ2CDddjFX1+9cR2sZ4wMVIpvHBCf5+zYzxtmzvkQ7poRGjhIyIhaQimyJXWIIknzMThw==
X-Received: by 2002:a2e:9682:0:b0:2b4:8168:2050 with SMTP id q2-20020a2e9682000000b002b481682050mr17105259lji.29.1687904759817;
        Tue, 27 Jun 2023 15:25:59 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id u22-20020a2ea176000000b002adb10a6620sm1870686ljl.107.2023.06.27.15.25.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 15:25:58 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4f973035d60so6898601e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:25:58 -0700 (PDT)
X-Received: by 2002:a05:6512:2348:b0:4fb:7592:cc7a with SMTP id
 p8-20020a056512234800b004fb7592cc7amr5962097lfu.20.1687904758209; Tue, 27 Jun
 2023 15:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230627110038.GCZJrBVqu/4BfdyBeN@fat_crate.local>
 <CAHk-=wghuOwXtMH9u7RAW694BOwf_Q9TeWR2v=GgLy0gjTfu4A@mail.gmail.com> <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com>
In-Reply-To: <1982e4b4-3858-d456-6c90-92782b95726a@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Jun 2023 15:25:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
Message-ID: <CAHk-=wiQEj1cP7tnQ6Uw1jjFYnZmMdNgodga3b+rw98vBBvENg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/misc for 6.5
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

On Tue, 27 Jun 2023 at 14:44, Arjan van de Ven <arjan@linux.intel.com> wrote:
>
> fwiw long flights and pools have a relation; I made a userspace testbench
> for this some time ago: https://github.com/fenrus75/csum_partial
> in case one would actually WANT to test ;)

Hmm.

I don't know what the rules are - and some of the functions you test
seem actively buggy (ie not handling alignment right etc).

But on my machine I get:

  02:   8.6 /  10.4 cycles (e29e455e) Upcoming linux kernel version
  04:   8.6 /  10.4 cycles (e29e455e) Specialized to size 40
  06:   7.7 /   9.5 cycles (e29e455e) New version
  22:   8.7 /   9.6 cycles (e29e455e) Odd-alignment handling removed
 ...

which would seem to mean that my code ("New version") is doing well.

It does do worse on the "odd alignment" case:

  03: 15.5 /  17.8 cycles (00006580) Upcoming linux kernel version
  05: 15.5 /  17.8 cycles (00006580) Specialized to size 40
  07: 16.6 /  19.5 cycles (0000bc29) New version
  23:   8.8 /   8.6 cycles (1de29e47) Odd-alignment handling removed
 ...

I just hacked the code into the benchmark without looking too closely
at what is going on, so no guarantees.

         Linus
