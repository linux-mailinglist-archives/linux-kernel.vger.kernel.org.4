Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EF6B7749
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCMMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCMMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318D928E46
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678709689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dE2wMx+vOCRMCJzU8QhzPuFSW9hg2epgPnZ1mTuHG5s=;
        b=Pkodg2Ayp4xSj5zyy/mlIVMUjZtzgOSy6SSol8HuBe6sOx/571xwWRJMH5D3ZF+qqkykzU
        fqsQqfW2O/CGBOktqkUXWF5vO/zjEmJL/ZPTCeE2A+7VA1hvVby4Prl1IzmiFSUchRCEJO
        tABbhSjy4oes9BASp556qlEzViZ+uUg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-6NNVD1FrO4O60oHQky1O6A-1; Mon, 13 Mar 2023 08:14:48 -0400
X-MC-Unique: 6NNVD1FrO4O60oHQky1O6A-1
Received: by mail-wr1-f70.google.com with SMTP id y11-20020a056000168b00b002ce179d1b90so2080262wrd.23
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 05:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709687;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE2wMx+vOCRMCJzU8QhzPuFSW9hg2epgPnZ1mTuHG5s=;
        b=f51KYWUm2GM+tBmHajrxng+XPvVJ3y0F0FCwqDf2u3rfVGJ+Mvp9Po9ZLF+YA5GHxV
         oBgZkmMjYy2eHaCwe7t9zWI/276eqKtMzVdNFf+r2mybE8aXQaeYqljSMxYrPG8v3Jqa
         +ChkIRiRrpta4whBVJqkBVa7i15CTGWwNVUJ8MilHOJBql3dMk/OlbFJ4ynXjxLleZo9
         qJPQtAR/yuP5Tf+QpGwgULRp6z2SPnZTC2v4juZhYVqV7vKurzJ2KX2pSP4iUQE67tlO
         gyDiHxMp1guXFpJl/apsGnBTOCDMhvs6EgSGJb1CnrktOSXmQU7VQ5RGDL+NnHOeY4Ll
         TA3A==
X-Gm-Message-State: AO0yUKUyA+5dIX9rI4nXrklHNjuqr0b8C5qN4ZHcnn0c1dxBKIZEsxDm
        Qy6V31XB6144zeAcsEfYKxwQJQux8zy5XgQS/LNy5Z5z5d3PV/xb0Dp3hmj15Ybs1OAMUQ9WuXH
        sb13jt88aujmo9sDDwsrKksyF
X-Received: by 2002:a05:600c:a46:b0:3ed:276d:81a4 with SMTP id c6-20020a05600c0a4600b003ed276d81a4mr1675615wmq.32.1678709687283;
        Mon, 13 Mar 2023 05:14:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set8lzXeR+ODY2orSeSnL+3trKbHmDkj5bzj07VpDCsFskMxLnm9fmRcrxbhJil+xgOtDy8/COw==
X-Received: by 2002:a05:600c:a46:b0:3ed:276d:81a4 with SMTP id c6-20020a05600c0a4600b003ed276d81a4mr1675591wmq.32.1678709686897;
        Mon, 13 Mar 2023 05:14:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:7500:9d5c:56ee:46c3:8593? (p200300cbc70175009d5c56ee46c38593.dip0.t-ipconnect.de. [2003:cb:c701:7500:9d5c:56ee:46c3:8593])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b003e209186c07sm9975728wms.19.2023.03.13.05.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:14:46 -0700 (PDT)
Message-ID: <50dd030c-95a5-7bd0-bd93-1a5777923669@redhat.com>
Date:   Mon, 13 Mar 2023 13:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/6] ksm: support unsharing zero pages placed by KSM
Content-Language: en-US
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin16@zte.com.cn,
        yang.yang29@zte.com.cn
References: <david@redhat.com> <20230311053714.178439-1-xu.xin16@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230311053714.178439-1-xu.xin16@zte.com.cn>
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

On 11.03.23 06:37, xu xin wrote:
> [sorry to reply so late, on vacation too, and my mailing system has some kind of problem]
> 
>> [sorry, was on vacation last week]
> 
>>> Why use flags if they both conditions are mutually exclusive?
>>
>> Just to make the return value of break_ksm_pmd_entry() more expressive and
>> understandable. because break_ksm_pmd_entry have three types of returned
>> values (0, 1, 2).
> 
>> It adds confusion. Just simplify it please.
> 
> So I think it's good to add a enum value of 0 listed here as suggested
> by Claudio Imbrenda.
> 

Please keep it simple.

>>
>>> MADV_UNMERGEABLE -> unmerge_ksm_pages() will never unshare the shared
>>> zeropage? I thought the patch description mentions that that is one of
>>> the goals?
>>
>> No, MADV_UNMERGEABLE will trigger KSM to unshare the shared zeropages in the
>> context of "get_next_rmap_item() -> unshare_zero_pages(), but not directly in the
>> context of " madvise()-> unmerge_ksm_pages() ". The reason for this is to avoid
>> increasing long delays of madvise() calling on unsharing zero pages.
>>
> 
>> Why do we care and make this case special?
> 
> Yeah, the code seems a bit special, but it is a helpless way and best choice, because the
> action of unsharing zero-pages is too complex and CPU consuming because checking whether the
> page we get is actually placed by KSM or not is not a easy thing in the context of
> unmerge_ksm_pages.
> 
> In experiment, unsharing zero-pages in the context of unmerge_ksm_pages cause user' madvise()
> spend 5 times the time than the way of the current patch.

Who exactly cares  and why?

> 
> So let's leave it as it is now. I will add a (short) explanation of when and why the new
> unshare_zero_page flag should be used.

I vote to keep it as simple as possible in the initial version.

-- 
Thanks,

David / dhildenb

