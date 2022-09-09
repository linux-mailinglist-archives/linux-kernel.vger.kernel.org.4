Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A95E5B427C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiIIWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIIWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 18:25:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307062715
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 15:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC46BB82628
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 22:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1D4C433C1;
        Fri,  9 Sep 2022 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662762342;
        bh=YR24SjL9hD2IUBf0unQ9ghgo4+TqmWl8eCQbDGfdy0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmPSZZQGmZIHYMh3UVP1BSAttpVww8hBDv0Xxkqy4s6OJEh1v/1ntV14BZ4564ZfK
         k/UICTgq1JCnq4pbhYdhVw38ZKKS26hDk+L5DHJbD9XxsVAivL0553083mhh+ET7E5
         1Quzm78SaQI75gqaez6hBfoAIsMxX5DPo/D2Qf1E=
Date:   Fri, 9 Sep 2022 15:25:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3] mm/huge_memory: prevent THP_ZERO_PAGE_ALLOC
 increased twice
Message-Id: <20220909152541.dff88a98938258f09c46dcd0@linux-foundation.org>
In-Reply-To: <20220909021653.3371879-1-liushixin2@huawei.com>
References: <20220909021653.3371879-1-liushixin2@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 10:16:53 +0800 Liu Shixin <liushixin2@huawei.com> wrote:

> Since user who read THP_ZERO_PAGE_ALLOC may be more concerned about the
> huge zero pages that are really allocated using for thp and can indicated
> the times of calling huge_zero_page_shrinker. It is misleading to increase
> twice if two threads call get_huge_zero_page concurrently. Don't increase
> the value if the huge page is not really used.
> 

I cant say I really understand the point about
huge_zero_page_shrinker(), so I propose this changelog: 

: A user who reads THP_ZERO_PAGE_ALLOC may be more concerned about the huge
: zero pages that are really allocated for thp.  It is misleading to
: increase THP_ZERO_PAGE_ALLOC twice if two threads call get_huge_zero_page
: concurrently.  Don't increase the value if the huge page is not really
: used.

The patch makes sense to me.  What do others think?
