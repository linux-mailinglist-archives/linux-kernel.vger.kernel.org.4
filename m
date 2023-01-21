Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428EB6762F3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAUCLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjAUCLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:11:53 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2100.outbound.protection.outlook.com [40.107.94.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50171F20
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:11:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hgx/ffxk8a/ASJynFJiDdp0vswjgw3HTWIBu/nhcoG9SyIXXzjm+a2bGaNhH4liQeUT4nEhlI++EK0zidHVU2qBznxoB7YjuDArX6IS/paXbf7m3vaoO8YlkzKAvYIz0LFkTivq8DMO54hHzgRuj8j8Sy53q61A4D4pc+7AfrhZxoC2rnPI1+R2vz4ssliecSw2hzirhfxBQHDUwoU8gLt/8jPZZTssXEiNjlB3pVOsomy2eabc3VWl53H2cUhUkyx9bnyLCJtAGnduqey725M0Q4uP/+PnqMzZ5tofNMSGIuMTFWN2O1uAhz+eda1kgTa9L4BN2PbAiMplaRJ2mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hsuTKHjsRniShAlfhx1Rzupn36hIMVLkma3EcUDWwo=;
 b=A/axhvSACVBOcS8BoZ6ljxejksuwdS0RdpapaCkMR5OpQhb2Io0IcLF66q+Jhe5Rks4oIMQYluTSXYkNUF7SwH8wQWV4c97ICWQ6/3qgCUnUkpaxNzUGAi3gKhCw9UcX5LnZ6EzGprNTxrlizIwivp9fCy2Ut2y+0db8EAfJ92Ig7oHanlleW2gO7r+FzruWK3TtdwVfv3275DwNI5bUjBTEVsM3bIzFMUatoROQvQsFQb3ssnN1wHnjt1o2kbKG59nRJTHh386Kp51WB822DLi9DGXPhJNs5LKfvOHH2AmTz1xuPedyJ0AoGpqwXJOgLxRKkH+xXKgArufs9iSr/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hsuTKHjsRniShAlfhx1Rzupn36hIMVLkma3EcUDWwo=;
 b=mYu4256iLxwwmJscje49LHidoEyqipwsUCjjCOCsCGssCxfjtETTULoU7NBMFqOhmAwFJ7IeUiSu5H283x9o/a1yQDwA0qgWTaIssLIrdBLWLhJHl2cZQzx1c55NxzJRB93Aa1DpP4hp8yLOPV6dt0DLo2k9QQ+Pi7BmQHo1qoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 LV2PR01MB7837.prod.exchangelabs.com (2603:10b6:408:171::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.24; Sat, 21 Jan 2023 02:11:06 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a307:bac5:2136:d4e5]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::a307:bac5:2136:d4e5%7]) with mapi id 15.20.6002.013; Sat, 21 Jan 2023
 02:11:06 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     ilkka@os.amperecomputing.com, will@kernel.org,
        mark.rutland@arm.com, robin.murphy@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: [PATCH] perf/arm-cmn: Check all the DTCs when reading global counters
Date:   Fri, 20 Jan 2023 18:10:45 -0800
Message-Id: <20230121021045.47595-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:610:e5::10) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|LV2PR01MB7837:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c8e893-af99-4423-3ecc-08dafb54c054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc4Q/w5CdQrZFF8D6lgsZWk1xf4WCMPNK48MOZXRqufKVxHDJsg+nYNWaugOxJKE+8LwgFeKnENirnecwqBaErejcAbFDuiIiXEVBuaVNdSNA+WXZWDhYmdFty6buvr/KiQyWQxIh5SKPsSCgWnsODcK4zuwR/5bq2BlzoNF+PSFoNcgDFDXH9FZ/0Msfg+GaEu+GiCKRLVhvHQlNI+PHC6SIXdIGn2qT4ATck1Gek5K/iDx0xeTcXut78prBV69HrtrbTSAPQVDfzTZYQitUS9n5QJS/Fz/ZmD/K5piMUv+GnEca2BSzym+MeKSlNvoBu4ue027NyROqQWNzKneE+Wkg/H4iugsOUwI9gjLgepiDuRc1kBFVOAVISQbgtDfDSXy94THX4EPyFfth6htL03ATNZahnUDVLfBOgdMk00O9Gvp0MaA4ez/J0Jj7fyZ4LoppYAAOhGwau/ixlAGn0Dg7WYdG2DGnwQytg2LXs6SZcIVQoWM+j+6xWYCiIs6/37FHH+gxsJXasi+Y1rjEPwKx7+bO27LuzlJa8tWOiCA7OlDJqrdpe2+jREJaJ8WMu19KEwQxqiyUVrJnu15x6i8cpfZJZi6a0Z3cq+luepL3pYqb6ungKgcsd2X1OfaO+MRdnluCDeJIlXzIgUTWcOoncxD8e2fnpyWUvKEWTCCTIS6oseWjzf4XWYRyeIiqfPzgoUjJ2hbcdGL2aMynw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(451199015)(6506007)(86362001)(6666004)(2906002)(66946007)(66476007)(8936002)(5660300002)(38100700002)(66556008)(38350700002)(316002)(6486002)(4326008)(107886003)(478600001)(83380400001)(41300700001)(26005)(52116002)(6512007)(8676002)(186003)(1076003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3zhV8mqB6M88/xrgq24FEfwdl2ZCKDTAYj5nSIEpWR/xRJxp9UcWhHzTmr2?=
 =?us-ascii?Q?+d4ZfbuZFL38dVwGpaKgDij1wlVOtK1x/hLsdzE8QLpniCJEb5TRgzJg2ev7?=
 =?us-ascii?Q?EalEJr/yb7B/NEXpiH7/u19V7yIdKeMJBWj7XtpnjE67Sn7eGfEPN5t4HMTq?=
 =?us-ascii?Q?/a9e5SQQupni411JrUJoRTs1CKD9ScRPWLr568CTZBpemnkNJfOSjHPIpIJD?=
 =?us-ascii?Q?gHsk4svOY2YyclbiN1mv2D9lxOLwQiIlRerVzf3PBOurHpHBv8zUg5cs83IC?=
 =?us-ascii?Q?thfOYbLVIMBZcgpKxNHalx2MZazZV3ME3f36Q5HXZOyrrmeow4UJedMlGb0I?=
 =?us-ascii?Q?H7MaBadaXOcaObs8uODk5Zdpa3kLKC1U1MbjXzGQ6r3nW4q6WXQJ5LHkneIf?=
 =?us-ascii?Q?8Z1Z3uMIA9S8KVfUkwHEoPzsQL+Jh1x6OzDiG7IS+pyycrErNzWT6RrqNS95?=
 =?us-ascii?Q?tQUIzldQ8a01oZ0HhmOfo4hGebYYSKAqAQvKcUI7yCiCQyU+be2SVYgY0BMf?=
 =?us-ascii?Q?YAVWC7ErpF9ak03tD8wOaaEG5Fw9T4grjWmU/trD7OPPW5rz4xAVmWnzXgTp?=
 =?us-ascii?Q?jX+qkeBWRlfOIvyHhpxFmImB9S/8ylHtXniSJLisu2xD+KsnKTgw6DdBAeRh?=
 =?us-ascii?Q?OCOH4pIKfqAj/W0Kod86L19dWDyd14ZyC8uKHc56RFd/Wy/tXIvYoQJSAnoR?=
 =?us-ascii?Q?0vj3OrrfwmS+tlM12ULR9t31t86TWMZYPN20Ik0d4O5iBtVk6tH4mPbwTX+4?=
 =?us-ascii?Q?AeBm7cZSIXjZ3tKkAS9snDDREbvwf0NU/NmiQ5P2DbJpg/8VsJxU9LcYIhcb?=
 =?us-ascii?Q?SrRA+SvA4eXKqSA15/7nwDnAjXxrLTv0CPFWMd/qQv5/nFuFvdwNm+WY+3Wv?=
 =?us-ascii?Q?aVPhxCyLuta2C3/GBclyMOMA9qQYjliKursRsKat0EtHC8PQ7aPw2qP+DLOK?=
 =?us-ascii?Q?R7lG9EveKe8qarLvIs5Qq7k05/VOy1T2HrvYdcai8y0oqOgc/6asSxH8BbEE?=
 =?us-ascii?Q?JRdiy8mFmQ70bDoHMpcnplCkH6NiBrcRZCoIdhIDuOl1z1o+SMX4Oytpz4+A?=
 =?us-ascii?Q?AQl9QfL2Teog1Nl1JhObcLEwmWMxCZZ2F4U3t1BEuP6kfxIs84p9U00PDjbH?=
 =?us-ascii?Q?fEWq9HtzKkT1BJqLNjTUpXlctKoNSX+ohON2Y3boDm0n35O/LAjQa0Mz+2It?=
 =?us-ascii?Q?MdhrejE3smSysSDdXMT4KOvIzZsDts9lB+5sgWExvUMVAr8IDmZkRpWr/SfQ?=
 =?us-ascii?Q?012ql1IzTw1+s3WfH9hmV9qBGyo1qacY0ZXwKXV7AqNGNKFA4zQq7eSgytdi?=
 =?us-ascii?Q?wkeuj2fzhFTqOhL47C+MqHiqO1Tn0rhMhiUb6RIRtX3PCLNawiF55F6gqF1i?=
 =?us-ascii?Q?9yKozr/wPSzSfVoscD8QbMfrzvKsp2rFLUajbfpgQy7RGLSKPJ8vInYrEoEI?=
 =?us-ascii?Q?Aru+IfbtPh6ckfqO3uqyxcSp5kfKFZ1aJ00M7GOIwh0E9bUfcU3yf/lTLh5L?=
 =?us-ascii?Q?TYnDTdPvX5gWNBT8Cxy1eQdSFBHMKsJphbCHgG6pApNBUZoHUfSppRosVfWx?=
 =?us-ascii?Q?dFJTwmYfctPf8AVpwPrVV+/E9XAFqaqgbFyqm8URqirYz+sLMCnoRjyMuwGt?=
 =?us-ascii?Q?1SAfrxGSm2ZdkmsWfvKPzYg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c8e893-af99-4423-3ecc-08dafb54c054
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 02:11:06.0635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2yyshhThKMG21Bb+TPxWmRc2l4FCoJ2ZtjBLz4hW1EpDMsTKMrMLNzxVbAeiCrn8UBUoC0BoAyo9cQQazfM8GqspogLi1Hd/sNJNGEOZVA1V91bxHooiWewRIvvXPic
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7837
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some events may be available on nodes, none of which belongs to DTC0.
When the driver reads the global counters, it stops as soon as it finds a
DTC that's not being used and, thus, ignores the rest. As the driver
doesn't read the paired global counters, overflowing local counters are
regarded as overflowing global counters (assuming the new local counter
value is smaller than the previous one) and therefore we can see values
around 2^64. Fix the issue by checking all the used DTCs.

The driver is still trying to find a counter that's available on all the
DTCs rather than doing per-DTC allocation of global counters. We may
need to change it in the future, if needed.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index b80a9b74662b..c516f091a002 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -540,7 +540,7 @@ struct arm_cmn_hw_event {
 	struct arm_cmn_node *dn;
 	u64 dtm_idx[4];
 	unsigned int dtc_idx;
-	u8 dtcs_used;
+	unsigned long dtcs_used;
 	u8 num_dns;
 	u8 dtm_offset;
 	bool wide_sel;
@@ -550,6 +550,9 @@ struct arm_cmn_hw_event {
 #define for_each_hw_dn(hw, dn, i) \
 	for (i = 0, dn = hw->dn; i < hw->num_dns; i++, dn++)
 
+#define for_each_used_dtc(hw, cmn, i) \
+	for_each_set_bit(i, &(hw)->dtcs_used, (cmn)->num_dtcs)
+
 static struct arm_cmn_hw_event *to_cmn_hw(struct perf_event *event)
 {
 	BUILD_BUG_ON(sizeof(struct arm_cmn_hw_event) > offsetof(struct hw_perf_event, target));
@@ -1272,7 +1275,7 @@ static void arm_cmn_init_counter(struct perf_event *event)
 	unsigned int i, pmevcnt = CMN_DT_PMEVCNT(hw->dtc_idx);
 	u64 count;
 
-	for (i = 0; hw->dtcs_used & (1U << i); i++) {
+	for_each_used_dtc(hw, cmn, i) {
 		writel_relaxed(CMN_COUNTER_INIT, cmn->dtc[i].base + pmevcnt);
 		cmn->dtc[i].counters[hw->dtc_idx] = event;
 	}
@@ -1301,7 +1304,7 @@ static void arm_cmn_event_read(struct perf_event *event)
 	delta = new - prev;
 
 	local_irq_save(flags);
-	for (i = 0; hw->dtcs_used & (1U << i); i++) {
+	for_each_used_dtc(hw, cmn, i) {
 		new = arm_cmn_read_counter(cmn->dtc + i, hw->dtc_idx);
 		delta += new << 16;
 	}
@@ -1614,10 +1617,32 @@ static void arm_cmn_event_clear(struct arm_cmn *cmn, struct perf_event *event,
 	}
 	memset(hw->dtm_idx, 0, sizeof(hw->dtm_idx));
 
-	for (i = 0; hw->dtcs_used & (1U << i); i++)
+	for_each_used_dtc(hw, cmn, i)
 		cmn->dtc[i].counters[hw->dtc_idx] = NULL;
 }
 
+static int arm_cmn_get_global_counter(struct arm_cmn *cmn,
+				      struct arm_cmn_hw_event *hw)
+{
+	int dtc_idx, i;
+	bool available;
+
+	for (dtc_idx = 0; dtc_idx < CMN_DT_NUM_COUNTERS; dtc_idx++) {
+		available = true;
+		for_each_used_dtc(hw, cmn, i) {
+			if (cmn->dtc[i].counters[dtc_idx]) {
+				available = false;
+				break;
+			}
+		}
+
+		if (available)
+			return dtc_idx;
+	}
+
+	return -ENOSPC;
+}
+
 static int arm_cmn_event_add(struct perf_event *event, int flags)
 {
 	struct arm_cmn *cmn = to_cmn(event->pmu);
@@ -1642,11 +1667,9 @@ static int arm_cmn_event_add(struct perf_event *event, int flags)
 		return 0;
 	}
 
-	/* Grab a free global counter first... */
-	dtc_idx = 0;
-	while (dtc->counters[dtc_idx])
-		if (++dtc_idx == CMN_DT_NUM_COUNTERS)
-			return -ENOSPC;
+	dtc_idx = arm_cmn_get_global_counter(cmn, hw);
+	if (dtc_idx < 0)
+		return dtc_idx;
 
 	hw->dtc_idx = dtc_idx;
 
-- 
2.17.1

