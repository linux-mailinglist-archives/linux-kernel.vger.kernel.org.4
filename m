Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624EC70D758
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjEWIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjEWIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:24:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B22E1FC8;
        Tue, 23 May 2023 01:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvu7LCK/Sz/UZh7J+n+fnfFmSzFJklPJ1UZLyOTPr8qHbeNUbScLIAa1Nn+x9yadqHWI6gNLLQ+UTGk/ggKyPuLt4pTBVMPlOUPH6ctuLSQe4685iVlO3E8KdaUNRU0GbVtbSAP7mDGfiL15SvTgv30dSzmI26zD75uTG751in1aGnIBaFO4QKBehmyfmNqpR/sUBkg4Del12yG3G+2qNBwbtfQgkqo52p0ABd/C9sAtp3KILGwuEWQNOhOTbRUluoQOoZkItch9BCSrqc6AciAE4hkp9kZC+i6Rhzf9iRSgM0/HOBLecmEm+H9iRAkzYTftuHZTh4IHVKfmHYt49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyl0ERCDU/+Tn1KkfWVKp0nmoTdIQGLAKV6LcUxqOYE=;
 b=eaDFHf3faYIAgoLoxOyqC9cnBfv9Yo/EyrzL1iSFd+13WAdfdIIUU8a9IB4jUpqByZdy6h6YrduPU36PGrqKbKrbQ2wozDgnn0tmNyoKCJeDpSS5BBd9JDpcX2UpoLJhnTY1NoIBcuZDqhNTwa8JIQ474ayjdw3HpIUy3xVhxP6SnbXyxiPXiCMsQ4FPa6/D6wxQu1+CjSWfviQw1M8fSJjfh6ppcqzPNshvN4r1EBmH9ERGUXGaMAcETR75HkRxcfwai1YIndHzU9IfK2itwHuHzW+ktrXi3oyaWI7wgFPd7xdzqYK13wfU76JH7b+vCZbBcWw+qhIZgubs0SLswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyl0ERCDU/+Tn1KkfWVKp0nmoTdIQGLAKV6LcUxqOYE=;
 b=QwcXTx0ADJ8bC8H+nl7DR8MnNnKWRefTcYtYks0p9ahvlwwF5xIhtBqIxmndLIIiYrsFp+q5YCT/qmBKa5esLAtGwg059qxLuKo8JGQvgXU5w7+jI8F1236qbhRkx0otkYVMP8ypuP3zzLNq+gmuOZiooK0QCm6GbLv+jv4bwbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 08:21:37 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::2de2:b2ee:d931:157%6]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 08:21:36 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     conor+dt@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [ASoC: da7219: Add Jack insertion detection polarity selection 2/2]  ASoC: dt-bindings: da7219: Add jack-ins-det-pty property
Date:   Tue, 23 May 2023 08:21:01 +0000
Message-Id: <20230523082101.380-2-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523082101.380-1-David.Rau.opensource@dm.renesas.com>
References: <20230523082101.380-1-David.Rau.opensource@dm.renesas.com>
Content-Type: text/plain
X-ClientProxiedBy: OS3P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21d::14) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TY3PR01MB11797:EE_
X-MS-Office365-Filtering-Correlation-Id: d24c3dd0-e830-420b-257d-08db5b66b9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OUb7z6FWh6cORLxEFEkmovgP1WoJ6BiOD5NCLXfFzj7CA7bTs79jO/cc6QRRe0ZGQoMFrnvXLH5vdTErWXRaXvU/Yo1fN87ICZwoNUBd7JvXZinLEsj5ZjqcA7Rghvn/koU46bLgObzH/PGCBGzjXINKsbR2pKJg5awM+S7vFzuqjygUnjP/k/KnJJSx63cJoTJeKX1XdW/7xOBgW9xZZKOuNbwD9wJqOrHrGIlfUcQf0aNMZ2LrzmJ51AsZ1EiVH4UrrgN0poDyTF/2vTJob47o4JaMnfu2bh65pkOSwBlxKJqYjGnaYU+UvdemsjBlwOmb4W+1/PbUnmHG2k8ZkAPA35UiV9xr1FTdoLTw7wEuKFjpdy4LA5jAKtFiphCI+qw9WdcWG5Vnz3fUYZCMII/q7/vwMDeNCyZpHeq5hLQXaafQrOW1jW0f8rZmxqWhEMbM3mqZCI/Att9ZC90HeDhigyfVeTTqFz9yT7tqnAZZp0zBY2klOO67qrda85/q/UYfOdXjyRRE9R+PSG9CZ3S2La62huW2WmU0Vxd+Fb+bKNeR5lfNCjnMwscV0oNoz8/Iy6bcs4Z4VBsxoRLHDkMzy+nrx2OwO2zrrgaVPA76Hz47wp3tZstsFZdURSv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(107886003)(6512007)(8676002)(8936002)(83380400001)(103116003)(38350700002)(38100700002)(86362001)(6506007)(2616005)(2906002)(41300700001)(52116002)(66946007)(66556008)(66476007)(4326008)(316002)(6666004)(6486002)(5660300002)(26005)(186003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69l7xOLyJfplMESNRJMD+muoJUvTgxDaICVK7DiBDOtyq7ujXmfUXBsz1PrZ?=
 =?us-ascii?Q?KGAten+oBeJv4yehExde69gkrcFqhf8QE69N6j1/SH+w8eD2p25DZs3sAty7?=
 =?us-ascii?Q?jfjj9TdfaOPssVOYFkTIAJXrfb5vpDbJvOctD14Gb5TzogjmtUGjxAQkou20?=
 =?us-ascii?Q?ywfohHAgxXrBtV8Gs70t7ovfszdGz+QlGxLQ7/HSMc6WfUaIhKWhuzXa8UJ5?=
 =?us-ascii?Q?+d5FyNCP9gwTwdBIMIoHqCSkGB3E6gwvsaigIhr3U/PkJrveMsL0r197XjGY?=
 =?us-ascii?Q?dtHvjkv6wWmB5sR1692cXFwPfCKzm3UriqJFvzBWoN+aI1IXMBEu0DNMdB2t?=
 =?us-ascii?Q?WKGvJjtHA3b910+uHT1hTBxcRR4JU5yD2i4DCWalS0ajcfOi8ERG5Z5W1nPh?=
 =?us-ascii?Q?vWlzQ24+7BBoR+Lgb+T1BSY5kv9l49eVEPZ/e7fNBxmBdWG4iG1p1JV5HlMf?=
 =?us-ascii?Q?Y4YBFAH554yraUlL/YFJcNq9ycq6v9HRvr1yJyjjqBvhTI2EEv9QMFqgfh5V?=
 =?us-ascii?Q?bpwB3qkGUH9bmjWWxEwznloIR+PfC3MyXPqRB+4cSeAxeAGP6aSncLixB8G1?=
 =?us-ascii?Q?0HWvKi3qw86HUq49nj8yYLcRNFakjwbk+Piuu6KdXkuNgObXOhE2yDm0z6cs?=
 =?us-ascii?Q?u+5ZNTVqKBrMlbZYbmO0p3qQ69uQ9R4mTrjy/fJ5VE/hWqkipNtE3LZ+qmMu?=
 =?us-ascii?Q?KWXhctqC5V86hwtcTR5jcEHV7bQRq49J9jNEKUbNUnLF5msLGpt4XZS14LXv?=
 =?us-ascii?Q?PgjKbVN+2LoHZUOtLNDME67lYBwWUnZxmBkn3fHnBmp0H7ycg8wXXqJuwkn5?=
 =?us-ascii?Q?BEEZ0FX3AB7lWGQKMNSYsqzvrSiL6FCmIJgH30CJ2YkcnPjUnQZqf6hvuRer?=
 =?us-ascii?Q?DMvo8UAJye94AQJYlIZllA7r4LtKdk5nfX6Fs4NPHPwUQK/1VmHWZC24h3z1?=
 =?us-ascii?Q?3wo3ktvn5hjFtYOWVmjDCXGznALWNowUnWl3R0BZXt7QW2+Se6ucJ+fOaKB4?=
 =?us-ascii?Q?4JdSUBraAgqCKBloyJ6tII6Nlv0Lt+EntYLBk/p3oDePILFsPrwk+mMqwG03?=
 =?us-ascii?Q?1Ly1d6hhjk3SYTUCFZV9Jd+OI/muFrY7JhUrTwQvj3yrSaBoMOLKOBTqUBuX?=
 =?us-ascii?Q?3rKGbjYw+2GVJK5hAEa22Z2s8bfaoXeQdzH7j3dquiRbFgpR0nPFSf72urir?=
 =?us-ascii?Q?AcdUpD9r26dAwNvbBHH9Jf94IPt40O7SSAark10Jm1zsZACmyYYw6vCEm3P0?=
 =?us-ascii?Q?IFxqDpn5K1OXvQDEErRHkMqawkNPw6x5ZGGcNaaEFiMarlobQ4GlZvdRZbx5?=
 =?us-ascii?Q?XYYZuHkXQXuQSeQbMoQhzs/ZSALGjFkbwKViakY7DgUZsA/rptOAYzsLfPb3?=
 =?us-ascii?Q?LXmviGi6XQNWTqqpSb2/uRwC9sG14QEuLbeIdtGnz4tkHicwzaTFojHmcXe8?=
 =?us-ascii?Q?n2vkuljNkqrbhMkJ1W3jeWnuaRlgNqnX6ppQppwWGwuSYUOugf7F131bIk0c?=
 =?us-ascii?Q?L/85sHzfWSDk23SqsGhWC4JDUb6bzHkA/ytfKR2oRgdPf0jfpMtD3/rZfVbT?=
 =?us-ascii?Q?aJzUZXhQ/PLNRdc1AGKdsT1DemBvO4fUoo69zY9192D7wXn3WonDrAR5gb0U?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24c3dd0-e830-420b-257d-08db5b66b9e5
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:21:36.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pz+koEk3D3wq4Hi80vuhD7xrre3SaFMbmi5WRcddSYNHT7IvJBccGvEX4T7FZEQgwWg6U6PKPsh0rduWWC5b0MwAA21k98pSaBtak7lhWCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11797
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add `dlg,jack-ins-det-pty` property for Jack insertion detection
polarity selection.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 Documentation/devicetree/bindings/sound/dialog,da7219.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
index 9160f68696dd..bb5af48ab1e1 100644
--- a/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
+++ b/Documentation/devicetree/bindings/sound/dialog,da7219.yaml
@@ -122,6 +122,12 @@ properties:
           Debounce time for jack insertion (ms).
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      dlg,jack-ins-det-pty:
+        enum: ["low", "high"]
+        description:
+          Polarity for jack insertion detection.
+        $ref: /schemas/types.yaml#/definitions/string
+
       dlg,jack-det-rate:
         enum: ["32_64", "64_128", "128_256", "256_512"]
         description:
@@ -215,6 +221,7 @@ examples:
               dlg,btn-cfg = <50>;
               dlg,mic-det-thr = <500>;
               dlg,jack-ins-deb = <20>;
+              dlg,jack-ins-det-pty = "low";
               dlg,jack-det-rate = "32_64";
               dlg,jack-rem-deb = <1>;
 
-- 
2.17.1

