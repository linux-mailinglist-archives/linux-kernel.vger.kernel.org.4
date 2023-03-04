Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7064F6AA89F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 09:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCDH76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 02:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDH74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 02:59:56 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9AD1167D;
        Fri,  3 Mar 2023 23:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHPA49pyjKAdJREE4RoX7BkQ6pSHEw+9zEDVsmx5l/OOcPTrs0PkQ9ZGcgYlpiYKLqTFxnOLSSNacEcitl7FUnKxYzI21+JmzmAlRtfn2+hTL4kyEfq5JaK4GOP1Lp+EXW6QfpmYAGVoyJErM4VxxMrPWorc9RF0mBlaXIgiL7EMN/yx20ENWnhhXm9TuZSrHOhLJb6EobNuG5t8hGhK/ePahlVP67CgbG0i/H+DRHfPpgDEAfvbxOX0Mbh37qhUB0fIzlyRg7cVp2Bg9ypftg1VWj+q9RCAr+p2RsRRgulpwQJr+ldDqjC+fgaSMFc4NhQ0P03BqKpiK8sCUNkqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmTJMX2l1zklvekTbqjbzgjFkshu3EybXelDktpcLw0=;
 b=PKzAIdwgSV1wjydvjzdq7trztf4dRkmw4025+VAyGUmiYM7SoEBJpD/rraUOj1KVUJtr7X8CkEJe3y4a3kUaKA9h7tzvaY3JeqPtwM9XVHWvPfZ3D6PZ6RGiW553n1+fPHXIvR1OC9QXObgYc3NjyPctowKUfjes9a22gpjO8MC0nlBffOVw7E7FPfZ4ZJMqgsVkfPXMunD6ZCYWr1yybfNOgdomNye8njZ5jVYBgiRyKopT5+qDYEMwELgdyocdpnTFTlVfqcSoO34zE5aMEJeuAt53ZJFTsUL7ztlZcqCVnt7m6Vx3mjxAAHoCaFMSwBkn0wHHjsDNaPpSix/iKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmTJMX2l1zklvekTbqjbzgjFkshu3EybXelDktpcLw0=;
 b=QVV++sSLprChO4HD5Y/iVrxxvK2B9KKeVwZ25QG3AvPNjj5C64oi5xO9/RBz3gexjjLexuUFdGkMicgVMCRGOqLEXAqK12/NAD+VCBAc+FJJoD6kKn5VRuLCacX4JK4qyUjtdG9ugIT5gUFMYXsJx0D4tTFZiFMaMcZRISS5sxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8301.eurprd04.prod.outlook.com (2603:10a6:102:1c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Sat, 4 Mar
 2023 07:59:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6156.022; Sat, 4 Mar 2023
 07:59:50 +0000
Message-ID: <343571ba-faed-35d7-2859-2668391dadb2@oss.nxp.com>
Date:   Sat, 4 Mar 2023 15:59:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com> <20230213175006.GA310433@p14s>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230213175006.GA310433@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c97d8d-57c3-40f7-ebc5-08db1c866dfd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXepWJFTI9bq+59Hpr9A+yrpOsgp4OLkyATotPVevGhQiNNtVnamSBRe+/6u89qpYn9VX/wu415TPD2swunMBrHj8gbtNwkKdqPDekFEYTb2ruRKFQDCTSHFCjFxReyPy+HLN9rgxXbPy2b/JBvwNtEvqrdr0CtokhqVcpnNwqczPYWq2JLYvpWmCN9ELLWJ5e3n1RuI67odSeZ4ig9IzQwuKwe9TPf2dEhMuxyFkDGnhiOnvgL/x+VRsPjT+hit1bS2Dsw8ykzox/aM0b1RkeWHdUClg8LHpBfm147tlYb6emBgOdUs7h2RFtMvXyPbFC/Nhmbc7iCOngW815Qxdb5D7NR0rA9SFpCiSAVNGRjCjvVmg/mV3Ai6He6jJFWxVNJW/VmTOcZcuc3xS6dMEOdJd5SSY+WKNMbqYtICrnvux3eZe/y/jrM51UtX0cg8FvOr6IjnehvOaaapqtrX/sQnssWCBGNvZ5ozzmqUMQggfUVZmpX1jbgibIRRfuAw8wvdo7Xp+Ydm+XKG3CE7+fxm3WBZ/hNy2tLh7mSBq0l6UVQ1O0QNGyWFUve+AdTO16oYnqBSzl4WSBkQj2Y8R3bEO5UOqhmt/NMRvMGSRYiENx9xkwOEUZxxWDaZhubdFBjA/Evn8F3yvtU/m9i6/6toeGUwTBK2IrUIRr1bf5SXeWhdtFNYVzBzlqwfHBOFeJUVUBAbYpr69/vKjoiykKSlQS12+9vFExVDq7cZ4A8HN0CskZxdzEaZ2s9JUpylkekaPSjm136CUSGZia1Q4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(41300700001)(38100700002)(7416002)(5660300002)(38350700002)(8936002)(86362001)(31696002)(53546011)(8676002)(478600001)(6506007)(26005)(6666004)(6512007)(186003)(110136005)(52116002)(2906002)(6486002)(44832011)(83380400001)(66946007)(4326008)(66476007)(66556008)(54906003)(2616005)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXBNK0ZYdUx5bjRORkoyd2xuRG9XcjBGbFV5MUtmOWpDdldBVFQzYzhzR3RC?=
 =?utf-8?B?VmwzdTJORW1kR1BEdG81MzQ0YUdkeSttUGxMZjBVc0VLdnBhWnJ2OVpDbVhT?=
 =?utf-8?B?eGFDMzlxUmg3L0ZSemVqeEF0Nml6eHJRdndFODhCZnJMSG9yNXk5ODJJZzBv?=
 =?utf-8?B?WWt3TkEvaUl5a0RwNVZhdVVSTk9rSkQ2WmV2dXZ2a2wwUUVTOUVibmRWb2lV?=
 =?utf-8?B?STFsa1RTSitlVS9LdHBsdW16N3I3Z0huamUyeVpWeVpLU3Q2SnBNZXFaQjU2?=
 =?utf-8?B?MlRyTHMyRDJ1L1lXbFpNN1hvYXZxMklSemM4RklsMTFsN1hnLytHYWdLSFQ4?=
 =?utf-8?B?YnM1SGtuR2dMWnZxQlk5Y3MrQm56WW5pd2FFVWptdGg3ZTFiMko2REVUZ0hX?=
 =?utf-8?B?Z0lwSlZUZ2JzamRIRnNCKzQ0Wml5aHJ0L2g0eFR4OVFuRnR0cEtSOTB3elpR?=
 =?utf-8?B?Ym1jZEs3bU5ITzJ4WUF4NTFFMGZKSDhTWHJ0bCswVGJkMzBEZHVNMGlDZVU1?=
 =?utf-8?B?NGpxNEVRL0xWd3B2U1dpM1RYUmhEQ3BPY3NzNjJNb3R0U2ExYVhSY3ZsN1dw?=
 =?utf-8?B?T1E0VHFnTE9nNHptQ2Zqdy9saTdMYXcyQThRM21Jb0UrVnE0N3VCdXlnR256?=
 =?utf-8?B?SEFsM3V6cWtoUVlrNzUyQVVUN3MyL0xzK29DVkZDMC9mNzNJN2FVS01LSmE0?=
 =?utf-8?B?NkR5YVVGSlRZb3UzQTdzU05Wc2Z2a0d3U3I5eUhEbDU5UzZNOFprb2psN2FP?=
 =?utf-8?B?ZHFkNW02NlVnSFVmZzVxRk5UbFZOeTNYMVZIQ1I0NkphbjZqY2NJdWlWNHNn?=
 =?utf-8?B?aExSbGVYTFVKN1RtOVNKRERSZUI1eVN4K1EyUHYwYW8vdHhGYlBQcHlZVWRD?=
 =?utf-8?B?OG1IMDVNZVpLYTNjd0NsaEdvRk5GSEV4UkFOc2gyeWhsUnZCTDgvWXBiMGhz?=
 =?utf-8?B?WS85bmx1MTBNVzFBRDN2NG42d0J5RCs1VS9mNkxGY2JTak9EazY3SlFJcGJR?=
 =?utf-8?B?WC80NVJGUEJYYmR5OU56OEhoVUFEZ1JCc0lNWVZBbHlFY3VudENBem9iSExJ?=
 =?utf-8?B?VFNZTThsTmJHdmd6dlFwMlk1cFJOV25rUDFDT2xyUmM0V2hSMTdma0hTRm5J?=
 =?utf-8?B?bHZPTjQ4K3dsU3R4Y1BFbzFsTDBBb3FvdHhYWjF1SVFveEo0V3pIQXdQRW4w?=
 =?utf-8?B?VDFFbkpuLy9zb0VRSDRVUUJkS2VpVkZ2bFVoOGUzYVl3QnRYR1dXWnhvblFY?=
 =?utf-8?B?NDluWDRTcFBnZVJLK1lGblJKQ1htblBsbFFWNkF5djlKUGtSdXpUdnVkUENi?=
 =?utf-8?B?WkxVZlRodExFTGkzbmFmRHlId2c0cFdodTgySTc4TllmcDNmWjE5bGpWM1Bv?=
 =?utf-8?B?YzNaWFAxcTErV2JING5FMzlWVVE2dHFNREZFd1dGdDZ4L2NBRWFOWUIxc1M1?=
 =?utf-8?B?b3dlbmt2R1lXQ1ptazZvUDRKRzhWYjR0bmRGY3NrVG11aDBSZ2VFUXhocDhq?=
 =?utf-8?B?MEkxS1VyVS96YitibmI0MFBYclRzd05xNzhENCtGblBQM1RPSTJIRzd6TkNu?=
 =?utf-8?B?N0FVa1hIVGcrM2tGSzJwRXgrZzZ3blpJeUtDeWw4QmYyc0wvT0JCUkttTEk0?=
 =?utf-8?B?TklUc3ZDamtSYUV6WkdtYys2YXpzemFUSzJnWkx0bW8zcHhYVURWb2UyaG5T?=
 =?utf-8?B?Wlp0VWVaNTdWYkR3blRjUmZmeHVZNnBZeGpMQjAxK3Fland1bzYvMDhNV1VJ?=
 =?utf-8?B?TnEwclZBcTFjazFkYlVNenltWndDVk5OeU9YVit2NGZheXluVE9xeG05ejNa?=
 =?utf-8?B?bzREeHZvM2ZTYjJ1dGFJc2RvRXY2QWpyMWU1ZEE0OHdENUpsWmZQZVRYSVk0?=
 =?utf-8?B?VlVUZ29nZWJhUFloMjRaMlIzVW9HdU02cUJKOHNvSnVJSlQxQ3dsaHMrSndO?=
 =?utf-8?B?bURSWU1xZnEyWTNGZDlUT2EwY0NXMlBwT2ZDWCtuNjJSN3dQYVF6ZXdON1hH?=
 =?utf-8?B?S3FnWTllanB4SlQ4dkRjaENDQnFpNGhGOVY1UWZ4UjVGajRPcDJvVmFnSmg5?=
 =?utf-8?B?cnNkaEh5Nk5QYXFLeDd4ZnhjS3ZmMUE2akFFRnJNbk5Ed3FYYlo1SFZSTDRj?=
 =?utf-8?Q?Bao39jK+oOsVyvP0iVnTdt0Q/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c97d8d-57c3-40f7-ebc5-08db1c866dfd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 07:59:50.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m25302A+Rov3tMRQTDzuTeK5vf2OliHB8MCrOK8Vv2/8Ddo6LR5r9SapfyQmqFe+hrfyV56SFIMZcL212eTzng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8301
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2023 1:50 AM, Mathieu Poirier wrote:
> On Mon, Feb 13, 2023 at 12:15:59PM +0200, Iuliana Prodan wrote:
>> On 2/12/2023 9:43 AM, Peng Fan wrote:
>>> Hi Iuliana,
>>>
>>>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
>>>> DDR
>>>>
>>>>
>>>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> V3:
>>>>>
>>>>>     Daniel, Iuliana
>>>>>
>>>>>       Please help review this patchset per Mathieu's comments.
>>>>>
>>>>>     Thanks,
>>>>>     Peng.
>>>>>
>>>>>     Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>>>>>     IMX_RPROC_ANY in patch 3 Per Mathieu
>>>>>     Update comment and commit log in patch 5, 6.
>>>>>
>>>>>     NXP SDK provides ".interrupts" section, but I am not sure how others
>>>>>     build the firmware. So I still keep patch 6 as v2, return bootaddr
>>>>>     if there is no ".interrupts" section.
>>>>>
>>>>> V2:
>>>>>     patch 4 is introduced for sparse check warning fix
>>>>>
>>>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
>>>>> could be in DDR, not just the default TCM.
>>>>>
>>>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
>>>>> initial value could be got from firmware first section ".interrupts".
>>>>> i.MX93 is a bit different, it just needs the address of .interrupts
>>>>> section. NXP SDK always has .interrupts section.
>>>>>
>>>>> So first we need find the .interrupts section from firmware, so patch
>>>>> 1 is to reuse the code of find_table to introduce a new API
>>>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>>>>>
>>>>> Patch 2 is introduce devtype for i.MX8M/93
>>>>>
>>>>> Although patch 3 is correct the mapping, but this area was never used
>>>>> by NXP SW team, we directly use the DDR region, not the alias region.
>>>>> Since this patchset is first to support firmware in DDR, mark this
>>>>> patch as a fix does not make much sense.
>>>>>
>>>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>>>> .interrupts section. Detailed information in each patch commit message.
>>>>>
>>>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>>>> If one can build their firmware as they want, then the .interrupt section can
>>>> also be called differently.
>>>> I don't think is a good idea to base all your implementation on this
>>>> assumption.
>>>>
>>>> It's clear there's a limitation when linking firmware in DDR, so this should be
>>>> well documented so one can compile their firmware and put the needed
>>>> section (interrupt as we call it in NXP SDK) always in TCML - independently
>>>> where the other section go.
>>> Ok, so .interrupt section should be a must in elf file if I understand correctly.
>>>
>>> I could add a check in V4 that if .interrupt section is not there, driver will report
>>> failure.
>>>
>>> How do you think?
>>
>> Peng, I stand by my opinion that the limitation of linking firmware in DDR
>> should be documented in an Application Note, or maybe there are other
>> documents where how to use imx_rproc is explained.
>>
>> The implementation based on the .interrupt section is not robust.
>> Maybe a user linked his firmware correctly in TCML, but the section is not
>> called .interrupt so the firmware loading will work.
>>
>> So, instead of using the section name, you should use the address.
> 
> Can you be more specific on the above?
> 
>>
>> First, check whether there is a section linked to TCML.
>> If there is none, check for section name - as you did.
>> If there is no section called .interrupt, give an error message.
> 
> We have two ways of booting, one that puts the firmware image in the TCML and
> another in RAM.  Based on the processor type, the first 8 bytes of the TCML need
> to include the address for the stack and PC value.
> 
> I think the first thing to do is have two different firmware images, one for
> i.MX8M and another one for i.MX93.  That should greatly simplify things.

sorry, I not got your points. i.MX8M and i.MX93 are not sharing firmware 
images. i.MX93 M33 has ROM, kicking M33 firmware just requires the
address of the .interrupt address which holds stack/pc value.
i.MX8M not has ROM, kick M33 firmware requires driver to copy
stack/pc into the TCML beginning address.

Whether i.MX8M/i.MX93, the NXP released MCU SDK use the section
".interrupt" to hold stack/pc initialization value in the beginning
8 bytes of the section.

> 
> Second, there should always be a segment that adds the right information to the
> TMCL.  That segment doesn't need a name, it simply have to be part of the
> segments that are copied to memory (any kind of memory) so that function
> rproc_elf_load_segments() can do its job.
> 
> That pushes the complexity to the tool that generates the firmware image,
> exactly where it should be.

For i.MX8M, yes. For i.MX93, the M33 ROM needs address of storing stack/pc.
> 
> This is how I think we should solve this problem based on the very limited
> information provided with this patchset.  Please let me know if I missed
> something and we'll go from there.

I am not sure how to proceed on supporting the current firmware. what 
should I continue with current patchset?

Thanks,
Peng.

> 
>>
>> For all the above options please add comments in code, explaining each step.
>>
