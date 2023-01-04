Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DB365CAC1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjADAZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238403AbjADAYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:24:52 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49754167DD;
        Tue,  3 Jan 2023 16:24:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB5A8cyaXSDg2fpHK7ROJ1wlW1nPcDODFQUOmJPrM3RfquRxSONEvbwg63MmJSQML6bfudcV1X/Ixuj0F79IAEtXZ6n8SPbqGFskxzXlz4PlcgsxWOKKTvsWFez4F1TPisO9ixIr8p4pHcoZAWftDqhcU6FzMM2jtRR1I3tpMC+hy0LQw+/YiA7vtFoCFp2iHDQaBNw4o5rnoJce+MJ3VNbi0qjLB/NwPwD4M20+d9nSt0T85Tlzuoa/hFhjc0qMvV5skYPQ7ad/ohfkkBUtY1vfBKlchjSjAdLLaJGg1+tzH4JfxAaDXqxF0oAEVEdM6M/zWt5RXCGhso3clLQDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYXBidzfSx9UqlDLOvX+s464vv8nWcWD6mUSqYYuzos=;
 b=P1hGh3mzP5dN9SCx1Jfi+xj07/BMykiCujA0C1Jf6fWuOBp0arae4YcxgWX7fHb6rfP0/fZ/YmOSLdh8MrdrNABGIrpXBPUH4Y73frKtnOGloGQOPUCQsebBkrNAKx4qOE2gGZhH+7c/I/WYbz2XdqkXKTTfiyjzXwStGawSQ/8iQ6nYwiVkuZA1tfoZ9sJaucAsRoUoFJc5dPNjE2qdOrOrOEOQwXijjXP9bNdyMRs4dGh+0CgXMDcPf6l2tkUuP1KltLLckZFXV37E78UzGzog0E3CUM9k+iTvZfXPKMK37vTtbZOGHjwgr/XSp/T6oQpZRd2q8C42qIICrJ/cBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYXBidzfSx9UqlDLOvX+s464vv8nWcWD6mUSqYYuzos=;
 b=cgxm3rR+Kl16hlIfXmYxyxUWf1JiYtzJLJ5hTaZ6tGUXqqc+Apzko9I89vVDqeOigkEga+mGc4GjC2YBhyA70LVhlooH3H9TzSm3ZhyHTiuY672g5r/2udaNY+SxwHTgFg251KiirbMlcKyTQrH6aExCy1t4aNsrF3v0pArgelk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 00:24:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 00:24:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V2 4/5] arm64: dts: imx8mn: update iomuxc-gpr node name
Date:   Wed,  4 Jan 2023 08:25:44 +0800
Message-Id: <20230104002545.3473598-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
References: <20230104002545.3473598-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 55955900-7e2d-49e7-1346-08daedea14ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kGJj9ddh+DqNwS1fqdlDl9TbEGjiajG6X11RB4VUjxWnEkuVpSFWM6yTk9FYzWS45UOehGp8lYtz2NIufl2yAVff24GpyY7N4s7mDFXY4SaDaCzNYzkPH+Mf5s24nTlZ8XDmstrADcVeftq4XR+uNtgiKN4Y/HHVOCOS7KEK3ZzmR/76qHTdgyPex5BQZiIUwAj9oB6lHn/wcuN7EbDwjy6fAfBXWAHeyH7TS6Uc0gY4FN6Fepb23c0ouK5OnyeFRqmcToNUB4usc22Hhb9kaKOwS1Q7+NRValZPpZ40VLsDuvHD2KsoRQyf9AAQyVHWK3iLrEUMPJB5rFpWPjkpuOjCb9NgL9hBbKjt3rbgaZHVqQUfn4b51Zrnt1VFQzzYJMBDqV2TBEMFgaX1wJiEH+mMiF0ygic5scWM4FvrbcLdAxqvSJijKHZcf/ZV25UbYf1CgikwjsQYAlu27jb1hvywA2Xxsk5Tw7OqPPJcQV5nt8uAP2vHXOb1Hekpt/i517CvgrgkAXhjTi1xIj3DplT0/S0q3qzS8ldO2zvLJkxfx6CaXbdU4KC9VyGJ6hypQoAC2a5bPdnb8ZOsnGOzCqklUq0OPVih2UhpLr6/zdKJQpB/JCUwfHMwR6Io62s4W2FZfTjKwtxKZyahKV21TD36Vd/Xr6sl5BeoqN1YX1uEm9zLoMefbx0e78Zo4ep25tFaj5DaUCGfXogT+K9uDI+E5DKlno7o0LN7vRyRek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199015)(26005)(186003)(6512007)(83380400001)(1076003)(2616005)(86362001)(38100700002)(38350700002)(54906003)(2906002)(316002)(4326008)(66946007)(41300700001)(4744005)(8936002)(5660300002)(7416002)(8676002)(66476007)(478600001)(66556008)(6486002)(52116002)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTS2zpbHEt9jh9AyxtWFpj+fkNy6TF62+sLTSPJeaa4gYHn0pTBdWJ4xd/em?=
 =?us-ascii?Q?iNP76ehrIGZax6ywH6Do+T7ieGd5BNCI1voXjDvGMMX4MEqmesHebz6ycocV?=
 =?us-ascii?Q?7OGvpYmJQFDm/mqFbFjJPCgS2uLG+0xS1lTAxtxRpFgi9Ww0+EkPv4/c7/Kd?=
 =?us-ascii?Q?RAnZKQ3ESwQqRG2otFG/ME7oVkqhAOyG68VlTUdqVBoF+nmCqzwTkPNzLr9P?=
 =?us-ascii?Q?hyqqGAfyDc24Bfiz6gOFtAz0nZDzFYm6ugssabuGRvpnijIPCrGOp1Yvcq8d?=
 =?us-ascii?Q?qhBYniOL4n/02dUngDjEJs6JfmjI2zQNCD9J0qpDcSGc6gej0IW6F9Cl3okb?=
 =?us-ascii?Q?8W5E1g/v4oYtYpcTlLRLE8rEd5icPbme3Co/JH3JImZGSXi2MsAnjQTXKMLB?=
 =?us-ascii?Q?N9Vonbt+iqMK7XF88e6l28KotkeN6kHnDgAk0NyttR8zROet7NHZBjL/N4gN?=
 =?us-ascii?Q?YNHUFfH7CnQE6B4ujlvqvGmiXPd3yIg0E6YSnuNh1aSlWSwoDb8QM9iRNZzQ?=
 =?us-ascii?Q?hbhFYSGI0J3fhbNGYiZaJZEIhNY/u1zj2wctY4+kDly6cSyA3+eAEW1Pk/3v?=
 =?us-ascii?Q?Z4NmBY6tVZ7lBHqQOD74oQNzFn/G5zXKY+njpbwHfnv33cIbk2BvPwLh3h8O?=
 =?us-ascii?Q?V/r1NcDoK5/SFlB2q6PMpEiNXd7AOZfQip0Hh083omFN/DoaEKPxwTAeJSUc?=
 =?us-ascii?Q?HaxK+36JX1hSfMsP8kLRSbP+pCrQlefXKqvsi8IW+HNFJYn0roaNLucTo7F4?=
 =?us-ascii?Q?djw7o/md3iWoVWotCc2Yc1mO7ZI0ANJo3FkqaAOYYqEqpGU6a5yfrRngCxcy?=
 =?us-ascii?Q?NSHL/MwEoCHzDBIeDvOriax9ehy9ytwW6V2YEr3xwE55QcH8jrdO7kZKuCtI?=
 =?us-ascii?Q?OYgpIUT2qD4u5RPG2El8mX9Z8wYIT8hTr345ucnmKXsz3jvCufYWqylh7JNA?=
 =?us-ascii?Q?P38FTfbOomiy+9jwS4Mdt7aKg9gI8ekC54urkMCgJClcsfi0JhtqnuX46unr?=
 =?us-ascii?Q?b1S/XdGeYu9yVqHmViIHv1NcOjTwwx/o4vO9DeQ3qwTFTVvM4BVyohOXpYmC?=
 =?us-ascii?Q?i/2meP5OMF1WDPMYL/LKCfJ+S8KNAFwveBHkon2ABOHqKK/56+iTOz2ssBrv?=
 =?us-ascii?Q?aG+kIkW8Vn3KxUn5W/J1UekjKeEIN8PO4gsJ7sBh8p99CAxhtkyNn9k6zNrW?=
 =?us-ascii?Q?OHms6QGiqxsYZGpeC8T5ZuVbEvEQ3elzb1u2DrpyIcJ3rY52m1tJFYiGKiRR?=
 =?us-ascii?Q?ainaZKEZcZQXBeUSzKxca3HkxvP31mwd1M00WQziM12v+/Mck8j9+MEMUTpH?=
 =?us-ascii?Q?eVsKI5JTreVgfsu9OkAh3UCIbRvVPPl/HxfljeBP7efxFBkHqczz+iHEXfXa?=
 =?us-ascii?Q?3hsbc1ehtDX2wwjG1KpFjfo2GHNPR+28Lac6cifT7cx3npUSnEQ8WWvxkn5y?=
 =?us-ascii?Q?vVofbbeYtZ7/nU3KrTYJikRlxOQqXzwbLhy/KN3C7VgGmPGS9rDOg/ijjSWC?=
 =?us-ascii?Q?SyjkrYrnEjPLAO2ERziW/Twyu9NR/Y7veIOoWaolaKxnuOi4NHVImTsFHms7?=
 =?us-ascii?Q?q8PkKWbRHks0Jk7tLmj9T3pfUS0mFNsk+SKF5jhM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55955900-7e2d-49e7-1346-08daedea14ce
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 00:24:45.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd8KI6GnYgPiSuFhTsqBO7+jVQejg+J+FlcP+0sjokznGt9NSXMpLUnHtzGS25KSU1PhVh09wB6WODmEuqLDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is better use syscon for IOMUXC GPR, since it contains various
bits for system control

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index b7d91df71cc2..08ca91bb1887 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -552,7 +552,7 @@ iomuxc: pinctrl@30330000 {
 				reg = <0x30330000 0x10000>;
 			};
 
-			gpr: iomuxc-gpr@30340000 {
+			gpr: syscon@30340000 {
 				compatible = "fsl,imx8mn-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
-- 
2.37.1

