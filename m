Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970DF6EB879
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 12:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDVKOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 06:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjDVKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 06:14:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C497198A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 03:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yWTtb8X1PWzMP0hPPxIA/opEVBGXs9woxLUOBTFzLto=; b=URet+H5Q9KNLN5qCHeLNLyT2Dj
        VdmGkSAxj3Aw6ybOEfB6vzr+dUMOBqnWSFvi3Bd5pitTjfKJP2SNfR/vY7Oe9v1BLQBJYLfVGBVw8
        grovCMQgKDmjOmWjR8n9goZ4mDCETMvmnsWxJ+YCQ0ia7UEN12MtZcPh7Zp1gptnlWKggwAIvQ8tx
        hVQm9DMwf0g+yuHfcE1gj5CAtC81EgEW+OQJE27quMIAui6IV9YYoS6XDANIJEjCad9Apu0W6LmCi
        kYTTbmDsMm8xKDu+lxAzToGhkxyV0u+gdVR2F/fxbsjvpKzBK0rnwB3P5OCzZ6YzJTFzQq/9BpXuB
        toC7A3RQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqAFD-006CPK-2w;
        Sat, 22 Apr 2023 10:13:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70B6E300338;
        Sat, 22 Apr 2023 12:13:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2BB4623BD94B2; Sat, 22 Apr 2023 12:13:25 +0200 (CEST)
Date:   Sat, 22 Apr 2023 12:13:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v3 09/14] sched: Split scheduler execution context
Message-ID: <20230422101325.GC1214746@hirez.programming.kicks-ass.net>
References: <20230411042511.1606592-1-jstultz@google.com>
 <20230411042511.1606592-10-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411042511.1606592-10-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 04:25:06AM +0000, John Stultz wrote:
> +	/*
> +	 * XXX how does (proxy exec) mutexes and RT_mutexes work together?!
> +	 */

They don't, if PE works we can delete all of rt-mutex.
