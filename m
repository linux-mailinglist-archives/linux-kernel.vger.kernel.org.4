Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF7E60BDA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiJXWlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiJXWkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:40:03 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2097.outbound.protection.outlook.com [40.107.103.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42482C2ADD;
        Mon, 24 Oct 2022 14:03:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWINxz8rwwO5m5phVePvmeKjFdqkeu+WCEcfeCbhJI7++OcDNRcxVqrLhze34ZXQGqZChnmssxnqe7IxkBmY/H6Ydf3A0zaNEuRbiQCk8lkfXe737erbHIXWPUZ7QcACOmlF+TDD4ubUREPUgBX/mdViQ9Ap3iKJijDp7nzB9I5oUjuR1azQ5EeODyPPCVvJTW7GftEfNQg/XAn3/VgFyt4tvwLT15mR2GXDcInwlByWlJFUZNzxBLMP4lbRMY9Y9oGtOW+3biKjrBAJY5ZJAcEAVFko0t0mNc90rlSGyKx5X9xPezngNYND5ONrQbxE5UlUHi/LDawtbSqer+Ca4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqGTqYjB3v46jNVAYJGxsAF0IPCp3Dn8a9o5uXuuw/g=;
 b=antJOKG92zRdvDVRPDGbhnv9I1XUVWsxVCWvmmqep+reOb+uCdh/HRSnXpYhZG1dP69UcMmaQYbRza1+j3pZ2lRXWOLM1Ld658OB23z7zk/z+U0KcUfhdbIvcOHUU69u77EnQm/DN1rQMAorxboFDTCYecTTm/zBTHJDUo3qvbyjrS33oEjagEpKhd3MxmZ2KJ+Mb2Ul5Q2Oj+8bpGi8yqG2lO8HzvDJNRsM4StUtcxprmWMaHQI6rPlVObbfXTlxonXncWuwSYdCbY3tv3hbASn68xF5meH1r53x7azFUKnvqtDh/UA3j0ZRlNdmLwE93VEilBHyNyC1BCgWNp6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqGTqYjB3v46jNVAYJGxsAF0IPCp3Dn8a9o5uXuuw/g=;
 b=l6ozQrT21643jwZzsxK9u52Yr26fi5qSqvQSP+/ua0m5+UD4BsK6iRh+bY2xfSdSQAHIXhFg5yUvhrHc4+qcVv0X/m3uvl5F98306xsFRgkTH2VqU5slyJRAcQd7/pUT9N+Bg+S8TkH1H0cAIRLxoJLIdnvLOfOQXurPDClQdcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS1P190MB1798.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:02:13 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 21:02:13 +0000
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
Subject: [PATCH v3 0/2] dt-bindings: mtd: marvell-nand: Add YAML scheme
Date:   Tue, 25 Oct 2022 00:01:49 +0300
Message-Id: <20221024210153.28852-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS1P190MB1798:EE_
X-MS-Office365-Filtering-Correlation-Id: d273a858-7ff6-4276-9d77-08dab603060e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSAbqAeIBEXFyDlz5sIryx9X6jz1zA7S1mKO81OEnTBHK3bIUt0SKSHbjhbeYc8TBQK8qIxubyw3S4PupHhAxZHVuxvZcaI5j9Bt6wusd8+mvD44A8ItFU59JMoeh69gOf3jnY9Q/UTU3rceUnPADNmg15qbXYily+C1dil+OavQMZ1oHeO4D3Uj9wl8oKuV+2H2BdAWlhM0xS5c3apk2kK8lcOEtbSb8RZgkd9/AqlTEwD2HnYxvI/dwXrJtfZqujAvAG6CjgDiVDcgbF/9KOX1v8ZN6lbeo9TS9hzfziOv22I54tl1w+eUEgQe2fGqQCf1DxgC3o0MH5mDzxPw61AJKUBv5FV+IVAxT26oZCRBLqUuKPZDfutQJe1aUgnjCQUa5HcyWbWQHpG16qm29BzQaZBjoNOy4e407RaS6cbaUqI/Uah47Tzvz/z0NZSmWE9I7CtTT0W7V4ecntcaykDgC/9jz8RIJ5gNrXUE2dMPc+3gs6Jh4sQaFj93g/tUWZFbgVXg3PrbO2QT102sO26AH57eJKkxTo0D8ez3naGTPGDNBcxrlrdSYjJI8LsQnlb4f63tf5OOGbM43JyMeAD8XPl/rjCty2aoTnvD3Z2Z2WSBhU1ZosMadYVtNb4saptORK2hOT8deSwnk8kAmAZex1X2nWf5mlMpfdwZ+HUnhkNWHwyJQnTgw4yzvW69mfYLQZjFV6tkzgVfaal+q+ZhBwwHDGxHAqdChgBTuTR4sa3JF8MOhD8xXoOBRC2V+LpRNQQgWu9FMwdHXZHDzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39840400004)(346002)(136003)(34036004)(396003)(376002)(451199015)(4326008)(54906003)(8676002)(66556008)(66476007)(66946007)(921005)(110136005)(316002)(5660300002)(7416002)(36756003)(8936002)(41300700001)(6506007)(6512007)(1076003)(52116002)(83380400001)(41320700001)(186003)(2616005)(86362001)(26005)(6666004)(6486002)(508600001)(38350700002)(38100700002)(2906002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZeUa1CNc4cQw7XDiQEK7/cIYvPzdO0TKTX64HKn8zOldy1of9+cF3hfpz3Ga?=
 =?us-ascii?Q?VO2JBKeXlmxAPShYuOwOG9Wmw3FkgKBvOO7umUJsXbEQp0DXRGKuEmt5Dkmi?=
 =?us-ascii?Q?d7YxeGDLAkzRYwaAehQMPisw1T9SZfLxvJqeWrwmr25pagYXP8r3Dz/fmFV6?=
 =?us-ascii?Q?UWU5c7Bo0UCLec275m5TwsZuTbIH2ntf+tXp4S3MDxjY3ubPGczUsoNgfhb8?=
 =?us-ascii?Q?eagC7x9QBtlWWQx79eUpO0F/9Yt5nphctDuUAthPA8+pcNdIBUrJE03vBU6l?=
 =?us-ascii?Q?0z6KyIlTwysyenaYc6otlZbziJE+Q2Asxd5rX5Rgigmc+aIRR3PJQWRsrM/Y?=
 =?us-ascii?Q?VHPl49INCbm9cG9ENkzsKT+8W0X2Tho6kQY5SQgB4E3lQ+nAL9dpvsFGCGCL?=
 =?us-ascii?Q?y8lWbfP07Hb3fgbl74qU5hdxLZjSdjxEB1WwBslrVrbuavfdDFJ2ps3kz7KI?=
 =?us-ascii?Q?1izp91ekmNrVqXLtcn9N2/wGaRupwwlbzTRCMtziXceT8ruGN8V8wEaclI2q?=
 =?us-ascii?Q?p7oT3TNQQPDjYdUTkB3V1u12yE15xqoIYVYNPgAeJbRZLM+iKvm8P/52KK6u?=
 =?us-ascii?Q?itBD1S6JVUzWm09gHoZJVfJqYxe1L8PelPQcm2PFyIFqH10b/fvxhQGA7UiQ?=
 =?us-ascii?Q?hIavVDdCVDbdTB+VojJPai39czF62ohFcarGWe35xx7Q4Dr89XjgYpzlm/IJ?=
 =?us-ascii?Q?W/vk+124dVxVlKIgQjpvoxm6vmt9rPKseJMbmo0BMawbhOUjYv1/JKN7cSVe?=
 =?us-ascii?Q?iXbx1wSaKyyEvRRaFhjBi1oMCRJGonAX5ct0gQjSBKVj9r0Iks0+z51BwOLa?=
 =?us-ascii?Q?PEeCrVe0VZQNvfCEbBtqkqio+e+yQiNnTtdjx4O5erlIfxlHKsSnN+CYGppP?=
 =?us-ascii?Q?B6J/dSlJxMSt3NMiDSg76NhTHqLDgSu3iZbFyxe7d8BkllIPcDKJDkuhnTB2?=
 =?us-ascii?Q?IVkjAUs+d40kvROKrQzpv8hQBvYWRCYlwPBCKTuQBjSyD9om/vJ7xdFKfNAC?=
 =?us-ascii?Q?13lNS1j5WD8DBMM0MnIf7/GRnkw7tcUCD0G2wt5n9nJO8SFMwtlBsqkPrJ6a?=
 =?us-ascii?Q?jh0VQtPKhHd8fz/S2pCSKrbOOtROAkPVVRe4XXhzNlw6QqTBgcLjrnqumAJu?=
 =?us-ascii?Q?nBc12YZxK0B0qmDucJA9TFmBoEZWdcbSbVInQq4+zHMriwml/vM2fPR1PBEb?=
 =?us-ascii?Q?LYCT8LMpxZIjX6HFQEzocKIMBQkN4lgjuazZGpONtRMrwKiYWEdzaeRr75sm?=
 =?us-ascii?Q?byW88XtwM7uvsjLVMhEUbLdWG+wo2cT2/d0d92dYFm4M6XwvM4xLSEn9qL36?=
 =?us-ascii?Q?h2KZY6J6ifWGHXTIaeL4CxrCJERReuwujP0W+fbDAwQc9Rfy5ZQHH3xsJNi8?=
 =?us-ascii?Q?SLcHsG3sQqInWO895BB0Lt1RVhtgZX/L93/VGUEx2ddHhLNLq/PNrUwdCJSZ?=
 =?us-ascii?Q?VEzC+4AYnT0mqqXicA+TMXmPLDNk7P7/Qjdakcy+wR1ODOERsK5B/c56ifTy?=
 =?us-ascii?Q?8m3Qk93alyaLQtmGydTjDvk8FpgnwypZshkadnHihxlvlp1oK2IF5o+i0gBB?=
 =?us-ascii?Q?404c4MwSzzJ4l7UlbpAHzgXREpQfmSiWPifa4w1Tds1FVgHYA7XdpLlmjSV6?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d273a858-7ff6-4276-9d77-08dab603060e
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:02:13.0687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xldjC1fI/wBG2jV9FZcehI2lFxa7VIlYewunmEuz3kvCPBRCoMXouWj9arPnebLp4bIAGaBsxNRKCa+z5eEamS8iBYABvj8wVBGOd8cxQxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

 .../bindings/mtd/marvell,nand-controller.yaml | 189 ++++++++++++++++++
 .../devicetree/bindings/mtd/marvell-nand.txt  | 126 ------------
 MAINTAINERS                                   |   1 -
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi |   2 +-
 4 files changed, 190 insertions(+), 128 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/marvell,nand-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/marvell-nand.txt

-- 
2.17.1

