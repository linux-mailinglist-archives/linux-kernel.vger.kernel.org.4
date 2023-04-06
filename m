Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD46D9366
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbjDFJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjDFJ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:57:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF771213B;
        Thu,  6 Apr 2023 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YxhRL3yiAbFaoSIURbLJJRHKJGjYXkeVxmnQ/pEnBmY=; b=jGkaZVBOG3JXDwyQnR5K3g7hz/
        2ptks3zFH6B32uTi1CJ187m0NUIOvTwd4CvbInPMwVIBAPC+p2DKBfy/J2kLaA/fxIEf0a0HR4Mfs
        FxgSqwl17h+5IdMBqA0/qX5e6Y7epVv5hRgeFOvyVHmfodi3Cii3INJTSk1Nv1uZ7L7hZkqvyLD4J
        4ehW5fGpIMn3gvJkcfDEB1qAy/Xgwrn+wwKGDl1s7fcnsJVGImxEUmrUWAotaLMgyE9OFK2Yyre4G
        eiSXzS/tsczaroxHZ9QV16yIcr5pxeB1fIBzpIhoHTT+ra48irTEDlcBncZDNBXA0vVpfckFTAsfB
        oMqihneg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkML1-00AUXC-1c;
        Thu, 06 Apr 2023 09:55:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20E2F30008D;
        Thu,  6 Apr 2023 11:55:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04F7520B6A7D6; Thu,  6 Apr 2023 11:55:19 +0200 (CEST)
Date:   Thu, 6 Apr 2023 11:55:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH 1/1] smp: Add tracepoints for functions called with
 smp_call_function*()
Message-ID: <20230406095519.GG386572@hirez.programming.kicks-ass.net>
References: <20230406075718.68672-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406075718.68672-1-leobras@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 04:57:18AM -0300, Leonardo Bras wrote:
> When running RT workloads in isolated CPUs, many cases of deadline misses
> are caused by remote CPU requests such as smp_call_function*().
> 
> For those cases, having the names of those functions running around the
> deadline miss moment could help finding a target for the next improvements.
> 
> Add tracepoints for acquiring the funtion name & argument before entry and
> after exitting the called function.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

How are the patches queued there not sufficient?

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=smp/core
