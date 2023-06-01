Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34B77190C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjFADCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjFADC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:02:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2095.outbound.protection.outlook.com [40.107.94.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A783134;
        Wed, 31 May 2023 20:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4n7wtRLLK7Rco5obE5F51Rs043bQLFKy/R25ZzTS6YWGTde9/f4cuTKTwZD0Y8G0gIcJmxta8cvx5RbUiJSQ5h/FwTQ1a+kxp+6TmL1ouuwXAwtr4V3wSekgZVoAWWNiRJoiU6AZoGOil8wX4ORomT8TkimaITvPj5coV3icvsfzgXk9kxektC9wb1/dsXsaxcDsvGtqJWlYKFPO1Jv8/22cflEDjdJ9ThVY4y58vv1dS5nZ5+a53TKygXzn7qt8jbuDCngKoUpzLLYdAMVJ/9KhvD8qNcpR8qVNsJwM9UURybHf7uP2VOPMo5fqOP+BFRDJXQuYc+fwPNrD+HKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d65Wo5EG9F8HQayaLlS48GXBxOZlohrCEMTy3Z++FE8=;
 b=H17vuTRI9jMEPZT/A3b/o5Bb6dzn8io0KIqbsoF8PKXVFupLTbPDf+Ik65HTXYYhYDW/ccLytzO7D6qmqvIzAzh0f9TOdRJFplg+wTfbev8Hym/2rhf6q6kF9759UaDk1JHCJKNq4CHZYQk6FimHJvSWYPgFG/HNr9tnzc2t04UmQslY45xztOmIHuQp6iKPlUfvAqE0qzGNCn0lyPbKHhO0vBC5Dn0ALfN5F0DiSrZVy9bYxRf9m38SBZ/uBP36tX5+xAFsvzoyJmp58/DJ/yx1q0TazHMy05rdje1nnwQAg5RsWj7zH85gxkevn0ZG+qPFg8rDeG/1axkGAXQmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d65Wo5EG9F8HQayaLlS48GXBxOZlohrCEMTy3Z++FE8=;
 b=Rfk21SkI3t0FXykkdxo52CQDfgTF7fAVkiTJlIaY7oRjGSneUhMfrJg8zI/ALH4vJlWgtjTv1qiKCfaQjqtaF+BKyiJ2NrGe2gtOTYZiuLVU7fo8qvmgQUdngNOXEloc/aayxnMRY3wb2eygO4ym/ZsASlmlbbl/RLNoUvyEOLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS0PR01MB7889.prod.exchangelabs.com (2603:10b6:8:143::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Thu, 1 Jun 2023 03:02:24 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:24 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 0/5] perf: ampere: Add support for Ampere SoC PMUs
Date:   Wed, 31 May 2023 20:01:39 -0700
Message-Id: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS0PR01MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: ae5d2ca1-be7f-48b8-595f-08db624c9fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aybqQzoH7LCJ2q1NN4LGi5daBimdjMeSa7iHAh/7OEtqFHjLpiD6wz1ey6c+roDgPDuW69xmXuxeHj3nBDU41jXxCIoLtdKt0jRv4S7cca5NW4k3qvibxxbHp5vrMi0H+6R10oObCax6Rf39N/SPTz93g9aZYuRUZWYdjquQ4pYZ8Ns82Y4mQLIrDvV22IPSUQh1nZfc3fMfv6k08PlJboSCB3z0fzItC8TGGmGHngDZh76RoOxrTLBMX1YaKS/BsvkkC+yBUWtR/0kt1g/r/lpp0O4u3rHWaG6nf6vjGNmTdNJEN1x/Y16fgabDSblPN4Ov/zytxXUBJ8NtdXg7FRHfpeHKDLJmCuK7tCIdca5qu4/bI6uFtsnssccngUGx4UKkKH4Mqer2OcR6ixwoBc89BTo8SfZyiYZchJ28dP7MAToYcfnCKxnzrv+W5E/sLDaM6rabnKVWygM2YUrbOJO0ui5Prwi3/Sm465XZmKKNQm/m7/iaZvCpn3VDxx5UdDuK5pWGmLN0Uo0SdkFvmmSDH3PRBqgqGyPRC3c0OPcXumU6+yoePgyYX8oLvTsE14j+dWUfVxFX/WnxEvx/38aa5wNU1ogjNipoTYgBBWIwSE2EfQcKOlD9XiIbkx1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(4744005)(83380400001)(2616005)(2906002)(86362001)(38100700002)(38350700002)(6666004)(41300700001)(316002)(6486002)(52116002)(5660300002)(8936002)(8676002)(478600001)(110136005)(4326008)(66476007)(66556008)(66946007)(26005)(186003)(1076003)(6506007)(6512007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y8WXbugDVQcJvzqe9inXCCsiTqx9jAZx0RSDLtWiXX+pTTRlFPmD0JvuEsHM?=
 =?us-ascii?Q?5i48Eq0AZD+M5SkFlKC8dkxTveqP4jd3j66oqc5NTG9yRqcjBGjh4em9BMot?=
 =?us-ascii?Q?siM4e8oAKLvbb9Kyp7y3cLc67rG3NWwAW1MF1ogHUxhtO1PjNYHWRPlemiir?=
 =?us-ascii?Q?oBMMeHiWdA2dp8PFMK8OHBGghpanvntXTNmVUtHR7aquC/4pZD1NWsT7SY+Y?=
 =?us-ascii?Q?kWSypePn38wYczDUcsFU4t6wI3GR0WZ1FccCOi27IUL4a2BrLTUO5mZ+z/fu?=
 =?us-ascii?Q?/QMNZe7NGUdvsVyJXOVNJ7TCvk4Xn2g/2C/xuLOpfPVj1wKp85CmdifUSxNK?=
 =?us-ascii?Q?Byhec39QT3sBW479C1MNyWCJvCQ4NqMpwvfdDqP3pDGn0v9QzIVLw5xr/DMv?=
 =?us-ascii?Q?EMn5HEN/MS5HySQHoN/Y1nkMY3IKz32Ey7BIcoXygH0yxgsKZQCjwUcUlFmk?=
 =?us-ascii?Q?eDrLTLLllMUhJ2ytydLAoijG1ZU0SIohNMVhuq+xLS2GK+tNGDkSqiLAyOli?=
 =?us-ascii?Q?fNksbilrNz2AZ4qZNcFFVmqOBNKuI8SR7szFh5TbP8E0vF8lcP9C7r4M0Lbz?=
 =?us-ascii?Q?j4+JGIQvyuL8fJR0BsWMNbxsv8fwwg2Vk+Dk97DElEDZeJSlbCVoXGhrWe1j?=
 =?us-ascii?Q?gIfUnc18a4Ck8irWWVc/9rDE74F+/X8Aq09LwS886UuJU3WnLSID4xWmd8la?=
 =?us-ascii?Q?CjstiGSkfpnSPbwecf+GwiaXNmp4xo4ukOYHE1Rq75WMR2W1vj3UKjZpdlbJ?=
 =?us-ascii?Q?CZeNtA6/YM6clC+NwU3mWZD3K93727qiorYZQDQDBeQqMzIcxMwI/FbyPQpp?=
 =?us-ascii?Q?D+zS6fN6zr583dW2czVdwovJB8mFKVqF6tztbh6y+XBgr6RYKbdm3Ly1VCFS?=
 =?us-ascii?Q?Muhbonswdm7gePrRbvzgG8qyQES2UblFTJKN4c9GlKqvPPdgfTAdyUzSY/lI?=
 =?us-ascii?Q?PT8E4apliUtIR3BJshp+rG3msng9toKimUup/FLYJ95L5XJLGzh2ECCfi4F2?=
 =?us-ascii?Q?C9YJs+n+g5E2rZjaya+NwLE/6knWSNeJExooqBwk6mLWLgbQfWgo7CduCIFK?=
 =?us-ascii?Q?l0HGSoQo+3qdv5hij1KoLXc15Kn5GEKoQ1ntJo16HjoSPGhos5zM0c2A8E9B?=
 =?us-ascii?Q?9m2xZZsLM4s5c8+pbUXg9qXmagSCXJ4g4h0ICsCoNf/gFL1t0xpVEpZhSVKW?=
 =?us-ascii?Q?+pRIyfnbDL8LRvi3HORG3KU7ltmtwCuKgWa3vQ+mGAO7B2ImJbx1BayEAIpR?=
 =?us-ascii?Q?qRFOU+6yXSJr4Af3RnOXZqnXUrJH2pPvKTn5jT1IWlmCusrVfS+qWD/bW6Uq?=
 =?us-ascii?Q?fjpE9LKFOOH/rFhQKWMJPENs/3XFLDBOo0Q+4gbR9ckEZWyTk+JaFN6gPvtB?=
 =?us-ascii?Q?l4SP9f1mpp5ij3zSSJfisMoofdCbjSl34xFi2NFNaoT8L3jHzWruPITWmcey?=
 =?us-ascii?Q?rJBVSHrADl3b8zce8aZkfS1y4j5ikHaGqTvX6SW9zOiML9oDhwG20oaQmYLN?=
 =?us-ascii?Q?rci4vSknJGKTKy0bkT9HkvDPebQqcJoEy2wi/0oCaw6ehH+MDw3S0nbTxWf5?=
 =?us-ascii?Q?HFeO9+Ad9eGAXIzBoQqwYFzoZ9MQBQ0pKO5WidxZw/dQoh5a6kyVK3aJXHOE?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5d2ca1-be7f-48b8-595f-08db624c9fe2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:24.4106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIwQFEMDnHsLYaYJwoGf8f+OAq+gkynlCFblxzRp4g0xv25e/xcbs+Wr0FldS7t6hdZS2jDZYen7xChA1GMPiTDVl/IQYzxMszdk4VlOa97PZ8ArxRjokKEUeWOuweap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7889
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
    * Rather than creating a completely new driver, implemented as a submodule
      of Arm CoreSight PMU driver
    * Fixed shared filter handling


Ilkka Koskinen (5):
  perf: arm_cspmu: Support 32-bit accesses to 64-bit registers
  perf: arm_cspmu: Support shared interrupts
  perf: arm_cspmu: Support implementation specific filters
  perf: arm_cspmu: Support implementation specific event validation
  perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU

 .../admin-guide/perf/ampere_cspmu.rst         |  30 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |  31 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h            |   7 +
 6 files changed, 312 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

-- 
2.40.1

