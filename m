Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187716DF4AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDLMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDLMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:08:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6E4EDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X6WFaagDxA1HSNNorPLlMI2u9P5Ku6tSIBRxh0ocD30=; b=ABhlM9wUckgXQJWL6kJDkzboco
        RGXw5Hg+GfMYXPpSrUSOCsLO5j7giKKNBUio/BjF3jHHWlDj8ny7A0Qf8iCdKL1n6iEm8uR3JS1Qx
        xNUyTmJgYSt2D3LFDpSOw+qK15vjUBYh1ICjy54ycwE10yrOp1Q9YRF+rDZyy6JTu0xJUldMTmJ+b
        XEr9uRFzyaCtb7wlukH+l2MK9juccfw/zwDMciwgrUEsNEc7D9c6qU5eMF4S3q4hE5q4dNl2pHfSs
        Pzz+w/acszRDsYTMAbdJLSQoIw9Amjmc65ePuB0vc+1eBgCsFaxp/tS71ZmnzV3V7JAVyTanHRevu
        yXv9Yk/Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmZGE-00DuvH-1U;
        Wed, 12 Apr 2023 12:07:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A57523002A6;
        Wed, 12 Apr 2023 14:07:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 88F3D235CC4CB; Wed, 12 Apr 2023 14:07:36 +0200 (CEST)
Date:   Wed, 12 Apr 2023 14:07:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230412120736.GD628377@hirez.programming.kicks-ass.net>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:45:57PM -0400, Daniel Jordan wrote:

> The topology of my machine is different from yours, but it's the biggest
> I have, and I'm assuming cpu count is more important than topology when
> reproducing the remote accesses.  I also tried on

Core count definitely matters some, but the thing that really hurts is
the cross-node (and cross-cache, which for intel happens to be the same
set) atomics.

I suppose the thing to measure is where this cost rises most sharply on
the AMD platforms -- is that cross LLC or cross Node?

I mean, setting up the split at boot time is fairly straight forward and
we could equally well split at LLC.
