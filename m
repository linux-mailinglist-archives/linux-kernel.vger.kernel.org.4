Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726926987EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBOWeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBOWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:33:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4D3252B2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 132B361DD6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 22:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE16DC433D2;
        Wed, 15 Feb 2023 22:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676500437;
        bh=683KEjyjJdGprwp6x/MvliefPwqxgwCTxqoPXal2rZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUFbtrutIJyOZc8/SOR3PMPupt1r82zh365IH9L0Hra0teTwojAhfwbi1XdGGMZnK
         PKlBHfNp0vj4A89piR2y3tvMmKgPUIx3bRkkYozH4ImTwZvYgN2NoXkWPexnMPQZem
         38Qa3WXmxK+ePiRJiB7wygl8gVx9pblzTS7wqAdAsBpLzWXIgPOVq7l/BgsZBa4qlp
         NhiUryFRPumaiin43OlJvMh2Aa9dE8MO8q4PCGFjVs/4HZMYHTaZCwy2jbvuzTDUN0
         MXW/ptsFujDa5x1AJRA2ea/XABSvchJRug0iEZBAl6ueR2uboM8gCB7ktgjp0E8uUB
         A2yBwaWMeWJcg==
From:   SeongJae Park <sj@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: return zero from do_migrate_range() for only success
Date:   Wed, 15 Feb 2023 22:33:55 +0000
Message-Id: <20230215223355.102508-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1ddc2eff-f1bd-be62-3c62-abe6d539feef@redhat.com>
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

On Wed, 15 Feb 2023 21:00:50 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 15.02.23 19:03, SeongJae Park wrote:
> > On Wed, 15 Feb 2023 14:16:05 +0100 David Hildenbrand <david@redhat.com> wrote:
> > 
> >> On 14.02.23 23:32, SeongJae Park wrote:
> >>> do_migrate_range() returns migrate_pages() return value, which zero
> >>> means perfect success, in usual cases.  If all pages are failed to be
> >>> isolated, however, it returns isolate_{lru,movalbe}_page() return
> >>> values, or zero if all pfn were invalid, were hugetlb or hwpoisoned.  So
> >>> do_migrate_range() returning zero means either perfect success, or
> >>> special cases of isolation total failure.
> >>>
> >>> Actually, the return value is not checked by any caller, so it might be
> >>> better to simply make it a void function.  However, there is a TODO for
> >>> checking the return value.
> >>
> >> I'd prefer to not add more dead code ;) Let's not return an error instead.
> > 
> > Makes sense, I will send next spin soon.
> > 
> >>
> >> It's still unclear which kind of fatal migration issues we actually care
> >> about and how to really detect them.
> > 
> > What do you think about treating the isolation/migration rate limit
> > (migrate_rs) hit in do_migrate_range() as fatal?  It warns for the event
> > already, so definitely a bad sign.
> > 
> > If that's not that bad enough to be treated as fatal, I think we could have yet
> > another rate limit to be considered fatal.
> 
> IIRC, there are some setups where offlining might take several minutes 
> (e.g., heavy O_DIRECT load) and that's to be expected.
> 
> So the existing code warns for better debugging, but keeps trying. So 
> the ratelimit is rather to not produce too much debug output, not to 
> really indicate that something is fatal.

Thank you for clarification, David!


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
