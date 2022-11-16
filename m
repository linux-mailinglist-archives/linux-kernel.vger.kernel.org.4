Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78AA62CAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiKPUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiKPUWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:22:30 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C34391EA;
        Wed, 16 Nov 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hH19YGq1y0eRu9Lz4t4Ti6l6o3b8IXO3bDhzZqQwNaE=; b=E8C5WnIHLdEd9OcjaESPE2e+yG
        It9TH+s1V2kojVcvngPQK5OzfSjbvShhkX5JnONkhFvqpuph9NP4hDQ7WKSDjQNe6LCJUP2jQfVDh
        lvTDyPqVYIW01UVilV8SLdejTPr52jdXnIMFCXeFxohb9zMJecbJZHwj6iImS0RarSmW1Dp2t08sW
        DvQrrABoofo0DkGsZnHtmP3NyJS6aPCQ1ls64W9gS1UUXv6asuDhHSS0wWhWkOUuy7+0Jfcqj4Ktq
        w/IQ65hnJLqYwQtxmvyfgwsCTLqt5X4Al0MdBB4n5ofWsBgAAtfXfiray32/8okWcb+Gin8PPnYDS
        s0HhXcIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovOvJ-001SdE-8G; Wed, 16 Nov 2022 20:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D18B830002E;
        Wed, 16 Nov 2022 21:22:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA003206A3E3D; Wed, 16 Nov 2022 21:22:15 +0100 (CET)
Date:   Wed, 16 Nov 2022 21:22:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@suse.de>
Cc:     axboe@kernel.dk, mingo@redhat.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        liusong@linux.alibaba.com, chaitanyak@nvidia.com
Subject: Re: [PATCH 2/3] wait: Return number of exclusive waiters awaken
Message-ID: <Y3VGd4f/nk7r+Eoc@hirez.programming.kicks-ass.net>
References: <20221115224553.23594-1-krisman@suse.de>
 <20221115224553.23594-3-krisman@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115224553.23594-3-krisman@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:45:52PM -0500, Gabriel Krisman Bertazi wrote:
> Sbitmap code will need to know how many waiters were actually woken for
> its batched wakeups implementation.  Return the number of woken
> exclusive waiters from __wake_up() to facilitate that.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  include/linux/wait.h |  2 +-
>  kernel/sched/wait.c  | 18 +++++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
