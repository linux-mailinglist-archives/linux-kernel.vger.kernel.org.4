Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E2645CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLGOeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLGOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:34:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C086D48418;
        Wed,  7 Dec 2022 06:34:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D10461A22;
        Wed,  7 Dec 2022 14:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BBC433D6;
        Wed,  7 Dec 2022 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670423685;
        bh=lBKJBpVB6cbpxtDkoojthxARG0HGrqEdw1sgH86GMnY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fKsN2YiHRHTHyiHmrZsg1L8AzS7evSfvVTzCQVk4rQ9lcY/jcucuMWzwF6ka3dJUw
         XX85ugsOwwPxT9tqW8ujJvoBqRB1z9Xtqvh4bP8HPnGgUg1nh5dF0QhfcGowkOJOyt
         mdpjjhPE4d1TorIUcKr+Vb4jsA8jantfgQIg9Vem4JR3asu7gfYLDnM+FuMULmjj/o
         rp3VShtVk2IrVB/gqoG5l7pbN8rSNvQRs2bFc1YjroXt4n0tAJC4NffeUYObJctuir
         CCIAyk9bkffGyqLfeKndLv5KR0W8uuPc5F6yJpgxDbVYMhTRBw/PNm343w8Wh8Ie3P
         HdGzIR74Acc6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 44BA45C0AFC; Wed,  7 Dec 2022 06:34:45 -0800 (PST)
Date:   Wed, 7 Dec 2022 06:34:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221207143445.GA4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
 <20221206164927.GD3866@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206164927.GD3866@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:49:28PM +0100, Oleg Nesterov wrote:
> On 11/30, Eric W. Biederman wrote:
> >
> > 2) I keep thinking zap_pid_ns_processes() should be changed so that
> >    after it sends SIGKILL to all of the relevant processes to not wait,
> 
> At least I think it should not wait for the tasks injected into this ns.
> 
> Because this looks like a kernel bug even if we forget about this deadlock.
> 
> Say we create a task P using clone(CLONE_NEWPID), then inject a task T into
> P's pid-namespace via setns/fork. This make the process P "unkillable", it
> will hang in zap_pid_ns_processes() "forever" until T->parent reaps a zombie
> task T killed by P.

Given that this is not the first time that Tasks Trace RCU has been
involved in a deadlock involving this exit path, I could certainly get
behind this approach.  ;-)

							Thanx, Paul
