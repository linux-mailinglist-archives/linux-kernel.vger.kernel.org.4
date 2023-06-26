Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E55C73E39B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFZPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjFZPk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:40:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3EAB;
        Mon, 26 Jun 2023 08:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0pGzpkMBrEZdxv8FckJnxe65vyl9hiypRo0BgENxePojem1u0JrAmO0mi9VGtORuBPdmxnxcr3Uputw/kkiw/BPCHwiMG5MQm45C0IE4J0jGAw45fzZDCWUA2Q4BBOgimuhQRUX6bfqzbohJc31/KTBGt5sBE2H2gND+WATOLRks6fsaav/EOlHH3xShP9IlZiIfPlwsPr7xjNrS2c3Wply5w/vLe6KBGA97S7Tl2EzUF85hNpcoO7R+1Cp5CqGfbyd+HjxF2T6eP8xzsluvtfJ3jrOUFxJEoqyYHq4+W9SoZ1Lm7TPleUt8x1yhHKYTtWGqaB+oMlwmk0kcMfO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0j/nqHqDpvEjXYb8h1shYRMos067V+5iSrxQMD/IY0=;
 b=BnybLaITLk1yXFq5phy3SPRYd4ESn4VQ7B+YKblMJaN/w0ryVB8YSc2+Tz9zhz5wvj2qc6IkEKNd1/cgz2UNqQy3ALqVkN6bimECoRnJGLGLkGc/Nli08aoOm52ZeAIGq4rHFFBnxcDI6HKkPzR9KNmxpzJSHaNwbFkKQKkRvDOhxKaEXWo/nsCJa8jBG+/kW+fzoX3VHgF6y3SqAIsB8uTjxM89GycZdJbuUrIy8meGvZnzTwZhS+QiFGaFiVUTXl7nROMaWdaFrSiV+18DdZolXhPCxik99GafEKNWSSRKH57oWwQ5AWsU6NbCAABL+xLAwN/1iP5hEo93SHAnKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0j/nqHqDpvEjXYb8h1shYRMos067V+5iSrxQMD/IY0=;
 b=JZ0FZl9reC1lGJidsVkue1RGoVpj7vhQXwA9NR6wgcVsbFokT0MQ4dAHO9o3ay2p2czUkkCVtgsaob8na6vOTKQEhdaPrhW/LKdO+xV8/tY9CyFwSOkV8dYLq/ERkejA6Th1mBNXv6oBTywM7ILNZo3HoxbSz0R2WOn/0mjGHn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB8638.eurprd04.prod.outlook.com (2603:10a6:102:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 15:40:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:40:22 +0000
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
Subject: [PATCH net 3/3] net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
Date:   Mon, 26 Jun 2023 18:40:03 +0300
Message-Id: <20230626154003.3153076-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
References: <20230626154003.3153076-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0121.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::38) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB8638:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e94864d-1cb0-42a5-65aa-08db765ba76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5H8EHj3NtD1NVVrfOGmFAR5pAJxTTpUxrinbq5TRBpjUsv/UctFUtFxDoeJu4Oim4WMHFHuuSyPZGbcvZa/BfR5UoOwe2+xzATjFCv2ym2/0B+1K2CX5sH8PVxyKCCIHB4VnRoV/VF58VCwvqLbYG8sbt3l26hVVcxGDmLoSWjDMKzap+RwF9qf76R3JRq/0cY2JeJ9G9RPGMda4u+zWF1ElrVp00UuWaIxPRNaMArU1Vsp7+Qyg048QIS3ouuWLTaDRyUU/nDWvbkgFPu1qLPxX2eR65STNjydN+pFNQr7Hue94rgkicXmOv0kckP0X2ko0usD7Yt3BLxjIO9WjA0X23nym/Ai5URe+qmWf0t7oruXTziWVxAAnmGN6Dd+sfhhWiNiJj/8cEsITLAJpSm8xoPhl6fCVaW4nVreHctnAoZr5XCiO75p06LTc+Dawhy0aw8SvpVuCKtlSlfNsFaxoHrcUNh6LHL1JxLBq79YSXM+yA5/Uq84V3GAl1xV9KuMR482BX4DwyWWsVPiXtfUsJdKDWaYmgCkp7gSd/fyW2SjLLabGhEtNLTm+hYp4TspTMyOCAUW15a1+by6HxYDBX4tGrztJofj5IR7avAhuc/DD/WanhiKIM8uAd/Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(8676002)(66946007)(41300700001)(66476007)(316002)(66556008)(8936002)(4326008)(26005)(1076003)(6506007)(6512007)(186003)(6916009)(2616005)(54906003)(478600001)(6486002)(6666004)(52116002)(2906002)(5660300002)(7416002)(44832011)(38100700002)(38350700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PA0bRp8zV+J8nCOBZ35tPCzeYCEb9dXiFWY9JDaMqHBCbtcVvP4gCPC6CbMR?=
 =?us-ascii?Q?4XopaaHqPKgvgJs9CWk7MdZj8NHJQHkuxtwG4hLFtRf1e0Gh4RJb7IPfFAso?=
 =?us-ascii?Q?419h6c3PWob99Id0mgawhG+LzCFYI/+T+OjQ55S+XEcWD/ufPVlkqD7qBJ4z?=
 =?us-ascii?Q?QwQp8qIVdCIDNYvERssKjYHVPXd4uuRgELyZjROKLauXMejwEik2qLzWGqzB?=
 =?us-ascii?Q?zlBcEKGwOIhHDDCPAgpso0aQ89axK5e9erGtQdz9Yb81yOGy+WO0OvB4ZE9N?=
 =?us-ascii?Q?kX8CsTuMNDMYz3TKXKn1e5HJXHflHxRbTjs6RrpSqTw2ZGXPrMsgCvUYoySe?=
 =?us-ascii?Q?eeuXEHSekDxhLP7BXd30tTGQ7hhvzJYPa+Uv69roG0tVWFtCnd5MtD2yK1S0?=
 =?us-ascii?Q?VyDubf0ED8tc1UbKlXGdkK/MaLS/RG8sRujI/y8MsL2ym14B7QVJKYHQNg4/?=
 =?us-ascii?Q?J6YtLGBX8rKs3jPLC5zu3XaGgCWAYK22CpP5k773mCC3EN1MaOYtA++su2FG?=
 =?us-ascii?Q?+co8bUIPlW3ZvC3Y5JWTNlsbdy3h3bvZS2HxhHo69Q8hYqJ1w/pd2W7tGGgv?=
 =?us-ascii?Q?g2oWSLXzGv4soh/a/Qj4EmqetcNVI7+H6xi3JofGTR8ihtSVjalcAgG1WSzo?=
 =?us-ascii?Q?gfyCogLS9cOb5LlXGK0OST5WqvqL/teeBJ2HnIGOAez+p2sCCnMLJH/MiMak?=
 =?us-ascii?Q?WZXJC6hQ94bQlhaxiBr+iZLDYRQqBPiWGsLzVUmBEACzDE9scUjo8NtGsWVL?=
 =?us-ascii?Q?Z6S+ylvmjFYlZkrjKSX2koyrtzv7MrotYwNnbTBg97qD2q1QNp0kvKQf03DN?=
 =?us-ascii?Q?tHuKnXt3lF9Yj84RfjjZd4lKf1hFMI/ZtH+0K4mPrYaIgrhrbptpdQLdVl/x?=
 =?us-ascii?Q?d+y6918tyqb+QC0HuLicw1nt2QsnZXsqR3NTcEcjSkzi7rORiLNXCOUpr+8g?=
 =?us-ascii?Q?55/N7NpmX/Gr6hQHbOAmy/1/wKWKhf1HkLdHakQsg7a8GzDbh8fEkhwnhf2i?=
 =?us-ascii?Q?xLEhrnUYTLdNL3BRzrypMqGgoXNorf8hdfrgbPQaCCMW7CJ8RwEcix3kBm0S?=
 =?us-ascii?Q?diIl/g7aTiTry+gzQmTomXXFPtVbdjlKVf02cWHcsqqlvkR4KY/xyrz6cKPg?=
 =?us-ascii?Q?iNvBqlTh3HhHMtSFvm6hNdGiuBprGHprH8ebZrt2RmT2wCmVRIy0s56pDjv/?=
 =?us-ascii?Q?dbsNI4cMnA/Z47GptgFS8IQVese3lZ8B7BziXPtW+DCXxptKYMJODd/HSclM?=
 =?us-ascii?Q?AUA+nAVp5qeNWPbIiguuuYfC7wReuhneGlpoRkC4dwU1/QEkAq0lGrbT9Nt2?=
 =?us-ascii?Q?Htkj2fuMt6AVUn4OOSpSYCa1TNarzDLhvNQJ4EWPyIobo/n1+Xf8DfqH6fI2?=
 =?us-ascii?Q?Hqg7s5TqFcJA5CeSmD26H2QWBF742Hhtlw3FWxM4uPze+Z9SdSaDw8WDbQW0?=
 =?us-ascii?Q?NF7LkWA97HEbh0/CTH4DYx5SR3sXpcOd8DfXs3yMkuN58UCgMUL9Wj9NR7gy?=
 =?us-ascii?Q?YE7lG8dRloac554Hg9iypVL5B/dvus1DwwFV7sYzSemCjqSPM/AIIbKBwWYw?=
 =?us-ascii?Q?qfkxXAv8+EtSZOkNw7UlD/BE4bYfNjDgg3Q8pNLf+NH34pitjujVUwpC07co?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e94864d-1cb0-42a5-65aa-08db765ba76c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:40:22.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UcRm/b0rGYU8n+p4teweupaLu/uhqs9gQ8NZnDgaOZZ3lylsHjf5YOZdkSTfBs7uc95SndjQT9M7cyjjf8IuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver implements a workaround for the fact that it doesn't have an
IRQ source to tell it whether PTP frames are available through the
extraction registers, for those frames to be processed and passed
towards the network stack. That workaround is to configure the switch,
through felix_hwtstamp_set() -> felix_update_trapping_destinations(),
to create two copies of PTP packets: one sent over Ethernet to the DSA
master, and one to be consumed through the aforementioned CPU extraction
queue registers.

The reason why we want PTP packets to be consumed through the CPU
extraction registers in the first place is because we want to see their
hardware RX timestamp. With tag_8021q, that is only visible that way,
and it isn't visible with the copy of the packet that's transmitted over
Ethernet.

The problem with the workaround implementation is that it drops the
packet received over Ethernet, in expectation of its copy being present
in the CPU extraction registers. However, if felix_hwtstamp_set() hasn't
run (aka PTP RX timestamping is disabled), the driver will drop the
original PTP frame and there will be no copy of it in the CPU extraction
registers. So, the network stack will simply not see any PTP frame.

Look at the port's ptp_rx_filter to see whether the driver has
previously enabled the CPU extraction registers. If it hasn't, just
don't RX timestamp the frame and let it be passed up the stack by DSA,
which is absolutely perfectly fine.

Fixes: 0a6f17c6ae21 ("net: dsa: tag_ocelot_8021q: add support for PTP timestamping")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix.c b/drivers/net/dsa/ocelot/felix.c
index 80861ac090ae..7b494d975073 100644
--- a/drivers/net/dsa/ocelot/felix.c
+++ b/drivers/net/dsa/ocelot/felix.c
@@ -1725,6 +1725,9 @@ static bool felix_rxtstamp(struct dsa_switch *ds, int port,
 	u32 tstamp_hi;
 	u64 tstamp;
 
+	if (ocelot->ports[port]->ptp_rx_filter == HWTSTAMP_FILTER_NONE)
+		return false;
+
 	/* If the "no XTR IRQ" workaround is in use, tell DSA to defer this skb
 	 * for RX timestamping. Then free it, and poll for its copy through
 	 * MMIO in the CPU port module, and inject that into the stack from
-- 
2.34.1

