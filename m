Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1735702894
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbjEOJ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238696AbjEOJ3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:29:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8C31BEB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:28:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so8213612f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684142917; x=1686734917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRBaFlhf9sFFgjiQBXj3BZflOgpJ96Bb6sKHpf2Tstg=;
        b=w51K1VOHufmt/cdo5w3wovdmoamaTl7lMVZxFXyP3ZWusdj94pYEGN60Mn9Ooj4rnE
         5rMJTFoOJbcZ/of+KvbrkjcxABJz2X4nxpdNCceheEmAtlwojp7jcYk3O2kfo2xwLu1g
         p0fUGqFltb7quYlp/4UbBp7s80AmcQXqO2kOS4edtOF/fod9dxWe+M3OhZ0Ko+E/P4Qa
         Wq+LQ/DZq7Fdyn5cAvqbv+oQ5IRg+PuDkiyZsKOtEx9GW1Cc7I1qdZuPfnjVyVwlH+jB
         jwtNmg33+8hGhnefPskKyhY3dXFUduJrjw3IJ6RKNtD/PKLmD9UEDdIcPgQh33GVQnyv
         LjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142917; x=1686734917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRBaFlhf9sFFgjiQBXj3BZflOgpJ96Bb6sKHpf2Tstg=;
        b=QDekxAcrCRvfRsfilPahHRQVayZIyzNu43ophwSt5XU6V814EgWlDp+IcO3aSmUxWL
         4ItPi99v7fnfYUmKoEb74DdYvXV5jirPgftRcckgWubcipJP/sSfPSFF+UmHYvEBhT7r
         C/ut01uVq8pGHrnB2FtMHZ1J+ocOibO5PPtfry5Jne2TR8XdHaOdjQsQGq37X9pQmH76
         yocmQqoyQ4gagGtuFolkfAeTC2BGYGinvjeT94XjZo7ajJEFLKkYKkpSy0Kzr/qkzkg+
         OULKWBSNipmS6/gsHZetQRK8vtKkPnuPfMZjMCMv2E22J1glx+lbFXTkPTrNfnKYx4u7
         Afaw==
X-Gm-Message-State: AC+VfDxi6O/dOWlX7eg34YGnZj2dIm6jWSfrdZPlWblS2wQKQneuCWBS
        oyfDXSnaCp1GZShAnjM/RZQBoeenSiRC0vWum2g=
X-Google-Smtp-Source: ACHHUZ7PbioezIsR65ywi6/2ShhPZZoflieboKI5tlTUmDknlGjBF0hRQiD/bbU3CrRMH0nAD1PH1w==
X-Received: by 2002:a5d:58c1:0:b0:306:20eb:bedd with SMTP id o1-20020a5d58c1000000b0030620ebbeddmr21733882wrf.51.1684142916991;
        Mon, 15 May 2023 02:28:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d4ec2000000b003063a92bbf5sm32022989wrv.70.2023.05.15.02.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:28:35 -0700 (PDT)
Date:   Mon, 15 May 2023 12:28:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     wuych <yunchuan@nfschina.com>
Cc:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] net: liquidio: lio_core: Remove unnecessary
 (void*) conversions
Message-ID: <61522ef5-7c7a-4bee-bcf6-6905a3290e76@kili.mountain>
References: <20230515084906.61491-1-yunchuan@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515084906.61491-1-yunchuan@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 04:49:06PM +0800, wuych wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  drivers/net/ethernet/cavium/liquidio/lio_core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
> index 882b2be06ea0..10d9dab26c92 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
> @@ -904,8 +904,7 @@ static
>  int liquidio_schedule_msix_droq_pkt_handler(struct octeon_droq *droq, u64 ret)
>  {
>  	struct octeon_device *oct = droq->oct_dev;
> -	struct octeon_device_priv *oct_priv =
> -	    (struct octeon_device_priv *)oct->priv;
> +	struct octeon_device_priv *oct_priv = oct->priv;
>  

Networking code needs to be in Reverse Christmas Tree order.  Longest
lines first.  This code wasn't really in Reverse Christmas Tree order
to begine with but now it's more obvious.

regards,
dan carpenter

