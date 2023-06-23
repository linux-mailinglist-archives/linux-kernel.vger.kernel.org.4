Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134973B1D6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjFWHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjFWHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:41:39 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405C719BF;
        Fri, 23 Jun 2023 00:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BM8yc7DMeld/tWw96Sjnad52WFWtDFdZj7RBewWqssDKJKE4QLPxDejXqtvHpwCiLZHCNNfSjzppu+3vsIt53HM6/qWYg5zx/5kvm917/bg/IXF9d+QRs2Y0mg68/EbNGhoufzCxwUZkarvkR9ZTYRfW53NOomw+T6W2t1vIcDzTavwjgZ1Yi02HCyN7EletczJfFgVY1geCXhGT0McaU6Qduta940T/fpTIvI3JAb7nfe4Try0p4tt18Lt9OdgGhUg51piXc4U9sSKZUsgFMAIRUILMZxXFOXPXiHCstQT3ZsiRA8OtPFjwDeJ+IA1AJyeWxet1uO6QcNUuqao8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F27nP82DYzFtxAIMeBG2K1lb9MDVi5jZlZntDP6gI6A=;
 b=kIBwz9tCdhY+0b5BjgU8Wh3ikSt6NnxwbKasOf1wr1C6sTl8NJrwGxmAAjK3WlhF2VuI+54jsMlWLHUijebE+d/BtMQhjtGVis/ZN6eqmmdgiIvxgBkpslz52+QB/qjFBxZmgT5sVINe3EODjIVdMlL2WuOgUxP4S8qTz0zPALXsjpedln1uFIkEsVEXzIGX8eRcbnkdvmnr05BHr6j3THjbwix3omoV+6MG0HKdPZ4C6S1s9buUKEgEOIhHluK68jxnHaBlbXU/y0YIoGh4knt8ymfD31cieGaKrRiQKhpKxY70VMZgx741Hq6/6kX82WiHIW6whQBP2e0Wum6ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F27nP82DYzFtxAIMeBG2K1lb9MDVi5jZlZntDP6gI6A=;
 b=lNP+aLRiR5z4LQ5MUaP2fX08QRN//CUX0EnZYjej7qUxTtOQbgIebIjb1Gr9EfN3Wlj1K4fcAu4vznuFKf/M1FbO670aHe+duh3E/StexWhtIHBqjG+tkTdhfDgeFu6SaMefq0C46ntXgvPmCC5jR1VgiTNI5mVAmg4asYETFzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 07:41:35 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::5356:c79f:ef9f:dc29%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 07:41:35 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH v2 00/13] Add TJA1120 support
Date:   Fri, 23 Jun 2023 10:41:10 +0300
Message-Id: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0011.eurprd05.prod.outlook.com
 (2603:10a6:803:1::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8e9db1-95b0-489e-2d83-08db73bd453d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JU5Nnnda2twatTUNi+9oR8o8yuof4lsf1HArA4n42qKqL7BuCuYU17ZCz3YYOKUfo/mApNMY7dynngzAk5ccs5GfIm3O02GR0JXOyM+MoTXfEcVsM9UOeiSTatir1Oksr6pOFTZ9gm+VaAe8T+IX1eL24FmrpWcIaGQnzHYCPaNG+YBVMZeD2flLnNAdKb8MjWYh+MT3CzsRnkIP3TDbmW+Lm9N2iMNrk3FDGRL9hhAFuNNXwffTlk4hm2IFc0S0Dwz4soOLjOgnPRd+hYq6cK8C+cTPxQ/+EGMN3qVrqLoJ6gWNp9RqWzjv4uVwUoM2e29EAxR7lkCh4xLjDpq1nb5qxjdmBfboXKyEI4ikL634k9xAtglSF8OtnhF1dBiAyZXuaoTWFRypbwHOQXOfcaI/Fs6hOVGDX2yhJN9JaW1WpMXjDPYVDuRSZRgKL2JVCLtVzeaY75RHGUpyBC7lXJehFSJwnbd9vpeZpHW7NEuz6PwbJNB6OY2jE0hdqJqGdo7Ro7A+ck20DmKxi3e9D64GhMKbQUp697WgLCFjXh8k84vYxVejOlfmBXWWgLdKTaCEjODouVCyeWQlmTn+sTUU/+/iDGbHS5H+FrQmJSQWhpGRVFvpExzz6dsj+JRu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(41300700001)(8676002)(316002)(8936002)(6486002)(52116002)(66574015)(66556008)(66946007)(4326008)(66476007)(86362001)(6666004)(478600001)(186003)(26005)(6512007)(6506007)(1076003)(83380400001)(2616005)(5660300002)(2906002)(7416002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?febRcSKboq4DZstcR3XTlp9Wt3dGa/XE1zEHKmVA6b+B1g+HztMPDFhVYy5w?=
 =?us-ascii?Q?wmlV4IK1M4LlYE1nM7uUF0DPHMK1O0EHdKsYlgN0CiwB7Q5wdmlHnSYcq0Ho?=
 =?us-ascii?Q?P6DU6EoZMfXQ+4kvrAIzfc5WqBIaq7fG6QqRAua8SVJkttSwVIdvJmQ6DIQl?=
 =?us-ascii?Q?izwVyVZ97KNseiKnLSY4+UEIwP59A/rcE/ZS3Ino1IQ6Lpc6KFPOQC76Z4N3?=
 =?us-ascii?Q?YTYlShFg+H1Xp6JP//9G7ncog6/rUGFh6g8x9e35/EiLrFG9hdXqwWuWkE+V?=
 =?us-ascii?Q?e4iP7RMFLZJV0q46+/i5fBCmusAB/XGCVuupz0mDKKOUBW/NNjwx8IBB4iD5?=
 =?us-ascii?Q?0CX13VwpdX9WesenjDhlXr3wnQnDLxzeAL+z68uF0pV2/+5Q60LKx0eXZ0yj?=
 =?us-ascii?Q?GWMp6I8XDxEN2FjJdLBpz3cyxczCpAovYin82A6kebZqFHM2IlrSRaDV0eFY?=
 =?us-ascii?Q?DdOQRK+waxni7gUeRL+mUCHmFVfvI6clwFMp0Iz/GrUV6raxRJF/C0yVeo2Z?=
 =?us-ascii?Q?GhjH8P6UYHcgusklnmEjhQLtV3HRszXfqR7MG8+Vb43/KOla/Z2A7mrYuakB?=
 =?us-ascii?Q?Ujp61fFYGa08140tEMkV6oetdQAT1VD8Ag1ODPc9pWyd8UBUb5Omp1gK0rHg?=
 =?us-ascii?Q?dVMGdOu3bxYccweKFCzwwEgEBMfgSDWg1cYpDJRA7IaQrJw9lxKpI9y5ey5/?=
 =?us-ascii?Q?17v/83ScK81KwIs1Qa2+WBEOkRCbX6BjZ4RHzYpFETEmGAaCy5JSe+ykmyQi?=
 =?us-ascii?Q?61dskA9ZYc/dBFmz6McGsSS36WjSBRrjJ3C/yyLnSGicZvGHbmSUVzKY5SGf?=
 =?us-ascii?Q?EWitSyRquQf7RpkERNfzNfd2JJ5UMi+sl2ff7y9ilE6c0ERVCd92DVHxv/tP?=
 =?us-ascii?Q?RXwNp/NYSgWrijX6LgshBHRwSUNRJg5MLqtE/gTfr8R1sQ9z6I5ZYCcu0zqq?=
 =?us-ascii?Q?ADpqF1g4GYNwhXESUFaANBUiP07XK4BaokzaRJMa8YKd3T3yVxx4b8hfYJSH?=
 =?us-ascii?Q?fUuHnUrc88nInTFGogfnLij9lzcaMH8B+inKKRq4VueZx+Dr8ru8YsENQ5KD?=
 =?us-ascii?Q?YGGFMZy3UtHfqNNe6eU0t0Om2lvY2EeQowWnTJJ39lyKAUbzOlM2+ebS4G87?=
 =?us-ascii?Q?kh8IngLvhcLWODdSY3yT+TLdnfVUWyP+0O7mf9Z5aByY9NBzmyye9AklbfHZ?=
 =?us-ascii?Q?SQ7lbDTL5aaP66895kDo7kLCm8HGfP7v+iiOpChYhHmmRzm9IyxSpwuVrTMU?=
 =?us-ascii?Q?iUcFN/ZSm4VfXX/J2ZzgSXjh0SQ25ZwDXjR1FeDHXlPQC24jeTYEHKO71Ao1?=
 =?us-ascii?Q?G0h4ofWTb5Qnc+BqU0lpJU5P7jqzLuDdDO4SJLjhAo18FKm5i4UGMAuOH7fG?=
 =?us-ascii?Q?C1GP11fVz3zS+OKD2fUpLtztWgAvr4m8K3tUi9hkJVB2DP6MLjJoZPNMqKsW?=
 =?us-ascii?Q?dFnYo11XvW5CUHopn94JDzzm1vyak3OGqLGLsVNziAHFmGU3E5HJNX3FXR3x?=
 =?us-ascii?Q?e5gpZuaAB65szBhE2rkTVjdudTTAOsmagaD/0tCrvSvJeD4CgOhQzpEopJ6a?=
 =?us-ascii?Q?rY7Mr0gzptTI0OLWjuIsAYSsgd8+Wwy9VwvEvGE1NHfXkIQMUNe2R1SusmSZ?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8e9db1-95b0-489e-2d83-08db73bd453d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 07:41:35.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXEyMkUtJqwFbC/tc3Y7p8d/xf/sXFDAkCFuBaPdHvXMaPBn7IKX7sdJ157+uECuzSiBvGxy+Bk/lsi+r0GZLpi3uY/v/E1iEPZGg+0MD8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch series got bigger than I expected. It cleans up the
next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
automotive phy).

Master/slave custom implementation was replaced with the generic
implementation (genphy_c45_config_aneg/genphy_c45_read_status).

The TJA1120 and TJA1103 are a bit different when it comes to the PTP
interface. The timestamp read procedure was changed, some addresses were
changed and some bits were moved from one register to another. Adding
TJA1120 support was tricky, and I tried not to duplicate the code. If
something looks too hacky to you, I am open to suggestions.

Cheers,
Radu P

Changes in v2:
- dropped "net: phy: nxp-c45-tja11xx: fix the PTP interrupt
 enablig/disabling"
- added error msgs to nxp_c45_set_reg_field and nxp_c45_clear_reg_field
- used phy_err instead of phy_warn in nxp_c45_write_reg_field and
 nxp_c45_read_reg_field
- removed null checks for .driver_data and its fields
- added 100BT1 and 1000BT1 features bit
- replaced .features with .get_features
- dropped changed on TJA1103 EXT TS behaviour
- improved timestamp reading workarounds
- merged patch "net: phy: nxp-c45-tja11xx: timestamp reading workaround for
 TJA1120" to 9 and 12
- implemented PCS reset workaround in link_change_notify callback

Radu Pirea (NXP OSS) (13):
  net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
  net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
  net: phy: nxp-c45-tja11xx: add *_reg_field functions
  net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
  net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites
  net: phy: nxp-c45-tja11xx: use get_features
  net: phy: nxp-c45-tja11xx: add TJA1120 support
  net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
  net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
  net: phy: nxp-c45-tja11xx: handle FUSA irq
  net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
  net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
  net: phy: nxp-c45-tja11xx: reset PCS if the link goes down

 drivers/net/phy/Kconfig           |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 1134 ++++++++++++++++++++++-------
 drivers/net/phy/phy-c45.c         |    8 +
 include/uapi/linux/mdio.h         |    2 +
 4 files changed, 873 insertions(+), 273 deletions(-)

-- 
2.34.1

