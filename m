Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FF711784
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbjEYTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEYTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:38:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9AFE7C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:37:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so4371849a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 12:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685043388; x=1687635388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=omMTY1or9SrrKMZELZLQH6rGhEK2aJzxF2jTBqOVLSU=;
        b=wg5c8jdhw6dhpnaxYlwmSH7K6xXkIFO0nKelPkT/j17pdZeoabE3GVMdIbCICDY+BJ
         3PX2PDFshXCzFZe81mX7I439XErrxtdgcDIwhpxCTHbxuWBlQge09bXRv46SHV/Iohgw
         0lIafwSRDPNOKIbBcremXoHfdXrc94AYh86bE4AYplQBLB5j/fmgfJjLC8xB0toJniP2
         708YpPTc6F+T4hNZfaTyywYD6NOjR7I+e2Qk/dIyt3kHmEvSaQDhtjV+uXwqjBN+DFyY
         BNnJ7fjuTpqZRiKzqWzhcB//2Q2ub3itZAfEljYDZ+Jc0YvTtcZ9p3u3XAtt4rkBGuHn
         nfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685043388; x=1687635388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omMTY1or9SrrKMZELZLQH6rGhEK2aJzxF2jTBqOVLSU=;
        b=aArv/g709c5Dt3hgqzeQndHtIRwjXyJ54hETffwY71WRuQSQ7U/EhR8g9CCesUykQ6
         4zcmZVaXqzbmQW8XO8BAU71mSb8siV09QdlUmCSmaBPuSVr2J4KzSoBMaSd0hD29jAwr
         KoEJwgx/KjtCFF1z566qDYv+oSjJL52VbdAjaNaemTk/6SzBo6Danmzrs1sNIAFgkEd2
         xxqpWwbdUxUDIb2/W/vjLppEfT0G7ME3JHkF13F3XpSjdZCyhhT6SDSosnGDHfo/FCNx
         XPbJSY8Hzn2ezES04JjompPVXENdPS/MEzfKtQvVoXIvcwN4vhmoqhPfATSv/wDEYlXY
         PwuA==
X-Gm-Message-State: AC+VfDwH8Rscb37RIT8V3oZrGyxIgc07K0VQIY8qSuYHM00WhASm1OFb
        AkOb6b8Crp5lZ7WSPvT02mVTNiEe08allKnrpsg=
X-Google-Smtp-Source: ACHHUZ435jO5TrrceiQBfE9d+lBxEraCM6asT5qwo8SN1MRiOJ4KYPTcXaqdfNzdKmKkbfSdyI9fsw==
X-Received: by 2002:ac2:5923:0:b0:4f3:bb14:6bac with SMTP id v3-20020ac25923000000b004f3bb146bacmr5341050lfi.56.1685042554346;
        Thu, 25 May 2023 12:22:34 -0700 (PDT)
Received: from builder (c188-149-203-37.bredband.tele2.se. [188.149.203.37])
        by smtp.gmail.com with ESMTPSA id c6-20020ac244a6000000b004f4cae38a1dsm305824lfm.223.2023.05.25.12.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 12:22:33 -0700 (PDT)
Date:   Thu, 25 May 2023 21:22:31 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 6/6] net: phy: microchip_t1s: add support for
 Microchip LAN865x Rev.B0 PHYs
Message-ID: <ZG+1d6m7Tum3KcVL@builder>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-7-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524144539.62618-7-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:15:39PM +0530, Parthiban Veerasooran wrote:
> Add support for the Microchip LAN865x Rev.B0 10BASE-T1S Internal PHYs
> (LAN8650/1). The LAN865x combines a Media Access Controller (MAC) and an
> internal 10BASE-T1S Ethernet PHY to access 10BASE‑T1S networks. As
> LAN867X and LAN865X are using the same function for the read_status,
> rename the function as lan86xx_read_status.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

I spotted something that's missing, the help text for the
MICROCHIP_T1S_PHY config option in driver/net/phy/Kconfig
should be updated. Currently it says:
	  Currently supports the LAN8670, LAN8671, LAN8672

Which should be extended with the 865x phys
