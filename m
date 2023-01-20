Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF65675CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjATSeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjATSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:34:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8084CE6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:34:07 -0800 (PST)
Date:   Fri, 20 Jan 2023 19:34:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674239644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPo3LVEpzVOEfXYBnBity1ZSDmfmPTYiTBNlP6gCwc4=;
        b=WZiGoyAIdVvdASF2zSWLpzwpOggPoPLoK9nGauUcFsTB5k8LD44Jd5OXf0WrxZr7G775Cb
        A87YhpH05Rr0g33n7TFKaLkMGQ7leN9TQtv5Tf6lEY26b3Vn8pwlctXSHlYyL4HajjBVsn
        iym8L2NC83EFOOMIWVTjaafJg/XJ8QT+TqCFgPinGwDh1LnVP9VBdDNIjTfGNM4L9e70zk
        A41/BzJKLgNryqpXLTs2fAAzP/gizkNlUgJ/ckLzY5sQfekZXrAkM8dc/Y5iCv7sdJrPjT
        KqliWNMUpFCFqhEVZjaM96oOGTL07B9GvgziVDBRFa1mDdP2g6RVDldM1hp+QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674239644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EPo3LVEpzVOEfXYBnBity1ZSDmfmPTYiTBNlP6gCwc4=;
        b=yUoCrzUdebt1eIGt/qxmKRm0Vs0plsYl5XUmgDSZ76wbWdMBLz4kD5Dw3+pa0gZ7C7uAIu
        856zN+thPlWz22Aw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <Y8remhZnLCtr+y5s@linutronix.de>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8gPhTGkfCbGwoUu@linutronix.de>
 <20230119011538.3247-1-hdanton@sina.com>
 <20230119135903.3524-1-hdanton@sina.com>
 <20230120093711.3862-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120093711.3862-1-hdanton@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-20 17:37:11 [+0800], Hillf Danton wrote:
> 
> I am fine with either 4ms or 40ms, or a second.
> 
> Given the cure, does it still work when reader bias for RT tasks is allowed?
No.

> If not, why keep starving waiters after they pay the 40ms price?

That kind of starvation will also happen if you have only spinlock_t
locks and you say 3 RT tasks that acquire the lock back to back. And a
few SCHED_OTHER tasks. Those 3 will be always be in front of the queue
(as they skip the line) and the following SCHED_OTHER tasks will starve
and never get the lock.

So it is basically the same scenario.

Sebastian
