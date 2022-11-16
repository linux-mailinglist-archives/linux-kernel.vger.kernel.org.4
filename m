Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212B62B63B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiKPJRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiKPJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C5F63A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668590155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lXB7geeDOHGl0xlPBQdCp9G9AIuT+xoszozZAW+zE8Q=;
        b=fVDz5n9h4FfwTD2VpYIKPhPIrtueu7p00eXLJ9uNHU+RvtsJ+X4l5VxDWinbh7zGzFb1UZ
        dBPuge7Io3mFUgd3mnZCa68LEZNTKl+ZfUf3t7NxHSIQ01PSFaAbU1mxOY1H2c8YJfADRq
        8OYz9sQYybF4RJ6UK/66M3qONrF8Gqc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-dIuxcO3vOyWzUZUknMUIHw-1; Wed, 16 Nov 2022 04:15:52 -0500
X-MC-Unique: dIuxcO3vOyWzUZUknMUIHw-1
Received: by mail-wr1-f72.google.com with SMTP id i12-20020adfaacc000000b0023cd08e3b56so3488269wrc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 01:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lXB7geeDOHGl0xlPBQdCp9G9AIuT+xoszozZAW+zE8Q=;
        b=794dkbuBsZ+XmaUAzcfyr9VAOr8fD9pX1XowENchqafrcNoRa0r4oee6nchmgfKWkU
         2f/Xljkke8s1F5TXNeM/GMnfDcjI/wfjoJ+tVjELwbmbV+xIAgJ51JJPDH1Vt3uv68yh
         Q415MFqRyUABuXWXAb3zcVRsgHJL30X8c4oCFcW4MfYngOyZWGSAZbm66Bos5f0lY/7k
         BZrRS4GNwSblzPV489dd9J4FhM4ikhnTyxhwu2jw/nN/Y1uqDcSl6JzHU5LjYbNNt82p
         4Lg/4eSau1+wy4oxINgpI5tkXySomve9hIO6xVY0G/l1yGPLCvVlthuFWxVmmDQ1uqGt
         GKBw==
X-Gm-Message-State: ANoB5pmd1Rts8JhU021Rq3FjZNjf8puglEURFJsPmY4T12hOoRdLy6Tl
        5/A4c8Qid6OmtSB/rZIWpfvJcaw38r50MMvgHhBOexfXlF1AzbkaJ7kO/ojRf3B/rB/6Ud2xPFH
        xwYGrFsx28sM2bhXKxdRXOhw8
X-Received: by 2002:adf:ba8a:0:b0:241:a825:205c with SMTP id p10-20020adfba8a000000b00241a825205cmr723883wrg.40.1668590151410;
        Wed, 16 Nov 2022 01:15:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5q1YiQuRZuDh0m/3hidhum4BE2NmI2J9RofCm2nmoGqmv7HNMCAG+OXViUb83JQKL/H5aWnA==
X-Received: by 2002:adf:ba8a:0:b0:241:a825:205c with SMTP id p10-20020adfba8a000000b00241a825205cmr723867wrg.40.1668590151028;
        Wed, 16 Nov 2022 01:15:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id n126-20020a1c2784000000b003b95ed78275sm1350756wmn.20.2022.11.16.01.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 01:15:50 -0800 (PST)
Message-ID: <bf27a35f-e568-f8e3-6aa9-45b129db0b09@redhat.com>
Date:   Wed, 16 Nov 2022 10:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/4] mm: introduce 'encoded' page pointers with embedded
 extra bits
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20221109203051.1835763-1-torvalds@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221109203051.1835763-1-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.22 21:30, Linus Torvalds wrote:
> We already have this notion in parts of the MM code (see the mlock code
> with the LRU_PAGE and NEW_PAGE bits), but I'm going to introduce a new
> case, and I refuse to do the same thing we've done before where we just
> put bits in the raw pointer and say it's still a normal pointer.
> 
> So this introduces a 'struct encoded_page' pointer that cannot be used
> for anything else than to encode a real page pointer and a couple of
> extra bits in the low bits.  That way the compiler can trivially track
> the state of the pointer and you just explicitly encode and decode the
> extra bits.
> 
> Note that this makes the alignment of 'struct page' explicit even for
> the case where CONFIG_HAVE_ALIGNED_STRUCT_PAGE is not set.  That is
> entirely redundant in almost all cases, since the page structure already
> contains several word-sized entries.
> 
> However, on m68k, the alignment of even 32-bit data is just 16 bits, and
> as such in theory the alignment of 'struct page' could be too.  So let's
> just make it very very explicit that the alignment needs to be at least
> 32 bits, giving us a guarantee of two unused low bits in the pointer.
> 
> Now, in practice, our page struct array is aligned much more than that
> anyway, even on m68k, and our existing code in mm/mlock.c obviously
> already depended on that.  But since the whole point of this change is
> to be careful about the type system when hiding extra bits in the
> pointer, let's also be explicit about the assumptions we make.
> 
> NOTE! This is being very careful in another way too: it has a build-time
> assertion that the 'flags' added to the page pointer actually fit in the
> two bits.  That means that this helper must be inlined, and can only be
> used in contexts where the compiler can statically determine that the
> value fits in the available bits.
> 
> Link: https://lore.kernel.org/all/Y2tKixpO4RO6DgW5@tuxmaker.boeblingen.de.ibm.com/
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

