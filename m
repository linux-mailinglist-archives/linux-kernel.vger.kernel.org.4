Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3BC69CD36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBTNr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjBTNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:47:27 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D7A1E1F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:47:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LREQjqHDoWTWdQJlkxOLSNEn32g6hrX729e7xOvJlop1FRnpXo4yi7X6aakrBbTNL7GRm30byP6tlBwP978mNbYGnmmxzm2KNhVXwd8YAm6kkJSgGWC4QJOBE0jWLQBYnV26xDhUdxItVPj3x/OzZ589W70RlR1kxI9l2vtFmg3Wh2SuX/QOli7cbPonZDbuHauqPwI0m5P56snvYfYi0VCJDEZDOa4+rWjA5CdXPU0iD/WpUpG3Ejj+ojP1WcPNx3B1nWCZxY/Sii0xLpfr5ybQPHZz6+IOTinoJs27498tO2/NegkzZq8WHOvCB7b/9Gj4tUdtFsR27YG8R57MLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQtaz4aQV69kpUr/6zrDopdjPrmWDadZ7rpWz2CL5KI=;
 b=iJt6NsVUcP6P7AM3Cm4zqOTPxP0JQegoSXjGwopCU6ycAK/EWKTYMD4BQc4EwsV20XQTdu2VpeLBLB8EnpUPg5SMr2yW4eSXw40ZI3FI5q/VUb8BxVbI8DWBqlmfRQZUO7SJKpQeUO2aMGWtO6rqAFDc/dsbUy8UnuJ1kPZVhq0BxShD4WQyo7QIPXZE9pUvcVG8FhNw9LzoMBG2GVbgXzA0DQXRo+8P6aKSR03ZZeTgfq5ASqokqUgtkq1CVodV1WPfOifd4HHQHo0z+2dBgRKB2HLByFw2wlnNjK2XFD9cH28K6cDSBPyFkSFk0gh760Kt67UrQXRyO/qwyUsY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQtaz4aQV69kpUr/6zrDopdjPrmWDadZ7rpWz2CL5KI=;
 b=RxrumYT+eJyLu5MjvmK9j8T2TmkKVvme6GMzMTcXZZAdRVl2X4pg59zQzxsja/MK8x9XdH9/uVIMP4BcomhkgVlq36aO3LIuGpN0T2+OALhbkT2/WAhLSCxhs+QoMMkAFnX3Nux4W1WxcvUcR2zXZ8VcOI6E3h6Sba51nklTqGtWXvt63T8N4IfhsFLiyZnpU4vkyDPqxIF9h88p195PYmTAl61NNW9QaceLSkpzmf41dGw042iu7L1pe6GalL7wOYs38sLRFQZc4U8gO+djiuOGY76d6o802NBzV3qDgLocYJo5pPXXr2fGs7no+y0OFAcRt4T9YclXawh45MCmXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB3993.apcprd06.prod.outlook.com (2603:1096:4:e9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.15; Mon, 20 Feb 2023 13:47:01 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%3]) with mapi id 15.20.6111.009; Mon, 20 Feb 2023
 13:47:01 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jack@suse.com
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] quota: make dquot_set_dqinfo return errors from ->write_info
Date:   Mon, 20 Feb 2023 21:46:52 +0800
Message-Id: <20230220134652.6204-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1aba67-d382-44be-f932-08db1348f19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+FwxknMmF4tk7oOYZdkjhu9zJvdTnA1LkpPSKrzceRCEjDyNiofAUQGSk9cYrsEZseVnvoBupa2TRZLROKih0ewHLhex5OTL65dOHeD6DpG3aPH92F4qSaGXWm3Uvs/LAOBB+sMlJbUWxM1kYnYKMAbJhfWCxDCM4MAoSfmiTr4VRuMX7MDAD+0OaShyu9RQCl3pe3HZqffrZarcnLpMZ/KpspxzKaQJGQRJx1BmCAcSz325nqlFm43fkc6B8J+Ns1u3RHjCiTlrYzDA7xcP2xnVVBRpFqkX289znh6eIlOCi7abFRpxQrb0RISU6ep26Fo0+wbrrj9AgCMFOTBIs6LZdMLISQ8OQW2NhWmp4PdovZZqpGrvdWtPMU7yxbjlyeWOM9c/T/U1fWvTukRV4z9wBBoG4LoBfySJx6ej/Tgz6ZbYSFW/wudp+QoPEVwDMkJxPEIvzREsluSoiTIp5ZKf1r7+NajmgnRD+rv+jSZXeCck1puv4sWFe9BY9xH2dMNyuM2mxja+zXbjhauLoRbF4mIk0AV5pOsyEPB04hO2OiFWztV72kWrDVG6YV/GBUOMsQ1eFGjv9u9Wf7QPPaaQ1/9bxzBySEK1YAavzYzrMLi7fvaBe+99vQuhbcI64XSsnL94OotwgtY3BRnm65U9ay1LiZxUO2YHXqwaF0Zop0DOP+RqebVjAnLiO0rXn4wPHapDE1D2kzBUMEZXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(6916009)(66946007)(8676002)(4326008)(41300700001)(316002)(52116002)(66556008)(6486002)(8936002)(5660300002)(86362001)(36756003)(66476007)(478600001)(6666004)(38350700002)(26005)(1076003)(6512007)(107886003)(186003)(6506007)(38100700002)(2616005)(15650500001)(4744005)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjFDYZ+fF2Gfvx41S1ddxSYzXBNKtQU2Qa06spN4hWge0WZQCVmWGj/oGaJv?=
 =?us-ascii?Q?e6KjmgXEsBo/OVQ9q2x6jXDqwX5AitE06lw48KEe0QQKG4NZCGFIC6D2L+g7?=
 =?us-ascii?Q?viX9Sr7gRDVVFfsucBO40NNRTONPlvM43i+bAfEEWZ5x+CyYyPTspqWnGwTs?=
 =?us-ascii?Q?uQ1jDAundl8kxAZir8a17VpFntojARVmpB/OjJ3vzUTvZ8+4qJ5ngA7L9NKo?=
 =?us-ascii?Q?TwDw2P/4M5Zlo2rhCYkUjDBVActEik1cbOG/Y4aPUEPITYxvPidU09HiZwBy?=
 =?us-ascii?Q?1kCxBMx/q5Gkv369Lx5zvKY7KMLiPbhkkAWk12M0doe8eNMiRZQIgcqfZK/U?=
 =?us-ascii?Q?3wF1FjRieMHnLZ4CdZy5EgCa/JZkGbzkEjpBzB/c7kVp6aC0n/odOfwTU3IW?=
 =?us-ascii?Q?Y4qT2HokeE/AIarQ8GC0K/eOCD6DFhI6cLwyruhFkA/dqOqkBNIIxRrxdegb?=
 =?us-ascii?Q?KFSk/UJuED2ijo/zOycO5mlLqp3t2BqTFYeQzQK8HM+j5Hr1p7BkyqY5Wa4r?=
 =?us-ascii?Q?Bk82JxReXEZq0mxOnyBTIznhr0JGmambLVXAyGxlnt60U08T7pCVvKTJG+lD?=
 =?us-ascii?Q?xuvzqukAOuP2X08MkAsfMxTbTPMiiNgo+ZXb0i0BKOgGWDEFIG7WAg/pQX09?=
 =?us-ascii?Q?t2ZEM6GXPKmA+4ccXr+GpYe/buXz6OnbFnYPhnz7zH7NbfF+CdAI74oX/mv4?=
 =?us-ascii?Q?KFBDzvpOBaQyzxADGGIKmKkwiXzdSo3SL4LhnX51+9QiaKrp5lrDdrExHSQ3?=
 =?us-ascii?Q?NT/vGjVqMDca/2kvjV5/VkoLwmeeEwmH0wQ5BnToULDzc/tvfX2M1U3x7805?=
 =?us-ascii?Q?yN2bJpP1uiq4b8zwtmNiVMDnDNa2Ldytif80j6noPYtvgcfPorx5NtJ4B2SU?=
 =?us-ascii?Q?NctFeZNQ4RKDlNmNGXftA0v9jxLgZ+z1KQmjDzDlKFV3aOa+7jnBzjabrx+B?=
 =?us-ascii?Q?ob+Mfk3eYZd3Tywfy+ez9BrjYwpDAVjpsqc1q/5V8dz1oVeFLV/bh3/RB/bR?=
 =?us-ascii?Q?YsMuNAqSR0sEK3B6omtAtT6TmHVXzd2Qy8hO6lF4iJFm3zQDIxFwpbtS+ltl?=
 =?us-ascii?Q?yAtzKdN1zQMw6U/d76dV9be7yErKsdeB/nJkAhypEVu/Pjv3/1upusauN0Zw?=
 =?us-ascii?Q?I5IVQ1vKLjANWYHyJotr5bTpbPZpKQ85H4lTljk9VmcnLQgEt4m82INTBI3Q?=
 =?us-ascii?Q?KryyGdmeA4gTpk8LIDVuDeqfvw7LTOYxAptbMkFksvaD2PymeS/e3K/HyXgw?=
 =?us-ascii?Q?3JC/mT3Hw7cBpQxYBy0LClKqmx0rKS/cCoNcW42ueFUZva4VRbHob8RnBsc7?=
 =?us-ascii?Q?kA06nTKWewexatgIq4/4Vd8TKLgPrc9hrusL2g7LXVmHY0lf6dz5W4dcDgvt?=
 =?us-ascii?Q?cLLQx86cERTalVlYKX68BbjhLnIEzM2JR6/zoXQbGfm4+510duNrgySfgCOj?=
 =?us-ascii?Q?G8dye0D8APLZSno8a56tfBSURZes4Pssz7tBZovV3MwYL8utU053zFcaUl9c?=
 =?us-ascii?Q?02fYMn55ISTefAHqUeOdqYbJn+fnlR/fpVXjnYQS7yt9DP4KuZBbZhXZYK5H?=
 =?us-ascii?Q?yDbqJaoioEunAAFYf3n5LvGLPwdvwjPo2eqU/+Em?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1aba67-d382-44be-f932-08db1348f19b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 13:47:01.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7yFX2XmEY9VqX3LB6bioWTiVENj3oBcLbQ06qq9p+/TmGsiZUdD7gVrudU6DIji6J6Pu+Yk8JERoriUtNI/YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3993
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dquot_set_dqinfo() ignores the return code from the ->write_info
call, which means that quotacalls like Q_SETINFO never see the error.
This doesn't seem right, so fix that.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/quota/dquot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index f27faf5db554..be702905c74f 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2819,7 +2819,6 @@ EXPORT_SYMBOL(dquot_get_state);
 int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
 {
 	struct mem_dqinfo *mi;
-	int err = 0;
 
 	if ((ii->i_fieldmask & QC_WARNS_MASK) ||
 	    (ii->i_fieldmask & QC_RT_SPC_TIMER))
@@ -2846,8 +2845,7 @@ int dquot_set_dqinfo(struct super_block *sb, int type, struct qc_info *ii)
 	spin_unlock(&dq_data_lock);
 	mark_info_dirty(sb, type);
 	/* Force write to disk */
-	sb->dq_op->write_info(sb, type);
-	return err;
+	return sb->dq_op->write_info(sb, type);
 }
 EXPORT_SYMBOL(dquot_set_dqinfo);
 
-- 
2.25.1

