Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFEE62DF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiKQPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbiKQPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77EFC0B;
        Thu, 17 Nov 2022 07:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7AB88B820CA;
        Thu, 17 Nov 2022 15:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FCDC43149;
        Thu, 17 Nov 2022 15:15:47 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZKesOcbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668698144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XHkq3ad6Bqf2YCyr+yoCYodOwfC/o2hVDt+gZbphk/0=;
        b=ZKesOcbi/0qDd3YH+2vtZGNoTUM3mgX9LFfn4oLAZhnnKOoHCopOc6j1DvKahCeyL2S6Wm
        BwkEQVMN0UKai2o6FCVqpJ9t6FEeT6m4yCq7BWE5P750V/D7kBNB8hCaRT0DKv3AIIWzsV
        U3AEPUKmR2YWQ6QWtROueox4GmU6UXw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0b488cdc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Nov 2022 15:15:44 +0000 (UTC)
Received: by mail-ua1-f54.google.com with SMTP id y24so479697uaq.3;
        Thu, 17 Nov 2022 07:15:44 -0800 (PST)
X-Gm-Message-State: ANoB5pkKZPsS+dXACp24SnBJ9AgRfDvumQo4TppQqPlOoyGggYWOJtFu
        Hpbmxb4sQVeuvQR2e3EyUmnz8EHRcA2qlewkHvo=
X-Google-Smtp-Source: AA0mqf7J4YstJ/YCf1egdbrYuqtq8BgIuZsUj+Re07CPnkmhSNF1VaVhoXCHiKmYLa8zRZz8qp1PufIbkYp5hJ97dd8=
X-Received: by 2002:ab0:7610:0:b0:3dc:40aa:84cf with SMTP id
 o16-20020ab07610000000b003dc40aa84cfmr1493768uap.102.1668698143328; Thu, 17
 Nov 2022 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20221103042740.6556-1-elliott@hpe.com> <20221116041342.3841-1-elliott@hpe.com>
 <Y3WxcrjHD4MRWHcS@gondor.apana.org.au> <MW5PR84MB1842928E4228956EFA4D4BCAAB069@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <MW5PR84MB1842928E4228956EFA4D4BCAAB069@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 17 Nov 2022 16:15:31 +0100
X-Gmail-Original-Message-ID: <CAHmME9rQdKDk47GuG3HyZ86hx0D-3eWERkNktVejQTGpc0DzTQ@mail.gmail.com>
Message-ID: <CAHmME9rQdKDk47GuG3HyZ86hx0D-3eWERkNktVejQTGpc0DzTQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/24] crypto: fix RCU stalls
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "ap420073@gmail.com" <ap420073@gmail.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Nov 17, 2022 at 4:14 PM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
> > -----Original Message-----
> > From: Herbert Xu <herbert@gondor.apana.org.au>
> > Sent: Wednesday, November 16, 2022 9:59 PM
> > Subject: Re: [PATCH v4 00/24] crypto: fix RCU stalls
> >
> > On Tue, Nov 15, 2022 at 10:13:18PM -0600, Robert Elliott wrote:
> ...
> > > These problems have always been lurking, but improving the
> > > loading of the x86/sha512 module led to it happening a lot
> > > during boot when using SHA-512 for module signature checking.
> >
> > Can we split this series up please? The fixes to the stalls should
> > stand separately from the changes to how modules are loaded.  The
> > latter is more of an improvement while the former should be applied
> > ASAP.
>
> Yes. With the v4 patch numbers:
> [PATCH v4 01/24] crypto: tcrypt - test crc32
> [PATCH v4 02/24] crypto: tcrypt - test nhpoly1305
>
> Those ensure the changes to those hash modules are testable.
>
> [PATCH v4 03/24] crypto: tcrypt - reschedule during cycles speed
>
> That's only for tcrypt so not urgent for users, but pretty
> simple.
>
> [PATCH v4 04/24] crypto: x86/sha - limit FPU preemption
> [PATCH v4 05/24] crypto: x86/crc - limit FPU preemption
> [PATCH v4 06/24] crypto: x86/sm3 - limit FPU preemption
> [PATCH v4 07/24] crypto: x86/ghash - use u8 rather than char
> [PATCH v4 08/24] crypto: x86/ghash - restructure FPU context saving
> [PATCH v4 09/24] crypto: x86/ghash - limit FPU preemption
> [PATCH v4 10/24] crypto: x86/poly - limit FPU preemption
> [PATCH v4 11/24] crypto: x86/aegis - limit FPU preemption
> [PATCH v4 12/24] crypto: x86/sha - register all variations
> [PATCH v4 13/24] crypto: x86/sha - minimize time in FPU context
>
> That's the end of the fixes set.
>
> [PATCH v4 14/24] crypto: x86/sha - load based on CPU features
> [PATCH v4 15/24] crypto: x86/crc - load based on CPU features
> [PATCH v4 16/24] crypto: x86/sm3 - load based on CPU features
> [PATCH v4 17/24] crypto: x86/poly - load based on CPU features
> [PATCH v4 18/24] crypto: x86/ghash - load based on CPU features
> [PATCH v4 19/24] crypto: x86/aesni - avoid type conversions
> [PATCH v4 20/24] crypto: x86/ciphers - load based on CPU features
> [PATCH v4 21/24] crypto: x86 - report used CPU features via module
> [PATCH v4 22/24] crypto: x86 - report missing CPU features via module
> [PATCH v4 23/24] crypto: x86 - report suboptimal CPUs via module
> [PATCH v4 24/24] crypto: x86 - standardize module descriptions
>
> I'll put those in a new series.

Thanks. Please take into account my review feedback this time for your
next series.

Jason
