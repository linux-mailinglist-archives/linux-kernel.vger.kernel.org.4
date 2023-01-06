Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D79266070B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjAFTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjAFTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:21:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C843D5F2;
        Fri,  6 Jan 2023 11:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dsRHMp9OopMZ+5Sq2nVA/uTwPQ8x6Lz0DDDDmnk8Iwg=; b=J/+vDt8x6eZrANv21ctTOHWcfV
        +gj5WdtL1fDmWIXastniD3CxjCL0Ru3TzClJ5iLARTdm77qNeKVQjkoLj9j70Oxy+onoyxIC0mu1h
        +iDhKvbEMmVh4lAfU8B5LDbshRvTo6Y5Ui+3aJFMQuO/GfPU+lvqIW5AimVwRMJ/kDt9tFOHXrHPC
        vRuPxnJeTSLxMfjObxQlCVgJf0H5BxJWwPNQl271CWuMFldmB21m2j5TyEPxh90zstQP0v+H5hbs9
        V64WIvCs7yGIqayunr7g+QpvzJUfM5WUuvp0OGUDN6H9U7N8TO7wgxXSS7Pyde0ZAzzKAaxVeEzkI
        nbxDQcww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDsHc-00HR2F-Dc; Fri, 06 Jan 2023 19:21:40 +0000
Date:   Fri, 6 Jan 2023 19:21:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-mm@kvack.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] add folio_headpage() macro
Message-ID: <Y7h0xNGlj0qzFlua@casper.infradead.org>
References: <20230106174028.151384-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106174028.151384-1-sj@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:40:25PM +0000, SeongJae Park wrote:
> The standard idiom for getting head page of a given folio is
> '&folio->page'.  It is efficient and safe even if the folio is NULL,
> because the offset of page field in folio is zero.  However, it makes
> the code not that easy to understand at the first glance, especially the
> NULL safety.  Also, sometimes people forget the idiom and use
> 'folio_page(folio, 0)' instead.  To make it easier to read and remember,
> add a new macro function called 'folio_headpage()' with the NULL case
> explanation.  Then, replace the 'folio_page(folio, 0)' calls with
> 'folio_headpage(folio)'.

No.  Everywhere that uses &folio->page is a place that needs to be fixed.
It shouldn't have a nice convenience macro.  It should make you mildly
uncomfortable.
