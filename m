Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0262A1D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiKOT0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKOT0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:26:49 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on20712.outbound.protection.outlook.com [IPv6:2a01:111:f403:7010::712])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1B62F38C;
        Tue, 15 Nov 2022 11:26:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckdwVhfShalf35O+SZmFQDh6KY4KjVjC+yRGoqmgPuJNcSL24MoffvGlUzpLdJwxKrJwAEV461YxDzkn2TP4IOOXQQTm1jW+HKn59FqpPNDLK6OeeT1q8T1QkSz8ckWsTr3VOwp3zLtS3fC+Yi1iEAk62RkIaMfqVaL2Pe5mDOWE9w6AgMnNDr9du6iYbG+BfvspmmpXFBLw17VjjLGWJ7CeWXT6WVYQZ+yN1XgSXDrlHoXuJo5SgZYsqMm7ZNEVix8Fu4YLZS/eFV3dxWt6/65Xuv8SCJ6wZmRip6jHlXM6nF8o3H9/dOxETvryBV2QNFQTWWPEnQsnvwh6P/ZlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iTml/Tdtensao2GltxQlRaTS/ICox853gA6KI3OMGY=;
 b=n9+sFV4RvahWFSXvKQ//3KT5ZdrjnT5eun/HI8Mw/Ti+bJxkqFRjISAWRxoFOsZQArs5l0njvFJRHhxMU46PpFX36fFljHpBpE6iipLHNvfpy6fP/RY6pOHj9zc5M1JB1RtoTpR/KYSkh42fV1lzXA2bvUkL8AV9El67HU/laRsI6NRhLOi+TEoe8h5XTsZaY8MgY6F43bZrfq4Ewniq1ewab4B9Ufw7tgMcL1HFiPJcXZcFlL8puWhFBsTbd+g7E2oGV8na8VZT8p5BOJjjjpcvgOfMwzM1IqbxCUoquvY47ioMV3q/9x0A6Eunbon2blUZ+Y0BH7Ivs/Fx2Adq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iTml/Tdtensao2GltxQlRaTS/ICox853gA6KI3OMGY=;
 b=bRegdyuhjYPTuqkOSHzyyb48qkkAYPbF6X0mymrCjSiFGdyqi11L1/369tHBytAi7ltmI9OPlFrcyprBlyKgu16y13SOhYK33qouVse3l8Yy5CulbjCZ32Hg8R5+gcwldzQ5m6ykblLJVxgjhbm2VfeTW6uIWdP3Opv/Fs+6UiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYWPR01MB10539.jpnprd01.prod.outlook.com (2603:1096:400:2fe::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 19:26:43 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::60f7:f062:7c7c:d289%6]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 19:26:42 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be,
        alexander.helms.jy@renesas.com
Subject: [PATCH 0/2] Add support for Renesas PhiClock 9FGV1006 clock generator
Date:   Tue, 15 Nov 2022 12:26:23 -0700
Message-Id: <20221115192625.9410-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:a03:80::34) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYWPR01MB10539:EE_
X-MS-Office365-Filtering-Correlation-Id: 76211f4b-6d98-4040-b65f-08dac73f5316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmAk/qfr348ovY2BjRIw3iLTKsTZRJaZIvEJHDLIOwI+1VA9t6ffxLG7C1p36EM+21phH9d6Jw/BuIXVQqeYJLQyXa5aIsnDxpPTIV3CNxG0wjuwfFdnXmXJbP/HejuY8kyXzFSjePGvVa6QjUzE/AP6p5xV1Ed+grYA0H+84CJuAz0kgVS2xDeErvfJ5nWsaM6vd1+fIWlfwO0XSdlttOCjHm261Yk7p1GJcTsMEixlBLJYQydKjzeWrmfL+FbtYpwzLNPmGQ6RGbhdGwIcv7kpxUwURsVPjAa7dq/QWcqCPLegzGSG6XrnXS/gDxYYTMA5SOzF+kbuMtC71nqvoufscLp53mSHWcuDTqmPihldDm3zYp3hN5r8U9rz2TnnMkLmGAKXztNqMpEgFdxCFt+IWBrV/zU71UCi1XbWY+iMQbWSkMG/DctFVDVezdzfwxXy7SX1wDgCveGzYxXwJq9uqND50Pc6XTPEvAIO4sai0STrx4lYsO4vUv9YTAwRc9JSad3WB3K9UYuSQNYj/pCqzQ3ULWxn13pL4xU8/6hPl/BNc0kHg7SSAW8ISr+nBJaMDHDw8RAjxu9zyA7FZ3mIrN3QW5K06+Ecobtuc9trRILMo1j9Dvm5OdSfe4is85C+DiV/vrtNbz4Cs2A0uOIn0q7LJ60eVu/5EdrboBiSIkSj+xoJhhWDdOoOdurDcCTs/sB59dj9I/Uuhez2q4VCCvA4hGl7E5SIP/4SOUR4S4heeGgDvH6Oz7YOdSxyDdLBk6jlb9bLkoEixDsT1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(2906002)(8936002)(8676002)(83380400001)(36756003)(2616005)(66946007)(66556008)(66476007)(41300700001)(86362001)(6506007)(38350700002)(38100700002)(52116002)(186003)(5660300002)(1076003)(4744005)(4326008)(103116003)(316002)(26005)(6486002)(107886003)(6512007)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ayUqtKCLtiEXb2gq+XUBJILpSJTo6SU4x4snNz4bkJNJKZys4t8+/h/Fikjn?=
 =?us-ascii?Q?SEfE/sOjwnK1s2GgnPKdkv2MXLhnztltA1wQk1IGFov1cPjRynv/Z4EigbXN?=
 =?us-ascii?Q?3EeKCRPlHGm0OxCz0WeVzf1AxvpozApkSKGSgFPb43b/PLEM/+Ohv7xcp1cx?=
 =?us-ascii?Q?aBKWJ7Y3TJ0DQTx7cdQdeOZsVpPO2uCfExqcmfEXt9IKsCJo4iNwGHQ2+/xE?=
 =?us-ascii?Q?rAG0hJBkneeTgGeYtrE0rqbRoooQGqlGhJGg7v0NnNIDOvrGAT3YCZCmJM/1?=
 =?us-ascii?Q?vLnet100sS1mbkdWLnNtDMTI0RA+IJA9iVqmZHGDTZpfAlKL3tooue+upmq0?=
 =?us-ascii?Q?8J4npOeApn6mJ9DBSw4PhsKJL9GMFG9KzzZZJ6XCyB/dGGlJEuUX+x8GceSP?=
 =?us-ascii?Q?i3avwwWBUws0v0bxbc9y830o8tOTPDMg0cNpS3+DQB/Y8fjHKCFl3HuHsWyA?=
 =?us-ascii?Q?rGaVaggQJl57JWJb/hEWvLHaleKlrsjhz1a7vsI4J6vtvGrzhqQimIksgVkw?=
 =?us-ascii?Q?2idVA4kFi4YJXotVEVj2Iv/sC+uVF6o9yUG5fG6tIFm87Ub98pH6O2d7rdaz?=
 =?us-ascii?Q?8yoLeYICHzhCtLqU12bM6Oba0D1Om+HT6t1xy/Ulhz8KxRsMxhz7akbl4ipf?=
 =?us-ascii?Q?mc3WCo1+1p4E18JkNV6UXmDleQbNuMSj28AFNptRwWDhsoUkNHWRiUpqunkB?=
 =?us-ascii?Q?zzH7+VsDf5+6y+YnlepDg+5gTMdNiku+o8VDynKwh+8pef+n91/vCrQejcw9?=
 =?us-ascii?Q?DNauDLeTAw2llDY0s0n6y71RhYZXM5Ukcy/bAqLUFCFYJGo9msNRWXe9EwB0?=
 =?us-ascii?Q?6BVCv843qJ7QYdNSxS63vFBKU1yQwSr9XM+3AWXESdbENnJjBwEkKxmdbdh2?=
 =?us-ascii?Q?cB6IFAcDtTlui/6253opCa1SbNAOiXtMhQKp7fw8IupvqEeeoQIDwy0HM9B2?=
 =?us-ascii?Q?ZquueNUd3vPvc+OxJ3FVk4aodRThbQOe1Us4Aau6p+vzjr4D3noKuJdW1tzy?=
 =?us-ascii?Q?Ywku4cI/yp6s9XDv5qBoFz01ZNbfZ0iNf0ibgMWUaYU6UqeiLc0ZZV5raCAX?=
 =?us-ascii?Q?mX/2oUVYivcBuoC+7Sv3oiTRkH4vcDTLwoIdiHRbci7lkNzHeqJ0FrQ5Kxlw?=
 =?us-ascii?Q?2a4k7/N9jEsVfnaHGmEq3zgf3CVkcxX3De6cm799qYEBPJQCQUX9hLL6tP7N?=
 =?us-ascii?Q?svYLNVRUoA+x8H+yHVIk9OtiHoE+zlLk4+j4AySdrJphCB8ZCrLfSn6l092e?=
 =?us-ascii?Q?Ubb9Og3RY7mi6XKYcb07C+ewb1Fxc/8nXa42kbh9/q2eBXI/5/K2ZDg3kxgI?=
 =?us-ascii?Q?8K4vtzAeF1izl0Y2wG2MegMezpIqORcZSWPrO5PJU3JB5y1mbrYQCi+EgwY1?=
 =?us-ascii?Q?7hqaS3lajicyD7lgy2VeLN3P3QSItCcEYVhlDH1YYkTAHI1C52o3l0r5VUAw?=
 =?us-ascii?Q?TzvwnJSD4Q6/gxcO8QX+aX9ANQY6sEDMGUcht54tNmxnAcEenzs/MCrzdEs3?=
 =?us-ascii?Q?6y9EZMvmzHoxvheJ/DTfc2XdOI4JVhRmowacxhGkcuDQ2I89gAYxDINoK6tU?=
 =?us-ascii?Q?doplTjMOQBHmV+Omh3ulajkck2m8KMBE8BXwL/tvEwmRbB6mVftWwCu4L8EG?=
 =?us-ascii?Q?ukurO9m3++cS+z2dLHGZ0UY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76211f4b-6d98-4040-b65f-08dac73f5316
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 19:26:41.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFJxZbKWNi6yqmh3GOu+VO/JYTtcE2g7tDMHL7GXBfonBEZ6GErLwTf5A8fOUi5XmvHQrJQLunygd4E0Szt4G9bnBEL4SJf9c/ukrN/LHJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10539
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device driver for
the Renesas PhiClock 9FGV1006 clock generator.

Alex Helms (2):
  dtbindings: clock: Add bindings for Renesas PhiClock
  clk: Add support for Renesas PhiClock clock generator

 .../bindings/clock/renesas,phiclock.yaml      |  81 ++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   9 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-phiclock.c                    | 729 ++++++++++++++++++
 5 files changed, 826 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,phiclock.yaml
 create mode 100644 drivers/clk/clk-phiclock.c


base-commit: 094226ad94f471a9f19e8f8e7140a09c2625abaa
-- 
2.25.1

