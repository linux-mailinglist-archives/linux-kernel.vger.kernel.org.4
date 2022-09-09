Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61F5B364E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiIIL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIIL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAEA108736
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662722815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UTaE70j3QvpvgRkMEbbuVhGtDnHfrnrQRxeJ8rHUyOo=;
        b=gHoMgy3257T9AQajnC1t0X8OutlX6QkhjnzT0Qeb7OgkVhrjP3Yc0Nc7BP4C3howcdxRyx
        JPvfEALpcmIQv/zdbgn3WhHrLvOsvPRl4oQbK702O/Jh7vdCvV3BrXvEM9Tpr6YJqbOAfn
        bl+cUjgRJlHdMCwU0Y0jLPbhwKkXpBk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-93-NnvKhLJVMgO8pDJ9jO1nqQ-1; Fri, 09 Sep 2022 07:26:53 -0400
X-MC-Unique: NnvKhLJVMgO8pDJ9jO1nqQ-1
Received: by mail-wm1-f69.google.com with SMTP id y7-20020a7bcd87000000b003b338001a4bso407912wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=UTaE70j3QvpvgRkMEbbuVhGtDnHfrnrQRxeJ8rHUyOo=;
        b=5rHXQpdgwkunHivp2kvEEQVegJdr0Y0kIKcVt8KfhkJ+KSk8QxMmaaAqao8vNJSsga
         MruDECLv3mzcuhFT1v3qw//PF4l1oFTSiYx4ga8BadjfuzXDSZ6mdbdl8BV74MWbE3cK
         7Hyc2NjHpeI5TZFVurhUU6c6yWiRAGOQeCKmhbOSy4+hTlX1KetEYhU8BlmrrRwnzuVA
         IJdkr/FZnSeLjsDO26Jj9A3D0uYMtUVqMzvtum8BoqgsscLGrhMZPftRVbNjRi2nlcJQ
         JzHTwzEaU89TmW6tfNWGcu3HezNR7NhXHgPGkHsDRkPLl1OKlGdwk44L4uxMpBO+KG7I
         +8/w==
X-Gm-Message-State: ACgBeo2rxQnb8+evSD0uDDR9s1vXiGZfh8sD+8zY+Nh1mTLfOMr6DEHc
        H4n/ezqodIq9glxXwwzYJGO499Jq9ML9T/9GDUubUsBHLp1PvD8KODniCvuUgz17NpzaZorcNtg
        1STxOG7Szfm0xa6SD1VKimq0p
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr5199562wmq.71.1662722812767;
        Fri, 09 Sep 2022 04:26:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7EsvH5axM4LJBQ/uuA+Nz3CpDzEzdQAPy6Rg6UY0IX9t76KAsfjLmDUzYNUhAR6c/HWCdrug==
X-Received: by 2002:a05:600c:34c5:b0:3a5:f6e5:1cb4 with SMTP id d5-20020a05600c34c500b003a5f6e51cb4mr5199550wmq.71.1662722812478;
        Fri, 09 Sep 2022 04:26:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003a5f3de6fddsm434095wms.25.2022.09.09.04.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:26:51 -0700 (PDT)
Message-ID: <92c59e69-7bbe-ac9c-20df-e3b94b178b46@redhat.com>
Date:   Fri, 9 Sep 2022 13:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 03/16] mm: remove obsolete macro NR_PCP_ORDER_MASK
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-4-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-4-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.09.22 11:24, Miaohe Lin wrote:
> Since commit 8b10b465d0e1 ("mm/page_alloc: free pages in a single pass
> during bulk free"), it's not used anymore. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/mmzone.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d907a29cc429..6950179a20a2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -569,7 +569,6 @@ enum zone_watermarks {
>    * in the least significant bits.
>    */
>   #define NR_PCP_ORDER_WIDTH 8
> -#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_WIDTH) - 1)
>   
>   #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>   #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

