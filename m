Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E276DC9BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDJRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjDJRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:09:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B08E2133;
        Mon, 10 Apr 2023 10:09:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdNHvy5uBN+ww/12ncNYWMNhlcSuwjbVzW3bJ4vgqmRYZFqVVAfpRRHuULN9vvuFuUXU4AnyfAvWF1E2/ksJz0Zg71IFP2Qmqdeg2727eaDsbEb3HrNJa7rH7y91tdNm70FoRvcrM3eLGQwSMbVu43cm4PHWSpOiXZq5JD9q5mXDgCaJANfumfpeI4hkIGlqqQWR2gi4z1TOMLLVPGxFoanGh+Cv7UjXSZm0XDAo+ArfmCauSaFYFX/IdXlXsjM0ibuU5ksP03Ti6m57vT8FS60fxHPULbEBWQnPmFYJRcDb4RCM+A5/PTLD9iKGv7TUoxxmxvZGCYgbVyRi41DwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ArTU54Qhg9LBEDPXdYW9TiAWjgYwl3eBd9LH0E227w=;
 b=VZ3PAzWERKiYfNUws3Dqts723ZSDexwdJWO54XtSujyZYbQkO82PaaDBRs4ejp+poFIiqm0+RoHwv0PXeDKAiOMKyaDtuLFsCT/X5Dp2AJX3mUpz1DwyQoPB3aSlKKZ78r1uQvKNwrPZJlgHotrqXf1RLbJRT93r8NNIhOqKNwTT80gruVYQuUEAG7IbfCZtZSDcwX19UBWRo2D4IfYAzPIqp882fFaNnDDE0r0CtAr8bN9au/kpyR22pgLgiPpMCL8mcDxr3R4gUXUz+4Mvc9Cmh8TFxppumLvy5I9PhAuq+1hEhT5ywMEk/YkRmh+9X/VLl30yZFZhkvNmsnVqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ArTU54Qhg9LBEDPXdYW9TiAWjgYwl3eBd9LH0E227w=;
 b=s+jx4LUd9QKsGFeKDt67Xa0ncOnTOfsmpB1gO83iuwxMvwlQwTqqQ0dIBLxnYcvwNNKaHMxKVqY9CWqWzMgMFiR9uyIaQ0xuz9aBfqv4Kwy6CI9QTrWwhObo6621AQLkTAC35Qk9/tyT3TEVQtA/yu5VCqx2G3ouJM+LBWI7oDdJcrGssYQZlJcODsx9ZhPx/j8CA7Ufv86+hMI7lAzlPOxUpMWeVfgeE8Em2wlfjLlk8Kp9i+9kiaxxIa28lnIak89ycpl7vKMxP1e+tKA9kNivo9tuqWCuRs2myzEU7sczoH1DQzAfvV5WVbb0Vg2GT4BbYj0vRuWhyIvlLz1koA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 17:09:27 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::f6e3:c3af:67f9:91e9%6]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 17:09:27 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 0/1] HID: shield
Date:   Mon, 10 Apr 2023 10:08:39 -0700
Message-Id: <20230410170840.16119-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.38.4
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 16120c96-9af5-4c7c-aada-08db39e65768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUoJt3+j7riCO4p1RB5VOhz1bTwT+Lri2U/N7dYs8Il1Er/ZnnGTYM7ulysTKLI4AJ9VqgZImAz2hMLvluqnpgAH/c0HoaIs4+KgdjWVBR9Yn4XrNd9kd06xHjx+/ja4XyhT0u7mgRptHXPkEhZYr4UtscQIpCyQBn/19pm6z2/PLOUBjZxA6/rDjINOoBw6dxwmr+Ce+rEZanTbHqslD1cq09VxLMc2XpEwryW0eqy4hwNUn0fHW82k9U0uXUWptUnHsxyc46vyJ71EeOBcskUqLDpR3u0Q3w9C1K+Vqudm/gXtCDSYyu2VjmxtgTFoFYh33k8XWKWLu32kdxiuzWzQE6vDsOvJghCX1ZBIDnQs+tdIZnVRSULWa+Yl59REakhKDGdIhs+5pR0Bgxx9s1X5Ar74NVb+U72aAUAMf2HJiqC1uWD77upgPcyyM6XOrAtrRdRAhfJI28by31Q6bixDif9D+GHaqhfu5WHSuZj9fG7Fxlh6pl0DPQuTRipnl04DfHHYHok24iq4ay1x16a3zsa7m1MJbFygEOAuTefOH2oNqWM2WFdgVWqqsGNjoeurJrSSd1iTUeaRa/DGJ8TqPTT0nJxTMcLMp266ZNHCmXGPmjgGvL/97fGuz3PsHDGORtB+RGS+6Qs70HLYJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(316002)(110136005)(38100700002)(66556008)(66476007)(8676002)(66946007)(86362001)(478600001)(4326008)(2616005)(186003)(41300700001)(36756003)(2906002)(6512007)(1076003)(6506007)(26005)(8936002)(6666004)(107886003)(5660300002)(6486002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gb/YmENmS76NnBippRxdu+SqHqbM11RiUFcGA26DblU2m/gB4JXpAmgwNsu7?=
 =?us-ascii?Q?Y/reOIjsaOL4eGzBglHrEjZvxrzIAxTX3roxU8JewzqSdKOtWP+UB1gzS2+T?=
 =?us-ascii?Q?q3STNuVcVqrt+FhrrpDgUbBdhmv8sMmkibX5UuKCdrRbT8WgnDF+k3bOhc2i?=
 =?us-ascii?Q?UERiXvP794PgMzmiggU6It6SL9fD37/QVmzj8eXXBc69LetrTKUQvdoWc/RZ?=
 =?us-ascii?Q?xngFL3SSYAntTodDGT55oTobtDkGBvfUsvMEj8GjS+QxHG7LUhI+uw38t1PF?=
 =?us-ascii?Q?xCWmeKM2yDTTAe4AyEX1YCQktR1aLs1wBaCIP4oefgX2hyO7+wQs8e4PpsKS?=
 =?us-ascii?Q?DhKNYKCt72F5Lj7urIYbIxduOiNtuiQwvx3P/T/FRuwv1AYwIlPWoQghtJWr?=
 =?us-ascii?Q?do6HzoVac2w/Gzkp7v1RmMDOVLkkvrHvmm/KFe2YSUAPKE0htBGuV0akgMb2?=
 =?us-ascii?Q?9y1EgnHfMDCAQ8pdULYNrzlXStPX51gwrvGQY9BXMFfhGnCyA2SpVjCsxUZY?=
 =?us-ascii?Q?X+Ew3EYevt/lxbhckXTTWjuf/esB0Sn/znw3eYwCHV1a8ZsRJBCPNjqLYEu0?=
 =?us-ascii?Q?0eF993O6PyqOEeSddVsM22LfpakYnIHjksZYu0/9nhUvxphD9nepg4016gvZ?=
 =?us-ascii?Q?tJrCIBodKC2n/BpvK2hV8YmQ1wh2IzcOe9CAruNsfUZE068NBTgxElacghvP?=
 =?us-ascii?Q?I1zyOEX3m3U9EawUJ26VS31YWUORJD/OyaQZYvpOTgjFIpZOT4tOtuWtGkwi?=
 =?us-ascii?Q?NwyYJKKdxnhH4IwVLx+gO/0TkjypY3e/JC65q0Sk0e0/JATNs8JFNuTO7AyN?=
 =?us-ascii?Q?e38TmQ9fJ+g0XfX/chevx/xDZZu2AZhlOYKHTcUvxySnrniyDHTV9PTOcT+6?=
 =?us-ascii?Q?3wOw5kBsLDhlx0BURmxFND9zbGOU/RVzeoFrz9bj8xbcrAl6wOv3PbYPdGZ9?=
 =?us-ascii?Q?4iLNin1rhCOC2S8+UWS8AYkkc1LMoa8moskbv8bRvOvExf+04fnIp+6P3x+L?=
 =?us-ascii?Q?qLaxpLxGwg0BSPlH4vXGg1mHxDQ8+Hy0EzhLvTnhH7Wh7biFe1oSTk8nhfcd?=
 =?us-ascii?Q?mcfRHEM3SiPF8qyJv5cRnchuejvyTDIsmTE5ixKWebJg4q+jhB1xccy0uPiI?=
 =?us-ascii?Q?QxBJ4+qAODNz40h0Gshikau3NfgYKoGporZIHP3QohyYp+beH1Gpu4YZkbTU?=
 =?us-ascii?Q?BQXyiCZqrBcQXS0VdrkgMcjCVEy/ByJ82iCFXzcSxnTIwdiGOp0L+QBOlfvh?=
 =?us-ascii?Q?0wOOVsEJzn1Uq3WryLK4h0seiIdhdeoiUGLl2Jq8EgWJSXBUw6lrGQc2viLY?=
 =?us-ascii?Q?DDJAZ9kbhPT7Z1I5aBgHHqL2sF8AqqMXTgi7f+vWa+YAVeBPQ7sQYDxQrico?=
 =?us-ascii?Q?lsdGX0JwRaBrRDpV6flmphWI6J3ofxZtczqwT7M8wGHTAN6rKIrKmFanX6zL?=
 =?us-ascii?Q?Cx2ScxdXlhqvqNbRXf+h0BLr3qgHhs3Dxm7/9z0U8ScRoeJMyceXd1SWZSBO?=
 =?us-ascii?Q?lWwPk59kxWHpoYmXglpkCK07GQomdBgofRmhQsKl1Dto6Wrzam9+MegvQ6ur?=
 =?us-ascii?Q?HydhZKRiqO/Asi3LuAH6zL5/yRuMJ481JP0ni/XNtou4rIH3MDOscgWhplqg?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16120c96-9af5-4c7c-aada-08db39e65768
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 17:09:27.6462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXJ4cnB45GWVeAffURitHiWYfKDBLd7io4+wueqOZz3tZm5e/5fEUe5/YF0TOlCCEaiH0MgNUH+ph1azw1g0Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This is an initial driver implementation for supporting NVIDIA SHIELD
peripherals. Currently supports the following functionality for the
THUNDERSTRIKE (SHIELD 2017) controller.

  - Haptics (ff_memless)
  - Serial number query (sysfs)
  - Hardware information query (sysfs)
  - Firmware version query (sysfs)

Changes:
  v1 -> v2:
     * Declared thunderstrike_hostcmd_req_work_handler as static.
        Reported-by: kernel test robot <lkp@intel.com>
        Link: https://lore.kernel.org/oe-kbuild-all/202304011342.6Bh3cWhA-lkp@intel.com/
        Link: https://lore.kernel.org/oe-kbuild-all/202304020922.vsngJnBT-lkp@intel.com/

Rahul Rameshbabu (1):
  HID: shield: Initial driver implementation with Thunderstrike support

 MAINTAINERS              |   6 +
 drivers/hid/Kconfig      |  18 ++
 drivers/hid/Makefile     |   1 +
 drivers/hid/hid-ids.h    |   3 +
 drivers/hid/hid-shield.c | 587 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 615 insertions(+)
 create mode 100644 drivers/hid/hid-shield.c

Link: https://lore.kernel.org/linux-input/20230401032150.7424-1-rrameshbabu@nvidia.com/
-- 
2.38.4

