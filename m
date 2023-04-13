Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011EF6E10FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjDMPWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjDMPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:21:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64586C163
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JSA7DUMmab9XIFRokr1Gg2DqpWe9m6dRKJATj8CtMkE=; b=IvFUikd9p2IykK2QzRcZXGOzQu
        joWjrPxni2+21VMGpai03DpfUTNtZy2QJb2CBlyDRc83KbRv48hJztfcJ9smqNI+hzgw6m0kDxo/r
        r59TnZEMNDvIz4DcjUEB5kq7ATDP/teasdjtwge2P0ElHWLchWFAaXdXoNW/NwSkluien+zbI84q+
        5HV2K18hGH9d/2IeiBnheBc3hFcZ/ZRlrqGz8sisFl5m7FQPrzNKGB6jYE/E/zEFywUKzb/YSfR85
        AkFl9gjbxj5mSGiucerfhNkcsj2EzW4hc2RwnOxHjP8Tg6ZLsM6v/SpwtK6G/5hm3p1jbRqF1T7ww
        qqLXtItA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pmykJ-00Elmn-2d;
        Thu, 13 Apr 2023 15:20:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5756430008D;
        Thu, 13 Apr 2023 17:20:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DB8E2023D643; Thu, 13 Apr 2023 17:20:23 +0200 (CEST)
Date:   Thu, 13 Apr 2023 17:20:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com
Subject: Re: [RFC PATCH v4] sched: Fix performance regression introduced by
 mm_cid
Message-ID: <20230413152023.GO4253@hirez.programming.kicks-ass.net>
References: <20230410150150.2179062-1-mathieu.desnoyers@efficios.com>
 <20230411045225.GA3509@ziqianlu-desk2>
 <20230411131221.GA7356@ziqianlu-desk2>
 <20230412091043.GC4253@hirez.programming.kicks-ass.net>
 <20230412114240.GA155547@ziqianlu-desk2>
 <20230412142616.GI628377@hirez.programming.kicks-ass.net>
 <20230412143934.GB162902@ziqianlu-desk2>
 <20230413111047.GB83892@hirez.programming.kicks-ass.net>
 <6b8e63ab-e81e-470c-e03f-f3860c83bdb1@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8e63ab-e81e-470c-e03f-f3860c83bdb1@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 09:56:38AM -0400, Mathieu Desnoyers wrote:

> > Mathieu, WDYT? -- other than that the patch is an obvious hack :-)
> 
> I hate it with passion :-)
> 
> It is quite specific to your workload/configuration.
> 
> If we take for instance a process with a large mm_users count which is
> eventually affined to a subset of the cpus with cpusets or
> sched_setaffinity, your patch will prevent compaction of the concurrency ids
> when it really should not.

I don't think it will, it will only kick in once the higest cid is
handed out (I should've used num_online_cpus() instead of nr_cpu_ids),
and with affinity at play that should never happen.

Now, the more fancy scheme with:

	min(t->nr_cpus_allowed, atomic_read(&t->mm->mm_users))

that does get to be more complex; and I've yet to find a working version
that doesn't also need a for_each_cpu() loop on for reclaim :/

Anyway, I think the hack as presented is safe, but a hack none-the-less.
