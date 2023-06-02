Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F09720A2B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjFBUR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 16:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjFBURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 16:17:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854A1B9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cxXn9ZZJzYkbTqmmYgtF4h7OB5c0AJRp8F6tkM43sjc=; b=dL5QQUe2XQNKLxxUUDTl0sNhEA
        wHunLHSieCm9/pVxSaN219DOvGZFq3o9c2CLEt8W7NmvGee/Pq+wJZWffw5KuTsuFXQHkvTbuE3ZE
        6HFi7h1HUkz9aozrR6NBCAD38yWxbTUy04kLARmUqw7F0kEsTQwqYKoF3xUoAr2Hq2HjBHT2QzkI8
        SFnpEoON6pl4GZZmyt5sGWisf0PU4h3YY7zCzn5YHUo4ITwWR1CTFofQ++2A2X4VVG34LNtnvVXid
        HCR9X1J6fayQYKTYUiId37t6QjucoXjljJfnPEgmtRJ6C3JcjepeTklhL+0I4RIIWpU05QVdI5WuS
        wbz3xhHg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q5BCu-009VDm-D1; Fri, 02 Jun 2023 20:17:08 +0000
Date:   Fri, 2 Jun 2023 21:17:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, sidhartha.kumar@oracle.com,
        vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH 2/2] mm/hugetlb: Use a folio in hugetlb_wp()
Message-ID: <ZHpORDg3JltVUwNb@casper.infradead.org>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
 <20230602015408.376149-3-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602015408.376149-3-zhangpeng362@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 09:54:08AM +0800, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace nine implict calls to compound_head() with one by using
> old_folio. However, we still need to keep old_page because we need to
> know which page in the folio we are copying.

Do we?  It's my understanding (and I am far from an expert here ...)
that the 'pte_t *' we are passed *inside hugetlbfs* is not in fact a pte
pointer at all but actually a pmd or pud pointer.  See how we do this:

        pte_t pte = huge_ptep_get(ptep);

and so the page we get back is always a head page, and we can go
directly to a folio.  ie this is different from the THP cases.

