Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7E6DF62E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjDLMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBCC93F4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oybkbka4fOpt3xY41p981UiNKAAComubQyhE6dbXvgM=; b=QgbidjcWe2Lf65qkdM3ZstxFlp
        1TKvO3E3Jswv8snN9rK1PcnMlLDSZKCLL6mu0JuR8xZW6l8OvgpGBxucirCC+Bq9mGcBzEc/XeG00
        GOBVze6QCGk8CAEpmwzaDWhfXxCDD0Z8bvrqJTmqoJbnNXpuEg3ZCsP+gptobdtrUYhbgU5M7pNRb
        HoXPjTmRTN87+vHPB4Saebp5PL7dRV2Ymsxdq3LIIA3V53uy8lS5HDBbR186VndHJbibP8vI7sY3U
        qVQj7FDURee7zwr03lC3BVWorm+fA1YkQ6i5oxKa0Igs3DN9JwHf9Ihid5zIBs1+t15w9lKXxC6Dy
        ff9TQk/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmZvw-006sGW-8s; Wed, 12 Apr 2023 12:50:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87FEB300274;
        Wed, 12 Apr 2023 14:50:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A894235CC4A1; Wed, 12 Apr 2023 14:50:43 +0200 (CEST)
Date:   Wed, 12 Apr 2023 14:50:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, tjcao980311@gmail.com
Subject: Re: [PATCH] sched/fair: fix imbalance overflow
Message-ID: <20230412125043.GG628377@hirez.programming.kicks-ass.net>
References: <20230411090611.627225-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411090611.627225-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 11:06:11AM +0200, Vincent Guittot wrote:
> When local group is fully busy but its average load is above system load,
> computing the imbalance will overflow and local group is not the best
> target for pulling this load.
> 
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reported-by: Tingjia Cao <tjcao980311@gmail.com>
> Link: https://lore.kernel.org/lkml/CABcWv9_DAhVBOq2=W=2ypKE9dKM5s2DvoV8-U0+GDwwuKZ89jQ@mail.gmail.com/T/
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Thanks, added Tested-by Tingjia per his reply.
