Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE685697B93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjBOMQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjBOMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:16:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994D99EF3;
        Wed, 15 Feb 2023 04:16:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35FEF60D34;
        Wed, 15 Feb 2023 12:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E81DC433D2;
        Wed, 15 Feb 2023 12:16:35 +0000 (UTC)
Message-ID: <c990e632-4e2e-3942-0fe3-4b7a2e636ff7@linux-m68k.org>
Date:   Wed, 15 Feb 2023 22:16:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] m68k/nommu: add missing definition of ARCH_PFN_OFFSET
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
References: <20230214140729.1649961-1-rppt@kernel.org>
 <20230214140729.1649961-2-rppt@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20230214140729.1649961-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/2/23 00:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> On m68k/nommu RAM does not necessarily start at 0x0 and when it does not
> pfn_valid() uses a wrong offset into the memory map which causes silent
> boot failures.
> 
> Define ARCH_PFN_OFFSET to make pfn_valid() use the correct offset.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: d82f07f06cf8 ("m68k: use asm-generic/memory_model.h for both MMU and !MMU")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> ---
>   arch/m68k/include/asm/page_no.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
> index 43ff6b109ebb..060e4c0e7605 100644
> --- a/arch/m68k/include/asm/page_no.h
> +++ b/arch/m68k/include/asm/page_no.h
> @@ -28,6 +28,8 @@ extern unsigned long memory_end;
>   #define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
>   				((unsigned long)(kaddr) < memory_end))
>   
> +#define ARCH_PFN_OFFSET PHYS_PFN(PAGE_OFFSET_RAW)
> +
>   #endif /* __ASSEMBLY__ */
>   
>   #endif /* _M68K_PAGE_NO_H */
