Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E858E6EE287
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjDYNNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjDYNNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:13:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401482D52
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZQTBANVa3oFV5yAMvwtfcC58SK/396dB2/cb7fWed+E=; b=iqY3C5h39AuUUbw23EV0R0Vsg9
        84xzbF9CHJLrVk2nfbbPsOgCVLqv5dbPnVYnEE80cnlyVAPp09VITkmAcBnQ3e4AX+enBt4Yied8w
        wy59x8P4KZ0AC3wzLdrjzUF3/tJHVHxVqI9QoLcJCfFIfklglOgGqZMEWDKmgsi19Q3nWLYsRKVdi
        h4HbUR+vgF9KvXJqkK2s5baax3H618HeyMMx8ceOgEZp84jZja8VozqS5RoWkx+J2ScqriI4leYUr
        y7mqvAboJjsuMO1Q9tDF2FjtHqzSCLGFAKeVbGNUhMSKTdzB8GxAGPDl5CFtaVRM1CwOFXpvzJAdM
        JIKpcVig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1prITY-009dXl-0h;
        Tue, 25 Apr 2023 13:12:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1A7C3000D5;
        Tue, 25 Apr 2023 15:12:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A531031C74AA7; Tue, 25 Apr 2023 15:12:54 +0200 (CEST)
Date:   Tue, 25 Apr 2023 15:12:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <20230425131254.GF1335080@hirez.programming.kicks-ass.net>
References: <20230418205159.724789-1-tj@kernel.org>
 <20230418205159.724789-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418205159.724789-5-tj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:51:58AM -1000, Tejun Heo wrote:
> If a per-cpu work item hogs the CPU, it can prevent other work items from
> starting through concurrency management. A per-cpu workqueue which intends
> to host such CPU-hogging work items can choose to not participate in
> concurrency management by setting %WQ_CPU_INTENSIVE; however, this can be
> error-prone and difficult to debug when missed.

Well; you could use this very heuristic, and instead of silently trying
to fix up, complain about the missing CPU_INTENSIVE thing.

> This patch adds an automatic CPU usage based detection. If a
> concurrency-managed work item consumes more CPU time than the threshold (5ms
> by default), it's marked CPU_INTENSIVE automatically on schedule-out.
> 
> The mechanism isn't foolproof in that the 5ms detection delays can add up if
> many CPU-hogging work items are queued at the same time. However, in such
> situations, the bigger problem likely is the CPU being saturated with
> per-cpu work items and the solution would be making them UNBOUND.
> 
> For occasional CPU hogging, the new automatic mechanism should provide
> reasonable protection with minimal increase in code complexity.

But why not keep it a debug mechanism? Now you're got a heuristic with
all the down-sides that they bring.
