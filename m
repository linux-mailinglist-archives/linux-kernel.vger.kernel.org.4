Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECB69C423
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjBTCdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBTCdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:33:45 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119C19010;
        Sun, 19 Feb 2023 18:33:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itpyy7h7qaxNttfs24ED9oAyptOBYGK9hiuCYdUuOwEK2qvbtO6NnCqx7h5GAknEtSFTl4Y55KI/NA+P7+Ets08eWDnMwYOtKMeiWApQcf7U+YTzZKMhTiIERQ2RUtsUBALE3K0tzDUhf41LjTVhwLzc13FlUZGuzgI9D1/Y4bHg/bc4QXywRXVGQbWqLznXDMPn0Y+hwhe2LBebBnxsnpK0bS9DJT6Nh6SVT9O0mrRGG52E0RdBrseR0aYg+HQRmSFQeIZM8o3hdb6EaL73Sc4K4ern+DUnIsACiWVpMQyhNPcGm2VQPseez6dqo/CUt4YoupeXDe8viGkPfZGAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpbTYgyuYRWjQG6odLowPacC7raQfylLb/u4+/7cZ6g=;
 b=CytxxxVjTgzn71jBziYYpl8dD3+/AKNONb2TAtm7/Qag1EN0AJveziHaUUduOPPfAyE9/lXpfPeL9jrkohJwUW71/NRraIpLJ9d+Wl+bhqAJvNKZmlcrHIoTAHo5ZRQ5SwvIgZM/FanjeG6dzXuIpechhC6nw14VOMyqyB/3CoIgmURiGAFIw16iC6O8+haJsJK6iJPaYiXJXnmSbBNcaUrUmB+WAOHzSbdelmob/HYhxvePkcg0SP0hpB8MWAORfu316iyjHk2P+/CvqNcnPAgBiK/nI4OyZxlgG0BcyeJCJNdieNZyK+pMD0dYGs5V9Q3xOwzdWnuCmtSE+jSOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpbTYgyuYRWjQG6odLowPacC7raQfylLb/u4+/7cZ6g=;
 b=xDkD2ndD45X1SzQWwvn3SmdFQGQBEra3OU3/M0HG0YcD2L8ipwGubydnJFG3rfXlvE+J/kf9Ovq+566bhcIBYrTxE5PbjTUHxPPmaTcvALYazTqC1naSvFUXezrbFlWJ40wmR+6/arUeQlV0AX4xRyPf0ZN4p97R1Y16OUiFI0RZ5UsIAX+Tw0QGr5QU+3WLZa4cq30JU5O+1jcFI/E1zRjWjHjZpwMjbt3f8xWkCsNfItTegOW5DccAJ6Hv0R4QYsSnKGCvUUCgFIOUOSD4euiLSiI6IBSmsq1pIKwb2htuCqWWoEY1bh1OnIdmRw+lS/bb/HRFFcouTYoc9LAVxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25) by AM8PR04MB7762.eurprd04.prod.outlook.com
 (2603:10a6:20b:241::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 02:33:38 +0000
Received: from AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3]) by AM0PR0402MB3428.eurprd04.prod.outlook.com
 ([fe80::4157:bcf7:8f05:fab3%6]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:33:33 +0000
From:   Chester Lin <clin@suse.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Chester Lin <clin@suse.com>, s32@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v5 0/3] Add pinctrl support for S32 SoC family
Date:   Mon, 20 Feb 2023 10:33:17 +0800
Message-Id: <20230220023320.3499-1-clin@suse.com>
X-Mailer: git-send-email 2.37.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0223.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::11) To AM0PR0402MB3428.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3428:EE_|AM8PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: b383b776-5e88-41b4-a3a1-08db12eadc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IjqbWvMD+r2sW2AxF+Ig1lx/xY+zUkKkbJbi0glXpWr5rmIh437Jji+RN7/+bQ+VV+6RinMjFGHA1G5MrSVEGeBabwW/c7+9gc7jrk9aJy8V8A9trrFbCQT5ba+PcabcCeCoKyRfJC/mAXKBBWI3NhfnrraSIRTv1JCoaFr7Pc+TxRI/vgPF22Tt5Venhyea0vC0rUMrrQIaY0/xLhZ3OROkq6XSOzsgvDRbk/ZSvPdawSPeQHePw48O/cnzNDhuPk2XvMZ55fc235cLe2t9eP+ssWfvJ3xXU4HUL4gKZmdWh4jdWYMjh6LbfuM8fCj7F+sltiokqmmxuyrpEL3gcofC5ddsvN3uVxy4aLwBEIIWHU+Leo04F/pp3Ok9FXBX0mzqKsW8h8Byvb6WK+0SqHcgT7WK3gfJEoeknt/CCAXUvDAHJ2AwVX+Xi2pE3j5/k7Nzcsq8Nr7iD0zlt0hs14YcQQ697KY3Na6iCUMCzjpZ6xBTae80X2O8jGX6yl40Q9tWDcnajSEfDluge111dCWyYh6JCILsFHUP+DuQqagRQpQQwcIwD/C1amTj+ddioqjesCjhsYvuWAhhSBnGtSPqQSULDEwIK+7sXPMpiLBrl0QHWEyy2vq+sBJK5tRe9VrH5fTfXnbn7oSD7rXlGgnhvQqAM1kygtX4EuAmsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3428.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199018)(6486002)(186003)(26005)(966005)(107886003)(6512007)(66556008)(4326008)(8676002)(66476007)(5660300002)(6666004)(7416002)(83380400001)(8936002)(2616005)(66946007)(6506007)(1076003)(36756003)(316002)(478600001)(110136005)(41300700001)(54906003)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yI8pDrxtBhA56sGlwM+jGZwHIYoXo5d7LHiE2CYbZ1KvcY3Y2ewpLg76iQim?=
 =?us-ascii?Q?b+Rm2hpLuDrnT7JzoUTnEvc69iGHXo7T55pfHYQ9Vo737XigdNnlsQHvbyBk?=
 =?us-ascii?Q?NjCqMCjDcXlCJ3s374C42f90pxjxmuCIiPIR3VaaJkLUkYVhFCN/AP5Z/aMc?=
 =?us-ascii?Q?W/48KEVX902g3ou9dLjTo2oONMIuBgcHrAbxl+Bhkjg9gUeSv20z/+3V+ldj?=
 =?us-ascii?Q?jyxWrTLLDEaCT2oXp/g+XLGDxax1wxLhvMzaqvM5XefeY3a3JsqgrQ11Qo70?=
 =?us-ascii?Q?XHavqFNGa73Gt83iXgsXrgA7QqUnWDdIIYLOhOyQBOlScINKlNSTVmh4SXEs?=
 =?us-ascii?Q?/IU/UqH+Tn4zAOeb0qwb5F6Exlx6uxpHGLB4k74adduujLjwPFj/kFpv8i8G?=
 =?us-ascii?Q?WkKfp+55VKvVIu0/C/ReyInupqfgUxCwq213uXSFdnaWbMWDMbJkRmSyHjFQ?=
 =?us-ascii?Q?aUfwTZKFrTy2Xn/jro2X6CtE60aCrkBlxrx67Meywl9ZgJiDeSZ2xqZHPC1q?=
 =?us-ascii?Q?o0ABJ/BfDZ9pd20fVFPIjEKBEqr4RlTsw1gcs5/LjHdjWNG6oZhwbIb/Pjfa?=
 =?us-ascii?Q?2S/iENu4EFuPs45ubzLHVz9d28wLx+D6ztWIMS1+0cpnXxh9/zxu5A5jToPw?=
 =?us-ascii?Q?IAgm5d7qb5l8y+vUMsbApfhoyXByNtu3YQx0Hjs2P9+oNuLy80rOyViGgdua?=
 =?us-ascii?Q?WmRoBGUKgCDL9o1LEok9zOtBS4vcLx/JqTYkvHV4UOB8zTxIhaTLtPc+F2u7?=
 =?us-ascii?Q?SS26ZeQzdezbYHK5jhCi56nCI4YAmYiVsSTBgiS4Rgwo9ovlrjTBCruOfSxp?=
 =?us-ascii?Q?kTNmmsFbwFy6V7xBNP8ejjJN2A6DAULFKXOeTp9KgHmEzBMND7fub7oCeCYZ?=
 =?us-ascii?Q?0y77LsZIpjKVcXV0vkuPHWai6kRQvZckO92154LMm7wZoOsCvbTDspzI7i9/?=
 =?us-ascii?Q?DoE2cpXIYoActsmpBnz1Mp7+SF6Qphv4/21w/+E1XxMXOWXcKKmBlfTyFXsI?=
 =?us-ascii?Q?F2fBoc0hxsk0EFoJrechHZ/FuRDtZ4hlJ4deP2IsbJDfGj/JYJGHrOfs94Mk?=
 =?us-ascii?Q?i97vIg8Egp4vy6H8PfzMjHqXkw/CdSr70ryzZScls8ZJ2nKAvNIOl23vfP7w?=
 =?us-ascii?Q?olBLnjtMOBtwsQudQJmdg50sgKiWOENmAXFgoXyn7BliPQpjNg5l/umQrpe4?=
 =?us-ascii?Q?RwNNQ/NIRzN32SurCFAEmi2oFk8JBUwkoXn/LCyQ9u8Bdx6vYg2thUMuPIyJ?=
 =?us-ascii?Q?TAxc0GGYFn01GydKyTQjqLOGywjnoGDdc54+6kyyoo4fd2T8N69YunDpjpzw?=
 =?us-ascii?Q?xKI6tLSiE/hOEX0652vTPn7kFfOCOy9IDyXF3zKLoGykkwhaxVdW5aohrFws?=
 =?us-ascii?Q?8dRrYb8i3+VuavXAafsJBPwnzbWPNLCbEHOpNL0MY/Y90TjxdOZEat/RdeFL?=
 =?us-ascii?Q?mXn6cssX2qbnNFFDgMbzXBqEBoWHE+mH+IGKjC9VNH/U3IO5b74c0F0g6MOW?=
 =?us-ascii?Q?/7oDYR6g0XWcEbhhQ3MMSgy50XTi4pyqeflAsLcS+ZG+5xXE1Cy1kR3If9x3?=
 =?us-ascii?Q?p9tsMqeKW2c0AFf+9wA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b383b776-5e88-41b4-a3a1-08db12eadc1d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3428.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 02:33:32.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MT5uJZ7rF8EinXqXd9QR5yU9Pr7dCVyS/MzJmS0sjnq1GV7QJyYyvlym3p/GhQsS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762
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
nxp-auto-linux repo[1] and it will be required by upstream kernel for
supporting a variety of devices on S32 SoCs which need to config PINMUXs,
such as PHYs and MAC controllers.

Thanks,
Chester

Changes in v5:
- dt-bindings: No change
- driver:
  - Refactor register r/w access based on REGMAP_MMIO and regmap APIs.
  - Tag PM functions with '__maybe_unused'.
  - Add mask check while parsing pin ID from a pinmux value.
  - Simplify s32_pinconf_mscr_* functions.

Changes in v4:
- Link: https://lore.kernel.org/linux-arm-kernel/20230118094728.3814-2-clin@suse.com/T/
- dt-bindings:
  - Change the representation of available slew-rate DT values from
    register values to real frequencies.
- driver:
  - Add a mapping table for converting the slew rates to register
    settings.
  - Move driver files into an independent folder drivers/pinctrl/nxp
- Add a MAINTAINER patch.

Changes in v3:
- Link: https://lore.kernel.org/lkml/20221221073232.21888-1-clin@suse.com/T/
- dt-bindings:
  - Remove the minItems from reg because there's no optional item for
    s32g2.
  - List supported properties of pinmux-node and pincfg-node and add more
    descriptions.
  - Adjust the location of "required:".
  - Fix descriptions and wordings.
  - Rename the yaml file to nxp,s32g2-siul2-pinctrl.yaml.
- Rename pinctrl-s32g.c to pinctrl-s32g2.c
- Adjust Kconfig options [menu-invisible] and names [S32G -> S32G2].
- Add .suppress_bind_attrs
- Drop the .remove callback and replace the module_platform_driver() call
  with builtin_platform_driver()

Changes in v2:
- Link: https://lore.kernel.org/lkml/20221128054820.1771-1-clin@suse.com/T/
- Move the "nxp,pins" ID range information from DT to the driver.
- dt-bindings:
  - Fix schema issues.
  - Add descriptions for reg entries.
  - Revise the example.
- Refine the compatible name from "nxp,s32g-..." to "nxp,s32g2-...".
- Fix the copyright format suggested by NXP.

[1] https://github.com/nxp-auto-linux/linux/tree/bsp35.0-5.15.73-rt

Chester Lin (3):
  dt-bindings: pinctrl: add schema for NXP S32 SoCs
  pinctrl: add NXP S32 SoC family support
  MAINTAINERS: Add NXP S32 pinctrl maintainer and reviewer

 .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 123 +++
 MAINTAINERS                                   |   8 +
 drivers/pinctrl/Kconfig                       |   1 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/nxp/Kconfig                   |  15 +
 drivers/pinctrl/nxp/Makefile                  |   4 +
 drivers/pinctrl/nxp/pinctrl-s32.h             |  75 ++
 drivers/pinctrl/nxp/pinctrl-s32cc.c           | 945 ++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-s32g2.c           | 773 ++++++++++++++
 9 files changed, 1945 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
 create mode 100644 drivers/pinctrl/nxp/Kconfig
 create mode 100644 drivers/pinctrl/nxp/Makefile
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32.h
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32cc.c
 create mode 100644 drivers/pinctrl/nxp/pinctrl-s32g2.c

-- 
2.37.3

