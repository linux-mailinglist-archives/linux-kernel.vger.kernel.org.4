Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5ED6315DA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKTT1s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Nov 2022 14:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTT1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:27:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF3717A8D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 11:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0993460CEB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 19:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9362C433C1;
        Sun, 20 Nov 2022 19:27:41 +0000 (UTC)
Date:   Sun, 20 Nov 2022 14:27:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, ke.wang@unisoc.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Use cpu_active_mask to prevent
 rto_push_irq_work's dead loop
Message-ID: <20221120142730.4d863176@rorschach.local.home>
In-Reply-To: <CAB8ipk8xXWzc_PurHwVPd9-azN4B5OD=MYQP+Oze1kmbom0avQ@mail.gmail.com>
References: <20221114120453.3233-1-xuewen.yan@unisoc.com>
        <20221117170028.04fd7013@gandalf.local.home>
        <CAB8ipk8xXWzc_PurHwVPd9-azN4B5OD=MYQP+Oze1kmbom0avQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 20:08:54 +0800
Xuewen Yan <xuewen.yan94@gmail.com> wrote:

> Let's consider this scenario:
> the online_cpu_mask is 0x03(cpu0/1)，the active_cpu_mask is
> 0x01(cpu0)，the rto cpu is cpu0,
> the rto_mask is 0x01, and the irq cpu is cpu0, as a result,  the first
> loop, the rto_cpu would be -1,
> but the loop < rto_loop_next, on  next loop, because of the rto_cpu is
> -1, so the next rto cpu would
> be cpu0 still, as a result, the cpu0 would push rt tasks to
> cpu1(inactive cpu) while running in the irq_work.
> 
> So we should judge whether the current cpu(the only one active cpu) is
> the next loop's cpu.

Wait, I'm confused by what you are trying to do here.

The rto_next_cpu() only sends an IPI to the next CPU that has more than
one RT task queued on it, where the RT tasks can migrate.

If we send CPU0 an IPI, let CPU0 figure out to only push to the active
mask. Why are trying to prevent sending the IPI to an active CPU?

Will the first part of your patch that modifies the cpupri() not keep
it from pushing to the non active CPU?

-- Steve
