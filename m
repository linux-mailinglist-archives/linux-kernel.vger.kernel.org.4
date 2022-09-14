Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13E25B899F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiINN7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiINN7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:59:38 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00074.outbound.protection.outlook.com [40.107.0.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7978F114B;
        Wed, 14 Sep 2022 06:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKGdNAZhXFYV31X2krf433DZ81in/1qQTOZ63dgRFEwQpugAbAJnrJmvj4aPFnD2yl1yddbDe1Ut32rzMrH44/qrdFuXpvDDRB0A1esgHbQlOFRGyqxL9cxyinhLN4P7WisGfUJ3UW1SHp78SA51tyCr0IYD4KyoynXYdawD6/zFR1mzUKqitX6bwX5Bq/2yab3x2gLUA7mVJjgT6jQtucHv9nyokpb5RjBN2JQqYRQjcAAm1cDKWVbyO/l1d2CjcLJzJLXjlEcIWYdnZ9idGjBvwzNBjmIj25pgeZdWC/mvq26RigfVdkoxFYsymr4+k05bw9QHLSeUrj521NHNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvEczb4CI80QFspzyxO3gVaqpJxdO2UbayqL9zB6oDE=;
 b=fxdSKvraSi3GwG5KGMGbfd+NtUnKfRtCq+9e0AIn82ph6kysYJzrjDGMWMcEFz1SzbK9MANF96EN6+Rw9aJd0QUtY6rQQ5Pv+qCC4ObY9W2M/72W70iBI+gykz7ucFYnKi6aoOsWG/18tgV8gbe56ImbJD1JOV24yxJ9e695cZZ8pocZQquOCKMH8swChn7F4Cis9pnzKa5I5NIyUqiMTQgEfUXsKhJxQlyym4DlH/45Mp6PeGxn6iG0QraxHbnnQIMEq8WhJu6vtpqPbpRK7bCy9ZNQaj6JxVHI8FSOsYQv/paelGImpRsCOSXr41yoy0dbFuKh6JecAJWiZh+xnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvEczb4CI80QFspzyxO3gVaqpJxdO2UbayqL9zB6oDE=;
 b=iOFlpEXpTuSd2oCBFU8oYaUByVFxhPGzCjk1ABDHCvdhS0J0sYgia0sTlLhDkikrbCg6FKDml0usotW3Bjjy9fd2d7ODXr8oqWN5jty4wTnjNdwvK1SG8f0ZSU8r63HmHeIeY4V2wc/IhXjnrnU2MMmJWim0s3aq8oeUBwBepgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:59:28 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::a552:97fd:60f4:edd6%7]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 13:59:28 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Zhou Peng <eagle.zhou@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH v8 0/5] add imx8dxl evk support
Date:   Wed, 14 Sep 2022 08:58:43 -0500
Message-Id: <20220914135848.118616-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0079.namprd05.prod.outlook.com
 (2603:10b6:a03:332::24) To AS8PR04MB9176.eurprd04.prod.outlook.com
 (2603:10a6:20b:44b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9176:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d128dc3-b0d0-433c-763f-08da96595632
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DqOCHmyr7gIt5TYyr4kO/SXUcMejqrdQzAnG2hBZmVXaSEWRTmmIywf/JZfRoOSBOhLKIo+Hyzul7MpZg7c+UMLhwWU8egNhJ45FXJds9GNwrQ4E7kWaus/oTiDFL5bRvD4FilhyRT8M2IFSkYu5e2v5CxGF9CmekWhtpVKcRTlmuVyinVUlRtcn7oJw3IeaO+5hAhj8bDCOvPmVITWTIIEx9Vv5t3dc2LxgQim/Ktivep0ShX72o+voeepexUxbyTUaKdUJ+0bSWFDFFplL8Z8hbIOyNV0ErimaIXWi1cHAf4fxNyupCPxZwoBGvpnhzMiGhu2C2+2/Z/YhIyBbWpVk0zSEyI7zhoPdtT8jm3rlQqM9WRffVOBYXOuz68FOHBGxygw1Av0LtA5xri1WCSgR5BHiBzbUhk2BMRwRBLTl5h6T26UWBh31punnkj7j3ygFE/yIq4gxL0fvY5On2MHL87yAdE6rCD6nMSqICzcQehMMw55qyAib82nkJQYdUEbZ2Oxq5rzYx2T7aEbDYNsvghjPQj7+71GPWcBSmOP2QAfdtsgqZswqJIdPnCPF4VI7cJleaEFaKscoAA8UjdHYEh3eiP0qLLyJMZAQZ/v7rHC0WgsRzq2hqd1uGeOHpFaJheimLVsCT1az+azILVfeilcyU+HTHtrMoTiPIZpBwFS/OY9uOgmEJdqpwk1Ko+HFqiufazWbalqtfiCr1W3RwdCwVe7SIltsbX+vTNHJXh27H5Ypual54JYA0kKmEsPLP9X6HWUy48j2cR8MMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199015)(38350700002)(4326008)(5660300002)(7416002)(66946007)(6666004)(55236004)(1076003)(66556008)(38100700002)(8936002)(8676002)(6486002)(186003)(44832011)(41300700001)(66476007)(86362001)(26005)(316002)(110136005)(2906002)(478600001)(54906003)(2616005)(36756003)(52116002)(6506007)(83380400001)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWRBwRwI8K06bc/YaBExS/3QlYJIJFTeBNcLQx/X1XXnTj8MRuVEjvDirf6B?=
 =?us-ascii?Q?IGmE8WCzmCYbkFuLkiEKM1c2GEHc18g/tmtE26YHFsXOUmhJH+QA+g/MQACd?=
 =?us-ascii?Q?VJu83O9LI74YDdPHrWBFMHshRz8Y6yuSXDHrFzBvbObJxnRK1taLbFptgk2p?=
 =?us-ascii?Q?haepKfpvfJNgLzwBRWU2P1sEIb8MYta/eLcHZh7tY8zOSuxjnqI3cIJcaAVJ?=
 =?us-ascii?Q?rVMRCKVl17vtXf3JZ4WgWmSzH3ucZ8HE/oPOAXej1Mhc1DHu5+Fxikus7QR6?=
 =?us-ascii?Q?IaJJa3e71AnL2uIaynyqtybl7uG5HQ6rCW/CulnOp3bJHtiEg25m9CAckZyN?=
 =?us-ascii?Q?7ciWHBTkTKLjVwP4kmy5T5eS6Pngl/sHmPKeuJDTbkrYGaZhsov89BQ+NWJu?=
 =?us-ascii?Q?VE0P/9wE+VgJZ3wtZdkPiugrkK7amR/JQ9Z+mNxmI+OzXz7jlvRM3rJm6Pg1?=
 =?us-ascii?Q?YUIklpddOO3BTzLo7cHlkKwV69/14890EwQCdcTAVUf2XL7yDvfRLSoiaHzH?=
 =?us-ascii?Q?Ga3KGX8NM8QKXuF03ZbdWvhr+GweHSKxArelY2g/+xhXkYISYRza+8RNgCLc?=
 =?us-ascii?Q?/cJtIO+oygiHfjOAY9xavzX/Nu1Md0nQBWEZpFfmX8e5cMnQSLFJlL3OYCBi?=
 =?us-ascii?Q?yuRGurNw+wm+atS+cZYptlgU3AJrQ8xNwd7JK9eybG04/7r/jOwWaV4bJq5m?=
 =?us-ascii?Q?W4PAesQDIJwGodGa4JtTeVS1nSue6cnGUB44sIe6fP4NW+4hurK0BaCbKc3O?=
 =?us-ascii?Q?pIrA9ggMg61QWH+4ByfdErd69nZhO2wTZfPn8nWa049auyl3JR67avjKJVXa?=
 =?us-ascii?Q?zFSPZYKfZS6/RhEYkni64RmigRPt6D7JoysogsIgM9/SrtnasSJw3rICE97E?=
 =?us-ascii?Q?Q+2OYMbfJqXJILyxOvxm/HbWhvHX5vhmyhgjAyFQHZWDLpOK5+jcngxu1Ebj?=
 =?us-ascii?Q?MYnDc1XEHgKPLrNHzpeob0/v7MoXlm7MuHkoycJskDt8JVhYkUgl9/vh8t5Y?=
 =?us-ascii?Q?gVtjy4VWhKvkwibiDVQl6re1chTCceeIVlJAGczzmqVVbXZy01jmUhdxUtZ+?=
 =?us-ascii?Q?z2rH+OWqRbsbGnckBg+u6EvZqT/q3I7YbiW2vUUOysKXlXM89YhrJDse52Ky?=
 =?us-ascii?Q?E2M3DNHgQTI2MMUlz7VpZjBHxzd2P6zpGIeN5ynLXjAhCA9ptNCvwsb7XmC2?=
 =?us-ascii?Q?ZouPCTxXj1vo8ZD/aINdMh0sa9OWEY+gka06yNZkzl3x1nfbks1E4E+BQGet?=
 =?us-ascii?Q?6pOmfOfGJFjhr29aWinop+yIwnC6jk0SJppKab+9qKcigVRJxqsLqyL+xlcy?=
 =?us-ascii?Q?fxv3puBR+uQAmbU8H0VRuOPaW7yb4YbQ1lxPSNLebM1OaQF3gqcTn60h6uQc?=
 =?us-ascii?Q?JqGGKHfJpA4zmUNl1TMlDvpNcbwd3MEPa7nDPsWieo2pedbj2NE9MKfL0Pub?=
 =?us-ascii?Q?7XhccLw/d8cY/kgJXpNg7Ys5yq4ZejO7rQByNaOp2Dw4jiY9NFNanOJFl1YH?=
 =?us-ascii?Q?SuRFjkBnKifIcOh8zvoRocPRLbscWb52a52fOmJWEiw0FauTw11P/M8oaB7F?=
 =?us-ascii?Q?j1ueBMbOCjY8iLQsbPJWoPcDDE8Gq1jGkDZm33nt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d128dc3-b0d0-433c-763f-08da96595632
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 13:59:28.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hi3HjHknCSyjGkN98hXh5e2RLl4hzQB7Xiqo+rJIecYwkErnGfjfI0JjKodsDj8HPmPsfOUK0aJ8IiUfMCvCAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8DXL is a device targeting the automotive and industrial market
segments. The chip is designed to achieve both high performance and
low power consumption. It has a dual (2x) Cortex-A35 processor.

The series of patches is to add the imx8dxl soc and its evk board
support.

changes in V8:
  - change the flag of gpio phandle in reg_fec1_sel node to
    GPIO_ACTIVE_LOW to match the hardware behavior.

changes in V7:
  - move the fec1 reset gpio into its phy node

changes in V6:
  - The V6 changes mainly respond to the comments from Shawn
  - Separate the V5 patch into SoC and Board commits
  - Remove the unnecessary properties of "max-frequency"
    in usdhc2 node
  - Remove the unnecessary properties of "clk_csr" in eqos node
  - Fix several coding style problems

changes in V5:
  - change the "scu" node name to "system-controller"
  - fix the typo in the comments for imx8dxl evk board

changes in V4:
  - move i2c/mmc/serial aliases from soc to board
  - correct the node names to follow the generic names recommendation
  - remove some unused nodes in the evk board dts

changes in V3:
  - re-order the commit sequence according to Krzysztof's feedback
  - correct the syntax and styple problems pointed by Krzysztof
    (Thank you for the detailed review, Krzysztof!)
  - remove the unused nodes in imx8dxl-evk.dts
  - dt_binding_check passed

Changes in V2:
  - removed the edma2 device node because the edma v3 driver hasn't been
    upstreamed yet.
  - removed the imx8dxl_cm4 alias to fix the compile error.
  - removed the extra blank lines at EOF.
  - dt_binding_check passed.

Shenwei Wang (5):
  dt-bindings: firmware: add missing resource IDs for imx8dxl
  dt-bindings: arm: imx: update fsl.yaml for imx8dxl
  arm64: dts: imx8: add a node label to ddr-pmu
  arm64: dts: freescale: add i.MX8DXL SoC support
  arm64: dts: freescale: add support for i.MX8DXL EVK board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8-ss-ddr.dtsi |   2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  52 +++
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 142 ++++++
 .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    |   9 +
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |  74 +++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    | 238 ++++++++++
 include/dt-bindings/firmware/imx/rsrc.h       |   7 +
 10 files changed, 956 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi

--
2.25.1

