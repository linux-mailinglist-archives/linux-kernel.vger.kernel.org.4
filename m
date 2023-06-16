Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02087732F02
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345020AbjFPKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344612AbjFPKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:45:53 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98353207D2;
        Fri, 16 Jun 2023 03:38:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so695581a12.0;
        Fri, 16 Jun 2023 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686911853; x=1689503853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vf9ZcsEUteN0CUh6L+CQvBHKwKLXajDDbQoRw1QcpzE=;
        b=QkTJq+5qZ5xCiAgJ7YtOWmnJLruaTfcacW1v91mZqVrJVnWxoHuc0EXVGGyeIcZ/wg
         cKOGDcuAI167QOfnsswfqiBidyttu1t5cHJvU7aruO4SmoLhFaStjSLHS5CaX+axlSTv
         2PNApnjPovXgo5Og6Eei0/zmBbGKu7hx0ZoWY7PHrEFUw//1b+GHHUnTkIOjdmExzR/p
         YJVN46wOtcskwxwH70YVdFgXmuPEV9Hdez8JGrFF+VO4dXhcf2Fbe6zVIUD8c1fyBZ7Y
         sW77Kr/Y2riUfIydcSuUazOm6jxaX31SpJ0cOi17WFxnXaeuM8yTcLEprFMQTxqzJ7r6
         WTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686911853; x=1689503853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vf9ZcsEUteN0CUh6L+CQvBHKwKLXajDDbQoRw1QcpzE=;
        b=S9tORRN2d4OaXGKdr24mKnN5r4PWUAyGpHe3VJc3gcAR/t5hUwPjZ2hzVO+Ymeoz+V
         0Ad+fo37eIGbzuAfyx4jOV2JHz1uZLjg1U6Jek8N4LwNqZUT9dXZVk38i/Su9G8FDSQt
         D+EmFWx9L+7MaoNeLIQaUEvLWb5B4S9ctoU6zMHMgJConeO94/MpY24DKaZkCackRg6z
         sMnnmdp3PYAMX5f67ClDZaFo7T+2B97LmbuhLC4D8W24Lk37/B+Z+2Ktrv/lfP7eQFQv
         6PPMgoT3qFfIdToZoVXGTcL2PTjt5T6J1AwLH6rSzget8Omv8WwN8fR953EP9gYGu3Tc
         c5xQ==
X-Gm-Message-State: AC+VfDxvFXl8oIgm7DTelIPBiqmCYcekPjYScBRaFcVc8cuM6NwPz721
        2dGK6rGrYTJz1qkcOcjmkL0=
X-Google-Smtp-Source: ACHHUZ6cOZJOEoYbXoXOAEywb2UlXWhCDx3Vt292UOxt+QW/1LptejmO1UBVVws94N0Mq/wInJOClQ==
X-Received: by 2002:a05:6402:3d0:b0:516:9f60:170c with SMTP id t16-20020a05640203d000b005169f60170cmr953320edw.8.1686911853221;
        Fri, 16 Jun 2023 03:37:33 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id k12-20020aa7c38c000000b005187b5b82f7sm3577966edq.9.2023.06.16.03.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 03:37:32 -0700 (PDT)
Date:   Fri, 16 Jun 2023 13:37:29 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
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
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v5 2/6] net: dsa: mt7530: fix trapping frames on
 non-MT7621 SoC MT7530 switch
Message-ID: <20230616103729.a5t2top2av5vkxt4@skbuf>
References: <20230616025327.12652-1-arinc.unal@arinc9.com>
 <20230616025327.12652-3-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616025327.12652-3-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 05:53:23AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The check for setting the CPU_PORT bits must include the non-MT7621 SoC
> MT7530 switch variants to trap frames. Expand the check to include them.
> 
> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Maybe this alternative commit message is an improvement:

All MT7530 switch IP variants share the MT7530_MFC register, but the
current driver only writes it for the switch variant that is integrated
in the MT7621 SoC. Modify the code to include all MT7530 derivatives.
