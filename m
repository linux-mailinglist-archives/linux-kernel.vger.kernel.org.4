Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F874CE66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGJH3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjGJH3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:29:47 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD0100
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:29:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so21695535e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688974185; x=1691566185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2jy5zTnsEjclW0IAo6TI4KH09ecPC4N8l96twGj5N0E=;
        b=OBAbthM1v1c78/ZzCyTdIpwTdHirp2JVWB3eDHKM3yppE8P3aW7bDozXCSbCfWCGvo
         aUJhkV9MOOBlgcArpIE7XMWjWnsRdnWwGgRD7j1RpPrD6eiToYHeHf0/kHKrsAl7vs9Q
         0LVNAuVBm9Ag0wKK7btutonbmGXnR2ZHigLTSRfxBYaD6A3CvlGEsVGLMurOCq3bsgXN
         kT2XnduE6CYa7eSe9Cm105uUZIE1A28AyWSzVEhqkOhUbrp6kdT/+8dDEGqEYo0mlC0N
         +p/NmuArdn1E3yfJPZxONsLJNo47TFfmB+uq37uCzOY1HYBrZaypYGD2le0rnusaQ9Wu
         fGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974185; x=1691566185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jy5zTnsEjclW0IAo6TI4KH09ecPC4N8l96twGj5N0E=;
        b=aBUHNrIM3ii1CWHBgcZbMsxa7M660lgezNt7tWVraZVAeUQmv4ofdpMY5LXj+0ovBG
         KA048fYk3iDu0HZtCmNgdPMBXJQzVsaHHe18VsASLkQjWnA6L4u3cV1nUkldivh5Z6UJ
         e1a4FXJa3AULcQfYgPMY2jArN5ETGz+Pn9NKRA77vm6QHT3c19jGPkMd6bjVbLeOCjxj
         nBPJ+m9onT/tKMEOir8D84xjAs3p3FEoTGqgFFRh4ARCdOiCAs3jMwlmfzxVkaV1KPCb
         n7+1oiWPp08IaRjeGR5BuoJD4Kb1s07SBjStuANmTttYdMLEAc+MSD7G7rinOFSXJ366
         2npQ==
X-Gm-Message-State: ABy/qLZj82XQgIQ8WreCdCNFGIsZZofBL74hpq6PNRDDw7PvQSzP0nnO
        rqBxCHd+E58/6rXXsz3vFdMBKw==
X-Google-Smtp-Source: APBJJlHVp1/4Jh3pSjHcnXhiWDH/u3GR3xaCfeHhiOKMO2azzBEjQPQEy5nxXANY+hMDz9a27mSt/A==
X-Received: by 2002:adf:f592:0:b0:314:1d6:8aa7 with SMTP id f18-20020adff592000000b0031401d68aa7mr10971747wro.29.1688974184893;
        Mon, 10 Jul 2023 00:29:44 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v12-20020adfe4cc000000b003143cb109d5sm10790399wrm.14.2023.07.10.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 00:29:43 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:29:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     qiang.zhao@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, wuych <yunchuan@nfschina.com>
Subject: Re: [PATCH net-next v2 01/10] net: wan: Remove unnecessary (void*)
 conversions
Message-ID: <45519aec-6ec8-49e5-b5b2-1b52d336288c@kadam.mountain>
References: <20230710063933.172926-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710063933.172926-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 02:39:33PM +0800, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
        ^^^^^
This doesn't look like a real name.

> 
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: wuych <yunchuan@nfschina.com>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index 47c2ad7a3e42..73c73d8f4bb2 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -350,11 +350,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
>  static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
>  {
>  	hdlc_device *hdlc = dev_to_hdlc(dev);
> -	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
> -	struct qe_bd *bd;
> -	u16 bd_status;
> +	struct ucc_hdlc_private *priv = hdlc->priv;
>  	unsigned long flags;
>  	__be16 *proto_head;
> +	struct qe_bd *bd;
> +	u16 bd_status;

Don't move the other variables around.  That's unrelated to the cast.
(Same applies to all the other patches).

regards,
dan carpenter

