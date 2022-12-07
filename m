Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72862646200
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLGUDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiLGUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:02:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B32FC27;
        Wed,  7 Dec 2022 12:02:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5025C61BA9;
        Wed,  7 Dec 2022 20:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D09C433C1;
        Wed,  7 Dec 2022 20:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670443318;
        bh=Demd/UfJqFw2eDXCVUg8SZIC3opSCXKHPmwW779cpVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtZx28qWQ2lj/cxCC/WUdC0hR5/c/5goXOTvWAXOlVOkqsMeCG/bLaJyM/AfUjtnx
         t1N34HbY++iJpoElHzBSiDbDqy3gxEwUffWBjXw/8mKjo9oE6UdGgpsXmjMXp0w/yb
         Od5UtLXeiFCvsQStP1JnzQ+kasPwPA7BCONQ0qtK1I/7YweYz3UOAgp+Qz8OyT13jH
         VuAZyIkV4gBamAOpeNlFRmryaOB23w5t3mCSq4AiB7xV3QZMlfY3D85cbWghH2XeAL
         ZM5DmU0mdKsr0823Azaxp45Mg5WDQw14SNxRTLDViCx9XaP/QOe4q0tpKiXRGw/sir
         rL8jCGjAI8Nng==
Date:   Wed, 7 Dec 2022 21:01:55 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()
Message-ID: <20221207200155.GA1840475@lothringen>
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

I think this was made that way on purpose, see the comment in
zap_pid_ns_processes():

	/*
	 * kernel_wait4() misses EXIT_DEAD children, and EXIT_ZOMBIE
	 * process whose parents processes are outside of the pid
	 * namespace.  Such processes are created with setns()+fork().
	 *
	 * If those EXIT_ZOMBIE processes are not reaped by their
	 * parents before their parents exit, they will be reparented
	 * to pid_ns->child_reaper.  Thus pidns->child_reaper needs to
	 * stay valid until they all go away.
	 *
	 * The code relies on the pid_ns->child_reaper ignoring
	 * SIGCHILD to cause those EXIT_ZOMBIE processes to be
	 * autoreaped if reparented.
	 *
	 * Semantically it is also desirable to wait for EXIT_ZOMBIE
	 * processes before allowing the child_reaper to be reaped, as
	 * that gives the invariant that when the init process of a
	 * pid namespace is reaped all of the processes in the pid
	 * namespace are gone.

I can't say I like the fact that a parent not belonging to a new namespace
can create more than one child within that namespace but anyway this all look
like an ABI that can't be reverted now.

Thanks.
