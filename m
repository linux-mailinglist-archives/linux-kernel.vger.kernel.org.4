Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199C36EE03E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 12:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjDYKZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 06:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbjDYKY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 06:24:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5989E12CA1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 03:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8trxHQlipP6oT34LPJl9VgVH6T2UJUKznx7G3zY+IKU=; b=rFuXQWBTFTOUMXG/6yBzO+TVZD
        rvdUrm5d9c0UvWwXltdjfcgrU4O2yKjlbJC5MalRCsI4HKX4q/Svz6ykB8WSRH8UcSKR9YcV9jv4A
        PBF61THdszy6sOMmEGfT2YHAjGGZWJxFtdvADoh1YY0WV5pBl2KzrCngASDfSnToR/tsjo3U1hmDh
        siQ9vM8UGtGwgs8bxbq0VjbH9LqLIjhMVi5tVdjlQ/rI6A7No05FAupvnzR3eljpDtFqDYc79qP0O
        dJrvNB8Me+ZvN/Y5fJXj1NhLCJJsdsoV74V2YsCtew6J95hDT2W9XBjXgpwspPHO+oJ9652W3runw
        nzoHWBHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prFqN-009bWp-2g;
        Tue, 25 Apr 2023 10:24:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBE4C300380;
        Tue, 25 Apr 2023 12:24:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D47D931C6F0C6; Tue, 25 Apr 2023 12:24:16 +0200 (CEST)
Date:   Tue, 25 Apr 2023 12:24:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     zhaomzhao@126.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Subject: Re: [PATCH v1] sched/fair: fix inconsistency in
 update_task_scan_period
Message-ID: <20230425102416.GA1335080@hirez.programming.kicks-ass.net>
References: <20230425100204.2032009-1-zhaomzhao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425100204.2032009-1-zhaomzhao@126.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 06:02:04AM -0400, zhaomzhao@126.com wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> During calculate numa_scan_period diff, the actual code
> and the comment are inconsistent. The comment says it is
> using shared faults ratio, but code uses private faults
> ratio. This patch fixes it.

So for some reason you think the comment is correct ? You also don't
discuss the performance changes caused by changing the code.
