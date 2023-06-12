Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D0972C950
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjFLPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjFLPGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:06:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C320CC;
        Mon, 12 Jun 2023 08:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GkyHPB5PJqVXyya1HJmHa8ORABYaU/NCZ0d93W2Vf3I=; b=fmrdvYEEH5jeX2zgYzbnx/CKGN
        BNUqZ4JZRQ1qqtjfGKTyQi/z8jnposyGDi/OuWzJp2qVZlDhAYqTdWlHOdDE0zTqVWRWQNVCTxDWl
        C7pxtmwwpK0vDIJrqlqeY13CoGnlcOO8u2+6/TSxPNXgX/+8AEuq3i7PBq/es989dfXrwSbdji/KZ
        LhRoBMyFLq1QgXXy16jBkyb4CcHdYP7umrZB2lM/BTuWrkt6NOS0rI8XbE5RD9BeKqo8n7v24thFl
        Bk1HaX1aRU4BULWG0ECOR3JRWv/2x4zGLQjfNyxT98+jFk8hVMk2uzUDb+SjQLOc3zfGagayZpXev
        x1GUo3sw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q8j7F-008uNy-32;
        Mon, 12 Jun 2023 15:05:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A9CA30031B;
        Mon, 12 Jun 2023 17:05:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EBF520D70605; Mon, 12 Jun 2023 17:05:53 +0200 (CEST)
Date:   Mon, 12 Jun 2023 17:05:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Adding support for setting the affinity of the recording
 process
Message-ID: <20230612150553.GM4253@hirez.programming.kicks-ass.net>
References: <159de73b-fdd6-6df8-4f77-73c628fe641f@huawei.com>
 <ZIcqmlHIfBbyZFDl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIcqmlHIfBbyZFDl@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:24:26AM -0300, Arnaldo Carvalho de Melo wrote:
> But could you please spell out the use case, why do you need this, is
> this so common (for you) that you repeatedly need to first taskset, then
> perf, etc?

I'm thinking this is due to big.LITTLE things where the PMUs on the CPUs
are different. Intel recently having stepped into this trainwreck,
there's now a ton more people 'enjoying' it ...

So what people often do it is affine the process to one type of CPU and
then perf it so that their measurements are consistent.

It all sucks, but given the situation, it might be the best option :/

Ian was working on improving the whole hybrid thing, perhaps he has more
opinions.
