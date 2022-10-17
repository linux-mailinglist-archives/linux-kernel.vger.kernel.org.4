Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B053C6017BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJQTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJQTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA103D93;
        Mon, 17 Oct 2022 12:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 863ED61218;
        Mon, 17 Oct 2022 19:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2E5C43470;
        Mon, 17 Oct 2022 19:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666035199;
        bh=kQAx6OW++zd8pER7ELrKKvtjZdOAbdTFngiOV+8G34g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=llC3W2pjNBdwi5MREeeCG+5YeQYxSZUkP74uDJCPUJWMwnXudTXQEICQXe7hFjBKZ
         gYcSqIuT7BrzmwPU852eBxxhQzu/pvQt0D4WGhhusNzQoobKW0PP5alOhBX7f5W7qt
         hes0bCyYsKWnSemNWnUtN5aF3577GrQStuQ9NmwC4xN58Ji6t92duKa9fvvbEcGYK+
         jVowZSjyWxrDMGLXwxjxwjA+5LULRq/W5XQGvUWR3uygtno2P3W7oOeZ+OLdUNTUAZ
         96Kb+eLihGhTdkoQE3Z/FijBSlNmwM69jBeFvzfyeqPPlnUoG4L+tGx5MjDuoRbfyz
         /wXf6HMp35HVg==
Received: by mail-lj1-f171.google.com with SMTP id by36so15244965ljb.4;
        Mon, 17 Oct 2022 12:33:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf3y+Pm9fistoP9xEkZLgXChkE2UbSmSokXyPhkpR3YLof+dPM53
        iqMtSjISrNZkzw+kbAeDvhIAWaMdpUDOxzN04K4=
X-Google-Smtp-Source: AMsMyM5zJeD6UmMgl7EE/qe8Ukfh7tws99HZZCYmK+3PX7I8FETFhmo5M2hWaTPyonuI50r5rNVgKK6/0kfUnu0+QsM=
X-Received: by 2002:a05:651c:4d0:b0:26f:cd9b:419f with SMTP id
 e16-20020a05651c04d000b0026fcd9b419fmr4367081lji.415.1666035197952; Mon, 17
 Oct 2022 12:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com> <202210171227.35ED875219@keescook>
In-Reply-To: <202210171227.35ED875219@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 21:33:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
Message-ID: <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 at 21:29, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 08:14:14PM +0200, Ard Biesheuvel wrote:
> > So once we use the same size for input and output, I was curious
> > whether we could encrypt in place, and get rid of the big_oops_buf.
> > And the answer is 'yes', precisely because we have this horrid per-CPU
> > allocation which serves as a bounce buffer. And this is not specific
> > to acomp, the old comp algorithms get wrapped in scomps which receive
> > the same treatment.
>
> Ah, in the sense that "in place" is actually happening in the per-cpu
> allocation, and only if it succeeds does the input buffer get
> overwritten?
>

Something like that IIRC.

> > So at that point, I wondered what the point is of all this complexity.
> > Do we really need 6 different algorithms to compress a couple of K of
> > ASCII text on a code path that is ice cold by definition? Wouldn't it
> > be better to drop the crypto API altogether here, and just use GZIP
> > via the library interface?
>
> Well, my goal was to make the algo "pstore doesn't care". If someone
> picks deflate, do they still get all the per-cpu allocations?
>

Not if you use the library interface directly.

The issue with the percpu buffers is that they are only kept if any
scomp TFMs are active, but this is always the case for pstore, as you
don't want to allocate it on the panic path.
