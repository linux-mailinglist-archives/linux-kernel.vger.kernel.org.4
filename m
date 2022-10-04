Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C9E5F4616
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJDPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJDPBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187594F651
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:01:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7BC61494
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 15:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA2CC433D6;
        Tue,  4 Oct 2022 15:01:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bheiFFAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664895680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/SKtC4p7vOwr6A/9dZvSFnj/qem7KrbZw2Invv3vXGs=;
        b=bheiFFAt8quI2EryNfRexXkoMfYckkosEI2bi/adzS09IZ0L9dfL0ba5/v3AxBarfRZ4h1
        AD1B9z44p1BvvaDc6T5tDqTfLUPiODdeGg0JeGlJ8mQYHadwK5YNXHecHVgryTOLMPE1Sz
        kIhgaS2Q2zXXpLd+9W4VCQYW+GN/FW8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c32fece6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 4 Oct 2022 15:01:20 +0000 (UTC)
Date:   Tue, 4 Oct 2022 17:01:16 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
Message-ID: <YzxKvMqO2WYD2gow@zx2c4.com>
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com>
 <202209261125.8AEBF245@keescook>
 <CAHmME9qAqJrds_R6R6+5MpxJyP-H_w-pwCHQfh26SnLhWJ-2Vg@mail.gmail.com>
 <1DA96D23-12A0-4B5B-8032-90D13D4700E4@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1DA96D23-12A0-4B5B-8032-90D13D4700E4@chromium.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:39:53AM -0700, Kees Cook wrote:
> 
> 
> On October 4, 2022 6:41:48 AM PDT, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> >On Mon, Sep 26, 2022 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Mon, Sep 26, 2022 at 03:34:34PM +0200, Jason A. Donenfeld wrote:
> >> > The clamp family of functions only makes sense if hi>=lo. If hi and lo
> >> > are compile-time constants, then raise a build error. Doing so has
> >> > already caught buggy code. This also introduces the infrastructure to
> >> > improve the clamping function in subsequent commits.
> >> >
> >> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> > Cc: Andrew Morton <akpm@linux-foundation.org>
> >> > Cc: Kees Cook <keescook@chromium.org>
> >> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >>
> >> Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> >Wondering - did you ever queue this up for 6.1? I assume the plan is
> >to hold off on 2/2 for the time being, but this 1/2 is good to have
> >either way.
> 
> Since it produced at least one warning, there may be others in weird
> archs/configs, so I wanted it to bake in -next after the merge window
> for 6.1 closes. It's a good feature, but I didn't want to risk new
> build warnings so close to the merge. :)

Alright, sounds good. Hope it catches more things!

Jason
