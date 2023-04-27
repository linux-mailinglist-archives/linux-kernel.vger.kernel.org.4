Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F846F0C28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbjD0SyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 14:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjD0SyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 14:54:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EE40C6;
        Thu, 27 Apr 2023 11:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKGk2BYkRHTc6nbVd0Nlx/nNcGurSSmdS6NyS1DG6lH/9ee6U+0N/1VSyFqJ2ivWjKbbkM06+Mxza01zPKTwC3hEXWzPa25W+FiohITkRrqQsuIGjIonE0hJiQBiK3kUlEmK67+tYjbpEgvWsgwXu97ONIqAhd6+9ImX3Ci/Fuk+qSWUxQYzcqxq7JxD7BSeEM7iYncWuxXUmdCIS0KbgPCAuOiqJ2m2GJtxl05fbHErcNz0/Y0Qz9fx23dYFOg27Ms5wYFOI20teDYbOb6SmAZ58UGMOrxN5uRnTlj/2kpUcv3dxdAfhbshp1Ah/fOpkl4sRhq+3gXTYO1y9s/Mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzK5LzBT8iRga07xn4UCQQkMHBvzH5qIctZz4zFV8+U=;
 b=eJZtlKMeeaMHKuX7zmQkp9b4dj8SM++fIVkDyge0TYgDuBNejqo40zpbmD/2+BTqxq9LXSqcFRDjyeXzbNz+cjWtJqLTt7XEvaGOYo7CbJfWKUMFbE2orTX71dY/ZWQLs8HHP7JHWezwddFD9Ec4Z3ituakEjBNqp5jq5m3rycQeY6tlUHeRpdVYmyDvwEgXjDA+SzD+qcR6gM8XFkBYV6Oj0LuB3SbqMUPbSRYRWuFY88qykxEVTHeHx8TaMbSOgNU+GYFkT4zEyCgDcFJVEt9hQ9x+Dmd/tU642mRK75hOJ5ey0T3Gtr72LlTaIGY1sUQPmwhDlOO82RzsjsKiXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzK5LzBT8iRga07xn4UCQQkMHBvzH5qIctZz4zFV8+U=;
 b=e93xYtGUWWKVE7cz/Z3l3/iXVMdSh+N412q6ZNwXhOqlK07SWcv56SNGmWuByMJac/+bkhPJeUxKIWZYlXjSqwEAtSGUdsFJwTWhXROWHqRePMysbJSLvpBr1MOBvwx65iAcvPQw4uIZg0qh5F1h3z99GI9MH7YRMnyxElRdAZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB7231.namprd08.prod.outlook.com
 (2603:10b6:806:18a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Thu, 27 Apr
 2023 18:54:09 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::d2d1:7af4:ef32:542%3]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 18:54:09 +0000
Date:   Thu, 27 Apr 2023 13:54:07 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix freeze in lm8333 i2c keyboard driver
Message-ID: <ZErEz57E1amWtxa7@nixie71>
References: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
 <ZEf0RYdD5jhE9JEk@nixie71>
 <ZEmwsViIjUVPZ4Cd@google.com>
 <ZEnBZs9VYxriT1Or@nixie71>
 <CAH2-hcJa_vL9iWTARUAD+adrvQAjzr1N4bQ=cN+8kbE0arVwZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcJa_vL9iWTARUAD+adrvQAjzr1N4bQ=cN+8kbE0arVwZw@mail.gmail.com>
X-ClientProxiedBy: SN7PR04CA0162.namprd04.prod.outlook.com
 (2603:10b6:806:125::17) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb6dece-e1ca-4e2d-4135-08db4750c8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gaiO0XfmTLHkPVvciJv/zKz3pURI1bXKOZHkJjpfq34j7kPrjLKp0RDpb9c/Cq0l5cAUFB8ZyiCuEn18a5JBOuUoynMag3ptLKYp8Tq6BrD1BS7HoRpc29j4fGEIC48qKo5xfnzDlCQplIXH/leMtBiy5rWRLvM+XcaXVw9mSwk7qwFRxlXTxZ0gipR0vGLjPdEtu/L5HOzIR3lG+Xp9nSvDFGvtaO1KwKiDO4Sxxz4d8cvmKxWRZmVouTBL12foheFoL/+q8cg6XgAjCfIMlIg+cYylq2R2j5rBPOPSX8Vmlu7IsF5ZuJ9M7J3tAchKcq20XbAo9QB23teVCPefiifBDTr8X+ekjzMDziWeKo+hbuuE3GKBVNPYLhE/Q09WN0vj0RJom63eZtlH2jODU0QVKLrWo0WDOAnqJa5Ud5lxcRTQ17AfpsUG/6TUKGGBD47GUKNK4+KXGI8TlYKoojRSl0D6+JG5wBrJVxeNJW14kFZjpBdJASV9ch5cLtKY3RR+U4k3DkYRDX+pd4uP3CXu4EgK7JcrRo9Ukvjf3Ar52TELynIkkgRpmNKP0io
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(346002)(376002)(136003)(39830400003)(451199021)(33716001)(83380400001)(9686003)(86362001)(6506007)(26005)(6512007)(6486002)(66574015)(478600001)(316002)(66476007)(66946007)(66556008)(4326008)(6916009)(41300700001)(8936002)(8676002)(2906002)(38100700002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUMyY1U0SFphd2VQRm1MV3U4ckhXdnpTcEdlQlhlZ0NhMlA0Sy9FTmZ6UUpF?=
 =?utf-8?B?eGxUYmhycHQvdmgwSXFvT0pFR3dZSWVtcTdBOFZqdjhpbnFjcnZPdVl0dURk?=
 =?utf-8?B?MFQvQU5SaGtXNnZWS0ZXOWNrYWkyeC9ESXlETlNBYnhuaWdCYnM1OW1pQ2Ez?=
 =?utf-8?B?Qm55alhTS2hscXVoSSs4V005MTgxMGJqQVdHMHVIcmhsVzlpTTVXOE5EeUFM?=
 =?utf-8?B?Um9KKzJRMFZoTXExRUw5amxjK3BMZmpqNDllWFkxS2FUbThPV0RKYlhmcTF4?=
 =?utf-8?B?cmZ4S0pNQjV0NkM4UEk2bmpCUXdqUHoxTDN6NDFRdFNhQTZ4V3lBQm52VEJQ?=
 =?utf-8?B?cm9yWDNZQzB1eHY5WTJkcFhhaFpVZlU1VFowMGZYZERKS01rTWx1a205dDV0?=
 =?utf-8?B?S0JVU092Yk8ybVBmWkp2Uml5V0l4NWZCandQQ0F3cmlWdklZL2F6T3Rob3ll?=
 =?utf-8?B?RU1RMzhHOFlYVm1pRTNzUURjYUNHZUlOd2xWN2pzWllkWm5tdDNTWUp5c0xY?=
 =?utf-8?B?SFhXV0hhcStvelBBdG93R1R0Z0h2THNjcTdwUmtWRVU4L3JSRHdOaFRuYno3?=
 =?utf-8?B?TjZtUnUzSGljMXc0Z3lhK2doOXJMOHhDT2pDTElzQlBtUmdpSFR1NnVEWEox?=
 =?utf-8?B?NDEvc1VsU1BFaitFcGJKMHgxWUMyb096MHhLRlE0elhwdXdQUXdITjFhc2d6?=
 =?utf-8?B?UW9GNEV6b3pvbnNqeGNNTTE3bTYvdEpFQnZUSm1QS2RxdTc4MlNiZVJKMWJH?=
 =?utf-8?B?VmNMaHBtakM4UDdtM0dEakIzekhRNVRSYmg3cWhsclgwaE16Nk8wcGVKUFlP?=
 =?utf-8?B?LzF5cFVSODBnMUxEdGNzanIzTndyZHl1WFhYQjlXc3JQQnpLL3RVWER0ckIx?=
 =?utf-8?B?Q0tiVjYwUSt2U2NmcWs5Q3ZXdVcvV2lRNkg2SFJGYk9xc2NVQ3l5c1EzdG0v?=
 =?utf-8?B?WXB1N096OHBLY2ZEc1FKYTFrOU4xaDEwTFp0SlZGcHhDeDlsbGphUjc3YVF2?=
 =?utf-8?B?Z1NvV0dPc3hQZGthMTgyaDNmem9CY0svS1B6REtvd3pDVUZBSURnMDY5cy9W?=
 =?utf-8?B?OFU1R3F6MXB4anZOQ2lOaDFUVGdRQWpLY0cycW11NnZ4OEp0YzQxZDFjNm5u?=
 =?utf-8?B?bGpaeDU4T0ZRbTNvNncxd1VTQ2ZuUzNiRTFFa3F0dGZaRExHeGY2Q2FqQVlG?=
 =?utf-8?B?aEpEd3lxaTFFTVpNcGJnRzkxMUFicndTdkdCUm5ESWFKTVJRbmZsNXBzb2JL?=
 =?utf-8?B?VHdFZkhRQUx6dkJEOGxEcW9FV09jYnBRL1Bjb2JtSmpIV3ZQcHBPcmN0aHJD?=
 =?utf-8?B?Ulo5bTdlV1JWZTJibllRdS8xcFNwcWRaQmFiZVZmaXVwd3BNQzcyQzN0cTNo?=
 =?utf-8?B?bUFLN09yMVRMbzZTQmZYTFFHMjQ5dk1UdUNSclNXclZLVHU3SURJYVdRUWZU?=
 =?utf-8?B?OTdMN3ZlSVVtMkdjOVh4bDBlSzM0akFqSndTSHNHbmNpV0xxd1ZuNVpMRVRV?=
 =?utf-8?B?NkxCaG9xVDljVWUvaVdUMVd5U3dDRFRYL0ZGQVpYdHpidmtHaUxtTmxUZ2p2?=
 =?utf-8?B?eDRnS0JrdzdWaGo4WS9OQzJLVXhPYnVQU3Fvc2ZhczBrSlpoOFIzMHU0ZFVr?=
 =?utf-8?B?cmMyNzdIcS9iTGpyRGxFd0t5b29PM3dPcDJSKy9kVWJxMWZvZGREaEFkZ0My?=
 =?utf-8?B?S2dFMFVKNnN6NUVMRS9jVnBzZmhscE43R2xIdTZYSG1Qa0NnOGlKZWpIaFZ4?=
 =?utf-8?B?YkVHWkVHQ1NUMmErL0NoRTZERDhyalFtdHZXN2pXSlhXenJwNUhOL1E0SDYr?=
 =?utf-8?B?R2pQVmhDQ1lqYlVraU1JSm1CUThoRmZGSnFGQUxNSHFkMFRlZ2lubWFGdUZx?=
 =?utf-8?B?b1hQOXJWQlpxOEc3MzhsWThnNHNaZ0dCUzh6ck10NjFsMU84LzF3OWpjSEtQ?=
 =?utf-8?B?ejRCNlNPZkt5a1FRL0ZTencxMXFjUHBROGVUOFg5VzcreE82ZENESEYzTDVD?=
 =?utf-8?B?V083SW9oNXVYRno2cGxvbDV5Q2N2S2gxWTg0L2lpejNXTjdpSzhQcUE5NVR0?=
 =?utf-8?B?MlhXMWZoeWwxYmwyc3RzdGZiaHlMMFZ4Ylpic3BaNU5SVWFTRWxsWlFPS3RK?=
 =?utf-8?Q?ZvGKrinmeWDJso5gN2Z+yMowx?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb6dece-e1ca-4e2d-4135-08db4750c8b7
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 18:54:09.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9XcavtQSR2zMhxazz4OFd6qzOrqN3Yl7sbRafo1yGg46OLgqeND7Wm7eZXfiKLk02N5e1Di8MP44cqiFWlCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7231
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas,

On Thu, Apr 27, 2023 at 10:19:38AM +0200, Tomáš Mudruňka wrote:
> > Yes that's correct; what I mean to say is that depending on the nature of
> > the read-to-clear mechanism in the part, there is a chance that the IRQ
> > has not been deasserted by the time the threaded handler returns. On some
> > devices for example, the IRQ is not deasserted until some time after the
> > read's stop condition.
> >
> > For these cases, I consider it best practice to measure the I2C and IRQ
> > lines on a scope and if necessary, add a small delay before the interrupt
> > handler returns. This is especially true for open-drain interrupts that
> > may need a few hundred extra us for the pin to rise.
> 
> Well before posting the patch i did some testing.
> I was watching the /proc/interrupts and checked that IRQ counter for
> lm8333 matches number of keypresses.
> Which i've only tested for like 20-30 times, but haven't seem any glitch.
> 
> But i still recognize the fact that the gpio line getting stuck for
> some reason (short circuit on PCB?) might cause troubles by
> unnecessarily loading the CPU, while with edge trigger it's more
> likely to affect only the function of keyboard itself rather than
> bringing down whole system. But i am not sure if this case is supposed
> to be expected and handled in SW.

In the case of short circuit, the hardware has failed and there is nothing
we can do.

My point is that different devices deassert their IRQ at different points
in the read-to-clear operation. For some devices, the IRQ is deasserted
immediately after the register address is latched, so we can be confident
that the IRQ has already gone high by the time the I2C read operation and
hence the interrupt handler return.

On others however, the IRQ may still remain low for 10's or even 100's of
us after the read is complete. In some cases, the threaded handler could
have already returned by then. Since you did not find any unexplained IRQ
counts, perhaps that is not the case for this device.

Kind regards,
Jeff LaBundy
