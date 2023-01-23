Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B0677FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjAWP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjAWP3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:29:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E109F27D41;
        Mon, 23 Jan 2023 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T+bLlWhxraIB24/FPxicbLBvjKYyf1uyDj4VccpINmU=; b=r5HrQTNhoJx6N4BbieyQTWTPQl
        UMv0gwM+K1ovK/S89t26NhXkIbuXXN6FrmP07g/aW4cmBQLzxJAXtFZE5Nm9PTixvUKUmaaR9F19n
        uyVGe14G939AigCOrwCgZmRaoxbTQg2HyEinry/ahiCinXTciyr19ze6oSlbPbXSHRdkahfm5HRx9
        bWX1zLDQNmtYlzpE1zZBnTupNEGF9rDfwLZeR5cS9mfVHFAdOPlst1Q/DM7D4kMtopRlGW3tPo7Y9
        Cu9Q7khPsEgpi9qJXbWs/MKUt5mwe64MRVZkzqo36hSi1h61CLZceNf0JTnF09HEDhs6oUz4WOt20
        FwwZrmsw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJykk-004KC3-Nf; Mon, 23 Jan 2023 15:29:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AE1630008D;
        Mon, 23 Jan 2023 16:28:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32179202441DC; Mon, 23 Jan 2023 16:28:58 +0100 (CET)
Date:   Mon, 23 Jan 2023 16:28:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [perf] lockdep warning between cpu_add_remove_lock and
 &dev->mutex.
Message-ID: <Y86nuqyUwXUWchQs@hirez.programming.kicks-ass.net>
References: <8c3fc3d1-8fed-be22-e0e7-ef1e1ea723ce@I-love.SAKURA.ne.jp>
 <Y85yadQes4fSwCZm@hirez.programming.kicks-ass.net>
 <b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bc63c8-bb28-d21d-7c3f-97e4e79a9292@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:10:57PM +0900, Tetsuo Handa wrote:
> On 2023/01/23 20:41, Peter Zijlstra wrote:
> > On Mon, Jan 23, 2023 at 07:39:24PM +0900, Tetsuo Handa wrote:
> >> Hello.
> >>
> >> I tried to apply below patch, and hit lockdep warning during boot.
> >> Can you break this dependency?
> > 
> >   cpu_add_remove_lock
> >     cpu_hotplug_lock
> >       pmus_lock
> >         dev->mutex		(pmu_dev_alloc)
> > 
> > vs
> > 
> >   dev->mutex
> >     cpu_add_remove_lock		(pci_device_probe)
> > 
> > 
> > Possibly something like this might do -- I'm not entirely sure it's
> > fully correct, needs a bit of auditing.
> > 
> 
> After applying your diff, lockdep message changed like below. Is this
> the reason commit 1704f47b50b5 ("lockdep: Add novalidate class for
> dev->mutex conversion") was applied?

*sigh*, clearly I should have actually read the slat and not assumed it
was another perf splat.

Yes, something along these lines is why it was done. I think it was this
thread, but there might have been more:

  https://lore.kernel.org/all/Pine.LNX.4.44L0.0804171117450.18040-100000@iolanthe.rowland.org/
