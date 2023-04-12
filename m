Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BAC6DED87
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDLI0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDLI0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087F71FF3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681287923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4IJICmTyYhGT2gtwna9xdp+oOGGlb++xfNzV+F8TtI=;
        b=IbhdSZsPmeZWDODDR/WRaifdQPNGmKSysRNcsboNuRy11oxigpFBW8f2TDhqrGqjLBK3OG
        wuMR8NiUmDC5M8yY4Q5jABuZZQvUQWnJUpWWY4Wrb2YDLG90VGqD6j1FAqrMoflFmdjQZN
        w1OQDiq8RgbVaUhtbt3QjnvWlwM5hls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-RnKb3i0nPV2L0xgvgA72AQ-1; Wed, 12 Apr 2023 04:25:22 -0400
X-MC-Unique: RnKb3i0nPV2L0xgvgA72AQ-1
Received: by mail-wm1-f70.google.com with SMTP id n3-20020a05600c3b8300b003f048e0e09eso979288wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287921; x=1683879921;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4IJICmTyYhGT2gtwna9xdp+oOGGlb++xfNzV+F8TtI=;
        b=HISnOr7AvF07FORgq66sBupvpleUyMFqKvhnPoI7te6ynukuD17CYimx+/WCYuhXFw
         8JEVuzwto0LjuHgKGtBApU36EK3T+PKkYi6AaWgswWW9tfo381KFG+A2j2e7t3bWhckr
         Io9mflxMYfgke5ipRYFbnR431JyGdmDL/kNyv3L9LF7LrioBFOCGp05QULwEgJLWKl2W
         JEn+Q+E0EbXegcqmOCPxEAkf3ICZdyiF8uMzyE3ckhK9C8EEs+9YAx/g1L5Jo1IMWBm8
         /f9hhT2945DMeWkpvEC6PmJ/x9kSSgnJLm8/mgDlFM7/mGNzcCEYJuLjMSD7z91Pk2fe
         gOTQ==
X-Gm-Message-State: AAQBX9c7XS+Xa3H3uB4IjoeMgisi1NpqGVBcUH0QZG3hbI2PmVjxkmF0
        mwJnZNIpsrMN0Id+fsVf0znF3Y025gHD8ZE2ehYZ1LkclZAfnR0d661NbMaOlIeWevUhPITlhwP
        k3Z8sTwb2FPbolMjhFqKAllSfDVgG8uC5
X-Received: by 2002:a1c:ed02:0:b0:3f0:7dd1:8e4b with SMTP id l2-20020a1ced02000000b003f07dd18e4bmr10910962wmh.6.1681287921021;
        Wed, 12 Apr 2023 01:25:21 -0700 (PDT)
X-Google-Smtp-Source: AKy350a1WECB1kk68NRdJPbyNjAlu6PPKO9jxkSM5x5lIq92uVGPiP705lFjSOj5uP6sSkJPeDZ5vQ==
X-Received: by 2002:a1c:ed02:0:b0:3f0:7dd1:8e4b with SMTP id l2-20020a1ced02000000b003f07dd18e4bmr10910945wmh.6.1681287920628;
        Wed, 12 Apr 2023 01:25:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4b00:c6fa:b613:dbdc:ab? (p200300cbc7024b00c6fab613dbdc00ab.dip0.t-ipconnect.de. [2003:cb:c702:4b00:c6fa:b613:dbdc:ab])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b003ef5b285f65sm1520457wmq.46.2023.04.12.01.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:25:20 -0700 (PDT)
Message-ID: <d2746727-b0a1-d4ed-cb09-56ae8d3e363a@redhat.com>
Date:   Wed, 12 Apr 2023 10:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To:     Deming Wang <wangdeming@inspur.com>, akpm@linux-foundation.org,
        shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412072741.2116-1-wangdeming@inspur.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] selftests/mm: Replace obsolete memalign() with
 posix_memalign()
In-Reply-To: <20230412072741.2116-1-wangdeming@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.04.23 09:27, Deming Wang wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
> 
> As a pointer is passed into posix_memalign(), initialize *p to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).

I don't follow how that comment here applies to the patch. What is p? 
Where is it initialized to NULL?

> 
> Signed-off-by: Deming Wang <wangdeming@inspur.com>
> ---
>   tools/testing/selftests/mm/soft-dirty.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index 21d8830c5f24..4bb7421141a2 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -80,8 +80,8 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>   	int i, ret;
>   	size_t hpage_len = read_pmd_pagesize();
>   
> -	map = memalign(hpage_len, hpage_len);
> -	if (!map)
> +	ret = posix_memalign((void *)(&map), hpage_len, hpage_len);

posix_memalign expects an "void **memptr", casting to "void *" looks 
weird. Further, you can drop the parentheses around &map.

ret = posix_memalign((void **)&map, hpage_len, hpage_len);


> +	if (ret < 0)
>   		ksft_exit_fail_msg("memalign failed\n");

Better adjust the comment to "posix_memalign() failed\n"

-- 
Thanks,

David / dhildenb

