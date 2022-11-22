Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B5063450E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiKVT7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbiKVT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:59:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B8A2897
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t6inRfo8fhYTcjbUb4z/g3yOL4I/5GIwL+fC0eINU40=; b=aGcBYBg9kB652G6mSb1smBAsJM
        F5GYlOXxkdXZfFuvna6dTBa5QlfvW84uPaRkj1N0AOEp/oue/a1SmKP44Adhdz6iYnuRC7debTWKf
        u0BPK5vnnEUtRA9BuoQSZOcB2cETHPj5XeQUzCZmRA1JBpfMJ3Dvl9Ec/wQsSeLBQthXnrWxnzble
        cOrwoFl+fF8NpUlupebpEq1LimcIqAbAiY4PRSJx+FRs1lJmvyLA/X3WVKS3RnFVXBfs0G3wARJ4i
        Eh72KZVX4qS1ArCScBUpd8CaCCs4LXOzp8qbvYhvXZW6z6ZEFs7nOZ8cVhH4tZZRBEomHkI9dYL5y
        TW99BiIw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxZQ4-006htl-CH; Tue, 22 Nov 2022 19:59:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52399300244;
        Tue, 22 Nov 2022 20:58:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 14AEA2D6CAB89; Tue, 22 Nov 2022 20:58:52 +0100 (CET)
Date:   Tue, 22 Nov 2022 20:58:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH-tip] sched: Don't call kfree() in do_set_cpus_allowed()
Message-ID: <Y30p+4e0KbesAw7z@hirez.programming.kicks-ass.net>
References: <20221118193302.522399-1-longman@redhat.com>
 <Y3tVPjAjE9OFRLaP@hirez.programming.kicks-ass.net>
 <601640d0-9dc2-a060-e165-c8efac54aa34@redhat.com>
 <Y3zCfQCpBu8aBy6O@hirez.programming.kicks-ass.net>
 <70b65b5b-385d-1c47-f003-1e42de290e86@redhat.com>
 <Y30h1NXFmDrHAXcy@hirez.programming.kicks-ass.net>
 <542be8a5-f374-0245-ca22-4033708b6469@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542be8a5-f374-0245-ca22-4033708b6469@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 02:30:38PM -0500, Waiman Long wrote:

> I have just sent out a new patch to fix that before I saw your email. I do
> forgot to put -tip in the subject line.

I found it; I'll stare at it in the morning. Things don't seem to want
to make much sense anymore today :-)
