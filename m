Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A5273F098
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 03:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjF0Bnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 21:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjF0Bnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 21:43:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A26D9;
        Mon, 26 Jun 2023 18:43:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b5018cb4dcso19154675ad.2;
        Mon, 26 Jun 2023 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687830214; x=1690422214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kuS+J2WqbCreeIe7PYXRfOV5ugfO30G3d5LDVodX73g=;
        b=jNeKvWkjvZrD2HKxULxSpne41OyLKWSbpDHFlEXuBq/OFmHg1wTo1wHPd1/P4zXVIC
         5zlgoBG9IIuIntfOL30xtjgSDbRfIdT0zS9WK+6qYlOVnHKCHNiy2pOc5i96S2pGzkvv
         /TzwKsq7eJSTxZktr48AT2Cpw6GMbWGn+oWrHxjktRocveMjkBeCuX2DIRVhvidzx0QB
         V3vwRtGZAZYYFQhNuSh1WSYBTn1crHytAnwjNxIawqRFZMnWqzxJlHIsPgUwvhbNpI9k
         QrbIX5hbhhhirnbA3W29tY/fPh4uXh4BMc5sC3cmWDbg9BfzlH6SHCVLd6uzNzgHHDzb
         sHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687830214; x=1690422214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuS+J2WqbCreeIe7PYXRfOV5ugfO30G3d5LDVodX73g=;
        b=XJ+7ppoZxhP6+knD94iwy76IykrUGHRRhbW0p1A+XlAiVqvv1km4MYEweuGXVECo/T
         kxW8jcpkQdYobWa7t76Q92m/YToc61ZftezgUMixBnGPF/dnA8CPtliGkXqd6p95+hMs
         zNaNJMLBe0A0GN9X0OZvK+yC7+UpmhhTy7hfGoa9bjEQPQMNWmzOnWc5KysCJZFu7sWT
         ASaV8ik8DeIKWp4+CdzfRf2jgPh/kFW9f2d71aitPHoy2bSbr+6adISK/rl00YVbuoJJ
         1fsH8vZ20MeA9YBLvFBT25WziaBBXOrzyuUj3CBBXiZCIx94Z4SnIgSrAPVGl4p8gARP
         j2Gw==
X-Gm-Message-State: AC+VfDw60Y3xYSxtsrjGVYrJiJgiWuy9PtdZ9a2tyR46uEiH/0oN5NBW
        EpXClE/IXGwKHyAkbXeNJmc=
X-Google-Smtp-Source: ACHHUZ61mVyjes7SOcRIwSHU7bvR49j6ng1qPouAzJLc0OIkgrxjf0PP0ZmcQJpgQpK450Gu05ddPw==
X-Received: by 2002:a17:902:dace:b0:1b6:7b75:60f with SMTP id q14-20020a170902dace00b001b67b75060fmr5585355plx.41.1687830214408;
        Mon, 26 Jun 2023 18:43:34 -0700 (PDT)
Received: from sol (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001ae0a4b1d3fsm4783498plm.153.2023.06.26.18.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 18:43:33 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:43:28 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock
 deadlock issue
Message-ID: <ZJo+wBMsyHvu/7Mj@sol>
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJk87rWsDj7pWJIP@sol>
 <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 05:50:47PM +0200, Bartosz Golaszewski wrote:
> On Mon, Jun 26, 2023 at 9:23 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> >
> > spin_lock_bh() should be sufficient, given that edge_irq_thread() is run
> > in a softirq?  That is faster and would allow the hard irq handlers to
> > still run, and timestamp the event, but inhibit the edge_irq_thread()
> > from being called on that CPU until the lock is released.
> > (hmmm, gpio_desc_to_lineinfo() also uses spin_lock_irqsave() but it is
> > never called from hard irq context, so there is a good chance I'm missing
> > something here??)
> > More on spin_lock choice below.
> 
> Again: this is incorrect - edge_irq_thread() doesn't execute in
> softirq context which can be verified by calling in_softirq() from it.
> 

Ok, that matches what I had initially thought.  Wading through the kernel
doc got me thinking the secondary handler was run as a softirq.
But it is a threaded irq used here, so the thread handler runs in a
kernel thread, as does the debounce_work_func() and hte thread handler
process_hw_ts_thread().
That's a relief.

While we are on the subject of spin_locks, why does
gpio_desc_to_lineinfo() use spin_lock_irqsave()?
I assume the _irq is necessary as the desc could be updated at interrupt
level, but AFAICT gpio_desc_to_lineinfo() is only ever called from process
context, so why not just spin_lock_irq()?

Cheers,
Kent.
