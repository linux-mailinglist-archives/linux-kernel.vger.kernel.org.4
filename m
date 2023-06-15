Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2C730DE1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 06:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbjFOEE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbjFOEEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:04:54 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2040.outbound.protection.outlook.com [40.107.241.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34AE3;
        Wed, 14 Jun 2023 21:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VygD9DpMVaQwg+Xp4Q86wW3bIx4Mrizzf6flb9B1Lww86jaIaevF5neNdYM3xjnb8wuR8DItZhUAV4MNUkg27/2KlNneFjYvIOvdg2rxq9YZwhFWumyyU4UXQFQQVmCjR45l7NRO7PrE4WnMJH/uNC43kvjUTp7/xfQhZ7fe26ZLVoNRs+05ldyhOamNsyLkkwDiD0PRMjNQkUlQlWH6tqzDZoQrvAzMZTf8M0mcd+ycvgAKLzc8Ed4uSUFF0OedCUV+00aJfRmQXSQ/gEMDxbWq0Kurywbk4WYh2uaEWqTuxubIE4GWjkbs5eNmbjVsj3XL9rXV52IOR+aef8FlGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GziC+0oDObUmZWxUGK5Fadfn5yBH40O6tOs7VUidWNk=;
 b=go3Gkcm6+huv9kT9i8imEAv+H0Zvg32XJQfgo7YzJc/uNudWyEgo1aYNSe7LhGFddms0VT2XHy7sbuts2QQ64TfUn89Tpg+CbHnwlwknuwCzVa0UWUiNrbOScv33fr+s1hpXtLDf3Z+VXnRSmQ7NxW3xuD9ezGqCViAYHQ9dBQNDE6PKsJxMkrGmbQapNndjnHDuQpSnl9KwEXHncRlyyAPK7yWDVUXx79pZOejIcsEzEHuFELDwmNbLuQlnzftY4rRWmLDsFTecQyhuM5+68IQAcUHuJpZkAk/FdG+C3EWQzkBlh/FWNc60lyEnaxRJWQ64QzVRTAZgyPHAiDjGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GziC+0oDObUmZWxUGK5Fadfn5yBH40O6tOs7VUidWNk=;
 b=aZ9zv4SDBMm9rg9UrO3zy029t1LbXNELNNBzmVWjzvHpgFiz3xrJZScARZAay7y1QPqZUgfNHhlQRcfq1T0+bf1X2zCdhdqbBVKHGnkL4/x8UT75aZLp470xUUpUWQgZl7ah0si+FDYYjef1ys6cYz1GNHo9/Ttqxs4HF3Wz0Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 04:04:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%6]) with mapi id 15.20.6455.039; Thu, 15 Jun 2023
 04:04:49 +0000
Message-ID: <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
Date:   Thu, 15 Jun 2023 12:04:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
To:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <4844567.31r3eYUQgx@pliszka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f21925f-4de1-4196-96f6-08db6d55a9c8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xS7pqQNDZwEJAx+EXh3tZpc8+8IKPHjbsp8mekGbRSHAOZjNdXJSipJLhRXZ8zHqwKmFrqqDdV6Xr3K4KgAqixQWljxEyTmkqk+zA0BwlsnZo6mkXtx2pKyGKWCMKmY48guL7hIoK/7AsvauuHQUtLmY+sql5Cqp3dkY1np/52gQQ3lXIe0muskM2vqQBxBG2seOhFni/kIUIjeYh/+6j59aO64DsvfbM33INQLe8qjB6RjDz1IAJvcOStIZujHRn65Gkrv1CLdpI7O05G693ZG1nvDiz1ffq/xG7StHE+kJO1CCFcYbUfz6WvxxO4KbfztnQ9lDvw847AnKtsiZqA+Kh8Y4ZLOOLrj4PYHUgahSjFdGhsI3HL3GhibQmsWc8nBgC8D4W1d5oC913HfNfxiuZxRZnAHs5sW315OR85zqjNCt5NKS4yYr3KZW4rBc3vjEzqzp1rFgeQ68SY4WbJafEwK9bdkgt6ZMisoGdpvJJq2ioghoJ0E8WkyKcrrXbc3LJqyBQ6mywhzm4GCW0BkSPjYZSP1vlqHK0P1Ynt4xf/Oxg5xLo3wJPJxBr9JVwR0A6g+souHmUMnubOnuqHiw/YJ/04MzF505q18521zNmXgjO00Z9L9Z1IsJIhP48drAFMQIF9gJEPObkO8bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(2616005)(31686004)(6512007)(53546011)(6506007)(26005)(44832011)(186003)(2906002)(83380400001)(478600001)(66946007)(4326008)(110136005)(54906003)(5660300002)(6666004)(66556008)(66476007)(316002)(8936002)(6486002)(41300700001)(8676002)(7416002)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVhTTUpiTndMaDE4ejNoU3VvdGdCcnUwVVMvWElzeGQxTGZLMGpRRmh5dW0z?=
 =?utf-8?B?ZHVmenZDS3FhY211dXY1eFlxVlZJelM4RlFlUDQwMFBRc21laFF0eUhld0JF?=
 =?utf-8?B?UlkzU3dCeEZEUmlxL3Y3SENrOGo4anQ2SFJwYTBXZlpnM3hHdk1oYmVjUkRa?=
 =?utf-8?B?Sk1XbGx4bjJ2SjJQbzdUdFVHT0hDMkx0ZjRGYXJUMllQbThCanpZOGdVM3hB?=
 =?utf-8?B?Q0ZFQVNERDhIUTVGSTV1aTM3bjF1VGhmdHcvb0tLTjBHZDVLcmlEK1VhSUJU?=
 =?utf-8?B?cUo1L0hlKzlHTHlDd25NMTNZV0U5NzlHRlZWRnFVcW9rQjVVb2VMNndFTURT?=
 =?utf-8?B?dDI0cVBjSlZyaHI4WW9QUG9nZCtBOUdPMEFlNnRHNnhkMXRwRTUzYk1LUXpw?=
 =?utf-8?B?YnM3aEdaK3FsU2xFN05naFBUNVd1emJMSFRlamxMSktIclJPM1NVK1UwR3p5?=
 =?utf-8?B?UEg5VHZGQlI0NHkyVWREWkpnd25NUDZzRHJRY2RXYlhuZXFDVkQ3SDE5clhU?=
 =?utf-8?B?UUZwSGNSUlpFTkxZOTByVmdWeXUza0t6ZUFEUU5VR0JRU2c5ckx3VEFZMkNC?=
 =?utf-8?B?bnlOVU9DUmdOcmxFaTEvYUV2eEtnYS92MVVqa2tvbG00aXhENUp1QURUSFpT?=
 =?utf-8?B?VVdTaVdSeGFTS2FmYTR2bGZxSUlUNWhhaTNZSTZPa3JQTWpMYzh4UFh1blNu?=
 =?utf-8?B?WjVTV0p2RU9lL1lSRFUrRHVCajdKdWNXOXV5djJuSWJaVDJDTmV1WE80bVBF?=
 =?utf-8?B?emRoQjlScFBxL1dabHY1UW01c1lNVzlLVityWi9LdExUckx2K2FHS2Fkb3I2?=
 =?utf-8?B?YkdDYWo2Qjkzak9NTjVGeHhYdU5CekVXZkh2REU2UjlmZml5NjBvTERiT0FK?=
 =?utf-8?B?dWNpUy82UHlsb2w5bWZsVGRZZDR1UDNKUVhDbFpaczltQ0JTd09pY2RkWU9I?=
 =?utf-8?B?d1phdlA2SXN2aDlrTVZaRlFlMGx0UktoTG1lUWlLaEtjWWZjVTdXK0E1UlMz?=
 =?utf-8?B?SUFLZlNnL3Y5anozWE12aHllWXErNUF6UDdoNmJXc1F3bEk4cld5eE1ZRXJS?=
 =?utf-8?B?YmIrQXFwNDFWSEFTNHVCM3ZJN3ZHaENVSU1EVUlrLytQSkRuQnRyMWRNNzdL?=
 =?utf-8?B?SitBNGxzUlNyT2xXS05zMVkzaGxUY3gxM0xMT3ZaYm8vd3Z4Wm8yempMU3pq?=
 =?utf-8?B?aGJUMURjVHJBeFQ4aDNSRGxxUmRtVkl5NEJzdVY5RkZZaGFJT3ljSjMxTWpt?=
 =?utf-8?B?TDRaTHFlS1ZUSWgzSm5FMHRoWmtzTTMwbU5ZQzZvSVFiTS9Za2EwVXFUSnhp?=
 =?utf-8?B?WnRTRFRhUitLelZFQmFWRDN0YWliTEVsWmd3NjBIbzhTQlVzR0U1YWltQXZH?=
 =?utf-8?B?bDRRSjlJczlTYkFVREF6T3V4d1UrWGJVYlF6Vk1RTm5vL3FBVkFTaWQ0TXRZ?=
 =?utf-8?B?RlhpWkVPMWdqdGJ4R29qVGdWeDV0VkVnbmhCTU5hVkZiay9lWW9UcElqdzd6?=
 =?utf-8?B?SVg2TGMzMVN5L2ZGMXExM2FXSnJsQUNjL1QrNEFjRWUrS0J6cVpqWG0zWXcw?=
 =?utf-8?B?R1RlcFRNTWFsZDNnN0phaXZCTXlEUW10L2ZwbHBETGsvYm1MVEcrWTZQTFJ2?=
 =?utf-8?B?OWdHaG9RbEplOEh6bTNReENpa2RndndkVUI4M0tWV0I1M0hWQ1psUTBMWEx6?=
 =?utf-8?B?MDFON3RrUXUxV2k2OTVBQXFockFpd2JNSFdURDc1RGpwKzNoNFBoT0QrRGhF?=
 =?utf-8?B?ZlczZWV2UnpVQXkyM0hnV0dLWWhlWlVJYzI0OGJ6NS9OK205QzV0dUY2cGZE?=
 =?utf-8?B?VFNJL2VBWVZrQ3RSTzd5R3pvb0FLRGtLNU5uOEdhdUFkZldrU3NJTUsrRHRQ?=
 =?utf-8?B?RWoxUTc1LzhEM1pWNGg5U3RwWWVpNmpQSk9aNGFyRGhJQWZ6TlRqRDZ3b1Na?=
 =?utf-8?B?ZjR5RkVrM0V0UXBWSU5DT013NE5NV0F6ZFpQb2xDc3FzeUF2bCtrbjBOVlpt?=
 =?utf-8?B?OTlWUEE5YzRnbnZxTmJoY1Z5UGZ6TXYxbXhZT2JXSS9jM1ppUzQwOHFydlk2?=
 =?utf-8?B?NlJzVk9JSWdMNXNETlhpdFpDQ2NLazBQZUw0TmxraXdWTXA0N05lUjhnZGdh?=
 =?utf-8?Q?gxDREmRYHGAKJnU4ZSiH18Fum?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f21925f-4de1-4196-96f6-08db6d55a9c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 04:04:49.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNvz0qGN55SLOpwSNOLK4bRkTwwMKFl9T9R+TP25SxeT2qHGwii2h3eaXDtsX7EIrTiJ434TMahspOG3SxofEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8898
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 10:53 AM, Sebastian Krzyszkowiak wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On czwartek, 15 czerwca 2023 04:29:01 CEST Peng Fan wrote:
>> On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
>>>
>>> [...]
>>>
>>> Ok, I misunderstood. I thought that was for failing registered thermal
>>> zone.
>>>
>>> Would enabling the site in ops->change_mode do the trick ?
>>
>> No. ops->change_mode not able to do the trick.
>>
>> devm_thermal_of_zone_register->thermal_zone_device_enable
>> ->thermal_zone_device_set_mode->__thermal_zone_device_update.part.0
>> ->__thermal_zone_get_temp
>>
>> The thermal_zone_device_set_mode will call change_mode, if return
>> fail here, the thermal zone will fail to be registered.
>>
>> Thanks,
>> Peng.
> 
> I think the idea is not to return a failure in ops->change_mode, but to move
> enabling the site in REGS_TMR/REGS_V2_TMSR register from
> qoriq_tmu_register_tmu_zone to ops->change_mode. 

But qoriq_tmu_register_tmu_zone will finally call ops->change_mode.

And it is per zone, so we not able to enable TMR_ME here.

This way the site will be
> enabled only for actually existing thermal zones, since those not described in
> the device tree won't reach thermal_zone_device_enable.

No. The TMR_ME is the gate for all sites.

Thanks,
Peng.
> 
> S.
> 
> 
