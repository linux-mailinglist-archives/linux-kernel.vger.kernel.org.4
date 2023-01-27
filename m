Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C27467DFE8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjA0JVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjA0JVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:21:34 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207DE5BB0;
        Fri, 27 Jan 2023 01:21:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7wv8QyQIFqM+RB055QLtywDgx9rMfwor4xTQB+6jO+Gucd479IxKirXZl0CF5rTzKHLz+7o+Rir8Pj/DWj5JgKYQNBRB3guwfiL3NAZOU4xfJ0ZTy2q/nFO5J5xFgBS87Tityr2k3wjXT+PAhNSLMHTt7ky48qmNKRCF9AzUOSMsRIj8Z2WxM2zda+TCgOzbu9eVxm0KYv4eeb/puNfE/YY/GGIRhq9tfh5G6jTQuyz6Q0/pHC2dROkLD/+Ky4iQW+OvtOZ+pmojZM8n5jaANHXBATV6FH87Jcw50DlYAVl5USFINQ0aH1h+WTMNyZsn53JEmMkjtelNqLsmtnZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukuik0eSXzAL8MMKPEtlsRuIFnRGwhLBcfERop83VNk=;
 b=BB7dC/kNWvvaefoMsxXp6JSGvz07D/5JeTgyf14WlwHeDi+7g/x8hac6G5bpMiNkyF4oNWKGBJuHw/ZedvdemZZji/m38lldo4uobg6GhVX7t5uybZrarc/zPF5pahLJNc9ENfxjEOFlHtzUqdAMpLUE62ShWeR7ZVBI7c+tj3qaaVDaA3Zjkn3wYFtBrZ4i16AIP5BxWhRtOy7m8UXrux769WhD05sZYahlENqjnL1FePpCDhBxFAqXoaKZ2Z7So7QZbubVGyPo4QsS2/cCXa9RPK8+Evfr3lwbczLMDFpAAkWXhvrPJ8L6e1oN6Q4P28xFFABM9ijINe8lj2BkIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukuik0eSXzAL8MMKPEtlsRuIFnRGwhLBcfERop83VNk=;
 b=RN9d1AsKLfq4oW+7egPiBfSc3DhcW1GtUjiDJgum/SS4ClV0YhhwYV+q/icB7BgPQ3RjVB5DPpmjO+NBglC3zW1h6jCGo3mF+bVXGOVcUbcfmCOWG71MtLYENMxSZcq22NhgBuldGbYz22NXYIikprLt4sWexbxSQ1+vBPjVdC8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 09:21:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e203:47be:36e4:c0c3%9]) with mapi id 15.20.6002.033; Fri, 27 Jan 2023
 09:21:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/6] remoteproc: imx_rproc: support firmware in DDR
Date:   Fri, 27 Jan 2023 17:22:40 +0800
Message-Id: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: bcd58447-b28c-4bd2-4ca9-08db0047deea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiPqjXB9Z4T7PxTeS7yDZJMx6nUxBVO5iQF8JhWgnCDADGN8CYTvD+pYs8f/ze6ynJkAk8fZNu1f0/Sl9ZgxODaZ4A4fTIHPwMK2ydNfaHbUS9AMY60rbfmdVspH5KJ5+cmAlbV5BxBLup/hN7AbIZKhDRxGIL+UbhfS2dCcR8gfpbM7tfkPJxOTZTLMD4/k1O4kSphjMdfXLRAztycgs6FBAVA97iVcZmheQcRzyvsRn+hzCf9qjPqslnFmn5xsww/eyGCHQRUINy6XEfl0XevPeO/UqDmbEmdVjuCc6Vy3J1JJdVpHAG82d55p9UPiU2Gx6xgM9Xmyfvqz4IhkFTIqFw0wtRKhGl6a3ZJ+E9JfS59VSmPyyrswKwvJlPmcdQX6HZV6tePB4gJkBxLHxe2Nkxln49jhrEOdDUFU89IvD6RsAvShbnRjNe6C6kj9T8IleEtsKRv5YqHxVBBGcS4rSaNEJWsCYZSy3oLmoqarBkF4BQW0IFIXfsN9ZrLRwurO38ljI/WsoENhXi74vFCn3T82Ec1I5sijJpZXkKkSfHjemrYrOMZyR9AWPYjk44GyEMUzkVpiHI+k+UqPBajXC6Vwtv+AnnC7HC4C5TjgLX165pSePKkmvXKd8dkDtkWaVHH65CeIU0vdflGBRwQaIu6ZoT/kJn0hWf1p4e1PR/6ho0OtZcjK36PTC7ttd+AKTHydqRBbBewjhRhoCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199018)(86362001)(66556008)(2906002)(66476007)(1076003)(2616005)(4326008)(8676002)(26005)(6512007)(66946007)(6506007)(186003)(316002)(6486002)(52116002)(38350700002)(6666004)(38100700002)(8936002)(5660300002)(7416002)(41300700001)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2cQCli2EdYcj4qSMzwMjYUbBdpGCld/1Ge/LmretqAkK/qCzIGgD5Ze3fRK?=
 =?us-ascii?Q?aNre4jHHlTeIdQ5MbT92yYfZG8Mok/lF6+ylgLiaykjhyYDcE5SbXw9sD2qi?=
 =?us-ascii?Q?HnIpyykbguZwiawpeVvE8ffF4rlKuGdDSmwMNFF22/rXboq0rWE5KE/tRLrt?=
 =?us-ascii?Q?gGppfbxwWlXf+bYC2GC989RQCcweCCIcS16P32kGfFLxyYB25+0QVdm3eFxS?=
 =?us-ascii?Q?sjl06HvAfANQv+1FWETsGq7WnnSu4XbcEnSt1Gq4QpDt+NpjS4B3l8p7YtdC?=
 =?us-ascii?Q?VYCN15UJjhO54znrkmzKdE7dRH1kJdPL9aMEoRj2e+1GSZc8dJBVDtGf5CjY?=
 =?us-ascii?Q?tLwpKGF5V7uorep1SxYKmGW5hpkGZt2egSZXC4Q1URnfNSqwqRZk3eul7J4c?=
 =?us-ascii?Q?dxU9Pj9PByHREEDJPP8vUZUaEVAoIpTSm7E2kTmsh18G6yJnukFPQ0HcDd6f?=
 =?us-ascii?Q?Z5ECOa8tU2eNDZe8L12ICfpF8tI8yc6SP/XFGnmrG1hiktKt3/SIVF9hDhcp?=
 =?us-ascii?Q?ztekYNNp8wwRNNWP1eohGEoK02xmfLZ3Waggth0R+iJw1Ly5bEs4L8D6mFth?=
 =?us-ascii?Q?x+jz5y2qffQ9DSQwLRGS4PMst4I/od1foUcVM8wWFlFnz/2tJJqwFiJk0JCN?=
 =?us-ascii?Q?V+L7eG5NZ3KRSVRoDwV02K+mfssfx1YRPjA23vlE5YqscnHmL6Cp/sBF94ZK?=
 =?us-ascii?Q?rqti0qV1ORBGX2It5JgGAlILz5GbSEyztFWgzSTqWuB9AvkxYKwB9RUFqYgF?=
 =?us-ascii?Q?gbDgq05M18G4gyZByWKC2LMTACL1abt5kgd7bSaMtpTGdyn4Nftggmjzh9t0?=
 =?us-ascii?Q?HJTGBGKfLirs2s2z6Pg3ISqUG+moYdnk36ONy1Ln46p/EvriwukeZk/JTdtu?=
 =?us-ascii?Q?AHwsTl+1wAmWq4e4DrSRXtDdm41jNIlYPTXXZ9BsITaVgURwLVZ8deELI9bu?=
 =?us-ascii?Q?7xWscbRN1nT9/uMTQDg50orh7ZO+TipMnhSyzCRNRniwC7icte0hURMD4aGP?=
 =?us-ascii?Q?LTpSmG8Wl9BXBp5Vk1DZ847EN1mcD2q7WrQj9bEvoAVG4tS4kcMv/f9BNy7q?=
 =?us-ascii?Q?Gcf/udepqm9wCo5TlzodAYDWxZBMUVmPC2J6LLLwpblxCS1QEMK75nVyVxIJ?=
 =?us-ascii?Q?SHHGazBYhymLHpshxQ74Pl0Fcgx3fbAmiryN0fV2jt2m0uB4AiwEBmg35Jfg?=
 =?us-ascii?Q?wWerN4hTjcRznvQ5wsow8wT1YiDPH7CMZtg3GYVpxSbpZdGkksdTRnEZhwuO?=
 =?us-ascii?Q?Hy1LdKyy7b6s5Px3PK8rJZq2umJt0hGoa9ER8eaeE3O2lVvJz8IFRrAoRTiL?=
 =?us-ascii?Q?d/zjUmnTgyGtSsJz0qG18rDYVdXXUzevMxlT3881zO7OpdxrZHbQ5T8TpsmR?=
 =?us-ascii?Q?5DhudmOLWsiZvWrtXladfUdIA+63+gotCUqmP6t0rqxzhpyj/TiEvEpKPbah?=
 =?us-ascii?Q?LZVxYEaR3LxFmQJSyBpp+ik5SAzcHr5ERDb4XFzz6vKKvgWhrfg2366HQqOL?=
 =?us-ascii?Q?sTXRUE1IWjqSyQUCQxFWvT1qa5mTxuOcJr0HsAZRy4lFObRXahnq/Rf3vz37?=
 =?us-ascii?Q?vOzU2Z8mHFycwO/8btC+wiSNH4mBm6QU8mRogX4K?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcd58447-b28c-4bd2-4ca9-08db0047deea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 09:21:29.0318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjtYHkgnqOLoIq7NBA2rJhIVwxpU0QXTaj5j3vBuk35OqI340N7eciYW4LJNTztG3jZ3rZsj6E9NWsRt5CeifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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
  remoteproc: elf_loader: introduce rproc_elf_find_shdr
  remoteproc: imx_rproc: add devtype
  remoteproc: imx_rproc: correct i.MX8MQ DDR Code alias mapping
  remoteproc: imx_rproc: force pointer type
  remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
  remoteproc: imx_rproc: set address of .interrupts section as bootaddr

 drivers/remoteproc/imx_rproc.c             | 58 ++++++++++++--
 drivers/remoteproc/imx_rproc.h             |  6 ++
 drivers/remoteproc/remoteproc_elf_loader.c | 93 +++++++++++++---------
 drivers/remoteproc/remoteproc_internal.h   |  2 +
 4 files changed, 114 insertions(+), 45 deletions(-)

-- 
2.37.1

