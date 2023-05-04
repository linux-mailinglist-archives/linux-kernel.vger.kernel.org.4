Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D7D6F6260
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjEDAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDAeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:34:23 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295AD138;
        Wed,  3 May 2023 17:34:22 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3440VsXh020146;
        Wed, 3 May 2023 17:34:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=l/bOPC0q803VBW1oB44WhxBdLRxG0yrzJBActgIXnO8=;
 b=RF5xPIJdDK6f2C5H3qgHIisQ7sdE42dlQChQCqjMauk/cSe4+K9p2Mmt5it/cxyd+5T2
 wEnJOAB5SOmonhMNqaeeEhGJGIsPmaMR+D0qtqggpG7HFjIR5lm48gDt06IUQYeJSKhE
 AMS9eFL/cRvxiPb8aoMT3UnjbSAC+FEPRIlkAnzrFcd4nqDLa7jMbHd/zAUCQ5/T6o7e
 5nlqae/erd/0stPneYUaxTJjIe5G6echGPGu00G0FoDXALTpwr0uhNkSuPk4/cqAF0Vn
 UqnQ1dodCLiKOr9wwTU/eFWZL9sdgAzz9xvIt1Ejbk3P8PQPPmio2gTXtQRI2SBeRcwH PA== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3q92rnc16a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 17:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKLr6Qq/H3zORU2KjX6hsSggGJtgGZRyN4GCB/V0BQH/LqzJE89W2FJjbJ/KWmFLFPGVsxGCMrPUIINyrxQEiMcNdARyR32PzBKTJfapRbFiufopjQKSa6V1T8f4Gxr7LmCbAJI4UMvYwkkGAnjTqawP9eu7FPKFDTBrtosv3dYafTw7/fxxYJCAk1JqyqdwjDN4IaIOxwwSISIrZGvifegFjhYZbU+VtsiMhzaG4Fe63Nou9YeP/cKFEgOVAzHS8V5Dt5elNe3/C8qj5fdhtiYj2CaV/clvEvyKR3BSN0YaaM3dIZRtMjlEOOZqeEnCrWXdnMaSFwoWscnm0Ad8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/bOPC0q803VBW1oB44WhxBdLRxG0yrzJBActgIXnO8=;
 b=No9BhkXuWIUyP+BkkRWeq8lwpZi4OzlQTwEnadCFH03KuQiAsu9b0myuZuwXBr0MTNPvAvG30vYbZ0x9I1/+GNrsm+vP4vUCMA6tvUogk5mCkrC6Cf1JLkLj6+OVwV58MrzNh7oRn6fmQz5C2Fgkx87j57fqTx16CxzvgCw9AlbOlpJT11dsmzmjKzkljDaKAITTXQ/M5cGdTfrBX2I7MVUXEBtZCqVLtVL+vFypssPoMm7JWiOgrn3E1A3b0sFt0hd7hiQ1y8Fkghi1bVHPyk8F4z5NB/loFru2eYmd6+IBe3zopoFz7SY/yQ8C5T6eA9/fpJAmFqLojORby2mnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 00:33:59 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::6485:357:72c7:e45%7]) with mapi id 15.20.6340.030; Thu, 4 May 2023
 00:33:58 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        shenwei.wang@nxp.com, peng.fan@nxp.com,
        bartosz.golaszewski@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] pinctrl: freescale: Fix a memory out of bounds when num_configs is 1
Date:   Thu,  4 May 2023 08:33:30 +0800
Message-Id: <20230504003330.1075531-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230504003330.1075531-1-xiaolei.wang@windriver.com>
References: <20230504003330.1075531-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:15::24) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: d9080282-f16e-4172-1992-08db4c374025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCbx5K7bWKl2ezbkl7P8FoR2le2DeBH2PObKY3aeqmRdKPwhdQ4XKF6kix+lwau/8TpD0fhAOVvMQ9GyTwr2Vq7s57Eh9myjSAnXe6ElFuL/FBtcUKXEB6PwMpQN8p9YfWGx95kUJmzC2ClcioJ42woOxZCp7673JseyQKEX3LRsVkdjZIVh3XHHvbMsf8Tb9zRUQ3Yerxmv908jwyHRoR2ymlDXb+FD5tsKaeNnMsAEJ/arpx07MLpYYvjFb4Jd2LrbRBtu2OnJ4cUWeFFIwYwJpnasm12yIfZiR7hNWK9ddMm5EqbFjxPlZ46mUWJkZp+dLfrxnk8rV4C6wtq3RgwPv50Bbc+CaSscFEiMpUsYHaLHmAHk9MtcMPnwbIhCbN4yYWaKyZ8oUeScfQ6UQhXU+Ewl5fuwPVUYEv0NHDU69bsGDCJ581+4HLDUScKNY6zaJ3dlNeFdwsHRf7pDdcHiUWJlPHmzfoj9M61t99ic4k4UctEkwir8LXtYqdLbq7rRxXFPeWOVguouLMDZaOS0U7yWUTP9HZoWTIvQPTw+m+BEqzloyap+/3CHFs8ZFKWdjNKyRxNfxKj8Jgh2DNUHEUIju5/QawlPuBL2NR1N9ia7o2l8EUje69J0dx+D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39850400004)(396003)(136003)(346002)(451199021)(6506007)(26005)(1076003)(186003)(6512007)(2616005)(44832011)(2906002)(5660300002)(7416002)(83380400001)(8676002)(8936002)(52116002)(6486002)(6666004)(36756003)(38100700002)(38350700002)(478600001)(316002)(66476007)(66556008)(66946007)(86362001)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p1ViqC4GOz77aMEYhmg+6C/bnkqfLkLoM/CoRkgOT1nQ2vMOo0eQIj/9fnzV?=
 =?us-ascii?Q?vssg8NdYVFn9DW/PZ9k39b+Snkvy7FGHyx5BnQeYCWx7xvuoc0mZzfo+XXKL?=
 =?us-ascii?Q?vz6bA1x7ovdV3fInWJP+1fnIv56alJAF1023u858hGC9K+zov9oPtb5owSh0?=
 =?us-ascii?Q?3NUXBOzsOv4wdDD5CxB0betW8vYTMULlDwAMsNmHfT1v3S/dboWGVwc8SS6b?=
 =?us-ascii?Q?uqBEHui/MPixV/N5wl7Yp0ZuUOfzPxy+Ff2yanYDo2e9x1E8oZWxFollPvk4?=
 =?us-ascii?Q?K1P2bIpgc4DYOPqkrrhDDUxdBbmpbDpHUYZuYIX9nOvvzuec9PyRil5YXOBv?=
 =?us-ascii?Q?pacTwugs6OPGD8LPDAoCc3y4/DWcSWhARLOIqBQblYatMQISgE0L3Fq3WIba?=
 =?us-ascii?Q?0wOOapNU7ESIwd4QEpUl2mnLA5T8eJWDMoXRGlRFY38/9rPXPBIIthd1OmR6?=
 =?us-ascii?Q?IJcH1LNTXL9jMuv4vDmKKeD3ltBa7BoAvYoQc3AT35PNEd+nyt4WxB+6BeFj?=
 =?us-ascii?Q?WvG+WjuKS7rImVyl9VfmybTOgO3EXEt1rgjiZRTH/SjA/6RfgKYjPuGrivEt?=
 =?us-ascii?Q?ErJwc41dbDrHUamIR6v+97YhbTMFQ0ByU7B5YRKKbVxHyWqMS4wkcROAlvmr?=
 =?us-ascii?Q?2tfYuCPICP+6t3GvUTLKXPByPoj+W3XeMEPZzusRuJtDnR+/wfxhf7JOLmlN?=
 =?us-ascii?Q?L2+m4uNDpz3x4hpU8d4aUKDjljG/7IPbQtkI9qU7TstvfMWN8uDGr24xF5jv?=
 =?us-ascii?Q?AkhjKE8onkLJ0mpCoccIcRewH2qiGwuK7gRT3ucPfu0BiwHVYObmWYUqvmUZ?=
 =?us-ascii?Q?+Fe4fI1wurzcjYFXvnRqWjIpZ+aD1r/5IKd0GGLh2cq4kKt/e9YE53Yw4a0d?=
 =?us-ascii?Q?uSypYlnQA8nglZR6ciKJ+3XDAygHMCsghXTwZeITGTPp3vmx0S8Z7WBA4HiP?=
 =?us-ascii?Q?mammwpTmTNz25kSGdh1ZX9s64h60lv/Km1UtIqxvN6pVMnaw/3mYJ21ObNNp?=
 =?us-ascii?Q?KNSACk/NKSDG2NSno+9VgAX9TJ+aIqUQlPvDoezZTKmG9TDCEJ6GvlFS+vMm?=
 =?us-ascii?Q?BwHvzsyZ+clrx5umbUGS7eqQ1XGCIuT/Y4wFu+jEkwHd67VSg7t2qWTqU9mS?=
 =?us-ascii?Q?btFLhNxuhs6GxZkGyxPab2aTfTrWim4kCBjbTJi+6D3HIlXVTQDptYwQxBr6?=
 =?us-ascii?Q?t1Nx/cE/HmMvDkHnFVSgzPFMQKwlJp6fjrzBh9SxmC1ejgIuLMQi928UZ7e3?=
 =?us-ascii?Q?DcOQIwujpH49lHsZyrjKqtBBJRZrbewFGiYoc25IsZBnTfgIqY2GqEbcVg5w?=
 =?us-ascii?Q?x5ELdb8dq+SivQYldSB5b5xlK64TbtY2G5IjKtYYXz2EgMa2FPtQTv0ykmja?=
 =?us-ascii?Q?SpwbQDQTrjb+tiPD1f2eCydTpfbgxM/LriWcoVIGUSWHJDYcm63v85JST/TB?=
 =?us-ascii?Q?GCbJWRaExa7aXQ503CCk9lo7gPYqR1xD+qsNDAC8GJFmY8Ax/f/xbp3wLm4k?=
 =?us-ascii?Q?NcGq93Oc0vGPh3jtLBaQZsXbH48yUQtI/W/qARUCWhmb0jz3HgScRNw1gX5h?=
 =?us-ascii?Q?1I9BoRkDDorFpWIJYDoQ4eofFnYKLxpfRjiwlMvRwKw45d0UvOKNXgHJLerH?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9080282-f16e-4172-1992-08db4c374025
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 00:33:58.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcCjiQPXBvc9LGQ0oWj80zI0plpAZuGEb8Hsfn1gSVlPdyM18Mr5h5QxXBL6BwsdYk/V66xkviQEvRdEx2VumWgTz1e7X8Lb/NhMaMQd7MA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-Proofpoint-ORIG-GUID: ag8JoNVDj2TnzieBMSkZ9l6v6EwsUAxe
X-Proofpoint-GUID: ag8JoNVDj2TnzieBMSkZ9l6v6EwsUAxe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_16,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=648 adultscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The config passed in by pad wakeup is 1, When num_configs is 1,
configs[1] should not be obtained, which will generate the
following memory out-of-bounds situation:

BUG: KASAN: stack out of bounds in imx_pinconf_set_scu+0x9c/0x160
  Read size 8 at address ffff8000104c7558 by task sh/664
  CPU: 3 PID: 664 Communication: sh Tainted: G WC 6.1.20 #1
     Hardware name: Freescale i.MX8QM MEK (DT)
  Call trace:
    dump_backtrace.part.0+0xe0/0xf0
    show stack+0x18/0x30
    dump_stack_lvl+0x64/0x80
    print report +0x154/0x458
    kasan_report+0xb8/0x100
    __asan_load8+0x80/0xac
    imx_pinconf_set_scu+0x9c/0x160
    imx_pinconf_set+0x6c/0x214
    pinconf_set_config+0x68/0x90
    pinctrl_gpio_set_config+0x138/0x170
    gpiochip_generic_config+0x44/0x60
    mxc_gpio_set_pad_wakeup+0x100/0x140

Fixes: f60c9eac54af ("gpio: mxc: enable pad wakeup on i.MX8x platforms")
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
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

