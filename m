Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F045C7190C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFADDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjFADCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:02:50 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2115.outbound.protection.outlook.com [40.107.101.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330619B;
        Wed, 31 May 2023 20:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmQ/d4FiUmDaygse92YShTw9URN/7am4UdcB6l5JV9Y/Z0QYgnCuFcs2PqHoiM/fYl5JcAKbwhh7M+vUkAP/gKphEnLxqL1p54NcZcjqveTkev+dw5bF21kxZ6hL6xqLz9pM+Fx/bEN5iGYoiGjDVf58VSvDqcYaTvT2UKvIC8KPGv0+pfIa2WRHoKJa5zVL0PIgxI7+bWdv/UIBEID5g7oKKIOEnbio7k0ECwDWlRzyFxEnkucK/TKgTg4Z4K+0CdxzmKzDX0G/j9cIKeD5RYX6Uh+aS2Cm27nRtdStuNVi6VC/cT+aNY6YpnvhUrrIuNZPic+WCtcdY/yUgtZFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWKe79HyrxnVliMN+kGZfKv197rvGPnxmP5qPgke8t4=;
 b=bE7Gt9i4N8Kr1dh8Wt7hynV31lOwfEqsFvEkx3MgGbZmuDAERu9qr4+DIet443ZH2dNyJKk6SGQ3SjvGFL0O5Z5GUMG2lpQ89b+bhZF/a9rMf9rbHqQ5ub+qxRsBD5PyoHMdyOMMqBk0bNiWZzVZMTMQL/xyuYublckOtpE5lTzGQqnNRae1QOTYIC8ab6+B/8JaICmj0B49SO7ulfctbgMP/VhotIRmv5qdiQ6gUOXFOeTlbEwjATXL6qtPhztK94HemONqKP6vTc/ma7JrE7Msq+qkk3+2D3IrBXReb6pO0unccaxPeaxJlVBa55oKFVIqZiwoFgEuVtdJyZ4RIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWKe79HyrxnVliMN+kGZfKv197rvGPnxmP5qPgke8t4=;
 b=KGCE9+OmBzFRH5I5onFxkIlUNi7VZN73iegFfC7HHjIFbRKru++AiwuyuB+zBEv6noVqoNIr5ZaA9xin3aGpmSYUPB1IRxyxxAQYXk/0KRKH/89Ju5aOAfsQ7k/faqLK+XnT6D2LN/m2nY7W3D0K0qH+4rxxGcMFjPORVtSg0cY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 CO1PR01MB6709.prod.exchangelabs.com (2603:10b6:303:f9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Thu, 1 Jun 2023 03:02:37 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:36 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 2/5] perf: arm_cspmu: Support shared interrupts
Date:   Wed, 31 May 2023 20:01:41 -0700
Message-Id: <20230601030144.3458136-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
References: <20230601030144.3458136-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:610:33::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|CO1PR01MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 13111809-f624-40bd-89c4-08db624ca6e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMyBiOcOwL8NQqEA/n7pZOGFCkDaESg4pyoC2XI9OPR3Jnn6MQzYfUyAH5JcQfIJKYDjrT71DQBa8WUMWVeIM03ZCtdo9r+DZFzejF8LzOHbdWQI5GirUEQKYN/UdVlsrxJPRv23BtMqKvBW5lYnd1mZm6JfyHmxAglS1UzENV0SCOpewcJhwj7qnSrSd/aIsN+tXj3vU6Belx/CiK7+s6Vlm9jAdncyT6Jm7XXpbrVmfqr0CWXxGJhzSGZAxeZer+dzy+FI9/Oln6gCKgqE/KminEJxzmJy/dc6f00u5S8jE7Pb1nA4wypbXg12Tp1F53TielHXSlA296Jz3UlR9/1f3nTON/EGEVP1Qaks7P66D4mvmHbl8/8TAYbaJuKTNvKAOFA/6fVeEDGO6fu7yqnGmOaYr0DSXI2NkDHZVkxTin/uw23m+SZuRh/UDblDlrHjbjHOVZLONCNLnpACfBs4vijq+oQC/Mwt2qZ2wfDhFc/XQ3CCkEr0hKGncwVn5mxdwOCWPe01L/ZWRVA/d+s4zah78tMfzTMzpKoa+ddoe67c63TsC/geBhquvHatXlRoEMqmrnH15Fhznr/BR4rMJIFmngqLOGZl3Cpt74tTcZnCrjC9Zj4VA7Cm7/DUBmMa8yv8bPAgpu6Ez2RJiwWQoLndEnSR4xjj67H2H4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(316002)(83380400001)(4744005)(2906002)(110136005)(6506007)(1076003)(38100700002)(26005)(6512007)(66556008)(66476007)(4326008)(38350700002)(66946007)(86362001)(2616005)(478600001)(5660300002)(186003)(6666004)(41300700001)(52116002)(6486002)(8676002)(8936002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sO92BGVzI/p7+A853GHmpSfS+WfGvLpc/yyK5L3ktWBYdwQP/pPcNhI4eQj0?=
 =?us-ascii?Q?oqPKHLkYXRaPIpbmjLl+0W65DtSXsrbWpAlIxMotdXItRNDQ35NDGD+ItJ0+?=
 =?us-ascii?Q?shk72kZdoLv1oHBAg9UDUvV6AeYB/MWy3ypzvjHOjHuN9JA9zOD/J2ii7gJH?=
 =?us-ascii?Q?G2eDzYnBgTeU1+r2rKxiOH6vC4F5yFRQrRGoBusXvvu24GCWDzfY1vDlksNl?=
 =?us-ascii?Q?0y1s/NZi3ORHkKpj/ssZ4kd2J38OoG/Cy/397ciqx7fg2h7HzsGW19VlkI13?=
 =?us-ascii?Q?vDUuobxoqc8VzK7oQ6WP5twnsvvXpn4b6JDt3tQBOya3Fo/AaSurB6WyBvKO?=
 =?us-ascii?Q?hODd+axNh7n7phLVN1xFR7kBCcn4sBptJ/CSHL9QDbUMV/Zeb5I1nJj91Sw+?=
 =?us-ascii?Q?I6RikhbP8kEZ+5eTdx049X/uNffipYKHzaD2uxBPSME+56jNyi+tH1r8MIFh?=
 =?us-ascii?Q?K3qi2pWcwERR+CoVwYqIkolY6PhNT7mYTd/H+ul7z/4DNcDgaAk3GUnvxSKn?=
 =?us-ascii?Q?5dPoixKktYPISfsoyxcuuGtvVFMztM9W/l2cQSyVIIC/FMYQvGsYBrjSlSJ6?=
 =?us-ascii?Q?+pVAQUgRFik3Dbq6/1NbuVdAv7YRcA5gj0K/cSlhP96n99CVT60y5ikTwTmS?=
 =?us-ascii?Q?17mMltwb78eg2EX526mIGHpXVqC3s7xd/O8QrCa59SgnmrL2lU4OKUrMpR/K?=
 =?us-ascii?Q?ru0dO+6LQFK4340YK+tVRHNv9Qu0jExHQw1UXdIcF68QEjkUnRhNoOLWLNtM?=
 =?us-ascii?Q?kLLS/+ePP0iK1eeau6yHnZJ5+CX4607ha3YinlAwu5nDXSMUcD3Y2a1/KWBB?=
 =?us-ascii?Q?cTwlAwA0xd1TnYU+AjdNpWtgJP+BavchggkXk2S+gKo9ppFe5852iU3KwXLl?=
 =?us-ascii?Q?5WUj41j68M5apDzkga71I4HZZniN89BxBLUeAD/dyr1ut0KRXPBAO/kIoRSd?=
 =?us-ascii?Q?FEi/kXMJdbembncFAVEdkVc0W7aChFu14MhCLbsFRHSfWUP0KhEcdqPk4eOc?=
 =?us-ascii?Q?jRQscohjzG3418TPArxCItS/s4WmDwuwT51+3mynKFzZoiRTURpDmjV+w7GJ?=
 =?us-ascii?Q?qVHZ0/iwQOs6LrS/4UW68Y3opfhPLWz6Brsa5MGdkmKrGUrUeaaiH9Kk/7A5?=
 =?us-ascii?Q?MAndRLZAK+gPLmQ5jDwJOSnZ+W9esIPwASD0Aqu3fztclJT8cnZuP0AFvrrI?=
 =?us-ascii?Q?ki0uQ1xbfBUccUcBxym7xgxWCWABU+x57UUyH6I12w8cyFPSRGDWBws4CIZp?=
 =?us-ascii?Q?BUX2xlnJglw1bAEG4/Zd+1QxFYnzX70PbyI6a1kmKpizKWMjOKUvIKbolqxp?=
 =?us-ascii?Q?BQLFbUHBEIRugtBTYAEdDliSuM2Lia/HiGrmTaECcQBIQffrndqgHFyOFY46?=
 =?us-ascii?Q?KD0K7A8BCf92ibrNpK1stPPZFSjn+5b2uJjtYVq8ne+2MHieU9aFcJrT04V0?=
 =?us-ascii?Q?+kZsxx3KtIF051UJYQs/+E1q5KIlvnKr2iXmChVKZRBti5q6evWbCowzgdIz?=
 =?us-ascii?Q?/868yF4Qm/cP3Wb/kuofe8tGZhC6kM9yvgOAk5DdGnQPmLrbO5ksuM196dDT?=
 =?us-ascii?Q?1EnQR/toJ/VJpxykOZ5SCutRvS3EXtyoQtFeEjtjo+8Tp/bpC2t9nv7gLNzh?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13111809-f624-40bd-89c4-08db624ca6e5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:36.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1rcmitTyd0dzqxQq/HUZFdkoLf3t1nnd8PKnRMAl06FbG8zIN5lztF9q6E27+Jda5RyAEdyrO+i4L0xHWlpLJNZJa5qnLPSqQ3j8fggSx5DugIxF1XvsJiCo6Z69tbp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6709
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the PMUs may share the interrupt. Support them by
setting IRQF_SHARED

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 88547a2b73e6..cc5204d1b5fb 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1067,8 +1067,8 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 		return irq;
 
 	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
-			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
-			       cspmu);
+			       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
+			       dev_name(dev), cspmu);
 	if (ret) {
 		dev_err(dev, "Could not request IRQ %d\n", irq);
 		return ret;
-- 
2.40.1

