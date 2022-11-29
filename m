Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93163C54A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiK2Qhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbiK2Qha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:37:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DD6150C;
        Tue, 29 Nov 2022 08:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05CF61802;
        Tue, 29 Nov 2022 16:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573F3C433C1;
        Tue, 29 Nov 2022 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669739849;
        bh=EKfKe/2mfUZaI+fNUsWchrNUPYZShN052BZnl84rVrw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pHlkqYw9WoeYGYJ4shgLaIGZSS7Bc8t79tAS4WGRqUNmESWcu3l+sCtztjVrBVxYq
         7nlU68t5Q5aComUXrShoKQMY7jDYNkpWDrY9n+H2TtLUlw1nZbg5ASHiFS87vLCY/G
         HVNwfSpgBDqwYduuUXXuXxEjRliwwqOrowUS+K71TRDdutkj7Zux8I8SBAzx1F7S/l
         gwG4oDJDIyhPHFOa6qMkpt1eDP662cBlwB+lDwSGbCs4LLfHP+rxZQn1XJuptjlugv
         ej0tiE6+TYwBCh0DzKCuXkRpisceaU4aPeNvU0elLwKp+9FjZgFu4J7spB4FXc88TG
         xFF10Eb8bdTPw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E17285C0584; Tue, 29 Nov 2022 08:37:28 -0800 (PST)
Date:   Tue, 29 Nov 2022 08:37:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 0/4] kvfree_rcu() updates related to polled API
Message-ID: <20221129163728.GA4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221129155822.538434-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129155822.538434-1-urezki@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 04:58:18PM +0100, Uladzislau Rezki (Sony) wrote:
> v1 -> v2:
>   - Rebase on latest dev.2022.11.23a branch.

Much better, thank you!

I have pulled these in for review and testing.

							Thanx, Paul

> Uladzislau Rezki (Sony) (4):
>   rcu/kvfree: Switch to a generic linked list API
>   rcu/kvfree: Move bulk/list reclaim to separate functions
>   rcu/kvfree: Move need_offload_krc() out of krcp->lock
>   rcu/kvfree: Use a polled API to speedup a reclaim process
> 
>  kernel/rcu/tree.c | 221 +++++++++++++++++++++++++++-------------------
>  1 file changed, 131 insertions(+), 90 deletions(-)
> 
> -- 
> 2.30.2
> 
