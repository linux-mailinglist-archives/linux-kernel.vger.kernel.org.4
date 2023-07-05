Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC58747F10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjGEIIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjGEIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:08:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2113.outbound.protection.outlook.com [40.107.117.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30A1712;
        Wed,  5 Jul 2023 01:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/P/R++jXPmjsF+UzMhE1/l9AVc2GEL5Ixx5Grf5lr5kRha+kohMdK6k+TQluNrJ6r29hop16GoIJUBfOwh6F0E3WLPRBmOO+ATLyVNBIKkA/MtHAt+teqxkory54wv55aJBnz3qW1azqvhMkFeScUBnIx0kmaRI0qUOSypHRbHU+DQ383QpGwAxcDnANJGnUKQ1anE47Fr4zbGUmtLfDCW3D6aSoHnLhHQa5vxUV75YofBb8BNbW1RiAAW7ruDtjsxdAG5Txg18Gt2Jomvt6tnSk140VL93peikBrKbiJJaiOHwCMgsAD2vfHrxFBlC2TNa1gMHysl62R1u8OYIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0rsqwsyOHA4eQOepreYqMJTFnegkQi3M3c2ri5k1HQ=;
 b=WnMxX41BBoRfSjRR6hffoL3wYHFtga9tyenSqH3BCa74LsUinpKRxBoTVhYYOJ3wIDlfOzYmDdSgNJh5uMvHsUGPCKqF7Mu2b/stbJtXDfhlfjdX0DUBEAQkT2evXK4A69nrVJPtv1SiJvxOc1kfaKryjggPCO5sbGpvsAApcNNyuRwRxnY61qZ40znecuZgsn917lDx8hI4wat1Q9wxbeP/JTfnvdeIdin0CBosb6FZ7RbaiHV3+rpzbAr4dtNXXsNTa14GqNNKeZTV0wBs5CLDCmTsA8IFFNZlX11+tjp03inqh2MSsjDKAPzW177kz+2WKiQ3oWRNZsCQVvUiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0rsqwsyOHA4eQOepreYqMJTFnegkQi3M3c2ri5k1HQ=;
 b=NhJLB80Z0cULxzY5jtAQkg6/IRiqgxUsNHT3Hsjb7/mARcN+JqGqTouQXPpu6Ca/MMDtzccWkaTbziROo+35c9BQPKXtHOGfrFb0Day5H8TUu1GUSft+juG6dPsJlaxYr7MFSeTzbLKwupcNNeNnm01Yx5GUZYyqQTOCPuQ699bG1PBxeRj/fvaNtj8zMPHzNEl8T4MHjJY/hBcvB91Qs0O2eaYiNnepIzdpvAG/xM19XuKqnS8JseN5kv0eNo2Y5DAb7U0SQuH8TZGXSQ1TO8mGoe87NG5xm3stZWtS+HuVZMVZgHXlidXNN+s6yBc9h82TqlAc9mFD532PDWOhSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5681.apcprd06.prod.outlook.com (2603:1096:400:275::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:08:29 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:08:28 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:QLOGIC QL4xxx ETHERNET DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] drivers: qed: remove duplicate assignments
Date:   Wed,  5 Jul 2023 16:08:19 +0800
Message-Id: <20230705080819.12282-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:405:1::28) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b30e4f-e1ff-4966-cf4c-08db7d2f03e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p0PyleKx92etZRzQH8rnzgcULHXVhtg4enmJBMeZ3OPXBmQT8WRC7STN6MmNV82ZhZ0r3pl+dK+4le3YfCmvKFQjaE2w1aI88S/g9KprgX2qN8Y5uWFaGesXLtEL3dtpy0sAhHpSe8jfW+OqG2YyGQEl7T6/3ZuhHGiUvfAr1Y19PlUNCa7xECspLur8L00JC+M6E8+u1eJZutC/8EZVcHWAJKGAwaBVkGGUsxCD1AxGUg3X4qbDxBTki46ziXklLDdY2UofUUnsJFIKm0mrpBZq1P+uy6/hGL7v9a2LYR4thXTfZl8V/l/wc+Hly90DkfYY7zrCBG4CWR1LJEeGLtsmLbT1645E0AqQLT3cJPvZWbQOtBC5ZjEIaoVIQarlNyqssOWxaYODOcX2iKIznPYJAyS7a81PU5FR4SNfWW701KyOor8aj/fU9stpRJjCR3rJpaNwctPueYLHwQc8AbLSz1ib/HKgyUaFQQIu1ncB4vGWr1DInRn14EvcpeFWq7TSUcEaNIvY9vTxvfnbfhLPyvLbGlKxnGuUk8ivXIc+GKfgMX9+qMn6ad4ZEErZQPfmmhsdaQ/5AfLUcpWDVqvrdsUa4WsGKf+wSwizTjcg8gyRh/bnU0faUr3jvzt9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(4744005)(2906002)(41300700001)(8676002)(8936002)(36756003)(5660300002)(86362001)(186003)(2616005)(478600001)(107886003)(26005)(6506007)(6512007)(1076003)(6666004)(6486002)(52116002)(316002)(4326008)(66946007)(66556008)(38100700002)(38350700002)(66476007)(83380400001)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ch4AYDHdOilRZKx8bKvEXV3sn2m0dsdo5o1LZjtRKVqgaZi0soBl7wVbwYjE?=
 =?us-ascii?Q?fF2AkZRMEEf/n/NJ1hQCUkYBOsIonbxuq5bdd6+P6ttYxtDX8TSAlqzgplRB?=
 =?us-ascii?Q?fOZQL8SXwY1YCaEpSGHFx9vtr3PiLLhdmVztPjgY84LwovNTWjxMPkj5ngqm?=
 =?us-ascii?Q?go8+xpvJinO1rNEASBhuJGildxki4evD+cORDqiywtCwj0oj6/CNkf4GHNm+?=
 =?us-ascii?Q?77x/XUfYLykmvz42IlyFWsxrHywE33VORHodCQvxFYuMmqOA7/G8ka5jC16w?=
 =?us-ascii?Q?EoHme2SRWohaaysylkvaHD9Va7z+JeHj0IcJC3dYq21LSZgp6hZuMJKBBM5H?=
 =?us-ascii?Q?PeMZSdTrvK4VFSt0LvEVfIdZMrIHc2Fmr/BZLTSPNyNIyRRYEh+F3Y8LV0fd?=
 =?us-ascii?Q?Jz6XnThVFvVYyPHg3XE9mdbZupB3W0y/pxwoXRVOtaogvzQdHBLE83s9VtxM?=
 =?us-ascii?Q?MeDMGqP3NYFxC0vjR0qegY4nns//bxOePjJA7bZGAazYBDfoLtjMdoL6tDla?=
 =?us-ascii?Q?AdlcXHP3Hy9VLrVfI9haAsOm8RSBtgrWWdFzVq8b5jUvk8MQihRHX18B9SGR?=
 =?us-ascii?Q?I38Z4rIKB739VLXvu6Kwrwb91brBTSZRsk+pX9RQjHrSjdw22BGdVwAck1uY?=
 =?us-ascii?Q?RBD9WYKn8zRxtT7Xuk1Mse2wcx8yWTiF2csQabAxKr+UBS5o8qggfrG2p6jh?=
 =?us-ascii?Q?+o8s0yWXxZJYJ2qcAXjhiyfsI9cFSP0GnFWFszABuFOv8HD7SRluOVyZKg/p?=
 =?us-ascii?Q?BYhr/eCs6EOI1QVCtfntCpaiqQliUzG391Rbqw4IdaDPmtpXyfhrc0JQ6bB6?=
 =?us-ascii?Q?DXoFcv3r5WYJSEt6va17K8WQ4Xp3OCLqA1yzS7L0FEBb71uT+lDVYbaOeKeE?=
 =?us-ascii?Q?WssNVFg/Em/MGCmLkbcN2GuGbhsYTHlCc23ZmKdhwG4viXYS3/fc/Wjw9UBI?=
 =?us-ascii?Q?Od/XczzPxx9xojr+bXhlHxAn2AZ0GyoL0aRyG8uLLBI7yf2Ik+IPJytulmcC?=
 =?us-ascii?Q?gAYuwTF4bOtj4QABSQuw3cX243BAFT74StjLo/T9ae6BJdkZzSpNg9X85Tsc?=
 =?us-ascii?Q?WKROUk0r1fbX5kOpyJXjzJwjBONPoqYI6a3d/yZvZMRVdRUEVfSTxVohUWh0?=
 =?us-ascii?Q?VlDvEBIJJtcqhtFP0rZekX5kP+RYeysiqp18OJr0gEuf00Qrs87w8US3NVIX?=
 =?us-ascii?Q?XKHpmQhfhBbVzMOiP4HEft6Ky588v0pxZknP2D34th1vB3PQVfzXDw1XQvho?=
 =?us-ascii?Q?HClJEDSRzd0zoAV7dywQj4O9+M0tmfhF+qwZJlOVe+M/wwAc7iYRtdtjqnls?=
 =?us-ascii?Q?cySwKalH9d9+U1TggoEngIdaAwaDH+v+6qknnljJXV12/kkRaVOcMBqpKcTv?=
 =?us-ascii?Q?WUEw0OC7eZVZnhX4Kt7B7Y3s4xOqlrf511iOzrZflWh2r+7w+bLiIhI+0+fd?=
 =?us-ascii?Q?TELrJeDMyhL/02+eau5rdp0BHYeLPWq6pUxkgCzj3xl9MzEZlT6UuEjjgfJq?=
 =?us-ascii?Q?v27HmkTkEtvJGUtP3Llncxphxas67dxelTyzcI5MUPFWq9EiUygn4iBsYqK/?=
 =?us-ascii?Q?fJkrDyGM2QCH9U9jj5zPPx0yEpN7CurDa/MV9pLr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b30e4f-e1ff-4966-cf4c-08db7d2f03e9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:08:28.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4ukeuY9MPUdFjOgAa6j84nG+ldVrH+RDU5Grw9PRpwBtWP/+QZT2/Tk0Yd04WhyFB5f96ZGXZxrO54VZyGUuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make opaque_fid avoid double assignment.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/net/ethernet/qlogic/qed/qed_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
index 5a5dbbb8d..41efced49 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
@@ -1795,7 +1795,6 @@ qed_rdma_create_srq(void *rdma_cxt,
 
 	opaque_fid = p_hwfn->hw_info.opaque_fid;
 
-	opaque_fid = p_hwfn->hw_info.opaque_fid;
 	init_data.opaque_fid = opaque_fid;
 	init_data.comp_mode = QED_SPQ_MODE_EBLOCK;
 
-- 
2.39.0

