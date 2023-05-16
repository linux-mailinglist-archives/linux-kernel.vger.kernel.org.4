Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDEC705AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 00:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjEPWr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 18:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEPWrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 18:47:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E5DEE;
        Tue, 16 May 2023 15:47:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1aaf70676b6so1339875ad.3;
        Tue, 16 May 2023 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684277242; x=1686869242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BwVx45rSbRoG0Y+Iq+9ELL0fyg9NpBr4MhKOR0qWqws=;
        b=Nd7FCY4bWcmsXY+AFsbhYhBxW+O1J23SD+AlrtCULGzIco+tyeQhfIw/2imrd31Dpd
         MKPd4Acm4TdWi55iocMN/z+H8aN4a2AhjfxvmzODNJJhF4rSAv5k4XOoiCAzI8yVfB1y
         5xLI82/cPX8alqfcVq7CcucnjHChIWA7SeO4Sa/UyemaNE21Jl6ns9mm8b+S479RAl1f
         Bhzl5VHj9dnitQFE8emzrOlC5twuxNpYvOrI45E41E92OOIF/M29+uDUqxeTvQboxvW3
         q6UIY22FFmCeSHQWi1nFtwz0FsAsbSLCZ4wZO0s4u3H80CUDSg4Hy54dfCM7o6OyPZtw
         XeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684277242; x=1686869242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwVx45rSbRoG0Y+Iq+9ELL0fyg9NpBr4MhKOR0qWqws=;
        b=HjlRnMCVb0iQ9PiOLZLFzJBImLKsK8OJ1SOeCcDGq+R8vGGreveoXj1AbDe1kgvLxP
         yYSzdp5gmqgDTqYxP+ALAPkAoRDaZPz4YHzNIpB7NY2E8BvoQx6Ngtx5gKt4I6/vzsXy
         0Wqfv/SlLc4U+6lCtHiylOWA2Dop6Fckp2L4NuP6mGVbKMlOMv+tecz4HaoCnugnIPaQ
         aRce4xczdm15o743T2i8C2kIlamDJ7u0pLmKaLlgiW94f1yaK+WYH1P+k97vRt3BPsql
         EdiJhlGs/z5RgnUjLGw69HuTFSCD4gs4NZ/OgG9GHVe/B0cFfSNqYqSCOuajnvBYx2U+
         6HuA==
X-Gm-Message-State: AC+VfDxKaMmJPP4uGbK+kBFi/qKbsnH9sbGwbH1HuHH5BfRZMbVeotg0
        g3Hcg1/7CwywvSFvuxUCpdY=
X-Google-Smtp-Source: ACHHUZ6uOxhrdk0jihUU8nu1Mn4we7DZ5iE/mJumFGxqxQz2WPh2o7fPytaCe+YSKDintfzgKwWoAw==
X-Received: by 2002:a17:902:d4c9:b0:1ac:6c46:8c80 with SMTP id o9-20020a170902d4c900b001ac6c468c80mr41809977plg.53.1684277242190;
        Tue, 16 May 2023 15:47:22 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id b17-20020a170903229100b001ab39cd885esm15986779plh.212.2023.05.16.15.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:47:21 -0700 (PDT)
Date:   Wed, 17 May 2023 06:47:15 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "johan@kernel.org" <johan@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        Ben Brown <Ben.Brown@alliedtelesis.co.nz>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpiolib: Avoid side effects in gpio_is_visible()
Message-ID: <ZGQH8/hH0Llx3rzZ@sol>
References: <20230512042806.3438373-1-chris.packham@alliedtelesis.co.nz>
 <CACRpkdYz9ipNTo2ORXKWy5Q4uCpKL=9Gd+kK76pestX7Onuz-Q@mail.gmail.com>
 <b36fcdf1-45ab-0c06-efe4-237df0612466@alliedtelesis.co.nz>
 <CACRpkdbiSAFoJP_JB1d_6gQ+Xx7Y+mLAh=C6Za+fpyWuRe6Gbw@mail.gmail.com>
 <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31a23398-9b0e-4a19-3576-84fcfd3ce4b5@alliedtelesis.co.nz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:19:14PM +0000, Chris Packham wrote:
> 
> On 17/05/23 01:57, Linus Walleij wrote:
> > On Mon, May 15, 2023 at 12:27 AM Chris Packham
> > <Chris.Packham@alliedtelesis.co.nz> wrote:
> >
> >> In my original case which is a kernel module that exports a GPIO for
> >> userspace using gpiod_export()
> > We should not add new users for that API as it increase the usage
> > of the sysfs ABI but if it's an existing in-tree usecase I buy it.
> >
> >> The crux of the problem is that the irq_desc is created when it hasn't
> >> been requested.
> > The right solution to me seems to be to not use gpiod_export()
> > and not use sysfs TBH.
> 
> That's not really a feasible solution. I'm dealing with application code 
> that has been happily using the sysfs interface for many years.
> 
> I actually did look at getting that code updated to use libgpio earlier 
> this year but found the API was in a state of flux and I wasn't going to 
> recommend re-writing the application code to use libgpio if I knew the 
> API was going to change and we'd have to re-write it again.
> 

Its 'libgpiod'.

> Even now with the 2.0.1 libgpio there doesn't seem to be a way of asking 
> about just GPIO lines in the system, application code would still need 
> to open every /dev/gpiochipN device and ask what lines are on the chip 
> and keep the fds open for the chips that have lines the application 
> cares about but make sure to close the fd for the ones that don't. So 
> now the application code has to care about GPIO chips in addition to the 
> GPIO lines.
> 

Trying to better understand your use case - how does your application
identify lines of interest - just whatever lines pop up in
/sys/class/gpio?

Cheers,
Kent.
