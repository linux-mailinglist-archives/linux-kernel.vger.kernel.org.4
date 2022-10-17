Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A360160C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJQSOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJQSOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:14:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0695A2;
        Mon, 17 Oct 2022 11:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12E66611F0;
        Mon, 17 Oct 2022 18:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D20C433C1;
        Mon, 17 Oct 2022 18:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666030467;
        bh=Z7Uwug6k5qEwWDN4mEOJmsmTE37uy3yD2SlcrHBOjfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JhbKcd8nBgltA2cUxf6NC8Sd1Lkj61y8yc7blRAS5/r2etietj/cYYde5jgRzzHMc
         yZA8SacFxyO6z8aSp+Atm5UFshdSmFv8RQghZn6jvijtR45T6jFFVRGhAhUEv6dCl1
         sW5v06KtI/bSSCB1U7fV75UOUOLHMAi1RSODePWj6rK3GcfHp4lhfv85ddjv+tS2JB
         9h9NuwjM4rhgaOpvos94L3I4iK46U+5CGOiCBXLJ1+pRO495oVfSGf0VDJNPq7qFfO
         lPH1B5uQubHSTFkgyMdAfnR+0BZW525Nx8Y1gfe8edTnxUkJFHva+o7NSIS3txXgMd
         49cvX5hC90T4w==
Received: by mail-lf1-f48.google.com with SMTP id bu25so18848292lfb.3;
        Mon, 17 Oct 2022 11:14:27 -0700 (PDT)
X-Gm-Message-State: ACrzQf1qHsh7hZDZUHLLEzne7CAA+hoZ6CqviWyJx5v6HhNUOy0QPxc5
        dt7ZFUADka+OvDSYo63/Y6UEKGkXP/KFDezeauM=
X-Google-Smtp-Source: AMsMyM4/H3HQax1mbJP34lo4x+Pmo9RUHwIASnn6faiAlgbBz7yBzStFDye5LFJLAze7tVEr2i5XVPWAuQlEKIIufjk=
X-Received: by 2002:a19:c20b:0:b0:4a2:40e5:78b1 with SMTP id
 l11-20020a19c20b000000b004a240e578b1mr4345794lfc.228.1666030465499; Mon, 17
 Oct 2022 11:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221006234138.1835739-1-keescook@chromium.org>
 <191ec24d-35d4-e4e5-85f7-d7301984e647@igalia.com> <202210171100.5BAC4A5CC8@keescook>
In-Reply-To: <202210171100.5BAC4A5CC8@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 17 Oct 2022 20:14:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
Message-ID: <CAMj1kXHzrRTVcxb5+hgUPV3tjekPcDWzVf6cG_Mc9JJmYBz2Mw@mail.gmail.com>
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

On Mon, 17 Oct 2022 at 20:01, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Oct 17, 2022 at 01:26:12PM -0300, Guilherme G. Piccoli wrote:
> > On 06/10/2022 20:41, Kees Cook wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The crypto 'compress' interface is deprecated, so before adding new
> > > features, migrate to the acomp interface. Note that we are only using
> > > synchronous implementations of acomp, so we don't have to deal with
> > > asynchronous completion.
>
> Ard, given your observation about all the per-cpu memory allocation,
> should pstore still go ahead with this conversion?
>

Well, the reason for doing this conversion was so that we could move
the 'worst case buffer size' logic into the individual drivers, as
Herbert would't allow that for legacy comp.

But as we found, we don't really care about the theoretical worst case
of an input that is incompressible - we can just pass the uncompressed
size as the upper bound, and if the crypto fails, we just store the
data uncompressed (which never happens in the first place with ASCII
text)

So once we use the same size for input and output, I was curious
whether we could encrypt in place, and get rid of the big_oops_buf.
And the answer is 'yes', precisely because we have this horrid per-CPU
allocation which serves as a bounce buffer. And this is not specific
to acomp, the old comp algorithms get wrapped in scomps which receive
the same treatment.

So at that point, I wondered what the point is of all this complexity.
Do we really need 6 different algorithms to compress a couple of K of
ASCII text on a code path that is ice cold by definition? Wouldn't it
be better to drop the crypto API altogether here, and just use GZIP
via the library interface?
