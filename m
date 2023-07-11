Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24CD74F805
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjGKS2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjGKS2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:28:05 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7058919BE;
        Tue, 11 Jul 2023 11:27:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so74428185e9.2;
        Tue, 11 Jul 2023 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689100071; x=1691692071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uY50bhfklwYom6IbFHdDY1XKnR9zwxPbXW3WB2UupyU=;
        b=RWaG0sP3x2YIg5aKevCdAMmLZT83c2FrrbgfmqwS7pZlxU6ab4xZCkQENYRD9NvnFR
         Xz7xr7o/VJzRT0fctp3QMC0TZeAeKE6fu8J6UGEnE17lNFMArv7tUKgqKpE8vLMQSIiD
         0MsxdDnZoYhYxs2pW4XQFOY4MOUI7HujXZI+bDSv6EHNlFZISUDU8bN/N43w+Rfd6oBA
         dgVBwd6wWBRvSIq6HxR/OmaEKS//BGrWuZTx6lynL1QjUpKcl8qslQ48LwyS8MlKclX8
         ZAKQbpDRSL4qLkheFUSRfT0zTrCLdTT6Hv1MrgZhnxaZDJc7TC20O7fC2MavzRdJKMpL
         /X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689100071; x=1691692071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uY50bhfklwYom6IbFHdDY1XKnR9zwxPbXW3WB2UupyU=;
        b=lxYwsEZYrkosAp/wmdkfplJxdnWRo5dRegCd1NRk+GT33jmPtM9Sd4f7lIwIONrqrg
         saxH9GR69JX27yEunrjZqEu5inM+UljjJpdTS0mMhaBYNtxWKdk+NtUaaEN8WSZ2ZADa
         vOFrdJgPLGxMAxcszqlsbRLK8wKgwKaC3K55onWjbzKgjHkTAETtZFHiYBwbqA0BHjXI
         pFMEx5Se0Z1Mr9O8cki+Qui53yv2/xHiMrN77tVhkwx8pho11AjI6EKxkQGwyrDZMEuy
         3dqJOnKEo0EywYNR0bhgY9CK9Gcfjagnn6428GgrMbz3W0OSs0ewl+DLQqFja9KFxyTQ
         TGMQ==
X-Gm-Message-State: ABy/qLa2xbfeJWcgmtXOup+BS2TuC1JHK3wqJv3gsfUalUPnn1hFZC/9
        gpvDLLVx9gbXVeEcZj2f0FA=
X-Google-Smtp-Source: APBJJlFc4oDq1avIkEm53uwVKsR4aP34NcWZvU8wFGjGRSwXz5Z9yA0NUsBwqFDZyh2iYIWORi/COw==
X-Received: by 2002:a7b:cd94:0:b0:3f7:f2d0:b904 with SMTP id y20-20020a7bcd94000000b003f7f2d0b904mr21276033wmj.8.1689100070637;
        Tue, 11 Jul 2023 11:27:50 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003fbd9e390e1sm13643250wmc.47.2023.07.11.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 11:27:50 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] Input: sun4i-lradc-keys - Convert to
 devm_platform_ioremap_resource()
Date:   Tue, 11 Jul 2023 20:27:49 +0200
Message-ID: <5846980.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20230705052346.39337-7-frank.li@vivo.com>
References: <20230705052346.39337-1-frank.li@vivo.com>
 <20230705052346.39337-7-frank.li@vivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 05. julij 2023 ob 07:23:43 CEST je Yangtao Li napisal(a):
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/input/keyboard/sun4i-lradc-keys.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c
> b/drivers/input/keyboard/sun4i-lradc-keys.c index
> 15c15c0958b0..95d927cc8b7e 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -307,8 +307,7 @@ static int sun4i_lradc_probe(struct platform_device
> *pdev)
> 
>  	input_set_drvdata(lradc->input, lradc);
> 
> -	lradc->base = devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, 
IORESOURCE_MEM, 0));
> +	lradc->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(lradc->base))
>  		return PTR_ERR(lradc->base);




