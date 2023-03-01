Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2A6A65D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCACyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCACyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:54:21 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D91ADCB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:54:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCiB3klK3mEZf/apL1sdoWwMyN0PfuAryIdlSBV9fY4JUYQMJojSHyU5vSu3yHU+EeMRY6blKhpJIkyOYaCL/OuoyTr0RecALllMzJrJ9h1jpOa1TTmX2VX3cAry5caQ2Vm8HT20rx4tOhaiP4LOMSYWgMgkJIsX4kZpEafEU523z29AgwprLtgfvANYiPCNMfdiFzQ8NMGc0xtXBjN4K0D8N+MrG9OILlmH2pehs6S7jGo7HiUJ6R0oc2PjmHoqYzBZazpexRq3CHeFCxJuSN/W2vQBj2WFLSfhl+RS2VVOMo0FulfzV2cogiqkrQkdz73xITRBj483nCwdniWxrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4UCBv7Eu1C7RLmPeV4UzD7Cr/bOYxeOqsk6x0TLI4A=;
 b=kcLJhXCDrS1FNgrgHCSHiOxOiluZFgR3ax4DeOPweeYpUQbALbP95r9zku+HWxV3SYkx8hWRyCYzhYFCCujuwsyNEcJcrEyMd9LZS0h0fMg25RWb2RpjhLD0ZDdH1J8TGdjvpF/k8r6/5h5vqAiuBGBB0ln81N1NuRE+c8jRJi0I2cTIQfzjgFiVIXvKVMrULen2xCH89a55hLHKy45EqxdSUk7No9NyvMS+A49PdOrBayeqiae4Mg/6oxdScUCMPFYNESO1tkkTelkD8+tCGsThefyhJuPWCESKqi2wlyTeG7ghwPKjWlEVIQ2B661OGDkM3XI7iv+bG88htUTlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4UCBv7Eu1C7RLmPeV4UzD7Cr/bOYxeOqsk6x0TLI4A=;
 b=K+PvhUx3sddp4pBpBr8WCZFeDLwQZeUOl5SxwvfSoP3USVuE3eZ/rER6QzBpd4Wiro7aSaXFdG+vUv9HMnb3xsgwugv0pgcfQdn/9RDInApZ2BPtTOh9mIEMGApS0BJsN1awttNsqDcG3yUXua9xfn1vHY6r9oAZ+iPVUMQg4aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com (2603:10a6:150:27::9)
 by VE1PR04MB7469.eurprd04.prod.outlook.com (2603:10a6:800:1b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 02:54:17 +0000
Received: from GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36]) by GV1PR04MB9183.eurprd04.prod.outlook.com
 ([fe80::bc90:f96e:eb61:cb36%6]) with mapi id 15.20.6134.030; Wed, 1 Mar 2023
 02:54:17 +0000
From:   Jindong Yue <jindong.yue@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jindong.yue@nxp.com
Subject: [PATCH v2 2/7] soc: imx: imx8mp-blk-ctrl: Fix typo of imx8m_blk_ctrl_of_match
Date:   Wed,  1 Mar 2023 11:00:37 +0800
Message-Id: <20230301030042.2357706-3-jindong.yue@nxp.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230301030042.2357706-1-jindong.yue@nxp.com>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0136.apcprd02.prod.outlook.com
 (2603:1096:4:188::16) To GV1PR04MB9183.eurprd04.prod.outlook.com
 (2603:10a6:150:27::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9183:EE_|VE1PR04MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4d5329-4733-4969-58de-08db1a003f29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Gax3EsqMc1kMW+wtEwITWuEIIpnTHd2emTmbkWenSquQfaeNLIRDsqCijXZ6gX5a0E+dLZdizU8GrznJnc35R/k0SFIq42s+oZG5O2HfIYZnmvxTCuNzqrWpE5+HsBrnEYnwDqjurPb/xYlh6TbbN5DTnNdSuq3snwyZ+nu5a3scudk1L9mURcwE/5Jo/b/JlhrHeNPPW5WmKjKQCmX/sshu5otx8sFamCjuIAL2xcINZSl8vbqdgSeuwl8d1PQsTgQU2WApVqcQztWu/TCQ852J4zFcEIdXMTM5Vsff47odpgwitTjDSzE7IE+7hQqLJpewmxyXo1eqFHSVL9x7PSCX5bZL1Yy7TYO63HuqS7ZNO6nhXyDn18KCw8dgUPn+SQuw/tQtpVAU1XxJfv7hLsO8tuzcx2lJxoGd6l5+PYzo3RHjEVh0TAXqzYpmdrWEnvgNn4mL7XtFZ3EX0z7YMKTixuSkk9GWewVdFHS2gSzMS6TOZn4U2YUAZhDtNUfLoD82ICM4F1qt/iRfnyoZ+ef1NpvzTvpb6E8avI/gWwSlbLkpHVb+RfZYGZCD41UVjPMB0l7y4CIglYA3L6vCJ7CnFH+UyPXcOOt8evNGRKGa5Z/QZ1T5ROn16CQ6aOz917T5V5jnYdUoQ0HJ5LAyhZTyj6ELeV6ZKsLuJ+e7hj6P1FeyLz//9jcH5lVFdZleoFibTdJRkC2wvRUpe8voy5/MnPaO9aGGheoMZq+p9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9183.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(316002)(86362001)(41300700001)(6666004)(2616005)(66476007)(8676002)(66946007)(66556008)(4326008)(5660300002)(186003)(478600001)(36756003)(44832011)(2906002)(52116002)(6512007)(26005)(1076003)(38100700002)(6506007)(38350700002)(6486002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVgyK2hWRDh4R0VvVTI3UTJMMGE2Sm5BNWJ3bnlzU1ZBV0Q5N05uWVpLekQ1?=
 =?utf-8?B?VXNnT292MlNadndoZTRidkhlYlQzbFJrc1hLZyszMlZqUkdRSmwxb1lNejBB?=
 =?utf-8?B?bVFUT0NxYVl2VG5wTzJWaEhZRlhZbHhJUi9tWXFUanhSejh3QjZHUnR5d3Aw?=
 =?utf-8?B?SUw3YmJMYkNZcnJpSTZnV0FGYVNySGRmWU5yQmVYWVlHZmxnUHVjRzg1Qzhk?=
 =?utf-8?B?a3h3dW5NUUF6THdPVFM5Ukl2TDRHQUNqMkhXUTRxK3JqajhWZC8xRFFVcFdX?=
 =?utf-8?B?dnRBRUtpalE3VjdDYUgrZTVnWHA1NnVndWlWb2pEMTZka3U1NHFzRG9TU2Y5?=
 =?utf-8?B?bWhWVjhGN092WjdGMysvTmhjb2pEY3ptSWdVbDhjK2p2WFA2OGtkMmUvK2kr?=
 =?utf-8?B?cmY3S2FGaU0zUDZXU2lNZHFxd1haWlNQZ1ovUTZwdDhoL2Rxb2hadk5tUXVO?=
 =?utf-8?B?d3E1MXA1T1VoOVRSaUhOVVY0R0d3enNWWVFrcWRCRVJWSjJ1N29xa1BuUW1U?=
 =?utf-8?B?RXdUMXBrS3ZtVFFZQUxNVTE1N2ZIQk9NOExBajRUUmF3MnpLTForMDlNL2tN?=
 =?utf-8?B?QXJlYklXM0ZSTmMxYlBlVVNWNytFTFlTR0hvbC9qYjhMcDA5T0tFS1VKSVZH?=
 =?utf-8?B?MGhoc3F2aGJPUjFsTUp1SjJZNzFBeTJsVkIzSWx3RnJ4d0thUWN3Y2Jaa3hE?=
 =?utf-8?B?SXpLRmxiSUFPaUJpa1dhZlNTeERtRGRwVDYrTzBpUk5BZW9DZlFXWkN6SkZh?=
 =?utf-8?B?VkdFUXlvYlJpZERGdnZHWHVSWngzQWRwQU5wbHJmWFJKL09ibjdYUHhKMjU2?=
 =?utf-8?B?dC9XZDdNdUVoanFEajJ4aDdYNzg1QW0waFRDaVhITzVsMG1TRmxIaFVsMjdN?=
 =?utf-8?B?aFUzZHZJbW9KM0hvdXhHU0crL250V3N3cmh4aUtsRTJYM1Z3RXBmOEdJenpK?=
 =?utf-8?B?SXpJOTV5MnRMS0FybVlid1UzUmlYUEVXWUVnOGJOem9vbXRFd2lZcm0yTkFo?=
 =?utf-8?B?VEpkckZpOVlGV3kxbTJqNVpQT3hsdEdDTEdEVVpDRlBNQzJFN1lxWlkzNEhy?=
 =?utf-8?B?ZC8wUkZJWk1iZm4vRVJMTGJEalhGYlFkU0tRK2hyVkRzT09yS2JoMG12aVZp?=
 =?utf-8?B?S1FlVXMrcmJuV1hXYitlTjdrWU5tMUlBMjZqdHF1Y3NSRDVRNVFWY0Vtcm1k?=
 =?utf-8?B?WGRKQTJEajhBRDZ0VHVKbGVsTmRLMGJJQ3NEUHVkTEJOc1JwS3p5ZHgvRS9h?=
 =?utf-8?B?QmIwYzhhdU9SVVMybEhaQ0VKL1ZWREpaeURSYVJ5djdvcUJncXluUXhDSE1W?=
 =?utf-8?B?R1d6WllCVHRCL2dVeGdXbnFabk1CZ2tlc05Va05XLzZjL2YxR3pRL3dnanRu?=
 =?utf-8?B?M3ljOWdNWUM2NldjdWkxazVScjZSVWJsclFrTGtNaTZSZmpHbGdRSUZYRzdq?=
 =?utf-8?B?SVhYRUtPTTZPYjBFK2pIV3l4L0RTUlBUOFZ2MlpPcDl4bmxKYU1sZDZaNElz?=
 =?utf-8?B?TzI5d1dlWCsvQVpCSXA2MmlSbTJrRnIxNWxta2JlZDQxcGVqcnhLUFJrTnU4?=
 =?utf-8?B?cldUaDZyTUhXNnkzVkRTclExRENmUEE3c3VXM2ZtQ2dibzY1andoVTRSZ0Nv?=
 =?utf-8?B?Zi9rcnpRWGx1VXV2d0s1RndVRXVQbFYxZlRGWDRqM0h0RVpPd05CNThOM2px?=
 =?utf-8?B?Wm9xVmUyM0tvV3FBNE1ibVNJV1ZRMlZLOW1zUkNjZzNxTnV0UEV2NS9TVmQ2?=
 =?utf-8?B?RnloSi9mMGRHWktGV3c0dXpYSUphb3ZBZ2VZclpOSjRET2pkc2dXOU4wLzl6?=
 =?utf-8?B?cVM4aWlsR3FHOWtBVXoxendzM1FCeERubmEvaGtlOUhxdWtJL1hnN0dQT095?=
 =?utf-8?B?U3VRKzcrbFBQTXk2SXdDb2tIcEJHUnVEWlV4VFVTbXFqMHVLSXF5M2JGdEEw?=
 =?utf-8?B?OE5URWI2UExtblZyNG9hQXV2aUNXYzhPSVBvWTJQZmFFdFZ6MkZsbFJJTTU2?=
 =?utf-8?B?alh6YkRFblBsOUJvbHFrUWxKcGI4VEMwMG9ydUlUYm9vZWJCYzF4MFM3cmNk?=
 =?utf-8?B?MVlmZXk0UENURUpZUHBtdzlySWJiRjRsdHl6OW4wMzlhV2FDVUVaYk5iVzBI?=
 =?utf-8?Q?6ALobk+cG/qO33VJfeaceoUTK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4d5329-4733-4969-58de-08db1a003f29
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9183.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:54:16.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRLERF4RekVEbzggay6l4TGZ1wF7Y0NEoCS8wTGRObdcvdsokXEEC0TbtOJwwJHfAFLG7leNIcRnBQ3Pr0BVqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once set CONFIG_SOC_IMX8M as m, following error occurs:

drivers/soc/imx/imx8mp-blk-ctrl.c:747:25: error: ‘imx8m_blk_ctrl_of_match’
undeclared here (not in a function); did you mean ‘imx8mp_blk_ctrl_of_match’?
  747 | MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~

Fix the typo.

Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 1892c2c78831..f109c7bd6658 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -852,7 +852,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
 		/* Sentinel */
 	}
 };
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
+MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);
 
 static struct platform_driver imx8mp_blk_ctrl_driver = {
 	.probe = imx8mp_blk_ctrl_probe,
-- 
2.36.0

