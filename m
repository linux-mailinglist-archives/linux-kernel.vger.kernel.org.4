Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABF170527B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjEPPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjEPPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:43:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C9519B0;
        Tue, 16 May 2023 08:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYFx6AcywX6qkH1eHY4HEDn/Jzao7kFmm+9q+FuJ9eTeYPe8Z89G+W5agXyUZYgOCVgYtt15i94jRQ7UukSxF5dr64DC/IaSAX9YRBK/LaQ4Jax9XFKsEuGPm/3cmDV3x7Kb38m0LIZ4K54KTvZ+tuWLehQBtRpOuRBzfMUov/bEaNlv7Po1i6vPEyx87mhn5w9bIHpvNNHCcwT+fPMBLA/ts7iJ+sW9WFqEjZ6DG/yU43kfnmYkdopaZKF0GsW2AyP7kdJm9eud3aiccE9pCtkfNgosDMwbQXydgJ6eLO9awCwgl/xJSxrmzOma/BCYfj7KHA/BrrnSOlxwurE5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3887h0SSxVe7/3H8w+67PcI1bqxhmwJbxBcqHT+TpQ=;
 b=E4ImGR0/EfujoEb+zD7ZWzYEHmS4Dwqyo7P6ylfD7tjww5gfnPv5QDj+t5eyDRKkWq6lObv/9ZfL5gFjkM8wD3q+gDH9WxnlC2Iw/09pb8wsP3Gh3oube4sSu7Ez18Qy/DJI9ZurYImY0z9SYIj1EvsYUMgN+oFONeyoU6IoVN1Oi7deFrcGbvpeIkTCGPplHntPFHSdZLp7iPao8U1Z7tu3kK6wdeVl4qYhX5ibkQU8mgB7Sj7f/TU5CIn0RnxGhx0uMpKTf6zkxHbIA/HA1S3oKXIyGVCmVi5abUruZ7fcyYGd3ZsfhPbjBfep2fqHTbvXJ7yROzdofH3zzyMRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3887h0SSxVe7/3H8w+67PcI1bqxhmwJbxBcqHT+TpQ=;
 b=NE+Jbk0Bbyzh9skP+YY4a//Nae5QypXtvwBdL034BTeIUvEtojP+CqikGIDV10x9WTo4l4XC3Kr50NUXZ/aRoIZDQgRco3wnJf/M8zrDfGnUKMgj+sveu9pfC/209gTt4O43u5QaW41rXSyIUNo6/1L7f9eAJy/aJUeLgb5ZNOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 15:43:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::25d3:de2:ef1:3884%4]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:43:49 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, fushi.peng@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v4 0/6] phy: cadence: salvo: some fixes and workarounds
Date:   Tue, 16 May 2023 11:43:23 -0400
Message-Id: <20230516154329.3155031-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d00f9fb-e9d3-413c-c000-08db5624578b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FklrDsuSJ4D4ryjnAcQwzT6eVKU9CnYRH1vEu+8RJco3EhFyPUzDMPN9AyjaLy4RKXFM9X10Fqx+wCbPPZmptFXzUSQ5wJbl7yTG6+OIZ8Q96qBmLn5q8VzGcozHgT2YcIScTXYtICUDZt7rs9hCtwrQYg+mqhaeoC56mNwg6sjLMphPXehW6a5hIAdFzqW1rvnNl73F5gaMz+8ZPBc/mhCAQTpvM6RJDwtBmh1TM59C0iSfZHy+UW6w8N90W7GCUtY31YL1PWeex60nDnep48eIb0QGZS6HtqPX/hSpG4/XJYNIJlOLnj+tS3vbksJ8BTzEqvr5l05RmJ7HbJdTTOHY/BbQ6tKKNVcWokgscGMx8Mizx1V7c9qvvbcnTeR+Ml2cPYQd+lG3Om6FYkQbM+7a5XJI1DmHDRfhCFh5RsLv/W1q0Y+gkrVSHXffwHjKFvvz7FEzkhvVpQEWSDeQ4iVLEfIgnT+e0Kp/oF4SESue40f1fQZWZFuIaREe8OddSGACwAKEYikyMVbyRZfcYXxBAgxYUUXLtbZcdFOweYLqjCvRyE3JpSSkJS+4fhmJtVEqndCkOakX6z+VUwwhYiL6527BQZCD97JdEwB6rjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(478600001)(6506007)(186003)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(36756003)(8676002)(8936002)(41300700001)(2906002)(52116002)(6666004)(7416002)(6486002)(966005)(316002)(86362001)(5660300002)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6GVts4o388z755XMrjWLST16i1Yk7dUlq40un07WyezpOqIi6ZGVK1STOs2?=
 =?us-ascii?Q?flCU0v10HqmxBJaYD0KOHK2Gee+AcuNtpx2MfY93xzPaUcl9RG9jx3tCcONp?=
 =?us-ascii?Q?R6K531CpRYk0gTDMexe71mAbSaOiclJnbe1uQL21DZyYU6RiGAMZOLXMNbwg?=
 =?us-ascii?Q?3cuYMZGSyhhsDOdu1JrBKNsdWLIljLhEnBpPofNJVxD7kOgsS6MCb6WiRzUE?=
 =?us-ascii?Q?/+luR5Fu3PjlnlVf+PHUgVSjxfnrVgRFHXhnwWSw0+SFfDIgPEBfRknM6KHf?=
 =?us-ascii?Q?Z8IoD4iDJ7kaGZzAX/e9I1n88wslSNxPDlXq+NE0Bxvu0xTVkZjnNfZebfig?=
 =?us-ascii?Q?fdqR5yQKYUTSAWIT5hTVymRrDpbeuCVPSgA9SuHc08/2Qe+awmlh8/uliagB?=
 =?us-ascii?Q?u5CNRyUvnS0OrfAmMBHh0wtIX6+X4W9ywdmSve9rEYqkX5c7W5e08k7neahY?=
 =?us-ascii?Q?gu23sP+BGozgRvqvmT/GQ6bh5IPaPUKBb8xyTCgTL7YE21c0ye8/027wtF+c?=
 =?us-ascii?Q?9kx0wnCSB89gHr8fjYSCO4ZYffMx+4q0LADBP9/T0QvZZeiydNZdGWuPpgSp?=
 =?us-ascii?Q?1M9N5EeQvOPrpu9nRTXM9tLqBKPwkbfCxdZgLIVoWTjW4HRd7fJqJ5pVHvtF?=
 =?us-ascii?Q?xITi+PF1p8VR+8vleFaAko5+fJde65NWfQM5y9R4WYgaLiudpv48f/ma1mR2?=
 =?us-ascii?Q?N+25Nntyb1+s88gJDM3+TLG3z2Tdy/3UtexAzggWEF36QjAmxu3pqSfnd4d8?=
 =?us-ascii?Q?gGgrEIBJNst5qIH0YXreJxYST0BSiMnur4s/5nO3VefCkKBkiWw7Fz/ljict?=
 =?us-ascii?Q?4gVpXXfjOd/FhhpjHx9Vdn0MWxo8ohXWHIGCWVlIBZFdZNUxMNxJedgHRDM3?=
 =?us-ascii?Q?lZGoruV9X++u6mBzmVdMmMW9URcjEJJGwgQ5l6Gcz4RQvEolwu9BOQLvgzpD?=
 =?us-ascii?Q?+3Kjqfnc1MvHa6uvXzu3/F1tVEi2Zfm3/IRe4EsnNRqo3mXvMEZqT11NzENf?=
 =?us-ascii?Q?7d90nlAgKuGBHnRmCqZ+lwz/RUCaw+xq3b3Ix56M/L2T8PfS12okmtnuwQp8?=
 =?us-ascii?Q?W4kegzaV3kEQ5Odb3S376qTSNOytACuw2eyy1Rfn/YPVM+kWjOHsKJ9veKSN?=
 =?us-ascii?Q?f8qEZXipAFzhAMi2ea8mwHXptwBWstQKS5Sqlx45jcwhu6zNgLeV3D3+9uHq?=
 =?us-ascii?Q?7r7Gd8XXRwpHXUZPCbUTMNkwgPvlYpzn8K8v99OrZutmbkhbMsAq+3nZ/669?=
 =?us-ascii?Q?JCikEdE6PEtDWcuW0AdfXAYh2Jp6mAVM+Q5Ss1Qnk8sYvJNRqexHcahATmLm?=
 =?us-ascii?Q?V94onU4aBrHH1FpzEO5qBF+2866OKonkf893gBaBhaKbA1HEJYrrDJj0oRgd?=
 =?us-ascii?Q?xEXYB4xjbydnQdwxIIMMAaATumsapeyq2TfbdtnMk9vaOgoyBFIzfxD0GTyk?=
 =?us-ascii?Q?FAS2yMWWZzqWRDuiSs6c7DDfdRzg+zQFf5QrQX0Ji8qmmn1yLc/txF+2fe7u?=
 =?us-ascii?Q?ISm5q4ejlAgpRMss0kTGu1yNoGHeKZLp7cbuNSzBSxxPoADbvx+dOgBSN3nP?=
 =?us-ascii?Q?Hl8BBb34xxA2VC7qEdtKs3HEmuJZViSw33TjkWWo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d00f9fb-e9d3-413c-c000-08db5624578b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:43:49.3835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dupalH2Y/xqKB6qEGWnj4wPkiSMZk0JTkxQVyS7FyiSpQfuiipxuWGeKddt+diph7Eef6VjP9BMezwcDnx2x/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I have not realized some patches were missed at upstream kernel.
Version number continue with previous
https://lore.kernel.org/imx/ZGOCT0Mdg3Jtar6c@matsya/T/#t

Peter's Fixes:
- Bist issue
- fix corrupt package from devices when start transferring less than 20us
- fix the FSM in controller seeing the disconnection at L1 use case.

Change from v3 to v4:
- Added missed dependent patches.

Change from v2 to v3:
- add cdns prefix
Change from v1 to v2
- remove empty change before #include 
- Remove dts change from patch
- fixed dt-binding-check warning


Frank Li (2):
  phy: cadence: salvo: Add cdns,usb2-disconnect-threshold-microvolt
    property
  dt-bindings: phy: cdns,salvo: add property
    cdns,usb2-disconnect-threshold-microvolt

Peter Chen (4):
  phy: cadence: salvo: add access for USB2PHY
  phy: cadence: salvo: decrease delay value to zero for txvalid
  phy: cadence: salvo: add bist fix
  phy: cadence: salvo: add .set_mode API

 .../bindings/phy/cdns,salvo-phy.yaml          |  6 ++
 drivers/phy/cadence/phy-cadence-salvo.c       | 96 +++++++++++++++++--
 2 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.34.1

