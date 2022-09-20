Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1E5BE513
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiITL7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiITL7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26C274BBB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663675152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZaluPZpVrNPRVcSQh9l/MDeSu1M1m1rlp/jFFAVOTJc=;
        b=UfnkOOp1cdGfUMSjHr385VY8JHqozfSNu4IydA0o8/7oaPRFm3l3ewn8RyuoYthIDc9xZt
        BY8/tSiuK0ZQvYAF81YwJH14q74rh8BNj+BlTAxUk5kqwIWmdt2Qq2yw4Fq3FALEs0Os8d
        T3r7UI9F5wOEkd4O6eQsbTeoJ2BVLg8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-tfG9GwYsNBuM2UZ2LMcVag-1; Tue, 20 Sep 2022 07:59:11 -0400
X-MC-Unique: tfG9GwYsNBuM2UZ2LMcVag-1
Received: by mail-wr1-f69.google.com with SMTP id o7-20020adfba07000000b00228663f217fso1053597wrg.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=ZaluPZpVrNPRVcSQh9l/MDeSu1M1m1rlp/jFFAVOTJc=;
        b=7lPekJy+R4oPT9vGWcTIei8oRQix0B05yD9MlhLtjWSj7OvvNzoFsz3Ki1BRy7Te71
         LJVuJt6u1cEWPcId9wRFIDH167Lc/QgL9s06XRsnfSbKvJg7p/Zl+Pde/XvslXmO4Vxr
         BP8z6eSY6uIAD3ALtqEKTEfBVPZr8SeAsFgiPLhQ/I+bMQfw7DkI6Ublo6cIiOODiKAH
         PayPqdT0iJxu/pX1NON4fZyEu3QVgNR9VHjuGNFFSE9iavpnniYIAxlQaEHYwbOK07z+
         t0EWQonbxGbNxfH06EMztfMg0oqbrhhnF2UM3iHoqr7uOVOOycyytezRs2TOzYuff2KO
         vJxA==
X-Gm-Message-State: ACrzQf1jm1tfvWhAYlF4WaXhXFELSWmYNI42BpeKWBvzxyA3Isp1RFAw
        ki73+mx4wN2Q+xfKNZpDLRXbuwli9chOoJmcTEHWFy+jPmAyQSeb8+iF8EPuxeAhRxXd53r38Z8
        jJeDqqRKfa8v1MseVzOOZLfec
X-Received: by 2002:a7b:cc85:0:b0:3b4:9fc7:cd4d with SMTP id p5-20020a7bcc85000000b003b49fc7cd4dmr2069346wma.68.1663675150531;
        Tue, 20 Sep 2022 04:59:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6YMdklbiftLEaborupQggyhJCLWR65L2+29xbinHFHNPNHsxJl2wqSNIN17DKFFJ+jt+4IWQ==
X-Received: by 2002:a7b:cc85:0:b0:3b4:9fc7:cd4d with SMTP id p5-20020a7bcc85000000b003b49fc7cd4dmr2069329wma.68.1663675150231;
        Tue, 20 Sep 2022 04:59:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:2300:e82d:5a58:4fd8:c1e6? (p200300cbc7122300e82d5a584fd8c1e6.dip0.t-ipconnect.de. [2003:cb:c712:2300:e82d:5a58:4fd8:c1e6])
        by smtp.gmail.com with ESMTPSA id r203-20020a1c44d4000000b003a840690609sm21386092wma.36.2022.09.20.04.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 04:59:09 -0700 (PDT)
Message-ID: <5a9c07cc-251f-c8f7-42ab-f3525f9ee320@redhat.com>
Date:   Tue, 20 Sep 2022 13:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4] mm/hugetlb: add available_huge_pages() func
Content-Language: en-US
To:     Xin Hao <xhao@linux.alibaba.com>, mike.kravetz@oracle.com
Cc:     songmuchun@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220920015122.68064-1-xhao@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220920015122.68064-1-xhao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.22 03:51, Xin Hao wrote:
> In hugetlb.c file, there are several places to compare the values of
> 'h->free_huge_pages' and 'h->resv_huge_pages', it looks a bit messy, so
> there add a new available_huge_pages() func to do these.
> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

