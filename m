Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2A6C0ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjCTK3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCTK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DC19B9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679308117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A2ZIMLXtTrOT8NgoolFPGGVIokNVmwALp7gLh6bdD2w=;
        b=W8n5UTOcrAy/sf3IB7KwRAL8wj9xI/cjxHzCEl7xgALzNaxFFQqkIywSNMjTbeQ5DtkQ38
        7FGN7Eu3JilB0syU0bA94gxG52OHn0ZPgeEX7OJ7vob90kIxzJRWutLYpy9EdoPjjGTFcB
        koxpYsAHNAeOsWO0KMmtc2xFS+JPqAo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-6QfGmerzOG2MgEelqU3B_A-1; Mon, 20 Mar 2023 06:28:35 -0400
X-MC-Unique: 6QfGmerzOG2MgEelqU3B_A-1
Received: by mail-wm1-f71.google.com with SMTP id p21-20020a05600c1d9500b003ed34032a01so5313806wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308114;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2ZIMLXtTrOT8NgoolFPGGVIokNVmwALp7gLh6bdD2w=;
        b=kFm3ElAeVHbtpk2ptAw6OEWfCvKzw/QELLCBUE9ycDUJYvPknTHvuBq4brtOvxRHjD
         jc6uVLNCUM6MtAq5GaSKJon/MBrRejEqxglP6HLUZM8skjKjYHywb8WnQIA/4KGdYOZH
         VGtLfgM7dkNQQuclvPW6enzPfe83nGIG8vHEzHaq8h1d84u/QlujPQSz0UdO1MuUAK/h
         tcxFmNO1hHkLbS8copBtc7nSDYmciPYk+eaBguI3Jk1CeqeX//iK7tvDdYcSK2Rf+Ipc
         KxWKMbCBgFY0KPQ8neQDOhBYDrEbm0jRTv8wyME0brBhrGPcyEHwYVErRAP3hsEaysJ8
         Nujg==
X-Gm-Message-State: AO0yUKU3VZiAvrM2tcwHR8w8qzMtGsUhK8c9NfTWmawZDCGsJxbyt2bp
        GM47df/ZGvTw0Ff8/m+rx6im1XPdw9xV91CP8jt2iyq0fV2fk15ETjqk173mDPmlwpxGZwH7qaV
        IFbodxW++3crn3IYkYh6UCLJngD7k8hrp
X-Received: by 2002:a1c:770f:0:b0:3ed:a86c:3fff with SMTP id t15-20020a1c770f000000b003eda86c3fffmr6337699wmi.31.1679308114686;
        Mon, 20 Mar 2023 03:28:34 -0700 (PDT)
X-Google-Smtp-Source: AK7set+7luEApA33dTRq2dp7wzv2fLDxIrS/qrcTZ5smU6+ZWum0te1Quot0o/YABt4CbNIPc62FNw==
X-Received: by 2002:a1c:770f:0:b0:3ed:a86c:3fff with SMTP id t15-20020a1c770f000000b003eda86c3fffmr6337684wmi.31.1679308114363;
        Mon, 20 Mar 2023 03:28:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c3acf00b003ede2c59a54sm3859892wms.37.2023.03.20.03.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:28:33 -0700 (PDT)
Message-ID: <8aba2dc2-25db-001a-270c-9ccfe24f8bc1@redhat.com>
Date:   Mon, 20 Mar 2023 11:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/15] mips: fix comment about pgtable_init()
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org
References: <20230319220008.2138576-1-rppt@kernel.org>
 <20230319220008.2138576-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319220008.2138576-2-rppt@kernel.org>
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

On 19.03.23 22:59, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Comment about fixrange_init() says that its called from pgtable_init()
> while the actual caller is pagetabe_init().
> 
> Update comment to match the code.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/mips/include/asm/fixmap.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/fixmap.h b/arch/mips/include/asm/fixmap.h
> index beea14761cef..b037718d7e8b 100644
> --- a/arch/mips/include/asm/fixmap.h
> +++ b/arch/mips/include/asm/fixmap.h
> @@ -70,7 +70,7 @@ enum fixed_addresses {
>   #include <asm-generic/fixmap.h>
>   
>   /*
> - * Called from pgtable_init()
> + * Called from pagetable_init()
>    */
>   extern void fixrange_init(unsigned long start, unsigned long end,
>   	pgd_t *pgd_base);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

