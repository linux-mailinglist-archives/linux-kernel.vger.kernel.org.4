Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF6263A0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiK1Fsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK1Fsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:48:45 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D441AE6D;
        Sun, 27 Nov 2022 21:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy7xOc7iCc6IJdVONQtN//nXa0UpzLfEs/sDYwq7iodwbbd21tehnPaIWBXqB6233J6ZVUrFWKrikfC5IzHA0hO46NhCktMbANgfnfBHsFJ3jObEVuh+CtFbWq1IkpStpfKNFnoSql4ioj3CulNaMQgsVNPunvzbf8b+kdd5HT6tvH6vzocdxnvsyHcWCZxJHebof8Ql3gzh4gbBDDWgFbwINqMH4N7GHaj8WdawX3Cz7+MhRJuzaSkqwTN0KkVtEHQwfG4wQBx5djuMTDj/8F4YKazlkW5XLJEhNYDfOVnxFDRpkxIG/Ql+J3SXW9JcNwrdhSTSwwXwczdMSAWaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcqryaXh2osR+0q4xR/lUluYb77/5Wvx8TRRFuAMHSo=;
 b=M1QeDF8252Bn/OSYsIctEo0n1TCcXbXjLEyAGZo/qL2dCbuPxP+0K12nl5YgQxYdziDaRaPO5nGo11I+N+nPDSTgWS4rkfEfV986hK5oYjKuNNF8ziyUHxxq/jVTpZiUSiIDyKMKqr9Dsf7t7q3DjlmZIEGyGwmKMelCd6yL9jZrvXomOlw5Ys93fxMxIWtDKvjUnVL0OWlnTQHxu/ewaw2LjUsNddsnP0y2xRZVhN+6c36G+Mcq8fe+BEpBnr8xJkCw7po34wFTCT8KSrWwWHMhCXjjxFBvYMqouJ/WQHFngGiLk5WHbjEWGtRb39vdjlW2eyFgquxqAQVEQGyogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcqryaXh2osR+0q4xR/lUluYb77/5Wvx8TRRFuAMHSo=;
 b=L73Jf9tx0wDWZfKwYwO0uxO+fZdvDFZsjgKMfg8KRBLmts2UKehNGvZjC6vYsCPcHhG74WMcQs9tZgxJzp2dX1ASiblCo30NzeEuQ205+bAe43p1kaCIgp/bb32GwQnpA6aHteW9sm6kioLGXYngAizupH7mTBgPkyjvVLq0sqP83Ffw+CzRe7MmzmScCZmQ1G5Xcxrj5G6unRErchwg4Dyx7Mc6g6nghwOox/KR57v7Ii1j41LBHFX88kSSgaz3+0Ukzv/+6rjZ86NaxjE0woKITxXpUnAsJst0Dzw1cdxRYPQqgOXYdQnKpl4uFvSKlV+ZANXcZFlpqE/bXC6/PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AS8PR04MB7829.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 05:48:42 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::28d6:1b8:94d9:89f5%7]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 05:48:42 +0000
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
Subject: [PATCH v2 0/2] Add pinctrl support for S32 SoC family
Date:   Mon, 28 Nov 2022 13:48:18 +0800
Message-Id: <20221128054820.1771-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AS8PR04MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 747d59b6-0280-4bc6-5809-08dad1043478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2kXiEKNfaT3UjEi+fzFulWOTQ3JMYdADet8qXhnDlf+0tWru9qQb5aDTpQx7C+JAjIyI5eCk17Kr+q2U1uOK4zpnNpJ9StAvoJ9Ax/VUOGDfr0zIQs+VXesqMD6Or0xmX4/bq2gctyvbYsHvFDYR27sYq/ASItggShssNAPkvXKLAQjNxSAXOya/Mwwa2CNYtfrlxaUd+thZGx8eqYZq7+ZYWEV1mpbCtqtG6atq8Fta6MOpS5nljUZfSBwbzetFPaag2diU4U0FLHK4kEc0QzcIIkiabo7b09riCG/j9CEjkw0jxj2VjMFvC2WyeCnBJXaSFl0dfHRnfBUP4SqaUCGWw1NA+DBHAjNl6vfZeM++u5i3GeBwJ+PLL25Cp3ma8f2AEckH92vztDCZSXDVWfshgevoMkgFgWnjkNMoh5m3mmxKUDksTS/iQvnjd0sQDdw//GJvfKYCjykUVgpsQL3QOjH5X9PZtFQbDWtnfDGAcR9gRzyjVq/G1SP+cYqdHLly5ROkJRDY08O6cAawEPTTK6ARsH6tHsYIJY2OOhVKffKXvoA1sRgSs86EjfaJ56bjhlcGvveEhVAge19hpps+sOrE9MW6a9ldFy4l10KMppgnCpAjjeb3rGTuBvGoz34NGUOAoEFRrqjAITrqOCcVOgmCZ7xgYzSCxc9p7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(86362001)(36756003)(186003)(316002)(1076003)(54906003)(41300700001)(83380400001)(66556008)(66476007)(66946007)(8676002)(110136005)(107886003)(2616005)(5660300002)(6666004)(6512007)(6506007)(4326008)(478600001)(966005)(6486002)(7416002)(8936002)(38100700002)(2906002)(66899015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lwnvMG4n0MTVEzQ9XRDldvEn7Ek+z56nZ1oaZ0hqHF3b1ifkYMMUpCyWoZhx?=
 =?us-ascii?Q?KJnYOcIJxqS9m/tTQBOXq+JDKMl4xdlxFXgICGXnaUzzk0UAa04MaUWepO8z?=
 =?us-ascii?Q?6NZ8KtdEIX3z2MF8/66N4ogBmwz8ORlGmWJQJIabmViCfo/5JAtQgetJNMbq?=
 =?us-ascii?Q?o15zavpp4Ms8XoQ1O+zbV8rsQsjWg+fLiQzXIUD/+SKfr3+vacT8CYF1ptjw?=
 =?us-ascii?Q?5IA0qeY3c+SBIU6KgPmlt+i9XZYpT9NcnnBV35bfixEGfCaCh4V8jp1ORFdA?=
 =?us-ascii?Q?i8WYSIF4V4DcMiUMp399n9X/G/h/PLq5pEe4SzG9HAUUPluj9oOQbfxvC1EH?=
 =?us-ascii?Q?zegEKF0MKl9zzfGLYjm+/0iMS+m6QNgseFt2QZKNgmXfx9Nn8INg4tbt4Yq5?=
 =?us-ascii?Q?BwMSGHsB3M4OUj8Xm8OFyz4S4jp1P6hZ9dPBDdUlWVKX/NO2Gi+WMzaan/4l?=
 =?us-ascii?Q?lrwnjwkTkwJeuQEl89Tg3UCJb3gQpQKrlbcsqzzTqgT5PHuP883TM/Nce9oO?=
 =?us-ascii?Q?6bkNoj7piF/C69PacbybXTyQe0g/D0BnwWE1f632LgtUSKFHW4X/oKYqMlD0?=
 =?us-ascii?Q?covjutYmDIEVRkk5bQGP1Q+90ZgfSX+v1HgkZuko7qgkeqrMTpCivFqjH/Ea?=
 =?us-ascii?Q?HWk+wJrDOZzkqKJhoD+NaDqXAj6Iq3qR6JCwQwfcU+zlN+rB5y08rNozu6o6?=
 =?us-ascii?Q?a1QN5LVmDfp6AT+eJZn/zO5IxIyr1dtnKg5kp6D0gLTa6N5it5vu6ptVyOSA?=
 =?us-ascii?Q?OC7GWUlzXfnS0WZK9f6h6y2y81l0JcAzpWH9l3+Af9pFISjnaovYcoo3Evyr?=
 =?us-ascii?Q?+Gf5duXtFQqzS4m845T8zgDUTC+UbmdHJDKUcLF8WBlGRoxW5SUydPmdduUt?=
 =?us-ascii?Q?FfaRGbM/cILjRNlp8cdlBotyf95nkEd/GDNER3dBPnHhx2ruoG9IkpWDiZqC?=
 =?us-ascii?Q?7CMCG/WZ0NImKHVV5hvwd2yJYsnZOeLuCLT4b2bieDlHZdUizlHTPfceKdMO?=
 =?us-ascii?Q?fwWDGt6Na7cxGvJqzMeLDBMCOlMUvgAvya9Taw7gj4jBvf7+T74DJuS7t3z3?=
 =?us-ascii?Q?31L/Zps+HrzmtnYIHdg4+JFSBf7xdl8Y9Wv+dyaxDzIbNHZnyBmK+LpWZ4U1?=
 =?us-ascii?Q?vyeEgGCZreAWO3Nbr1ejEcphgSYg8TuDicIibjvsYHIutUxQtAExkALKzI5x?=
 =?us-ascii?Q?4MXR04zpM5G05gm0O7N2H4Xu1zfOecuBkck+pKFLAkjCfleNqxbFcml64BiQ?=
 =?us-ascii?Q?85kPyx1nn/T7c876tjgqEvCacKKBS7FQ2u3KOflHw5YDFif9CHnFTriJ4xER?=
 =?us-ascii?Q?QpY/2b5+D5uHRK2xbHN+px0031VL+oYhpTFCueM5L8t/k2l0eEcNf6SqQqaD?=
 =?us-ascii?Q?SFBfKzyojRKLTFYjm0ky9iHQzpj6uOC5DpTimnG0jhz6y/Cqbr4tIaGAOy50?=
 =?us-ascii?Q?i8vyr+oNgubmaGr8aB/7d/8yhMsidHh6cVRXSC3Lw2Mua6EjdrIkV5Q6RJd1?=
 =?us-ascii?Q?VgBVf98hquz7xYp8HC5pGeh1lLKg7LsMzKg1p+bxQH9vnEAqRW3AlFtO1q4a?=
 =?us-ascii?Q?7Pf6n9dQJl4eWJYNJtiVSw0IlZRhdIjcmlyd9BjCoI2kMSV3VqE763gMApse?=
 =?us-ascii?Q?iM4U9uumN1h6TyhmyaWexyOdajzJe2Y93zEMu0cJt7jh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747d59b6-0280-4bc6-5809-08dad1043478
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 05:48:41.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCWQazlOq5lxJryuF7TYztqjNZElA7WpjjbiTqXc3l/vj4iTtarYZFKywoB5/4xI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7829
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

Changes in v2:
- Move the "nxp,pins" ID range information from DT to the driver.
- dt-bindings:
  - Fix schema issues.
  - Add descriptions for reg entries.
  - Revise the example.
- Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
- Fix the copyright format suggested by NXP.

[1] https://source.codeaurora.org/external/autobsps32/linux/tree/drivers/pinctrl/freescale?h=bsp34.0-5.10.120-rt
[2] https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware/tag/?h=bsp34.0-2.5

Chester Lin (2):
  dt-bindings: pinctrl: add schema for NXP S32 SoCs
  pinctrl: add NXP S32 SoC family support

 .../pinctrl/nxp,s32cc-siul2-pinctrl.yaml      |  125 ++
 drivers/pinctrl/freescale/Kconfig             |   16 +
 drivers/pinctrl/freescale/Makefile            |    2 +
 drivers/pinctrl/freescale/pinctrl-s32.h       |   77 ++
 drivers/pinctrl/freescale/pinctrl-s32cc.c     | 1003 +++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-s32g.c      |  773 +++++++++++++
 6 files changed, 1996 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32cc-siul2-pinctrl.yaml
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-s32g.c

-- 
2.37.3

