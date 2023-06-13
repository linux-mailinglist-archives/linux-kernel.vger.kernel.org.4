Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F8C72E965
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjFMRVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFMRVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:21:45 -0400
Received: from sender3-op-o17.zoho.com (sender3-op-o17.zoho.com [136.143.184.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C871721;
        Tue, 13 Jun 2023 10:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686676865; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mUSutJ4v91LRQhTNQ2N8KPrx9BmEGGldCXHyxcahlDwzevtw6fzxQyyXONweq3353zkauZtua3D0shybbjVenQ+zGBYqmQh7Ozl1dfglcbDKPsE9fs+NjLcInOtj4Ycdd3wPRnhflgyh5JJlpkH0jHhdIO5t0ak3CFoxVhRLJKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686676865; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=YmlHAc0oA+Gd6qbZ+MYa616u3dHbORdC6jb4K9GdGwM=; 
        b=CReqfNMQLpGsTEVB1q1q79cdA9+cVV1GtaEamLL5Xhs+CSf9G3S9dvcwqILzNyOnMK3DEfDNsSqjArw6TCpG9MxqJ5quhpwT3TO/igw7JT446pjnE2n+oNIhhFicU0qpxiS0IkjwLKzjnW1qehvnecHY4WLVPy6Xh7vd7sDaWIA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686676865;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=YmlHAc0oA+Gd6qbZ+MYa616u3dHbORdC6jb4K9GdGwM=;
        b=baQLGno+CdvN4L7LkqY2lVK2b44oEj3+1/mN6K58irFUL3QE8vuoWAzKzQovWgCp
        I5t4K5Col/eHZNweivrGwIwgxb9SDwGrEf5u8XA15xwkTx7IxW8/dlY7EAgB4Ig5bIx
        FxeWXPDVig8UcpyRxmuM5KNH7AtU4/HJIogv5uM4=
Received: from [192.168.1.248] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 1686676863664276.1065429103859; Tue, 13 Jun 2023 10:21:03 -0700 (PDT)
Message-ID: <826d89f5-1451-218c-a100-0913c98b931b@arinc9.com>
Date:   Tue, 13 Jun 2023 20:20:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v4 3/7] net: dsa: mt7530: fix trapping frames on
 non-MT7621 SoC MT7530 switch
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
 <20230612075945.16330-4-arinc.unal@arinc9.com>
 <ZIeKoVklLus8uzDp@shell.armlinux.org.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <ZIeKoVklLus8uzDp@shell.armlinux.org.uk>
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

On 13.06.2023 00:14, Russell King (Oracle) wrote:
> On Mon, Jun 12, 2023 at 10:59:41AM +0300, arinc9.unal@gmail.com wrote:
>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>
>> The check for setting the CPU_PORT bits must include the non-MT7621 SoC
>> MT7530 switch variants to trap frames. Expand the check to include them.
> 
> ... and now you add support for this to the MT7530, which is what
> alerted me to what seems to be a mistake in the previous patch.
> 
> "The setup of CPU_PORT() needs to be done for the MT7530 switch variants
> as well as the MT7621."

No. ID_MT7621 represents the multi-chip module MT7530 switch in certain 
MT7621 SoCs. So saying "the MT7530 switch variants" already covers the 
switch on the MT7621 SoCs.

Arınç
