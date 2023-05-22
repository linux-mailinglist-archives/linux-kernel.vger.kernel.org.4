Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8970B749
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjEVIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjEVIGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:06:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A772B3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:06:07 -0700 (PDT)
Date:   Mon, 22 May 2023 10:06:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684742766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9zRzDl99pwWdehNtIs+tbua0ZXe8UOy9OP1OPW7TtY=;
        b=YcJbAjjuIS/jkNGwx7T08dow9NLLmeKv92dcL3jdekk8bwSc0KYxPXp7OodwAnE1k89J4s
        wMSoDMm+q8QiEC9LokSncRMQwfwOlCdefag9pld0rXmHEekosFrDE9bZO91b1B/JJq3DHc
        L5Ipue+zFc8dc5wejos2cqfEaJyoIlDKdn7q/IwI/a2NfUq2cBQNYgsVQi4YlUyg6QJ6uF
        nY5fZ1azKtaEeWO13zDfc4NBTM+ZGQyy7UgFjlCKhZ1JJuGM07ITHjREQ3z3/loZuNnj0H
        Lp7k/ExHWZnE8iZR68vf2XMbtoWfS7pK46c5Nd9eeGxKPpaAPYsy72XiZano5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684742766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F9zRzDl99pwWdehNtIs+tbua0ZXe8UOy9OP1OPW7TtY=;
        b=bZq6t8soZIUW6rGzv/mFMiktMNx7OwbbsopkNuVpcoJa1F6UXNueqQiDGsYz1H7Gd+IcCH
        S/02ourQJrTjskCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: r8169: disable ASPM during NAPI poll locking changes --> BUG:
 Invalid wait context --> PREEMPT_RT pain
Message-ID: <20230522080604.MgUGcyeU@linutronix.de>
References: <e55be0ae115ad6494ebb48fecd03e5c2fe528230.camel@gmx.de>
 <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28727b435c143f15feddffb4c29095fee2500dff.camel@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-21 16:27:10 [+0200], Mike Galbraith wrote:
> On Sun, 2023-05-21 at 08:03 +0200, Mike Galbraith wrote:
> > Greetings,
> >
> > The locks added to prep for $subject induce invalid context moaning due
> > to not being raw locks, but if I do that, the hold time does very bad
> > things to RT.
> 
> The locks aren't really 160us horrible. The GPU was enabled (oops),
> nouveau then makes box horrible for RT (and graphics:).  With GPU
> turned back off, the largest trace I saw was 77us, which jibes pretty
> well with new max of low to mid 50s without ftrace running, or up a tad
> over 20us for this now pretty old commodity i7 desktop box.

So you are saying it is all good?
I've been looking at the r8169 the other day and it seemed all good
since it was only scheduling workqueues and NAPI. But now I see this
mac_ocp_lock + config25_lock which are acquire in hardirq context but
can't. This needs to be taken care.

> 	-Mike

Sebastian
