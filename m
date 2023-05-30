Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E983A7152F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE3BVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE3BVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:21:36 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2132.outbound.protection.outlook.com [40.107.215.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CE3CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR0pIfZXS1I2r/CfOho+Ub32XM/O0GXDVwexcjjf7BFZIqCtEGhj17DVCOAkINvjJ8F6TZkVWP8niaNZox55TPqR3bK9/xiEbqotmyksQU02vSPC4A6taj6p1tBwY7U0jxLfYYCrsTGUwWzOUlSD2QKZ8NnO/XV1dbGLZC7vGNzM49wmaaWrkTy79qmZ+t5cxNBzRsue+EqdU5dCi6fFUJLKdXFgSejz5bAd9ik8TD3uWTetmw6SAevotLkQVw3z3Hg+DV2BhYRnThXKiGmviBl+60/KVD+Qm+hyR2QlnYUGXMMiPZ4QhTPjqEf1aJ6BYqCp2KigEfuPZFdLpPG6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/2WV/8330ze6pmrDXmMdp50FsuVn+MYjbmYvlegJUU=;
 b=U7Cx9ArQPHpj8NR8OhTARs6vPDLaBN6WII6qlSXRUVjYv5c4ZZ765wRJw/nXDXYxYoDSbQ79ePHkOcD1dzjkzfdJG7/nTdOePQAyESlLSFaopVAG/fOz94SQbKtQP8F2XvSEmEmS4IpvX4yyDxEFB6XgRIijI3we4Lv0FXi4+sq/qQ1Ua3NNV2TOG/Cy6Vb80vqO47HIap8dEuzTKYomIQapP3L9cDpOQtEDFGQijoDOS+DITQpkIG6t/vXbX43yq5Lzy//yVTVATyxMD7aEAdO2geaHA0+SWxy5Jyez48SXfKt2aDX7dD3F0j4tLLVFjTXzDNoC71pgUnsv4Qf60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/2WV/8330ze6pmrDXmMdp50FsuVn+MYjbmYvlegJUU=;
 b=rEo/DPj6Ngy+4RZW/nEG4b6pDkDnlEVlUX4y3q6YiKk1aOabeH5EW0k+StFQ98G21APTR5lVZL4dK0x7NI6Mw4RjFf/nkgVdORqW8XWUps82rLk3JL/1BbahuwTbBaIBZfOgpX4RLkdPgY42fnv7Wqtk1OFFjYdTIuI6j7KESaEjbuoWlPnx0lu5gIrAXpJjRaauXcrGJJaB0LjMYyDLlspuhSqIsj3v2vxm3bqXAxv5IVHutZMOky2q9wbW9MFCx93vIlJ0rq8i5HGmuUKP+jFKenri8OHj1UJGhTvC4e1OgDxnJScMOniWXuvHqkzb/By3wi7+qgP3WXNmQVdV1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3023.apcprd06.prod.outlook.com (2603:1096:404:99::11)
 by KL1PR06MB6273.apcprd06.prod.outlook.com (2603:1096:820:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Tue, 30 May
 2023 01:21:30 +0000
Received: from TY2PR06MB3023.apcprd06.prod.outlook.com
 ([fe80::feb9:184e:907a:1359]) by TY2PR06MB3023.apcprd06.prod.outlook.com
 ([fe80::feb9:184e:907a:1359%7]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 01:21:30 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com,
        Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Date:   Tue, 30 May 2023 09:21:18 +0800
Message-Id: <20230530012118.74228-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To TY2PR06MB3023.apcprd06.prod.outlook.com (2603:1096:404:99::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3023:EE_|KL1PR06MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: b5081685-f5fc-4c83-0f70-08db60ac326a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: It1kANXYE0VdctnT4BZPJ4jBiV156UZ4HyY5oVMYwbc61nAPDa3uZTzqdQUNM28m9LGxt8qAHMc313u+0zcvOsg/ozZbISm0XWMOBQlQZ+wWgUzr2Ha6zdotKvh6ZCdxxLX25hCtO9P3xCbmpIqtvlEcCJGefAM0glCOgZRQAUxqQBqWn38zSqd5JXOmadMoLFLjSIPY5eZz3cO9j34BJhSo97JmMZLOH55jaVdPkn1jDJJkaLggyat9f3EgAmvS/Im04vmNuA4EUMdGNCaaJP3xwgb2v0Zcbn2+w0V1f0G9usVpxDx47FLc+l8/w9meIVQwgdeE79XgAtSIJ8KVcRyn16UMciNZGwrAw2OE81cMkTge44aHL58A4y6edE3sLB4BK6ASNQ8svUR+/jkPpyYl1BxCTJGKk3yuw0QPZxvAVOJ5irhggdLVClrk+0ZYWvyTFEpBJgdo//T3sAj6DEHHkOiWNc14Lq8GEfPr3Q+hOO2+awvjWnUaWDhZJ1UWNikU9Pi5H8Q96y3sNxv6H5lm3zizepenF7FibrQj01JEmTXvChBaEYsnENLhPclg++66trsgO9ktD2g4F3Pz+Wb5CjU8TBHNwHMh+3cHKDXbxYj4qrrbm24zo/lfDYde
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3023.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(38350700002)(107886003)(38100700002)(8936002)(8676002)(478600001)(110136005)(6486002)(41300700001)(316002)(6666004)(52116002)(5660300002)(4326008)(66946007)(66556008)(36756003)(66476007)(4744005)(2906002)(186003)(83380400001)(86362001)(2616005)(1076003)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sa8bMBW1bw8mDpiA4IF8VlqfMbBxuM/KA4yj8b7/vYoVldJV8jp3WZKbeYk2?=
 =?us-ascii?Q?RfpWnA7s1Hw/xEEN6ATaaALVVtgejNOVBPFTZu0jsppUfMVneNf+Fhdh7sP0?=
 =?us-ascii?Q?POoE5Af44tqllKMw7pacvVr79/XkbpU2iEWVOKySxFW3xYF4do8ZqocyamGZ?=
 =?us-ascii?Q?3dQM2Rn3czCA8X0OXxyw+1GPIYrhP9ou3o3sqChmvhqQf+FI4r2hDWPr1KP3?=
 =?us-ascii?Q?fsojt2qUThBMyw0t84EbwHo9suVCHo483znp+ZKRYqU4ImEYno2MiHCD/m3X?=
 =?us-ascii?Q?JFsDJTMDoselmAPe2Kg9S3ixtraUvbHgZBOGDazbFJI9bYD88z+5553ikoxY?=
 =?us-ascii?Q?Fa2kPpI2ZLgGJ2T276Lq0mUGBBzl2/EiF2QxPIi/RUmx1xwWm1lg8X9pCoXg?=
 =?us-ascii?Q?8kGHDMMDNm3s1Gr1jr1tKlerquvnYDvGpufUjCAMQhbRuHaEF+tB2EXZRsMz?=
 =?us-ascii?Q?TAG5+cfhzIU+LTLsDE2cTWUY3La3RCINWh6omIPYqEJvO6ZUiG5aC1WChOzy?=
 =?us-ascii?Q?R5sVgyy+0D3cB4EuJ+ZZOEvvAVAx64QlggmDMce+nxOwpBPWdvpAxJ29f46X?=
 =?us-ascii?Q?8Dq/LLXsBfSfnHLR3HoohDHoBC1W1zptJx4KmWlZqgkV72Ty3U3uOAP1s/oP?=
 =?us-ascii?Q?1al+cwmcGDqgRvbM7qY4kourTrNFf1KjpQe6dgy5Nv9hzTNia1pWQ6JdwvN5?=
 =?us-ascii?Q?nniW+TFwdzlyRhmY64xok7Y09GbpJFYfjGmFoEC7CjLkDcqqrhBh3kiq+ytu?=
 =?us-ascii?Q?bRVO9sYwTqG3l93ahK1Mq8TLV0bvO+YCsrkjDXjkcy8u+6/U2ZaCcU8wv9sa?=
 =?us-ascii?Q?8tJqrmQjSKCT5sJu0nAUc+qTrV85IHkd/17QMkBe487HuqNcoyo1GhxVbILK?=
 =?us-ascii?Q?NUFP2vU7+R7X4suDPVB1OYSZBYAwWGceqXriq/qQipVhkum2KNi/GwibHZR6?=
 =?us-ascii?Q?m+GA6eVaCHxKO1AaD7HxHYIVqzTk6BXtFRWp6mQtbw5q5izm9mWYgy+U+0/+?=
 =?us-ascii?Q?t5rjTmTcDTA4lGTe4IzbFL6oKBcMWMqp3wClI+ueLBR0iIAD4E55dLWrMirw?=
 =?us-ascii?Q?NmnPCZ8h3t3s94kpK10C3RgARmG5qUzSEt0iuPsEkhoPKiR2FWG3v4Gag/eP?=
 =?us-ascii?Q?n/0Jk8u+he4/JvkgXbiz4t4CBiXuIiCASLbcCx0UlWzttm38fQcOFUVBwQ2F?=
 =?us-ascii?Q?Wv7ByCAAsRvm+ruFOi7ccP07paqGUGBJ1WUs6410WEnHqfojdT+jDsD20qi9?=
 =?us-ascii?Q?nw4+QpwBz6FF4SEXw+fISCs5QboYTt518xrhOf5oK0EC6EXtLtomy4TTRAh+?=
 =?us-ascii?Q?PsNbE4hIjbJ2Jm1qWQW3BPte10opOjpt14w9X4k1uvHunm3/veeIMncDbDkT?=
 =?us-ascii?Q?dD2KK9qCGCJ7WdmHRpJWiDvbZVX/jITRaXC4O0vGrqRF9FAbLg3KrVOn0cuA?=
 =?us-ascii?Q?rvhpnRBtAwSj1EmsaWKCPwDsUymDXtcBHpsiiedGSpn/xbX43bVBTOE3sjd9?=
 =?us-ascii?Q?Rdr1/0Imt+v1tC/jI6TeposMoZrwe7u9vO5NUYXuu4WyufFdI2C0FgA3kVIa?=
 =?us-ascii?Q?6+wKbo8E0pjmU/RsPywCGKf1XHP6GhSc/k06ZqMF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5081685-f5fc-4c83-0f70-08db60ac326a
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3023.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 01:21:30.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8d/mf9Teis7iadEAdP6vtxM6okTeK9wN8kvCItx7en2ikj+F16EOGnPfh3a5NJZA430Dac8VlXhBteC0SBtQeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NULL return of 'd_splice_alias' dosen't mean error. Thus the
successful case will also return NULL, which makes the tracepoint always
print 'err=-ENOENT'.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/namei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 77a71276ecb1..0c5e4c424eab 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -576,8 +576,9 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	}
 #endif
 	new = d_splice_alias(inode, dentry);
-	err = PTR_ERR_OR_ZERO(new);
-	trace_f2fs_lookup_end(dir, dentry, ino, !new ? -ENOENT : err);
+	if (IS_ERR(new))
+		err = PTR_ERR(new);
+	trace_f2fs_lookup_end(dir, new ? new : dentry, ino, err);
 	return new;
 out_iput:
 	iput(inode);
-- 
2.35.3

