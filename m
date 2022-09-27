Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE05EBEA5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiI0JbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiI0Ja6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:30:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0213C153;
        Tue, 27 Sep 2022 02:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D391A6174F;
        Tue, 27 Sep 2022 09:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0F0C433D6;
        Tue, 27 Sep 2022 09:30:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kF3gAJq9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664271053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOsRsI2SbqGs1hFMWbK9H3koFhP046bcsz2N8V78ieg=;
        b=kF3gAJq9dnuirJjeBPCuYkNjDfsRW9GlsTIv+vdeUM0+tgKaMi1/2DcuhIslVk6fLHiRVZ
        uRpIqmJEO05hC9BBITUW4+dmrIel8BFUN8aF+HvGMUqa+SgPmoHqfnKXo7Nl/dfLoSJFUe
        2kXa+3P+080GPft0/DmKbJ8jKpFAvQo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd881e4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 27 Sep 2022 09:30:53 +0000 (UTC)
Date:   Tue, 27 Sep 2022 11:30:51 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] random: split initialization into early arch step and
 later non-arch step
Message-ID: <YzLCy2rVIBebeMrB@zx2c4.com>
References: <20220926160332.1473462-1-Jason@zx2c4.com>
 <202209261105.9C6AEEEE1@keescook>
 <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com>
 <202209262017.D751DDC38F@keescook>
 <CAHmME9qTf+aDmBen2dFXPmbDGkn1E4=oXqqeBRiguLCo7K9EhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qTf+aDmBen2dFXPmbDGkn1E4=oXqqeBRiguLCo7K9EhQ@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:34:16AM +0200, Jason A. Donenfeld wrote:
> > > Yes, we could maybe *change* to using init_utsname if we wanted. That
> > > seems kind of different though. So I'd prefer that to be a different
> > > patch, which would require looking at the interaction with early
> > > hostname setting and such. If you want to do that work, I'd certainly
> > > welcome the patch.
> >
> > Er, isn't that _WAY_ later? Like, hostname isn't set until sysctls up
> > and running, etc. I haven't actually verified 100% but it looks like
> > current->utsname is exactly init_utsname currently.
> 
> If init_utsname()==utsname() and all is fine, can you please send a
> patch atop random.git adjusting that and explaining why? I would
> happily take such a patch. If your suspicion is correct, it would make
> a most welcome improvement.

https://lore.kernel.org/lkml/20220927092920.1559685-1-Jason@zx2c4.com
