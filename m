Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ACE6C31B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCUM3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:29:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA75113C0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rxExlsFHV2rHwI7H49eZY5En1rlL6SA6nz9Vc4sFlm0=; b=Em2v+J+ihQt0TSpXu5hWmjXC6D
        60WNcYLQzC+FoYCaFS3ZpyADQW31PcFJoXfNibhBLP6PJ0PdFdOcUvGl+WSzBiVI9Llt9SMMXY0I0
        4l+RaROncXF401TNL4YIqZrphQFR5DFOmI5RERB/OIJnZAOoaGinNFOx/flwblG4YdSbpc+rh7dFh
        xrpWUR/ChXSOw2hXmrAijhmOONZYLFXU+d3CfLbcLrNGMyHyu+UotSQJxsviRayRQYB9zDhw77l3U
        ODHzAb/nS09+yUaFau5c6O6Ez5nZ47JRACx5EmZlzee5MJ/cCgWcfW/VjHXW2r3r95HhTQsFuNeuC
        wQFAdHRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peb6e-0021py-8Z; Tue, 21 Mar 2023 12:28:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA73F30030F;
        Tue, 21 Mar 2023 13:28:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C4019205414ED; Tue, 21 Mar 2023 13:28:46 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:28:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
Message-ID: <20230321122846.GK2234901@hirez.programming.kicks-ass.net>
References: <20230317160810.107988-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317160810.107988-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 05:08:10PM +0100, Vincent Guittot wrote:
> Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> fixes an overflowing bug, but ignore a case that se->exec_start is reset
> after a migration.
> 
> For fixing this case, we delay the reset of se->exec_start after
> placing the entity which se->exec_start to detect long sleeping task.
> 
> In order to take into account a possible divergence between the clock_task
> of 2 rqs, we increase the threshold to around 104 days.
> 
> 
> Fixes: 829c1651e9c4 ("sched/fair: sanitize vruntime of entity being placed")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Just noticed, that SoB chain isn't valid, should Zhang be something
like: Originally-by or Suggested-by or whatever?
