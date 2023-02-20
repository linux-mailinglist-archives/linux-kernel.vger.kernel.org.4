Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0B69C8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjBTKh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjBTKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:37:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7348819F0B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 02:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dqC6uCCNSZsh7QLdjCh88Mrfy984bt4Auv6cufE9wqQ=; b=N4euyOkHcEf43v//6Kh1tJaYpn
        70Z8SRb+/tAYT14cyq3VamOH/yz5vt5Z+x3ER78NuHXmJ9jSsI66mc5YYB/O9CRCw+q4l9j6ekOrS
        TgjNxBLTp0iBz9AG6AQSnV9ov/n0k6KBVKs8qo790m9iTd7DR9L2jsb2X3WSLTOmeCYGUTq5WMBr4
        +QGiTQ3Vq2Pq6qY88VkmxC+X0s+br5CNJRVGGYFx8eS5xBfmVgtCFeJMh9s8N+WfqJQa3iae60y1w
        mJBLOA5PBcLTYW6TNZGMSfXM/+wOUIGRKRhrY4Tn+JVBX0ipvLp4cwZ4rPY9j3zWHOUWKaetyktxr
        QqKknySQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pU3X1-00BeNe-Fo; Mon, 20 Feb 2023 10:36:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3666330036B;
        Mon, 20 Feb 2023 11:36:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 079CC2135FAB5; Mon, 20 Feb 2023 11:36:26 +0100 (CET)
Date:   Mon, 20 Feb 2023 11:36:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com,
        len.brown@intel.com
Subject: Re: [RFC PATCH V2 0/1] x86: cpu topology fix and question on
 x86_max_cores
Message-ID: <Y/NNKdAtSZv631Z2@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220032856.661884-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Feb 20, 2023 at 11:28:55AM +0800, Zhang Rui wrote:

> Solution for fix smp_num_sibling
> --------------------------------
> 
> Patch 1/1 ensures that smp_num_siblings represents the system-wide maximum
> number of siblings by always increasing its value. Never allow it to
> decrease.
> 
> It is sufficient to make the problem go away.
> 
> However, there is a pontenial problem left. That is, when boot CPU is an
> Ecore CPU, smp_num_sibling is set to 1 during BSP probe, kernel disables
> SMT support by setting cpu_smt_control to CPU_SMT_NOT_SUPPORTED in
> start_kernel()->check_bugs()->cpu_smt_check_topology().
> So far, we don't have such platforms.

This is the much recurring problem of the boot CPU not having access to
the system topology.

Instead of fixing that, Intel seems to work at making it worse. At some
point, we're just going to have to give up and move to DT or something
:/

Please communicate (again), that only knowing the topology/setup of the
system once all the CPUs are online is crap. Once you start bringing up
APs some things are fixed -- if we guessed wrong, we're hosed.

Specific examples of this that we've ran into in the past are:

 - does the machine have SMT
 - is the machine Hybrid
   (and if so, how many different core types will be have)

Specifically, things like determining the number of GP event counters on
a PMU sometimes depends on HT being active, but we want the PMU
initialized really early because it also serves watchdog and you want
splats when something goes side-ways.

The end result is that we have to make things complicated and
dynamically re-adjust when system resources come online.

So far we've managed -- just, but *PLEASE*, dont make it worse!!!

