Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B786615D2F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKBHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBHvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:51:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF52C25C4C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:51:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2C31F8CC;
        Wed,  2 Nov 2022 07:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7DuwjAkYM/Dv14i5yvJmY3bptRAmV3B0bXlSokhvkU=;
        b=p9XCoIBRceI3p9u3l1FfW99PKsINz+chQP2YGzw+W9mP1uTvesAnRC8Fr8kFBu3Owg49Rg
        Xa1IjExoFwfxCeNCmgFfKnuacTwNgPl+yvAa1P/QuD9UNqQNovjJBnRgqqZZk6Ddi7H1oM
        doeP5HW63nNRDzGEUN40s4Z+hMgDHgs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 694421376E;
        Wed,  2 Nov 2022 07:51:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z+cmF4ohYmPjdAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 07:51:38 +0000
Date:   Wed, 2 Nov 2022 08:51:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Bharata B Rao <bharata@amd.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
Message-ID: <Y2IhiSnpQsmY7khx@dhcp22.suse.cz>
References: <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
 <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
 <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
 <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
 <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
 <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 08:39:49, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 31-10-22 09:33:49, Huang, Ying wrote:
> > [...]
> >> In the upstream implementation, 4 tiers are possible below DRAM.  That's
> >> enough for now.  But in the long run, it may be better to define more.
> >> 100 possible tiers below DRAM may be too extreme.
> >
> > I am just curious. Is any configurations with more than couple of tiers
> > even manageable? I mean applications have been struggling even with
> > regular NUMA systems for years and vast majority of them is largerly
> > NUMA unaware. How are they going to configure for a more complex system
> > when a) there is no resource access control so whatever you aim for
> > might not be available and b) in which situations there is going to be a
> > demand only for subset of tears (GPU memory?) ?
> 
> Sorry for confusing.  I think that there are only several (less than 10)
> tiers in a system in practice.  Yes, here, I suggested to define 100 (10
> in the later text) POSSIBLE tiers below DRAM.  My intention isn't to
> manage a system with tens memory tiers.  Instead, my intention is to
> avoid to put 2 memory types into one memory tier by accident via make
> the abstract distance range of each memory tier as small as possible.
> More possible memory tiers, smaller abstract distance range of each
> memory tier.

TBH I do not really understand how tweaking ranges helps anything.
IIUC drivers are free to assign any abstract distance so they will clash
without any higher level coordination.
-- 
Michal Hocko
SUSE Labs
