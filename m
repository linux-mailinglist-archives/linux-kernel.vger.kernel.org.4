Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9DF63DA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiK3QKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiK3QKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:10:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EDE2E9FE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZ5C7tU8XWxdCkvCFAowgU3FU/2N0c+MvJiXmJ8D94Q=;
        b=SdKwtIVrNYLlFW+O4bRyv0i2EBS9EOkpKir47L9KBWdK1pWyzoMBS6oMeZZ+y3wzPIvZQw
        p344m4+10rTEgTJo0NNdqrl1J+quoQnZdtEnLAguncjFymE6IGr/0El5G4hrPfOWh7mTcF
        o1IFctDFmatDxcKpJl9ART/r/toUEhY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-424-HoaTJeW2P-K_f6n9hG5AdA-1; Wed, 30 Nov 2022 11:09:34 -0500
X-MC-Unique: HoaTJeW2P-K_f6n9hG5AdA-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso9592904wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:09:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZ5C7tU8XWxdCkvCFAowgU3FU/2N0c+MvJiXmJ8D94Q=;
        b=Axtp32XV7Ic+jLnBIwXKIEbQY3Anru2C32m9fZ33GxDoAeu0QB7Qu3EQ+OY3CgcpJ/
         gcjsN1bisKIxAYBk8lNmVGxkM6PbhVlpl/i9UvKdo6frbAR9fiyC6m9fnyHeya9CNxyQ
         eMDajAKM4fuEfdeOGm0u3Xk4ukGbEM5uf3NffEEjABkGhRM1QF+gRuF7qHO45h6rgP4o
         MdT7qJ7UdIloM+LkTqlA8JbL9SusSmiOct0vdfdwm2HSAitYrKTfRVbqehZ6Xd9iedrV
         entjSa71+PSKD2+v/x94j+5b2wOCpEfKB5D9zP1TpECQhVRwuaqlzwzVJiddsJ4+J9Ya
         U47g==
X-Gm-Message-State: ANoB5pm3nZK5Ca0jMlPfedyDpPI4bQ4WQFHh+EZnQFWXB8GG18wZQyOI
        KmpfOdnHF7i3GwTZ6uExMpf/Sc+FNIyECZZ90ohE+K4AcW6gGUJK9klQSVccqt5JSmGOL82a+BS
        hxqR1D8E9sc8aauoZQo1oQvMZ
X-Received: by 2002:a05:600c:1f0f:b0:3d0:2a82:1cb2 with SMTP id bd15-20020a05600c1f0f00b003d02a821cb2mr31181319wmb.206.1669824573113;
        Wed, 30 Nov 2022 08:09:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7WFlDmbNW6fPR2lPbq1LUK8mTwnh55wa0sQ5dTS6ZTadKTFEvLARRhTBEtxUvdNgT3SyrJpQ==
X-Received: by 2002:a05:600c:1f0f:b0:3d0:2a82:1cb2 with SMTP id bd15-20020a05600c1f0f00b003d02a821cb2mr31181298wmb.206.1669824572889;
        Wed, 30 Nov 2022 08:09:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id v25-20020a5d5919000000b00228dbf15072sm1930695wrd.62.2022.11.30.08.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:09:32 -0800 (PST)
Message-ID: <294d0053-6e5f-3599-caa3-4c60a8b20492@redhat.com>
Date:   Wed, 30 Nov 2022 17:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 07/10] mm/hugetlb: Make follow_hugetlb_page() safe to pmd
 unshare
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
 <20221129193526.3588187-8-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-8-peterx@redhat.com>
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
> Since follow_hugetlb_page() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

