Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D26423A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiLEHdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiLEHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:33:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB9E12620
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:33:12 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D04451FE38;
        Mon,  5 Dec 2022 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670225590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NePOxt+MDk0hEjxXAZdBpH+ZB5USLXCDgbBxeYkWlMQ=;
        b=d8exc43Rdw6AmvWnBLKZYaVMFfDlgM5VvL+qxoMjtFkJSLbjIwHRAODIz6FUz7zuky9Q3O
        ZSYKPN1J2l5Kh87wNhXwq/EXfdCDeJkmnkdCSn/jFJUIxsewvLxRmk98AYgGIrcUnKDzgh
        ba7N4hzvKSUmyqSUBlwJyDflQGzDY28=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B01211348F;
        Mon,  5 Dec 2022 07:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 1Z78J7aejWNCJQAAGKfGzw
        (envelope-from <mhocko@suse.com>); Mon, 05 Dec 2022 07:33:10 +0000
Date:   Mon, 5 Dec 2022 08:33:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Shakeel Butt <shakeelb@google.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Eric Dumazet <edumazet@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftests: cgroup: update kmem test precision tolerance
Message-ID: <Y42etVeTHxUvkLgn@dhcp22.suse.cz>
References: <202212010958.c1053bd3-yujie.liu@intel.com>
 <Y4m8Unt6FhWKC6IH@dhcp22.suse.cz>
 <Y4oy4foegCdOKVKj@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4oy4foegCdOKVKj@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 02-12-22 09:16:17, Roman Gushchin wrote:
> On Fri, Dec 02, 2022 at 09:50:26AM +0100, Michal Hocko wrote:
> > OK, so this is a full patch to fix this
> > --- 
> > From 7f338ed952ba4a100822004bc8399bf720b42899 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Fri, 2 Dec 2022 09:45:29 +0100
> > Subject: [PATCH] kselftests: cgroup: update kmem test precision tolerance
> > 
> > 1813e51eece0 ("memcg: increase MEMCG_CHARGE_BATCH to 64") has changed
> > the batch size while this test case has been left behind. This has led
> > to a test failure reported by test bot:
> > not ok 2 selftests: cgroup: test_kmem # exit=1
> > 
> > Update the tolerance for the pcp charges to reflect the
> > MEMCG_CHARGE_BATCH change to fix this.
> > 
> > Reported-by: kernel test robot <yujie.liu@intel.com>
> > Link: https://lore.kernel.org/oe-lkp/202212010958.c1053bd3-yujie.liu@intel.com
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  tools/testing/selftests/cgroup/test_kmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index 22b31ebb3513..1d073e28254b 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -24,7 +24,7 @@
> >   * the maximum discrepancy between charge and vmstat entries is number
> >   * of cpus multiplied by 32 pages.
> >   */
> > -#define MAX_VMSTAT_ERROR (4096 * 32 * get_nprocs())
> > +#define MAX_VMSTAT_ERROR (4096 * 64 * get_nprocs())
> 
> Hi Michal!
> 
> You need to update comments above too (it says 32 pages in a couple of places).
> I actually sent the similar patch to Andrew yesterday, but hit reply and missed
> adding people to cc.
> 
> Please, feel free to send your v2 with comments fixed and my acked-by,
> or we can go with my version.

It seems Andrew has already done all the fixups. Thanks both to you and
Andrew!
-- 
Michal Hocko
SUSE Labs
