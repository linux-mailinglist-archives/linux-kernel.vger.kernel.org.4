Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08740613343
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJaKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJaKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:09:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBFA6386;
        Mon, 31 Oct 2022 03:09:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVxCdlPvFvMQM9fqxeqkH1dlrf34QaY/wph2VnDps2EaNsBp0WAYVxpMu/LYusBXbRT/ybT9KYlwSsXWybGOau2rcx81npKAkE4s5ddnjITQioINKimxUJwhwcuglp1JmxMnDla8+xbbXTvZ9eCKTWVwYcRQTSYCHyh5WBrLBRX2KKIVNDukEILNtn//0eG2QVp9SMHpwbZcRFPcuYisodXt6r2dNqeIxbD0nUoeh8xARp44+xzjPXNOxh3onLR9hxCHQWio6UCZA29njqrjMk0J19Cg1icPyG1QbRPqcCla0xcZD32uIL3QBSsZ3Z3QIEfenUPIeIJdlAONAyO8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgnSlVsv5zUNFkFATW2zz7zlOT6Ti1gDC+ZSgQJHZkA=;
 b=eWpK0tDgllViggTXkLWgg7c3fbe/FFL6IINZBpaXZx2qMj2vh3Dqj9a+qWdwKcfDJE1Za26JPjned2EhGmYZot3kZBDFyDeHZTz5sVFwApkV48NbjKEcYNzcX2M0xgq648Ew4WfC9Dx0Jj5aCFx0eBkzek2J1C7/k1FPusihzcT/Kz3jIS8ywLzfcBOcHipMdiSN4FMZccrZVVryBghaY4aveiM3UC+WBt55PqgUF9AaHS9PvbV37oKj2FW0fz4Z+nURBFnHRJ9vwopu8gghv4L8iCauFSSjcq7VdnG0FCgRgfvPAPqMEh/pN3+tbw8+Gw0atWtAZTVlzgGSPSkmJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgnSlVsv5zUNFkFATW2zz7zlOT6Ti1gDC+ZSgQJHZkA=;
 b=H0atyPFZQYEucZM+c/u41TqiL57JLyqG+sKB7qqeTGGc05nV9lmaJqOnsQACLOWi4rdeTauCP5mkLlaB/y+u3aRhPj+NOQeZDRyyyxf6x0K35Of3Y0GTqdQe3FSnpSKxJ3vHN9ITt03ihh8/8K1tavf6AIz7LJe6ywY1GSMohX9kxN3ZUGxL8VWv4fk9dkF/7vnRuXvK3YripbUfscCYr0dTPwr8EJaOKcrC3lPOC7uB492IbF0qnQhTSnZC/JaMI657AAuH3vUQNfuiiKVq6B63mwsCqmr8nfwHmuim1AAzdWbyp9dEAs8cMvhFdt+HbzAwTkaMePSuz4b7IdwMaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by DU2PR04MB8886.eurprd04.prod.outlook.com (2603:10a6:10:2e1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 10:09:02 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::41c4:5b70:6fec:a963]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::41c4:5b70:6fec:a963%7]) with mapi id 15.20.5746.028; Mon, 31 Oct 2022
 10:09:02 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 0/2] Add pinctrl support for S32 SoC family
Date:   Mon, 31 Oct 2022 18:08:41 +0800
Message-Id: <20221031100843.14579-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0207.jpnprd01.prod.outlook.com
 (2603:1096:404:29::27) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|DU2PR04MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaf5540-9df0-486d-71d5-08dabb27ef42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8i3vt2Dlffa39KQANf5eC6xMzXCFhYpsob8oOhy437d1xkmUrCwdtKKJVOQ8VRKONQlAggxpKS4tYKp17zYS86fQkRDh5ETJKq60w6wpGx3MqPKUTzcZDL6GdtniTJDRIdZ42dk4sLvtRCusbNvt0P/pDtY9ca/6g9naVPWRArw/spob4dvh18RlDZO95nnWXc71Oo7NOzWaJ8zEkCMfUu6Lpv//+S5mljHufYpw7OmWHZykqFQAZwkpWPKspOsuPKEbrig7tYJTJ0ppr0KD8FREOmxvrSrmYaS+cqZw+e4q2pS9RwibjZFMDWS3NrHn0kTvLUrrlQFOf9VYwQQVLAvAGKVIHbFTZiNVOZKWqmkQ6817gwKBn7ypy8LZ9ChdhbNfwYTxfXbrHmiBTw6gxVPujUDcDsOnaVYHUjnlY+jnMbe20zmu/m6hqPsQ/nJagP6BSpcRLvjD33GD9ie9h4MXgsOsYabhlBGzf4K/su4ydOLcAbwAp9N0dmDbnPI5M9ukYIwX9tXJinxC52Jtz/40kFZknA8WnEm0UkwfCJcWECwpsqH59ZkEvBb1n669Mdqto3qrooE2WUYWpaKNwoRwHFGLr05TUpucEazzSLjBbhcXiELpdG+uS/Xpu/m6vQ+XfOLJPP9dAbr11DyjS0IXjvOrsBRH57w5ko+mhmKYeRGRM+S5VOq8X05A4ZPHm4OIcHLSvPkBy+wnlaLPPdscpmykh3a4MGtJcXO/04Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(54906003)(316002)(66899015)(5660300002)(4326008)(478600001)(6486002)(86362001)(8676002)(110136005)(6506007)(6666004)(107886003)(966005)(36756003)(38100700002)(83380400001)(186003)(7416002)(2906002)(66946007)(26005)(6512007)(66556008)(66476007)(2616005)(8936002)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xTC9dme1fy+S1qXFHLuAT04tr27OrVR4ecSBlSj7DH0thLiJdzbb4SFBYvhN?=
 =?us-ascii?Q?RfPYEZwCZa+GNswU+IaFBWXjmaxfiUvYwrDPF/kzukPygBapqXBqGs8NPcon?=
 =?us-ascii?Q?Zr9FhCeQlKnqVdt03wIX6GpJFDKKtMvq25wvRX+1+ESBW6K9kp/k6xiUcXkA?=
 =?us-ascii?Q?DL9ZTayaAdDiZmavtpA0pUL3+D9Di2QwpgdmTjsZc08RpEjmdlN9i9bI1giR?=
 =?us-ascii?Q?0MeGYYtv+fIXtgfoPmUIPXvlWFRL+D4OeL0MYrCpjg+LfOKwOxgK3IN0sYTw?=
 =?us-ascii?Q?lUPh3g8FF1lYT/wwMrXK+6DsQaRf9Fbhjhk1XB9r+kfP9UvfHrNUPObRkRVO?=
 =?us-ascii?Q?e3JCLy0LR210juJPVj3UzHIiEv/sC/9CknEeSIFODFN+3pvuA4xTSamDLlaF?=
 =?us-ascii?Q?qpqh65kiJ2yFJB+mIk3zIl3cq8m4mxfH3ND7UyxvrvUNyBbqGQS+uMIDR5Ti?=
 =?us-ascii?Q?3sqhmKO+ARsTCPkmrDrGtyd5Ab8PX3plmPpmG83NpkVljd249MkHdLJo1N+c?=
 =?us-ascii?Q?Ikeymzs22C9mdojmUppAdlPVG8wK8gDzNDNQxvYDKhSyI8pIoMCxdQ9ecr5l?=
 =?us-ascii?Q?HAd6tPI2YPMecUJdFSK3AQYG8s77G9FF3eKv/e5yKVh+jOlYVfGR1fA/E5h4?=
 =?us-ascii?Q?h8k73r9oqBGpc2Yxj4GU6V4uOQ2AfEyt8O21U9JVUFiakoxA4LHoM5bxuNJV?=
 =?us-ascii?Q?EPcUhhmwlQpnQCOq3Rdc8bTTsmGJJDx3MRr1xL7j9FZXlIXTaldFpN7aXmFH?=
 =?us-ascii?Q?vG44MW3Uc2ZZPO3phxFZ/gW49eTDuTxzJRErQGOg9zJU6A4zVilXEgrga4jt?=
 =?us-ascii?Q?ZXvOrdqsFTMzJgbU3kdBtXq5npYTleEJczpMBaTWTx2h6oeVA0RQFn3HlwVm?=
 =?us-ascii?Q?HnmClr720C5FgfnCpEDRB1SW4+eFGkuw7JuvpZBuhlzCXEXpSTylgVRFzgtF?=
 =?us-ascii?Q?gB+0Gxf2143rCUv7lXwgLgMIYWsME7og/Hr/i2rXjV0JwSQzWitUNK20bk8y?=
 =?us-ascii?Q?k8Ui9Xh++uO+ciGnExu0E6c8mq6U9zFCIu+kC3F/F2HLGNLwF4WIn/ZpMyLw?=
 =?us-ascii?Q?3gx/uoMj47WChVBcdridUa2Bdg2gCuogvEozqSeW9RXjYwxtcaCAS1hoWr9T?=
 =?us-ascii?Q?RdNPWehyX2+vWJ5k//70Nweev7azzpWhOcyvKEfG2msSmWVR4kL95zCPFr9C?=
 =?us-ascii?Q?46mLIzJi+ayG/Ve4lFc1ha6oJbrTRll89G0MDFQGuYclnYgsyZ0z0GXC4lC4?=
 =?us-ascii?Q?npSNPJYQ4pOQC8n3NepEZmdCGeHoGWl0xtxYOqTJG2vIqJPDxR43Vq8YGekz?=
 =?us-ascii?Q?EnyFfqfkszvqha8xY+cuoZo80mDnyRww7NWYqYi0MKrTggZfFGhiCq8OmQ92?=
 =?us-ascii?Q?IeQwhMcwglOL/A15j86yepQbedCU7sAAy1sYn7E9bP40eCTCJ2og3CWjrS21?=
 =?us-ascii?Q?zVyJzEi5MwVszhNfX41Totc+mvjtrjdveLUZ+mp0qubY52DHXHKQjyK5dd8p?=
 =?us-ascii?Q?xGN8Y9UnrlmLaOrryrTHW9kN2gEKqJAfybR7+tj7m4bJYq3rU3wtUyykiA4C?=
 =?us-ascii?Q?63PdX+zR4qrbXdHafTE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaf5540-9df0-486d-71d5-08dabb27ef42
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 10:09:01.9980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsXb5zyGO7tuX6XBW5FKlaXAKwfnhPiv7uxrwbm/L9B4MUHKXNw+LU9gq+ALXirK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8886
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here I want to introduce a new patch series, which aims to support IOMUX
functions provided by SIUL2 [System Integration Unit Lite2] on S32 SoCs,
such as S32G2. This series is originally from NXP's implementation on
CodeAurora[1] and it will be required by upstream kernel for supporting
a variety of devices on S32 SoCs which need to config PINMUXs, such as
PHYs and MAC controllers.

Currently, the whole architecture relies on FDTs offered by ATF[3] on
CodeAurora to keep the flexibility of handling multiple S32 platforms since
now S32 clks can be triggered via the ARM SCMI clock protocol and clk IDs/
settings can vary according to different board designs. To ensure that the
driver can work properly, the dt-binding schemas in this patchset are still
required as references.

Thanks,
Chester

[1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt
[2] https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/tag/?h=bsp34.0-2.5

Chester Lin (2):
  dt-bindings: pinctrl: add schema for NXP S32 SoCs
  pinctrl: add NXP S32 SoC family support

 .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      |   91 ++
 drivers/pinctrl/freescale/Kconfig             |   16 +
 drivers/pinctrl/freescale/Makefile            |    2 +
 drivers/pinctrl/freescale/pinctrl-s32.h       |   65 ++
 drivers/pinctrl/freescale/pinctrl-s32cc.c     | 1023 +++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-s32g.c      |  759 ++++++++++++
 6 files changed, 1956 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g.c

-- 
2.37.3

