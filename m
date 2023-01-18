Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7893F67100D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjARBb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjARBbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:31:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9551545BD1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FBC615BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E07FC433D2;
        Wed, 18 Jan 2023 01:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674005506;
        bh=ORSqiiZq8cG14KquIYYw1lnGL7sTZSd7hbj0pDKiBNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=txc0NC6aTXOuztOTLSjUuDpGgNWO5TrFsT3doh7lNjlZ3wODbE8XhyxM1Boc2Md+X
         IZ5qzsLLf5pGlxLnpuYR6+C59i6jp/T8uAKEQIG2q9bk/dOeoqOQ0jtkCtS21NN+31
         VPoTYW6OI2Drn4LkM4wFl2WaD1tggrSEBsKn3Pgs=
Date:   Tue, 17 Jan 2023 17:31:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCHv2] mm: use stack_depot_early_init for kmemleak
Message-Id: <20230117173145.867a06c1585728da1e9b6a54@linux-foundation.org>
In-Reply-To: <CAGWkznHKJF1hiVTS2gAxgywnGz4T9u8UQtDV_Oj7r3cWqM5=nA@mail.gmail.com>
References: <1673943112-8620-1-git-send-email-zhaoyang.huang@unisoc.com>
        <20230117161731.ab69c2352a62a0693570cf70@linux-foundation.org>
        <CAGWkznHKJF1hiVTS2gAxgywnGz4T9u8UQtDV_Oj7r3cWqM5=nA@mail.gmail.com>
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

On Wed, 18 Jan 2023 09:25:48 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:

> On Wed, Jan 18, 2023 at 8:17 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue, 17 Jan 2023 16:11:52 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:
> >
> > > Mirsad report bellow error which caused by stack_depot_init failed in kvcalloc.
> > > Solve this by having stackdepot use stack_depot_early_init. Extra Kconfig also
> > > done by moving kmemleak stuff to mm/Kconfig.debug.
> >
> > I don't understand - what was the reason for the Kconfig change?
> The items related to kmemleak are moved from lib/Kconfig.debug to
> mm/Kconfig.debug

Well yes, but why?

Is that related to this bug fix?  If not then please let's have that
change in a separate patch.

