Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D871C69D24E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjBTRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjBTRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E4B1DB8F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676915143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0Izq1sT8yQqR3StJyRIa9aUpeGU1pXLanSYRIGX2E8=;
        b=i6Gquehn/na+E1+cR772Pwl8cY9jFWi4zwlqLIVRnaR8GgKzAsFHHCW7/H24liF1gIdOXm
        uXEokRS5FWvCmHMyoPC4YYq+7KRyGl7dEHT4dgYRbxhLFMHGoLLyC5NRm481bqYSu9ARXi
        GDIodAvYAgZ5O5y8M5xwmxYegVStVz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-ypJX01bVOTmB--iAQMmQ8Q-1; Mon, 20 Feb 2023 12:45:41 -0500
X-MC-Unique: ypJX01bVOTmB--iAQMmQ8Q-1
Received: by mail-ed1-f72.google.com with SMTP id cz22-20020a0564021cb600b004a245f58006so2866113edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:45:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0Izq1sT8yQqR3StJyRIa9aUpeGU1pXLanSYRIGX2E8=;
        b=psedNHAizEFDWngNfI2Q45gX5gyTGDb5PTxovL3G4yKW0DfLzn/6RRM4qRy6UceQLk
         mf6U7HlF76dGJsCBzNUGDUnHZQdvIZf1gArCQiD+Txd4MwVm/KULKPq0E/wjKY7TeS2v
         Zj0lse8afv3jR5d+wBp4bfYH2uy1oWgV1zDkyUAWlPrSJ2Se2rfsQvU0LcfpP6HpEIWk
         MenB4D7bqt1f+9Mlrue+3CwnIBejZXdP0zDg/8j6BquKwYN8n9RRE8LapyVI8/iF3CCI
         SXIDw8HBRfm/D7OOTnFpPuhhIpD/j595tCIrXoWanaDdJw+tZBdrG40NVCxLBWRt4A4Z
         4MqA==
X-Gm-Message-State: AO0yUKVcHD7IcC5jf6Z1Q8Bjo5k3UAMShyZHwCy+zptyxDC4/KhDFa00
        7PiaX3JPC7pUs2Y5cSOVPrfoCN61HyvntJ+VFLahqi4HF7aPsWWEIShbDOzn9BnEg5TVfJI9r2k
        yZk+42kvaYi3/PgaKImzba8E4
X-Received: by 2002:a17:907:94c5:b0:8b1:319c:c29c with SMTP id dn5-20020a17090794c500b008b1319cc29cmr13659855ejc.70.1676915140665;
        Mon, 20 Feb 2023 09:45:40 -0800 (PST)
X-Google-Smtp-Source: AK7set/Ga6rG3Eq1hZqRFlC9SxeuFv04ZCxlmBzWk9HFcUACYcpXem95hxGHCYiEqsp+Ho5tDk/t+w==
X-Received: by 2002:a17:907:94c5:b0:8b1:319c:c29c with SMTP id dn5-20020a17090794c500b008b1319cc29cmr13659833ejc.70.1676915140411;
        Mon, 20 Feb 2023 09:45:40 -0800 (PST)
Received: from ?IPV6:2a02:810d:4b3f:de78:642:1aff:fe31:a15c? ([2a02:810d:4b3f:de78:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906561500b008d09b900614sm1826220ejq.80.2023.02.20.09.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 09:45:39 -0800 (PST)
Message-ID: <e43f6acc-175d-1031-c4a2-67a6f1741866@redhat.com>
Date:   Mon, 20 Feb 2023 18:06:03 +0100
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
From:   Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <Y/ONYhyDCPEYH1ml@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 16:10, Matthew Wilcox wrote:
> On Mon, Feb 20, 2023 at 03:00:59PM +0100, Danilo Krummrich wrote:
>> On 2/17/23 20:38, Matthew Wilcox wrote:
>>> On Fri, Feb 17, 2023 at 02:44:10PM +0100, Danilo Krummrich wrote:
>>>> Generic components making use of the maple tree (such as the
>>>> DRM GPUVA Manager) delegate the responsibility of ensuring mutual
>>>> exclusion to their users.
>>>>
>>>> While such components could inherit the concept of an external lock,
>>>> some users might just serialize the access to the component and hence to
>>>> the internal maple tree.
>>>>
>>>> In order to allow such use cases, add a new flag MT_FLAGS_LOCK_NONE to
>>>> indicate not to do any internal lockdep checks.
>>>
>>> I'm really against this change.
>>>
>>> First, we really should check that users have their locking right.
>>> It's bitten us so many times when they get it wrong.
>>
>> In case of the DRM GPUVA manager, some users might serialize the access to
>> the GPUVA manager and hence to it's maple tree instances, e.g. through the
>> drm_gpu_scheduler. In such a case ensuring to hold a lock would be a bit
>> pointless and I wouldn't really know how to "sell" this to potential users
>> of the GPUVA manager.
> 
> This is why we like people to use the spinlock embedded in the tree.
> There's nothing for the user to care about.  If the access really is
> serialised, acquiring/releasing the uncontended spinlock is a minimal
> cost compared to all the other things that will happen while modifying
> the tree.

I think as for the users of the GPUVA manager we'd have two cases:

1) Accesses to the manager (and hence the tree) are serialized, no lock 
needed.

2) Multiple operations on the tree must be locked in order to make them 
appear atomic.

In either case the embedded spinlock wouldn't be useful, we'd either 
need an external lock or no lock at all.

If there are any internal reasons why specific tree operations must be 
mutually excluded (such as those you explain below), wouldn't it make 
more sense to always have the internal lock and, optionally, allow users 
to specify an external lock additionally?

> 
>>> Second, having a lock allows us to defragment the slab cache.  The
>>> patches to do that haven't gone anywhere recently, but if we drop the
>>> requirement now, we'll never be able to compact ranges of memory that
>>> have slabs allocated to them.
>>>
>>
>> Not sure if I get that, do you mind explaining a bit how this would affect
>> other users of the maple tree, such as my use case, the GPUVA manager?
> 
> When we want to free a slab in order to defragment memory, we need
> to relocate all the objects allocated within that slab.  To do that
> for the maple tree node cache, for each node in this particular slab,
> we'll need to walk up to the top of the tree and lock it.  We can then
> allocate a new node from a different slab, change the parent to point
> to the new node and drop the lock.  After an RCU delay, we can free the
> slab and create a larger contiguous block of memory.
> 
> As I said, this is somewhat hypothetical in that there's no current
> code in the tree to reclaim slabs when we're trying to defragment
> memory.  And that's because it's hard to do.  The XArray and maple
> tree were designed to make it possible for their slabs.
> 

