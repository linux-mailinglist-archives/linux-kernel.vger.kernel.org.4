Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9635A5E75AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbiIWI0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIWI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:26:05 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10071.outbound.protection.outlook.com [40.107.1.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1FA107DED;
        Fri, 23 Sep 2022 01:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABU54zFuxHjlqhwWnTRy3e4KU/8YpE4OTIqsB5ZU8y3WLw2keT1QHrJQl5V96phzmmUFTy/LJvid38jgwJC6QpmMKuDoP/iuUCygehLVofLzXnp6z3Zq9LIcmmlhr4bVSUmdBoEPV7CglPRFVoCTP/qGjFPFQtHg9eP0CfEvOLWhPshy8UYCVkcA19bnw7e1ARanK/iEvtFzXpawNWO2rlC8YwdgkDBHf11zKyVjURLW4A43NvDIt0XpfQXPbEaRBBmzfYhMH2utXZbuystxSYaMKn34rb/77lZ4UudjhctZSdf6/o91ye2vp3UhC6t6uQvssu+TwjhC5jELkb8b0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kIuapQxWpOTFH0axwi9ywl2Mk/2I8M4IiGtxuGKzffs=;
 b=b0vgzrRbCo5fvasE5QVTsOSVRvBh/OmEPIaLPOOqVHhuNnpKSKmgTveq4jkdYe+8dn9NPIf1bA4RwXowzRRtab8Se9xqN1a7dkdQh23h1yuuLJQEXwTnl+V5oDhBtZEMpayEASHOKMId5RIFpw3BXKz5gKPERTdkKkOF1TMq/PUwMHtSNn1Sts/xA5LW5KfwGukiru5OqxuaC4HRJFQCYkNZz0PWEuvAkPWQOZXn3/x4LD7WpnzA7stEOCEqNx+Fb+fOKZBrpejhAmZLnmcFuHBZh3p453PeKZear4WG1/SEMeqV0K9xleJJj0mhDwsNDZy69zyMHiKvEVgt0JXbwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIuapQxWpOTFH0axwi9ywl2Mk/2I8M4IiGtxuGKzffs=;
 b=I4wwX2VBC8EX7XYA8+727llaQANVciO14HXhMestetuEbVdwe1f1qDVyDp8dKTGIEhBvzyn3PnYHClKbWuHB/bnRjqbjvXdkHSFTkZeDCFul3GpEe4mkaiU47oR3ZEdSxROYi9W4rDoYRUGDo01pu4/VSz8aBa66ueP0hTD/0CwkPVZL+wP9NFQA88jdiPci6aR55ZGtSNB0Fkm9CX8xCPJXw+bj6UdKag0ZyyiyAsFZRH15gI5AB/NLc1/yaeMyhVZpwyufmdEn7X3LJVR5zwIYLkTO0soWKENHOcpsewXD6WalWEgqVCJ+fPuqPVnXRCQqiJ3PX3BQHRnbeaz82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 08:26:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 08:26:00 +0000
Message-ID: <7add41ad-2cff-adef-08c4-dbc02f7c7c31@theobroma-systems.com>
Date:   Fri, 23 Sep 2022 10:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/3] Input: add `SW_BOOT_ALT`
Content-Language: en-US
To:     Jeff LaBundy <jeff@labundy.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, dmitry.torokhov@gmail.com,
        klaus.goger@theobroma-systems.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20220922101211.3215888-1-foss+kernel@0leil.net>
 <20220922101211.3215888-2-foss+kernel@0leil.net> <YyyZRt5j180KzGqc@nixie71>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <YyyZRt5j180KzGqc@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: ace90edb-0f9e-4032-f6b2-08da9d3d3ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Lo0PziwvXeciu3l3ow16mPcOfeKj5pKtiiiqeF+bgd+hnY5b1aPLV8wJfoAFqArav9Lo4yeHizwvYP111kETAKW4I6z7fLXri/MwPM4KnvE1wX2goaazhzu5vZ+rG8swxac0yiEVYYeYGYtlBlWO+/z+ln0WksXwl5AZVZ7cp7qTm+4AhmiTBdj+OOvs97JVnGjMAl2HvzieEI7AP2mOuEPMbUsjtQ2rdelgSVM9KkBztvo7pQ9VPwgzGtYIvvwPcDEnuvhZmkhKmK3RZbqoM/HZYZHe1scihhdZ5aBLdLqwN7xQWo187ciA+w5gLspmJbKU5lbVrN1mpEdmZrQqFSSGb6U6evHY11ys0hA3L/tgaV9KwwrxLeUVO9JXoiO2r4EKxqqvkUJE7ErFpl0PgggegVZ8oxoDeY4oUxM12LRXgzYFLKHkVkF0DlPycifo5qntepyftQ2VnWAxFZVaX/HC+eobiA5ClXzEX5sCDq8YIQX6Am+EM5WQ/aKYNP5EH0FHTXn2jYpVpyvLS1ONoRRYJz0j8s1DewenwIgebHY9rJCTHYbaYfKx4bpvIi3jl4kKCigGgnegKJccRb4q5AlnGa1YDMlGfSNgq0MErG48ZKmcZDbeHO2idFZcEPdOH+oF/EOtQNft7lWFBzFzmZ+zWy2MgCaregYskFiiWqEedZXd6+mxKib+aHPpZVZNsPT41Hw5LPnOoRkT6/OIZk833sBZ/NfRQtRlcNpDZ/1Y9MWSWNwb4qbExxxWd4Ge2bPtXWZTgNe1z4CJBqEbkPDuGWrkdw1qPEc+/RXw/ScmexFACAnjygcTzw+6YkKtev5eYhItd6phqDbsMPx1Kb4HoeFVJxomt19AOaXSLsPoORLfPhT3+IqAJb5p/NjMj7AVbTB3h9ahEjQZk70ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199015)(26005)(6512007)(4326008)(6506007)(66556008)(66476007)(36756003)(66946007)(186003)(110136005)(2616005)(316002)(8676002)(478600001)(5660300002)(966005)(31696002)(8936002)(31686004)(7416002)(86362001)(38100700002)(44832011)(41300700001)(2906002)(53546011)(83380400001)(6486002)(81973001)(15398625002)(45980500001)(43620500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JvdEdSOEd0bmZBRVFKUEtwQm9iayt1dTJYaVUvVFh5aVBUNXhkcEpqR2ZY?=
 =?utf-8?B?UWZ4cTI3N2wxT3JKZml2dG9iaDlpTnkxOVRJU1JkQ1FPSURUZVZQa2c5VGk5?=
 =?utf-8?B?SzllTEFZM3l6VnNtRHdCRCtPb09SbWl2cTZyTWFWazZDdnNXaVRSUzYwdENs?=
 =?utf-8?B?TktCaU4xUkxuU2s4NVZsMDBuT2R5TWhLSURXRjdOZGVLU3BUOFgrbFhkNG5L?=
 =?utf-8?B?eFBkYWRXcjlxTGVHdFJXSzlzcm9mZDRDM1pCTWN1WjhwS0p3Q1lEaWY3dGtK?=
 =?utf-8?B?dmpzd0F0bDVUWlV1RndVS2VhbHlNM0hINDNjVWFzNXg3eGY3SnIzeXArTTRR?=
 =?utf-8?B?L0M0VU5PNnA4TStaR0tobDN2WklKODFPalJFcmo1NFh4eDVYdFpZN1pQRlVM?=
 =?utf-8?B?N3BDYmRZTEYyUU02eDdCaHI0QWZISkY5WFV4UTVGNU5WZGIwU2srVWQ3cFpX?=
 =?utf-8?B?NFBZY0NTTUVNVVRTdVlpQjQ2emdOUTBnWGlaSkwvaWJnOUR3NXgxa0NQRXZB?=
 =?utf-8?B?cEZkTU05MFJ3aWo2ZFhpT0dZazlSRkpadlFySzZNcjgrSVQzN0xBYzRTeDY4?=
 =?utf-8?B?U3NVMzZUZithZk1PeGtUaTVxUGNWY3ZBTUJUeFdmWTEwTEhwRTg0V1pjYnhK?=
 =?utf-8?B?eTlxWDBTQU90dC93NXNPaERIVHdBeGM3LzBXOUwrQnV5Z0hyZzNXVGQ2anQ3?=
 =?utf-8?B?K2tvald1T1ZleHF0NWFqQkNrV0JmNGJhTDlUTmNsR1dYUTRuc3M2ejVSdGtp?=
 =?utf-8?B?bGZmcWg5NTVaQThCc1RYODQwTUYxNjBoWHRUKytIeXZ1RGkySjM4RUVtSncz?=
 =?utf-8?B?L3h4MkducStMakJWTG1KN0FpS2pPckxzenA4bTRXOEJ1Z0xJcVdZS2RnWk5E?=
 =?utf-8?B?bXNjOVh5djh2K2tuNWpwM0taM0tPZ29kUXlkbThQTEhIOXd4N1F5VXZQVTVN?=
 =?utf-8?B?eXRxRi9SeUJUZURrckc1TmpXUUxaelBXUGtvaDhjTW5xTXQ0SlFwUWNmWFJF?=
 =?utf-8?B?WE0zY2FSZVVoSkc1YkdJcGcyODNMeVlCNGUraEo1K1FlR2NHZDVqbFNlWDdL?=
 =?utf-8?B?Sjd1RE9RbWE5dW1kQ0N3WHJETzJKYnBOcmE1TVRZbGErQ3JsMEkyUjlVU1Iy?=
 =?utf-8?B?UmRzWVFWRklzb0NmbUwvTUhVWE4xQ3dFNnp3MkdYR3Y1YndwOEpJNXVYUVNI?=
 =?utf-8?B?SS9TZ3RJaU9KWTFBQU9zcUlyTjViVWhtaHJWMUhmbjJBSFVZNlNkOFQ0N2la?=
 =?utf-8?B?dWxZVDYzWk15QWlSY3RkclBWQXU3VTJxQitZVTVaOEFTSFIrZW9qZnV0MkRj?=
 =?utf-8?B?K2pOL0llWkJrRWRMQkp3QUNqVDVHSmNKOVdVQ0hQQ0FBaW5NMFJSa0hsc2xn?=
 =?utf-8?B?dmtzMlY0VGMrTzFOcElobjRna1dtUUQwZm1qaDRRMU02SWNtd3R0MnpiNlBV?=
 =?utf-8?B?ZEZnWStNV0ZBa1hpUGEzdWYwZzN1ZU9VTFVaRTNrdzhzZzBud1RMVDRHMnUy?=
 =?utf-8?B?akpXS1FGYlFxMEpIVE40ZzlQbHN3aHpHeHhJKzFxeTY3VStLdi9OOUVWL2J0?=
 =?utf-8?B?VnZ2bFJsRUJ5NmxZM2hxengzTlk5SEdoVzFGNkV0d3lJckpReVVrR2VjamEr?=
 =?utf-8?B?VFVva1NVUjN0ZzFOeDgwOGZ0dVBBKzJwKzd3SnFXaTRNeGNFRUJydUx5ckdM?=
 =?utf-8?B?MTZ5NS84azE4cWpkTHMzUUpFT05IcktlVWh0bkVDL3pwRmdzVWtlZk5pT3h2?=
 =?utf-8?B?VUFFMEJxazdtU2NBUkRURS9hbWhjalpSMEtTcXJVSi9CbjliVzIwRnV6NDNL?=
 =?utf-8?B?NUNrYkRENjY1NDBrR2NYR0RlZzl1STFjb1R1dnhtNmM0b0NobnphUGpxU204?=
 =?utf-8?B?UjdCS2VqOVcwTmJKUDd1TXdoVC9jaTVCS0VKTHF0ZzE4VHZ5Z2J2QWFMZ2Jk?=
 =?utf-8?B?d0NWa2xtTzhBTkEwbjlTdGkvTmNiT2ZNUWxGMjl1aEdxZ3dvU0VOMDhjTFU4?=
 =?utf-8?B?cWQ2YVBXekJUZ0ZqV0VwSis1THkrNm5yckRnOXNRc0pBR0d5UzBXMjRHanVU?=
 =?utf-8?B?VWg4QnluRjZpSXhSek84Y3BJcFI0ZEJMR0VyWmFBcmJWZTg4YlJRaVg3bHZy?=
 =?utf-8?B?M0lQSmdGd21aR1BZbDlZSTNwVDhVKzd5YTQxNEZXMWRaLzJsSnh1U2xVOXE5?=
 =?utf-8?Q?waoFlGG9fEH7lXj+E4Z7IpE=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace90edb-0f9e-4032-f6b2-08da9d3d3ee3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 08:26:00.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMry42OR9WXPTFImM7krIjoio7mGpHzmBt/Wb5PeDq12gNPrUfvMo+Sj2YdU4yXIfUq1S8kDNblh2hPiKHse1x7ejURkFpN8qydId6TJw0glaAgplWLbswRrS7DREyFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 9/22/22 19:20, Jeff LaBundy wrote:
> Hi Quentin,
> 
> On Thu, Sep 22, 2022 at 12:12:09PM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> This event code represents the firmware source to use at boot.
>> Value 0 means using "standard" firmware source, value 1 means using
>> "alternative" firmware source.
>>
>> For example, some hardware has the ability to force the BOOTROM to load
>> the bootloader from a secondary firmware source (say SD card) instead of
>> trying with the standard first and then the secondary. This event allows
>> the userspace to know which firmware source was requested *in hardware*.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> This does not seem like the right approach, especially since the switch
> can easily be flipped after the state is already latched.
> 
> If the bootloader needs to pass information to the kernel (boot source or
> otherwise), a safer and more flexible approach is to share some variables
> in eMMC, or pass information using the kernel cmdline.
> 

I made a terrible job at explaining what this switch is for, sorry.

Obviously, the state of the switch cannot represent which firmware boot 
source was used as only the bootloader will be able to tell (since it 
usually tries storage media in a specific order and the primary boot 
source could get corrupted at one point in time). Anyway, like you 
rightfully stated, this is useless "info" and the important one would be 
passed by the bootloader to the kernel (possibly via Device Tree fixup 
in case of Aarch64). U-Boot does this to set the memory node so this 
could be done again with a different property or something like that. 
Anyways, not something I'm really interested in.

I have a switch on my devkit which implements the 
BOOT_ALT#/BIOS_DISABLE# functionality from the Q7 standard, see section 
3.1.17 Miscellaneous Signals in the specs: 
https://sget.org/wp-content/uploads/2018/09/Qseven-Spec_2.1.pdf

"""
BIOS_DISABLE#
/BOOT_ALT#
Module BIOS disable input signal. Pull low to disable
module's on-board BIOS. Allows off-module BIOS
implementations. This signal can also be used to disable
standard boot firmware flash device and enable an alternative
boot firmware source, for example a boot loader.
"""

This is basically the configuration of the firmware boot source to use 
for *the next boot*. It does not represent which boot source was used, 
nor which one will effectively be used.

In our case, this switch electrically disables eMMC and SPI flashes and 
only allow to boot from SD card (this switch is then electrically 
overridden by another GPIO at runtime by the bootloader/Linux kernel, 
but the state of the switch is still available to the user via another 
GPIO).

I have this switch on the board and I want to expose its state to the 
user, if this new event code is not possible/a good idea what would you 
suggest we could use?

Note that we already support the same switch but in a different way: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts#n167
We are just configuring the GPIOs into the GPIO mode with a pull-up, and 
then it's up to the user to use gpiod or gpio-sysfs to check the state 
of the GPIO used for this switch. I don't like this, very not 
user-friendly and was looking for something better :)

Hope I explained myself a bit better this time, lemme know if I can 
clarify anything.

Thanks!
Quentin
