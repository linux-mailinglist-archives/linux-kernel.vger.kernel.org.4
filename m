Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9363F121
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiLANDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiLANC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:02:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC5C90779
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669899687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YrLpv8IinAzI6TJvCdt8qSJlbjMH9iouKKI1hsHF2L4=;
        b=Lgd71gE0rB4yD5cfWb7iXfM6srFES8H4gacYXHKpipyXllHRH9Gn60P8k6NwZoPdsfoYm/
        Wn7Ktdh9XSgBm0OfvyxVIgCvCtl61dz4E2B1MryZpZBWjeAkmz0896oWhyMSUFKL4fuisM
        Mbvy2jzFHytPCz004B2Rm+QlqPgHu9k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-ivJQ47baPm-1yKeNs1YWLQ-1; Thu, 01 Dec 2022 08:01:25 -0500
X-MC-Unique: ivJQ47baPm-1yKeNs1YWLQ-1
Received: by mail-wr1-f69.google.com with SMTP id y5-20020adfc7c5000000b002423fada7deso111917wrg.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrLpv8IinAzI6TJvCdt8qSJlbjMH9iouKKI1hsHF2L4=;
        b=oYuRSQrcHwyQzQkAKmyPIhew7vv29TUYMUfzkKZsWQ0UYGiYd5rCnKD2tGK/tgZPWB
         o0U3+t+VtY4SfWWY2IUQwMPLdPGV3C+MNIUQdezS3H5SPLzoju2V2ZCo/Ps2FLgmjqZC
         Om5pTJspZPeQGnfLMz9yzuRbC0rg7yIhDgi3sz3rlyWVHjVIX0bV6Uaow+N/KcXChm6B
         b+R8Es2nMsX09EdKJr0z7UjjuEM2DXHfwDToR1Mjg0r12sgPr+MJN2YOrdJGMTCMaW1z
         tk7cg1X9fV3vTVl30yKtvlacPeyE2temaw4aGdJK/Qtg/flyFwcgL7BBCtYdNRsZIB21
         n8Fg==
X-Gm-Message-State: ANoB5pkC/xlf/3KciDRi+u0ZX6+0unGmAIHWijibmUJ46XqZSuFRmkTc
        DFFgoRjB7hb0xIcPqE8Cuqn58TMLElFxlIbvJ0ZbJxhT+7Dodps6B7dyewTPhcRrciaJLMlOc5v
        QuUMcsbjTJF0Eos7eBcPevBW5
X-Received: by 2002:adf:f4cb:0:b0:242:3b56:cc79 with SMTP id h11-20020adff4cb000000b002423b56cc79mr1494428wrp.310.1669899684496;
        Thu, 01 Dec 2022 05:01:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Q1wp/GBT8F2KRHWoEV0lTQae7B32mzgui7Kc4fgPi6S3v/UQciJOYVTUQx+7BbZwkvxBjaw==
X-Received: by 2002:adf:f4cb:0:b0:242:3b56:cc79 with SMTP id h11-20020adff4cb000000b002423b56cc79mr1494394wrp.310.1669899684139;
        Thu, 01 Dec 2022 05:01:24 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id d7-20020a056000114700b00242152e06f9sm4230517wrx.116.2022.12.01.05.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 05:01:23 -0800 (PST)
Message-ID: <906b0150-ef7c-d2b9-783f-4e94c48fa367@redhat.com>
Date:   Thu, 1 Dec 2022 14:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
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

> +	 * If the VMA belongs to a private file mapping, there can be private
> +	 * dirty pages which can be paged out if even this process is neither
> +	 * owner nor write capable of the file. Cache the file access check
> +	 * here and use it later during page walk.
> +	 */
> +	can_pageout_file = can_do_file_pageout(vma);

Why not move that into madvise_pageout_page_range() ? Avoids passing 
this variable to that function.

In fact, why not even call that function directly instead of storing 
that in madvise_walk_private(). The function is extremely lightweight.

>   
>   	lru_add_drain();
>   	tlb_gather_mmu(&tlb, mm);
> -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
>   	tlb_finish_mmu(&tlb);
>   
>   	return 0;

-- 
Thanks,

David / dhildenb

