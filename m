Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B85F447F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiJDNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJDNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 09:42:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98641100
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 06:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5AFE7CE10AB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754E8C433D7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:42:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cqdDfHuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664890923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hiTjVOVsdjdURNHl7xrtUEksJ3wXa7MoPDO7FHc+3cw=;
        b=cqdDfHuVSfD2UZZ5Hb2VpX1mtjVCtyF+TQRcmcGKLE2UFAvPg7b+6aExPekymOYyLvhrWy
        xgF0FLaSFFIh786la73pakeNluSbM9NLIK/BDwNMgJa6jZ3bAOq5mNp1O1WchHd3/lYM1f
        y7JhgSbDPpLqGaKmp6fw2w4Yam6Iw0A=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e77ca2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 4 Oct 2022 13:42:03 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id l22so17425093edj.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 06:42:02 -0700 (PDT)
X-Gm-Message-State: ACrzQf23O22rERCsjUyaTziryD+iBYPBkCcqh0EGXWBn2YFtf52E3ac9
        7TnsMXhtnJv0na2g3a4u1zl9XXOmv2t1k5x1onQ=
X-Google-Smtp-Source: AMsMyM55KSzpL+3uSCdqyLgVLQXEy7addN49o8gEU2kWIHro3lLbgiT744GP/C7EZb6gghVq3/bz65ld42QQs5zn45M=
X-Received: by 2002:a05:6402:1a42:b0:458:b430:7e70 with SMTP id
 bf2-20020a0564021a4200b00458b4307e70mr14530363edb.293.1664890921003; Tue, 04
 Oct 2022 06:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
 <20220926133435.1333846-1-Jason@zx2c4.com> <202209261125.8AEBF245@keescook>
In-Reply-To: <202209261125.8AEBF245@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 4 Oct 2022 15:41:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9qAqJrds_R6R6+5MpxJyP-H_w-pwCHQfh26SnLhWJ-2Vg@mail.gmail.com>
Message-ID: <CAHmME9qAqJrds_R6R6+5MpxJyP-H_w-pwCHQfh26SnLhWJ-2Vg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] minmax: sanity check constant bounds when clamping
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
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

On Mon, Sep 26, 2022 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Sep 26, 2022 at 03:34:34PM +0200, Jason A. Donenfeld wrote:
> > The clamp family of functions only makes sense if hi>=lo. If hi and lo
> > are compile-time constants, then raise a build error. Doing so has
> > already caught buggy code. This also introduces the infrastructure to
> > improve the clamping function in subsequent commits.
> >
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Wondering - did you ever queue this up for 6.1? I assume the plan is
to hold off on 2/2 for the time being, but this 1/2 is good to have
either way.

Jason
