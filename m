Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F25BA787
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiIPHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIPHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:34:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E57CDFBF;
        Fri, 16 Sep 2022 00:34:37 -0700 (PDT)
Received: from letrec.thunk.org ([185.122.133.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28G7XsIY025301
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 03:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1663313638; bh=Ff+be2aCuv0yea74ummplMFRZDnk4ZWbn37rurbNeF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gr+5GH5RLqFulFpsF3k4gAP7e+11xkZg+vg/J7AxAp6kzUip8aOeSAKiISUDdcrUR
         XbPA0kK/r72MyA3yhTd4GoHHbmUG7DT1SYveDgKGZOZFO2GnV5EiKXjWXzP1ZiYa57
         TORlt4unerQXInsMP6ttfyv5cuX+oBO3BrV9h/keFbAMRevmAufOoEDumHADbY9zgg
         glD7pOvpm+MYMMD3YHZioaqvceS5ciQlmvqSnW0W7aUOKBbqLsEn6kFA18pKPifNhl
         Tn4ta8uu+Db6KKzPI/QmMJWZgdbWIn5WsCC2qF7wM5eEteZZ/v6dO3HoR4s2Oveh7H
         V00iWyjFqiEow==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id A88908C2B4B; Fri, 16 Sep 2022 03:33:53 -0400 (EDT)
Date:   Fri, 16 Sep 2022 03:33:53 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
Subject: Re: [PATCH 1/5] tty: remove TTY_MAGIC
Message-ID: <YyQm4dBVyvefVcAd@mit.edu>
References: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <476d024cd6b04160a5de381ea2b9856b60088cbd.1663288066.git.nabijaczleweli@nabijaczleweli.xyz>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 03:54:59AM +0200, наб wrote:
> According to Greg, in the context of magic numbers as defined in
> magic-number.rst, "the tty layer should not need this and I'll gladly
> take patches"
> 
> Ref: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/

Well, I would disagree with Greg K-H on this --- but I haven't been
tty maintainer in well over a decade.  Assuming code is Bug-Free(tm),
sure, it's not necessary.  But there is any kind of memory bug (e.g.,
a corrupted pointer, a use-after free, some other structure
corruption), this catches the problem earlier rather than later, and
it's a light-weight to do a quick sanity check.

It has certainly caught problems in the past, and I still use this
programming technique in programs that I do maintain, such as
e2fsprogs.

But it's not a big deal either way,

						- Ted

P.S. BTW, I didn't make up this technique; it's a program pattern
first used in Multics.
