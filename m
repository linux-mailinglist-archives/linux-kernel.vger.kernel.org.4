Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5362E6447E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiLFPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiLFPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:22:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149F9FF8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fTpI119qpAktFn4Vs6O2yNBbMwFml4YlPvJPmAmi3aQ=; b=AYjmlDG8052I3kahPR+g0qZmH2
        +coxrBOeRY39OnxIO04C4VQrhUTCUOcoP5az3beBkRgr0QbUq6JvhuC3pr2MVq6xmpFPQbG9v/pd5
        kSWuL8I01GNZ6W/SV4YKZUJCji1Cm3/ansK5NUk3o1CypnSTjl7re57SGJFaoA3VhuVJOUEE2kG/x
        OT4LbZAHluuSuXdMVrQeBrj2ZGPLyNploV30fzfK0x9jjWcK4eskqurrCYn98Qp3NMZCZ9gUyNEro
        Gs/ksxo6SVig7m8m6gftWQ+DOSVfp/G2uK5GaJBxLTXkDaHnbeIN/sjGAxODiRdUGEOykBim1EzOQ
        PVS+LRTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2ZmZ-004YCv-Ak; Tue, 06 Dec 2022 15:22:55 +0000
Date:   Tue, 6 Dec 2022 15:22:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y49eT0JmOt97Caca@casper.infradead.org>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
 <20221205175140.1543229-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205175140.1543229-3-nphamcs@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:51:38AM -0800, Nhat Pham wrote:
> +static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
> +	struct pglist_data **pgdat, unsigned long *token, bool *workingset)

This line needs more than one tab indent.  I tend to use two tabs,
others try to line up the parameters with the opening '('.  But
one tab is too visually similar to the body of the function.

>  	rcu_read_lock();
> 
>  	memcg = folio_memcg_rcu(folio);
> +
> +	if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
> +		&workingset))

Similarly here.  &workingset looks like it's part of the body of the if,
not part of the function call.

> +		goto unlock;
> +
>  	if (memcg_id != mem_cgroup_id(memcg))
>  		goto unlock;
> 
