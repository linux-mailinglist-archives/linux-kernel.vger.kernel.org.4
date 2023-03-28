Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881A46CB61E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjC1Fi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjC1Fiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:38:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECB1BE4;
        Mon, 27 Mar 2023 22:38:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7OC++0rRoj3zN6/K63R90bdNxm1QS/2Es4V3UQ1XK9zXd5ktPoF6920Y4AoBWi3hibMdZvDRP8/91fXE5AjLu2QaWmMs/dnzSAjYEbqtxpoxTtxxUNAkmF2uuK796ozpn1TO6aKFdaI0IXAvSbydUUYQ/fCdPc8qpsy2gxQcM/cUrPfDsD/8HapeG3ga0lzvuU56ySXC46lxZayO2nIqYOG2SJqxDdrBtJG8hbFKN6avrO2vvyKFeU5DKFTbAKIecpLcDKc9E7zkgDHqbyZqkLOBbGQGSKkgVzVtp0SCvepGmqjnPk+FapF4sIsI79NGeCGsF4wnhIYbAJvf2sMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bdPdHTTPXwNGzR4IyQE/78T4bAJxlivp7alICoECTc=;
 b=OwtTWDgfm3U84W9sElAQFbgpez8zhXPRUYTejCROg76aZRq8ADLT9B0Yc2NwTK7huki/2ST6IWtxlI6KR0/rFnmBCpsbQhjMgrzbDhNjUN6wt0o6WeroozbSse5KBx8Q8wsGpww15S0Kshkw+uBFBYk4OKDVVXBCi4Y8G6fRSQPQ0xC1DGoGvRztMNw8wB82KGerdQvH1T0EXScnJa5eJ0IDxI2q8u1JhENpWBIHI5znVC5zQ+/1hejZnvMyIEzXGw0Vf4ab70O+Y63z3m5RnOwV4c1o1pvMpihz+gkKiGoAWdYyHirS+dyci19gmkjf5bLsyTzBjIcTy2iO0m5QoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bdPdHTTPXwNGzR4IyQE/78T4bAJxlivp7alICoECTc=;
 b=eFJv56YGuUqt662hxERiXMMlQFYCZ0hNL1+SUQQD7XlYZ+c1ULoy8NE0CDZTNPdTuZNwjo0Wp2o65uZ8fU+4Lumbdit9U213rWGlFCB9Qex4NdqEGlJRli1gxjzzbgWKqtZx69krsd3kk7TA+5QBEPIHSODAoZd+ryjz6kjR2z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8129.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 05:38:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 05:38:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: serial: fsl-lpuart: add optional power-domains property
Date:   Tue, 28 Mar 2023 13:43:55 +0800
Message-Id: <20230328054355.1973397-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: ea6d9b33-ed8d-4ce5-cecc-08db2f4eb469
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCnQaFzkJ631MMfQeP6MhNrQitE4Z9lGe4ue1IWMGWSmE69hAClTDnfNx+cY9fQobL9//v7UhkZcpZ3lGzY5GTKGBF5tq11V5xoegpJkc5bDGPsov1uubnyiO3eUas2LHDXzM0j9552F/BQrYVxFAHacfNqPu3jfb9DCXsXLZ4+wQ8RKqehRXyBbzDXqqNo5bpqrjuXyBSUGbKeUpibKQh9hKbM+PuS/CDP0KPxT5K3Cf7/7YXtWVaTBydqDKDjhJg+QwZRGUtmscnJCf0lxTJFFzOaVJ4RLjLiN/6ZXB4Kbjp0q/49vRnrWj/rK3uPUtfo8eAri4tTj++6oWsi0DRaxvCbPs7gr5bVy5rdbAP/y0q5cRRSZczcWw9n6TN8nsUkfEtRqsICjhk/d6vdOGFARHorVIlfiWzexyvKwVMmQQEHGek871HQWjpLubgRj2t7iFKSHC8qkfF0z1Dhgn+X/hhgTEFb772rzU5zdIwAzt8eKeQctx2r0qhgZshW4faKbwGg2l3oYn45CGaQhvkoZvUcWBBy9EDyDbPTeLJsod2P54q+Nbeutby7zXYHIPcKiHh/knROnzH04NFBcaCbyyRHcVQTUV5vFQrZmtJBlagrw3QaTfsSxWVflV88J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(8936002)(2906002)(52116002)(4744005)(38100700002)(478600001)(38350700002)(86362001)(6666004)(6486002)(316002)(5660300002)(8676002)(4326008)(41300700001)(66556008)(66476007)(66946007)(186003)(26005)(1076003)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZNgwQMNRFDDLoueRDnuW7fWYLzDkRE8tM/XIU+NsLZ9n2LtpsqvrKhIJuG+?=
 =?us-ascii?Q?jWIRWGK1EKDYnhDBBVERhRa4rxIxatJUDE9UUW8lbi7Ukqf9/3DGE4wFag5O?=
 =?us-ascii?Q?JisxuIGLuhvmAKjXu7RY3WraAY9Vyv48A9Ptzln2D4hNwHi65vxvU/aMDAuJ?=
 =?us-ascii?Q?MnjSMQJ3kpMfLdTUKzg9yVx8vB8X2xNoOb94j6CNZYYHx86D5gbPbIv+Ua51?=
 =?us-ascii?Q?4CndfOLsdtqQuK2U/ePhV1c7wwGk48LPsiwSykLCvOqgBxAa90RPmScY1SJY?=
 =?us-ascii?Q?J7Jk5gNs+u/JRecaGabgQD215zQSuYbzPDB9ab30OKTZneYjgr73rzG0vT7b?=
 =?us-ascii?Q?EbkwtFgPJRIgXgntm81AwhOsq0E091IBwaIcdav+K7rKfD2oU/zrlJfQUMZz?=
 =?us-ascii?Q?w1S6jbAXhe4NTHdtvoT6izwEj+rM5QZByxthCsoCuVrPOfGxX35kLSFSRzpy?=
 =?us-ascii?Q?rl6rlw9fqhJrNmAz7PcAyMFOJ3GpPBG9D+kd0za+i8AoiUA0+3Q3AN51f+hL?=
 =?us-ascii?Q?IufMYa41+Z3yMOUUatw7LjJeK9U3jokGOKxgf9LWN/K9biAjZlHlSZ2VVpRv?=
 =?us-ascii?Q?VDCW7GYP/9PYr2NYdrSPNx5ZSq8H7grwepDNH1Z9C/6UkCnQOsnp/ZWmcLP9?=
 =?us-ascii?Q?6fxP98q8RJGucQa2u+DgHJy9upFPABeiBLaQm3Vbl8pPCB1QjwMVjz2jmf76?=
 =?us-ascii?Q?GFm6VZxu3PDS+hBfuSo/eJwy+VZXqakwdF46x6lVxKVIlLc6EQHJURBWZeGh?=
 =?us-ascii?Q?R7qgsy/03vMkCSwntttZK9FmyVcIALlOyj4zRZpRdPlYdZBEviLracVV09So?=
 =?us-ascii?Q?DgoLyfFOTM59+skRcESG815pv7zK8FPOQ8UUYQovvDNDVZqhgsSjbbwgzStH?=
 =?us-ascii?Q?e3zJ1jS3wcNEiz1ZMie91Ab21fLXt6sdoHovNMGBRpN3B76niLUSg0uJRzYx?=
 =?us-ascii?Q?ZhoqBYL4VhkEJ9G3miOwezAPX041k699mMrARm5QrXSkFfeGaLknywyyqEaX?=
 =?us-ascii?Q?z9CHT6Vwlqrf8YtZvzu7ILZKeAujb1aKj0/rTOTfY9aY9kG3oYkRtODvUTgF?=
 =?us-ascii?Q?PbMojHhU/EnV0N88ljLzIZ+R8Qqd4VsyfvnB6CcuTUtt/wQiULtyLXhjJgtm?=
 =?us-ascii?Q?tOaGikQT9psYFCCOZQ9d3ldKk6p/uci0T/p+mLfU0sV9apWv9VR2hkHYW4sT?=
 =?us-ascii?Q?KQmVcYTnw9H0rzcnOpjVjvde8kNAFy0G3np5anWvXZ0OjY5cKIvATP/ZeiAC?=
 =?us-ascii?Q?XZaB36Nw6+UTrPA9+FvHrlnx2JXrG0r/w4rFMWpPQ6I0BbVcZHyvu4vvhJE3?=
 =?us-ascii?Q?UCiZ32oNTuBGjpZKSKX7ozwGnWDy3VEBU5zDAFulW6gINDGVQUssTWkh2YKi?=
 =?us-ascii?Q?hv7FYz5gff+lWY74rturEBkJv4fX3ftTvk+QS1N5RFpB9eNcS7iFkXUWvxWD?=
 =?us-ascii?Q?rMgqyF5ytcWVBnfCjLnKPDAGfl6f5RAYX00RxDjZHl8sCVznFqYf+W19vHgz?=
 =?us-ascii?Q?/0E8iIthJmrU+Xw5Zoj5Ztpc0+1PEmjYtWvPcFizlDpxpzQ6pKisjkH8ms/3?=
 =?us-ascii?Q?gWvdLQC0Pjqmrz+UPrkOKtC+mhp5u3KOSRN/PZm9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6d9b33-ed8d-4ce5-cecc-08db2f4eb469
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 05:38:48.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPpHqfY33pNDhk4+5+pgLf4R5rCxyQDyx6U/dqrF4eeLvub5eyURquke6EkwWKDf8yDjIZlrEPXIZhEUgcD3lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8129
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add optional power-domains property for i.MX8 usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index ab81722293d3..93062403276b 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -65,6 +65,9 @@ properties:
       - const: rx
       - const: tx
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.1

