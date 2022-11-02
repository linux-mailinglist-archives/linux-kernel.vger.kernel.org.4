Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AEC616D85
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKBTKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiKBTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:09:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FADAFAD2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:09:51 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y4so17507246plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rceJbOCflyPx+m+jp0CiAofr11KjGzc/BosMfyINF6Q=;
        b=nTYtdAKQoQK2ASSwLeh5CjtoKDvCTGPFgwhrrlZGkl2cUuG0T1larCOBHjiCgaxcl3
         mR5tmneD4Ly087+iJQrS+9FP1EuHQvmT50wZQm/dGpkkC7/4t0AOPCgKmEPjs3N90ViO
         ZDcJ6MKXWBsJMUwgYDBLNZZT7WVhJVj5MbCXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rceJbOCflyPx+m+jp0CiAofr11KjGzc/BosMfyINF6Q=;
        b=wZ8NDTMt/woa8FvhBAunCcj2fqmxnsG1eGoFahq0vJtjRi73L51K7f/ZBjaVSN/zY/
         wk9hOCK4qSp6saJezo2H94ZCLc/IPLM+K1ZYudTgiQ7/3sVcXRzUYZrQXCF2l6UBu6/H
         +BCTIbYgMi+ii2iyRDQLFFUN+DTCUTboarOK5p6m8xT8CHvNbk34QuoP6E7XimJb5gYe
         q8nupZk08zf0WMRlsQL6eyHBhdtjj2Gb4SQP17vqTW8cZX99463IQGAxZdLT9ke9PL9M
         mO4cP1eBivSmn50Y4H1C1OyJ48Wb3QOQ9Eny/+jmuk2hvHNWeYXiYMmbp4m0QfO8XcBh
         LcAg==
X-Gm-Message-State: ACrzQf2FrTbP9VOWVEwpGoW+y2TwEaBSZZqpWDSb/xWfeIKPTY+aT8bP
        n0FNDj7Oe7j4YyBans0vAjVCIg==
X-Google-Smtp-Source: AMsMyM5iaPa8jHtaXe8TTihPGNBmjZOrJkjawt950HiY8oyo6JC1DPwtgOaOwWhqRWTHHvmX+izChA==
X-Received: by 2002:a17:903:1303:b0:186:969d:97cf with SMTP id iy3-20020a170903130300b00186969d97cfmr25743179plb.17.1667416190610;
        Wed, 02 Nov 2022 12:09:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ce8300b001782a6fbcacsm8698407plg.101.2022.11.02.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:09:50 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:09:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/3] s390/ctcm: Fix return type of ctc{mp,}m_tx()
Message-ID: <202211021209.276A8BA@keescook>
References: <20221102163252.49175-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102163252.49175-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:32:50AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/s390/net/ctcm_main.c:1064:21: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit         = ctcm_tx,
>                                     ^~~~~~~
>   drivers/s390/net/ctcm_main.c:1072:21: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit         = ctcmpc_tx,
>                                     ^~~~~~~~~
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of ctc{mp,}m_tx() to
> match the prototype's to resolve the warning and potential CFI failure,
> should s390 select ARCH_SUPPORTS_CFI_CLANG in the future.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
