Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE337610DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJ1Jwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJ1JwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:52:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC82B602;
        Fri, 28 Oct 2022 02:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7u1IDth4dBC7QFN/PTNFRgAkmPatByAatAsov0G0Ri8bg/8KNfmxjE0x+b2cRuneNYLPLK3Uy9+Eu/KS/UzeSvxhp63EOv9aiMlKCRhoyGyvklmv5qOStvRZ3Qs3oU1OUqEs4FbmJA0AC5vR2sSKcgq9zOiDMABdnA1ghykwe3kqnwV4pFavskg+mzJiOwwVG46swlBMq+t/3KsGkQ1I1I5StCjNsMyHdE21SXRcGAMnaWjR+NVbVXHT3dEnDorPLHWoRPsNWNR7izAw2Shq8Y8yP8ZK/sWk4KBBQN2TThMsQ0F4OpvHGEFVjjpDl3xyxcNRcIhCuAayrUljyoF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTAJH/n/0birU4jqMMlLt2ByZOBSv9bdV4+k9Zqdrrs=;
 b=cSRV+Lq2Wwstc4zVU88gan6PBSkRjPsPTCW7qH/Ab3j9hlXSYEJ6H9fKJHEZODCoA1IMB+nSRv2wCRqlzZ+5MO8zxRMT4f+Rr29pLvLU1nuKcDsMt9QHzI2fQOTCU2QLv7dYESeRDsYTCh+4SsKNPvyFdub56Q/2ZnGXoT9U7xZAiKkVjtPEeQ+Dka7bgE0jj98T7mqKSeaogOOJ/v7M3n11AxU7EhlHnicQ/c2H6h0AA4KVEZZWqHXCoooYBxbnjCC/d7VZLmn1cNTjUGedG5lKAlmEy3uQjIE3gAHuQfd1EEC7iO+bn5sXty/CMy7MxbMtIlP5NJJJASpLAsAlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTAJH/n/0birU4jqMMlLt2ByZOBSv9bdV4+k9Zqdrrs=;
 b=NC8kjnTxzgFO7sK25OE8gZcaGDUnq8Ld900UVTO3TJiORTHjop1fCa8WEVOO6GYd+cilhdEdBMGOKYmorYiLzavxqn1bSp/4mjI/udYOTOy9KeD8WC2oB4hixfVnouNDFNoq9Ju83hAwdGPV4vL4xiJAxeomFqpBzEGmcWcg6Qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8853.eurprd04.prod.outlook.com (2603:10a6:10:2e0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Fri, 28 Oct
 2022 09:50:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1587:379:da06:2f18%5]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 09:50:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] clk: imx93: fix and update
Date:   Fri, 28 Oct 2022 17:52:05 +0800
Message-Id: <20221028095211.2598312-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ec03bf-e7ca-4455-c306-08dab8c9e3b1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0NgYYyh/f8xGIBJQQYDwB8cluBPhbHa9cGxCsmjVCIMTLWcV4VtsanQkpbaC33kxS62ejEAW+6x8eMjG8+rxcLgIGUF/H+QZBb8fqxD2Hw8DcXJZI2UGPn7THeEQFKZ6NAMLNXGM/+jw4G0qXFDjN21PkCBCkiqZC1/8/uxSBw/5Z8q/ytC/RHKyL9NciWaIZ26F1h8tkoEj2Z0eC5h/9PeJvUAfAWm1++/bwll3lemziT2tcli2VfaAxEde0NPa0S7f3hYneyblZI4l9+opPofVQ/tzcFWpnedKw3JMa4pgqGobHSbIVswEQ2o7fe/wmv5mMwFy/u1MYkVh7cr7A4p2R2R3XWRzwm+HDH76MUubgBVEr7C+d9RGdXWMoU1dHJHxWnF/LtW7zHdmtlrEEHSICFc2LJJNKKXAuRSCCtXLcfRrgbk1Mz4P7ybEHiVD0XQuJa6gvN2aSulPY5RYRj4NPYMk0Bibgc1o1Udw6neza1XN+bahywPtkACQOVAmOzIyL9q66seiwabHP+nsTF1UJOh4Ni1iv5FifJTsHevvOe/BkZGKCV7UAqE0ZgqyfFLXAmF15I5yTnzoHwv3TcUbLzsAkUMFuMo6XL7lPDDMYoOKJYa/3cUEoZH6j+Xws7PVwaoTQ21Hq2RpmDYwv6EBnL1XmC2F9gSJDWZ+ysTEBHBig6UkXtuWSXX61h/MbF8q6cPJ6xkTyLdjFrbWlsaI6CXLUOPkdbf4ehzfQxL5bSOWozikfMR9lDxiXB8T0/J41++cr3mmw5Hx5jYT95ol7EnbB+e3K2IMgwscWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(478600001)(38100700002)(38350700002)(6486002)(921005)(1076003)(316002)(6666004)(4326008)(8936002)(186003)(52116002)(6506007)(26005)(83380400001)(41300700001)(86362001)(66946007)(15650500001)(2906002)(6512007)(8676002)(66476007)(66556008)(2616005)(7416002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zeOTQb9C5NUgYaUpgPo/gMZ4jVvaK6Efh8+gKg6bTLZc/1tyKk8wkt6G+gv7?=
 =?us-ascii?Q?cFnVBZ3U6+ZXE+ruQdITbM5uH1zZiqqcNdIxRNzu5OSl+qorBRIZpv55dU7c?=
 =?us-ascii?Q?pk39AM8sTHD4eKF81qAWbcL/3QyHGwY+SBgrw9lPacPclVmE3St3vxeKgFVk?=
 =?us-ascii?Q?nlKG9eBYYqZE7Wg1IddDygw2TxnMtQz5lbk5f4WKHXyENQcE4txgQstm5t2x?=
 =?us-ascii?Q?KkdRs0hqEGpltAtPMDh/+RuX2mrZE2SZfrfcQiduzvygWwWlsMVmsNje2Hrl?=
 =?us-ascii?Q?F83WcanTW3wKveFoBsUNbCEvUwapKjrq2ZBJz+1ugZ8TXqnGMOcC+2LYbwnq?=
 =?us-ascii?Q?8s8cRqJDDte5InYSW7gfWu5gMtxcc2jv3irPFcbzkAGW8DX+OU+NByb1WEkj?=
 =?us-ascii?Q?CRKwJRVYowZ4JW+qTE6bDOpqKLihQwefxHF0pNQTtt2wwuzUQUw2L0UMTO0F?=
 =?us-ascii?Q?gvQy2n6VqtiVMYOsudcNyDrVRSnR/R1G9Z157y4Q3aOvZxoOg5f+LBNvvBAS?=
 =?us-ascii?Q?YxRiWunxRpKHJOWcDKTqGvW72y69cfLSEI+CEwEXjx+b9dG6UdveVpjmZQhy?=
 =?us-ascii?Q?DHM4FDcrFwRLe68IX6vLqUGowRNcTuoKrtWyEVykh8dy1XgLJ68JmA5GHLm7?=
 =?us-ascii?Q?/vdJthp0Q15b1Gs8F3IGDEjAoyYKenOHKAbQ3f/4How071zNVhnNGyIsgJsR?=
 =?us-ascii?Q?vcb/UL264DnAWYE1DtAtn4aoyy7DvEmaP2EnDroMcUlFGX2nYTqlqXI15L8n?=
 =?us-ascii?Q?8bC4IZ8n81i46TnxYGczIcfgszcIxMRRJ53iZpH7pVEBv0sDt2NUtf4E3N2J?=
 =?us-ascii?Q?BYTT7cajAHth+LCFm0wUahCNk67S90WduGFX58b21oCUwaNHsLHV5WXF/Prk?=
 =?us-ascii?Q?F0giQfnp40ehksAJudK7tf4VS2pECXautfZDyVx7rn5Dd+m3qCv+UNvdxYEs?=
 =?us-ascii?Q?naAS1i38zDi/oxPcSycBt0+NiK1aPe9uSBYD4eiY6oaJRWoMMxd+tzGWCGUN?=
 =?us-ascii?Q?tuWFLhe9OYWMnil2DavMQqi0z7Tv9iuFYquDoklFI1v+ce4jt76sXo3qab3p?=
 =?us-ascii?Q?YZvoOWLgJ7oIzwFToahWCNr/T8YW9ixOWY2F7AIbTPhbGa3AuobyZFYLIjo4?=
 =?us-ascii?Q?pKEnjA4ojTD3E1Fs8U0pIo3iBDIuDoE6UqM4cKM8GgZhSeWMfvtD7Eta3fTR?=
 =?us-ascii?Q?kRxnwh8lFsXXhL5TJMtCTIhOlico/HT1v71ILu/Q7pMD9sWOIuh6mc7InrzY?=
 =?us-ascii?Q?trtWV6Gef9oPxo/810TzDRtD4uaZP7lWhqHcNav6IgqIl2mphvJpoPkdw+IH?=
 =?us-ascii?Q?EB5FxRcXNhjJ6e4g9Og+MLqHNkveLAGD8T85GE1FFP0GF1lZo/KEwWH8ZDDc?=
 =?us-ascii?Q?UvEpSFPF1GJ37h+nm8r1xALIKFEEvngtVYRG8RC4b23KeSJQq3ByT63ilDT1?=
 =?us-ascii?Q?KN7QDZ65QY76W57iOA0X0UkZeSLJGCnXLAxgN4oLle/EWqUB7L4jfXQcOzKU?=
 =?us-ascii?Q?c8nw+lpmpBy4Qzsm4u/X+KyiEmNENLsYhaPUcvX4e+URmppXzxtmmA7CMtHa?=
 =?us-ascii?Q?KAeikC1v4M/oGZGpU+LxuNcLTSyDlpWcAhqeTwEo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ec03bf-e7ca-4455-c306-08dab8c9e3b1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:50:47.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuZKQJgP+nfZ7P0Y5Tm+pyrSZCJz/zMcM31SbpPBWICgHXqHGaWFxuHN+gisCfGPvSwdCjNxtE2RX2baPAgcsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Update commit log for patch 3
 Add comment for critial clock for patch 5,6

patch 1 is reported by Dan and marked as fix

During our development, per updated reference mannual and design
information, correct enet and drop tpm 1/3, lpit 1/2.

The TPM/LPIT patch 3,4 are not marked as fixes, there is no user,
so update binding and driver both.

Patch 5 enable HSIO root always on
Patch 6 enable sysctr always on for cpuidle

Jacky Bai (2):
  clk: imx: keep hsio bus clock always on
  clk: imx93: keep sys ctr clock always on

Peng Fan (4):
  clk: imx93: unmap anatop base in error handling path
  clk: imx93: correct enet clock
  dt-bindings: clock: imx93: drop TPM1/3 LPIT1/2 entry
  clk: imx93: drop tpm1/3, lpit1/2 clk

 drivers/clk/imx/clk-imx93.c             | 38 ++++++++++++++-----------
 include/dt-bindings/clock/imx93-clock.h |  4 ---
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.37.1

