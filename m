Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C0A6EA35F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbjDUFxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 01:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDUFx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 01:53:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D762722
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 22:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqN/owMvn3a3+EIOfxZ4iBDxxzIQfkyWAyOhksPJsTNyl9KECTKlcCZRl5Vbugwnhj8PIyhwDE+oguihJViZiRXnyiTCc7ITGr4PSWayhu2eYxVb2q5xpE5JHuha0+CkZ0AKHq8Pzheh5Mv1GAH0WJYz83p/lB6dv96twiqHvAokruDnnwzmfzxNUJq0bI5Ahf+yy9DSaQMwF7QLcTcpzijdRsP54BJjqb60c4IylQz5yeZxZNhnSc5VLWA6B8tSEK4L9UeAeZnmgFI/KfPLQMMKRH1BoS349/xtJi0Hrt+sXzuoHSN6BgCCIw9s9W8s89/v43OpupzvGo64E41Tjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SITf7rCUoHHdaiaM3toRiQ3gftc+eSQ5mJFBtlx1kYo=;
 b=SyLvkvJ32hYAkLrTNZvXW8AZiOnBN1JHVqJULP7gaywznOUGqdo+W3m10RfHRy9WBKRjPzqmgRM7nvnQ8Ux06sAwGbCkN5IbdrDcOGyGgogUkTAeczFClb0H8JZR0StIpqv98TiiM24csdjqwA0iiqpWZ9Zdm4Ymj4hSsf7c0nw8M09ekfAJ7VZR28AtqTG6u95jTOlfM2mSSl2h8jLlzhvWG+IcqJ+mW2rH2+6y++hJu0mVd0nZVX/9FB+RwWq7iY5rkjloARk8I3k3hD1E/SkfRSYlBOer48/6eh9PH+Yt4eZXrdYSdbEJMmh7HYH4V7D+wVsRGJwMTInBI4wUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SITf7rCUoHHdaiaM3toRiQ3gftc+eSQ5mJFBtlx1kYo=;
 b=hy5dNoT//7Je/p6+Qe4QZkjSfQN2MEekqE4O1P1Exyef3DKMNjoaR3DVFFLdSEWtcyKazNlx6IP7pzp61qeEymkFko6iE9hsYBgafVTOM+4DJHxSpUOLWOktUTurc7UKGm30Djo7Yt7krGf0oynXTe8Xeqf0iQcsXfV3D9SzOss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 BN8PR01MB5588.prod.exchangelabs.com (2603:10b6:408:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.11; Fri, 21 Apr 2023 05:53:07 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::5cf:2baf:f5ab:ac87%5]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 05:53:07 +0000
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, suzuki.poulose@arm.com
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com,
        gankulkarni@os.amperecomputing.com
Subject: [PATCH V2] perf cs-etm: Add fix for coresight trace for any range of CPUs
Date:   Thu, 20 Apr 2023 22:52:53 -0700
Message-Id: <20230421055253.83912-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0291.namprd03.prod.outlook.com
 (2603:10b6:610:e6::26) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|BN8PR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c47bd1-9d1e-413c-af27-08db422cadf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+pBdETo17FZZNflUBY/0FgUmvjRoaYiQ1ZnP3ognskf5nxMm1AZfHfojzFYC2t5+7c+D8yJo0AoZhY+OfCi2GzJYMPPKxQkuyytFcuQp3saU1Yp+ZS3r6T30wMqbH911RREbFhZAUg+plITMf9ISzezWOHY7jREb8fl9XR0GXum1H0dG4kgi6UZYDR5L9q2koamFFj7X2dn8UsYgawcj2mnI8oPJ6hSUBWvn5/Vlw69/4HwBERafPVgxdvg80EepcLIadNKRFXEYAV3f9ITwz5msZg2fM4EP9bEWU/oN+k3O6pNUihrIvgWxEnUj2jZjxNxu+pN34Lz4eCt66pKdkfeRzgZcFkHj6XswTZtG9reLX442jMwnmQ+FUzpaRZTr6Kh1I96+9hFejjy3KaoDTMoaBO4Id9aXrAe5Z9haRytCXNi4CpTa2bid2W7MMM9keAwI3g0ZnHxyQ8RLZXyVygTKhZCd+ak23l9O7sX1OzeEZv/Pu1r9koSwYOcprHqTUu0ZQQCHwOUGpGjiuIZgHyeKfnK9v3ukipCek3Mj3AReGouKQqqG30ov6+YJy/2e3z2RDAmCVwZFCJleY3Rp4Y1GjE4lVpsLTLRFzQ6eq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39850400004)(451199021)(966005)(107886003)(316002)(66556008)(66476007)(66946007)(4326008)(6486002)(52116002)(6666004)(86362001)(478600001)(5660300002)(2616005)(8676002)(8936002)(2906002)(83380400001)(38100700002)(38350700002)(41300700001)(1076003)(26005)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ev/MhtW3EBWD5g+NRPtDtRztiBvDk8GIF6iYLkED6xd8BHwxKDxc9ySEMpzq?=
 =?us-ascii?Q?9+Q0+uu23z+lACl8lOa9PRyoC/l98VYR+cIUx2pV6soE4eJCOgdRpcf7SZYC?=
 =?us-ascii?Q?tyWJ6pZzAzoIcKSOwOZ+LTkTFtHTY44NGx7qwVpKJSSNYwh5n79vrKMpE9hJ?=
 =?us-ascii?Q?A1K0berageVmlyiQUH+4o+NFf5JzYZ/C9+eJT7qriSi3TTNFPVh7wXE1XK+q?=
 =?us-ascii?Q?EOKqsEoUmDbgBruGc2NBozybYT7qSVvCOaaIwC55aSFFyi49WhT5jWws3huz?=
 =?us-ascii?Q?RB3K8mGkRohJ6z/Qe7IlsUJWiqpBnzUKibZVSM6AoeM07k4rB7o0gTkD2p4e?=
 =?us-ascii?Q?I1u8rfkYssuzLBS2LlZaLR0gRTO4k/SnHiyz2/RIy88My3vEgb9519O7vjko?=
 =?us-ascii?Q?xdAf4cbJomm0pXG88BLwa73L5uwE1nnBcS2EPimHr4LmoUbfKbCaD7HC/RIW?=
 =?us-ascii?Q?vPf4VvnukxC2nnM5f1Au5+y5r94HwZMtlL5d45wHzKQwAsS0n7R43A7rKtnA?=
 =?us-ascii?Q?GWC/Pg22KZMzS9oZWiT1UbBoWxbvM7unNU3BllLz1ABmZhe459QA9bCybl93?=
 =?us-ascii?Q?n+E3NdtYgmiJhagJnNx2B+/ITT7J27JwGh0QX0GH+n6UsyEQrQCXaVVU3qaI?=
 =?us-ascii?Q?Skgt9xwpXLg50rSOOcQRLaiROBsDp19UmtW9+hlGMzKYKLjLPWgel4p32Vfe?=
 =?us-ascii?Q?lwZrEvq54ZNwoWNtO4k72wDJ5liGUNLMCunTWhqkHeoibs3S5FDcC8peWVE3?=
 =?us-ascii?Q?hVmgisQWa3i6lpqKFO8f75rFI4Z2V8Bzw5cAo6R8HK44AH7y9ukbncl3krmI?=
 =?us-ascii?Q?nYZosPNWx2fihvbPm9e7wL1YVfZsRDFmYx/aiPy7EZtV83XPdwUdEUn9BzAv?=
 =?us-ascii?Q?NyQHmUkjpwIGzWlsDUmFM5FUVVSovnpDjRGdoDq/XasL5ayiQwJKkqYC9hh2?=
 =?us-ascii?Q?zmpBm67Rn1NFUiEWyxKeUxXXIkxrou3rP/Xcm4UGPdIqo/1xNsNfyoepCUzU?=
 =?us-ascii?Q?Yk241wj8jAlRYrkf9JAnwIB3ufHNVTwk/p8hUt5FAqj0Jh53HFxp8AJ9vsSv?=
 =?us-ascii?Q?LLnOM/uCkLgpYHspgADaUTblIF3bpZ/Jdst3QWWiy9iJcybPo1spCd8WZg4l?=
 =?us-ascii?Q?uHEydYiQJbUxwPwURZ8ftz2qXE8xPal9ZxgQy1JZp3zwm3oq5Xckvj/c5/Wv?=
 =?us-ascii?Q?ZUbYjKu+xqZDmu21WeGBavBAO09ZnmgJwOdrBog4r9q7tJEvHwaG+ig/PvAT?=
 =?us-ascii?Q?4ORXwLFzXzBfeRLOxDYTfbxxKjuu7oEAEZakMFKu0U5NSEqrLP9dQtzHqj8e?=
 =?us-ascii?Q?h6dnziJIS7WI7RTUzj8GZBpKSSdvCpjbqZE85zaEu9F1yXH5Y8oUlOxF1ymv?=
 =?us-ascii?Q?xdU6YewB8mFf6sQ0rK76yo85rZ3RPAKJE4DgNffpZv9hoPWlG79wrVtF0Jvp?=
 =?us-ascii?Q?6xU3+DF3ftPLSLoedVMKM5qnem2XbJr9aqgp85ctHr2LU9VPKZ0OuG1dN/PF?=
 =?us-ascii?Q?aFx+k23Oi7GSwdVAFiz8G1de/DdJWrhOh82T4vm70/w5YQ+5lAElVgmze2/p?=
 =?us-ascii?Q?nflpNkj7hrcYSiGrtfXDPTDHwlEsv2UPNcMd7iHzbDtqsY2eTyXrE8g8rL7g?=
 =?us-ascii?Q?g213iS6C0Y/QkYHXRvcT72o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c47bd1-9d1e-413c-af27-08db422cadf5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 05:53:06.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kw6QIaJdzDF3bxDJpXQOVmucxl2yr1arhWXHJrT+ibCgabxJVb3DIQFyfgKPmMiQFqHKLlOEdL5Nx1ttkHB43F+fUOEdZYtSsPbZKm1C44SE90Jn1liXUUgdKEfQlycV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5588
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation supports coresight trace decode for a range
of CPUs, if the first CPU is CPU0.

Perf report segfaults, if tried for sparse CPUs list and also for
any range of CPUs(non zero first CPU).

Adding a fix to perf report for any range of CPUs and for sparse list.

Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

V2:
	Updated with review comments.
	Fixed for sparse list of CPUs also.

V1:
	[1] https://lore.kernel.org/lkml/20230419172101.78638-1-gankulkarni@os.amperecomputing.com/

 tools/perf/util/cs-etm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8dd81ddd9e4e..2003717f5779 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -275,6 +275,25 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
 	})
 
+/*
+ * Get a metadata for a specific cpu from an array.
+ *
+ */
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
+{
+	int i;
+	u64 *metadata = NULL;
+
+	for (i = 0; i < etm->num_cpu; i++) {
+		if (etm->metadata[i][CS_ETM_CPU] == (u64)cpu) {
+			metadata = etm->metadata[i];
+			break;
+		}
+	}
+
+	return metadata;
+}
+
 /*
  * Handle the PERF_RECORD_AUX_OUTPUT_HW_ID event.
  *
@@ -344,8 +363,11 @@ static int cs_etm__process_aux_output_hw_id(struct perf_session *session,
 		return 0;
 	}
 
+	cpu_data = get_cpu_data(etm, cpu);
+	if (cpu_data == NULL)
+		return err;
+
 	/* not one we've seen before - lets map it */
-	cpu_data = etm->metadata[cpu];
 	err = cs_etm__map_trace_id(trace_chan_id, cpu_data);
 	if (err)
 		return err;
-- 
2.39.2

