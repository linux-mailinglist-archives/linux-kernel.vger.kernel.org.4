Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D0C7313A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbjFOJXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237138AbjFOJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:22:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87941709;
        Thu, 15 Jun 2023 02:22:54 -0700 (PDT)
Date:   Thu, 15 Jun 2023 11:22:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686820973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSxhHbyD3ao3w+CWcCPXZAJxdSKQ4HoWIOdzGWXnOQ8=;
        b=v/6UfCoZCZRG2kkCpcG15QPL7Vwlzi4aInwU47T6uBKUW6WiT8qCs2MeBG5JNL3OevY6ni
        fwAIQDTyIz+IaCDHD3ZiSwXh6kYK6UqOqe7HV3MkyHzLvT0wL8YZudPb4Mtp6YpvyPTkhf
        us7vZOMkt2jnd9hPA1xEyWb9cIFCP4AfxV5QRXDHA6CbCXF5rqhaCgZ1qYPqB6IQUOx93o
        ieamadhSb1/1NTtaNbCr7hrwrDukbW6kMpJHVlksd6OILHSqoYPATLlWbaDhj3G/9kBEQC
        iROKMu708yuTJEOQ4fa4AmG8m+LOc3MNyNH2xhHp5f17X/pnYo3Qca2swRZZ9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686820973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSxhHbyD3ao3w+CWcCPXZAJxdSKQ4HoWIOdzGWXnOQ8=;
        b=0wPFoFohlwE8u2JzTQrR7XBmP7tFuiGARW34hEdGeyrbKHHahAYq5vsnhViAhlhost5Vck
        DLvHopP03Hx7t3CA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Gusenleitner Klaus <gus@keba.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ tick.
 -- regression report
Message-ID: <20230615092252.8ajVwMXB@linutronix.de>
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx>
 <20230406150254.ZrawA2Y-@linutronix.de>
 <87jzypq6gq.ffs@tglx>
 <20230418122639.ikgfvu3f@linutronix.de>
 <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-14 00:59:46 [+0200], Mathias Krause wrote:
> Hi Sebastian,
Hi Mathias,

> this change doesn't seem to achieve that goal, unfortunately. Quite the 
> opposite. It makes the (boot) clock run faster and, because of the per-
> boot different offset, differently fast for each boot. Up to the point 
> where it's running too fast to make any progress at all.

I meant to reply to this thread but took the other by accident. Sorry.
This should be addressed by
	https://lore.kernel.org/20230615091830.RxMV2xf_@linutronix.de

Thank you for the report.

> Thanks,
> Mathias

Sebastian
