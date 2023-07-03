Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC3745B15
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGCLaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjGCLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:30:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2138.outbound.protection.outlook.com [40.107.215.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844210D3;
        Mon,  3 Jul 2023 04:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/G4gbPqbmHxAS6mmGV+N4D88ydXHkJoj+iwwXQo6z8INUY7SYwEttwJhhsAmm5Tj+1nRKdeZsQkM+NWi58rTgOuAwsh7kFo7IK1NZw4+ggl0qrvo5atG34cuBiU6bcVbn/w+5cx7hQn/ipQzIMiq2bxwdXKHCIQN/XkdL7P3IieIUPsiwly8VU7QJxTItU0usjcku1MdRreJm/2CIMyiYApF0kteh+FuQy+RSpohKq60PnTodT8Gh1HK6Vb1kg6vZGg6CO7YKWBNKndgRB73cQjn3awGwdsjU36alyl1udj/qU+Z7W1/0ZCTHovKs6E6WB6B/0MAXmd9lutgiuRfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEZ4c8lVzu3OP2NlOk1edi6u6SqNO0HguDVueCsnU1k=;
 b=NMYcgAfrSizaW+ZBL7AU2it3nUYTrlzkWHwB2GRNFI6CV4+HRahb8csEq9qhUzq4Hjm6Fr7vnuGvDypy5bzjS0WBVVfcEicgcEWFiqWFeGspVt0kRQ0gdKAZFo6JG/OkADuG6Oi3LzOtEOeWbud4bpZABaMZoBAeK9T6OZSqs6iYBnzBljwb+wofv1zur4sLISLW4ltR+6vhn4o4A3GHTlfYeWLsW9S5qVNAHoPvCTNRXz4O6Pg73y20F48M/W3pkS9LY2EKRZhvkAdDrxtzzNNqfztL0bEPtPBk+f2uYnFGmQzCb4f6gI1kMos0pPMFR6mCoCv8UvVol1uArXVpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEZ4c8lVzu3OP2NlOk1edi6u6SqNO0HguDVueCsnU1k=;
 b=pgNTiqbyqXvJheof+pbkLi8LvBObERivYIb0CZZX4JYLcwjtdH8s+cNOamp9YsHrgCo26lrwQguoDI2Q2mwg1ajYU/HARmHiQA9Gq1f2V/KDbLtZ7ai7iNh9cKu8Qun1smtn0NKrEjF8s4bmuW0lhZFIKavTI9d9RzqWRHaGqiIO2pdmV8tk3e3gkrcJcl9Ukp2jyIC+oChny3jPDUfGr+CueMugQHnVlJ45Kerbr70DSKHW1wd/8ABTntCjuhIOErHI5jA8+mBbygulSO/G4vrRT0iCU5Wcxk8dQDUfqsgSDmDzZSk9C28SfnHQUibO6wgWOuqsWg5rr5fUoa9RrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13)
 by SEYPR06MB6132.apcprd06.prod.outlook.com (2603:1096:101:dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 11:29:54 +0000
Received: from PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9]) by PUZPR06MB5936.apcprd06.prod.outlook.com
 ([fe80::5c03:58ad:fb2b:49d9%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:29:54 +0000
From:   You Kangren <youkangren@vivo.com>
To:     Kalle Valo <kvalo@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>,
        You Kangren <youkangren@vivo.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-wireless@vger.kernel.org (open list:RAYLINK/WEBGEAR 802.11
        WIRELESS LAN DRIVER), linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v4] wifi: ray_cs: Replace the ternary conditional operator with min()
Date:   Mon,  3 Jul 2023 19:29:45 +0800
Message-Id: <20230703112950.11854-1-youkangren@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To PUZPR06MB5936.apcprd06.prod.outlook.com
 (2603:1096:301:11d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5936:EE_|SEYPR06MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f978a12-a6f9-4097-78cc-08db7bb8d240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHkBRVit+sKEBv6wSGbip/gjCWLzmrMq1h1BOdn1jtuV8p3t1ES39N/I/VTUs2QIG72Qs99Zsn2ljNUoudf6E/xREggcZ9tbbY+I9G2UUc8k3eDbX4cWKJhmef+IBiFRu6X9q8PGYJeEFt2Zdw4J1X0ZibgZ0GO0NC8Sd35Y9lyO0PZLFWDclhXCWazUQJhjCnQpCeM2RVvc9zMVJ8AzMLYBRyHrxLuwATxQN37yMktRoLtKlyPEONpyCdKcNDT0EiR5m2wQ1GrBZ98WSzmI4IKLdRVwfKMTaHm/AIYXP2wtoTDUcfER4FgCqM6eOuipWn9lGN2ydpKUwf3GEJ7qC6CXjPx1sQhznrS83TW7jkz3HUhbBH5YP9z/kCalAu5jqBbA4ZK0wSjUka8g1Wjl7mOpKMFx0OVeYF21PCnwdD8Z/BvhyQE4mHWujuAMD65mVHup3H1aZVcnGItuOnXB/lj3328K5OSxFL7mYQPkGIdHENwdKM0gc8z8Bf1BLfYF/l5YSfteDEhyazPs55YFVIkTpiRuf2CeXKKu0nvst+jKMYOYT7fECnAQz85Dd7nG1T6PiYvgaEcnPb1wmlyLDv+V/mBjaYK3ztgCDB9mAJku2mpxE84bhty+6Qgm2nT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5936.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199021)(1076003)(6506007)(66556008)(4326008)(66476007)(66946007)(478600001)(41300700001)(107886003)(38350700002)(38100700002)(316002)(2616005)(83380400001)(186003)(26005)(6512007)(52116002)(110136005)(8936002)(2906002)(4744005)(5660300002)(6486002)(36756003)(86362001)(6666004)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzrXtKm+hmzVvWRSZVerFi7abJeu09ms52HP5MnK3fjbWwv/Evu7EBbafYK8?=
 =?us-ascii?Q?VQuI5oc45J3dVz2WgA9hx830hARzSZfnnLZ9/UKVYWcozC/94UDmNfyhJAnS?=
 =?us-ascii?Q?BEqbyiXtNVrhA6ndAkS5i4Hg2xk0ixhtG4ZihnUxCF9lf6vu3jENH8LRwfN6?=
 =?us-ascii?Q?1C8WLbnxHdVde1b6uGyKvrs+PPblesc+rFmVHiM+3KIB/bkD9EOri00ofuXW?=
 =?us-ascii?Q?/VjLZoEwJ6YkR6WmkFJMhELjyorSBQ1r2/WYkYHhdS+R4XZqsyJO0a7dCPh1?=
 =?us-ascii?Q?TgdF1upLtDf9/w9nbYgZM1RU4cc7r0UOvVNVzzrokSPWs2+D5+LhNrYHZ2Uh?=
 =?us-ascii?Q?BIEwTasH/vFWjkqbEvACOCFpdcILZ+dHY8FSneHRouGtZNNvBSInX64WaagW?=
 =?us-ascii?Q?yadXhjL4kPVrmqgVgzdy3UJbW0XDBG+SF6Pli6Tmu7sc7/X+SQtSvVT5b1S1?=
 =?us-ascii?Q?t4QTF7rZWaOj1gGF1YFj8OTdzQZSTClI8oO8HnAFVqKPx+4wynpt9JAnG3wP?=
 =?us-ascii?Q?24R+Grlxum4dH65X9LwbUAGUOzmiZhX2/IhHxPOFmKLSVYO5cAplzGoiSv4d?=
 =?us-ascii?Q?jvkXhLJumrTXn0OgMpLi6QoxhEPX1ALisVxfMQJUxnTGeLWeuSEJgf8oTRTF?=
 =?us-ascii?Q?0yA8FS+9veCAVIKr94nTRr2QzaJdIDd++UUf2zw5ifitldu0XtaFrcMRRVcF?=
 =?us-ascii?Q?vLdxI0/lnYzX3yiAYbTJ+vaa0edNi5F6bfix9a2vZz2Mq2ft471xFp/cO0gA?=
 =?us-ascii?Q?JGsKYcAQaRwJ4dJJ13uwMqLwt2DhsKfHa/RImTFOiJPCzxF+qnlnDvF3eQnS?=
 =?us-ascii?Q?bAZppsx3B7F/bU7AJ6wJkKqg1bRsw1EIDNyL1fBQYK3iLF4k34lfnG3JBIvx?=
 =?us-ascii?Q?oraUVVgUxDLcCZq/2QAhqRprLkCYTTsE5bSIj671lVo5q7XzzwUthr2pWsil?=
 =?us-ascii?Q?K5bhIXC1FUtm8GGDwbvHoE3JkU6xJTjf5iQb5SEzKjKyH7+3Oh2f+3FOLVp4?=
 =?us-ascii?Q?H4fepEKNipVIp5r/fqR0P+BlWk3CrICp5kG5cslwfjqyKABz9ot9EW29qPJQ?=
 =?us-ascii?Q?cclQo+TSHWEm38jSLzLfQ+BG/hMdM6lmh8sIC5hFAXdKCjM5vxKft5BTIh/h?=
 =?us-ascii?Q?LMOkPnyI8EPEVI0ohdcNFzvdUwxSRc5VkX7lE9z/YK51OL+huz5qykNqrMXa?=
 =?us-ascii?Q?0dI3VAGPYD+MqOJqB6NIGhbtqa5u4oAKx8soUwcsD7OzRG7cPPTbe8UfsAKe?=
 =?us-ascii?Q?yVNbS1843c0DaOpucT+qTqaFYosCFx4i9/JXUaI2YgPiabwiOpt6w474ANce?=
 =?us-ascii?Q?AMtcALbCuHE35VmAFQ0fFyMv85ddaJBZZn68Io8bUIXr+jDRa5ctURCuNvVl?=
 =?us-ascii?Q?M7J5vrnEKi9migyZAJxzhqqRCHxFfaZSjGolish9xfBHMF83T2AnsTxL/8es?=
 =?us-ascii?Q?O7vIX5JoLhp7EVLQ/nuuOPlcxJvBEyrC2+NlftinKtMji/IoMXJaOeTSpQuI?=
 =?us-ascii?Q?slCJdsHruePzVhYeGJdplVx8xeN1xEqbC7/a/cpgns2L5wzNZXkvEQBZG5Bd?=
 =?us-ascii?Q?gbnuFCDT89iQi0LSIr4d5z136F20pGgc7d9V/vvr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f978a12-a6f9-4097-78cc-08db7bb8d240
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5936.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:29:53.7128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTzUEKv8jNhDe7PJtEUlmgrfVX0HLuTlv+HzRn8j0uXAzd4QXuCAhjtl5Lc6AuB5OQaWeqNLYHzgZq4kstn9Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6132
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the ternary conditional operator with min_t() to simplify the code

Signed-off-by: You Kangren <youkangren@vivo.com>
---
 drivers/net/wireless/legacy/ray_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/legacy/ray_cs.c b/drivers/net/wireless/legacy/ray_cs.c
index 8ace797ce951..f8c4e9ac7621 100644
--- a/drivers/net/wireless/legacy/ray_cs.c
+++ b/drivers/net/wireless/legacy/ray_cs.c
@@ -2086,8 +2086,7 @@ static void ray_rx(struct net_device *dev, ray_dev_t *local,
 			rx_data(dev, prcs, pkt_addr, rx_len);
 
 		copy_from_rx_buff(local, (UCHAR *) &local->last_bcn, pkt_addr,
-				  rx_len < sizeof(struct beacon_rx) ?
-				  rx_len : sizeof(struct beacon_rx));
+				  min_t(size_t, (size_t)rx_len, sizeof(struct beacon_rx)));
 
 		local->beacon_rxed = 1;
 		/* Get the statistics so the card counters never overflow */
-- 
2.39.0

