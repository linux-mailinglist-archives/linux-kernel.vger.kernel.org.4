Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596274EDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGKMLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:11:06 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994B199A;
        Tue, 11 Jul 2023 05:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZ/6yluBcCTRCCSUE2ybu3EvDw7RpTzOL1Vq0CMeyEDA4Gsy+QtI4NSIozeg+B7PFQsJo72uoHseLb7S0adTF7V3flTH81SK4pY4He+1EX7jvGejijeDhJUY8NyAL+zN55zZlh0FcNEnMZ7E+9OhL+itITCd9HdWIBzNVuOmzwRMY/uFSqjwAq63iHF/vzZsZpFkSap4X4crgHYPQ656bJF5yDm4Qtp4ZyxzHUfAeA90CuZdGYVQp2fqDpD3s/ePv+TJ6bV54kuF3YGJcrTxhxvYkE9sOuyyw2p2HxuABjrpUXJYi0empylEWcrqtar5TITl5j4rA+lXuCo6nRV9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5eR0aH52igag3fy26IyIL97T02paCXN9wSwNlqwJaw=;
 b=Sbsb/t0+cF7mfnu+BAebhEOQAOewHHduH11m0RS+lPLNqVBYFmdT/c55pEQONqc5ETR0XN4Mb0UJdMrZgmjr8QPc7kWh+9947zMqFesbazJ/+7D4miRtiCpCvsCgc/rgMjQEn8C80VUsL/yfjmLfI3Na9L3TX6UntkaufJhKoOzwLwOozYRZHSBwN0wToXcr7IR3sW5oAOBpVCcdcD76wipNmymNGAfdm5rqIHQ/muiwAKnPtL/lKTWVyHfh2YNdR/p9umREOB0RXt0HZ7mK4dnVJEfo8YmX4+pWHd17H6Bbp441WJ6CUDojQflKKS4Gf2WMFFiUKhUdf72LBzMNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5eR0aH52igag3fy26IyIL97T02paCXN9wSwNlqwJaw=;
 b=WijPPNlnaCaDGPVdAEQ1FcKQ0cg0TwGYQuGpWC807z4OGJNWu/36+bbamwLI+7J8/QPZsmofF1+F7X0LMDSxy+ZW/Tu9Dgnl7GY68zlivZl0cTTLRQfU3Xvv6Jxu14H6eMipddL9gXuqhVpN7yri2Owiy9iigN8g+VAwVqwsQY2DJSR6uxjYMcA4qLJJWgVN0re0lQoiPvv7jql3Yw5hg/4PH4M002YBYSvSlHNlHtODGDZj7xz8xf6VAUmp4orK1ml+s5IbcHL6QddaDEdgeEGs3NnJg85+a8x1OGAqoygz+C+45Po6txvTyY3igRb72n0J3n6UmHfXEPapoQbFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DU0PR10MB6653.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 12:10:30 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 12:10:30 +0000
Date:   Tue, 11 Jul 2023 14:10:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 0/2] platform/x86: simatic-ipc: add another model and
 hwmon module loading
Message-ID: <20230711141019.05ea532a@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230711120842.30044-1-henning.schild@siemens.com>
References: <20230711120842.30044-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:610:b3::19) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DU0PR10MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: b68c6115-7db9-4453-0d33-08db8207d223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14EgqBnPNSr4lVVlEGnkLHGs7KvBqLRBa1jEK2Mt0ddX1OvwPIZF2WSuqLmZsqW+7brkQ/o0PeKAvj60npq4aEzvRW6kSwykVovY37FRCqL8yHZ6Rp4AXuRP4sP1sXg/1dPAYMyzcCa/96rQERQKJcP1Q5agVrS5LPagbK6mm5NdgPxwCJGFr4ICNRyHdsHkzVM9YXjR8B8d4be4XvT3d0mkPmNCwwX3dUgZlQO4oP8gX9XXZ0oH/Aw7skAlhpMBO45nQOfvNwHoB2hwgQbw5MmOD0dlO6vMydq5VYuenfvJlflitaL8OTMZGW2QwC8KoXvcW2YR92fAKzy4p42Oefzxc74kMsg2Vvm0KKxMGhc+KTtX5CJsZvcEsVhR5TOpJD/N/qUEN1GYvFMl3qAmQfTu4poARZ+0b66+erT8McFaXxxbA2/zVWpaanEAsIblP3j6MH6/XXWW1rnu3wgqE2o9JvxQzf8Hs9dgSv+Iq/kpGzb8Nxn/XWO+OHNXlUKS7+uOqo+izJPmvxRKeTzLav2L5KGdJPZ936fMhfBndLRmv5aY/xIbUmiBNW74naxj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(38100700002)(82960400001)(86362001)(6666004)(6486002)(110136005)(54906003)(66946007)(107886003)(1076003)(6506007)(186003)(9686003)(6512007)(44832011)(5660300002)(2906002)(66476007)(478600001)(4326008)(66556008)(8936002)(8676002)(83380400001)(4744005)(316002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fKMGLW0m9DlRA/MagRael9yjBjdqsp5Nl//3DC9WrnaRBAT/EjZfSDmrf4p2?=
 =?us-ascii?Q?KQ+Ii/SJMfVoR4kLcARtPZTBtIT5ufiKRH+bG7d4iI4mZbvg8o+TgzMDpo4t?=
 =?us-ascii?Q?mp8RhgVNTMUk43E9WBbSAVXJEYCVBa+yAo5U+xEsVArVYSsP/BCJi1d0lH9l?=
 =?us-ascii?Q?R+aNjqc2IvETZ0fqWNw5NC8HfmO3Z9O3cRaxoNjGl/S60Buf8AQ43kR5un9H?=
 =?us-ascii?Q?c0JWMmFQ75FF/jh2HEKrVkVjphiB77u7iccDiQnbRDxbraz6495cZWtO+cnN?=
 =?us-ascii?Q?RHf0f2W9iuM4lGVK9WtM69oCLuiSFzh2E5DpVlR3N1S9KCC58sNswMTpsLZ+?=
 =?us-ascii?Q?tZ4k+hmiAAnR8UEPSUE3aOVK793NFzaeJYQecEi7w+c2Gygut42Go9MQrT4u?=
 =?us-ascii?Q?Fahwj+KMZ2wBy8kkphlJsLTW+6yhDv8Xu0Gb120qAuK24rIcedohLFfwVOAO?=
 =?us-ascii?Q?yGy8ShcRtjIv6fjINzHGCaoH5OKh+WPzB4xfcjaZInmALGkaWxkLVtaU1ERx?=
 =?us-ascii?Q?v51Dt/UnN/gU+NI7lmciO2n9mOUM5kd50paRGXq0hUtBFQQBWyYF3RflMKUT?=
 =?us-ascii?Q?hVKkjV1bCuok6bdwHVBKbdNImWqF8SJWIT8Qf4NNC6MwK4OokI6eQ9Qsh7/H?=
 =?us-ascii?Q?NQ//U5Y/5/kUpPE/3lOD9YprgQhgbNqpa/2PIoWNAiJ6Y+0nWQZ/BhgAqRkh?=
 =?us-ascii?Q?IHe1IBnv0js41yoD1f6n6eyVMZpC1yqGNLd8Ansml18uECX+HY0NS64fZHtE?=
 =?us-ascii?Q?1Fx9UMRBE2canShFA/j6Zgl/fGQ7j308QsFyj7Xj5W57d532CgQfsIYOdGjF?=
 =?us-ascii?Q?lhi3SumHK+giwlY/0ZORUPCzy2HqftSJiQ6uVHY9AxDx2Skyra5TK4p+dPb6?=
 =?us-ascii?Q?GB+nKQfvieRhC7kPYWG4OEqe8Vzi4Y5U9BOV4we8rD3dJdj9+V1lLHY0G5Na?=
 =?us-ascii?Q?zXFcQRl1aZxjJtrav6uxBRYAh6MTOXv+Rf8TuKfL+1FbqOpU0YrbNBwLWPH2?=
 =?us-ascii?Q?3GUqouM1eDI38T47b7wu5rJ7ktc5crqeNXqACXaRvzpgfck4fnmzEk1E+/gD?=
 =?us-ascii?Q?FqzGHEOjPUulWTMxozR9N5ehyKGGMg+XlM3vjA30ZKNZYCsmUK563NaXOeZR?=
 =?us-ascii?Q?O5xU5Pn95oRWjQnhpxoIkVEDSaB8Okx+TxjjyPEAaV9BmZoMC3vPepnUa43O?=
 =?us-ascii?Q?ETSm7v5K1g2+8RzEuMEbI5jUbSp7Mb+XEIKWSBTGzjwZFQYhsI9ZQjXzsEtL?=
 =?us-ascii?Q?p0+NpZzLasGK3frvKuns5YIPEVZBkQlthr2SXjO/Af9Iw+w5GHljsVXmvARG?=
 =?us-ascii?Q?/AbhUidj61Cg0Y+tevGvlWYEjByzljKltuQ7b2IV6lIqlq6JnZ8XRZoHH8vW?=
 =?us-ascii?Q?6MPMYAWF8w1ItMa7aONTyxIbRpl9EPuk3oX9x3eDCQJ76Q3hGTrV+T80IbWS?=
 =?us-ascii?Q?M2OVq/nkFb+T3gOk1SO2WZ7hWqs8M0NtRPEcnTAkzUOtOYdcu4TzUt8yHZUv?=
 =?us-ascii?Q?uMbpxm6eG0Cctz1V1cISUoATHarj4Ibjn6PouAEKZmPhH+cPI+C5W+l6gfxU?=
 =?us-ascii?Q?rLm7XEvzBrO8sIqW2zZ/d+jAzVyo9lYqDWqO7w2YnKLKzql6feRbJdyanoTr?=
 =?us-ascii?Q?Or7H2WQxXL/6PAol2bFkGOe0nWadDhvOZSY5mTD9MCedLIQm4QdRvRHBPG5l?=
 =?us-ascii?Q?YZ/fiw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68c6115-7db9-4453-0d33-08db8207d223
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 12:10:30.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UQLq3fUXu/bYzHyvs0fnutp499B/++PiRTZqQBoRkmknXTwzxaHvUJS7klyfH9FBwSCO0EBJ5AdzPXgSYg8sHWmrsNxR6fBhz9I03fyhPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6653
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 11 Jul 2023 14:08:40 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> The second patch loads modules for hwmon support, should they be
> available. That will save users the need to detect and manually load
> those modules after a machine has been clearly identified by its
> Siemens Simatic IPC station id.
> 
> The first patch just adds a device that is pretty similar to another
> one we already had here.

Note that this is based on
"platform/x86: add CMOS battery monitoring for simatic  IPCs"

Henning

> Henning Schild (2):
>   platform/x86: simatic-ipc: add another model
>   platform/x86: simatic-ipc: add auto-loading of hwmon modules
> 
>  drivers/platform/x86/simatic-ipc.c            | 19
> +++++++++++++++++++ include/linux/platform_data/x86/simatic-ipc.h |
> 1 + 2 files changed, 20 insertions(+)
> 

