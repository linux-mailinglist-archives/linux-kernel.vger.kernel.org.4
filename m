Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C0A73597C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFSOZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFSOZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:25:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2128.outbound.protection.outlook.com [40.107.220.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F02E55;
        Mon, 19 Jun 2023 07:25:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCgQePLIdOWBFSqJjpxKTJcT2dfreO1xJ140HlU5CrsZfi0O2mwv654gtRl2SRYW3sj9JCW0I+TYkQjSf/+Tod+7zBiorBI9Ec9RAgV5Q7EMsB2keMwE8eBtsqTcE6RCaeChJ0w0wnrHnw+dvOX44rBVytfHegT4dxxT4JVl71AMpqhrmb1NAy25sguynahf+TsQa9e1nxo3nqVlU8SjsnHaZtY4wCbtNuft9Ud9Qk5bwlo63AY7uQEcOOupF7Hpw3hXtbk2dRj12MSYNEVijNdlqo27jeAwyfgOtauJVF6yYvEvhHDzjrETiAg+lCPukMQ/xYKjbbgcw7mVTvOAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBAYruvg9a7/eN0QYG2L5YEeQ5d6tWbZ408LSkHhv0g=;
 b=HcJKHOc1AQKCeKJB7B/5WzGb+71nOvGm8l6YWJ7o+sWuI0xYoYuTvD++Sdj4RQCyQHsS5OuesErHnP8qnS2ZAnCg+06mHBSe+SArSPhUpv/C9ptBe8wsqVHjSsVAxucRaelu59stJEg/M1KMLd+WfDqecYSvnpo2aVoDnTz6uQBRhxIs1nM/iZq7jWnAzo4RNjF0JmHXPCInqGBp5np6iug7nbH15gcRlmeV95he2ORkPGo0pclqDSRI6WUN60wOrl29PoLfuCJIVXXWJfQZv4QGaKWhUZWiPAIfJJoTEZMdW7Wu7BPuxaCC1aT5C9xA2xSmAqlHWATFzi3kX28YAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=limntech.com; dmarc=pass action=none header.from=limntech.com;
 dkim=pass header.d=limntech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=limntech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBAYruvg9a7/eN0QYG2L5YEeQ5d6tWbZ408LSkHhv0g=;
 b=cgg9Zm8G1c2eiEvIlXE69L9e+7vpWRdWyZe36VomWM6/ABo5Ie9KRdmIAoq0zwE8Za3lg7yMX4OglrRnxVeppTLn9ZBx57VOPfNGpgBBTTN+64jZSz/ThvxVj/1sn6Z6tAOJWjgYcoXn8GXPsYvi8TZM9OCXbsFhQTxshlXTsk5fThcgU0EUU9MuUbWUgKRtC2M9e8Yk4kLnr8YXeT8DQvTfvUVFwWnnpt1p9TfiTVzWT40BI93lqYQvaHLFMugdMXEjlAfL6uFVXGMbLCrPd/DRRVjSu7+8tnZZHTUuNjNdOvl01+YtZHMRPpFC06BVLX3WBHcPMFbv6aGpIVGFqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=limntech.com;
Received: from MN2PR15MB3727.namprd15.prod.outlook.com (2603:10b6:208:1bb::24)
 by SA0PR15MB3871.namprd15.prod.outlook.com (2603:10b6:806:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:25:29 +0000
Received: from MN2PR15MB3727.namprd15.prod.outlook.com
 ([fe80::6086:e1a5:596a:d99c]) by MN2PR15MB3727.namprd15.prod.outlook.com
 ([fe80::6086:e1a5:596a:d99c%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:25:29 +0000
Message-ID: <afff3b9a-8d84-49c9-4fc0-a07a792d4177@limntech.com>
Date:   Mon, 19 Jun 2023 10:25:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9] can: usb: IXXAT USB-to-CAN adapters drivers
Content-Language: en-US
To:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Peter Seiderer <ps.report@gmx.net>, marm@hms-networks.de
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-kernel@vger.kernel.org
References: <20230522200144.15949-1-ps.report@gmx.net>
 <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
From:   Eric Stahl <ericstahl@limntech.com>
In-Reply-To: <CAMZ6RqJ4gL35=8112ES1y4jW9k+AaDNRmCcL-rbUPXtRMnZb8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0040.prod.exchangelabs.com (2603:10b6:208:23f::9)
 To MN2PR15MB3727.namprd15.prod.outlook.com (2603:10b6:208:1bb::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB3727:EE_|SA0PR15MB3871:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b738aa-cc43-4300-f766-08db70d1086f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcOZMJXL/5oNeZkOQ/rjh9kkgpvdeioqPX8q2Ndik6RJry+Xl3QBLnKNmPz61yL3hJgkrh3ToaTauZ0qVKlSeZOtJUPSsmHOeJOkHLorWPbVKUzqFxBVx3XuJ+tlXpJuOCVZ1TS0PuEKS82mPptfpRROqeBKCn9N04gLOvtbVmKwkgIalCs4OBWuHDdCZHNYl20KaPRyEnOERAgN8tGuWQQR15W69RjX2v9fvv0MnSqT8RDsx1XtVCVINgtt6oi8CmYZSxu6FIbvEDOO2x0e3nFiE2pPpOxLH4jWKJt/QrpcBUFYiT11fAJymtb9ZTFvb2hXMoBXBVCdVXX1GX/R2s0UOj5Ky0Di0LyJS4msE2L57JAOrfyEdAK2E52UcLLnnDWBUTRnDUM+A0jiEUDZCLbUPUUXTeYcu4sR0I5cg+ea8ejhT1b2G/dvMtUsDGox7vw7S/dvTWd4mMDIGmdzkX9zf6eABYZgIOXqznOdixAVvFWTLAU2WXenesN2LR/+QwIRmgu/xyPM9a9TtC/n6NxJmio7x/huYRmj815kNAWOrcldqDyQZAlyKBdJQs1lPrrFwA2cA44InDmW0ScyJlo6dSg/NdY5u2ZnaEncMsv+R2noXkwUMBXmd999zbQ2uRB5+BiMMWO5GEXNtvHvFCMFw+Wjq6VZ530aiTgtI/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3727.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39830400003)(346002)(366004)(396003)(136003)(451199021)(186003)(110136005)(52116002)(478600001)(966005)(6486002)(31696002)(86362001)(53546011)(26005)(6506007)(6512007)(54906003)(31686004)(2616005)(38100700002)(316002)(38350700002)(83380400001)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(30864003)(5660300002)(2906002)(41300700001)(36756003)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFhWUIwRnR4cnU4bE5Jc0V4bUhPQTdwckR4d01aeWtTVDdUdHpjNnhldXc5?=
 =?utf-8?B?a01BektBOFZ2UThlVzhxTXg2ZHVURWtkeFI1M3N0Vi9JcEtiMHptZ2FIUzl5?=
 =?utf-8?B?VHlJOENzeFhnZlg5aEFGVmJjUVdzZ2lFbkVVakcvQy8rV2VaakphUWVINlNx?=
 =?utf-8?B?d2JwOEd4NEEzWjErV096QVZ3aUF0Zzl2Z2xLMngwUWdLTzFnQm44UjNneXgz?=
 =?utf-8?B?OHBrYjVFdmFscU91OHk5UkVIcnAxbmZUU3R1VVJxZWh2R1Btdm01d1QxdHlW?=
 =?utf-8?B?Wmp2TTU1dE52K2llTVlvRGNLbWZVeWJnRGpFRUZiZ054TUxGeVhqQk1mOEFN?=
 =?utf-8?B?dUE0eUhETzVvYkR5SUJDZEcvbTR4dGVSbytTRVFNYVRUWUNVWFlxM25ZbFJS?=
 =?utf-8?B?L3ZQeDl6NWF6ZlpGZkdGek5yWVFZMDFBQkpaZ2x6K3FacHNwRGlUdjlZRU1i?=
 =?utf-8?B?L1JDazIzcnppNkZVUkxQY3NDdjVVVUhWbWo1czRiYnc3U0lKYjI5dnE4eVUy?=
 =?utf-8?B?VmhkbFVEWXZ5ZVNMREYxUm1hRXdJM0M4d2VPN0FxUlVhRmRjYVFadmtWTDZl?=
 =?utf-8?B?SW02eTR6dkFsU2hDb1VXc09XbUpjSXVWYTQyK05jVjdCWjRNc0NVREwrc1dR?=
 =?utf-8?B?RDh4c2RmT2Q5cmxhNERaVSt1N1d2UUMxM3AzVVJpdlYxdFg1NEZ3SS93NFMr?=
 =?utf-8?B?RkVzSWFzNTNkTmlqRU1Bb2dkSUdoQW9aTm1YWnFYazRmRHM3VFJub0w1d2Za?=
 =?utf-8?B?UlFEV0hLZmFrODIvS2svLzExS0VOZ2VCNUpUUHVQTnVKKzI3TmFubUNXdklD?=
 =?utf-8?B?YzFETllIeEZlVmwxamtqc3VUeEp2SGtVWjV2ZC9RK0QzLzVRb0ZRanZLZ1hJ?=
 =?utf-8?B?Umg1Rjg3NGVNVi8xSzY2Q09INlBmUVVmeS82Q2FadWpEUE1vMytZRElManZl?=
 =?utf-8?B?L1VPa0RMbVErS2ZUYU9mOTNxUWRpNlhQUThyMFlYQmFOTUdoVTZ2VWE0UE9j?=
 =?utf-8?B?ZDZ4YU5JY21SOVlOSTlyamdFREZ1OWo1bVZCN2pZUkEzMnFPVjBmNFp1cE8x?=
 =?utf-8?B?QXZBdXk5Z1JjL1ovTWVPdWdXQVRSOFViU2lZdjZJYjhCZ1luYm16dHVleFFD?=
 =?utf-8?B?UEd0V3RvM3lCL3E4cWJ5eUVyRFdYQytybDNsRzYrYXg5T1JMc0M2akJHUzNq?=
 =?utf-8?B?TzFlUWJJcU5aSUVJUGxscThFTWswSUcrMWlDZlBlUzBYWFc4bGpaYW1JSUxE?=
 =?utf-8?B?d3EzWjI3NHlJeEN5SWVIcDZEN2JBeURjaE1TUVM2a2tRWWZ2aERHeXpxNGkv?=
 =?utf-8?B?K25aZHlqRzlWTWZBZGM5d0xpbi91RjIzdTB3TEVoa0VKQ2ZGWEV6dFVnVzM5?=
 =?utf-8?B?dmNlT1lsQ09hNlJSTndBSnlqVVFHcUd2SVlzN0UxcFI5RUZZbkRkV2d5eElZ?=
 =?utf-8?B?MFlqQmxDdXZ0ZzBzaFVJalhTNlcwQU56cXEzMnUwdW9JVDYxQ05XODJKajcv?=
 =?utf-8?B?dnY5bFlJeDduMHZVekx4SC8yR0hZZGlLZjE1ektTc09HbHdId2IxSy84ZWVz?=
 =?utf-8?B?Q3pDSm9Xb3pNbUVqdnNQTUc0OTF4ak5iblJYNllkaTJwL050aW1jeENuVFE4?=
 =?utf-8?B?ZXBiT1dQdmtBOEdMaHJDWUtiYUZvV2J4R0lxWjRGSHZSSnpzNWtqMW4zdlFC?=
 =?utf-8?B?S1V0ZnNXL2pUbWt4TUttQ3IrUFgxL0JOVlMvbFExTGprYWpnWUhPUkNtUzJ3?=
 =?utf-8?B?Ynl1czdJVnZRRTg0VzZFaFg3d1VnQVdhVld1OHEvdzJzblhtTDRFaTZLRmtC?=
 =?utf-8?B?bG1vVHRMcTF4MDlWc2VLV3hWUVUzMFRvcFpHNmRFSGxKajdNdmYrcWhnMFc3?=
 =?utf-8?B?TlYyTk5ZS05BT3lnYnNmeUVkK0VLRCtOaWlScDN6emVTZmdIbUpLTjBZWWp0?=
 =?utf-8?B?akp3YzhtTGkrUFlYekNwMUJIYUJsSDIrazNEZnFBcFl1S01RSS9DMVNSY1lJ?=
 =?utf-8?B?SG93UUJwalg3UlZXZjcyRTN2SlpTVGo5VFRzUDhTK3hRUUhXbmxVckdLL1Ix?=
 =?utf-8?B?Y1JVZmxqaVlzOFBEZHBNdk1iaTdIRW1Yb0I2QWNPblREMkN3OFNMUkhHcU1L?=
 =?utf-8?Q?B3bJY+bDRriH9pkG012B6/AVS?=
X-OriginatorOrg: limntech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b738aa-cc43-4300-f766-08db70d1086f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3727.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:25:29.6876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9ae210fb-cbd6-4b9a-bbf2-a375f08b4179
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcCcKzBiScf4AVlow2g2VbKLeQuCHUgPDVuevay3ZdegQWBQaRA8LmfKyje3VOFVQdEsGf6uQgAFm78cu1m3kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3871
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The socketcan@hms-networks.de is bouncing for me. I removed both Florian 
Ferg's email (flfe@hms-networks.de) and sockectcan@hms-networks.de. I 
saw Markus from hms commenting on the last thread (PATCH v8) resolving 
those issues, so I've added him to this chain. I'm not sure if they are 
still a problem.

I've backported Peter's PATCH v9 and it works well for me. It seems that 
hms is distributing a driver that does not incorporate the proposed 
changes from the past reviews 
(https://forum.hms-networks.com/t/socketcan-driver-for-linux-20-04/70299/30). 
Their driver has not worked for me with higher level CANopen libraries, 
but Peter's v8/v9 and Florian's past contributions work well. I would 
like to get ixxat's active pci socketcan drivers pulled into the mainline.

I don't mean to hijack this thread, but I was wondering if it's 
appropriate to add those pci drivers to this patch to get reviewed, or 
if it's more appropriate to open a separate patch.

Thanks,

Eric

On 5/31/23 03:25, Vincent Mailhol wrote:
> Hi Florian,
>
> Here is another batch of comments.
>
> On Tue. 23 May 2023 at 05:02, Peter Seiderer <ps.report@gmx.net> wrote:
>> From: Florian Ferg <flfe@hms-networks.de>
>>
>> This patch adds the driver for the IXXAT USB-to-CAN interfaces. There
>> is an adapter for the older communication layer cl1 and another
>> adapter for the newer communication layer cl2.
>>
>> Signed-off-by: Florian Ferg <flfe@hms-networks.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
>> ---
>> Changes v1 -> v7 (Florian Ferg <flfe@hms-networks.de>):
>>    - for detailed history see
>>      https://codeberg.org/psreport/socketcan-linux-ix-usb-can
>>
>> Changes v7 -> v8 (Marc Kleine-Budde <mkl@pengutronix.de>)
>>    - port to recent net-next
>>
>> Changes v8 -> v9 (Peter Seiderer <ps.report@gmx.net>)
>>    Addressed review comments by Vincent Mailhol:
>>    - update copyright headers (use SPDX identifier 'GPL-2.0-only'
>>      instead of 'GPL-2.0', remove full GPL boilerplate)
>>    - reorder includes (lexicographic order)
>>    - remove IXXAT_USB_MODES defines (move modes directly in the
>>      declaration of structs)
>>    - remove bittiming defines (move directly in declaration of structs)
>>    - remove _EP1_IN/_EP1_OUT defines (move directly in declaration of structs)
>>    - remove rcv_size/snd_size vars (use sizeof(*cmd) and sizeof(cmd->res) directly)
>>    - use GENMASK/FIELD_PREP (IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK/IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK)
>>    - update dev_err/netdev_err (use %pe, remove 'Error:' prefix)
>>    - use U32_MAX instead of 0x00000000FFFFFFFF
>>    - do not increase the rx_bytes count when receiving a remove frame
>>    - ixxat_can_msg_cl1/ixxat_can_msg_cl2 use union __le32 status
>>    - do not increase the statistics for error frames
>>    - do not use parenthesis in log messages
>>    - remove double brackets (sparse workaround for struct init)
>>    - fill netdev->ethtool_ops with default
>>    - fill netdev->dev_port
>>    - use FIELD_GET/FIELD_PREP instead of IXXAT_USB_DECODE_DLC/IXXAT_USB_ENCODE_DLC
>>    - use driver_info intead of open coded ixxat_usb_get_adapter
>>   Addressed checkpatch.pl warnings:
>>    - change MODULE_LICENSE to 'GPL' - checkpatch.pl WARNING: Prefer "GPL" over "GPL v2"
>> ---
>>   drivers/net/can/usb/Kconfig                   |   17 +
>>   drivers/net/can/usb/Makefile                  |    1 +
>>   drivers/net/can/usb/ixxat_usb/Makefile        |    2 +
>>   drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  100 ++
>>   drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  176 +++
>>   .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 1277 +++++++++++++++++
>>   .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  511 +++++++
>>   7 files changed, 2084 insertions(+)
>>   create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
>>   create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
>>   create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
>>   create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
>>   create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
>>
>> diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
>> index 58fcd2b34820..b50706f2a5e6 100644
>> --- a/drivers/net/can/usb/Kconfig
>> +++ b/drivers/net/can/usb/Kconfig
>> @@ -62,6 +62,23 @@ config CAN_GS_USB
>>            choose Y for built in support,
>>            M to compile as module (module will be named: gs_usb).
>>
>> +config CAN_IXXAT_USB
>> +       tristate "IXXAT USB-to-CAN interfaces"
>> +       help
>> +         This driver adds support for IXXAT USB-to-CAN devices.
>> +
>> +         The driver provides support for the following devices:
>> +           - IXXAT USB-to-CAN compact
>> +           - IXXAT USB-to-CAN embedded
>> +           - IXXAT USB-to-CAN professional
>> +           - IXXAT USB-to-CAN automotive
>> +           - IXXAT USB-to-CAN FD compact
>> +           - IXXAT USB-to-CAN FD professional
>> +           - IXXAT USB-to-CAN FD automotive
>> +           - IXXAT USB-to-CAN FD MiniPCIe
>> +           - IXXAT USB-to-CAR
>> +           - IXXAT CAN-IDM101
>> +
>>   config CAN_KVASER_USB
>>          tristate "Kvaser CAN/USB interface"
>>          help
>> diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
>> index 8b11088e9a59..52b4cc66ff30 100644
>> --- a/drivers/net/can/usb/Makefile
>> +++ b/drivers/net/can/usb/Makefile
>> @@ -9,6 +9,7 @@ obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
>>   obj-$(CONFIG_CAN_ETAS_ES58X) += etas_es58x/
>>   obj-$(CONFIG_CAN_F81604) += f81604.o
>>   obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
>> +obj-$(CONFIG_CAN_IXXAT_USB) += ixxat_usb/
>>   obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
>>   obj-$(CONFIG_CAN_MCBA_USB) += mcba_usb.o
>>   obj-$(CONFIG_CAN_PEAK_USB) += peak_usb/
>> diff --git a/drivers/net/can/usb/ixxat_usb/Makefile b/drivers/net/can/usb/ixxat_usb/Makefile
>> new file mode 100644
>> index 000000000000..125d2705979f
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ixxat_usb/Makefile
>> @@ -0,0 +1,2 @@
>> +obj-$(CONFIG_CAN_IXXAT_USB) += ixxat_usb2can.o
>> +ixxat_usb2can-y = ixxat_usb_cl1.o ixxat_usb_cl2.o ixxat_usb_core.o
>> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
>> new file mode 100644
>> index 000000000000..cfd95ff722cd
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
>> + */
>> +
>> +#include <linux/can/dev.h>
>> +#include <linux/kernel.h>
>> +#include <linux/usb.h>
>> +
>> +#include "ixxat_usb_core.h"
>> +
>> +#define IXXAT_USB_CLOCK 8000000
>
> Nitpick, use the MEGA suffix for linux/units.h
>
>    #define IXXAT_USB_CLOCK (8 * MEGA /* Hz */)
>
>> +#define IXXAT_USB_BUFFER_SIZE_RX 512
>> +#define IXXAT_USB_BUFFER_SIZE_TX 256
>> +
>> +#define IXXAT_USB_BTMODE_TSM_CL1 0x80
>> +
>> +#define IXXAT_USB_CAN_CMD_INIT 0x325
>> +
>> +#define IXXAT_USB_CAN_BTR0_BRP_MASK GENMASK(5, 0)
>> +#define IXXAT_USB_CAN_BTR0_SJW_MASK GENMASK(7, 6)
>> +
>> +#define IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK GENMASK(3, 0)
>> +#define IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK GENMASK(6, 4)
>> +
>> +static const struct can_bittiming_const usb2can_bt = {
>> +       .name = IXXAT_USB_CTRL_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 16,
>> +       .tseg2_min = 1,
>> +       .tseg2_max = 8,
>> +       .sjw_max = 4,
>> +       .brp_min = 1,
>> +       .brp_max = 64,
>> +       .brp_inc = 1,
>> +};
>> +
>> +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
>> +{
>> +       const struct can_bittiming *bt = &dev->can.bittiming;
>> +       const u16 port = dev->ctrl_index;
>> +       int err;
>> +       struct ixxat_usb_init_cl1_cmd *cmd;
>> +       u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
>> +       u8 btr0 = FIELD_PREP(IXXAT_USB_CAN_BTR0_BRP_MASK, bt->brp - 1) |
>> +               FIELD_PREP(IXXAT_USB_CAN_BTR0_SJW_MASK, bt->sjw - 1);
>> +       u8 btr1 = FIELD_PREP(IXXAT_USB_CAN_BTR1_TIME_SEG1_MASK, bt->prop_seg + bt->phase_seg1 - 1) |
>> +               FIELD_PREP(IXXAT_USB_CAN_BTR1_TIME_SEG2_MASK, bt->phase_seg2 - 1);
> Remove those opmode, btr0 and btr1 variables and directly assign the
> values to cmd->opmode, cmd->btr0 and cmd->btr1.
>
> The issue here is that the use of these variables get scattered for no reason.
>
> For example, opmode is initialised just above...
>
>> +       cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
>> +               btr1 |= IXXAT_USB_BTMODE_TSM_CL1;
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>> +               opmode |= IXXAT_USB_OPMODE_ERRFRAME;
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> +               opmode |= IXXAT_USB_OPMODE_LISTONLY;
> ... then specific flags get assigned here in the middle of the function ...
>
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.size = cpu_to_le32(sizeof(*cmd) - sizeof(cmd->res));
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
>> +       cmd->req.port = cpu_to_le16(port);
>> +       cmd->mode = opmode;
> ... and finally, you assign it here.
>
> Instead of having the pieces of code scattered in three places, you could do:
>
>            cmd->mode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
>            if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>                    cmd->opmode |= IXXAT_USB_OPMODE_ERRFRAME;
>            if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>                     cmd->opmode |= IXXAT_USB_OPMODE_LISTONLY;
>
> in one single block of code. This is easier to read because now I do
> not have to look at different places to understand what the function
> does with that opmode.
>
> This comment applies to other functions as well. There are many uses
> of intermediate variables which could easily be omitted.
>
>> +       cmd->btr0 = btr0;
>> +       cmd->btr1 = btr1;
>> +
>> +       err = ixxat_usb_send_cmd(dev->udev, port, cmd, sizeof(*cmd), &cmd->res,
>> +                                sizeof(cmd->res));
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +const struct ixxat_usb_adapter usb2can_cl1 = {
>> +       .clock = IXXAT_USB_CLOCK,
>> +       .bt = &usb2can_bt,
>> +       .btd = NULL,
>> +       .modes = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_BERR_REPORTING |
>> +               CAN_CTRLMODE_LISTENONLY,
>> +       .buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
>> +       .buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
>> +       .ep_msg_in = {
>> +               1 | USB_DIR_IN,
>> +               2 | USB_DIR_IN,
>> +               3 | USB_DIR_IN,
>> +               4 | USB_DIR_IN,
>> +               5 | USB_DIR_IN,
>> +       },
>> +       .ep_msg_out = {
>> +               1 | USB_DIR_OUT,
>> +               2 | USB_DIR_OUT,
>> +               3 | USB_DIR_OUT,
>> +               4 | USB_DIR_OUT,
>> +               5 | USB_DIR_OUT,
>> +       },
>> +       .ep_offs = 0,
>> +       .init_ctrl = ixxat_usb_init_ctrl
>> +};
>> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
>> new file mode 100644
>> index 000000000000..268544f52f1e
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
>> @@ -0,0 +1,176 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
>> + */
>> +
>> +#include <linux/can/dev.h>
>> +#include <linux/kernel.h>
>> +#include <linux/usb.h>
>> +
>> +#include "ixxat_usb_core.h"
>> +
>> +#define IXXAT_USB_CLOCK 80000000
> Nitpick, use the MEGA suffix for linux/units.h
>
>    #define IXXAT_USB_CLOCK (80 * MEGA /* Hz */)
>
>> +#define IXXAT_USB_BUFFER_SIZE_RX 512
>> +#define IXXAT_USB_BUFFER_SIZE_TX 512
>> +
>> +#define IXXAT_USB_CAN_CMD_INIT 0x337
>> +
>> +static const struct can_bittiming_const usb2can_bt = {
>> +       .name = IXXAT_USB_CTRL_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 256,
>> +       .tseg2_min = 1,
>> +       .tseg2_max = 256,
>> +       .sjw_max = 128,
>> +       .brp_min = 2,
>> +       .brp_max = 513,
> 513 is really uncommon. Are you sure this isn't 512?
>
>> +       .brp_inc = 1,
>> +};
>> +
>> +static const struct can_bittiming_const usb2can_btd = {
>> +       .name = IXXAT_USB_CTRL_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 256,
>> +       .tseg2_min = 1,
>> +       .tseg2_max = 256,
>> +       .sjw_max = 128,
>> +       .brp_min = 2,
>> +       .brp_max = 513,
> Idem.
>
>> +       .brp_inc = 1,
>> +};
>> +
>> +static const struct can_bittiming_const canidm_bt = {
>> +       .name = IXXAT_USB_CTRL_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 256,
>> +       .tseg2_min = 1,
>> +       .tseg2_max = 128,
>> +       .sjw_max = 128,
>> +       .brp_min = 1,
>> +       .brp_max = 512,
>> +       .brp_inc = 1
>> +};
>> +
>> +static const struct can_bittiming_const canidm_btd = {
>> +       .name = IXXAT_USB_CTRL_NAME,
>> +       .tseg1_min = 1,
>> +       .tseg1_max = 32,
>> +       .tseg2_min = 1,
>> +       .tseg2_max = 16,
>> +       .sjw_max = 8,
>> +       .brp_min = 1,
>> +       .brp_max = 32,
>> +       .brp_inc = 1
>> +};
>> +
>> +static int ixxat_usb_init_ctrl(struct ixxat_usb_device *dev)
>> +{
>> +       const struct can_bittiming *bt = &dev->can.bittiming;
>> +       const struct can_bittiming *btd = &dev->can.data_bittiming;
>> +       const u16 port = dev->ctrl_index;
>> +       int err;
>> +       struct ixxat_usb_init_cl2_cmd *cmd;
>> +       u32 btmode = IXXAT_USB_BTMODE_NAT;
>> +       u8 exmode = 0;
>> +       u8 opmode = IXXAT_USB_OPMODE_EXTENDED | IXXAT_USB_OPMODE_STANDARD;
>> +
>> +       cmd = kmalloc(sizeof(*cmd), GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_3_SAMPLES)
>> +               btmode = IXXAT_USB_BTMODE_TSM;
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
>> +               opmode |= IXXAT_USB_OPMODE_ERRFRAME;
>> +       if (dev->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
>> +               opmode |= IXXAT_USB_OPMODE_LISTONLY;
>> +       if (dev->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO)) {
>> +               exmode |= IXXAT_USB_EXMODE_EXTDATA | IXXAT_USB_EXMODE_FASTDATA;
>> +
>> +               if (!(dev->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO))
>> +                       exmode |= IXXAT_USB_EXMODE_ISOFD;
>> +       }
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.size = cpu_to_le32(sizeof(*cmd) - sizeof(cmd->res));
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_INIT);
>> +       cmd->req.port = cpu_to_le16(port);
>> +       cmd->opmode = opmode;
>> +       cmd->exmode = exmode;
>> +       cmd->sdr.mode = cpu_to_le32(btmode);
>> +       cmd->sdr.bps = cpu_to_le32(bt->brp);
> The BPS (bitrate per second) and the BRP (bitrate prescaler) are two
> different things. I am not sure how this is supposed to work.
>
>> +       cmd->sdr.ts1 = cpu_to_le16(bt->prop_seg + bt->phase_seg1);
>> +       cmd->sdr.ts2 = cpu_to_le16(bt->phase_seg2);
>> +       cmd->sdr.sjw = cpu_to_le16(bt->sjw);
>> +       cmd->sdr.tdo = 0;
>> +
>> +       if (exmode) {
>> +               cmd->fdr.mode = cpu_to_le32(btmode);
>> +               cmd->fdr.bps = cpu_to_le32(btd->brp);
>> +               cmd->fdr.ts1 = cpu_to_le16(btd->prop_seg + btd->phase_seg1);
>> +               cmd->fdr.ts2 = cpu_to_le16(btd->phase_seg2);
>> +               cmd->fdr.sjw = cpu_to_le16(btd->sjw);
>> +               cmd->fdr.tdo = cpu_to_le16(btd->brp * (btd->phase_seg1 + 1 +
>> +                                                      btd->prop_seg));
>> +       }
>> +
>> +       err = ixxat_usb_send_cmd(dev->udev, port, cmd, sizeof(*cmd), &cmd->res,
>> +                                sizeof(cmd->res));
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +const struct ixxat_usb_adapter usb2can_cl2 = {
>> +       .clock = IXXAT_USB_CLOCK,
>> +       .bt = &usb2can_bt,
>> +       .btd = &usb2can_btd,
>> +       .modes = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
>> +               CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
>> +               CAN_CTRLMODE_FD_NON_ISO,
> Does your device allow you to send and receive Classical CAN frames
> with DLC greater than 8? c.f. CAN_CTRLMODE_CC_LEN8_DLC
>
>    https://elixir.bootlin.com/linux/v6.3/source/include/uapi/linux/can/netlink.h#L103
>
>> +       .buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
>> +       .buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
>> +       .ep_msg_in = {
>> +               1 | USB_DIR_IN,
>> +               2 | USB_DIR_IN,
>> +               3 | USB_DIR_IN,
>> +               4 | USB_DIR_IN,
>> +               5 | USB_DIR_IN
>> +       },
>> +       .ep_msg_out = {
>> +               1 | USB_DIR_OUT,
>> +               2 | USB_DIR_OUT,
>> +               3 | USB_DIR_OUT,
>> +               4 | USB_DIR_OUT,
>> +               5 | USB_DIR_OUT,
>> +       },
>> +       .ep_offs = 1,
>> +       .init_ctrl = ixxat_usb_init_ctrl
>> +};
>> +
>> +const struct ixxat_usb_adapter can_idm = {
>> +       .clock = IXXAT_USB_CLOCK,
>> +       .bt = &canidm_bt,
>> +       .btd = &canidm_btd,
>> +       .modes = CAN_CTRLMODE_3_SAMPLES | CAN_CTRLMODE_LISTENONLY |
>> +               CAN_CTRLMODE_BERR_REPORTING | CAN_CTRLMODE_FD |
>> +               CAN_CTRLMODE_FD_NON_ISO,
>> +       .buffer_size_rx = IXXAT_USB_BUFFER_SIZE_RX,
>> +       .buffer_size_tx = IXXAT_USB_BUFFER_SIZE_TX,
>> +       .ep_msg_in = {
>> +               2 | USB_DIR_IN,
>> +               4 | USB_DIR_IN,
>> +               6 | USB_DIR_IN,
>> +               8 | USB_DIR_IN,
>> +               10 | USB_DIR_IN,
>> +       },
>> +       .ep_msg_out = {
>> +               1 | USB_DIR_OUT,
>> +               3 | USB_DIR_OUT,
>> +               5 | USB_DIR_OUT,
>> +               7 | USB_DIR_OUT,
>> +               9 | USB_DIR_OUT,
>> +       },
>> +       .ep_offs = 0,
>> +       .init_ctrl = ixxat_usb_init_ctrl
>> +};
>> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
>> new file mode 100644
>> index 000000000000..8787d27a3886
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
>> @@ -0,0 +1,1277 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
>> + */
>> +
>> +#include <linux/can/dev.h>
>> +#include <linux/ethtool.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kthread.h>
>> +#include <linux/module.h>
>> +#include <linux/usb.h>
>> +
>> +#include "ixxat_usb_core.h"
>> +
>> +MODULE_AUTHOR("Marcel Schmidt <socketcan@hms-networks.de>");
>> +MODULE_DESCRIPTION("CAN driver for IXXAT USB-to-CAN / CAN FD adapters");
>> +MODULE_LICENSE("GPL");
>> +
>> +/* Table of devices that work with this driver */
>> +static const struct usb_device_id ixxat_usb_table[] = {
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_COMPACT_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl1, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_EMBEDDED_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl1, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_PROFESSIONAL_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl1, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_AUTOMOTIVE_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl1, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_COMPACT_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl2, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PROFESSIONAL_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl2, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl2, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAN_FD_PCIE_MINI_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl2, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, USB2CAR_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&usb2can_cl2, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM101_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&can_idm, },
>> +       { USB_DEVICE(IXXAT_USB_VENDOR_ID, CAN_IDM200_PRODUCT_ID),
>> +         .driver_info = (kernel_ulong_t)&can_idm, },
>> +       { } /* Terminating entry */
>> +};
>> +
>> +MODULE_DEVICE_TABLE(usb, ixxat_usb_table);
>> +
>> +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
>> +                        struct ixxat_usb_dal_res *res)
>> +{
>> +       req->size = cpu_to_le32(sizeof(*req));
>> +       req->port = cpu_to_le16(0xffff);
> U16_MAX. Alternatively, if this value has a semantic meaning, declare
> it as a #define. Something like that:
>
>    #define IXXAT_USB_PORT_UNDEF U16_MAX
>
>> +       req->socket = cpu_to_le16(0xffff);
> Same.
>
>> +       req->code = cpu_to_le32(0);
>> +
>> +       res->res_size = cpu_to_le32(sizeof(*res));
>> +       res->ret_size = cpu_to_le32(0);
>> +       res->code = cpu_to_le32(0xffffffff);
> Same but with U32_MAX.
>
>> +}
>> +
>> +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *req,
>                                                                    ^^^^^^^^^
>
> If you declare some of the arguments as const, follow the logic until
> the end. As far as I can see, req is constant.
>
>    int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, const
> void *req,
>
>> +                      const u16 req_size, void *res, const u16 res_size)
>> +{
>> +       const int to = msecs_to_jiffies(IXXAT_USB_MSG_TIMEOUT);
>> +       const u8 rq = 0xff;
> Here you have req as a parameter and rq as a variable. The names are
> too similar (both are an abbreviation of request) and this can be
> misleading. Try to be consistent within your different functions.
> Instead of "req", use for example "cmd".
>
>> +       const u8 rti = USB_TYPE_VENDOR | USB_DIR_IN;
>> +       const u8 rto = USB_TYPE_VENDOR | USB_DIR_OUT;
>> +       int i;
>> +       int pos = 0;
>> +       int rcp = usb_rcvctrlpipe(dev, 0);
>> +       int scp = usb_sndctrlpipe(dev, 0);
>> +       int ret = 0;
>> +       struct ixxat_usb_dal_res *dal_res = res;
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
>> +               ret = usb_control_msg(dev, scp, rq, rto, port, 0, req, req_size,
>> +                                     to);
>> +               if (ret < 0)
>> +                       msleep(IXXAT_USB_MSG_CYCLE);
>> +               else
>> +                       break;
>> +       }
>> +
>> +       if (ret < 0) {
>> +               dev_err(&dev->dev, "TX command failure: %pe\n", ERR_PTR(ret));
>> +               goto fail;
>> +       }
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_COM_REQ; ++i) {
>> +               const int rs = res_size - pos;
>> +               void *rb = res + pos;
>> +
>> +               ret = usb_control_msg(dev, rcp, rq, rti, port, 0, rb, rs, to);
>> +               if (ret < 0) {
>> +                       msleep(IXXAT_USB_MSG_CYCLE);
>> +                       continue;
>> +               }
>> +
>> +               pos += ret;
>> +               if (pos < res_size)
>> +                       msleep(IXXAT_USB_MSG_CYCLE);
>> +               else
>> +                       break;
>> +       }
>> +
>> +       if (pos != res_size)
>> +               ret = -EBADMSG;
>> +
>> +       if (ret < 0) {
>> +               dev_err(&dev->dev, "RX command failure: %pe\n", ERR_PTR(ret));
>> +               goto fail;
>> +       }
>> +
>> +       ret = le32_to_cpu(dal_res->code);
>> +
>> +fail:
>> +       return ret;
>> +}
>> +
>> +static void ixxat_usb_update_ts_now(struct ixxat_usb_device *dev, u32 ts_now)
>> +{
>> +       u32 *ts_dev = &dev->time_ref.ts_dev_0;
>> +       ktime_t *kt_host = &dev->time_ref.kt_host_0;
>> +       u64 timebase = (u64)U32_MAX - (u64)(*ts_dev) + (u64)ts_now;
>> +
>> +       *kt_host = ktime_add_us(*kt_host, timebase);
>> +       *ts_dev = ts_now;
>> +}
>> +
>> +static void ixxat_usb_get_ts_tv(struct ixxat_usb_device *dev, u32 ts,
>> +                               ktime_t *k_time)
>> +{
>> +       ktime_t tmp_time = dev->time_ref.kt_host_0;
>> +
>> +       if (ts < dev->time_ref.ts_dev_last)
>> +               ixxat_usb_update_ts_now(dev, ts);
>> +
>> +       dev->time_ref.ts_dev_last = ts;
>> +       tmp_time = ktime_add_us(tmp_time, ts - dev->time_ref.ts_dev_0);
>> +
>> +       if (k_time)
>> +               *k_time = tmp_time;
>> +}
>> +
>> +static void ixxat_usb_set_ts_now(struct ixxat_usb_device *dev, u32 ts_now)
>> +{
>> +       dev->time_ref.ts_dev_0 = ts_now;
>> +       dev->time_ref.kt_host_0 = ktime_get_real();
>> +       dev->time_ref.ts_dev_last = ts_now;
>> +}
>> +
>> +static int ixxat_usb_get_dev_caps(struct usb_device *dev,
>> +                                 struct ixxat_dev_caps *dev_caps)
>> +{
>> +       int i;
>> +       int err;
>> +       struct ixxat_usb_caps_cmd *cmd;
>> +       const u32 cmd_size = sizeof(*cmd);
> As a global comment, those *_size variables do not have a strong
> purpose. Using directly sizeof(*cmd) in the code is unambiguous and
> concise enough. This comment applies to other functions as well.
>
>> +       const u32 req_size = sizeof(cmd->req);
>> +       const u32 rcv_size = cmd_size - req_size;
> Here, one thing you could do is:
>
> #define IXXAT_USB_RCV_SIZE(cmd) (sizeof(*cmd) + sizeof(cmd->req))
>
> and then use IXXAT_USB_RCV_SIZE(cmd) in place of rcv_size in your code.
>
>> +       const u32 snd_size = req_size + sizeof(cmd->res);
>> +       u16 num_ctrl;
>> +
>> +       cmd = kmalloc(cmd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVCAPS);
>> +       cmd->res.res_size = cpu_to_le32(rcv_size);
>> +
>> +       err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
>> +                                &cmd->res, rcv_size);
>> +       if (err)
>> +               goto fail;
>> +       dev_caps->bus_ctrl_count = cmd->caps.bus_ctrl_count;
>> +       num_ctrl = le16_to_cpu(dev_caps->bus_ctrl_count);
>> +       if (num_ctrl > ARRAY_SIZE(dev_caps->bus_ctrl_types)) {
>> +               err = -EINVAL;
>> +               goto fail;
>> +       }
>> +
>> +       for (i = 0; i < num_ctrl; i++)
>> +               dev_caps->bus_ctrl_types[i] = cmd->caps.bus_ctrl_types[i];
>> +
>> +fail:
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_get_dev_info(struct usb_device *dev,
>> +                                 struct ixxat_dev_info *dev_info)
>> +{
>> +       int err;
>> +       struct ixxat_usb_info_cmd *cmd;
>> +       const u32 cmd_size = sizeof(*cmd);
>> +       const u32 req_size = sizeof(cmd->req);
>> +       const u32 rcv_size = cmd_size - req_size;
>> +       const u32 snd_size = req_size + sizeof(cmd->res);
>> +
>> +       cmd = kmalloc(cmd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_GET_DEVINFO);
>> +       cmd->res.res_size = cpu_to_le32(rcv_size);
>> +
>> +       err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
>> +                                &cmd->res, rcv_size);
>> +       if (err)
>> +               goto fail;
> This goto label is used only once. You can directly return here:
>
>            if (err) {
>                    kfree(cmd);
>                    return err;
>            }
>
>> +       if (dev_info) {
>> +               memcpy(dev_info->device_id, &cmd->info.device_id,
>> +                      sizeof(cmd->info.device_id));
>> +               memcpy(dev_info->device_name, &cmd->info.device_name,
>> +                      sizeof(cmd->info.device_name));
>> +               dev_info->device_fpga_version = cmd->info.device_fpga_version;
>> +               dev_info->device_version = cmd->info.device_version;
>> +       }
>> +
>> +fail:
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_start_ctrl(struct ixxat_usb_device *dev, u32 *time_ref)
>> +{
>> +       const u16 port = dev->ctrl_index;
>> +       int err;
>> +       struct ixxat_usb_start_cmd *cmd;
>> +       const u32 cmd_size = sizeof(*cmd);
>> +       const u32 req_size = sizeof(cmd->req);
>> +       const u32 rcv_size = cmd_size - req_size;
>> +       const u32 snd_size = req_size + sizeof(cmd->res);
>> +
>> +       cmd = kmalloc(cmd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_START);
>> +       cmd->req.port = cpu_to_le16(port);
>> +       cmd->res.res_size = cpu_to_le32(rcv_size);
>> +       cmd->time = 0;
>> +
>> +       err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
>> +                                rcv_size);
>> +       if (err)
>> +               goto fail;
>> +
>> +       if (time_ref)
> I do not think this if () is needed. All the callers of
> ixxat_usb_start_ctrl() pass a valid pointer.
>
>> +               *time_ref = le32_to_cpu(cmd->time);
> I do not get the logic. cmd is not modified by ixxat_usb_send_cmd(),
> right? So, here, cmd->time would still be zero. Am I missing
> something?
>
>> +
>> +fail:
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_stop_ctrl(struct ixxat_usb_device *dev)
>> +{
>> +       const u16 port = dev->ctrl_index;
>> +       int err;
>> +       struct ixxat_usb_stop_cmd *cmd;
>> +       const u32 rcv_size = sizeof(cmd->res);
>> +       const u32 snd_size = sizeof(*cmd);
>> +
>> +       cmd = kmalloc(snd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.size = cpu_to_le32(snd_size - rcv_size);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_STOP);
>> +       cmd->req.port = cpu_to_le16(port);
>> +       cmd->action = cpu_to_le32(IXXAT_USB_STOP_ACTION_CLEARALL);
>> +
>> +       err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
>> +                                rcv_size);
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_power_ctrl(struct usb_device *dev, u8 mode)
>> +{
>> +       int err;
>> +       struct ixxat_usb_power_cmd *cmd;
>> +       const u32 rcv_size = sizeof(cmd->res);
>> +       const u32 snd_size = sizeof(*cmd);
>> +
>> +       cmd = kmalloc(snd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.size = cpu_to_le32(snd_size - rcv_size);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_BRD_CMD_POWER);
>> +       cmd->mode = mode;
>> +
>> +       err = ixxat_usb_send_cmd(dev, le16_to_cpu(cmd->req.port), cmd, snd_size,
>> +                                &cmd->res, rcv_size);
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_reset_ctrl(struct ixxat_usb_device *dev)
>> +{
>> +       const u16 port = dev->ctrl_index;
>> +       int err;
>> +       struct ixxat_usb_dal_cmd *cmd;
>> +       const u32 snd_size = sizeof(*cmd);
>> +       const u32 rcv_size = sizeof(cmd->res);
>> +
>> +       cmd = kmalloc(snd_size, GFP_KERNEL);
>> +       if (!cmd)
>> +               return -ENOMEM;
>> +
>> +       ixxat_usb_setup_cmd(&cmd->req, &cmd->res);
>> +       cmd->req.code = cpu_to_le32(IXXAT_USB_CAN_CMD_RESET);
>> +       cmd->req.port = cpu_to_le16(port);
>> +
>> +       err = ixxat_usb_send_cmd(dev->udev, port, cmd, snd_size, &cmd->res,
>> +                                rcv_size);
>> +       kfree(cmd);
>> +       return err;
>> +}
>> +
>> +static void ixxat_usb_stop_queue(struct ixxat_usb_device *dev)
> The name is misleading. This does way more than just stopping the
> queue. You should use some keywords such as kill or free in this
> function name.
>
> Also, considering you do not have a ixxat_usb_start_queue(), it may be
> better to move netif_stop_queue(netdev) out of this function and call
> it separately.
>
>> +{
>> +       struct net_device *netdev = dev->netdev;
>> +       u32 i;
>> +
>> +       netif_stop_queue(netdev);
>> +       usb_kill_anchored_urbs(&dev->rx_submitted);
>> +       usb_kill_anchored_urbs(&dev->tx_submitted);
>> +       atomic_set(&dev->active_tx_urbs, 0);
>> +       for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
>> +               if (dev->tx_contexts[i].echo_index != IXXAT_USB_MAX_TX_URBS) {
>> +                       can_free_echo_skb(netdev, i, NULL);
>> +                       dev->tx_contexts[i].echo_index = IXXAT_USB_MAX_TX_URBS;
>> +               }
>> +       }
>> +}
>> +
>> +static int ixxat_usb_restart(struct ixxat_usb_device *dev)
>> +{
>> +       int err;
>> +       struct net_device *netdev = dev->netdev;
>> +       u32 t;
>> +
>> +       ixxat_usb_stop_queue(dev);
>> +       err = ixxat_usb_stop_ctrl(dev);
> ixxat_usb_stop_ctrl() kills all the anchored urbs...
>
>> +       if (err)
>> +               goto fail;
>> +
>> +       err = ixxat_usb_start_ctrl(dev, &t);
> ... however, ixxat_usb_start_ctrl() does not seem to reallocate those
> urbs. Am I missing something? Was this restart function actually
> tested?
>
> Also, for a restart, you do not need to release and reallocate your
> ressources. Just sending the stop and start commands to the device
> should be sufficient.
>
>> +       if (err)
>> +               goto fail;
>> +
>> +       dev->can.state = CAN_STATE_ERROR_ACTIVE;
>> +       netif_wake_queue(netdev);
>> +
>> +fail:
>> +       return err;
> If the fail label does only a return, no need for it. Just return the
> error instead of doing a goto jump.
>
>> +}
>> +
>> +static int ixxat_usb_set_mode(struct net_device *netdev, enum can_mode mode)
>> +{
>> +       struct ixxat_usb_device *dev = netdev_priv(netdev);
>> +
>> +       if (mode != CAN_MODE_START)
>> +               return -EOPNOTSUPP;
>> +
>> +       return ixxat_usb_restart(dev);
>> +}
>> +
>> +static int ixxat_usb_get_berr_counter(const struct net_device *netdev,
>> +                                     struct can_berr_counter *bec)
>> +{
>> +       struct ixxat_usb_device *dev = netdev_priv(netdev);
>> +
>> +       *bec = dev->bec;
>> +       return 0;
>> +}
>> +
>> +static int ixxat_usb_handle_canmsg(struct ixxat_usb_device *dev,
>> +                                  struct ixxat_can_msg *rx)
>> +{
>> +       const u32 ixx_flags = le32_to_cpu(rx->base.flags);
>> +       const u8 dlc = FIELD_GET(IXXAT_USB_MSG_FLAGS_DLC, ixx_flags);
>> +       struct canfd_frame *cf;
>> +       struct net_device *netdev = dev->netdev;
>> +       struct sk_buff *skb;
>> +       u8 flags = 0;
>> +       u8 len;
>> +       u8 min_size;
>> +
>> +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL) {
>> +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_FDR)
>> +                       flags |= CANFD_BRS;
>> +
>> +               if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_ESI)
>> +                       flags |= CANFD_ESI;
>> +
>> +               len = can_fd_dlc2len(dlc);
>> +       } else {
>> +               len = can_cc_dlc2len(dlc);
>> +       }
>> +
>> +       min_size = sizeof(rx->base) + len;
>> +
>> +       if (dev->adapter == &usb2can_cl1)
>> +               min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
>> +       else
>> +               min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
>> +
>> +       if (rx->base.size < (min_size - 1)) {
>> +               netdev_err(netdev, "Invalid can data message size\n");
>> +               return -EBADMSG;
>> +       }
>> +
>> +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_OVR) {
>> +               netdev->stats.rx_over_errors++;
>> +               netdev->stats.rx_errors++;
>> +               netdev_err(netdev, "Message overflow\n");
>> +       }
>> +
>> +       if (ixx_flags & IXXAT_USB_FDMSG_FLAGS_EDL)
>> +               skb = alloc_canfd_skb(netdev, &cf);
>> +       else
>> +               skb = alloc_can_skb(netdev, (struct can_frame **)&cf);
>> +
>> +       if (!skb)
>> +               return -ENOMEM;
>> +
>> +       cf->can_id = le32_to_cpu(rx->base.msg_id);
>> +       cf->len = len;
>> +       cf->flags |= flags;
>> +
>> +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_EXT)
>> +               cf->can_id |= CAN_EFF_FLAG;
>> +
>> +       if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR) {
>> +               cf->can_id |= CAN_RTR_FLAG;
>> +       } else {
>> +               if (dev->adapter == &usb2can_cl1)
>> +                       memcpy(cf->data, rx->cl1.data, len);
>> +               else
>> +                       memcpy(cf->data, rx->cl2.data, len);
>> +
>> +               netdev->stats.rx_bytes += cf->len;
>> +       }
>> +
>> +       ixxat_usb_get_ts_tv(dev, le32_to_cpu(rx->base.time), &skb->tstamp);
>> +
>> +       netdev->stats.rx_packets++;
>> +
>> +       netif_rx(skb);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ixxat_usb_handle_status(struct ixxat_usb_device *dev,
>> +                                  struct ixxat_can_msg *rx)
>> +{
>> +       struct net_device *netdev = dev->netdev;
>> +       struct can_frame *can_frame;
>> +       struct sk_buff *skb;
>> +       enum can_state new_state = CAN_STATE_ERROR_ACTIVE;
>> +       u32 raw_status;
>> +       u8 min_size = sizeof(rx->base) + sizeof(raw_status);
>> +
>> +       if (dev->adapter == &usb2can_cl1)
>> +               min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
>> +       else
>> +               min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
>> +
>> +       if (rx->base.size < (min_size - 1)) {
>> +               netdev_err(netdev, "Invalid can status message size\n");
>> +               return -EBADMSG;
>> +       }
>> +
>> +       if (dev->adapter == &usb2can_cl1)
>> +               raw_status = le32_to_cpu(rx->cl1.status);
>> +       else
>> +               raw_status = le32_to_cpu(rx->cl2.status);
>> +
>> +       if (raw_status != IXXAT_USB_CAN_STATUS_OK) {
>> +               if (raw_status & IXXAT_USB_CAN_STATUS_BUSOFF) {
>> +                       dev->can.can_stats.bus_off++;
>> +                       new_state = CAN_STATE_BUS_OFF;
>> +                       can_bus_off(netdev);
>> +               } else {
>> +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERRLIM) {
>> +                               dev->can.can_stats.error_warning++;
>> +                               new_state = CAN_STATE_ERROR_WARNING;
>> +                       }
>> +
>> +                       if (raw_status & IXXAT_USB_CAN_STATUS_ERR_PAS) {
>> +                               dev->can.can_stats.error_passive++;
>> +                               new_state = CAN_STATE_ERROR_PASSIVE;
>> +                       }
>> +
>> +                       if (raw_status & IXXAT_USB_CAN_STATUS_OVERRUN)
>> +                               new_state = CAN_STATE_MAX;
>> +               }
>> +       }
>> +
>> +       if (new_state == CAN_STATE_ERROR_ACTIVE) {
>> +               dev->bec.txerr = 0;
>> +               dev->bec.rxerr = 0;
>> +       }
>> +
>> +       if (new_state != CAN_STATE_MAX)
>> +               dev->can.state = new_state;
>> +
>> +       skb = alloc_can_err_skb(netdev, &can_frame);
>> +       if (!skb)
>> +               return -ENOMEM;
>> +
>> +       switch (new_state) {
>> +       case CAN_STATE_ERROR_ACTIVE:
>> +               can_frame->can_id |= CAN_ERR_CRTL;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_ACTIVE;
>> +               break;
>> +       case CAN_STATE_ERROR_WARNING:
>> +               can_frame->can_id |= CAN_ERR_CRTL;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_TX_WARNING;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_RX_WARNING;
>> +               break;
>> +       case CAN_STATE_ERROR_PASSIVE:
>> +               can_frame->can_id |= CAN_ERR_CRTL;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_TX_PASSIVE;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_RX_PASSIVE;
>> +               break;
>> +       case CAN_STATE_BUS_OFF:
>> +               can_frame->can_id |= CAN_ERR_BUSOFF;
>> +               break;
>> +       case CAN_STATE_MAX:
>> +               can_frame->can_id |= CAN_ERR_CRTL;
>> +               can_frame->data[1] |= CAN_ERR_CRTL_RX_OVERFLOW;
>> +               break;
>> +       default:
>> +               netdev_err(netdev, "Unhandled can status %d\n",
>> +                          new_state);
>> +               break;
>> +       }
>> +
>> +       netif_rx(skb);
>> +
>> +       return 0;
>> +}
>> +
>> +static int ixxat_usb_handle_error(struct ixxat_usb_device *dev,
>> +                                 struct ixxat_can_msg *rx)
>> +{
>> +       struct net_device *netdev = dev->netdev;
>> +       struct can_frame *can_frame;
>> +       struct sk_buff *skb;
>> +       u8 raw_error;
>> +       u8 min_size = sizeof(rx->base) + IXXAT_USB_CAN_ERROR_LEN;
>> +
>> +       if (dev->adapter == &usb2can_cl1)
>> +               min_size += sizeof(rx->cl1) - sizeof(rx->cl1.data);
>> +       else
>> +               min_size += sizeof(rx->cl2) - sizeof(rx->cl2.data);
>> +
>> +       if (rx->base.size < (min_size - 1)) {
>> +               netdev_err(netdev, "Invalid can error message size\n");
>> +               return -EBADMSG;
>> +       }
>> +
>> +       if (dev->can.state == CAN_STATE_BUS_OFF)
>> +               return 0;
>> +
>> +       if (dev->adapter == &usb2can_cl1) {
>> +               raw_error = rx->cl1.data[IXXAT_USB_CAN_ERROR_CODE];
>> +               dev->bec.rxerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
>> +               dev->bec.txerr = rx->cl1.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
>> +       } else {
>> +               raw_error = rx->cl2.data[IXXAT_USB_CAN_ERROR_CODE];
>> +               dev->bec.rxerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_RX];
>> +               dev->bec.txerr = rx->cl2.data[IXXAT_USB_CAN_ERROR_COUNTER_TX];
>> +       }
>> +
>> +       if (raw_error == IXXAT_USB_CAN_ERROR_ACK)
>> +               netdev->stats.tx_errors++;
>> +       else
>> +               netdev->stats.rx_errors++;
>> +
>> +       skb = alloc_can_err_skb(netdev, &can_frame);
>> +       if (!skb)
>> +               return -ENOMEM;
>> +
>> +       switch (raw_error) {
>> +       case IXXAT_USB_CAN_ERROR_ACK:
>> +               can_frame->can_id |= CAN_ERR_ACK;
>> +               break;
>> +       case IXXAT_USB_CAN_ERROR_BIT:
>> +               can_frame->can_id |= CAN_ERR_PROT;
>> +               can_frame->data[2] |= CAN_ERR_PROT_BIT;
>> +               break;
>> +       case IXXAT_USB_CAN_ERROR_CRC:
>> +               can_frame->can_id |= CAN_ERR_PROT;
>> +               can_frame->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
>> +               break;
>> +       case IXXAT_USB_CAN_ERROR_FORM:
>> +               can_frame->can_id |= CAN_ERR_PROT;
>> +               can_frame->data[2] |= CAN_ERR_PROT_FORM;
>> +               break;
>> +       case IXXAT_USB_CAN_ERROR_STUFF:
>> +               can_frame->can_id |= CAN_ERR_PROT;
>> +               can_frame->data[2] |= CAN_ERR_PROT_STUFF;
>> +               break;
>> +       default:
>> +               can_frame->can_id |= CAN_ERR_PROT;
>> +               can_frame->data[2] |= CAN_ERR_PROT_UNSPEC;
>> +               break;
>> +       }
>> +
>> +       netif_rx(skb);
>> +
>> +       return 0;
>> +}
>> +
>> +static void ixxat_usb_decode_buf(struct urb *urb)
>> +{
>> +       struct ixxat_usb_device *dev = urb->context;
>> +       struct net_device *netdev = dev->netdev;
>> +       struct ixxat_can_msg *can_msg;
>> +       int err = 0;
>> +       u32 pos = 0;
>> +       u8 *data = urb->transfer_buffer;
> Do not use an opaque pointer. Directly assign it to can_msg:
>
>            struct ixxat_can_msg *can_msg = urb->transfer_buffer;
>
>> +
>> +       while (pos < urb->actual_length) {
>> +               u32 time;
>> +               u8 size;
>> +               u8 type;
>> +
>> +               can_msg = (struct ixxat_can_msg *)&data[pos];
>> +               if (!can_msg || !can_msg->base.size) {
>                        ^^^^^^^^
>
> I do not think that can_msg can be NULL here.
>
> I see some redundancy here. If can_msg->base.size is zero, then then
> next check (size < sizeof(can_msg->base) would also fail, right? I see
> no need to make this a special case. Try to do the size sanitation in
> a single if.
>
>> +                       err = -ENOTSUPP;
> As discussed previously, -EBADMSG or -EMSGSIZE (as you prefer).
>
>> +                       netdev_err(netdev, "Unsupported usb msg: %pe\n",
>> +                                  ERR_PTR(err));
>> +                       break;
> This will print twice in the log (here and after the fail tag). Only
> one log message should be enough.
>
> Maybe you can remove the error message and instead goto fail? Thanks
> to the %pe, you would get:
>
>    Buffer decoding failed: -EBADMSG
>
> in the log which I think is sufficient.
>
>> +               }
>> +
>> +               size = can_msg->base.size + 1;
>> +               if (size < sizeof(can_msg->base) ||
>> +                   (pos + size) > urb->actual_length) {
>> +                       err = -EBADMSG;
>> +                       netdev_err(netdev,
>> +                                  "Invalid usb message size: %pe\n",
>> +                                  ERR_PTR(err));
>> +                       break;
> Same as above: try to print only one log message.
>
>> +               }
>> +
>> +               type = le32_to_cpu(can_msg->base.flags);
>> +               type &= IXXAT_USB_MSG_FLAGS_TYPE;
>> +               time = le32_to_cpu(can_msg->base.time);
>> +
>> +               switch (type) {
>> +               case IXXAT_USB_CAN_DATA:
>> +                       err = ixxat_usb_handle_canmsg(dev, can_msg);
>> +                       if (err)
>> +                               goto fail;
>> +                       break;
>> +               case IXXAT_USB_CAN_STATUS:
>> +                       err = ixxat_usb_handle_status(dev, can_msg);
>> +                       if (err)
>> +                               goto fail;
>> +                       break;
>> +               case IXXAT_USB_CAN_ERROR:
>> +                       err = ixxat_usb_handle_error(dev, can_msg);
>> +                       if (err)
>> +                               goto fail;
>> +                       break;
>> +               case IXXAT_USB_CAN_TIMEOVR:
>> +                       ixxat_usb_get_ts_tv(dev, time, NULL);
>> +                       break;
>> +               case IXXAT_USB_CAN_INFO:
>> +               case IXXAT_USB_CAN_WAKEUP:
>> +               case IXXAT_USB_CAN_TIMERST:
>> +                       break;
>> +               default:
>> +                       netdev_err(netdev,
>> +                                  "Unhandled rec type 0x%02x : ignored\n",
>> +                                  type);
>> +                       break;
>> +               }
>> +
>> +               pos += size;
>> +       }
>> +
>> +fail:
>> +       if (err)
>> +               netdev_err(netdev, "Buffer decoding failed: %pe\n", ERR_PTR(err));
>> +}
>> +
>> +static int ixxat_usb_encode_msg(struct ixxat_usb_device *dev,
>> +                               struct sk_buff *skb, u8 *obuf)
>> +{
>> +       int size;
>> +       struct canfd_frame *cf = (struct canfd_frame *)skb->data;
>> +       struct ixxat_can_msg can_msg = { 0 };
>> +       struct ixxat_can_msg_base *msg_base = &can_msg.base;
>> +       u32 flags = 0;
>> +       u32 msg_id = 0;
>> +
>> +       if (cf->can_id & CAN_RTR_FLAG)
>> +               flags |= IXXAT_USB_MSG_FLAGS_RTR;
>> +
>> +       if (cf->can_id & CAN_EFF_FLAG) {
>> +               flags |= IXXAT_USB_MSG_FLAGS_EXT;
>> +               msg_id = cf->can_id & CAN_EFF_MASK;
>> +       } else {
>> +               msg_id = cf->can_id & CAN_SFF_MASK;
>> +       }
>> +
>> +       if (can_is_canfd_skb(skb)) {
>> +               flags |= IXXAT_USB_FDMSG_FLAGS_EDL;
>> +
>> +               if (!(cf->can_id & CAN_RTR_FLAG) && (cf->flags & CANFD_BRS))
>> +                       flags |= IXXAT_USB_FDMSG_FLAGS_FDR;
>> +
>> +               flags |= FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC, can_fd_len2dlc(cf->len));
>> +       } else {
>> +               flags |= FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC, cf->len);
>> +       }
>> +
>> +       msg_base->flags = cpu_to_le32(flags);
>> +       msg_base->msg_id = cpu_to_le32(msg_id);
>> +       msg_base->size = sizeof(*msg_base) + cf->len - 1;
>> +       if (dev->adapter == &usb2can_cl1) {
>> +               msg_base->size += sizeof(can_msg.cl1);
>> +               msg_base->size -= sizeof(can_msg.cl1.data);
>> +               memcpy(can_msg.cl1.data, cf->data, cf->len);
>> +       } else {
>> +               msg_base->size += sizeof(can_msg.cl2);
>> +               msg_base->size -= sizeof(can_msg.cl2.data);
>> +               memcpy(can_msg.cl2.data, cf->data, cf->len);
>> +       }
>> +
>> +       size = msg_base->size + 1;
>> +       memcpy(obuf, &can_msg, size);
>> +       return size;
>> +}
>> +
>> +static void ixxat_usb_read_bulk_callback(struct urb *urb)
>> +{
>> +       struct ixxat_usb_device *dev = urb->context;
>> +       const struct ixxat_usb_adapter *adapter = dev->adapter;
>> +       struct net_device *netdev = dev->netdev;
>> +       struct usb_device *udev = dev->udev;
>> +       int err;
>> +
>> +       if (!netif_device_present(netdev))
>> +               return;
>> +
>> +       switch (urb->status) {
>> +       case 0: /* success */
>> +               break;
>> +       case -EPROTO:
>> +       case -EILSEQ:
>> +       case -ENOENT:
>> +       case -ECONNRESET:
>> +       case -ESHUTDOWN:
>> +               return;
>> +       default:
>> +               netdev_err(netdev, "Rx urb aborted %d\n", urb->status);
>> +               goto resubmit_urb;
>> +       }
>> +
>> +       if (urb->actual_length > 0)
>> +               if (dev->state & IXXAT_USB_STATE_STARTED)
>> +                       ixxat_usb_decode_buf(urb);
>> +
>> +resubmit_urb:
>> +       usb_fill_bulk_urb(urb, udev, usb_rcvbulkpipe(udev, dev->ep_msg_in),
>> +                         urb->transfer_buffer, adapter->buffer_size_rx,
>> +                         ixxat_usb_read_bulk_callback, dev);
>> +
>> +       usb_anchor_urb(urb, &dev->rx_submitted);
>> +       err = usb_submit_urb(urb, GFP_ATOMIC);
>> +       if (!err)
>> +               return;
>> +
>> +       usb_unanchor_urb(urb);
>> +
>> +       if (err == -ENODEV)
>> +               netif_device_detach(netdev);
>> +       else
>> +               netdev_err(netdev,
>> +                          "Failed to resubmit read bulk urb: %pe\n", ERR_PTR(err));
>> +}
>> +
>> +static void ixxat_usb_write_bulk_callback(struct urb *urb)
>> +{
>> +       struct ixxat_tx_urb_context *context = urb->context;
>> +       struct ixxat_usb_device *dev;
>> +       struct net_device *netdev;
>> +
>> +       if (WARN_ON(!context))
>> +               return;
>> +
>> +       dev = context->dev;
>> +       netdev = dev->netdev;
>> +
>> +       if (!netif_device_present(netdev))
>> +               return;
>> +
>> +       if (!urb->status) {
>> +               netdev->stats.tx_packets++;
>> +               netdev->stats.tx_bytes += can_get_echo_skb(netdev, context->echo_index, NULL);
>> +       } else {
>> +               netdev_err(netdev, "Tx urb aborted: %pe\n", ERR_PTR(urb->status));
>> +               can_free_echo_skb(netdev, context->echo_index, NULL);
>> +       }
>> +
>> +       context->echo_index = IXXAT_USB_MAX_TX_URBS;
>> +       atomic_dec(&dev->active_tx_urbs);
>> +
>> +       if (!urb->status)
>> +               netif_wake_queue(netdev);
>> +}
>> +
>> +static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
>> +                                       struct net_device *netdev)
>> +{
>> +       int err;
>> +       int size;
>> +       struct ixxat_usb_device *dev = netdev_priv(netdev);
>> +       struct ixxat_tx_urb_context *context = NULL;
>> +       struct net_device_stats *stats = &netdev->stats;
>> +       struct urb *urb;
>> +       u8 *obuf;
>> +       u32 i;
>> +
>> +       if (can_dropped_invalid_skb(netdev, skb))
>> +               return NETDEV_TX_OK;
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
>> +               if (dev->tx_contexts[i].echo_index == IXXAT_USB_MAX_TX_URBS) {
>> +                       context = dev->tx_contexts + i;
>> +                       break;
>> +               }
>> +       }
>> +
>> +       if (WARN_ON_ONCE(!context))
>> +               return NETDEV_TX_BUSY;
>> +
>> +       urb = context->urb;
>> +       obuf = urb->transfer_buffer;
>> +
>> +       size = ixxat_usb_encode_msg(dev, skb, obuf);
>> +
>> +       context->echo_index = i;
>> +
>> +       urb->transfer_buffer_length = size;
>> +       usb_anchor_urb(urb, &dev->tx_submitted);
>> +       can_put_echo_skb(skb, netdev, i, 0);
>> +       atomic_inc(&dev->active_tx_urbs);
>> +
>> +       err = usb_submit_urb(urb, GFP_ATOMIC);
>> +       if (err) {
>> +               can_free_echo_skb(netdev, i, NULL);
>> +               usb_unanchor_urb(urb);
>> +               atomic_dec(&dev->active_tx_urbs);
>> +
>> +               context->echo_index = IXXAT_USB_MAX_TX_URBS;
>> +
>> +               if (err == -ENODEV) {
>> +                       netif_device_detach(netdev);
>> +               } else {
>> +                       stats->tx_dropped++;
>> +                       netdev_err(netdev,
>> +                                  "Submitting tx-urb failed: %pe\n", ERR_PTR(err));
>> +               }
>> +       } else {
>> +               if (atomic_read(&dev->active_tx_urbs) >= IXXAT_USB_MAX_TX_URBS)
>> +                       netif_stop_queue(netdev);
>> +       }
>> +
>> +       return NETDEV_TX_OK;
>> +}
>> +
>> +static int ixxat_usb_setup_rx_urbs(struct ixxat_usb_device *dev)
>> +{
>> +       int i;
>> +       int err = 0;
>> +       const struct ixxat_usb_adapter *adapter = dev->adapter;
>> +       struct net_device *netdev = dev->netdev;
>> +       struct usb_device *udev = dev->udev;
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_RX_URBS; i++) {
>> +               struct urb *urb;
>> +               u8 *buf;
>> +
>> +               urb = usb_alloc_urb(0, GFP_KERNEL);
>> +               if (!urb) {
>> +                       err = -ENOMEM;
>> +                       netdev_err(netdev, "No memory for URBs: %pe\n",
>> +                                  ERR_PTR(err));
>> +                       break;
>> +               }
>> +
>> +               buf = kmalloc(adapter->buffer_size_rx, GFP_KERNEL);
>> +               if (!buf) {
>> +                       usb_free_urb(urb);
>> +                       err = -ENOMEM;
>> +                       netdev_err(netdev,
>> +                                  "No memory for USB-buffer: %pe\n", ERR_PTR(err));
>> +                       break;
>> +               }
>> +
>> +               usb_fill_bulk_urb(urb, udev,
>> +                                 usb_rcvbulkpipe(udev, dev->ep_msg_in), buf,
>> +                                 adapter->buffer_size_rx,
>> +                                 ixxat_usb_read_bulk_callback, dev);
>> +
>> +               urb->transfer_flags |= URB_FREE_BUFFER;
>> +               usb_anchor_urb(urb, &dev->rx_submitted);
>> +
>> +               err = usb_submit_urb(urb, GFP_KERNEL);
>> +               if (err) {
>> +                       usb_unanchor_urb(urb);
>> +                       kfree(buf);
>> +                       usb_free_urb(urb);
>> +
>> +                       if (err == -ENODEV)
>> +                               netif_device_detach(netdev);
>> +
>> +                       break;
>> +               }
>> +
>> +               usb_free_urb(urb);
>> +       }
>> +
>> +       if (i == 0)
>> +               netdev_err(netdev, "Couldn't setup any rx-URBs\n");
>> +
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_setup_tx_urbs(struct ixxat_usb_device *dev)
>> +{
>> +       int i;
>> +       int ret = 0;
>> +       const struct ixxat_usb_adapter *adapter = dev->adapter;
>> +       struct net_device *netdev = dev->netdev;
>> +       struct usb_device *udev = dev->udev;
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
>> +               struct ixxat_tx_urb_context *context;
>> +               struct urb *urb;
>> +               u8 *buf;
>> +
>> +               urb = usb_alloc_urb(0, GFP_KERNEL);
>> +               if (!urb) {
>> +                       ret = -ENOMEM;
>> +                       netdev_err(netdev, "No memory for URBs: %pe\n",
>> +                                  ERR_PTR(ret));
>> +                       break;
>> +               }
>> +
>> +               buf = kmalloc(adapter->buffer_size_tx, GFP_KERNEL);
>> +               if (!buf) {
>> +                       usb_free_urb(urb);
>> +                       ret = -ENOMEM;
>> +                       netdev_err(netdev,
>> +                                  "No memory for USB-buffer: %pe\n", ERR_PTR(ret));
>> +                       break;
>> +               }
>> +
>> +               context = dev->tx_contexts + i;
>> +               context->dev = dev;
>> +               context->urb = urb;
>> +
>> +               usb_fill_bulk_urb(urb, udev,
>> +                                 usb_sndbulkpipe(udev, dev->ep_msg_out), buf,
>> +                                 adapter->buffer_size_tx,
>> +                                 ixxat_usb_write_bulk_callback, context);
>> +
>> +               urb->transfer_flags |= URB_FREE_BUFFER;
>> +       }
>> +
>> +       if (i == 0) {
>> +               netdev_err(netdev, "Couldn't setup any tx-URBs\n");
>> +               usb_kill_anchored_urbs(&dev->rx_submitted);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +static void ixxat_usb_disconnect(struct usb_interface *intf)
>> +{
>> +       struct ixxat_usb_device *dev;
>> +       struct ixxat_usb_device *prev_dev;
>> +
>> +       /* unregister the given device and all previous devices */
>> +       for (dev = usb_get_intfdata(intf); dev; dev = prev_dev) {
>> +               prev_dev = dev->prev_dev;
>> +               unregister_netdev(dev->netdev);
>> +               free_candev(dev->netdev);
>> +       }
>> +
>> +       usb_set_intfdata(intf, NULL);
>> +}
>> +
>> +static int ixxat_usb_start(struct ixxat_usb_device *dev)
>> +{
>> +       int err;
>> +       int i;
>> +       u32 time_ref = 0;
>> +       const struct ixxat_usb_adapter *adapter = dev->adapter;
>> +
>> +       err = ixxat_usb_setup_rx_urbs(dev);
>> +       if (err)
>> +               return err;
>> +
>> +       err = ixxat_usb_setup_tx_urbs(dev);
>> +       if (err)
>> +               return err;
>> +
>> +       /* Try to reset the controller, in case it is already initialized
>> +        * from a previous unclean shutdown
>> +        */
>> +       ixxat_usb_reset_ctrl(dev);
>> +
>> +       if (adapter->init_ctrl) {
>> +               err = adapter->init_ctrl(dev);
>> +               if (err)
>> +                       goto fail;
>> +       }
>> +
>> +       if (!(dev->state & IXXAT_USB_STATE_STARTED)) {
>> +               err = ixxat_usb_start_ctrl(dev, &time_ref);
>> +               if (err)
>> +                       goto fail;
>> +
>> +               ixxat_usb_set_ts_now(dev, time_ref);
>> +       }
>> +
>> +       dev->bec.txerr = 0;
>> +       dev->bec.rxerr = 0;
>> +
>> +       dev->state |= IXXAT_USB_STATE_STARTED;
>> +       dev->can.state = CAN_STATE_ERROR_ACTIVE;
>> +       return 0;
>> +
>> +fail:
>> +       if (err == -ENODEV)
>> +               netif_device_detach(dev->netdev);
>> +
>> +       netdev_err(dev->netdev, "Couldn't submit control: %pe\n", ERR_PTR(err));
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++) {
>> +               usb_free_urb(dev->tx_contexts[i].urb);
>> +               dev->tx_contexts[i].urb = NULL;
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_open(struct net_device *netdev)
>> +{
>> +       struct ixxat_usb_device *dev = netdev_priv(netdev);
>> +       int err;
>> +
>> +       /* common open */
>> +       err = open_candev(netdev);
>> +       if (err)
>> +               goto fail;
>> +
>> +       /* finally start device */
>> +       err = ixxat_usb_start(dev);
>> +       if (err) {
>> +               netdev_err(netdev, "Couldn't start device: %pe\n", ERR_PTR(err));
>> +               close_candev(netdev);
>> +               goto fail;
>> +       }
>> +
>> +       netif_start_queue(netdev);
>> +
>> +fail:
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_stop(struct net_device *netdev)
>> +{
>> +       int err = 0;
>> +       struct ixxat_usb_device *dev = netdev_priv(netdev);
>> +
>> +       ixxat_usb_stop_queue(dev);
>> +       if (dev->state & IXXAT_USB_STATE_STARTED) {
>> +               err = ixxat_usb_stop_ctrl(dev);
>> +               if (err)
>> +                       netdev_warn(netdev, "Error %d: Cannot stop device\n",
>> +                                   err);
>> +       }
>> +
>> +       dev->state &= ~IXXAT_USB_STATE_STARTED;
>> +       close_candev(netdev);
>> +       dev->can.state = CAN_STATE_STOPPED;
>> +       return err;
>> +}
>> +
>> +static const struct net_device_ops ixxat_usb_netdev_ops = {
>> +       .ndo_open = ixxat_usb_open,
>> +       .ndo_stop = ixxat_usb_stop,
>> +       .ndo_start_xmit = ixxat_usb_start_xmit
>> +};
>> +
>> +static const struct ethtool_ops ixxat_usb_ethtool_ops = {
>> +       .get_ts_info = ethtool_op_get_ts_info,
>> +};
>> +
>> +static int ixxat_usb_create_dev(struct usb_interface *intf,
>> +                               const struct ixxat_usb_adapter *adapter,
>> +                               u16 ctrl_index)
>> +{
>> +       struct usb_device *udev = interface_to_usbdev(intf);
>> +       struct ixxat_usb_device *dev;
>> +       struct net_device *netdev;
>> +       int err;
>> +       int i;
>> +
>> +       netdev = alloc_candev(sizeof(*dev), IXXAT_USB_MAX_TX_URBS);
>> +       if (!netdev) {
>> +               dev_err(&intf->dev, "Cannot allocate candev\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       dev = netdev_priv(netdev);
>> +       dev->udev = udev;
>> +       dev->netdev = netdev;
>> +       dev->adapter = adapter;
>> +       dev->ctrl_index = ctrl_index;
>> +       dev->state = IXXAT_USB_STATE_CONNECTED;
>> +
>> +       i = ctrl_index + adapter->ep_offs;
>> +       dev->ep_msg_in = adapter->ep_msg_in[i];
>> +       dev->ep_msg_out = adapter->ep_msg_out[i];
>> +
>> +       dev->can.clock.freq = adapter->clock;
>> +       dev->can.bittiming_const = adapter->bt;
>> +       dev->can.data_bittiming_const = adapter->btd;
>> +
>> +       dev->can.do_set_mode = ixxat_usb_set_mode;
>> +       dev->can.do_get_berr_counter = ixxat_usb_get_berr_counter;
>> +
>> +       dev->can.ctrlmode_supported = adapter->modes;
>> +
>> +       netdev->netdev_ops = &ixxat_usb_netdev_ops;
>> +       netdev->ethtool_ops = &ixxat_usb_ethtool_ops;
>> +
>> +       netdev->flags |= IFF_ECHO;
>> +       netdev->dev_port = ctrl_index;
>> +
>> +       init_usb_anchor(&dev->rx_submitted);
>> +       init_usb_anchor(&dev->tx_submitted);
>> +
>> +       atomic_set(&dev->active_tx_urbs, 0);
>> +
>> +       for (i = 0; i < IXXAT_USB_MAX_TX_URBS; i++)
>> +               dev->tx_contexts[i].echo_index = IXXAT_USB_MAX_TX_URBS;
>> +
>> +       dev->prev_dev = usb_get_intfdata(intf);
>> +       usb_set_intfdata(intf, dev);
>> +
>> +       SET_NETDEV_DEV(netdev, &intf->dev);
>> +       err = register_candev(netdev);
>> +       if (err) {
>> +               dev_err(&intf->dev, "Failed to register can device: %pe\n",
>> +                       ERR_PTR(err));
>> +               goto free_candev;
>> +       }
>> +
>> +       if (dev->prev_dev)
>> +               (dev->prev_dev)->next_dev = dev;
>> +
>> +       err = ixxat_usb_get_dev_info(udev, &dev->dev_info);
>> +       if (err) {
>> +               dev_err(&intf->dev,
>> +                       "Failed to get device information: %pe\n", ERR_PTR(err));
>> +               goto unreg_candev;
>> +       }
>> +
>> +       netdev_info(netdev, "%s: Connected Channel %u (device %s)\n",
>> +                   dev->dev_info.device_name, ctrl_index,
>> +                   dev->dev_info.device_id);
>> +
>> +       return 0;
>> +
>> +unreg_candev:
>> +       unregister_candev(netdev);
>> +free_candev:
>> +       usb_set_intfdata(intf, dev->prev_dev);
>> +       free_candev(netdev);
>> +       return err;
>> +}
>> +
>> +static int ixxat_usb_probe(struct usb_interface *intf,
>> +                          const struct usb_device_id *id)
>> +{
>> +       struct usb_device *udev = interface_to_usbdev(intf);
>> +       struct usb_host_interface *host_intf = intf->altsetting;
>> +       const struct ixxat_usb_adapter *adapter;
>> +       struct ixxat_dev_caps dev_caps;
>> +       u16 i;
>> +       int err;
>> +
>> +       usb_reset_configuration(udev);
>> +
>> +       adapter = (const struct ixxat_usb_adapter *)id->driver_info;
>> +
>> +       for (i = 0; i < host_intf->desc.bNumEndpoints; i++) {
>> +               const u8 epaddr = host_intf->endpoint[i].desc.bEndpointAddress;
>> +               int match;
>> +               u8 j;
>> +
>> +               /* Check if usb-endpoint address matches known usb-endpoints */
>> +               for (j = 0; j < IXXAT_USB_MAX_CHANNEL; j++) {
>> +                       u8 ep_msg_in = adapter->ep_msg_in[j];
>> +                       u8 ep_msg_out = adapter->ep_msg_in[j];
>> +
>> +                       if (epaddr == ep_msg_in || epaddr == ep_msg_out) {
>> +                               match = 1;
>> +                               break;
>> +                       }
>> +               }
>> +
>> +               if (!match)
>> +                       return -ENODEV;
>> +       }
>> +
>> +       err = ixxat_usb_power_ctrl(udev, IXXAT_USB_POWER_WAKEUP);
>> +       if (err)
>> +               return err;
>> +
>> +       msleep(IXXAT_USB_POWER_WAKEUP_TIME);
>> +
>> +       err = ixxat_usb_get_dev_caps(udev, &dev_caps);
>> +       if (err) {
>> +               dev_err(&intf->dev,
>> +                       "Failed to get device capabilities: %pe\n", ERR_PTR(err));
>> +               return err;
>> +       }
>> +
>> +       err = -ENODEV;
>> +       for (i = 0; i < le16_to_cpu(dev_caps.bus_ctrl_count); i++) {
>> +               u16 dev_bustype = le16_to_cpu(dev_caps.bus_ctrl_types[i]);
>> +               u8 bustype = IXXAT_USB_BUS_TYPE(dev_bustype);
>> +
>> +               if (bustype == IXXAT_USB_BUS_CAN)
>> +                       err = ixxat_usb_create_dev(intf, adapter, i);
>> +
>> +               if (err) {
>> +                       /* deregister already created devices */
>> +                       ixxat_usb_disconnect(intf);
>> +                       return err;
>> +               }
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +static struct usb_driver ixxat_usb_driver = {
>> +       .name = IXXAT_USB_DRIVER_NAME,
>> +       .probe = ixxat_usb_probe,
>> +       .disconnect = ixxat_usb_disconnect,
>> +       .id_table = ixxat_usb_table,
>> +};
>> +
>> +module_usb_driver(ixxat_usb_driver);
>> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
>> new file mode 100644
>> index 000000000000..56c6f3b938d8
>> --- /dev/null
>> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h
>> @@ -0,0 +1,511 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2018 HMS Industrial Networks <socketcan@hms-networks.de>
>> + */
>> +
>> +#ifndef IXXAT_USB_CORE_H
>> +#define IXXAT_USB_CORE_H
>> +
>> +#define IXXAT_USB_DRIVER_NAME "ixxat_usb2can"
> Remove and use KBUILD_MODNAME instead.
>
>> +#define IXXAT_USB_CTRL_NAME "ixxat_usb"
>> +
>> +#define IXXAT_USB_VENDOR_ID 0x08d8
>> +
>> +/* supported device ids: CL1 */
>> +#define USB2CAN_COMPACT_PRODUCT_ID 0x0008
>> +#define USB2CAN_EMBEDDED_PRODUCT_ID 0x0009
>> +#define USB2CAN_PROFESSIONAL_PRODUCT_ID 0x000A
>> +#define USB2CAN_AUTOMOTIVE_PRODUCT_ID 0x000B
>> +
>> +/* supported device ids: CL2 */
>> +#define USB2CAN_FD_COMPACT_PRODUCT_ID 0x0014
>> +#define USB2CAN_FD_PROFESSIONAL_PRODUCT_ID 0x0016
>> +#define USB2CAN_FD_AUTOMOTIVE_PRODUCT_ID 0x0017
>> +#define USB2CAN_FD_PCIE_MINI_PRODUCT_ID 0x001B
>> +#define USB2CAR_PRODUCT_ID 0x001C
>> +#define CAN_IDM101_PRODUCT_ID 0xFF12
>> +#define CAN_IDM200_PRODUCT_ID 0xFF13
>> +
>> +#define IXXAT_USB_BUS_CAN 1
>> +
>> +#define IXXAT_USB_BUS_TYPE(type) ((u8)(((type) >> 8) & 0x00FF))
> Do:
>
>    #define IXXAT_USB_BUS_TYPE_MASK 0xff00
>
> and then use FIELD_GET(IXXAT_USB_BUS_TYPE_MASK, type) instead.
>
>> +#define IXXAT_USB_STATE_CONNECTED BIT(0)
>> +#define IXXAT_USB_STATE_STARTED BIT(1)
>> +
>> +#define IXXAT_USB_MAX_CHANNEL 5
>> +#define IXXAT_USB_MAX_TYPES 32
>> +#define IXXAT_USB_MAX_RX_URBS 4
>> +#define IXXAT_USB_MAX_TX_URBS 10
>> +#define IXXAT_USB_MAX_COM_REQ 10
>> +
>> +#define IXXAT_USB_MSG_TIMEOUT 50
>> +#define IXXAT_USB_MSG_CYCLE 20
>> +
>> +#define IXXAT_USB_POWER_WAKEUP 0
>> +#define IXXAT_USB_POWER_WAKEUP_TIME 500
>> +
>> +#define IXXAT_USB_OPMODE_STANDARD BIT(0)
>> +#define IXXAT_USB_OPMODE_EXTENDED BIT(1)
>> +#define IXXAT_USB_OPMODE_ERRFRAME BIT(2)
>> +#define IXXAT_USB_OPMODE_LISTONLY BIT(3)
>> +
>> +#define IXXAT_USB_EXMODE_EXTDATA BIT(0)
>> +#define IXXAT_USB_EXMODE_FASTDATA BIT(1)
>> +#define IXXAT_USB_EXMODE_ISOFD BIT(2)
>> +
>> +#define IXXAT_USB_BTMODE_NAT BIT(0)
>> +#define IXXAT_USB_BTMODE_TSM BIT(1)
>> +
>> +#define IXXAT_USB_STOP_ACTION_CLEARALL 3
>> +
>> +#define IXXAT_RESTART_TASK_CYCLE_TIME 20
>> +
>> +#define IXXAT_USB_CAN_DATA 0x00
>> +#define IXXAT_USB_CAN_INFO 0x01
>> +#define IXXAT_USB_CAN_ERROR 0x02
>> +#define IXXAT_USB_CAN_STATUS 0x03
>> +#define IXXAT_USB_CAN_WAKEUP 0x04
>> +#define IXXAT_USB_CAN_TIMEOVR 0x05
>> +#define IXXAT_USB_CAN_TIMERST 0x06
>> +
>> +#define IXXAT_USB_CAN_STATUS_OK 0x00000000
>> +#define IXXAT_USB_CAN_STATUS_OVERRUN 0x00000002
>> +#define IXXAT_USB_CAN_STATUS_ERRLIM 0x00000004
>> +#define IXXAT_USB_CAN_STATUS_BUSOFF 0x00000008
>> +#define IXXAT_USB_CAN_STATUS_ERR_PAS 0x00002000
>> +
>> +#define IXXAT_USB_CAN_ERROR_LEN 5
>> +
>> +#define IXXAT_USB_CAN_ERROR_CODE 0
>> +#define IXXAT_USB_CAN_ERROR_COUNTER_RX 3
>> +#define IXXAT_USB_CAN_ERROR_COUNTER_TX 4
>> +
>> +#define IXXAT_USB_CAN_ERROR_STUFF 1
>> +#define IXXAT_USB_CAN_ERROR_FORM 2
>> +#define IXXAT_USB_CAN_ERROR_ACK 3
>> +#define IXXAT_USB_CAN_ERROR_BIT 4
>> +#define IXXAT_USB_CAN_ERROR_CRC 6
>> +
>> +#define IXXAT_USB_MSG_FLAGS_TYPE 0x000000FF
>> +#define IXXAT_USB_MSG_FLAGS_DLC 0x000F0000
>> +#define IXXAT_USB_MSG_FLAGS_OVR 0x00100000
>> +#define IXXAT_USB_MSG_FLAGS_RTR 0x00400000
>> +#define IXXAT_USB_MSG_FLAGS_EXT 0x00800000
>> +
>> +#define IXXAT_USB_FDMSG_FLAGS_EDL 0x00000400
>> +#define IXXAT_USB_FDMSG_FLAGS_FDR 0x00000800
>> +#define IXXAT_USB_FDMSG_FLAGS_ESI 0x00001000
>> +
>> +#define IXXAT_USB_CAN_CMD_START 0x326
>> +#define IXXAT_USB_CAN_CMD_STOP 0x327
>> +#define IXXAT_USB_CAN_CMD_RESET 0x328
>> +
>> +#define IXXAT_USB_BRD_CMD_GET_DEVCAPS 0x401
>> +#define IXXAT_USB_BRD_CMD_GET_DEVINFO 0x402
>> +#define IXXAT_USB_BRD_CMD_POWER 0x421
>> +
>> +/**
>> + * struct ixxat_can_msg_base - IXXAT CAN message base (CL1/CL2)
>> + * @size: Message size (this field excluded)
>> + * @time: Message timestamp
>> + * @msg_id: Message ID
>> + * @flags: Message flags
>> + *
>> + * Contains the common fields of an IXXAT CAN message on both CL1 and CL2
>> + * devices
>> + */
>> +struct ixxat_can_msg_base {
>> +       u8 size;
>> +       __le32 time;
> Is this an hardware timestamp? If so, you can populate
> skb_shared_hwtstamps->hwtstamp (c.f. function skb_hwtstamps()). Then
> ixxat_usb_ethtool_ops needs to be updated accordingly to inform the
> userland that you do support hardware timestamps.
>
>> +       __le32 msg_id;
>> +       __le32 flags;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_can_msg_cl1 - IXXAT CAN message (CL1)
>> + * @data: Message data (standard CAN frame)
>> + *
>> + * Contains the fields of an IXXAT CAN message on CL1 devices
>> + */
>> +struct ixxat_can_msg_cl1 {
>> +       union {
>> +               u8 data[CAN_MAX_DLEN];
>> +               __le32 status;
>> +       } __packed;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_can_msg_cl2 - IXXAT CAN message (CL2)
>> + * @client_id: Client ID
>> + * @data: Message data (CAN FD frame)
>> + *
>> + * Contains the fields of an IXXAT CAN message on CL2 devices
>> + */
>> +struct ixxat_can_msg_cl2 {
>> +       __le32 client_id;
>> +       union {
>> +               u8 data[CANFD_MAX_DLEN];
>> +               __le32 status;
>> +       } __packed;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_can_msg - IXXAT CAN message
>> + * @base: Base message
>> + * @cl1: Cl1 message
>> + * @cl2: Cl2 message
>> + *
>> + * Contains an IXXAT CAN message
>> + */
>> +struct ixxat_can_msg {
>> +       struct ixxat_can_msg_base base;
>> +       union {
>> +               struct ixxat_can_msg_cl1 cl1;
>> +               struct ixxat_can_msg_cl2 cl2;
>> +       };
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_dev_caps - Device capabilities
>> + * @bus_ctrl_count: Stores the bus controller counter
>> + * @bus_ctrl_types: Stores the bus controller types
>> + *
>> + * Contains the device capabilities
>> + */
>> +struct ixxat_dev_caps {
>> +       __le16 bus_ctrl_count;
>> +       __le16 bus_ctrl_types[IXXAT_USB_MAX_TYPES];
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_canbtp Bittiming parameters (CL2)
>> + * @mode: Operation mode
>> + * @bps: Bits per second
>> + * @ts1: First time segment
>> + * @ts2: Second time segment
>> + * @sjw: Synchronization jump width
>> + * @tdo: Transmitter delay offset
>> + *
>> + * Bittiming parameters of a CL2 initialization request
>> + */
>> +struct ixxat_canbtp {
>> +       __le32 mode;
>> +       __le32 bps;
>> +       __le16 ts1;
>> +       __le16 ts2;
>> +       __le16 sjw;
>> +       __le16 tdo;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_dev_info IXXAT usb device information
>> + * @device_name: Name of the device
>> + * @device_id: Device identification ( unique device id)
>> + * @device_version: Device version ( 0, 1, ...)
>> + * @device_fpga_version: Version of FPGA design
>> + *
>> + * Contains device information of IXXAT USB devices
>> + */
>> +struct ixxat_dev_info {
>> +       char device_name[16];
>> +       char device_id[16];
>> +       __le16 device_version;
>> +       __le32 device_fpga_version;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_time_ref Time reference
>> + * @kt_host_0: Latest time on the host
>> + * @ts_dev_0: Latest time stamp on the device
>> + * @ts_dev_last: Last device time stamp
>> + *
>> + * Contains time references of the device and the host
>> + */
>> +struct ixxat_time_ref {
>> +       ktime_t kt_host_0;
>> +       u32 ts_dev_0;
>> +       u32 ts_dev_last;
>> +};
>> +
>> +/**
>> + * struct ixxat_tx_urb_context URB content for transmission
>> + * @dev: IXXAT USB device
>> + * @urb: USB request block
>> + * @echo_index: Echo index
>> + * @dlc: Data length code
>> + * @count: Counter
> Those two fields appear in the documentation but are not part of the
> actual struct.
>
>> + *
>> + * Contains content for USB request block transmissions
>> + */
>> +struct ixxat_tx_urb_context {
>> +       struct ixxat_usb_device *dev;
>> +       struct urb *urb;
>> +       u32 echo_index;
>> +};
>> +
>> +/**
>> + * struct ixxat_usb_device IXXAT USB device
>> + * @can: CAN common private data
>> + * @adapter: USB network descriptor
>> + * @udev: USB device
>> + * @netdev: Net_device
>> + * @active_tx_urbs: Active tx urbs
>> + * @tx_submitted: Submitted tx usb anchor
>> + * @tx_contexts: Buffer for tx contexts
>> + * @rx_submitted: Submitted rx usb anchor
>> + * @state: Device state
>> + * @ctrl_index: Controller index
>> + * @ep_msg_in: USB endpoint for incoming messages
>> + * @ep_msg_out: USB endpoint for outgoing messages
>> + * @prev_dev: Previous opened device
>> + * @next_dev: Next opened device in list
>> + * @time_ref: Time reference
>> + * @dev_info: Device information
>> + * @bec: CAN error counter
>> + *
>> + * IXXAT USB-to-CAN device
>> + */
>> +struct ixxat_usb_device {
>> +       struct can_priv can;
>> +       const struct ixxat_usb_adapter *adapter;
>> +       struct usb_device *udev;
>> +       struct net_device *netdev;
>> +
>> +       atomic_t active_tx_urbs;
>> +       struct usb_anchor tx_submitted;
>> +       struct ixxat_tx_urb_context tx_contexts[IXXAT_USB_MAX_TX_URBS];
>> +       struct usb_anchor rx_submitted;
>> +
>> +       u32 state;
>> +       u16 ctrl_index;
>> +
>> +       u8 ep_msg_in;
>> +       u8 ep_msg_out;
>> +
>> +       struct ixxat_usb_device *prev_dev;
>> +       struct ixxat_usb_device *next_dev;
>> +
>> +       struct ixxat_time_ref time_ref;
>> +       struct ixxat_dev_info dev_info;
>> +
>> +       struct can_berr_counter bec;
>> +};
>> +
>> +/**
>> + * struct ixxat_usb_dal_req IXXAT device request block
>> + * @size: Request size
>> + * @port: Request port
>> + * @socket: Request socket
>> + * @code: Request code
>> + *
>> + * IXXAT device request block
>> + */
>> +struct ixxat_usb_dal_req {
>> +       __le32 size;
>> +       __le16 port;
>> +       __le16 socket;
>> +       __le32 code;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_dal_res IXXAT device response block
>> + * @res_size: Expected response size
>> + * @ret_size: Actual response size
>> + * @code: Return code
>> + *
>> + * IXXAT device response block
>> + */
>> +struct ixxat_usb_dal_res {
>> +       __le32 res_size;
>> +       __le32 ret_size;
>> +       __le32 code;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_dal_cmd IXXAT device command
>> + * @req: Request block
>> + * @req: Response block
>> + *
>> + * IXXAT device command
>> + */
>> +struct ixxat_usb_dal_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       struct ixxat_usb_dal_res res;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_caps_cmd Device capabilities command
>> + * @req: Request block
>> + * @res: Response block
>> + * @caps: Device capabilities
>> + *
>> + * Can be sent to a device to request its capabilities
>> + */
>> +struct ixxat_usb_caps_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       struct ixxat_usb_dal_res res;
>> +       struct ixxat_dev_caps caps;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_init_cl1_cmd Initialization command (CL1)
>> + * @req: Request block
>> + * @mode: Operation mode
>> + * @btr0: Bittiming register 0
>> + * @btr1: Bittiming register 1
>> + * @padding: 1 byte padding
>> + * @res: Response block
>> + *
>> + * Can be sent to a CL1 device to initialize it
>> + */
>> +struct ixxat_usb_init_cl1_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       u8 mode;
>> +       u8 btr0;
>> +       u8 btr1;
>> +       u8 padding;
>> +       struct ixxat_usb_dal_res res;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_init_cl2_cmd Initialization command (CL2)
>> + * @req: Request block
>> + * @opmode: Operation mode
>> + * @exmode: Extended mode
>> + * @sdr: Stadard bittiming parameters
>> + * @fdr: Fast data bittiming parameters
>> + * @_padding: 2 bytes padding
>> + * @res: Response block
>> + *
>> + * Can be sent to a CL2 device to initialize it
>> + */
>> +struct ixxat_usb_init_cl2_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       u8 opmode;
>> +       u8 exmode;
>> +       struct ixxat_canbtp sdr;
>> +       struct ixxat_canbtp fdr;
>> +       __le16 _padding;
>> +       struct ixxat_usb_dal_res res;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_start_cmd Controller start command
>> + * @req: Request block
>> + * @res: Response block
>> + * @time: Timestamp
>> + *
>> + * Can be sent to a device to start its controller
>> + */
>> +struct ixxat_usb_start_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       struct ixxat_usb_dal_res res;
>> +       __le32 time;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_stop_cmd Controller stop command
>> + * @req: Request block
>> + * @action: Stop action
>> + * @res: Response block
>> + *
>> + * Can be sent to a device to start its controller
>> + */
>> +struct ixxat_usb_stop_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       __le32 action;
>> +       struct ixxat_usb_dal_res res;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_power_cmd Power command
>> + * @req: Request block
>> + * @mode: Power mode
>> + * @_padding1: 1 byte padding
>> + * @_padding2: 2 byte padding
>> + * @res: Response block
>> + *
>> + * Can be sent to a device to set its power mode
>> + */
>> +struct ixxat_usb_power_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       u8 mode;
>> +       u8 _padding1;
>> +       __le16 _padding2;
> Nitpick: you can also do:
>
>            u8 _padding[3];
>
> This comment is an FYI, if you prefer not to fix, also OK.
>
>> +       struct ixxat_usb_dal_res res;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_info_cmd Device information command
>> + * @req: Request block
>> + * @res: Response block
>> + * @info: Device information
>> + *
>> + * Can be sent to a device to request its device information
>> + */
>> +struct ixxat_usb_info_cmd {
>> +       struct ixxat_usb_dal_req req;
>> +       struct ixxat_usb_dal_res res;
>> +       struct ixxat_dev_info info;
>> +} __packed;
>> +
>> +/**
>> + * struct ixxat_usb_adapter IXXAT USB device adapter
>> + * @clock: Clock frequency
>> + * @bt: Bittiming constants
>> + * @btd: Data bittiming constants
>> + * @modes: Supported modes
>> + * @buffer_size_rx: Buffer size for receiving
>> + * @buffer_size_tx: Buffer size for transfer
>> + * @ep_msg_in: USB endpoint buffer for incoming messages
>> + * @ep_msg_out: USB endpoint buffer for outgoing messages
>> + * @ep_offs: Endpoint offset (device depended)
>> + *
>> + * Device Adapter for IXXAT USB devices
>> + */
>> +struct ixxat_usb_adapter {
>> +       const u32 clock;
>> +       const struct can_bittiming_const *bt;
>> +       const struct can_bittiming_const *btd;
>> +       const u32 modes;
>> +       const u16 buffer_size_rx;
>> +       const u16 buffer_size_tx;
>> +       const u8 ep_msg_in[IXXAT_USB_MAX_CHANNEL];
>> +       const u8 ep_msg_out[IXXAT_USB_MAX_CHANNEL];
> Do you really need those ep_msg_in and ep_msg_out arrays? The list of
> end points is advertized by the device. You also have the
> usb_find_common_endpoints() to help you to find which end point to
> use.
>
> At the end, you only use one pair of endpoints:
> ixxat_usb_device->ep_msg_in and ixxat_usb_device->ep_msg_out. Why
> storing the other endpoints if used?
>
>> +       const u8 ep_offs;
>> +       int (*init_ctrl)(struct ixxat_usb_device *dev);
>> +};
>> +
>> +extern const struct ixxat_usb_adapter usb2can_cl1;
>> +extern const struct ixxat_usb_adapter usb2can_cl2;
>> +extern const struct ixxat_usb_adapter can_idm;
>> +
>> +/**
>> + * ixxat_usb_setup_cmd() - Setup a device command
>> + * @req: Request block
>> + * @res: Response block
>> + *
>> + * This function sets the default values in the request and the response block
>> + * of a device command
>> + */
>> +void ixxat_usb_setup_cmd(struct ixxat_usb_dal_req *req,
>> +                        struct ixxat_usb_dal_res *res);
>> +
>> +/**
>> + * ixxat_usb_send_cmd() - Send a command to the device
>> + * @dev: USB device
>> + * @port: Command port
>> + * @req: Command request buffer
>> + * @req_size: Command request size
>> + * @res: Command response buffer
>> + * @res_size: Command response size
>> + *
>> + * This function sends a specific command to the device
>> + *
>> + * Return: Negative error code or zero on success
>> + */
>> +int ixxat_usb_send_cmd(struct usb_device *dev, const u16 port, void *req,
>> +                      const u16 req_size, void *res, const u16 res_size);
>> +
>> +#endif /* IXXAT_USB_CORE_H */
>> --
>> 2.40.1
>>
>
