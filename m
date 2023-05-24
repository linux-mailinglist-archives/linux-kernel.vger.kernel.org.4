Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4470370F812
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjEXNxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjEXNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:53:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4B0D8
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:53:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DC9621F38;
        Wed, 24 May 2023 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684936392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dT1yNCcJpvvO2QbPL8e/KP4ylMe8xLmnrwlKlxBl7s=;
        b=0rUGUqYV5NMfb+s8ioG0P3bHJ0LK8zZPW4FP2G6Og/U7/d2QSl3HEXqlTuj9Gc1IFFSiLB
        c5A3n7TkekRBLR/JHb9HBbigaRnaM2hHlvoA5OGiR8jkWYinqSuF22iS6KSB2lZrvXvIdl
        TcZEOp42qbvGQXyCkMTVVitu6pNW5p8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684936392;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8dT1yNCcJpvvO2QbPL8e/KP4ylMe8xLmnrwlKlxBl7s=;
        b=Lvoy8xSOk+0NSyEgmzvbYikH0sfGnRnwQIbb5QjsAMef3qho/SkyMcrerwqEN73h7SwZS5
        lUC+CtlFrheoaqDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B318133E6;
        Wed, 24 May 2023 13:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tosrAsgWbmS5FQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 24 May 2023 13:53:12 +0000
Message-ID: <70763661-b2a2-4bf2-f589-e0d71083f1bd@suse.cz>
Date:   Wed, 24 May 2023 15:53:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mm/slab: add new flag SLAB_NO_MERGE to avoid merging per
 slab
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>
References: <20230524101748.30714-1-dsterba@suse.com>
 <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/23 14:56, Hyeonggon Yoo wrote:
> On Wed, May 24, 2023 at 12:17:48PM +0200, David Sterba wrote:
>> Add a flag that allows to disable merging per slab. This can be used for
>> more fine grained control over the caches or for debugging builds where
>> separate slabs can verify that no objects leak.
>> The slab_nomerge boot option is too coarse and would need to be enabled
>> on all testing hosts. 
> 
> Hello David,
> 
> There is no users nor interface to set this flag, I guess you're going
> to use it by modifying source code, when debugging?
> 
> Does introducing new slub_debug option (i.e. slub_debug=N,pid_namespace)
> work for your use case? (there are some boot-time slub_debug options described in
> Documentation/mm/slub.rst)

Yeah, it supports globbing so it would be e.g. slub_debug=N,btrfs*
That would deal with the "too coarse" aspect slab_nomerge. As for "need to
be enabled on all testing hosts", is it more convenient to deploy a debug
kernel build on them? Might be because you do that for other reasons
already? Just want to clarify.

BTW this was proposed as RFC few months ago but not pursued:
https://lore.kernel.org/all/167396280045.539803.7540459812377220500.stgit@firesoul/

I have no big objections, just wouldn't like to see its usage proliferate
unconditionally into non-debug builds.

>> There are some other ways how to disable merging,
>> e.g. a slab constructor but this disables poisoning besides that it adds
>> additional overhead. Other flags are internal and may have other
>> semantics.
>>
>> A concrete example what motivates the flag. During 'btrfs balance' slab
>> top reported huge increase in caches like
>> 
>>   1330095 1330095 100%    0.10K  34105       39    136420K Acpi-ParseExt
>>   1734684 1734684 100%    0.14K  61953       28    247812K pid_namespace
>>   8244036 6873075  83%    0.11K 229001       36    916004K khugepaged_mm_slot
>> 
>> which was confusing and that it's because of slab merging was not the
>> first idea.  After rebooting with slab_nomerge all the caches were from
>> btrfs_ namespace as expected.
>>
>> Signed-off-by: David Sterba <dsterba@suse.com>
>> ---
>>  include/linux/slab.h | 3 +++
>>  mm/slab_common.c     | 2 +-
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
> 
> Thanks,
> 

