Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFA68D1C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBGIuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjBGIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:50:46 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373014202
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:50:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675759829; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WgmlCvAAFn4Gt9ZmijArDO1jcwx++DCPHyFCFAGJ1AETX8e3eKegsqwscVsAYhXT9RlMvHr8HJ2Q0LG2TxpDpaCLro4MhQ9YoB07VrmZSQ1YXq0PkXfkCKuHhbPZ6FvUFcCeTjTW7kOD/bdZCq+M6WePpvYU5agijkLqWHfeqVo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675759829; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n6uraEzQ7snd1B3mJHkhy+yrztmpCqfklvd8VQqyxbk=; 
        b=ZE8wm38ZpR9ITNUd9hsmFd55Xh4UbrqyXLkmi1RohHlNsxzTaEYo7NPtgFZiblJKsTrD0L4jULYhe6Q/xAvuafJ7cx1G2ebrC4jGxt9HWUkVGiX/HRvIvmMPuHLMRaK5ZYj6zqD4ZMd7ODVhs1C0vP/aTPpd2St4i4WtXP1k9fw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675759829;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=n6uraEzQ7snd1B3mJHkhy+yrztmpCqfklvd8VQqyxbk=;
        b=itA3r0vePIpOYB7BOz/KNvAyl1tGMM/dTJRYV6LGmCF4vlSDxj0RGm1mfyuBOKbh
        v0qOfk1CaF/K1OqfIKyCtA/OfCTFM+lcUcRz6/BKcrzJy7A6Hc6kPxcfJwj+aMM/gQW
        pl0Xsliuf0ACjOahxfKeLCx5JBkT5ugX+gmTSkJc=
Received: from [10.10.10.3] (31.223.26.239 [31.223.26.239]) by mx.zohomail.com
        with SMTPS id 1675759827730423.8160413004782; Tue, 7 Feb 2023 00:50:27 -0800 (PST)
Message-ID: <dca5d799-a562-4494-bbf4-79b7e9420cac@arinc9.com>
Date:   Tue, 7 Feb 2023 11:50:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/2] nvmem: brcm_nvram: use buffered nvram data for
 cell values
To:     Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675717472.git.wdehoog@exalondelft.nl>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <cover.1675717472.git.wdehoog@exalondelft.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.02.2023 11:42, Willem-Jan de Hoog wrote:
> On OpenWrt 22.03.3, Asus RT-AC88U does not boot anymore:
> 
>    UBI: auto-attach mtd4
>    ubi0: attaching mtd4
>    ubi0 error: 0xc04f0b3c: PEB 0 contains corrupted VID header, and the
>       data does not contain all 0xFF
>    ubi0 error: 0xc04f0b4c: this may be a non-UBI PEB or a severe VID
>       header corruption which requires manual inspection
> 
> The problem seems to be that brcm_nvram_read accesses its (mapped) io
> memory. When doing so the correct data is read but after that the
> mtd/ubi process fails to work.
> 
> The bcm47xx_nvram.c code has buffered the nvram data so the cells value
> can be read from there.
> 
> v3:
> - Export symbol for modules.
> - No dependency on Kconfig.
> 
> v2:
> - Fix the wrong author information.
> 
> v1:
> - arinc.unal: Improved patch subject and log
> 
> Willem-Jan de Hoog (2):
>    The bcm47xx code makes a copy of the NVRAM data in ram. Allow access
>      to this data so property values can be read using nvmem cell api.
>    The bcm47xx module has a copy of the NVRAM data in ram. When available
>      use this one instead of reading from io memory since it causes
>      mtd/ubi to fail.

I believe you're supposed to put the subject of the patches here, keep 
that in mind for future contributions. No need to resubmit as this is 
just composition.

Arınç
