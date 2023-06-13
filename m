Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D861E72ED17
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjFMUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjFMUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:36:06 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59261DC;
        Tue, 13 Jun 2023 13:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686688520; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gDbI8JSeMB3XvfUEcW+rYmjoiLoAZEb32v+S12IxsTgbsgWXTxBIDDZaZCFF5Fe3hjimVj2sSQecbaCVO/zn7mHdvO7Ua5n/PBjbI+e9fO1zgXgMTBy79oUvKzuNw/aQ2Y0K1oWzVxVj+pHbJDh3L37BT+SxX694jFL6Nm1G4vI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1686688520; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NJkettsSxBuNQxUsWm06yE58sGMZHkSWM+zZvdZ8dHk=; 
        b=k5VLqZG5MBviUDoBb7IWZFoADYxnUjTI9HCx5FtvSavmYo9wYYgrv7em1GvkmmInpWxeZmOnjgv9/scf5RKpbNKbKHgBF9e5X1HvLHlEwgVARZqP1v/vOatnlkqEe/POof+oQ7mTdAqG4RtNv55dVMpIoZkHXIUP0IgUNZdo/fI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1686688520;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=NJkettsSxBuNQxUsWm06yE58sGMZHkSWM+zZvdZ8dHk=;
        b=fuo48VYkqz+6Ex2pjx6EzU+s0d0muvUkrkpFXJ67v1nbotl67aJcacWZx/v2JlvZ
        OtfN7ypp0Wwkyb3jUQfc1v16f5fwRsRNJkIZ/loQea2M0t8/QzNFoFNftAYj60/RjJK
        2b+7ZS3e3qRzL8Eu2hMBoA3MPm3b0DXOx6YWKA+w=
Received: from [192.168.1.248] (178-147-169-233.haap.dm.cosmote.net [178.147.169.233]) by mx.zohomail.com
        with SMTPS id 168668851895067.87878257025943; Tue, 13 Jun 2023 13:35:18 -0700 (PDT)
Message-ID: <4a2fb3ac-ccad-f56e-4951-e5a5cb80dd1b@arinc9.com>
Date:   Tue, 13 Jun 2023 23:35:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2 2/7] net: dsa: mt7530: fix trapping frames with
 multiple CPU ports on MT7530
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Daniel Golle <daniel@makrotopia.org>,
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
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
 <20230611081547.26747-2-arinc.unal@arinc9.com>
 <20230613150815.67uoz3cvvwgmhdp2@skbuf>
 <a91e88a8-c528-0392-1237-fc8417931170@arinc9.com>
 <20230613171858.ybhtlwxqwp7gyrfs@skbuf>
 <20230613172402.grdpgago6in4jogq@skbuf>
 <ca78b2f9-bf98-af26-0267-60d2638f7f00@arinc9.com>
 <20230613173908.iuofbuvkanwyr7as@skbuf>
 <edcbe326-c456-06ef-373b-313e780209de@arinc9.com>
 <20230613201850.5g4u3wf2kllmlk27@skbuf>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230613201850.5g4u3wf2kllmlk27@skbuf>
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

On 13.06.2023 23:18, Vladimir Oltean wrote:
> On Tue, Jun 13, 2023 at 08:58:33PM +0300, Arınç ÜNAL wrote:
>> On 13.06.2023 20:39, Vladimir Oltean wrote:
>>> Got it. Then this is really not a problem, and the commit message frames
>>> it incorrectly.
>>
>> Actually this patch fixes the issue it describes. At the state of this
>> patch, when multiple CPU ports are defined, port 5 is the active CPU port,
>> CPU_PORT bits are set to port 6.
>>
>> Once "the patch that prefers port 6, I could easily find the exact name but
>> your mail snipping makes it hard" is applied, this issue becomes redundant.
> 
> Ok. Well, you don't get bonus points for fixing a problem in 2 different
> ways, once is enough :)

This is not the case here though.

This patch fixes an issue that can be stumbled upon in two ways. This is 
for when multiple CPU ports are defined on the devicetree.

As I explained to Russell, the first is the CPU_PORT field not matching 
the active CPU port.

The second is when port 5 becomes the only active CPU port. This can 
only happen with the changing the DSA conduit support.

The "prefer port 6" patch only prevents the first way from happening. 
The latter still can happen. But this feature doesn't exist yet. Hence 
why I think we should apply this series as-is (after some patch log 
changes) and backport it without this patch on kernels older than 5.18.

Arınç
