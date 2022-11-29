Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3847063BB43
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiK2ILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiK2IK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:10:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DA54751
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:10:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 893951FDDE;
        Tue, 29 Nov 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669709455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpF2YamSI/QIudpCLdal+ckmziNQUnDAtuCenuOdo9E=;
        b=YD9s9c997jmmDDfxsh3bT8iKz1T1lktCDneoYeKA31d6pomrnHKwLbcmWdlsXwNM4bDr90
        1ph1S+71F1eevqdw+JIE0ynaJC0nuC7RRGJs51S0lKdGyfazaWgF/a//RKWGGuP0AGlM/x
        r5cLonfI4ma+50bx4w/oxa9qLyl8JFQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C81013AF6;
        Tue, 29 Nov 2022 08:10:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pGrBF4++hWOWegAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 29 Nov 2022 08:10:55 +0000
Date:   Tue, 29 Nov 2022 09:10:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Yongqiang Liu <liuyongqiang13@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        aarcange@redhat.com, hughd@google.com, mgorman@suse.de,
        cl@gentwo.org, n-horiguchi@ah.jp.nec.com, zokeefe@google.com,
        rientjes@google.com, Matthew Wilcox <willy@infradead.org>,
        peterx@redhat.com,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        kirill.shutemov@linux.intel.com, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
Message-ID: <Y4W+joR1rIug0ydA@dhcp22.suse.cz>
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
 <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28-11-22 12:01:37, Yang Shi wrote:
> On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
> >
> > Hi,
> >
> > We use mm_counter to how much a process physical memory used. Meanwhile,
> > page_counter of a memcg is used to count how much a cgroup physical
> > memory used.
> > If a cgroup only contains a process, they looks almost the same. But with
> > THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
> > more than rss
> > in proc/[pid]/smaps_rollup as follow:
[...]
> > node_page_stat which shows in meminfo was also decreased. the
> > __split_huge_pmd
> > seems free no physical memory unless the total THP was free.I am
> > confused which
> > one is the true physical memory used of a process.
> 
> This should be caused by the deferred split of THP. When MADV_DONTNEED
> is called on the partial of the map, the huge PMD is split, but the
> THP itself will not be split until the memory pressure is hit (global
> or memcg limit). So the unmapped sub pages are actually not freed
> until that point. So the mm counter is decreased due to the zapping
> but the physical pages are not actually freed then uncharged from
> memcg.

Yes, and this is not really bound to THP. Consider a page cache. It can
be accessed via syscalls when it doesn't correspondent to rss at all
while it is still charged to a memcg. Or it can be mapped and then later
unmapped so it disappear from rss while it is still charged until it
gets reclaimed by the memory pressure. Or it can be an in-memory object
that is not bound to any process life time (e.g. tmpfs). Or it can be a
kernel memory charged to a memcg which is not covered by rss because it
is either not mapped or it is unknown to rss counters.
-- 
Michal Hocko
SUSE Labs
