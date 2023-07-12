Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAF75098C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGLNYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbjGLNYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:24:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2114.outbound.protection.outlook.com [40.107.255.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CF1BF7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8lgYKRxUEYc/+oVSp55h4eJ7lflueIOemItlv2d6X8OtcNvlqK/Jt0OYfYVaFfrxNsx+URfAP2SisQT1xcXk+GRBwWpKK2+5IJdS1+1ZFQZu4zfU3WNKl+JK7ivlDeDfNcpvRGsCcTL02ZyNFzmprQLmKbcge7enntt/4aIxj0qXw2OylO7vvlPNIz9l6kjclrmdcC83BCeECmB/u9aa6kFL0zWSKSNZck8+LLNDiY0q0Ocja20yY/cmgs2jmxmS6OLatoh9m5Omm94rsDW+wuQjDcMM3aSWJFgJj9jQCjYgKuQFhker+vN7K6xCWoEw8rqcJ9VTH1d0kAhQPUMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uqz2bE7yp51gtj1c1rObEdF/SihET8pPG3OU0DbKpg=;
 b=BviUq0ObNQZGDvGy1yGwdtceNM83KVo8V70xG3yo5z5X70u3FNalRDV8k3cVKgUjnRTqFBwZxSB3tT8qNMm7AJfgTb0TokwEs9J3U1kt9OMezMvLd/94SAB1/6m9biO2kDNyDPIJHuNa5j9bJWAtfnznfVHLVWjLYTSoWVbQ7+bPfh1MVsDScBQJzwgXNYQeXr929HAsdVar+ZKbk0ufglHgJAEQBLfkc7WvpOXsm+8LfmMKSeokXvyVjzB3w43Qse37ahGw5kYdqwaCeoLDD4nsqH2r5fq7sNwGBediu5WfVKcafVrjpa1zgzatPZfXiM69jvr1a0B9Ebp7MnDDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uqz2bE7yp51gtj1c1rObEdF/SihET8pPG3OU0DbKpg=;
 b=It7qnKj1j4AFlhpyEEB/zF0Cy3P8a+rmbnClzm/IQMEc34S4w+6xnWhEvGDqPlzZ7WIkGvJBSoo5Fh7SvYShFToEm1OaEaFDN8c0Lz44AFGA5+zneTMT8tCe6LubB/XCEMR+2LK3MRFOuE6ZLy25DS950wmZThbvr7You8UkkT3D1nkuRG4w2RpEnXoYoXTlAlNDXXpaitNsFKLxpCGCQntMIGO2ef5cajoWOlrKXU4DKWEbfhLudszTHc6ytYUakjeRiBBFd6KOCMZ8IA2e1LH+GNvksNUTjkxhcM/Cpv/17RiEYdL1ZnDuKn+OapFOyLt7BwaWGYQUXONeUbDTIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYSPR06MB6339.apcprd06.prod.outlook.com (2603:1096:400:412::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Wed, 12 Jul 2023 13:24:23 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 13:24:23 +0000
From:   Wang Ming <machel@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wang Ming <machel@vivo.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v1] bus:Fix error checking for debugfs_create_dir() in mvebu_mbus_debugfs_init()
Date:   Wed, 12 Jul 2023 21:23:28 +0800
Message-Id: <20230712132343.8802-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::15) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|TYSPR06MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: ac34f690-b390-49cf-38e3-08db82db4dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 18PVq5BWX1yYNsZIbx+cvcJWQg2GC9omps40sgrh/6wkWc8lTqjK9f+VEToMkYs1d9YVFExVojDEagqyP4Dwbktv15X1WFvLygeFZUGNDqiKNggVwT6F8oDYB9SSd5zVkSewjsIBTPdz40YfBgtkEK/9IZy2yQnIrjCZnkOalwTD1gFMOxWwEkWh3e+nDa0CwA74gj/V/KLh5weLD6EdQPH43l5V1rUplHxs8+6ZENwXH83jkMl1LKkinPUvQE1ZcNn1BqcT2iVegqEH21FjWNl8Y9jmwIEN2GGP8vC7ZmKjK0aOD3AuTFUSCI/bFv8HS4iknNlUVhTJQtOj3RL/5rRhriMI/j0/9dyibkNyRmCXU+WBtF34xsJav752DxEmtHu1aN9dhZ66S/02y4D15VyWiaNF3OjqCVXo5JOpAY0goo9Rc1sig3GyM5c9M6/l9pV4/G/vcrYbJHI7wV0c/f73bP4Vuvmh7n5FwvEQSBXQ8v/oLGyd54rg44jhBw2McazzPPgbXf6Q9L3/RBampFgErSsRwfwc/bUZbp3/pFFxWOwsGb6MHtFq1tfPebzZIyNTnKACBZ24dY+zijTae+SjLFpplfv6dFiTdB764nJSslpeW8d9UxeFgQqNTXpz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2906002)(6512007)(38100700002)(38350700002)(83380400001)(2616005)(186003)(26005)(1076003)(107886003)(86362001)(6506007)(5660300002)(8676002)(8936002)(4744005)(36756003)(110136005)(6486002)(52116002)(478600001)(66556008)(66946007)(41300700001)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?of6gXoO6FA1kdn0JwcyE8BEWGsjjbNWeu6f39VDJBZMD/3KqPTtl9vTmUqgt?=
 =?us-ascii?Q?cjQQHDKhjN0HXYVQLiy7/n7KArvZ11SztBTSc3XBnfQELb7qxNRPAIagqeMP?=
 =?us-ascii?Q?d4GKqLeyU78sSeyCjZAb99Sl9NbHqnxRb4/jMwEZKwFk0un+2s1v2AYiH4PO?=
 =?us-ascii?Q?PeqnLyCX55foUjVwtt6fLE8kuOtKEbFxahJhLZ9X9/9fqGtwDRqJl3PlfHeU?=
 =?us-ascii?Q?M727UCa/mbiXemG6/AgmG8wwgnIQDedgZfKqKe/9QW7qsddMP6PLXtXdJ3v3?=
 =?us-ascii?Q?OVyuAaU1Zig+588+T9ZXjDDERzsqb8uz6r+DeYv9r9eeBfh7X2nylsbQhbDY?=
 =?us-ascii?Q?PbkqfhF1Sg9f4AMjYuvWdGYA/uXBue0G/RJEguyONh2ILC7KxhqBj12kOCIG?=
 =?us-ascii?Q?AtF64neNuPC3HWfC8kN/CeXf6CmgSJMd1hnzDHX6GRti+zUbfqvEmP61rNw0?=
 =?us-ascii?Q?2voR2bdAYUjuEidXwfmE9ZqQCexOyr+CtUbS+MiXh7xYtiQ8XihQlipbCwRa?=
 =?us-ascii?Q?rlo43pEeXsABOHBk3x6omJXw9yS6JTvC5XE5KZ3JHpRDFMDvhImDDVqs8gvG?=
 =?us-ascii?Q?RMNXrQZfbvv6JqpYfK6llXkgSEvtGEwvaLENoGKoAPoI2XH9+XtrE3HycOLY?=
 =?us-ascii?Q?7msHjoo+D4HZ6+EYfKITBAeVJXMwOzpVeOYlA+8w4+yfpPZvIH9ZfQApzhz/?=
 =?us-ascii?Q?f3PZkmfgCKjazw62cshhsf5QAmR0npDP+Eeg2dohGJc/yu6UNypFKMbFLEMp?=
 =?us-ascii?Q?1ZfeVeRsD1OpEkmYZLKCLNHfihjgIymWUPcIVBIsnz/syP57FReYtxLlFdhF?=
 =?us-ascii?Q?2eWOlATsIJfALqSYQEeE4sZd5acW757xtcr18bWMnbxEpS+BfDm3kPYTGN+L?=
 =?us-ascii?Q?XJavhiKXR+/EXDVo/ikexiSJ0PfovIFAeRU2fr5cn7LJSL1Wnx5A6bRHX7t7?=
 =?us-ascii?Q?ZzrRCvrvEp/v1VnUWNp9LN5KyGEA7j5AwdkQgyaJkgs7OrL8sQjwPjq6aE1t?=
 =?us-ascii?Q?wyD9DWHfUCkeIDAV2y66eGssRnHX2aJjAx5iafshXjpOHvVRSUt58yaJCeM2?=
 =?us-ascii?Q?nZK4a5wvxEgh/UUO4rFoikxZgvcCPxV7cU9hAbIQKAxTDjeF50x8JTcQXc90?=
 =?us-ascii?Q?yjxBU7V4v+nPgLHDfmDrA+T8YZ82GOIUfYZZiXjUb+LAOTQVABovSk2kvizD?=
 =?us-ascii?Q?vpsIvBEcCnwiQKOtz+Xwi/Ui9t68qU6746+K0Eh6QDy/grhl20pKMFc7zXl9?=
 =?us-ascii?Q?SYqtb4tlFYfhoZg7bknKM39sqe6PumGjYiVBqX0FLWEINKImY5As+I7Xj52D?=
 =?us-ascii?Q?wUt/W+DvDlABeBeUF3UetzzKqmbaDUmwjIV5sYM5hS68uC1BntHLSo9JVHek?=
 =?us-ascii?Q?3CegAe5aG1Ho7lV8FAwlGAU0wC3TLx0Tz0XnOp3MSmACW5etvzigTOWFpDGm?=
 =?us-ascii?Q?mKtsRcLq8wNd8GVVSrkBoVm9nokkhr7HbcaMYjICJ91iYPq8Rnv8pQc+OtUD?=
 =?us-ascii?Q?WBhS4UlcxB2CFb+m0pTZNlZpTGB2GZadsNZ0ZOvF+7Rx6jlqjbXk3zWDOSK/?=
 =?us-ascii?Q?CRD/VQmTLd775gPm+5jGkqESFWtV3X7q7+1Mh5xw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac34f690-b390-49cf-38e3-08db82db4dfb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 13:24:22.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asi5ZUEsTvPcntTZp3T+5BPPunOrLPhP5fSWo/DvLWMNcMaCAewOm5kj2lNXVUQs7TgyQ5me219KYdbXnvqzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6339
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_dir() does not return NULL,but it is
possible to return error pointer. Most incorrect error checks
were fixed,but the one in mvebu_mbus_debugfs_init() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>
---
 drivers/bus/mvebu-mbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 00cb792bda18..4c514894cc1f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -993,7 +993,7 @@ static __init int mvebu_mbus_debugfs_init(void)
 		return 0;
 
 	s->debugfs_root = debugfs_create_dir("mvebu-mbus", NULL);
-	if (s->debugfs_root) {
+	if (!IS_ERR(s->debugfs_root)) {
 		s->debugfs_sdram = debugfs_create_file("sdram", S_IRUGO,
 						       s->debugfs_root, NULL,
 						       &mvebu_sdram_debug_fops);
-- 
2.25.1

