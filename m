Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3561EEDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKGJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiKGJZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:25:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF62918E16
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:24:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so15160221wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+354V4bqL0Q80jmGbwChiKqgB2s0lMwmgUyfQySGfaA=;
        b=E71QyXbP3nAgn6MM5N2pgIc3hT3H/iHfIUAU8Ieoh/Ek99yAgL4c+CSCtxXlJFsxi2
         oQKXQt5hRIoFkHwXg4zDilcpzkUaNn5sHtJF+RXJMDmKJ8GvRHLOYuf7jOjKILE7JLXz
         vkf3yrbpQNlPbK3hzs4yvXiGrtLXR4GhK1keNClzSJ68zTACMW9QOlIo3dJBkpqfZkNY
         rYqrcRMkTZr95zGNnMJDUjRbaAgqaqQQ7jKZjfPJlegxtwOWJfPsjbJQDHCwR7WObvjg
         sOXt/xfP3F5lmklHbFiX99USOs+IweJ5rmmNJ3FmYYsx54KH9yB5mizRKoMTndNF34LK
         R5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+354V4bqL0Q80jmGbwChiKqgB2s0lMwmgUyfQySGfaA=;
        b=ImzNKRjToJrEDUV1dLU7jfHyqjD0zJg3tOLY9QSFqWOOi+aWU29IxOYk0MnUKuB/aM
         /kMKGVyWeyb5pDzWwkEAMYXWo8Ywa0BNY54O0Gp1Mocxg9/IVav7bDu+fex7/3onzz/6
         DwHsw9TeJUTDAEScgNNi0q0g7UpOPPTrJxU2I3K0gkL1Obz2qq7CSuwYErqPkOamDE+n
         IWOPSaFrWLnV/QK74naoZxNMRz7mp8PZNGTiGrV5eojbu8Jv4e0agWkBLNFgpWC5gptJ
         1CGepZ1tHl3qAPgDp3zIrGEtf8uZzsTpBO2QYlL5qRR/z/8MyRVRUcu+PQD6y0IUq6xO
         Z++w==
X-Gm-Message-State: ACrzQf1yQKeaDlF+Bn9HQoLV8IKuwDx5r9PEoUlZZVA1cwpTUr5tj52H
        zin9kz9c8BrD3EOfDCkokRFs3Q==
X-Google-Smtp-Source: AMsMyM76jUbfY3U9anmFeQe0yqiI0jfkssTVhjiLNVk0IeFJjugyoiEQh76BCcrNqUAVsVF7XkG27Q==
X-Received: by 2002:adf:ed89:0:b0:236:8ef6:472d with SMTP id c9-20020adfed89000000b002368ef6472dmr28532719wro.61.1667813070284;
        Mon, 07 Nov 2022 01:24:30 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id bw14-20020a0560001f8e00b00240dcd4d1cesm2268916wrb.105.2022.11.07.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:24:29 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:24:24 +0100
From:   Corentin LABBE <clabbe@baylibre.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, heiko@sntech.de,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] crypto: rockchip: Remove surplus dev_err() when
 using platform_get_irq()
Message-ID: <Y2jOyPoor1hJ7xoV@Red>
References: <20221104074527.37353-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104074527.37353-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Nov 04, 2022 at 03:45:27PM +0800, Yang Li a écrit :
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
> 
> ./drivers/crypto/rockchip/rk3288_crypto.c:351:2-9: line 351 is
> redundant because platform_get_irq() already prints an error
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2677
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
> 
> change in v2:
> --According to Corentin's suggestion, make the subject started by "crypto: rockchip:".
> 
>  drivers/crypto/rockchip/rk3288_crypto.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Hello

Acked-by: Corentin Labbe <clabbe@baylibre.com>

Thanks
