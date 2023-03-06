Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAF46AD030
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCFV1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCFV1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:27:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5E438002
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:27:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3639B8111A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE034C433D2;
        Mon,  6 Mar 2023 21:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678138049;
        bh=HAyqRJPBWOYhe525mNCiGvfIZWlnvzCu67PTvEwxrx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z+FgstKIsqpFyF8cCJ1tHZ8P2KfFgHyOC2aeedEKRm8Pl4ga1i/uZYxLXoN6wm9mi
         2K0y04/Gizq8hYjyImUPZd+nby8pCQrrj10Sz/zacUwMteS10Dt6VuZLFDzfM9TPCR
         yon0HovIsuKzq5uFzKjGSMoxJf95SiDv+1J3/qpAiKtT3ipsdATLwDAxFplyu85lpB
         8olBSf4iMCiN3w0bWk7h/D4Go4XJDDPjHSIfEwPS5/0d8xOPOGL6GAnJ1RXPlsq+BJ
         406mwdWhQxm6QuKXKZZTcA5yEzvgwU4++mtMQTvYyG6Q01/SLW0XFnktsTve+aA6+q
         U2J/9K+4WANMQ==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Date:   Mon,  6 Mar 2023 21:27:27 +0000
Message-Id: <20230306212727.303846-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202ac11d-3692-69bf-3984-627c1b9f9d38@huawei.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Mon, 6 Mar 2023 09:56:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2023/3/6 9:10, Kefeng Wang wrote:
> > 
> > 
> > On 2023/3/4 2:39, SeongJae Park wrote:
> >> Hi Kefeng,
> >>
> >> On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang 
> >> <wangkefeng.wang@huawei.com> wrote:
> >>
> >>> Omit three lines by unified folio_put(), and make code more clear.
> >>>
> >>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>> ---
> >>>   mm/damon/paddr.c | 11 ++++-------
> >>>   1 file changed, 4 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >>> index 3fda00a0f786..2ef9db0189ca 100644
> >>> --- a/mm/damon/paddr.c
> >>> +++ b/mm/damon/paddr.c
> >>> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr, 
> >>> unsigned long *folio_sz)
> >>>               accessed = false;
> >>>           else
> >>>               accessed = true;
> >>> -        folio_put(folio);
> >>>           goto out;
> >>
> >> Because you moved 'out' label to not include *folio_sz setting, 
> >> folio_sz will
> >> not set in this case.  It should be set.
> > oh, it should be fixed.
> >>
> >>>       }
> >>>       need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
> >>> -    if (need_lock && !folio_trylock(folio)) {
> >>> -        folio_put(folio);
> >>> -        return false;
> >>> -    }
> 
> Hi SJ,  apart from above issue, it looks that this branch need the 
> folio_size() setting, right?

folio_sz is effectively used by caller of damon_pa_young() only if this
function returns true, so this branch doesn't need to set folio_sz.


Thanks,
SJ

> 
> Thanks
> 
> >>> +    if (need_lock && !folio_trylock(folio))
> >>> +        goto out;
> >>>       rmap_walk(folio, &rwc);
> >>>       if (need_lock)
> >>>           folio_unlock(folio);
> >>> -    folio_put(folio);
> >>> -out:
> >>>       *folio_sz = folio_size(folio);
> >>> +out:
> >>> +    folio_put(folio);
> >>
> >> Before this change, folio_size() is called after folio_put().  
> >> Shouldn't it be
> >> called before folio_put()?  If so, could we make a separate fix for 
> >> that first,
> >> and then make this change on top of it, so that it can be easily 
> >> applied to
> >> relevant stable kernels?
> >>
> > Yes， I could separate it, after folio_put(), the folio could be 
> > re-allocated and the folio_size calculation is not right.
> >>
> >> Thanks,
> >> SJ
> >>
> >>>       return accessed;
> >>>   }
> >>> -- 
> >>> 2.35.3
> >>>
> >>>
> 
