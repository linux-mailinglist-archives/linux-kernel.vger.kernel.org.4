Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6DD688042
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjBBOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 09:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjBBOjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 09:39:32 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D1427989
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1675348738; bh=ASvwjKGBpJqFDEkuz5eKD6fPqaYvosVx0V5wDvgtKQs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oVO4/TdC20DHRHaBJ/0W8lw7+MzLq7PPUl8BmjXmK3R43aAWZ331XPQS+uVokW6hp
         7opMs+MKj1jL+TkYQnzT4y2258cZzYyVf5SqSfaoIU8yYyPmY+5CuoRZbwklx6gPRU
         pxD5BfI9LzRoKPexCOXrfbDfsLuGhNN7ubFTVwUbhHU0uqoX8r5NIQ7sEXP48mg3sU
         sZ5w9y0eZ7P5qAoHRuPUpd4peznalzE++nAWlgcdjmZ9vDg6cJpfq/FTWy1oc1sND7
         6UdU3mklfUb7GKFn+ypqEtVGLT7i6Ls9qQt9mnCGbTSX0GWwhhsrKzVOydtHGcZGLU
         AQe30QTpW3icA==
Received: by gentwo.de (Postfix, from userid 1001)
        id A81ABB00711; Thu,  2 Feb 2023 15:38:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id A5820B0067C;
        Thu,  2 Feb 2023 15:38:58 +0100 (CET)
Date:   Thu, 2 Feb 2023 15:38:58 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/5] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
In-Reply-To: <20230201195104.460373427@redhat.com>
Message-ID: <fb371ac-cf69-28a6-eca0-6caccda4e0b8@gentwo.de>
References: <20230201195013.881721887@redhat.com> <20230201195104.460373427@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023, Marcelo Tosatti wrote:

> In preparation to switch vmstat shepherd to flush
> per-CPU counters remotely, use a cmpxchg loop
> instead of a pair of read/write instructions.

You are mixing full atomic cmpxchg and  per cpu atomic cmpxchg? That does
not work.

I thought you would only run this while the kernel is not active on the
remote cpu? Then you dont need any cmpxchg and you can leave the function
as is.
