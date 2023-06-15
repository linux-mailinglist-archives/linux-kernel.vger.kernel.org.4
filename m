Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632C0731BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbjFOOrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbjFOOrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E1E2736
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686840378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PnLmUoyxNluv5/vtd5/0yWU5N0tz3la7jPxFVnmntV4=;
        b=IVzHVIuLx9AQLUe9+2L6Nf83tAaBlw54EcWz577mnSGfjYG3uVO1gsLX7RDZT+yXoBBgGK
        wqz533YPY/y3+HyyF4r+NMDFz1eJTiM/71DLSZjwk99ve6ae3pA4KtzkA8u9VjofWwVzuA
        xMt/6wIyjJCrgacpUcBjfykT/8zsIX8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YsJKObiVNc-3GXa-PotTyw-1; Thu, 15 Jun 2023 10:46:13 -0400
X-MC-Unique: YsJKObiVNc-3GXa-PotTyw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b1bbe83720so18271741fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840372; x=1689432372;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnLmUoyxNluv5/vtd5/0yWU5N0tz3la7jPxFVnmntV4=;
        b=TrxjQ5yFa+G3yD4PMHSe/zRXn7C4BnKeNqO81polW0IT5vnhjZB3jq0xWs/Kx5G4RR
         mYKLt3KNKND2OEEBNIFSGj1EnJ9IdChRCnB/n/+cDy/+p5BpeAc+4M4IAee6DTwCsxOr
         UlFevEpEkFuBY/y236N5//sOsnR6+1PNSXtLSp4dKkXnC9MqvgAhT1I+zwGRaLov1ViK
         rBRABxhjEKnPuK29TtIkocb7AZw7spBCEJZOtf4jCi8g60KX5YtU6vsSW1j7d8LRWRc3
         d76hFHlpBdTOz7cO7jv7RleJk7WshR2qDkeseAdgU4x3qY49Au6YyfNQfd/6KwpAspt2
         GSXQ==
X-Gm-Message-State: AC+VfDxiufxWVI8+nME1VnnCUV6sfAMAw1KUddYhMhuSxpPRc+qbj1kw
        h990SVj4gzByDv1CCxoOL7dn0R6BaPwc0uMWQNbOYATSajfTMqhNu+g6l0nFIkw/UWZkn96o2po
        Lf7cSk7tQtkfeOV/OFrCBS7i+
X-Received: by 2002:a19:6445:0:b0:4f6:1e9c:cb11 with SMTP id b5-20020a196445000000b004f61e9ccb11mr9778912lfj.14.1686840371889;
        Thu, 15 Jun 2023 07:46:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7+WZ4YUQntw7WMkLcw0eXfwK8H6yFwvqd4w86K2UmyLFpVgf58ZbzhUZDRymx842mwEr515Q==
X-Received: by 2002:a19:6445:0:b0:4f6:1e9c:cb11 with SMTP id b5-20020a196445000000b004f61e9ccb11mr9778896lfj.14.1686840371380;
        Thu, 15 Jun 2023 07:46:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:b500:4648:c96c:d6ba:4b8d? (p200300cbc70bb5004648c96cd6ba4b8d.dip0.t-ipconnect.de. [2003:cb:c70b:b500:4648:c96c:d6ba:4b8d])
        by smtp.gmail.com with ESMTPSA id m6-20020adfdc46000000b0030e5bd253aasm21293470wrj.39.2023.06.15.07.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:46:10 -0700 (PDT)
Message-ID: <290d79bb-b1a6-3146-76a7-9938829e6ebe@redhat.com>
Date:   Thu, 15 Jun 2023 16:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
 <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
 <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com>
 <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
 <bd119703-7b7b-c4ab-0c38-9b85809de252@redhat.com>
 <CACSyD1NfbD_YBADH-3bR0=sGkrkEqxfgYLvyNyTiWdTvw2R6vA@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
In-Reply-To: <CACSyD1NfbD_YBADH-3bR0=sGkrkEqxfgYLvyNyTiWdTvw2R6vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 15:40, 贺中坤 wrote:
>> I suspect for the swap->zram we should always get charged pages, because
>> we're effectively writing out charged anon/shmem pages only -- without
>> any buffer in between.
> 
> Hi David，the charged memory will be released in swap->zram. New pages
> are allocated by alloc_zspage(), and we did not charge the page directly，but
> the objects(like  slab), because the zspage are shared by any memcg.
> 
>>
>> For the fs->zram or direct zram access device case I'm not so sure. It
>> highly depends on what gets mapped into the bio (e.g., a kernel buffer,
>> zeropage, ...). If it's a pagecache page, that should be charged and
>> we're good. No so sure about fs metadata or some other fs cases (e.g.,
>> write() to a file that bypass the pagecache).
>>
> 
> Yes， the pagecaches are charged in fs->zram, but  will be released if
> we drop the cache. the compressed objects are not charged.

Yes. But just to stress again, one issue I see is that if there is a 
page in the BIO that is not charged, you cannot charge the compressed page.

Assume you have some FS on that zram block device and  you want to make 
sure it gets properly charged to whoever is reading/writing a file on 
that filesystem. (imagine something like a compress shmem)

If a user (or the filesystem?) can trigger a BIO that has an uncharged 
page in it, it would not get charged accordingly.

The "easy" reproducer would have been O_DIRECT write() using the shared 
zeropage, but zram_write_page() is smart enough to optimize for that 
case (page_same_filled()). :)

Maybe I'm over-thinking this (well, the we do have partial I/O support, 
so something seems to be able to trigger such cases), and it would be 
great if someone with more FS->BIO experience could comment.

I'll note that this is fundamentally different to zswap, because with 
zswap you don't get arbitrary BIOs, you get an anon or shmem page (that 
should be charged).

-- 
Cheers,

David / dhildenb

