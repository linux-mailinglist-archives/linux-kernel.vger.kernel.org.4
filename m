Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8095FC708
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiJLOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJLOKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:10:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA3426C977
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 07:10:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E53315A1;
        Wed, 12 Oct 2022 07:10:46 -0700 (PDT)
Received: from wubuntu (unknown [10.57.35.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED1AF3F792;
        Wed, 12 Oct 2022 07:10:38 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:10:37 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Connor O'Brien <connoro@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <20221012141037.5cm3mzmnsz5wt36z@wubuntu>
References: <20221010154216.6mw7fszdaoajurvm@wubuntu>
 <20221011111846.284-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221011111846.284-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 19:18, Hillf Danton wrote:

[...]

> > The issue at hand here is that the softirqs boundedness is hard to control. And
> > the scheduling delays ensued are hard to deal with by any sys-admin.
> > 
> Given "The RT scheduler is for tasks that require strick scheduling
> requirements over all else, including performance." [1], I would invite
> Steve to shed some more light on the relation between RT scheduler and
> performance/network throughputs.
> 
> Bonus question, why softirq took no care of RT tasks, given strick
> scheduling requirements above?
> 
> [1] https://lore.kernel.org/lkml/257E96C2-6ABD-4DD6-9B7F-771DA3D1BAAA@goodmis.org/

I think you're mixing the two patches up. That patch is to help describe some
latency requirements for CFS tasks. It has nothing to do with RT. Your
suggestion to use RT scheduler is not valid as these tasks can't be converted
to RT. Which is what Steve was trying to say IIUC.

Generally converting normal application tasks into RT is a recipe for disaster
because:

	1. Misbehaving RT tasks (busy looping indefinitely) can hog the system
	   to a halt.
	2. How do you manage priorities of all these pseudo-random RT tasks
	   each application spawns so you end up with correct resource sharing?

ie: using RT policy is a privileged operation for a reason :-)

The target audience for latency_nice is the average Joe task from any
application that might have some latency requirements to deliver a better user
experience. ie: it's not strict latency requirement. We just want to handle
delays within _CFS_ part of the scheduler.

By the way, your emails don't seem to make it to LKML for some reason; they
show as '[not found]' on lore.

	https://lore.kernel.org/lkml/20221010154216.6mw7fszdaoajurvm@wubuntu/#r


Thanks

--
Qais Yousef
