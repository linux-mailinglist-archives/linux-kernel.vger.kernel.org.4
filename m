Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838A36C005A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCSJ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 05:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCSJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 05:27:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441F1A4A9;
        Sun, 19 Mar 2023 02:27:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjRG3VCnZepMrIWi0ZnIB1zlCRea8h9vRc4HLxcGXNEu2Oup/IJbs84KMJaz3hi3qAmhazsGO9spkA1RXTNKZZhs5hxlMFMuVNWqxQstR/8n+gRnn/v4AcX9sxIoZQCkBeRjFf4wwkQjBkrG45yQ021DrIFAjkdiWbqcNg2UX3iJ+jyBRXx1BwocETgefl3tWV33RccF0QahHNwGEXMclF0A875ApKo4bNDthHxZQlFrX+PnsIwqxReXpBDS323lA+9lZE9m0WSTcX8pCskqbv4NcyL5noQULts2EtV7NgMxTcCIMRZ7tSU3RywAjskPLb9pui6r8KYoxOyUJ/Of6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOSp+BJif7DZNfqGwNo0uxz7Rp6qR7QtsZhgyfaKHS0=;
 b=S6g0PrnkJC2lVko1s40Sm5mZXIzUKy3CUs1gG9m+PkmSwULau+EuwKzyiYkeex+lxON8K9z3nQ/q9P8sn39sm6xWVxQsmFxK9QrdzbvwwwHbZXpJdiVTpNE39xP5ff1ufWv762J/UGbgEbydplBikrgI0T1hjt0LeW8bJau5O6Z+trWJdgJM/gnmzA1Dpm3NH6KsXLfU8jnirrz9wRCUfe5xisiXgS+xbRSh7PLibDGoMqhFiHZkSS3i93NzkiT7FhAaLAM32YuG2CbYDNDx7zalu+/XMGX02Vdf4SDJZx7B/KL9w2akDxn7i2w0aNXH4b+31HXvN/Ui5TspDahrxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOSp+BJif7DZNfqGwNo0uxz7Rp6qR7QtsZhgyfaKHS0=;
 b=N+VfLWI1bbYoDQ18JOFHz4mC+EJzApUaVU9Km0qem3ZyP1NG0aQdEaxTXLTg5hlhhy+KmxoNyxozzxwUdCjLXUUpTvsfy5pIfhUKMJ+JTqzEsB5VdB3Tl4ZxLof7V11KfEQqUFItpbjWJz5D+p10gq9KAP9Td07fu3qhfyFv+q1+LnB/f/Rl/MzGiM3l9xuxgqWkRFIuBpq8FvlQW47bl5PhY2yyEoFqft+4lRgH9N84ddtznJkUteGS0VzfXQFmK1HfNOFl2wzNpbdifOxh0j95aP4/wIi5/oIO5ICNRvmCFXhDlfXKMIBx65qzwle+5aXZSj7poDHyfXNW+UFpKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4012.apcprd06.prod.outlook.com (2603:1096:4:f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Sun, 19 Mar
 2023 09:27:22 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 09:27:21 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2, RESEND 07/10] xfs: convert to kobject_del_and_put()
Date:   Sun, 19 Mar 2023 17:26:38 +0800
Message-Id: <20230319092641.41917-7-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230319092641.41917-1-frank.li@vivo.com>
References: <20230319092641.41917-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4012:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4d3692-bfbd-46fe-ca72-08db285c2448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WqCf7bgT3615EQMexCaRiphIMCssX4CiRjz0bbppti/v945gWHQoby3MiWfFSNLtDO+3btzBsmh/2mWYT9jN1H1NkVOHbOHu/UweTwX2JrC5RNsbwcueMs4jXWW7XjeXs4Q9kcHcSzTVriJZvTg4hn50C4+EQLJ0i39j/iVYp0rVfHkb9G6ThxFzwYBINL7X4A14XrGTDO/N62WPbM3yZDJUfqQa7Udzdw5AXNI1XiSzoTsO+aciOJF7PZ41cTdIdcj3o6/hhI3vuMqVZEwo50KNPbUBDCWr4xmgs7RdT88/dO7MDaY87iUBLqZhKv5FPnjDFOjua7RgLZ6ykfMYyEti/iWr3T2qD5F0zgphpR52prNMUP8m6CeZJx1q9lKr/ysiN3szQLaTRMzMQMc1vGy0djKh9guz3rvShR+4jP4oQ5CVhbf79+1Jf17kuRa7RilzZx8+Tk+a7rn3bfCF8YkEy8a0ZEUnNQbS06jcKXD/92FVSikU1PRl5VRB3x7gJkZmPnMvzdxRt2bJSU4uI75+Jsai3r2CZemyE78vWWUmtpwKNbDP85VPZC9aU+muhyjKdn2rmH3noz/oOLZfW3BSztw1vkE8wb1nttfp+x8IoiMm+ZBj+PEcMucAIAjosptImGQrL6gfXb+w93f4kDQVCAHUT3oJFVsuNCko8oz4ICODn8rAZcK/M6Bbhya72AItWYnXx8CYNRNRBRgZcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199018)(52116002)(2616005)(478600001)(6486002)(83380400001)(6666004)(316002)(54906003)(8676002)(66476007)(66556008)(66946007)(186003)(26005)(6506007)(6512007)(1076003)(4326008)(6916009)(5660300002)(41300700001)(4744005)(8936002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?myITlizxOMNexpKekaTOBHwnG2Sj9eAOa/6DtqAJAG27mEwXNl0NINdUKOp9?=
 =?us-ascii?Q?LqxdhChq99ZVS6xj1sFZznrE2ex2+jTYnjOw5ELPtE0mi+bYRZWWRqYJ5c5o?=
 =?us-ascii?Q?JojhDBx8LsJY7lihv904gLLGWgtlVu1EJnU7INWcVhUdsXYEjxQjQo08t2VH?=
 =?us-ascii?Q?V+GtF1bxhch38o8qg7G8GudK1BR5MUbQqN0ckMB2aQMAA+DfJ86VROp5MVeA?=
 =?us-ascii?Q?bz/QraItqIoz/a0AybEP72u/QJonxCB6bXRRVZwswaWfXsA758n9EWLN2GKs?=
 =?us-ascii?Q?vho/VpYoTY/x4zZH9+CqPsZ8hYRxaAnxzs+Yg0LWZquroKQIXwNP7eHbPWE5?=
 =?us-ascii?Q?WXNX7YLBR7t/boGmbKshuGdjNsaJ/ZUB1RgpjpBvPfssEH10F41Vyo01M8dy?=
 =?us-ascii?Q?ZeZs3B1j39m23c3uSMP3D+qHdY6TUsje7nphWGa7pBsghXjOpZStB0FoD0A7?=
 =?us-ascii?Q?ZAuh1ya52aAj9iJdXOwipf2b9BIUIN9BBiotEnnkmxuYnZpDzyJ+zxMCC+FE?=
 =?us-ascii?Q?mG9pZLgLqw5ygRvNC414G3lvqZ9/a+RJXs4jd9DKPfOvuUJ7jH8gHVjvgGyZ?=
 =?us-ascii?Q?55IBef/sBxFjIM6JiikA7cfeZX09iwCTn9AUHGXH/+/3fYG9wsELfqqOlaZC?=
 =?us-ascii?Q?ZvX4yedGmfCe4WMF596fPyK+MzwZeImGId+ogaAKGLjj/N4eXj7v9jYyUO4P?=
 =?us-ascii?Q?kufW72JMYSxD7n4HcsXc0nWBmNbCBGeL6ytgR92fbw4VrSQobtAozDjDW7XH?=
 =?us-ascii?Q?UNryE+WRL9S9D/qTGRtmC6EQWVOWznSDRSMANVHHQk15quAm1nGQOlhMeD7M?=
 =?us-ascii?Q?6TYtJIDCq91WEBu2VT5QtfoA34TyqQ08wmhfEj9HC2QwJg/nUzEr0by/GFuT?=
 =?us-ascii?Q?rPCLiXlVy7+u3fd8G6yD2IDg6OQwoeW90761jVXgFlk6e7vP3K1ZwF1XVUko?=
 =?us-ascii?Q?Qq9hg7UwO6NPcsbGEKSnu6swUNTMNvl+5L2oUZl3EtN3Qvims/cMymt4/hxM?=
 =?us-ascii?Q?3fj22/Jd2CcdSj2OQi5o1yQ3T4t+5bbE283RCEr0HS6EE8u6x6fpFvO+pOvd?=
 =?us-ascii?Q?oJm2n5/CK3dvDfH1ooIINTrYPH9Al46maLgjEWT9iiCbErYt1fCU8a80ltWH?=
 =?us-ascii?Q?HBTj9yr3U/83sTC5QPbL4V3Lw3qT04Jx3GIyf9VyB1Zk5Y5IWcXI7Co8rQCl?=
 =?us-ascii?Q?dEmaQD0JMiVULg9Yr7aUVuaQQHKnzpOH6y9FuDIuB4vZlunjbN/52t7qs/Kg?=
 =?us-ascii?Q?jFLycGPn8oII02fo6AFgPJFiioffObD+TqIX46o0NaeCA6KV2ztAWeRy8BM1?=
 =?us-ascii?Q?3+va0ivtoTphcsa7jT8iI11qDi/uLwp7+DKxi7E72RoH4CrTjh3ocL7yoUx/?=
 =?us-ascii?Q?byNTjsaQPAK1L7RvUZ3xXdfBwdAjW7jsJZjPF5IpnTKS8aueXhI4shjtj6eU?=
 =?us-ascii?Q?y6naj8TqwjSa7lIHoAfC9oihzKcN1E2MbpqO0d8/N9OEghiUn5CoEcsTtaSI?=
 =?us-ascii?Q?ISUnZRj9UtUirgSgcVw1z0p8WEds6VNqV+mWXkqVCX7zUUFfflCMIsA2dkWL?=
 =?us-ascii?Q?FmORvwEfo1b6knaZy0sM8USXmnvSNHGUg+ERHxi5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d3692-bfbd-46fe-ca72-08db285c2448
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 09:27:21.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grKAwbcWeuZ8b74RUuylqaN4X9yfChIhl7eaWIgVpRWhVqArnGZeiytvGhQ7EQTkTnMxcdlvKd6KKA+KWehI4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4012
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobject_del_and_put() to simplify code.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
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

