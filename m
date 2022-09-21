Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E545BF959
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiIUIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiIUIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:34:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD7712AE7;
        Wed, 21 Sep 2022 01:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fdbjL5VhQ34WmhthZwfzbvkNiKnHHQVvVpAEIOCaE0c=; b=Bz5Bc3iZpOcDIEriFASnnm/18e
        Uez4uEacjiUb0oCtG8nyBbZc/dPOgv1xkWuPCUdpY9Gk5OmVFJK7T3WYJK+gBzHGkulu7u8k5QTa+
        5X2m64ee2IAzxkVmVi+tQKBestAQDCPmyW4zBVELdOpnPtUPEEGSVzHEIGRJv6VaZG6K35xKMOh1V
        9QPTpRw3pyMLK3N/DYR5RTs+3fHUAQP4HqesLS7btQN8eLH6z8ZkJRLEKxNyRYE8jmGpEtCD2AU0A
        PEL/2Otkxyih/8WtjIBM2UPF1ZFk5kvI7k9yGjvMuvIHwKWKyWS5ZHRw5SI+a58QYCx2y+PVdm8/w
        qD/YCYwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oavBm-0069lq-2i; Wed, 21 Sep 2022 08:34:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B214300074;
        Wed, 21 Sep 2022 10:34:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A2222BB0BFFC; Wed, 21 Sep 2022 10:34:35 +0200 (CEST)
Date:   Wed, 21 Sep 2022 10:34:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Message-ID: <YyrMmyUPk+4t6OLm@hirez.programming.kicks-ass.net>
References: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:08:55AM -0000, tip-bot2 for Jules Irenge wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
> Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
> Author:        Jules Irenge <jbi.octave@gmail.com>
> AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00
> 
> perf/core: Convert snprintf() to scnprintf()
> 
> Coccinelle reports a warning:
> 
>     WARNING: use scnprintf or sprintf
> 
> Adding to that, there has also been some slow migration from snprintf to scnprintf.
> 
> This LWN article explains the rationale for this change:
> 
>     https: //lwn.net/Articles/69419/
> 
> No change in behavior.
> 
> [ mingo: Improved the changelog. ]

And yet, at this point I still have no clue what's wrong with
snprintf(). So not much improvement :/

As such I'm still very much against this patch.
