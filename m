Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B9F5F76E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJGKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJGKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:33:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2069.outbound.protection.outlook.com [40.107.215.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6055A4621D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlDCYQKH3W9aF5cd6Gt6vrpOEmYqsJqChxupWcveQrLEupaerZJ3n2/sxVdR3lsbpZrvpz1BLfn+VmwYAMgCOi6Yh2QR+kXwUf+YodoG6dTPMEFd5zhk/mXvn2cd8PTgULpZnFXq+T6Zp5sa23pEUipXpzb+4V96t4UR23tfXGEXnFT2hbezripojG9DNAxLn9iIFN2nBBjJbbLvpkP+UrVT3s6GtNHjs6C7GPLdqlH1obDqDi55QnIJ6Oh5V9ZYNq5770/g6d96Z185/5E1Fs6VGOaKXiqlqK0wJmJ4LC3d9eyilOcZPdUWzNAxBHnjoith5o7mp3/AzLxwZ6on6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE1YhwTMKxBPyyLb0JqH0cyid3TYieoLtdw0TZmxMy0=;
 b=DvB0Ua/92LbDC7N447Qc4VoH6VVL5hvvycwYo5Z8T7jup5gpJf+5TcSuL7AUFHCRFXhuy0HI1SF9j7H5xnlnlzivmabPRk7jKVG+2bvuyaKg7aPuAlbUJp0RRGztB2nmD/QBkuClLSvyJxljsQ7lcXknGbziOQKfhpGgSWpGCxI1IGfcBExn/cuff8qT2cPv4g1rQt2G90FG/sj0HZyim4EoAD+8CzZb6G90Fsg7hWdbFvYQWEXXFGPQNT/O1ZAN3s24KI3WStzJ5FIbzJih4Dc46ufMwMSgV42131K87gzAnnBl2DF7y0PlACiYkEGNqLU14AwMP2VH4sHryw038Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE1YhwTMKxBPyyLb0JqH0cyid3TYieoLtdw0TZmxMy0=;
 b=WjRqZwxKQpCZ/m9IxdLsGEtfkM3eFJnfNj9dYW2GwPwtCHhgX/fxAxljXfHTdNVbmMJ2TN+wlRwR51rTddvaZ2KyuzED2TFcE/+Asfe4LM5deSV6aQ849Htpj6nZ4+3Mas2823KF6PThRlPYH8ZH9RdpR98G/mxcKOSZoPFVt+VpH0SUuE5EAmSH1l0VYUOUNRO4JAXaGidnNgXhwDDU0cR58nB59IXdL/pHhTXv042azbsZSgcDepZc9pLMAhj2+RWK6GP1/M/yXpR0yci8MX104wMg4ep9gtb79WjUVIj+3Uee3isitAz+BSsrbFUmfoUNCxsGIwgckh/TfvjL1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB4300.apcprd06.prod.outlook.com (2603:1096:4:15f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Fri, 7 Oct
 2022 10:32:58 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::aa83:33dc:435c:cb5d%6]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 10:32:58 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] genirq: Remove unused parameter force of irq_set_affinity_deactivated()
Date:   Fri,  7 Oct 2022 18:32:36 +0800
Message-Id: <20221007103236.599-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|SI2PR06MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 415e663f-ea3e-4e01-aeb1-08daa84f4d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99bv9d2Tiw+FKVFLG6GJlB1VONz6+GjXQxKMQXvaf6UY7+Y3SZEaE4eOeN/oG+NJabtU1ULna6U2tTNxguU784uL2zA4uxpiszAKcfWV8BVvyuhEgjtnlcmci/XGfkK+8Ei97fVw0E8RgWWW4AMnYVABnQmh5bhUFE91qDw4YY86RA7ZMReJFSAVd7d/tmVaC4jeocmWeLYy83R3rzqgB0YIW9BptZ8p+MVEV08K2sN1NTTFluFOEeMaDQL1jl7H6+tT52SUtR5Mhdiv68rXXm7bxXCTkAqJC3d8sM/hpQ/u8NUcCUNnjNaw+DeSNrZtznUiD7yM8RlZc8sQEtH04uwKVeZcpHHojhlz+PbxZYaeA8vGxFZBSJJ4+OoZspjyBoM1J9pMJinTr3bSywDc/X/h/jO4ScSf/Yv4qsT15P2yUowrZL2oY5LKS25+P/oygItm2G7PUQHLRQd4Qp0GaqPunFNUyjNyGzH23LxFIHXPkWubpHh3WBaU+r5mTM/XQUJt3KsbjiVdkfrZQdUeg+Gu1Zo94pYo6OjYHBVp1uainqcHvZj0uMA0YABV0W7d4g0FzpTUqmDombd1PvDurvZD7XGEqOn0gf2sMzzgVbn9SamaPWER2wxZA17URUpqiUoADlWjyXXuILsV4FVki5KvPL9odlGecE5oPB5Mt3cts/SB++gj15OxnBo+caR2xK4xxEaiFdVW6xft970FxNrJC0cbzLAMpJfeBRDgAb67SUuhkNqemHJvdk91SQ2NOFczCNcznpN1J5D9NlE2IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39830400003)(396003)(346002)(366004)(136003)(451199015)(83380400001)(44832011)(478600001)(6512007)(6666004)(2616005)(107886003)(38100700002)(36756003)(38350700002)(86362001)(41300700001)(66556008)(8676002)(66476007)(186003)(26005)(52116002)(2906002)(6506007)(6486002)(8936002)(66946007)(1076003)(4326008)(316002)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZilrojfGDlnfx2JaAwWOaBzpak0sAvjNbfNu5JESLSWWeuwyJRMR5aqu6HuL?=
 =?us-ascii?Q?v6D4nWN5YOE8wJmt37B/5B85P7bpt3LTIeTuTvXbGa6HkXIoj6k3XxUjCh7M?=
 =?us-ascii?Q?IzkHmpanmpNGm6a0v7apq9IzpTP3xdtedMHn2d7gR1PymDQJrBsiXtVBz6cK?=
 =?us-ascii?Q?E50a+IlYaRuBUMUWBux66Hpd6YEEDinVwWWno1qQNuYLtDXKuOnlIZ89eQy0?=
 =?us-ascii?Q?At+X1T71YQ2k82zFc1AX1HhBoA19qyBE7tIXCx1jh6TYbgj2PLegQ30jwXtE?=
 =?us-ascii?Q?AcITSAPW5PkvPCV1AQRU8YpgknR/7tXOGhIUxz6KatoPnEMkZv1YjOWkI1NR?=
 =?us-ascii?Q?EaSsjgtwanEzx5JAzAP2qk7D+9KFQeYHVj67e0nvQ+elqCiCJ4I1TSOYRoXg?=
 =?us-ascii?Q?1uc5UR0iiX9o/xxiOw7kMr2Kdnt9wsNDzen10AklwK7jsiPzjZ0tttSHDUNW?=
 =?us-ascii?Q?PpBQYVT8WKqQjtIJwPO3gG7dRMDoOMX258o1Z2jCcxwAsN7F8Jz8sMXhyjF2?=
 =?us-ascii?Q?ZcF30A22uHOuXs7M15nTc+AtFj4BFofo4jvf0xHsCcs1esFL1SvkzzSpNDvt?=
 =?us-ascii?Q?yNzfS7Cdykou94ur6BlyO+/dIs0SnRN+Sr1dDd7Wk13Q5uLL/w382rZZT78g?=
 =?us-ascii?Q?Mop034j/zvDygjvL+U6dgu2HP3C5Bkljczc67Fd2KjzZIRZ19ddkaa6yz5BQ?=
 =?us-ascii?Q?pe+5L0vDkeCNmfuoM5wir0rYl+vONmUbQpF7iTiVTkYqAb3YIRwpzkW9OAQB?=
 =?us-ascii?Q?ITBLz0sBB0FqNIMbBDO55/045gcNFA6ByNfg5YVUKrZYfPyQOi7WJg+ltxgo?=
 =?us-ascii?Q?ol6F144L9cnvZukhZnbPVofuxmR1ubnrga4gtJT61JkSFhRdchMEI4TMHpXf?=
 =?us-ascii?Q?Xn5Uwiqqdmmvu07tI5uSRzfP62ilgXyj97rXUI+224WIQUmOYA/F+ukI3k+u?=
 =?us-ascii?Q?sMkFadc6HIA5donQhbLWz56s66UOG73BbuUq4AqXxFWUg+vYvyl68D/v2zBa?=
 =?us-ascii?Q?M3mpOn1nqvLxlWoxYFkG/gv4Gm4RScCz+ngijNMaZ4oIcdPfb4I350cikQjW?=
 =?us-ascii?Q?NXSTLA5mmSVqvXdKY0GgjwYbi5adHqyB5iQBpvPH5u9WwkoTHXkYRBXG8wQf?=
 =?us-ascii?Q?eWPnhCbHukpg34hbvvM1ytzcLwRtzEIGQVhgrN8N9ylfZaYDrEFQiVAKasDQ?=
 =?us-ascii?Q?wFvUFuJJZvxpfiT/+HWlIrgePK9XbN1By3hyCo7gn2ip19Y1EPRASZGzA2T7?=
 =?us-ascii?Q?iPaEZYM21bOIQQiTc55sa+ewg7pKLwyURnYwRMsgcMhy6MzX79AqL6eJ/mhf?=
 =?us-ascii?Q?qjrpQ8Qjx1uxJUaohzgxHe5k1tZMREncL/5kMClcOPbq7LWJvm+Uw6FOuE9R?=
 =?us-ascii?Q?W97HiAZMVCegAsCeRIEgJEl/T/RI4XBSyRBTJrkiOqjCtdV8PhwjUi6R0C9a?=
 =?us-ascii?Q?oWrOsf05xtPqQoTd+fppoORLivK6/qYEnODfy/EM8E5//nbcbqxypdgAESTj?=
 =?us-ascii?Q?dcDPs16A5kyAmZ2ynGwsdlN/13VpwEtDzTbv9B8M8uZx/kK0lM3K/ExhaD+J?=
 =?us-ascii?Q?0b4MhPlCx+QS3Hl4YiHyKFs3epIeC+FSdbdz7cGcma3Ap5ZF548r1i93g5Rl?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415e663f-ea3e-4e01-aeb1-08daa84f4d27
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:32:57.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F13jQqsbl1OE43qSNfvMMdpslENlTf/K4+wjLuyW7gBxhFvIYCHEszICMCyIvjE7zgYwOag/HHVqxYmN7v58fJcQLAOc6OQvZTHUkwZRUaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4300
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The force parameter in irq_set_affinity_deactivated() is not used,
get rid of it.

Fixes: baedb87d1b53 ("genirq/affinity: Handle affinity setting on inactive interrupts correctly")
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 40fe7806cc8c..5b7cf28df290 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -321,7 +321,7 @@ static int irq_try_set_affinity(struct irq_data *data,
 }
 
 static bool irq_set_affinity_deactivated(struct irq_data *data,
-					 const struct cpumask *mask, bool force)
+					 const struct cpumask *mask)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 
@@ -354,7 +354,7 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_set_affinity_deactivated(data, mask, force))
+	if (irq_set_affinity_deactivated(data, mask))
 		return 0;
 
 	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
-- 
2.25.1

