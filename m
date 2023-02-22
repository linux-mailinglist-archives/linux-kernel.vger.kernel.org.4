Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074369F12B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjBVJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjBVJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:21:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB028866
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SttN5f10xfR0m0SBvLy9f8LurNJJcRsV1kewlNcV/PQ=; b=PoYQQ1EzdmKJl+OajsfbsEzegZ
        nwjVxy9hLAg1CLP1nsb/sjujKLJ618xIDJwCLA1VcfWkO2mt42HA3gfQ+sFKa6CJxji6fyUUQym6I
        PReEFUccagMDQIT7yMCLm7WvKrtcf5bD9SXGQrvh3s4itPiV8LIEdTJyIVd58KvxUiR/Gp2rKn/mx
        u+L/blaUvXewAbGiHpnZ821hkqp58DHWBn4YbdNNFWQucJmlkll9KCbcB7n2LAQPsJt+d2yRoOApY
        w6e/zF/XE8wFKFYFrrRUv2GEJ5Nv9fTqCZNUXznoN5+hcuh18nRvBXiFLq8LBgMd9ateN4ta4XiKO
        lC5Q2NcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUlIx-00CU2c-1x;
        Wed, 22 Feb 2023 09:20:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 111C4300328;
        Wed, 22 Feb 2023 10:20:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CACEB20DD8786; Wed, 22 Feb 2023 10:20:48 +0100 (CET)
Date:   Wed, 22 Feb 2023 10:20:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Olivier Dion <odion@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Official documentation from Intel stating that poking INT3
 (single-byte) concurrently is OK ?
Message-ID: <Y/XecPdgpG0Cx+gX@hirez.programming.kicks-ass.net>
References: <786f4aed-2c30-806b-409b-23a60b3d7571@efficios.com>
 <20230221125032.0b02d309@gandalf.local.home>
 <5774aace-23f3-c53d-8e65-b90b588dbbe3@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5774aace-23f3-c53d-8e65-b90b588dbbe3@efficios.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URI_DOTEDU autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:42:58PM -0500, Mathieu Desnoyers wrote:
> On 2023-02-21 12:50, Steven Rostedt wrote:
> > On Tue, 21 Feb 2023 11:44:42 -0500
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > Hi Peter,
> > > 
> > > I have emails from you dating from a few years back unofficially stating
> > > that it's OK to update the first byte of an instruction with a single-byte
> > > int3 concurrently:
> > > 
> > > https://lkml.indiana.edu/hypermail/linux/kernel/1001.1/01530.html
> > > 
> > > It is referred in the original implementation of text_poke_bp():
> > > commit fd4363fff3d9 ("x86: Introduce int3 (breakpoint)-based instruction patching")
> > > 
> > > Olivier Dion is working on the libpatch [1,2] project aiming to use this
> > > property for low-latency/low-overhead live code patching in user-space as
> > > well, but we cannot find an official statement from Intel that guarantees
> > > this breakpoint-bypass technique is indeed OK without stopping the world
> > > while patching.
> > > 
> > > Do you know where I could find an official statement of this guarantee ?
> > > 
> > 
> > The fact that we have been using it for over 10 years without issue should
> > be a good guarantee ;-)
> > 
> > I know you probably prefer an official statement, and I thought they
> > actually gave one, but can't seem to find it.
> 
> I recall an in-person discussion with Peter Anvin shortly after he got the
> official confirmation, but I cannot find any public trace of it. I suspect
> Intel may have documented this internally only.

My 2ct, ISTR this also having been vetted by AMD, perhaps they did
manage to write it down somewhere.
