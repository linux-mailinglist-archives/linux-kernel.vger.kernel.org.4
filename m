Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD6E6A487A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjB0RrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB0RrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5141BF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677519981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mkc3cHryKoQlVgV2zVl+0PzzwDJTUCgbCBX7Jw82OE=;
        b=cM9OPig+7nHtfKxOdc8qz4kRoAGnVQK5gIiML3Us4h4Ybsnx8iYpktEHLvG3gVbh+UHiQI
        33pNqgchdz/Q6XyTt7JkbHb6wCp/wpCVvJdlC8aC6MQNqagOmph9bFoQ3BjAUC3ynYNQxm
        yImLiupYhq85anpIZjuwyAfK5duwwbE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-554-NRACiFujM9KPGror2wlpfg-1; Mon, 27 Feb 2023 12:39:43 -0500
X-MC-Unique: NRACiFujM9KPGror2wlpfg-1
Received: by mail-ed1-f71.google.com with SMTP id cy28-20020a0564021c9c00b004acc6cf6322so9535192edb.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mkc3cHryKoQlVgV2zVl+0PzzwDJTUCgbCBX7Jw82OE=;
        b=Pb5HtmlAvuwnTvUE/L+eUzF9pBoCYHOn7UzQ24OzqHI4j95lLYqY2Kug1tCSlmVjP7
         6zRG5RgmnbehM7vG5CGgLvE4jNimc0zV6tlCRoOEEjI4RwR0lbYhPYgRP/VSb9KzVwxb
         usJeX7/BQNKaddZVGtsDhhfLngdqIZ146PlVCPNP9VU+vWHfbpNNPGufMml9bC0DQ5S5
         XHGbE34zrRIymN53qr3RIVxQtvc89IAqPnWfl8BY7TWePVafd/qTzlWo9Lqvw9USAV8h
         PlgfLfG23rMbb+wsgZP8fSrRXYYb+m+KKciR60281n6DCta13ZGj6TZQWz/Ar3RicJ3p
         5khQ==
X-Gm-Message-State: AO0yUKW7rfa0hw5Xp6nFz+BxgvPpOTAB0HxnVqyQqb4bv0e2m56PUuIM
        NVaP0oc12/Bl+GsCQM7LlyKywd92VTAOybOjmxNNbViFJXrY/rCvORiGL1ATxe3XwjAjv7qi+9D
        BY5+KcpV6kxSSX4sY/7yP9IGH
X-Received: by 2002:a17:907:97c3:b0:8af:ef00:b853 with SMTP id js3-20020a17090797c300b008afef00b853mr44969565ejc.73.1677519576275;
        Mon, 27 Feb 2023 09:39:36 -0800 (PST)
X-Google-Smtp-Source: AK7set8dwfwqQmqPjam8UzWIoP7CWEacRLfEPhcixYlLH9/bKx4zKjhRg3obJwXpommPMEyYgK8mKw==
X-Received: by 2002:a17:907:97c3:b0:8af:ef00:b853 with SMTP id js3-20020a17090797c300b008afef00b853mr44969529ejc.73.1677519575989;
        Mon, 27 Feb 2023 09:39:35 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709061e9300b008d83ad86fe8sm3481538ejj.59.2023.02.27.09.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 09:39:35 -0800 (PST)
Message-ID: <67942a68-2ae7-8883-25d7-c6d595c3587e@redhat.com>
Date:   Mon, 27 Feb 2023 18:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH drm-next v2 04/16] maple_tree: add flag MT_FLAGS_LOCK_NONE
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     matthew.brost@intel.com, dri-devel@lists.freedesktop.org,
        corbet@lwn.net, nouveau@lists.freedesktop.org, ogabbay@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, boris.brezillon@collabora.com,
        bskeggs@redhat.com, tzimmermann@suse.de, Liam.Howlett@oracle.com,
        bagasdotme@gmail.com, christian.koenig@amd.com,
        jason@jlekstrand.net
References: <20230217134422.14116-1-dakr@redhat.com>
 <20230217134422.14116-5-dakr@redhat.com>
 <Y+/Xn11dfdn7SfBD@casper.infradead.org>
 <3bb02ec3-4d19-9135-cabc-26ed210f7396@redhat.com>
 <Y/ONYhyDCPEYH1ml@casper.infradead.org>
 <e43f6acc-175d-1031-c4a2-67a6f1741866@redhat.com>
 <Y/PZH/q2Xsr3od9m@casper.infradead.org> <Y/TXPasvkhtGiR+w@pollux>
 <Y/UN50hCaRe+8ZCg@casper.infradead.org>
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y/UN50hCaRe+8ZCg@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 19:31, Matthew Wilcox wrote:
> On Tue, Feb 21, 2023 at 03:37:49PM +0100, Danilo Krummrich wrote:
>> On Mon, Feb 20, 2023 at 08:33:35PM +0000, Matthew Wilcox wrote:
>>> On Mon, Feb 20, 2023 at 06:06:03PM +0100, Danilo Krummrich wrote:
>>>> On 2/20/23 16:10, Matthew Wilcox wrote:
>>>>> This is why we like people to use the spinlock embedded in the tree.
>>>>> There's nothing for the user to care about.  If the access really is
>>>>> serialised, acquiring/releasing the uncontended spinlock is a minimal
>>>>> cost compared to all the other things that will happen while modifying
>>>>> the tree.
>>>>
>>>> I think as for the users of the GPUVA manager we'd have two cases:
>>>>
>>>> 1) Accesses to the manager (and hence the tree) are serialized, no lock
>>>> needed.
>>>>
>>>> 2) Multiple operations on the tree must be locked in order to make them
>>>> appear atomic.
>>>
>>> Could you give an example here of what you'd like to do?  Ideally
>>> something complicated so I don't say "Oh, you can just do this" when
>>> there's a more complex example for which "this" won't work.  I'm sure
>>> that's embedded somewhere in the next 20-odd patches, but it's probably
>>> quicker for you to describe in terms of tree operations that have to
>>> appear atomic than for me to try to figure it out.
>>>
>>
>> Absolutely, not gonna ask you to read all of that. :-)
>>
>> One thing the GPUVA manager does is to provide drivers the (sub-)operations
>> that need to be processed in order to fulfill a map or unmap request from
>> userspace. For instance, when userspace asks the driver to map some memory
>> the GPUVA manager calculates which existing mappings must be removed, split up
>> or can be merged with the newly requested mapping.
>>
>> A driver has two ways to fetch those operations from the GPUVA manager. It can
>> either obtain a list of operations or receive a callback for each operation
>> generated by the GPUVA manager.
>>
>> In both cases the GPUVA manager walks the maple tree, which keeps track of
>> existing mappings, for the given range in __drm_gpuva_sm_map() (only considering
>> the map case, since the unmap case is a subset basically). For each mapping
>> found in the given range the driver, as mentioned, either receives a callback or
>> a list entry is added to the list of operations.
>>
>> Typically, for each operation / callback one entry within the maple tree is
>> removed and, optionally at the beginning and end of a new mapping's range, a
>> new entry is inserted. An of course, as the last operation, there is the new
>> mapping itself to insert.
>>
>> The GPUVA manager delegates locking responsibility to the drivers. Typically,
>> a driver either serializes access to the VA space managed by the GPUVA manager
>> (no lock needed) or need to lock the processing of a full set of operations
>> generated by the GPUVA manager.
> 
> OK, that all makes sense.  It does make sense to have the driver use its
> own mutex and then take the spinlock inside the maple tree code.  It
> shouldn't ever be contended.
> 
>>>> In either case the embedded spinlock wouldn't be useful, we'd either need an
>>>> external lock or no lock at all.
>>>>
>>>> If there are any internal reasons why specific tree operations must be
>>>> mutually excluded (such as those you explain below), wouldn't it make more
>>>> sense to always have the internal lock and, optionally, allow users to
>>>> specify an external lock additionally?
>>>
>>> So the way this works for the XArray, which is a little older than the
>>> Maple tree, is that we always use the internal spinlock for
>>> modifications (possibly BH or IRQ safe), and if someone wants to
>>> use an external mutex to make some callers atomic with respect to each
>>> other, they're free to do so.  In that case, the XArray doesn't check
>>> the user's external locking at all, because it really can't know.
>>>
>>> I'd advise taking that approach; if there's really no way to use the
>>> internal spinlock to make your complicated updates appear atomic
>>> then just let the maple tree use its internal spinlock, and you can
>>> also use your external mutex however you like.
>>>
>>
>> That sounds like the right thing to do.
>>
>> However, I'm using the advanced API of the maple tree (and that's the reason
>> why the above example appears a little more detailed than needed) because I
>> think with the normal API I can't insert / remove tree entries while walking
>> the tree, right?
> 
> Right.  The normal API is for simple operations while the advanced API
> is for doing compound operations.
> 
>> As by the documentation the advanced API, however, doesn't take care of locking
>> itself, hence just letting the maple tree use its internal spinlock doesn't
>> really work - I need to take care of that myself, right?
> 
> Yes; once you're using the advanced API, you get to compose the entire
> operation yourself.
> 
>> It feels a bit weird that I, as a user of the API, would need to lock certain
>> (or all?) mas_*() functions with the internal spinlock in order to protect
>> (future) internal features of the tree, such as the slab cache defragmentation
>> you mentioned. Because from my perspective, as the generic component that tells
>> it's users (the drivers) to take care of locking VA space operations (and hence
>> tree operations) I don't have an own purpose of this internal spinlock, right?
> 
> You don't ... but we can't know that.
> 
>> Also I'm a little confused how I'd know where to take the spinlock? E.g. for
>> inserting entries in the tree I use mas_store_gfp() with GFP_KERNEL.
> 
> Lockdep will shout at you if you get it wrong ;-)  But you can safely
> take the spinlock before calling mas_store_gfp(GFP_KERNEL) because
> mas_nomem() knows to drop the lock before doing a sleeping allocation.
> Essentially you're open-coding mtree_store_range() but doing your own
> thing in addition to the store.
> 

As already mentioned, I went with your advice to just take the maple 
tree's internal spinlock within the GPUVA manager and leave all the 
other locking to the drivers as intended.

However, I run into the case that lockdep shouts at me for not taking 
the spinlock before calling mas_find() in the iterator macros.

Now, I definitely don't want to let the drivers take the maple tree's 
spinlock before they use the iterator macro. Of course, drivers 
shouldn't even know about the underlying maple tree of the GPUVA manager.

One way to make lockdep happy in this case seems to be taking the 
spinlock right before mas_find() and drop it right after for each iteration.

What do you advice to do in this case?

Thanks,
Danilo

