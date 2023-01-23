Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7D677E97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjAWPDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbjAWPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:02:58 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF61A252;
        Mon, 23 Jan 2023 07:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QsIsfRz11u76ytKuRg/7ke75KipeBiduQx3nFpUgW40=; b=lORnCktcinTTw0vdbaUqtLvSWU
        FLKbaxy/LWEaX+OUvNyhDQj/hk3/NndAd0LX9zRtxLWhgUE4jnS/k8JjIHVYQ/zsnTwsEtoSRFC0X
        40GoQ4mt2NJ5fkXICxdS0IT+wu2blvZeweZ8nV2bFRYyQJLyyHZQWBAZFaapwGGrclgw0ZaV+cX3R
        c1I/4f413R4gNe+cycym20RZjqxTQWnq5gKRnjcLSiGeNwsxzyJ81u4YUBCM1kKndswlsGlk7BdYY
        EfdAW0TT9SsGbb5zpfmHsdhLa5uxhPpqIvEWwehcZd//YGS/2ne1RbGhLqCrBS49iK3S3Z1IJe06a
        8XoXrz7w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pJyKo-001Z3P-0w;
        Mon, 23 Jan 2023 15:02:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7376A30008D;
        Mon, 23 Jan 2023 16:02:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52C2A202441DC; Mon, 23 Jan 2023 16:02:39 +0100 (CET)
Date:   Mon, 23 Jan 2023 16:02:39 +0100
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
Message-ID: <Y86hjxjEizQILXB+@hirez.programming.kicks-ass.net>
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

> After applying your diff, lockdep message changed like below. Is this
> the reason commit 1704f47b50b5 ("lockdep: Add novalidate class for
> dev->mutex conversion") was applied?

No, reason was device probing itself. There should be a thread about
that with Alan Stern some 15 years ago or so.

I'll try and have a look at the new splat later today.
