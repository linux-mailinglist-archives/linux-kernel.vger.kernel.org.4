Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CF7686EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjBATMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjBATMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:12:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C307BE74;
        Wed,  1 Feb 2023 11:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BFB96192C;
        Wed,  1 Feb 2023 19:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D3EC433EF;
        Wed,  1 Feb 2023 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675278731;
        bh=kpaUOeRYXyQg2f+dAbUbTgJ7/3PZS7RUaXOPMerihYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qHUBumJeZVGjWXNdfgmJx4mZDGcsslw0fayEEJPFOVGyqLoiQdtTLTasa4JNiy40N
         kUwbx8uc0trTRBk26alUzGn2E9gexasqrqPzb5Ai5rM3DYoN2RJv5CRmkxyFsDbA4d
         Ty4RD8ST+q+bPQHXtpY0AiC3dWjRX7mx1oOZmHGhbZSFiYPqS07eJB7+aJw+MUU0AS
         l0hS62z6cWG2826cttrYlKaqhu+RU5R+t8OO2ic6h8AqYFNq55r8Z3BCw/dXSTgARa
         qO94bK1Cx5NZDxZbYRhSdjbEICi/87ydCvXg/8Y12KRMPa4tcQpF8m3uHGpNeN68RI
         rPrGgir26P+Bw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 451DD5C06D0; Wed,  1 Feb 2023 11:12:11 -0800 (PST)
Date:   Wed, 1 Feb 2023 11:12:11 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230201191211.GK2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 04:08:06PM +0100, Uladzislau Rezki (Sony) wrote:
> This small series is based on Paul's "dev" branch. Head is 6002817348a1c610dc1b1c01ff81654cdec12be4
> it renames a single argument of k[v]free_rcu() to its new k[v]free_rcu_mightsleep() name.
> 
> 1.
> The problem is that, recently we have run into a precedent when
> a user intended to give a second argument to kfree_rcu() API but
> forgot to do it in a code so a call became as a single argument
> of kfree_rcu() API.
> 
> 2.
> Such mistyping can lead to hidden bags where sleeping is forbidden.
> 
> 3.
> _mightsleep() prefix gives much more information for which contexts
> it can be used for.

Thank you!!!

I have queued these (aside from 10/13, which is being replaced by a
patch from Julian Anastasov) for further testing and review.  And with
the usual wordsmithing.

If testing goes well, I might try to get 1/13 into the next merge window,
which would simplify things if maintainers want to take their patches
separately.

							Thanx, Paul
