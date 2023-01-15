Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF59266AFE9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 09:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjAOIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjAOIWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 03:22:53 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7CC14B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:22:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1673770941; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=jOXDkLHM8sjbw13TWgRUrqi7LljgETBWDx22LzTuxNg7ix6OEw2u7oaN9eyH0zcwiaMJVhXqVHqrL3d3mMumSxEDLrnV1XMc9PoTL/j6gjE/lq4tR5hvooKwZCZLv60wId844x4jMYrJFPHAD51zpi8VzZPB8rlAlEmt742Jv5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1673770941; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=HoFPi2zHYHBii6ImK1R3fS/gXJBvgvD9QMiEM0r7T34=; 
        b=NVhivhUb/Djyzm4tQRYEFp2Um6el0JaMEp1pK9v+ZWc/EUdLYU+EwVoprVpy8z8Vs/By3rH4MRsllySNu51b938WtCCfynOtF5Rjm36h0sj5c5FgqK5x9uE9zQ2iYlWlLNGgjY+7leC8vjlaVYxNJIaCxA1AOJ+9NwdBhJTHRJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1673770941;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=HoFPi2zHYHBii6ImK1R3fS/gXJBvgvD9QMiEM0r7T34=;
        b=VKhk95aijO3NmUxhbNVNGKA9mQv5GQMDE94ZsxYScMs0fq4Ggjd5z88MWfPnfLgP
        B8EQtQq/ovey+DId1A0OB0XQoFPh/jEqd9V3LgvDY49WaXyVp7HwHBfNxAWYflIRBBw
        QQQ8N9jxLs31EDNjru2y83hVZ4FX4H4n0LxDvjME=
Received: from [10.10.10.218] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1673770940011540.826507404914; Sun, 15 Jan 2023 00:22:20 -0800 (PST)
Message-ID: <435531df-3087-cda5-a6ae-a0143f5169ba@arinc9.com>
Date:   Sun, 15 Jan 2023 11:22:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mips: ralink: mt7621: fix phy-mode of external phy on
 GB-PC2
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Petr Louda <petr.louda@outlook.cz>
References: <20221128213238.3959-1-arinc.unal@arinc9.com>
 <20221201105049.GA6569@alpha.franken.de>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20221201105049.GA6569@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.12.2022 13:50, Thomas Bogendoerfer wrote:
> On Tue, Nov 29, 2022 at 12:32:38AM +0300, Arınç ÜNAL wrote:
>> The phy-mode property must be defined on the MAC instead of the PHY. Define
>> phy-mode under gmac1 which the external phy is connected to.
>>
>> Tested-by: Petr Louda <petr.louda@outlook.cz>
>> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>> ---
>>   arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> applied to mips-next.

I just realised I forgot to add "dts:" to the patch subject. Would that 
be a problem?

Arınç
