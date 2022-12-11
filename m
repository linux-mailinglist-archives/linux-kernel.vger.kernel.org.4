Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C45649414
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLKMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiLKMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:03:37 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CFB7F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670760216; x=1702296216;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=2lTKIKn3YaEWMXrVPAA/dLAQ0hnSuHhx+rusnpCkBng=;
  b=eEWZ9OkAVpHFDUFMXxxTFa0iWs38Nhg++zEu/0Jxe7n2AH6gN/uBXZKf
   IiTVF0PUVSIBa3RqeU/GzggyzNBsk2dGOlTWQoDr4kouxW8L2cnP389sW
   FufYe1S6rHGePMhmRFHP579RvpO7C3Ks+ms2At7BJvTILTEyQqBuUehGX
   1Tgg81VdVJRfkjBAI1svg9ZgNa60bDHY8Vy4WUl8EhLfPwBN5sLV8Wz/b
   eOQWJt0RpxM0SvCkWmmD6htDgr8jEIQPakrvo5rG5kyuwoz9GoiUI04ig
   ImBXgxXdP7UIdSfC3d73HMjNU6lYwGnUg4lXaWuuc9l5zgTXyRNkCo33b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="298042965"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="298042965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 04:03:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10557"; a="754591659"
X-IronPort-AV: E=Sophos;i="5.96,236,1665471600"; 
   d="scan'208";a="754591659"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2022 04:03:34 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 5/5] swap: avoid ra statistic lost when swapin races
References: <20221208180209.50845-1-ryncsn@gmail.com>
        <20221208180209.50845-6-ryncsn@gmail.com>
        <Y5I3lSfsTmZ6tlJk@casper.infradead.org>
        <CAMgjq7AuY_oi9Rw2r8rnA_tr7NeEXAd0OgZ4sNz4CiVV+2i9Rg@mail.gmail.com>
Date:   Sun, 11 Dec 2022 20:02:45 +0800
In-Reply-To: <CAMgjq7AuY_oi9Rw2r8rnA_tr7NeEXAd0OgZ4sNz4CiVV+2i9Rg@mail.gmail.com>
        (Kairui Song's message of "Fri, 9 Dec 2022 09:54:31 +0800")
Message-ID: <87edt6qhay.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> Matthew Wilcox <willy@infradead.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 03:14=E5=86=99=E9=81=93=EF=BC=9A
>>
>
> Hi, thanks for the review.
>
>> On Fri, Dec 09, 2022 at 02:02:09AM +0800, Kairui Song wrote:
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > __read_swap_cache_async should just call swap_cache_get_folio for tryi=
ng
>> > to look up the swap cache. Because swap_cache_get_folio handles the
>> > readahead statistic, and clears the RA flag, looking up the cache
>> > directly will skip these parts.
>> >
>> > And the comment no longer applies after commit 442701e7058b
>> > ("mm/swap: remove swap_cache_info statistics"), just remove them.
>>
>> But what about the readahead stats?
>>
>
> Shouldn't readahead stats be accounted here? __read_swap_cache_async
> is called by swap read in path, if it hits the swap cache, and the
> page have readahead page flag set, then accounting that readahead
> should be just the right thing todo. And the readahead flag is checked
> with folio_test_clear_readahead, so there should be no issue about
> repeated accounting.
>
> Only the addr info of the swap_readahead_info could be updated for
> multiple times by racing readers, but I think that seems fine, since
> we don't know which swap read comes later in case of race, just let
> the last reader that hits the swap cache update the address info of
> readahead makes sense to me.
>
> Or do you mean I should update the comment about the readahead stat
> instead of just drop the commnet?

__read_swap_cache_async() is called by readahead too
(swap_vma_readahead/__read_swap_cache_async).  I don't think that it's a
good idea to do swap readahead operation in this function.

Best Regards,
Huang, Ying
