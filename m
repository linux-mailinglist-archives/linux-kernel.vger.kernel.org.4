Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944CA63C9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiK2Uv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiK2UvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:51:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623420BC3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 12:51:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 766D3B81911
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 20:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3DEC433C1;
        Tue, 29 Nov 2022 20:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669755078;
        bh=AkZ30X/OiDPV8bwnUhgyuvrVqcrd6JXlO9QWazKMlZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzxquCNdTpLW4LkZvO0DkvUgUJBX4/LGcrOkfPPiGQZHwTVSvqTqqbbSJ2LSkBcQi
         FgyducA69FMsKqlD5Uqz4vNzW4X/HGG3aZDaiECI828EhCS7pqbsmJZOef/44vp2gP
         P/0DPCVcDQnrudVM0MeGoMqk7bh71G6uo88QP1WI=
Date:   Tue, 29 Nov 2022 12:51:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 00/10] mm/hugetlb: Make huge_pte_offset() thread-safe
 for pmd unshare
Message-Id: <20221129125117.6d31c7cf4c83510be0c8cf10@linux-foundation.org>
In-Reply-To: <20221129193526.3588187-1-peterx@redhat.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Nov 2022 14:35:16 -0500 Peter Xu <peterx@redhat.com> wrote:

> [   17.975943] Oops: 0000 [#1] PREEMPT SMP NOPTI

Do we know which kernel versions are affected here?
