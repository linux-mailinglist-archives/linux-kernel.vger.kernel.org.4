Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88EE6C9399
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjCZJhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCZJhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:37:18 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2128.outbound.protection.outlook.com [40.107.101.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F6F5;
        Sun, 26 Mar 2023 02:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l44vSYHN2G7jhZj21Ofgxm8F0/j5+v+CtGWLZlHnipKiDhBDDNGBcY7lA0kXnYkcmKoZIjw6Ou/A3H6q7oHOF+TQ7GADCrJdUm7fqEADQka8BC6LUsClXUOkY1X7EkyIe101QNkOEn13vwFkauQS1aJlvBbDYEC4PUr9ih/ekwD3MSrdgqAuoxGq2bqNyWI2haYNpoWbEDeXLU9gUBYOh4SocB6Ky2qBtltEnbWWO3Uwx6QyhNs283cxj5/NIm1L2Tq4hQI3Z11djpXUVVmS6Ubha6Fki3M6O4tAb4am3ByrO6mi0kJ7mx1rWQ42W55ZUJeF6ks0yKcKVlCmmuyROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUw7FeQe6E0Pg97OWqbiQBqZcjsoBa2to2L6DzV1yp8=;
 b=UmdpuTfB8xjHwcwKRhW6R8MbnYLZJP/AEveFaOBymotJV4XlUMkviL/PHJGy7kw1Qa6rKqfT22xkbWR9d0UgGzei9uLfTmcohN0qGXrvjrY7Tp39VMt4DLhxBcDAHweblZqkzybjmY//vaVJGz30rqj3jWJui4NeN/rjezrwZtqT8d//xmlFLmrJ4Tq8bzidL+Cm95HKOkQQzkFtBjWdYK+N/0B4jP2FCJqtWfNdNGwf2dWjuLZbxr0+BVJsblCCHcuuSwJU361TvVmzv/PfdZ5T0uJ5Ofl9eMxDf1hTzQfvGahcf2aLdjiilBguIHR3GQka/SMK2stkpwlVaYHFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUw7FeQe6E0Pg97OWqbiQBqZcjsoBa2to2L6DzV1yp8=;
 b=t+XA56GjIynJB8G6Ugg43CwsSDtWYh9+IBd5U/SWQDzDaM+z9QGb226/EfKq3JyJs3BrYz3m6nqYSkX/c1JrdywvDzXXWu7dio1DMRTIO4YyCywfNNDnuWmPp4R51NZKKKzT3aH+/sbqCWbTkdA7Esz0MCmWLOUnyGxfmNVJAtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW5PR13MB5463.namprd13.prod.outlook.com (2603:10b6:303:196::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 09:37:15 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::c506:5243:557e:82cb]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::c506:5243:557e:82cb%4]) with mapi id 15.20.6222.028; Sun, 26 Mar 2023
 09:37:15 +0000
Date:   Sun, 26 Mar 2023 11:37:08 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Tom Rix <trix@redhat.com>
Cc:     zajec5@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] bcma: remove unused mips_read32 function
Message-ID: <ZCASRO7jQk6gxPdV@corigine.com>
References: <20230324190647.2654293-1-trix@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324190647.2654293-1-trix@redhat.com>
X-ClientProxiedBy: AM4PR0101CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW5PR13MB5463:EE_
X-MS-Office365-Filtering-Correlation-Id: cd22d6a2-705c-4514-1a35-08db2dddaeed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nih/rX/owBFKGDikTCnzOQ0x0x9g4CpHO6fgqwcJ31H/x7XP8m5KIBQHh8ztLA2croNmrnB25WxEF0pZAUByHoQdXQwvmScCK6Q54G4Z4wT7FQzahCm7XOUwvfkQpumuG+KGDYPeFR7pbkmqZUJklqUVY3bDR/bptmidkrwFffxyqWViFxzPrbb09/WjpWRXedDeO9TDC4yiARNRDVFU9YAB3oqygn20bvJBchVku66bAuReACMdEdzKb8dxLlZUKHwJX210yI/GbPyQlWpVcMSaET+Q0z0AEP8mIDzrhSy1TaBawdRmSqg4L01UrArPtUwRSFHc3w68SFjfHacfLL1emBrd2m75F8Yt4SqxKKYmGbTUO92q+SuJI8x7s/SnhBFfOXgmcemFwV0fpkV2pjFRrd7kdjcvzFi9hJC40X5O1Nla3sfrqIIMTbBTu/AinYfHCfhjMFlzTOM2Euzq2fuPvnYoztacBryV0h+iIi6YEWmagmZY7QRGkZn3S1YejxU1BzWm6zp78snU9HKNSdwLMh6ZgnT6rug15RRuDi5di8vxumKZluU2vDN/MHQU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(366004)(396003)(346002)(376002)(136003)(451199021)(478600001)(6486002)(38100700002)(66556008)(186003)(66476007)(66946007)(6666004)(6506007)(316002)(6512007)(4744005)(5660300002)(4326008)(8676002)(6916009)(2906002)(41300700001)(36756003)(86362001)(2616005)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZK7+AJG6U8E6BKVWeVPJBCZUgzYSpU29XbmaBfugc1UbiRVQyP7EASrDDZZz?=
 =?us-ascii?Q?QhHABr7pN1ilQbD8/moIbPxxqFVDYb683YUolCV071yzaT+h9L9HwyteV0n/?=
 =?us-ascii?Q?HjHunqMYUHZl7wUwnRQ3MCRirbDIfA1EyuZp+Cb2RU4UtDnGwKOgF2xXjqv6?=
 =?us-ascii?Q?A98BPM5EaKIxoxAsezG85I6EGClDPgCER0vkbcA9yC6wFoBORjZm5Hwy6hFl?=
 =?us-ascii?Q?SVfCYXgtM02ka8eg4r36Kx/N16Hum187FmBQWKMByprIcUiYVdIfnHDfD5uC?=
 =?us-ascii?Q?kmRWGdfVegr1QXVcQpLvhMIpvdIywRL2bw5a65ihwbYQil1MqPE6A3R+95HM?=
 =?us-ascii?Q?MyjLRrE4jdCYPv7azoxqoYiYiI/G1BMRrTWpoWDr/fX2mQLMmG2H1O/RGdht?=
 =?us-ascii?Q?QIbDIEgUXfBSQ9BLDMMR8qFGYa9+OG3UKwR/zyKyrzCO7QLB7X4KGayfBcUo?=
 =?us-ascii?Q?yT1UgoxOQJjjoTSjftNA2sTJyKtF99J2FZtNwUudqMQ8eb9mz7cjeGoVlHJI?=
 =?us-ascii?Q?EiPHU6YLDcv5DDlYmI5BZhPHweRQtNp6ywCH8hs5l5ULJmoCITKVr3OHEdQR?=
 =?us-ascii?Q?rYwCAwGVFLy2fE/OXgMXHz7RabfjV1C5eDe5XU2/8xdO+OPIblmwJZdCvyA8?=
 =?us-ascii?Q?N4wF5tuzZ0JX6KaPwJOEWrGh7Nx+JHIzWTpDlMNNjzuz08mLyQBzmHQqvczD?=
 =?us-ascii?Q?Ta76DPKchvUu/a5JL4AEAn5DtN7o0xppnngaUWpp0Sywg3HswuXoxEh6s0/Q?=
 =?us-ascii?Q?DrH3RHPGShNThww2pkwGhONbkfmPZyXsb7BmPQaSrSAeSKjBVkNCF4VBnSY7?=
 =?us-ascii?Q?kWVOdOTnrBZz3L+LvCUSYucvnYbWeY6ewIYhPkd/67qDJ0VV8wFqJJFWeZEu?=
 =?us-ascii?Q?+BTogIpSKbE/ru9gKsEwTaLLQLaKcPhKHEN+Gm4Z29TJdKTjXkInH8JRsbaj?=
 =?us-ascii?Q?W5vann4FNjSQcqmMEHtdhvKwlsSGpLK9bUDImROWU5y9mudBCo/kJCMkXwmz?=
 =?us-ascii?Q?/5t3e3t8eFsqLRVA9nh7qa3b6IjJZCPf1nYpfHbJwKUBbVnX/tfdckZIQUe9?=
 =?us-ascii?Q?vg9pzHdHWy6tKXS5y6fnLO2ZMGXw2kpip6Gyxq44K9pjzL0mrojxrSuSN9yU?=
 =?us-ascii?Q?6Nlj5BakIIsnFDTBUYxxE17Cf5n2O9rRqoWkGyBVb0r51bTJFuk6myXFB/yC?=
 =?us-ascii?Q?vdyMZASrF8kRk0YS+B6eChXztrqcTwkYnM5mjA9Qex7pewCBlzfGycj/FKAJ?=
 =?us-ascii?Q?o53+5l5av7FMC3ekCXYGS7Ga0GsImFMwZ6U/TEk8zLGTeyA/T5XwZY8WRFk9?=
 =?us-ascii?Q?TmayL/zoU3C7eI+i+1q823Rw4+Y7zHbpx+gxidRNytqjb6D9bmvQVMqn+9Zt?=
 =?us-ascii?Q?Nys6mgbwVQbrm+aP03mLrM/UGRnBBxZ57V/QA+hVot/nkXcUuK+Un8FI1TYn?=
 =?us-ascii?Q?YZ+hPhi5IpcQwhPGFlPUVTPP0fQwpq0w6vshiLirLuaHIXdo5I/gC0vwJKbv?=
 =?us-ascii?Q?VTjT1e+OtTZXPcGz8RLSZXM/F2ew7XtKmZHcw0OxtQ2hTczd5XK8/HRy3ZeG?=
 =?us-ascii?Q?JWB7C8jictLGMfSUVW0tRb1G7m1kmz6x/0tfxtrkmhrThBF9eMZs1eRtvlb4?=
 =?us-ascii?Q?E7jGueVPcmVAPQCLuHQ9EdZeVqcglSSBTE92hiW28WcyaGsMGfe0qWuoNY/v?=
 =?us-ascii?Q?v6KhVg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd22d6a2-705c-4514-1a35-08db2dddaeed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2023 09:37:15.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSR2VMu+iYQlYa1CJX59644TyWCXCjG6OsNWF+OjGGxwhDXd99eFdPbU7t8yRuK+s8rm96F3fyopy8YmBmSV99m/4sk7m4JoqNrhhQsYDzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5463
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 03:06:47PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/bcma/driver_mips.c:49:19: error: unused function
>   'mips_read32' [-Werror,-Wunused-function]
> static inline u32 mips_read32(struct bcma_drv_mips *mcore,
>                   ^
> This function is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

