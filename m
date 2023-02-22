Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2987A69F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBVJlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjBVJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:40:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FACD4481
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TX3Rxscot+rHVja+o+ab2vLZf40EPrsycVFF9XqUkm8=; b=ZCS7ZLLAQXf9qLK+criuLtw5pc
        IvesCDDDk+cQw3rXN+gXUwpu0/ML4JCiu1qeEcQKj83WjZio9akEXGgwqnX0xBaTW2LtQK2+Dp0sP
        v4akWcKFZI3lwFR48xRtfTxEqmTW8FDEBeyugQyuRarl+3UR97PFpf1tkOhujYzDUFtQB7tDvhw2Q
        5kr0SZI5tt9qnDUDazjOOTg3LlNX03OoLCjNjpvpmowiYv/Qx66yFVEz1pKYuWrZLSjtZEPie6he2
        f3vD5b50qBjI3yAYO9Jrz+s8TFkJfjKiK0zv9LGYUg41DJFx5bwWD4yv5swZpDJtpSdgq8+8I0+lS
        x99qlQsg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUlYI-00DLzO-52; Wed, 22 Feb 2023 09:36:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 21BF93001E5;
        Wed, 22 Feb 2023 10:36:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F26EC20AB479F; Wed, 22 Feb 2023 10:36:40 +0100 (CET)
Date:   Wed, 22 Feb 2023 10:36:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     shrikanth hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Thomas Gleixner <tglx@linutronix.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Interleave cfs bandwidth timers for
 improved single thread performance at low utilization
Message-ID: <Y/XiKKDLcejSYc6+@hirez.programming.kicks-ass.net>
References: <9c57c92c-3e0c-b8c5-4be9-8f4df344a347@linux.vnet.ibm.com>
 <Y/Ov+DzOtA0iHfFO@hirez.programming.kicks-ass.net>
 <0c4d7bbb-3fef-031e-e9a1-a678ab68ade7@linux.vnet.ibm.com>
 <xm267cwa4ruo.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm267cwa4ruo.fsf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:43:27PM -0800, Benjamin Segall wrote:
> The value should never come up, so it's just a question of if it's fine
> to call get_random_* in early contexts, which I don't know offhand.

Should be, scheduler init is quite late as things go and people have
been pushing the random init earlier and earlier.
