Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BB63DA3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiK3QKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiK3QKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:10:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D812CCA4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669824561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAV7qid5lUhlLswMeHWUDOojo8YrR2eC9NJjbYq7JCM=;
        b=eSNBB3DFmTdPG8p6+YFrueYdf9+65qjyAA0dTiV4zeIfA/3EsipbdUqpXDx6uRZrMtJcBa
        7vy1Ih1vxcWOnRJeaw453KrNwdrecAa0tDh1mrNe+o7kvKjzqdcF5KnZDDAInYHM1bw91u
        uI3r6Nx+g8in4+PRWLJiAOKe68cLtXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-278-9pRnUuDJPhepmQ54yKO99g-1; Wed, 30 Nov 2022 11:09:18 -0500
X-MC-Unique: 9pRnUuDJPhepmQ54yKO99g-1
Received: by mail-wm1-f69.google.com with SMTP id l32-20020a05600c1d2000b003cfefa531c9so964785wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAV7qid5lUhlLswMeHWUDOojo8YrR2eC9NJjbYq7JCM=;
        b=MoIcSV4JNz1YnJ0QloJN4ZCLBJVnDYJMvmmiWbZ554dJmjrDTCu4zahstNUMQPmwDB
         y4eC/dmuVbUNW9as4IFMTHXGZEIk7tbMf3/aKBPC3tOPYuYSSCabMjjOX2hr0BdTVVyt
         UX9SEvaBbmd/0fQnDKHOZ0Z3a4WiZPdbjYj7ip3FCcRHs/tP6dGQ2SRnVI3s+bmXSKa6
         UTm6g+aMhosc795qDSPUp0EbF5CWzo35TjTG0V2aPJfLPUfYmaAzEOlnMVknfr7O6Nui
         hHlayZJXcBEMciCw/1UzGiXYbVyzMokkHo1A6jUo8GkYn6Q0TVahVicqTst6qgRVvK8e
         /6xA==
X-Gm-Message-State: ANoB5pka3J+J86Yny4RsCWXovffrBo+UM5Dx9g9UCq+OAw+lG7qv5Dbp
        PzifzlDjeB5jKTudXnP8Ko9JClI3zaA8fVBYAhkQZrMJvVqoZCOgrHb+EtfJ226xG5VstlCE2js
        tymN+15BBMuD6bSMQRHnrKqdB
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr34671558wmp.63.1669824557527;
        Wed, 30 Nov 2022 08:09:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf72YsRrDl6JnBJd90DcuW6hRHI/E291PqyeujBjHfKniqZgAmDl2fu6PZ0YTuFPmuUaH6FMLg==
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr34671544wmp.63.1669824557292;
        Wed, 30 Nov 2022 08:09:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id bg9-20020a05600c3c8900b003cf483ee8e0sm6702973wmb.24.2022.11.30.08.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:09:16 -0800 (PST)
Message-ID: <e55915c8-5360-229a-610c-5332f00e7d7c@redhat.com>
Date:   Wed, 30 Nov 2022 17:09:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 06/10] mm/hugetlb: Make hugetlb_follow_page_mask() safe to
 pmd unshare
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
 <20221129193526.3588187-7-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129193526.3588187-7-peterx@redhat.com>
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
> Since hugetlb_follow_page_mask() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

