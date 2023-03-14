Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1F86B961D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjCNN1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjCNN1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:27:03 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544A524BD9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B8EDCE1255
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4737AC433D2;
        Tue, 14 Mar 2023 13:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678800257;
        bh=L1xbswtZ+tRIScQp2d/rMwPFifCNcW4ZM2s/LXqiggw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YPMASsSeWB5qnrsUjSKf7p+yTbLM3QeBEkC2DyJnlkjympuQz5Ced/1N3qYQTQa+g
         IlImoKuLWiHWMbjJumkj/nIlXoUtLUQ3yeFbj3Ssa8mDwqb20dup0hKmCx80wajCae
         O1nt6H6eD5fpIl+iNhUZuR20a+aR7ZM/YwTN/LMuS9BCDX+KMJjnItrr9Vy1hk6x/d
         +GwuSVMWzwzWpNTMj94zJC+lNW9mru/4AFjkxqDlYmcJkfTbrs+x6e9cBLdHSTchQN
         APWAQevMmjuoOivRB1ElwnK2PMtQGkvk9sXFl7ZjAe7RRX/hBRpVqcQzLHvWmsCqaB
         l+V9J7AjsEXtw==
Date:   Tue, 14 Mar 2023 14:24:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v5 16/18] timer: Implement the hierarchical pull model
Message-ID: <ZBB1frBCnpG741ma@localhost.localdomain>
References: <20230301141744.16063-1-anna-maria@linutronix.de>
 <20230301141744.16063-17-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301141744.16063-17-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Mar 01, 2023 at 03:17:42PM +0100, Anna-Maria Behnsen a écrit :
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..5a600de3623b
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> +static bool tmigr_active_up(struct tmigr_group *group,
> +			    struct tmigr_group *child,
> +			    void *ptr)
> +{
> +	union tmigr_state curstate, newstate;
> +	struct tmigr_walk *data = ptr;
> +	bool walk_done;
> +	u32 childmask;
> +
> +	childmask = data->childmask;
> +	newstate = curstate = data->groupstate;
> +
> +retry:
> +	walk_done = true;
> +
> +	if (newstate.migrator == TMIGR_NONE) {
> +		newstate.migrator = (u8)childmask;
> +
> +		/* Changes need to be propagated */
> +		walk_done = false;
> +	}
> +
> +	newstate.active |= (u8)childmask;
> +
> +	newstate.seq++;

Are you sure you need this seq counter? What bad scenario can happen without it?

Thanks.
> 
