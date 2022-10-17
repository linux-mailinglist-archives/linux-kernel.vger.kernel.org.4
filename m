Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30999601555
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJQR2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJQR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF86BD5D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31B39611EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC03C433B5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:26:40 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C17OfLTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666027597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUidW8NItaDXNEWCUfPFKo7TadH14Rb3mgSUQBIql2o=;
        b=C17OfLTVAcbSc8ni9sfKd+c6UoqAxYU0EQaj/2eMikZyQG1iZLMRMkLVHK42SY13XDcnoR
        dUWSNw2z6WGAbH3RrHfqA+QFD9kDHiG2Fr3qpcsSGeScz4qTJHxfWQpTxi6X2wmAP+qM8k
        Z0g+RdFZD9fHMBmf+6qYkKdcT1AlpAA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 513d9858 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 17 Oct 2022 17:26:37 +0000 (UTC)
Received: by mail-vs1-f45.google.com with SMTP id 63so12211876vse.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:26:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf1oFCl0cGz3qx7/z7BZJCeXwDhsl5Ze/Ky6tYL8/NB0GMl0chnU
        j7XzCnsHnrUf6mUsEPBSzGAPARG+bfne3syU3Vk=
X-Google-Smtp-Source: AMsMyM4aMdf4Tn/s2BPpJ8TlVWC8q0eENts4ICBr39gxGZGqvKXMtHukIwE3qPRPRZNlSonjOac0NrULi1DCMH/Djjk=
X-Received: by 2002:a67:ed9a:0:b0:3a7:718a:7321 with SMTP id
 d26-20020a67ed9a000000b003a7718a7321mr4013100vsp.55.1666027596776; Mon, 17
 Oct 2022 10:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221017044345.15496-1-Jason@zx2c4.com> <CANpmjNM7Sca3YJQ7RK14e_pzB5Wq3_-VokLum6MpqKXq7ixzSQ@mail.gmail.com>
 <CANpmjNO0hu7OHmckU7kAVu+C6Jy_M_yMxe41YmcF2oePxh7Rnw@mail.gmail.com>
In-Reply-To: <CANpmjNO0hu7OHmckU7kAVu+C6Jy_M_yMxe41YmcF2oePxh7Rnw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Oct 2022 11:26:25 -0600
X-Gmail-Original-Message-ID: <CAHmME9rTwugD49-0VRbAu72fZ8nHBQbXicSct6CPq529fWCs6g@mail.gmail.com>
Message-ID: <CAHmME9rTwugD49-0VRbAu72fZ8nHBQbXicSct6CPq529fWCs6g@mail.gmail.com>
Subject: Re: [PATCH] kcsan: remove rng selftest
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Sun, Oct 16, 2022 at 11:09 PM Marco Elver <elver@google.com> wrote:
>
> On Sun, 16 Oct 2022 at 22:07, Marco Elver <elver@google.com> wrote:
> >
> > On Sun, 16 Oct 2022 at 21:43, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > The first test of the kcsan selftest appears to test if get_random_u32()
> > > returns two zeros in a row, and requires that it doesn't. This seems
> > > like a bogus critera. Remove it.
> > >
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > Acked-by: Marco Elver <elver@google.com>
> >
> > Looks pretty redundant at this point (I think some early version had
> > it because somehow I managed to run the test too early and wanted to
> > avoid that accidentally happening again).
> >
>
> And kindly queue it in your tree with all the rng related changes. Thanks!

Okay sure, will do.

Jason
