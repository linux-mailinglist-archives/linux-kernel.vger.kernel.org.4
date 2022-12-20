Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08CDC6526B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiLTTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiLTTBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:01:09 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001371BE8E;
        Tue, 20 Dec 2022 11:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671562865;
        bh=/0Oi+DHifoIwufO7cQbm0fgGedMbH1T10vLjdK1ObKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DxxUoHNLNUIpL8TX8lq5TJKcZAC0pnvtN0HObWtd2d13Ujtje7O0DyDmd1tsPJ95r
         kNUFOHx1ZXGpm2yT0mTVqaKcd7Xo83s1Q3b3hrGHXdjjCbgPipQRgpZFxdj1hLrlJT
         FzuQO7d65d0kI1bsFuLe3cZu4hGQEqEPuEVMRgF2LEkYqVj7v9w5ZXUNrBaAe3TTb7
         MfN+hZF2LEbfV+Hd3b8Y8lRL5QI1b/D4Fn4vAtlJp0o77eG8wUsK6DrSmBvdZ8uy0E
         BlZyTrtRRunMU9rJK2Ym1XUuvE8J9lYDcpl0Ub0Tm6KCmLgBDoGS+34sKXWoIA9YZk
         J7kptzFA5gthw==
Received: from [10.1.0.30] (192-222-188-97.qc.cable.ebox.net [192.222.188.97])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Nc5Wj1HFCzbnm;
        Tue, 20 Dec 2022 14:01:05 -0500 (EST)
Message-ID: <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
Date:   Tue, 20 Dec 2022 14:01:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-20 13:29, Joel Fernandes wrote:
> 

> I do want to finish my memory barrier studies of SRCU over the holidays since I have been deep in the hole with that already. Back to the post flip memory barrier here since I think now even that might not be needed…

I strongly suspect the memory barrier after flip is useless for the same 
reasons I mentioned explaining why the barrier before the flip is useless.

However, we need to double-check that we have memory barriers at the 
beginning and end of synchronize_srcu, and between load of "unlock" 
counters and load of "lock" counters.

Where is the barrier at the beginning of synchronize_srcu ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

