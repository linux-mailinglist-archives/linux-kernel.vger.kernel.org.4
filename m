Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3235E7E04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiIWPOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiIWPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:13:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF54139F5D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD28B825FB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ADA7C433C1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:13:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lwbtCPjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1663946027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZMmimBNR1SRi2DZoJ/yoCP2CZX7yXhg9SS7M6HkpaE=;
        b=lwbtCPjyzlZxsOetR8mHAL+SPkv2TD00ZcRA/F5BzyJj9WdFAeHXQxQWhT5OfFXKkpSsl/
        /lCE2qMtDe+A0Q4ZvhhvdvsrsLWjT1sGLxITShdqggVB4uHzVeGl+VYgtWeH671vZwtbah
        Y4Gc4YmyfHoKGqhKUfCZgGp+0MTh3aM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 943b89ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 23 Sep 2022 15:13:46 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id bu4so181282uab.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:13:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf0oeuzXl8MeQIj8GtR0C1G9nJeT7j1JxGDGUDp3AcWQNx6KVulC
        /5GaJXZ8GPX8KOqW7Uv3gBNqvKZo/r1GL/FNrEg=
X-Google-Smtp-Source: AMsMyM6+seJDSocUuQT1Af+xycNCb3Ze0pBQQIIjYfHBmGqyl2gejRfVhcYUlPQPg04nim1U4l6xkycbb6MzsRDjJi8=
X-Received: by 2002:ab0:5a24:0:b0:3af:fbb1:2dfb with SMTP id
 l33-20020ab05a24000000b003affbb12dfbmr4052051uad.27.1663946025432; Fri, 23
 Sep 2022 08:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220923100621.3888015-1-Jason@zx2c4.com> <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
 <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
 <CAHmME9p+SKTHzniw=TsC=vnQsyCuBa08+LcK-CsFcjA58K+ifA@mail.gmail.com> <Yy3M5Urqiz8jnIYe@smile.fi.intel.com>
In-Reply-To: <Yy3M5Urqiz8jnIYe@smile.fi.intel.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 23 Sep 2022 17:13:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
Message-ID: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
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

On Fri, Sep 23, 2022 at 5:12 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 23, 2022 at 12:48:48PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Sep 23, 2022 at 12:40 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> ...
>
> > both for the old code and for the new code, the result of lo>hi is
> > total nonsense:
>
> Exactly and my point is to add at least compile-time check for constants.

Cool okay. Rolling v2 now.

Jason
