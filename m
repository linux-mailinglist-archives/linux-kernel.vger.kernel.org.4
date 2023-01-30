Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F0680F23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbjA3NhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjA3NhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:37:12 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCECD2BF06;
        Mon, 30 Jan 2023 05:37:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675085789; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Z/3GlH9NZCV6SjobVyTG8J8Jj6q7mv68y7HRhCxtLVGW6uEC14x8zdIrbiRbAqzGLO+azLs/c7vdgHrhQlvsMj9ZKA2oWRLqCF9BkZKhPhIpoBsQFXL2MuyFdTvJoHY2mwJGOJQi1ozYEsPBjyDE6fU1NykkHZZEETLhrrtx3ng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675085789; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=mR05keK3ynmmM3Zq8e1jTLmPIijO9N8YT0CgtjDOhxA=; 
        b=XqIc/B806pk+XcJ1c+QgG/xPpOrdQw4ln4D8ruVT3cdG41ZeZn5RVwst8iGl8iEZg+ODQmbZTglEKACoMQm4bZz4wU4YXxNZLgNaMPfBkjBhQbPq5SG+KrSoZY+UsqvyGkvFAY2/uaLGDJof8JP1rYGJndjWQIc6mLDMD7snC0M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675085789;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=mR05keK3ynmmM3Zq8e1jTLmPIijO9N8YT0CgtjDOhxA=;
        b=UoyHXt1wr4aZ4sUr5SSIZnPQLXJ2mpDdbW5vU5u6hBEItvIE1WWIu3XrYOV7K0xQ
        HZYz/ycz/AU00AApVPODjLlnCyteKAi6z80IO4x4sv5pl0usK+r8vgWnBfspPzbLT9T
        rUes/WG/NjdWObGTx1i/U84g5hBfMPqDiJ7g1R24=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1675085787600658.2593333343776; Mon, 30 Jan 2023 05:36:27 -0800 (PST)
Message-ID: <883798d8-f7d9-eadc-1343-7d241741ff67@arinc9.com>
Date:   Mon, 30 Jan 2023 16:36:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: mtk-pmic-keys: Ignore power button if pressed before driver loads
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The power button on my Bananapi BPI-R2 (MT7623NI SoC, mt6323-keys) is 
shorted, so the device automatically boots when there's power. This 
causes the device to reboot when KEYBOARD_MTK_PMIC is loaded because the 
driver sees the power button being pressed.

I was wondering if it's possible to change the driver in a way that 
doesn't break in this situation. Maybe don't do anything if the first 
state of the the power button the driver sees is being pressed, and if 
the state doesn't change.

To address an edge case, if the power button was being pressed before 
the driver loads, look for if it's ever released. Only after then start 
working as usual.

Looking forward to hearing your thoughts.
Arınç
