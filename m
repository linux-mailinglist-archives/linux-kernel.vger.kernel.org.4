Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68F7482A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGELF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGELF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 07:05:56 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA2170D;
        Wed,  5 Jul 2023 04:05:55 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668709767b1so3441410b3a.2;
        Wed, 05 Jul 2023 04:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688555155; x=1691147155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeKtBMiAST0aoNC2/KzpUoC9c1uu7SfxW2jRYu14RC8=;
        b=fLZ7H9qMrcFlJ3fSqrlsCaiW4HNunOhg3MILl7iCC191gEnmU8quzX5gZ2xR0/x4Eo
         07e61uNayx0dII7TPmbDlgz2AZzQctserXSr9p8KhW2TvZ1euM/Cs6LYeE7Py2P08MjJ
         bQVnKo8itS3gBnIsRsApbch56Yxt1gg7LfbnZ/zRWdpLr0XsNQ1yTH5FxOUL2RF06lJL
         BVtDdfuaP1IoRJPdq9uKaV2kWvz9Ra6iQIi36shIb3hTT2VU6Y7TZvFeWz3rA0/Df+5Y
         tsHoDbucMNFQMa9N3PBCAkZolBv9tvoijl0Tqmjdvdt9SPRoFO75IC9Y1tFf6pukHCUW
         njBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688555155; x=1691147155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeKtBMiAST0aoNC2/KzpUoC9c1uu7SfxW2jRYu14RC8=;
        b=h58d0MaZHvr/TFYMiIASY2IDJFMloq9uLgf7DLjor41jK+VSfZud+W/HQUz3GIGjOW
         4Lpf4epiAdV37T8rYqeY7y1iqxJOBzM+0icasgr3l9ItCpo+NxWgYzDWhcgLrBax0uhC
         g9m2I4a3vnAoCqSR0SSZyUliv+r8DYe4c4ENMUA2k/5njsAgC2Ls+sGEKQClR8kEuWZl
         T9tY63KcHM5kwUVYZ5f2emKiYA562xpo4ncEOWaLyfTMDvMysCxoK9EMfoNFRZ0kyExB
         SAzxdlKSDD7PvLTw9miPrTGe81TlINdTZd0lQuXHpA92UOG2OSTebe2IEGnD86K6QWrT
         JkyQ==
X-Gm-Message-State: ABy/qLYYcJkf8MRSgv3rswj7DPWLlCNGD2zUqLz+WznN0xoQ5YqCrZhj
        ZUQDBZCZdDCKh8MWVnS8MO8=
X-Google-Smtp-Source: APBJJlFgzA7iOvKXi3S3vjA3bYdPOgWIseQswEpQPpyvBycy3K711me3JdBpkAKNPf75nxf2v+D8DA==
X-Received: by 2002:a05:6a00:b8c:b0:682:26e4:599e with SMTP id g12-20020a056a000b8c00b0068226e4599emr15260131pfj.21.1688555155087;
        Wed, 05 Jul 2023 04:05:55 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id y10-20020aa7804a000000b00669c99d05fasm17123254pfm.150.2023.07.05.04.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:05:54 -0700 (PDT)
Date:   Wed, 5 Jul 2023 19:05:49 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: add missing include
Message-ID: <ZKVOjft+q4FXykwd@sol>
References: <20230705074219.8321-1-brgl@bgdev.pl>
 <ZKVMr9yrL2JavqhF@sol>
 <CAMRc=MfVsayqftsBJcxyotP2Lz-EPzcXWofFBdYuBDSsVjho_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfVsayqftsBJcxyotP2Lz-EPzcXWofFBdYuBDSsVjho_g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:59:19PM +0200, Bartosz Golaszewski wrote:
> On Wed, Jul 5, 2023 at 12:57 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Wed, Jul 05, 2023 at 09:42:19AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > gpiolib.h uses notifiers but doesn't include <linux/notifier.h>.
> > >
> >
> > Fair enough.
> >
> > Reviewed-by: Kent Gibson <warthog618@gmail.com>
> >
> > Same is true for gpiolib-cdev, btw.
> > You want to touch that one up as well?
> >
> 
> No, it already includes gpiolib.h.
> 

Yeah, but that is indirect, and gpiolib-cdev.c uses struct notifier_block
directly.  Doesn't that warrant an explicit include?

Cheers,
Kent.
