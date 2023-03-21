Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C226C3577
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjCUPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjCUPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:20:15 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9167681;
        Tue, 21 Mar 2023 08:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd/J8R5HyvhtLUOtb7S8i8Hj79UM1PiUXPih4ZpHABXGHjxdISXaG7f4/1YYTPUhEIesPMTOCS6W/lLHx2GNt6WQPtHlRyj8e1IOgqmFvO3FS4u9CfaUYHssAjpqH6HfY+S7BaNY9Kng4nfU0sCUYbA9iCYO89G+6wkcX+prtvrsxAW5nMOKhCvignXe5J16yO79pN8wtEF2wBi3lVAE9LtRC/MbClTJjScNgFkD59UYcbi89px6smC/EHVErc3EFaGTHYRjNh6pzKe6reMsiD6Fzfmgby3bLtjPBURbnKWdTUEeCsXRmkAEyJAGX/G5w1yNQpkPASxyk77UK6tVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CFLexbop60KixCZ9ON8hGjdQjfSCylSY+TLEF1UhoQ=;
 b=j7Fwoof7wAR/A/mSCuokG/IGDja3DZeCGkJT1jMoPQOwMtiUpVH4CbJ2Du/nY8Az2b+1i+ghNWGy/X6H2kOYawJIa3eP2wH44SckNEkVy1D2YbnM1lF9L4aBD4XXkptitMXTDRE773554G+4K1ZbMg1lkjH+qlaPn6O6LWdteYcJA4m2FobsrtRtfVUBw/TYqQmKEeUPgnuIO6j/Evs7x5fBSnhwGCW7/2iAtOJWKdDAGGOwgKZ0PGDc/jqhPMGBO5xEjonJueZFEXEvkNNXcviSfLT7tA7wPNalyRya38jqCrtFHVNOqLq3ocPKkFnInhH5aP38iXkhTNFvKGbMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CFLexbop60KixCZ9ON8hGjdQjfSCylSY+TLEF1UhoQ=;
 b=b3C4a3xi0EvX+ftaz5UEWZF81bNmluyNO6gPbCnVvchlamOHT6hp/8LSqEqnhl87Q9h+q9yKrRxE7eBkWzqYgTF+OQ5waA6E7wBiSuqYI1PcZRMU8Q/0Kf1sNN1KOu0+mtzyBwSf+zUrpyNl6Dzq2VVjrnv90qrA8D3zTDC0ras=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8819.eurprd04.prod.outlook.com (2603:10a6:20b:42e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:20:09 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 15:20:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     devicetree@vger.kernel.org, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: [PATCH v3 0/3] dts: imx8qxp add cdns usb3 port
Date:   Tue, 21 Mar 2023 11:19:48 -0400
Message-Id: <20230321151951.2784286-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:180::27) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a81974-f007-4c3a-6934-08db2a1fc231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MV3C8AA1c3lAxSKntWjdTuQJWBD4GhsJMTyfLTLwQeiEVkqrIPmjD/nKS3vC6Czv4NI8nzgy5PQA7MOPsjAVdZd9ijuQBfYrQlK3qEZhdAXj514SWUoZ8DGR32F1KgOiH6lrpOZJIpMRU+d+UZZviQVOCXlzTjOdvusNRrNUlQvhopUysaiOBm2q/mNsZLTVnPTuhtnxZmG3r2W2Y6pLPUDI96oplpAp4rpITaiVrWd3jLS5knpNxVzSOQpd2ByNChWPozTik+FxvVKgPO/TEjzjcnQ69tRsI016L2QVlXIopMMVuhmDDXn7P9fnV/TtuJNt8T0YuAsw/6j7+tdXV7IrDgB3ZVZtr/I+gXCyPfEsGQ95jXqSknuTCibiu8Jgv9IcjdlIqu96YyhUfhFtrBTa0fz2pyESV8G82XvnKMjDjwZmWEtwdxTxo0ox1QWcpvHZwrbi8jMFIM/vTyurXWK3dKwDcZPU/OiNHu6n/ylgif6l2J0uqejaDGpLYKuKjXaypBbH8JIUyQE/wBtRlmRfY+u7jdBpsyU1fMb1S6HIygG19Han2X7jKtfAOvRQ/sSyWu67454i4Er08Y/j3Zkak/4aHI8KtR3BTJ7ygGSBY5auFrzwdttc6b6gJSThWq5hi2mbLUso7KDYM7nVRq6118cxoF1s+7aJK75p5NTL4lP0yxnPHe7s1XbFoA/3nRdsjYo4K1kx5/Ehr5esVdnCZ+89EIEVkDmdrMS+dQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199018)(8936002)(41300700001)(5660300002)(7416002)(4744005)(4326008)(86362001)(36756003)(38100700002)(2906002)(38350700002)(6916009)(6486002)(83380400001)(478600001)(52116002)(6506007)(2616005)(6666004)(186003)(26005)(1076003)(316002)(8676002)(6512007)(66556008)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxV6vku+P1RHe8Ha4ekYmnjPyp3wwzxjI8nmJbhBLivusHqCGgxps8OZFd5c?=
 =?us-ascii?Q?pJXz44NWBXj6IKF54QI73Amr0JAEcbofgna7LIoIvAL4Y5MrdACf0aw4npxk?=
 =?us-ascii?Q?RzvhMLtCE/ceMrlGUC7OSVwm4D7FpkjoL4RFmXHcYDOmnexWKnD/z1JU8xbB?=
 =?us-ascii?Q?m6LlEWHeYEnfj21C9aLmK97PqoGTCzAXN2oib3jzUSfVx95quG92ioTx95UE?=
 =?us-ascii?Q?z8q/62soBPaCv65sbhgDcyV2qmAoqIQdKK39guZiRZ52ooSO1aHtGEU3d3ln?=
 =?us-ascii?Q?Q68e+HbgCPKR/vhsmwM/1qirCniCs9hQ9pkd7bOv7fo3J1MFuRFAWKhhgUoK?=
 =?us-ascii?Q?mu/Ctk3PEkXdxwN90gYnXIiLdJKtkVV7OLcqRslQUYToQtrnL7R07jDPmXpx?=
 =?us-ascii?Q?03wlzKjcIWT0+AIi6ubfOmJH6+G0jElAV0RkqxC4jWLc+yrJgkMsWoQlUGtv?=
 =?us-ascii?Q?sK7CfldM2Exh6vkUOwHYz2pnu6H5RUWSCnjIukvoHA0UOCDu/uGbABdR35hI?=
 =?us-ascii?Q?Kuoe7j+jVyH/U22IdXyNJZWiGgZYDxehL4V6vUo4DLHGtatMz4497B2zPJCQ?=
 =?us-ascii?Q?GdYN5xJ81Z5fzfSnSnJXllCRmTC4nkhTcVY+Dr7X0Nyrg5tJaC3DOkYplvQu?=
 =?us-ascii?Q?xQtHx45eBzlC/EQiEDoRfOQF5BrwHVzluUj+BrXiKZhBkMpcZeibUt80zJrr?=
 =?us-ascii?Q?anJng84SKBzxI7pHaEag3JZrRVZbO1WwRdqsp7GM44cPjWDfWNTs0lsG0MhM?=
 =?us-ascii?Q?L8FselC7/0+B6CbZKbnjGyOYuWNPhgUcOUnq5qBu3f7sEAjIGbpnyafzBfku?=
 =?us-ascii?Q?CcF0hKzEmf8RV/tiOBF+CD5E+/dFxv9LJ5x0gCWXpZtEGnkwEnpYU7R8Xx/l?=
 =?us-ascii?Q?xWJl+0TbaIuBoLJqKZXFs9Yp+rvWdbdJur/wX/choQQ2kczkR/QCXq0rg9bM?=
 =?us-ascii?Q?dZXM6PQdbzt34dCyRaDNx4odYSdNVkWriOwtTxd0QcV7zsnDVSHefVSQa/mw?=
 =?us-ascii?Q?nrJ1Y633kn/3YLK5gh2OjX8cUQabSBMSL7+HoR0jtmH/u/LVDEYo5SpgNq7k?=
 =?us-ascii?Q?uJTRDczKsOXu6pxQXiL/n7jiZICMo7GDM3kWFiV2ocZuCTOMl2Xh3s9swnJx?=
 =?us-ascii?Q?dAHhbpu0dvKquqq8lFvatwmR+C1ZYXtuQ8Zoh0+k9xdI0dVoSwxK6rk2gfxi?=
 =?us-ascii?Q?PSbZBsGsimolqu2BU757hSNoQ1vOVF7nXsKfsJrtQ/buFyyhLMiCYAPDI3vx?=
 =?us-ascii?Q?ggJqCeV+T7YuzkFibCzeD2ISWFxF7HJtAatu3Fpux+Dkjpl6TgfsG8VgJfu8?=
 =?us-ascii?Q?gf+HGMZaM/SfHEDnUEuOq0tlxCUNHupukiIpeTol7SwLUUTAUhcC+dplf5PI?=
 =?us-ascii?Q?bOLo2T2OXGxu3f2DmCd+aVj+quWAjDPvLVlUvCAPxABOEfeysuiolNRXugE3?=
 =?us-ascii?Q?HnkXtQtNrvtAP6mpcIROeGojwyrx78FcQ1YJOgC96+Ft8brcK5e3RAfsmaJL?=
 =?us-ascii?Q?Kp9YIAnJ18WxvikqiuZ76mv4XSh6abWp+8FxWyIKrQzIlZXyDTjNgor+Y6y+?=
 =?us-ascii?Q?oOlsxq7VZO9YvnLE5ZNET2/MZF8p74tkcJDLUlLX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a81974-f007-4c3a-6934-08db2a1fc231
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:20:09.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILlwsnLLL07qmX6R6uSQ83MZCzWgJo+f/SBkQ9P/K5wKfwXAfc3Mci9ZATBSqQnjClhXra6JQh5m3dbRsaxcpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8819
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cdns driver code already upstreamed. but missed dts part.

Change from v2 to v3:
1. drop fixed frequency clock binding

Change from v1 to v2:
1. Add binding docoument.
2. Fixed all shawn's comments

Frank Li (3):
  dt-bindings: usb: cdns-imx8qm: add imx8qm cdns3 glue bindings
  arm64: dts: imx8qxp: add cadence usb3 support
  arm64: dts: freescale: imx8qxp-mek: enable cadence usb3

 .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
 .../boot/dts/freescale/imx8-ss-conn.dtsi      |  72 +++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  85 ++++++++++++
 3 files changed, 279 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml

-- 
2.34.1

