Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458447170BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 00:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjE3WaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 18:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjE3WaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 18:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A786D93
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 15:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24EA9634AA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 22:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F46C433D2;
        Tue, 30 May 2023 22:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685485807;
        bh=L4WaZnpCGMusMfNexWgFq61vWT+q2ikrfQ3r1nuz2S0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IwKTc81HJpslhXJQN5IEtsr3d+TJO57tr578zquodCfzAMkk/I/MoBv3tKbfaP/Gy
         RyO20aVk5oH3P80fJUR9n7XZrnv8lhbsPMnhn4DiffPpoghMmu654t22hbH7BnSSKj
         3q74qIvseKB9kf0ndga4hv//j0yIQBcO0VlEdmJA=
Date:   Tue, 30 May 2023 15:30:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink if cgroup may not zswap
Message-Id: <20230530153006.8b73c276b1aaf5c3275f0b3f@linux-foundation.org>
In-Reply-To: <20230530222440.2777700-1-nphamcs@gmail.com>
References: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
        <20230530222440.2777700-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 15:24:40 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Before storing a page, zswap first checks if the number of stored pages
> exceeds the limit specified by memory.zswap.max, for each cgroup in the
> hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> triggered and short-circuits the store attempt.
> 
> However, since the zswap's LRU is not memcg-aware, this can create the
> following pathological behavior: the cgroup whose zswap limit is
> reached will evict pages from other cgroups continually, without
> lowering its own zswap usage. This means the shrinking will continue
> until the need for swap ceases or the pool becomes empty.
> 
> As a result of this, we observe a disproportionate amount of zswap
> writeback and a perpetually small zswap pool in our experiments, even
> though the pool limit is never hit.

That sounds unpleasant.  Do you think the patch should be backported
into earlier (-stable) kernels?

> This patch fixes the issue by rejecting zswap store attempt without
> shrinking the pool when obj_cgroup_may_zswap() returns false.

