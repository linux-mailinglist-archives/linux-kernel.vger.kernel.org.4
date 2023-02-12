Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBA6936FF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjBLL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBLL3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 06:29:43 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060911284A;
        Sun, 12 Feb 2023 03:29:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676201355; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HkGFvJeUk+bE6QufNRZaCyMbx8qdTD+HFi8LSv+UOmkHny7AG8XaN324TSs4Dg0pF3nDxkXzbrECXAltiWoQ+NHskdXpSvArmDfmMeRNapbGN6V9TSjxlMkefulJwHLLanftEYBedzBdyQ8LeHMG7t0Mgjo944/PlTl1QheS/II=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676201355; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=sdKiqtHN6nftFsRpB9ipKjZhb69tnZdSxehkWarvD8A=; 
        b=g5t+LEH6QDCe1Q2Gv348lXJ0xgpnfeyAjK+eGkfbhKm1NC3BBJtsiVHDjKCUe0aWi14ZzPIMUX1n4ihrciirbo8Un46IYqlssCsQ//rt78FN1RPpIDF6QGQUoSlvvnsAslwljMGh6ez3R6isuUGpohFC/YGkeF/F9R/8B9tG4FM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676201355;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=sdKiqtHN6nftFsRpB9ipKjZhb69tnZdSxehkWarvD8A=;
        b=Hy8r1v89SG4Sv6Rol2/5mOrhOgIBDRCDTziw4D9gbmI/n2eA2cJVVuq5zNKGn0MC
        9heT0NnuuP1e6KnuCwvksZBuuQ0f4wZE626HeQ+G97lu6kapMJ3Rl2L1LoSG5T+wwpT
        tg8opL5fsiHMGfoRO+VVSWOMrRlO1sQwNu9xZHMQ=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676201354267603.4220221328939; Sun, 12 Feb 2023 03:29:14 -0800 (PST)
Message-ID: <ffc0f65b-8bdc-3353-8fb8-6e60582c2412@arinc9.com>
Date:   Sun, 12 Feb 2023 14:29:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: mtk-pmic-keys: Ignore power button if pressed before driver loads
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-input@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
References: <883798d8-f7d9-eadc-1343-7d241741ff67@arinc9.com>
 <87r0vcc51b.fsf@baylibre.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <87r0vcc51b.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Mattijs,

Sorry for the late response.

On 30.01.2023 20:21, Mattijs Korpershoek wrote:
> Hi Arınç,
> 
> On lun., janv. 30, 2023 at 16:36, Arınç ÜNAL <arinc.unal@arinc9.com> wrote:
> 
>> Hi all,
>>
>> The power button on my Bananapi BPI-R2 (MT7623NI SoC, mt6323-keys) is
>> shorted, so the device automatically boots when there's power. This
>> causes the device to reboot when KEYBOARD_MTK_PMIC is loaded because the
>> driver sees the power button being pressed.
> 
> What evidence do you have that there is actually a "press" event being
> received by userspace? Did you tested this with evtest or something
> similar?
> 
> If a "power button press" is generated, than I imagine that a userspace
> process must receive it and halt the system, right?
> 
> The PMIC also has a feature to shutdown in case detect a long key-press,
> which is controlled by the mediatek,long-press-mode device-tree
> property.
> So is it the pmic that shutdown your board (probably no evidence in
> logs, just a "power cut" behaviour) or is it userspace?

Nothing appears on the kernel log and evtest doesn't detect anything. 
The input device appears only after loading mtk-pmic-keys.ko so I have 
to run evtest after the driver is loaded. After that, I see nothing 
noticeable running evtest:

# evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:	mtk_cir
/dev/input/event1:	mtk-pmic-keys
Select the device event number [0-1]: 1
Input driver version is 1.0.1
Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x1
Input device name: "mtk-pmic-keys"
Supported events:
   Event type 0 (EV_SYN)
   Event type 1 (EV_KEY)
     Event code 114 (KEY_VOLUMEDOWN)
     Event code 116 (KEY_POWER)
Properties:
Testing ... (interrupt to exit)
(Device reboots)

I've set this on the devicetree of Bananapi BPI-R2:

&mt6323keys {
	mediatek,long-press-mode = <0>;
};

This prevents the device from rebooting after the driver is loaded so I 
believe this proves that it's the driver that tries to shutdown the board.

> 
>>
>> I was wondering if it's possible to change the driver in a way that
>> doesn't break in this situation. Maybe don't do anything if the first
>> state of the the power button the driver sees is being pressed, and if
>> the state doesn't change.
> 
> If the driver is an issue, can't we blacklist it from being probed
> instead? or do you want to use the home key feature that that same
> driver provides?

Since it's a special case, specific to my own board, I just disabled the 
key.

&mt6323keys {
	power {
		status = "disabled";
	};
};

I also see there's no home key on this board so I may submit a patch to 
disable the home button for this device.

Thanks for your help!

Cheers.
Arınç
