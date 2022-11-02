Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7B615D7C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKBIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKBIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:17:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE21F9D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:17:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB9051F898;
        Wed,  2 Nov 2022 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667377059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wko95XSy2SHsBUnksXP59GvfWwdvJCJ/BihoSvq6r4o=;
        b=jz9zThdt3aB+bCicBEdSh+DWj1aKlA36kBhpABPGm16AcMiajgtJm2u3FC84h8hV4GVbTS
        +S/l9EmfWmukXQv1HTGq684orhUxYXsy+1B6T1OAbQ2tzcwYJcYDttvPmNxKUD64m0lJwK
        JCfERZbiqDVdZjiMcIxcnS6bM7/9gW0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B2F01376E;
        Wed,  2 Nov 2022 08:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bgH+IqMnYmOBBQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 08:17:39 +0000
Date:   Wed, 2 Nov 2022 09:17:38 +0100
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
Message-ID: <Y2Inot4i4xUGH60O@dhcp22.suse.cz>
References: <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
 <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
 <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
 <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
 <878rkuchpm.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y2IhiSnpQsmY7khx@dhcp22.suse.cz>
 <87bkppbx75.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkppbx75.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02-11-22 16:02:54, Huang, Ying wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Wed 02-11-22 08:39:49, Huang, Ying wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
> >> 
> >> > On Mon 31-10-22 09:33:49, Huang, Ying wrote:
> >> > [...]
> >> >> In the upstream implementation, 4 tiers are possible below DRAM.  That's
> >> >> enough for now.  But in the long run, it may be better to define more.
> >> >> 100 possible tiers below DRAM may be too extreme.
> >> >
> >> > I am just curious. Is any configurations with more than couple of tiers
> >> > even manageable? I mean applications have been struggling even with
> >> > regular NUMA systems for years and vast majority of them is largerly
> >> > NUMA unaware. How are they going to configure for a more complex system
> >> > when a) there is no resource access control so whatever you aim for
> >> > might not be available and b) in which situations there is going to be a
> >> > demand only for subset of tears (GPU memory?) ?
> >> 
> >> Sorry for confusing.  I think that there are only several (less than 10)
> >> tiers in a system in practice.  Yes, here, I suggested to define 100 (10
> >> in the later text) POSSIBLE tiers below DRAM.  My intention isn't to
> >> manage a system with tens memory tiers.  Instead, my intention is to
> >> avoid to put 2 memory types into one memory tier by accident via make
> >> the abstract distance range of each memory tier as small as possible.
> >> More possible memory tiers, smaller abstract distance range of each
> >> memory tier.
> >
> > TBH I do not really understand how tweaking ranges helps anything.
> > IIUC drivers are free to assign any abstract distance so they will clash
> > without any higher level coordination.
> 
> Yes.  That's possible.  Each memory tier corresponds to one abstract
> distance range.  The larger the range is, the higher the possibility of
> clashing is.  So I suggest to make the abstract distance range smaller
> to reduce the possibility of clashing.

I am sorry but I really do not understand how the size of the range
actually addresses a fundamental issue that each driver simply picks
what it wants. Is there any enumeration defining basic characteristic of
each tier? How does a driver developer knows which tear to assign its
driver to?

-- 
Michal Hocko
SUSE Labs
