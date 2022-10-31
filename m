Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422CF613F34
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJaUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaUrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:47:04 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0CD12AC9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 13:47:03 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 918B9240029
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 21:47:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.eu; s=2017;
        t=1667249222; bh=14ImJoriqviYQaubYTW2HWYoZcV6WuztfnCI0NZQ2Bc=;
        h=Date:From:Subject:To:Cc:From;
        b=gej8Gn2LSjg738qmxy8uVtlwf9JsIbOnvnfrCwfjY+h5gegHfJyfxWrd15e7Jkk1f
         QBbOwJW1v4MvyEVdu6T31zOI9Phhexk5056aP0lDnsQtHzxzmtVxzaHkxuSsAzQi7X
         fH9y6aSM0B7ilKPyXA/Vm9gVXgkbhMa8UrX1CDAlNMPYmXdDs0jBLqXVJQ//Ai8nTY
         APMTRjk7szb7F8SNb1UZHZSHp5+uK+WPm87U8yN5H/6w7DFXmmY3+ejuAYV7puizJ/
         8ohSH/N1Q4p0V6iHe4cIjk5KW9TdNPLrJSbMqzHbVNoMBY2CpCaZxX93HS9KbnRy7F
         4MBVgvUgFAujg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4N1QF20DLqz9rxB;
        Mon, 31 Oct 2022 21:47:02 +0100 (CET)
Message-ID: <71829e56-a13f-0462-37a7-a4d64c16f561@posteo.de>
Date:   Mon, 31 Oct 2022 20:47:01 +0000
MIME-Version: 1.0
From:   postix@posteo.eu
Subject: Fwd: [REGRESSION 6.0.x / 6.1.x] NULL dereferencing at tracing
Reply-To: 20221031144850.5522b036@rorschach.local.home
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        tiwai@suse.de
References: <e693eb6b-28d0-d091-3df3-60f2b591c0e7@posteo.de>
Content-Language: en-US, de-DE
In-Reply-To: <e693eb6b-28d0-d091-3df3-60f2b591c0e7@posteo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you apply this to see if it fixes it?
>
> I'm guessing there's a path to the release of the file descriptor where
> the ring buffer isn't allocated (and this expected it to be).
>
> I'll investigate further to see if I can find that path.
>
> -- Steve
>
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c 
> index 199759c73519..c1c7ce4c6ddb 100644 --- 
> a/kernel/trace/ring_buffer.c +++ b/kernel/trace/ring_buffer.c @@ 
> -937,6 +937,9 @@ void ring_buffer_wake_waiters(struct trace_buffer 
> *buffer, int cpu)   	struct ring_buffer_per_cpu *cpu_buffer;
>   	struct rb_irq_work *rbwork;
>   
> + if (!buffer) + return; +   	if (cpu == RING_BUFFER_ALL_CPUS) {
>   
>   		/* Wake up individual ones too. One level recursion */

Dear Steve,


I have tested your suggested patch using kernel 6.1.0-rc2, but 
unfortunately it didn't fix the issue for me.

Thank you for looking into it though!


Best Regards

--AD




