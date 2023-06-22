Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570AD739450
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFVBMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjFVBMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:12:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2092.outbound.protection.outlook.com [40.107.92.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB551BEA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 18:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvT84yydpXI6FjX1/bCSC8vhLO/uKVQ5kuP+ti1hng/SGUm855FIc/Chbas9u292e8gUorcpRfAZSPdjn9VeVDkOVYwxIjPJdjJRfT2TVRQ5dMzyNZf+6etoXZPodj3+F9rRAUsPvNjGjAZb40xBbiabFjXRTuskcA1DgRl9ypOR9zRrqKZ1iPehT5ZFzMcstVt8KlbQtO0wa9V3MNS4IjCYykL+doPKGEe1XtTON8yi8GMwUOrz3BwbdZ8wAwkb3dDaV0h6Yta7xuGFBxENqw4T10sIqiwh2OAPyejgfqKtKx0a1DzlZuFu5bHmuL07ieB/e+6B1brkvJQ9MOab4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1Np9axgFb3diOIO8yZgWlgDmY3jjcwVHh+rWeAvk3s=;
 b=CQUffigQLuCmFmJ5jIIWBOp01zQL2hrVtnMVwiqG4k12Lz4LUHisQwDm8oXYzH5KcERIOFz4WUpmaddv23w88RSQYQ0flAf1HnW2aW+sqYLsd5aGmoPf5GJPqQcZxpwUfQUQ/Ef46Zz+rVY2QWpZjNsPDOPtW4rJD3BPx1uLGdE5ZfhpsPAA8hencd7rJEtN4uWH04LDDgSQIggHq9slM0LB1K0lMJyV78gZph0aZfNtV/vnbDdk4DgwtOYsa/7DfqyNR/sW/kMhT1hTveH+NWAE0R3S38A14MwIYdSZ3sXtI11VgwetAcLuPqv0q+O1CS5h3R44CWLweDmaJ2acMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Np9axgFb3diOIO8yZgWlgDmY3jjcwVHh+rWeAvk3s=;
 b=Y1bXb8Qfv6xSh5yrH92rmEx9/4SZDucnnVJoHFHUlBLrh4lOpqF3OxrCfmde66+4u4BCfqZTYufkVKntprJUnScylLbRomIXyl9i+7lJyfuv6bx3h59P5kZIaQfx3CIxRcPNNnyfQMQeNowIKg6F+XNJBXnYoCQYuEwt9d8lA90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.21; Thu, 22 Jun 2023 01:12:36 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a323:29a7:2fd7:621%4]) with mapi id 15.20.6500.036; Thu, 22 Jun 2023
 01:12:36 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] perf: arm_cspmu: Support implementation specific validation
Date:   Wed, 21 Jun 2023 18:11:40 -0700
Message-Id: <20230622011141.328029-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:610:b1::22) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DS7PR01MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d710fb-c0aa-450b-8c29-08db72bdc404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HeKi/zMF7y0QTVMmtGnfVgXkbnupKL73vwe9dqVoAWvAsBv+fveHiFDxDW3F8gSTDb6Zch5Kd0WzMFxyYgusnkXyo1O9EUM60zRnaQaE1U/ijSd792acEyPK7LtEhN8JdV3b7WPgOiyobVpM+XuCFmuKLoVKaZPiJjajdnQKros7K+f0oDWGtOs/qiEXFllwIyX5R0Gxlj1lgol5HwTCIKdGPLeosP69Ew/FGsLe6nyxeQSkOSg+8Uvb0U3vnkshgkKrhRJYFcJEf4LALEoH78rg/gditgLDE07axzokpZfIjwG4BCdLZRCXnsP1qmtyDwGNt7o7bsW5p4Sh1Wq7RCida+d/s7R+2R1YAYI0DLnDKWg/8Bjoii0bxD2u9xM6KAvLh9X04zXHY6/MCoe/Dl9woq94QbpTb6tqI63e3ldOH4cBtnm9l1BOPlUlC/q85De219EExXhdnt4adkPZ1zbevmOKw2ecM3Mug4M1yIzse0LFJCHaz+DqDvh8UR4EVc/Rz1qVy2tY+Kym1Y9SjTJu71Bu4YFIb0oFYSnxA1FHsh5Ti7AGlQplHFFBfP9Oe/fXDUpjwmvAgnDwMFcjWMFF0oRM7rLD4aFvp/LOKhBuMq12GEpAhgmYXxoJHZcl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39850400004)(346002)(136003)(366004)(396003)(451199021)(8936002)(41300700001)(186003)(8676002)(26005)(1076003)(6506007)(2906002)(6512007)(86362001)(110136005)(66476007)(66556008)(4326008)(66946007)(6486002)(6666004)(316002)(38350700002)(38100700002)(478600001)(52116002)(2616005)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EBLSFT27DV2Zes68rL0GL3RYrznhxz8rFs8QzKbnKiUF28EdWrIm01AbsiZg?=
 =?us-ascii?Q?sk3IzEoHehl/8Tis8788m7sDGRi0RpdN5BsVbDSDGxeFQpIgdOtn8TcmBXFj?=
 =?us-ascii?Q?5sq7pIfItFGjKf1YdH+5RFQWVvMz6astFBOT+lwvBuSPc7Lz6vWNS6uLuxYA?=
 =?us-ascii?Q?oHcD+YUyWnSpp+/Peoi+R/ZiBcvHSvDwGe7IykSdkW6HgFdFHy/KDDJNwjQN?=
 =?us-ascii?Q?IkXxgsf42QZGx9D35LqKQF4nSDkjuXNBXEOYIJIolEU16CStXvID4uRMf4wP?=
 =?us-ascii?Q?JjqNMnl+kwG3ULgtEu8zz+7lw08COYjD2+gLaktExlmVN4Vtr7QJR2Ap5u6Q?=
 =?us-ascii?Q?UQo6BuyW/Uav8FX+AnGib7Dia0KGNJO36JrS944hX7aubXfSZhQls3DJ7XdI?=
 =?us-ascii?Q?1cVYWffrK0X/t+cJxrc0TiRYm7nLQ1ZrnNrTFe/uNGTLJk/Kzw87EZLfYwtA?=
 =?us-ascii?Q?/lMfFeEj0sX+4VcLNLH8aCD8KyCXSCZHUeiorz8UbZOos3EsV3tWuKSnmvmn?=
 =?us-ascii?Q?82//dT0NWUePr/rYTXECuqtxWzMPuZNztgfqz7HsLtCD4B8YwOlEAEoLTN+Z?=
 =?us-ascii?Q?K1sNMDJaRMHuxPw/W+ZuB5kCKFfc0XfTKh3irdI65XHHXzhLZE2VTx4xAL5D?=
 =?us-ascii?Q?NWA8MTsKhbJ8LkAwpCuljFULOHI/HoWZP/+ukbMl9wjzhQ40H+85sWq5nzvV?=
 =?us-ascii?Q?hZMm1HtkepPcYdQp85C478Ps7DnzOwp3XYZLx/zKGhd7wamh6L5YslIjkQKa?=
 =?us-ascii?Q?XKL418rKNf+dNDsc/2La1Fn4s9CXPSRLv3yRInbvPhM0wJDv7UCjjRPOz/bt?=
 =?us-ascii?Q?6SsLPMOH9Y3tHxLA7Vasy5aJ6Ci+gCh/eW1OawNs7NIaXuEjUKhnBXSzdyzr?=
 =?us-ascii?Q?fH30IG/VfPsJY3tBjkHCpoePIVp1+s4Mu3KaEczMR0bCoTORSpt2pn3eQKJD?=
 =?us-ascii?Q?L8M9+8ORfU2XoScVoeAlWzKgxsx/txdlO0kucEOru6xwEMWaRKHuUZaqIEZo?=
 =?us-ascii?Q?kVcDJY+qkdVFJyVNnP8SuFernLFtEz2fJb1n+FwSMl7kcN+ELWiW4f6Fw8kT?=
 =?us-ascii?Q?3nPM0EiSysAm2SrrKKzey2mUh6LJb6OShC0S52tUPK2dx8cUiIRfuBn+nN4l?=
 =?us-ascii?Q?nFLFXYXIiL9TmH8B3VaIFsEo68TXyFP7Qe2rlU0RCUX/HI2isAk21XB5ks1Y?=
 =?us-ascii?Q?7iqwMyDT/Xr3aIeGHbHm+xsR5/j/njf1zFjgIoxHNSp8f+RoWgRJ9GSenM7d?=
 =?us-ascii?Q?yDNcdT/rbfMxhVzZrerGpYias39RKNSJN7iC4EYARlJSylcZ4Ye6qJ2KSnHg?=
 =?us-ascii?Q?CBNc1yGlWZL3ySxDNNUgfOt+fQcdqeKEPmf6kliYo7Ng6dLUoVPU50fZWido?=
 =?us-ascii?Q?7Pezz/rlGPM1hcYbCiE6biPX+iI0UwEgHxw9NDCEYt4LhW7E6zw9XMf8C9an?=
 =?us-ascii?Q?IVyP88VqhPMPzfnrOi0Mqp4s9v5lg5s11NrZgSh0alZDKeL3jvZUCEdei2Az?=
 =?us-ascii?Q?z3dWmB8Zzd9dbuQZEuLh6KsfUENk3BDfKgMYK1IpI5UyGwV7f7MdE67yoydn?=
 =?us-ascii?Q?ylXXgkMCIGw6DeLGkDCtY9adjdzvOkr9rl/12FCLaKL0wNki1I2+zkAMYORE?=
 =?us-ascii?Q?X/o9imAgjAKH1bHjdUXzhw0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d710fb-c0aa-450b-8c29-08db72bdc404
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 01:12:36.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlKnYQeJQOZySLBJqrVe5XPQZ39uYyfPnUfhVhEXTYF7oKeX0ThA9ah+0vqxf0XuetNrRvNeh0BTUaBKbhXGozwP3Q1fu6KZRWTpDI3uVx6VvYJGpTo+FNCTZulI6otR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7805
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms may use e.g. different filtering mechanism and, thus,
may need different way to validate the events and group.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index fafd734c3218..471d6d7ac81a 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -553,7 +553,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
 static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 				struct perf_event *event)
 {
-	int idx;
+	int idx, ret;
 	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
 
 	if (supports_cycle_counter(cspmu)) {
@@ -587,6 +587,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
 	if (idx >= cspmu->num_logical_ctrs)
 		return -EAGAIN;
 
+	if (cspmu->impl.ops.validate_event) {
+		ret = cspmu->impl.ops.validate_event(cspmu, event);
+		if (ret)
+			return ret;
+	}
+
 	set_bit(idx, hw_events->used_ctrs);
 
 	return idx;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index d6d88c246a23..5070d34c2285 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -104,6 +104,9 @@ struct arm_cspmu_impl_ops {
 	/* Set event filter */
 	void (*set_ev_filter)(struct arm_cspmu *cspmu,
 			      struct hw_perf_event *hwc, u32 filter);
+	/* Implementation specific event validation */
+	int (*validate_event)(struct arm_cspmu *cspmu,
+			      struct perf_event *event);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

