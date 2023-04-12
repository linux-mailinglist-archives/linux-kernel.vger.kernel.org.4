Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E696DF21B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDLKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjDLKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:41:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F996A76
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:41:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2CC52195D;
        Wed, 12 Apr 2023 10:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681296111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qORcrIdBgTd6N3Ng5bWVL93iviLNLM8ytHL/iEw+y1E=;
        b=tll98gAJ4PBYuuJblGT3bQTrcize3AXLB86X/BE3z46RbRj6az/IkE9vtA3F8V4XllLfBz
        FKgQKz4aY9oahSA0ue9QWwRaAp1hbkHNI83EAXRvwR/7cwiEfbdUDBQbhNWsDDzJEkhKr2
        izPIq2ctZFtma5fABC7ObRIhNzaZLWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681296111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qORcrIdBgTd6N3Ng5bWVL93iviLNLM8ytHL/iEw+y1E=;
        b=veHbgvGOYpdoyrweJpndxK/nR+6BALDmQjqNpPGDHor1aYk+XMVgcPGxI81C6Vn7hpKX5v
        IOTXkQ82MPDbcrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BC54132C7;
        Wed, 12 Apr 2023 10:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L+YAJu+KNmTCIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 10:41:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1F497A0732; Wed, 12 Apr 2023 12:41:51 +0200 (CEST)
Date:   Wed, 12 Apr 2023 12:41:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: find_get_page() VS pin_user_pages()
Message-ID: <20230412104151.hkl5navnaoc7l7ob@quack3>
References: <PH0PR12MB5606D4611050BC8B1CC430FEF09A9@PH0PR12MB5606.namprd12.prod.outlook.com>
 <87mt3ehti4.fsf@nvidia.com>
 <MW5PR12MB55984F39C8CECADDFE7548F2F09B9@MW5PR12MB5598.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR12MB55984F39C8CECADDFE7548F2F09B9@MW5PR12MB5598.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12-04-23 09:04:33, Teterevkov, Ivan wrote:
> From: Alistair Popple <apopple@nvidia.com> 
> 
> > "Teterevkov, Ivan" <Ivan.Teterevkov@amd.com> writes:
> > 
> > > Hello folks,
> > >
> > > I work with an application which aims to share memory in the userspace and
> > > interact with the NIC DMA. The memory allocation workflow begins in the
> > > userspace, which creates a new file backed by 2MiB hugepages with
> > > memfd_create(MFD_HUGETLB, MFD_HUGE_2MB) and fallocate(). Then the userspace
> > > makes an IOCTL to the kernel module with the file descriptor and size so that
> > > the kernel module can get the struct page with find_get_page(). Then the kernel
> > > module calls dma_map_single(page_address(page)) for NIC, which concludes the
> > > datapath. The allocated memory may (significantly) outlive the originating
> > > userspace application. The hugepages stay mapped with NIC, and the kernel
> > > module wants to continue using them and map to other applications that come and
> > > go with vm_mmap().
> > >
> > > I am studying the pin_user_pages*() family of functions, and I wonder if the
> > > outlined workflow requires it. The hugepages do not page out, but they can move
> > > as they may be allocated with GFP_HIGHUSER_MOVABLE. However, find_get_page()
> > > must increment the page reference counter without mapping and prevent it from
> > > moving. In particular, https://docs.kernel.org/mm/page_migration.html:
> > 
> > I'm not super familiar with the memfd_create()/find_get_page() workflow
> > but is there some reason you're not using pin_user_pages*(FOLL_LONGTERM)
> > to get the struct page initially? You're description above sounds
> > exactly the use case pin_user_pages() was designed for because it marks
> > the page as being writen to by DMA, makes sure it's not in a movable
> > zone, etc.
> > 
> 
> The biggest obstacle with the application workflow is that the memory
> allocation is mostly kernel-driven. The kernel module may want to tell DMA
> about the hugepages before the userspace application maps it into its address
> space, so the kernel module does not have the starting user address at hand.

I'm a bit confused. Above you write that:

"The memory allocation workflow begins in the userspace, which creates a new
file backed by 2MiB hugepages with memfd_create(MFD_HUGETLB, MFD_HUGE_2MB)
and fallocate(). Then the userspace makes an IOCTL to the kernel module
with the file descriptor and size so that the kernel module can get the
struct page with find_get_page()."

So the memory allocation actually does happen from fallocate(2) as far as I
can tell. What guys are suggesting is that instead of passing the prepared
'fd' to ioctl(2), your application should mmap the file and pass the
address of the mmapped area. That's how things are usually done and it also
gives userspace more freedom over how it prepares buffers for DMA. Also then
pin_user_pages() comes as a natural API to use in the driver.

Now I'm not sure whether changing the ioctl(2) is still an option for you.
If not, then you have to resort to some kind of workaround as you
mentioned. But still pin_user_pages(FOLL_LONGTERM) is definitely the API
you should be using for telling the kernel you are going to DMA into these
pages and want to hold onto them for a long time.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
