Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B526056B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJTFWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJTFWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:22:04 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C81B15ECE6;
        Wed, 19 Oct 2022 22:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bHgO3V7i8G41klxyiVv7xcjgv6aTc1mHBQcIemEhvo0=; b=dza0J5EigBYzlhPG33O+pHLewO
        yFI3MRCxWPosGrxbPdDDf9GRDNDsbylA2/rRbfv6c46VsVj9M7cS8TOKQrd4yMgej4DRc19xVj4ok
        OeyX6m7MYuH0XPAf5hKBQ55EUoLSiennRl3/q+ft0oTV29jg9r2sHjbEdJS++eiLwVBBQCw+WuT+n
        MOwQxipnkQDQYEOUuB8a/5PgPmJdmSU2VF62f5PmtqiMlUZ/gj6TrYKMdQX+huAeIeqQATopW83c9
        +oqijXSPAMHttptobD/Wl+RzscXbhcotLE8rNbNpNy1gedfMwbD04E3pbC5l+WXtZ3hB6bCDiPNlJ
        6R1RwL5g==;
Received: from [89.212.21.243] (port=49886 helo=[192.168.69.85])
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <andrej.picej@norik.com>)
        id 1olO06-00CZ1p-SX;
        Thu, 20 Oct 2022 07:21:58 +0200
Message-ID: <d57f34db-2aff-f469-0146-335950c2b437@norik.com>
Date:   Thu, 20 Oct 2022 07:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/3] Suspending i.MX watchdog in WAIT mode
Content-Language: en-GB
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
References: <20221019111714.1953262-1-andrej.picej@norik.com>
 <20221019152915.GB4602@roeck-us.net>
From:   Andrej Picej <andrej.picej@norik.com>
In-Reply-To: <20221019152915.GB4602@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 19. 10. 22 17:30, Guenter Roeck wrote:
> On Wed, Oct 19, 2022 at 01:17:11PM +0200, Andrej Picej wrote:
>> The i.MX6 watchdog can't be stopped once started. This means that
>> special hardware suspend needs to be configured when the device enters
>> low-power modes.
>> Usually i.MX devices have two bits which deal with this:
>> - WDZST bit disables the timer in "deeper" low power modes and
>> - WDW bit disables the timer in "WAIT" mode which corresponds with
>> Linux's "freeze" low-power mode.
>>
>> WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
>> WDW bit is not common for all imx2-wdt supported devices, therefore use
>> a new device-tree property "fsl,suspend-in-wait" which suspends the
>> watchdog in "WAIT" mode.
> 
> I think that needs to be validated using the "compatible" property;
> it should not be possible to set/accept the new flag for devices
> which don't support it.

Ok, I can add that to a v2.

Thanks,
Andrej

> 
> Thanks,
> Guenter
> 

