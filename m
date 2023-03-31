Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FAC6D179D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCaGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaGld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A5411144;
        Thu, 30 Mar 2023 23:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuKPY9xfy99Y64do7K42VoysV3Yo/qTQaOIbh50yRZWvmoVoAGdWBq8aGdVzGZVOLDbqLBhMgrOOoHFen0FBXHHBoXjPEACh87/r2ucZkCtUc3fTmLyAI419ZQN94PHYKSmrDApLvezHaQ0S6SLJ00JTBXuhK4m9gHafqgcBkIx9Ahk13wp4KC+Xhs0LzoV53Lfv6jl2Va6VkSzSyA1K1sgfeBwtB/9FHFv+Q0Ko7hCZJ2pxC0u+yYHQddzhjgtiZU5qkBh5I3vZPNhIcmxwUjPQ5cEOy6009Uy5m1PywOHw8HBWRMi+WAZHIi64IxBofovnf3SR88OIYFsc3FRQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3z2xECp1nJ3FhPj2w1+bYiirSBm1j2FW1oU0jTqNaU=;
 b=QHnrvc0doMmge81PdOPTeYrYNXYSIlQkHrmXVm3SUs8+2F8fZqLFNawHcQuALGq28bR5EGGF/XLKmnpGo8DIWTP5b/0NyBBBz2svL1PSzTgaqlISb8IR8d+wCvzxhnuTt4kiIwA3ZLnQ1f1kEYfChTf78J0+aWSQT8aG3TqMELh4MVF2AyJMEUOk6zqMT2KGZSbw5oxHF6mXHFY4QznSWwdfm0fZhuudweUd5XUdfQgMdNgYaxvZ7clkCxtTP0vZv/IEmNtUzxxRKfbisRl+gMb9bTtMGeeY2rrKSWVlwtw0LVv5XvP4ga8Y/wIB+f8IMqtk35gv8xGuT5UiC7ORLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3z2xECp1nJ3FhPj2w1+bYiirSBm1j2FW1oU0jTqNaU=;
 b=N80iduqKau3PHtQmlC0SsjXRFghj2G/kmUOutB+IogasZnYa4iafGOayOPQkGv0W6WrwehyvGsQqW4tUhy7RoiAvZG6dcywM9hV3zzsd4w4qtsid8JXdJ9McmkG6B7GPKZeygJ+0cCwf6WmErilg4w0kuZ7oZc5pjLPM+NdnCig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6854.eurprd04.prod.outlook.com (2603:10a6:20b:10c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Fri, 31 Mar
 2023 06:41:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/6] clk: imx: imx93: fix and update
Date:   Fri, 31 Mar 2023 14:46:23 +0800
Message-Id: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM7PR04MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 532fe9dc-eb2e-4f7a-4896-08db31b2f314
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uq+vkRgmyKXMLvNVmdVwl20lHkb2wWgkmr8aRThOguQJnpvqfwZpl+cXuFOAtXEXYPbF6ieQwnJmFGn5YcLgMl6LbdyCLLwzExdy2CpKMCKLTjCNA3jRKQi2dfpIU1sbOcVi1fLaA8D3wujjPxBxrW5us9cjYYpi0wDC//PHoqLmfYd+TNLQwVDOkGGjp3w2cXtdhobj3nepKVYIh2oEslEi8G4mqVrb/4cJvsTNnFZci+r6PM8sAJaK8Pu2wcVLGt4o77YYZnybyobR9TrW4mjOqSb26X6/EbfTq0v/OruqH7sx6jq7uWuPJNHvzYcHO1D9r0FVNCHZvN1xU/1iQxCAK5pFDar34UER7LpB1D+eBpGKkiZu5814VkKuEaTMlUePaB5P8XjoyH/a+TmTXki/0F9wOE71OkhoSld97uLgsarQRHW5PTRck5W7Q+XhzpHdkO/VEe2QkGRxhLoLwK+zh7Gi1S2/B1lhfVmzL/MCgydeMUE7eotDZW6vmzr6g3vp7YQ1PxJSmpwpaRrf5ChnGNlT9Afh76mVsk+t2SdgzG8Z6Gk8lVpn6rfG07q4KlooURnyJxDQxE7G1CNfaoJrLUZO0lPFFjh4zdb67JP6Vv85Va/BobLzoOXts477
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(6486002)(2616005)(1076003)(186003)(83380400001)(6512007)(26005)(316002)(478600001)(52116002)(6506007)(6666004)(2906002)(5660300002)(7416002)(4744005)(66556008)(38350700002)(8936002)(38100700002)(8676002)(66476007)(66946007)(41300700001)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GADy+nSqjq0+PXn7ER3SdPVJepN4Qetfmq57jE/aLxjZ4tuqG1zrROkQe7DR?=
 =?us-ascii?Q?giC1xPBrs3f6f6eBiwVgBEhCISNjxbiCj+DZnPI/ScHmhDIQkoTflTLzAAuM?=
 =?us-ascii?Q?uDkaf2oj/gn4QGyNza2uIDeNzDZ+PFZm3/4FsIBGSIU9ynKKiHwpZDdYWd7q?=
 =?us-ascii?Q?BcXOMtj4OHQF3SF5ehLI9HuD98Yx664W1yq+2ZSWnbKouru9WzH8ruvRD/hJ?=
 =?us-ascii?Q?dsUeIuxAfDYS3iuBmYDVI0/PfosDjnxQg8WllAFPSwTu+EtH1d8OXRvXrAee?=
 =?us-ascii?Q?sDEkVPUpfoMC33Gzp7is3t92gUZDsrEgnN5053igbQb5PnU58b4GSWQd6DNh?=
 =?us-ascii?Q?iMO0o9Xu+8sIa87kuKbs7wAXH90j3WAMOuRi9+dhxXG/Zric+lNsn8ZHyP8W?=
 =?us-ascii?Q?S62k3ydbJaTQTaOGEOi82yEkyWDX+AxHaD2GtjT6JChZ0kIvEMCafrJDOjmZ?=
 =?us-ascii?Q?WL7/jOBJB/t7b3mzhDh9H7CMFXw2p3X6q8qEpK0UDvrbGt6xy/SUpWCrUQPb?=
 =?us-ascii?Q?kVDwt99ieLTkU5lzQO5UultnTtLjm2AG4bRKc1qU3YZkwm1pfxAy/agVkWSz?=
 =?us-ascii?Q?562Rgh+dfblI6MNVjq6A8DKxefAZsjrjiEXW1GgVid+n/Ls9ObrI3MnHPb0z?=
 =?us-ascii?Q?NbJ1Qza4YW+glRkAaRAF+eN/lY3JAtLaJbydwBaRbCOWZc9Zpzez1zG2zucN?=
 =?us-ascii?Q?IaXY6qKLz4jdQCCvWnqyLSVJKxpWsHy7Ke/aG+xINYu7VNiGbkI5vIlZqJH4?=
 =?us-ascii?Q?SuPhb/vUxSfBxZbj1P65wBXmoEuIbARzfoFglAzUE84r7Lv5+mmVVrCzWJMV?=
 =?us-ascii?Q?y1zoEQEv2wR+X/uetHa/+PlAWLBVSqgtYvX+ivAqvUBQ73z6qZCC0ZkkxzKS?=
 =?us-ascii?Q?nw0EAcHPmnqPoZlbnCeht4h8M1nvS0yzPLg7ibKBbhQtIXCk0qY0BsA0RQ9z?=
 =?us-ascii?Q?0Iktf1XOnQk1C88G5DDz9wJRJJ0tXlyIYfbpVDqXcZbncieHmtKCMa0RgyNj?=
 =?us-ascii?Q?yrJnFPrH32FNS10UPDv5DyRZ1pszTiuqREdDWGvuxAhtfYKfIA8q5wir8KMn?=
 =?us-ascii?Q?3LOcNdw/N9TzaOM3srijJo4SWbE47WP0eNMY3g/7VXB6d12vbL2PHv7EoGz1?=
 =?us-ascii?Q?BINruMcozyr8rR+EM8XneXRTPBwfzSo34rsP0Oqg2WAoYW2OWH7ZAeST2ZeD?=
 =?us-ascii?Q?17b1qje+JMLOAetW7RZSC8mHjlKX/NSNEXsFHdW8fSV6x2P1e7qYY3XHzMjL?=
 =?us-ascii?Q?mkvcF7MMjcrCxW5X2UI03mkoJi8XelFIeF2Tg6CLEWRVq/0U5Wh1nQnDfy2O?=
 =?us-ascii?Q?SMcvB1plIqVU2TW3BBu2ZOF/mGRhBiGbdFJG52zmJ0BcY/4mqqABWgJ22lcL?=
 =?us-ascii?Q?BZr9MPIl8XQ10fsDP+62Xdh0GMYDuCnZVP0xvMJvWmCJvtnMCesSwNsvJBBE?=
 =?us-ascii?Q?3kptuhuVbZthr9H4DAgnRrhBcxbMZZBT4FHaxLVoTk83NQ4/cMx/oDvmicTJ?=
 =?us-ascii?Q?5wikl6Vic3EQYU69xFgbG6DytHzZEm8flETUYiHudz5bGJC1Ukjagzi23wwE?=
 =?us-ascii?Q?oBmv+L3iBNqcDpLZ519Ubod95OM2TeTP+rpp9MNz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532fe9dc-eb2e-4f7a-4896-08db31b2f314
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:26.0951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FVO9Z5SKMUJBDPyo2gx/i3aWej6B3kCdC5VFrcng/RjSCkh1ZVQHrZlKHS9H/n0UO9xwYBXaOXILJsKGOU6OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6854
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Patch 1,2 is fix the freq table and set rate flow
Patch 3,4,5 is to support integer, A55 clk, mcore_booted parameter

Jacky Bai (1):
  clk: imx: Add 300MHz freq support for imx9 pll

Peng Fan (5):
  clk: imx: fracn-gppll: fix the rate table
  clk: imx: fracn-gppll: disable hardware select control
  clk: imx: imx93: add mcore_booted module paratemter
  clk: imx: fracn-gppll: support integer pll
  clk: imx: imx93: Add nic and A55 clk

 drivers/clk/imx/clk-composite-93.c      |  8 ++-
 drivers/clk/imx/clk-fracn-gppll.c       | 89 +++++++++++++++++++++----
 drivers/clk/imx/clk-imx93.c             | 19 +++++-
 drivers/clk/imx/clk.h                   |  7 ++
 include/dt-bindings/clock/imx93-clock.h |  6 +-
 5 files changed, 111 insertions(+), 18 deletions(-)

-- 
2.37.1

