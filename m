Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509F26CA849
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjC0Ozs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjC0Ozq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:55:46 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F81718;
        Mon, 27 Mar 2023 07:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj3eyv0GWLCbSt62CT5yFnvhhZQ992sN5Lj9oRP4OLFKjA0zgstUaQ7C8hEfdPmHVarSLH/fDlexNKxugP2GRjiuCfhnHFyob2Kubv+pRTBBAz0mr3ryAmtX9eElUaVFeshM4K49gS/ZN0ylH8RmLORj31Hf/y563n3Gef/jdd/5Wupy26PSzOR7riarIZRiWGNH37DrBIhsMPfEM3ROM6QiQN8hzNX585uTCHMJsvtlAtoS7XeZJy4gyrhY6fVIPazYqNyg6I8bdbOxPq5QEjimXuQDemKEd7ZzQo4T3KfJmfocK/3dd6ipXxeqkec4fj8FWK3pvawvDPzCevhJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NELi6ZnhwgglsKO+ygPAAJjJq6LN9Ma3yGRUm1Mi8H4=;
 b=DKiFC55vRQGb/2nYb7cj58U6IReEtuOATkNuHjlxAgcWQ+TMDUE7skjw6P9QeGb5HRtGbEFu+g8NjZ88lm1EeaFBh5q30yfWc9hjLLn4AmuAETXwCX2Aj5gUYZWz2nQ+j8GJkTs+GCoIFqKVwE0RCCaBSSd4/R+3GAoPQb5efMrUYS+aIv7BhRZw0HeeIGVJyWl9sWN2TT6HSgAMG0tTSQB9qF6GNb1fgaXWzFfzuyG3chLitf6mhG3CHRXIYT686RzzkTN8rLeddXz7Bh3s+miRZJD2jWQ7CB9y+o2ylAmiYsgQ1a2qERyeu7MKEPhmN62oQw8EdIhM/SNW5uAzzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NELi6ZnhwgglsKO+ygPAAJjJq6LN9Ma3yGRUm1Mi8H4=;
 b=JNvrjtzoxZe+QLIkQE3OZDJgFUkOKMyadtG9lH7b1nNZRM7xRvZuM8Llz+xT9iuQU/bG/X1DQPzD37AUXkLtI36wsms7Cgj+SoIYO36j6Swv8tKscPbOfZqSaj3PvOnrYrxdCvF1phKqbctCDuzwuBkvE2zMC4Ge4lt3kqwmB7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8640.eurprd04.prod.outlook.com (2603:10a6:102:21f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 14:55:42 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6222.029; Mon, 27 Mar 2023
 14:55:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v5 0/3] dts: imx8qxp add cdns usb3 port
Date:   Mon, 27 Mar 2023 10:55:20 -0400
Message-Id: <20230327145523.3121810-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: c6790db8-dde0-467f-b48e-08db2ed35614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: am2AFdDNYn7cYOMW6osYdW/Pva+djNOR+TS3PE6lmLniZ8jmRiCiiQdZY1fdI4HBZDJu1WP6GA70Bq+Zucd5hmaF/NNNgToiv9hREQ9DZa7KWWrQpkUd5HzgQw0jpFH0cci/JGmZkeHjtsOiGgLsRp0kP8+VbFSMWhAmUlloVsmTig29h/U+1g9ifxEQMt8rPfjFDUtv/AdVV+Wco1zbHXtTbnHCZH2L/Rl568Jx9LX7x0tzpTAUW853QwSHnKbTwBHQby8/IsnEspbCLh2RwqVuIFg/jX4Yo8XWKGWYXeMi1S30OWKbGNKOaYnHo5nqZKEwUTNaTFP5HY09ClJ98ywv8URsZyvv02gKtk+O+BBcpVgZTvX/g/4ea+va2LP8jxv4+CJAyrhxPlJ6SMc4JAb6anpEVC6+9qBzJmYkCwaIdufHKjztprXOsjGMl7UNleSh/kSvrNVyc8Q8JaAToj6YZ97RFcrJ4+lfiPneWAxL613FlX/U/HfFo2Lc9X8Zu7QnY8ynEUQS8BuFVneOwxXGvNT9VdUUI1pCwU/deRr4jmVi/EMbZdZxlTg26miOZ8b8AwSSbDgZGmhIQL0o+2JSMYKUzA1ZWBwcU84EN0Z3glEHF4tM8qCPXF9/fROYRew57hURQ/geBAaknWUNmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(36756003)(86362001)(6512007)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(4744005)(7416002)(8936002)(34206002)(6666004)(5660300002)(41300700001)(6486002)(52116002)(4326008)(38350700002)(2906002)(38100700002)(37006003)(316002)(66556008)(8676002)(66946007)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z7swYPk81r9zxpAEFsurgPd5fW8/7RFoPcfVy4yuX3nYZSFML7J1BRuAQ/tz?=
 =?us-ascii?Q?nj2lGfigfzmKxkvi5kDJhsRCLB7XE7Ua8esoIzRGxDAvhpdeOyEuPs00T714?=
 =?us-ascii?Q?VkiPKoyDRAJapL+gSHIQe34qYgnd876VjfVuo06ZYIoG3Q3Bv05Ay62+A0Zi?=
 =?us-ascii?Q?SAo7xX2L2iv2Ozn8LSSBgDfetBWNTOx6FrcpL2RvN8qVtkIOw/l+nkQE57Dp?=
 =?us-ascii?Q?g9f62ijYZ7zcOIM4DM05bMikB3c8Bw2poRm/psR/0xuvVKmvLAEG6a4M+Ew7?=
 =?us-ascii?Q?w7jadsSQfMalj39y17dPdIpz6v04GQRkPPW/RdnxOm7KBe12cx02ByqLUTWq?=
 =?us-ascii?Q?Cwf2YJLQYhezqwF3VHgZu6pf1mBEoFQpuXz6dUYuVmUXlj8seKEPG661M9/Q?=
 =?us-ascii?Q?DVwGEzvLj3EZR2v3RSaPDJMbhBaxUYpMradz3BGuZiCDjXb6uOSoyK7O+YdV?=
 =?us-ascii?Q?t0kdu6sv1kPtsnsZdg/GixpyW66jByTeD4NektSZX0DZX5xuKVk0WDpplDPr?=
 =?us-ascii?Q?rGY79nIdoj/P+6yoTbb61ZxUFz1hjFBG5hI85W2rOHkEtteDF5ngVPLs/SsC?=
 =?us-ascii?Q?lNRdcd/BakAOUT+eqHXK/+iTTRgCx4fQDVBYJgHVjTu+fTIkN2rOix87deHv?=
 =?us-ascii?Q?m8v4yu70VGNSFM9RBMozZVmR0BEKh8WLN5AQk4Btq3SvKktmK8OPttd2cndd?=
 =?us-ascii?Q?56DVLD0r4iSjbxasUfmwg9ehfBo2NwsHXTJ7RuG2+h8aZad+C9ns6Sdyebi0?=
 =?us-ascii?Q?krHKPJG/y6MPjx4n+HwDF1vtEBx8jXEh4KroGDB/Z36jmMnGiCXYt5QmUvJn?=
 =?us-ascii?Q?+KT2E36ZHeQa0KJP+sWeocDxMOKKUtXDw7TfsTdyOq0uC51OZDReG8dAW3g9?=
 =?us-ascii?Q?cqNX1bOd0Q2SaXu5gFAfvhTOsDTgPvlLvegkRIiXpfvibUubWqQSdwKRXdSk?=
 =?us-ascii?Q?pOyy8OSoByu7hCGN8cJLnpGc3nF9WE4IkXj08rVx1Eil3GXMkbzHhCLyKRxe?=
 =?us-ascii?Q?4AdYqT5OAh9+vW+f6oMEsox+7jZyK7FWfqfQeao6T4gY66ZhhEfiTvG/4NjM?=
 =?us-ascii?Q?v2wNYu5m2Zt/tujnEhF3Bg1iVSprZWzhy1aTp5D6iUJvxFT9Iv7/eZkG0pR4?=
 =?us-ascii?Q?J9P2KQKArEljvoL3yIRCb8FXb8XJ/yWcKmc8rNKSpPPi109N4hNpkLjzc1XF?=
 =?us-ascii?Q?CIvhTXeipRqc9N1weVw5vUwvx+cH5n8dbf0M982NH1pNCchFaJlxBge/CbHe?=
 =?us-ascii?Q?lKdJexrAWdKhlYTodPl8Va4o2Xt8r1FGy8ZhYBDOlhb8RGLDgDOEN4vfndjg?=
 =?us-ascii?Q?siCbUxhG1QQhKctV2GjRziD1yfzJra6S63Kwe8/1kLhW0fdWaLd4eXrtw/hA?=
 =?us-ascii?Q?BgULXhlhP/Q/CP3N4T8EgvNfaP/9imJCsB2VAZRkMP6bhdGyKdNP4pzVyemo?=
 =?us-ascii?Q?hwDPQsWRoUaE9YIjaHGK9K2XyZDNrRl0Ah3WBGDnz/F83MNEyJQrdlgWazSe?=
 =?us-ascii?Q?3Qb+feak+rpIePWGh7+L7P6nJ3KdQqSkCF+7iooyIVMBHb1Cds+zZeBX1VYm?=
 =?us-ascii?Q?qUKc/6KJF7IRdRfQoHGi+LhKAY4QaVSCIt5yaili?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6790db8-dde0-467f-b48e-08db2ed35614
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:55:42.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDqgG1ePNIStKPhsHnX0knx8n6H5A81qZ8PtRsUkEo1inSpyiAPrViwNcur20kojAu8sSOF3A0nKOIU9R+XUdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8640
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns driver code already upstreamed. but missed dts part.

Change from v4 to v5
1. using shorter clock name

Change from v3 to v4:
1. drop assign-clock in yaml

Change from v2 to v3:
1. drop fixed frequency clock binding

Change from v1 to v2:
1. Add binding docoument.
2. Fixed all shawn's comments

Frank Li (3):
  dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue layer
  arm64: dts: imx8qxp: add cadence usb3 support
  arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |  72 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  85 ++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

-- 
2.34.1

