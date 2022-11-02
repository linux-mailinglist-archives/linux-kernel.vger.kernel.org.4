Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F09616D77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiKBTIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKBTID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:08:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ECFC00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 12:08:01 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l6so17166816pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 12:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vw1PeYfYrmcqxsdFm8vSKj6yNnyKJrjXBsCDkZ8l7vk=;
        b=XNJLSicRjEN8rmTBOFq4nZjBNIwb3bfbU77PQOf7hvq7/KsYyf4RBy+5zc2UAJlGhc
         TMgcRxRmNxosn3VWIIRRCpYt9DoDGwFFE5H6e1NdTJGJbA1bAcnhH8n7lpiKmKZMfShp
         b+fHS0RnxesbdRP/UtHxZ3cWF55CBAMmG0h1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw1PeYfYrmcqxsdFm8vSKj6yNnyKJrjXBsCDkZ8l7vk=;
        b=d6Jww+PiBBU2sKZLDPvBeeVP/u3oCM7iSqpYPjyCSMjdwiMkm5nVUx1qKybfvE0HUN
         r4eILRArGKYZQTasoqS2p9mSiIRG+w6bZmUANzXmuxcXR/tXrH0jlN15w4eOIB6wKFbk
         AHBxlaASgU5Esx7ch4ZCC8+FfaVllgGrHUcbNrD5YZP4Hti5/LHuZesfWcuRKvTHj9jp
         adyDqB63HKr76Z4QIAow6s1os4aXDLUehBYnz6518mvztbrc8J7TJ/kdxGaVMfHvgiI4
         6AOh+cCC9miw1uwl4ywdK8WbuaHg80dDLq3RDNj2T+dZrz30Ces3LfCadrSjs6fTLqck
         tsxQ==
X-Gm-Message-State: ACrzQf2tWE90Q9a7LY7/Hs1/ccDDSV6bUjtPU6X7uShR0kT1WNVhNQOg
        eizsr/T/5F0/bIPXPRmM0KMr+w==
X-Google-Smtp-Source: AMsMyM7I9I7fudr6NNXqLACM4CekbYXQHH71Q92LDGS3KIiSUx5BXYQkZEVhg3knX05G924q3TSVHA==
X-Received: by 2002:a17:90a:3947:b0:213:ebeb:2cf3 with SMTP id n7-20020a17090a394700b00213ebeb2cf3mr16561908pjf.9.1667416081215;
        Wed, 02 Nov 2022 12:08:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h23-20020aa796d7000000b0056d2e716e01sm8015248pfq.139.2022.11.02.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 12:08:00 -0700 (PDT)
Date:   Wed, 2 Nov 2022 12:08:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Sailer <t.sailer@alumni.ethz.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-hams@vger.kernel.org,
        netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] hamradio: baycom_epp: Fix return type of
 baycom_send_packet()
Message-ID: <202211021207.E41AE398@keescook>
References: <20221102160610.1186145-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102160610.1186145-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 09:06:10AM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/net/hamradio/baycom_epp.c:1119:25: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit      = baycom_send_packet,
>                                 ^~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of baycom_send_packet()
> to match the prototype's to resolve the warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Heh, this one was already using the enum for the argument to "return",
too. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
