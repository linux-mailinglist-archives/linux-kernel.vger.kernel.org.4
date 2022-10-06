Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883DB5F63B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiJFJft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJFJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83826925B9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665048942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=go40zFr/9iiDvA5R+CukTDIZOFWbDoEwVAldJ/dw7HA=;
        b=YtMDQckcgqd5f7x89ot84ye+/IpmVgu2ezswwNkUzDQYeUGnsFZX3i9WZTfXqvAvoLiBW2
        LbMM8B2Y1fTnue2WjpZyMCAjZt2TbG5rC8aa2+dG/cdBYSn+jPF6OHRBipDO2En4OuemdR
        jmCDG1wLIqBjdhEGnCWNjBuGP4eldLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-501-v_QjYv-NOnKomMoqeaDwjw-1; Thu, 06 Oct 2022 05:35:41 -0400
X-MC-Unique: v_QjYv-NOnKomMoqeaDwjw-1
Received: by mail-wm1-f70.google.com with SMTP id f25-20020a7bc8d9000000b003b4768dcd9cso389259wml.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 02:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=go40zFr/9iiDvA5R+CukTDIZOFWbDoEwVAldJ/dw7HA=;
        b=i4FCf+7sbCFEz4uC6oidU4GYu5c7yBqQ0up24lTL3ymmYkdNrWuDE1rbBrHzSlhWqq
         TfANrpp56VRsklVj6iroXkP4Uq/Em8W8Vja81E4Q+YnvL3F3qh0skxlZ8ReVUigiefSi
         g4ti6nijkKpSw2+5OSHgMNyr1iL5DVdYUVPfmMVdp+1QwxGkYJhHAnzdYMQbZ1BW5swo
         E6jtCJd6Y3yf0t+2HSVnXTBDDqN82q4O+/ekoyGYxYVr83uh9JYi8RwGBcjVOGvt8lJw
         MYZ3W+FhEehhOoUyPLQwLIU3VkGKTpRPJvco9f2Y7ESU8F93jjxl2mSVVIv7CPmBqt3M
         UOSQ==
X-Gm-Message-State: ACrzQf1RSBIwANb5Q+cDCNK95/Hxdwy1TmYaiprP6VGs9/ARzcNzakhy
        DBt84Ukmgi/LaXl5Dlp2ufFxCmXDpDTcdXKll0Kgi+TrlUEmfOo8Rx461S+AR0NNPXtCPW8k/Bz
        3oyrf34wiOLef2VAkA0i5E5Oi
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr2539244wro.78.1665048940462;
        Thu, 06 Oct 2022 02:35:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FbNUZUTcpyWNZ14N4SZRoLrItztcXYWPLFvPsaCMZQ09OI7Y6HnjjTpPj6olm9G3I9db3vg==
X-Received: by 2002:adf:f501:0:b0:22c:cbea:240a with SMTP id q1-20020adff501000000b0022ccbea240amr2539227wro.78.1665048940201;
        Thu, 06 Oct 2022 02:35:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:3700:aed2:a0f8:c270:7f30? (p200300cbc7053700aed2a0f8c2707f30.dip0.t-ipconnect.de. [2003:cb:c705:3700:aed2:a0f8:c270:7f30])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d6dca000000b0022917d58603sm17203084wrz.32.2022.10.06.02.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 02:35:39 -0700 (PDT)
Message-ID: <274c790a-04c7-078a-19be-851066dc21bb@redhat.com>
Date:   Thu, 6 Oct 2022 11:35:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-6-david@redhat.com> <Yz3sIY5Njzda3XSA@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 5/7] mm/pagewalk: add walk_page_range_vma()
In-Reply-To: <Yz3sIY5Njzda3XSA@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.10.22 22:42, Peter Xu wrote:
> On Fri, Sep 30, 2022 at 04:19:29PM +0200, David Hildenbrand wrote:
>> +int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
>> +			unsigned long end, const struct mm_walk_ops *ops,
>> +			void *private)
>> +{
>> +	struct mm_walk walk = {
>> +		.ops		= ops,
>> +		.mm		= vma->vm_mm,
>> +		.vma		= vma,
>> +		.private	= private,
>> +	};
>> +	int err;
>> +
>> +	if (start >= end || !walk.mm)
>> +		return -EINVAL;
>> +	if (start < vma->vm_start || end > vma->vm_end)
>> +		return -EINVAL;
>> +
>> +	mmap_assert_locked(walk.mm);
>> +
>> +	err = walk_page_test(start, end, &walk);
> 
> According to test_walk():
> 
>   * @test_walk:		caller specific callback function to determine whether
>   *			we walk over the current vma or not. Returning 0 means
>   *			"do page table walk over the current vma", returning
>   *			a negative value means "abort current page table walk
>   *			right now" and returning 1 means "skip the current vma"
> 
> Since this helper has vma passed in, not sure whether this is needed at
> all?

I kept it because walk_page_vma() similarly has it -- walk_page_vma() 
walks the whole VMA range.

I do agree that it's kind of weird to have it like that. All users of 
walk_page_vma() don't use it, so we can just get rid of it there as 
well. Might make the walk slightly faster.

> 
> walk_page_vma_range() sounds slightly better to me as it does look more
> like an extension of walk_page_vma(), rather than sister version of
> walk_page_range_novma() (which works for "no backing VMA" case).  But no
> strong opinion.
> 

I matched that to walk_page_range_novma(). Now we have

walk_page_range
walk_page_vma
walk_page_range_novma
walk_page_range_vma


-- 
Thanks,

David / dhildenb

