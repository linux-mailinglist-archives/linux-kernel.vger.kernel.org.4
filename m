Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738FE745CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjGCNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGCNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:11:51 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AD1B5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:11:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLNnvcGRcGnSvcVyXDXxPRU66NthC9/Fhwp+hSsOaajFeJ62elaEaChT+OzGuO5965JGieuSHDXuPsP6+mCg3w7DbSVehvyjp8ympUHR65EJJUvsSNx//ZnPEt7xzXWCSmV+JyGVybCCETKV7fcES/53EAhlXrSwrprV6bY3PZwhPDoiWE7H6s5PKfboE7o31EFk+d+vE6L8kkRrn2XDSvHDQ7TD8q++VLF0JfyLncOeIDScofV3WtoGvPM+8fvDFTc9w0dhCR1/J/Ado3yUT/CSVYnulYBo54ewXg1djCZzSOqCEjik6F+kAPaO3c1SCxYQ1x6tHRRHsxpMEcYzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEd38gsmEiYhvXExK1ldQuVF7T9+80esfhC3A7KWC+8=;
 b=PiR4m54XDbzXWhGJcSn+mH7BdR3LKAdve0ZJUUHVN21XF3iv8eQmM3BvMFTn1XZps3TP2KZEvByEOo3aPF9fjRVJjTgjGBw9KgsWdEMuTZNfOAuvnfZNYqku2uY0XtPFZMIsSX8a2IxAvQTjVKFPuJz/5C4ow6sAIb1xKDlXkG99m0mRINE3sZLfWd6pjzMAdKlg+HdN3BoyL/tH6rByHPE3NqTOPd5ozr4skjXUEjBcS7g3YCIE/Uy22k4tlY+FQ7QemjIgmktt+5KB6h9vprS23eU8peO7A0uGqfxIkHBFHAnxBnxduue+gAcPRoL/7pseUmEhcFgZS/2g9h1E/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEd38gsmEiYhvXExK1ldQuVF7T9+80esfhC3A7KWC+8=;
 b=TEsijPKuTZVeOkXdRRJyOGwr4YYPnak+w8d20yhh5NruzBGeGgwStzbY0IMrxA10N2H2Iyqhpk6g0B8g3UzIsy+6MYYNYurZ+oWv+hQfEIA8CE5wlz0Nf84FxL2UzB5I35jYR7xLTJFv5iiPXE4XJIbuWcKjNFTD9zw6o4MKZg98KY4iOLpPTR3gcJdavNEyL8sYyg0beGLkI1TCGsL7WToZbptZYoaMHkBJOi3ArwaLUbGesE/l9SroKbe/aClPHU6DeB3BFXrF18EfDMe7ofK2bMi+7QnN/IbPD6FwgMI8LIgwdAaJ70I8REtlVwBFHzvwvhukR+rLT+F3RCnkpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 TY0PR06MB5845.apcprd06.prod.outlook.com (2603:1096:400:278::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 13:11:46 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 13:11:45 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, sfr@canb.auug.org.au,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        11162212@vivo.com
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v2] drivers: use free_netdev before return
Date:   Mon,  3 Jul 2023 21:11:29 +0800
Message-Id: <20230703131129.8588-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0018.jpnprd01.prod.outlook.com (2603:1096:405::30)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|TY0PR06MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d36b2c-2ed9-4210-9fd1-08db7bc70d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T56n+dm2q1OAuzIAVeURNbQ8vyZWXXEXGo6R5YJTXVC/z3Y3Phof72D06BPfIG095HA+vaeVPnibG1+GYZ78ZXTY/n9KbfL9s/vik8sUchQXb46Ej9tH/RkxGCQ76+szdt4u5Mq5jhqx2k52rtNDKuJZijdrypyb2zBavj/sVR6DEKoli8UiDdCQQZLKOIcuYUm52KsAUqCWx3CZeLN1qDBXTjvf1v/rwYK/DPRveilMCaYVwGfvqMVBvtxt39/HX+8mjFOhSBWapU2DxYed445TRx7wOPD7qpeLHM5/2fDhyKDfwRcpDkeeJNVhOaq/bgrK1GrEy+Fe0Ww21+Ij+JYXuG2GP1JUKHrZAYGq8G438dGf18D+1gqkdYN989YyAiwbgJ+2GOMnTbmd9sZp+ycOrCpW0lk9HfWx/jvswSIBDIxpBVnF4azI3i+Wpec5tq4C509rQjOTpPQ5JIrlIsq0C2yqaXl5f2q8yXjOVmDflNi5WqP/c7GVPttv3kkXh4PT6acbcKqYS7I8zIkaLzCEHWpv0CXEfmrbPCDCmbTrKnw7a3/nf+hWVVUdbAWVqZ/3mBMKTa+KpnA881I6NaDUJVXetxEDkgAP4GSNCPg6Hvcawdm+/m3BxT86HcCM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(38100700002)(38350700002)(52116002)(6666004)(4744005)(2906002)(6486002)(8936002)(8676002)(36756003)(41300700001)(5660300002)(478600001)(66946007)(66556008)(66476007)(6636002)(107886003)(1076003)(6506007)(26005)(86362001)(6512007)(186003)(4326008)(316002)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uo3ZFieFJcFLjvjfPyfTj73J/sI5Du/euVRWv9eTi70cp8Ai7pbSHTcZmMjN?=
 =?us-ascii?Q?NkVupAghbAMPDdPgbh8k+04i/lIgV9flsUzzHZYyDbK/rFzsTi85lNepFpYU?=
 =?us-ascii?Q?g7BLGwBCUzHh12+BK+RuxtgPWk0EQlWvheufQ+sxpDofnuYftKt2upu2jkCx?=
 =?us-ascii?Q?lovO/rU0VZ9SDTAjXvoYKWKyoej3U/93rjxjpow0MV10Nzwxf6TsXN0KGKmo?=
 =?us-ascii?Q?UZPwbNBhb2kQLNnbZ0N9gpxrr3Tg306iBPeHdrlBYVetLHAt7s3sEB//krrX?=
 =?us-ascii?Q?z1hIsRFSEPzm2hiBOdXJH7ysibWayaEwhew0RNwpbJLU9pAkwgcmp6i0JtRm?=
 =?us-ascii?Q?/wxkEGHB4j3stGybeK02ZiSDi5x9d1Sjwstc2zOO6U6LQr5AuEYuN3VLx0AU?=
 =?us-ascii?Q?PP2wl6qiBNTH0DjhuGiEVMj11TXM6gqeYdsxgkZqrV1W8KpYcJwbeESSLhBz?=
 =?us-ascii?Q?0TTbHypEzwCh1+DKXq2rYXQge2F+48XSLk+Jkt/g96XBNto6SCHsvbZKq8Xp?=
 =?us-ascii?Q?zYtPTlGc9TeOGykpSwe8aYbb9ApTKBjd9Vp27wgqREtmfdsjxvcVsVkZdShb?=
 =?us-ascii?Q?tOiUcpu4noEQf5IYS5Zx+GkL1pFY7pqxLVm3r9R9qcvwbqR/OPao+tWbWhly?=
 =?us-ascii?Q?jLJC6yl4cEWy2dhIhBMme6WyWBaeg0OnqxwfhabGkSvfgJksbtEAZ2mU7w/N?=
 =?us-ascii?Q?MmBQYSlLRATTnAvh20K7oH608Eg3pkw96t5kZZBEkeVgBV4ftFAjlzADP0At?=
 =?us-ascii?Q?bdjEzXk/4e5fB2MrworWDQcu4VV6wH52mdfwW2c75C0OYYUe8KXq5k4hAs05?=
 =?us-ascii?Q?dnK/ZN8aRJQz6umcS8i/KBzOEa/CpDt+qEe2pG17lKvbilgOBko5Y37KDf/T?=
 =?us-ascii?Q?0WUBSD6m0Q5dRcfHFvOOgG1m3nu1v2N9RJaQgssiUhDE5rmIMFCXtR/FQ6t3?=
 =?us-ascii?Q?cCXuC8XACyI2mfxD+H7tBbaqCoOWdtlgRVxRyQrX/yxa5LcbrYQV5XQB8Kxt?=
 =?us-ascii?Q?gfSB402nxrd7a3yZQGJslRToXlMvAIAM8jaQ1WS9Hf2tZmBItFcKKvxoeE9B?=
 =?us-ascii?Q?dDkZZsjzx9IBwPsHem702XxSt5YIwQVL5esNwpt1iqRGpkC25D4UFeKIPelL?=
 =?us-ascii?Q?EbnEjE6fBCu5rTDF0aaj7iWs+AWNi9NQ8iDncy+TbwrzkPuLQxyG9oOysnwn?=
 =?us-ascii?Q?QSNl3x0G8T7nRSPJJ01XGX64fip07eoZixabH9CL3jENGO1bIFLuNRaiZ1Nm?=
 =?us-ascii?Q?aTGVnytSZ9i3FQd3IBdqMSwIO2Q7E5AN7DLAHfeSNQwvMvgt44L1sQJG2S+H?=
 =?us-ascii?Q?Hhx/z7QCNgE0aGbdvgsxjWCz8FCnp8PaqJ3UsYrQ+igvmniEoLLBHQl8hHS3?=
 =?us-ascii?Q?m9V3FcsT8EjNoHixBQw/j0HfDJMCQG7K3NMmqIA8fmADQlUr+shRa8gTMmIs?=
 =?us-ascii?Q?q+M9Cs2MO/oullALJJ6w8H7KrRZ6zvSQRWQ2f1YyEesaBIGo9fdRuWAPajGH?=
 =?us-ascii?Q?txeYLyxYBfACKeHvzm82V86/MvqzsqasUWOZcnBD4oTs/V9GSRGZ4XA8K4cV?=
 =?us-ascii?Q?C+W1c4v+1OBqPvgnYhVNKKaUTtWeX9wOYqKzEt7N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d36b2c-2ed9-4210-9fd1-08db7bc70d06
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 13:11:45.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O38HmcdpqxxPhlC8t6L3cuJZ2cRDXOWjNOAW7+yjpshkmyk6o2n93ediGyiS6cuaqsZAMj8NoF4EGPy7Dg2zFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will replace the old version of 
undo_user_init and use out_free_netdev

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 arch/um/drivers/vector_kern.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index af7f6fd4c..7ae6ab8df 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -1646,7 +1646,7 @@ static void vector_eth_configure(
 	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err)
-		goto out_undo_user_init;
+		goto out_free_netdev;
 
 	spin_lock(&vector_devices_lock);
 	list_add(&device->list, &vector_devices);
@@ -1654,9 +1654,6 @@ static void vector_eth_configure(
 
 	return;
 
-out_undo_user_init:
-	free_netdev(dev);
-	return;
 out_free_netdev:
 	free_netdev(dev);
 out_free_device:
-- 
2.39.0

