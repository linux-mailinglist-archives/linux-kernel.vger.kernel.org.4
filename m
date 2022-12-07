Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA664623A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiLGUP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiLGUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4CE6DCF2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670444066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NwhTHbbeviWH0KrB78oH/LTS3J/aYRYFLjpGDACvYxQ=;
        b=jN/ba4onri330YoCiFckZBHnXuaQWrj1XMffCbziL52MGSjsmKELFiyy5vp2M//B5+CKQ3
        6breuLRQ3prE8OQ9oGQ+1R11Ka8ZjCaQo6EgLV0BWmHRoPCLXYSxeFpYtXBi8bXc+xRLUQ
        /9NfarbG40nLtwwZn8GjOtQTve/1Iw8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-0-yPqorCOiaSdYjxgbu6sA-1; Wed, 07 Dec 2022 15:14:24 -0500
X-MC-Unique: 0-yPqorCOiaSdYjxgbu6sA-1
Received: by mail-qk1-f198.google.com with SMTP id m3-20020a05620a24c300b006fee2294e97so4704878qkn.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwhTHbbeviWH0KrB78oH/LTS3J/aYRYFLjpGDACvYxQ=;
        b=D4LYldDE1Pss5bQkKWNwZGulHIjmkwrXzVrt2FtioKxUsYqSQlUmZ1pRgeSUIgAR/g
         PHzTl4hRv/wNQFuGAEY5tqZ/29cAMttLsbwuDpcy69ESpL/rGQ1PXgamtpYJcxCL9I+I
         0OBgl93AXOmhtShf7OikdQbiSNBrQcrBPzJY5xBnlTCR8TASouKDaNhlGBj2VJHTTM+x
         5UkgkFZ080V1i/s8DKJE/pvWu5DpviKDREBO9KG9nOAJHu6zuiaYcplAkrhAtyRM8+Fq
         N1oUrS/yxyknsEi52DgFep1XIkqyLLadLtdByYVuqhsvElllRzLXgc31Qni82dhmQH06
         RNSQ==
X-Gm-Message-State: ANoB5plwbvCuQFJVVQBdsOBH5fAtB7EdIsm7NQvp/mESx5d5TpL/x2Ee
        wo7XpEW9TRMIFySKSTDbna9/ZRrKg6do4MhH6xok8tMqJy5YI7AG0e+WDkQGxHHj5U5LsCzoA40
        gsRXSkwxRKJxS84OgAhHH3GJh
X-Received: by 2002:a05:622a:418e:b0:3a6:50d6:9d83 with SMTP id cd14-20020a05622a418e00b003a650d69d83mr1603202qtb.65.1670444064223;
        Wed, 07 Dec 2022 12:14:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4SSNd44QhqnnNZ0i6AennrIOirgtTvrJFr6Mu7McdEgQfXGHu8jvVW9mOcJnUEYSAhNsEucw==
X-Received: by 2002:a05:622a:418e:b0:3a6:50d6:9d83 with SMTP id cd14-20020a05622a418e00b003a650d69d83mr1603193qtb.65.1670444063944;
        Wed, 07 Dec 2022 12:14:23 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id x16-20020ac87a90000000b003a5fb681ae7sm13845182qtr.3.2022.12.07.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:14:23 -0800 (PST)
Date:   Wed, 7 Dec 2022 15:14:22 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ives van Hoorne <ives@codesandbox.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH RFC] mm/userfaultfd: enable writenotify while
 userfaultfd-wp is enabled for a VMA
Message-ID: <Y5D0HsBAfQiswoKV@x1n>
References: <Y4oo6cN1a4Yz5prh@x1n>
 <690afe0f-c9a0-9631-b365-d11d98fdf56f@redhat.com>
 <19800718-9cb6-9355-da1c-c7961b01e922@redhat.com>
 <Y45duzmGGUT0+u8t@x1n>
 <92173bad-caa3-6b43-9d1e-9a471fdbc184@redhat.com>
 <22d8e8ac-d75-a66-2650-b4d59f89855e@google.com>
 <Y4+xpCRQCazCymdS@x1n>
 <be1a2244-24a8-480a-a38b-e4ebb9868ce5@redhat.com>
 <Y5DQrHqc7RPYWpIA@x1n>
 <37a9442e-f6e5-35f5-0d51-669d60936b5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37a9442e-f6e5-35f5-0d51-669d60936b5f@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 08:53:36PM +0100, David Hildenbrand wrote:
> Once user space successfully placed an uffd-wp marker, and e.g., verified
> using pagemap that it is indeed placed, the system should not silently drop
> it.

Note that the anon path doesn't use pte markers.  We won't lose a pte
marker, hopefully, if we do that's a more severe one.

> 
> The behavior between an ordinary THP and a huge zeropage differs. For THP,
> we handle the split correctly and don't lose the marker. Assuming the huge
> zeropage woud be disabled, the behavior would be (IMHO) correct. The test
> case would pass.
> 
> For example, QEMU with uffd-wp based snapshotting will make sure that all
> virtual addresses are populated (e.g., mapping the shared, eventually the
> huge zeropage -- populate_read_range()), before protecting using uffd-wp.
> Losing a uffd-wp marker would be problematic.
> 
> The good news is that we barely will end up PTE-mapping the huge zeropage
> unless there is real user-space interaction (mprotect(), mremap(), mmap()),
> so this shouldn't trigger in the QEMU use-case.

Ah yes, I forgot that part.  If it's not affected then it's better.

> 
> 
> Anyhow, I'll send a patch in a couple of days and we can discuss further.
> It's independent of the other discussion, just wanted to report my findings
> after staring at that code for way too long today.

Thanks, that works for me.

-- 
Peter Xu

