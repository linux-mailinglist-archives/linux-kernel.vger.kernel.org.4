Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E737A74826A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGEKo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGEKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:44:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F7710E2;
        Wed,  5 Jul 2023 03:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0uWuHWY15ZZpX/2mcaOfFbA01Dq6oa0Mukyxwvum4Gvzz3+7JWrIGXVmBRiguferjfp0sLfEjno/9+FNWIXPm/mr6X9Yr02ZNY6BUlexq7qBF1FW/xoTm5DtOOD98vOhjgEGVg8UwyuhkhD3tM2lZeAoHyY7l/Cd5z4Fli54Sq4P1njVdhIdi6Y9CWdR3VpavhH+7GCEvZFkRyfUFWEaYH6OxgU6mhpJo7OCwgdAuHP+1wfVksO6r2P/iS5IAqBmvS8wa1RIHAptlp62kPvkyMWhSJDBgZiVGU2CVuJCyEbabJ+wKlWNJbQ3MiFYrshmrlJ8n8pdzPg+BtonnAptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S/P45oboQINAOfQiR6wVqrvX/Lkqn1Qt+9oFesH5U4=;
 b=DU7UKTQwcXeQqYxyqH19qG/p8lbyd+YM4qYUT8QAaw1+2q9zLcFT+/y/lCbPEQxOJxAuM6BQrdG4C18pZ/7MfmtPtj3e7UXreshjgBmiycoNcgzdSPnIbOsNkHee5/SDcJ4ApL88bpNL503Rk1IlVQNTY34bN2wZaGxx97rW5I4yUR3JUFkWHWyhqco8pss+IcAfN9131I3BWimcRTDNCP9VXh4ZVXbcF1zk0xrimdzwkOsG07sXE5Gol9tQ2B4qp5w7LEXVrklYDqARGHogwHyOOCY9IuW9QwguPshYJuo2O6iQe3siqsyh71i8bgvGpt0OxHccqmX3JtMZFaTc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S/P45oboQINAOfQiR6wVqrvX/Lkqn1Qt+9oFesH5U4=;
 b=mBN+Yt2/ex/wIEOtG5SRfOQE4RszUCIB4e0/D+A5PH/DTVVIeY5a5xmLlTEiQdpo8J0NWMl0csSZZfbo8RX6MwXgJhin7JSjthBO1FmPecNWbPAZP/5tOPYyscoOMdwSTzzOVbAwHQQibf3zwe1gJ0pcauzz+RXdnPZVgJtlvL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB7658.eurprd04.prod.outlook.com (2603:10a6:10:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 10:44:43 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%6]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 10:44:43 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: mscc: ocelot: fix oversize frame dropping for preemptible TCs
Date:   Wed,  5 Jul 2023 13:44:22 +0300
Message-Id: <20230705104422.49025-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705104422.49025-1-vladimir.oltean@nxp.com>
References: <20230705104422.49025-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0066.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::9) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3895ad-6a93-4458-a980-08db7d44d769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnO4cYYxHZpCmzjwwT7eOjxX16STFyUq7+X/WzpdzE79kbWjBW3R9KC/5Tli4rD6ucDa+c16k37LXgAl4kDlqiccUQ1YazS3/mB+ZZGr1Y4G64AGrongQ7GWuSg/fQSU3Jr/UwCPTkZfJjCUw8SBPsauoC1ZQJw+x5qa2pa+wepf+ud9EkGOzsCFvgBck0ufZQwTIni7j17x9Zd1wjXjsocsHGh/o+UspXo3T7/7HFUaH1Q6RTimVw3IKfur6aho8SZZUCejUwF2SxKuJqgN3XqlQoMCgX/FLd7MHFLxwv8q/hGHaJvxDflChSlrylp7FUBDRC23D3qTI4xbBdmhgXQF5c39cmcUc4bYMyiT5dfVzhOLvZ4HuaHxjCOEubq8+yjFM8Kef9DekB1PH57mM262pvrvWJ8pr4MnNFybTP972cLq6yAUIry3ixOCOl2X4DMIxvb0fR8PPTQb3+UgadDfCWFQcMHnR8MtlustSOdBhOIQPBsXFGdAq5Hm7sPueo6Ar2fTwpFyZ8AKmtZHpPxvyDodmf8kgM2eXqoC+k0Cn/GhQy89jTgdZ4QkL3yJefchrVbcrGZmRnRczv31AtmdYh91h3Akd7RbiXHcHjpWefnnz6pA1YPuaGLvvTrK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199021)(41300700001)(478600001)(6512007)(54906003)(86362001)(52116002)(38350700002)(38100700002)(6666004)(6486002)(4326008)(36756003)(316002)(83380400001)(6916009)(66946007)(66556008)(66476007)(2906002)(8936002)(8676002)(2616005)(5660300002)(186003)(7416002)(44832011)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bozBtAznxQavjlYlTIx4njmLTwTMKAvCCSJFLFwprUjgvTFN/sNJ+B06t65+?=
 =?us-ascii?Q?HZpTzSeDQmXv474SfmtGpPrfE20WPKaBO0tGLfVvOfWUkaJMGKGYaNbKDThh?=
 =?us-ascii?Q?5m95+WTw5u3V802vzNxqrwuAOa2u8vmNME9cN6Rjfsl5r387oHRLhIR1srRw?=
 =?us-ascii?Q?M7scsTKElAZgqL5uIAljjJJfDAdVGx+76nJB9dDUnzuFYjQ5hAJQBUg8CokZ?=
 =?us-ascii?Q?s170lj6slsKCufN+4Utevf4ItTsDulrnbdLnAhJ0qOTvRzCjNmu47Ky0f+Nu?=
 =?us-ascii?Q?j2I7HasZ6xxtvYjGlfziT8dAOtOqrRvbS2RDSM8qqmZfEuZtFZ3QnQnWx9f+?=
 =?us-ascii?Q?SyNalDhHUmcRGZ+uAIxUrRik+U5NI3eN9lEozVo5MPpb16LTbSZzMSxpE/3O?=
 =?us-ascii?Q?OAqHgG9wrq0cfFWlORjPZN5bWlWyupWMZsgAkMnvjR1G7yluZzYTzBviUr/t?=
 =?us-ascii?Q?cQi3aOwpM/9jh9dSIjrLoKFVCOJ8VAPRxPWRCRMyYmDdnreKS/K+M9CeEZmz?=
 =?us-ascii?Q?7odY9Al3RBtSoAcHAg0Cd1ZoobmnoS8Wh5zkFg3NX0sLvP96ymN8XI48bdwW?=
 =?us-ascii?Q?li6+TJZuVBIVRMKxSHgxHDHXpbLwhGHder1Nrz/6I4PQfkxFu8wobIDJxMm0?=
 =?us-ascii?Q?5v5SsOMXZmLQWKIjDRmW6o7W8mbjZFcVCTaKf1DHcN2880RaTmOcO8YTSNHu?=
 =?us-ascii?Q?b23ubVsJ7sSK2Q3HvNJzP4XXE4ffSJBta+bjQ8H1vZAfANfKcwU2MNDSBqXV?=
 =?us-ascii?Q?tb2JjPQpYf6l6J380Afg8mlY2glrsBxSYQyHIEhWulpWWhN+p22mLj2cJTyQ?=
 =?us-ascii?Q?uZu3SWJjGFbOcccJeP1Qo5r5Ng+YtTv5nUHkT3OoGFlpyvdifGz4JVYqWaxY?=
 =?us-ascii?Q?lVlY7cnYPsEzVGrgz1yExGuLy6zcq+CqWe1Au7a7tCbagfb3EsbYZICNcSjW?=
 =?us-ascii?Q?GgIzPad2FWVG89YrQx1NTmCFqTOR8S848osTxYMKZE1rZe72VQc7knYixDTm?=
 =?us-ascii?Q?BMUQGtj4zeRWYT+40JeTUz/jQRfevbRk1j1Gfu7M6sHJ7ZLEQxMllJaddlLm?=
 =?us-ascii?Q?8wu5R8u1g8mYuCaTh0kcrH5GRYT8FJdQJd+rQbhAHcPhqwJpBhJKhgwtDBCd?=
 =?us-ascii?Q?dPqR/IBZXaVYlq6PVDDnmia1lJyj2V9DBPhL/uK+vwwwRMe9uWOJ63Wb5Lvo?=
 =?us-ascii?Q?Rg/QXkZmODTMrbfcV6zaLPHccpfHGQolI56B+z3OSkoriKso+n0TJwh3b6Mm?=
 =?us-ascii?Q?TnuJU9qXk1vhGpTOESRjQLXDXtskUcvz4VxEachYTKDdVNhQfLr2MrH1ljO2?=
 =?us-ascii?Q?tUkF5Wovu5sxMl2pGUen3c9FuusH4l6YxWJTOp+DC18Wq1VgMl45XhPOqKTg?=
 =?us-ascii?Q?McLGme1EyHVo5GUIuUQ4w3f8+7blXL5YkD92eww+iIc1DuTYskuH203/PJhM?=
 =?us-ascii?Q?TG9kOz40OgMSLWQfqHZdgENI4ZdIrte42ALyuswlAN6JyllNUBEviEqChiD7?=
 =?us-ascii?Q?hk8g6JGqPPmNWjJK0QMxBxNXfBRjF9+X4wCe22ETndLDPpCvtY+1lfr5D4th?=
 =?us-ascii?Q?VoK4KfiJU0oaD7W7VdTV2WpPS5y50wVh2+3kwUpdqB/EnhJjerpAIUNcnRLX?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3895ad-6a93-4458-a980-08db7d44d769
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 10:44:43.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipq2SoAIFfjYJHNZjSDDidiJYfyV8/qViY+3r7Tc7Bl6bociWJJ+w8qisRejM0zGm5+2hUQ+JphIYz+Dk7+Ylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switch implements Hold/Release in a strange way, with no control
from the user as required by IEEE 802.1Q-2018 through Set-And-Hold-MAC
and Set-And-Release-MAC, but rather, it emits HOLD requests implicitly
based on the schedule.

Namely, when the gate of a preemptible TC is about to close (actually
QSYS::PREEMPTION_CFG.HOLD_ADVANCE octet times in advance of this event),
the QSYS seems to emit a HOLD request pulse towards the MAC which
preempts the currently transmitted packet, and further packets are held
back in the queue system.

This allows large frames to be squeezed through small time slots,
because HOLD requests initiated by the gate events result in the frame
being segmented in multiple fragments, the bit time of which is equal to
the size of the time slot.

It has been reported that the vsc9959_tas_guard_bands_update() logic
breaks this, because it doesn't take preemptible TCs into account, and
enables oversized frame dropping when the time slot doesn't allow a full
MTU to be sent, but it does allow 2*minFragSize to be sent (128B).
Packets larger than 128B are dropped instead of being sent in multiple
fragments.

Confusingly, the manual says:

| For guard band, SDU calculation of a traffic class of a port, if
| preemption is enabled (through 'QSYS::PREEMPTION_CFG.P_QUEUES') then
| QSYS::PREEMPTION_CFG.HOLD_ADVANCE is used, otherwise
| QSYS::QMAXSDU_CFG_*.QMAXSDU_* is used.

but this only refers to the static guard band durations, and the
QMAXSDU_CFG_* registers have dual purpose - the other being oversized
frame dropping, which takes place irrespective of whether frames are
preemptible or express.

So, to fix the problem, we need to call vsc9959_tas_guard_bands_update()
from ocelot_port_update_active_preemptible_tcs(), and modify the guard
band logic to consider a different (lower) oversize limit for
preemptible traffic classes.

Fixes: 403ffc2c34de ("net: mscc: ocelot: add support for preemptible traffic classes")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 21 +++++++++++++++++----
 drivers/net/ethernet/mscc/ocelot_mm.c  |  7 +++++--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index d7caadd13f83..1c113957fcf4 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1209,11 +1209,13 @@ static u32 vsc9959_tas_tc_max_sdu(struct tc_taprio_qopt_offload *taprio, int tc)
 static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct ocelot_mm_state *mm = &ocelot->mm[port];
 	struct tc_taprio_qopt_offload *taprio;
 	u64 min_gate_len[OCELOT_NUM_TC];
+	u32 val, maxlen, add_frag_size;
+	u64 needed_min_frag_time_ps;
 	int speed, picos_per_byte;
 	u64 needed_bit_time_ps;
-	u32 val, maxlen;
 	u8 tas_speed;
 	int tc;
 
@@ -1253,9 +1255,18 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 	 */
 	needed_bit_time_ps = (u64)(maxlen + 24) * picos_per_byte;
 
+	/* Preemptible TCs don't need to pass a full MTU, the port will
+	 * automatically emit a HOLD request when a preemptible TC gate closes
+	 */
+	val = ocelot_read_rix(ocelot, QSYS_PREEMPTION_CFG, port);
+	add_frag_size = QSYS_PREEMPTION_CFG_MM_ADD_FRAG_SIZE_X(val);
+	needed_min_frag_time_ps = picos_per_byte *
+		(u64)(24 + 2 * ethtool_mm_frag_size_add_to_min(add_frag_size));
+
 	dev_dbg(ocelot->dev,
-		"port %d: max frame size %d needs %llu ps at speed %d\n",
-		port, maxlen, needed_bit_time_ps, speed);
+		"port %d: max frame size %d needs %llu ps, %llu ps for mPackets at speed %d\n",
+		port, maxlen, needed_bit_time_ps, needed_min_frag_time_ps,
+		speed);
 
 	vsc9959_tas_min_gate_lengths(taprio, min_gate_len);
 
@@ -1267,7 +1278,9 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 		remaining_gate_len_ps =
 			vsc9959_tas_remaining_gate_len_ps(min_gate_len[tc]);
 
-		if (remaining_gate_len_ps > needed_bit_time_ps) {
+		if ((mm->active_preemptible_tcs & BIT(tc)) ?
+		    remaining_gate_len_ps > needed_min_frag_time_ps :
+		    remaining_gate_len_ps > needed_bit_time_ps) {
 			/* Setting QMAXSDU_CFG to 0 disables oversized frame
 			 * dropping.
 			 */
diff --git a/drivers/net/ethernet/mscc/ocelot_mm.c b/drivers/net/ethernet/mscc/ocelot_mm.c
index f3c0e6c32934..c815ae64e39d 100644
--- a/drivers/net/ethernet/mscc/ocelot_mm.c
+++ b/drivers/net/ethernet/mscc/ocelot_mm.c
@@ -67,10 +67,13 @@ void ocelot_port_update_active_preemptible_tcs(struct ocelot *ocelot, int port)
 		val = mm->preemptible_tcs;
 
 	/* Cut through switching doesn't work for preemptible priorities,
-	 * so first make sure it is disabled.
+	 * so first make sure it is disabled. Also, changing the preemptible
+	 * TCs affects the oversized frame dropping logic, so that needs to be
+	 * re-triggered. And since tas_guard_bands_update() also implicitly
+	 * calls cut_through_fwd(), we don't need to explicitly call it.
 	 */
 	mm->active_preemptible_tcs = val;
-	ocelot->ops->cut_through_fwd(ocelot);
+	ocelot->ops->tas_guard_bands_update(ocelot, port);
 
 	dev_dbg(ocelot->dev,
 		"port %d %s/%s, MM TX %s, preemptible TCs 0x%x, active 0x%x\n",
-- 
2.34.1

