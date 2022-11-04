Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8320F61A0B1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiKDTRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiKDTRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:17:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E107D48748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:16:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j12so5761214plj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwf9cNrPS5Rc31CwAis9I5k42+w3JYRmcdVU7DdGiu4=;
        b=N6TFAIctV4hgpYE38ZyX/b+J/o7aIK0+cR8rBnXD24Pic0BLxQcHU237p09FZeLrX9
         6yj0AmbLE6V1HcPmWLID7VETZlaV+M9dng3VlpfIN3WNRO3xTYAAiE2momLGKWMNEkhQ
         G4VT1cqNjnQ6Oe4tlUOO1WbSzvJVPgeHtyRA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwf9cNrPS5Rc31CwAis9I5k42+w3JYRmcdVU7DdGiu4=;
        b=4kNj7pqjbq+qwetMoCsqNMHg15uy/PWG6GZzk3Aqx5UPdVXYXoE51dv91yxM003hQC
         QGp3XHNyEZNxQgAIywlDL9DSRvTkb34OQPKT4DrWkk/ng3hLy10MQWfLtkUlyM0hDXe4
         0xMW741DjsF+1jE03NmVJF2eSBP9XIDChnBDM+BlVsUoY8X3QUSN1Nd/EY0Dq2YQ0ODn
         uEgxUPG4kee8Cv0zBkRyO3Br3ThDjtPwJcPPMrEQSQUYSMXpzFQv4Q+IHWmfymjGa6hB
         HS8ul60xS+Hvfj2LSxTwSsdnz6LNeLu2m1HfP4dHx4YiQ1P6KFt4jSUdqmy8orwbJr7o
         cr+A==
X-Gm-Message-State: ACrzQf3yBaROphL1zArSBL3p22yamS8zm7IWlR6Mq996KnP4FgHCopGM
        pytuWgeABkEQNihm9VSvTxPLGA==
X-Google-Smtp-Source: AMsMyM723xbKuDkCJ7wXLAB+SxhuL5RfQWSJSVDW6OhzUsKHC44G/DKWPnsbHUAvL7N0/sG7WSCPRg==
X-Received: by 2002:a17:902:8693:b0:17a:f71:98fd with SMTP id g19-20020a170902869300b0017a0f7198fdmr37053238plo.25.1667589419426;
        Fri, 04 Nov 2022 12:16:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e38-20020a631e26000000b0046497308480sm74704pge.77.2022.11.04.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:16:58 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:16:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH net-next] net: ethernet: renesas: Fix return type of
 rswitch_start_xmit()
Message-ID: <202211041216.AEE2A8A353@keescook>
References: <20221103220032.2142122-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103220032.2142122-1-nathan@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:00:32PM -0700, Nathan Chancellor wrote:
> With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> indirect call targets are validated against the expected function
> pointer prototype to make sure the call target is valid to help mitigate
> ROP attacks. If they are not identical, there is a failure at run time,
> which manifests as either a kernel panic or thread getting killed. A
> proposed warning in clang aims to catch these at compile time, which
> reveals:
> 
>   drivers/net/ethernet/renesas/rswitch.c:1533:20: error: incompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_buff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, struct net_device *)') with an expression of type 'int (struct sk_buff *, struct net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
>           .ndo_start_xmit = rswitch_start_xmit,
>                           ^~~~~~~~~~~~~~~~~~
>   1 error generated.
> 
> ->ndo_start_xmit() in 'struct net_device_ops' expects a return type of
> 'netdev_tx_t', not 'int'. Adjust the return type of rswitch_start_xmit()
> to match the prototype's to resolve the warning and CFI failure.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1750
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
