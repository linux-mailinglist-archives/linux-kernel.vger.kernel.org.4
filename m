Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0932366DA10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjAQJfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbjAQJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:33:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC15F59D2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:32:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 60CF73825E;
        Tue, 17 Jan 2023 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673947973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXNsIh0lnYpgXnWoPchzigTDCYUxJKPhFr5rGbl3ro0=;
        b=iN8lChSlGzVoV2RkiHm/4oZyp2fUksV0PrH52fhk1TIxqikDnaBMyo7ESAy640eoVVnqsq
        rDL4ZLCypiPiWqENot9v3y8UpNXky7WBK5yhtWZqqnS8EdqnOTwr8qutOXXGfDv7fJlNdj
        +306hc2OBVFFri+T4pVnpY170bllk1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673947973;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXNsIh0lnYpgXnWoPchzigTDCYUxJKPhFr5rGbl3ro0=;
        b=y6m+TzbZl0p7PNVLqQGjOvZKZdXmJVsv5VlMjGQEdvu8a1x8e8eGFZmzmjNoqquVa1ArbU
        wmnG/VhRWPdGNABQ==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E0E4F2C141;
        Tue, 17 Jan 2023 09:32:51 +0000 (UTC)
Date:   Tue, 17 Jan 2023 09:32:50 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH v4] sched/fair: limit sched slice duration
Message-ID: <20230117093250.asfytnijs7zytscv@suse.de>
References: <20230113133613.257342-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230113133613.257342-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 02:36:13PM +0100, Vincent Guittot wrote:
> In presence of a lot of small weight tasks like sched_idle tasks, normal
> or high weight tasks can see their ideal runtime (sched_slice) to increase
> to hundreds ms whereas it normally stays below sysctl_sched_latency.
> 
> 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> (half of the sched_period). This means that they will make progress
> every sysctl_sched_latency period.
> 
> If we now add 1000 idle tasks on the CPU, the sched_period becomes
> 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> This means that the scheduler will look for picking another waiting task
> after 609ms running time (1500ms respectively). The idle tasks change
> significantly the way the 2 normal tasks interleave their running time
> slot whereas they should have a small impact.
> 
> Such long sched_slice can delay significantly the release of resources
> as the tasks can wait hundreds of ms before the next running slot just
> because of idle tasks queued on the rq.
> 
> Cap the ideal_runtime to sysctl_sched_latency to make sure that tasks will
> regularly make progress and will not be significantly impacted by
> idle/background tasks queued on the rq.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-By: Dietmar Eggemann <dietmar.eggemann@arm.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
