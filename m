Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F07653216
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiLUNyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiLUNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:54:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805222B28
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:54:33 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so4419052oto.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjHL28xIIWZ3H/BvrvTL/SzJsTlT7yr8mn58EIua50k=;
        b=Hoi5o+otCqI2B2QM4oTKy3KiqIvRxPA1Cwg0liYMPI28BAGwXdGwg8xJ3zk22MHkC6
         3Cog9oXBdSRBubKsbN6PxxIpWPss5//tsRVUOLTNmFSJsGzlOmuWjHDA5lQLluwk6lc3
         2+olSRPP5ZMaL1TLPBEXhsm4uAQN/skPmK6YcAQhqf5GwtAg8cqv3EXqQDd0sWG7El2k
         3pHzGj8CxWElzsbEjRf05269uhJByIPkz6qmHDt4i8zobvKGauIN/uZLatbwC7MYVv8a
         TdeNNO6nW9n80N8vzUU37Ie7f8FWoPYuv3761AvdamHoX8sl40QlOBNpuBi9bCbbajp7
         nbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjHL28xIIWZ3H/BvrvTL/SzJsTlT7yr8mn58EIua50k=;
        b=dePn2BwfInOglriINn/dMkP+33jfSbuizZ8P1VlZZwBIUAu4ED9yhZXOmAr7nG+Mtt
         ILS+X0QLvQihUTXtCiZVbOECnqsVKz0dWyPz0AsH4QZNmr7wnXk3UgD7Jix/EI0MMmDf
         Vq+CnVDFjWCkwpC/52HeZJFiroVo0csLRS9wE1N6vNuxzbs94CJMDpb65+lz+0yV504W
         /6yoaEZx/SujDgDOU7/0udyVxY7TUhLjlWBr2AwMI93S3NU6qgixKtLEhyqN5x3MCgrA
         kndS0D3iku9Y0UUi/my9MSqPbljN6PIVMUfGqkB6tdNe/cKsxuatqcsi2JAWA6UvSmOo
         S87g==
X-Gm-Message-State: AFqh2krkYoUCNhpxhF9chWiuugaO6vRpm0DPUQUv6XULu4UP5/1pvI9g
        uLxyQnLI3OYZssOaanJtGM4=
X-Google-Smtp-Source: AMrXdXvnRfz+J2sIuXk2RP7veVaaGfPhrnoRytEF5O2eK35NAqtPf350JeS2E2+/TaCPXivuPUKbow==
X-Received: by 2002:a9d:7f12:0:b0:670:9cff:64bf with SMTP id j18-20020a9d7f12000000b006709cff64bfmr677054otq.21.1671630872896;
        Wed, 21 Dec 2022 05:54:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830128300b00661a3f4113bsm6800783otp.64.2022.12.21.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:54:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Dec 2022 05:54:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: Re: [PATCH 03/13] sh/mm: Make pmd_t similar to pte_t
Message-ID: <20221221135430.GA1510470@roeck-us.net>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.645657294@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022114424.645657294@infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 01:14:06PM +0200, Peter Zijlstra wrote:
> Just like 64bit pte_t, have a low/high split in pmd_t.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This patch causes a compile error when trying to build sh:defconfig.

In function 'follow_pmd_mask',
    inlined from 'follow_pud_mask' at mm/gup.c:735:9,
    inlined from 'follow_p4d_mask' at mm/gup.c:752:9,
    inlined from 'follow_page_mask' at mm/gup.c:809:9:
include/linux/compiler_types.h:358:45: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().
...
mm/gup.c:661:18: note: in expansion of macro 'READ_ONCE'
  661 |         pmdval = READ_ONCE(*pmd);

> ---
>  arch/sh/include/asm/pgtable-3level.h |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/arch/sh/include/asm/pgtable-3level.h
> +++ b/arch/sh/include/asm/pgtable-3level.h
> @@ -28,9 +28,15 @@
>  #define pmd_ERROR(e) \
>  	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
>  
> -typedef struct { unsigned long long pmd; } pmd_t;
> +typedef struct {

Was this supposed to be "union" ?

Guenter

> +	struct {
> +		unsigned long pmd_low;
> +		unsigned long pmd_high;
> +	};
> +	unsigned long long pmd;
> +} pmd_t;
>  #define pmd_val(x)	((x).pmd)
> -#define __pmd(x)	((pmd_t) { (x) } )
> +#define __pmd(x)	((pmd_t) { .pmd = (x) } )
>  
>  static inline pmd_t *pud_pgtable(pud_t pud)
>  {
> 
> 
