Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAD0614CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiKAOfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKAOez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:34:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1F1BE8F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:34:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F727336F9;
        Tue,  1 Nov 2022 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667313292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=md7UdvagT3X4V8u77OX2NjG4n87gQfkAxPbnmYefNuc=;
        b=ZFyHqoxeRhYtLuEfJJNaBqeFdVHfTDO5Nw6gJoMHmH7yKnkMiUXJUeYsGswDVHeja9lhMH
        cixX1+RaowWVAo9iTCEgoLGomWiO4zrBnXZlIsAInL8LqcOmjtZeRrN2OWoBtE0ixgVwPc
        Qs18LUCGxWBtXDgWEZYyvQkLStW2lYU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF91F13AAF;
        Tue,  1 Nov 2022 14:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TWBUMIsuYWPeRgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 01 Nov 2022 14:34:51 +0000
Date:   Tue, 1 Nov 2022 15:34:51 +0100
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
Message-ID: <Y2Eui+kKvwj8ip+T@dhcp22.suse.cz>
References: <20221027065925.476955-1-ying.huang@intel.com>
 <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
 <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
 <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
 <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
 <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 31-10-22 09:33:49, Huang, Ying wrote:
[...]
> In the upstream implementation, 4 tiers are possible below DRAM.  That's
> enough for now.  But in the long run, it may be better to define more.
> 100 possible tiers below DRAM may be too extreme.

I am just curious. Is any configurations with more than couple of tiers
even manageable? I mean applications have been struggling even with
regular NUMA systems for years and vast majority of them is largerly
NUMA unaware. How are they going to configure for a more complex system
when a) there is no resource access control so whatever you aim for
might not be available and b) in which situations there is going to be a
demand only for subset of tears (GPU memory?) ?

Thanks!

-- 
Michal Hocko
SUSE Labs
