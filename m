Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF671599A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjE3JM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjE3JMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:12:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542D8CD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685437927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JM53ssDZ1pW2l3meo+OiWTQQLf/RYKK5DG6HuMkac1g=;
        b=d13+ZTRT3ESjdw2Yk1GTGQ0SViIdp0zg2ztRYEoUxEDgJPcQ4RruZnNy1pf2Rk0t79bKE8
        gVNoo1y0spwDG6zx6GIhFJmDQxKHbh9aTL+HwsDgon3hc5klWTxjlJ9v7XGqCYPHplfMuq
        tWaU+EwZpCjUCv5OCJvOwE9OA6KKKx0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-dTG9WXmiNpm0dJjcMgA3_g-1; Tue, 30 May 2023 05:12:05 -0400
X-MC-Unique: dTG9WXmiNpm0dJjcMgA3_g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae8776c12so1051357f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685437925; x=1688029925;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM53ssDZ1pW2l3meo+OiWTQQLf/RYKK5DG6HuMkac1g=;
        b=MwPqGlLFcs/DnNWr+VeQvAmgFrGneZH4TEQISLEP10MRtZoZxjFMRuxPaYgmIRCcw+
         WlZTOe7Eu4ybcOIIVTHudtntWO5Jm4DMJfFOa31avvyD41Mird6TLNIwZJAAdwqf+0s/
         /leA8/u1KG0Txx2h4uEBBfiqVCMuSN2Oj6KzBQe9eUjnND4BZlvaRtOpWep39KQ/s9ex
         b8LpgR1WsUJ1zEs4f/1xGpMUNZXQWBQQfg5lLPSDc5L3aWfDkdp8bmkgo6wcI6jXEgJt
         5OKiaMrcdwFIVZsndBvABxSRPDIusbya4g70YLDUSUS/vQfBPUWWWr814mT8d37G6myZ
         xwTQ==
X-Gm-Message-State: AC+VfDy6purIy9cJudkIVE45YrQC50baSKJ1zsIbk5KBc6buq5jVELE4
        +/yOuubl75ZiBnFDAVS4XRQ7HkLfi3uHG4SyX4WRJHg1lphlJ6R6i8Stavh2CNeRWUB9fLOMlNs
        Q4rRWXgmE/qD+KnT8UVSeRkEl
X-Received: by 2002:adf:f485:0:b0:30a:c681:fd2e with SMTP id l5-20020adff485000000b0030ac681fd2emr1411991wro.22.1685437924903;
        Tue, 30 May 2023 02:12:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tviPM4BUy2+k3VQs0hpNDgkwiGjdPWwIma/uLVioVsCHBmAS9J8CtBKSFYLJttd72o8dzHw==
X-Received: by 2002:adf:f485:0:b0:30a:c681:fd2e with SMTP id l5-20020adff485000000b0030ac681fd2emr1411973wro.22.1685437924564;
        Tue, 30 May 2023 02:12:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:d500:78e5:f448:8bef:a30? (p200300cbc73cd50078e5f4488bef0a30.dip0.t-ipconnect.de. [2003:cb:c73c:d500:78e5:f448:8bef:a30])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b00301a351a8d6sm2558387wrw.84.2023.05.30.02.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 02:12:04 -0700 (PDT)
Message-ID: <e41791a5-229d-ad3c-7d5d-cc174e909763@redhat.com>
Date:   Tue, 30 May 2023 11:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v10 5/5] selftest: add a testcase of ksm zero pages
To:     Yang Yang <yang.yang29@zte.com.cn>, akpm@linux-foundation.org
Cc:     imbrenda@linux.ibm.com, jiang.xuexin@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com, xu.xin16@zte.com.cn
References: <202305251341580149313@zte.com.cn>
 <20230525055410.27423-1-yang.yang29@zte.com.cn>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230525055410.27423-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.05.23 07:54, Yang Yang wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Add a function test_unmerge_zero_page() to test the functionality on
> unsharing and counting ksm-placed zero pages and counting of this patch
> series.
> 
> test_unmerge_zero_page() actually contains four subjct test objects:
> (1) whether the count of ksm zero pages can update correctly after merging;
> (2) whether the count of ksm zero pages can update correctly after
>      unmerging by madvise(...MADV_UNMERGEABLE);
> (3) whether the count of ksm zero pages can update correctly after
> 	unmerging by triggering write fault.
> (4) whether ksm zero pages are really unmerged.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

-- 
Thanks,

David / dhildenb

