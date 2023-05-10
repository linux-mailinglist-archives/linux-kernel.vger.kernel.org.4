Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9226FE557
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjEJUpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjEJUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:45:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F351718
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xs439CFsXzsTFOIfB4roC5tTb3tt9BSLsCjkXLQQ20G6e0AW2cS96eWeulywyWcexunnaRonp+7Uz6+qOg+xnxta8bR26fVTLQzRw/wLZXau9xEKjYenle+sWglheKJ8uKTV8xD+xdwMan7SIMYvdXB1N/5yuRemWJEGwGrqH4uWdwaCgu3vz1Wgt0Hr3v5OlRK/0SS46PfObQt1MJtkFvIUM7wKfyC2GgPOqANk78UlJy81IQAqEALbYQV94mrG7cYu6EiZ4qvFtphGdHBgfy8QYzm6r7qI8xHExDs0o8YHiGFbURNwq/OKKJz3PGMLIChDNUBi5oisJ51HS21xCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy/8gBqBx6ggr9bu5sN9/4QXexOuOjBY8JjbGQErNJ0=;
 b=FBJSrMr8OyipEt2aUAoamnRTFijxCy9fHDAPUCwucFntVU+LvzofMY87zYkDoKLO+/vFwM0AHZePDGsrnDsgZ6Zpo/028umrF8Y1qggt6SgwgmczihpnPG3/iDgvFOKKcSQMxm5HuSKEc51N1pFfmoLtQ9+zy7M5MlDxlueJUBtXqLCNKFMZcrALmXngdB4adGQfvgByW5/tZFMpBM0q5ydlB4a244SW07jwQXMvUyMKTgNwLT/3pRO0BNtdAJ/KXoo5XexT43MtgRxvwUidqJIRDxkEjW0HMJoTjrIIbl/WBG7dFBurbipsFFp+M2j49cefvEzn1T4usQ+b+ybFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy/8gBqBx6ggr9bu5sN9/4QXexOuOjBY8JjbGQErNJ0=;
 b=SbadI4xsPZTUSF3Zs/K5F1nBDrX9aT514QHlfdR/lYWXIvxeQArShw994ToABl/h3rDk9nHJhcEI24HDUaSVI3v612iLMjpebqrimJC35MyXBT6wP7KYtCp9Mq4W2k5b5B8lfOox2+jCoTww+b/Gb/CzPxgrfsJj2n8KsR3dDDPjvc2SqvYm5cV2LcsHtxIbrlT8sWKjkFqwgVqVUrs4s9z5CSzavmwEFk0oghMVv1hZADvBZq76ROvHnURigRNWhc23Jca2HmyOvPDMPo4XdKwBfl+QAZcuaqwgRBKtKcLy6O9PhkHBBTkWg6xz98QMZ5QIvemN/LKMi2Xr1Nbmtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6468.apcprd06.prod.outlook.com (2603:1096:400:459::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 20:45:08 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 20:45:08 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Icenowy Zheng <uwu@icenowy.me>,
        Wei Fu <wefu@redhat.com>, Yangtao Li <frank.li@vivo.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] riscv: Add the T-HEAD SoC family Kconfig option
Date:   Thu, 11 May 2023 04:44:52 +0800
Message-Id: <20230510204456.57202-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 3186cd59-af25-444a-885c-08db5197707c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vs12hl+5cFp1njyw6FUquG+rphiTdh4WunP+Bbds9vSqUQljz22kTLT1y7NYHKGPkI9zmHrEVrF71M8zZ8etEK6s/RZlHyxpMkxlagQCLu0RgXWn0INH4ER7HQq8a6CFigdakjuSNKKvIKLioezsF9t2OxQ/lY0/25n92S69KQf+MY3ax9jKqDKTSiro0/WM9AXuRW4y6uSBCoDK5gDj5KafX6e16ydqvD4LmpAqo/8niW5Sc+WgLw0nmcgE9gb+PEL/zhp9uSiQmfIb5WJooFvMw2FsNFea1HA+RdOMssQXm6X1Jx331Bndor2n7cyzm+K3Q2DbXfNXMHexITVU/oIUWGkaqbJ56VW9MzRRDZbeKh9y+U7sYxmCh+gqWhQB+Twe0hl2t+FH/BcxXPhAie6ovkAfGL/cLZzsK7dpDz8WH3opPTKM1DrVhDdWSkgs+H2d40dXoTtq/RthyyokwJ48i58RAGBYoiBrsql8bWDgOa2hJJNKf2FiRbAHbE8lNc5tzu806J2/pNWHQNlBWPe+hEX4P23ovie376cssAAopQqLvq5uNWuntRuwZSdM7sxXnfqwAdsZL10dIkOujsV2il3Xb8VLkZDmB77D84ZvUdDJOyRvwUKyk8oq9XEn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(6486002)(6666004)(316002)(66556008)(66946007)(478600001)(52116002)(4326008)(26005)(66476007)(6506007)(6512007)(54906003)(110136005)(1076003)(186003)(2906002)(38350700002)(41300700001)(36756003)(86362001)(8936002)(8676002)(4744005)(5660300002)(38100700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVOKM2qb18HQcfvyXAKUjSTPF1xWl8uxQVCphPyacPztMZY3iW3cZyGXLj5f?=
 =?us-ascii?Q?BCdaFd4WsULfrE+whShKKs8neydK5p3QzAl/0p/AC9DrTwvaDIio+kOr0H1k?=
 =?us-ascii?Q?EJ4mD6esjbV5awIFLNYcEh/8yvYIxAsyJiHbiV6Xi/Bam0/UlkJZqhEAsTd0?=
 =?us-ascii?Q?YCXPN8WNvbDrGT+qT4yS/mSJM8kG9sAdZVeRafr5wTPOEPLumcD5NDhTTWum?=
 =?us-ascii?Q?Sj4NFYvmnOr1ZVCvdkiF7Lu61WtdWtikGsv+TKBWsGEDC5CSkmj/BBIU0oMP?=
 =?us-ascii?Q?qvqZN6/sIMxYV5PKB4RTFOVzZR5AyCLGTUhCWX6Aqlcq3EyD1ibudpTw0ilY?=
 =?us-ascii?Q?clQpllyigoJmtgLVwd+BsL6ngT/Bcv0GRfTo/xsStDCvMfon3HYiGo+4k9qc?=
 =?us-ascii?Q?7P4dv8gk7y1IB5vivzHNJ4OyQrQRFLfulRd0STeMukS95WmgIMmjhMk5t2pZ?=
 =?us-ascii?Q?ZZZbAVJF1tkxE7qEaoS6e+39Emo0MSQOd8F3Q1azinYHL5PjOePhrX1LjreF?=
 =?us-ascii?Q?Usu656mR8MFqn6gi3z3+p8rHBs5EJdr5GIlBs9ecLa8dkGXnCN1Orm8ZRPo3?=
 =?us-ascii?Q?RXTV7peB7FSKMNyevyoLmiDM3FmOAwYdcOtgz73xTSB/x/hGatrim88Gz4t4?=
 =?us-ascii?Q?JwQxlF6J1I1/1v0ziuUI5RED5Ory+youjyW2rDry9Zk+Ij7Fy5Kbn7fHW+v0?=
 =?us-ascii?Q?VlzW+ZI3qErzfHO2IIrULn4r32UbPtVcDErSqpFFqP2Nw9dpH2PeZe1LoNf2?=
 =?us-ascii?Q?PXGoVW2uB6mvQh0W/Xt1jg0P1KrkvfyBwmkB3XoZuvXqMalxYHQ9EmagHC3n?=
 =?us-ascii?Q?J/H92DpJvRUKOiUYEKIjs9h+qcz+QZZeTmd7XjL96zSsc+VtTqMRP95PcJVz?=
 =?us-ascii?Q?gUtIg0l53xC5Kz8NN1D8+L64ZULvLOeL1KnSCepQHZnRJAqMESdX2pl4VfEb?=
 =?us-ascii?Q?YPo5vbvus2+IoRvSYOJY8HLsG0rlugqQ7eolaFlT1hABCuIThrrpaSvp51zd?=
 =?us-ascii?Q?qzs8NpSVH2sIx0NAjLkT2KBgFIvqp4LL1ha5+scHIsrbXNvJ8xJwQJN8Xfu5?=
 =?us-ascii?Q?SIXKC6crqdFGjgCqbMPmKlP4/X5tpB+37XNEXINNwFLl7mfMlRcymj5mxwtf?=
 =?us-ascii?Q?ke14W2NzVcHc6LHEt4moMsPIux+MeZG5e620jETJ8GX8gIDI4BVuknBdl/Bj?=
 =?us-ascii?Q?23B8YNvc8qhzNcmX1apgJ2P7enpSP1cGQmGx+dFZvJPJFodgLVuacACWBhcO?=
 =?us-ascii?Q?Vqx72lRCkazbNqsBAD+UmfOTyIwAmNmUACJXkoDfZ5kgg1uM1vxzViBxBH1V?=
 =?us-ascii?Q?p+0ohxwLgYNAZdtog+95QfsdqkrxSZNSS0fSofgISZrKrgvGQQ+/T8XSunOe?=
 =?us-ascii?Q?Kp89px26kcRnCWkzo8CJppnFkCu3eHWW6CXquL2cdywhDyQ/TEihTkkz41hR?=
 =?us-ascii?Q?NJre+yFCKSo9DSMXGNrguQytVVzK8mMqiKiIh2FKjYwMtBtEoHIxEzSg/jfJ?=
 =?us-ascii?Q?A8evIoheiS7cbO5o/EjGdl5ZWrSWmfiD4Y07/Cdq6rvnfParFdNpdyodlbmM?=
 =?us-ascii?Q?pYf25J9rb2djAk9yTl+SdFqozkKyfHwMImHUE/ab?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3186cd59-af25-444a-885c-08db5197707c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:45:07.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1/jTYI62nBs64l4zEIahXf3Fb2yopmOPUGWIaj/zD+rs4iq+w4KpdI7H1TTEumeW/3QOcuuT4qhWxbPDHyePQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6468
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

The first SoC in the T-HEAD series is light(a.k.a th1520), containing
quad T-HEAD C910 cores.

Cc: Icenowy Zheng <uwu@icenowy.me>
Cc: Wei Fu <wefu@redhat.com>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 arch/riscv/Kconfig.socs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1cf69f958f10..ce10a38dff37 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -41,6 +41,12 @@ config ARCH_SUNXI
 	  This enables support for Allwinner sun20i platform hardware,
 	  including boards based on the D1 and D1s SoCs.
 
+config ARCH_THEAD
+	bool "T-HEAD RISC-V SoCs"
+	select ERRATA_THEAD
+	help
+	  This enables support for the RISC-V based T-HEAD SoCs.
+
 config ARCH_VIRT
 	def_bool SOC_VIRT
 
-- 
2.34.1

