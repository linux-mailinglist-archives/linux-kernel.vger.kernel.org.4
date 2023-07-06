Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0B574965D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjGFH3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjGFH27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:28:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2129.outbound.protection.outlook.com [40.107.117.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B3113
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elk3lXlfe8iv+QhnDHaN/OrjiKM0Vwvr2UlQcsgjHoPZw/JzHYYnzQFhQUZyMgeTCZE+O8JW3q4XhwaTZBZzEfja8B1VxYVNWD3yId16N8RVHwxejl35Sm1lB1T/xPR+rKv+pFOWPF9GK26LGe/WlkN+KrR7vb77DovG5pWz8zPlsGtrApqoxguyi2nO5NhCCavTl6Vz+NnBBYuTzN95h1bnj3zP0b7BH4KZX3XauXuRjHXFrv9+qJSVvW1lJ37tNelxXWVP+4zgzPDy405ctMnEmetBxpaTNpJQHzu/qSyKVpvdw0FDbk7HYlDyllDdMnfF3jyNqwGrvGD6wY2srA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qfj5U6kFi64V0m7JWmb6NEKQsd3iz82S1T51uxK1qgM=;
 b=EXX5TOMKMundc9V5AC1MGlt0W/ea2ZCtvsydp6Cosp55ge0zds4XQzJ4LASdmahBt5H+rsrP/YlRn6Od1JZTEMnz4DyMdSajpG2kTx6zp01JfHwusy+HB4wHKLAQKWEifnlqGMBbmpJPkBqcRH6WBk7VlaXQLGg1KOqGOmFFIyUpUIcRNHp36c+08B81a6m5YPqABmO5pRsZH9lHbtE+LLE8nWNPwfnGIDIUBxUuaOzs/VLAFj9w6s0WA+j7QFTfd42LYTEyzSRmeSApur/TlSAL4KTp9LPr+LVDWa8arkW68sYR4Vab6+wF+dTRwU8Sh5+jJAtuQJF1MgrI1j+m1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qfj5U6kFi64V0m7JWmb6NEKQsd3iz82S1T51uxK1qgM=;
 b=fCCDjBKsrSXUhpSXSESqxXljl1zmKVhDeiu2D1wosE6OuhWPkWWZtvbapY+VyCL5ZXTU4ggtghusMmac9hQq6zmDD9MP7rcsf8sQt7RI2UnVPCGg1tgruEILn+5XP62D7pZ7sGb0crLBdmDbKU/aTqwA0rGLzmgv5Mr+KoldwAtrvM3FeXRuH/XJlZDWWizbbtRggWpP1iYkFtRzdD7COQSHnchYlhNVfRdtmzrUmsYzDMDe5iUqHaHFT6Izt6SdqSNEx70yFl2ADLhPawGHm/LOtUDtAgq4uxc60pWtllDPXyjaHfS+c1o8rKTwDN67FnT+VvXrpjd2WjUdzgzL8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by KL1PR0601MB4049.apcprd06.prod.outlook.com (2603:1096:820:22::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:28:51 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::8586:be41:eaad:7c03%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 07:28:51 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH] drivers: bus: intel: Fix resource leaks in for_each_available_child_of_node loop
Date:   Thu,  6 Jul 2023 15:28:39 +0800
Message-Id: <20230706072839.42905-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|KL1PR0601MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8fe3a7-6f43-4e09-6fc7-08db7df2a500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeR1a6NyQWgxEqLB3CnpHimHt3u0kegvDQQwDunTi3fPDkOsmtQnlOrce0yheM0WPmiEPJiLT5h7D6Fi0w7ygjfv442/g8AkBPnAsZuPazvXYUCkMrr04zEwqtcHI3uruUYFS5XmMvahj85QnxLGSDH8UipZOVtc7WNZ2Fx88ErzklA/MPwwZX7lvl7aay1Zpy4PY9v7yTdZTSSihXbt5SeGTz5BHgtTkYS2SOQLMWLeEgbAgkRlvYDKR6JfMxCEvh9HRDh2j1x/XN3+YG1P5AZPjzI/lasYpMp9VQ07Mg+5frCwoI/wXtKep1btUWctqjNTLjyW4DMcq48C/OOg610LMhVaAMrIV3//SS3rDbvZ5A4EX6xenMJyO1PzhG8YmNqAiHu/WcipgF3jmBDTOotdrUgel6YKBZ8h2OESXVjo7ZLnry+FJlAib79XQAPSw2njiy6CTlMoKnwMKe2lTXmJ5FFjlZjyaGJCc2SmnQUMlA/UkIowe+PSx+METXmA46/0UlCCFTH/ZQYS3u8SZ0kIlN0q+t8g6mBoycDNc0qbHTwyigYU3149kHLFDKlP9jbEOfPsg/lFtxgcetMQrrdCQNE946ZuuGUTj1Qa49ru5gN6qJ3j8Ht2gD79C27h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(66476007)(4326008)(66556008)(2616005)(38350700002)(107886003)(86362001)(186003)(1076003)(6506007)(26005)(38100700002)(66946007)(6666004)(6512007)(52116002)(478600001)(6486002)(110136005)(36756003)(41300700001)(4744005)(8936002)(8676002)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XBXVVZPVqz3yAD0oM6ynlEY1v9fLwC7+5ZuQDPOQYdu+j1XyE+LkWtnqrGVJ?=
 =?us-ascii?Q?z63fm2lCvsV0AZ1qD/deiVPsjfouL4cgJtTXmTZGA/j2+dfUcM+GtWeLRK/L?=
 =?us-ascii?Q?ClDp+Du49VH6FHKEsJvgFptO0lQD2ULd65nFSi1JMLpC84tsQuFGWHuNkVpI?=
 =?us-ascii?Q?yy2XOUyjOnB8kcSwtguFCUmq5xvcp+sumkVnhEdeDdMdEovidnLSbco2KWjs?=
 =?us-ascii?Q?mqr6V676moVniUZkfK0WB2/KLChTwgc0VAozprcE6wnTMRtFSoBOB6tyYe4y?=
 =?us-ascii?Q?pqeOwv8Ui5G0vvbv08+SeTAsPXSy3FQNhdeQynMoydKOsvhtDZbSgWXomEx4?=
 =?us-ascii?Q?fAVy+4Q+AkeV/nyvsRQzRPwIKRcaI1Sp+iz9kcf2MBoiOams3ZeBAbU1Wx/+?=
 =?us-ascii?Q?ToEXJUvD6IrneipBuKuP48iD5wV0wajyyvf4y13McXwLiUxZOQ7ZY7KkqE8o?=
 =?us-ascii?Q?TrXDnsGfunryAxq6nNKEqnVh9DzUnP1SVBh+ejipnumfh3QVR3Qjg0UJEtmK?=
 =?us-ascii?Q?qwKbwUx/J9rhHgXPqYPdQY0Ub/38Np6xMFa1QatQmv9HFu+Ars2YRNb6hdhe?=
 =?us-ascii?Q?0WPDH4KpyU1iBrQcTvoNQ59qJWyfezgXUnxKveVlen5xe1eBQSNJoxYukpw8?=
 =?us-ascii?Q?MRnaHNJb5y2QzZ8O0UyZMMnBU+R0rROvxh9grp+8v6SBZ3cMYnl5zEiA5XA3?=
 =?us-ascii?Q?dZYWTNtKMKgwpiTZXsWK5IArGHfJlvz/K7mOTHtkAJsPEdYfxVi35w9sKZdy?=
 =?us-ascii?Q?WCsG8XHCirW3fxC0BPPH3kcoZ5FQ2iRUIRigICeWnSRwaUWicsDqJJi8hfUF?=
 =?us-ascii?Q?Lc1xQ5Y6DPki+fRa6BC7An+meWUIW+n/1ohsLrr3GYY7zbXLfbQHE3YU9RHI?=
 =?us-ascii?Q?Zn2xmxHy1tjpths9m46qmsACWMv0zwlHHunsQ/wNdRJhRes4+/drK3FphVZy?=
 =?us-ascii?Q?3jdMxw06deOayjv+PRf6QrLHcFm/4NZ1N8YcaUgtXhsWzmxtRlQpIhHIpGys?=
 =?us-ascii?Q?IN4wf+8YKZ+9tFJ+/RNt4ewWqpNioBUI2xk9RjxmflL3TW9+3mkefua7dIfd?=
 =?us-ascii?Q?fkwG6ALn3i6NvkB3A0kcRzMxStGusH6L4jSDB/PPWi1HuB/CJgvhiFNKQaUC?=
 =?us-ascii?Q?dKGaEFL7aGxJ7lMPMzBu9UU8bG6tao7jcYUUzONyYBd7AG/pBfEFz5OAA4vA?=
 =?us-ascii?Q?X7fGp4lfbeO+5Und39DHecAW7AvbAdssfs76FRN5KSmKoT5FizfjM7++QWWX?=
 =?us-ascii?Q?iGQ/Cf6yDhkJUQuagx0XWYX9ftbBQ5wzqxykBbqZv+rak6P8IUFHJh9BnDkF?=
 =?us-ascii?Q?fKL+VC+xUyGhrFITz9bCERolxFV/zW9YcXKz8+AFmuLCOp9lua1FLwdkCsMU?=
 =?us-ascii?Q?f3OLG9FCppMFQQYvh3c8F/lbkxIlg1L9CUQHInOvadgJPqTVq9AKkSKF/LRv?=
 =?us-ascii?Q?/iktajGPkJp3exbJMLqOEcLBTfozROWkeajXe0xwq7H7mMmNYqRvjH7dzpzS?=
 =?us-ascii?Q?g2Dlbjce6N29T1io+AwvazdJihtCl1cg/WCzD/9LHiJT5R7cG2c73y7a8DNJ?=
 =?us-ascii?Q?TW2c44xE9eDDZpfBWSFSZ0TDZCuOVF+hdwvguV1V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8fe3a7-6f43-4e09-6fc7-08db7df2a500
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:28:50.9364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBzO9zeUfJhAGfzJTsYJPJHGN8V3r7e3SLDykLQ/ab3PsC5GfV3A+BNpkIRTV/lOlc0V6BEFq5zQKbn0KDyOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure child node references are decremented properly
after loop complete.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 drivers/bus/intel-ixp4xx-eb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index f5ba6bee6fd8..cac8a8f5d7f9 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -398,6 +398,7 @@ static int ixp4xx_exp_probe(struct platform_device *pdev)
 		/* We have at least one child */
 		have_children = true;
 	}
+	of_node_put(child);
 
 	if (have_children)
 		return of_platform_default_populate(np, NULL, dev);
-- 
2.39.0

