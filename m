Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A223F6E5ECA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjDRKa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjDRKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB61B9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681813791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/WVe/7/OKmghxefKS6nQkLQJNjNIEtm/g7km3sbxUMI=;
        b=bGDr4vaHqgnvqC8OkDAJV7PjbBLiFXS8nE9pdQWK7iYpepaJtozN7Q2fz35m16kG5MOM/r
        fBWJjsBKMdP4RBZ5ejC1EXWNHPvoWUPyYlhdigdlkhXR5ROA7AFbEcaFj0MswqXc2hvBAv
        iZN7siz5dvs1EVBdIKoNSQTps1BK5v0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-aWTkdq45OnKDUHCIZ_Traw-1; Tue, 18 Apr 2023 06:29:44 -0400
X-MC-Unique: aWTkdq45OnKDUHCIZ_Traw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f065208a64so12851895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:29:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681813783; x=1684405783;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WVe/7/OKmghxefKS6nQkLQJNjNIEtm/g7km3sbxUMI=;
        b=aTBBIULFXhxC8H8jVpquRCd6ljQSjXlvbRpywGV4JIE6fBkz/NEH7L734hRRH++Eaa
         e4G/3DWA7KQ9ouztFzYsTig/yibrHhVedAGZ+kseMrKATIMZi1r6Sd6oWR4VAJPc0MTY
         yg131wZWGFmpCoC+DVwF4S4q9L/8ZH1rR6JjRaKVtRHVYaJ90uh7IR2+2k2WqHk1rrqz
         SaaaPAAENcASEBm5Ebhpi1R0fyOANdLyjFi5JYT6nB3c/oQyKwAmxoemt2e1kLb6DfJa
         xE8HNssHHdHFoKDwlG8iKuO+RwKgw5jD4YTmblIw/Hx3Go/fO2pKzwr2Qsdhhhydq7UI
         HzcQ==
X-Gm-Message-State: AAQBX9fW9xnKmUAANZlwc+DC4aXti/ICCuRzh7oXNFPlTjlfHdEsNLuE
        KfmgiZnkcwc2BpdHtSXjH/vaKDbsBnKXSGnJlZOMVVnp5aBdx2CKcN+flmoYsC0Bps3tUl7CltH
        5n3I2DqEyUA5puLpS+uDFCDxD
X-Received: by 2002:adf:f30d:0:b0:2f7:af3a:72fd with SMTP id i13-20020adff30d000000b002f7af3a72fdmr1467660wro.59.1681813783678;
        Tue, 18 Apr 2023 03:29:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zxg1+fvSmfIW+1kD2tgmPT7fUEB9YPbp5R/lSUC8reXHVDmWAT7newxKQPKKwoaA2tgk7thg==
X-Received: by 2002:adf:f30d:0:b0:2f7:af3a:72fd with SMTP id i13-20020adff30d000000b002f7af3a72fdmr1467646wro.59.1681813783300;
        Tue, 18 Apr 2023 03:29:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d5644000000b002f02df4c7a3sm12725811wrw.30.2023.04.18.03.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:29:42 -0700 (PDT)
Message-ID: <c1429e20-7462-dc73-766a-cf7b3d482c6d@redhat.com>
Date:   Tue, 18 Apr 2023 12:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/7] Split a folio to any lower order folios
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230403201839.4097845-1-zi.yan@sent.com>
 <20230404144727.e613116684dbd65a4b4745c1@linux-foundation.org>
 <49ee481e-452f-61c7-2da5-28de2cf3de2@google.com>
 <b37d1876-0a74-aa52-7911-e6f78280caaa@redhat.com>
 <8B784026-7C90-427D-91E2-2D551FA576D7@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8B784026-7C90-427D-91E2-2D551FA576D7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 21:26, Zi Yan wrote:
> On 17 Apr 2023, at 10:20, David Hildenbrand wrote:
> 
>> On 16.04.23 20:11, Hugh Dickins wrote:
>>> On Tue, 4 Apr 2023, Andrew Morton wrote:
>>>> On Mon,  3 Apr 2023 16:18:32 -0400 Zi Yan <zi.yan@sent.com> wrote:
>>>>
>>>>> File folio supports any order and people would like to support flexible orders
>>>>> for anonymous folio[1] too. Currently, split_huge_page() only splits a huge
>>>>> page to order-0 pages, but splitting to orders higher than 0 is also useful.
>>>>> This patchset adds support for splitting a huge page to any lower order pages
>>>>> and uses it during file folio truncate operations.
>>>>
>>>> This series (and its v1 & v2) don't appear to have much in the way of
>>>> detailed review.  As it's at v3 and has been fairly stable I'll queue
>>>> it up for some testing now, but I do ask that some reviewers go through
>>>> it please.
>>>
>>> Andrew, please don't let this series drift into 6.4-rc1.
>>>
>>> I've seen a bug or two (I'll point out in response to those patches),
>>> but overall I don't see what the justification for the series is: done
>>> because it could be done, it seems to me, but liable to add surprises.
>>>
>>> The cover letter says "splitting to orders higher than 0 is also useful",
>>> but it's not clear why; and the infrastructure provided seems unsuited
>>> to the one use provided - I'll say more on that truncation patch.
>>
>> I agree. Maybe this patch set is something we want to have in the future once actual consumers that can benefit are in place, such that we can show actual performance numbers with/without.
> 
> Ryan is working on large folio for anonymous pages and has shown promising performance
> results[1]. This patchset would avoid getting base pages during split if possible.
> 
Yes, I know. And it would be great to get some actual numbers 
with/without your patches to show that this optimization actually 
matters in practice.

Unrelated, your cover letter mentions "file folio truncate operations.". 
Would it also apply to FALLOC_FL_PUNCH_HOLE, when partially zapping a THP?

>>
>> Until then, "365 insertions(+), 68 deletions(-)" certainly needs some reasonable motivation.
> 
> Come on. 225 out of 365 insertions are self tests code. We need motivation to add
> testing code?

Well, if you add feature X and the tests target feature X, then 
certainly having the tests require the same motivation as feature X. But 
yeah, the actual kernel code change is smaller than it looks at first sight.

-- 
Thanks,

David / dhildenb

