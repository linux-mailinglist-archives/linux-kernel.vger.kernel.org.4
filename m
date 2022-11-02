Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94680616D74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiKBTHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiKBTHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:07:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D822AC3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:07:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b185so17244868pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al21TcPJt8to6DKIHKPsHPs63wTLg/3m3c5X1IY9ZVk=;
        b=OcMa2PXvffEHTQunOgnNyVVSveU1Xb65KX1gioYtZk3gy2NegHqZ67GKmvzpjPnDJl
         zKfuWdA2xd3gYCvHb+t/2yRIVb2JA+hl9J9vsDf3NoLYr2nWYglOAJ7O3AmVFD3BBhXm
         60sjC1gk9vHdyyZ1gOJyAbff5s4FGFzZCbOtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al21TcPJt8to6DKIHKPsHPs63wTLg/3m3c5X1IY9ZVk=;
        b=nNU0omhooTcO4oGWNV4EuK5AglCbl4fqPwyY4+E2hJeXrYSqmVupgvC026awt4VMdk
         +4g3BQy2zVgk/RpWio6SIx/uo6AXogcRiTdRkUKANhaSNNtIA9hwFrCtPzUprN5455Wu
         qLF6yqFdddtfCuvvuBrA6BXtY7M2M3NzRLexVglEcuvhBHn0z0YMfJkrh0WOgEgKUoUB
         IowOeErmzbHiAC/hhjA9wPPCE6zHILoRvq5tZorRCBcccHzoEJAoUyZs+9eexg04iQKV
         14+uf20LlItfrSeFiFLQsWZXPGbOGFpTfBjZiQyqA4gpRWWXU2oziiclznNwkzOjQ15H
         bdqA==
X-Gm-Message-State: ACrzQf0oC5bKMvI9FYgPdyA0+soGio5PpxKqDX59Q0Acffyj+GY7rdqn
        Adl8IH0zjmALSN7lmPYboHWYoQ==
X-Google-Smtp-Source: AMsMyM7e7i+B4cU9w/Cyv/Fyf+gg4EoaUzMwpOjPVeEN10vhsy2lFnKC9AXyAPa+74dzy4vTvNDnfw==
X-Received: by 2002:a05:6a00:140d:b0:528:5a5a:d846 with SMTP id l13-20020a056a00140d00b005285a5ad846mr27168744pfu.9.1667416023443;
        Wed, 02 Nov 2022 12:07:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e64-20020a621e43000000b0056be7ac5261sm8822038pfe.163.2022.11.02.12.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:07:02 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:07:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] HSI: ssi_protocol: Fix return type of ssip_pn_xmit()
Message-ID: <202211021207.8F7604C860@keescook>
References: <20221102160233.4042756-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102160233.4042756-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:02:33AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/hsi/clients/ssi_protocol.c:1053:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit = ssip_pn_xmit,
>                             ^~~~~~~~~~~~
>   1 error generated.
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of ssip_pn_xmit() to
> match the prototype's to resolve the warning and CFI failure.
> Additionally, use the enum 'NETDEV_TX_OK' instead of a raw '0' for the
> return value of ssip_pn_xmit().
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
