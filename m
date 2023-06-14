Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F2730973
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjFNUx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFNUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:53:26 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1CA19B5;
        Wed, 14 Jun 2023 13:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686775951; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nyOFGpzXWXbpc1xoBKwWNlhReMsnv5XqnEy/tsLyROxO0xB2PrXBc+hfIT/sAvuFVl4Dx+lddhjmMQIvrsNfXdijoCfbIvl9oIltiJWl90oOnM9ZVkhzzP4arVMo1Pk7Dn04HUDDHUHK/GeI9PHIMf7ofrExdEc4k4CKaFqlGXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686775951; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=64/Oii+d8OL5qpva/X1Idla2wjT3g/qIoLmKKbrccbY=; 
        b=NG94f/R5ZflThIAHevT7+GzSLE8l3MmL71xrX0M2hBJ+IRJMUXC6+wI6ajb+M3vCq2iG1kiA4rSZaJUTdwjNhDj/tHbjC8PFFsDuAmFNnXATFRMCMExCyOPl5d6ZooQs5w61YXUVuCvberq9VqB0o3JyD8i4Rb2ybwEUPbW4A3A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686775951;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=64/Oii+d8OL5qpva/X1Idla2wjT3g/qIoLmKKbrccbY=;
        b=ZxccuiHqoBz5SNcGLX5EnfEWCcdF8Q331DTsO4KTvCqzqPIQqUHkoXM47QRNL8Lx
        whMFk/LZYwa2p6lG4992DENJcd7QklWQZqk5/hHtO1NCMxAdQWXRilZO/HMcFy9Bkz2
        zYF2Xiy7PilBwvuTUNUDlfxv790jHBYPMwsNoJ9U=
Received: from [192.168.99.141] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1686775950296301.39053858998864; Wed, 14 Jun 2023 13:52:30 -0700 (PDT)
Message-ID: <3eaf5a2c-6ef2-e43a-1d0e-08ec4e1ee7e8@arinc9.com>
Date:   Wed, 14 Jun 2023 23:52:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v4 5/7] net: dsa: mt7530: fix handling of LLDP frames
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612075945.16330-1-arinc.unal@arinc9.com>
 <20230612075945.16330-6-arinc.unal@arinc9.com>
 <ZInt8mmrZ6tCGy1N@shell.armlinux.org.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZInt8mmrZ6tCGy1N@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.2023 19:42, Russell King (Oracle) wrote:
> On Mon, Jun 12, 2023 at 10:59:43AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> LLDP frames are link-local frames, therefore they must be trapped to the
>> CPU port. Currently, the MT753X switches treat LLDP frames as regular
>> multicast frames, therefore flooding them to user ports. To fix this, set
>> LLDP frames to be trapped to the CPU port(s).
>>
>> The mt753x_bpdu_port_fw enum is universally used for trapping frames,
>> therefore rename it and the values in it to mt753x_port_fw.
>>
>> For MT7530, LLDP frames received from a user port will be trapped to the
>> numerically smallest CPU port which is affine to the DSA conduit interface
>> that is up.
>>
>> For MT7531 and the switch on the MT7988 SoC, LLDP frames received from a
>> user port will be trapped to the CPU port that is affine to the user port
>> from which the frames are received.
>>
>> The bit for R0E_MANG_FR is 27. When set, the switch regards the frames with
>> :0E MAC DA as management (LLDP) frames. This bit is set to 1 after reset on
>> MT7530 and MT7531 according to the documents MT7620 Programming Guide v1.0
>> and MT7531 Reference Manual for Development Board v1.0, so there's no need
>> to deal with this bit. Since there's currently no public document for the
>> switch on the MT7988 SoC, I assume this is also the case for this switch.
>>
>> Fixes: b8f126a8d543 ("net-next: dsa: add dsa support for Mediatek MT7530 switch")
> 
> Patch 4 claims to be a fix for this commit, and introduces one of these
> modifications to MT753X_BPC, which this patch then changes.
> 
> On the face of it, it seems this patch is actually a fix to patch 4 as
> well as the original patch, so does that mean that patch 4 only half
> fixes a problem?

I should do the enum renaming on my net-next series instead, as it's not 
useful to what this patch fixes at all.

> 
> Bah, I give up with this. IMHO it's just too much of a mess trying to
> do any sane review of it. No, I'm not going to give any acks or
> reviewed-bys to it because nothing here makes much sense to me.
> 
> And I just can't be bothered trying to parse the commit messages
> anymore.
> 
> Sorry but no, I'm going to be ignoring these patch sets from now on.

... okay. I listen to your reviews and change my patches accordingly. If 
that's not enough, I don't know what is.

Arınç
