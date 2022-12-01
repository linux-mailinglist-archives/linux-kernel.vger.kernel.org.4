Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C4963EB14
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiLAI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiLAI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:27:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475B1EAC3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:27:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e13so1324816edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+I7iCy6KN9SjmrWdCmm3vCgXjOfriD/ytuDhEGftsH0=;
        b=ccRUEe70S6aLdP/NOuPonIQioXmU4XdSdX10BPrNCR6McvBXW1v2QPnhbtaYAMA64w
         7cze4x1pY4Rki+B4ZfY1T+OsJXs8PHqhztAFRLVATuD1xJxSkHGIAlPoY7TprqioL8AV
         JJ6E06Y8l4/XLKJA9o8gTq8JI/TzNsm8NwtmAIoO3fdGS8XocKj/Ay1Lfk/5UlXQwSgF
         0bn9bIJz/mPzL8SjDC9xfHe/fSycMYN5KFhOP04eijttMG52ADHHpOU60gn6sJenmr8u
         jgdFwOoC/kaVURmCFNZ0AXyeVDn/h7b0nH71sF18iXxHjqgvPYsaofdawrvuyJt2DfXy
         57Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+I7iCy6KN9SjmrWdCmm3vCgXjOfriD/ytuDhEGftsH0=;
        b=2gH71JrugeBLpRph3TzMsad9+hTVhh8GNhqVkqny9MHf4xbP8fAyIKB5i/24FO99cP
         y8AjGiyR+E6pozDyMvuDerh+4ZpzUS+xKA48unVXh3S96ytyj+h9BibgyTveAgK22jol
         /Do4B6Mg3hWJHw9Fm5ltj24DDptQKAXiMRO1LDlmywOpCoLbiQ62teLXX8G+zKP8XTJf
         ye16GJ25TJTSyRQsSvKmO89rZYjR71ok794o7euw671IZek3EYRgnhnsA9OM3VaYZrK9
         EZ9EWOKU4jn/FTpBaTQfAhm9X7FlS1LA3Uhmmru81T5sEI+QwOZMztmSXjHCBbLImv3j
         OfeQ==
X-Gm-Message-State: ANoB5pntJwCAdRnI3U9uF5M3i7o5mEpKeGxo/il6PFa9Xt71k5zErhRz
        rPYd16sHiEKX8EbVy8XMSNXH4Q==
X-Google-Smtp-Source: AA0mqf5yjnJVb1/yYiKxeZcGrg+oNQaA6VJ4pfW5oYMIplJzuj6fTM4R1fYk5p4Jdx1EdSgqfBfVdg==
X-Received: by 2002:aa7:db91:0:b0:458:bd09:1b20 with SMTP id u17-20020aa7db91000000b00458bd091b20mr59869948edt.176.1669883264612;
        Thu, 01 Dec 2022 00:27:44 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id f29-20020a50d55d000000b00467960d7b62sm1505465edj.35.2022.12.01.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 00:27:44 -0800 (PST)
Date:   Thu, 1 Dec 2022 09:27:43 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        aou@eecs.berkeley.edu, corbet@lwn.net, guoren@kernel.org,
        heiko@sntech.de, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 1/3] RISC-V: clarify ISA string ordering rules in cpu.c
Message-ID: <20221201082743.xjxcnx7zcwycdwy7@kamzik>
References: <20221130234125.2722364-1-conor@kernel.org>
 <20221130234125.2722364-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130234125.2722364-2-conor@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:41:24PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> While the current list of rules may have been accurate when created
> it now lacks some clarity in the face of isa-manual updates. Instead of
> trying to continuously align this rule-set with the one in the
> specifications, change the role of this comment.
> 
> This particular comment is important, as the array it "decorates"
> defines the order in which the ISA string appears to userspace in
> /proc/cpuinfo.
> 
> Re-jig and strengthen the wording to provide contributors with a set
> order in which to add entries & note why this particular struct needs
> more attention than others.
> 
> While in the area, add some whitespace and tweak some wording for
> readability's sake.
> 
> Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/kernel/cpu.c | 49 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 852ecccd8920..68b2bd0cc3bc 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -120,22 +120,45 @@ device_initcall(riscv_cpuinfo_init);
>  		.uprop = #UPROP,				\
>  		.isa_ext_id = EXTID,				\
>  	}
> +
>  /*
> - * Here are the ordering rules of extension naming defined by RISC-V
> - * specification :
> - * 1. All extensions should be separated from other multi-letter extensions
> - *    by an underscore.
> - * 2. The first letter following the 'Z' conventionally indicates the most
> + * The canonical order of ISA extension names in the ISA string is defined in
> + * chapter 27 of the unprivileged specification.
> + *
> + * Ordinarily, for in-kernel data structures, this order is unimportant but
> + * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
> + *
> + * The specification uses vague wording, such as should, when it comes to
> + * ordering so for our purposes the following rules apply:
> + *
> + * 1. All multi-letter extensions must be separated from other multi-letter

1. All multi-letter extensions must be separated from other extensions by an
underscore.

(Because we always lead multi-letter extensions with underscore, even the
first one, which follows the single-letter extensions.)

> + *    extensions by an underscore.
> + *
> + * 2. Additional standard extensions (starting with 'Z') must be sorted after
> + *    single-letter extensions and before any higher-privileged extensions.
> +
> + * 3. The first letter following the 'Z' conventionally indicates the most
>   *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
> - *    If multiple 'Z' extensions are named, they should be ordered first
> - *    by category, then alphabetically within a category.
> - * 3. Standard supervisor-level extensions (starts with 'S') should be
> - *    listed after standard unprivileged extensions.  If multiple
> - *    supervisor-level extensions are listed, they should be ordered
> + *    If multiple 'Z' extensions are named, they should be ordered first by
> + *    category, then alphabetically within a category.
> + *
> + * 3. Standard supervisor-level extensions (starting with 'S') must be listed
> + *    after standard unprivileged extensions.  If multiple
> + *    supervisor-level extensions are listed, they must be ordered
>   *    alphabetically.
> - * 4. Non-standard extensions (starts with 'X') must be listed after all
> - *    standard extensions. They must be separated from other multi-letter
> - *    extensions by an underscore.
> + *
> + * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
> + *    after any lower-privileged, standard extensions.  If multiple
> + *    machine-level extensions are listed, they must be ordered
> + *    alphabetically.
> + *
> + * 5. Non-standard extensions (starts with 'X') must be listed after all
> + *    standard extensions.
                            ^and alphabetically.

> + *
> + * An example string following the order is:
> + *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
> + *
> + * New entries to this struct should follow the ordering rules described above.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
> -- 
> 2.38.1
>

Otherwise,

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks,
drew
