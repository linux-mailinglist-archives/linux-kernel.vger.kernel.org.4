Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865C6E1CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDNGrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjDNGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:47:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72BD6A6F;
        Thu, 13 Apr 2023 23:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxDfFn820y5dDBJ4iO9lXCaj8doEI2XuqLR2krCn4IZ7mtyFriMIRrdpCExVwCCqASeb4fczR6M6kStR+x/Yw/mt5j3AzlEyHrujSD73pzZv33fEGECan9vxD4F0CEevU0CJLg5drExXNBpH4GoDnN2hGlF3RGumEnUcPkTXbNQWXVQKv0B6hNaG+GzLyNwFCaKA9qImJuPCFwfy4zPGKepODkvmONY88BVmf0uJAaxZ1irIcvuS4QjdaMQDNhau3ogHyO1BxZ5WjfW+I0os+lgsKJ/n5b1wrLMBrHEKoYNw0WpAOSLW5m3x0N99hevA2eXNdHnNFKyL3hh3KhTaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwByKciOWQoBcuB9moOny6+AA5qLETUTS9x8XtchxHA=;
 b=JQPDiXK5yjO6M9tvNMlsAyoolJtNXau4Pd5Obx1xjiQTIVfftj23WY+oGME2VvK8KFUvblPAYHignAS7shjFvJfQS/eXoR9CiItJ3hJesW5zSuLel4rHqOXUhIQcxzaVj7lT8a/llwvANlqySl6a6E6wsvJpSv+sqIKFwvZWZxqoPRUAceouLz0RhQYydihgfL0/c3qK4SznlIBAvnFxC7BPAf6lDbsV+F5NohVBhfdxlpOE/VTn/8xegflIlqS8ATkHsXQ91+agreu6jmT4ermYWrtaZon1ihV5seJ7TqLQD/4JHQ1sPYUUN6hPuUr9G/3Xe163dMGq7GZs7lZywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwByKciOWQoBcuB9moOny6+AA5qLETUTS9x8XtchxHA=;
 b=TwROAcflz9AxRekEYTeqQKRLlE7LHoujnWgqi0OPb19jACO5fqZUwUg/x1krIQcodvLKHWQDgIDYSAxALVSOf05YtB0AjGaBbbE44iCdr4rLJ6+8B5SolJKKnL2r8gFq4ZlbPuwmPeZ1EoSHQ0XH1VuErn4i2Gm0cpa0L+GFKY3UuPoFMqIbMzcm7qzAaDIX93rIiP/b3oNgmHsIiQm91rK4KCZq9H0nPgcINVSSxYjoYbzeu3FlcCsLx4deeaVhz6ioIsAhTCAiwOD7HxEtzPtpB9IVlEJ545kCLssNiwXv858wAQLCbAGlvu1d2l+ZEzMoglZtX8/16givZRdc1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28; Fri, 14 Apr
 2023 06:47:38 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%7]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 06:47:37 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] HID: shield: Initial driver implementation with
 Thunderstrike support
References: <20230410170840.16119-1-rrameshbabu@nvidia.com>
        <20230410170840.16119-2-rrameshbabu@nvidia.com>
        <20230413151621.py34io57wcrfofo2@mail.corp.redhat.com>
Date:   Thu, 13 Apr 2023 23:47:26 -0700
In-Reply-To: <20230413151621.py34io57wcrfofo2@mail.corp.redhat.com> (Benjamin
        Tissoires's message of "Thu, 13 Apr 2023 17:16:21 +0200")
Message-ID: <87leivhse9.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ce70d5-b671-4f0c-d62c-08db3cb42277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLJXwJo4AQQTO1uIcaxFW9RHbx+/GYCpy6+DsztFJreW5CKhx+tREWzJkYzVONhPr1FYR4442AvBYCfNEwTuN5fda/rMhKo/EBuvRDX0MbBtTq3tSiP8v8VnlJC2d7xlTH/zo2thQHJlJ3AgUBPJru9LclUdBlnC0MA52AwnQqmZMlPisuRLaAWdp8PYmE+zP65CxN7XwRwMbG7eATbpgEO4x0neivHpUa2OfO8qbku6HCkj7oulN+roBwiBQEovTADBcIkNUFni62hYlkZgfMlOnuHhLhF3U9fSyFY5fq2AKav1MHrtJAobggctEI9/aGiPaBC4J9xCOgjcMjIY5hca88HXRdLO4KwigYKpCjMcgh9MknEsLKEbaTVzIcBvUQbiv/wm4X8lctcnXUMXRQuJ1XLUKMqtpQE4Y/KZ7q2VUrsynk7j6WIwr8G4vu7d2UfdPPqOPnwVDSIfWuZq0y35DJqXA24rHZTKFHQq/DYRZcmPZ6eYfKUWfL/rJlUdfqAcKU/4D/xlb11NVv0eLHamKfVtROnFnk2IRNRKl3ZT6HrZxG2jaPDPzOJTzpMX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(38100700002)(5660300002)(36756003)(86362001)(6916009)(316002)(41300700001)(8936002)(2906002)(66556008)(4326008)(8676002)(66946007)(66476007)(2616005)(6486002)(26005)(478600001)(6506007)(186003)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WIY+o0zLVrQDYCQSbBGfkzLIKlsAzx+VpLnkuLjzldAOviJEFv4vTdeYbFl?=
 =?us-ascii?Q?dohJ61EqMuoXOiUUeuN/UD7g2dw5GXvJdWzn3nGMJQMY2Zz4dhQjvcrSTxQS?=
 =?us-ascii?Q?QSlPvgVdv+DlcBh7JVRgxpGrNE+Cam+MZQaU89epmWRWa5ND2K1zCadd+unq?=
 =?us-ascii?Q?RiybZ8TA+26WNOO6BdgtFK2iO8X+hl142BlK4PrQga6w1qJvqkhu4KyQoxjY?=
 =?us-ascii?Q?MIUewWXJNs+KCt8S5Bwa+2nzjlWGkfVVrNpiML76BP9HuHu8thU8ORWaWwGC?=
 =?us-ascii?Q?azT3+I0zX27ZzKWohM++POzBjN1XMC1dqfAzpweJ9AZZZmMdKzkVjPkUHUgz?=
 =?us-ascii?Q?fqCRJ0TMwCZOqMZrRLLfsGvzWUxCGHFVRxftY+2f7khBi7/Pyr2sF6tV8MZL?=
 =?us-ascii?Q?aMYs32TONx0Br66BND3IIl9d9NbUvGDNDffF4FuwaYoxAXXtH3oCs3sH31bh?=
 =?us-ascii?Q?mwV+xHnTi/UXWUeptzZm7tVg+J/kWiXjFchXioNxej5pAfmO+bmfi/pt5Osl?=
 =?us-ascii?Q?dUAdn+xn637mQln14S+ZfoSptpSn8qZv+KdG+J/iMIGxSlfBVATQdjMN7/EQ?=
 =?us-ascii?Q?Xd9yO5feQfcqELJyV37MC+gHFHiQSuMjGzGQtj6Q6lmBGZv/FzxxA3rXlY8K?=
 =?us-ascii?Q?Z8V3pNEl/oHGLGyHYC5bx2GY1ZQRHZp5YLnnKZ4tnZnHWEZZcWjbGj4SI6f4?=
 =?us-ascii?Q?+hRnPyEpiwHLe9vuyNHvkZ+f/NNKFxpNdLgGyCL018zAIQFvnrb3GDUbWQ97?=
 =?us-ascii?Q?a6yTHW45t5NA2mTIQ0M134aBJk1XJ/2c3cPjD0H/Hmw3KMKSAfA9ceP7ZZlQ?=
 =?us-ascii?Q?qxLhqJZTO2KSpkmYXnr6KoYBI2kdEUVsWZy801yEefDchQRa+8PyQqqWfWFS?=
 =?us-ascii?Q?lLMlr1FK835UedWkN/muBfISON61qFb53XaLUrEDJtzFZ5M4LILTK3Eqi8TT?=
 =?us-ascii?Q?7xieYuZqrzh1GTez627BHKNqXG1yopvVTG7JuJLVcdCpzJHrCeFs+no2bky/?=
 =?us-ascii?Q?w5NKWLtjHdn5McAAnAuuTfS6yxwJtKzUxhH/mC/PElDUlP2ifCmbT7TU/K8G?=
 =?us-ascii?Q?LgZmab9B4XSXXdwlEyj3d4gJ1MhiUvEUig1LcCwZN2T3c71KQ/q/Enwh10+w?=
 =?us-ascii?Q?8EAdca9wUbkDxJSGklwbdKxYoXVqkEhsikN24LuQeCcvaUXhj8AhDwGMwZbQ?=
 =?us-ascii?Q?TcHDQWxOFRQW9gAlnwPfQf43k6v4lN/G0ZeVl3dlqC77D5jVYK0a6wkNKrPQ?=
 =?us-ascii?Q?lEBry0TyzTiy0nb6mhGz6a6VWnW1K7Kj6cuPtAk+gTdIgDfMIYKKJhbaoggg?=
 =?us-ascii?Q?hkNZ1fA0xRM1pYfpoOYJz2AaHwvsaoVOX5lf9yiZcyNi2BkrqJmkP7ufqZyX?=
 =?us-ascii?Q?Amy7FEg6rjR6WAzReEv2XkEZ9AEq5e2YM5OgHu7/RejlhJg5yJB104K34jsU?=
 =?us-ascii?Q?X66gmGhyxcnQ87BcYSKY4FwUTnq+yLntBRO7diUExf94Axub+x2kq55DxppT?=
 =?us-ascii?Q?sH2kBGLDBDJMvE19byxmDz0d9DVoJQuvtCo/2yZ2oAlB4yNAWpvE52YDohF5?=
 =?us-ascii?Q?+Gh40iWqOmK6qJMlaD5XyWzgAeDCix8dvU8u1/ZTZ9mxKF3U4huUwE2ueao3?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ce70d5-b671-4f0c-d62c-08db3cb42277
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 06:47:37.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0zuThc0VccUFmK381gTmNk5u5H8qtfOX86Rm0t2U040EsJAuHWYaSFhUQZnLBe2LBxHuVK5n04GHbmlGXMEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr, 2023 17:16:21 +0200 Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> Hi,
>
> On Apr 10 2023, Rahul Rameshbabu wrote:
>> Supports the Thunderstrike (SHIELD 2017) controller. Implements support for
>> the Thunderstrike HOSTCMD firmware interface. Adds sysfs attributes about a
>> SHIELD device and introduces haptics support for controllers.
>> 
>> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
>> ---
>>  MAINTAINERS              |   6 +
>>  drivers/hid/Kconfig      |  18 ++
>>  drivers/hid/Makefile     |   1 +
>>  drivers/hid/hid-ids.h    |   3 +
>>  drivers/hid/hid-shield.c | 587 +++++++++++++++++++++++++++++++++++++++
>
> In addition to what Jiri said, would you mind changing the name to
> hid-nvidia-shield.c or just hid-nvidia.c?
> The "normal" naming scheme in the hid tree is to group devices by
> vendors, and TBH, knowing that the "shield" is from Nvidia is not
> necessarily obvious.

Ack. I will make the change to hid-nvidia.c in my next submission of
this patch.

>
> Cheers,
> Benjamin
>
