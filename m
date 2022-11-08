Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39B46211EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiKHNFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiKHNFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:05:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED609B99;
        Tue,  8 Nov 2022 05:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dHBGD5sXlI0lRYkCZWGfedeiEQdnEUe+C13lU+wZ1iY=; b=QyvWUkK6pirDDr6L21v798/C7u
        qqoX+8LbeKfELkmoNJQCl1/4RTkBp+Q1C5iWU5oX4faHgFcSAUyIr/DDmsbT87hAtZlvRHdNYGDIg
        aMQBS4HzZFNOWMwAKiJTxPE01mKYIHPEDY+pTESREbmDVBbhE0JAAOus5IWcP1XNJwRy0TwmOsETt
        LY5Q6pS4faSz6cQ2Q5M7FCSK/vV3HYwAZzWr94+O52T0Tk87mnN+lV2s4iCoBTWozgbbOPXecE/ID
        k9btwTc5+ikym8XA/Y5Ms7EJjxN4f0l1duzlrtRoHojTnlo2ZU10O8NVK1YtpVB3DWbMJCaaMjxid
        RLO8fq6g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osOHe-00AHQF-5N; Tue, 08 Nov 2022 13:04:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CCC7300338;
        Tue,  8 Nov 2022 14:04:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 145D82B8C8559; Tue,  8 Nov 2022 14:04:46 +0100 (CET)
Date:   Tue, 8 Nov 2022 14:04:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y2pT7ij/TcI4EmH6@hirez.programming.kicks-ass.net>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 04:03:43PM -0400, Mathieu Desnoyers wrote:

> The credit goes to Paul Turner (Google) for the vcpu_id idea. This
> feature is implemented based on the discussions with Paul Turner and
> Peter Oskolkov (Google), but I took the liberty to implement scheduler
> fast-path optimizations and my own NUMA-awareness scheme. The rumor has
> it that Google have been running a rseq vcpu_id extension internally at
> Google in production for a year. The tcmalloc source code indeed has
> comments hinting at a vcpu_id prototype extension to the rseq system
> call [1].

Re NUMA thing -- that means that on a 512 node system a single threaded
task can still observe 512 separate vcpu-ids, right?

Also, said space won't be dense.

The main selling point of the whole vcpu-id scheme was that the id space
is dense and not larger than min(nr_cpus, nr_threads), which then gives
useful properties.

But I'm not at all seeing how the NUMA thing preserves that.

Also; given the utter mind-bendiness of the NUMA thing; should it go
into it's own patch; introduce the regular plain old vcpu first, and
then add things to it -- that also allows pushing those weird cpumask
ops you've created later into the series.
