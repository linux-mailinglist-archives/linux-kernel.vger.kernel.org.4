Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2487257AE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjFGIcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjFGIcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:32:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2114.outbound.protection.outlook.com [40.107.243.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3810F9;
        Wed,  7 Jun 2023 01:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSMDocZvrBt2YaQtAkd1nCzeN+onb6rT4NGzgbYS2G8Uad1rm/DK84z42968Mvvmo0pVoodbuLtiS+1OGI9sNUTLJ6aqYK8187eaPN4IYnvHm55i7PU46Il6s+TC+04m0hzmjHcEURU5H16ZcitwWLZsoj/ALUesqJgHeK/wQ5g56Hq1v7rnPWS1HGexR3w5jTMlg8iYiyx9rYHPVRVJPyj2+8TF48e7c75GYNX7mvK+ulkLkX2Zxs7YsQdIVOCFSsmBDmDtBVhuFyIXPidWQeVyq1KpgjiEKDhPrM1uVtXDoZb5V3K7PAOLmHuCK22GrqxXUC/LS7kP/9WG9vBkuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUcFBrC2fq2YCioiYdRVOpkXAS89uIaENNYO3h+lEtQ=;
 b=ciUaljmCHavabLxbhCFur/9DKe35+/Ubcdbrdk7BlBCbctrCvcu7q6J/RF2SQc5Wqzx20IEmVCiJ42Bw0is0nKubqLI3BWds3eSt3+oZ32WKsUBd7CSLgHQWNJFcVzTU74eOXGhflqjLXPCBGnMYqQR1mYik0CHN7g5X3G/KBNg791f9CKof9ob6fz8XgQh3zA7Z9Ac0QNz1AqHlG070OJ4++ysZMSyLfatq/az+oVuRxKHrOpLm3O4QeBsHH941OkXkh9rsYMlpEU4yRE+6f7BA5930r1oHWcSmZd8PE6eSe+s8jq4J028KH/OmgKS7t85FgVp22TL/6Lg9wRHQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUcFBrC2fq2YCioiYdRVOpkXAS89uIaENNYO3h+lEtQ=;
 b=pCirP6LS3slywUG7jqwR8dxcGGmgpIZogwh/kMiInr2GOFGL8DL3Cl8al5ruD9ivV2owkW7cusmpMlT07w/MR2aBoGnwq6vPyeFwq3xI9ZilcQW50rta077S/tSfwulFG+05Go+uyyTuYnL8d6aGPkbS8wP3MD6KXG9syiOFP38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB6304.prod.exchangelabs.com (2603:10b6:a03:297::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 08:32:37 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:32:37 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3 0/4] perf: ampere: Add support for Ampere SoC PMUs
Date:   Wed,  7 Jun 2023 01:31:35 -0700
Message-Id: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:610:4d::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: ca830318-19ca-4d41-c38f-08db6731beba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePtl50+9oliRtHTNDlq8SI800BmRl52+0IZt1UrBtv/b9SnA9xQgyRlJDKEz6yjRsm2YhvZavV5vRlG+AqbK6LCEQyKHeq4cj4AgyP6dGZB8Z/1nDfg+cYOfSFH7AZS/GhZanZOkanJrPwPhMmhPUKcp7rH3LgRluwsiiKC0+cBYUpuddurCVXiFkzWpcy1jAxazziKigUW8s9dup3n9wgX9Tc9l6/Q5K46Rn1hPjSSTRsKKzBgwsWx8hpgdxzhPbuxx8pYsCBOozxthJ4GxESBlwKujngWez6Cc7befrT6dfQxsMVdGBZ/xaHV7TjU5h2GvsIK3NkhtrMuug2oCGm9BX855MtkW0DzlJxD0HJDrg1Z70yGzB5x5iaNaHJEf1YOyVJzwNzBO/SV6k6ACc4LninpCOe4Z8hyMn5REuBBeoSMw07ZNkxcZOO8aG8DR1HyvchgvM01okL4Sfpux/3VP0pFsrUayKjNgM9IVmtttMPJESPkaeVQPGA7pbbyJRuqZn1YjcxCXccU50kzoadQZK2GwencU4HJCtD0Ttq6bKPNGzmu9pqc8wBlpahiWIuq5v95oxIYpYILKpKmyDyUPVHT+XOx7pEcseM87vhYcD0k8dkhm0M3GDBFHC1Pm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(1076003)(186003)(26005)(6512007)(2616005)(83380400001)(52116002)(6486002)(2906002)(8676002)(8936002)(110136005)(478600001)(41300700001)(5660300002)(316002)(38350700002)(86362001)(38100700002)(4326008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1uyarIWkyfu5vhSXxtQzAc2rOFzahmefWPemqaLvmYxT6SUvzq9AXC3/zTH?=
 =?us-ascii?Q?AWKnU0CbccEjGVrTv9fn6EzkeQ02nyH3hW8/sIcqxSCYGykt7j/5m7FPvJs2?=
 =?us-ascii?Q?4BTp7abxRKTFBOuZhK7sWL4fLrQVsxaXt7esHJsM6TUXy+ZS+qMG29ODXGEJ?=
 =?us-ascii?Q?iBpEhPHXXYK4R+cQ1xHIxmGn2fif9mXzQZ7KMpv7SQIsDS9mRKWyHoq8zEly?=
 =?us-ascii?Q?MpmziL3pLcY4O5kwICuBp+68REXhx+ky/31Q8LQGYl57Eh+b0x/v9B5KFBW7?=
 =?us-ascii?Q?ncy+Rf28m9FprbGqM1gPxJoWY1fdHbXyXTAVwiIhdEikGc1tdJj2thZVseFp?=
 =?us-ascii?Q?LA7+9WSOhVeAb2J5Y1QPIvRd4zQ0RNa7SMCNJr04AnaXbcMY/5lxggGcNmU9?=
 =?us-ascii?Q?Epsyh1haMz78pCbAdODHlCByrVWYKpPJJtYkpa8erSd+MDHDPXaMoS14DMhI?=
 =?us-ascii?Q?RfPeSsplLcq8Ud2Yo/SvA/zlVQmP+tFVHEHCWVqrBv6w/tYEJoWdc7LNgaGh?=
 =?us-ascii?Q?VelXbqCnY7Ad81Vguxx5lRwn+5iG3XhBYUadbs9ov/xyOdQdbCXhOzU9fE6J?=
 =?us-ascii?Q?IgjQK06HA7+YBGLUXcCC3Cx20rhJARldHC4DD9yjmNNH+DmrEgMaZURxyBQD?=
 =?us-ascii?Q?I7jOqUVPx2FDG1raFNCMWF8PgAoTxwc2sieWZDHqg4ZjQOXOAMAz6/Pnj5Xw?=
 =?us-ascii?Q?mBey+TKjaESvu5wfYVrYyoX7MwQhtLF7+o95uAPg5YRxymQBTnGgEeg41Hjv?=
 =?us-ascii?Q?X0rCFs/VCX8Yd8Ma0xvonggeMV02pB/fQivYqEt3sg2tIAZwA3bmjy5pNpn4?=
 =?us-ascii?Q?j/P6P01hKXYv0yZ4waiVcZZB56NjP7iIk+Oe/zAQNSxXsIYwgLf/DFYFmDN0?=
 =?us-ascii?Q?PjN8opBryFYed05G0d9P+AaJtZ87CDV8gpiMyZwqCnNYrvvpb33/BiAuWQ7J?=
 =?us-ascii?Q?c2a8p+UbRi9c9mHlTOXdirt3mzjECbUQBzVJS8Y3Tbd/H/hLYCKg13NUc6Ap?=
 =?us-ascii?Q?RiWcQhovJ0/lcPiwkD5RWEmJDspU7var3NSlHdp1QYwaBZezcLGZo7tAOsKZ?=
 =?us-ascii?Q?xv2S+OFGEVpj8w2+YSUSY9YUagvhwLBtvoX203+3jbqULKjXiptFGuVcLWSm?=
 =?us-ascii?Q?OFNOmwlGMjKXW/1OQqZ6lnzDv3aZhXheVAkzl9Lau6vM4DiyUjIH3F6xGygy?=
 =?us-ascii?Q?6KsuKHUoL1pKkNKBXVPgk1l7+rCMrdcCSAVnc/uV3s+zQQIRpMN3eOq7GrEY?=
 =?us-ascii?Q?CHqOxJpgqhdnzoG3WlUQmrMrohnGqN5xA8aV3eRuqopivffSTsY7dhuBJMS4?=
 =?us-ascii?Q?SNo4Qzy4mhT9B1WDIzuKdMVty1lhfqy9UD71P/sOrqwiwJymV9IWjbufoQW1?=
 =?us-ascii?Q?Yr3BFHXkkTY44dBSQmdtZoIEddmElo8W6tXaBwelJJE3zuUtOe5EY9y5TKdn?=
 =?us-ascii?Q?HhgivJyICnaD6lQm4tx+IgH+9Cqufhabw+64vxZst23xOR1mFFm/tjwnJD22?=
 =?us-ascii?Q?guTkFaALwefoSZ9xODIs4MgeKKN7LJGFkmVaZ5gKB+Ibg6OCnVPn6f9X/IZC?=
 =?us-ascii?Q?fN8GrG//X930al5sAu0EoFeukiHxHsJ7CVXLfAGGSOpOpiiTHGEpX6SCNAnl?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca830318-19ca-4d41-c38f-08db6731beba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:32:35.5678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaaVO7Vtb+iQDMbx5Dlel2NTqxWWPKxcrud3W0az3X85HBkzjwZHQygkMhltV7dSIelJFX8ZOt7k59UxoLsf1/0L+L4iCIXHSYrCxULGnCHg5rM6VvmHyKsRROexIE4i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6304
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
    * Changed to use supports_64bits_atomics() and replaced the split writes
      with lo_hi_writeq()
    * Added implementation specific group validation to patch 3
    * Dropped shared interrupt patch
    * Removed unnecessary filter_enable parameter from ampere module
    * Added group validation to ampere module

Changes since v1:
    * Rather than creating a completely new driver, implemented as a submodule
      of Arm CoreSight PMU driver
    * Fixed shared filter handling


Ilkka Koskinen (4):
  perf: arm_cspmu: Split 64-bit write to 32-bit writes
  perf: arm_cspmu: Support implementation specific filters
  perf: arm_cspmu: Support implementation specific validation
  perf: arm_cspmu: ampere_cspmu: Add support for Ampere SoC PMU

 .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
 drivers/perf/arm_cspmu/Makefile               |   2 +-
 drivers/perf/arm_cspmu/ampere_cspmu.c         | 243 ++++++++++++++++++
 drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
 drivers/perf/arm_cspmu/arm_cspmu.c            |  33 ++-
 drivers/perf/arm_cspmu/arm_cspmu.h            |   8 +
 6 files changed, 327 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h

-- 
2.40.1

