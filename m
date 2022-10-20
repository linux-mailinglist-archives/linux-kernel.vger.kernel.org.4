Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9B6065F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJTQjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJTQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:39:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0959D18B06
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cO1fa2bo/Hxe/a95/4bO/HsDw7b+cut+OO7L5SimxwQ=; b=Th+EKCi6cnGdjw5lqkNiR9yeCW
        O43b6isrQP9aj9FDHB5aoCu2EoaJHdeKF/vApv2+vSn3EFasuukpX01sWna2yGlOd93UfsWVPQP8Y
        1xEOl+A2H1++e4Ud/83JSFxXnkwdBS/xSkenRauyxvfV5GCF8okOtZO03FUNvbOwwUNauz9Zrneck
        OdQDd+NoxS9bk1TIYueJX9JCe1vK6DO0OV9c6G9ptAyInkB2ADxnyDRTrIFeW7lxMrCK1lFIS6V4Z
        NcTbe99YbZdbtTew9brXmqt1Ld3/zR4phzfraXFUbySShbvlQTpPo3QUJNHhqVkKhemLMdxUa95L7
        OxewbJTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olYZd-00555H-L7; Thu, 20 Oct 2022 16:39:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6AE78300472;
        Thu, 20 Oct 2022 18:39:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4BC5C2C15969B; Thu, 20 Oct 2022 18:39:12 +0200 (CEST)
Date:   Thu, 20 Oct 2022 18:39:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ruipeng Qi <qiruipeng@lixiang.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ruipengqi7@gmail.com
Subject: Re: [PATCH] sched/fair: Change mode of period_timer to
 HRTIMER_MODE_ABS_PINNED_HARD
Message-ID: <Y1F5sDVGen7ZVW+U@hirez.programming.kicks-ass.net>
References: <20221020091742.2962-1-qiruipeng@lixiang.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020091742.2962-1-qiruipeng@lixiang.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:17:46PM +0800, Ruipeng Qi wrote:
> Previous mode of period_timer is HRTIMER_MODE_ABS_PINNED,which means
> timer callback function will be executed in soft irq context.
> 
> When one task group runs out of quota in a period,but holding lock of
> softirq_ctrl,the task will be rescheduled later,and then a system stall
> occurs:
>  - next period comes,
>  - __do_softirq can't acquire lock of softirq_ctrl,
>  - __do_softirq will not be invoked,
>  - callback of period_timer will not be invoked,
>  - task group will not get any quota in any new period.
>  - a system stall occurs.
> 
> Changing mode of period_timer to HRTIMER_MODE_ABS_PINNED_HARD,which mean
> timer callback function executed in hard irq context fix this problem.

What I'm missing here is a statement about how the runtime complexity of
that timer function is sufficiently bounded to run in hardirq context on
RT kernels.
