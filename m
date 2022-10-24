Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671960BF50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiJYAPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiJYAOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:14:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045CA487B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:33:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so9981079wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KvKVMQI/Gf7MsCNMcz7W2vTdxkJ2eKGSuhzMcXNJv4M=;
        b=eKna1N4pEq1Xlr9AirBUuAdPo3mELpqkc2JPxZkAv23uAR2J5b2znhzyGH86GTxmy6
         d/rrB8Ao8Tf4GpSMwBPVckxd2lYDrVy936ylZAvMLKVABVjC0GWfrX9JZIdemxFoU7Tq
         pqgw9g0vTLt+PIB143p3vztkiupK5i8udqeOcCoS3qdk+Wkxrvcqgh1jQQYm+8ECa5eB
         AF1HDWN3JgXqohPrVDpkIyyynSKhnMUF2mjjEEoZahsQoa9MV3L6mlMcNJYth+iIizq+
         HBOUmc3q8ASvdmhFkoxgySDWjqOvUavYPScPGcp4w4fpZ38JwSVoofOSHByfKZADv6tq
         oglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvKVMQI/Gf7MsCNMcz7W2vTdxkJ2eKGSuhzMcXNJv4M=;
        b=IdDCHfXp/54fD0D+M8wjNb8uA174Ik5Kf5xBb6wwBCkW0MA9QP97r9YWxW0BOyRjDF
         QwQGX0MwkP62gXs4hHN56ds3uxeOJTqAl7znAPbWyH1dxWU4PGKLyfq36n8ejNzrk+lv
         wtwKLKUa3Zx2m1gKPo5NDSTKO1JLUjkbjl36m047tYEwVOcod3AYsDDl3uSIF2Y0IiWl
         vlkFmkth8IR5FAhs7X+F4TEXMkBHv6uD5x+o1g4T3EORLfEN1iDUIUK3h9kmEOTKSP9R
         XZzfy+d4AzSHB2UF3xjCj+rE74QtDurlIwVpO26gXQkVIej9xezx3m7vlmyMgze/k/Ok
         rNiQ==
X-Gm-Message-State: ACrzQf3kxlWXuzIvHTe2i5UzZDTPWniZb/9/d2r4w6dJE6x2QAZvTcud
        Q0z2EKE3Aq/x8d+ZbjCbmvl6+A==
X-Google-Smtp-Source: AMsMyM54J/QgISJ/cPYAEVS7M33AgpcSLl1BBSySf/nx7xGhZoOdBom98SqeSgFTD43ZfFUagwdd0Q==
X-Received: by 2002:adf:a313:0:b0:236:56a6:f136 with SMTP id c19-20020adfa313000000b0023656a6f136mr12161221wrb.420.1666650807008;
        Mon, 24 Oct 2022 15:33:27 -0700 (PDT)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d58f2000000b0022b315b4649sm812298wrd.26.2022.10.24.15.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 15:33:26 -0700 (PDT)
Date:   Mon, 24 Oct 2022 23:33:24 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Connor O'Brien <connoro@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, youssefesmat@google.com
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <20221024223324.2jgwrmnqxpgw2m67@airbuntu>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-8-connoro@google.com>
 <Y0YeUhDZWb49mpLo@google.com>
 <Y0q7TyEWco/PfOAI@hirez.programming.kicks-ass.net>
 <20221016164809.6cd6871f@rorschach.local.home>
 <Y00DoxbG9B2YoSO3@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y00DoxbG9B2YoSO3@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 09:26, Peter Zijlstra wrote:

> Additionally, the highest priotiy waiter will get the lock next.

True for RT. But for CFS, priority is share and there will be no guarantee the
'highest priority' task will run as soon as the lock is released to grab it,
no?

For example I can envisage:

	+--------+----------------+--------+--------
	|  p0    |       p1       |   p0   |   p1
	+--------+----------------+--------+--------
              ^  ^                 ^      ^ ^
	      |  |                 |      | | 
              |  |                 |      | Fails to hold the lock
	  holds lock        releases lock | and proxy execs for p0 again
	         |                        |
		 |                        |
	     tries to hold lock         holds lock again
	     proxy execs for p0

The notion of priority in CFS as it stands doesn't help in providing any
guarantees in who will be able to hold the lock next. I haven't looked at the
patches closely, so this might be handled already. I think the situation will
be worse if there're more tasks contending for the lock. Priority will
influences the chances, but the end result who holds the lock next is
effectively random, AFAICT.

I had a conversation once with an app developer who came from iOS world and
they were confused why their higher priority task is not preempting the lower
priority one when they ported it to Android.

I wonder sometimes if we need to introduce a true notion of priority for CFS.
I don't see why an app developer who would like to create 3 tasks and give them
strict priority order relative to each others can't do that. At the moment they
have little option in controlling execution order.

Actually I think we need two types of priorities:

	* global priorities for a sys admin to say which apps are more
	  important to run over other apps. Or fairly share it if
	  equal priority.
	* local priorities for an app to control which of its tasks are more
	  important to run over other tasks it owns.

The concept of share doesn't allow controlling execution order - and forces us
to look at things like latency_nice to, somewhat, overcome this limitation.


Thanks

--
Qais Yousef
