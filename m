Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD586FE2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJQl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEJQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C27ED3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683736835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NY0JJIQROZci35Lv+keQEV1GDPb9b7mS9KRBzx8tN4=;
        b=dFY32iLGkBt/3MEijOm6Pe4YMncPhwCbXfVY+SR7xTKx+bL1VIljsiiXZ4qnMr4nxy2I1f
        7ehkWhU/YVP5qSMZk/wUhWRZXgvpHogpX7koYyekzE20shvcxkxeS80IfSO/LmySr/m71U
        7KYCp+2g3OuXCFgRAl5IwWN9McvFb1g=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-fd4CvxVbM7ejRwxS--s72Q-1; Wed, 10 May 2023 12:40:34 -0400
X-MC-Unique: fd4CvxVbM7ejRwxS--s72Q-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-645538f6101so21951377b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683736833; x=1686328833;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NY0JJIQROZci35Lv+keQEV1GDPb9b7mS9KRBzx8tN4=;
        b=lmCqaC9ddUbaa7pgsMZXXl/PqLje92dCmdbqtsdItiV6O/Ubtxk450Wu3M378S4P5+
         bvifQBbxEcqTyZ8VP6n7nxK6f8pCUpw77rNsRRmRbPo2XqXQQ6nnpHzWvbJzF7gpEQxD
         MG0btIbXarkiGuCZdaIZOEU7TCQL1vwUoXDNUKMBXE3jqZcpyz0RiRLF3a1OxMj1BAyN
         M71DpEPjcMQknUw69uupvCblGrGO8jdlB5m6tR5BdzxkULBqiEIjFhF4YM+Vrlv8Pb8V
         dObsrV7RB+LD25F/LolmQvH3cwZANtqvfQ3d8DIAx3O3r3VZjTF5WsfYFhJZBHi8o/Tf
         B9jA==
X-Gm-Message-State: AC+VfDzDmCSewrE+P+QXseTfsMVyL1xHpCj1kfY5PAZ6a117V6hllm+q
        On6IqeiTyCao6F+1sqfdENiNju/ae9ipcqavVk6I9AzTBRPDOJiqja1+yjlVMk2TEC208vfEpwL
        tFXXssALRTHUx2l+WMlBTLmtw
X-Received: by 2002:a17:90b:1188:b0:250:32dc:3369 with SMTP id gk8-20020a17090b118800b0025032dc3369mr21521612pjb.15.1683736833000;
        Wed, 10 May 2023 09:40:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KmVpd3q4EvAEWG9cN6AIc7RLq0o7jc4GG/UBzSx5JcKue7oCjZjly+TneE2m+hsmUGhCWgw==
X-Received: by 2002:a17:90b:1188:b0:250:32dc:3369 with SMTP id gk8-20020a17090b118800b0025032dc3369mr21521590pjb.15.1683736832601;
        Wed, 10 May 2023 09:40:32 -0700 (PDT)
Received: from ?IPV6:2001:4958:15a0:30:5835:5bd3:f0c8:e5ef? ([2001:4958:15a0:30:5835:5bd3:f0c8:e5ef])
        by smtp.gmail.com with ESMTPSA id p19-20020a63f453000000b005287b22ea8esm3432907pgk.88.2023.05.10.09.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 09:40:32 -0700 (PDT)
Message-ID: <f74f2080-1def-f9c2-8884-97bb4c8ba4d1@redhat.com>
Date:   Wed, 10 May 2023 18:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Ruihan Li <lrh2000@pku.edu.cn>, linux-mm@kvack.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
References: <20230510085527.57953-1-lrh2000@pku.edu.cn>
 <20230510085527.57953-4-lrh2000@pku.edu.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 3/4] mm: page_table_check: Make it dependent on !DEVMEM
In-Reply-To: <20230510085527.57953-4-lrh2000@pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.23 10:55, Ruihan Li wrote:
> The special device /dev/mem enables users to map arbitrary physical
> memory regions into the user space, which can conflict with the double
> mapping detection logic used by the page table check. For instance,
> pages may change their properties (e.g., from anonymous pages to named
> pages) while they are still being mapped in the user space via /dev/mem,
> leading to "corruption" detected by the page table check.
> 
> To address this issue, the PAGE_TABLE_CHECK config option is now
> dependent on !DEVMM. This ensures that the page table check cannot be
> enabled when /dev/mem is used. It should be noted that /dev/mem itself
> is a significant security issue, and its conflict with a hardening
> technique is understandable.
> 
> Cc: <stable@vger.kernel.org> # 5.17
> Signed-off-by: Ruihan Li <lrh2000@pku.edu.cn>
> ---
>   Documentation/mm/page_table_check.rst | 18 ++++++++++++++++++
>   mm/Kconfig.debug                      |  2 +-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
> index cfd8f4117..b04f29230 100644
> --- a/Documentation/mm/page_table_check.rst
> +++ b/Documentation/mm/page_table_check.rst
> @@ -52,3 +52,21 @@ Build kernel with:
>   
>   Optionally, build kernel with PAGE_TABLE_CHECK_ENFORCED in order to have page
>   table support without extra kernel parameter.
> +
> +Implementation notes
> +====================
> +
> +We specifically decided not to use VMA information in order to avoid relying on
> +MM states (except for limited "struct page" info). The page table check is a
> +separate from Linux-MM state machine that verifies that the user accessible
> +pages are not falsely shared.
> +
> +As a result, special devices that violate the model cannot live with
> +PAGE_TABLE_CHECK. Currently, /dev/mem is the only known example. Given it
> +allows users to map arbitrary physical memory regions into the userspace, any
> +pages may change their properties (e.g., from anonymous pages to named pages)
> +while they are still being mapped in the userspace via /dev/mem, leading to
> +"corruption" detected by the page table check. Therefore, the PAGE_TABLE_CHECK
> +config option is now dependent on !DEVMEM. It's worth noting that /dev/mem
> +itself is a significant security issue, and its conflict with a hardening
> +technique is understandable.
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index a925415b4..37f3d5b20 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -97,7 +97,7 @@ config PAGE_OWNER
>   
>   config PAGE_TABLE_CHECK
>   	bool "Check for invalid mappings in user page tables"
> -	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK
> +	depends on ARCH_SUPPORTS_PAGE_TABLE_CHECK && !DEVMEM
>   	select PAGE_EXTENSION
>   	help
>   	  Check that anonymous page is not being mapped twice with read write

That might disable it in a lot of environments I'm afraid. I wonder if 
we could allow it for STRICT_DEVMEM. Hm ...
-- 
Thanks,

David / dhildenb

