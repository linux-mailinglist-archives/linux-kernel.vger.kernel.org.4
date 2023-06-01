Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61D7190C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 05:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjFADCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 23:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjFADCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 23:02:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A878812C;
        Wed, 31 May 2023 20:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNYc0B04oZcxBTnarJazLCI/e2MFZ+RUYwOTnblbxQv82u3S82I2WNG2z136qfNXpZJDfO4bKdoIv54x1cyVNkIN0HPtr2B3bzHBFzC/vPYwjP5A77gG9NtbTtQUKjayIdl0o9LnsT8n1evOCS6DH5o826/6onsAgZLn5ftHLykQGFuKpLkVLLg6FxDpGvpAKYwkIZ4gLEKr8JtNOCQtn0d1xMLSB1JtDkrTNo8UPWKXxQpLMY1/dF47h0QA/zZEyryn9lJyoE+n+Flj3bVegukyx5xvB4DSip8EpBHXe42816YAtpTQxDjkg+tV0qcvVdGe/+ieYhDjgwD0EcukRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZqVDjI/jaZkCvAHg8TteGXwKi+KDR2GpYKHaN+9Tbc=;
 b=QT0fnprHQpYtQT5G2wZ0aVPmOKp16ifOTBRkTTKZQyd9GXJHAReUHxI6FenX1bCuRzMrA7uIeoSMHqUqRi1qtiCq6+uDSPLURsQ1g98hrjQmUFZkTBZi94CFLLFydY13N0aUpxW0rUgl5zdlqyVPYfw2O99EYf2FdoR9Hz1BRThU3TFLeDUiWaHmZrnWLkvasUNzzVs3ah0wTltsjhx0IeogVIiCvbc5MU3niSKl5PcpJhx3lFjMap4JRZv/ntPS47TRKSU6P2qqH/IWPEFUxND4eIG69XY60oTiFCgZZvQfKnL9PfLLLRg4w7JrBLA3QXX/9oX0VS9FLP+V8geX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZqVDjI/jaZkCvAHg8TteGXwKi+KDR2GpYKHaN+9Tbc=;
 b=MpxDHZfYpQcfMnt8ka11L8Bj4SuvOI72bQ0fnm93hCiOj0gb4xPQA9bI4nQvIJF2v6QAeOWiC4tomnzxYlkhCR4Bm+7gGLDl0S2cRGWi6y/h/a1egotkeE2ZMvxz7hhF9BwbYlXtOXBK1mtlylHjkG0kuqPOGN1QhzxcG/moovk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS0PR01MB7889.prod.exchangelabs.com (2603:10b6:8:143::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Thu, 1 Jun 2023 03:02:33 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::5aae:2a5e:15f5:8196%2]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 03:02:33 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v2 1/5] perf: arm_cspmu: Support 32-bit accesses to 64-bit registers
Date:   Wed, 31 May 2023 20:01:40 -0700
Message-Id: <20230601030144.3458136-2-ilkka@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS0PR01MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 56bb456c-3631-4136-1eac-08db624ca4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYPgT22EGskChulGFVJfg4vHD09J/umnJfQJWrmp2a7F3wt0Nso7yzlkwiG1U48rCeyNFwnDyKrKoz+9MW6PFf9+EIZex8wigcARKxZdpkj4D0SsS32+GMhNYKKYR9YIulNVx7HMplVMFWQTw3H031b44Hxi8+M6L3O18Vx46A+SqVtk3tGdR7jMa55Yku36+Ig8qBhmmbC/0tC6P0QL3p0UBsN9FVTlDMJWRKrHrZ78NicxHv6FtCEQCipCKofxBet+N9zSEWXlS8PVuCGrz66LiWEXq2UzxzQbvVyMP47qZFZy9ukFC/qJyc5OZKlt9oJR5PHDJc1ktOJO7GlM5lHT/K0cgRs+BoQizTxw5zX6IzK1GiT+HriB0gXlhNgpeMGZfaTVeBXz6ZQEDRXr2IjUFqNhB5s+p8rgaBhwiK0iT4pZl+n0lrcDV6xErFLNqeVteUcOnngxp0uQBIrp9RMu/c9Iuuxv2eB+0JXp3dN1wUEsA7mC1fgq7uAPYaeVSNlssvOqp0wRliJamdhvh715X17oxDvlogJjB4OoSVEMVIWZaSwgNlRFddbGE4BTQDNKNSVsUO1oBxoPFvAc6hnyBmmp+QG1zibTqjXXvM2wS2A4CLI0M+bT5/8nyykH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(83380400001)(2616005)(2906002)(86362001)(38100700002)(38350700002)(6666004)(41300700001)(316002)(6486002)(52116002)(5660300002)(8936002)(8676002)(478600001)(110136005)(4326008)(66476007)(66556008)(66946007)(26005)(186003)(1076003)(6506007)(6512007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYs8zG9bfcScvMnwEJCOAOXXLx/tc1SFvdNIPsNPlmjxltWE0gMKsvKnZXRD?=
 =?us-ascii?Q?HZT3aN+XTAmZDq/6MtayVH+HdTyt0M6zpXXYuwqv5AEKOMVpbN7g8FP8N9kW?=
 =?us-ascii?Q?zrDLMBIp82ubrVbV5AC6iMgUcoHYmvSey7ANY0MDaXjHTwKygIH18FGw7a1b?=
 =?us-ascii?Q?l6cB+c8abSdYoLtQQ2f2PuVx7hAQuVH4nmJDKoWvcfvAJ5Ds3BMvR++il4IR?=
 =?us-ascii?Q?iuvo2LYIIH5LAk8IWNEwQtvqnP5+s8fLM9y2hHSueP21H5S8t/2IigQZA/en?=
 =?us-ascii?Q?24QKA5nMB1eBDlIFnkqZUuCr919NLoghhSuNINnz3CRU9Vu0hHC7tiMXRx24?=
 =?us-ascii?Q?KivXi/XLc9/aIZTxYIBET1NOBEJY/Xsmt2PVNA7U0/7jOi+Ogg5Z8JIAf5a3?=
 =?us-ascii?Q?HG6h5tNoKZlDEz/KdCpdtTAyLUgINoVO38dBlntMSPhkJAuN67GMZI2v6jqh?=
 =?us-ascii?Q?hhBjFjhsPiCeu45c6g1n79/+90Xfq/PNUlGqqhJdz7E7aYFP1FNMUWvq7NQ9?=
 =?us-ascii?Q?OosroiiuXqAUxWlKjDSd1K0cx29CrLtvu3x8KHo3q4jUTm+lCTS4h+Vw1B/c?=
 =?us-ascii?Q?BIFAxlG7OXqmSNIjOXrSeeTs/9+kJtYaXyArb5b9kBxH9rELyTLjcl2dSp7/?=
 =?us-ascii?Q?5qxEA97Y5j6JvE9eYYvK5C3t6LhbmPnSmqWbHXIYPaugeMt2HpVxyjsED7aj?=
 =?us-ascii?Q?+xQnht/0tsq8MHma50XdeoHTRtUJtyvlJ0Ltda4+MzeAZr47fbgxzx+rMKj7?=
 =?us-ascii?Q?Sf5Q8NzM22YWmVNFMRTUlIVqUhiApipG2b/240Pg6NUOQF+Dbd3hcaaRX33Y?=
 =?us-ascii?Q?j9EOOeZraXsQCUIkU1uqWcgi1C/3Rww29AqivGWw6KdRGCLp4AQtg13uFRes?=
 =?us-ascii?Q?SqkcW3gd8LrFH8pXvyjsmPPbhnIyOCcxI7dW03PHIE3W+2e4SWXtNT2eLFdr?=
 =?us-ascii?Q?ov2iDMjHfetM1A2j3Vs50LAER1ocbDIdNvSB8XGkUKfKEXKKNP5IRbXFJw3e?=
 =?us-ascii?Q?XTm5adFoz6dPh9CVnHcbcwDpvuCtGyAIhZvDbe9IoD0RoIPdpbbm5O0avqc3?=
 =?us-ascii?Q?sBI+lKS/e95MwjgGBTQqJe4vac0e9n2KA9xES+KfQxZK2TyGIK9i2XZs9jDz?=
 =?us-ascii?Q?00ot3edt7Quj+Ig1CbNLzxYkgVqS9UVaEAvbnHm3Vha7eX351KItYFLRzopQ?=
 =?us-ascii?Q?+1JDbLdAtowFaOBopx/4W2fflM4u3XOCv+1GL7YyEDNYbhR22GiWaNfsQSSg?=
 =?us-ascii?Q?jpAYzBxlDTgkABeDuCXE4dVFf3kY96hB3gU1kZgSe6qipx6Fsq0BjTtiCxlz?=
 =?us-ascii?Q?pqPITS9o9fOR/yfIps/wTvvTXhFgyW2LjYJ3rOmt85sxleBCzhsax7/NodWC?=
 =?us-ascii?Q?YvO3WThIiJHbEgGTQt7y83YXID4hEDznaEDkDzsnAVBz9BgmTUMR/1iQJDk7?=
 =?us-ascii?Q?FUGOvSIxinnkX/rk0sSFBoihaEVMy9D9AK4u6mGSz3Ei15lBFFSgPv/WE88e?=
 =?us-ascii?Q?nYS7LS3eE+9jFrjwXqleFF9BuxI3tHmdSMYYHo7U3TPXQn8LzNXGeOknSvfo?=
 =?us-ascii?Q?nnWlXR/jZpX01QleLLBH0jvK7Pk9NRb4VzhkX2BLmbqtQmRzexldTTUPRxdI?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bb456c-3631-4136-1eac-08db624ca4ec
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:02:32.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y3r91/TSssIMKcQT4H8AtshXYac4n6mjOsbB7hH4Uu1C6RLaEWaoCT76CUIHSSkIMLU8DADeERq0QxwwdzzEcz6dQ01ljm22MVAtNeIATY2aZGFdmlEFuZntW8XR15n5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB7889
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the 64-bit register accesses if 64-bit access is not supported
by the PMU.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index a3f1c410b417..88547a2b73e6 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -701,8 +701,12 @@ static void arm_cspmu_write_counter(struct perf_event *event, u64 val)
 
 	if (use_64b_counter_reg(cspmu)) {
 		offset = counter_offset(sizeof(u64), event->hw.idx);
-
-		writeq(val, cspmu->base1 + offset);
+		if (!cspmu->impl.split_64bit_access) {
+			writeq(val, cspmu->base1 + offset);
+		} else {
+			writel(lower_32_bits(val), cspmu->base1 + offset);
+			writel(upper_32_bits(val), cspmu->base1 + offset + 4);
+		}
 	} else {
 		offset = counter_offset(sizeof(u32), event->hw.idx);
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..c0412cf2bd97 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -110,6 +110,7 @@ struct arm_cspmu_impl_ops {
 /* Vendor/implementer descriptor. */
 struct arm_cspmu_impl {
 	u32 pmiidr;
+	bool split_64bit_access;
 	struct arm_cspmu_impl_ops ops;
 	void *ctx;
 };
-- 
2.40.1

