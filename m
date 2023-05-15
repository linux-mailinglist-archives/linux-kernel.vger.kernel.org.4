Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B327024E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbjEOGfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjEOGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:35:53 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34DB186;
        Sun, 14 May 2023 23:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R77cD1+HYpPSZ8PNvut+Ca2gRsPUAYCppyAzmWF+qNjgSRIsfJun4QJnx7g1wWVaii1+LDisQnC5TnaheEVjJwJMMggFaYAL4E52Sgc3RkK4rmAIiAsWZbY2hslRSRKmSJvJYa6KL1+tTomWnOE03px+fLN5b6m0TWAb2WEUaMkLrwdJ0b+/l6mu9pCT6rT2AEmKsidlipdWn0rbpKZRpVrV/uxLzFbUV9ld2x9Ek4nWggiqfVqqgJXyI9KnubqaEuMqgkKcBk5dHXC0mnkKZ2XStoSq2+SsCRegdTWYYJfNBSNrxAc1gNu3ZGpZxZixunc+lBpAUBIMRR9XTg+wCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7L/9kqfxDQrXtVZ6K4lDqyyYCmyKilVMvXCwGMGs3k=;
 b=bA8NNIGSczPOUvDTQFhyHyfgJwX0UNUxcS68XhslWWXCvsGIRjgDK5HyzzXNqg4blT+FPmJqnuLNHJRUMRk4FkcNL5rnpbBLMr12opqCdKvZ0dV9sz3KP3kUPVR/HvejnNhfCaiPdj1VEtXcArddnuQM7cLPwkAbon8Xjx8ZIyRu/ALZ3fgVlRjDbHIlWmYOofzf9m9UwP5Ndt5cynEmVARZFcdo/zRGHZB7mu8EXDlWKdH+uQUNdnERW5bkrW8ZO9+yj3coP4YgdVSv6KPZLWppV6CB18+xP5ErhKOZogW/9G0QJXr6pfxVpbL6FTHGkODFlMwt9xqHaBp39zN0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7L/9kqfxDQrXtVZ6K4lDqyyYCmyKilVMvXCwGMGs3k=;
 b=wU1UndssZRnAfYYJoFtDZBX0LksHKJ/iZKbHcK62Ax2ckJ/pYOw7yQ4K0jAPPGbW3quMMPD637RMGlmDCbFEzA9CMUfrqJfAHHj4W0/xZn3t58CndEsvUgFjkgccov647kttN8RbL2QyIUWjwJsGQvh8dlTC1gDDgUr4CyN8WHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 06:35:47 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Mon, 15 May 2023
 06:35:47 +0000
Message-ID: <55da12c2-dd4f-ebfa-c747-f12df6f7887d@amd.com>
Date:   Mon, 15 May 2023 08:35:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
To:     m.brock@vanmierlo.com,
        "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>, manion05gk@gmail.com
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
 <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
 <309c98bbe25b8493ac35c8da97f9bff1@vanmierlo.com>
Content-Language: en-US
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
In-Reply-To: <309c98bbe25b8493ac35c8da97f9bff1@vanmierlo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bed44b4-3a5a-43e0-cba2-08db550e9daa
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXwr8JEhonKe4cbRSG8rwg/GUEinFY1CRTxmGYc7PheJ7DTfgT7nKareyNGzO6rdXWEdCZ2tG/79tuv0G8vwo1qIXuH2tJHbHKPI4rF9C6G+KGWgzw4fLEcq6EtAG2zRkMmCUYqMLs1gLZWKgElhsPA8gg6NaUWYQKaAf4kibr3f0a4SU8yORVYqxNS3KopMBBzqZKqpnTkFgHtKXXfUUIfrTuQ4EzWqtPL4yCaDRCG92Z2cVS2y5fVdurx3UaEN17BDSMl2NOzTt0xpPYE2bL/1998DAPgTDPt+bJjJ7MrNphbN5qhq/HODgvJGwRG4tlmF0qrXqknAtDsiAZgcxuBoIaPQKoKzqR8+lD8/lE1xmn2UtjmdORblNEWd15J1uc95/n9z583+I6uuldK+5LMSZMFPFXpl7gBIPMLM09aw6qd8lIsfqJQTWI3VuVI8K2UQ2XFH5LHMJjbSG3jtBuPfWcZqkfSMz9OA3cPNpKEHVtToqOLx6bhBr07gqnAtOCJZnEgq+BymHflwCEI9rKJToxWJUWIiHKG0sweOaBzooZVWtfrLrggO9rKXe3gHm+fSdThs99a/5o/NzIwnX2/y4qbB3BWjqJAA3gi+6mTnu73dMz7d5yGNb17sjCeZcOfBIVIs1+2FCg6MMwVe0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(31686004)(83380400001)(4326008)(6636002)(316002)(41300700001)(36756003)(2906002)(38100700002)(53546011)(6512007)(6506007)(6486002)(26005)(478600001)(66946007)(66556008)(66476007)(2616005)(86362001)(31696002)(5660300002)(8936002)(6862004)(8676002)(37006003)(54906003)(44832011)(7416002)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHowaGllZ3htV01ramVCbUhYbzRXRFU5SEp3M3RsOVpUZXJPN0dqNDgycENV?=
 =?utf-8?B?alRiVjdJcXhRV0NuT0h5SSt4Si9HYzV0NGJndmN1YlBqZzVUdE03b3VXYmNR?=
 =?utf-8?B?VUtDNjNpdkZHYXdNNVV6QzNGRzRuc0tOcGNkeERwa2EyUGhSbFpXOGgrazBT?=
 =?utf-8?B?RG5EeHJ2c25pamgrbTF5WElQT3ByWjkvRDhaMGthd0hBSmFMTThtb2RkRHJi?=
 =?utf-8?B?T0JjVVQ5eXFOWFR6V09MckkyaFE3V2FjUis0WlVzRWFDdExPL2huYWlFUW5a?=
 =?utf-8?B?eWVlbFc0dE50bTFYWW1VMGZrQlZXdGtiRUh5SUprZmttUTZkdTdoSE5GN2cw?=
 =?utf-8?B?cVRXWFJFNVF2RTVyVzZob1lvSkk3SjloMWxKbnBzWjJZWDUxVlVRR3M0bXBY?=
 =?utf-8?B?NTFQZEhTVldScGVqakxpS1U1MmZKK3pUT3hmaWdYRG04RHdpcSsyeEl4M0gz?=
 =?utf-8?B?QVM5SjJmYTNBZEwzZFFNay9kYU1XR21CaXY4WnQ4U21ydmlNNnVnVkwwcFN2?=
 =?utf-8?B?WVFpSUhTYjJUOUxXUjZsamlsRlFtZzJvTDgxMlp5RUVqSnNybnptZ0NscWtz?=
 =?utf-8?B?OFM4TzlqZjBUQVh2OWlTWm1lMDZ3T0dSdWszVTl1ZGJaUHNDbzlvbmVjWllD?=
 =?utf-8?B?TnZIUnFpUjZwUVZ6ZzRjVnJucWludVB3TDV0ZnQvYi94dXpUWVF2UVBKMm9i?=
 =?utf-8?B?YlRJNVorMDRQVERlcFRRRVhjQjhiMCtiZC8yZ1FIUitlUjhYSm10Y1NCazV6?=
 =?utf-8?B?eWlKVVVpeUp3aGJQVkNxQjkyNE5PMnJQeFlHMmlJemZJRmFnWk82QjM1YjE2?=
 =?utf-8?B?V2Y5U3JBZUpmTFI4WlprU1IxV09XQTQ3SDBPd1Nmam5tNHRIM3BIdy8xVW0x?=
 =?utf-8?B?bkVhNERWeXZYU3FRUVUvYTVsdlJKSVdjeGltVFZ3eTZTQmFnZ0d1NDc2TTJt?=
 =?utf-8?B?VlJYZTBDRVBrczQzbFlyNGpackpoRTJlTFp6RVJseUtDa28yalZhWlF4a1hX?=
 =?utf-8?B?Sk9mcmwvemJsR1pxTlVkcHpOSFlrYzIvWFNFOHdoZW5hSzlqV2JyeVBVcmlC?=
 =?utf-8?B?TU5QckJYZ3RJOXNrVVFKT1ZaL21FSmdNaU9Mb3lOcys3NnFzc2RPbDZ2M0p0?=
 =?utf-8?B?M25acEx0SUN5TU9HYVdmSTZLN0pGelNkcUN6RzhCcWFIaER0dWhWaEFJb3Fa?=
 =?utf-8?B?WXZHSWNId1dNREdWdi8wK05aTE13OXRtN3h1aCtldDNvQjlzL1R4elgzMEhS?=
 =?utf-8?B?ZVBrTCtJY3lKeDRqMHA5T2ZEc1JYVHMrWkwvTGJJNVJzRzJ3TnJXN1E3T3dN?=
 =?utf-8?B?eEl0MDh0V0t4dyt4bFJiMEhYNGZGNmZkWmJKeDVIWHpDREZReUNvZEMxayt1?=
 =?utf-8?B?SFp0TlU3dmZkdk85RUFBME1BVVU1dFUyVkoranNzVnVseGxNL2kxNWwwd0dX?=
 =?utf-8?B?SVFoMWhJazg2b3o1VWxwT0tTY3o2WllVQmUvNVgvQmlvNDBDL1FBSEF0TEZG?=
 =?utf-8?B?eHpXMGdGa2lyUFNXYklQY1RMNHNyWUJHdVVWYnY5QWJMU0FreVAyWTV5eHRn?=
 =?utf-8?B?OHBLTUZKcDliNzJRSU1YUGhjelpLOEUyTWlsRE5KRjE0NFZXMjVxdUdGZHBB?=
 =?utf-8?B?cFlVZGFjVmdFMW5FRkZMRWtxQmtTaGRheURkOUpkejhrM2VNNEJsQVNXcGhR?=
 =?utf-8?B?YnkzNEkwVlZ1QlBhRVpxZXFSZVJMRkx3NGJROXg0QkhVUkJVb1ZOVXFXZDMx?=
 =?utf-8?B?anlBcDNFeU1wcG4rUlNuejNPTG4ybm5NeE1QL1ZKRFFwdjBkY0NYQllhcjcz?=
 =?utf-8?B?d0drc0p3YUtQa1FkL1pUc0doVjVFTkZXUTJibDZUVk1hV1Q4UnFoTStJeFla?=
 =?utf-8?B?YTVwVXA5c1g1eHJpU20rK25UelFveTB2Z24xdTloVVMxNm1RdDUva3c5Wjgx?=
 =?utf-8?B?K28zamlBaUZtNWU1aWowWXVEWEg2eUN4RTRBK2EybGVnL1ZUWDJuRURkN2R2?=
 =?utf-8?B?VStUQmhsekJOekFqWEdQTy8yT29FTG1ZUVM5YStpWW5XKzVkQVRJZk9VK2ho?=
 =?utf-8?B?cHo1eit3Q3dhTzlHV0RLMXlZcGg4VGV1Nkh3L2ZtcXhJM3RRU0lJY1poRmgw?=
 =?utf-8?Q?8yHtfhvgv7Rc/VxE9aGeoC+wQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bed44b4-3a5a-43e0-cba2-08db550e9daa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 06:35:47.0104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3CjU4K3MjeHxpTI9oRwhFyIiV92sAhSXMhAbysXhICijMbUPQo+gbowqJJ67qp61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/23 13:01, m.brock@vanmierlo.com wrote:
> Guntupalli, Manikanta schreef op 2023-05-10 18:26:
>> Hi Maarten,
>>
>>> -----Original Message-----
>>> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
>>> Sent: Thursday, May 4, 2023 5:52 PM
>>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>>> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
>>> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
>>> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; jirislaby@kernel.org; linux-arm-
>>> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; git
>>> (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
>>> <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>>> manion05gk@gmail.com
>>> Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
>>>
>>> Manikanta Guntupalli wrote 2023-04-26 14:29:
>>> > Add optional gpio property to uartps node to support rs485 Add rs485
>>> > support to uartps driver
>>> >
>>> > Manikanta Guntupalli (2):
>>> >   dt-bindings: Add optional gpio property to uartps node to support
>>> >     rs485
>>> >   tty: serial: uartps: Add rs485 support to uartps driver
>>> >
>>> >  .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
>>> >  drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
>>> >  2 files changed, 100 insertions(+), 1 deletion(-)
>>>
>>> Why would you want to use a GPIO and not RTS for choosing the direction as
>>> is more common in this case?
>> In ZynqMp platform Cadence UART Controller RTS signal routed to
>> external through the PL(Programmable Logic) design not through
>> Multiplexed IO.
> 
> Then why not route RXD & TXD to the PL as well and connect the module to a
> PMOD connector connected to the PL? But I admit that a GPIO always works as
> well.

I will let Mani to comment other parts. Simply that's how PCB is wired now.
I remember some discussions to enhance silicon with being able to route MIO pins 
to PL but that capability has never been added.
And the second part of it is on PL pin constrained system there doesn't need to 
be free PL pin for this functionality.
And third thing is that routing via PL means that PL has to be loaded to get 
this functionality. Which also means much higher power consumption even if there 
is single wire between EMIO and PL pin.
It means GPIO routed via MIO through free existing pin is PCB design choice in 
the context of project they are focusing on.
And good that you see also GPIO as viable option for it.

Thanks,
Michal
