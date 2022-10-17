Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983A86017DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiJQTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiJQTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:40:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA5691AB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 204so12012010pfx.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E40amjbnNYxi3bHXc6L0DGbJMK1J+X/tuw892jtBoNU=;
        b=HioGEo0tu/fTff5p7+5URNAqsTkxuMUcprVmRw/RLbDP+9Ri1kpdI3gsf1OIic19gm
         xGAVgJUoBW3KWNpp6oXrIR88dslb5v5TP/lP9ayZ1ZD9mOilpohAAD5qLMSqfpEu/gRr
         2MNTC75SbLXwE0eIPwW2MqRqpQVROdq8dz3As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E40amjbnNYxi3bHXc6L0DGbJMK1J+X/tuw892jtBoNU=;
        b=GZTbLbS6V93TwoeHfeaHNInNolxGPH+/lkUDpdv51dFj2+1tg2NcmZEgzzqUvOIGw1
         kzBjt8ATxus77VOMlhX8/ixxMKgdbFKy2AuL5lyzCp9W+yZxjply5E2S3ByMAhp6E40N
         ShZx0dvT+5CwTA+SDj6dYOrIUNV+5NJyzqxPTefAW1B4n1AiprOdLANke84Fa7FB0dwS
         x0h+4IEXOWwJVI18RFZrT9G24GNn65wHWcsWoiupeOZqxnzAldd1dTXIEIvdAXCFW6yJ
         SCDM/sulYWOXIDItraUrSegVrmlSPsWHy6Tf402SA9+OOgjj54Mui+XE8WJISEtfXHGc
         NvXg==
X-Gm-Message-State: ACrzQf0g6UWZCx/REseCgXMDf9oQc+SYxLztoj2euRBRMiM4qsJyQF1P
        CrKczNlJXE/vun6VEHPThiW9ow==
X-Google-Smtp-Source: AMsMyM7bnvMYy8lgjWKpP3JrejST49cSKxLgtUin0NtvpiI8/Xeqliqk/xu678J8YtDL/Yej1GUBAQ==
X-Received: by 2002:a63:91:0:b0:461:f509:2a31 with SMTP id 139-20020a630091000000b00461f5092a31mr11831239pga.108.1666035615423;
        Mon, 17 Oct 2022 12:40:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x14-20020aa7940e000000b0056389e00a83sm7479253pfo.63.2022.10.17.12.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:40:14 -0700 (PDT)
Date:   Mon, 17 Oct 2022 12:40:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210171237.DF5D4A3FD7@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com>
 <202210171100.5BAC4A5CC8@keescook>
 <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
 <202210171227.35ED875219@keescook>
 <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEJQ8gh-iXZNL8bNcmV=JCmKHNp5BnhYthhSOyR5h79_g@mail.gmail.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:33:06PM +0200, Ard Biesheuvel wrote:
> On Mon, 17 Oct 2022 at 21:29, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Oct 17, 2022 at 08:14:14PM +0200, Ard Biesheuvel wrote:
> > > So once we use the same size for input and output, I was curious
> > > whether we could encrypt in place, and get rid of the big_oops_buf.
> > > And the answer is 'yes', precisely because we have this horrid per-CPU
> > > allocation which serves as a bounce buffer. And this is not specific
> > > to acomp, the old comp algorithms get wrapped in scomps which receive
> > > the same treatment.
> >
> > Ah, in the sense that "in place" is actually happening in the per-cpu
> > allocation, and only if it succeeds does the input buffer get
> > overwritten?
> 
> Something like that IIRC.
> 
> > > So at that point, I wondered what the point is of all this complexity.
> > > Do we really need 6 different algorithms to compress a couple of K of
> > > ASCII text on a code path that is ice cold by definition? Wouldn't it
> > > be better to drop the crypto API altogether here, and just use GZIP
> > > via the library interface?
> >
> > Well, my goal was to make the algo "pstore doesn't care". If someone
> > picks deflate, do they still get all the per-cpu allocations?
> >
> 
> Not if you use the library interface directly.
> 
> The issue with the percpu buffers is that they are only kept if any
> scomp TFMs are active, but this is always the case for pstore, as you
> don't want to allocate it on the panic path.

Okay, so strictly speaking, eliminating the per-CPU allocation is an
improvement. Keeping scomp and doing in-place compression will let
pstore use "any" compressions method.

Is there a crypto API that does _not_ preallocate the per-CPU stuff?
Because, as you say, it's a huge amount of memory on the bigger
systems...

-- 
Kees Cook
