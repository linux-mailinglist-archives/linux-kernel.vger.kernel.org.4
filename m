Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0EA74B780
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGGTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGGTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:52:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2053319A5;
        Fri,  7 Jul 2023 12:52:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E51961A51;
        Fri,  7 Jul 2023 19:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012FCC433C7;
        Fri,  7 Jul 2023 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688759573;
        bh=9mAv2zb774pwe3iOYVua/iGcjk/mXLKCLXU/kTj+tYU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lxqWexKHSGORoOvxgS1r3nbcews2tsO7mowi1yx+lu1WE3yuB97MQPBflkcTeBuhs
         l2lncy+3R211VHQGA7pPbgbNIr3qQ+j3oGxA32Sdfm8B9qrW7rOnIqmzbbD+zQTdOB
         nHjRFfyFIRDGFxZdaMPQj/Cn2eEu506avOj5O9YYwnwSMBnJo0MiEwYrp9B3TOVwFX
         8FNzvNSLcQrC3ksLXoTEynPMmK3NCc7bj6NigxTGE3rgz8j0fsxMEoewVtxTA9bznJ
         zvEOzktvtDmgwlGgdXAqiDgqaodEOrPfHI6Xzdf2V5bU9ESGmfCLXy1cDBmTk3XrWr
         9gXYAQF6PkXDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 86C36CE007B; Fri,  7 Jul 2023 12:52:52 -0700 (PDT)
Date:   Fri, 7 Jul 2023 12:52:52 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refscale: Fix use of uninitalized wait_queue_head_t
Message-ID: <1629fe9b-aecc-466e-9d3c-179f90d41602@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b3a22928-6537-ebca-d9c2-82d2f940208f@redhat.com>
 <140FCD95-052F-4DA9-AA5A-374D417490A9@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <140FCD95-052F-4DA9-AA5A-374D417490A9@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 03:24:58PM -0400, Joel Fernandes wrote:
> 
> 
> > On Jul 7, 2023, at 10:56 AM, Waiman Long <longman@redhat.com> wrote:
> > 
> > ﻿On 7/7/23 10:07, Davidlohr Bueso wrote:
> >>> On Thu, 06 Jul 2023, Waiman Long wrote:
> >>> 
> >>> It was found that running the refscale test might sometimes crash the
> >>> kernel with the following error:
> >>> 
> >>> [ 8569.952896] BUG: unable to handle page fault for address: ffffffffffffffe8
> >>> [ 8569.952900] #PF: supervisor read access in kernel mode
> >>> [ 8569.952902] #PF: error_code(0x0000) - not-present page
> >>> [ 8569.952904] PGD c4b048067 P4D c4b049067 PUD c4b04b067 PMD 0
> >>> [ 8569.952910] Oops: 0000 [#1] PREEMPT_RT SMP NOPTI
> >>> [ 8569.952916] Hardware name: Dell Inc. PowerEdge R750/0WMWCR, BIOS 1.2.4 05/28/2021
> >>> [ 8569.952917] RIP: 0010:prepare_to_wait_event+0x101/0x190
> >>>  :
> >>> [ 8569.952940] Call Trace:
> >>> [ 8569.952941]  <TASK>
> >>> [ 8569.952944]  ref_scale_reader+0x380/0x4a0 [refscale]
> >>> [ 8569.952959]  kthread+0x10e/0x130
> >>> [ 8569.952966]  ret_from_fork+0x1f/0x30
> >>> [ 8569.952973]  </TASK>
> >>> 
> >>> This is likely caused by the fact that init_waitqueue_head() is called
> >>> after the ref_scale_reader kthread is created. So the kthread may try
> >>> to use the waitqueue head before it is properly initialized. Fix this
> >>> by initializing the waitqueue head first before kthread creation.
> >>> 
> >>> Fixes: 653ed64b01dc ("refperf: Add a test to measure performance of read-side synchronization")
> >>> Signed-off-by: Waiman Long <longman@redhat.com>
> >> 
> >> Strange this wasn't reported sooner.
> > 
> > Red Hat does have a pretty large QE organization that run all sort of tests include this one pretty frequently. The race window is pretty small, but they did hit this once in a while.
> 
> Having worked on this test initially, I am happy to hear that Redhat runs this test!
> 
> Thanks for fixing this issue.
> Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Applied, thank you!

							Thanx, Paul
