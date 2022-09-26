Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288395EA819
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIZONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiIZONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:13:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22327F081;
        Mon, 26 Sep 2022 05:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1D9A60C09;
        Mon, 26 Sep 2022 12:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD271C433C1;
        Mon, 26 Sep 2022 12:24:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lsJhMPtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664195041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRsqsmykDdIlfMApE0pzp5mdgW8UL+S3oZNON9FDvMc=;
        b=lsJhMPtJR5W+tc66j8jdzgwh9EdkcR5os0JnSqIEZp/hNCNGuqApNjrmLesRH5EVAbU23x
        rIQjQEiQFKUxHp49QC+LRA6sh45lz52TbLp8IrgzD4siZo2zCV/3YOpRIGr5KUht7ToP1p
        vuQUt4XKs8mlkuV6KGPvGZh9x934wKM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4bbf97c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 12:24:00 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id m65so6356486vsc.1;
        Mon, 26 Sep 2022 05:24:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf3lX2mAKWLCieZc7fngLChoyGL7bfXizg0XkHqbbTzQqFGrRWxp
        7Q0oj74uU9VYZl8yauPyRcwAK0/ai2CnEegHztk=
X-Google-Smtp-Source: AMsMyM5wqCEztXEdpVpMmtKyLL5prX0MZeDsIHIOKmXrYmNdlzgs0KUQH+2ZR6wRkst280EQ1vxlIps73hDzg8M3eJM=
X-Received: by 2002:a67:e401:0:b0:398:89f1:492f with SMTP id
 d1-20020a67e401000000b0039889f1492fmr8595413vsf.21.1664195039676; Mon, 26 Sep
 2022 05:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com> <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
 <Yy7d5qWpT5Xj2WvN@zx2c4.com> <YzF4NrcBkR/p0cD3@smile.fi.intel.com>
In-Reply-To: <YzF4NrcBkR/p0cD3@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 14:23:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
Message-ID: <CAHmME9pRXpTc2g5R-xj7hTrG00iQ6WLSSRooag1NPzJnyV90Nw@mail.gmail.com>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra comparison
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-toolchains@vger.kernel.org
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

On Mon, Sep 26, 2022 at 12:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Sep 24, 2022 at 12:37:26PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Sep 23, 2022 at 03:54:12PM -0700, Andrew Morton wrote:
> > > On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
>
> ...
>
> > Worth noting, by the way, is that the input validation check already
> > caught a bug when 0day test bot choked:
> >
> > https://lore.kernel.org/linux-hwmon/20220924101151.4168414-1-Jason@zx2c4.com/
>
> Hooray, it was a good idea! :-)
>
> > So, options:
> > 1) Keep this patch as-is, because it is useful on modern compilers.
> > 2) Add an ifdef on compiler version, so we generate the best code in
> >    each case.
> > 3) Go back to testing twice, but keep the checker macro because it's
> >    apparently useful.
> > 4) Do nothing and discard this series.
> >
> > Any of those are okay with me. Opinions?
>
> I tend to case 3) (I believe you typo'ed double 2) cases) and apply the rest
> as a separate change with all downsides explained (kinda 1) approach).

Alright, I'll do that. v3 on its way, then.
