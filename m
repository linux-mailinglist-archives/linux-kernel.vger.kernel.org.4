Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8DD67187A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjARKFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjARKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:03:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A90689E9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:10:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4558D3F4CF;
        Wed, 18 Jan 2023 09:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674033051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lE/uylM1agVn8TJzDINFCtcx7ZSVF4oMaIC06riBkFU=;
        b=PsvvPvI26SXGIQdfpayaw7XFIlKAXaKqXCfu0FT8yzlS1qDb8bf12b4ZWhDteXHoWPwvvw
        Tx5Z5AcennMK6OjUQC7GK4lWKgOi34BOmvkXaXIZ9/KJHbtL7mvZoFUd4acf5B5MqozsFP
        F+BCVDAEA6eSAjgENztvPURhydGeh1M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12310139D2;
        Wed, 18 Jan 2023 09:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J6ZFFZm3x2O9LgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 09:10:49 +0000
Date:   Wed, 18 Jan 2023 10:10:44 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 1/3] mm: return the number of pages successfully paged out
Message-ID: <Y8e3lHsYoWjFWbRU@dhcp22.suse.cz>
References: <20230117231632.2734737-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117231632.2734737-1-minchan@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-01-23 15:16:30, Minchan Kim wrote:
> The reclaim_pages MADV_PAGEOUT uses needs to return the number of
> pages paged-out successfully, not only the number of reclaimed pages
> in the operation because those pages paged-out successfully will be
> reclaimed easily at the memory pressure due to asynchronous writeback
> rotation(i.e., PG_reclaim with folio_rotate_reclaimable).
> 
> This patch renames the reclaim_pages with paging_out(with hope that
> it's clear from operation point of view) and then adds a additional
> stat in reclaim_stat to represent the number of paged-out but kept
> in the memory for rotation on writeback completion.
> 
> With that stat, madvise_pageout can know how many pages were paged-out
> successfully as well as reclaimed. The return value will be used for
> statistics in next patch.

I really fail to see the reson for the rename and paging_out doesn't
even make much sense as a name TBH.
-- 
Michal Hocko
SUSE Labs
