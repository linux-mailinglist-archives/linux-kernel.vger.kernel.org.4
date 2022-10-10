Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871E05FA151
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiJJPm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:42:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9817B733C1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:42:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F03312FC;
        Mon, 10 Oct 2022 08:42:25 -0700 (PDT)
Received: from wubuntu (unknown [10.57.35.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391FD3F67D;
        Mon, 10 Oct 2022 08:42:18 -0700 (PDT)
Date:   Mon, 10 Oct 2022 16:42:16 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Connor O'Brien <connoro@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221010154216.6mw7fszdaoajurvm@wubuntu>
References: <20221003232033.3404802-3-jstultz@google.com>
 <20221004013611.1822-1-hdanton@sina.com>
 <CANDhNCoVzJ_MSyAigMkE-TMgfRQRkiK=G0_S3OwPfnXPuKu1iA@mail.gmail.com>
 <20221005002149.1876-1-hdanton@sina.com>
 <20221005060155.1571-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005060155.1571-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/22 14:01, Hillf Danton wrote:
> On 4 Oct 2022 18:13:52 -0700 John Stultz <jstultz@google.com>
> > On Tue, Oct 4, 2022 at 5:22 PM Hillf Danton <hdanton@sina.com> wrote:
> > > On 3 Oct 2022 19:29:36 -0700 John Stultz <jstultz@google.com>
> > > >
> > > > Why would ksoftirqd preempt the rt task?
> > > >
> > > For example the kthread becomes sensitive to latency.
> > 
> > Is it the case where
> > the ksoftirqd thread is configured to run at higher rtprio?
> > 
> Yes, you are right.

I don't see a problem here. If a sys-admin configures their ksoftirqds to be
a higher priority RT tasks than the audio threads, then they better know what
they're doing :-)

The issue at hand here is that the softirqs boundedness is hard to control. And
the scheduling delays ensued are hard to deal with by any sys-admin.

Networking has actually introduced some knobs to help control that - but the
tricky bit of still being able to deliver high throughput networking while
keeping the softirq bounded to minimize scheduling delays/latencies. I think
even for PREEMPT_RT, high performance networking could be impacted to achieve
the required low latency.

See this paper which explores this duality:

	https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.702.7571&rep=rep1&type=pdf


With WiFi 6 and 5G mobile networks, phones are actually expected to deliver
multi-gigabit network throughputs.


Cheers

--
Qais Yousef
