Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A84370FD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjEXSI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbjEXSI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:08:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E25A119;
        Wed, 24 May 2023 11:08:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3095557dd99so1124262f8f.1;
        Wed, 24 May 2023 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684951734; x=1687543734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dfGLZw2z+tAZr+6s+X0j30LWgWmr1sjapi3S4gBoOoE=;
        b=q2Qo/qX8aKcmWcJF6gy59FYxkIpVa4M3ttp6vJ+895IAyMYhWwyvmHZem4b3OklFXl
         3KLIxPfVtUUv8qJ9HNCGa/v53XeaPDZuKXiLlesaPC32z4XP3PE2JyZ4Ynofa0TBT705
         E1FjhXeuZ4i0Eg5AkY2inXfcyNxBglrgJHM670xgpSxvu6Z3Hzds9Q4H2ncmz9NOOf3O
         g1gwwenCgUxADya9eQADwSIeoztpdPxbhc3Lz+AzlyfGReHz98nAhGGu771h5lYH0CPt
         b1NYobKxN1J9+4j4YwIuyDAYMmlPmbylhJyrKYk/CUXNowj4iu0fAUMdkfd3QSIceg7H
         8tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951734; x=1687543734;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfGLZw2z+tAZr+6s+X0j30LWgWmr1sjapi3S4gBoOoE=;
        b=hRsPhr1+ex5zwFtEgKCIhPtFf2V6AcdEect4zUW/8PR5ZZxywXvH2FPpJjr3pmbfCb
         3WSqVUOTY35qxfO76lGb+VWBdvUU+S1EOX2Qzs1Gu5YYvNxQJzTEjHPtCl7p8H9sKiQI
         C/5KlX/wZVjDdZhFk2NeNHjakB34le4WsGpUnDSmJe5ZJzU9wZ7njIdUjXvDiT1tDr5r
         9qDzjB5gd5N+bq8CNU17dw4KgpgVR4RCHaCiprTLY7X3cT+031yxiKZwolEzg4rKE5Oq
         FzvYaWCSyU4xExtGX/tURLuQ8dXGhdAvMDfOO1uREZFSOaod6z1v8LOT7W+wRigV9+85
         dZww==
X-Gm-Message-State: AC+VfDzscSvGmMIqNy8aSJ5NCHmqApqkCF4Kr7NuIfhqCXYcHtbr38h1
        hbvVNeC/8qTx5LdNLiMjnfM=
X-Google-Smtp-Source: ACHHUZ7Sf2YAfb5nZ0EbMpVeLJE07iRbAvLYuxkXBi3WWvgytfj3s06KheXiSrJJ0jg3a742Vzfx4A==
X-Received: by 2002:a5d:5384:0:b0:309:566f:3cd with SMTP id d4-20020a5d5384000000b00309566f03cdmr405284wrv.6.1684951733913;
        Wed, 24 May 2023 11:08:53 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id b21-20020a05600c4e1500b003f4283f5c1bsm8637601wmq.2.2023.05.24.11.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 11:08:53 -0700 (PDT)
Date:   Wed, 24 May 2023 21:08:50 +0300
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
Subject: Re: [PATCH net-next 10/30] net: dsa: mt7530: call port 6 setup from
 mt7530_mac_config()
Message-ID: <20230524180850.7zelk6x2dpiwmnw6@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-11-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522121532.86610-11-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:12PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> mt7530_pad_clk_setup() is called if port 6 is enabled. It used to do more
> things than setting up port 6. That part was moved to more appropriate
> locations, mt7530_setup() and mt7530_pll_setup().
> 
> Now that all it does is set up port 6, rename it to mt7530_setup_port6(),
> and move it to a more appropriate location, under mt7530_mac_config().
> 
> Leave an empty mt7530_pad_clk_setup() to satisfy the pad_setup function
> pointer.
> 
> This is the code path for setting up the ports before:
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
> -> mt753x_pad_setup()
>    -> mt7530_pad_clk_setup()
> 
> This is after:
> 
> mt753x_phylink_mac_config()
> -> mt753x_mac_config()
>    -> mt7530_mac_config()
>       -> mt7530_setup_port5()
>       -> mt7530_setup_port6()
> 
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
