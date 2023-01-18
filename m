Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFDF670EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARAmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjARAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CD43EC5E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:17:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 359B7615A0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 00:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E6C433EF;
        Wed, 18 Jan 2023 00:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674001052;
        bh=my8CeKBKthmM4cETYUZKfKa6sXIAEUx+m6tmPZCKcVc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXUQUlFMjxRqTzNs4mA+0H7hXDp//QeCH9R8gp+K4az25ku3HflR+/c+qwvs58rLP
         Hy1mStzFmMCGa2qa0fPA+6nTWZOhIMoZM9GJNJOG/w0vmdU/k/3kpVkNEetGRdT+YC
         YWmWKQntgO8ZTO89aw0plKc0bHkcMFXRRbyU7yu4=
Date:   Tue, 17 Jan 2023 16:17:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
Message-Id: <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
In-Reply-To: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> done by moving kmemleak stuff to mm/Kconfig.debug.

I don't understand - what was the reason for the Kconfig change?
