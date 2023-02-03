Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC4689BCB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjBCOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjBCOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:32:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB799D582
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675434676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
        b=KoCvTALGset8w6k1Si6CZ6l/74I0+l5J/fxz9/c71cc6sQogROtaYrOAQo01YgoYvBfzrC
        q/3LKjhGqMHX5kY8yrNk80Qy/RpbK+qE8oRrud0H8y+CB6t5xX/mDDkf3Jcvz8Ofnv+gqE
        Zxtn52h1d7tdsFFEMfyeGja/aYjxP64=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-373-sIN8rJdhOLOPLauYbO6-wA-1; Fri, 03 Feb 2023 09:31:15 -0500
X-MC-Unique: sIN8rJdhOLOPLauYbO6-wA-1
Received: by mail-wr1-f69.google.com with SMTP id i9-20020a0560001ac900b002bfda39265aso714145wry.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 06:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBuUxRqwVpT90qSSvu23sLwWbKqZ02KC/SRu5tcTWNA=;
        b=rcehCD4Sg8RoJZUIu2aBrwx3uaKn3IYvjnZMElsFJs1KDqqp8tu3a9AD3cvytyEEd3
         Wj8T+beZd1XJ9kjqXBeqIKe4KEOuPOlkljB+mCjItjMVFWMO7taPA5y2i605c5t2xLt9
         tOVZ+UKNoT2CMVE7UCjHEBSpcWVZ782bY4UxsdhHPaKf3UQj4A9lnJ5Y+vdLiIHWvGFS
         Te34PHSvmlY3EPQCt3IVksYp5memaXnRS5UY1z51e3AYFdxTlZcDWNNgmxUcnMwpYVQV
         gt3zqXz7KyPQChxQqV86t38VZz4T4s8cfEElCaO4+39uZZPsrUpnTE3Lxl1LyMFF07Ql
         guWA==
X-Gm-Message-State: AO0yUKVdROktACZUCy/SwI4o+dFXYTHlWsl0ZEqwZ4/S8mSu5PWGYYe+
        KhnV8PCT2V5VC00Luo99SkSwZ3ABW3uT8Sy0vyUI/xnF3QF11LT+pp6BzFK0Z6xnAC15G9vqyRJ
        JSiHtHh5WwhqzjO7u32PHrTPI
X-Received: by 2002:a05:600c:4707:b0:3df:e6bb:768 with SMTP id v7-20020a05600c470700b003dfe6bb0768mr2347099wmo.24.1675434673750;
        Fri, 03 Feb 2023 06:31:13 -0800 (PST)
X-Google-Smtp-Source: AK7set8jlKBL+3VH/Q/zFxtw4x3QAOrg1CgHYVk1aVg00PiHMhqeIMC/qbmUMqYVh9aDbNcRdczHvA==
X-Received: by 2002:a05:600c:4707:b0:3df:e6bb:768 with SMTP id v7-20020a05600c470700b003dfe6bb0768mr2347047wmo.24.1675434673459;
        Fri, 03 Feb 2023 06:31:13 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id w14-20020a05600c474e00b003dfe57f6f61sm2479833wmo.33.2023.02.03.06.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:31:12 -0800 (PST)
Message-ID: <862cb71f-0775-916d-b0c9-5247f772d637@redhat.com>
Date:   Fri, 3 Feb 2023 15:31:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU
 and !MMU
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> The MMU variant uses generic definitions of page_to_pfn() and
> pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
> good reason.
> 
> Include asm-generic/memory_model.h in the common include/asm/page.h and
> drop redundant definitions.
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

