Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE150622B49
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiKIMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKIMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:16:50 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458C326DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWkhya6gQmNKPOEtL8+Gxy23dEevmTKwDs+Fm+8YOP/ug9sBWxkriUtGEeBmzSLKz9pVDCgU+7ypQfCQz6bb6xWntUKw0V7Pu2/tgh1ikKX4C13NgzLOZSopgW53RB7eZ3NARL9991vGVIz2rSpVdJcvw97E4BeUDwduC+WKw6wS/bAML4IFxBMQziXXtPUHapzTMky50SumG6z15udlE9DVF+F9Er+PfyH9lk6uhk57m1R9F/VhKxZzICF7KoWzFZlnX2P9lRokWmnFOsRo+PIOUG+k4OPyMeLQAAijo6JDNi2gvD7UYXo8sUIOSrUC3O4s37Zhj9PasSxzSK2fGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meXvWAYQLHTKW/kLWG1cbXretdZoiinvshd8gvzQE7I=;
 b=bvSO0s58MzDKg8fb0XXeIC8pRA9GcuS0M2+hKaofOGJZQGrG/wUWuV2tjQrCionKIT6oxrYYi/J0TLMH4W9CZlqnVRDNIw2wnZEsW6rc4J8Y8O0vdNQ7w7Fo3Xevjz1bVAaJWGpole8aVX+BemJ/0lcn67eS2GDQ18V1ckgeaH+GbkRO9g3xpAUw3IOItoQzpg0yQZQ63rhNYNqQZXX13cW/xQSraolo/jEyH4s24O/k1vy9nesklowMMzRKC+RITVfDcRc4mvGtFdAdhikdN9WePF6VbudA3eeN+E2ynnhNsbAS7olg9jq0PMPAvS12xYBX9ul4zVaYbFFrBpwBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meXvWAYQLHTKW/kLWG1cbXretdZoiinvshd8gvzQE7I=;
 b=m9a+YZTJgovYpy1ys9wP9bsznLgL7BNGOxJxz9yixD/bYVFznO/FGclXV2V/S/U7D3xr/027SraBJLrPwakIdcVOIh8EUH8jRpAVepnQLA/D5nwfWJA2DUzWnC2u5VHBmYEK6Z+mb757IqFmYOEGLiD6iNWkGSYeV7zliauL278=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by DBAPR04MB7303.eurprd04.prod.outlook.com (2603:10a6:10:1af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 12:16:24 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::d09d:ac92:bd65:c390]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::d09d:ac92:bd65:c390%7]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 12:16:24 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        luca.ceresoli@bootlin.com, ojeda@kernel.org, cmo@melexis.com,
        u.kleine-koenig@pengutronix.de, xiaolei.wang@windriver.com,
        steve@sk2.org, chi.minghao@zte.com.cn,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2] ASoC: wm8962: Wait for updated value of WM8962_CLOCKING1 register
Date:   Wed,  9 Nov 2022 20:13:54 +0800
Message-Id: <20221109121354.123958-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To VI1PR04MB4222.eurprd04.prod.outlook.com
 (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|DBAPR04MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 148abf66-7991-4e11-c55c-08dac24c3801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PA8m8BIXRuuNN4pJKZMBwFIBVOW2XYWboCev9Hk+BdHBT5KJzgNib9QjfoOO2sXl5p/EkoL4FWSBL8pHHKIxylHHsqC3MZxiDkcr1nJIZHhFnG59N/YNGvc52yCY2HjmV0Zgx8VqQ/GSDLcEg2XZwf+7t0V8BlclZqHQTPz89L/W6j1BzEqvv4QJhRXThXbOqlBH/Szc2fL/xjTJw728WhMO8T8D2mwfFb3OQRp9vI2wzLwRl1loTxZQ3QtAJwHuUACMHim9a4QNnhhWei9lWe1v0UWfa56SjRQ1EU2GrMOfpYu0fxjKDyI6JXGPxRe02ea/SIJmnfwCdg6IqUH+khph4tG5E25Cfrde2eZjhshPqJBcpbeqT/3H+Gsus4XbJ/Zcx4O6qJpZJBRvmOi5nG2iSNmu2xck0EY2TxRF/1cs1VPxKyKQ06NXhygc6t5ftEg5JllfbFTXdwibBB/xz5MR7wPuqwsniYSXukcnpgoW8q71osceA1tkIAaMSDg6Tj+WAsFEFDJ9EIbt3aS4J/ubLdXewyYbEnJl/GNjCGF3Ulb/uh4d2vvv7t1zgB1mdUVTBH5w/kteTdOS6N0mfw1KVB6xL/p6ZRXvnpWpwVS2bpQsyw19fSl4D8pba3X0Dqihw7kmICona43CFTq6NSrXs9S8CxrqZMYMCh/Enq23J0mMastBEAkA//6QydW/llk3Qhp788t86TkfvYQPK3+8nHf4/JDr6ZBNNj8JAKy8C2Et3pmN8sphSzevyzUgQiOE+dA0NkYyQOdms85yA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199015)(921005)(38350700002)(66476007)(26005)(36756003)(4326008)(66556008)(66946007)(6512007)(8676002)(41300700001)(478600001)(186003)(7416002)(44832011)(2616005)(6506007)(5660300002)(8936002)(6486002)(1076003)(15650500001)(52116002)(6636002)(316002)(38100700002)(6666004)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S1FMxEaod0SRO/3l2MTCV5WeLs2EbhN3Mo2YhDb0HBAwRs997vIZE1H1dTSD?=
 =?us-ascii?Q?QFIz1cRCC+0o+xJbNVbl4UozK/+4dHCWKyz0CU+qJmFNnNzSeUfRxzDxQMn2?=
 =?us-ascii?Q?cU00JWT56aOsLJSGfdMmyZTneae+b9QX4zBx7EtEWfvDbvy7U+JV7Jphe86j?=
 =?us-ascii?Q?zSFR+Tcus/BI5DA+/sD4VgFU5TkDsjLIdPGp8Hbx7B0KkU+IcMyJvFUBELHy?=
 =?us-ascii?Q?y1qwqwIA/6bZt5okOXbYKHpO9zoxuA8H8H8xBRyzbjsg7DRJPYWV07OBTppW?=
 =?us-ascii?Q?wn7h7l7XjQabuJp4+1Lqe9ypbkTxkoHaqqV1u3pJhvTGf1gwoc223EebhmXj?=
 =?us-ascii?Q?Wijr4zsBOImus9p/xGbvRv64BTvjspHlohZG2oGHK2pto6EDsXut86iEsN1x?=
 =?us-ascii?Q?WCVlzeI1pPSIOv2ACI6txkUFxCZ2Mr3Y4xvjGpvCz7SJQg3tg+JZzXkMwsrp?=
 =?us-ascii?Q?PkpvstNW2Q55OjARSboXRxIaNle0Tt/ptEgmN/1LtA8K63990uxMfqdOjByj?=
 =?us-ascii?Q?oWLEQ7V5cPLNTjYcXKKYhvd9RKoBCLRFwKp2k6g2uLby5oDhFbucIwu6r8N8?=
 =?us-ascii?Q?gPCag1yr6T5joiyLZtwaavy52iwpxA2GkTlZ0KQNtrfd/sO0oj8DxzjKn3AY?=
 =?us-ascii?Q?G6PFkB1bf/njmqKTVEXoYMwIpFzIy9kq/09Ov1BG1CadOUJonn1ajrjSri5P?=
 =?us-ascii?Q?1SGEAcTYaeU4woY8Hrzhyz8PGjkhTf9Ow/5dkG9dwQRVhGzXEPPDY+B/e59B?=
 =?us-ascii?Q?buOVgQuGj1gK5aiD5TyejfHRqie21BeC8xBYrlHGQMN6ESnluUzJya++zTEQ?=
 =?us-ascii?Q?eB/jMe9ToZNwjEcKEcArInbUUbsW2KRGjTScjMr3Ft6M6btoHCxVHEuxb4c6?=
 =?us-ascii?Q?j2PW/FANo10d7oQyYPT88iVLUI/fDb81uSotBraBzVFwZ3FJa01gNl6l6QIm?=
 =?us-ascii?Q?MMG8N9hxsD1gyrVlh2yDI67yvCas8RebHayeC9BB9FAbNdoy0GbBOoS/tvbI?=
 =?us-ascii?Q?ZYezC/+u32sUFKZKo0jHwzNEYQUiDfrojOSu/7cjA0uuuKQd+qW4vOxqGQjs?=
 =?us-ascii?Q?Z06jG14aM0ocvJ0WC1yicBQo90vPJoKb3iV9sAi12JI0fI8n0vs+sOXPCxid?=
 =?us-ascii?Q?B84bt2wsDuR0hKR1dvggJrPObYKoOKkpBPrlsqkjIKYG1rdqil2i3toIeAGm?=
 =?us-ascii?Q?+SqdAOamadddRJFemZW9gmJAiSc1qCPfkVzIKX7ecblCwq0Mc9Tdzr4P9UB7?=
 =?us-ascii?Q?BLKthZT7+JZFtojgoOD8umTMRthwF7dgPPg/geVJ9qwz8EADHRBA3HPFbUxk?=
 =?us-ascii?Q?kPGtCEX2IyOQni697pJRgavedjuFbZ/U7NLnLNm51oUyNciMnqmVEUQKYJr9?=
 =?us-ascii?Q?IKWCeat/ixnZClmPJW1J7Xlyw+pjWRX2Df6+OYNusjO6G2qJXpYRJrEpASYY?=
 =?us-ascii?Q?vmSkBtWUVvnk2Pqlm1l8NVsj5BEC1j3FjPYLiQHIratGOhguqD5wbMttoHOU?=
 =?us-ascii?Q?LUI7SACcHo8r14jJU6RpwBjewBQ0B4BgoVAX4CRQDgHs8LA5uvc3KmDUSvFz?=
 =?us-ascii?Q?+C2EJjoDBD5j/fifvEuIHkQBRJtead6UBVog4ajS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148abf66-7991-4e11-c55c-08dac24c3801
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 12:16:24.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpeXjTqrehdqcLs0T6AVjiKUBgSKoLdgeRSxWFm2OzL98MpGb+l9NV626ur6FeaeW7OMH9KXOOfBv5Gydi0JNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7303
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
correct frequency of LRCLK and BCLK. Sometimes the read-only value
can't be updated timely after enabling SYSCLK. This results in wrong
calculation values. Delay is introduced here to wait for newest value
from register. The time of the delay should be at least 500~1000us
according to test.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/codecs/wm8962.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4b4355c6728..b901e4c65e8a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2503,6 +2503,14 @@ static void wm8962_configure_bclk(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, WM8962_CLOCKING2,
 				WM8962_SYSCLK_ENA_MASK, WM8962_SYSCLK_ENA);
 
+	/* DSPCLK_DIV field in WM8962_CLOCKING1 register is used to generate
+	 * correct frequency of LRCLK and BCLK. Sometimes the read-only value
+	 * can't be updated timely after enabling SYSCLK. This results in wrong
+	 * calculation values. Delay is introduced here to wait for newest
+	 * value from register. The time of the delay should be at least
+	 * 500~1000us according to test.
+	 */
+	usleep_range(500, 1000);
 	dspclk = snd_soc_component_read(component, WM8962_CLOCKING1);
 
 	if (snd_soc_component_get_bias_level(component) != SND_SOC_BIAS_ON)
-- 
2.25.1

