Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D530A73B28A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFWISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFWISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:18:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E432DC;
        Fri, 23 Jun 2023 01:18:00 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:17:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687508278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HIEiQwq/tiP0YESCXeQonSoeZwDOLqCYGYuM4G0DQI=;
        b=3ekUUU7ZpkEtF97la18Ks6zNbqeqemw8Tw0ZA3E3KPFcxuSCXKMoIk29oTtaolRW+F764p
        qag5av8B5AGlBiAUKGsAGfrxAa1hZW66CyqbhytsYZwPwYmHNmZ9idYm8N1ZHo/EHAxw1b
        LF8yd/sl1WgcXBAI6DEtYssf0zhpT78GOTnupvIUytINDLWcIQKg4hVgO3d/ALr3iaxlaZ
        O+VyOiV4lVdByTlci/xbRSQMJlkpgYlDwRIWZCqarUTkZrFG+rX8Jsy8Z3HO7ZxgY5cJma
        q34oN4QlOTE633IP09/NSvB97QJGGWLFoWKplvFZaoC3123NGgj7RPaet/HFSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687508278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6HIEiQwq/tiP0YESCXeQonSoeZwDOLqCYGYuM4G0DQI=;
        b=RohMQUn73P2BpROh8L3N42/8g/wWP/dCmMA4QWkIOHlozfQSzucJjudWNjXDzP1hP58Z5m
        rL/His4MHkbGupDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230623081756.vVHIjkC9@linutronix.de>
References: <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
 <20230623063726.ejuc6v9D@linutronix.de>
 <ed287d2f-5b53-dffb-dec3-e5b28fa70a52@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed287d2f-5b53-dffb-dec3-e5b28fa70a52@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-23 00:35:29 [-0700], John Johansen wrote:
> > 
> iirc the difference with the earlier version, is in the put case. Where in
> the earlier version, if there was lock contention the buffer would always
> get pushed onto the percpu list. With some debug patches on top we
> saw some degenerate cases where this would result in percpu lists that
> had excessive buffers on them.
> 
> So this version added a condition to force putting the buffer back
> in to the global pool if the percpu list already has 2 buffers
> cached on it.

So none of the versions perform memory allocation/ deallocation in a
preempt disabled section so it is fine from PREEMPT_RT point of view.

Sebastian
