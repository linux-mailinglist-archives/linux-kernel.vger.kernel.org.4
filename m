Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A56D3DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjDCHIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDCHIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:08:10 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDDD59D2;
        Mon,  3 Apr 2023 00:08:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS53Ief9MU8pNHsetDaj83z1atepQpy6OxdtA0ikzJBnzAwaMWpiYFD5SmPxkWqJmKYav7qR0BJil+aQ18ohV1WVXgzhcPVrHvudHBNS03VPZzdsEos7lbHi/g8Dai28Kx0OGgPIcbo74/p2ACbfWm9iT6nJUsitcI3TcwWG4wA7aEO0HHsoPmkCNiVVQFK8K7i7zYyFIZCjWWdCbTn6Jj1tLq+jc5rFK9+Wi8QGbhI43wOBxlGl+X0LxD++d87P1qZAM43WjbK9Gz16pkZFfR+rqtFoD9Vx7EiBAbj2kZRGKlJ1KsESD6fLYrqrQJtK3SMkOFQGANJOqZjjcjE6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjRvtjF0TFhob888R/LruGwCmqHD5KlAjQAIyqNqqek=;
 b=FKDJZ4V+/WPuhkzDw4o1wdPL73PFrHJxFkgVaIQqUZ5P9UqFE4CJ25aQZp2Duy6rI+TuXS/ib7DAa6V1rfzcgAY7/XKcXxYb3xuP23lKuZ+L+9XwyGXtsULsa/MgGNLfaL0F8qy5N1yH5nmSxuiIjDWM0IzA/30ZKNFrgAeJKu+NCxrCwAz+qZUlbtPBAr6ujwqiGGok1+hcMVzu4S6ZBFNf1wLm4JyGIdn30aR5NSMrV4+rkXxHdYnUHLK+B6xQPrjChttUYz7WaXLC0EKsrPM9ssd7wvF6lDLbsVNWlzV0rgl/wvF11ELBODPlhHdz+ax7m3pJX2ciJ9Rc1YJspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjRvtjF0TFhob888R/LruGwCmqHD5KlAjQAIyqNqqek=;
 b=IR+8dPtZzW9wSJfNMPx4pG5MP8T5hbh3ROctL/blr2jhvVO2+EMoJ4pyBX0dOWxOOYwCE6K5Ys430o4aT3E5WYscpPFN4k1AL+gTP146Dsu35dG114qHaFvXEmV009juTji1e+MqSITvpijNt2ug4/2F4bk8deoGECTD3EU+9IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8768.eurprd04.prod.outlook.com (2603:10a6:102:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:08:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/7] clk: imx: imx93: fix and update
Date:   Mon,  3 Apr 2023 15:13:02 +0800
Message-Id: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 46406cb9-398c-4876-7d5e-08db34122b8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9nD8lZG7SxEaqz4py/dB0eW6OO5sQelg4KziAtvBNULClJkpJis/qJ0nPWIMPlhz8AwJhhhIR5rEHbcSrm7AonWRYmB3/2FA+vg4/4GMVatKLjkQj/rMXkrkPaSMkar9H7lhmrgjZ0VhbIlwOfYFk/Lf8BLAxBOmBckjHMkOEcKO1dyQYIh86RCzUtN1BkM0wXYPMXPx2JB2JrICJT04LrNAqWCLQz6zaijWJa1Y04K+4SfPsfuhHlV9A0XFnFRC6RTmm/nIlgGbJ2GT6cdqlo8v3HyMRDoLtw9JpYWyos//Pl9SL5d62qgmH8aOJcpoWErROl9a5EP9YSHBGgGV3Nm1Fgb3ebt4PpS79ZxWu08et5rXouWmpQTUI0nNqQQueXfr6mjM/awm13U7aYT8xeinkIz8JGBJgdv1BJrEL+1xKQA6TRVnxDBtNhM9NmNeo5QNBKOuEI4WIfJaZyZDOmJFIiO6TDVlaS1bbOjXylFVHQE+jbxONZTF1SeEmi6A80z8R7adrAQ7bgxEHUDeBqRc2WcWrGAUCnpmlZt9YHOtvlONgfWmtECXKICPTo/M0FcTMQPRsHD4WAtHoPbsm13Di4aODIU34kJjlpKsZ9XTlw0UWG2a9Fr5nHe8CSu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(478600001)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MKHGuub+YqdxCCzr1xcHpa4mnBMSwjFwLVs4uWdSZOGPnZVzrWk4x8HKYVpo?=
 =?us-ascii?Q?GzoktlamswlOMNArm8gKJbb+Aty3Gqc838nFvM8RJ0JJxc9NndkSBNMIweLL?=
 =?us-ascii?Q?IU68KHsfnARS6fpnyWPQMhBQiVK7hToYL1RKLbDfhocAClX7r1LumXRQ2HtI?=
 =?us-ascii?Q?iQlaaCZ20rSG2lpqWmRhP5Z8aeBZMC4BbcfcDz8H96ghIyA8yLFUwY53SM5z?=
 =?us-ascii?Q?1/EoDKu5mFqLjFn56t4mKkfOfv16RMY1WrIzaYbydGIlMVIDAqPPDUtJbwf8?=
 =?us-ascii?Q?2ZwUJuAJhR/mAwwNK0qDT6Pk3N4sTktr0Y51vFI4CWh31G2XArM1DNcLz+us?=
 =?us-ascii?Q?KENUT4arfZ62OXuj8FAJQuVS4gDG2GZ4t6yLqXCBZzw2RzmbPB5DI6zPNzxN?=
 =?us-ascii?Q?4yC3Hc/jI60rUxxZsKY/pV/i1RpObAOFw0A+5FrvKVy5Qd05eGokM3IuD2Y6?=
 =?us-ascii?Q?lbxhDCzsfTlrKLydCJe9WInaS6ckh0Wkgfib2YQRT4XQIP4AY8M+4AC7ZxNv?=
 =?us-ascii?Q?K4+c90pL4kerqXF32VW9hJk1s92hjvJlZZLhWFlb0EJyfFb9w8TGZinvPwOf?=
 =?us-ascii?Q?8TTtjMU5FoUNBah35eq4epJDVQJ8/UXYHFkSLZDt/DyXoUFN7ewiRyvjLR2U?=
 =?us-ascii?Q?4+x0/EwRfTMvoyQ5ASbKUPpR4MzAKW6KIwBK83fpgw02BipdGeXVa6sMtjhr?=
 =?us-ascii?Q?xY2fBx7X6dmRIu8TX5R4vCel9MoAQa2Q9vHqIhq8fRTEBlLHFHCj9w+Qa84q?=
 =?us-ascii?Q?zvgHGP2G/AWeALQyLgP9pk+0Izh4g00pzRv5971fXcvB6cElkspyRrzLBIja?=
 =?us-ascii?Q?qEFOWwp94NFQuu1BgwoGrCEg31n60V31vBgpTQhZMrI5m4jCT/kZRl9Z/JkP?=
 =?us-ascii?Q?1iamj6dloP0N8JcI9RrOJlRXAS1zxYS4I/vcLj0N6/Rw41nT8nOMmTEAgCuV?=
 =?us-ascii?Q?uUFkOcJ+QIflz7TKF4Mb6fvmJwZFGvlO4Uyh1sIagh6udGmt9CWzWXjfAG//?=
 =?us-ascii?Q?X7NbsMRCTJksQbPf444Fr8g5QDmXBTnyKU/Do66Quo/41bwk5Hmj3DRsoYs8?=
 =?us-ascii?Q?yNwFwF1TMck7D9Mp3om9e4cY9xogswErQ4qyM9qcHGm8WtauGn73s2rRJQou?=
 =?us-ascii?Q?sVeM0r1fPTGjgLDi1/HUbHPcsF2bCxwvGHYTIhFY+n2NZadm0Dit9Bgif4zR?=
 =?us-ascii?Q?eegJTDTathmQb0oFUo/qCzN12zipZPRXnLSsohpe85cSTXAhLoZb7YC/JJdI?=
 =?us-ascii?Q?jv712pZ6I6DSig+4IePWJGChGj9Pg08ZOkOpMrulhDJNxBD0Ji6FnmGp06Tc?=
 =?us-ascii?Q?6xTk1w0tVUAfPHl3WDgkQ1s9Uqtyxy0nm1siQXsKGGe+zBAY5nAu6+GPogFr?=
 =?us-ascii?Q?7jQCoxJf+lUg7MWPf8VgulHSeYbsh7f8FVv/bgULzqmf+pC0SGg5YgRZh/YJ?=
 =?us-ascii?Q?BTt1+63D5lz/yVZmP83G97T2yTLsHvtyrKA+fi49kVAR7zrWl9Nk/x117aFV?=
 =?us-ascii?Q?faHj/fv3avWirGL5WqgnA8mmlIJ/Fk1WAls3KLNZIxHOEtRxuvHJRhyH15mH?=
 =?us-ascii?Q?w43v9z1LazZPiVzvueHWs2mt1klDYNxLdEOMx5qe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46406cb9-398c-4876-7d5e-08db34122b8d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:05.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUke/rghqcZmq35GYAKMwCUzGEIA5V1WSfVTwpZFOcRFGaed+lW8DAfgNH9uczh8r206J8PPelLkNXewVKifFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8768
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
  clk: imx: fracn-gppll: Add 300MHz freq support for imx9

Peng Fan (6):
  clk: imx: fracn-gppll: fix the rate table
  clk: imx: fracn-gppll: disable hardware select control
  clk: imx: fracn-gppll: support integer pll
  clk: imx: imx93: add mcore_booted module paratemter
  dt-binding: clock: imx93: add NIC, A55 and ARM PLL CLK
  clk: imx: imx93: Add nic and A55 clk

 drivers/clk/imx/clk-composite-93.c      |  8 ++-
 drivers/clk/imx/clk-fracn-gppll.c       | 91 +++++++++++++++++++++----
 drivers/clk/imx/clk-imx93.c             | 19 +++++-
 drivers/clk/imx/clk.h                   |  7 ++
 include/dt-bindings/clock/imx93-clock.h |  6 +-
 5 files changed, 113 insertions(+), 18 deletions(-)

-- 
2.37.1

