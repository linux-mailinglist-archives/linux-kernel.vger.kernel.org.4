Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8568A6B60DA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCKVOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:13:58 -0500
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2079.outbound.protection.outlook.com [40.107.127.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3D3E621
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 13:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvRFcFTpJOl+hhdP42GmJphBAiFGzKJY8e25pvGaG13flPMMwuu154GHxPuaYerwHi3mJQsUZ/09gr4TqYNncr1rUJo6F2KDkNrG0sXUKe7jK3+RREtGWv58rVfKjqFjrfw177PFY3C3ZoEBEPZCItRcaxx6r9qEYQtcxz7YE343eVXNT/iLz5KFsup54XFj0tH3mj85I4+VcCx1/xJNIJnSUJkJkSw1sUvRxe/yHRYtOse4+W2Kf+t+UlSRdxDQe525GjGvhPNVsJvgXlx0OFnGd/Nln9GDa4CsUT7/VQM7OL5vWD47Eie35Cg6KZoUxQVTa0GIkTWYqnerUP0B7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEJiGIqtSIixJAuJATwyqZIzp+WCekwVee7a15OK7ps=;
 b=HTFoYDTe2iUuPfdfezvbk45kXNe1DrJtXBwEkyRrB0dYwUszfeROvFfoixwo5w+jp0xlPIdRcU5jhEcg7epk7NWUG6JX6D+DgWMiqAYqjlCIRswwPVaDxr3GU34npyKY6L4bF9ygGFyXlYilcPll14k7zLqG7OkIm1ClsQXb8FgvxIoZ5nNTr4+bpxVCrcCSFSNaP7T8pJSpKIuC8d49roB5+FgCAmx1uT1E+j482GpUOVB6MNNE3xFbfcQ0SL1a8ngZLMTFeMOFXEx70h9XTA3C5gCZWIFVyt3YFV15EmrttHA72eABMO3DI18LLJA0bCGO7+wt4dx8hKiGzDQ1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEJiGIqtSIixJAuJATwyqZIzp+WCekwVee7a15OK7ps=;
 b=dXKJ8XI0gL/9MSu8TxTmGtSeRHY4gX8JWezuw6vPNkCPbGHBK8A9/igXMQf1saPJ6+ZcWHMDz5VvabQlGI6bSeVx01p59a7LsmW+bhXuMk/eVMdGTa/2R4n2Y7Qrq0SrVm6HIhn9BnMY0b6zCZFxsc3eJ25ijItX+8MAKWunHM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:6e::9) by
 BEZP281MB2834.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:71::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22; Sat, 11 Mar 2023 21:13:54 +0000
Received: from BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e8af:965a:6b92:6906]) by BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e8af:965a:6b92:6906%9]) with mapi id 15.20.6178.024; Sat, 11 Mar 2023
 21:13:53 +0000
From:   Thorsten Scherer <t.scherer@eckelmann.de>
To:     Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>
Cc:     Thorsten Scherer <t.scherer@eckelmann.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/gfp-translate: Fix script after refactoring gfp.h
Date:   Sat, 11 Mar 2023 22:13:28 +0100
Message-Id: <20230311211329.21385-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.38.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0270.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::17) To BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:6e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2529:EE_|BEZP281MB2834:EE_
X-MS-Office365-Filtering-Correlation-Id: 1709c835-4681-47e5-babc-08db2275849a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u51jtMgDkWW7C7mWVj/MzlIirAoZN9+hwTJ+QoO7rqZFX9UTSAVlYWkliWlsxOXTuvppHSmmO1Osyg1WO8StT2Urxch1g/q04Zmr34coP+DEeXh+UE5GpAhSCkn3xcnxqzU5/EmKg3KytFsogdWKse1ZDfNAnl3w5dz+8F02Z0jhZM+wK3KDo8gBTrNjWgbo9HJV53ZBJwDSzH3Q53zKZH0pH9FJneND8JfXD7u2dwIpUxNWXwZGq3mqbcOnt8KmDfIjN0ku8J+DN8QKo2oOMMWD6b0UWEoOCCft6a4dzvsK/b2ZbQsfxyuEJvBBcermitQCJZjF3DOCA4VvkpPaNV1jfd8SgnkIHEYmL4aPdB2MbPGawnsW0VCVraMwVTk7s/J7OMtOusFujJh4PyPt29X8gBmZex+xhbOBPT4uT4RuyVjRr5+Uirvio8ZxhG6LYnGticzdy2D3k6WMZbjd6WLOXMfJupHX/VkIgtYVRf9ag5dQYaQOPGAflAwHesit5965BwafmgoTZyUktDOzi8GNOlto8ymZF7OLxsQqVbasEXhxAPBPthQWlyLY0SZCCgcUCoX2jHIhzS6VYZ1lFS7D3s/xphVpJdkCUMnpBgh2Q3e3Ms+csM1wQqjhXHpSNgOOU9djZjVKop9Y2Vgu2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39850400004)(366004)(376002)(451199018)(8936002)(4326008)(1076003)(6666004)(86362001)(6486002)(2616005)(6512007)(38100700002)(6506007)(478600001)(5660300002)(2906002)(186003)(36756003)(83380400001)(41300700001)(66946007)(8676002)(66476007)(110136005)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T09jB0TuLp3P8W/Aa3jx7N3xmywtK3hzBSy/hfw0n8CiGlmVPMW3OkfygwSN?=
 =?us-ascii?Q?0Vq5YDG6agkeB+fJdVVysX8EGjzyi98VpPB2/I8ENI3cr7X5nfQxpCMonYFH?=
 =?us-ascii?Q?L08Mr2WTsRc89cNs1n5SMkZOkA+PYeUSQ3MajuFXWBCXI4xTEbjeO8yOLz+F?=
 =?us-ascii?Q?c2//36/7SlV/JKeC7Rt4AqjadbHjpTv5maaXW4GI+Zsmgje3cSmHHz7b2a6A?=
 =?us-ascii?Q?pMymDl6fx+TeVo68eDjUxnb0q7YNyLcGErDKjsws6YPxI6LLtlbBpPqN6kRE?=
 =?us-ascii?Q?rZeXFfWc+hPNs+edG74SGI7OYlkB4APSBPMoDPqlzbZqGgJY0K69aHZT0Rja?=
 =?us-ascii?Q?XWEOGhwLp14XonLKLB7FE5qTacu1Vpfy7pRyQqWz72TlF2MqsfQ0s6MHeJcd?=
 =?us-ascii?Q?3zXO/7rWm2XOHW/NUr5m4tmiVdZTxhaMLS7SqPyG1AYjCp5Tk4nlg984nLAP?=
 =?us-ascii?Q?OdW3Y5YDa/BAa7aKKQ6uvXoUhbLiHgetG+WF928A3mujCQrFXugT+Tx0jZiD?=
 =?us-ascii?Q?Wr5tMaJ6ukTgnQxEYhY+D4Jfrp8TD/hya27J9xg3FAcqLXnSl96g++z9kjf9?=
 =?us-ascii?Q?GJ0IVS2IovR2VpmhGhcUtcKPpLmZi/rkcIXSRMfLHrZyBU6CVFXR+rq0zg5p?=
 =?us-ascii?Q?FkyBg2w8XocgXQdok96ZBAmS7OkY2NNQNLmLydPxPu2YJ7+nLSdihSQCj0ad?=
 =?us-ascii?Q?w3eNVjtgAZcSGQR9KGZBdFEtOT15t2/sha5FuetIAJ56/x4vEDBVbXslSyIN?=
 =?us-ascii?Q?GETDp7n8JDaobuWkgfITcpBaF5uBKm1iZrIjRgK6YOiKdgP11qdsRMcFWeiK?=
 =?us-ascii?Q?rqwk3du2dp7yfKUwkYINp8JtA5Sr1x6BMB9ILx3kslqzZouM2MlqWRnDWdJB?=
 =?us-ascii?Q?Zc2H219rVjdt32yMJncYvJR3BHSm44RhsJxZxfcQpsr3AN0oErjUvc6LbLXN?=
 =?us-ascii?Q?Wfo8tUiykzvFZ7Yl6Cf4WaZc+UJYSy2VfmhXHATVkke98E6LBbPtpIwEqxeP?=
 =?us-ascii?Q?Iv2t+9sy+I+23qYu/zEc2kdkpoVqOvWJ4g4wTRRjeEI8KuzPMO4WZzBF3fGP?=
 =?us-ascii?Q?UHJHfwMkokshHHHDVn0EXdyR9i+ERhtXAO/YinXOegW2SERW9Qdybv/v3cfF?=
 =?us-ascii?Q?+kd4u4qf1xyuOzdrylrKR99Fi6CnhKD/Ho4UQGZVmspFnMFr2QZP6cjIfUne?=
 =?us-ascii?Q?2yJCpMH1kgAfDQhg/mCVL7TVszz7h2Bpfeu61JJxvqev7EKax5VqBMX3qUvg?=
 =?us-ascii?Q?yc8/C6KneDBEogqZDX/3Z60qnSGG6uvwfJnuGtfQ0cIwn9lV+4I1eeLQrLEZ?=
 =?us-ascii?Q?gFUzXfbF9lFl1DV0wnaetOL3HM/6I8GK6Ud2Ibmky+Z1V+xPjqMwM+ioOkfE?=
 =?us-ascii?Q?RMbRpe3rUi7ggj1bzf6eAb6cXgRWWD4rqdBgFjRwDQ5pQKJcNswE6dDgwdLV?=
 =?us-ascii?Q?HI2MU6xIYTphAcWH2si8lP/mRYW2om9H24qrvBzFTV7DriD4RcFDTE9Th447?=
 =?us-ascii?Q?iThsoXsZ9CwdD1ZVfA5zimwGQ225p3secXivvE8/ottBW9/U6B4r5XbTZKr0?=
 =?us-ascii?Q?x21gNxtSZ01qvrZNt6CHitJFPwNkfTZUuy8wJm4oM7iooz3xcSXwdfdETPAf?=
 =?us-ascii?Q?lF0D8IUtTcT0h8T/Liz5/Ou/ec31tYW4ObvpSndAfBkvDGDSJcHhFRNIaOYL?=
 =?us-ascii?Q?VIksEg=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1709c835-4681-47e5-babc-08db2275849a
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2529.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2023 21:13:53.8213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fowgLjKDsFBGeGJJqNhexY510Hk6e5xF0CvytDYsJjIsAWpxgr2As7PhmLorzayy3OPyMUCqUtZVd0OJn9RA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2834
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting gfp_types.h out of gfp.h broke the script.  Fix it.

Fixes: cb5a065b4ea9 ("headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>")
Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
---
 scripts/gfp-translate | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index b2ce416d944b..6c9aed17cf56 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -63,11 +63,11 @@ fi
 
 # Extract GFP flags from the kernel source
 TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp.h
+grep -q ___GFP $SOURCE/include/linux/gfp_types.h
 if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
+	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
 else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
+	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
 fi
 
 # Parse the flags
-- 
2.38.0

