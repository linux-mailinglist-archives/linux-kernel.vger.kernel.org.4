Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4096F9CE6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjEGX6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 19:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEGX57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 19:57:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1263C1B
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 16:57:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac7707e34fso45493901fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 16:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1683503875; x=1686095875;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=heWdWnuVsDgy3YSrIEI7KZvF6zrJpOnz1cwOgPMljgY=;
        b=GzRn0fYn5L+kd6X0Fe48aiNfUfW6wkqLabswGuWW5mgWqR/2GjUF84ljLns2d+o1sg
         a6vuGpW1z3TO+tfiggPQdcXC+NEPg8Gh+PNIyfpCncjeBL1vTkaxKrMTeCu23pZd3yit
         6CGMwxzuMtyjwtR5iJ0TuEsqd/d/2ICCNAm4Cn4ajDtiHfe8Ianjb+FNkEzlklqzN2QL
         jkIr4lE+mJBktzp3KrpGdeIFLkglGatWFaYxPDWX00GYxlYGVOTsBpq/x6aGVc/tklVC
         ZeZZVQrSP2pHCxqWHvyGLCe+VZwLSj97UPEe64VFJlxifThdQuL0WWJMJ6f1a+LGsuXU
         6Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683503875; x=1686095875;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heWdWnuVsDgy3YSrIEI7KZvF6zrJpOnz1cwOgPMljgY=;
        b=V2Oofx0AtAyB88XK+8qt6NbLgC6DMdIn7849hmnVxrq9cFYGtCkFrsI71HBh8CUu7x
         GlMt6edDHCF48bFzZnPPjOKgPcIl7rGV2pTJ1Uy5DejfgeZHHFqdTtegUL/bBA26yYnc
         KHVnzwH1Jnm3Z+CpkA3sVd3lfHsdNcKEfBy5SzGFer8AUWveY9GQ5i55gtwMEU6mp4jl
         xppXQu86HeIGO/vEi5vR/dmocaZYtxDXR72jnI6DIMDZVQQVRADmcq73UoN3QDnuWFKQ
         VKlz8yOZqDFfNCPkofIHawvKC6iygUN17eDpBrTSraWzWfYmwbZPw27+u63VwL2UUplz
         3H6g==
X-Gm-Message-State: AC+VfDyMc6wvlo7y7Tc5Zt9wMC7q9NheCS9MwYbyqFNU1x2KxtulVQzf
        oNGuN5WgBWDYoJAi4T29amfhKA==
X-Google-Smtp-Source: ACHHUZ5KDAewVtMMEUBKPDOXSl6kc4Kl99MUiOwLSnK0jQvpZ9OmWx9CGYgRWJyoQRHGvIlZiklKYQ==
X-Received: by 2002:a2e:9bcb:0:b0:2ac:8090:630e with SMTP id w11-20020a2e9bcb000000b002ac8090630emr2346480ljj.28.1683503875097;
        Sun, 07 May 2023 16:57:55 -0700 (PDT)
Received: from localhost (77.241.128.113.mobile.3.dk. [77.241.128.113])
        by smtp.gmail.com with ESMTPSA id s15-20020ac25fef000000b004f01ae1e63esm1086678lfg.272.2023.05.07.16.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 16:57:54 -0700 (PDT)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <ZFg0xPy0dbd1b0rP@bombadil.infradead.org>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Subject: Re: [RFC PATCH 00/11] Rust null block driver
Date:   Mon, 08 May 2023 01:37:19 +0200
In-reply-to: <ZFg0xPy0dbd1b0rP@bombadil.infradead.org>
Message-ID: <87mt2fae4i.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luis Chamberlain <mcgrof@kernel.org> writes:

> On Wed, May 03, 2023 at 11:06:57AM +0200, Andreas Hindborg wrote:
>> The statistics presented in my previous message [1] show that the C null block
>> driver has had a significant amount of memory safety related problems in the
>> past. 41% of fixes merged for the C null block driver are fixes for memory
>> safety issues. This makes the null block driver a good candidate for rewriting
>> in Rust.
>
> Curious, how long does it take to do an analysis like this? Are there efforts
> to automate this a bit more? We have efforts to use machine learning to
> evaluate stable candidate patches, we probably should be able to qualify
> commits as fixing "memory safety", I figure.
>
> Because what I'd love to see is if we can could easily obtain similar
> statistics for arbitrary parts of the kernel. The easiest way to break
> this down might be by kconfig symbol for instance, and then based on
> that gather more information about subsystems.
>

I spent around 4 hours with a spreadsheet and git. It would be cool if
that work could be automated. It's not always clear from the commit
heading that a commit is a fix. When it is clear that it is a fix, it
might not be clear what is fixed. I had to look at the diff quite a few
commits.

There is some work mentioning the ratio of memory safety issues fixed in
the kernel, but none of them go into details for specific subsystems as
far as I know. 20% of bugs fixed in stable Linux Kernel branches for
drivers are memory safety issues [1]. 65% of recent Linux kernel
vulnerabilities are memory safety issues [2]

> Then the rationale for considerating adopting rust bindings for certain areas
> of the kernel becomes a bit clearer.

As mentioned elsewhere in this thread there are other benefits from
deploying Rust than provable absence of memory safety issues.

Best regards
Andreas

[1] http://dx.doi.org/10.15514/ISPRAS-2018-30(6)-8
[2] https://lssna19.sched.com/event/RHaT/writing-linux-kernel-modules-in-safe-rust-geoffrey-thomas-two-sigma-investments-alex-gaynor-alloy
