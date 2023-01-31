Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77E66832E9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjAaQlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjAaQlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:41:35 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425DF46D70
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:41:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZuvl0WXwcznynByr4NcglColIRGL+wRkeYNPbpNTKTFqoUm/JotKFulVA+/+Rn6lq+I8Bm27Ne4ApuNFfYFUKR/ncVU7YI+OGnVdqGKU1WXp4EcvsiGnbPWUXxBRME4hg+P/9HBu/gCqfWs4l3uWNztKkVIoWfL9+HTZmwxu+DNsTHti5yZqxyirN8G/MuIU3i/oOXAOxaAr5LjCppoC2wG4m0iQ5OpHjX+Jyj8meCy75WPT5NYXY2bhYMiuchwKX1BL2w4VzjUDhczDTUehb2Npf7oEvY3rXOQLe3Rjb2xiJn4U1lJEGyu9yfFjAOJFvRk6uy9jrkwdAhhI6GmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPGXZv3Z2vZowd5OYHZbKM6hUyicnKh3ecB4W2TGio4=;
 b=lzTTn9JvOusrIoPHg0pOKr1tWK81YqBXKrGkwQ88xSldrV4KDxLd+INJTi23dp9xv/k5dix8tG9z8QRiWftpCMdKjT1SI9ROrW8IVOoKycxT0Q43e3Dw+dcLQ8Xv1sM0q4VY0smnRH5jDst88FZ3BjrjZA/RDdaB3Wyy4SRCP5ee6Z2lX/f85Zsaf2zxwuuezftZAsrbZIBUVJwY4rlDUWtxAVM/1Y3dl4q1YsQCzuft6zXMrsCtLW3ufY3mTIeoG3ARHUeq46FNsabUZtYUaeOPGcKkpjR6aRS6a+Ic5Ewn0jbYBPivjy2EpgXon6gBTNXRpjiHmQHiU4uTc/d5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPGXZv3Z2vZowd5OYHZbKM6hUyicnKh3ecB4W2TGio4=;
 b=t/cz62E8/xWF6qwYX4+uXUL+5OAV+WveEx3ZXaGb5xuqTxBa0VCW7D6jHr32pQDV0ZE4hgzoKHIzG3E09YcINVeD7ovQud6fZgnsSN/7AJlf33yyB+yr+dwjcJC35xjcQ2Y+U2sdWHC4xsH5pv+UmyQTDjUOb1H8n7a9SzCd3K8Nl63oy/ktHILjtedJ6dy8t1gp0hnk6u7/Q8tJestZdezh9v1CkfCMMsEqBFgpRloMy+WW0w0CvcmsaWbQwPsDcrVyihfaclco3L0CHRtx2il9j1OLhiHHTgp3C7ayxDb9f+YmmmhCi9+NM3UY0wbBWdYVwEbWIBrHkIDFz9isYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:41:28 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:41:28 +0000
Message-ID: <d0cef09a-a440-d61b-b541-d3d040a295cf@nvidia.com>
Date:   Tue, 31 Jan 2023 10:41:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/5] genirq: Allocate IRQ descriptors at boot time for
 !SPARSEIRQ
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-3-sdonthineni@nvidia.com> <87mt5z12t4.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87mt5z12t4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d5e663-08ea-4556-ae7a-08db03a9ffc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZJliMeZvUwK22oGCc/odMtUPkbv8vfu2bRiADR2E416c9p1v3+QEoxlgezesyqZJCMg6ekAFaiq7+z56X8bhnrROYtk+SUropDbNhbesYriPWRYovyC+WSTnMbQrZnZ62OsR70Fgd07g6TUTI1arFWkJxzCgLDyhZ38A+m8dP4q3vglfHZDaovpvqKmCxIqWxoIUqNkJ8P4uzmZtTNEWVgHkATUJC7OOh8i6cSbRQRT8EbJQXXZDDPpGEN9Ohm/ki1i16P0Cjc0vXLzDXB88RVChVP8i46Bf7Him91is9dK7y5qjxDgri8lxNI6q4jfCe0yJwkAdWbfxq6VkgNsYDnv30cOTRtS/V1cjM2nRA4CfKe1mHQEnFmTO3tvoMvx6Io/FyedfPjFWc5UyL3j3d3VBS2ct2p66dJYdMxtyGN1nr7YELhgoRLrw3fu+vIUEV1thIbEzG1T73H35bss/DXDtR6VeyPf/Y13lnpO+PXkUSjqYR+WZGtuStKS1HcJaZj6WmGlbtCoSqgzuP5dfQ1aChvU5knyBjnaWsXle+SzjYhLfmgovS7HFJIb4/XUHDy7HA6yhANTRbxBmiu6OZigZomfM6jWrH3AYFlrflxJfDiWO2OuC4k5OHQDfveaqYMAsyfAxbDuauaIAcQUkyC/edNoIq+rZZ+W2mgxDxBq0nHZRyIEokzAj8RAkbKGr7G/Evaq18PyXaJmkt9pmdDI6biTlVDVSd16nH+QfKU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(31686004)(36756003)(31696002)(66556008)(316002)(110136005)(66476007)(54906003)(8676002)(4326008)(41300700001)(8936002)(5660300002)(66946007)(38100700002)(86362001)(6666004)(53546011)(26005)(186003)(6506007)(6512007)(83380400001)(2906002)(6486002)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ai9QK2xiYjJWZlJWRkdNQWlUWDliaERSTnVoeFJtMElmNVBYbHhwb3F3T2c0?=
 =?utf-8?B?bzZmbUFDQkFnTTVQQkZKRENQVWlIcW1LTXloTlIvcThWMlNDbHRMVlBIOUc0?=
 =?utf-8?B?YkQ0b2Q0ZHdhS2UxaDIwakZIMTgzZWNqamxGSUswT3JXWWZhYlYzK0w0Sm9P?=
 =?utf-8?B?THhwSzhtNWNPdGo3d2tONEJsYU9lTkozYzN3RzBFNzNGcnNvWG9STGdRT1pH?=
 =?utf-8?B?M1cyeExpYlVqTUlPL09lYVlDN3NFT1FyMkZHUU1qZG5OdG95VGd3NXF3cVhP?=
 =?utf-8?B?L250TW9ZdEdPeDdqb1hESlN6V09UMXpiRkRUcjM5MUJqVVpwUUlNcVh1VnZ0?=
 =?utf-8?B?VU5EOERUSlVVUTRKc0VOV1VvTnFmazA1eXdTVzRhT1Bra3JpS2JvWDhvOVBB?=
 =?utf-8?B?OHpwVy9tNHlVVHNMVjZGbXdveE0vNDR4bHFPZDNnM0VxMFl2bnhCanEwMm4z?=
 =?utf-8?B?MExtelBOQy9EZFZaUzNSUjdkZEFYR3JNUXVQNlJuL2Rwa202Ukw0UEhFL2x6?=
 =?utf-8?B?VHdrU2laSjBDUXVJbjNaMkloNU8rZE9jSnJ5bFJ4Rll5YUZXTVpJZVRqY3BJ?=
 =?utf-8?B?ZlpxWmV3NUdNTG1keW9Nc0hwenRRMzhuWERYSHdYejZGNDVTQTdpUXdqVzdp?=
 =?utf-8?B?WS8vd0xaOElRcUJrYWVVak9yTkdZNUV0Q2lxcGNxMUZLOGhMUitRVUthM3F6?=
 =?utf-8?B?WWdVcEMyOTA2SHhGeVJJN3lvNFBINUl6RDJNZUR6N3o2clBFWWcvRmpZNmUv?=
 =?utf-8?B?bmwzTTVOTk9QWGpNN3hrL0FWS1puT2doMnlubHNEMlF3WTFDcDBtTk50dTY1?=
 =?utf-8?B?QUU2MGdhNDMyUXZjU01oS2FibFY1Rk9mMTQ3a0ZuM0hwdWhQemRnRWlML2hh?=
 =?utf-8?B?bnpISEVXNVdSZ2JQVjVVamxEY2lNK3R2MFNlVGQwMTZVdWxnUmJkeEU1QVox?=
 =?utf-8?B?MU43dmpjcGtsK1hkNDVtUWduRm93SDZVakJRcXZOUFpuOVFyOEdOWE5oZndt?=
 =?utf-8?B?ZlhMN3QrUTJ3ckY0ekhOdGVXWnhTZXJoeEpuQlNjdUpBc3d6cmRaeWJyM3Rx?=
 =?utf-8?B?VENpa2NXejhwdWFkUzhPMlQ1Vm1xWUhCVTl0c1JPbXppcU9qak5xZ2ZuelBi?=
 =?utf-8?B?b3kwZGowWTBPYzJkYmR5NXN0cXpXejBwdVJKUzdPeWxtR2lCTjZGeGtTUjc3?=
 =?utf-8?B?RXFDR1ViUzlCTzEvemcrUHovL0p0TlQ2QnVtRkg4QjdxMEYyUmo1U3RLZzZY?=
 =?utf-8?B?d0dhQmRueGdjaUtVS2xjNHFiU0hQNGg2QXkyM1A0VmsvTE9BUDJXT0xwSjdj?=
 =?utf-8?B?N1dUR0hmN1VSTDJkOWtQbWVtMDI1dE9ZWFB5T1hTVlU2MFcwbEIrRGNUTytC?=
 =?utf-8?B?a1F5L0VnSENKQk1idlhqMTBSNUNCR3ZxQ3YzSGltRlRvaHNQcElCekNIRVpN?=
 =?utf-8?B?U09RU0Zyb2NKRVBjL2dFVE1Fait6N3dsU0NPdU9JMjJPL1NOdFJ6Z05lMVAy?=
 =?utf-8?B?bysvYmZxY0I2TGZzTUErMUFNWW92TlJGV2wraW9peGN6V0liT1plSDFvQnRE?=
 =?utf-8?B?ek5BZ0l0NE5tY3BMQkRqY1RjT09vemZ0TU8vOTlJaGxwVGx6Yy9TZDBrU1Q3?=
 =?utf-8?B?bUJnV084am1ML0RmbmZIWjM1UEJqcE1Na3VWZDJLRnV4cTdCN3ZzUi9TN0Uv?=
 =?utf-8?B?d0pISjJnTjgzUVlUU0d4aVRPRkpxdlZpOGtoVkx2NTZOeS83c05NbHYycjZq?=
 =?utf-8?B?UThoK0d6Ty9rbjgzVEc1Rjh2VTN4M21tOFoxK2ZzeVBNV2NMNDczRmY1RklD?=
 =?utf-8?B?UmE2bk1rRUg2WWxmazZuTVhmaHFsOW9MOHdRYzZqU01sRFlGMGVBdDZOcUtt?=
 =?utf-8?B?THA0eFVaNi81WElMcVNwT2ZvMTA0UzRLSmZEYW9HQVQ5eWNWdXh4Tjdzd2x0?=
 =?utf-8?B?NFIxaGhETGJWdEp6TllreWZJTEptekFoSVlhTnptNkJ1SElSQlprZE1LVXBr?=
 =?utf-8?B?QUQ0ZjhzSUJXazZWUDhyZGZwdHdYNnlNNFJwWDB2YjErZzA3Si9FUndQdGxn?=
 =?utf-8?B?UGs1Z25zSG1PbTU5TGpHUkd3NjZaUU1pd1VrY2tiYXluZ2Q0VTFkd0VtL0lF?=
 =?utf-8?B?dnp5eVZ2eVVTaDNZMzRSVUo3WHhOZHZRUmxndmc3QlZIQUQvVEw5enY0RWJi?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d5e663-08ea-4556-ae7a-08db03a9ffc9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:41:28.0397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dn0xloG9mbXKtMbje1xcmEE7XGP6g2BItz5m8uFz2HSOS4q8npfq0KsDihXX/MgBEJCgLJc1rEsQ1YTk52CvQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 03:16, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
> 
>> Remove the use of statically allocated arrays for IRQ descriptors.
>> Instead, allocate the necessary NR_IRQ descriptors during the boot
>> time in early_irq_init().
> 
> That's not what I meant. I was pondering to remove !SPARSEIRQ
> completely.
> 

It's touching many files to drop CONFIG_SPARSE_IRQ=n support. Worried
about removing !SPARSEIRQ without testing on legacy platforms.

Can work on this after moving it to maple tree?

  arch/arm/Kconfig           |  1 -
  arch/arm/include/asm/irq.h |  4 --
  arch/arm/kernel/irq.c      |  2 -
  arch/arm64/Kconfig         |  1 -
  arch/csky/Kconfig          |  1 -
  arch/loongarch/Kconfig     |  1 -
  arch/microblaze/Kconfig    |  1 -
  arch/nios2/Kconfig         |  1 -
  arch/openrisc/Kconfig      |  1 -
  arch/powerpc/Kconfig       |  1 -
  arch/riscv/Kconfig         |  1 -
  arch/s390/Kconfig          |  1 -
  arch/sh/Kconfig            |  1 -
  arch/sparc/Kconfig         |  1 -
  arch/x86/Kconfig           |  1 -
  drivers/irqchip/Kconfig    |  5 ---
  include/linux/irqdesc.h    |  8 ----
  kernel/irq/Kconfig         | 17 --------
  kernel/irq/chip.c          |  5 ---
  kernel/irq/internals.h     | 10 -----
  kernel/irq/irqdesc.c       | 88 --------------------------------------
  kernel/irq/irqdomain.c     | 14 +++---
  22 files changed, 6 insertions(+), 160 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43c7773b89ae..d4fc6c549660 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -134,7 +134,6 @@ config ARM
         select PCI_SYSCALL if PCI
         select PERF_USE_VMALLOC
         select RTC_LIB
-       select SPARSE_IRQ if !(ARCH_FOOTBRIDGE || ARCH_RPC)
         select SYS_SUPPORTS_APM_EMULATION
         select THREAD_INFO_IN_TASK
         select TIMER_OF if OF
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index a7c2337b0c7d..6d4ff82c40cf 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -4,11 +4,7 @@

...

-#ifndef CONFIG_SPARSE_IRQ
-#include <mach/irqs.h>
-#else
  #define NR_IRQS NR_IRQS_LEGACY
-#endif

...
# Make sparse irq Kconfig switch below available
-config MAY_HAVE_SPARSE_IRQ
-       bool
-
  # Legacy support, required for itanic
  config GENERIC_IRQ_LEGACY
         bool
@@ -107,19 +103,6 @@ config GENERIC_IRQ_RESERVATION_MODE
  config IRQ_FORCED_THREADING
         bool


> That allocation does not buy us much.
> 

Agree, not much value other than reducing kernel binary size. I will drop
this patch in v2.

Thanks,
Shanker
