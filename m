Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150B7702371
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbjEOFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbjEOFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:44:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B8D171F;
        Sun, 14 May 2023 22:44:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HESx18KcDHRgJ2YKmwM+Yv6svzw7hVTYJVxaem2Q80BD5ohYMAG0dOVFBXBBXPCpTuQzU46CyRsHFu2gwuDXVnY9HrN9BZylD42/EKYRzAL4/Otiz/x9AY84fRi/mnYqZfTC+0WRV4+mP7wrbMli2hEPyXt/5Y9aNSR1JifhmKcpjzlUyT4VpoQxOcrp2kkMoEmr8GJ8GI/37qZfNSrlz2fhEXMu7YA3T7ZHuBeruXCPr1ewdp+sLRoA2a3JjfJrrZJF1XxDtAwnRVv37abhxeUHSKE8cgezAUSHoptpD20MZDMyPc9JitPwTcCQN7EnX68wB+u1TySMCykODo/Oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyxCoa+uYB3ki2UrAVfZ6nNW28mbV662FZgcEtY8mIY=;
 b=ky4SiM0s5Z+qLQDf9MIhOHK+b2dwcwBlAswGg0I/owlJS0pgGXXKoyZNAZKpy7fQm0mP5gyJRfquwmaFghUWHuKFbWo1MZ1pKW8CPojK8Ogan+QaZqg2OUCPS3kAKF0uQhdYSVbDx/b486ZZr61DDVkNwvP+NbJ1yBeIqiqbx6Z/o4dConEIAApa5fBnukhlt1fH+WcB9KTDSHIRRSvCaZAkdH7Ob+B1HgkJiqGckpCDE2XcGZGqisae55XCQPBuxsxLoSs8kOmlQIphYLR981f8tpYuNTKzQxPvrk0LBS+lnag3+CYp3I6TTKdjlKxPHibKh7/+Wm5tV+Q4xXl+JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyxCoa+uYB3ki2UrAVfZ6nNW28mbV662FZgcEtY8mIY=;
 b=q9DSYSqRBBiJ6crgaCHlZ2elCD37HY9VFakzL83FwJBOF02lprMGzDiQGnyvGdBLZGsV/aNiNSF3GO4u0AuJ/oRmkFfYUgbwePreHNdf6LMKi2aVcnk8RnC0Iqo6scTcc5H2aSQmlo5jOUQOfrKfUykkEhX32nG/61t4ozHCxqhhjbAUhbNw1l6D4qsQu1zh6032e8VObs/oP6c8R/7ZbuYt8/LBak5/3AP+dn7PDY1P5c6cNTKnjaC9fDu1R7Xf58yOH8d9cj951zbd3wsSla+/Ait9zWOFIh2bpzle4A+acLzpaVLnNBGiFbi3eqBkqc7+L/SIvuLW6ELcCnQoeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEZPR06MB6571.apcprd06.prod.outlook.com (2603:1096:101:185::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 05:44:26 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 05:44:26 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Icenowy Zheng <uwu@icenowy.me>, Wei Fu <wefu@redhat.com>,
        Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH 3/3] MAINTAINERS: update entry for T-HEAD RISC-V SoC
Date:   Mon, 15 May 2023 13:44:01 +0800
Message-Id: <20230515054402.27633-4-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230515054402.27633-1-frank.li@vivo.com>
References: <20230515054402.27633-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEZPR06MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: f8def625-d9f6-4306-f723-08db550771b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jani4bT5BHbes/CFTWwYpHgcR7+INGsBAYdRh5Rkk91UE65N1z6IHP9bi/rKMQly+a0mnYZbspRLtjJanCbiUI18bQfTr/iN4yFSHpdhjzOB48zbNC0LKS2UK5w+M1jXZPSnWOikhQ6CCU1F5ZJl5msz8dTqrauVacN1HZpSWCuU6TLe46TNiCn8g5SmcAHDaWQgXSxjleAad+McMRt1IxqMjfQWgRiKyBKcC4+Yed00OUx8IHvwCFcq7xjderuIETIFlxlSvKON2Y6/d8+BN2LRMPMAitogaOPiGKZIeL1Mdh2m/TxPJYihetAS5QkyQAVUfrWotP6qAPbLTiWgIhM6p0rPR6EYpNShrc/q1/OTnIN8Trq6hXUtas6SBpL8MByq9LHitBBVT0qoExHYM92xWk6Zb/DZe6D1RMZqtnyDsuFjvFeBN9rBn6MZgiMBqr+BWFSMynf3Kn4IUsFYxq7JycgCCPAlVaUt7LPgqyia6C7ap4Z0bacj8+qaOUfMp8Rz54Tkvx53VYewMb62TbWCE2IZNVyWY7UKcvbh5u0QcROPkDWbqev1gtepj6JgzVDp/u51DXav+pbUA0ijcdzSnm5FtW9FewMtykhWdRQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(966005)(52116002)(66556008)(66946007)(66476007)(4326008)(478600001)(6486002)(86362001)(316002)(54906003)(36756003)(83380400001)(6512007)(26005)(1076003)(186003)(2616005)(6506007)(41300700001)(8936002)(8676002)(5660300002)(7416002)(6666004)(2906002)(4744005)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kDoQtMJvJMPa6tIOcE3Fb1FRuZRXjl0w9hi0S0p7VyR1cQkZ+kkLpLRpBIxP?=
 =?us-ascii?Q?NyO2YJykWlvmt7N3COnKYlsdBJ56JT57pls8fauwB8Y+u5syE7rDkYfYgxSH?=
 =?us-ascii?Q?vNT6sP+X/nrEKm9D1RXmToxgrK3AIA7fQeLrGLfnAetXEHAUM9iANcQxtw04?=
 =?us-ascii?Q?G06ZhkEP/JhK/LQqTtKIuKgkOnIvw3nYH+BYt8q2XLA8/9cZzrZpddkedQ7b?=
 =?us-ascii?Q?d3OWITrLrmJOEcGTPTYivcWSaPSGLRuR9RqgaaE8XTK4LLS1DkQQQOhuVaue?=
 =?us-ascii?Q?ap7xcxmbH/krSuGrxzNxBw28Pck1WC69xkqVGmJpriEdFmE8RGKWvSkQ0vDA?=
 =?us-ascii?Q?xTmKkjNQqD4YFf6zGYICDJZ7W/3NO5z5v/+JMpOPzAVI49i7ySLjG0PLJIYP?=
 =?us-ascii?Q?5Ct0Heq4OA4aQuMJ+TlkwL6lRjFVwXBk4RdPWsRklLzjF1iRIYdLi3hbjV95?=
 =?us-ascii?Q?d3A6meWo1YNQwBkAGeUXhbMakpy8twQWiWn0j5VN+d2aYA1+g+BzdAUZfv7C?=
 =?us-ascii?Q?AQivhjN1uo0puTzB2PrAatDHXHJ0gK47KMxxteFouMtD1MqdnIXWw/UFKMwK?=
 =?us-ascii?Q?vf8ZSc4VtlQrTDZyAAM0kZBjOOwU6zrBq3G/KMBZKnck1fM2VTFG2KG80AUj?=
 =?us-ascii?Q?qm7vB3fRnIobf4pYiLKNVcU+8gvRVwVeb/qR6V4q7PZxh9dedUfJTcrgrUTc?=
 =?us-ascii?Q?UgQ/P4waY03ZAHnJ/sc5bpw9SejU5v4yxwmK0Uc2BnR3WpupyumXF1H8TVke?=
 =?us-ascii?Q?EROSkJalhqtz5iHWKSd4HOlTWRvZZMfsv7vbEzbVuWj8bg7gMq6LIN4LTraa?=
 =?us-ascii?Q?VnCy8KgpNeKLQb2wV5GxFhfW5IS/e1wQArYBtfg4MFz0Yf3z7cx6feD1TcbS?=
 =?us-ascii?Q?mM8QMHA9KYbY6K32rrw+h58MVl6G0WR+kToo5rQWSfoD59uigija9QPR4LVk?=
 =?us-ascii?Q?ZFO/n1uzq9JKAPQKORw/AUQEr/2espnxhmbOyt/LMtimuYCilPZGhpz/SBmO?=
 =?us-ascii?Q?XRs2UHoGLIB+uoTu0H2gAirp0MMi8AHoRptnqTBT28/rw8xn7v1KvLELfo7s?=
 =?us-ascii?Q?iR6zs02NDZk1A+OmUOCBMhmBcLeUcJILcSbjzLwOKHz/lZt51q7zlpAnMof9?=
 =?us-ascii?Q?roivDZyZG6d+SqoHktKb1Z/72M+my/7IpjFl7cqmYHd9DXNRj4vitq4ilyNv?=
 =?us-ascii?Q?ItjcM7d5AujMFGfQ44d9DWAC56VbetvxFV5lysi4ehQtWzvCqGuY1Id40BUG?=
 =?us-ascii?Q?KB0WbHFJ6t0dfniP6/ac9w8fiGgaSjcfrim7zXzL0/yBXau4omZTULxUuXxQ?=
 =?us-ascii?Q?OFRM0s+jlsXI2L/+tzqsKJ+wlMB/go+AwiCL10EaEnhdeFFQOnklE5HXtppf?=
 =?us-ascii?Q?x37flTnIJ32pmc/+XnFxy3wshHWImwS/KYTO4Q73ATy6LwhLxw80UCuoSmNm?=
 =?us-ascii?Q?JPl2y6C0DanIrXAAbHQaOiLolhtPGyiPaf2sq3v/lCTE1X/J6Ps62IT4jIHA?=
 =?us-ascii?Q?eirWnzOIK5lir0kkLg8FhTRu4Z8/0UVvK5UMTfpic5yEx2OQrsFQ4dSBm9Jr?=
 =?us-ascii?Q?S4bgpF0R5fCMHZabwpDmv1GnBdsGZocSVko2dnXd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8def625-d9f6-4306-f723-08db550771b7
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 05:44:26.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1x83OqyQNHVPlYadVUp3iq24v5drASv2JfhO2af+vullNNxGtamGH9egYS+xSxbilxxrKiMP4YLjL254OzL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6571
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei and me would like to help support and maintain too.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Cc: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1e51accec4f..dc35c654f78e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18155,11 +18155,15 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/riscv/
 F:	arch/riscv/boot/dts/
 
-RISC-V THEAD SoC SUPPORT
+RISC-V T-HEAD SOC SUPPORT
 M:	Jisheng Zhang <jszhang@kernel.org>
+M:	Wei Fu <wefu@redhat.com>
+M:	Yangtao Li <frank.li@vivo.com>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
+F:	drivers/clk/clk-th1520.c
+F:	include/dt-bindings/clock/th1520-clock.h
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
-- 
2.39.0

