Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739B7665E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjAKOtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjAKOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:49:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433411C2C;
        Wed, 11 Jan 2023 06:48:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D975FB81C0A;
        Wed, 11 Jan 2023 14:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D82C433D2;
        Wed, 11 Jan 2023 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673448526;
        bh=UEfl0KhVxYyXipkkr67e2P9gmRximnKB5GfIk2W8EsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzzVw6+qEMqRcc74jyTIdwny/0zFquyCQRecNUHhIgC4TAhKlfPSzjOmLFOJYxx6Y
         dby7NZLeH7KuotpImqA062vIQbVEaE6P1yIyonxoVPGOth5lHX/kM5QDVyM2E7wnfC
         eTkgxEM4YwCFbRFV3KhvPMj0iWWu9LVNGNRldO+qwQO3PLiQUe1FqxSb2iQIRSOAc7
         ZMZeLrjCDIWOoYiWB12E+2L9sNb2vSclVnXd7WlVyPlqaMqToS7mNsn/Wsywz4QWLg
         PqDgwzBWtRnT9GsgY+VCgVBA2ftABOEBnypUjjuJHWdKCjCTSQ7MIFBipCWZXe+K5N
         OZmbpZ+r6QVgA==
Date:   Wed, 11 Jan 2023 15:48:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Message-ID: <Y77MS0+8Hjoxaog+@lothringen>
References: <20230111131453.1626214-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111131453.1626214-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:14:53PM +0800, Zqiang wrote:
> Currently, the start_poll_synchronize_rcu_expedited() can be invoked
> very early. before rcu_init(), the rcu_data structure's->mynode is not
> initialized, if invoke start_poll_synchronize_rcu_expedited() before
> rcu_init(), will access to NULL mynode pointer.
> 
> This commit therefore add exp_seq_poll_rq member to rcu_state structure
> to store snap seq number

Is it even sane to poll that early in the morning? :-)

> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c     | 3 ++-
>  kernel/rcu/tree.h     | 1 +
>  kernel/rcu/tree_exp.h | 6 ++++--
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 63545d79da51..34b13d6bd8c4 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -92,6 +92,7 @@ static struct rcu_state rcu_state = {
>  	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
>  	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
>  	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> +	.exp_seq_poll_rq = RCU_GET_STATE_COMPLETED,

I don't know if we really want to fix this, but assuming we do,
can we rename it to boot_exp_seq_poll_rq? To avoid later confusion.

Thanks.
