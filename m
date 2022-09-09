Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8C65B3661
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiIILcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 07:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIILcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B966E13867C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662723136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d50SkkWrkIdpdMIVL6ztnsBoBH02DSFy2w4b8A0IjEs=;
        b=G6DoCdsY5m2/zkBza4EsYzH+gbZUJLujCog3oyGuCbQABV+f1zokaWogg60vSYsuZG1ulU
        KrfcB6SCTWVB4VwVtczy2zKHS6hsqAc1Il0sqj0nLq/vDSO1D4FuleaHVWxgsMe2gu16fX
        Xw95ymj6or1N4/JfCPyKqdGI1hMi3h4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-c0PCVwxBMsGS_vGSNrpUfg-1; Fri, 09 Sep 2022 07:32:14 -0400
X-MC-Unique: c0PCVwxBMsGS_vGSNrpUfg-1
Received: by mail-wm1-f69.google.com with SMTP id j36-20020a05600c1c2400b003a540d88677so720911wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 04:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=d50SkkWrkIdpdMIVL6ztnsBoBH02DSFy2w4b8A0IjEs=;
        b=UhVHVD+Fn4+u2yShbiIWT2TRGJMIi/h3eVx6c6f+Ms6Zx9osJTIJYf8k4+eRDs7Jd8
         DtPXaDDWmBIGY1Nkc7I7bRsSQr+xsiIGScV0+zmxzpPUvizimRdrzYXXxkG4xWI8BXPh
         h5rCgMAmOXqpkNbF5ffisFtb/geGNTTyw1D4UVjiCGmrugsqAeWtHKI4ap2pMNMmmvlt
         LPQ5oRcMHklErvwdKVXgVgV7XvdRe/xoM+2IIHLGUYLpQ17IuT0yHfu85fYbxwBCVDV8
         zpo48CLGcFN/lZNYffs7caJyex5f3tlaMTNyp/d6Ops5stFlR7fXp+x+4pMYcppK5o3g
         nhPA==
X-Gm-Message-State: ACgBeo0piGsboxYr6t4ofHSUrZPjeKY3TbPFpc4WS7GGvRXJZ8WFSz2U
        Ij6DBD6+FXTIxq480neh9zOxaxwcycUV1DOJSZfpzg5RH9TBWF1dL5Ls6cfkY9+DK3P3tJpzTKK
        k45IrutmMoZNdJiMd0V7+jGWw
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr5084860wmb.91.1662723133529;
        Fri, 09 Sep 2022 04:32:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4N73zmdsLJhBg5eCUJMbXWc2aViXaT3qqh7XFt/DT8yrkWPVay0ZcuKruKG0m9vD8U6YWpoA==
X-Received: by 2002:a05:600c:3d93:b0:3a5:eb9b:b495 with SMTP id bi19-20020a05600c3d9300b003a5eb9bb495mr5084845wmb.91.1662723133258;
        Fri, 09 Sep 2022 04:32:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:6300:1fe0:42e1:62c5:91b6? (p200300cbc70463001fe042e162c591b6.dip0.t-ipconnect.de. [2003:cb:c704:6300:1fe0:42e1:62c5:91b6])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003a607e395ebsm663249wmq.9.2022.09.09.04.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 04:32:12 -0700 (PDT)
Message-ID: <780938ad-9e14-7241-a139-573c967ce73f@redhat.com>
Date:   Fri, 9 Sep 2022 13:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 10/16] mm, memory_hotplug: remove obsolete
 generic_free_nodedata()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-11-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220909092451.24883-11-linmiaohe@huawei.com>
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
> Commit 390511e1476e ("mm, memory_hotplug: drop arch_free_nodedata")
> drops the last caller of generic_free_nodedata(). Remove it too.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/memory_hotplug.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 51052969dbfe..9fcbf5706595 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -43,11 +43,6 @@ extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
>   ({								\
>   	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
>   })
> -/*
> - * This definition is just for error path in node hotadd.
> - * For node hotremove, we have to replace this.
> - */
> -#define generic_free_nodedata(pgdat)	kfree(pgdat)
>   
>   extern pg_data_t *node_data[];
>   static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
> @@ -63,9 +58,6 @@ static inline pg_data_t *generic_alloc_nodedata(int nid)
>   	BUG();
>   	return NULL;
>   }
> -static inline void generic_free_nodedata(pg_data_t *pgdat)
> -{
> -}
>   static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
>   {
>   }


Reviewed-by: David Hildenbrand <david@redhat.com>
-- 
Thanks,

David / dhildenb

