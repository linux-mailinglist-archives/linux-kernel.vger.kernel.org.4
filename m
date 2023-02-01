Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF3C680E62
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbjA3NCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjA3NCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:02:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA179C663
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 05:02:44 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F4C121BB2;
        Mon, 30 Jan 2023 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675083763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ARwEGyGpwYF9H5slVIYtCFzph0d26JmSdEf25hcilbY=;
        b=pyJcnYwBl3DH/jl+/129tNUOIFyqyViNLmoDtFmngEAY4W5QwguCfIassNpLWPbUwRip5Q
        Z+RahvE57ghKk8jep3/EAoHBgMp7qdYPURDYQRlHKF4OEFFpfS8h7xHSkIfBx29ubvbPnC
        EUuasEmCb8a1ZTWBgJ4rSbPj1ooYlNQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3007913A06;
        Mon, 30 Jan 2023 13:02:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GpzmCvO/12NKUQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 30 Jan 2023 13:02:43 +0000
Date:   Mon, 30 Jan 2023 14:02:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ma Wupeng <mawupeng1@huawei.com>, shy828301@gmail.com
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in
 mem_cgroup_track_foreign_dirty()
Message-ID: <Y9e/8jtcDzSp9Ix2@dhcp22.suse.cz>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
 <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
 <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com>
 <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
 <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-01-23 20:20:16, Kefeng Wang wrote:
> 
> 
> On 2023/1/30 16:48, Michal Hocko wrote:
> > On Mon 30-01-23 09:16:13, Kefeng Wang wrote:
> > > 
> > > 
> > > On 2023/1/30 5:48, Andrew Morton wrote:
> > > > On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > > 
> > > > > As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
> > > > 
> > > > Merged in 2017.
> > > > 
> > > > > hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> > > > > could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> > > > > occurs a NULL pointer dereference, let's do not record the foreign
> > > > > writebacks for folio memcg is null in mem_cgroup_track_foreign() to
> > > > > fix it.
> > > > > 
> > > > > Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> > > > > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> > > > 
> > > > Merged in 2019.
> > > > 
> ...
> > 
> > Just to make sure I understand. The page has been hwpoisoned, uncharged
> > but stayed in the page cache so a next page fault on the address has blowned
> > up?
> > 
> > Say we address the NULL memcg case. What is the resulting behavior?
> > Doesn't userspace access a poisoned page and get a silend memory
> > corruption?
> 
> + Yang Shi
> 
> Check previous link[1], seems that it is a known issue, and there is a TODO
> list for storage backed filesystems from Yang.

OK, so IIUC this patch will just help the test to not blow up but it
will not allow the test to behave consistently. From my past experience
the hwpoisoning is not really something that any production environment
should be relying on working properly.

But this patch is straightforward so no objection from me. 
Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> [1] https://lore.kernel.org/all/20211020210755.23964-6-shy828301@gmail.com/T/#m1d40559ca2dcf94396df5369214288f69dec379b

-- 
Michal Hocko
SUSE Labs
