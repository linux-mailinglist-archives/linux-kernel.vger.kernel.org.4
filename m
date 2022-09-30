Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0D15F14AE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiI3VYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiI3VX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:23:59 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E985D1C2943;
        Fri, 30 Sep 2022 14:23:58 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id t62so5983244oie.10;
        Fri, 30 Sep 2022 14:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Egx5XjNvstllYfKUMVpC+IMEYscFqCls2I9zPgjCRII=;
        b=J7ItJwQd4gTttN0FY7fMhW+xN8ItmbUNrNnjWDUb1dB8/WL59yBt3G/S6S0Xr1K08+
         1b9yqLJ1ZKC9f+hcefEX6bxck9DhAi04Wbwwz8kiNJwW9sD9N+vTTUsU1p1GnJNH0eBq
         91WJzz5Q6O8nBjWncLmwhBtPoa30iFzTCGyMg7E21uSCSoA3LXkywwv91JnyOTWX8/gE
         yO7i0i6RGiWM2gAX/Tkfn51Vj3Ed6FzIKfSPpHZr9uskF7cwdLZmDC14/PqkwqGfAiSf
         VvCUMZxyegD9X/Mx4OrGFf8Fa6t2YyMQD2HpgfC+xSmr8yXnL2l3kzexYj54CVEIw6IR
         X0sA==
X-Gm-Message-State: ACrzQf2vvJxiAdIKA439Otzw1Ys2y6pGHEKtv52DoA+V3obS3JPijj+V
        dBDEjl8IbulN1pYqyJIPKycFINCvww==
X-Google-Smtp-Source: AMsMyM401TunIp/xhW82QrMrLefnhxpOtKcr5l/iVVgG9t+R8vLtv5k0jWhe9oZViulvsEQM+fnemw==
X-Received: by 2002:a05:6808:13d4:b0:350:7653:234f with SMTP id d20-20020a05680813d400b003507653234fmr63223oiw.223.1664573038207;
        Fri, 30 Sep 2022 14:23:58 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ep31-20020a056870a99f00b0011bde9f5745sm979273oab.23.2022.09.30.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 14:23:57 -0700 (PDT)
Received: (nullmailer pid 1071686 invoked by uid 1000);
        Fri, 30 Sep 2022 21:23:56 -0000
Date:   Fri, 30 Sep 2022 16:23:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] of: base: make of_device_compatible_match() accept const
 device node
Message-ID: <166457302846.1071517.4315827909600989170.robh@kernel.org>
References: <YzY5MaU5N4A2st5R@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzY5MaU5N4A2st5R@google.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 17:32:49 -0700, Dmitry Torokhov wrote:
> of_device_is_compatible() accepts const device node pointer, there is
> no reason why of_device_compatible_match() can't do the same.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/of/base.c  | 2 +-
>  include/linux/of.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!
