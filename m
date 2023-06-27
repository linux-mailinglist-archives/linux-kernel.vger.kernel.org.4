Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1845740137
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjF0QcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjF0Qbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:31:48 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A803AA7;
        Tue, 27 Jun 2023 09:31:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjwuLiMYFIxuSkC/SW59wKTYqTIAozsfD8DMOA9y7Myi1yTl5C8q5w5NFmV1JAskderNPR38bvJr96wULDkfPtsmoFGh2ToKt3hpWtPwrAmauz1fKkXDx0hSe5tXiPdCEB9HvriAjvdVEPVIDlwovgtzUnFBcKq2oOL3hrdA04Azb+x04Qk/IfzoYqnQhpwbnSI7E3TLslmngwrKz8srHxG4HqkAIbYHpbISvNP3MT8byXtQJOrwggjNkrZUAdJMeMa97L3aOLLFubq7iE46WgPoG7KS02yt2lu+QOkVjY59hNcsRp5AC/O1pT8uO4WbntUzWlnAKPbEMX2VHxzEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4qcaUqNanHHtxoAPK5Ov1WCMrI4/cQtkes7O0mwpxg=;
 b=Dp6UBO3SPLdBU51RVueiD0pPLOwwdbuzTSRdPoWcwQvdYAteIq8bVr1ULIJrFfJTP8SaEqLbOe8QOLp6KUiyS+A+NAakdUEUdwp+u305iEj2mGl5QO3Tv0RY/ZA/QvOIsKSvjh4o7KPh4IXdS73LI5pmBBmu4xJH1yjlA1NwqeNsMk1hlLLqJZo+lJL8ptiY+6ypOs4Ds6ch7rj4TmpnPc2oUPzCIoKLdwd8Y5j2XtX2csyCoiYaOTitKkeOFAGPvl5cOowbNO2T/lLtXpP1wioLOF5E/oksh97xPa8lf8z53KbORRcDoRJQmNmgEBoAy25Q1ykdVUTp0iKy6Usv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4qcaUqNanHHtxoAPK5Ov1WCMrI4/cQtkes7O0mwpxg=;
 b=rxZlrrcJjUoP5gvzU1dLQWI2ovSl37ZCi9Ctwkgnk+cAYnUTNTeYZZx9WWNieFEgni6oYLQ7/nitHeyaUBV/IeN52fOkzHC9zkyIpNOM8rvGmR5s16b1AGX8Bnc0WarzUGDKau3JSn7t3B67qVa18j7bl3eM4S+URUV1K0mh3So=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM8PR04MB7314.eurprd04.prod.outlook.com (2603:10a6:20b:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 16:31:28 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 16:31:28 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/3] Fix PTP packet drops with ocelot-8021q DSA tag protocol
Date:   Tue, 27 Jun 2023 19:31:11 +0300
Message-Id: <20230627163114.3561597-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM8PR04MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a220490-378a-4cea-a1cf-08db772bf53b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8GqNhUSy3M8513zvQEeBHC+khcu7E3ZxNcNd1U4usI1tGtH5AAbxNfUUVmNd3NWtGlRdpxiKnBTyIiSNUJuurFIadmSHLk1xpJ/VOjXpa337VPh9HET0/TbAuPvxe9ObOIxZ14j2+m8sHqdWI0e3dV5wuy/OMRtf1UInyEwy/cGNdF3v8wB3tSjCzegT2PL+aA+8AFjEekPJkwTIlFFUrxYhcoFAdOxEtV74Lwr3/WaUrE/XDVR5Uzt4Gs6oB2NkhhNz/xn7AIS5XnNZdDj4Ee7RIgdbUE4K23sM48xAmBHqe3m/+QdkUzSqzMr+b09OyOEakrIjFmYnKINPFeabn+aFQR8yDuR3lnJeaSebg7otMXmqbqxKu+ygohP5MuheouNnKWDFFx03r7tceCM+2fQELhxpB9eal8P1fu+rYwHRcFZH9UyNuzIRLek8r01+AJrnt/3Lw3k6gdeC1UjUTj/Fp0DBQgYOAUfwoD2nWTJSRDAPP8E/1RKEl6oxhUrHo0I3ivFRBIoxU49lkH3Nfbd6+hhdEnqa/hLCXVjMNVy6JIqrhz5EIHEX8LVcMjb68wTMEwpXH5MvjE3yOYKKB8fZpH9jZhw/4KNhchpetA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6512007)(1076003)(44832011)(7416002)(66556008)(4326008)(6916009)(66946007)(478600001)(316002)(36756003)(8936002)(66476007)(5660300002)(8676002)(2906002)(966005)(86362001)(54906003)(41300700001)(26005)(52116002)(6486002)(186003)(6506007)(38100700002)(6666004)(38350700002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sLD0+l1wEB2OiATaRePzeCyWeRPG1WU7yD/eH3Qm4mta34JaNAFoqxWZYHbZ?=
 =?us-ascii?Q?r5OFx+CYDgoht+UWXDlOjoi1BeETk83Hfpaw3klUIPZoliyp+Oh+f/qXFvKP?=
 =?us-ascii?Q?XSq/lYc4hGUfv8P0MJMetcS3XlMZOTTDIFwQgZRtjcd94u8oI7TNC/+LL8jI?=
 =?us-ascii?Q?2ZyDqMcyA6ZoQk8XOhuaN1nuuD4lf7G8hsdxDphLDnjxYyHIUF2x+5joSGx7?=
 =?us-ascii?Q?yOs6dOjjUJUpxcELdcjpT9qW8eGyqvRVv/dsApCeyBSK8xseKxIpN+X/Z7a4?=
 =?us-ascii?Q?JYIAs6LqKr85bL2wcLHaLf8Zj6+ITjiUFINY7nvn7Mtyy8hhmSjrRbtVhE0c?=
 =?us-ascii?Q?dNZrG6IvbPeR1MQ5JjvUdpzSZq/5lcxQhzPNNfq+71GfJB8mUhjyBoj2K/Ei?=
 =?us-ascii?Q?sc6OBEEKTLMLF5Hmqzhs891JHnuUFo8wzK07/YmDutttHtXBtBtKESPB6cJi?=
 =?us-ascii?Q?usXMdHl2KHe1QpLUSO8YMfRPJHOhr4aV0tovgHNQzKXG5pUiYr+VJwPHlyWs?=
 =?us-ascii?Q?92udLo9wDa7imAK8w6h0I6eNw3bG3+N7BFa8eZ9tZYnX0TH/LDFRWickqk/p?=
 =?us-ascii?Q?ljEGMetV4A3mBzWawBB8sfKYujLYbx6o0U3xnPcXUCaiGfFYyCe9Slnzjmht?=
 =?us-ascii?Q?cdAe/7ArxX/J5nLIBT07E7q8OHuPH/nLw2SvpdIqXDy6jV/IqbEjGQg7003D?=
 =?us-ascii?Q?eVNHOAqys9wDie6UMziUED6nVWffPKJvX1dZB73FDficI8tqsQj/VihTVRNZ?=
 =?us-ascii?Q?dtX2wjpKdm01JfrdgEzmd2lxYx4GU8NoerZNy40zCfZU3TDzPBdzVlgJdgcK?=
 =?us-ascii?Q?UVF8y2Mjaty/tKBEFcGXnLsX8ubo+53ZMJORUmJmRkQZ1r/TQOeaRM/bwUBQ?=
 =?us-ascii?Q?02HU1GatS1kzaicgsooJx9wFThdmr5uz6i//kLGpPAECGIkYOCSXfkE9bJC7?=
 =?us-ascii?Q?frzB+vydcsyU7M/z1NBe0NFEIdmmOCsAUvYKn2PA4KOfueeT+48zrvHiXG6z?=
 =?us-ascii?Q?cLpvO0EUFOR2WGYiHzLf9sFl1Sc5MwUn4GnWRN95Mzbb+3FJ7Rjde3nerxtL?=
 =?us-ascii?Q?PuRILgc7jkSRLI4Lbd/jPpqXBRgMWxexTefX2sBcw7YqmmnEAvHa/I5qT46I?=
 =?us-ascii?Q?X+Oy+de3v7o6WeBtx0XqBW3DR7Kpg4Ei9oj2MIi7rxwbHFXrU/oQcBMIm8iD?=
 =?us-ascii?Q?zXrhSa+XkWK/eOHLAs0IHUFNN/x1jaazO0u1uUb4aobfYAjnguSjdyds6mqQ?=
 =?us-ascii?Q?9ureIo2WDaaYBXP6tzElDG760ntTvvqrUbGPNaNLozlW/mhjyyvK1pSRUHbk?=
 =?us-ascii?Q?YnIl+1jQVPPQG6jWbObenxkZajcEQrCH+qNDQ/R5RPryeysO1LmuvR7Gcll+?=
 =?us-ascii?Q?154N+kouNhlhmyL8cfLglU50jH0PddiAm/yw3QCd9Od7Cgx9FchcueE6RnVu?=
 =?us-ascii?Q?FM6NdRb5mDhW3DamWlPI9sFRgHAoVJrLmNfTSwPiCdi3RLhoz4SGBrsb5cjY?=
 =?us-ascii?Q?r/qXSGUmXNqFH/SLgFScX+v8jXH625CKHZACE4IvE/W+OEsSVFzDwdAw+ygL?=
 =?us-ascii?Q?Uuf5Ud6yyGpyd4iNOBl5V/3BoAI7O+8kSeQ36wkbeweZH/bhL/0mAJxHWycl?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a220490-378a-4cea-a1cf-08db772bf53b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 16:31:28.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHewWaEtux2AhH2v2OR3FMYhMpTi+w3ebQPfcr8noXLwWEHGty3yxJf+DRYS8ghufcVkjIsZG750E0zYcRtdGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Distinguish between L2 and L4 PTP packets
v1 at:
https://lore.kernel.org/netdev/20230626154003.3153076-1-vladimir.oltean@nxp.com/

Patch 3/3 fixes an issue with the ocelot/felix driver, where it would
drop PTP traffic on RX unless hardware timestamping for that packet type
was enabled.

Fixing that requires the driver to know whether it had previously
configured the hardware to timestamp PTP packets on that port. But it
cannot correctly determine that today using the existing code structure,
so patches 1/3 and 2/3 fix the control path of the code such that
ocelot->ports[port]->trap_proto faithfully reflects whether that
configuration took place.

Vladimir Oltean (3):
  net: mscc: ocelot: don't report that RX timestamping is enabled by
    default
  net: mscc: ocelot: don't keep PTP configuration of all ports in single
    structure
  net: dsa: felix: don't drop PTP frames with tag_8021q when RX
    timestamping is disabled

 drivers/net/dsa/ocelot/felix.c         | 12 +++++
 drivers/net/ethernet/mscc/ocelot.c     |  1 -
 drivers/net/ethernet/mscc/ocelot_ptp.c | 66 ++++++++++++++++----------
 include/soc/mscc/ocelot.h              | 10 ++--
 4 files changed, 60 insertions(+), 29 deletions(-)

-- 
2.34.1

