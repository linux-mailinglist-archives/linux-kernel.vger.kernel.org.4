Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792837129D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbjEZPnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjEZPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:43:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3D410A;
        Fri, 26 May 2023 08:43:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-970028cfb6cso166452466b.1;
        Fri, 26 May 2023 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685115782; x=1687707782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rVpwhBhZjm4u1PvolKtSrwJ++hTN+rljYI2eWWd/rv0=;
        b=g1pKCw2HscEcTD2GSPzJcYYGnMv+ROG4mE/6/SigjSTX8eiwhWxP0BhCD/H4icUkHo
         r6IuwTfsrmcU4LAIJVM2PyWwd1bjjyBBr034WXEIrlxXQI/LVBM+E7EA0elIQDJ8Djtb
         N1wlACq8KMzwqpp2rfsQ9kL9GQYnAiEPPQIstlU7wg0AJ2zqHuo1am4MzLj4YdNLdQct
         /cOWOV/PTUtDKBa9rsYWxTuzYvyrgn8b/8WfUUnYgbaI+GfsAdesMSD87roP64nEs6pI
         pgHKPgiUm+GSZ9nCCBXCnp0Fx24vq8yR6H+DBI3k8a4/lJIQEgJk0VYRpcVzZLd3Ev3u
         vcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685115782; x=1687707782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVpwhBhZjm4u1PvolKtSrwJ++hTN+rljYI2eWWd/rv0=;
        b=E2vRz+UKdGbsGrc8kNEf3C22KjQjkTvQIovowA9ovTop7v/OX9C93TBondWgkeIXFk
         v1lTwR6fkfd1lRo7MvKF3hPE1kZP8447IouQIN2KS4vI/5soWl5IxUl+kxp97/NXrTWF
         qRNl7J4bppUqXPLTlA2p22C7Q8MT5LDoJayUvuT2QDxksp2D0h5G5vY0PGYhkbtTgnaj
         pde47VgsiStCCFrYZ4pvuXZC7wl38I+BlIiLy8AUeadfp3A8UyFPWwX3W25InnNBuXVC
         5NQ8N/VFUDXwSq99UiDdA1rSpu58z+xwGRTiVbJvqrYeEqgOeTLAYwOTHSHtl8lf62le
         9KLQ==
X-Gm-Message-State: AC+VfDzxz8BLcZWGZkW6MV9KdGTT4aGXciwtrCg7SnxiqYB4XexH7xsU
        VExfRNxudo08PnCqr3JrBAM=
X-Google-Smtp-Source: ACHHUZ7ENqk+5BVzxKJXJxcqn1R2u/aOB0IQFM/e6/2oz6itZMbKG26Hj93JeZvFUEvEL21RD2w5Sw==
X-Received: by 2002:a17:906:ee82:b0:96f:7af5:9e9e with SMTP id wt2-20020a170906ee8200b0096f7af59e9emr2410888ejb.53.1685115781493;
        Fri, 26 May 2023 08:43:01 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id gr4-20020a170906e2c400b009660449b9a3sm2266901ejb.25.2023.05.26.08.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 08:43:01 -0700 (PDT)
Date:   Fri, 26 May 2023 18:42:58 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 24/30] net: dsa: mt7530: rename MT7530_MFC to
 MT753X_MFC
Message-ID: <20230526154258.skbkk4p34ro5uivr@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-25-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522121532.86610-25-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:26PM +0300, arinc9.unal@gmail.com wrote:
>  	/* Disable flooding on all ports */
> -	mt7530_clear(priv, MT7530_MFC, BC_FFP_MASK | UNM_FFP_MASK |
> -		     UNU_FFP_MASK);
> +	mt7530_clear(priv, MT753X_MFC, MT753X_BC_FFP_MASK | MT753X_UNM_FFP_MASK
> +		     | MT753X_UNU_FFP_MASK);

The preferred coding style is not to start new lines with operators.

> +/* Register for CPU forward control */
>  #define MT7531_CFC			0x4
>  #define  MT7531_MIRROR_EN		BIT(19)
> -#define  MT7531_MIRROR_MASK		(MIRROR_MASK << 16)
> -#define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & MIRROR_MASK)
> -#define  MT7531_MIRROR_PORT_SET(x)	(((x) & MIRROR_MASK) << 16)
> +#define  MT7531_MIRROR_MASK		(0x7 << 16)

minor nitpick: if you express this as GENMASK(18, 16), it will be a bit
easier to cross-check with the datasheet, since both 18 and 16 are more
representative than 0x7.

> +#define  MT7531_MIRROR_PORT_GET(x)	(((x) >> 16) & 0x7)

also here: (((x) & GENMASK(18, 16)) >> 16)

> +#define  MT7531_MIRROR_PORT_SET(x)	(((x) & 0x7) << 16)

and here: (((x) << 16) & GENMASK(18, 16))
