Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADDF5F3B18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJDCGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDCGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:06:22 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640E733E09
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:06:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 70so11595871pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iYypC807JYs4w64BOpEsZTnI/cBYntmwgutrGP5QA+8=;
        b=IQj0OY9pgnzyNX0O21jufg0JmRCYY5TL6Xo9l1chWUNBQyHR0S0UIIT3ORPSqKHjXa
         lUl7pUkjsq75NiqddPlOOMBI3mf87RK4kWMqHOekHIk20xlYrd2IHE70U7s1BMdxJMit
         e94IxRJGA2fvPgN20Mxg+tbEQDVgGWmq9+whI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iYypC807JYs4w64BOpEsZTnI/cBYntmwgutrGP5QA+8=;
        b=TYM1/UIP0CaNumM0e9lxEahGuVUyQiQ0HDpNIzlEyXWtlnbm8g3hMt+2G2IEX/grtQ
         q6h7+5WC/IISYRdI9Nb5jVtK+B87RpXC4XjguZG5He8IdGrI3oOA04XAJMno6t3QIH+b
         xU69HKKWBFjkfyAf6mXSmBhp592q+rYGHbpiF1g4xvob/bApFtLWhOtye1avZqAlpPbv
         Mbn0KzPAOE8WtNxYz9tYRLu/ktwPbbnwC7m+5VJkXM4GzSu8PDqvdcDrmsKfBcQrREVk
         Y3lWVhO6yBnd/vTRo+oahzZpXpdH5b+si7810RAQsV3qRsjXnlVtzEgbWw6NiTZ4oL7p
         hDLg==
X-Gm-Message-State: ACrzQf3meT/BFAD24Y0Rtyn/EaV7Tfkbaq7A9cFVEMT/61FPztcZ7fH9
        ooXDKRvdpgj3VtjKIyDPo7pSCA==
X-Google-Smtp-Source: AMsMyM6Qg2JvrwIqQ0uIJUx+G2t5B1I3fTHUYfgBAjBDlddew0eKOzw2MDxyakB3mCUqDVoJFuRHTw==
X-Received: by 2002:a17:90a:bd01:b0:205:fa9c:1cfc with SMTP id y1-20020a17090abd0100b00205fa9c1cfcmr15173334pjr.116.1664849180964;
        Mon, 03 Oct 2022 19:06:20 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:bbfe:7397:2574:b7ff])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0044fdaa9a749sm2415137pgi.34.2022.10.03.19.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:06:20 -0700 (PDT)
Date:   Tue, 4 Oct 2022 11:06:16 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzuVGJkthm17LlSf@google.com>
References: <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
 <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de>
 <YzcvvPargLYDHhgq@alley>
 <87zgeg7gnb.fsf@jogness.linutronix.de>
 <YzrzmHZYxp8iKEDT@alley>
 <87a66c66px.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a66c66px.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/03 21:41), John Ogness wrote:
> A semaphore has been needed because we are performing global locking for
> ambiguous reasons in all possible contexts. We should be using
> fine-grained lock and synchronization mechanisms that are appropriate
> for their used contexts to precisely lock/synchronize exactly what needs
> to be locked/synchronized.
> 
> Your first question is literally, "what is wrong with a BKL".
> 
> And the answer to that is: A BKL is preventing us from optimizing the
> kernel by decoupling unrelated activities.
> 
> > The above proposal suggests that it might be something like:
> >
> > register_console()
> > {
> > 	console_list_lock();
> >
> > 	if (!need_console())
> > 		goto out;
> >
> > 	if (!try_enable_console())
> > 		goto out;
> >
> > 	if (!(con->flags & CON_NOBLK))
> > 		console_lock()
> 
> Why are you taking the console_lock here? The console_list_lock needs to
> replace this responsibility. I realize the RFC and this v1 series does
> not do this. For v2, it will be clear.

So tty/VT code also needs to take list_lock? list_lock does not look
precisely relevant to vt, which has it's own "list" of "struct vc" to
maintain.
