Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B8C6C72A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCWV43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCWV42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:56:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D610B18AB1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lzMmO+zKVqXdO9G90HpKaUlhfTP3JctDS1llQxXFGkM=; b=eyeipyv9EzUE9dkAMLWUbyZGp/
        LIdD7u3lxBEPmLJdF5aWC6Oj9AFsP34PZO/6TsjzZDSMqBekuWWyvMUwFv3DDs9tfo1xiQTwj8k5I
        DLuh/QYQlEk4T4Yc9or5y2W8ahMXRC6384O0NPuQvowq7Yfk1ayeXtknEY+C/cVuULDcMzP1v7RBj
        jnF/IKKw769VQMHhACTmnJKlQmku0OxSfB6PT7g+qHSVkc8vl1kkqadr2O5dkWsuOTuYEeQ/N2zDf
        IthNSMypfdReCLWkcx8eDJoNijLd/H9pOlGwUSD1LcXC8oUmwSiwdaYe5/Oi1XgqOOzVFo69L5NOQ
        LBjL1UVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfSul-004IQM-Oi; Thu, 23 Mar 2023 21:56:07 +0000
Date:   Thu, 23 Mar 2023 21:56:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
Message-ID: <ZBzK99dSmbPB7vjA@casper.infradead.org>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:07:46PM -0700, Hugh Dickins wrote:
> On an earlier audit, for different reasons, I did also run across
> lib/buildid.c build_id_parse() using find_get_page() without checking
> PageUptodate() - looks as if it might do the wrong thing if it races
> with khugepaged collapsing text to huge, and should probably have a
> similar fix.

That shouldn't be using find_get_page().  It should probably use
read_cache_folio() which will actually read in the data if it's not
present in the page cache, and return an ERR_PTR if the data couldn't
be read.
