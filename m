Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBBB6EAF75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjDUQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjDUQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:48:44 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3364DCC0C;
        Fri, 21 Apr 2023 09:48:43 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso17396311fa.0;
        Fri, 21 Apr 2023 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682095721; x=1684687721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sbqUma2ZLI3KKcCdIaep9AcRZ0rbFEkxBwd7VQhDn1w=;
        b=AEqDR2esTJbMF4Qk2M4GfO9MiPIPtu+WCDwVh0L7o5f3s3KD9Hxsnc5fmvp0xjUpWU
         gjBrC+vBKT+5d+xTgN9qfaU3E1neRIVYXye4I8BtGArjFyojlOBftA1WCvh2dZ38N/kf
         Mkh4gDbnhQahJOHtpUaRtoYMpcswmIUe78U1+LkxcIdbc+pOa+dqgXUo5+5unyZrmM86
         hPs7MrIg7+lJqfA1Lc2n7fZMOHNcrdDMiqNCTXzWJCXWWQiQJ/CLErjkck6abXOnVpdk
         kL9qDvxkvLfNJ9wy/xiHfv8VjiwzuEX8BCK05LaIZuOAatXEpzbc5D7Cwfc6aO8yTlza
         5bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682095721; x=1684687721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbqUma2ZLI3KKcCdIaep9AcRZ0rbFEkxBwd7VQhDn1w=;
        b=fHy+X+c2fjL9sp3SKoxLga9Y8xacfOjuibSafxdzSsCrpmBLt96PvwysCb8Bn0Qka+
         /HXP2jJXNKQstZ9MqALxI9VFynxDWspP0egL4mI/qjWf5pz2EF8mXFyfEabMyruYFN29
         3iCeWr8J+qE6iJd9dzB73mglkVvh8cRFNjMm8rZTuPQjf5+G9oVjQGF0RqpU9Sw8/88M
         0SuaxzOTgrBReaOHDUST+FxfA4bCgrWrwbDbulB30lYageJZfttFywnY4j7oztnCGU1n
         04LyZCxcIpIZ2Dtd+pGxi8x3375OAyxuXwezhlwCRXAmoTVBqjTLDgvnlrpGOZufJYoQ
         jm4w==
X-Gm-Message-State: AAQBX9dnVzrM9lXVVi6iuTYZB7MWbgiS1NuVqNGGmzue3OzUFVLsJh6C
        6pC9GPo2BiA9bIKxBqvnw1Q=
X-Google-Smtp-Source: AKy350YkjWesBjkql30TP6H2CBJ2+FoAljOxqZilFUE5jkivO2NLHwbPffiawbjfSURsL74d+l7Jlg==
X-Received: by 2002:a05:651c:1058:b0:2a8:adf6:b0e2 with SMTP id x24-20020a05651c105800b002a8adf6b0e2mr760571ljm.13.1682095721298;
        Fri, 21 Apr 2023 09:48:41 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e9c1a000000b002a76dd438ddsm656599lji.79.2023.04.21.09.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 09:48:40 -0700 (PDT)
Date:   Fri, 21 Apr 2023 19:48:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Joy Chakraborty' <joychakr@google.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "rohitner@google.com" <rohitner@google.com>
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Message-ID: <20230421164838.52euobr5ohfyxxti@mobilestation>
References: <20230420055131.2048959-1-joychakr@google.com>
 <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation>
 <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
 <969a083998224016947f5e77218f4587@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969a083998224016947f5e77218f4587@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:39:30PM +0000, David Laight wrote:
> From: Joy Chakraborty
> > Sent: 21 April 2023 10:22
> ...
> > Sure, I can make the following change in the formatting and send the
> > patch series:
> >          dws->n_bytes =
> >                  roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
> >                                                  BITS_PER_BYTE));
>
 
> Won't checkpatch bleat about that?

Why would it?

> 
> Is it ever actually valid for the caller to provide a
> value that isn't 8, 16 or 32 ?

Judging by this
https://elixir.bootlin.com/linux/v6.3-rc7/source/drivers/spi/spi.c#L3630
it is. SPI-controller also supports word lengths within the
pre-synthesized range. So it's up to the SPI-peripherals and their
protocols what word length to select.

-Serge(y)

> 
> I'm sure it looked as though some other lengths/counts
> where likely to go badly wrong.
> 
> I know there are times when it is useful to bit-bang 'odd'
> numbers of bits - like command+address+delay for fast reads
> but that is a sub-32bit transfer so (at least somewhere)
> is 1 word but not all the bits.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
