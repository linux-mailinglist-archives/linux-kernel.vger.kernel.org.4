Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AAA6E803B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjDSRV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:21:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2130.outbound.protection.outlook.com [40.107.102.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B7765B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 10:21:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHC0jwtUAsam3/24ioTTUD60CDUqOo5vuSHw1gJmAtJl7ZxMj9lfku4VtNdbzcPy+QfppBwk+3GIauE4gE71knWgEnzA+vjKDuvSs2sPMPswlmIBuwP8r3JJp4VDqyaFT4FjINOewlPKB8dmZoTxrkjM8XSCyP8CM4qZx3RcztBiAAW7jjkzejUzFeK07KQwPbo2uIkpv7MDNGmV21VMRioldQoPlRCRd0aIC36e4cDs/gs7A5iiy5uqeQp9cQRIO0fDq+i2Lnp4+gnUPXrX9by9lY3e6hYy5A4oflEQQ4SxFy9bA0fOGRhsLF938SX4a6O5ZPSNDT359lARQZkHeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJgEWTkc/GZAhBSEt2/g7wf6XL3jy88yCeiMYuP1Cn4=;
 b=aXigXJPK1S95vE3O0BfB3M9IbU2m1UlIIlNh6UxylZ4MRaRATt2p63WudbVgTZ2FX21R7n7Ex3mwFH8qN7L7I59F0R0RE7mnVfHSy56E0SN2NeQWZUTEy8C9EL2VMggJWiMjRu9cRSMHxX+9qvm65sp4GW0GpQVeezzNn73QgAeKQVog7lPlCECaeGlEJKvs0d55Pq/Woka3iPq1End+HDDNz7pcgSewKwiAEjbtkWYNkhi8OPnfj2CoXjguYdKOMKYotV5vfO89hi4SEjFyYdp+PZy98YNfxQoDhls/b7SGhTJrSJbFnQ6u+EariLqXpTo7U5d5uCwyLgkefSEt3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJgEWTkc/GZAhBSEt2/g7wf6XL3jy88yCeiMYuP1Cn4=;
 b=lVNJ5ZUuZpZe0SYdGQHlLmWADVyKo/gEoCc5fxqm/tgfycoRV3zKWh5J8D1ATVjBrAtnHODCE0y/jq8nK7v9wT0qVggl4eAGMwsxSPPO9liuBTgjVq7QBXjg2074jCiU5g4MzyzxeyNUwkvbKGvuXoDrpoSwZvSz+/C/gR/lQIQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BYAPR01MB4358.prod.exchangelabs.com (2603:10b6:a03:a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20; Wed, 19 Apr 2023 17:21:17 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87%5]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 17:21:17 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com,
        gankulkarni@os.amperecomputing.com
Subject: [PATCH] perf cs-etm: Add support for coresight trace for any range of CPUs
Date:   Wed, 19 Apr 2023 10:21:01 -0700
Message-Id: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:610:58::25) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BYAPR01MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b03fc4-9ea3-4359-b522-08db40fa7c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apFa3RohvaAn4+6Z9o3cKYuWr8u554Wl5BZTAEnLI2KLjj0BiksjltqZlyPFTJ8irfVI5UTQz3mNZTESfoofLp9mLnADl+yysKMqNqcjGK2RjNKo91p/tJel61nfQmeXCCIm8UFJLo4p6MvM0RH6mbmg1wmyvIRDqg2dKFPREqesfAInRgCVHjE+XWnsoVeRHm5Khjh9xn1bhE8sH+ddYfjtqDeoov9w/iJF0bQLpUria7J3HU5FeeBpyABZ16jymp3gk7qJUbFPgi4MtacgnuqFUSEX4RXCYpJolKJJdffzLskbdanv+rlr+oAnG8X4HUDpj6CCBgWJ7UHTi6GQTFOb736JqBKWCoqt6ccf7NuVFzbamXBZSj8aVowqT6ro5gVwMC20iPlcFjXwrkNGKBD6Z5bUnp9C7daJUt2MQ00O4pD5dZWHz9DFSmr3mwmZYDz0aHrnHRPlcY4qvHb6jPnlFHpjQPZBI+QKXX4nnU6DfTakZT3LYiyy1jMLX7Wq/CINAyZpYurlfsiN0hGs/EAiDvyCNI7HKKU6RtqUxBA3yL23q8qXxcXbbk8Q4tTOaQKoOpi4hDQcs1+Y0kTeHTSBJr4W7jI69nnopfKq7iHJnQKKTkN4UbbpQkWOVVRX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(4326008)(38350700002)(8936002)(8676002)(38100700002)(316002)(66946007)(66556008)(66476007)(2906002)(478600001)(6486002)(6666004)(52116002)(1076003)(26005)(6512007)(6506007)(86362001)(83380400001)(5660300002)(41300700001)(107886003)(2616005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JzXUACAYtgXsqesSP4yV+FlmcWJqWVjO/F7CAbRYpYUGqq9Jn4T6nNAeXe64?=
 =?us-ascii?Q?RWB3iDOi6zxBN2/eij79c45GmXBlmyk+EjUjbZibrwqtR0q54TMBe3jV8BLR?=
 =?us-ascii?Q?w4a5xndUycHZy7hTtpTI15BcBZOea9TJRsrDjiSJQiuUfOtbXGTsNy7NdNv9?=
 =?us-ascii?Q?fRjX1+iSgPeMgmUxx5K9d0KWefWzsxjM95hK+ZeOEDvMo8yGz8Oh0g64s5fJ?=
 =?us-ascii?Q?h3OYF058GhhUHjtDm+n2euiXnmwF4JlBv47CJw40T/DGNOblcTYvRpBk6fez?=
 =?us-ascii?Q?bkPid7A04dDy96qC8bm9Cz3foi77LZ+6uTEbJ2VVoB1s0pvHUHRdT/swHf10?=
 =?us-ascii?Q?NAlkzwC1r7n1hYcmT1pS6rPfsxALp3y1xwRqnM1ZYNPelsgdV9B1YyS+x+/b?=
 =?us-ascii?Q?/eEtvC6Wi40bKU/jQxR1XHon9TUDS0O2txOsEPoXKkNRRGFCq1ADg6Rg4ecY?=
 =?us-ascii?Q?Ypw05AUnY4Hj4V/zYc8MYAF4cU4qJiV/eSYMn2MXlUVvbaasmHyI9cISF0TJ?=
 =?us-ascii?Q?jBqx5ynGuzuH/WpvJ8xMSY48HJBKsBkMssQ7axUOpndgerqXzumUR1ZXLd0v?=
 =?us-ascii?Q?fSq3/qiMKJRxvgjh8hae15ZLxapXEFJI1sE1Euh/Rhqj3M/iE7EuyZ3i3TCo?=
 =?us-ascii?Q?xLCe9qRMKVQTPPfUhCZATIRgsvDyd6kYVpAu6384xlhgByTn4JAzdLDOpanL?=
 =?us-ascii?Q?B/OABCok58B1CTn50s5Cln3TMh6YS0WstlBNQDfSDGGBd1vBrTMdpWbUZl60?=
 =?us-ascii?Q?ZCOgFVd4ux+NzfE/YhLmoXROr7Fh+zfYhDlbfrkQlQzJ0XT6VOcCd2LhPZy4?=
 =?us-ascii?Q?0vOdKtkYd3JnNfZ29+5X0NrXMDRFpMX1VpIsg+nI+A82BaYfmqdk+t/qj+c/?=
 =?us-ascii?Q?L5WO5FcIZGMzInv3aII9FH2lLW7wsFLUPXvmdST/Yd+695q24vbNPesKH2rZ?=
 =?us-ascii?Q?olwFoBZZVLsDKBrAozBcNSfP97lLyjwOKZFdSu0TBhK5uAJQhC4p044LHkQe?=
 =?us-ascii?Q?RDD3oAYxZ+IGOyL5T1RkvUlFOij9k8HnMxpA+K2qAF50MqOkUnRZlbCKA0OF?=
 =?us-ascii?Q?wG1Nf2En/f4qAUV+OLJYUOry9RuwyT5H7QvsNYCa5iLCCmwXh2EvRQoi1Awu?=
 =?us-ascii?Q?JnANiQa16xczcS+BaKbtmsFEIonQC7qlqwQOWNVPjUyc+iJQb3jO24madd9l?=
 =?us-ascii?Q?cilPF95HBtSHD739XeQX86fout2/l2Ei5CppDGbwFlU2XZgt/DRkk7iVhlfB?=
 =?us-ascii?Q?B50KSbTtU5qI0O7iLneK6YCQGS373/NWk5yiIqnICox3pnNHBxzkCzXxtb0q?=
 =?us-ascii?Q?12juS/Ujjwm5UF4xTkX24s37kIynbmu8KaiO4T+CR7xWkE0Y3bGehtGHn5iC?=
 =?us-ascii?Q?fKa2L3lVj0DLgqlWk7AglJw+U8tvHs4p5r/assBq/mIOYNOo1Y8Oxzcx53kc?=
 =?us-ascii?Q?KYDSs8zwnqeTxYb0ZOp7aBOaMON4duQqn2mEKx+A+WPNFs184ljyjDk6JeP3?=
 =?us-ascii?Q?viyIFkQdk7qzaAyNH/m5zUftC+jx6KZ+gcQoSW9a0gSRieJAKq7KmtlI/spJ?=
 =?us-ascii?Q?rCnHHGF6kGTK6cd0pO9J08Po9tS/VUZupm8XDyCSeSNNuosRAjqDAt1CY1EP?=
 =?us-ascii?Q?BGR2jMgameb8d8Zx5QZTR4c=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b03fc4-9ea3-4359-b522-08db40fa7c15
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 17:21:17.2690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deQ+A2QSsr3ll0cFBgyxHmjcAXs0ttzfY9APZhtG2CVaTPMb8tQ5U6f2Pl/WyFzhGER+RhadSzfYPRsipzHSGpZGyRU7WecIQTnnVf3/eCpvzR/DZZYtKOBgvcu7mOql
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4358
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation supports coresight trace for a range of
CPUs, if the first CPU is CPU0.

Adding changes to enable coresight trace for any range of CPUs by
decoding the first CPU also from the header.
Later, first CPU id is used instead of CPU0 across the decoder functions.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  4 +-
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  3 +-
 tools/perf/util/cs-etm.c                      | 62 ++++++++++++-------
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 82a27ab90c8b..41ab299b643b 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -724,7 +724,7 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
 }
 
 struct cs_etm_decoder *
-cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
+cs_etm_decoder__new(int first_decoder, int decoders, struct cs_etm_decoder_params *d_params,
 		    struct cs_etm_trace_params t_params[])
 {
 	struct cs_etm_decoder *decoder;
@@ -769,7 +769,7 @@ cs_etm_decoder__new(int decoders, struct cs_etm_decoder_params *d_params,
 	/* init raw frame logging if required */
 	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
 
-	for (i = 0; i < decoders; i++) {
+	for (i = first_decoder; i < decoders; i++) {
 		ret = cs_etm_decoder__create_etm_decoder(d_params,
 							 &t_params[i],
 							 decoder);
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 92a855fbe5b8..b06193fc75b4 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -90,7 +90,8 @@ int cs_etm_decoder__process_data_block(struct cs_etm_decoder *decoder,
 				       size_t len, size_t *consumed);
 
 struct cs_etm_decoder *
-cs_etm_decoder__new(int num_cpu,
+cs_etm_decoder__new(int first_decoder,
+		    int decoders,
 		    struct cs_etm_decoder_params *d_params,
 		    struct cs_etm_trace_params t_params[]);
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 94e2d02009eb..2619513ae088 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -55,6 +55,8 @@ struct cs_etm_auxtrace {
 	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 
 	int num_cpu;
+	int first_cpu;
+	int last_cpu;
 	u64 latest_kernel_timestamp;
 	u32 auxtrace_type;
 	u64 branches_sample_type;
@@ -638,14 +640,13 @@ static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
-				     struct cs_etm_auxtrace *etm,
-				     int decoders)
+				     struct cs_etm_auxtrace *etm)
 {
 	int i;
 	u32 etmidr;
 	u64 architecture;
 
-	for (i = 0; i < decoders; i++) {
+	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
 		architecture = etm->metadata[i][CS_ETM_MAGIC];
 
 		switch (architecture) {
@@ -817,7 +818,7 @@ static void cs_etm__free(struct perf_session *session)
 	/* Then the RB tree itself */
 	intlist__delete(traceid_list);
 
-	for (i = 0; i < aux->num_cpu; i++)
+	for (i = aux->first_cpu; i < aux->last_cpu; i++)
 		zfree(&aux->metadata[i]);
 
 	thread__zput(aux->unknown_thread);
@@ -921,7 +922,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	 * Each queue can only contain data from one CPU when unformatted, so only one decoder is
 	 * needed.
 	 */
-	int decoders = formatted ? etm->num_cpu : 1;
+	int first_decoder = formatted ? etm->first_cpu : 0;
+	int decoders = first_decoder + (formatted ? etm->num_cpu : 1);
 
 	etmq = zalloc(sizeof(*etmq));
 	if (!etmq)
@@ -937,7 +939,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etm, decoders))
+	if (cs_etm__init_trace_params(t_params, etm))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
@@ -947,8 +949,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 					formatted))
 		goto out_free;
 
-	etmq->decoder = cs_etm_decoder__new(decoders, &d_params,
-					    t_params);
+	etmq->decoder = cs_etm_decoder__new(first_decoder, decoders, &d_params, t_params);
 
 	if (!etmq->decoder)
 		goto out_free;
@@ -2959,11 +2960,11 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
  * Loop through the ETMs and complain if we find at least one where ts_source != 1 (virtual
  * timestamps).
  */
-static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
+static bool cs_etm__has_virtual_ts(u64 **metadata, struct cs_etm_auxtrace *etm)
 {
 	int j;
 
-	for (j = 0; j < num_cpu; j++) {
+	for (j = etm->first_cpu; j < etm->last_cpu; j++) {
 		switch (metadata[j][CS_ETM_MAGIC]) {
 		case __perf_cs_etmv4_magic:
 			if (HAS_PARAM(j, ETMV4, TS_SOURCE) || metadata[j][CS_ETMV4_TS_SOURCE] != 1)
@@ -2982,13 +2983,14 @@ static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
 }
 
 /* map trace ids to correct metadata block, from information in metadata */
-static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
+static int cs_etm__map_trace_ids_metadata(struct cs_etm_auxtrace *etm)
 {
 	u64 cs_etm_magic;
+	u64 **metadata = etm->metadata;
 	u8 trace_chan_id;
 	int i, err;
 
-	for (i = 0; i < num_cpu; i++) {
+	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
 		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
 		switch (cs_etm_magic) {
 		case __perf_cs_etmv3_magic:
@@ -3015,12 +3017,13 @@ static int cs_etm__map_trace_ids_metadata(int num_cpu, u64 **metadata)
  * If we found AUX_HW_ID packets, then set any metadata marked as unused to the
  * unused value to reduce the number of unneeded decoders created.
  */
-static int cs_etm__clear_unused_trace_ids_metadata(int num_cpu, u64 **metadata)
+static int cs_etm__clear_unused_trace_ids_metadata(struct cs_etm_auxtrace *etm)
 {
 	u64 cs_etm_magic;
+	u64 **metadata = etm->metadata;
 	int i;
 
-	for (i = 0; i < num_cpu; i++) {
+	for (i = etm->first_cpu; i < etm->last_cpu; i++) {
 		cs_etm_magic = metadata[i][CS_ETM_MAGIC];
 		switch (cs_etm_magic) {
 		case __perf_cs_etmv3_magic:
@@ -3049,7 +3052,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
-	int num_cpu;
+	int num_cpu, first_cpu = 0, last_cpu;
 	int err = 0;
 	int aux_hw_id_found;
 	int i, j;
@@ -3068,22 +3071,31 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	/* First the global part */
 	ptr = (u64 *) auxtrace_info->priv;
 	num_cpu = ptr[CS_PMU_TYPE_CPUS] & 0xffffffff;
-	metadata = zalloc(sizeof(*metadata) * num_cpu);
+
+	/* Start parsing after the common part of the header */
+	i = CS_HEADER_VERSION_MAX;
+
+	/*Get CPU id of first event */
+	first_cpu = ptr[i + CS_ETM_CPU];
+	last_cpu = first_cpu + num_cpu;
+
+	if (first_cpu > cpu__max_cpu().cpu ||
+			last_cpu > cpu__max_cpu().cpu)
+		return -EINVAL;
+
+	metadata = zalloc(sizeof(*metadata) * last_cpu);
 	if (!metadata) {
 		err = -ENOMEM;
 		goto err_free_traceid_list;
 	}
 
-	/* Start parsing after the common part of the header */
-	i = CS_HEADER_VERSION_MAX;
-
 	/*
 	 * The metadata is stored in the auxtrace_info section and encodes
 	 * the configuration of the ARM embedded trace macrocell which is
 	 * required by the trace decoder to properly decode the trace due
 	 * to its highly compressed nature.
 	 */
-	for (j = 0; j < num_cpu; j++) {
+	for (j = first_cpu; j < last_cpu; j++) {
 		if (ptr[i] == __perf_cs_etmv3_magic) {
 			metadata[j] =
 				cs_etm__create_meta_blk(ptr, &i,
@@ -3145,6 +3157,8 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->machine = &session->machines.host;
 
 	etm->num_cpu = num_cpu;
+	etm->first_cpu = first_cpu;
+	etm->last_cpu = last_cpu;
 	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
 	etm->snapshot_mode = (ptr[CS_ETM_SNAPSHOT] != 0);
 	etm->metadata = metadata;
@@ -3152,7 +3166,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
 	/* Use virtual timestamps if all ETMs report ts_source = 1 */
-	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
+	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, etm);
 
 	if (!etm->has_virtual_ts)
 		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
@@ -3232,10 +3246,10 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 
 	/* if HW ID found then clear any unused metadata ID values */
 	if (aux_hw_id_found)
-		err = cs_etm__clear_unused_trace_ids_metadata(num_cpu, metadata);
+		err = cs_etm__clear_unused_trace_ids_metadata(etm);
 	/* otherwise, this is a file with metadata values only, map from metadata */
 	else
-		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
+		err = cs_etm__map_trace_ids_metadata(etm);
 
 	if (err)
 		goto err_delete_thread;
@@ -3256,7 +3270,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	zfree(&etm);
 err_free_metadata:
 	/* No need to check @metadata[j], free(NULL) is supported */
-	for (j = 0; j < num_cpu; j++)
+	for (j = first_cpu; j < last_cpu; j++)
 		zfree(&metadata[j]);
 	zfree(&metadata);
 err_free_traceid_list:
-- 
2.39.2

