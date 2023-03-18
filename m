Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535176BFCAD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 21:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 16:16:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DACB211F9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 13:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWYHyiaEQ6lP4i0uBNrW5MSc9cqsD2Be9RYCTAPYFFRlxEJAX2jEGHi5LPE1uNcUmBJ3p6PhiM0qqvlaKKFEmWh6DqH8zYPdUo4HW7V/ntjM4WzBpXtDfhljaIFCPQHlUgo8o62hF67BLWxfeNNH6gFpKzUmwg09ht+gzrLRN8Uf/fWfoMSXkEX3PtcLyeVN8zSvymuIfVkDNeocZAZ8xLLkYbsfkalK1Y7CFrOFRwH07N2rD/ptuUd213DoNCXAQ4hp96UVAB7tnSsHChC91naPMyvUF6OEOtXTIZ4rSKMT6CkTrgsuDcd9Xi8P1Qd3p0dT8p7PPDsmewd11vMvDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNwcOwmhOOXwGP2v58fMFXMsY7+WbcCQ1tbvb704xL4=;
 b=PJYc7iz/7eUQIhnvWwUTYIANSaKd00B+YmjDvVk3gZPG3PYrpNP1qK8Q5KG5XgXhIVYtJu4+DEUzO3hJZ7hrGOEdmBqX6yycsrgzSUYLq0fbkE7bFOezwTjFo2GJ3FU9flBhyPsRiHZdGr3UsI8SN9YmgY1o/a5xi+Cu23Ue5pj2U2E3m/jvNDou5iyyjQ4TPAwccDg9Ete9BS5xCHQhTHC2qDKXq3qs/Hy7HMaycW9Z5vvIQaS/YjwXI8UQsOrfjkCMdFoUifUrOhoBgULuMzJbxKDkKWhGG3Z9xhwanT+RhLnb5YUzPQ99V41QAU+/P+CmccgGKv5OtRMQLHTrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNwcOwmhOOXwGP2v58fMFXMsY7+WbcCQ1tbvb704xL4=;
 b=PbAontzNRqVZatG+YIaQDq+jjC3qdliOwFV8wS0SZlSencwa/p1hX0nGuOmBr3U8rF+P3JXmE/r1lVxmMTgUClRmOvGmbjK9nlP48VV6n9irdQc0ZdrDKqnSEt2+XpwTtEj/gTxbo6PsOYtj6sC5F/Cd5oF5gUI2B2XcOCUsb/yU5ypYHKxy0bND55NniPP6pYtFWuvX0qOQuOAHsBFsFK0TzncDp06ZDTaRsUu71IuDJj122jxxaUF55aFDywnIpSsle/a80pd5tCUE37rRiRUqInsH1lYGk3+tpheJi6WeM/z6J7flnqkYI+KnwrUIZguMT2rLnRG3rkckYQyzyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TY0PR06MB5077.apcprd06.prod.outlook.com (2603:1096:400:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 20:16:53 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 20:16:50 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kobject: introduce kobject_del_and_put()
Date:   Sun, 19 Mar 2023 04:16:39 +0800
Message-Id: <20230318201640.63238-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TY0PR06MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 0708801b-b485-40d1-a981-08db27edb51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCsvm2QDBX+CIFEV2nsZ7NY0pfSzbx1VJWSPcZqWTtjwWHP2691jVWy8mS/4nvHV9FKl/HcnJaFUDmlFzVe+uhveIZHmT3Jo9Jjr5VOBjPDUuRvO8bJH2X3oMQUqpr9ukvH8pXbD06JH1QbMW+Dh9j8k5WgoYl51MG7oZssvt18Hh+an78S+rj9bUN6YDPP7XDFGikufRvfpzn6UuCTsdAvdQixRynOiP76RxCGuPbtNIW1nUxZUuhRYCnY5vfwhjhC3wIe+oLw4QsBPawUYAesQ6nysnaMWvhel0GJ5kq8HlGE/MEu9wEEoUyWrPl+agjVqZ9bFuwfT30rcpzISqDgz5LtqkiUN4+hhdO3GS22n8ke7YaKKKUGdWfjgrgbwoV+QTQC6HTrUVlh446tj/RtCxSRMvTNT+nfk05Q2MCWlO7xgOZFDKaP2w9gzPELx8wbVnqdJERyXG0U6XaDzpw0TB/7n0CcupFfiP3b0sY/KopZJs1olBf4Nci53FCw2s37CZla0llNhCHPZGo+jy/arBI1exJCJCvPn+GUbgrirs3xdymu1NYCaTBYTfUQBMsVNyBe3Az1AWWau4kfbFRVh9N1WU89frobBujL3pN+wO2favljbb4B9GCwIfhbwPo5qH9O16SuVZBPoXEzFLup/HgUi/X109Bf+Ne+sl2D5pT9DRBSSNn39mU9n93ULOaK2UU7d8Q+/OarQjzTVQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(186003)(38100700002)(38350700002)(2616005)(6506007)(6512007)(1076003)(26005)(8936002)(41300700001)(6666004)(5660300002)(83380400001)(86362001)(2906002)(66946007)(8676002)(66476007)(66556008)(52116002)(110136005)(36756003)(4326008)(6486002)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVtP64cwicfH2cL/gGAsFjWxGGSqEnXo3cRq2MDhmgCgUnJTp00bn3tf/Vea?=
 =?us-ascii?Q?koXmLGE5nDj40SHEaoZ279YsXSsa1xSvnrUzt1LgQ6HkyqK8U5+kGu3/ygvh?=
 =?us-ascii?Q?DNXGLTmOwtPjnKYhlUglK10RcqKCVRkcKEsvEoUi7IJi7WJ2rlmoid9LrqAS?=
 =?us-ascii?Q?540qEdrR3DePi3fxNhGcxVdGWsz0f9oVl0pZKWW42f25U0SAp59kWEivaFox?=
 =?us-ascii?Q?2NNAKUA8D1prIlzlNCtJRyunPObpPlTvzF1fnJDZ2XtA3hf8Vu/IDVTgUQ7l?=
 =?us-ascii?Q?FciIBfOiqjPc48n/BAeDENuKgyimsfjKrYUmygf1cgyQYlWIypm19OYK1gLM?=
 =?us-ascii?Q?vvsEave9f/arNXwpw5LfwleDw9Z9rh94beDSb5S7D0LYT5K15N155u031Rsm?=
 =?us-ascii?Q?B2eqZSINmd3IhUvQKAbofFJ71cckY1gtOosjdvBb329a4Ef0tifJXT6X3Ruf?=
 =?us-ascii?Q?5iCo35/zsbIBxrpx/zgILGZySXP6TeUxlCSg3EbTyjRXAXn6vKD+G95UEw3J?=
 =?us-ascii?Q?Dcx/sgVLK+TlQ1G82AtdcfU6M9dSM6V0GjrOWVulWE3rIXrYDXBOeeLIwgfT?=
 =?us-ascii?Q?45r4vBWTc65l/ymhL5y6zXM5Ejei4+WOGtYo1tnsd9LQQIx4ztTfNcap8idi?=
 =?us-ascii?Q?hLUnkmsrCeorBfd0vKvygKnewuNoNfGq0LpqCXdSnKOgow9YY0T0sV0hjfkI?=
 =?us-ascii?Q?2v0VWe9fscZ+qFEFg3i0j3v7qBlO0Y3U4VPhJI9awJLP9XALAXnsiEb6FUal?=
 =?us-ascii?Q?xw3AE6seeDCB0R0wgV88kvpS7U/w4QN5VSymgxPskE+khhvp6zQgeHsjdtuf?=
 =?us-ascii?Q?iHQEWKcgR02j9UcT/BCxEiFZgDtxmjhNzg5Ua1tNwXcf6+/m8IXZbfi6oLHo?=
 =?us-ascii?Q?/cYFrgVL+D9LbiaBS9l2eo63H/X/jUoNjBFprB10wtGL0W+yAf+zc/FAspMi?=
 =?us-ascii?Q?65RMQ93wocQzVNlWEwwRCemdSxS/pYGD3wADzyYrccAzThdh8F+bNWBljBdg?=
 =?us-ascii?Q?R9/3GJG9pNHSzzY9aGM0JEe2VZmD0jEWT9aUXm3Fe52K1/2entFdLZ8ew5Kk?=
 =?us-ascii?Q?9iSiTKNfCzJ7L9ra2HO5qnllvvkxDiqFJJDXCXhmp/LgGATxzhh7gLII3eBv?=
 =?us-ascii?Q?G+zcwo5PE327G41BBRg2pJtcyj5g2r6ISt6voEepO/6BjtBGarwQBib+k+Nu?=
 =?us-ascii?Q?Q56wuGVNld+eUoYbW37aY0782TOshWDst+MeGuX0jurLtZqP8/aUrIzYtfE7?=
 =?us-ascii?Q?libv46S9JhmYXQYMuq+ttLgft32ln0xicOtKuLi/UcMmDm3DMsEciqvFO4Cx?=
 =?us-ascii?Q?0/I1Es3WTd9Dv1L5frTvFlzB3b/kjYoe11g1du0mZErC7fwhJcWVbRwuoqrn?=
 =?us-ascii?Q?dyu7oisYpEXtdz+T8ryY+F+2V7dQGqX8TtgiclSCCx9Nftjdp7GAy+n59gmn?=
 =?us-ascii?Q?jC3SbDcBbQVqsJ7vXXRPAvXqfRGT6n1qYKVTrlFHtphSRj5ZXBxtl0D/qOII?=
 =?us-ascii?Q?dsvoRiGbhgchyco2Z202ODexOicrc10DzA971tTU/dk+gbliMtG7HraKA9p8?=
 =?us-ascii?Q?5e1s3G28uPqiKoLglxj/iOBrHtzczMgvjNDV2op4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708801b-b485-40d1-a981-08db27edb51b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 20:16:50.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /liUYT4gv/SFGFc2h+m19SS3qXTO3zyxJ8rmczadizDmuJfEsZimGYKRGRUCb4PJF4XYCkT9My/1br7WyzMYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5077
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are plenty of using kobject_del() and kobject_put() together
in the kernel tree. This patch wraps these two calls in a single helper.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 include/linux/kobject.h |  1 +
 lib/kobject.c           | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index bdab370a24f4..782d4bd119f8 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -111,6 +111,7 @@ extern struct kobject *kobject_get(struct kobject *kobj);
 extern struct kobject * __must_check kobject_get_unless_zero(
 						struct kobject *kobj);
 extern void kobject_put(struct kobject *kobj);
+extern void kobject_del_and_put(struct kobject *kobj);
 
 extern const void *kobject_namespace(const struct kobject *kobj);
 extern void kobject_get_ownership(const struct kobject *kobj,
diff --git a/lib/kobject.c b/lib/kobject.c
index 6e2f0bee3560..8c0293e37214 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -731,6 +731,20 @@ void kobject_put(struct kobject *kobj)
 }
 EXPORT_SYMBOL(kobject_put);
 
+/**
+ * kobject_del_and_put() - Delete kobject.
+ * @kobj: object.
+ *
+ * Unlink kobject from hierarchy and decrement the refcount.
+ * If refcount is 0, call kobject_cleanup().
+ */
+void kobject_del_and_put(struct kobject *kobj)
+{
+	kobject_del(kobj);
+	kobject_put(kobj);
+}
+EXPORT_SYMBOL_GPL(kobject_del_and_put);
+
 static void dynamic_kobj_release(struct kobject *kobj)
 {
 	pr_debug("kobject: (%p): %s\n", kobj, __func__);
@@ -874,8 +888,7 @@ void kset_unregister(struct kset *k)
 {
 	if (!k)
 		return;
-	kobject_del(&k->kobj);
-	kobject_put(&k->kobj);
+	kobject_del_and_put(&k->kobj);
 }
 EXPORT_SYMBOL(kset_unregister);
 
-- 
2.35.1

