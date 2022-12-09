Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26278648987
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 21:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLIU1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 15:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLIU1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 15:27:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D0B1649D;
        Fri,  9 Dec 2022 12:27:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C8DEB82910;
        Fri,  9 Dec 2022 20:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B92C433EF;
        Fri,  9 Dec 2022 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670617620;
        bh=VHSEcb2HPradXnz78wt3OItcWSye4V75Ag/bPnxxGbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmHaN1N8+v8nni6vfG+awJLvVJX0y4/Bs8g+Xhr3PTvXflh9b952JN+naqlXRWBDI
         P4NPqI+fUZ34srK2L/xHX7Rgu4iWLM2NC8P1Tg0jw6g25SSV1VWjKmF+EE3qC94Hn4
         AJFQ56AaLZH7qcWEBlIrVwf1ymSuKLESxSVdRFJvTmc4UxJi0xKNA9oQeTo++F47IK
         etKWFSUm6SGX0JndXRDphB7wXeCYSti52SREXhSkMFVNHuUXRXKl5lxqvfe782igrJ
         t2nQrT3R6IK11QWajIAyrk8yXUDZAP2rBIs6+M03X3EGtwiNsgWNoCSg6jyohroe19
         qG9yRMfP02RpQ==
Date:   Fri, 9 Dec 2022 21:26:56 +0100
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
Message-ID: <20221209202656.GA1865787@lothringen>
References: <20221125135500.1653800-1-frederic@kernel.org>
 <20221125135500.1653800-4-frederic@kernel.org>
 <871qpkqof8.fsf@email.froward.int.ebiederm.org>
 <20221206164927.GD3866@redhat.com>
 <20221207200155.GA1840475@lothringen>
 <20221207203859.GD5421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207203859.GD5421@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 09:39:00PM +0100, Oleg Nesterov wrote:
> On 12/07, Frederic Weisbecker wrote:
> >
> > On Tue, Dec 06, 2022 at 05:49:28PM +0100, Oleg Nesterov wrote:
> > >
> > > At least I think it should not wait for the tasks injected into this ns.
> > >
> > > Because this looks like a kernel bug even if we forget about this deadlock.
> > >
> > I think this was made that way on purpose,
> 
> Well maybe. But to me we have this behaviour only because we (me at least)
> do not know how to avoid the "hang" in this case.
> 
> > see the comment in zap_pid_ns_processes():
> 
> Heh ;) I wrote this comment in a53b83154914 ("exit: pidns: fix/update the
> comments in zap_pid_ns_processes()") exactly because I didn't like this
> behaviour, but I thought it must be documented.

Bah! I should have guessed ;-)

> 
> > I can't say I like the fact that a parent not belonging to a new namespace
> > can create more than one child within that namespace
> 
> not sure I understand but this looks fine and useful to me,

I mean if only one task could be injected within a new namespace, we could be sure
that all subsequent tasks belonging to that namespace would be descendents of
that first task (the same way that every task in the default namespace is a
descendant of the real init_task) and thus we wouldn't be bothered with such
deadlocks. But I guess namespaces aren't designed to work like that. I don't
know much about them so what I'm saying is very likely irrelevant.

> > but anyway this all look like an ABI that can't be reverted now.
> 
> perhaps... But you know, I wrote my previous email because 2 weeks ago
> I had to investigate a bug report which blamed the kernel, while the
> problem (unkillable process sleeping in zap_pid_ns_processes) was caused
> by the dangling zombie injected into that process's namespace. And I am
> still trying to convince the customer they need to fix userspace.

Heh :-/

I wish we could fix this but I have no idea how. I guess the child_reaper
of an ns could avoid waiting for the rest of the ns and designate its parent
as the new child reaper.

Or we could arrange for all tasks in the ns to autoreap if they ever fall back
to be reaped by their ns->child_reaper and that child_reaper is dead.

But that would look like ABI breakages...

Thanks.
