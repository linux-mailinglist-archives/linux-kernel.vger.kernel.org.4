Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F176BF020
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCQRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQRvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886ABE41F9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679075421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+5rVi0WyfwWKJrN+StQmENQv1kIwISDnMPK24LSLpw=;
        b=BqBA6FqCPsM4NlpzJJBjsi72jY8U6qHSR9EcXWhG0U4pVtzN2/puM+ZJiuyRAWw1WQv3o9
        sQVU7ACMCrWtJz29KNn7z2QcwvEh6oO0M0Bj12xRQk6ukwh2uhDWaD2cov2ap54gv17H5C
        2+lZMQPtpIVINRZ3Xlwl4XlgNgMbq8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-9-H943yBPlSCCQ8eOZhGfw-1; Fri, 17 Mar 2023 13:50:20 -0400
X-MC-Unique: 9-H943yBPlSCCQ8eOZhGfw-1
Received: by mail-wm1-f70.google.com with SMTP id l18-20020a05600c4f1200b003ed35ab903aso4176895wmq.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075419;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+5rVi0WyfwWKJrN+StQmENQv1kIwISDnMPK24LSLpw=;
        b=CMl7y3fID2VLyxSSL5/OjSLnlu63fsJzemSAVgKhOb6NB4BQ4L4vTO294F5Ve7/26j
         qWYLdSapE75WJeyEJpVRibXYcS35f7GCf4rnLOtj50meUqWKk4Wr11I9QfQCL/Jz0GvL
         c3rlcSB/L334XxZ3UOn0OoZBz2CBv9QpLMEA4x4ZuZvxk4nqJMGIMMiLxF2mJqaWLoov
         YVyKoEYQmBSuiQjDNhG/trbdXrl36AypKtPulHP86n9zW6OtqjrBKKSpC+7jCwLFTyhO
         vwmArgnMiKUVOTNX5qHVz2CkEFamQvwYmMXPtOybd1HqL5b9fHGqFsnEFmPGDU1ooX/8
         nl8g==
X-Gm-Message-State: AO0yUKUuOOUXWsKZinzZkVc/SviLjkyZQNefChMkAKVZ17OtBiKV9b6y
        +ambOrNMjZanWiYnaT5T4469vGX6eo2rBTh1dNzqMKgZXvaCbYSJzXba7xKfclPp31ft4Gd8p0t
        cvomtaBRIMfaXAe+eyBe+PNB1
X-Received: by 2002:a05:600c:524a:b0:3ed:3e72:3580 with SMTP id fc10-20020a05600c524a00b003ed3e723580mr7677038wmb.26.1679075419109;
        Fri, 17 Mar 2023 10:50:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set/WzB0KfelzZQrjurkv0RtAmJa99mtgVV5SoH08YYwFZPhGUX8bbh4GYOhR/WlBJ8RJz4hW1g==
X-Received: by 2002:a05:600c:524a:b0:3ed:3e72:3580 with SMTP id fc10-20020a05600c524a00b003ed3e723580mr7677020wmb.26.1679075418729;
        Fri, 17 Mar 2023 10:50:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003eb5ce1b734sm2931664wmj.7.2023.03.17.10.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:50:18 -0700 (PDT)
Message-ID: <373b22c7-9162-eff0-1f0c-0a8d79a8b372@redhat.com>
Date:   Fri, 17 Mar 2023 18:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
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

On 17.03.23 16:35, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when pageblock is larger than MAX_ORDER, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.

See

commit b3d40a2b6d10c9d0424d2b398bf962fb6adad87e
Author: David Hildenbrand <david@redhat.com>
Date:   Tue Mar 22 14:43:20 2022 -0700

     mm: enforce pageblock_order < MAX_ORDER
     
     Some places in the kernel don't really expect pageblock_order >=
     MAX_ORDER, and it looks like this is only possible in corner cases:
     
     1) CONFIG_DEFERRED_STRUCT_PAGE_INIT we'll end up freeing pageblock_order
        pages via __free_pages_core(), which cannot possibly work.

     ...

How should it still happen?

-- 
Thanks,

David / dhildenb

