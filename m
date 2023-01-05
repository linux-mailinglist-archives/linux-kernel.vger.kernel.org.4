Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DE65E6BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 09:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjAEITf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 03:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjAEISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 03:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F15A8A3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 00:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672906608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7rG4uCX9wvgLxa5VSSu2Sj8AAkcwgQ3HOlO0JMkfC8U=;
        b=BMhimpWOxC97bgDSjrxBvgPlteb9k3BGgn0l4VybrhHySb7HnKWBR8wZZon9TiNAeWdLqx
        Y7/vjrEYVjqI4qP3xXYDvi8+SThF32lBVyIHHt5DLKTWcaIQYoNU1q0PBnm0ssN/aYz8zU
        xhW5J+ZNhW3BSAUt/pQC3IKMRu6U19M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-Fcdupt6iNpC8v26d-a9SVA-1; Thu, 05 Jan 2023 03:16:46 -0500
X-MC-Unique: Fcdupt6iNpC8v26d-a9SVA-1
Received: by mail-wm1-f72.google.com with SMTP id k20-20020a05600c1c9400b003d9717c8b11so17411737wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 00:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rG4uCX9wvgLxa5VSSu2Sj8AAkcwgQ3HOlO0JMkfC8U=;
        b=Tcm1ZD57iXDNUb17BLoDhdRyvhBLK9pKhEuUp5oU8GNlABMJ1Hepo3Dx4QHIXddZkw
         PemEe0sYqKe4xqQzpSbe+wSjxw6xN72F2xiUJSQ507u5gsQfeWm6iq6J9cBwQn7UyG5G
         /f7kadvNPx+bxxqmUJwMmru4w3hJwcbdQSmu0fW/IdSw7dH6RSEib8Edq+ZguXmbM0oF
         0ff9E3DnJM2XSsJYqGmaq3/mHC4WI+L0ljWWPn9/UtxoEd9DFSh46AY0fPQj7n6S7Z8Q
         yCr1RUubxhFMYCpN8ZOYHNBXFC48tL1Q8YvtN+kYIka65GIWFXeCR6o7yV6XsBao+AO7
         gytg==
X-Gm-Message-State: AFqh2kqdAIfNmlejlpv2izvzDuXL+ToI7rZNioN81UEEBYwVcVNOXyD9
        DrEh8LwqbrSbvQEgeDzfuxKWbsTchDkqAskNMYjrBqVHbmxSIHIMvVTX7qbN4abBAYAynVhTShc
        HlHRepDdC1LBtCwoDTaBcl4bV
X-Received: by 2002:a05:600c:3ba4:b0:3cf:d428:21d6 with SMTP id n36-20020a05600c3ba400b003cfd42821d6mr34338873wms.3.1672906605577;
        Thu, 05 Jan 2023 00:16:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsdMMXGP2JQgYjKQ1XLsBqX51+fK0JSBhRIo6tH/6CRGw6g3PfIyAM2+k/1yNSYK6NhIaDcIw==
X-Received: by 2002:a05:600c:3ba4:b0:3cf:d428:21d6 with SMTP id n36-20020a05600c3ba400b003cfd42821d6mr34338855wms.3.1672906605283;
        Thu, 05 Jan 2023 00:16:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id fj15-20020a05600c0c8f00b003cf894dbc4fsm1534778wmb.25.2023.01.05.00.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 00:16:44 -0800 (PST)
Message-ID: <b6b428a9-f411-a813-0f9f-11b7b57f64c1@redhat.com>
Date:   Thu, 5 Jan 2023 09:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] mm/uffd: Fix missing markers on hugetlb
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230104225207.1066932-1-peterx@redhat.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230104225207.1066932-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.23 23:52, Peter Xu wrote:
> When James was developing the vma split fix for hugetlb pmd sharing, he
> found that hugetlb uffd-wp is broken with the test case he developed [1]:
> 
> https://lore.kernel.org/r/CADrL8HWSym93=yNpTUdWebOEzUOTR2ffbfUk04XdK6O+PNJNoA@mail.gmail.com
> 
> Missing hugetlb pgtable pages caused uffd-wp to lose message when vma split
> happens to be across a shared huge pmd range in the test.
> 
> The issue is pgtable pre-allocation on hugetlb path was overlooked.  That
> was fixed in patch 1.

Nice timing, I stumbled over that while adjusting background snapshot 
code in QEMU and wondered why we are not allocating page tables in that 
case -- and wanted to ask you why :)

-- 
Thanks,

David / dhildenb

