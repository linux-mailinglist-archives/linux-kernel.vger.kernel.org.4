Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC274FD02
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGLCXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGLCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:23:09 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D41720;
        Tue, 11 Jul 2023 19:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsWpMlaO5plu57w7jR30RYb3iACWfYbWPmgFluZiv9M32Ip1hd8C+12eMxTkXtd6B/hep2CzGWHz29zJaJRPK8s9esQT5x/Y65HKxc1ma0Frb4O7+uCJwi4QmxlcfB7lvlBBuKyBk9x/FCNbwqd3rnhpYgxnohR+jENdYJo2hH/463OyvkRVjqBeWvQIFHZmdz7N6/OwBmpZgeFjcTnwzTvJLtSPAc+5gfr+FNUF1WgfZ6osAoAcivfBPHVXLgf1D5iog3UiEUzLXZLha+LZ/EYL17yfNNLhagkYpvO3PpLY3ENzMz0/njEMp4b/M2/SLk1chBufZbUJmNhHtygJCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJXLNnetxioz9ii+SRrNEjBV5Cl9Pju8/4sl76cdMvE=;
 b=R9C+knr29vY7msbPGCXQZtGppZEeR1LVsjv71LpAUoG/RnwiTzXeRVi04JLogXbg4OETJzNxrXJ1Mlgf1ck4E+lGTGd4fKwl3+jsQK+hYN5fcF4GQsseZ4ZWlN2GrBUEFxku8Bw86vjSfpHEdunyH0htEBrd6PGdwR41QGiUnkZEjy915pnIRD5nPja4kJzLWWJlQ34nlL4i9XJwoZwFI20irMWPPnyP6cz/TdduUhcgdV0qX+MPJ9I4Yo/PxB5LXUGRjBDInxc6AcKRDZVW02wAEg/ETodG68XXNIwCwd89yC0fGCNtYrcUoy4EltQYuy1N8nDPi+BZEBxdnMLcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJXLNnetxioz9ii+SRrNEjBV5Cl9Pju8/4sl76cdMvE=;
 b=XT4WMkoYJLYLnoC/TgJu/Xs8j+VcMpQGm6ONuMNjeJa69C1MyUOAj97Pqd9XGjCWbyYT4NI8pHp2zCOEynpvJfsIbOi/7+kpzUx4qMIVFgIYQNyydxEj63Xk9iaAJ5/mN36AwdP/mrD4Jk48MAHV3aF4/+fq41DClCCn1dq805k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MN6PR10MB7467.namprd10.prod.outlook.com
 (2603:10b6:208:47f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 02:23:03 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::f575:8f7d:c91:5078%6]) with mapi id 15.20.6565.026; Wed, 12 Jul 2023
 02:23:02 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Daniel Machon <daniel.machon@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [RFC RESEND v1 pinctrl-next 0/1] add blink and activity functions to SGPIO
Date:   Tue, 11 Jul 2023 19:22:49 -0700
Message-Id: <20230712022250.2319557-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0034.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::47) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|MN6PR10MB7467:EE_
X-MS-Office365-Filtering-Correlation-Id: 06888a2c-e1be-45ad-c900-08db827eea73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SV9poL5eZlKygxUUX7A/PSIjBNckimP+GL8XSktI5M6yvNQ6i0Qz7lToUAJsLvUOpX5g6tfqWpTPIIrdJ1gIFeupu6fHrwwznsGxcx1JLsBbaDnnPfe36Zf5+Zmzk+0mC59hN2jq1WezlJeq5L2R5HnOP+/0IxLDG2NJEEC4xLvdfbD7nPk1TjVzptQ//8Lz/XL2FzvwXwJIrZ1EWrLSU8OnU+6ObmilWSbP0wGfwkJLWU9pDGxRqV6jjMf4sLNiVIU0zqO+i4McziN1At7vcE8xT5MLFTj7ucIzvCCyYvwKFQ8vRtb57ELDrsydxsMPBIsT6QUe410q4Sw2gOvC7clEeZSQFf9X3Sd2S/rk9R930/HxEJs92geakFGMRX8EXeVXkMRq7p6YjX1NeqbOf3Wx+4lUh3RHY/QZligwb6eWbHwPdGMt+iJJCtgYXq5e3sHwB8/2yZXvS1itYwAqQxyCSj8yBA15wO0yhERN9nRnAx2czP34JF0wlvGWdbEmtOOdBCyjOLleOrzR94UQbSSq/kTcIAppb6pGAQwKii+1jjifKhP2PINNA4KijMWTxyrR0cPffxXKuQCzjkLnw9ycF3vNFhGgkdVbORjQ/DKD8Xi/ydQv+iDuRRlNMQx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39840400004)(346002)(376002)(451199021)(38350700002)(54906003)(6666004)(6486002)(66899021)(52116002)(478600001)(7416002)(8936002)(36756003)(5660300002)(2906002)(86362001)(8676002)(44832011)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(41300700001)(26005)(186003)(6506007)(1076003)(2616005)(83380400001)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IA4tsEegAVuWR0RWBoQp7GkQAoQcmhM6ODJdFQHPGypr93ftfGJTgVA1h/YG?=
 =?us-ascii?Q?rHpSzDDGcLbavVIieS6a50Y1z07PG7Y0xVX2a1y9xMLU+ZXedBChVL+UaO9u?=
 =?us-ascii?Q?jDmUjS2uM3TXaT4xLH14SPqRAqVKNRs3Pa3djLk0riuCDeYPJCH/SHngpDCJ?=
 =?us-ascii?Q?NN6fhNDyQr+FZX/KzKytHxd624uswUOorx4B++VYullfnnr0xGfu22diXMDr?=
 =?us-ascii?Q?zi3HvSMPgLQwjJc9Wy+WxqjzSAgnlTf5+7GrEMfeuHWqZGKweqie/S+KVgsS?=
 =?us-ascii?Q?vviDsVwOdYByT4ekDS+fmlnkia5lSKoEWhy4+ZPYP4yOuX92LJsbV00b6eVH?=
 =?us-ascii?Q?z6AJbP3/LrQivcLB6daUZpAWoLvBCRPes/622cNpcCeq7KSyBtK6EHEjMsHA?=
 =?us-ascii?Q?W/td+K3lnDmFJI81a6MZkbQ9Hyb/N9ax9GgOUFFGrtszCACJ3E1oAylPKLB1?=
 =?us-ascii?Q?7ev7s5bcmRy85t3w8tqrW6CQCrEKT1p0INx2T/EgTXnRgeprlwGwR8viwR1Y?=
 =?us-ascii?Q?9frX+F2sAhOr9LrCc9/Vr9p/9s+6EKoLmtOXlRjIJLZPPZ5KIks5HVDehWhZ?=
 =?us-ascii?Q?KGky/BintVNQAMMHL7EKgjKKmpozl1enKO7iosln69GPdemwIOoqY+KshUNv?=
 =?us-ascii?Q?6NLOsUZssISPNRmVBefL8K5dr57bXvkBoPC30yBd1oS6R6i6w/9h7vs6hvG8?=
 =?us-ascii?Q?Wy8pbDT/iJsF6H5xZj1fNW7xiz7rQmHeAs/rnESo6jJHefv4kXe/No2uMpzF?=
 =?us-ascii?Q?rGaJMrLqABn+aOPLOGYjV5VyICTymaIaQYRRXz9Fx6QKMPqegMoeGA/Yi9o7?=
 =?us-ascii?Q?9wbWsStvuTsHp1ebNPzANt1TmF2fTKNhbcwOmOyhNIujULjAS920ESi8eyBu?=
 =?us-ascii?Q?XiiEDlqBb/wfrtFZ4Q1MpzP7n9eTzve4SUsoFM3o2Zem/w3SBClrOsJLsX/z?=
 =?us-ascii?Q?qa75rNSGZwqtlw3ilrHF16JLg9GVMNTT86ATUXpf8Wb4UXgCHuL/5VDMRaKv?=
 =?us-ascii?Q?OmQl0CXy93yFN9wOemK4lYPYzoWb40Oy5oiHTfwb6eA9pkkidu8Gua10+cYe?=
 =?us-ascii?Q?lJx9Woca77BN32FwTUjxrC26fhjtHdQZUNoJHhtyRkbDnRrp9p6ZHLzQPQtv?=
 =?us-ascii?Q?qySgBT9THmwIGpQI+8OZ0P7YtjaSkZ4p6FGDL+0WzUgbqgC2eEBU0E+MY6cD?=
 =?us-ascii?Q?Ipm8Oo9BZvwWhcTuc97B7XSAd6OTiVWi4SO2tXFJ19SpGCxURWaKlZQ3VZn8?=
 =?us-ascii?Q?PGQwYXBqtnkHpufozQy4RO5Cm9TXPEABSiOTun1xdmHwQMq0D+vgJJIvYTiL?=
 =?us-ascii?Q?mnuJ55qtWuHDwo8RvVLp9ngI2/D0b4zOp6lZs+KY2xcByYxJiaj7obLYsB/j?=
 =?us-ascii?Q?JgFZU64WRngfWUYjRwXgiba7phChG3hlzU9TRL/RTI5cnw02tX1fTliBlmm9?=
 =?us-ascii?Q?JYI09RKEyxQQS2kIP+sd8jtk0JZW8LpjAZVqaBe5tFh1IrZmqMWnLN7Yyd3I?=
 =?us-ascii?Q?lewHyoEtZZd3fx9YBH+a2joJ8LCipXuUlSMELrjrtY5CEdPKnX9b1PKXb4WH?=
 =?us-ascii?Q?VfTa6Ml0RF4ykgCbnPRyn8Ae2dPsUt3ZhguMQ/WfcUwKBHBT7n1X6gLwmg3B?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06888a2c-e1be-45ad-c900-08db827eea73
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 02:23:01.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +s5TA4wcAUIw9Y6qjKtyLQ1E4/PEDDdmCNS2p9lR472M5AYEc5+DPvAYjtJjnVBctMwFuJmhPfPVAHSt8A0YYelwWpTfv+3elFn4OYU3Tkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7467
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preface (new for resend):

This is a resend of a patch I'd sent a couple years back. At that time,
I was told to wait for hardware-offloaded LEDS. It looks like that time
has finally come, so I've changed this from PATCH down to an RFC to make
sure this is the right approach for the framework.

Ocelot chips (VSC7511, VSC7512, VSC7513, VSC7514) have support for
hardware-offloaded LEDs based on network activity. This is currenty
managed by way of pinctrl-microchip-sgpio (and this current patch).

The purpose of this resend is two-fold. First, to come up with an idea
of how this pinctrl-microchip-sgpio module can fit in with the new
hardware-offloaded netdev triggers Christian Marangi recently added. Is
this something that should be in the pinctrl module itself? Or should
there be a drivers/net/ethernet/mscc/ocelot_leds.c module that I should
add?

The second reason is maybe there's someone out there who might also be
considering implementing this. This might be a good starting point if
someone is eager to get coding. On my priority list, this is quite low
so I'll get to it eventually, but maybe not even in this dev cycle.
That's why I'm including the original patch.


Any suggestions on how to approach this problem are welcome.




(You can probably stop reading here)


Original Header:

Expose a debugfs / devicetree interface for Microsemi SGPIO controllers.
By writing values of 2-5, the SGPIO pins can be configured for either
automatic blinking or activity.

The implementation is modeled after the code in
/drivers/pinctrl/pinctrl-ocelot.c.

I have only tested this with currently out-of-tree patches for the
VSC7512 that I hope to get in soon. They are not needed for VSC7513 /
VSC7514, SPARX5, or LUTON - but I don't have any hardware to test.

Of note: the 7512 chip has a discrepancy between the datasheet and the
registers. The datahseet claims 20Hz blink default frequency, the
registers claim 5 Hz default frequency for BMODE_0. I override the
OCELOT registers to correct for this. I don't know if that is needed for
LUTON or SPARX, but having two blink modes at the same frequency isn't
beneficial. As such, I make the blink modes match the 5Hz / 20Hz for the
two modes.

Tested with VSC7512 by way of:
echo SGPIO_O_p1b0 {blink0,blink1,activity0,activity1} > 
/sys/kernel/debug/pinctrl/pinctrl-sgpio-pinctrl-sgpio-output/pinmux-select

LEDs blink!


Colin Foster (1):
  pinctrl: microchip-sgpio: add activity and blink functionality

 drivers/pinctrl/pinctrl-microchip-sgpio.c | 135 +++++++++++++++++++++-
 1 file changed, 130 insertions(+), 5 deletions(-)

-- 
2.25.1

