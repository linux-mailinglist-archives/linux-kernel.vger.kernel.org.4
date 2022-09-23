Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2C5E7888
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiIWKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiIWKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103ABFB306
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E493615F7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD86AC433B5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:41:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YjxWbaB0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663929659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ZvGhR5oXwTPAFeFW8Pe3TOzgD3HHUZP5l33sdHCiXk=;
        b=YjxWbaB0BmfhuwrN/pcc/+PPHdr+Bxkg6lhyTbDNEPidLOdhWobNHTovIwUxhnkyNxWxa5
        h5p+qJivAJjwVRgdfb9kwj4YLp8ofOe7CQw5Y6QPQPBjSANJFGyFQQUSJiBTgPDnIJlgH2
        TFKVqymUtRCZvOHI43CeFz7NfkruyLM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2af2599e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 10:40:59 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id a129so13287466vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:40:59 -0700 (PDT)
X-Gm-Message-State: ACrzQf2sgvdiBuoyvDXG+9PcibxrsryyWdbzvHbUIHhl2pqbZfPp511L
        aW0kHx5c1fo8dJqwF02ls/VhzecYXY9xkt7FLz4=
X-Google-Smtp-Source: AMsMyM5NjhSLTcvmv7OTrctkBp6LT7rovMtRrcjXWXCO0Djt/mRAc2+ko0y2ai8qW5IC10nINby7EPfcYEtecX53CFM=
X-Received: by 2002:a05:6102:2908:b0:398:ac40:d352 with SMTP id
 cz8-20020a056102290800b00398ac40d352mr2608039vsb.55.1663929658486; Fri, 23
 Sep 2022 03:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220923100621.3888015-1-Jason@zx2c4.com> <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
In-Reply-To: <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 12:40:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
Message-ID: <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra comparison
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Sep 23, 2022 at 12:36 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 23, 2022 at 12:06:21PM +0200, Jason A. Donenfeld wrote:
> > Currently the clamp algorithm does:
> >
> >       if (val > hi)
> >               val = hi;
> >       if (val < lo)
> >               val = lo;
> >
> > But since hi > lo by definition, this can be made more efficient with:
>
> It's strongly speaking, but we have to proof that, right?
> So, while I haven't checked the code, this change should also
> include (does it?) the corresponding compile-time checks (for
> constant arguments) in similar way how it's done for GENMASK().
>
> Otherwise I have no objections.

I think most cases are with compile time constants, but some cases are
with variables. What should we do in that case? Checking variables at
runtime incurs the same cost as the old code. I guess we could do this
fast thing for constants and the slower old thing for non-constants?
Or not do either, keep this commit as is, and just accept that if you
pass bogus bounds to clamp, you're going to end up with something
weird, which is already the case now so not a big deal?

Jason
