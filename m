Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0C63BB21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiK2H61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiK2H6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:58:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2131.outbound.protection.outlook.com [40.107.15.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955CD1D0E8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+HdA+cjXgpamfExQm0DkZ8W1AqgZG3iXGJIC66GCZW/RX1H40lVYIOKzyYsSkMCCrac8XFEkq6wz+0iJRp0m3mB3y4uGj1h7wd0mDMo0Kj0uy6zQituERxlg1c8seFqC5aYeg+7wfcVCj96Q882bzIohjkvaq+b/sA6EfRC5ml7VuoBN2/Wp7gbnPs4mrVpf0VectkjIaB/jxYL2Dx7ChWzHTAY5C8rB60V8T9CVcv4et4DfVJcmJ2iqZI1Bw35OD+Ygfcnz9BLtY376fpjBz91dJDvDSoNuqzjAnBvOuPBodVpUNB2nQFhmpSeW5ow3Sc1IXfKAQcGhFIzmV5ZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NzM5bPNgoZcA1NomhBWx/cryuopF4ePRuJNhuJwv2s=;
 b=OL2Da74Z5bYuZ77f5VRL00QhMlNAQuhAfRgCpft0lCBJiQCUW490HaPYcgH2+iCvfrb5jR8VV8dwOdlsPWK3Bheh1xtr+QisqoMbNXNt/6x14ZuKXntYI0qTyjOhOjCZNNyxHUlP2Pqy+W3G6wX2v8+N/0phlBwECo5kHTVi9wzrrtTFW7BL0QR3HycmS3Gg/AMIVL11B0Q/4bL2ahKTcLeiXrgmNWJ5vyZspm1jvyrH1okhFaTUpdTScHAZL3M5Fwe3dcUaaV5/jtlQqeV3+NSAmvwuf0l9GsKPFOU8DMTDPfo1GnrOo/lwSzrHo6TRYQeycXXiwqkF33p4oTfWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NzM5bPNgoZcA1NomhBWx/cryuopF4ePRuJNhuJwv2s=;
 b=jWqU6qN7qjyuBK1cX6emeytROQfIcFsgXjMMrmgcWQKeKjJL6EBEZYyetHemq+F6tQ0/PAvTyhhJuipAG2AYaZaqStSyLi7tNmOxCGgMy3N7bTMMSb5W8DmbdX6EtI8jiuwKgKuk73dYc1A6d/p83UbFzOxbRfeOmATSCZpm87E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com (2603:10a6:20b:1a2::10)
 by DB9PR07MB9599.eurprd07.prod.outlook.com (2603:10a6:10:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 07:58:18 +0000
Received: from AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9]) by AM7PR07MB6705.eurprd07.prod.outlook.com
 ([fe80::1087:71b8:5b7:f8b9%3]) with mapi id 15.20.5857.020; Tue, 29 Nov 2022
 07:58:18 +0000
From:   Stefan Wiehler <stefan.wiehler@nokia.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH RESEND] arm: topology: Consider clock-frequency property from parent /cpus node
Date:   Tue, 29 Nov 2022 08:57:11 +0100
Message-Id: <20221129075710.8407-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.31.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::6) To AM7PR07MB6705.eurprd07.prod.outlook.com
 (2603:10a6:20b:1a2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR07MB6705:EE_|DB9PR07MB9599:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c2de65-ef9f-4453-8ecd-08dad1df7a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JnfOFuISd+BLsn65VeA2fMgrgB1h7+yNG/EXguUltDlkW3vNILbXNgnXw5ig+Ee9j9/cx1dhHbFSwovzlLv1EPht0LWynewXAVRgTaXX3VjF4JaCaZJMNuHnuDZghxLSKdTY55iuEN1OzVS+mnzpYQDmrHL9Q/63pzOlzLKkCyXFeXUoLHFV4eGnpcltNkms/k4bvWm93kyjzG6X+Z/pw2f3NCKteLnRWSvjQvHQCMz4/qmnf7jevUHyR7qZ8TMfU4sONJw//ExJ9KDp0vGi2t2XChsWeWCQV/c9eAaoree9B2hlF32hzAb6w2usDrJNbyc9WQU8u4emjXA1kZ7gMBc42lTKV5R9ybqzkLK2NMTHylc5Ep/Ho4Leth/RM8y/rroYLXjlrHrp3h+rXeQdtBoZVwi2zsy1xYG0hfqUwxmjkJptkltwdUZTtDR5oPmuVdxWHLJF/CHxqYfYhIBJhYfVs/rDyGvRyHd3UooeudhQByYWBW/0jdXl+zkBvR8vLlKNFBdxREaVFsI3bvIW3e/J7FezPdh68aW/1UoVZdvCZo/n4I19V9Z4BGoeX6WQV04m05eJQs5yUnuLiIljrRo3g/YhHtCx2JOZzql56jy/HSxy3MOvejAv0DArPifoYfcOqLEJ0W3hkoLA5jrFXHctXwXVHTSNXHKRIGkznVEY13sTkpUPR+Qfqz1Q+2qsMzm2rx5wko/e6OErhy30A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR07MB6705.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(4326008)(41300700001)(8676002)(6916009)(66556008)(66476007)(6486002)(316002)(66946007)(26005)(52116002)(6506007)(83380400001)(1076003)(2616005)(107886003)(186003)(6666004)(478600001)(86362001)(6512007)(36756003)(2906002)(82960400001)(38100700002)(38350700002)(5660300002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gVxVFICDMIFlVQiyNUX/c3QPmxfFB4Svt7abkCyU4PsXX3v9vwhB548qyLjc?=
 =?us-ascii?Q?1Bb0JL+1rczGyNNVdX5BsczEHg5lbfe9O8y4tTPwUUa8q7PHg6SJzX4pA/8z?=
 =?us-ascii?Q?NGWF7dwzwokhGl12cpqLwnPI92aYK93bajaZZ2FdYm1ZSPHKNy10kFZ61BgP?=
 =?us-ascii?Q?uvOj5VsJp697eaTX1m57OG0Hy9gfxumXXn58uezNjlWup1z1Tk2R80Bwv/3g?=
 =?us-ascii?Q?r85OEnEmYB2vjmRIejUfuUEz/0/ujGv96KdvTGzpIkh94LTb2ncl2sROOU0T?=
 =?us-ascii?Q?cIlaE+HC5SakyK86T3XjAp0Gy0m9xYOXlct4BfDokNE68eUDmJaMm3Dt16Ig?=
 =?us-ascii?Q?Uj3l2dKkljwMUKUlckOiJCvK9V8MFlJIel/TcP8MBrz1fBrvWTfao5V64Ovg?=
 =?us-ascii?Q?TGYtHt0rcfZiHCFltRdOUF6izt0hu0yatDPshLSIamzxsGQoX89M0VN6F5Cl?=
 =?us-ascii?Q?v/QvNXO3DquI7qT3gd53QZpCLOAG4UCEN9QZb2+4iTQm/Je65qVUZr9grIj6?=
 =?us-ascii?Q?MLyRyoZ9mIhkvWVMRLCm+TU7DglKtua8WlciFT6ROzyuzKrhWFy5Dbl0j9GH?=
 =?us-ascii?Q?2CP5eQ9rhnK8tVniH7udwPIHExTg+xM0mfSoJFaVuM3spJqG/BHnfh6MkB/Q?=
 =?us-ascii?Q?nNfwU9ZWdcfen+qd9s4bFogKQ6rJ3h18fia2FgontYL4uQUNA97NUW3Ie3As?=
 =?us-ascii?Q?QqsYxq1z+NcGFuR0JfmESVjh7/wIJ3qJJPv76Am7wCke20CO7J8QDhGbbN/H?=
 =?us-ascii?Q?6EShWE7XaZWsFef7xa29mmjIAITzZ6q+rq0Y9B6ngjjCctM+Yx6j6A5hs9eF?=
 =?us-ascii?Q?njtqO/3+W2AzkZusFjtCd8EhUfC/nqx8lKa7DNuSM013b1HYnME3dQUhwGq3?=
 =?us-ascii?Q?K3NrNYeP9mtAQQuf+35ANLMCoFU+64S7tMEDqbJg+5WlDD5roc/TJtKow4Of?=
 =?us-ascii?Q?VnOfi7tzg4KFceROS8xVbe0gkYIkf7QlIz/kIMy/j6Lg/fm/faFt8MwLcziM?=
 =?us-ascii?Q?i8VsDlA24HnMqDjhoBmC8sbrf5XXIlAjE7n0hiye8mMLfQeVg1VD6PIaDlX0?=
 =?us-ascii?Q?prdAw456Q+RgOjPIP/Q5+mTX7jELd2J8666hKju+WwwYLMONHXGIWiCCtTZ6?=
 =?us-ascii?Q?EZAANrUJcskurlLRa5AOXtqKtmy/w7MNB3/3HD3R79pakzrR8fUxe8Ybg2QB?=
 =?us-ascii?Q?KZ7aOLs3qFKgH9aeOu2ayyTDNqzL8VoMUsrdI0FiVefdWOEizSYRpMCeBfRB?=
 =?us-ascii?Q?4CqhQpyscRWrYyCE45naddfaadpJJyDNZQoUTanRHO4qWAs+TukRRo/Tfpkj?=
 =?us-ascii?Q?HSMJmtP9w7fHUH+5eKmTBI5ikP+enGXihRyWMsFxrpAMwqh3qz++Kkq8z0Fc?=
 =?us-ascii?Q?x1LIsv/LGFCqprq8+t1LbsJrPq8FN+9v2BT8KFB3ocbuQXOpPIvgKLYFrACj?=
 =?us-ascii?Q?2tqcdspC276DkCOya9vlB17enADebXQ76nqrqw8uwI/QOovXxJqKc+L3u9bZ?=
 =?us-ascii?Q?zAPJumiymK2X8Ia4A7T3CJZE3A4KbTQFAVUQnZItEcpCJuazkjhUdRJgAAgS?=
 =?us-ascii?Q?mOz9caWlOGycjaD/sT7XOGVEo19gB0nvXm9xsC9NOzcg3DCoqk3SE7yd7iik?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c2de65-ef9f-4453-8ecd-08dad1df7a1c
X-MS-Exchange-CrossTenant-AuthSource: AM7PR07MB6705.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 07:58:18.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d/tv3L0t1CYCWBVGRL5ULgVHBW5JeLllU13oMdfSUswGKEpk4oGiEBdTpp0DnqROi6tO4Jq4WJLVNvetskjafuLD+K0794JYCNizxUqvas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9599
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/arm/kernel/topology.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..fe03f1426353 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -90,10 +90,20 @@ static void __init parse_dt_topology(void)
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	cn = of_get_cpu_node(cpu, NULL);
+	if (!cn)
+		pr_err("missing device node for CPU %d\n", cpu);
+	cn = of_get_parent(cn);
+	if (!cn)
+		pr_err("missing parent node for CPU %d\n", cpu);
+	common_rate = of_get_property(cn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +131,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
-- 
2.31.0

