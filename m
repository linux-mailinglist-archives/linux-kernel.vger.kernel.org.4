Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19BC7105BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjEYGne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjEYGnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:43:31 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340319D;
        Wed, 24 May 2023 23:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684996973; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=b4OmCbQMkB/xWAZ9zMBvj9vwTWQ8Ic7aJwINdvnbgtdOzZ9vILqZgyZQ1KgeSOutaCus+K9qentddJ1UM495kFs+iDvmgBfyEkRyDOEVj8IMYAvxFz7vfKr8ZkS0h8YmKz0laAmbVE2ycyB+ydrP3rvX3uCBS9M+dAqFbRKtrvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1684996973; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Ps2q2KVmI6g4VaRsE+0myr/6Vqen3BTZMXDldgpuQPo=; 
        b=ljFT6Kco9BHrnta9c58NvfUQd4x8APIiKsL5sZZ49xV11pshEOc4H4w4LDU4BWpu2lPMkzqCeur+KTPCPdPCtkhWpWHAyZFJIChgSw0ixIWppnXMcCo2Dbcddc4TIEz5qCiRQZKXWD69UAmLmtZ6aQGyqRogYCC2fzlQ3v2KsRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1684996973;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Ps2q2KVmI6g4VaRsE+0myr/6Vqen3BTZMXDldgpuQPo=;
        b=fceW8/RS+55TuTbhyxyu/OfRp1/xRytzAxpbGzgIH42/82kIzs9KnDjl4NDu9qkt
        U6L1M1cf/03FoW81sioA3BTckKmGidprk9DBRR5Lsmw6/G9E6YhAcx4smB2cORsyqUL
        fNz90N+hl2RM14bn15C2MoGqjDMV1fN5tDZ6Selo=
Received: from [10.10.10.217] (149.91.1.15 [149.91.1.15]) by mx.zohomail.com
        with SMTPS id 1684996972294524.5913253999956; Wed, 24 May 2023 23:42:52 -0700 (PDT)
Message-ID: <1c1d8990-1719-5ad9-027a-856062021917@arinc9.com>
Date:   Thu, 25 May 2023 09:42:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next 06/30] net: dsa: mt7530: improve code path for
 setting up port 5
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
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
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-7-arinc.unal@arinc9.com>
 <20230522121532.86610-7-arinc.unal@arinc9.com>
 <20230524173510.xvq434ekaee4664m@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230524173510.xvq434ekaee4664m@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.05.2023 20:35, Vladimir Oltean wrote:
> On Mon, May 22, 2023 at 03:15:08PM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> There're two code paths for setting up port 5:
>>
>> mt7530_setup()
>> -> mt7530_setup_port5()
>>
>> mt753x_phylink_mac_config()
>> -> mt753x_mac_config()
>>     -> mt7530_mac_config()
>>        -> mt7530_setup_port5()
>>
>> Currently mt7530_setup_port5() from mt7530_setup() always runs. If port 5
>> is used as a CPU, DSA, or user port, mt7530_setup_port5() from
>> mt753x_phylink_mac_config() won't run. That is because priv->p5_interface
>> set on mt7530_setup_port5() will match state->interface on
>> mt753x_phylink_mac_config() which will stop running mt7530_setup_port5()
>> again.
>>
>> mt7530_setup_port5() from mt753x_phylink_mac_config() won't run when port 5
>> is disabled or used for PHY muxing as port 5 won't be defined on the
>> devicetree.
>>
>> Therefore, mt7530_setup_port5() will never run from
>> mt753x_phylink_mac_config().
>>
>> Address this by not running mt7530_setup_port5() from mt7530_setup() if
>> port 5 is used as a CPU, DSA, or user port. For the cases of PHY muxing or
>> the port being disabled, call mt7530_setup_port5() from mt7530_setup().
> 
> So TL;DR: mt7530_setup() -> mt7530_setup_port5() short-circuits
> mt753x_phylink_mac_config() -> ... -> mt7530_setup_port5() through the
> stateful variable priv->p5_interface, such that port 5 is effectively
> never configured by phylink, but statically at probe time. The main goal of
> the patch is to undo the short-circuit, and let phylink configure port 5.

True.

> 
> It is worth stating that we know phylink will always be present, because
> mt7530 isn't in the dsa_switches_apply_workarounds[] array. Otherwise
> this strategy would have been problematic with some device trees.

I will add this to the patch log:

This driver isn't in the dsa_switches_apply_workarounds[] array so 
phylink will always be present.

> 
>> Do not set priv->p5_interface on mt7530_setup_port5(). There won't be a
>> case where mt753x_phylink_mac_config() runs after mt7530_setup_port5()
>> anymore.
> 
> The bulk of the change is difficult enough to follow. I believe this
> part could be done through a separate patch, and the rest would still
> work.

Will do.

Arınç
