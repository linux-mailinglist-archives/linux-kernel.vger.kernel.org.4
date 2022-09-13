Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E45B77F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiIMR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiIMR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:27:18 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265191D24;
        Tue, 13 Sep 2022 09:15:54 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E35F8820A31;
        Tue, 13 Sep 2022 16:15:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a250 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BEE0B820FC4;
        Tue, 13 Sep 2022 16:15:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1663085746; a=rsa-sha256;
        cv=none;
        b=v/cbx8DJ+4lvFam+asAi7Iptj4LcSXnDsr4AZJ3nnGr7nydhBWRgFBlHXg9vpcm84F0GzL
        NV1d2Giow2T0VGpw1Nr7+1YCqERAbMrmCv3aofUyv8hhSeAO/7bB6Z0CI9HIRRE6NNY4Yn
        uULMSAwSQEqncey1YGaEp3d1CCA9FL7w567U1GKGnjsjaEUpBa0nlcj+rIyhzFH3UqauWO
        PFng9cyhx8+7QXkUgzsczifIwq4SKZqywrQM3myFS/onoBLO9FR+vZjH1DCycjryOE4Q2+
        ebI8EwjlHzUQPEvUevNR0dcXi5ZN3h7T4o32PKQmdlEI61Rpvl7CZw2mzkQKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1663085746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=ohm075s1m9Kp9Od2CHtG67wU33nUHIoZHydV6G2vhDY=;
        b=QtS+WWWyDokWth6M9fe419i29RtMd1jMVq4scewBj5jqh86LONSeeJ6YXMvpd0khAOrNJl
        MQBZ66+ej2pY5QcillVUaY5YpBrr7H+Bl6dSyOpyARU48b5fr5RbNv86QrPFtce1UXKCUo
        SfJJasDi5momk9Csl3FXG6OEfi0L4r5iLk7olDnZF5EHpCSp9g+fAuC+H1hpPbOApHxIG5
        zCjOurFa68fTT2DHTSec4X/jhPTHvT48fWJ54otqqslcksa0QvBVQzgOJR4QTA7L+oFkTd
        qPHafYLSJqxutLYwTdZTcFxKj3rAajxHzIHsgaNXr0VX09YU3mA6F3jsaL6Zhw==
ARC-Authentication-Results: i=1;
        rspamd-f776c45b8-bftt8;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Company: 1f85ae8b2d6d1fd3_1663085746430_1702281768
X-MC-Loop-Signature: 1663085746430:2199615271
X-MC-Ingress-Time: 1663085746430
Received: from pdx1-sub0-mail-a250 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.219.78 (trex/6.7.1);
        Tue, 13 Sep 2022 16:15:46 +0000
Received: from offworld (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250 (Postfix) with ESMTPSA id 4MRpV4190jz2F;
        Tue, 13 Sep 2022 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1663085745;
        bh=ohm075s1m9Kp9Od2CHtG67wU33nUHIoZHydV6G2vhDY=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=oPJZbt3RwtuVu5vSAY3pT27Ir2YQitrznv+xxsn6vAlPvPdRVHomHa9SUnf3gwvKl
         /KkV9My3lKDYsJ2u6bDVhi9ixnNTn0U8p/liDviDS9KvZ6JhIonbwEzXcKokWRD6jK
         emicAUY+gA1+9SInNXMBYlaZRTzvN64aFlNpWCcLxu5i+yFEnNEcxpEA4psrODM2YC
         N8n/rtlsYa2e8zCVmNJJ30+FeFHyduSp8SDjH0H0Z2UeB0bDwPp96M+VD8+zLC7lwi
         66aI/IurgP0DioI6SogGrP1M/Jnd6benT9BTcFzB/uahRqYhVFmGt/r1dCiUUuVafN
         if0tCIn8cOzFA==
Date:   Tue, 13 Sep 2022 08:56:24 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        peterz@infradead.org, bp@alien8.de, dave.jiang@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <20220913155624.yx3dbab6x5uza2av@offworld>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <20220907153016.f7cd4f42a337fedae8319f28@linux-foundation.org>
 <631940536d040_2736529437@dwillia2-xfh.jf.intel.com.notmuch>
 <20220908141319.00000f01@huawei.com>
 <631a7206afc2_166f29413@dwillia2-xfh.jf.intel.com.notmuch>
 <20220908160035.f030e3e533a996eadc04dbd5@linux-foundation.org>
 <631a7932c6eb5_166f2945d@dwillia2-xfh.jf.intel.com.notmuch>
 <20220909124326.00002c85@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220909124326.00002c85@huawei.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Jonathan Cameron wrote:

>On Thu, 8 Sep 2022 16:22:26 -0700
>Dan Williams <dan.j.williams@intel.com> wrote:
>
>> Andrew Morton wrote:
>> > On Thu, 8 Sep 2022 15:51:50 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> > > Jonathan Cameron wrote:
>> > > > On Wed, 7 Sep 2022 18:07:31 -0700
>> > > > Dan Williams <dan.j.williams@intel.com> wrote:
>> > > >
>> > > > > Andrew Morton wrote:
>> > > > > > I really dislike the term "flush".  Sometimes it means writeback,
>> > > > > > sometimes it means invalidate.  Perhaps at other times it means
>> > > > > > both.
>> > > > > >
>> > > > > > Can we please be very clear in comments and changelogs about exactly
>> > > > > > what this "flush" does.   With bonus points for being more specific in the
>> > > > > > function naming?
>> > > > > >
>> > > > >
>> > > > > That's a good point, "flush" has been cargo-culted along in Linux's
>> > > > > cache management APIs to mean write-back-and-invalidate. In this case I
>> > > > > think this API is purely about invalidate. It just so happens that x86
>> > > > > has not historically had a global invalidate instruction readily
>> > > > > available which leads to the overuse of wbinvd.
>> > > > >
>> > > > > It would be nice to make clear that this API is purely about
>> > > > > invalidating any data cached for a physical address impacted by address
>> > > > > space management event (secure erase / new region provision). Write-back
>> > > > > is an unnecessary side-effect.
>> > > > >
>> > > > > So how about:
>> > > > >
>> > > > > s/arch_flush_memregion/cpu_cache_invalidate_memregion/?
>> > > >
>> > > > Want to indicate it 'might' write back perhaps?
>> > > > So could be invalidate or clean and invalidate (using arm ARM terms just to add
>> > > > to the confusion ;)
>> > > >
>> > > > Feels like there will be potential race conditions where that matters as we might
>> > > > force stale data to be written back.
>> > > >
>> > > > Perhaps a comment is enough for that. Anyone have the "famous last words" feeling?
>> > >
>> > > Is "invalidate" not clear that write-back is optional? Maybe not.
>> >
>> > Yes, I'd say that "invalidate" means "dirty stuff may of may not have
>> > been written back".  Ditto for invalidate_inode_pages2().
>> >
>> > > Also, I realized that we tried to include the address range to allow for
>> > > the possibility of flushing by virtual address range, but that
>> > > overcomplicates the use. I.e. if someone issue secure erase and the
>> > > region association is not established does that mean that mean that the
>> > > cache invalidation is not needed? It could be the case that someone
>> > > disables a device, does the secure erase, and then reattaches to the
>> > > same region. The cache invalidation is needed, but at the time of the
>> > > secure erase the HPA was unknown.
>> > >
>> > > All this to say that I feel the bikeshedding will need to continue until
>> > > morale improves.
>> > >
>> > > I notice that the DMA API uses 'sync' to indicate, "make this memory
>> > > consistent/coherent for the CPU or the device", so how about an API like
>> > >
>> > >     memregion_sync_for_cpu(int res_desc)
>> > >
>> > > ...where the @res_desc would be IORES_DESC_CXL for all CXL and
>> > > IORES_DESC_PERSISTENT_MEMORY for the current nvdimm use case.
>> >
>> > "sync" is another of my pet peeves ;) In filesystem land, at least.
>> > Does it mean "start writeback and return" or does it mean "start
>> > writeback, wait for its completion then return".
>>
>> Ok, no "sync" :).
>>
>> /**
>>  * cpu_cache_invalidate_memregion - drop any CPU cached data for
>>  *     memregions described by @res_des
>>  * @res_desc: one of the IORES_DESC_* types
>>  *
>>  * Perform cache maintenance after a memory event / operation that
>>  * changes the contents of physical memory in a cache-incoherent manner.
>>  * For example, memory-device secure erase, or provisioning new CXL
>>  * regions. This routine may or may not write back any dirty contents
>>  * while performing the invalidation.
>>  *
>>  * Returns 0 on success or negative error code on a failure to perform
>>  * the cache maintenance.
>>  */
>> int cpu_cache_invalidate_memregion(int res_desc)
>
>lgtm

Likewise, and I don't see anyone else objecting so I'll go ahead and send
a new iteration.

Thanks,
Davidlohr
