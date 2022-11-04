Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8161C61A063
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKDS6N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Nov 2022 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKDS6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:58:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224B651C34;
        Fri,  4 Nov 2022 11:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0D8C622FD;
        Fri,  4 Nov 2022 18:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA292C433D6;
        Fri,  4 Nov 2022 18:58:05 +0000 (UTC)
Date:   Fri, 4 Nov 2022 14:58:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC][PATCH v3 12/33] timers: dma-buf: Use
 timer_shutdown_sync() before freeing timer
Message-ID: <20221104145804.4ec8404e@rorschach.local.home>
In-Reply-To: <d916e29d-d098-c3f3-940a-37be6772ecb5@amd.com>
References: <20221104054053.431922658@goodmis.org>
        <20221104054914.085569465@goodmis.org>
        <20221104015444.57f73efb@rorschach.local.home>
        <d916e29d-d098-c3f3-940a-37be6772ecb5@amd.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 08:15:53 +0100
Christian König <christian.koenig@amd.com> wrote:

> > index fb6e0a6ae2c9..5d3e7b503501 100644
> > --- a/drivers/dma-buf/st-dma-fence.c
> > +++ b/drivers/dma-buf/st-dma-fence.c
> > @@ -412,7 +412,7 @@ static int test_wait_timeout(void *arg)
> >   
> >   	err = 0;
> >   err_free:
> > -	del_timer_sync(&wt.timer);
> > +	timer_shutdown_sync(&wt.timer);  
> 
> Mhm, what exactly is the benefit of renaming the function?
> 
> Not that I'm against the change, but my thinking is more if there are 
> more functions which don't re-arm the time than those which do that then 
> why not forbid it in general?

Timers are more often re-armed then not. I had to look for the
locations where del_timer*() was called just before freeing, and other
locations where they are freed later.

I didn't rename del_timer_sync() to timer_shutdown_sync(), this version
renamed the new "del_timer_shutdown()" to "timer_shutdown_sync()".

Maybe I'm just confused at what you are asking.

-- Steve
