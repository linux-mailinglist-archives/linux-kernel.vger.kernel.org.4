Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988F6FBC98
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjEIBmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjEIBmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CEC5B83
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF1C630D4
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 01:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3ACC433D2;
        Tue,  9 May 2023 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683596540;
        bh=jZagtTHMTtmGZYvRq9Ar7kJfXxSDri3els3ZX0Z2CCk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kJAcNngX0ruO6lx/uGJMJLG/iqfu75SJo9XBPE0JAcLwZKLhOJJkc+uT/jL76xzH3
         D1lYCcVbgU1xLLmOqUqQqt8PBVVMJ8BwAE2J1/xEUXTWz4ax9OeiYlUkGY2SOdJqkN
         yBDdeilKr2jLDj9WZp01zwbQXiZIYAfNE+8qJrcTJELv7hjZRO+qzW547YpCiUh2Yx
         fIAnHw3SDMvBV4fNF6pwfccaMLXHgfqopR4Pzi0r8d78Rz6mh2yeUsBf0DP1HKN0xw
         kMiKF46Mty/JYUFLWvlaQkj0C9Jwm+o+TbebSJkQTkIMgT451gPj7VZVKjp2VJLw7z
         DeravO+rVH+XA==
Date:   Mon, 8 May 2023 18:42:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        netdev@vger.kernel.org, Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH] revert: "softirq: Let ksoftirqd do its job"
Message-ID: <20230508184219.4049952c@kernel.org>
In-Reply-To: <57e66b364f1b6f09c9bc0316742c3b14f4ce83bd.1683526542.git.pabeni@redhat.com>
References: <57e66b364f1b6f09c9bc0316742c3b14f4ce83bd.1683526542.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 May 2023 08:17:44 +0200 Paolo Abeni wrote:
> Due to the mentioned commit, when the ksoftirqd processes take charge
> of softirq processing, the system can experience high latencies.
> 
> In the past a few workarounds have been implemented for specific
> side-effects of the above:
> 
> commit 1ff688209e2e ("watchdog: core: make sure the watchdog_worker is not deferred")
> commit 8d5755b3f77b ("watchdog: softdog: fire watchdog even if softirqs do not get to run")
> commit 217f69743681 ("net: busy-poll: allow preemption in sk_busy_loop()")
> commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")
> 
> but the latency problem still exists in real-life workloads, see the
> link below.
> 
> The reverted commit intended to solve a live-lock scenario that can now
> be addressed with the NAPI threaded mode, introduced with commit
> 29863d41bb6e ("net: implement threaded-able napi poll loop support"),
> and nowadays in a pretty stable status.
> 
> While a complete solution to put softirq processing under nice resource
> control would be preferable, that has proven to be a very hard task. In
> the short term, remove the main pain point, and also simplify a bit the
> current softirq implementation.
> 
> Note that this change also reverts commit 3c53776e29f8 ("Mark HI and
> TASKLET softirq synchronous") and commit 1342d8080f61 ("softirq: Don't
> skip softirq execution when softirq thread is parking"), which are
> direct follow-ups of the feature commit. A single change is preferred to
> avoid known bad intermediate states introduced by a patch series
> reverting them individually.
> 
> Link: https://lore.kernel.org/netdev/305d7742212cbe98621b16be782b0562f1012cb6.camel@redhat.com/
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
