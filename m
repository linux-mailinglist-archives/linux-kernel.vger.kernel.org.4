Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B7690070
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 07:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBIGhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 01:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBIGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 01:37:10 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8225957;
        Wed,  8 Feb 2023 22:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PegX1fdd0cbu2wMClzkSeyTKcCxhpUq+cgsmdRgIcGCt3FwU3pyx4fbzfXXQcVPJJCEua/2h5ynZfXpG6ul1RCRF0U8Li7HRX8Bq6LgKIMQsnP+N38ZJoQDFhhorZWVnAg7gT3j30JLLzCOpv64E700SrHRHhnKkOBgK4S7JB4NbAbPB/d9TkkIjF+MYvvsbFwtYk+HG5FzpIDQET5msFbAqU3KKlMHiSrvPrDFY1p2SiBlWc2Xr5aCGGfmjb/3KF6fxMEYFwUnFvsZ0Zfjjw6IxO5ELOj4+NgtjAAY6qDbQ4JFFb2IAfGbCRbrj9QByfB4ARPOP/1BNGvO6d4YxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrykcaO1hlZUAnyAqnxtzVlmMsxwngOJ0SMFQ79MPFE=;
 b=Jgms07TKTpGdfNmAwjy1yjtRgOPCs/8cLlFkrg5PJ+8f5I50VisFwqbCy+PqL9dKFJ02cMHoo0t3qRNPl+j2l67QEIfDhXZWL+xVOPpsGJFz0aukcPiI9lxg05XlPSpE8XLXnpT9P9t/v5rDRR3JIvuszXBH/+f0r76NWibiKaUYu477m+zAsOa5cUrcXPhqQhjaK4L8dZFkf16GX7SuMmjf0BV/oe9EVQ896hsqm1ju+kulc+/Mvx88fnZ6Z43on94Uj7FlNJCZD1SLonblNUHA9DgIZiJW0qtH3vDZzlPpdi50f36bj9+s8JuRn3wd28v7rxlzA2IgEf4DCWBPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrykcaO1hlZUAnyAqnxtzVlmMsxwngOJ0SMFQ79MPFE=;
 b=BhN7fJ55y2fOs7lFt18B0w06HdFM8/4NGrC/CnBKlmisaZsHGb8V9p/8vQlBZJkeFzFqDYaZsyBvr0anqIlYOdiFCzCvKVxOvlbVo6TtMwX+V62FOH6xJBg4aR+39eifJtLQAN0EExd870FJaT/Wsrwwo0iNQEL8G+rj7ZJsazw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 06:37:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6043.025; Thu, 9 Feb 2023
 06:37:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, daniel.baluta@nxp.com,
        iuliana.prodan@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Date:   Thu,  9 Feb 2023 14:38:10 +0800
Message-Id: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b017035-a1d6-4969-3107-08db0a680d4f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIB4ysmgHe3Wnu92u5ZJriPG/ygjkdYQ26h+ZXAikbrAmtLFO3yhu8xC7jX8QfLkV4/RRXyk9qnwdgYy+cjIme/xbhfhPQ9XigIstoP0mTFM7pSpL4gFzsPqzrUOWerenRihhn7OHwrczBXL6OyMKphO5D3HwtVLvTGKNyDoS3pWHctiarvg2ue0TYo28HThiVgZUF97FFZGq9VEfVk84C64EbilWvF3MzaJ1kkeEd0YgDiSNAI/AEoLeVSV7zgeaMdt6LywGQnXTsMDV3aCrct7FEx1mAAUqLs/2FkK3o2nz+xb8UjrIbtnTn8sCONChjOkuUEhX0r2Ex9sXZkq9uXSDQNdimgnnpHPJPUfimnW9ypz6D6P/H1u3d9Aou938lS+K/YwTNphwN8ZORStmn3gx5S9rx6mjt6RgT2qnVWykXwcbmdFcutifAhBYU5nxwLCfg5VX8UzeedglLO9til2hsE6zTBtYZdHxe07IWOGpJdTSrWdMG7N/kRhZVcLioOoH63ogfAEa81ioVpmpJIUqbuOKYtpv7EV1XohF0LiaohPg9v86jwbadL971hP3QGRNza3Y4RVRbMlgNGyBMKITg+6tdfPwk8iku2KFwXrgFGwxfnYxHm4jwvTdaCMUniGrAOygweJKTnhobcTZta4hqVrER5C8Y9FjvgAuPGLVOhkINrp1iV7U3sfQ+kT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(6506007)(6512007)(6666004)(1076003)(86362001)(478600001)(6486002)(5660300002)(52116002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EGUsGJUn1PBmQDOFmJbp5TrPehjN8wHu73LaVv/+cMQ8Fs4Cnvw5NSvDyEUY?=
 =?us-ascii?Q?6TFH03A6bWjeWA0jhcc3sz+EHHKalTAPROTACe89qTxgArTechkQH2FqrObA?=
 =?us-ascii?Q?CkvCFhs0UFCQIhTEzy6gjaIkoBekR+McxVM1/JpJeVWmV34SlKI6A+kBJyh0?=
 =?us-ascii?Q?5k72C40FNVNw1oqyxOfPIF/iVOlw6eER9Qd76TstjZkgBWsawd3IHaMnnNgp?=
 =?us-ascii?Q?7Tdi8PruqFm4RJUcdALrHJNym1Rwsx6f61kxq+7OhNoQ4NUG8EYHpRkzkXd9?=
 =?us-ascii?Q?rFjj2OHW03gyFJlqXIca5t7yH0RzrO4InjkrgLRT8fy35kJLAetpxfRIQtBF?=
 =?us-ascii?Q?oljybNYh4IejBxPg52Uv6n+pL/jj/OCeuXG0GmsNNw8X18fPR6TVDwul2OXn?=
 =?us-ascii?Q?9HnKGG2ag8ImZe0tI91aExEyLrVKbpRMGVWLhmuRhwIOUrPRmEBDi50ivge4?=
 =?us-ascii?Q?PpRXq7scd8SWBr139P7HwwsX1OaBcntt6nW++/5gCqmYTk5Lz5mTj7j9KgMX?=
 =?us-ascii?Q?lQUBIYurvLFN2ovFu1qzCYEOcWE3Tv2IvW/PKK8R+AertUEiSlyOFqpRzNUt?=
 =?us-ascii?Q?aafaggkbJUgc4VkanEhY00VPalr0G6jthEaZPcf5cjFh1schFOANtXb0EnOk?=
 =?us-ascii?Q?E/MvntGpQdYhTjcIZUJwoKMOGdZjf3lKDH7DrOCq5BQeDU6LUrLiySLwLfCL?=
 =?us-ascii?Q?4VjaL2+F3RnTZEZ+4dl9wOi/9W4vGIRNuabOSnuxuxugeqWWkmS0LmBbTroc?=
 =?us-ascii?Q?HmQkeOeGA3VnBkQvnt5TPGVtrXP4UCONTh4MujO0pnwX1vwC45WyGTw03ncF?=
 =?us-ascii?Q?dI7rIk7XEae8VL0ggd5opPEg5hweigsG+cZ6BIUsJCRUnLiUU75zGa0P30CU?=
 =?us-ascii?Q?/Dv91pfnov9ojmxbLgNMfaEMoVl96eULD44tFUu1nYx/s+F4zSqVwdIwOtcU?=
 =?us-ascii?Q?c3mirmaToaNtn0PgDeZEdCG51MraK80I8iVDSND80s5cx/9erMyNygQ9lHnC?=
 =?us-ascii?Q?yIQCD3snuLgvcDmWfktQ9g8X5OdF3uwdKwcXVYxTBveCpxi7qsUyUx4qqUQ8?=
 =?us-ascii?Q?BDU/qm0r+2LDmm8A8bkII/6VOwljno/06lvoJk0lzSH2Q5ST43IwHYk3KJY3?=
 =?us-ascii?Q?YISfYZZmwKQKIi2deEXLihYXvHsv+qAUh8JgQPnn0IT5qgmQczQnjZDHzrab?=
 =?us-ascii?Q?Tqh1E6NCl2KkRi5C3mM/O79VNzQ3R3i+ccGMHx9RG1wDzFnTpDFgl4CgDDVC?=
 =?us-ascii?Q?zGA+j+KodCAfxmjisfTL0fkN6PCvd/ILQCPHl1DECrT0ZJ4+U7XKPhezo1Lf?=
 =?us-ascii?Q?sXtL1Yl3zEUN/ZANs8Xic3CO3DwC1JRus6bF1wniGLR3eVRouefYdSK1HpU9?=
 =?us-ascii?Q?Y+djaFBfOVdKh+Xou4jnkNaYc7Lf1eNxTOlm3ls/EkwMQvTY2/74jAaAUlhf?=
 =?us-ascii?Q?ErAttY90x0GjARqkULXqaPjtK7L0xdMJtYCYIn6kv4nL671eJUhLXRORagsZ?=
 =?us-ascii?Q?4i0VeOnmCBorPRG9oqOg30ozvoC1oLmIC/il1juXriDXtuBxPWmeTiNmkaCa?=
 =?us-ascii?Q?01mt5kCTq/SjeV3oKcm3vdcza47IogKUgacpGVlq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b017035-a1d6-4969-3107-08db0a680d4f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 06:37:02.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: El+ew3SPm+E6yi8E9EBLfU2i1eNL1AODEXR3RJVs49pU0//iiLL4PqFbgastlryrnNlhMKaMN3Cnzbs5vGIUqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V3:
 
 Daniel, Iuliana

   Please help review this patchset per Mathieu's comments.

 Thanks,
 Peng.

 Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
 IMX_RPROC_ANY in patch 3 Per Mathieu
 Update comment and commit log in patch 5, 6.

 NXP SDK provides ".interrupts" section, but I am not sure how others
 build the firmware. So I still keep patch 6 as v2, return bootaddr
 if there is no ".interrupts" section.

V2:
 patch 4 is introduced for sparse check warning fix
 
This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware could
be in DDR, not just the default TCM.

i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
initial value could be got from firmware first section ".interrupts".
i.MX93 is a bit different, it just needs the address of .interrupts
section. NXP SDK always has .interrupts section.

So first we need find the .interrupts section from firmware, so patch 1
is to reuse the code of find_table to introduce a new API
rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.

Patch 2 is introduce devtype for i.MX8M/93

Although patch 3 is correct the mapping, but this area was never used
by NXP SW team, we directly use the DDR region, not the alias region.
Since this patchset is first to support firmware in DDR, mark this patch
as a fix does not make much sense.

patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing .interrupts
section. Detailed information in each patch commit message.

Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK


Peng Fan (6):
  remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
  remoteproc: elf_loader: introduce rproc_elf_find_shdr
  remoteproc: imx_rproc: add devtype
  remoteproc: imx_rproc: force pointer type
  remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
  remoteproc: imx_rproc: set address of .interrupts section as bootaddr

 drivers/remoteproc/imx_rproc.c             | 57 +++++++++++--
 drivers/remoteproc/imx_rproc.h             |  7 ++
 drivers/remoteproc/remoteproc_elf_loader.c | 93 +++++++++++++---------
 drivers/remoteproc/remoteproc_internal.h   |  2 +
 4 files changed, 114 insertions(+), 45 deletions(-)

-- 
2.37.1

