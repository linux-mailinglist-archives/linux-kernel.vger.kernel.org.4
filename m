Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A01711393
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbjEYSTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbjEYSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:19:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1496A18D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:19:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f37b860173so2930343e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685038775; x=1687630775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eyp0v1JgQyCuZ+Exsevv8Sw+EcABs0zuWzeDebjKBmw=;
        b=r0flw4QnTiz04A0n4LN0sXOyBnPbGSV2c6qo4tsycTeFrdBWdS5R7JWPzMv3ztAHWx
         ApFEwKyAvCrlUEcwu52jkWwZBI1uoIHeDlXtnyfyT0AvrKL2VCjj2ajtit0WwuvDpuGQ
         Kol2B7YFry54crsTHC5IVEc4FIsq0DxuG4qMMLMUJ6r4VI02vH3l/pgisrQlRoGOxrzT
         3bETRSQdAxEv6q/bgY/o6N/bkkwsLliBi15i9b/FEY3kAa+jho0tfXC5Mz406AowLN2p
         nMCiN433nEFu8O+H+cLdNFTSvZENkrSXJiUwKbLRCJ1heYHyiwtpkH51aPF90RZWbj4p
         SSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038775; x=1687630775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyp0v1JgQyCuZ+Exsevv8Sw+EcABs0zuWzeDebjKBmw=;
        b=edLAH9b5+5+rJAU9UZ8SWFKvPfieNzs4jQPNEWJZgbLXjJDSprNYau/ybDm0amXAN5
         AZ8JoG9fZiPbGJ4GwFNnPhp+vV6nesw4DZVavbL4su8iCqGb8yGyY2z/8t670t08dE81
         PPT9uTfww2Br/NlokWGfmhfqFcRkw2fdx7mXt0aKRec/r/xyfSDk5q2MyL84KzzZ9J9e
         3ED/OpOfDFIjSr1aQ3ZD085JQ9Wstpqwi0U7IWRQoJL5jrUBK/2FDeiQqvUdLtugtKK5
         WNjohHnp8KbIbZh/S/hOuOWUZL3alJH0JLwVMy59wfrB8bp++1sZWAS5auucdtQD9Xyk
         t8xg==
X-Gm-Message-State: AC+VfDwAuLo4i1PWmiGKgNe1EEx2fFsgvIxOwT7zeo7n4p/ZmMc9vE+c
        TjvNmKmIzJE4pav35OtIRfHkcbbgqf3wMsntKf4=
X-Google-Smtp-Source: ACHHUZ4H4IUTvPMIl8KiFYEvdV32/a+qqNPZPsiQnmW0jRes3Yt2KP8fYi+hES0JuxHenxy5HlpH3g==
X-Received: by 2002:ac2:5d66:0:b0:4f0:1076:2682 with SMTP id h6-20020ac25d66000000b004f010762682mr5694599lft.42.1685038775297;
        Thu, 25 May 2023 11:19:35 -0700 (PDT)
Received: from builder (c188-149-203-37.bredband.tele2.se. [188.149.203.37])
        by smtp.gmail.com with ESMTPSA id j22-20020ac253b6000000b004f3aee3aae2sm296081lfh.140.2023.05.25.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:19:34 -0700 (PDT)
Date:   Thu, 25 May 2023 20:19:32 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 3/6] net: phy: microchip_t1s: update LAN867x
 PHY supported revision number
Message-ID: <ZG+mtFWGqTncZmcn@builder>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-4-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524144539.62618-4-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:15:36PM +0530, Parthiban Veerasooran wrote:
> As per AN1699, the initial configuration in the driver applies to LAN867x
> Rev.B1 hardware revision. 0x0007C160 (Rev.A0) and 0x0007C161 (Rev.B0)
> never released to production and hence they don't need to be supported.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

Reviewed-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
