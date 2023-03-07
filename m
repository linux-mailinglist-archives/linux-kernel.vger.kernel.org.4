Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892116AEDCF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjCGSHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjCGSHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:07:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482A699C25
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF872B819C5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 18:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403C1C433D2;
        Tue,  7 Mar 2023 18:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678212025;
        bh=UuWWRa7phftyu9Sfq9ZLAYegSNScAE2RjSDpFqcaEE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rVF4MQ7556nts+aL/5Xxa+DCyrEuvFbDQHJCKafOaDtXVEuk2ezf3thG6t+5LUmpv
         rXYOHmhYdiRvTq8cNn2E29mpscSFYtvVd3ACXaYlTi6hBhxwI7nIgiDuxAdcUi8KJo
         D0TNvMXywjDHtS6MH9YgeVfmOf3SNwuxzNkul9rPZyJ/WzXuL9Dj9gJhEk6TXRvpI+
         lGaAsWhidNDHWonS3g4fiCIuJjQNVtfSNFhz2sOFLAFkpdjA28cGeysP9dc0HANnc3
         Goj3Mmw0F1SE7mZ5Jcw3huvSiSpfhRG8PwL5wiWQ34bqHRGBvzWh0eTujqoLrxjIHd
         vi+fZUZGAfJiw==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mm/damon/paddr: minor refactor of damon_pa_young()
Date:   Tue,  7 Mar 2023 18:00:23 +0000
Message-Id: <20230307180023.152415-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <174e75a4-f03c-a542-5f6a-651abb5dec58@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 09:22:33 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> 
> 
> On 2023/3/7 5:27, SeongJae Park wrote:
> > Hi Kefeng,
> > 
> > On Mon, 6 Mar 2023 09:56:49 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > 
> >>
> >>
> >> On 2023/3/6 9:10, Kefeng Wang wrote:
> >>>
> >>>
> >>> On 2023/3/4 2:39, SeongJae Park wrote:
> >>>> Hi Kefeng,
> >>>>
> >>>> On Fri, 3 Mar 2023 16:43:42 +0800 Kefeng Wang
> >>>> <wangkefeng.wang@huawei.com> wrote:
> >>>>
> >>>>> Omit three lines by unified folio_put(), and make code more clear.
> >>>>>
> >>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>>> ---
> >>>>>    mm/damon/paddr.c | 11 ++++-------
> >>>>>    1 file changed, 4 insertions(+), 7 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> >>>>> index 3fda00a0f786..2ef9db0189ca 100644
> >>>>> --- a/mm/damon/paddr.c
> >>>>> +++ b/mm/damon/paddr.c
> >>>>> @@ -130,24 +130,21 @@ static bool damon_pa_young(unsigned long paddr,
> >>>>> unsigned long *folio_sz)
> >>>>>                accessed = false;
> >>>>>            else
> >>>>>                accessed = true;
> >>>>> -        folio_put(folio);
> >>>>>            goto out;
> >>>>
> >>>> Because you moved 'out' label to not include *folio_sz setting,
> >>>> folio_sz will
> >>>> not set in this case.  It should be set.
> >>> oh, it should be fixed.
> >>>>
> >>>>>        }
> >>>>>        need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
> >>>>> -    if (need_lock && !folio_trylock(folio)) {
> >>>>> -        folio_put(folio);
> >>>>> -        return false;
> >>>>> -    }
> >>
> >> Hi SJ,  apart from above issue, it looks that this branch need the
> >> folio_size() setting, right?
> > 
> > folio_sz is effectively used by caller of damon_pa_young() only if this
> > function returns true, so this branch doesn't need to set folio_sz.
> 
> __damon_pa_check_access() store last_addr, last_accessed and 
> last_folio_sz, even damon_pa_young() return false, the following check 
> still use last_folio_sz,
> 
>    ALIGN_DOWN(last_addr, last_folio_sz) == ALIGN_DOWN(r->sampling_addr, 
> last_folio_sz)
> 
> but last_folio_sz is not up to date, so I think it need to update, and 
> update last_folio_sz is harmless, which could let's unify the return 
> path, correct me if I am wrong.

Ah, you're right.  Thank you for kind explanation.  I was out of my mind for
some reason.  Maybe we could just do 'goto out' in the branch.


Thanks,
SJ
