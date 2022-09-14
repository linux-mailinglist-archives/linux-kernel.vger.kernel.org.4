Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00E85B9000
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiINVSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiINVSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 17:18:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2137.outbound.protection.outlook.com [40.107.113.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D5844FB;
        Wed, 14 Sep 2022 14:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Gt6AOS6ZvRuOvL51WkjiE//huiSnURwf51bMAi+P2F3qTQX04ujFSVmRX/fC+TMZs6gKdjV6Yks94OUhFNa9MdJX75YwyIhiWelP5DqnBsuti5PEfYPVaI7lj5Bz8zE6Qp+fAO73nCot4C6BGboFwgOezxZlYu/cFe3VVt+6GNBeFQThpwiK6g6YpgB8l4oitrX6Q93zQ8qepsMGvr/WbjOEn6svQVBTH97/QfnUfr4sE9LNN/pKb+OSB6RIk/pVPCf/x5uff2MCu8KePRZC5RcB3RyMl+DhadNCRB2d0VU8F4LVLS9l3UrBUN17gZnK7HuQJEV/glNrFQQYzxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sClItdNfOB95z6Kr9CQ0dw3/VCnJpVXxfHiVR394Ms4=;
 b=mKCp0oFbGfhPQGML8JGKv74qy+Qhu3rySvzTIiXvmQ9G0VOhnAP2cORcCGEihhI8FmH/b0p2qbQbkUBMQh3mR7YfMY4+i4QvwtYGp6GvVYQ4m2oJ5KIVHgdkXwpK4TDKbchXGkBuGXiGRidkgM02wHu/k3r4twI4aYkiMSXKHXO9mV+Hl+VnsgV0v2umAWhyxGC6eD42P8UMR4k3GTC/2+xL74TOy3+V3wU6a+qePdQPSA5drwAUwm/OdL5Oq8E5f3gwUofslL0NvXvRkadx5qrRyBpJq7ocTiS40VSYznfTVKUW73hYvoTqEELRlP6Mc12YF10uX4IU4w7i1Hgewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sClItdNfOB95z6Kr9CQ0dw3/VCnJpVXxfHiVR394Ms4=;
 b=RpkXOaKOESok1r2s8zpUCBXJXxgNGBXDj3AAhDyA5Z9vQgxW/n5IPOEET2IxJYOcHRCfRgqgu9aS9x0SZqerq9cG+FYaADn6mnz+OpjAhZXxzqHanGmdyxBsJdCJjgM/IrxNtX0nrjfi0EGAk3MyLiBfZzV63qGKKgjJUAPKyM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYCPR01MB10511.jpnprd01.prod.outlook.com (2603:1096:400:308::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 21:18:28 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5632.014; Wed, 14 Sep 2022
 21:18:27 +0000
From:   Alex Helms <alexander.helms.jy@renesas.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        geert+renesas@glider.be, alexander.helms.jy@renesas.com
Subject: [PATCH 0/2] Add support for Renesas ProXO XP oscillator
Date:   Wed, 14 Sep 2022 14:18:07 -0700
Message-Id: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYCPR01MB10511:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1c383e-4038-487e-f686-08da9696aa73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vj7AaPJQjT11Ew+uQPeTVULwaVxUCb1OwaBp08etlPO4FMV5hHEOV0KWxkSAcBiLn1+T9yp0L0sK8qPzZ+9k71BzJ8nN1uvTZCDVXqugVNQamkEVFHnL5AWAsZVOZeMQ/LhyCjTl5e/2ai7zkzolO2EKhjGwfFwpWHEeAOFd3edirp6lZLXIjNtyRHMkgpUCiLQ3ME/q1LrFyXUZ5bMYlzaE6Uyj8ewXexNgZJDszbEeUoWkol2V6b3f8dBAh3BnjNypQ4CpaAb8UXTKdXtIbe6PIvqmCsf+dsToduVgVrHZQBhCL+VQlLkoxAS897cLh0IW9LHA0ucG8RQO/+CFjVWlir+qzq6IOubiJp94J4sWghvCip7z2TI2fNzUnn86dYvlMndhhfTj/u9TkbRIOUsoDmcdxJ+GPxKxXTAtPfc5ZhY7WXncw6LXRmUdFv5sTMx8AqCrrh5T+LIogbPpPIlDr0u6OLNKw0+kUpxac8XdMwElmC6Qiq5EXbvyNgvV1Tzu2nAFk1PH47H55cfj/pGfjyN4mmf7fEb05IBn4PL6RX4+w2HdXWXoSBZqIiQqyhKt5s+n7A2CXIkm0xWJee1gqr06LfylsxkNE2adzJnqQm/9K9XWpzyVvMyWJTwlQvHM36vCNwOxchfQelar1JNXIvkRRKUXhEKX2n1ODf7jeEMwl1QlPSzwcwshHmr5/qdF5Iu2dex08x7n0LtgidyPRyE8FDC5+GmzPI/+wOIpzxeJ6BW7feXdbiD8Xjt8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199015)(1076003)(4326008)(86362001)(6512007)(478600001)(2616005)(66556008)(8676002)(4744005)(38100700002)(26005)(6506007)(38350700002)(6486002)(107886003)(5660300002)(52116002)(41300700001)(316002)(103116003)(2906002)(6666004)(66946007)(83380400001)(66476007)(36756003)(8936002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5TCwed7eGEil7O7aGuOe4G2lG5XePT7t/cCXJVD6dJyzcXQaayWPMOfDwzxJ?=
 =?us-ascii?Q?Rn1O2WNnMSm7HF7bUCYTFJrDNRScXTybaw95QiMECrMuymbx+DB3mPsoRURt?=
 =?us-ascii?Q?31EsVEoM1Kgpxkz9sJkIwMdgVx2pJ9KGgwhm7GK8yOr3VvctDfa5Kp+I1cqR?=
 =?us-ascii?Q?b0ii4H6P3qHHvJJevDkxcYBjXPtgFEHFzlvvp0bvIlSA4GgRuZMQ2QZpa3cl?=
 =?us-ascii?Q?02o/I+y1J4EymMWVsbZPKzCf2OHYki8YF20XvCN6rnqTPruybXvJnDx0GWqI?=
 =?us-ascii?Q?D6pM4+vv27+hXzsZL3ETHDS3q0cYLpAgg9p01ZgwEduJD8P6jm2Jv7Ramlpa?=
 =?us-ascii?Q?5FwAskgRBsP5NGMpHReKu5n4HiivOrK8BP83z/A35glKrol9Q/oMGBD1GFjz?=
 =?us-ascii?Q?mqviG4gpyXYaSzh6iYmo9gtJyk+7wlA3aSmG51P1OvNN6PvwLAgMXY3ia3mm?=
 =?us-ascii?Q?TbwX/qB1nxdYUKd/ne6WyvjhKscSQDH+RrONsO1LFX7IOSdsVnS4j8yAFPxA?=
 =?us-ascii?Q?iGExVQWPTgygZtfekz6cFKvsiCA3C+LF4u9eXBuyp4Opa2d6BCBSxFsDhsUu?=
 =?us-ascii?Q?cDBHYboLS+3AVWpHSXuM0DspoYaLSsEza/N8ZelV6glTtgYSpUDNfI6cpEBN?=
 =?us-ascii?Q?GEOzS2SGML9R0ulojTyhSaTwnUsOeFSHY3qjnuKjVwrQiHL9qH1pVrQMffAY?=
 =?us-ascii?Q?AHHMMPwD9RCB8y942weCTp7lCNcoNBaq+yuI+5hEo72LPpiZLutrxMNYyr2O?=
 =?us-ascii?Q?B0wW6Xwka+pokRQzdi2CCGLkH8SpDSkvOuxfvIcLG8A/ZeJpzyRE/g+LBFoV?=
 =?us-ascii?Q?YgrxviXBtxPcTMxlfVc5e4DagJcZrDP7ifBkHbN/9VqnTNXVD+h7APDSlMBV?=
 =?us-ascii?Q?yV8axEYilmNs781+uay4yzKlsNPZAf+1NQbj1B5/6UIBOjJVlkmhH4nE0qIE?=
 =?us-ascii?Q?NVuMK+ESh2OoD8fOxYEyH41t4qN1OqPNcuLb1QCy2DZIRZ3ayismovOnTLpW?=
 =?us-ascii?Q?R/HJTo0DvmpM4K267KdSI0iltFDx0+9Pboq5mjyflCYysrE1mRI9ahYESt4E?=
 =?us-ascii?Q?udTT3UkdUa7WGI7piFf7FtbN0KYVvqoTgGEFASLw1JflArmIsorG7bphZ3Fe?=
 =?us-ascii?Q?xc2+1VEXiEGbmSsQtK8QN4gQWKGFWIsD0Lh1ToJuSjkce0kYEl9vBu6E1uKf?=
 =?us-ascii?Q?bFKeZSUY87/1exTAEYO7VmrcyyUH6FdNCYLoTkJYHItqsSckE5qoR5DjnHJQ?=
 =?us-ascii?Q?Onsin6ix4BcagjcCALG6s2SSmJaoEfdMBQK7K0AuUDwV1NWetwlZmbASgfVO?=
 =?us-ascii?Q?NLsGJQH/xTd/G/4smx0JGH3nU/vsF2RfQhbm024p7Gi+7J3Z/K6MLoVQStQ4?=
 =?us-ascii?Q?XQ4uDSA+JEK3uGA5SmjMwaq1dDCulBY6MCcAaIL6nToiboaaIkADgt6e6PBK?=
 =?us-ascii?Q?Y1nmkUl0vW33jVzbAxdCKsdE3QWCD3HYXk8A7u6Qok6X1SfxUvTebD87U4Mm?=
 =?us-ascii?Q?spiL/hQ99v7Xt1mQ3ds5hLywBvPq04ffPmxQXO4jakghD0YYbQrNX3vFavgN?=
 =?us-ascii?Q?qIliAxC5JXauHVv4CszByaacJMpnhLKDMv3zljzXEF5uabRHgImrCjycgJQv?=
 =?us-ascii?Q?3XUI06PAKWPBxC0Bd/pE57E=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1c383e-4038-487e-f686-08da9696aa73
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 21:18:27.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mVGV+EVk+6IhetACV59K008TS/H1Hdqy5bfTasZFCPcO5ZeNNjscWbPT9yyN7rwOwbeCNctuu46tSxg+V6X0h0QuUStWK1O+W7wqTE986c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10511
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree bindings and a common clock framework device drivers
for the Renesas ProXO XP oscillator.

Alex Helms (2):
  dt-bindings: clock: Add bindings for Renesas ProXO
  clk: Add support for Renesas ProXO oscillator

 .../bindings/clock/renesas,proxo.yaml         |  50 +++
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-proxo.c                       | 410 ++++++++++++++++++
 5 files changed, 474 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
 create mode 100644 drivers/clk/clk-proxo.c


base-commit: f64b5666e11dce481737208027d4af300c63842d
-- 
2.30.2

