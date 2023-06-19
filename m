Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2756734E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFSIpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjFSIoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA8B3AA1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687164077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHYREAceAID4GY6I9tCHjlucH9SzlCuPatShlVuLLv0=;
        b=PZlC8aNt/U0BowSF4wbVYue1Ht4IWnMjTjJqjtBZxXKZYKlZl36IiugzijmTG71fE9f35c
        GizY9ZgIW+QKvnbzFeFKXSI/G2GHdH4xMH5QD/5eVi3ocl7mpwlvxp22QuVHb1wifiT1I5
        GBoWC5iMVw74o0e+oksTwp5hnEMQqxY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-aGQFReA1PkeQBlv3e8qWwQ-1; Mon, 19 Jun 2023 04:41:15 -0400
X-MC-Unique: aGQFReA1PkeQBlv3e8qWwQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7f4dc6ec2so16481635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687164074; x=1689756074;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHYREAceAID4GY6I9tCHjlucH9SzlCuPatShlVuLLv0=;
        b=R1op4aTh4Df6WgL+gAPCzUEBRq3ioBBVn2P/PhFgfH0i9QV4Tj4LwecDr+cwvQeSRO
         Mp6womzhCo1fdTMtIYW2QFGQFBh+UgFbRYt7kVbWmBg9LyxPH7Y76LAS2k4/sM/QU97r
         9Ys62DzaOQnR1TrwRoj610xy8yf6XqWo1wbus0ycYhtjhbO455DX9/n9hzM+yL2YJT7X
         qjVRrgUzYoyooG+mn6m174KYQj4oL+lGvAURiSz0/Aq0qz4NQDP0WWpztpXqN4/dMKg6
         q3li5CAyvMgT5U8XDp7RtcOh9WlXnTf4hWKAHfi8fby8Y24Sd1rAkqmS/cQIdV6kWk0g
         CvHg==
X-Gm-Message-State: AC+VfDwIO3NP2heiXil4CGjy8Sc8n4bAcLAC+Jgy6nNwFSlsDkGo3yfu
        FBLpfCDGw24kMiM2KmXhDZe1NBuvEq7b7QmhzXwGQ42qE1W9Q6pF/JLEMo0LN9rsSuSomFlmxmr
        I+cgZlOAjSkQLOHXqkjHZ6SqJYlTwlpKd
X-Received: by 2002:a1c:750a:0:b0:3f7:cb42:fa28 with SMTP id o10-20020a1c750a000000b003f7cb42fa28mr7260315wmc.28.1687164074151;
        Mon, 19 Jun 2023 01:41:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eGrtx5haDfRL+ovx+2RlIaHgzENmMu2m4F1LkVwfdV1RC/TbyevA11DCTgj+s1OBQGlIv9Q==
X-Received: by 2002:a1c:750a:0:b0:3f7:cb42:fa28 with SMTP id o10-20020a1c750a000000b003f7cb42fa28mr7260304wmc.28.1687164073738;
        Mon, 19 Jun 2023 01:41:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:7100:cede:6433:a77b:41e9? (p200300cbc72f7100cede6433a77b41e9.dip0.t-ipconnect.de. [2003:cb:c72f:7100:cede:6433:a77b:41e9])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc354000000b003f4248dcfcbsm10051839wmj.30.2023.06.19.01.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:41:13 -0700 (PDT)
Message-ID: <efddcb27-be9a-1edb-b98a-bd92d21dfa72@redhat.com>
Date:   Mon, 19 Jun 2023 10:41:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm/sparse: Check the return value of
 first_present_section_nr()
Content-Language: en-US
To:     Liam Ni <zhiguangni01@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@kernel.org
References: <20230619044403.1519685-1-zhiguangni01@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230619044403.1519685-1-zhiguangni01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.23 06:44, Liam Ni wrote:
> first_present_section_nr() may return -1,
> which means there is no present section in system,or other errors,
> so we cause panic here.
> 
> Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
> ---
>   mm/sparse.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b8d5d58fe240..175727e10deb 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -564,6 +564,8 @@ void __init sparse_init(void)
>   	memblocks_present();
>   
>   	pnum_begin = first_present_section_nr();
> +	if (pnum_begin == -1)
> +		panic("There is no present section in system\n");
>   	nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
>   
>   	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */

That would mean that __section_mark_present() was never called, implying 
  memory_present() / memblocks_present() was never called.

... but sparse_init() calles memblocks_present() itself.

So what's left would be, that there is absolutely no memory in the 
system such that memblocks_present() couldn't mark anything present ... 
which sound pretty much impossible, unless the arch setup code is deeply 
flawed such that everything else would be broken as well.

Don't think this will ever trigger, and, therefore, this is not really 
required.



-- 
Cheers,

David / dhildenb

