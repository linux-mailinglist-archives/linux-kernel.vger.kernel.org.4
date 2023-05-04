Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15EF6F79C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 01:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjEDXiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEDXiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 19:38:14 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BBA9ED9;
        Thu,  4 May 2023 16:38:13 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344MR5XE009181;
        Thu, 4 May 2023 16:37:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=NU641QE65oiioIfWKot+3wzK3GSfqmHWvF1fFTWyRpk=;
 b=gw0YfZxMBvZK3wIHYzhT5x7JK2aaeafKf+Ym/ONs6vKmBSXQ+5umjBcp/alkpq5uY42q
 ZBl2OUkA+RHfXqVoGyxIkoUmGAVDdWQydRmW8xe6s/T3nLJGPUX6B0J9OXqK8FebhhOW
 t4yePUc1vwoEPymJXeZFJQLE7uP5LU7t446CmZ2ouPKy+ihVA8oInT1iTYMK9XJkwk6u
 6zVGtBs/McFjmQd1FgHBAr4lWzUhWfe1U9jX0gZ7gXnXZiM+HyO1PZLgXvTbibpQ3Pjp
 tk7a4oWe3QkRQHiYgNkemzpXl5lnHNNHSQefzwEz7Z0hm3rgQ25iQfjXBb5f2PYyGueO SA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3q92rnd1t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 16:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbFhMcene/xgIwFprZal9er5JVU7xf5LIsKvpigUBYOwklRmeiV6KELRsAcfPsEre5uT3flGG7sp+1SQsxi1oAFPLhZc2O+o8LiDp1MYPxhZDcPpumrnod5G5W0Xn1+MmJbS+3zDQz1LYrTNeWYbKWfBWrc6JxfSOXqy3gVys83OnbyOkuzsjrMZy5X6urvRwvWmrpiu3j35TyQ0wCMVknX3i4eI2YaRjnZPXcW8XUpCoL6JzeW+OrVt6R/FwYZmEzt3/uYjlm3Ktt3/ak8k7p+bjeISCXPK9jq2h3noQhaJffO09WbwpRZlZwAT+5hpOA4pZ1hiihQyirxaX8c4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU641QE65oiioIfWKot+3wzK3GSfqmHWvF1fFTWyRpk=;
 b=Y0UhDTm1F00iqs19yJYiygN6JDsEUd3osti6KWb4pl0ih9CX8Fkf8mo5oDl0Fg7tkHb3gEiHwi6u5HPM1Yn3jMvCQi8gVgbxVWZWF9tQ0wi3SQcT1i1ZgOXqPBy3w0zhIMY+XmPilYD8ExKcxbzJh+riiRb2yn1/n7Q5Hssl1plPb+9eGMmm6+CjG+JPjgttfrQ+hk5i8TFvNiuyhXbB7uYur4jvGXkN2mPXCgdYQkY7+Me/K/f9TbCAT2Pv/H0PZnB02ykZP4mfJ28r3bQRGvt5EkO7rOrLc2QsPZB0D9DCW6TfsrqnM5fJEuCVv9/gZy8+rYOyN+xOXuYK+GkmLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 23:37:53 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 23:37:52 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com,
        bartosz.golaszewski@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [v4][PATCH] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Fri,  5 May 2023 07:37:36 +0800
Message-Id: <20230504233736.3766296-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::16) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 135aaa8b-5c68-4a8c-31a9-08db4cf89428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLL+1PC6ZfU1e3idGELIvng4Dutiy7KwC0CbDCCjtifmP45fG6xjkXDuaQ+ThONsf1z70DyoEmVwZ68996SSYGnJI15BqRMKqvQBFbW/B0BWB5kYCI8L3gzTGpseMXLiTJlbWjIgLXjElk9fstWolpQUbS57lyho1SLU0qasaOOlddS/NtVTboSC+k3BTqbbtbDdX/6vOpRp2N/ESD0aIvHTPZqbYtdURL/RXqHdBhSd7joGKUOHX4q0CEgt3ByS5AGKNH5HkPDzquJIfAkMfvR/fEt34VblaTLoURgdQ2XBOFpXZuEAJrrYLhuiYOJ4LR4x+TTYp1G299sR0UNZmq2u1wFQiXI6uDR/6SWgMyc9FX2DiaPPxkaXq88X0jXYAjqZfQotJckKptiQ+OhLTDwBHi1P1cJE2t0R95U7b2vrdEkVBS1Gjq8zvSt9ZjByFZUbj9nMXM7SszP73uSlyJtCfaQG1oYnzJLSpHw231Sy4RX3mxWf/nOFUGVc8UewmvoBXEVBaA4QwsrhLzuLwgrQfa8eBrCFa21NgHgiQFo8oNUc2lCjNdFhf53nr03jnDhQVouyTgFxExY2/dmRPBoVGysZeaY1N50Ynsk/GGlaLAyVDNvMKXqQJHvIb0HT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199021)(83380400001)(52116002)(6486002)(1076003)(186003)(478600001)(6666004)(2616005)(6506007)(6512007)(26005)(44832011)(2906002)(7416002)(36756003)(5660300002)(38350700002)(38100700002)(66946007)(4326008)(41300700001)(8936002)(66556008)(66476007)(8676002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8kJ6Vb9+EGYY2tkNcEtY8+tc2kOXKgt2US85IkeF/pmrYrbznPpSKmHjbR4y?=
 =?us-ascii?Q?whKqAYinjM7pJ0/fa7qL4dCGuWWqjsvfH5vohmg71bGWKyedz+F3mvCgRSow?=
 =?us-ascii?Q?3Yh5rCAbQj+UXCfKXOA+cxanoTsIBrx2oEAJI71Pkr6rQ/Xhz0C0fRPCODbN?=
 =?us-ascii?Q?zOV2o4yLsU2S7XeH0oWrnfs0Fu0Rl6E4KSsQ0bcGXoqWrG7SedS36E2V21RK?=
 =?us-ascii?Q?nLPmiLVzR2xg7ZqolRT+FmOU9nppxORfeWUEhnQWprCOIlt8t5Np7auTZ9B8?=
 =?us-ascii?Q?32wyJ68tUXIClOr71eXwQSupNntcMR+QHd68ry6GeJq6RE2o+QQA4fI7CEjL?=
 =?us-ascii?Q?DQfw1blw5tcrFIeoqW1XI1CMTBSpIkKcDIUGK1gYaJARBuAA0YRsU6uN3a+I?=
 =?us-ascii?Q?PsNKYDcWWE0grw9C3QgNDoI19ie5EUUxq1TUqXZZOuDZ7WwOCYqvOkUO98BQ?=
 =?us-ascii?Q?HpDSEHzU8vCeeFSuK/VzJtMBccYwq0YRa9OwMM9GBNq1msW4fwdgKSllMOCt?=
 =?us-ascii?Q?4q8Wo/Y3vY+8UNYkES9JbUE/t106APu40U/CzVPE4+nygqOf9nV9vwz5UxxU?=
 =?us-ascii?Q?kF4bU/Falhp+aemKX5djGOw/fIcissslD4amUlRNkc0PGVsjQXOy2BourFbV?=
 =?us-ascii?Q?MUBGVpOw78uWgdBGvhdmNSb71kgM2+GIeSrnfVbm7m8Ibur+SVAc6LHrn0G6?=
 =?us-ascii?Q?1pm/8HlmAIA//1ChbYXT8QjR0DFlmXRr8Uu6OWg83stSTLSQqXNKJx0rxI2a?=
 =?us-ascii?Q?clMrCI1d8BvTrD+kEw5asCuUpYlzY2bFtocT5JT2Cx5IOq+9McWq42ZBUZL9?=
 =?us-ascii?Q?w9a6T5GxoIKAEb+tk/5xUH1dqLn4WYlStrD+tUA5YaWNTXTgZhcxKnsyhEF5?=
 =?us-ascii?Q?hLDvVmLXF3sPyGs/pXOFs5yMzWVZgkhXxe4wHjJWzdGdBEzFSzCLF+qsX8lP?=
 =?us-ascii?Q?8gQG1v9GVZqMb9ht4E5jOKNBdR1GSTQN8fA+F0NA2wd6zA+r5xma1GEcaaG8?=
 =?us-ascii?Q?nh2XWTHjhBAGNC6oRB5Ar67jeWJUFXFZwzAfH6hQi4gRuONCBbZDpO4L19RA?=
 =?us-ascii?Q?XBO+I/EaU8z1oMH3P151gfM37VCt61+zWd3Tu4Z1oSs4UcShCEcYgO8YKSIL?=
 =?us-ascii?Q?fjeiqHyTmdqK2TXL05SFIa7gCnnrUtCNNh5W8ub8ChhLVxa0pxiShVNgLSEC?=
 =?us-ascii?Q?y9Bm111wgIC+bdhz7pK4d6VoGQxjmX8F6prcqcwSUEZePNiWZQN+X6CTlTq+?=
 =?us-ascii?Q?iJvutFQvk/EJSEsDOnfkKhcuEPqgDemxhrlRVHJgW1UZKYHqOhrqPRvbSsZz?=
 =?us-ascii?Q?9ei9jK2u2DCa0kgWSdSYBsboFpMyVvZ4mfeGm6ffpPakSpCBhB5yi+8l572F?=
 =?us-ascii?Q?xkI7H/t3zBiZ1+bqHu1HSel3Vg7Iw55sfNagn6Nfv9mzmyehTOXDQNsa9O/t?=
 =?us-ascii?Q?8IQ7LnpCSIQ3P2fO6nGpkOOpqlB7eMRQSzN6/KaKucpfUG/pFev3o/ddmbvo?=
 =?us-ascii?Q?dWA4A/3Zgr3/evxI8QmUyQjKLXd0Xrv1ZPF42vl+aX3rOfp68j5Fy/4+ArLp?=
 =?us-ascii?Q?rnYIh3+dYNAnuoKFgIt4iOkEj3MK1SoCI5ruXfy34ZYPyz34QmrCu8jIlevA?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135aaa8b-5c68-4a8c-31a9-08db4cf89428
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 23:37:52.7050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJnXlzOSEgpErzzS6FUxJPl+UXvdJkFNq54p47+KGMpNuicDyVkQwvWWhRtYSo48E8CQY8tYza6MBz8KlUuG6zboFLqVEQmO7GsbLL4unXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-Proofpoint-ORIG-GUID: pxcQC2M8v2_ZRQgZSlLEI-xUO2xTuTMS
X-Proofpoint-GUID: pxcQC2M8v2_ZRQgZSlLEI-xUO2xTuTMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=747 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040190
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config passed in by pad wakeup is 1, when num_configs is 1,
Configuration [1] should not be fetched, which will be detected
by KASAN as a memory out of bounds condition. Modify to get
configs[1] when num_configs is 2.

Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
Changes since  v3:
 - update commit log, delete call trace

 drivers/pinctrl/freescale/pinctrl-scu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-scu.c b/drivers/pinctrl/freescale/pinctrl-scu.c
index ea261b6e7458..3b252d684d72 100644
--- a/drivers/pinctrl/freescale/pinctrl-scu.c
+++ b/drivers/pinctrl/freescale/pinctrl-scu.c
@@ -90,7 +90,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	struct imx_sc_msg_req_pad_set msg;
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	unsigned int mux = configs[0];
-	unsigned int conf = configs[1];
+	unsigned int conf;
 	unsigned int val;
 	int ret;
 
@@ -115,6 +115,7 @@ int imx_pinconf_set_scu(struct pinctrl_dev *pctldev, unsigned pin_id,
 	 * Set mux and conf together in one IPC call
 	 */
 	WARN_ON(num_configs != 2);
+	conf = configs[1];
 
 	val = conf | BM_PAD_CTL_IFMUX_ENABLE | BM_PAD_CTL_GP_ENABLE;
 	val |= mux << BP_PAD_CTL_IFMUX;
-- 
2.25.1

