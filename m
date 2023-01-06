Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9984065F7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 01:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjAFACf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 19:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbjAFACa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 19:02:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2C3C0CB;
        Thu,  5 Jan 2023 16:02:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF5A6192F;
        Fri,  6 Jan 2023 00:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0307BC433EF;
        Fri,  6 Jan 2023 00:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672963348;
        bh=1KDmSWt4RhMhsaM1ixd2OuCs+ZKDeSjvTmD2Jst6BVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrdOR0JKHNNSm4I+mY7ODOwCttwAmhNuxViGChPKvwved9FGgOdIbPojo88iBEwOr
         qDxVTEoy59Ut2y4dnkBRlsc6GlSqLUsq0x5AAzSZwgiCwiUUSi4yZibuNIwQIl2ug3
         GgFU4ApcjQyL0yiGeSs7hURUVb23Z+uvikllWrNLtQo0eGpKKiDlEFfan2+xMyhoL/
         iizpiq+OpdkP6enAALvEwKkdsLsSldBTIVUms4Qif1Upcyp/YAnN+5GHATqY9K4QvP
         g9lqqH47Lo0Hd+cETK0lXuzi4KaJmsN/Nc7PcXfXE+BpOKUQHm1JdLgsBtB6FlU6G6
         DNkmkF03LcLPg==
Date:   Thu, 5 Jan 2023 18:02:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memremap: Replace 0-length array with flexible array
Message-ID: <Y7dlGEm3lWBjpFkG@work>
References: <20230105220151.never.343-kees@kernel.org>
 <Y7dLrdOETjg/+XKq@work>
 <202301051441.C1D7291921@keescook>
 <ec387c6d-acc7-6696-ba17-bb8792090136@embeddedor.com>
 <202301051536.1D1F92678@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301051536.1D1F92678@keescook>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 03:37:03PM -0800, Kees Cook wrote:
> On Thu, Jan 05, 2023 at 05:14:23PM -0600, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 1/5/23 16:41, Kees Cook wrote:
> > > On Thu, Jan 05, 2023 at 04:14:05PM -0600, Gustavo A. R. Silva wrote:
> > > > I think this is the same patch:
> > > > 
> > > > https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/
> > > > 
> > > > It's actually in linux-next.
> > > 
> > > Hm, it's been in -next since September? Is this in a tree of yours that
> > > didn't get pulled for v6.2?
> > 
> > No. I didn't send it. It's just one of the two patches I have in my -next
> > tree. They didn't look like high priority at the time.
> 
> Cool. I'd like to get -fstrict-flex-arrays=3 finished this devel cycle,
> if possible. Can you add this one too?
> 
> https://lore.kernel.org/lkml/YzIc8z+QaHvqPjLX@work

Done!

https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp

> 
> I don't see it in patchwork which I find confusing too. :P

mmh... and I don't remember updating it in patchwork before.
(thinkingface)

--
Gustavo
