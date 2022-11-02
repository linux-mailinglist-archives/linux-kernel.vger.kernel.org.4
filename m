Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C586B616D79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKBTIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiKBTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:08:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E065B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:08:13 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f63so866353pgc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MP4BRb8G//EPCRvu2R9JlpbDgZN8CsDsH/DZd17igRc=;
        b=dHoOR0YlYQtvqMoSMwAA7OBKvtTSbcXODHS/Tc0Vwebvsj7WgnjwO2vkTQMnOUerVl
         Sez8FzszOPreD3wyT3vR75Ik/paR44SwUNoobbY4CvGd1x83IeWfcpIid0cOTD4cGxY+
         RAmG96gPfVD1McsBaKMas2XcZK5sNRuZplaak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP4BRb8G//EPCRvu2R9JlpbDgZN8CsDsH/DZd17igRc=;
        b=scWnzqnmRUVMAllFPVEzqPixFoufW891FSznzikC8R6K7Vlt0V6PKH1TR8itQcLoM/
         xq0co+NyldcVKGqcRwVZ9v3T2F0j/qCeweYxgn6j4YnCdFMtXeLSfCNm1gfjc5gQcruk
         3JXTrPXKilED+s426rlG6WbbK5UyCB1LmNRrf4WMc8c1ZggHBNyOrT99lmdfe3kBxz3b
         bxH3u+T/PXSp9yxBjpLFnINK0ck4R00WtyvhqBXWsGnJCB7HSUMDKYbH5E8WUTm1kTUV
         zm7VLf926xGtW7WjEpkKUFjKGDTFw3yub5kUsXEyHLC8vzlf3nBbuWz3icjq9B+px/Yv
         oT1w==
X-Gm-Message-State: ACrzQf3SIezX0EpU8gJW7AY60rgSD8tSQG6HMnUI8VOll7zjQWOZRyDu
        pUhYoR1rIrPSoigcPXsAX/ujug==
X-Google-Smtp-Source: AMsMyM4IPUBovsejFQ8GfXnwAMEHsuPP2poW/HAI5FGF+wlubnRaKN5w5zkxEia8sMYYO6FsV2usMA==
X-Received: by 2002:aa7:9624:0:b0:56c:8c13:27bf with SMTP id r4-20020aa79624000000b0056c8c1327bfmr26851190pfg.20.1667416093082;
        Wed, 02 Nov 2022 12:08:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a2f0400b001fd76f7a0d1sm1779954pjd.54.2022.11.02.12.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:08:12 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:08:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] net: ethernet: ti: Fix return type of
 netcp_ndo_start_xmit()
Message-ID: <202211021208.F66688DFF1@keescook>
References: <20221102160933.1601260-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102160933.1601260-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:09:33AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/net/ethernet/ti/netcp_core.c:1944:21: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit         = netcp_ndo_start_xmit,
>                                     ^~~~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of
> netcp_ndo_start_xmit() to match the prototype's to resolve the warning
> and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
