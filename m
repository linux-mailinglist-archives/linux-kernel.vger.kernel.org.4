Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CAA60C9E0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiJYKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiJYKVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:21:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2094.outbound.protection.outlook.com [40.107.249.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADC18B753;
        Tue, 25 Oct 2022 03:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuVnKH3I6qRj5g5eAoLwADH+/fheWowZWVhn8QNWBmp4gU6b7ujQ9ICauOEbfnhzyMpYkmyph0DF8OBXM8rAVRfJa73YyTWKphurRafrSOYNSzfn4owZYjjeNDU4L/BHtRjWMJIr5ADyIbx90oeEOIasoQQCs4DC5lWVDSIBg+7dT6nApJI2Gr1BYkzsEfo3Nrancv95griISwO5Dlo1BS5bYRg3JSlvQiLc1v/OPbW+eVp+cmyvKWUDUapxZ97j6oSRUyx/+NxpeNSZ2aPndwyJ1+Zk1MATodmmnnSfgJjisOSzhxnLh1OLwOXXOcKEB2XF3wt16Ze+dmg9k8EQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70vnxq1xQuAnjc6aYpSdHRgehWWGttkxloyG0WgUWXs=;
 b=iFnXM++ZKUgPkuTXBcZpBxftcMM+gU0YRjfnaO8rabavpOIykef3sWXUV5GTJ4jpimd0WxXj82ljImXDsxA/ihlzXYVpQ2S6GdcMmQ8/iH2TG95tv0sr3d534BnHOud122Td4Vnw7AudfyRkoHQVPN7ij5aYfNWhFBVVD+N4v92VwLVPtidD4wOcI0odzTq0xi0PBqy/D827qbz9Mtn1qFQceJDQgkRcYTTIE9z9a/GhuO5sgWRB8Vwz7Dux/z3iWASdAHaefdL/xTYAS9yD+29MRuws1v66+GpShxuj72xD9nnHZW5JUgppHD9/j8+h74p/vzBUylXao+5hVfJtdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70vnxq1xQuAnjc6aYpSdHRgehWWGttkxloyG0WgUWXs=;
 b=nyGdJOnzfC1kV8eD2NwQeIZ8W/xBV3Fnw7sRyW+u79M0CiMrcuZXOWOIccEKQMz5M3nhykm00L6+4GzDf7dimtqZymMOPdVZfXjjPKCz1Ju3TUOOPq1It1LIEr4GGNt391Ie0GAoCWa5VrWS7kh/yClxNa36yCSnehksDWp3ciE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by VI1P190MB0733.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 10:18:04 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 10:18:04 +0000
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
Subject: [PATCH v4 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Tue, 25 Oct 2022 13:17:09 +0300
Message-Id: <20221025101713.11893-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|VI1P190MB0733:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4fffbe-f267-4a6a-14b6-08dab6723381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6O8Xlcpgf29uzCr8u3Va50Gd87hQWPS1kNa4O+KLxGBkmZWRBWVw4Y2xd6PmqNFRN7NHlCRELwy1b8srzgctFwmYgw2r8pzIxT8mZrBAYre27ZC7nKmMQoiOyMvsdTBJoLw6OwFcf8k4C6RmiQ/iOM1x20nz+2gLR36Dk76Ch2eGFXr6xARunm9AOgMxfbs06VOGDDR4u+ZehcDdg3wr4/ZFFVsonKN73Tze1l3FEpZD+9uA1zmGTX5sCKlVIs1xfKcnF2/d9G/ZAzlREK3BrVMZWJstbIQmFnjY5oO0vsRuF9eF0Q2Alenz/3swex2miMZ2njIUMnTMHq/3YpHMnxpkC5qwjnnruzSStCGyvE4viA75krBIm/hrFeB/QLlTpxYKYXYE3eb3tPdD/Se8RZfVZlxkmeI04eG04G7bBubWYLv9Ttxl5kZBKUAfnm4ULQ12ujQAz3MLhczo3YMJpsQAjTFTGN1+0P1rA95gLt9nqx+Wdi4ZrZ8l9SlufiuPS20qVuvv6jwQHQ18Gp40Bni7Zs0VQPyG9i7Wr0Zgtdn+O98WyHr/Y/FGq/V03GRST28JU+aKXCyX6KqdcHR7DBZyXwPAZ65apm8VeaMvyywSng2UmGokVwqsElEFvFgrGSofpaUdFjKeeqSrBBP/rcXvyi/r0LefYWAvelKg89q0udysmCBQoYUyFYaBKqxy2EPFaOAips6uw6Ba8JWx7fRjeaioXq2eqGQlpA50tRf23NMgl9pYD/mhdagmvFOK0bwILlqLLmpi+Z5y/4ImKnrnJrDorlLmGfYPU67xpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(34036004)(396003)(39830400003)(346002)(136003)(451199015)(86362001)(36756003)(38100700002)(38350700002)(921005)(2906002)(5660300002)(7416002)(83380400001)(44832011)(8936002)(41320700001)(52116002)(6506007)(186003)(2616005)(1076003)(26005)(6512007)(66946007)(110136005)(54906003)(8676002)(508600001)(316002)(66556008)(66476007)(6486002)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7CD75MRpryd2mr+D7shX9E4+j3yGLekAheoXUMRRCQNZwzL9oBLrX9I3OoMi?=
 =?us-ascii?Q?PxYY/+lqzpCnGo+BqSvsL4eUM0kM8yzCewDiB5JeFwUR1QJGz5OxTvlb5hgO?=
 =?us-ascii?Q?HLgcZbaOaKGrVlvTs8ChRWNJfE1vSn9OzRw+L9WqY0dvnvRUaTj+WyIq+g3K?=
 =?us-ascii?Q?1A+qBTXl0FAd79i84t55Pc2jPTXPVPB1MMdTeaN9zvTDZzNJcxx6jAtVsYqK?=
 =?us-ascii?Q?FzaYGfWb1poGWQg+xcl8cZG1NA57/dfOGdLl4vYs56qW0tFlc+2nOQh/GGz3?=
 =?us-ascii?Q?nPJZBhBNY6OwcKQ2k9eDRdX9GOa/dt5Fqvpy72bM61MYe1ajkkk8jNAO7CmG?=
 =?us-ascii?Q?nMTBoxEJLC8nIipjP6+u253w5Xy4X6RNynk+uOWXIjL7LfPLAXNQi0cTCSga?=
 =?us-ascii?Q?6hnfL0MJgDQn9B4fr46NlYjlTRBQVc+RBzNz2jvT+HzmOQvHQYUwocy4LCnE?=
 =?us-ascii?Q?ccx56TQhniuk0IJFhYoYeAYPqiu2lqQE87yciafbOCeBuc65m7yx4OUtVQ1R?=
 =?us-ascii?Q?fBv/C+8TMLuWrfxbl26qPEbPB+bb37PdSA77kQt4ymfdXAy7/bqDtksV1GP9?=
 =?us-ascii?Q?JdA4cEI0UG5jv2OIVhMUlijaq6MPaDOJ28xxaZhLugDdCWChiz9JGBRl5tTq?=
 =?us-ascii?Q?iIfv0PJ/Xy/g/2FivXArAvy+7nDnasPj5CLDVI2q5ti525lqLY31oAZiEZvJ?=
 =?us-ascii?Q?aTG76UxhPLW1s9Zr8exobPRdhuo/vf7PLaKssz7hl+WPuFH5BOG7IkZEZA4g?=
 =?us-ascii?Q?2oc/8VJ6inZ3zjpvI3n3rX9ByRPRkft5lSVpbDfD7irRRBUie6D9t9fdA90w?=
 =?us-ascii?Q?RZJWiIQZNcPFVhItwQD6+iF+f2OxizfI9eM4z2EXaj0e+JPsuN5bx49+nJNB?=
 =?us-ascii?Q?j1dHLlsqOAq3Ag2zAoZwqASjV7fXdBzmnXaFkcasWkaI7fFzm0hYCgXejgUp?=
 =?us-ascii?Q?Ttzu1n/7dmWiwR4TJsj5BpgARhykVuU2jWHfLSBSpKKoxutmrW1Ri2E967l3?=
 =?us-ascii?Q?xn4w+2nMFt3ay5i+Dj/KiPTnv1Jkj/GKgPTG6AHWdAADGM74prPmLd5NoHEm?=
 =?us-ascii?Q?vxo8MDilTURBKQaDh8g+bhtDhsfKFhgi++cEIUYGKbUVlrtAGrQDGoyZrVf7?=
 =?us-ascii?Q?AOuyMegvtH4POJJgHIflcuau5pv/Qo8t6HI5AD1lkyoMKZ/ZQnAEqs7+Zgmd?=
 =?us-ascii?Q?9So60LgRkdOyAO4KGvu/JkuI5pB6oWn9XD+uSmrtIKrc6XC1u4L+4gp9UwZ1?=
 =?us-ascii?Q?R/8jb3SvWoyMjR/d6O6mbr0P1wZ/Su2LfsFdGpHTECNA3cZvLXUZjfT9Bk/h?=
 =?us-ascii?Q?4uWBXB3wV3EhOlMgg+EpU2xbD/GbOe+CsUtBg2m3NZK8i7FMAJCcuspInLGC?=
 =?us-ascii?Q?ltO2YrDoVS+wudsqyggaqRJ7PafLBNDVujixSkFlJNPYGBdDuuTOJ6pEgSRv?=
 =?us-ascii?Q?NULXWnNwlmI1BDDg0jJkRiT5z+juKehoZhgVcY0vOoEXtqUxn+rs/3sV3FHQ?=
 =?us-ascii?Q?nijgKlw5BgvnlPZeC6T3RAUAaQ+p6CCLl53C5LftVSM8XD8/8BWVZFdNs3HW?=
 =?us-ascii?Q?VZ5sgE3tohAwVYXyWSbOtimjYzLiz+ET8MAj9DCEaUqnX+ZICR3i5hq4LB54?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4fffbe-f267-4a6a-14b6-08dab6723381
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 10:18:04.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4NzygpnHpHi0nX8zCOzlUTmC9kQR6S0arRO5uHznC8hj56/1Dx8SKc3V9+ixP2FfTrywGiO8VN1ePlNSV6Bb7Zl4+98uyCR1AoqwxPi4JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0733
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

 .../bindings/mtd/marvell,nand-controller.yaml | 187 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
 MAINTAINERS                                   |   1 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 4 files changed, 188 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

-- 
2.17.1

