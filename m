Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E116DF66A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDLNEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjDLNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:04:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F640F2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2u4C6fn8rcBG4p3IFP1tSLcJySxwgo6iZPmr/m9xEiI=; b=H4xjivd+25lajydBPWRap7/1zZ
        aWg+3k1OaiDh87KsoSgA13s5fv6UMEsDgKGzWIj4D22ZYXeT9xIOzjjsQiBPh3jXhTgenMvx1HCwO
        DADm48N/N6gPoQG7FXWDtJ5AybjAgJkQ5Dq/E0eHqnL5i4N7xwMNXEpWqXv68C6QM4szljLD5LW3/
        VjzJqOpXGXgSVafz9ythipDVQdJDkRkSre5JBdWC2CYafk3pbSsqF9Dbysz9SjXuFP3AWUzMgdKNo
        Npv2J94oLBpboWl+UZMXzryV6EmpaxGdbj77ypZR9T6/OCfg+A+oXZNMh6Unyd5DoRxBIiV+XKJcq
        h3FZe16g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pma9J-006ssP-D2; Wed, 12 Apr 2023 13:04:33 +0000
Date:   Wed, 12 Apr 2023 14:04:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: convert __page_{set, check}_anon_rmap() to
 folios
Message-ID: <ZDasYRqHLayZXc6E@casper.infradead.org>
References: <20230412021811.1503281-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412021811.1503281-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:18:11AM +0800, Yajun Deng wrote:
> The 2nd parameter in __page_set_anon_rmap() is only used by
> SetPageAnonExclusive(), so there is no need to put
> SetPageAnonExclusive() in  __page_set_anon_rmap().
> 
> Remove SetPageAnonExclusive() from __page_set_anon_rmap() and modify
> __page_set_anon_rmap() to __folio_set_anon_rmap().
> 
> Since __page_check_anon_rmap() needs a folio, we can directly use
> and change it to __folio_check_anon_rmap().

I do not think this is an improvement.
