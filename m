Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4793474C936
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 02:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGJAVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 20:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGJAVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 20:21:30 -0400
Received: from out-35.mta0.migadu.com (out-35.mta0.migadu.com [IPv6:2001:41d0:1004:224b::23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA568114
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 17:21:28 -0700 (PDT)
Date:   Mon, 10 Jul 2023 09:21:16 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688948486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9Mc26a/DPJrsB3Au4Lg7Qs2eiX+PC7/Wg8QJdNNfb4=;
        b=NF4a43yR/DlMAmwvsD4TF9y3fLigDbBFsIHMyLJrLsldW94ar6HI8OfvE/2uvwGh/f7bwO
        1zbW46g64E2YDSpD1WodpLImFRkyWmv0UrALaLW//AsKwmn4M2VKFlCn5xmSXkQFDf/yqk
        DKPX7V5FYpyJxsUBcUjYpV0DijSKl+Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jiaqi Yan <jiaqiyan@google.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, naoya.horiguchi@nec.com,
        songmuchun@bytedance.com, shy828301@gmail.com,
        linmiaohe@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v3 2/4] mm/hwpoison: check if a subpage of a hugetlb
 folio is raw HWPOISON
Message-ID: <20230710002116.GA1578139@ik1-406-35019.vs.sakura.ne.jp>
References: <20230707201904.953262-1-jiaqiyan@google.com>
 <20230707201904.953262-3-jiaqiyan@google.com>
 <ZKh2K7ObVtlXHkTk@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKh2K7ObVtlXHkTk@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:31:39PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 08:19:02PM +0000, Jiaqi Yan wrote:
> > Add the functionality, is_raw_hwp_subpage, to tell if a subpage of a
> 
> This is incorrect naming.  "subpage" was needed before we had the
> folio concept, but it should not be used any more.  We have folios
> and pages now.

I think we can address the raw hwpoison page by the offset in folio/hugepage
to eliminate the concept of "subpage".

> 
> Also, abbreviating "hwpoison" as "hwp" seems like a bad idea to me.
> hwp is already used as an acronym by acpi, intel_pstate, some clock
> drivers, an ethernet driver, and a scsi driver.

I originally introduced the abbreviation "hwp" to avoid using a lengthy
function name such as "folio_test_hugetlb_raw_hwpoison_unreliable()."
Therefore, I prefer using "rawhwp" instead of a longer form like
"raw_hwpoison," although I don't expect any confusion between "hwp" and
"rawhwp."
As for "hwp_walk", another user of "hwp" in in mm/memory-failure.c,
we can easily substitute it with "hwpoison_walk."

Thanks,
Naoya Horiguchi
