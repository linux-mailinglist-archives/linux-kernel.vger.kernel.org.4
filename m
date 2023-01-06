Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F3660A54
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbjAFXhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjAFXhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:37:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81F78B75E;
        Fri,  6 Jan 2023 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=4z8jlsGzKRXDnUPd0+0CGYVLXgFO5gR2NP0vR0jf1RQ=; b=GZ0GXf0dbZsAjRecTv0692X2ut
        o9+eaPoq3vU7X5lCaZTx/RDqG0BoQkZ9dInEr3dd/WVUosKIGGgksXyVWfwMXwajmQnX1bqUZPbdO
        OQiGwfxTrh4udC56u3menS0axqP4UlMKhqm7xK4yXt1IIM5b8VYCcYXGxmP/syRR4xCMVg1MLRpuv
        J33swl3Gcw0ImVaIi7lqTOwoIEJR22fIpudpQSF6uFJWXq0BYfrHIwteL2nffUu5zhWKgFOTpkps2
        v4KK6YKGkbYFYuwJMCjwKZ+KJQtvk8Cj8LTv5yizQhkmlUxmWgj99oU51vMvKtozlJsCCGfBr3hWO
        ex26iu1g==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDwH9-00FfeS-Ce; Fri, 06 Jan 2023 23:37:27 +0000
Message-ID: <68bb3273-9795-8436-c588-8ff8da4aaa08@infradead.org>
Date:   Fri, 6 Jan 2023 15:37:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC] MIPS: Fix a compilation issue
Content-Language: en-US
To:     xurui <xurui@kylinos.cn>, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230106030956.1589041-1-xurui@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230106030956.1589041-1-xurui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 1/5/23 19:09, xurui wrote:
> arch/mips/include/asm/mach-rc32434/pci.h:377:
> cc1: error: result of ‘-117440512 << 16’ requires 44 bits to represent, but ‘int’ only has 32 bits [-Werror=shift-overflow=]
> 
> I guss we don`t need a left shift here?
> 
> Signed-off-by: xurui <xurui@kylinos.cn>
> ---
>  arch/mips/include/asm/mach-rc32434/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mach-rc32434/pci.h b/arch/mips/include/asm/mach-rc32434/pci.h
> index 9a6eefd12757..3eb767c8a4ee 100644
> --- a/arch/mips/include/asm/mach-rc32434/pci.h
> +++ b/arch/mips/include/asm/mach-rc32434/pci.h
> @@ -374,7 +374,7 @@ struct pci_msu {
>  				 PCI_CFG04_STAT_SSE | \
>  				 PCI_CFG04_STAT_PE)
>  
> -#define KORINA_CNFG1		((KORINA_STAT<<16)|KORINA_CMD)
> +#define KORINA_CNFG1		(KORINA_STAT | KORINA_CMD)

I looked at all of the macro values here and this change makes sense to me,
although I know nothing about these registers.

Thanks.

>  
>  #define KORINA_REVID		0
>  #define KORINA_CLASS_CODE	0

-- 
~Randy
