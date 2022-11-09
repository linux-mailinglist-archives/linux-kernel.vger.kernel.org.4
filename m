Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669AE622A08
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKILRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKILQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:16:31 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C672AC7D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:16:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E8F41F6E6;
        Wed,  9 Nov 2022 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667992570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nt/ta1l555vr4EsYp1C+UKFBUJaf1xMeh2se9hvTXV4=;
        b=A+ZNMvKzJsRbs3XX0kDqucBV1QNYQeSVip1ZSRDe6o/ioxjNewKigBfJ/jKiAwRYHN8oOY
        tfDdGmNMDy0YWSd/Q0hEmo8HW2llBqZasFgJQ+Qc077dyXpHhVfAvbnhHEY8ddylWvpNuY
        p0/5Tjy2pNTIKp0I22D9cw+9UUKMJaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667992570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nt/ta1l555vr4EsYp1C+UKFBUJaf1xMeh2se9hvTXV4=;
        b=v+hsFIFU7SeXH0BVMt0N5U6cmbClwvje2b0/4Xit0/rOiAaD5EWurfl9KA9zqMrvmbtZrT
        jeTJiqAygmEW+6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33ACA1331F;
        Wed,  9 Nov 2022 11:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5NDC/qLa2M7NAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Nov 2022 11:16:10 +0000
Message-ID: <cb71d0f1-c8dd-2bd4-30cf-7fe8531a66e4@suse.cz>
Date:   Wed, 9 Nov 2022 12:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 0/3] Refactor __kmem_cache_create() and fix memory leak
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20221031134747.3049593-1-liushixin2@huawei.com>
 <Y2IgUwTH/dO06Tot@hyeyoo> <c03620e3-6159-1c46-c472-c15186f4ccae@huawei.com>
 <Y2PA6JBklwwtLlST@hyeyoo>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y2PA6JBklwwtLlST@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 14:23, Hyeonggon Yoo wrote:
> On Wed, Nov 02, 2022 at 04:53:08PM +0800, Liu Shixin wrote:
>> On 2022/11/2 15:46, Hyeonggon Yoo wrote:
>> > On Mon, Oct 31, 2022 at 09:47:44PM +0800, Liu Shixin wrote:
>> >> I found a memory leak of kobj->name in sysfs_slab_add() which is introduced
>> >> by 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename").
>> >> Following the rules stated in the comment for kobject_init_and_add():
>> > Thank you for reporting this! Indeed it seems tried to fix double free but
>> > introduced a leak.
>> >
>> >>  If this function returns an error, kobject_put() must be called to
>> >>  properly clean up the memory associated with the object.
>> >>
>> >> We should use kobject_put() to free kobject.
>> > But what to do if a cache is created early and later sysfs_slab_add() failed?
>> > (Which is unlikely on normal condition)
>> >
>> > With this series it introduces use-after-free if sysfs_slab_add() in
>> > slab_sysfs_init() failed.  Should we just call BUG() or something like that?
>>
>> Thanks for your discovery, what I missed.
> 
> You're welcome.
> 
>> I prefer to panic directly, just as create_boot_cache() does.
> 
> IMHO that should be nothing serious. but let's hear maintainers' opinion.
> 
>> Of couse, if you want the system to continue booting, I think it's possible to distinguish them
>> by slab_state.
> 
> I'm afraid to make it more complex :(

+Cc Rasmus who did a recent patch in this area. Thread starts here:
https://lore.kernel.org/all/20221031134747.3049593-1-liushixin2@huawei.com/

As for me, I don't think we should be addung new BUG() or panic() in
general, and especially not for a failing sysfs add. AFAICS
create_boot_cache() might panic, but not because of sysfs, as that's delayed
until slab_sysfs_init() and we don't panic anymore in the latter.

So yeah, it could work to tell sysfs_slab_add() whether it should not do the
kobject_put() as it's a boot cache. The slab_state should work.

> 
>> Looking forward to your advice.
>> Thanks,
>> >
>> >> But we can't simply add kobject_put() since it will free kmem_cache too.
>> >> If we use kobject_put(), we need to skip other release functions.
>> >>
>> >> In this series, We refactor the code to separate sysfs_slab_add() and
>> >> debugfs_slab_add() from __kmem_cache_create(), and then use kobject_put()
>> >> to free kobject in sysfs_slab_add(). This can fix the memory leak of
>> >> kobject->name.
>> >>
>> >> v1->v2: Fix build error reported by kernel test robot <lkp@intel.com>.
>> >>
>> >> Liu Shixin (3):
>> >>   mm/slab_common: Move cache_name to create_cache()
>> >>   mm/slub: Refactor __kmem_cache_create()
>> >>   mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
>> >>
>> >>  include/linux/slub_def.h | 11 +++++++++
>> >>  mm/slab_common.c         | 44 ++++++++++++++++++----------------
>> >>  mm/slub.c                | 52 ++++++++++------------------------------
>> >>  3 files changed, 48 insertions(+), 59 deletions(-)
>> >>
>> >> -- 
>> >> 2.25.1
>> >>
>> 
> 

