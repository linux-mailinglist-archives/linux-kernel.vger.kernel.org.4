Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F26E675538
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjATNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjATNEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:04:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D93C131D;
        Fri, 20 Jan 2023 05:04:19 -0800 (PST)
Date:   Fri, 20 Jan 2023 14:04:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674219856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1W0wx5GLXqJFqLI02c9LueVs242lVw0159Mgl2bhFE=;
        b=3R+rSoPpKs/9y39PgQ9cpha7hWA0zUk0UZ73qQvoXWjXXdYcW49Ep16oKAXStcVyMHIfPu
        o0pe/VzSgDfLVAn19lPkhgtf3AFMSnqyr0vnHoDZUwuiHEaEP1x0DuMMOtnz79/I6bbwhU
        xxjzoNg63xsvN5Wg7l+WtAuHNXuuPg/rsQV0bCJSeWMvka/PAfMXmjorY/+5wFVN0GOSR+
        7d7NnCCvtvY4ivemfvO7J5rv8paI1OI+ZEv8bt6IWw8br1J3ls41WkF2y9weW06ngwJQ2C
        GE9J2AZt3+1eGNQM4LVlK5+E7ryfwY/F8hRbC2aYhjxi+GhaUN38EsL5I87atA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674219856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1W0wx5GLXqJFqLI02c9LueVs242lVw0159Mgl2bhFE=;
        b=USf0ngINaW5LREgzu8Y4CtaQnxziEViykdcDhSBl3QuEeT/GvovJ2VWOS0EiPte6HDv/Oq
        Yyvg5fnu/7otr9AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8qRTwEnEJz0L4mm@linutronix.de>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org>
 <Y8mwF0m+M1+e/fz/@eldamar.lan>
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
 <Y8oNTkUVDr7iQWzp@uudg.org>
 <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
 <Y8qOOxON9Vfsek0l@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8qOOxON9Vfsek0l@uudg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-20 09:51:07 [-0300], Luis Claudio R. Goncalves wrote:
> My question is: do you prefer renumbering the bits or the neat asm hack
> that Mike proposed? 

That change, that was stable-backported, should have hit the devel tree
first. Why not sync with that?

> Luis

Sebastian
