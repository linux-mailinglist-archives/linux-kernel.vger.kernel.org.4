Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682946C2089
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCTS5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCTS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:56:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48443402B;
        Mon, 20 Mar 2023 11:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG9EyKuYVXK2FEq5RZeydidXEWFSsxMjwVgkpWwVc1o35AsRX1LIXe19vJ9J3pQIZqj52RGqw46Og4IgQ6VVJQHT1o/uryQ1aMJ42ExT4obWWH0jjjW0UT0O4QqzvwR6LSFB3e8AvyZpk66qzc2uEQ+xpaLpN1fOkVaM2E3/nuOsRbLPUakbYk2hZAEfV3VFFGwjbA5J0M4mdA+eoSPdIWme9xxNNMyfc8uZ0Z1/8oTc/P/cexdikBvn34ImpamSv6JyB0/SV5kb2eM5o/FkB1HgxIUfSdoyWHpusKMtQ8KB97zRuKom1+IXSjhXcKiHFzerg46ipQmEQwrRR6Sw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV8vWGKFQ2SpsYCXDRkcEes8uHuerA+1iOZq5yPEi9w=;
 b=GQX1Ts4npaLJt5gqRsKm7gaKCbH/lxAkZWt2OlIV8e4srd0lz1s1dVDiAF3WB04DNEouS80va+uEvho85uDWyXX8VB/G/pL5jgSBSbBLo7K97Io5mULnmM2xLHPQ7AZUfjYlFWxGxMU6SbHDETct9f0V6PkD275gAaXKFJdE5TXgUH4wyHj3bHKAgbSjBBqO8P7Y0Ogp92/e8JE77dY4f+3kryxd4vFwwBQzU0mS9t1Ru1xxGnBX0tTLq0R9vKdYZ76JD4pjx3RSBGvtux4BhseTTPH4RWHo0k6F1i2tiAHti6I7KSE8lcq9FQBVArzN/bEzJ15BFY63AgM/sda0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV8vWGKFQ2SpsYCXDRkcEes8uHuerA+1iOZq5yPEi9w=;
 b=WOrVJArZDb8AJP2kssBj+BelX5HEigC3oWWGcHLHLBMlaXI79Ps40P1lVBP5b2e7Wz9h9n1nQOTrcruYZ06Gj/A7ODm2lqnlnSuMxxcgxVrH9TfMjtH6qZ8Ikb/ENQl3YwsmFCR19L3W2ocYCgSZ0Ss5nFeen026ou2opyH7focFS4kVIEufNSVV29cbabMxcHob0O4VavxoHLgMWpXpI7dTWXdiMxvEJF4vJova1ynFMdGeuTBnTaHHVcbEc8Rn2AiKoD6lEC2ZEoDCyGvkaoaJSgE03VafKUihgNoxTaQ19B4ZqYiNRhxCZQiKz4EVbVS2e+eukarQ5+zIYVuSCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Mon, 20 Mar 2023 18:47:58 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:47:58 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND,PATCH v2 07/10] xfs: convert to kobject_del_and_put()
Date:   Tue, 21 Mar 2023 02:47:26 +0800
Message-Id: <20230320184730.56475-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230320184730.56475-1-frank.li@vivo.com>
References: <20230320184730.56475-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: a7977c57-0b4e-4d86-ddef-08db29739f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnnyBwBRBrmtfPVb5KhtGQvPGc/t5LsUDmQjNcT3YK7UuJHeG+bVkAcHzE+qDt6lZQel9R95cAZInHf4qs/2x/11aKPxVJK9wqG0R+jBdQcm6APxqg1QIQ4yS3P8pGJEycaXJ7mxcqNSqebgPhBHJ0SSwMc0vlPJXjzCGj0LylcQDIvY8mMXbqeqP66fWDH1CYIvXTs+yEd5ZzmdGZ3ubI4eEilO6Yv4p4QzQd1tQDjbthzXkpsgot0G3rreannNeoCAOFmsfjRJR9/AoCG2i8jCT5Nr92ZvmhzhX3TorzAAS+k6T8zSe8dMVZBfX5H6ohpCOu531S1jVKHN/iQ7Q00vfZqzxPU73/kRqDx4yGlCd/U6jkv+XvALGpmnJHywYiN+e6XWnUHNPJ7OtMcZJLKIdmW9RqQO4YSWEE3Mh+WdjE2pUihEUq0Z8tA5duYs9W5pOiz0fyn5R0ON8Om2EbmSaFvDM2ObJ5DLZ7mMvrIGRH9K4rE8FcmYPRTUNgRSYeRF5tnd0bw6DzeTj3ECfgzQZWJzFqCx7Ujw/JXih7fUZcCwmzmDmIJaT7MIL6fJ9PdcawnHMT8HaoAEUjT90aagQifDtHQtJjeHeY+E11ylKofVc9OtG5o0h9hsaJp35ITp4x2hRs1fpe/ptcb59u7kYvAc3/kk0f5n0zbEC7Y+hzs78bnC2WUz+UA++UJSGnKutTLFUXXwKJ4Q7/UXCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199018)(86362001)(36756003)(52116002)(316002)(4326008)(83380400001)(6916009)(66946007)(478600001)(66556008)(54906003)(8676002)(186003)(66476007)(6486002)(26005)(6506007)(6512007)(2616005)(6666004)(1076003)(38350700002)(38100700002)(5660300002)(4744005)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVHrZ4jDDFrrQRlRGVQJFw0N1anWlP8+Lva3JBIgzMbMIWRP6EMYtVwh0JhC?=
 =?us-ascii?Q?I6YHXAo5JjvnsYMrXzhMcg/hkMiittw9Zk31vFWV6/E+Xiv/gtrKo68BZ19x?=
 =?us-ascii?Q?pRjxVle+yKRAQjsf6fA08NA1GEVJlLdt2X+HDBjtpdLo9um9OBYK52iV3cpe?=
 =?us-ascii?Q?dMFGyvL4KlFEwC2FGpf3bpLwQ1b4SvOQQXmpRD5Dz3s4X5KTCVL8khv4XeGx?=
 =?us-ascii?Q?NfDSDoOmUKWtXQreKS3yYaN3sFvjGCmt3n0aC9NF10aUW/Td9R1SLqyhMmla?=
 =?us-ascii?Q?RFFFfjXASgBy9aVo78o8IkqXQUbuCL672b++43bzRXjlUM/F9KZiGmHRFl80?=
 =?us-ascii?Q?h5zaTGsuopJvmFDBjoojd7y8FkjhOni8r314X4HgT4rbLWz+jfUPRorpMLIK?=
 =?us-ascii?Q?OXnz4p1/D6kjucFRILtjy02OY3lI/7+o3kJP/RW3ypHt+6VqMfqcCAKEODFT?=
 =?us-ascii?Q?UkS3A/RJV8SWb3nwn3o39QKS7XIlbr3gU66XOJ6VgfxV+7VLGNev7E9h1r8a?=
 =?us-ascii?Q?CDQrW+LXNEDs029vLmwHsWgEj/0ktxKUFYUpR7dxkuWUyqk2HkMiK0QoETI5?=
 =?us-ascii?Q?Of9yfdPtPuVro5U+jcbcZkC3Qh95mSFAoHyC6bTwyWEvE7xeUp+kTGyXVfqG?=
 =?us-ascii?Q?mwyjOG9sR4MOzPsC3F7gRaEPb9v1bfoEaDucAmu3UJPkWWinvxnlLEAMG4+y?=
 =?us-ascii?Q?RAuzSxEofF0euBDgCTE+bGwZ5F99frsPEo2dJUCQ3Up0GM6a0DiYateTduHj?=
 =?us-ascii?Q?PBiNAD3tUYLzqCOP3hlHGaoqc4x4O4N4GYLsIr1duXcSZJhPeHkcXCnuEaCu?=
 =?us-ascii?Q?csf5DjLQEudII+JkgESnBMGZZDSOFXm75to74ozLIUAC5IDhga9kEyl9veFg?=
 =?us-ascii?Q?WmZfjy0acnz4mKcwbgh8K70eRhEKPycvlbX5Zg1pX6X0IQR0Hi5HdSIQz6OR?=
 =?us-ascii?Q?wYLEqQBE8dWahlP8WVqMiPQdTRzZwzbdPPt7Iaq/NCtMLkBumyZDK9P/USqH?=
 =?us-ascii?Q?yERVz+VBLvEMvoUceteaHqLPv4GHCrw1p8R6MYlIt3pI5TrE+RnTQKQphU3e?=
 =?us-ascii?Q?mMFl+tCUObEMxvGyB1PPaIoUpF/LerUWyUXn1N6bvqo9YkBXtngy8/Lb2LQ+?=
 =?us-ascii?Q?cvFFgDqYmUT9Z9KxQcOlgLDyZjpm1AvxksFiGf1sC8DyZNaghfgEFayswU9W?=
 =?us-ascii?Q?o2EpcHK5gai/7rfHVODq8q0BPULDwsjrFJc1ByxSjCuetGnoluvUlQL9pcZQ?=
 =?us-ascii?Q?KYjFB3eIgnVm10e7D/gZu/LMShkrI5gD6AbB+NZ7t6g3QAmAEgoxEYiczQHG?=
 =?us-ascii?Q?RpRP5MO8tfrmlXJ1gyLSo1rsInj+vUTmzE46wghoSDYBvM/KUyO76rk18Ywn?=
 =?us-ascii?Q?Em2bYr8halxDGMWgyMcFsh25YL9CgOqE3anTqzJyq5CaChvcOaldkUVyWWQm?=
 =?us-ascii?Q?UCzszQlK62gRnA8lQpR1qMEG6RDqnaioQBec0Vn9jBV1tTcbMRPr5ILwVNEo?=
 =?us-ascii?Q?XOAjjs1RIJLWjZ6rR9/0XRzvbJwl5+71/EoTJ2tu6FhVgVYNALvbNApi0e/Z?=
 =?us-ascii?Q?xmz7JrWgAIxrGKgw+BK+IxI5YXXMv+3TmXA40MlI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7977c57-0b4e-4d86-ddef-08db29739f8d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:47:57.9940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkvaLXGdjGQtLAUJ7Kctn/piOU5FWdyXcCl/rcwUon4Dn2gUIURsRPeDla6TlUuR6RhNYYD7xNtT+NPrP+woPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_sysfs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_sysfs.h b/fs/xfs/xfs_sysfs.h
index 148893ebfdef..e2ff063e2c29 100644
--- a/fs/xfs/xfs_sysfs.h
+++ b/fs/xfs/xfs_sysfs.h
@@ -48,8 +48,7 @@ static inline void
 xfs_sysfs_del(
 	struct xfs_kobj	*kobj)
 {
-	kobject_del(&kobj->kobject);
-	kobject_put(&kobj->kobject);
+	kobject_del_and_put(&kobj->kobject);
 	wait_for_completion(&kobj->complete);
 }
 
-- 
2.35.1

