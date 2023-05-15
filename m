Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7A703107
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbjEOPIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242110AbjEOPIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:08:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD078E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cwWX1J8jmE9CcWWNEepi0uSPUXS9Vb5N2uT4ZDVIwkg=; b=KpmrJ2n0w3STusTXAwtbRnA94l
        R5nXBr4Mw837OBfh7cMHo0iUTSo47DnQX8UL3HEkUEhK3QdStkQ8VP5WzGTHS032mGKQ4FNiF930z
        KsYquS9AFOgavZOtY+6ORRtuVFeHdX32LA7zN5WgtyCZ4daHWWdyu0/W8UDYzu0GPlBzVDR/8NTZk
        gQlrNCLicQYoqkfvnSBt1x3XxnCz70U+jqilLVCpJWr8Vksp9757R0402bkXaoMNhGdXJpJHL8/eT
        jlfSPBZ0YCTlsLIh6Sngpi6CDz9i1Q/REsYQPb2EasGA+eAgZsOvxJLwMT25Thhk3k5POkRoDeN9s
        7mFFkjVw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pyZo3-002W0c-0L;
        Mon, 15 May 2023 15:08:11 +0000
Message-ID: <ff19a404-e059-ce7e-4a4c-27804503bf07@infradead.org>
Date:   Mon, 15 May 2023 08:08:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm/secretmem: make it on by default
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230515083400.3563974-1-rppt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230515083400.3563974-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/15/23 01:34, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Following the discussion about direct map fragmentaion at LSF/MM [1], it
> appears that direct map fragmentation has a negligible effect on kernel
> data accesses. Since the only reason that warranted secretmem to be
> disabled by default was concern about performance regression caused by
> the direct map fragmentation, it makes perfect sense to lift this
> restriction and make secretmem enabled.
> 
> secretmem obeys RLIMIT_MEMBLOCK and as such it is not expected to cause
> large fragmentation of the direct map or meaningfull increase in page
> tables allocated during split of the large mappings in the direct map.
> 
> The secretmem.enable parameter is retained to allow system
> administrators to disable secretmem at boot.
> 
> Switch the default setting of secretem.enable parameter to 1.

Nit:                            secretmem.enable

Maybe fix up while applying.

> 
> Link: https://lwn.net/Articles/931406/ [1]
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  mm/secretmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 0b502625cd30..974b32ba8b9d 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -35,7 +35,7 @@
>  #define SECRETMEM_MODE_MASK	(0x0)
>  #define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
>  
> -static bool secretmem_enable __ro_after_init;
> +static bool secretmem_enable __ro_after_init = 1;
>  module_param_named(enable, secretmem_enable, bool, 0400);
>  MODULE_PARM_DESC(secretmem_enable,
>  		 "Enable secretmem and memfd_secret(2) system call");

-- 
~Randy
