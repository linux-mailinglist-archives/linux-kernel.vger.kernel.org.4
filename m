Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E186982DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBOSDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 13:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBOSDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 13:03:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EEA34F70
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 10:03:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2523DB8227A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 18:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A85AC433EF;
        Wed, 15 Feb 2023 18:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676484198;
        bh=U0LgVqQCYtX33qCxw4lWn6glWxSkvnLkN2wB2NOA4GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8P+gEsrGigSC22hdhSFnkZSWjdZBt1gTksC1sU6uwkC2r5cEyvcZHy5gssr7/JGF
         0zlcNopIONb+R8RdW3/j22DcAswYke5i7l4L8aWhlVF61J9hZdIDdfJlu8/6LVIMAW
         akmtaoyT625q8e+zD0hRVdplWJk63pwb+KPChv90WrpG6YnDaDLRqYyd2u/oANAEqL
         bZwgRjWr5ItMyjnb2wuLyUHptD+v/z4YVxABvOb/RsNMOk8EeWX9BtoIA2fBk9lo+x
         jtvwfSQPyu/IO/Q9uqNayocoJRGPM4qglv4YvMdKiamKK1PUyZy74bAA2/B9A2eoXR
         3c2iWylgFj+ng==
From:   SeongJae Park <sj@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: return zero from do_migrate_range() for only success
Date:   Wed, 15 Feb 2023 18:03:16 +0000
Message-Id: <20230215180316.75431-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <388b9a93-423f-33f8-0495-2a4a290fd1aa@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 14:16:05 +0100 David Hildenbrand <david@redhat.com> wrote:

> On 14.02.23 23:32, SeongJae Park wrote:
> > do_migrate_range() returns migrate_pages() return value, which zero
> > means perfect success, in usual cases.  If all pages are failed to be
> > isolated, however, it returns isolate_{lru,movalbe}_page() return
> > values, or zero if all pfn were invalid, were hugetlb or hwpoisoned.  So
> > do_migrate_range() returning zero means either perfect success, or
> > special cases of isolation total failure.
> > 
> > Actually, the return value is not checked by any caller, so it might be
> > better to simply make it a void function.  However, there is a TODO for
> > checking the return value.
> 
> I'd prefer to not add more dead code ;) Let's not return an error instead.

Makes sense, I will send next spin soon.

> 
> It's still unclear which kind of fatal migration issues we actually care 
> about and how to really detect them.

What do you think about treating the isolation/migration rate limit
(migrate_rs) hit in do_migrate_range() as fatal?  It warns for the event
already, so definitely a bad sign.

If that's not that bad enough to be treated as fatal, I think we could have yet
another rate limit to be considered fatal.


Thanks,
SJ

> 
> -- 
> Thanks,
> 
> David / dhildenb
