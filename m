Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36A9695CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBNIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjBNIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:32:05 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F8D3C29;
        Tue, 14 Feb 2023 00:32:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676363505; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=iualKzOx4/tXV8fnCcIs5szqt55CddsE9QRpRAZMbcIlKV4pC14z23m9vbFNrm/RYaSeznxNACs4a4V48yII+jUBa7zw7EvDTllUkQ4JFBNr6qmRoQxGPF1T5PjFLyEseIDkveEAPXKKV7hcr+CZmsEnm6QdUE+AQRpX8pFA38s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676363505; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=IDHUVK6k6nJv+wJzQGsZyu/MG5qaz5nXBO6YgZMfEpo=; 
        b=mciP8mZiBPztYw/VHZaOMd2CUEgMByjOjVFXtsUOEWz/f3UNj1Sh+PtXxi1SrhQVrZHuwbch2SlKGD0Axwel3cP5cxeqrpGZCFOiy1nieTXfwO72kWxbb2TeSXfLqaefe7TxY+23LNQxDHN2p64S/ezOGv7wcYsJo2SUtdY5Uws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676363505;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=IDHUVK6k6nJv+wJzQGsZyu/MG5qaz5nXBO6YgZMfEpo=;
        b=ii+webR7VyQL/Z2HY0Pw0/+n6zo52eGzn0DL0sT6bUrH0zHLl7ER+9SW467Z7k87
        EKUZz2UP1DtbU8Hv2G06A7BAruLOkIPLQNRwu4iP1D29VbTvalortWzcotqqWuwtOwe
        6CSXyBYaa4HdzTWrNOzingPGXlOtAnnl0XXGtaMo=
Received: from [10.10.9.4] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676363503759332.83192985950996; Tue, 14 Feb 2023 00:31:43 -0800 (PST)
Message-ID: <b302c25e-5365-c335-c790-71b3135847d0@arinc9.com>
Date:   Tue, 14 Feb 2023 11:31:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 0/3] watchdog: mt7621-wdt: avoid globals and arch
 dependencies
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230213200519.889503-1-sergio.paracuellos@gmail.com>
 <7bff7c46-ed03-ba7d-6a88-f94dfd0cb1a5@arinc9.com>
In-Reply-To: <7bff7c46-ed03-ba7d-6a88-f94dfd0cb1a5@arinc9.com>
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

On 14.02.2023 11:12, Arınç ÜNAL wrote:
> On 13.02.2023 23:05, Sergio Paracuellos wrote:
>> Hi all,
>>
>> This series make an update in the MT7621 SoC's watchdog driver code. This
>> SoC already provides a system controller node to access reset status
>> register needed for the watchdog. Instead of using MIPS architecture
>> dependent operations in header 'asm/mach-ralink/ralink_regs.h' get
>> node syscon regmap using 'syscon_regmap_lookup_by_compatible()' and use.
>> regmap APIS. Driver is also using some globals that are not needed at
>> all if a driver data structure is used along the code. Hence, add all
>> new needed stuff inside a new driver data structure. With this changes
>> driver can be properly compile tested.
>>
>> Thanks in advance for reviewing this!
>>
>> v1 of this series here [0].
>> v2 of this series here [1].
>> v3 of this series here [2].
>> v4 of this series here [3].
>> v5 of this series here [4].
>>
>> Changes in v6:
>>      - Get regmap syscon using 'syscon_regmap_lookup_by_compatible()'
>>      - Add COMPILE_TEST and dependencies to Kconfig.
>>      - Collect Philippe Mathieu-Daudé 'Reviewed-by' tag for watchdog node
>>        warning fix.
>>
>> Changes in v5:
>>      - Drop patches related with device tree ABI breakage and only
>>        maintain the rest.
> 
> This makes me regret taking mt7621-dts out of drivers/staging. Clearly 
> there were improvements to be made on the MT7621 drivers that would 
> affect the devicetree binding. I don't think one would bat an eye to 
> make dt-binding changes on a devicetree on drivers/staging.
> 
> I also want to make a similar change that would break the ABI. I want to 
> split the MediaTek MIPS (currently called Ralink) pinctrl subdrivers 
> further, namely mt7620.c, to split MT7628/MT7688 pinmux data from 
> MT7620, so I can properly document which function can be given to which 
> group(s) for the MT7628/MT7688 SoCs.
> 
> This means I've got to introduce a new compatible string for the MT76X8 
> SoCs which would cause the pinctrl driver to stop working with an old DT 
> for the MT76X8 SoCs. By the nature of the change, I can't make a way 
> around with the code like Sergio did in v6.

Now that I think about it, I think there's a way I can introduce a new 
compatible string for the sake of better documentation, and keep the 
driver working with old DTs. I'd not like to convolute this series with 
this conversation. I'll send a mail to the related mailing list when the 
time is right.

Arınç
