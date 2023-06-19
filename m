Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A88F734BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjFSGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjFSGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:18:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887A88F;
        Sun, 18 Jun 2023 23:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA11614A7;
        Mon, 19 Jun 2023 06:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0F9C433C0;
        Mon, 19 Jun 2023 06:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687155494;
        bh=1QwrfkXws282a/X0drBElYIBbWLM8rTUZ8/6zofeERE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTw4njNyovkm9utAYfDJaAvpzyn0fan/TX8kaURDGHCroW8Ro2UX+6XbxZ+dCM/Nu
         fuihdgPbqZS1rrJHZdA6W3t1/ads6YvYKWMpTAtdOBRsx0VnIqG4a/uZHgxo35Kx8k
         UgssX+NSq+qYffLd1vRbANZKktwPH63Sql/TsY9E=
Date:   Mon, 19 Jun 2023 08:18:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        Luiz Capitulino <luizcap@amazon.com>,
        Sven-Haegar Koch <haegar@sdinet.de>,
        "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, abuehaze@amazon.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tick/common: Align tick period during sched_timer setup.
Message-ID: <2023061944-uprising-applaud-990a@gregkh>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
 <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
 <2a3fa097-8ba0-5b0e-f506-779fee5b8fef@sdinet.de>
 <f5d2cc62-4aae-2579-1468-2e6e389f28dc@amazon.com>
 <23fb8ad7-beb0-ae1c-fa5a-a682a57f79b0@grsecurity.net>
 <20230615091830.RxMV2xf_@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615091830.RxMV2xf_@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:18:30AM +0200, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The tick period is aligned very early while the first clock_event_device
> is registered. The system runs in periodic mode and switches later to
> one-shot mode if possible.
> 
> The next wake-up event is programmed based on aligned value
> (tick_next_period) but the delta value, that is used to program the
> clock_event_device, is computed based on ktime_get().
> 
> With the subtracted offset, the devices fires in less than the exacted
> time frame. With a large enough offset the system programs the timer for
> the next wake-up and the remaining time left is too little to make any
> boot progress. The system hangs.
> 
> Move the alignment later to the setup of tick_sched timer. At this point
> the system switches to oneshot mode and a highres clocksource is
> available. It safe to update tick_next_period ktime_get() will now
> return accurate (not jiffies based) time.
> 
> [bigeasy: Patch description + testing].
> 
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Reported-by: "Bhatnagar, Rishabh" <risbhat@amazon.com>
> Fixes: e9523a0d81899 ("tick/common: Align tick period with the HZ tick.")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lore.kernel.org/5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net
> Link: https://lore.kernel.org/12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com
> ---
>  kernel/time/tick-common.c | 11 +----------
>  kernel/time/tick-sched.c  | 13 ++++++++++++-
>  2 files changed, 13 insertions(+), 11 deletions(-)

What's the status of this fix, I didn't see it in -rc7, am I looking in
the wrong place?

thanks,

greg k-h
