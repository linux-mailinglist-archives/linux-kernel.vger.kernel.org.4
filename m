Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2876270FD87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjEXSKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjEXSJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:09:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198C98;
        Wed, 24 May 2023 11:09:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-306dbad5182so849190f8f.1;
        Wed, 24 May 2023 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684951786; x=1687543786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6hQKtSgQEWi9rODQsWaqyzCQpbBtWGNPmRG6g+0ml8=;
        b=lJmaJjwzNATJXlTs4cbN5TwMpgB2XYhqF7kgxMI4BhGPK4IikPyo2VhVkvzRIuPTAL
         1Ih5Ph68b/w6yXNkdw339e9iZ/7tfZ6mfkktqV9WlNueekaxrunwZ6NIYkL54UojcCGf
         xM9M7eY295tsyFW+MjG3Q0XfUh/JHH/ZafxzBNdVqhSilxeSjLd6lMhCLauyGT0xA9Rt
         hXaJ4wmejq2/Z6Cb8SgjvUVO86z3A4mFVv8o9EG8As9XdtIqPCluFrsHVulzPz7GdWm4
         egMR/6FNpF1ewy2josOqyA8cXF4WpKnLdHa83fxy/D68OCg0hFfY4NClrTd1Z5/zXF13
         WDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684951786; x=1687543786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6hQKtSgQEWi9rODQsWaqyzCQpbBtWGNPmRG6g+0ml8=;
        b=Xc2TPD85LnY4v5mC8SnzGGuITT9ko/IjhDVqCn/0nrrDXSstL6Q+osBfit3dcv2d/S
         EcYbBpDyBz1YqNAlPBLBXrLJOXU0q4+Gyk5z6pMK3lXlBAmRWKpyf/10XMEZK3zHVHkK
         fAg+M1eTiUySRajsQqEguSW2zO5AED4DDGQM+RboGbd4MYnw4IE2J8YpXgViqAVsitCg
         TS9ouPIZxl/7nFnG1HVby91HKo2gu5XxG4v1D2IhqjDThb4EYJqz3J16xUX6SKTF21zo
         vw9satrWwaWVp3021oU4EzcsFrdZXJXWB28ZVubHkCaAQKXBQhOEMFreKMwguNAGPodg
         6UJw==
X-Gm-Message-State: AC+VfDzpEEgttRf4pm6zdLgk2QZj78pa7J8H2XEI8E5zCH/4TfDlt+lv
        FqpmbsATqxTkgJUGm6LT/bw=
X-Google-Smtp-Source: ACHHUZ6onREVy6Pl2TF0gq10+tc+q2AOGed5crJlE6SNJcWnR/VrrQS8bGbnXupCPJ53qAZzLgsyTA==
X-Received: by 2002:a05:6000:104e:b0:306:368d:8a1c with SMTP id c14-20020a056000104e00b00306368d8a1cmr446044wrx.45.1684951786193;
        Wed, 24 May 2023 11:09:46 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600012c100b0030630de6fbdsm15134104wrx.13.2023.05.24.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 11:09:45 -0700 (PDT)
Date:   Wed, 24 May 2023 21:09:43 +0300
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
Subject: Re: [PATCH net-next 11/30] net: dsa: mt7530: remove pad_setup
 function pointer
Message-ID: <20230524180943.y24syoustr65o2qk@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-12-arinc.unal@arinc9.com>
 <20230522121532.86610-12-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230522121532.86610-12-arinc.unal@arinc9.com>
 <20230522121532.86610-12-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:13PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The pad_setup function pointer was introduced with 88bdef8be9f6 ("net: dsa:
> mt7530: Extend device data ready for adding a new hardware"). It was being
> used to set up the core clock and port 6 of the MT7530 switch, and pll of
> the MT7531 switch.
> 
> All of these were moved to more appropriate locations, and it was never
> used for the switch on the MT7988 SoC. Therefore, this function pointer
> hasn't got a use anymore. Remove it.
> 
> Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
