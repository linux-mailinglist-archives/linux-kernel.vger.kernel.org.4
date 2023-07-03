Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A57465A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 00:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGCWGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGCWGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 18:06:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60319E6D;
        Mon,  3 Jul 2023 15:06:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMJ0z6+6AeTc/LptQU4Mm9MDMBMoKCJS927XbPAUHrk44jZNUq74E9MKH6JrKGr37mdfl76IVcG/lRDOXDY3H5KJXLpGiyWmT7JvAYhZ7L7qdQsHsyJSn5NpYpm3CHNYxV61CB4GZALRXTg15Mq/RyyYeckEFs1NpaZNEEwdhahL23qoheIodmPpV+tiYdCZLr2JHCtehOXwKkzeV+SEhEENF4y8MUi+QZbgtrm2B5j17X5mUVa8KSx8Rh2VUIlw27dxCc0DIQZQYXbP1xvMi3MZknHLRQjJifwBQF6oRpupbkXwGpnqwFbJx3Rsb/qC+leOI+p9o2haweFX7FFgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9uWXx5U6NJv9IJ4mulwa0UJoWk5HRI+kACPTEIAsE0=;
 b=DYX5D+rBUSi3LU976VQZ8UCt5C5vaGiYSUwyDyXdhMZ+TM2+8kAO/64yqMWe4jAgY6AbvffPmFdpu1XKg4YzXn3Z/h1PJaxG3MjVKRQtTrXyTb1HSQRDY4o/b9qvDREZkOtW9MRjRiE4SQb78dA8vhPWyiDs8w7r6yYSLOEcUs7klp+A5WsHSHJYtek2T/+F+sdQx5Iu3tDJwNHtdQkA2vq0jIlNRIqDOpwlqMQn61YROVWkmU5rwmwPOuy7NeSVuJUcNO5EETHXEDxw9aO5hLGElMAeBSmzR+MYF7ThpvJ9RRaoxbUWj+1GAuIt/xpQqgk+BzKZL8e3lkvKUqi1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9uWXx5U6NJv9IJ4mulwa0UJoWk5HRI+kACPTEIAsE0=;
 b=C4LhvWjbcyIhCD0G6jMkuBQwvCo9604HDwBkaWW0Guhyl5J5Z710xiDgEqTcHrKhKfGcRsoWvpi+A+JA8UY/xTfXEbSn+yzztUcfIY5AShBEFv/KDB6WlZtNAZNztJpyRa7AmFlNwAsE+qjU0ky5vkWO4YixQ8GXFaOJxQOASrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 22:06:11 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c40e:d76:fd88:f460%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 22:06:11 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 0/2] Fix mangled link-local MAC DAs with SJA1105 DSA
Date:   Tue,  4 Jul 2023 01:05:43 +0300
Message-Id: <20230703220545.3172891-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0152.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::45) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: a81d1803-9d87-48fb-2f87-08db7c11b5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V790ZSgumHfVaLEed92IWFSa3TxjtZvXhBVuGEwcgTXmgqhoQKfHCEMKMyEKUJYticIp30Qlb9I9/7C/SIHBBNSPQzLkjK8LZxAqB4Ux5vb9D8RjBQW3/ZdPvo7QB2o8fJtn/z//4ATyzv2PcAf4NMdISpfu9nIcUqBir5FJpKDe0lAbt4i92gm+4NC61ac4mPspu/OKZsFnKJRZOta+i6kt1Ed7Lc8WcKAC6pnE/L/yMELnY3s0YoxKZuKW6K+tkE/SLHczlX1UWsEDxdhCvTNNxrNEfScVT0H2fjLfp4Zo9/VJIeg0eV5BH0xf1VRkC47s7ZffPihL/tYryCSb2TeJfA44zivTR89nrly4qCnn0AH1IIom5jAsgREiqEd5zG9+7/JsGGcCo2BHjmJIDYaU0tt/AelHW2UnBTEx3D2eO1PW/NqoVoB0y5lHI3GTuTJUolGt8mWDZ+z2uUtf2r6IlRXpVYqmIyMMr499dE0In6Q821lYdq+Q370nir0iDgcw3nRqy09TeYzEOioloufo92p5cfZTq4vJ6mWpYHU2TqhVoQSKBSMiErbRT4tEWtMTyhhbvbdraHOd8NRjNgixa18sWbH3YP2T6DIdJ5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(186003)(2616005)(478600001)(26005)(6506007)(6512007)(966005)(1076003)(6666004)(6486002)(52116002)(316002)(6916009)(66476007)(4326008)(66946007)(66556008)(38350700002)(38100700002)(54906003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4r5x5ftiLf36DIYJGMb2bHSFFzV9WrdF1n4tvtBXIGQAQMD/5R+Tyth7ig9?=
 =?us-ascii?Q?/zJXoS+QsHqswat5VEre4LBHgWdxNWX9s8p3zLBfcuBjP7lsbbTJ2hkS2aDv?=
 =?us-ascii?Q?sciajrUmWHBxdhnTCfBsxpEO2tPaFk0fBTA0Pn1cE0ZKxMRIT1IxZnVgMY8n?=
 =?us-ascii?Q?H8QsUK4+XlA0bT1ueGgiLP6rEMGBnaKTR6L64AdZqknCsp4TcFTlOFrRKSrL?=
 =?us-ascii?Q?zV03uzNuZWSsaWmldmCD5qqwvYZTX2PDibU7m+CVs3YIV+1dPNNqxZKJ5vxS?=
 =?us-ascii?Q?56SdWbgxcTNiHb/do61fJcxPhzR/IHTqGG2yGXvLSx63WSKgPZYejkB5ALWf?=
 =?us-ascii?Q?KNg5WS1s+LYrua02LEsmC48urFw62Sp4Foozw8cSF2fv4lPwEFX9fLbou6oZ?=
 =?us-ascii?Q?SewW8rFcb41XDm2xKfnLJf6cuJTReYQ8eL/+AIXmjyUZSTCztWx807jS1J2/?=
 =?us-ascii?Q?652xmlsD0RS/ct9kxQe3vMBNLGNQ/B4l7CZIz4Hm1MLbuajY/cPNl3XaN7Mh?=
 =?us-ascii?Q?7h2tKKzADM6SnnGZ3mEgK7TmlUG6zgKdgBseW5JBlEUgRoPcLmJxXT6K8s7z?=
 =?us-ascii?Q?R5pcxBkAFivCHZ7q8IwruDTL0iLYDUMDMx3tn4+7ltmqKzs3JDZ5ouD7irXE?=
 =?us-ascii?Q?XrO+3Oc/SVTEE79Eb0PVwmC5xASVtbqL0WHA3dzttzwT03GLlyOPwlNJbykB?=
 =?us-ascii?Q?/O623ayhkDqkSSkwMpfQLznRH2DIZUfYa3hlk+rf7h+XtTr8MJyQHGGmtX3g?=
 =?us-ascii?Q?2IP4gpIbVrVcBFk8RnoRaQHMk1YEhTu8H+WsklqAdUr6ly7Y8CadRuob9XxA?=
 =?us-ascii?Q?WyWHxp80oWXSZ/ea4bj3sxo1JthtcoB/qQw8UccZkEEaDRU8B4muIDkV95ki?=
 =?us-ascii?Q?9RPeYbqYcKcIpjBQ7+/WodCBsRo3AH1pVigBG3N/iV6DPj2H4wVpP5Y8YH4+?=
 =?us-ascii?Q?r2bxeCRfDMTPSbJ1bg05xWrJNL4wOlXMjyouCjj4oj+zmsWq0+HLgd5nMR4q?=
 =?us-ascii?Q?8amJXHbdM8AhopC4gNUPRMSMOQxTu3caupSD7Nv2DrPYgXaCtktudJffkMJQ?=
 =?us-ascii?Q?XO3jMguhc8PVvlT6EmkCoQDiwlMUZcQImkZxWbpdo7xlR0tKSWnx5rBhbAVx?=
 =?us-ascii?Q?nntN0f7mIdh3+V2Fu3+6Qdbl12PgAQEACJ9yEtk+6jY1GayhgmTNWd95Emaz?=
 =?us-ascii?Q?g6WdolLtC4mH1w1QH1qdoJOsNbLPlQa2VQdV7K/lHJ683nFPYcO6fo4Tm/6L?=
 =?us-ascii?Q?1PeOTfaKB/6rvghbZyXb2ElS54seyGwplhafBMY4yN3bYRMykhwcx4xOAW7B?=
 =?us-ascii?Q?MYVHB9JELBKavlli3/HsLFFj1z05eQtwLMS+6ojHRo546bnxcXDHWzyjvqPw?=
 =?us-ascii?Q?8L4y6q4hs3INGdJQ2DH8UNVcVktx9gZHZfYXFqTsnlhllhCZKQeyCjxUXssl?=
 =?us-ascii?Q?Gf7VZD9tAvh5NpcOCGt3gnSVTenTEsljdOWcVI8H8HTFOMk3I1vU5U+JKKCc?=
 =?us-ascii?Q?u+QSqn2uDmhWNxMNBhyfRT89dQyFTpMZftw7396zOhINlGP/MA2RMA4RcHpe?=
 =?us-ascii?Q?33Hul8w1urR8MJXcqi6nbyeucS1pVI/pHGrSU4bdKfvgz0HTpiw3xACiLtTp?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81d1803-9d87-48fb-2f87-08db7c11b5d1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 22:06:11.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZeAhm0wQ8hMpfNvpH5VRZKQ7MrOh3/dE4JaszuAp+WmkQ2OJ2GQYWPSN6colQ/fcmJASrUlL5OXrdeNZa/9zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SJA1105 hardware tagging protocol is weird and will put DSA
information (source port, switch ID) in the MAC DA of the packets sent
to the CPU, and then send some additional (meta) packets which contain
the original bytes from the previous packet's MAC DA.

The tagging protocol driver contains logic to handle this, but the meta
frames are optional functionality, and there are configurations when
they aren't received (no PTP RX timestamping). Thus, the MAC DA from
packets sent to the stack is not correct in all cases.

Also, during testing it was found that the MAC DA patching procedure was
incorrect.

The investigation comes as a result of this discussion with Paolo:
https://lore.kernel.org/netdev/f494387c8d55d9b1d5a3e88beedeeb448f2e6cc3.camel@redhat.com/

Vladimir Oltean (2):
  net: dsa: tag_sja1105: fix MAC DA patching from meta frames
  net: dsa: sja1105: always enable the send_meta options

 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c |  5 ++-
 drivers/net/dsa/sja1105/sja1105_ptp.c  | 48 +++----------------------
 include/linux/dsa/sja1105.h            |  4 ---
 net/dsa/tag_sja1105.c                  | 49 ++------------------------
 5 files changed, 9 insertions(+), 99 deletions(-)

-- 
2.34.1

