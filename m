Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951D263F22F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiLAOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiLAOCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:02:01 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FCBA5193;
        Thu,  1 Dec 2022 06:01:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaGrWNj41wGuuktjFtb6cOVb31FGOF8Em48Y1ddNTHI5TzJAFw/p6KRc4FozI06r7JzVPpoGkV+zVGbyAoDFNkochrYy5NSQuqot+4XEeYXi5J7hAK44/HQDpE4/T/0uwUj7LIcqPzJ5/f5pxuW7b3TAVGH1oRPlo4G1Wx/lpwmMmM1iXHWiiU3txrIUlye3yNpnVS9JQMywYWwZiEeUyiVffm4fbSLLQjWaVT+mguYyP235CLrVnCOpL/N/kUZtSr068Ckzn6VGtq58PiB60/myH5TPDgKeQHjFdaiEamgcGlFOe4CCt9/1ae2ahu6r6BnqtDZLq8v5zahD4fESgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz8PRJOZnElxFCZ6PmbmRdQ0lO0d7shDrWiugbwPCj0=;
 b=n88+ftNcNl+kOXcD2741fKp7ZVSqVPvmU+7aculcUKhYMTnIUoMkOGZPNmLQMxm1YJREnEkziVPVS/rWNXJKGg3gHOY8pqoPcfeWGhPkjKjEXo2K/6aLvkMvIH5MY5tXNT0ZOXRzgSaFnT1tElDnKAEaW0IUPZB5kb127NlbCUxuGhf1I0VVMpND2mh31Axobl+7DRA4Fy4Z22irCHX1RQA9xew9fHn1iZxEZKUs/ToGDjqkgdP+zyYt3X8riMWVhbMdzPtkeB/8mVX48GOYZFrPqPn2IP05DeKuEn6SI8ttgXkMP+cIoRW38TqHO8JjbZd6rH3B6T5ofmT7plqj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz8PRJOZnElxFCZ6PmbmRdQ0lO0d7shDrWiugbwPCj0=;
 b=TqWqv8GOBb7WTRtH53zrziR1sTCi+GhuhmTGQdgzZsE/8Iit0lpUO4N3on2CZmAKmGqpqTgnpkD96qS2G5pukSPCDgFk02Jp3ZSJnjeMz17VNYBv6UGv6e6/UYJV0zRicfw224126oZaPMQhlfMOAjjNctPaf0jrjp3UJaieHu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 1 Dec
 2022 14:01:45 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 14:01:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     haibo.chen@nxp.com
Cc:     cai.huoqing@linux.dev, festevam@gmail.com, frank.li@nxp.com,
        imx@lists.linux.dev, jic23@kernel.org, kernel@pengutronix.de,
        lars@metafoo.de, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Subject: [PATCH v2 1/1] iio: imx8qxp-adc: fix irq flood when call imx8qxp_adc_read_raw()
Date:   Thu,  1 Dec 2022 09:01:10 -0500
Message-Id: <20221201140110.2653501-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: c562ef1a-c6e9-42ed-8452-08dad3a48b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSGC5uMTYU7Be9hm9IIFjtfhx0ERrFgAiT+ZpdVz5Y+UONtvLkLhHmo6OLvuKavtx2JV9COAcFb40+/YaSxTx++ZfWtB2q0uExGaEXKN6jJ6t8VuJ7ZenneYRXTRxUVQqP4PvFxTCSH6D7A/5UxECczaeNHSaHZWnwnm9o6SWHUhfumw1SbnS1gvhMOl9FWCjLK6Od4X6bncdtd/V4kTg7CTygKerlpKq//RxguMZkC4kWrAyTDVHBooMUc+LSLi8Wn3WNbJsfrSckSDvor08TG4RK6w1WBF/3LZj5BNP0Wnsk5XJm7dfe3Cg6VoPzBXmeVUHZzrhVVZURU7ltt620Q7BKGn2zgG32ov4VAqldoYsh6Q4JfR1qDazivdN9kNJSN2reXTsjXg2vYYjBXeFE7b5wMPPdpyip+ogBlyHMOQTdc1XcaM7hPvYkGlUHY8tcTXp6Sj55iEZTZENtM/G9+p1ae2UmomxLRH5yKy4cR4ePwhwKgkwRKOt4ln1jyW6rHbpK9HZtYM6fCU4nPWmRRbKz8BhhwniKgm+wePTEn7IUHQ5h6m61H3dryDh2BbvmzkzhhjSxX31uZJUA8R2b/2n0qwmYHQ/1RoEG35D3IIJ9JLB/fUN6XlNCBxCs15KJzqj45mWJgp1ujXl3DXsRAhEp+YsFe6MQBwNVcOCOyR4u92zbh1tbGurjrmTgUBcZ+o9n6dGwpVihPeI2RSbeDVgxu3DyRFbib+XSu9omg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(1076003)(2616005)(83380400001)(186003)(6506007)(52116002)(6512007)(26005)(6666004)(36756003)(316002)(37006003)(478600001)(6636002)(6486002)(34206002)(8676002)(2906002)(4326008)(38100700002)(38350700002)(66476007)(66946007)(41300700001)(66556008)(86362001)(7416002)(8936002)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C5Zb/HKmTgHAJF8SC1ZrhJ8XYrwGV3avIKdV7CcrjY8eR0Z349ww7L84//5B?=
 =?us-ascii?Q?rN9HJqszTd79BquYmerxjHcaOIo8eAxcdppQMsmh6z0LFeJuBEw4Mkb0D0JA?=
 =?us-ascii?Q?++3pijwO08DE4vGIedf2J2wE6r+advzKQAPdR5hgoWYctYr1Bc4vwIfHqJ/y?=
 =?us-ascii?Q?C9+yoqg7MwnxQJXn1srLADga9HqXT6tBuSyyH0q0LppLi2cCaVAu2UEomrDN?=
 =?us-ascii?Q?pjhOgbwI48Zic3oFOGtmZZ9eU2hii+WttbAnasMMdAaEzqzGl7LCBKKpsLYo?=
 =?us-ascii?Q?uvtseKHFrCRUL3QSI7+ZdcBzf53Z+nSfkoIKHZFIqYeaGz0WEE/10Nrp+Krt?=
 =?us-ascii?Q?yTxj8W0QeVkvd+9NihgXpfSE+8dJTD5D0JbAOHAOcBpDqBxS2b2gsjuVQNjE?=
 =?us-ascii?Q?Cd+ZgM71SwTBDEbwSPJfccudMS1f2Ld5StLn/YjBLvP1oEiqBsMVhBhetE3C?=
 =?us-ascii?Q?bvVxwKMYBmn3hZsTHqTFhk6AEk2rLZeTsh46cQZesMCViiPFbRkS1HzIlKXs?=
 =?us-ascii?Q?Yr1z+2ujM27Nm/WRsh0Qg/78nIRy4QikuRPJFDuxl1YztgZM9RmQ2DDuEUNH?=
 =?us-ascii?Q?NXqbFDtz3bC1bOaYj1n2p/W+jRcebuu0j+xrBhR1QL6mzGOE6JZe6jNXYxbc?=
 =?us-ascii?Q?89uC1mvno4fxtCUc7quyrzwSbZ7KjmmsimUb9XXFyDaD/XQZ2dxnujL3dhBh?=
 =?us-ascii?Q?VEhXaXauMF+bocnfPNntUyXnIlTuabM0f2kX1mlisyV4j+H0HLiV1zEY5fJv?=
 =?us-ascii?Q?e+7RcWKGESY6LDg1AVZrHilE+8VUkcCtW3QawGQcF8octmhfMpO7whZAFWx+?=
 =?us-ascii?Q?nC0OJ0SgDwzWUK4DvJExfEHW6w4V3u52WhY/8/biBh9e5PvrLW61u4US2n4G?=
 =?us-ascii?Q?ehs8eR7AD7T/b26eFWbyXABw/pGlxMoAXRRk+w7xKd7sTYjlI4Fq2T1eqqFL?=
 =?us-ascii?Q?InPb06ajDuEGMufaymF3j5OQYejauEimKKJ71KbEI0wR+cpCB/KuNaxfg4N2?=
 =?us-ascii?Q?0L75IDDbcieAik2OeSg5VEFIOKvVFSQCbUvUMk0ElUrCiUwZ/sCOBEFGWOlG?=
 =?us-ascii?Q?hTv33Uc3b7lAT02kWk1ZVGHuV38YkaJ8bDpxCIporZl2LyxXu2Mej3XXmGoj?=
 =?us-ascii?Q?sbktVGdzXPKQJ5Tc+g6vpy+FZNQZDoBzoDnr/pQwQw34hd2eKwNACbgMUnZi?=
 =?us-ascii?Q?Mz5pEyI6PLrUfUwHwucWF7c7VD17Mp4ARw5dpcYFd4PXNhI3S/uyYc1DpFme?=
 =?us-ascii?Q?ZuEWb4XW92nD43NmBwbnKqg3cykm3sT2aShzTNX09+edRU+ojoLACJRDdk8V?=
 =?us-ascii?Q?VpNOSgZTZuex1//rO22k3J8c1xvzfz4hcWgSc+jI1o1lYWPbCQ+s5lP4Xzed?=
 =?us-ascii?Q?KUF5ZeaFhHCoKGvNcKEVXS7Y3XEIKrzuH8+I/cv3ubkvmrWU+zztlQfe9rc7?=
 =?us-ascii?Q?9rMxML2JudrSU3pNYN9gBfwjY/LlhxXuKTy5Voh2qnGc4Idfax79eZInd0A2?=
 =?us-ascii?Q?+DIcVycy89Y7hu/ZQo4JSh71t52Sa+G//sHWRKtz9nHnQAQwezEQTfja2kV3?=
 =?us-ascii?Q?4uG+Z5aOyGZtsgLnUsM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c562ef1a-c6e9-42ed-8452-08dad3a48b55
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2022 14:01:45.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6Bk//TSb2lKqojNKQ+EZ0uqjgV1FTzpnIEcB9pGagMaMhefZo3z6ilU4yXgsxRu41WWboUuFNMfZgnMOM1KeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq flood happen when run
    cat /sys/bus/iio/devices/iio:device0/in_voltage1_raw

imx8qxp_adc_read_raw()
{
	...
	enable irq
	/* adc start */
	writel(1, adc->regs + IMX8QXP_ADR_ADC_SWTRIG);
	^^^^ trigger irq flood.
	wait_for_completion_interruptible_timeout();
	readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO);
	^^^^ clear irq here.
	...
}

There is only FIFO watermark interrupt at this ADC controller.
IRQ line will be assert until software read data from FIFO.
So IRQ flood happen during wait_for_completion_interruptible_timeout().

Move FIFO read into irq handle to avoid irq flood.

Fixes: 1e23dcaa1a9f ("iio: imx8qxp-adc: Add driver support for NXP IMX8QXP ADC")
Cc: stable@vger.kernel.org

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
 - move complete() after read fifo


 drivers/iio/adc/imx8qxp-adc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 36777b827165..f5a0fc9e64c5 100644
--- a/drivers/iio/adc/imx8qxp-adc.c
+++ b/drivers/iio/adc/imx8qxp-adc.c
@@ -86,6 +86,8 @@
 
 #define IMX8QXP_ADC_TIMEOUT		msecs_to_jiffies(100)
 
+#define IMX8QXP_ADC_MAX_FIFO_SIZE		16
+
 struct imx8qxp_adc {
 	struct device *dev;
 	void __iomem *regs;
@@ -95,6 +97,7 @@ struct imx8qxp_adc {
 	/* Serialise ADC channel reads */
 	struct mutex lock;
 	struct completion completion;
+	u32 fifo[IMX8QXP_ADC_MAX_FIFO_SIZE];
 };
 
 #define IMX8QXP_ADC_CHAN(_idx) {				\
@@ -238,8 +241,7 @@ static int imx8qxp_adc_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		}
 
-		*val = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
-				 readl(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
+		*val = adc->fifo[0];
 
 		mutex_unlock(&adc->lock);
 		return IIO_VAL_INT;
@@ -265,10 +267,15 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
 {
 	struct imx8qxp_adc *adc = dev_id;
 	u32 fifo_count;
+	int i;
 
 	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
 			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
 
+	for (i = 0; i < fifo_count; i++)
+		adc->fifo[i] = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
+				readl_relaxed(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
+
 	if (fifo_count)
 		complete(&adc->completion);
 
-- 
2.34.1

