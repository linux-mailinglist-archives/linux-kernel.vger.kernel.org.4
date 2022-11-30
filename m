Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6604463E57C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiK3Xbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiK3Xb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:31:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933AD60376
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:25:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F0FEB81D68
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5B4C433D6;
        Wed, 30 Nov 2022 23:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669850700;
        bh=gqcFXZHwwBwyWaUhRXSzf2GnKgPLlzaIwX0k3rlJp4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uB6Gy53iThRwFUtXz0Lrt0gouRzm76Xw6GupSl/Il/ITiYN6eZNV0tlhrGqk76arO
         zKfEYpxEcumW46KA2Rm49M1isUzl2ZNz4Ps1qN1S7oiU598V+ONGImxHZOqdeidcMO
         BCW2U161XPLpGcBhLDO6e1aA+tjfOBIa4NZVS4ZiR1hDsQcahacrbQ4JKQLCqmNi29
         sgIkgb0goTGHi6rvR5gxo3QV+3p3GYpRUTVV+K8Kto07jywH32KmpW7b00f2A1/m/B
         bZHOhKDUZGg6ieVvPQxtVRCtLkWkusFmdolNJKgvZnTHCHuOkr8DnuiQJTS3OdyFeq
         /k2l6pkaSMjvA==
From:   SeongJae Park <sj@kernel.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Should we reuse target when damon's operation changed?
Date:   Wed, 30 Nov 2022 23:24:57 +0000
Message-Id: <20221130232457.56003-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAM7-yPSL2ewn9kjaR01vq8V410G+F1taJzAqVuvNOJOkbX7URw@mail.gmail.com>
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

Hi Levi,

On Wed, 30 Nov 2022 15:01:29 +0900 Yun Levi <ppbuk5246@gmail.com> wrote:

> Hello SJ.
> 
> While I try to use damon, I have some questions whether it is correct
> to reuse damon_target structure when damon's operation is changed.
> 
> At first, one user set up damon like below.
>     echo 1 > /sys/kernel/mm/damon/admin/kdamonds/nr_kdamonds
>     echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/nr_contexts
>     echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/nr_targets
>     echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/pid_target
>     echo 1 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions
>     echo 0 > /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/start
>     echo 16384 >
> /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/targets/regions/nr_regions/0/end
> 
>     echo vaddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
>     echo on >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state
> 
> And some time pass, user change the operation as "paddr" like below:
>     echo paddr >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/operation
>     echo commit >  /sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/state
> 
> In that situation, the damon_target is reused and the region isn't changed,
> former region information which damon_region has -- nr_accesse,
> last_nr_accesss, last_sample addr is kept.
> 
> But, former accessed information is based on vaddr and changed
> accessed information should be based on paddr and it seems the wrong
> information to new applied operation.
> 
> IIUC, it makes some confusion to kdamond when it merges or splits
> regions based on above information.
> 
> So, Is it much better to remove the target and region information when
> the operation is changed? or should we check whether it's possible to
> reuse former access information between former and new operation?

Thank you for the good question and the suggestion.  I agree that it could be
confusing.  Such a scenario could be just a mistake in many cases.  However,
I'm unsure how we could distinguish the mistake from intended usage.  That is,
the intended initial monitoring range for previous 'operation' and later one
could be really same in some cases, as DAMON doesn't ask it to be strict.

After all, DAMON allows users to set the values as much as they want before
committing the input, so this looks mistake of the user, not DAMON.  Of course
DAMON could take care of more things, but in my humble opinion, it's hard to
distinguish the mistake from the intended change in a simple way.  And I'm not
sure if this is a real critical issue that deserves to add some extent of
complexity.  So unless you know critical issue due to this or have a good way
for improving the situation in a simple way, please suggest.  If not, I'd
suggest to keep this in current simple form.

Nevertheless, maybe we could improve this situation by warning this case on the
documentation.  If you'd like to, please feel free to send a patch for that.


Thanks,
SJ

> 
> Thanks.
> 
> -- 
> Best regards,
> Levi
