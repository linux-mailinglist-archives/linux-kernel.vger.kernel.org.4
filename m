Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AA6615F64
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiKBJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiKBJQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296928718
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667380478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFG3X5y9S7va/OVhuAw/JvhOPfXEnrd2/y2bVN5C4mk=;
        b=UqmFpA3JF7wJJDbAySVLrR6x21z1Z+r6EOWRBcIbYEAHw152U6ekZvy5cAg54v06PjPvwi
        X48pP4fKgUiieOMkinJG/f5Lxd7RIX6Zok3+1U4u9Pt+kTP/OzeG1dwKjPrwlU00+3oAIc
        IdDwvPtuhlo1gd3IexKdfOoIgHvJRcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-451--z5JwHiMPx-AeJ3NYB54Hw-1; Wed, 02 Nov 2022 05:14:37 -0400
X-MC-Unique: -z5JwHiMPx-AeJ3NYB54Hw-1
Received: by mail-wm1-f69.google.com with SMTP id v188-20020a1cacc5000000b003cf76c4ae66so805141wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFG3X5y9S7va/OVhuAw/JvhOPfXEnrd2/y2bVN5C4mk=;
        b=PM9hNfLhSRlyF+RHOLlpLrROwP8t+itHMrk0SNyir1QpwBYXZvLk6PvVvxCb7GLYX/
         /UmtwGWhAVXPEA3EJQzgHb2/CJTOifEcXD5+FUUH+LNFCzhYjE8pFnmYxXyvs0kGUvmz
         PulD2Wu0CoSY8p8OUK6T7yJX49TYJhbdf2DvfPRVwkdv0oMg9/4ClBVObXUpPCiA6h7Y
         P7hZjglJwuWs1ilBl5UJ8jd6Yv3EWS1lgbp+vJrCRWA5lcv65PSTUg/Bgjw84UwLSah3
         HSkxmP4Yt+x4isdizz9Z84I25RsD/mVGUlhRtwDwMCXMPScXRNmALfM7GwvchfW8KT4A
         QqQQ==
X-Gm-Message-State: ACrzQf3NuXM1BWZX7pTChat6zo/tVGylAb1237F53vWMJWh5dnOoHAqh
        a77W7fBw1HXsN5gFTGcjb54l45BbqCUfKOOojgV1twvPxhpjG059CyZxnORBUVWOAdocTZl86i4
        IamHwR2JyVKJjP/o1gHp4ukGG
X-Received: by 2002:a5d:67cf:0:b0:236:6f36:6029 with SMTP id n15-20020a5d67cf000000b002366f366029mr14216094wrw.224.1667380475875;
        Wed, 02 Nov 2022 02:14:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5yHT6EACT7euGAbQbbD1Ul7ttmBJSp82YcXjpsu9Gih7KBgsTkA/cMIhPwxyCfSuN3zvrMMw==
X-Received: by 2002:a5d:67cf:0:b0:236:6f36:6029 with SMTP id n15-20020a5d67cf000000b002366f366029mr14216067wrw.224.1667380475623;
        Wed, 02 Nov 2022 02:14:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:f100:af38:1d1f:66f4:48c7? (p200300cbc705f100af381d1f66f448c7.dip0.t-ipconnect.de. [2003:cb:c705:f100:af38:1d1f:66f4:48c7])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d6e11000000b002356c051b9csm12188701wrz.66.2022.11.02.02.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:14:35 -0700 (PDT)
Message-ID: <13c0caee-82e9-c295-b1b4-6d2bff132b72@redhat.com>
Date:   Wed, 2 Nov 2022 10:14:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
In-Reply-To: <Y1/0e12ZJT6+N0kI@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.10.22 17:14, Jason Gunthorpe wrote:
> On Mon, Oct 31, 2022 at 04:25:24PM +0100, David Hildenbrand wrote:
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Reported-by: syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>
>> I assume this has been broken at least since 2014, when mm/gup.c came to
>> life. I failed to come up with a suitable Fixes tag quickly.
> 
> I'm worried this would break RDMA over hugetlbfs maps - which is a
> real thing people do.
> 
> MikeK do you have test cases?

This patch here only silences the warning. The warning+failing is 
already in 6.0, and so far nobody (besides syzbot) complained.

RDMA (due to FOLL_FORCE) would now fail (instead of doing something 
wrong) on MAP_PRIVATE hugetlb mappings that are R/O. Do we have any 
actual examples of such RDMA usage? I was able to understand why this 
case (MAP_PRIVATE, PROT_READ) is important for !hugetlb, but I don't 
immediately see under which situations this would apply to hugetlb.

While we could implement FOLL_FORCE for hugetlb, at least for RDMA we 
will be moving away from FOLL_FORCE instead --- I'll be posting these 
patches shortly.

So considering upcoming changes, at least RDMA is rather a bad excuse 
for more widespread FOLL_FORCE support.

-- 
Thanks,

David / dhildenb

