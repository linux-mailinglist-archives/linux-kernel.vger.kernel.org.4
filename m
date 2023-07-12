Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A767750804
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGLMUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGLMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:20:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD29B;
        Wed, 12 Jul 2023 05:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1YusR6pZFOsHi7luZpS0PbUeRHOg15OMJaqfvkLHd/y29WBV17VqDVCRHqiAwRZUMKY0qpXXB4axT52o/mywG6FbBOhcCmiGgRIfH/L4HxIPzmHaeyOnZSSta/vzI+YrSqdohQ0d+Ki+la2w0xunAX7yxrBywiaTU4WSAvvt3UB/vyE3AhBBOM48KuLmZP3R55WEi7zkCq2iW1MFslAulm0ykUgpRHac83gJ1LWdZq9O1jGWkw/SN8sv+M6hnP0vn2Un0G7+VTssCpsQNgVGr4fiJh+GaMc1zrx5yeTSUMm7cxqsPcJDBTkzm24cr6yb2tBPVquInLpXwlwzTOe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KyH18EUJ3vlZfmWiDB66XBTSDqXPUV7j9Li/DHQ5SY=;
 b=VKT6kV1YF8q5iuWstncWSQ84bkhueOD98/OuSdPfs2ZUCl4eLK9JV5BHN4nlmFP96JpfhiY4y9p5qpH5edFhkXI8BLAfCyahb2WA8qypdPJ9FY+kNvgTlF1mXLlActwL/0KuYqAjefZ2y86Jyg/2QRN1D7O66659IfsWCwggs7hNwCFRk7Muz1uKW0BBbnYZklrJlII1STyi3AtfIVCoymHfVwRgDFlbp3KJmf8dl+1eoHh9s/ejZq8S20MHF8zil+q/lH3JbL3JRpQVeqLUInZsPoVyIL/nR4Bfvs+xF1YU+WtOIMVhTzL8Uffkl97Dv7u007GWMcYUcN8jlR1ebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KyH18EUJ3vlZfmWiDB66XBTSDqXPUV7j9Li/DHQ5SY=;
 b=gBtA6s+3okNQb5nLE0wU+D5hlZ+B3PEtk7VkiwCnJXgeb0cWETNAQ9l3LH/3SB2SfvuA1EH/FvQxncHS9qBeDCS8R6EPghDgUUvkhr79cbp7CP1DThax/+sRsp+KjU/drkT7/SG2yZJZshFWdnutMKlkXdAxN6sJoK00J3UCtF/+umjztWpIEZOBDDZ+SMOSSM0LXoVDu/F20wQ7vOt/Z247YWCgH3mCKSelibT2G3BjBkBl077m2g0oFqmgDs/SD2CG1Ga/GMPDbpIgxv73/ecFdqlJFq3JJs7+4Lf9gUfiUFxQmN09G1N6Pz66iBG8r1G8fmb1D1kygknEB05CcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB4393.apcprd06.prod.outlook.com (2603:1096:4:155::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 12:19:56 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 12:19:56 +0000
From:   Wang Ming <machel@vivo.com>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v2] net:Fix an NULL vs IS_ERR() bug for debugfs_create_dir() in i40e_dbg_init()
Date:   Wed, 12 Jul 2023 20:19:31 +0800
Message-Id: <20230712121943.7597-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0017.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::10) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SI2PR06MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce59582-ac7a-47f3-ac0d-08db82d24da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uK2IOgVA28TSnYz7TLffGKN1bP1b3piaNxw7FJyPY7ArGtFP3Cr2z0DOs7PBUmDiV/Uy4YyzNAW196hr4Zs61EAMYqWE7Ljd+eIo1wGkOaXtSQ8UaOzdBTcz/7bCz1gimqqzBmPUaHdWcN9M8BDp6Tcab4OM2NeDzn2q9Kkk4oIVRFgB2STsrGZ1s4EKhGNCsfgn03T6jOf9FliXiMM0koTKKxtu+jN6tzvzkVVdYsuGb2F0An4E2V0lMB5D5YUCgt6pfxbeChrbhnwFP99QKqCWoGL2EDtQPc/jYdJ/GThxonrrrxrLIINU42w7wLaq5n/h/OjImMPcig1tZnaMCiJ/97L59DhKKGh96wT9XkkqmBnhXwq+4TUBEpATsaaQnCQ/nfAGgsUc4F/HZOX+gN7Z7Ey1ieSiSHruY/jBLxjDPdOw5+zcOeV/HJAt7gvDubSS43ok+T9WQUU13UxQvgQAuxYn0KGGPsL9OoisJtDS7P5LMy+evs55CVh82JLTgUCl9eUmufz2xRxAA7q8yQ23WmiTVCvWsrlggn41hnBKzqyCkdXcVue8QEb1z/9GYPiRk9LuVpHj4Up6zhoYz5lg/F8O4+YIRTvIUDrbtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(52116002)(6486002)(478600001)(6666004)(110136005)(2616005)(83380400001)(36756003)(86362001)(4744005)(2906002)(66946007)(6506007)(1076003)(26005)(186003)(107886003)(6512007)(38100700002)(38350700002)(8676002)(316002)(66476007)(41300700001)(5660300002)(8936002)(4326008)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/BCe8eoFHgU00OvBjBHJJoqqnD7msQg1JQdMjsMj18An6Ce60Hy2Fy6+moMq?=
 =?us-ascii?Q?o8qY/RqLeFHw7JK6NDxIvBwAS/EdMadfd7TVNHHO3uvIBT8GlzVwOk3SqX4Q?=
 =?us-ascii?Q?+21dESRJFUII2MUYmyayEK8fntowbENbS1Hn3COFcof7EdnJyKvLvf3/tCYI?=
 =?us-ascii?Q?f9qZiOevF06ZefT+PNJS10u3rHzJBi6qqvb7MM1x1tLwyArlQ95YxNkfEhY2?=
 =?us-ascii?Q?lIUSXVcJb18229UF4dWprXkJ9FnDhEIPA5Yf3FhktYB8H9DfTCQ0mWK/VWVa?=
 =?us-ascii?Q?Ahlljm/qvR/PPD2F3H37CyI83cvN3uuvzex6kC2bbyygIwBduk66RvOSc6c4?=
 =?us-ascii?Q?W8gZtzl2r/fr14y4QrYOuVdhcDydmT/H4irLtIl+feYJyCUvT7pVECkUNbPT?=
 =?us-ascii?Q?nONIBvRGdPVBO4VKZqTZvf6aB7rMoSxKPJWW9YiBCvriSd+gtC/l7RjOShxs?=
 =?us-ascii?Q?qeJBzBl8l2upGWb9rYbafFpJfhsloJjdBIflYIb2q7s6wJ9vb87N7lf/BQWt?=
 =?us-ascii?Q?rOOD5IQvEFCWHBFLRdvvKyK51iAAWR8cHLN4MuqcOzADAXEDN/Rc66sZH6ke?=
 =?us-ascii?Q?UEAIWmzmeNv1JPfVSEPoTle+EP/LGbCkUIBqpqVEb1wI/dKkL5r4rRedomd8?=
 =?us-ascii?Q?ORWKAxxY4+yzDDL/2r5wwA8FyeEu8zuIAVU3kOqq8JFhGWmk6sKpGF9kACZh?=
 =?us-ascii?Q?TcIyUrwiFha8cXmCGpx9mmOgXPYf83/5D2Xr2LWuipRO7dtfF9VFuRe9bXr5?=
 =?us-ascii?Q?+m8VvuzehP4gL5U4YCxc8uxvDEn9DwTi01OHuqbO4i3OawFLRMf8XAJVF+pd?=
 =?us-ascii?Q?JO+dmRGG1wGuqEcI1QFa3cWzp9hcQs4U1oPhF0i8z0EpT4ThRAnrAL7zNAj3?=
 =?us-ascii?Q?h4iUZRXpIt7Jd1zcUg7jntQbJx5QVZ5X3+FDByuznaY+ixKlDfr7EGhC5fRZ?=
 =?us-ascii?Q?FBoGIUc3yRv/1DoKaQWY+y4SjzILCPvizRiX9Ianlh+4n+7L8jzLCmfbERty?=
 =?us-ascii?Q?xbhtqy2yNGEKIWVRiXjsK4EyfASvsTRmNHcKBMDQO5rIIGraac3xuzoimsAe?=
 =?us-ascii?Q?Sn/J96aprJJ/dhUUZwiGfJi0IJaLHV29BV6d8CCeRLusrFzpsIPNXNfbtEJu?=
 =?us-ascii?Q?/oy8WqPBz3gQZ5vavkft+uiE/p5nZ5ckOZ1y3JDLvvpv8iOsJntqAMM+24y8?=
 =?us-ascii?Q?KxZY8pRFeVVdT/JC470JIaV0NmVYbJUHc3AQHmZMS1Hf9rNl60w3hTvNXgsy?=
 =?us-ascii?Q?HClz+5RgFS5vWsNU6aUMqfj0cQPassKW3zbTfrD4FVuHHMbYdDV1g8pFAIDv?=
 =?us-ascii?Q?hCEfNW25lRKhkwJpnvnI6JKjS4+bdFXqi8dI2o3iU0OAg29sdN/NnUIxnRSQ?=
 =?us-ascii?Q?cXI1Ajff9Avzcc0PNmnh6KahhrN+tIv00Q5+84w9Oy0uTGHCrxrbmlM9B3I5?=
 =?us-ascii?Q?kIzKHfuctz+/pzzZEbBf3EzdAfgClfQX6OuQnkVH+t3ohF4C03FqxkBBObNt?=
 =?us-ascii?Q?FwYNoGeQj6UfPltQH/EtE837kgA7uKc/WED3aRQ+UFKyQ1l++lYPJoZNCGeU?=
 =?us-ascii?Q?VKv2Py+UwMREUKmkuEwkdaOrHN7En2LK8KCNUnDW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce59582-ac7a-47f3-ac0d-08db82d24da2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:19:56.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UMau5IXGzUy5EbptaU6A7b5pqHErLdpGubyvMBuiw6i5F91OMBX8M/W1A3NRZZJTcDIeXULYXgOYUe0260FclQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers.
It never returns NULL. Most incorrect error checks were fixed,
but the one in i40e_dbg_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 9954493cd448..62497f5565c5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -1839,7 +1839,7 @@ void i40e_dbg_pf_exit(struct i40e_pf *pf)
 void i40e_dbg_init(void)
 {
 	i40e_dbg_root = debugfs_create_dir(i40e_driver_name, NULL);
-	if (!i40e_dbg_root)
+	if (IS_ERR(i40e_dbg_root))
 		pr_info("init of debugfs failed\n");
 }
 
-- 
2.25.1

