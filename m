Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBB63DA35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiK3QJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK3QJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5403F175AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVNwuW5+uccfiZVDEZIcPICj3awEkrtKMxi+jom/QYY=;
        b=NNnbKagMMit73LKJchiwPePVj7eID1gZstjvZjRkG3DkIEMq88GI3idmfIGJjkPbv3orwU
        wuBhQflD2+7sDMPwqTN8hD809Sr9VPK3RtUhSVpk84UPBbrdnI50CmkyrPkOldkVAlMzs3
        W0dbz2WjAof8Uw2LJyo3/XdMe/jsFt0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-8F99FeFNMxGq8KoMPNNnEg-1; Wed, 30 Nov 2022 11:08:10 -0500
X-MC-Unique: 8F99FeFNMxGq8KoMPNNnEg-1
Received: by mail-wm1-f70.google.com with SMTP id 1-20020a05600c028100b003cf7833293cso1170589wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVNwuW5+uccfiZVDEZIcPICj3awEkrtKMxi+jom/QYY=;
        b=swQxrwnEYOlLuG8DpAte6le11yjXw0K5umEhYwbtGE9ZkrW8w27bRFYojpOl09gCcS
         rCSbF3yXj5uKXlkmDVEmNdgyncl2QQ0qTvgQK8ExhNDYLkzdXGhS1Oftfjcxj+LKVz3y
         BO8BLsnxygJ9QhGy9HNTJ8TlCUrwXVyRWYE9uPYZ0TouiIvUuFJoS2VJ3EjZGsMWnczH
         FiUi45jCciXEP/Munp1M0oSfOpbnGDQaXxVkXwKCKkJedW3lblm8wvCrEK9kBGtyuh3t
         1AtC7XJZhixK8kfdsRod6jtwtB8gMQb2Tqvxwg8h/pagNqX27vBm6+I0S2Ig0EsjzkrC
         JOIQ==
X-Gm-Message-State: ANoB5pm2OdqPLmAvDj+M/7JK8+0cDD5wfPyxz5dpOhvXpW7j9Z5F3T9H
        0dg/3uYLoS9T4FuMjWSLLU5CoP7K5Chj8WaQSADezy46ln0qKT3SnEMhjjSg90jCsOXwHpG0cJB
        fwBIvvvUE3jJnm9jjQXDRtbXB
X-Received: by 2002:a5d:5045:0:b0:242:199a:e067 with SMTP id h5-20020a5d5045000000b00242199ae067mr8932745wrt.148.1669824489133;
        Wed, 30 Nov 2022 08:08:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6tLsczYE+jaX+/S4Ke5H1PV9UVJEwf0u6/NzgVOF1skht049dP36B4OFnIUthpVzBMHDu/2A==
X-Received: by 2002:a5d:5045:0:b0:242:199a:e067 with SMTP id h5-20020a5d5045000000b00242199ae067mr8932724wrt.148.1669824488885;
        Wed, 30 Nov 2022 08:08:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c4b9900b003cf4ec90938sm2220657wmp.21.2022.11.30.08.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:08:08 -0800 (PST)
Message-ID: <d3925f89-a219-9871-02c7-4c7d439ba542@redhat.com>
Date:   Wed, 30 Nov 2022 17:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 05/10] mm/hugetlb: Make userfaultfd_huge_must_wait() safe
 to pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-6-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.22 20:35, Peter Xu wrote:
> We can take the hugetlb walker lock, here taking vma lock directly.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

