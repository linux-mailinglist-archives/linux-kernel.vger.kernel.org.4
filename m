Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B0704E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjEPMzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjEPMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:55:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D5710E9
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684241649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1qCVHKGyMmBkvSwj8jD8xadePPBV5y07Cbb6BpzJk0=;
        b=Zgwm51tOF6qF5R+L7vYQrrmPDCPvxlhgrTSgAssf6ss2DSDANa6855eACrWq2kUWPtYHV0
        HOrsdjBtOaGXNSj48IjbHVqPCUWiSC1wJ00q3ei9qF9fXnUJAHwjGpRED3lKH/6s86V4fa
        FP1+M+s8/oHX5TyC2NwcrSm9Bau4+aQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-RW7tYTAkNYWZfoHTgdVyfA-1; Tue, 16 May 2023 08:54:07 -0400
X-MC-Unique: RW7tYTAkNYWZfoHTgdVyfA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f433a2308bso19053715e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241647; x=1686833647;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1qCVHKGyMmBkvSwj8jD8xadePPBV5y07Cbb6BpzJk0=;
        b=LAMU9HSCTIdz6BDVwPvkZE6pF7q88m8qQDWrtoTcGNK/45erYTBCuD2zgGkuvjUYtj
         nJ1jd5pL7VU8WXFks8gUKf+9TfzKh5uV/yJyPp/8kBzou3+rPRObUZhncsxieHOMuANi
         /jKRsjKhY51SCM/D2y1rDBkcxKiaksWsIiRIZIUtu4FBXSApUKK1vzWjEqq+WzpeFtdN
         QP9ucSxQudZfX/MZqHuzuoOb3T5Ij9SR0WGXnCevxH+w2+WcZcSXAt1PPrjArST28ltm
         hCILSKYncKpHHk0BMfmdLSLJIFuB8EEKEi9lonQsRaat4mBBspPuGdfZnefLMTYQJKUC
         4i3g==
X-Gm-Message-State: AC+VfDyCLOx2L3Alo49eR10pZN+1noZKIzQtkoSFSMycAPIFme/aAgZ5
        JGZzSZRUuzSXRsPxqn8ShGFbB1guQbaJElHUZFzcnJblUqFqbojTZVEtzZGHGIQ+LvGfrPrrh46
        Ikgw/aMlC6gg5eVoIDKvOaUrO/Me7LiAL
X-Received: by 2002:adf:feca:0:b0:2fb:92c7:b169 with SMTP id q10-20020adffeca000000b002fb92c7b169mr29878253wrs.10.1684241646773;
        Tue, 16 May 2023 05:54:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E3HQhNNLuXMmrsn3WJ8GykAt/5MVJ7LuTbKLv8blwYpd6a7g3VYLzeJsCM48zuxrgXN/dEQ==
X-Received: by 2002:adf:feca:0:b0:2fb:92c7:b169 with SMTP id q10-20020adffeca000000b002fb92c7b169mr29878230wrs.10.1684241646425;
        Tue, 16 May 2023 05:54:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003f07ef4e3e0sm34062325wmo.0.2023.05.16.05.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:54:06 -0700 (PDT)
Message-ID: <c60d3aa9-f8cd-6c78-3004-8017d7c95443@redhat.com>
Date:   Tue, 16 May 2023 14:54:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] mm: page_table_check: Ensure user pages are not
 slab pages
Content-Language: en-US
To:     Ruihan Li <lrh2000@pku.edu.cn>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20230515130958.32471-1-lrh2000@pku.edu.cn>
 <20230515130958.32471-5-lrh2000@pku.edu.cn>
 <CA+CK2bBD_fdmz1fFjB8MXBGMHf4jzRWeBRirH3HdWRLqY7cmtw@mail.gmail.com>
 <mgnjfbklr6ew7p4utamdidrvdtchaazovfuduaabplwtpq3se2@uamamaee3rlk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <mgnjfbklr6ew7p4utamdidrvdtchaazovfuduaabplwtpq3se2@uamamaee3rlk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 13:51, Ruihan Li wrote:
> On Mon, May 15, 2023 at 12:28:54PM -0400, Pasha Tatashin wrote:
>>
>> On Mon, May 15, 2023 at 9:10 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
>>>
>>> The current uses of PageAnon in page table check functions can lead to
>>> type confusion bugs between struct page and slab [1], if slab pages are
>>> accidentally mapped into the user space. This is because slab reuses the
>>> bits in struct page to store its internal states, which renders PageAnon
>>> ineffective on slab pages.
>>>
>>> Since slab pages are not expected to be mapped into the user space, this
>>> patch adds BUG_ON(PageSlab(page)) checks to make sure that slab pages
>>> are not inadvertently mapped. Otherwise, there must be some bugs in the
>>> kernel.
>>>
>>> Reported-by: syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/lkml/000000000000258e5e05fae79fc1@google.com/ [1]
>>> Fixes: df4e817b7108 ("mm: page table check")
>>> Cc: <stable@vger.kernel.org> # 5.17
>>> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
>>
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>
>> I would also update order in mm/memory.c
>> static int validate_page_before_insert(struct page *page)
>> {
>> if (PageAnon(page) || PageSlab(page) || page_has_type(page))
>>
>> It is not strictly a bug there, as it works by accident, but
>> PageSlab() should go before PageAnon(), because without checking if
>> this is PageSlab() we should not be testing for PageAnon().
> 
> Right. Perhaps it would be better to send another patch for this
> separately.

Probably not really worth it IMHO. With PageSlab() we might have 
PageAnon() false-positives. Either will take the same path here ...

On a related note, stable_page_flags() checks PageKsm()/PageAnon() 
without caring about PageSlab().

At least it's just a debugging interface and will indicate KPF_SLAB in 
any case as well ...

-- 
Thanks,

David / dhildenb

