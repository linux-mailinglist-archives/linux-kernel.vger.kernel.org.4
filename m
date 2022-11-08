Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812F62047B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiKHALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbiKHALE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8B11F616
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:11:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6F66131A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAECC433C1;
        Tue,  8 Nov 2022 00:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667866261;
        bh=vHxhyutP9cB7DvECPymVNKDyiMvhF4zNuceuNtDxwVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZRY4ge/npV98d4/kIKfngLY8FdtlsE7dEX5IqV44G+gV2NeHk8t2bT2HH+ofN6uO
         5f+m/AQbIbX6UasdlDuqZkznV4Vn2eay6p+KPxpnSRDdYgJQOqJDLXrN4VnxmgJRae
         VVFUyjRCM94IgGLj3PXl6k24I+F1vWK9jKp9tLDI=
Date:   Mon, 7 Nov 2022 16:10:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=) 
        <naoya.horiguchi@nec.com>
Cc:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arch/x86/mm/hugetlbpage.c: pud_huge() returns 0 when
 using 2-level paging
Message-Id: <20221107161059.11414d456e24b77553d5a2df@linux-foundation.org>
In-Reply-To: <20221108000014.GB471526@hori.linux.bs1.fc.nec.co.jp>
References: <20221107021010.2449306-1-naoya.horiguchi@linux.dev>
        <Y2j9KqIY9sAIDize@intel.com>
        <20221108000014.GB471526@hori.linux.bs1.fc.nec.co.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 00:00:15 +0000 HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> > > Recently pud_huge() got aware of non-present entry by commit 3a194f3f8ad0
> > > ("mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present
> > > pud entry") to handle some special states of gigantic page.  However, it's
> > > overlooked that pud_none() always returns false when running with 2-level
> > > paging, and as a result pmd_huge() can return true pointlessly.
> 
> Sorry, I found a non-negligible typo here (s/pmd_huge/pud_huge/).
> Andrew, could you fix this on mm-hotfixes-unstable?

Done, thanks.
