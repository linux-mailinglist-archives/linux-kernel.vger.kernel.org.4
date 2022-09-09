Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC875B405E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiIIUMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiIIUMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:12:35 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A580B7C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqbId1VWPSZCiq/47u2hhpsTeK3a5oxyRFRJshG4G5SlvkC4xAIiRacFzxwjCBV2xfBEz7euWUAajkyF29xMnA5NUUipBg85wtChy/LwI/ZuJWYTrMVHL2d9d6zdOdT3/LFy1Z4SxsREmcv7GKwCg8ufmIwzSz2djvWRavZmFoQgszBqYmBHL3tbESL8xbkCN1UQfFL+wl6y6552ap+PTMKnvzCOuAsAHciVpq/RoB9/gsXW7TB/UWlKmyR3MS4Xevtb12XmQPdr3fixdYPqehvBHAlSe4O440jF3YStMoOjARqvMv33/qCtyYGLxhNFt9eBDwMpJoMeBckzX2vZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDGY7/YhZbK5CyPYwFmuxWjA5me3qI1iI6yZQjuUDgE=;
 b=ofMmwGKwbXTGeVVeSqOgkShj/RAd0aPflk3hA8GkFHWk3G6p4Sqhb8kqo0BGyi1ucBUh9CzN3eAGcW8gl9Se9Ujwzmol0IRrNhryaHjx6pkcqHHQJdmrKL3n9SZ1xjgJS3iMMxBwJkevBb+So91qBAA5SMF2NTmzDCqQSUDJBwdWxLFNXA5BdQqJXcaPEx7AbQ2QeN77a1zUM8ouobFuq1d8QN+HvwGRzsRVnCaK7WFLpmO/d3yWPdCr5yHYQJil1ZcJF6xqnVmx83bBe3T3OD43ddrKVXiwddOHW6ga8IQuMzTx8qE8rZBhjoJeWBwu8W92rs+aoRS3HHAF+rD9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDGY7/YhZbK5CyPYwFmuxWjA5me3qI1iI6yZQjuUDgE=;
 b=dIGaP2wYX6udWZrGDfWN29BzrB6kBd1u6zd0boe1P9dZCCvNzE3ScusBWXVNMhnuKGoVhV+7dRXjYgcwo/btuKFCGcE+6mzGDeyPeZahI6uy1xOdBSsCUkMm35YfmslSFJXVyzfQBOLddHsx/r+e7RWh6nLaUT2y+8GaBnP/wpMYVXzVQLbvs433XB1uDkLYuh1BmXf3y9pnO8dqbd+bjoCH8bFY454UhT3/vDx0T9TShsSdYRqs5a5/oITQOPGOWcck5mOVfWuS/leyO7LWTkCGnwzfe6knuck4IuGsKNlwWN6C1+fV/ouWXiiY5lqwhAJr/k2ymp27wGjhKy4L6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DBAPR03MB6549.eurprd03.prod.outlook.com (2603:10a6:10:19b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Fri, 9 Sep
 2022 20:12:30 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2%4]) with mapi id 15.20.5588.018; Fri, 9 Sep 2022
 20:12:29 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v3] md: dm-init: Wait devices if it's not find on first
 adpet
To:     Fabio Aiuto <fabio.aiuto@amarulasolutions.com>, agk@redhat.com,
        snitzer@kernel.org
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
References: <20220406154631.277107-1-fabio.aiuto@amarulasolutions.com>
Message-ID: <7442e695-654a-59c2-e3dd-710946e6cddd@seco.com>
Date:   Fri, 9 Sep 2022 16:12:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20220406154631.277107-1-fabio.aiuto@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:208:329::34) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5dea17b-e96e-43bf-65d0-08da929f9f33
X-MS-TrafficTypeDiagnostic: DBAPR03MB6549:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im216g86vJaxIw6Wuq4y1pvnyaOBfFxp96bGTpVA60wvWq+oJeY98E/7BO9s5NoVo9rPDDrYceM3NBqTJOpOdQj8iNl52HFNfHvYGPN7IDpbnzuwxHsBqrZCCO1vM5ofFbPWeG1/f04jHIfQ8qlp0RW3QaL4Y1pooBMWa2G+XN2GI061A9kVnwQxyRhee7MFhpU19FvTe99zofVEZ6Dj++dazt4GupuLLuD22HiciRTIqn0VNxndmNXS1Wa1XIBhgvs/bR1511y8UO+L50O5c83ABml6DIgHzYxbgeQeY92UY1qHJcUWcHPDf1GAzTm6BhQ3hSUf5abssFTYgIvlTlqI9/zUqqiANJqTEaNR67AVdhPgGqLNgzs2vsYEjMEVPY7iHWJB9K3C3LKI7qNRkED4bqvYfTHtcF9hYIm4o0NmQ2GyV1H0+REHAWX2udkmzPYTjNzXu6zciJ8RtRJOMc14HTBdOp79m+L+v0Dnxp7+AT6LHIxxc18Gd50I04fsg99+6F7Zfe8H1Xd/9Oi9emL2xJE2YC+zVFbIsdIL7VO76fTmP4ncl0WPFH5hB4kRhj0v2/UeiDKXK7czBYSZ8m00Gp3e3rmT7MeIxHzU2VjqCY/YO0xWiZTpRq5ptPsQrGBoQ3WRilD62kUDxnomDkZNMEz4po/uprdHe5OvCx6zlYw677UNNpSls4dZHPBn+X6MdOUre9iVRfJVr3mgWAKCtXl604mbSsu5OwQOQsdunNiKQoC05jt2X5l+eB2H+jxUzRWpYo3RhZc0V1sW8h352+lqGTlM66HoRAlsqp79DXu3rTQYRzFs/GSLLR0E36xkROiduAsmBIiHzcZirA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(376002)(346002)(396003)(366004)(53546011)(6506007)(8936002)(38100700002)(316002)(31686004)(2906002)(38350700002)(52116002)(86362001)(2616005)(6486002)(44832011)(8676002)(186003)(31696002)(66476007)(5660300002)(66556008)(6666004)(4326008)(478600001)(66946007)(6512007)(26005)(83380400001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RCtnYm4zQ1pLaG9vRFlQTnlJWHRETFhlMWVVaTQ2enV1aEJsbEJaMWlJZnZC?=
 =?utf-8?B?UFptVXh6MWRDNy96MGhvOHNaYkliTXVOYU5DQWxOcW5Zd21YMVJURVpTUzZo?=
 =?utf-8?B?NHhURDFPb0k1NkNWMnNmUDI4M20xZ0RsVUY3NTYzdDZlK25lZ3dIUVRvM0FK?=
 =?utf-8?B?ZEtuSWpQK3BDeXpqQ2s2bTVCRFJ5M1NNbVJjNVR5enMvdG1mUUhyNEgwTFhx?=
 =?utf-8?B?cWNZbEd0UWRZZzRDNTcwckovSllXSVdMUkZUSnZ5eUlRbnRJYzBPNWtsNFEy?=
 =?utf-8?B?bExnQTZvQmhrQWhyMHBzWjhkNHI5bTJLckNHclFRWm5FOTdFc0VwYlFENDJH?=
 =?utf-8?B?UEtWMFJMSnY1TytYZ2pLcXBkK2c3SEY4QU9FYUt5U0FJc2NpRXFNeXFBNEtz?=
 =?utf-8?B?MW9RdTJ4cVZzaUlrU3VnOWV3a2pCNlpnaEJjY3A2Z2pqMnBVYlF0ZWdwaFJy?=
 =?utf-8?B?UEdFUnJNQmR3SUZ5REtqdFdocGhpblVrSjZ3M2ZMWUw0djNrMVhSN1E0UzNa?=
 =?utf-8?B?ejErYUFlRGxScXh5VHlENnZsNzh2ZUZvaTZQLzgwcHZZaUxjcUxBYUFVTVQ2?=
 =?utf-8?B?SEpOSDNZand0UFRlUXlJSEZHOVRZSDIrWVNxVHVCZVJPTnQwZGRpdkkxUStK?=
 =?utf-8?B?YVE0eXhxOHFOakdTY1VhVzROYzRJUHFHTXBxQlZySE8yL1BsV3hDRjh3Y05w?=
 =?utf-8?B?bGRoaTF1d1RYYWNTWnNKME5MZklVNDNEcVlTTkpuOVI3SWlKTHFMZVJ4UExC?=
 =?utf-8?B?MFJHTTltMGxrYlJvbXpGUExMdnNMN2syNnRaVGZyY1lpL0dhcWJpN3Rtc2lJ?=
 =?utf-8?B?Y3ZOK1RHKzR3a0tMdlBRY080bUk1Ri9IMlIvMlY4TVVoci9LeFhEbHRPeGhk?=
 =?utf-8?B?Y3U4dDhBdTBuWWs2dzAwUER5QzdmSjQ0TXNVQ1c2bE4yejZneVBnc29ZS0Y5?=
 =?utf-8?B?ZW90TnpkcHBmcERnS3ZqVERIT0xUNVNSSTFnaFpPemFMVzRtMU41Rk5OZkhC?=
 =?utf-8?B?S3ZNSDRJaitzTHNPUkMxN1h1QmlFV0s2V1p4a0kzOW0wbmxwMkRvMWJGZlJ2?=
 =?utf-8?B?aGxpS3RobjJEd05sdjBQNURXdGwvNTBGODZmSmJkbzlxamlpM05BblVBWTR1?=
 =?utf-8?B?d1VqTjVRM1kvNXlMZyt2aGlPUjRCai9sbDlKa0Mxd1YzbFFaa3U1T3A4dWxJ?=
 =?utf-8?B?blB3cXFoUUNEM1pRUE1QRWQ2NzJoQ2JMT2REMVo1Q2lCd2ROT2VrQ2VBL3B5?=
 =?utf-8?B?U2EwR1NHZ1F3bGN0TmNVMDhHVGM3QjUrcUN6KzlzdnZFS1RZY2I2MTZ6R3Zi?=
 =?utf-8?B?aER5Sis4cXdvcFpVZythUjgzL2dCd0dEa0ZsT2RjOGorcEw3c0F0WHJjRy8w?=
 =?utf-8?B?QmM5VWp1SVhDZGhCUnBxeTJGMFNKalQvY0c0ekY0MEpoU0w1a1FlTDlmd2Fk?=
 =?utf-8?B?cDYrSTMyQWdSYW5EcG8xWncrSlRwTDE4bGRtNjBKRlhCTW9pajNIR0w3Q1Zl?=
 =?utf-8?B?ZjJsakEzQlgxc20wZHAyeUNNazdwSWlBWDBUcCtSV0VmcmFXcjN4a0h6QVMy?=
 =?utf-8?B?bWV3eERPQ1hsTDVzeEdvOU1xbURmQUZKU005bHlBTVZ3YjJ4dkp2NlNaN0c2?=
 =?utf-8?B?UitXZkFwbGJiQlRpaXI2MDkzVnZxV2l2UXVhRVJ2bWlRYUt2a1M0NmROZzlB?=
 =?utf-8?B?UThYRmNCamRVdlhwQzR1L3VEUHpNV242bkh0Q1d3S2VLSW1qb25CZ3NTdGV1?=
 =?utf-8?B?S21vM3ZUcTJveW96QVdlZ1NubkN1VkZsbDNrSGFmSVRrK2IzMkdtZ1l3bGIx?=
 =?utf-8?B?V2VRYlZvc0gwbnRac2ZLWnRac0lJNzlPRkc1cU9QMjBTRkFtTTZrQ0hONmht?=
 =?utf-8?B?V1BTdUZob3JXamhqY1dDNFYxVkVieE9TRTF5SWxvckJJNWhBeFYxZnhuRExq?=
 =?utf-8?B?bE16N0M2V2EyUGpscmRKNzByK3hZeVpnTmFoc0FiQXkyOHRFemlXbmozbEtT?=
 =?utf-8?B?U3NOdTkzWitjbEZmWUFaQmZGQkE1cERuNHlwdldCWno4Skl2MEhLLytISDRu?=
 =?utf-8?B?OWNvLzBjbnkzSGxtQW95NkZXdWJtb1FZRzZqTzJVL0F4STRjWlhhRWhhSXZl?=
 =?utf-8?B?M1Z1bEp4VEZxSDRrZytCbEg4ZTJESER1dHVMMC9nQmlQRUY5bi9rS0d1MXM0?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dea17b-e96e-43bf-65d0-08da929f9f33
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 20:12:29.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uIYged4Hmj1ag+FEZ7Mb6+lq/y4dKkpQpHN5LpcYa8dcc3Qh1UFMd+RWbNTQ8pNsuI/sh+bKgmcMcBQlsd1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6549
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into this issue today. This patch fixes things, so

Tested-by: Sean Anderson <sean.anderson@seco.com>

However, I think the implementation leaves a bit to be desired...

On 4/6/22 11:46 AM, Fabio Aiuto wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> The device driver can be deferrable and can be a race during
> the dm-init early. We need to wait all the probe are really finished
> in a loop as is done in do_mounts. This is was tested on kernel 5.4
> but code seems was not changed since that time
> 
> 003: imx8mq-usb-phy 381f0040.usb-phy: 381f0040.usb-phy supply vbus not found, using dummy regulator
> 003: imx8mq-usb-phy 382f0040.usb-phy: 382f0040.usb-phy supply vbus not found, using dummy regulator
> 003: imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 5 mkt segment 0 supported-hw 0x20 0x1
> 003: caam-dma caam-dma: caam dma support with 2 job rings
> 000: hctosys: unable to open rtc device (rtc0)
> 000: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 002: device-mapper: table: 254:0: verity: Data device lookup failed
> 002: device-mapper: ioctl: error adding target to table
> 002: crng init done
> 003: of_cfs_init
> 003: of_cfs_init: OK
> 003: Waiting for root device /dev/dm-0...
> 001: mmc2: new HS400 Enhanced strobe MMC card at address 0001
> 001: mmcblk2: mmc2:0001 IB2916 14.6 GiB
> 001: mmcblk2boot0: mmc2:0001 IB2916 partition 1 4.00 MiB
> 001: mmcblk2boot1: mmc2:0001 IB2916 partition 2 4.00 MiB
> 001: mmcblk2rpmb: mmc2:0001 IB2916 partition 3 4.00 MiB, chardev (249:0)
> 001:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
> 001: VSD_3V3: disabling
> 
> with the patch
> 
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table
> 002: crng init done
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 003: device-mapper: table: 254:0: verity: Data device lookup failed
> 003: device-mapper: ioctl: error adding target to table
> 003: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table
> 002: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 002: device-mapper: table: 254:0: verity: Data device lookup failed
> 002: device-mapper: ioctl: error adding target to table
> 000: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 000: device-mapper: table: 254:0: verity: Data device lookup failed
> 000: device-mapper: ioctl: error adding target to table

For example, we repeatedly print these errors, even though there is not
really an error condition. Additionally, we still loop even if (e.g.)
there is a syntax error in the dm-mod.create parameter. It also
introduces similar problems to rootdelay, where you have to choose a
suitable maximum value.

I would much rather see something closer to rootwait (as implemented in
prepare_namespace). To do that, I think it is better to modify
dm_get_device or dm_get_dev_t, which are closer to the source of the
error. One issue is that these functions are not just called from
dm_early_create, but also at runtime. So we can't just blindly start
waiting for devices to show up if they don't exist and dm-mod.wait (or
whatever) is missing. We could solve this by introducing a variable
which is cleared at the end of dm_early_create. I think that solution is
OK. We could also modify dm_early_create to pass a parameter to
dm_table_add_target which indicates that the target is being created
"early." However, I think this would be fairly disruptive to existing
code.

--Sean

> 003: mmc2: new HS400 Enhanced strobe MMC card at address 0001
> 003: mmcblk2: mmc2:0001 DG4016 14.7 GiB
> 003: mmcblk2boot0: mmc2:0001 DG4016 partition 1 4.00 MiB
> 003: mmcblk2boot1: mmc2:0001 DG4016 partition 2 4.00 MiB
> 003: mmcblk2rpmb: mmc2:0001 DG4016 partition 3 4.00 MiB, chardev (249:0)
> 003:  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11
> 002: device-mapper: init: waiting for all devices to be available before creating mapped devices
> 003: device-mapper: verity: sha256 using implementation "sha256-caam"
> 000: device-mapper: ioctl: dm-0 (rootfs) is ready
> 
> Wait loop is limited to 10 at the moment for our use case showed no
> more than 4 loops before successfully find data device.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@amarulasolutions.com>
> ---
> Changes from v1:
>         - limit the loop to 10 iterations
>         - change variable names
>         - check only for -ENODEV failures
> 
> Changes from v2:
> 	- use a limit in seconds (not in retry
> 	  number)
> 	- add a parameter
> 	- update docs
> 
>  .../admin-guide/device-mapper/dm-init.rst     | 13 +++++++++++
>  drivers/md/dm-init.c                          | 23 +++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/device-mapper/dm-init.rst b/Documentation/admin-guide/device-mapper/dm-init.rst
> index e5242ff17e9b..5c2f2bf1db03 100644
> --- a/Documentation/admin-guide/device-mapper/dm-init.rst
> +++ b/Documentation/admin-guide/device-mapper/dm-init.rst
> @@ -123,3 +123,16 @@ Other examples (per target):
>      0 1638400 verity 1 8:1 8:2 4096 4096 204800 1 sha256
>      fb1a5a0f00deb908d8b53cb270858975e76cf64105d412ce764225d53b8f3cfd
>      51934789604d1b92399c52e7cb149d1b3a1b74bbbcb103b2a0aaacbed5c08584
> +
> +Delay for waiting deferred probes of block devices
> +==================================================
> +
> +Sometimes the late initcall starting the early creation of mapped
> +devices, starts too early. A loop waiting for probing of block
> +devices has been added; the default maximum delay is 1 second but
> +it can be set through the following kernel command::
> +
> +  dm-mod.delay=<seconds>
> +
> +This allows the procedure to retry the creation of a mapped device
> +after a short wait (5 msecs).
> diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
> index b0c45c6ebe0b..f4c5b4a46001 100644
> --- a/drivers/md/dm-init.c
> +++ b/drivers/md/dm-init.c
> @@ -7,7 +7,9 @@
>   * This file is released under the GPLv2.
>   */
>  
> +#include <linux/async.h>
>  #include <linux/ctype.h>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/device-mapper.h>
>  #include <linux/init.h>
> @@ -18,8 +20,10 @@
>  #define DM_MAX_DEVICES 256
>  #define DM_MAX_TARGETS 256
>  #define DM_MAX_STR_SIZE 4096
> +#define DM_DEFAULT_MAX_PROBE_DELAY 1
>  
>  static char *create;
> +static int delay = DM_DEFAULT_MAX_PROBE_DELAY;
>  
>  /*
>   * Format: dm-mod.create=<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
> @@ -267,6 +271,8 @@ static int __init dm_init_init(void)
>  	LIST_HEAD(devices);
>  	char *str;
>  	int r;
> +	int loopcnt = delay * 1000 / 5;
> +	bool devnotfound = false;
>  
>  	if (!create)
>  		return 0;
> @@ -275,6 +281,7 @@ static int __init dm_init_init(void)
>  		DMERR("Argument is too big. Limit is %d", DM_MAX_STR_SIZE);
>  		return -EINVAL;
>  	}
> +retry:
>  	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
>  	if (!str)
>  		return -ENOMEM;
> @@ -287,13 +294,23 @@ static int __init dm_init_init(void)
>  	wait_for_device_probe();
>  
>  	list_for_each_entry(dev, &devices, list) {
> -		if (dm_early_create(&dev->dmi, dev->table,
> -				    dev->target_args_array))
> +		r = dm_early_create(&dev->dmi, dev->table, dev->target_args_array);
> +		if (r == -ENODEV) {
> +			devnotfound = true;
>  			break;
> +		}
>  	}
> +
>  out:
>  	kfree(str);
>  	dm_setup_cleanup(&devices);
> +	if (devnotfound && loopcnt) {
> +		msleep(5);
> +		devnotfound = false;
> +		loopcnt--;
> +		goto retry;
> +	}
> +
>  	return r;
>  }
>  
> @@ -301,3 +318,5 @@ late_initcall(dm_init_init);
>  
>  module_param(create, charp, 0);
>  MODULE_PARM_DESC(create, "Create a mapped device in early boot");
> +module_param(delay, int, 0);
> +MODULE_PARM_DESC(delay, "Max delay to wait for data/hash device probe in seconds");
> 
