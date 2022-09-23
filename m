Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCB45E8031
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiIWQzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiIWQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976CD88DCE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:54:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31737628EB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C296C433C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:54:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dVJ/IpFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663952092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6D/FHiuPOJ/mGSzzqf1RseXpkHecokni0RNiR+KTfw=;
        b=dVJ/IpFaalD/jZsPqCJfmPEoCY3csiWsTMIzKWNJdmRo/D3i18if4jWHlR6a/SD7a7E6l5
        pEnCFkI2U+DJB87bdoQzAWejSpTYoYthxEtP7O7JWJpHfzkNJ3Lkj8PVejtX95HwWVI/LP
        eA6Yz7v9A56ytGfc5CRC9+ZN7XzAYDI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 189b9744 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 16:54:51 +0000 (UTC)
Received: by mail-ua1-f45.google.com with SMTP id c23so295089uan.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:54:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf2UhLeNaaYexpff8XLRGqeiCG9w0/w7txmGiW3X7S7iZxlA+uS6
        4Mju1laGz6Xe1ENwPBst0VBo3wVwiO1Zu9+EcxA=
X-Google-Smtp-Source: AMsMyM7gaWYoFhwn4G1ZAzK8geVkegcCtZ0gQJUX7XAvADudgiCFg0qABvjohtdPA9NPfoCj9rXpJkS2BQe3zsc8xH0=
X-Received: by 2002:ab0:758a:0:b0:3af:2b2d:dae7 with SMTP id
 q10-20020ab0758a000000b003af2b2ddae7mr4258292uap.24.1663952090724; Fri, 23
 Sep 2022 09:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
 <20220923154001.4074849-1-Jason@zx2c4.com> <202209230932.1FA2FF39@keescook> <Yy3khQ4ERr+z16Wj@smile.fi.intel.com>
In-Reply-To: <Yy3khQ4ERr+z16Wj@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 18:54:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9o-hSA3XBry5rJ7uWiJbky50S3qyZXZxn3f1usNmraz4A@mail.gmail.com>
Message-ID: <CAHmME9o-hSA3XBry5rJ7uWiJbky50S3qyZXZxn3f1usNmraz4A@mail.gmail.com>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra comparison
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
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

On Fri, Sep 23, 2022 at 6:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 23, 2022 at 09:41:19AM -0700, Kees Cook wrote:
> > On Fri, Sep 23, 2022 at 05:40:01PM +0200, Jason A. Donenfeld wrote:
>
> ...
>
> > > +           __clamp(val, lo, hi),                                           \
> > > +           __clamp_once(val, lo, hi, __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
> >
> > *complaint about line being >100 characters, but I don't really care* If
> > anyone is really bothered, this looks fine, too:
> >
> >               __clamp_once(val, lo, hi,                                       \
> >                            __UNIQUE_ID(__val), __UNIQUE_ID(__lo), __UNIQUE_ID(__hi))); })
>
> Actually }) should occupy a separate line and it would be nice to have it for ({.

That's what I would have done, except another macro in there didn't do
it like that, so I tried to copy the existing form.

Kees - do you want to touch up stylistic things as you see fit upon
commit, or do you want a v3 from me?

Jason
