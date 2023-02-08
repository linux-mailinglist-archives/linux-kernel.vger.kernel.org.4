Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B068ECE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjBHKaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjBHKa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:30:26 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462B949008;
        Wed,  8 Feb 2023 02:29:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675852157; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eVek52JXMTyOCQvD8SrWWnOvnmAhgcEFEpfoQ1NthI4M1rg9aCK+z/xDzFw/a4Gjs6gn23gwAnpydcVeWO42dtNFVvs9LGL2QHHXZxqOXPHnV2v7h7hxnh1dDbxW/uCiBGH0ZUDGzGlgBF1ofI3zmT08E3dW3Y2rxGy0/GgFhPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1675852157; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tCCSsg5DzkuOXABZvuv5Om7FvIMgSFMnGm63fwIZA7w=; 
        b=EV/LCZux8g1yKtYtGh/zAQp3BOCL2/WVnWgZw4CkjcCbNygkcw3OddZSEwmOmEujFSIRKFJ91Gv3O1NVeHbQZ10irvsCrnp/skX0WtUPtPCSdGqq48GOwXxNSQzgfqoUOo5b28jMPID0A4ytVHe7Jfd3s6v0aW1/rM69kByzHiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1675852157;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tCCSsg5DzkuOXABZvuv5Om7FvIMgSFMnGm63fwIZA7w=;
        b=AtKoPvjmjT8pXsruvuxJRZYhnkUXk3mWUn3UZbl93YUEgAK+iNc9ljMSNFmYH463
        EVlwaA/Vum0TV5TRPqVhGpiVcpOAWVU8Xb/f3ztvkqgMLrxCmKaJx6rbB1bIWviZzmC
        7T9OJ4eZA8aCKKCWDIUWJGP7uPVnzgvS+6Pwi9sU=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 16758521567311013.6790666557337; Wed, 8 Feb 2023 02:29:16 -0800 (PST)
Message-ID: <2e2ff1ec-34a9-db77-64d2-c088e5f1a13d@arinc9.com>
Date:   Wed, 8 Feb 2023 13:29:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675717472.git.wdehoog@exalondelft.nl>
 <e179c12f73a6035690e814b842f677bbb38f5c96.1675717472.git.wdehoog@exalondelft.nl>
 <0496ff17-0a02-1192-3c9a-412656a38b6a@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <0496ff17-0a02-1192-3c9a-412656a38b6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.02.2023 13:25, Rafał Miłecki wrote:
> On 7.02.2023 09:42, Willem-Jan de Hoog wrote:
>> From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
>>
>> The bcm47xx module has a copy of the NVRAM data in ram. When 
>> available, use
>> this one instead of reading from io memory since it causes mtd/ubi to 
>> fail.
> 
> This doesn't explain anything. Why do we need that? If anything we
> should rather get rid of that NVRAM firmware driver. It was needed
> before we had all NVMEM stuff in place. Finally how can reading
> iomem break mtd/ubi?!

Did you take a look at the bootlog on this post on the thread, I've 
mentioned your user handle a few times but received no response on the 
forum.

https://forum.openwrt.org/t/asus-rt-ac88u-hw-a6-broken-in-22-03-3/147882/6?u=arinc9

Arınç
