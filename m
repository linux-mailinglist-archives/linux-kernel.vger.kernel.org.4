Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2686BA033
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCNT6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCNT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:58:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED223B0F4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=43005RBCqYxNFsZQigzDkWZ3ARwPuJ674R9Fb66tmh4=; b=b5U03Q6zEk6xyeFCxtIawjpkx2
        KFa8nl9wwSvjhNgg4bp2irYp40m5CvDa5hcf9cHT6jR90Siieyof1kcwAad2qOtI+F/+TE+AFfNH+
        DDQmSOLbSq25psF6ckegOCz4wrtNq3Zn45/dRkwpQoMGjlE1M2iRlktZQnp2Or8VrKD9cYAmVqlm4
        9EeAk5z229zvpe4tOPSSPaoALs60FHTXSV2t+9/3BLtdUVV7/49ux5dAjMOXdvHrm7U6LG+HHFnIP
        uLeZiCmp1NragAEOg0kfhh7G1qQtJ9CtqstqiR1f7PgNr5DakkTJs//C1sBivVo3P520vt2QxHnyh
        w+0q3JRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcAmp-001t80-2Y;
        Tue, 14 Mar 2023 19:58:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C79433001F7;
        Tue, 14 Mar 2023 20:58:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ABB65213604B6; Tue, 14 Mar 2023 20:58:18 +0100 (CET)
Date:   Tue, 14 Mar 2023 20:58:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf: fix perf_event_context->time
Message-ID: <20230314195818.GD273121@hirez.programming.kicks-ass.net>
References: <20230313171608.298734-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313171608.298734-1-song@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:16:08AM -0700, Song Liu wrote:
> Time readers rely on perf_event_context->[time|timestamp|timeoffset] to get
> accurate time_enabled and time_running for an event. The difference between
> ctx->timestamp and ctx->time is the among of time when the context is not
> enabled. __update_context_time(ctx, false) is used to increase timestamp,
> but not time. Therefore, it should only be called in ctx_sched_in() when
> EVENT_TIME was not enabled.
> 
> Fixes: 09f5e7dc7ad7 ("perf: Fix perf_event_read_local() time")
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>

Looks like I'm wearing another brown paper bag tonight..

Thanks!
