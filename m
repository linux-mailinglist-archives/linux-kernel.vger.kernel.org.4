Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD79B60E26D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiJZNqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiJZNqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:46:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2118.outbound.protection.outlook.com [40.107.22.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9047B5BF;
        Wed, 26 Oct 2022 06:46:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cf6jmaKXXi1xLGaY27atJy9f+0zMezWC7qcPG8KFSDoRqJh4IYPoFgjIPW2aNxS6Md/JOLwck9Jdf2h2mD/8Ob9MQWZcCv1/OAKGs28tOglDOQBA5lQGdzPsihyFs0X4hehY/xXzJmgwrMDq8liuBbVrCISp0EyvWoevfCXzXn33bG/ETG7aiMx4/p1RYuLTps8E5hqtmrjfQ/dtfYTJP9DVlfl4Kdkg7Chbk7DvHcEk+rljqXKEQH5WI6RZKz0WXApOSr6DceFnpviL4CbLqFMIKNl74TfyCXjh6Lesro9h9CCYJ6Y2r2g+JyfNb8fyXdiNBeywqOvh5WRxWuNxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cehBbaLsgKTVT3bH7JgyY3iuHVHuBK24delBQuBwn2o=;
 b=cAVsyQ/RtfGoKvf5fOsLK0T/h2sgGqIEC/rSqUUKfA8hFR4bxNsUyON/M7swyNWUlwk8YZNhLE5WUTb5NRH294Rg9qLptQmwmKQUm2hRMK+h7/Cjlsi8tS0b7x+QMUeB1L4MIHIwyIr4iZJ5TA0nSl14+PlKK5UFOMkKg8pVJNtta5WC4hv2mI8op6buoSEzryiwZDwFSQmrKc758KprqFpifK6GdyRdITMCGqstLNmRbA+ofWyTfZ7x3DOTpnBHldmaxdRDVFcyzRoo6qwbWi/IOzQFusOLenmrwI+ngVWDEPZhax9E4ERb5b0kcmaXXNzkIq1ZN0FX53K1NJIW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cehBbaLsgKTVT3bH7JgyY3iuHVHuBK24delBQuBwn2o=;
 b=KLfpu49tN6EFYh+Q0UoN69V92upGw60NWjjluw1QpQqlvAMdHnHQfVjpCXN4qntodghS65Ln2Eb8907nepnz3V6PsjKxUJr+MB0V1E1kab+J0QoaQxI/glBFc28KHtIAbp2iNsY/yhyG+DhhqCWVbqsTGcc856/sB5zUuFRaIbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VE1P190MB0941.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 13:45:59 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 13:45:59 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Wed, 26 Oct 2022 16:45:41 +0300
Message-Id: <20221026134545.7146-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VE1P190MB0941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7211871d-b0e8-418c-f14e-08dab7586a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPk1qQhDG9HZe7lILR4OM5zOZVY7a+XOvqjAwzmKVTJFFGX7yoynu/zoUZNy58bzNAOlrhDbesR31vk1bQt4MT6Av/YekGOKzc7ha+Xh3r3OofJaj2Myb2yUl0x1pmMKuHv3W9NxdQrobl53ukX59GI6o9crHmCN8ScNpaj6NTDSzBg3pl7ERQCeZ2gXqzqXqtHDaxeH2oDuOVdPLHR/bPG0JB8N4pNSP2ZdnOmkIqPUnaG0X7jMTe0kOqnxm58Av/79dSN2H/wYO1xrMruB+GGZH98mXMCySsLgrfC87C6M+GYel9yZSU1YRdchyT4lkpbtQQ8RZkNODK6tYJIotZYV3CGo9JB1U82rAAzsTbo+4DJwtVwx5q8etHodk0BWjk/iGKkeNgE3SSY+YAw9DefJOgyfRiZWHE4IxK5RzdO2gk04/yOexEjjWLu6i8Js5Mve4LGXrkcgB9NK9bkRXkOFvNGZwcqf/eowjyUTxXJY6ex875G2vy8fq1X83O2bNLhB7G+Y5W4Lzo15QIaMnhHDg5VF0RAz5mp2Y63wd4fuznl/rzVInL8P+zrTTeg5lnSAZzv3J3jkADwkczgFUv9kWxzXk90oAL89oqvALuTIQEymQbngdlv8HGmoNZq/umr6nHwKX6LT9qJRo4XweA7vM+ltv7qNFlS0sSG1s2VMRV2sJcTcPmmQxPL+bFd4t2WoEXMAJg65TfFAsy0thoCltES5/hKlV52l45V1n2MDwcr0Ulm0Soo9GKyg26q0+28qFIZ6idw1Z+CEtZzFWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39830400003)(346002)(376002)(34036004)(396003)(366004)(451199015)(8936002)(66946007)(4326008)(66556008)(8676002)(1076003)(41320700001)(66476007)(921005)(6666004)(38350700002)(110136005)(44832011)(508600001)(86362001)(38100700002)(6486002)(36756003)(41300700001)(52116002)(2616005)(5660300002)(7416002)(26005)(2906002)(6506007)(186003)(6512007)(316002)(54906003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xMYPKkgxpXyUYg/AwrtzC5GdamtfI1/2UPmQ6Fgv8exwiwqkbMUpiL+QyuZ?=
 =?us-ascii?Q?6mFZpAQeG2byp7bnPSecPV8bGDiysDcivhcJKWbjSCEzauVeYu0A4mlpLde0?=
 =?us-ascii?Q?kDCwjsAhkOx4LJNIrnkkfwabOVmUrRGqpjSNKh5uJognCP7Y4BDO58NWpm9g?=
 =?us-ascii?Q?AJ3mnidla0KTD2i1t5Zlhynhh0kstaCbnFMXWMEiow2aYzaB1+q1jNCzsLI8?=
 =?us-ascii?Q?NWWoPRzHOcNGRmXSUnt362+RdwCglxioTxQms1XY+MXWKFoecC9Rc1Gmy3yH?=
 =?us-ascii?Q?bMRNBK/eZdBfzFxUB/agTqNL4tdQi+7ViDKZdmU1IlCD2y1kW5e+9T0/7a8a?=
 =?us-ascii?Q?EXF5YuAH4zGHio7Xf2bUJwhIpPuSTyrxupLKvxueKfY7DxNHfkupgyo3IdOl?=
 =?us-ascii?Q?kIeUiYG5O/yjtMmD9rTd8gJqcemfRFIPsAwFnSI+SjlSJW2llLhnWVtfS72G?=
 =?us-ascii?Q?ksJ3YDNOO8MWHUMhos42g97AlKX3bYepuhUZkli7cUV4S/u3AILlHxqLfYqP?=
 =?us-ascii?Q?9j7LX/U53bIRTaWN6xinQCUnpIpi3pg3LXili+gP7UaakDkP3BmATDzc00mJ?=
 =?us-ascii?Q?xVPbBJDKaUr0cr18dju25EtD54ZopGgkKW+1fdJX08QIQ3dHc0vRtK/3tFmj?=
 =?us-ascii?Q?soCvprMJMVFttyArk+UmL4PLfTR3LbOOO0j/mVWI/gJDWXPYkkeqvnybwGNz?=
 =?us-ascii?Q?3iEfVTAcpCaxjbS19FxfKTSkHfk+Oent0EY3qk5kLR1RysEDgPBJnDfTJqbM?=
 =?us-ascii?Q?Qbtx1qTRgD+v5Q7uaFHnvNE384BTkZT8dAQhI2ohrY4Xy+jvk2UNkqvZ68Lp?=
 =?us-ascii?Q?Lx6iykMeXrbVACGXtDUNl0U4gQbOuIrbnvFiZ+7Y/icaQL78/1tQJP7zu03P?=
 =?us-ascii?Q?U9U5e1eDmG4bE3pD47TtgYiys4H1JWxoSg9+FemBeUoe0xHLoehPdEPX7DfT?=
 =?us-ascii?Q?JUaEke9LTQ4mU1cnOvlEu57lad+USFetUJuzd/Ejl7MpctLB6OXzLq3Do4d6?=
 =?us-ascii?Q?uK7nkFqtvnEZkZYiZUcnvmGCCIqqffPTd8dUpuGPVAXIQDV4Cm+NBVp4wys4?=
 =?us-ascii?Q?m3OaaRIH9q8lRuCKEDIKqWAQId1ceT3oLwyF49xfLNzPyx9wxfxmKQkUIhso?=
 =?us-ascii?Q?i9T3XzLRyknJ8jB0Vd/B9eKuDKm20ndFYDAULFqbrhCAGVzD3tpfbm59T1DE?=
 =?us-ascii?Q?V8rQnvAn3kxW+ip1L2AgjUJg96kXBu6cGlI82VrmsPQN31ESd+12RsbrE3uV?=
 =?us-ascii?Q?+QALYNGOVijaxp2oHcD35u9ZNXkvCNiI+NjH1nortwlcQHZo4L2Bu3GIi/Ln?=
 =?us-ascii?Q?5BDhAgy2H9ZEv2vGr16ug4KVqHo8qzxhfB77Vjl1ujrMOmLJ5A2hjVJlEpCO?=
 =?us-ascii?Q?k5NrDUfmIL8GwLA2SCU7v5aF8E94ofiSika9i0LHmBThRQv7f4S2hApvk6LY?=
 =?us-ascii?Q?ysHamb+D7DPbOmK0m+jMN9ECXvRfEVW33PuAatx2YPyfmi20K59QawfO34bW?=
 =?us-ascii?Q?wHjLRReDCZCCn08BuNEYQerKlTm5j+LEbZtnaORl3WeEV4nQsvtasMCRdZni?=
 =?us-ascii?Q?iw+8WTJe6Ip0m/pwmshtnehLGcZfqEtGENJbu48LQ0Ram3A+NIINlKBDaHSv?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7211871d-b0e8-418c-f14e-08dab7586a1f
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:45:59.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGlqrNkTBTxEB0FBIM170a4K/mEa8ZlUVk+bBGVfJVy668IeBTtzM0U8u5ply/9/IEatvp6KL7vKg386IIbGLsEcxQBZha0EM/yn3pGmrp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0941
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML scheme for the Marvell's NAND controller
to validate it's DT bindings. Old txt file is deleted,
not included the compatibles and properties which were marked as
deprecated.

Also fix node name in cp11x DTSI acording to nand-controller.yaml

v5:
   1) Get back "label" and "partitions" properties but without
      ref to the "partition.yaml" which was wrongly used.

   2) Add "additionalProperties: false" for nand@ because all possible
      properties are described.

v4:
   1) Remove "label" and "partitions" properties

   2) Use 2 clocks for A7K/8K platform which is a requirement

v3:
  1) Remove txt version from the MAINTAINERS list

  2) Use enum for some of compatible strings

  3) Drop:
        #address-cells
        #size-cells:

     as they are inherited from the nand-controller.yaml

  4) Add restriction to use 2 clocks for A8K SoC

  5) Dropped description for clock-names and extend it with 
     minItems: 1

  6) Drop description for "dmas"

  7) Use "unevalautedProperties: false"

  8) Drop quites from yaml refs.

  9) Use 4-space indentation for the example section

v2:
  1) Fixed warning by yamllint with incorrect indentation for compatible list

Vadym Kochan (2):
  dt-bindings: mtd: marvell-nand: Convert to YAML DT scheme
  arm64: dts: marvell: cp11x: Fix nand_controller node name according to
    YAML

 .../bindings/mtd/marvell,nand-controller.yaml | 195 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 -----------
 MAINTAINERS                                   |   1 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 4 files changed, 196 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

-- 
2.17.1

