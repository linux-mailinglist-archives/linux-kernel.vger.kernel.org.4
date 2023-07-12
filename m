Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3423975035A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjGLJg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjGLJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:35:57 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17C1FF3;
        Wed, 12 Jul 2023 02:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6T7lQmjCoPdR1aE6Y9VrYa08PvbG9/Oe1on4ZNZfHM++VyOD34i4qXPhoeI2elb5U6bHcVbQfVhHZz4rj8YGCc+E146qtCigoZIjoZW2feNgRgx2JVEpkD/M8WD8U9crnKo93jBpd2QG8DiCz2NPUPmvRRiRZtn7iojUBm/JdqeK2tkb2YW9Y3dOvJGVsgnra59Cut/qX5rBJAYkabZVy4hYLsC93zw2QcLmNYx4luQzUu8Q4iTC7COh7Ppy9yWk4q93F8kegL7lY0C1NK+wDTd4oWSpKeenf6T0pabwYAGyS+jyZ03yj14gNhdbmfboKktg6dNUUQZgEEld20Elw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLf6qz+xtBOzajbFrDVBtug35FxP5ZQC5eU36kh6To4=;
 b=FEVadYjTW8qOVzVaM71Z+I8RFDDgLcb84bjQM34lTGkFJqkVheTR85v7jJ5TbHl0iq5Raebb1w59HpRlq1Z1ZB1wJ8Hy4gWPqwfU/FdGRZSXRmXaP3YhLb1AB3UycrZyCzrRA0sJP8iqG/iHLYciwSExMXFwTAHZKQd7UgAPuKAg4kuXhO0FBHv3o+F9RKm3Op/+zwog7/o/gd9OyPhKFqkCUi2h3JT8jurETY1nTZQG6PtCfbPifB+AJTB0LY9sDbuEvdoUn5a45cbqCKVXOCnIL0iKZn6tR6xnN6ofY+DUkshKDBiQtnaPpAttTn7avkeQx1wzJEtTsEKJCKIBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLf6qz+xtBOzajbFrDVBtug35FxP5ZQC5eU36kh6To4=;
 b=qYAcWRrxzPsjHSjYB/gtovWZbwW/Jb/Ehxq4Av9dKDdhPvLeh+6/RUzgwEhFBzsJXebNQRh2A2hmXy627Bsz+FhXcePt8xK3FevV3Ekf3KAeVk3zfehHBVwKmKVrBo0rV/ry9l/hZsKS3Ma+MwR1fIVEgE5Sqe4W6xTbuQpvnNJlDDUeAI/ACX9QeH8nyrzwkkNKoDgAWDlwab0s68RbArp0A1hFiqGbOv8hAEnjOs/FCjp2hMArVB1+qrK9iGj2d9ucuoD4cqAmT9X+4rzz5mNzSgMtPi+ETOawOSG1iz3YbrUeD6WvTOP7D5vuWEugnajT57xJC4/ZieyZu9XeCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7871.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:34:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:34:20 +0000
Message-ID: <b0f31712-a20f-f5c9-5b49-7473ef5d8be7@siemens.com>
Date:   Wed, 12 Jul 2023 11:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Content-Language: en-US
To:     "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <HuaQian.Li@siemens.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
References: <20230711091713.1113010-1-huaqian.li@siemens.com>
 <20230711091713.1113010-4-huaqian.li@siemens.com>
 <165cf95b-663b-5dac-b686-a515f2111656@roeck-us.net>
 <0d1b15b1016d451862b895f851c6c6c81472755f.camel@siemens.com>
 <ec89d59b-bb8d-ae7e-2284-1fd6bca22366@roeck-us.net>
 <42d578c52a590f50f90e2378ef3e2a1522038fc2.camel@siemens.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <42d578c52a590f50f90e2378ef3e2a1522038fc2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:610:cd::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: 6966a049-dd00-4ab2-273e-08db82bb2b8a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9KG4poHiahOXKAamX7binMynYdphMixt2O1j7XqVPinI0UihJxgvrWmBFRHFZuEfwofp1yCq3m6qQgQudozM9Toa7dqzT4+TsJptzYAvoOdfvmL82Y/iLXC3K7Mj1wgvUXd6y/RJJti7QdVytfUK5556L7JwhGt2ZrIUN8i20bcP+Dskg4MHDGlmNvyIzP3Xubh/I7lTtnHnmnanxTncYh9RvNTTaKa7ztlvBzWRysfxUYzOZdvLq9L4kYD5sDEr77Myh5nPaSzn63fHwCTkTnenJjebSocXWbkFNY0pZD3bWxBh5bizXjAY/OO4Uq1TrsRlGywFz7z0lKcFRW1D1Z33nKjmRPuJp/etLQp0AL53XkmtJlTXSE0T3CzVEwUK5A6tytkhm3qN/wOFs0b27wU+Sc0DmICKodf3a9IffwrOcAQNSfVzHUetQ/pSz+wPMWXI8kdLEQqV5nNfo7GEsFCt8teflSLVIibA+AtD7K9AnfzV3U25HL9yb0qukdGUHPw+yov+/UeBhxJ8Pb/eKVADTAj5W/rUMEK8iQUTsLPbNzu1WG/RVJXlKR0F8Y9FkZ45i14FWJHk7xuLweomPT4ObNALcErAHFtYbQSAyfJInR99nucJ5JQq819oVno
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(38100700002)(31696002)(86362001)(31686004)(36756003)(6666004)(54906003)(110136005)(82960400001)(6486002)(6506007)(26005)(186003)(53546011)(2616005)(6512007)(966005)(5660300002)(2906002)(66556008)(316002)(66946007)(66476007)(8676002)(7416002)(44832011)(8936002)(83380400001)(4326008)(478600001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1YZjVRaVYwTE52QXYxMnJJbnZpdDRuQVprZkRpOU53UWFIS3RNMXdMd2pa?=
 =?utf-8?B?dG85WTNOdUhpVWd5N1FCeWhKQjZNTU93UGtIUHljdlMzMVpyMytYdmhzenl2?=
 =?utf-8?B?Z0JOK29wbHpscXBrd2s2S2c5QzFvNUZodGgzSTFVRW1VZkFOWmR1aXh6UVd3?=
 =?utf-8?B?TDdMbzhwaDFzMWlKRUhCN1pBVDUvMlIwbjYrVTh0RkZ1NkI1d1dPZXJhaUVC?=
 =?utf-8?B?Q2V3ZWd2WnhncjFJLyt6YTRIU0pKVWl6ZWkwWDZ0OEc3cHlDeUx4ejkwUlhp?=
 =?utf-8?B?VGl0bEZEby9lNUdDaG05cGtwVG5LZitha2U4MGN1M1IySHlUWlFoTkpNeXMz?=
 =?utf-8?B?RzJoNlJGbWF1QVBsRWVPRXdYYW90amdLTHdsZzVjRzBxQ2xhaWdrTU52eHNC?=
 =?utf-8?B?UnFNZ3BBckozQ2lMazFHRW9hcVZyREpVZ2l6R25aQUV1MWJNR1dGancrU1lp?=
 =?utf-8?B?NzF3bDY0cnN1Z3p4bmI4UHR0TUFnSDNaa3ZOalk0RVNuaVZlaGF4RHlSai95?=
 =?utf-8?B?V1NvNCt3blpUdzNZclQ4MzZMOEQ5WkxHOUJyMUl2bk5LdXFVcWVyam5ISzBx?=
 =?utf-8?B?NnFIWTlBUFE5SnRmMkRIOXZUbmZDRG5zWi9RM05hdi9nbDVLbnF5QW51NlhU?=
 =?utf-8?B?OWg4dUpRV3lzclhENkVFd1I1cEFiUGo2TXYwTms1eEk1NlpsK2RKNHB1Q3FM?=
 =?utf-8?B?eVRlMnhBVjluNGFqenJDZldTRW9FU3haUFNqZEVkclhnZUdmcHFDNEJEVndu?=
 =?utf-8?B?QkZneDE5a1BMWU0wb0ZqRnhnY1NGMUJ6RDM4ckg1THJKdVRqdEpVcDY5TERX?=
 =?utf-8?B?bnI0dit3anF1OFBOVFo0SklsUDZQdGttMktVQ2VCN2gxdnVPY29mTWhtc2xN?=
 =?utf-8?B?SXE5NlR5eXdGS2pibkFHSDVSKzZEbENCL0p3N3Rld1lTcDVuSEJxbzI1Q0xp?=
 =?utf-8?B?c1Q1QUNLbmlJZ1MrcVZSQmpUbHNXT0toSXp5TGY2aEdBNk8xTS9JUzRJbEww?=
 =?utf-8?B?ZDdUTEVKaUJjblRydWFxOEdjUW1QQk9KOUdqUWJnMHkrT0h3d28rTDJhdldB?=
 =?utf-8?B?U0ZaditNNWFhNFVSOC8yUmlGVkZDc1JGSWRwOEpjOVBtZmNhaGVBVk5mSis1?=
 =?utf-8?B?Y2ZIRmJOT1BZM1ZZbStkSXEwTGdBcy9lSTJkTFhFM3VQREw4MGhhcnl4VVVM?=
 =?utf-8?B?T21iR3g2Vzg2dzVJV0FLNGMvWldKMDVRakVWaXErY2J4UGZZbVpPNmVGSTlJ?=
 =?utf-8?B?VW9qMSsyTDgzZTlKbDVGTTlkNEZkQWUwRDNCZGFqY1VBdk95SEdZcC9QQ2NJ?=
 =?utf-8?B?bUhIUEdTNHBhVUkzNUM0WTlNcTBnUWVETWY5ZjZMeEJ1bE94ckdhTWE1UEor?=
 =?utf-8?B?NWRVazcycWRvZGxueTNWS0V2bGZJWWtacUdQWi9VOXpXcldIWHp1Y1NXV2xw?=
 =?utf-8?B?QW5RK3hpWXUvblIyOVVKVW5YYUNWc1ZZYjI5WlB2WlhkZGcxcXRzK1pKTlNt?=
 =?utf-8?B?c0ZSR0JSSHRDQ2hIZEo5dDNOKzFZWVJBZHlZYU1jZ2RsTStaYmxWVFpKdVhq?=
 =?utf-8?B?bDVoWGE2V1B0d3BsV04vWHd0aFJYTTNndTJEeDIrNHAyUmprS0ZLUTJQdmE1?=
 =?utf-8?B?aCtyamZZdldxcy8rMTRKZmlkUlU3SVRVMFhoR0VaQzkvVWRHaTJmQklEYUtG?=
 =?utf-8?B?Qys4Wk1RRERSektXaVhlUTI2bzl3UVYvN0laVmJ1RUF3U09ORlFUYmZITmdR?=
 =?utf-8?B?Y0FFNVJEVnZSY29ENlBaTGJTNmRqTzViMmUxcUIybFhPN0pCajFtUEpKbCs3?=
 =?utf-8?B?Q2xQb3djeTN3OC9lM1JQT1RORmJ2bjZYWkVDUG1GN1B6L1FDbkFVK0RPSTNJ?=
 =?utf-8?B?UXBudWsxZW82TExmdWxQMFZXbGxNQUtlM0dWbUEvaFpMcmplTjd6SFVTUi83?=
 =?utf-8?B?ZTBzVStnQnhWTUtUc2ptNmJSMW1VQWpSdUNwa3gwdDAvQmtPWUpXUHUrVVEw?=
 =?utf-8?B?aHpxOWNWVlh6U3VJZDhLQndaVnNhaUJUZUZrQUFIZ0NmTFFQNHp2Q3VHMDFn?=
 =?utf-8?B?NUVPZFBid1RESEZ3Vm1ZSVJFUlVaRnNOWitBUUkwdlJOK0doS3ZRbzRDRnEz?=
 =?utf-8?Q?mgte98eGnvPd7PmlBO35fNzgl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6966a049-dd00-4ab2-273e-08db82bb2b8a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:34:20.5970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPAe6B//8vFzJ/LyK6dqhhdvhksjy3MqKrZozF1mqjSBzAXbcJe4CLL7rjWjeF7r5pRuIrz/bS0kSObyBRkP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7871
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.23 08:05, Li, Hua Qian (DI FA CTR IPC CN PRC4) wrote:
> On Tue, 2023-07-11 at 22:01 -0700, Guenter Roeck wrote:
>> On a higher level, the entire code puzzles me. Obviously there
>> must be a means for the BIOS or ROMMON to write PON_REASON_SOF_NUM
>> into some memory area. That means the BIOS/ROMMON must be able
>> to detect that situation. Why not use the same code to detect this
>> in the driver without the complexity of passing it from BIOS/ROMMON
>> to driver in some random memory area ?
>>
> In TI AM65x cases, the hardware is not capable of issuing a reset on
> its own, and is not possible to record or detect the watchdog reset
> situation. So `k3-rit-wdt` firmware which runs in a mcu core was used
> to detect the watchdog interrupt and reset the Soc. Here I am trying to
> write the reason in this firmware when watchdog interrupt happens, and
> read it out in kernel.

See https://github.com/siemens/k3-rti-wdt/issues/1 for where this
started and where the firmware part comes into play.

I still wonder why we couldn't have had a nicer hardware watchdog
instead but this can't be changed anymore.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

