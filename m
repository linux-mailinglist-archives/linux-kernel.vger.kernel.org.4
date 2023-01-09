Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D141662300
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjAIKTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjAIKQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:16:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9A91868F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:16:57 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4c7d35b37e2so50296927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U60Van+eqKcdvfqQ+03BU+/nu30LeFsU7MWr64SwCAg=;
        b=G5R7bz2gNJ0Bp3J3+78krejGBZTNnpzIfGLrxDNwZBh4g0IhnjjDmyLrl+M3bixcQl
         vA3sPXPkMjqhujT+hxcLKwNIvaJl44RLcuQf5WFO+t7nwK4Y8NKNznYjjTAwUPO4PuJw
         fb5JGquilbP795H1fFOk66ZWj+OsIfkQsHjzUTxbIru5nC+RKyeT9wUSDOJxPrv157Ih
         vvGax35iGEtSb91SWvpJt2NWTUFSNmi3GBdY+SgyxwF8gtQMJGfIyBxbpRhEVbnV7jYj
         FE+Lfvxn/MDNemmgkGp2mR+xlKjq1TXxsiaFMfPI6yc54+PSShq51/YDBpmP4HiWA0kd
         0eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U60Van+eqKcdvfqQ+03BU+/nu30LeFsU7MWr64SwCAg=;
        b=rOrcgCHLQjPNsC9j089ANj79udwKHI+fOe20UuyLuCQrpczqlxYGV4wRGFX6jcVhTk
         09PMI5ECf965zXUMac/fUobD9Lh8Hos3quR2tluWhKqZ/1Pgl5KbzvHtK5l9kcCncK05
         VirkUUD61mEsHvpFDhAzQmxVt2RjKy8xBQgDMBrVm8aNR2Mcb7iaBaAgF9mFZGv7eg2n
         oRsSqS6j/kR89IrivcwhHk+6yqcqiV7QPmXkLGNiA9hVsJSZD/yKTuQUoP7WwZ+kh3C8
         pTKONCdsZaRIKd9+6IV7NBK/pewZkc3FYfwC4/17LukIwXBme90Fxwir8Xtc10ryBveC
         Osaw==
X-Gm-Message-State: AFqh2kpRsdF6lLYqVJZ2iXWw2pXmomsK2pHjDksMuCJnLawzOdo5t3L4
        O3ia1gotMT0rwYzcRK9wPUPlLb15XdCx8GvMrHvMXNKaTwhgOQ==
X-Google-Smtp-Source: AMrXdXskMkgDhLRxG6gWGGj+BS9pw7QSzhoomB4HeeSYuyksnUxqH4ZvCcmi11YEIVMRvqS159bDMsx1obzTzlEXziM=
X-Received: by 2002:a81:1441:0:b0:4bc:6c9c:bf9a with SMTP id
 62-20020a811441000000b004bc6c9cbf9amr2498262ywu.255.1673259416328; Mon, 09
 Jan 2023 02:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20221222221244.1290833-1-kuba@kernel.org> <20221222221244.1290833-4-kuba@kernel.org>
 <Y7viEa4BC3yJRXIS@hirez.programming.kicks-ass.net>
In-Reply-To: <Y7viEa4BC3yJRXIS@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 9 Jan 2023 11:16:45 +0100
Message-ID: <CANn89iK2NTz_M-OtcN5iATUacMaseNLi42QipuxDF3MMQCEVHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] softirq: don't yield if only expedited handlers are pending
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, tglx@linutronix.de,
        jstultz@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 10:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 22, 2022 at 02:12:44PM -0800, Jakub Kicinski wrote:
> > In networking we try to keep Tx packet queues small, so we limit
> > how many bytes a socket may packetize and queue up. Tx completions
> > (from NAPI) notify the sockets when packets have left the system
> > (NIC Tx completion) and the socket schedules a tasklet to queue
> > the next batch of frames.
> >
> > This leads to a situation where we go thru the softirq loop twice.
> > First round we have pending = NET (from the NIC IRQ/NAPI), and
> > the second iteration has pending = TASKLET (the socket tasklet).
>
> So to me that sounds like you want to fix the network code to not do
> this then. Why can't the NAPI thing directly queue the next batch; why
> do you have to do a softirq roundtrip like this?

I think Jakub refers to tcp_wfree() code, which can be called from
arbitrary contexts,
including non NAPI ones, and with the socket locked (by this thread or
another) or not locked at all
(say if skb is freed from a TX completion handler or a qdisc drop)

>
> > On two web workloads I looked at this condition accounts for 10%
> > and 23% of all ksoftirqd wake ups respectively. We run NAPI
> > which wakes some process up, we hit need_resched() and wake up
> > ksoftirqd just to run the TSQ (TCP small queues) tasklet.
> >
> > Tweak the need_resched() condition to be ignored if all pending
> > softIRQs are "non-deferred". The tasklet would run relatively
> > soon, anyway, but once ksoftirqd is woken we're risking stalls.
> >
> > I did not see any negative impact on the latency in an RR test
> > on a loaded machine with this change applied.
>
> Ignoring need_resched() will get you in trouble with RT people real
> fast.
