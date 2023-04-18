Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FF6E686C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjDRPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjDRPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B56588
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681832434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MsmWI5Pgohu3t/O3Pmt82XyF9y80a2YqEGBsfRyGHMk=;
        b=c58TDlxHpfWtbmMnjxotSff2qcNcdojnNzVXrXzjXK7Gg0Jfr/hSyFvb+ECwrPoyfsF8Zs
        iE+J1Pn92/0QJhRiLx4rnFC2FfkbMJ1dJPX7gi7wb4tfmejPdGIKEfge5DVy8HE3tSmW2n
        Dm5ODcL78FpQSs32f7zZn+rkK92SMuI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-1cAPPI1xPq253JHlte68Jw-1; Tue, 18 Apr 2023 11:40:30 -0400
X-MC-Unique: 1cAPPI1xPq253JHlte68Jw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-2f458b98be5so1415044f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681832428; x=1684424428;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsmWI5Pgohu3t/O3Pmt82XyF9y80a2YqEGBsfRyGHMk=;
        b=PDiX3SxunTHwb7r+baDQnQSrb4vnrpFsDDLykfDAw4MDK/GR0HQHjxWuUBJjKyPZrZ
         eXABNiCAqaFQB6Mhr2qXpA+cYyLTrF8kGSLyoqN4pkxJN3qRjZVitZR2UMawq1+otHIs
         o1nB6b+9FdncQBUtslX4Xf9C0Py4MpQQjcNyFKHoQVlp6Mg5jX1FVlBkkZmqflSk2nPN
         TRs2MiUluUhqETzXYNA6qilIZUJ3vlEcjquQXz01fLG2Uztt/Gmj21UWbNBkt2Mt1uPa
         SxJ1BHbTnuSkdMKrH3CnD6kcAhYt+3znusf8HSPI5xMnkNAtjP40msZYJkoiUOX1OMCe
         lAYw==
X-Gm-Message-State: AAQBX9d2DEoB4v7Ux+9yF6xlsvkwBoO/X7R1Ft62lrzOv7fTIWUvS2ZG
        I245o0KNXeJTbBqyAsciULLqrwyiXBMtsruY1nOlWx9C9O0o+PmYesGvav58AS4ITmkSqAv6/pV
        BQCJ/wmVxjoYVSGnjm6QbkWJX
X-Received: by 2002:adf:dc8e:0:b0:2ef:bc0b:e70 with SMTP id r14-20020adfdc8e000000b002efbc0b0e70mr2052815wrj.54.1681832428452;
        Tue, 18 Apr 2023 08:40:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350beiVppd1dCW6t/vLz5KVIjtgfvpgqbAdL1scTa1y8yxFu+tga5BEf0+JVU5K4kECfE529Weg==
X-Received: by 2002:adf:dc8e:0:b0:2ef:bc0b:e70 with SMTP id r14-20020adfdc8e000000b002efbc0b0e70mr2052801wrj.54.1681832428126;
        Tue, 18 Apr 2023 08:40:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003f09cda253esm3020807wmn.34.2023.04.18.08.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:40:27 -0700 (PDT)
Message-ID: <42c6d435-69ed-72f3-9d7e-1ab2e508cbda@redhat.com>
Date:   Tue, 18 Apr 2023 17:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: correct arg in
 reclaim_pages()/reclaim_clean_pages_from_list()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
References: <20230417114807.186786-1-wangkefeng.wang@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230417114807.186786-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 13:48, Kefeng Wang wrote:
> Both of them change the arg from page_list to folio_list when convert
> them to use a folio, but not the declaration, let's correct it, also
> move the reclaim_pages() from swap.h to internal.h as it only used
> in mm.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

