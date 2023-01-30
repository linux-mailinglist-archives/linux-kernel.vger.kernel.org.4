Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAD6809A5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjA3Jgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjA3JgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:36:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA36E97
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675071248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZBa2j5w5VmTxoXeZN6pIQHokSULsJGUutfpb9iRbKg=;
        b=Cj6oumLuqn+8FtRPc/jqJ2fprsvBZZM1+HlAL2FVE0Iyv/X0NnGfS3kN7Rk2zii+xUepLQ
        gaHFICBpmhfrsAul5YFARPiA6HCPxIFYATywekZRzHtSAicwVhx46d00288OtEn498EZoz
        1WVBGmQhQW0VnARx+sFTeFseYQGw9Vk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-139-9zldTsJlNJC7Mkv-0k5dJw-1; Mon, 30 Jan 2023 04:34:06 -0500
X-MC-Unique: 9zldTsJlNJC7Mkv-0k5dJw-1
Received: by mail-wm1-f69.google.com with SMTP id bg24-20020a05600c3c9800b003db0ddddb6fso6935184wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZBa2j5w5VmTxoXeZN6pIQHokSULsJGUutfpb9iRbKg=;
        b=uabMJ5neQiRIZZTOuex8CciZLWYFZPx6EOQyLNOaKbfqSJp2DEOKWdUxb80hydqI54
         P2ZO7T8pQYveswmZecX7jVXPK/lXOBVV55BnGo/rugHy4CnWLNgsV5bpS47PVtvdFZvp
         57fPn9GAltJCHdSC4T72lI9xtHYNC3DRQ58bEywF9QQCwurkpe0UJYJU+/gk65MzRYOP
         hzJUeIdmBPWuXzI1XdvuDlt3jgFV6HAArnPAsso0T3GiJlnKBBPPQUHtYT3xQm2rQHu/
         m/qu/u01F+JFcvDqe3JPMjtT7ujfgcddD7JcUHwGpwTDOG7toib4QEDJkx4Pe2k+VeOA
         92sw==
X-Gm-Message-State: AFqh2kr6OAf6loWFHgZpoYsYQi/OuDg0rc064gT5grOez6b7l5flsjO2
        VXkjW2aYvrjmaqSuIRnq0KSwVhShlh/w6L+RsjIaQ0eezYEni1YO1e+bYqepZq95gmhpoD1+lLs
        XrsJgY73YJ6hSIwUQ0m7SyTIb
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr41224867wmb.24.1675071245395;
        Mon, 30 Jan 2023 01:34:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs8CPbJeo9uICPC118QZYTBM2/cXjvJCRyO3hbTHbg4rM7/jignjWmKfZCd+ardw1+b87WHjg==
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr41224837wmb.24.1675071245000;
        Mon, 30 Jan 2023 01:34:05 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id h20-20020a05600c351400b003dc1300eab0sm17270274wmq.33.2023.01.30.01.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 01:34:04 -0800 (PST)
Message-ID: <bbd6857a-1303-34ac-9d1b-f61a540ea796@redhat.com>
Date:   Mon, 30 Jan 2023 10:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Content-Language: en-US
To:     Jane Chu <jane.chu@oracle.com>,
        Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
 <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
 <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
 <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
 <3a6af06a-729d-7659-50b0-8b242b555134@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <3a6af06a-729d-7659-50b0-8b242b555134@oracle.com>
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

On 28.01.23 01:48, Jane Chu wrote:
> On 1/26/2023 12:37 AM, David Hildenbrand wrote:
>> On 25.01.23 23:09, Vishal Moola wrote:
> [..]
>>
>> The issue is that we're not estimating the mapcount of the folio, so the
>> name is very misleading ... I think you really want to avoid the term
>> mapcount completely in that context. We're just using the #mappings of
>> the first subpage to determine something differently.
>>
>> Thinking about it, I guess "folio_estimated_sharers()" might be what we
>> actually want to name it. Then you can comment how we estimate sharers
>> by looking at into how many page tables the first subpage is currently
>> mapped, and assume the same holds true for the other subpages.
>>
>> It's unreliable because other subpages might behave differently, we
>> might not be holding the pagelock to stabilize, and we're not looking at
>> indirect mappings via the swapcache. But it's a comapratively good
>> estimate for most scenarios I guess.
>>
> 
> Hmm, how about simply call it folio_hpage_mapcount(),
> folio_firstpage_mapcount(), or, folio_cover_mapcount() ?

All not better IMHO.

folio_estimated_subpage_mapcount() is a bit too verbose for my taste and ...

> 
> It is used to replace page_mapcount() in that sense -
> https://lore.kernel.org/linux-mm/Y9MDJuPWsk9820xD@x1n/T/#me0531cfb9e82ad5ca88804c727d69cc6b9b33ffa
> 
> 	if (flags & (MPOL_MF_MOVE_ALL) ||
> 	    (flags & MPOL_MF_MOVE && folio_estimated_mapcount(folio) == 1 &&
> 	     !hugetlb_pmd_shared(pte))) {
> 		if (isolate_hugetlb(folio, qp->pagelist) &&

... what we want to have here is an estimation on the number of sharers. 
[actually, we would want it precise, but that's hard to achieve ... ]

-- 
Thanks,

David / dhildenb

