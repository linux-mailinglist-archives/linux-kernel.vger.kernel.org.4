Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4F669984D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBPPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBPPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:05:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96AE86B5;
        Thu, 16 Feb 2023 07:05:47 -0800 (PST)
Date:   Thu, 16 Feb 2023 16:05:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676559946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcd9pZdfs4tzgndqobKBzI9fzLihb8+hry0dZC6HYME=;
        b=1z5GUm5QARNWFKNvZxoVD87irJBdhQMB7eWsWvh4tcKXJwzE4YMsfddOPCEoa6fHeG8cf3
        E56WwNxmPMPz6x0ccDhWPgaTVH1ieoTiQsUldrqcSIWmAQSaAZOR3AyhPauZVT/HbHEg+H
        DJE/s8/oW+RcJ8vlMZKgSgBcchPp71d/LD6Eqdmm5bB5r6MfKGV9IKdLDISbPOJoJwgL+6
        IYcjOGD9F3Ji6sawoKyfq3ESRvF8zbaNMf+HLo0Wclj64zQ3ien6/MyueUSgUjoxxwPs2o
        sbd3iGg8z9Cj2undSLxCLFBnbqI8ohzPEnDJguQ/pzuqFoeP2wQ1NK/Jvh1iAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676559946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pcd9pZdfs4tzgndqobKBzI9fzLihb8+hry0dZC6HYME=;
        b=2hTv1TfIl+val479xbO2sCoAzPi4WujoFOPHZT3AX6mDOt6ZSijPl1NAGG6D+EebaIDxcU
        9gR+FcGH6Rko0mCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Crystal Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Keeping <john@metanate.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: rtmutex, pi_blocked_on, and blk_flush_plug()
Message-ID: <Y+5GScI95xYeQPvf@linutronix.de>
References: <4b4ab374d3e24e6ea8df5cadc4297619a6d945af.camel@redhat.com>
 <Y+47FVJ+hI+NA2In@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+47FVJ+hI+NA2In@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-16 15:18:03 [+0100], To Crystal Wood wrote:
> On 2023-02-09 22:31:57 [-0600], Crystal Wood wrote:
> > Hello!
Hi,

> - spinlock_t invokes schedule_rtlock() which avoids sched_submit_work().
>   This is the behaviour as with !RT because it spins and does not submit
>   work either.
>   rwlock_t should be have the same way but invokes schedule() instead.
>   This looks wrong. And it could deadlock in sched_submit_work().

I have to correct myself. Also for rwlock_t it uses schedule_rtlock()
which means it does not invoke sched_submit_work().

There there I don't expect any deadlock here.

> > -Crystal

Sebastian
