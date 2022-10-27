Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FFC60F1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiJ0H41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiJ0H4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:56:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C8C9E0D7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 00:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zl7dX9EpgclanizFHawlSrlLA7C4BACktFiPWCWkC8=; b=nNGgWCX7M5YzzPx3DVqPxLB9mU
        1SjuwIUu9yfPOXdnRw+UXWI6ixnnrH9Sbx9kyBsgOryzdr/R7NIZiKQro9Bj5trZLGpayUNaP4tuJ
        F2Fn5JH2br9ur5uK+C5cgtFgKrXU4mxMKTfcF06Kabo3I6IE2MCF/y+YanrJh7I6zwoINlPvDB6hR
        L471+706a+9QITtPGdt7zPiP6OfjHfBf66r6jgoSwqgu9JexsNa9y3YuMWP9mIqtpp8MFqswovchD
        MaiEx9C9Eb5W5MGGuuU07yIvPHc6mD0cnFOdmziYqxDL5uZx/GVCj4662SmwraTmKt4Fl9O4QsqSe
        CWBuLegw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onxk5-006nz0-3O; Thu, 27 Oct 2022 07:55:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1242830029C;
        Thu, 27 Oct 2022 09:55:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0D152012B90F; Thu, 27 Oct 2022 09:55:55 +0200 (CEST)
Date:   Thu, 27 Oct 2022 09:55:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove max_vruntime() and min_vruntime()
Message-ID: <Y1o5i1Trk2aRZY4q@hirez.programming.kicks-ass.net>
References: <20221027015351.2511149-1-yajun.deng@linux.dev>
 <Y1o5ILxBd9erW5zR@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1o5ILxBd9erW5zR@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:54:09AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 27, 2022 at 09:53:51AM +0800, Yajun Deng wrote:
> > There is no need to write max_vruntime() and min_vruntime() functions,
> > we can use max_t() and min_t() instead.
> 
> Here; I did your homework for you:
> 
> /* max.c */
> #include <stdio.h>
> #include <stdint.h>
> #include <stdlib.h>
> 
> typedef unsigned long long u64;
> typedef unsigned long long s64;

This should obviously be just 'long long', but the result doesn't
change.

/me goes goes get more wake-up juice.

> 
> static u64 max_vruntime(u64 max_vruntime, u64 vruntime)
> {
> 	s64 delta = (s64)(vruntime - max_vruntime);
> 	if (delta > 0)
> 		max_vruntime = vruntime;
> 	return max_vruntime;
> }
> 
> static u64 max(u64 a, u64 b)
> {
> 	return a > b ? a : b;
> }
> 
> int main(int argc, char **argv)
> {
> 	u64 a, b;
> 
> 	if (argc < 3)
> 		return 0;
> 
> 	a = strtoll(argv[1], NULL, 10);
> 	b = strtoll(argv[2], NULL, 10);
> 	printf("         max(%lu, %lu) = %lu\n", a, b, max(a,b));
> 	printf("max_vruntime(%lu, %lu) = %lu\n", a, b, max_vruntime(a,b));
> 
> 	return 0;
> }
> 
> $ ./max -1 0
>          max(18446744073709551615, 0) = 18446744073709551615
> max_vruntime(18446744073709551615, 0) = 0
