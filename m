Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3660CF5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiJYOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:41:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0821516252F;
        Tue, 25 Oct 2022 07:41:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1UlU4H/JZ/n2ie8KrLhl7xkow72Is4RWPJfzGrd9G5bKi3z2tmzrJl014sCWQJvnLvAy7W/yrt+hyj+6f34vlxKQG+dMTfwzSiuH1cAXvuazzZGoGafC0dEDLnnVbvekYgSiMmmidgkvgtV1UPEDgHKmQ5nyoMdTTJFufo72nQ2IKE9DxxYLdMdpLhSC/MeFaqf1ILQwKP+XpudLw+zgO7yhYUAbATbm6cvbmAhOGPdmEa57MJNQcyluWEpz3P6d0/FTrllzVt37dPugIERTzw9TD2D/m/Ufj+EHn3bbjEBg3Lia636gzYqf55t4CcjkeyeCAkF1bNKoY+uR+ReBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G2iaGGSMSO6AxfOo5Zj90EdHaJ3JSG8v3B787zvCRs=;
 b=DG3058efY5+HgbgwIDgeXRD5gcs1sG/Sj+6cLVreojuYhlcUp2DQvjrwjWurP138jxAaU8iDToCMz3v6IrRRnCh13kEhVo16mTBwxNC5jSq7tmmnIWa+H3iS+KYZgw9IBuTxLockNGKw3h5TeCweO7XsYf1genCBT9vtlRE4FfX/Uby2tvuqm3D6WyEDxiwuuOWzP3LHvdRblvx8h1u6QcraElTPOwe2JyMswLPgPjebl+HQ/DYLigiXhRrp8F6xVN1hVCd0aLLRgVaaJNDVw5wQEcns/51JofFUgNy71k0h8gKJtTcKVofs3P0mme5xzl9b9N2ccgdI041y8zIl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G2iaGGSMSO6AxfOo5Zj90EdHaJ3JSG8v3B787zvCRs=;
 b=SVhp14rLu8Fa24/fCtNA9ehLzuaW13Khl14ag+n6AGisVQ+E3uR3O5scaaylD9a3OwLXZHmuQ0z/KTlYThPOf61qED38eSI4h2OLM9razbbuMsz9ozzIwF2iZrx6cs3FdmZqx0fXcUiOL14Z08xyGrBE4o6ldB9runo/HP/FLSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com (2603:10a6:150:1e::22)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 14:41:54 +0000
Received: from GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a]) by GV1PR04MB9055.eurprd04.prod.outlook.com
 ([fe80::408d:4d9d:f80:620a%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 14:41:54 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rmk+kernel@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] arch: dts: specify the MDC frequency on Layerscape DPAA2 devices
Date:   Tue, 25 Oct 2022 17:41:14 +0300
Message-Id: <20221025144117.1010488-1-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To GV1PR04MB9055.eurprd04.prod.outlook.com
 (2603:10a6:150:1e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9055:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3bada9-1450-4878-64f9-08dab6970eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+1l5sqaF0bYLWDc7auH+TvBmOnUmKEXw8H20XIXzhReTc6th0Av0VCwJhIuuXdqzH4CVAdcSLChHw0dobQbhxrYvv34W+H7qjio3wH03hGrBu/aQGicfbY0DTNVCtCOF2HrrPwiWJG+0U+ddg2Gn9skyxXLYbcb77oYLugdth8cogyi9b8Z2LouOkg1BYOY5619CevytwBRMr7SlBiWWJQL1H33GiOKjyLE860pX+njxooxSgtSi7PNVXNytU/pqDDO7iRkcGwL1ERGGCLWfqam9A+iKWOW9eMl3wGENFUr6ZopPuqWm+4AT5RD4Yj0KRB4TE/MTiY7O2Gv3kYvsZIEvLEZvLV/AFD9x6hzrLum8kGSNdlgEe/nQimV5q5HCCaOuJP46Fle5UUVrqOx+WYsy6NvTAmZjlTQcV/MiClvu8Ik+X55VrFY8BAReLLvyhZkyEEYqgOXr4qQizzvmpHQkfDwBclQkDzmaFB5AVUBHYcmVy1UZqGed/fVaz1uyy0r145F9YFc21eJ3mwl5N19vS+VFksQfmkcJ3KeZGbp3hUP0QZ90BQsPfSpxQArfhJU7ZzIQcKG7M59S1LTG485rFAOqNlKzbuZIFZV4PM7rp4KMmUb6DmyobLnxAniq2vWVZSkaGo3sZu7iuNmez3jEq+5QmE/WR2YcdPusBbeKBlrV10IUozdSEqCXxUKNieIzP9u463Zk/k3ezQHgXJQkQRGV4Tu0ySuvqGLHs/3MsU6Kt1DqlCcMreKwJeb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9055.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199015)(36756003)(66476007)(44832011)(2906002)(4744005)(316002)(66946007)(41300700001)(4326008)(66556008)(8676002)(5660300002)(478600001)(6916009)(6486002)(8936002)(83380400001)(38350700002)(38100700002)(86362001)(6666004)(26005)(52116002)(6506007)(1076003)(186003)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3tzZk5mvvlMlbVM+zas+BJQwpdSd4sAALq8YQ7K8RKPiA2GIUI4/VQhbbqNh?=
 =?us-ascii?Q?oOjH8FbNtFr5sHd22zuWU+vSRyjzFJroVV9nfH38J+4I7gKqpnNf4VNbqDRI?=
 =?us-ascii?Q?76XfZ2ux1OOD8u19oT5WKUjrQ8FY2ENpodaNjzmiScZmWJ9AWh+2IpXEXzHC?=
 =?us-ascii?Q?TRb17MtGcaiNI92ixLoG7/9xHS5KwUofVwoeZ6afQLnlQC4/FSVyPzVeQ6Ql?=
 =?us-ascii?Q?rh0yskfbW2GuV6Xmg4pepxsnZZernLuC3NXnVo/Xp1q126jxkuVw7RIXbMCs?=
 =?us-ascii?Q?bbqLTPmU59vxsUS+o2dWZsg4YwGTnU4oIydyFDR+A0qh7wCeQVWUcxxb0+JB?=
 =?us-ascii?Q?Rc13e2WUMRzAfIOlssurU/Me98WVzmzOPQyTkOJKLouXJB2RCF8k56la9iSW?=
 =?us-ascii?Q?Ennr1Z19aiheG8JXzhZZjpptEbcMu7mUfOc8as6wT1W9YYVVVrNGiFCEoUMG?=
 =?us-ascii?Q?mHDM4iBWjy9zQNcbYS0ZRzNdI3xNZGHqxrzqq5U2LAS7YHMcmIp7+eltrFo5?=
 =?us-ascii?Q?MAH2NEqxCp/2mnvElgjn9EnjH8hKM0Sz80k8wOgbcjhIY2gSOf+O9zdauOgk?=
 =?us-ascii?Q?LkiNE7g/CQQell1hVG4i6R9FR8iJ30Xz9VJGQZSwPiGZTW/ZL7/xjlLOlBZS?=
 =?us-ascii?Q?pq/5cA5yqhJhXW5z9s6O2CJKwqiXOc3SE0GviqxSOw3X4uuGQyyEq8O1LqOG?=
 =?us-ascii?Q?IF3iSiN1ffiFWaAbP0YXbssRvpm4iFuwITnzzHkax9e6zT0iLLEVSGoYhtoB?=
 =?us-ascii?Q?WPxyBDfidbItPJU2EUj5QFQNVy7pMzhQPQxhtlqrLop6sBCIyFPIlRWhSzMB?=
 =?us-ascii?Q?rR+fm37/DTE+KB1wnUX+DBfeoK4cyp4TLvWwXSRF1TCCGns7MTYtcxlyJEkh?=
 =?us-ascii?Q?gENZPADGbE7MKFrUW1GTALF3LbnCRLfhsoEkAF2XA2AffJza91jFCtOo9fO/?=
 =?us-ascii?Q?7St9ov+aSw0lb/5cENNZQOLtt5jGZgMRqsmIuWVtGgBW5XP4PjKcw3o7D00y?=
 =?us-ascii?Q?3LEohRwQW2r21oaMYTqdvphJMGV16ib4kopUyvA2RPPXGlK4WA319dDeG+d4?=
 =?us-ascii?Q?MwBurJTuVG09v5OnoQ36Mrzu+YEsO2Qb/yaF6GUKJiWLSaqARDPjG0Y7UTyt?=
 =?us-ascii?Q?Bmyv5A/+GBx+/w+Qtezd2DvwHzfsbG1bG1DW2+evfCxREyNZg84vcUsS1XXm?=
 =?us-ascii?Q?6CJ99PPPQN/7ZDdZ+f7ShgI7sp7Sk7aKLJ6NBw5c6IMqSUCpewVqPugXbYT0?=
 =?us-ascii?Q?2GVy/xK/csgKw01Y3o4VZh1G+gNAFARKwPq8FOzViJyLX9vkTt8qQX3hh0LR?=
 =?us-ascii?Q?i6w1oTLFEFnNviDKY0Y1vTfdSH23Xbol0ntwb3TdQNvYieub0cdwhEInCkmf?=
 =?us-ascii?Q?EiVHsXI7vwWXZce0zuenCC27ZlUZw1hy7GsbHbXj1gWSjqx8Mkue21H6y+tg?=
 =?us-ascii?Q?hgDHBtDg1b1WD+iIAbbG6iVLV4iytx2jDyg1oWD+sfclT0SHvKiIws+cu1ik?=
 =?us-ascii?Q?qHtonZaz5aL2C/e7opdUZaIwqqDccmwlfAfEN3Tv3014x0RbPASUO5Q8IZQd?=
 =?us-ascii?Q?LbAAGwTR4tM3u3VEuBdqlcrWssK0xn0Z+SuQU8hL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3bada9-1450-4878-64f9-08dab6970eea
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9055.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 14:41:53.8998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8fS2pCmDlqNB1J6FmjBjPcfEBXVseu+KWcl+C4Ni1y8E4NA8AWfLuEmK1iGvS1BEc7EoQGWwrbLbNy7Uc6VEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the external MDIO controller frequency values relied
either on the default ones out of reset or on those setup by u-boot.
Let's just properly specify the MDC frequency in the DTS so that even
without u-boot's intervention Linux can drive the MDIO bus.

This patch set adds the needed properties on all DPAA2 based SoCs.

Ioana Ciornei (3):
  arm64: dts: lx2160a: specify clock frequencies for the MDIO
    controllers
  arm64: dts: ls1088a: specify clock frequencies for the MDIO
    controllers
  arm64: dts: ls208xa: specify clock frequencies for the MDIO
    controllers

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 6 ++++++
 3 files changed, 18 insertions(+)

-- 
2.25.1

