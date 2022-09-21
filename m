Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFC5BF519
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIUDyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiIUDyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:54:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5151CFDC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 20:54:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E60A021B4B;
        Wed, 21 Sep 2022 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663732457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nIbc/7y4eQaQeiEASLP8Mx3nQNV8bI27qmhnLRpUYVw=;
        b=gIN/sXkZBGKBnUmz5gPol/PonAMZXIi67UGjRYobz+DTg79GTHYSAJHbJ/9GKaO2iPYHwp
        hzoq1u+X7EPc0zOQ5lrfYAZG9yHE69RRvXqT5HlHJiaDotFOR6YNzcNutR8O0aMB7zHDvC
        wxKVe/6yyMEOgxuREw1lm/5qE+PvyaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663732457;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nIbc/7y4eQaQeiEASLP8Mx3nQNV8bI27qmhnLRpUYVw=;
        b=JtK9ronxdDqst8rlqP4WmaHadwdA9EVUyUj8Iuhs8RVwrOW2TInv531qOCeD9y4HlLCdqM
        UQT/TCIjJdcrE1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 538B91332F;
        Wed, 21 Sep 2022 03:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dfKtEemKKmMDPQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 21 Sep 2022 03:54:17 +0000
Date:   Wed, 21 Sep 2022 05:54:15 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] hugetlb: freeze allocated pages before creating
 hugetlb pages
Message-ID: <YyqK51L65yS4OKye@localhost.localdomain>
References: <20220916214638.155744-1-mike.kravetz@oracle.com>
 <Yyk7cN8KhUlNFmM8@localhost.localdomain>
 <Yyn0BZu1gNHG7pZ7@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyn0BZu1gNHG7pZ7@monkey>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 10:10:29AM -0700, Mike Kravetz wrote:
> Hi Oscar, thanks for taking a look.
> 
> I think you may have missed something in the above comment.  For gigantic
> pages, we only freeze pages if NOT demote.  In the demote case, pages are
> already frozen.

Yeah.
It got me confused that the link you posted
(https://lore.kernel.org/linux-mm/20210622021423.154662-3-mike.kravetz@oracle.com/)
seemed like an earlier version of what it got into upstream,
and in there there was "demotion" handling.

Having checked the tree it all looks sound.

I will wait for v3.

Thanks Mike!


-- 
Oscar Salvador
SUSE Labs
