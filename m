Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABF73D191
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFYOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjFYOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:54:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5111AB;
        Sun, 25 Jun 2023 07:54:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so214116366b.2;
        Sun, 25 Jun 2023 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687704888; x=1690296888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vwr9QncmErCcma1z5HXU+08eU15W5iGhG2cRYFjETk=;
        b=HFnmHx8+NOyasx0GY6Wh/jRt31cddH/5jq0fb6UgjCrQ/myAieduWNi4/PCDnmMT0S
         PzOhgnUYmnQPlOG1ex2hRtD2oOM+oz48+92b24zxKxU5Qbq6nnOa2QT+5BsXkTgWdJRd
         ek90G+jilJfkZC21/5jPUvp4Wh15KEbH5AI1vpqybAj5OgOPUac1nBuzdUoWkVuxIiJ9
         AHKM4OkvnDuVK2DFBw+tlpGXgsUK6tsZcfEPk1d1iXz0fP525Of75szQUDef3Gq8a76W
         91WGcuAuGp1/lA/s89NwcLsKX6phXpUZVYeCkbiM9iqelxFPHXKwnIAHPTPsie2Xjmlg
         hljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687704888; x=1690296888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vwr9QncmErCcma1z5HXU+08eU15W5iGhG2cRYFjETk=;
        b=KuPFeWxyW6rbQYQS0iDeuBAdmSGNUIEEnMSC1R/xh4lEQnkSy0jNM1m15PcXKHezNJ
         spFMr7epBSm9hyAcMnpf+SbFMEGwHOjBz3bPK+UNOXLEO3sw1eVdlXsRmLdAvlv5MioH
         QI/rPKPtVqzkm4Lgy99n9HAhnuBnCOlcOSOau+v/WzbNIGaLy6Rk79zrq538rlwiqmIE
         LnILLExgD05uwRlbRxnRsa8f9jPv89fBuguo5VfQ77Gocm8HFXVQ/EsRutCV28Nhc+DL
         oSk89dWgcAO4ovIxl0P+atCzjPUolgfLD2f6qjP8hAQE9Y8+dkdIj6hExsctti9CcMl3
         GEqg==
X-Gm-Message-State: AC+VfDwhr7AWsYL2vzle3OTSIlucttQB+HJo+lCQoO/avx02GLFZ/XsT
        oHuLRYbEv9LFzXUPXvcMFKY=
X-Google-Smtp-Source: ACHHUZ5QeOl1Y+2F11h7Iznk7njDlljlGH9Qiv+eec+jw6vxf/GlNXRdkUzVZg7pI4NxjXj7b1tY9w==
X-Received: by 2002:a17:907:928b:b0:973:71c3:8b21 with SMTP id bw11-20020a170907928b00b0097371c38b21mr24319497ejc.72.1687704887456;
        Sun, 25 Jun 2023 07:54:47 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id y3-20020aa7c243000000b0051bdf152295sm1814011edo.76.2023.06.25.07.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 07:54:47 -0700 (PDT)
Date:   Sun, 25 Jun 2023 17:54:45 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 7/7] net: dsa: vsc73xx: fix MTU configuration
Message-ID: <20230625145445.ialdexs2wxu6lu73@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-7-paweldembicki@gmail.com>
 <20230625115343.1603330-7-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-7-paweldembicki@gmail.com>
 <20230625115343.1603330-7-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:53:42PM +0200, Pawel Dembicki wrote:
> Switch in MAXLEN register store maximum size of data frame.
> MTU size is 18 bytes smaller than frame size.
> 
> Current settings causes problems with packet forwarding.
> This patch fix MTU settings to proper values.
> 
> Fixes: fb77ffc6ec86 ("net: dsa: vsc73xx: make the MTU configurable")
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Please split this patch from the rest of the series and re-target it
towards net.git.

> v2:
>   - fix commit message style issue
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index c946464489ab..59bb3dbe780a 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -979,17 +979,18 @@ static int vsc73xx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  	struct vsc73xx *vsc = ds->priv;
>  
>  	return vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port,
> -			     VSC73XX_MAXLEN, new_mtu);
> +			     VSC73XX_MAXLEN, new_mtu + ETH_HLEN + ETH_FCS_LEN);
>  }
>  
>  /* According to application not "VSC7398 Jumbo Frames" setting
> - * up the MTU to 9.6 KB does not affect the performance on standard
> + * up the frame size to 9.6 KB does not affect the performance on standard
>   * frames. It is clear from the application note that
>   * "9.6 kilobytes" == 9600 bytes.
>   */
>  static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
>  {
> -	return 9600;
> +	/* max mtu = 9600 - ETH_HLEN - ETH_FCS_LEN */
> +	return 9582;

This can also be:

	return 9600 - ETH_HLEN - ETH_FCS_LEN;

since the arithmetic is on constants, it can be evaluated at compile
time and it results in the same generated code, but the comment is no
longer necessary.

>  }
>  
>  static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
> -- 
> 2.34.1
> 

