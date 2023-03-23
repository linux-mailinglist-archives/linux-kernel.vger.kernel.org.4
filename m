Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518926C5D9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCWDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCWDz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:55:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AAEFF0E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAbMjOkW7H7DjkyGn2MGukvoRffbdsfJIphS3ncRzkRWn51yTYdftv1su85F7Vjn7ECKZSxvMgdQjPYaYFhwinnBPCrDZkUSVPEYHB19K7P/tu+JP6ime6lIugR357q+pqnU8u01M/T7PDsn/sz2pyxhcq9gKkWoAlx1/1FPUPWjf1Bmv+y/a2jQVg+rYLOgmjewybLyR9+gN0pa1kjaYqt7RDm3q7RBngq7Sa7KAIs8WmQIY5fG43looK1apyRaUTXL4JW8NALSsd1ANmACXUf09BqrpvIBC2qKJGEIqIe8w0EEpnj0FyR+5PtGhLkAIziYIPa/wRqHHfHJphjlmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xt7SueTP+zxlyyPaDB2S1cp9zshz5ysWIo+LXxSRvT8=;
 b=la3Ks0IzLEBbAz9WI3bKB9cvVa867Go5HukTQuQNl0KFYSQoTeEJqQ9BH1oYdng4lNiGVOf4ZP2gVubOa8p1oCNb/H9XbuD70sabVrSXXe8O0drpVKm9nKOoCE4g/oSRBXbxajMyLNe4sLGHwulLPuLjBxeTOtQwsNpYQPofF459H2XqOnvYsJQU5dtPsUp0suZzL7J4jOeGPYiFmNOwdn1RoB8QTf/CdCVAA4SOVZV3D9Q935KDUTLuDUWGdv9DKd0sG0oOVNkJmv3cZwMXvqpo4oEfQeGY/rIxxAdBx+rfWg0PXURzZCtIMQCMfNOWWUWtzVjc7Qse1hFux2lAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xt7SueTP+zxlyyPaDB2S1cp9zshz5ysWIo+LXxSRvT8=;
 b=NlUsbXUYSBZseSCGsGm4jh0ycEL2kffOiXmW9jDYOZ8mMddw+XqwXOokvH2/cYDadWpbw3Mg/vtVA0vk/uG4PTBXCezUHSxLZEZr1TLtNRVeA/uw+ewOMvXb+ERNBzn3RImIguprcfu4CPoxikXrS/C1LApNfdVWJW3/G6nM+/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:55:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 03:55:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     mst@redhat.com, jasowang@redhat.com, mie@igel.co.jp,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] tools/virtio: fix build break for aarch64
Date:   Thu, 23 Mar 2023 12:00:24 +0800
Message-Id: <20230323040024.3809108-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dde09c-0e24-4ab4-4ae5-08db2b526d3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZQcJh8rblMjfm8vtHt0rSrrTwaImmjQsgTc0nEWAbNh74yEgyUFiz5yaL2K3qvNm3GmtywLmjwYySuOPyujW7Px8rGIjYdw2AnCjBLbkEIYE2AVlI46tolThwrQgins1Gqr2PSIaUn8l9fxyInyt/bHwupMOiz8nut+ikwkUGyR+KxBjHEFTAlC/FJDgRWLIqSJrYDZ0Prkcchr7ODbF3AYi6mgifiqOccqj1tjCeeIbykJrGce6U64qRndWQ13S85km7bDADnOFizswMB8nDIum0jq9JLSw9plEumLw0suRklnektjWQNWCcHSBMbKD3TYJPn4snay7NxQLziCIr0GsQC/fDMfdOTnZ8RxaS4vVhDfdl6ptJvVMb5Bxc1UrkxsQNKcnOxLERe+9qU2+ECdv2Gbwnta4lwM/z+1mvMOY2XoArCSzO+cNhyejWnvZkY89bGOEcazouOjGxqipdW7JmmqYfn9BieLJ0ZTVeJka2DccN5b+KpvQmBwM7G8iO+8EAG9mk0QKMA/7mPKpmjHTEH9Uz7katbmS4yAXk5uHe0qIl9LGW6o7y3SxbE30OMa3yEWdWrdiLoEx78H++IyvEqLqoO8+gP0jHRff6WalBH6eX5Bh1cn6pFRxFZzbqJes8uI9JqGoP5tJMffepj61Md8LyUAA0sHyPCs1zM6FvRErZv1CxC91y5eIKFATguOAYmh5o5hnFZnipasXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199018)(2906002)(86362001)(83380400001)(38350700002)(38100700002)(186003)(8936002)(5660300002)(2616005)(41300700001)(6506007)(1076003)(52116002)(6512007)(26005)(478600001)(316002)(4326008)(8676002)(6486002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JEwM8khd7xIog38tRQjAFEynpgppp9J4z351JlJB7rozhEjrFlSMki6zQVf?=
 =?us-ascii?Q?LDEJ83yf5Rd/BVy+bxYADQV4b+vQWD13iBXwLk5wrsWBFggXgxcNNlW0s7N1?=
 =?us-ascii?Q?3qylDHKlr73oh73dQ7auNDm2pGilE4d93BCsSZx9GWgkqhX5MDyqIGceMLNu?=
 =?us-ascii?Q?SLqJhojtH6PcozKwzFYHPIHGF5Xrry4e5IQYNfjc3Khb5rTotNNmDmz9amAk?=
 =?us-ascii?Q?Txje3ap0IIkHPiXaN//v69TwWsWQxiaJC0/SXYmTDkvDHlW6GgXxeBVRr826?=
 =?us-ascii?Q?26fqtk9SFsPjvrMUTejn8hnKDbTnndpwRL2Ug4MweUIA5X54+GRd1aWKJq5t?=
 =?us-ascii?Q?4KxcoAZezw5Fp0eyYLYEn9OMKM+0d8r9HU6NKzxgFxYdXyujqoyEMq1AD7yq?=
 =?us-ascii?Q?7l6Sv/hzZHlgeWNljyFkaMqbsiuGcal0lTCfAHpwLcZ2uWForfGuNwmGMtdS?=
 =?us-ascii?Q?u9VUiBozFUG5mH58PmP/3ZiXE56CXaRGZjdJs3rQy9goUhqhY+oraf2segD5?=
 =?us-ascii?Q?rLF3u3UGkokcoGPC/QkYjMdfsSIwIiWNmoHTgv+7aOG6GF2rBt5u44dmHLki?=
 =?us-ascii?Q?w6d1gpGaR27HUixNu3yOex2Y4Qc6nsX2Ulw7/It0Nzu/AgWDwgYmsgsjfI+t?=
 =?us-ascii?Q?IV+T4xasyVeOn4TlZl9XL4edJ6AZLVJsGv/ebmIq5dSYXiduOAo6eOtmsMU4?=
 =?us-ascii?Q?3aowBVB4Ly4Ql16BhC+kAywUOIejqAQWBSeXfhr9p7hp99QeSTT2fwIEfa6w?=
 =?us-ascii?Q?If8In+3+ewjCmiPuUqLvnlZqlw5d+WpJ4kh0hE9w1hDe7liytIswRHHv79yE?=
 =?us-ascii?Q?9mD1b1hoUSqt8gdwOe9srj0jvQ9VaY8ZGJguK2sSkIwd1UnL3Uf8KmKTACRw?=
 =?us-ascii?Q?6lEEhmJ1rk7dyMnLUOpfvbFoEwmjkDOcCWUiGL4AzTGfVfI5K9v1Zg69nI0V?=
 =?us-ascii?Q?g8AeaBDWX1kfg/LdD7bE1UG/6UzoC02yaGk/IN8vnAxEDiVJaJlcosD8fpN6?=
 =?us-ascii?Q?7OcGOdVBpj+XSMZqVnRFcMbdJ0+4Sub/NgBflnCb5ESSCcr/xywkkF5pJR09?=
 =?us-ascii?Q?W+luY5Z9MGLZOPwU1x6fBZE50z6cI5tFc9eOMmCbj3vqvGUg0ngL7i6T4RGZ?=
 =?us-ascii?Q?4eb8UQ5iLNX+KSNtT0jI6rdCVdlk4mbyw+9gTDaYqPcmykTEpYsYlYBVHtGN?=
 =?us-ascii?Q?RrUDsCZIeJtkRsXUO2Mcgz1z0TUKbb5TUyr2195qDrx5G3tMtlhCZVLDnKaH?=
 =?us-ascii?Q?kJ+sbznibXSODsEMzzIQCzmpvdQ2jl3Q9fvKIU35EXpatC4Q8tT3DKusw0UI?=
 =?us-ascii?Q?CD2LVNTVNbwZYtoqV4kyJdXYQ5a+WgAxe8fUmRJR/c8EQi7LFqEKOtpu5tcs?=
 =?us-ascii?Q?pAOPdsTdtbfjt/x8pjZEQRvAaHiueFGPm84wvHnSUEHk8vJX2IwFfTpJgHfd?=
 =?us-ascii?Q?luHzaAr5K6+JSgy1E7qnhJaiKznEBRvvKhvnA275GHXJECuWv5Yi68BVX8ZO?=
 =?us-ascii?Q?A7KFJfR155iDaf/NOb24cWhBPvV74de0i62EP6xPmiv/8C1uKXgIlifuo0Tm?=
 =?us-ascii?Q?OsQxGqb+aEZFbXeuRF15jXQh0Phneseg6IsjOqte?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dde09c-0e24-4ab4-4ae5-08db2b526d3d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:55:22.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUohAhzRHztO9aaCLhjo7NrZVkqAUT0l/nfbFjgCq8BFwNhKlfa/xPCc53Gu6GJXYBl20rFmPcXTtE0DnYX/2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

"-mfunction-return=thunk -mindirect-branch-register" are only valid
for x86. So introduce compiler operation check to avoid such issues

Fixes: 0d0ed4006127 ("tools/virtio: enable to build with retpoline")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use /dev/null as output dest
 Move call cc-option to the original CFLAGS

 tools/virtio/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 7b7139d97d74..d128925980e0 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -4,7 +4,18 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h -mfunction-return=thunk -fcf-protection=none -mindirect-branch-register
+try-run = $(shell set -e;		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi)
+
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) -c -x c /dev/null -o /dev/null,$(2),)
+cc-option = $(call __cc-option, $(CC),$(1))
+
+CFLAGS += -g -O2 -Werror -Wno-maybe-uninitialized -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE -include ../../include/linux/kconfig.h $(call cc-option,-mfunction-return=thunk) $(call cc-option,-fcf-protection=none) $(call cc-option,-mindirect-branch-register)
+
 CFLAGS += -pthread
 LDFLAGS += -pthread
 vpath %.c ../../drivers/virtio ../../drivers/vhost
-- 
2.37.1

