Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A66066BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJTRIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJTRI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:08:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B1A1A5B1C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kpn8YsdQvhY0DWQ+ycOQ/aGzOPoScQBkvytFfq3DwZs=; b=L9bQ9wrKo+47eo1YY4g/TZOSXH
        1hXPatD4S/EgEA01uMln6dOg0g/QSIsmit+HGybZSxdPJ6jOb69zN0H+H0TYMXlCSzeJLV8miv21B
        huHRN+ycDHP3Be0tgmTkYUGVp1ZgzIidKxiqcF3elgQlKvpRBHol7my7BKO2HHJjqpJISGnskl5g7
        OJNnvcEqCDIde+toKFsNZ2hrG2AXmtBO2nnpKkj/w/TsqCQHsQ3MTmSQWL5eLQQWFA+fr/VDsRolJ
        qU/yXVYsHIJ3WTyjCt0DUK5US7uuwsS+QLMj1wJOWuj6xc0K6nAWnKgDQPlPYh0ExpNOuzNuNlYd0
        2ffLbTlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olZ1i-0055LV-CT; Thu, 20 Oct 2022 17:08:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0350300209;
        Thu, 20 Oct 2022 19:08:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCC902BF8156A; Thu, 20 Oct 2022 19:08:13 +0200 (CEST)
Date:   Thu, 20 Oct 2022 19:08:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chuyi Zhou <zhouchuyi@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, htejun@gmail.com,
        lizefan.x@bytedance.com, vschneid@redhat.com, bsegall@google.com,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: Re: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
Message-ID: <Y1GAffm4aHCpvoBB@hirez.programming.kicks-ass.net>
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
 <Y1BqT59ovFitahJa@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1BqT59ovFitahJa@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:21:19AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 19, 2022 at 11:15:51AM +0800, Chuyi Zhou wrote:
> > Tasks may be throttled when holding locks for a long time by current
> > cfs bandwidth control mechanism once users set a too small quota/period
> > ratio, which can result whole system get stuck[1].
> > 
> > In order to prevent the above situation from happening, this patch adds
> > sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
> > the minimum percentage of quota/period users can set. The default value is
> > zero and users can set quota and period without triggering this constraint.
> > 
> > Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
> > Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> > Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> This is a bit of a bandaid. I think what we really need to do is only
> throttling when running in userspace. In kernel space, it should just keep
> accumulating used cycles as debt which should be paid back before userspace
> code can run again so that we don't throttle at random places in the kernel.

That's just moving the problem. But yeah; perhaps. Starving random
userspace is less of a problem I suppose.
