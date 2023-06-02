Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067B720045
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjFBLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbjFBLTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:19:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC90E51
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 04:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mX/3s5jn0kye18Dtq9IV01UdoBlPE+i0WCzziDNI6ok=; b=qrMPgDfQgl7NfBgtOl4Glxq5y3
        R3xIRrOJzDdGMaZdrLY2OSL4S3I34sO8VjkMVYlpHBXvvEUZBT1dFIdf7qCUTibgxeFSMhVCUpUNe
        CcClr8wbXYn/U3oFRBNXHB0WwFtXNh/W5eFqdTh7aSSWcDjhpE3wcgNVTJmXPiql8IIgEkhaZTyzh
        XMy2On1IlTByANsgswyKkTvzk9IC2J8dh36qm0gUGqQI+DVhYe5oVwZImuer16MWOWMdoYXgp9nxJ
        E0FfJqX5Nc95FO+M+betXLc578qSQ2xn4g6xqus9FuUhRZZRil078HY+COV8dWnTr1BDlFpay8pUt
        eNyJ+r9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q52nn-001JPN-1M;
        Fri, 02 Jun 2023 11:18:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF9EF300220;
        Fri,  2 Jun 2023 13:18:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FE5A243B0938; Fri,  2 Jun 2023 13:18:37 +0200 (CEST)
Date:   Fri, 2 Jun 2023 13:18:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Consider task_struct::saved_state in
 wait_task_inactive().
Message-ID: <20230602111837.GE620383@hirez.programming.kicks-ass.net>
References: <Y++UzubyNavLKFDP@linutronix.de>
 <20230525165244.GV83892@hirez.programming.kicks-ass.net>
 <20230526080543.GF38236@hirez.programming.kicks-ass.net>
 <20230526151335.oPeFiIdq@linutronix.de>
 <20230601091234.GW83892@hirez.programming.kicks-ass.net>
 <20230602082503.GA624418@hirez.programming.kicks-ass.net>
 <20230602103731.GA630648@hirez.programming.kicks-ass.net>
 <20230602104958._mDE_6c6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602104958._mDE_6c6@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 12:49:58PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-06-02 12:37:31 [+0200], Peter Zijlstra wrote:
> > ---
> > Subject: sched: Unconditionally use full-fat wait_task_inactive()
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri Jun  2 10:42:53 CEST 2023
> > 
> > While modifying wait_task_inactive() for PREEMPT_RT; the build robot
> > noted that UP got broken. This led to audit and consideration of the
> > UP implementation of wait_task_inactive().
> > 
> > It looks like the UP implementation is also broken for PREEMPT;
> 
> If UP is broken for PREEMPT, shouldn't it get a fixes or stable tag?

It has been broken *forever*, I don't think we need to 'rush' a fix.
Also, I don't think anybody actually uses a UP+PREEMPT kernel much, but
what do I know.
