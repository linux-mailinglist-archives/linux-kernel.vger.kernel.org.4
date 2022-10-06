Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144D65F6E49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiJFTi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:38:23 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88DCE99B;
        Thu,  6 Oct 2022 12:38:22 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-131ea99262dso3360558fac.9;
        Thu, 06 Oct 2022 12:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLi+SmOjuiHZas5Uo0fpsaeIgV2ah1++3G/ReG05304=;
        b=K+WDifHblpyQuhZVF7+6ilj8u9tsIR8ZHTt2Ta+bcs4+bFO12BOdGDig9IowmlyaKh
         CMi2U1eOXQ+YsrqqMCcIU9BdPZfm1OmfOoFF8h0M5x8ijIR5U9YEkZRZneItb6szL6nI
         LORkpZE8AgbXSqiFrjt1xPojlTEdWEgEdh1ALK2Cq/1PcHRmoVdbwbW7qbDjfc4CA+HM
         8dz7O99FG3xE0aeVUytmxeySliaLUgbqK3NSPNMaFmde8E1dWMFdxMPgJOAt8TtgJXhc
         BQ9YWIXU9rjmd+Izkxd4bXA3aCb+rWYxo237Yuj/bBhaIfg6lku3vYMVwLdDOpds85vN
         6fwA==
X-Gm-Message-State: ACrzQf3S152kDm/WemJUSEIqSUpHQmSl2z/j9jdrlw33pMGcRcf67eVv
        uIOLwMdKXg89JxEiL/aUEw==
X-Google-Smtp-Source: AMsMyM6bDsahQ07UQdvwstE5A9s5XOU/6fwsKNFzWETEYZpA94Cimw6JBSRrg+vKc4zsb3lLACAnvg==
X-Received: by 2002:a05:6870:479a:b0:12c:fdf7:e898 with SMTP id c26-20020a056870479a00b0012cfdf7e898mr708722oaq.289.1665085101668;
        Thu, 06 Oct 2022 12:38:21 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id bd18-20020a056870d79200b0011f400edb17sm346527oab.4.2022.10.06.12.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:38:21 -0700 (PDT)
Received: (nullmailer pid 65490 invoked by uid 1000);
        Thu, 06 Oct 2022 19:38:20 -0000
Date:   Thu, 6 Oct 2022 14:38:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] of: fdt: add stub for early_init_dt_scan()
Message-ID: <20221006193820.GA61296-robh@kernel.org>
References: <20221006031116.13586-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006031116.13586-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:11:16PM -0700, Randy Dunlap wrote:
> When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
> SH3 build fails with a call to early_init_dt_scan(), so add a stub for
> this function.
> 
> ../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
> ../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
>   262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {

I think that sh_fdt_init() needs to be enclosed in 
CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.

> 
> Fixes: 7480e0aabd5f ("sh: add device tree support and generic board using device tree")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/of_fdt.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -85,6 +85,7 @@ extern void early_init_devtree(void *);
>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>  #else /* CONFIG_OF_EARLY_FLATTREE */
>  static inline void early_init_dt_check_for_usable_mem_range(void) {}
> +static inline bool early_init_dt_scan(void *params) { return false; }
>  static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
>  static inline void early_init_fdt_scan_reserved_mem(void) {}
>  static inline void early_init_fdt_reserve_self(void) {}
> 
