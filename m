Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F91160D254
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiJYRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJYRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:17:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9101581A5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W7+Qdona4M4hEcWhfDc47CR8ToDDCX79p0mrQJWdXnY=; b=AbayDTc9h9E3IVE2F+YXbDlLvt
        t53alW57Mv8zLXN/8GwE9wjWga6IrlpZSviMSpjyitna/vTNPMKKVJsIpk+PpVKLbVNNbxjQHiuLQ
        EH3+qPGCnlOEFrpuBiIuf7XVIqhQ6ChO9gN2PVl0NKOSucXI5LpE3iMgh8mjypHyuXRnEalmDkZbu
        Nzw4cUDOhuVhwHX8yyeqdEoyrB6kUUZKWr6BqENDE1/BR6aOZrEOe0SUY1lv7eks5wXP02lXodcjs
        ezJMAcz59wbH/WB50xow98TA6t6tiCRdUP4Zu6MPaTNlew+CmEjn2kTixuK7COQ1mlNQHL7sBqnPM
        zJx04RXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onNXp-00GQ7A-6n; Tue, 25 Oct 2022 17:16:53 +0000
Date:   Tue, 25 Oct 2022 18:16:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim
 stats
Message-ID: <Y1gaBXp+IENVIU7z@casper.infradead.org>
References: <20221025170519.314511-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025170519.314511-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:05:19PM -0400, Johannes Weiner wrote:
> +static int reclaimer_offset(void)
> +{
> +	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD != 1);
> +	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD != 2);
> +	BUILD_BUG_ON(PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD != 1);
> +	BUILD_BUG_ON(PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD != 2);
> +	BUILD_BUG_ON(PGSCAN_DIRECT - PGSCAN_KSWAPD != 1);
> +	BUILD_BUG_ON(PGSCAN_KHUGEPAGED - PGSCAN_KSWAPD != 2);
> +
> +	if (current_is_kswapd())
> +		return 0;
> +	if (current_is_khugepaged())
> +		return 2;
> +	return 1;
> +}

Would this be simpler as ...

	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
			PGDEMOTE_DIRECT - PGDEMOTE_KSWAPD);
	BUILD_BUG_ON(PGSTEAL_DIRECT - PGSTEAL_KSWAPD !=
			PGSCAN_DIRECT - PGSCAN_KSWAPD);
	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
			PGDEMOTE_KHUGEPAGED - PGDEMOTE_KSWAPD);
	BUILD_BUG_ON(PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD !=
			PGSCAN_KHUGEPAGED - PGDEMOTE_KSWAPD);

	if (current_is_kswapd())
		return 0;
	if (current_is_khugepaged())
		return PGSTEAL_KHUGEPAGED - PGSTEAL_KSWAPD;
	return PGSTEAL_DIRECT - PGSTEAL_KSWAPD;

Not that I think we'd ever want to separate them, but it is perhaps a
bit less magic?

