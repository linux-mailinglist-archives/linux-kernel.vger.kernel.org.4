Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973B663C59F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiK2Quh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiK2QuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:50:08 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536456F0C9;
        Tue, 29 Nov 2022 08:46:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aent1CNYihXHH1+Z5K8kT3OqjsQkw6KyXTOq+TpJuzoy/DYBPfUqRcmb16ZBLnecgnBIlWebSndxWO+ciHAH6ouSvVUQuX3bjWyROZcZj7nxUKagMe0INx94pWgwTWckpqFKIAo7c7Uzff1EM0+rD1O4V9/RbACYfhZwiiuk5foXAWOgjB1oYteSaT/ouofSnlOfnuSF2bEe52d+ru3yrM4sDMT+MOwMhAcUlCXAPv0ZjjiX2PctlACSm+5Nob890gNjGLzdcaiVPLX5tY1Dc44UgTYxSZojed4EK7Y+atS++90TTnyoGuzTb0SNnbhGDwhoNJWSNT/Q35QB6c3wVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV7YRljoDAwIJhgPl9u7KFxJUrKL7D1aNBoYoEw6BzM=;
 b=IKwzFV0HNipjJUovyHDyDo6WTFTPLLTiIqwiwuFzQcepBQ8+WEb2VuIdToPYuAS/tXFZ2ZVQx+VWpPH7TnBPVDbpEy8i4f9qBBjUziyak03ecRSIWtbZl59npItvgWEb4eSerYRSPCM9ULNtovz27QJd6NyhxjKOhM0oWMTZJWzegwTgWvZGpq9K34D/wZhCdhwX38eUrGSUxM/xtMEit6ASOpPlk75DpHb0DEEpHD3RzlfevvHdyA1XV9fHfxLqybhIjOKJ1yVgtjUpLhpEAVHoD82nHY83G1bbDWHNo+lGAc1NJBwNzYc68tohELOdZ4JV0wAd1iRDDH4hleqK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV7YRljoDAwIJhgPl9u7KFxJUrKL7D1aNBoYoEw6BzM=;
 b=IFqN0zzDwURVsZRWlkM1R5Y4gO2qFGYU0/9as9b3wwyeMIxem84cFKH1ZjYEFLR1TaBbDYq7SxCFRqvHUElSiEFsIdjWzU/lbADle/P2i66TcfcBT0yyy/XxG+AA6UxZPLd+Pn8V8ORZILXVHUUgeiDzyK+3trQgenCg6kMgsZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:46:06 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:46:06 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>,
        Haibo Chen <haibo.chen@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-iio@vger.kernel.org (open list:NXP i.MX 8QXP ADC DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] iio: imx8qxp-adc: fix irq flood when call imx8qxp_adc_read_raw()
Date:   Tue, 29 Nov 2022 11:45:29 -0500
Message-Id: <20221129164531.2164660-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|PAXPR04MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a12d332-2c69-4e6c-56a4-08dad2293484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwhfb1n6gG+FaH9vHs6un/eHBSWI4ekJioPHXEdisYjl/eWzgXV0LMuwmAUWtaRq8/lvaJDZjsiP0U7wSPLpMUhgjaWkSatzvAlarxW4O/79Qq8gv9RMeuDnN9eCX9tnPll1HX9TIJm/uDVXIzjgJ5HIvyF4UowIz2S6A4NgKNDUkD7C2Nd2pgjGgfcts7lJ+1DmxieHYf2yrgHy7S5UpqEB23m4uP3WTIhQ77JjN+Zu6JLYPEwxDihNqB9Xik1vcp4HsuDaX7vtyigyO9rEXHdEMCduOlrpavtw6ssNwvd6FZQkZGVGsazcwAqNoosFYHCdWC8vsX/ygMSVNBCmkjDeZ66JrbKE+u23OYntaJks2kuEbLXeyOZuSzxY/7qU2zJFQ3g0hVjF8z79duhPSmmxbR+y3tvc18VoL3n2AAujODlFkuIUnrUrRtcQoFsqlcqqkPepw5X/D2VNYFNxnonmpFFKzbUaLL+u2JE87GBzXO/Y2amlYLbWSoRnK0/DX3uY+YmHNqi/M6iBP9KBNxDLzHqjL+iqV6y5FG2R0F/TuqvWBh226EA/LHENz8eVvtwq4luLgmnb1KRQrHUZp9CL1dyVcmQcZcuifQM4oGZcK0Eobwp+okPe9gIBK810iHBdlurRi0b9UPJ8O0x85mn1WebadIv5Yx27Tw6/jjnklDNF1xOb51v8Ileg5Jysekg3QM7jY989S5soQWH69Hm8U70YY3coLEyhs+N2wi+rqBiDLHC/Cyeoe6slZN4L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(2906002)(83380400001)(36756003)(1076003)(2616005)(41300700001)(66946007)(186003)(86362001)(26005)(52116002)(110136005)(921005)(38350700002)(38100700002)(8936002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(6486002)(478600001)(316002)(6512007)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLBjOAI8SHK0dnFrL3e8Mhdqe0sk5gRvgyAbGsbf8BYTo2WYaazpA+j4KDY/?=
 =?us-ascii?Q?s9/B+1UHs9rMYLrvlZXhRroT2qcRXdHzdZA9zsOFvbt7ExeND9pYpE2DZIDP?=
 =?us-ascii?Q?OiZ+dt9JkVzjc9PSKeCG2u7rtZbmv7c+zry8yAVLruq0Gver2/SVUo0kBUAu?=
 =?us-ascii?Q?H7fLbR45ayfz4RoGKOcKPSULOhwU6lFu/jB82ucASi+g7icZBiKZpRewKHQo?=
 =?us-ascii?Q?XPzpvuzFEnjTEJHdrvt1gNg+3dhpRZi1qEbNOgUC8MneiHojbxMjWp/YS2Qq?=
 =?us-ascii?Q?efH4oCjiuVwv5uRTyHTRd6XQ7pQsQUMeK4yKFLUTy9zFeujfI+5mVxTLYiBk?=
 =?us-ascii?Q?WJ/etnLNf6t307MUoijVhZ13EHNfAU2VHEQce64qc7Bdq8UPRZWkHbjsGWrR?=
 =?us-ascii?Q?NLCQhBMsO9oWwrxq1I1O3fzmBZpDhllthQ2U7qwaMzn27qIIB/aIKBUUq9nr?=
 =?us-ascii?Q?yNjhgc6GcNKLWYAdjMzg2EDw6DBxipqWZwMoCNrcRXL92/dN5N+6PH3uQtPw?=
 =?us-ascii?Q?0D4GHTKiry72LF9TOCge6e1bXv+rBerrA5fsHxfRw4fS5ZlUrrV3Ea2Ymv28?=
 =?us-ascii?Q?XQDqiGPFQzQyNpBeeo7Co2wKYyjONcuQFUigdYxUivmeG2W+tsv4b9sDpkVr?=
 =?us-ascii?Q?Laj6SG2MmbqngGNRSmgYi3JQ7tmmsaguaMEglDrOTFpXMgfhANOdl22OgH6A?=
 =?us-ascii?Q?kRTVdYwUxvDTWajFGQn85vxaigbFSZ2pWh/vkYEJ/mUd3YOcEA1MNHizVFV2?=
 =?us-ascii?Q?qlHZmM1CoQw1yM8xHNaBa00Vou37pcExldJeO190frkvZdbBOjvcgP6ieXkz?=
 =?us-ascii?Q?02Qng0LgUAOQ+uwiFpizLyXsV9vSxoVsRN923Ae6KqE4FhqO4QBUl5JOtuH6?=
 =?us-ascii?Q?JAO7hThA8LUseDFpTjOJt4EXSPvoCW3gWFTlPP31Bk56Or5Tm6EPMrdSMscU?=
 =?us-ascii?Q?IIRbcd8LQkVVSYkA1zkk/gqlr9Fi6RhFxOUhlwgC7wYKOSHp8i341KzXkpeN?=
 =?us-ascii?Q?0zbxSJenelyKGWadSAj1ZE21YYlZciTqOTqIBjCVEP5A/jbmN4JCx7sjHcHl?=
 =?us-ascii?Q?M6LSzDTs+oUCLPJxA2lApcGudW5rVwhunMEAq8X4XdmUQ3Oll+n33Jfq9kK0?=
 =?us-ascii?Q?HL7UQ3u7JvhctjkPV/fZkNGzZE2OXM31R1YiOI71AmKY2rYglC2FqYrcpxoP?=
 =?us-ascii?Q?KiG1o9fZrQq1nS0CQrImHTWVv/ly0ms2+D0cksQ6DPR//XfmpiG4wpfyTaHr?=
 =?us-ascii?Q?gXyZ7S1CFTgsfH5cJZRfufgFErypYzUxANldEvnu1lJZtdCmnRV6GkuaGQHF?=
 =?us-ascii?Q?MsExqoFMjXAu8kBnDRKcqqte38aS9V9fy3bTukonHrNCxxuvErjiAz/iUfU4?=
 =?us-ascii?Q?tt44y83PEPTfvyO3R4D3b21N97HlPgTtkp5q2gGKl0+UyqC3gHRHdMCuEhUc?=
 =?us-ascii?Q?GVQ0q4HYFR2+h3L710BHYd3gHcqr+TsWS1shn0fOF3qL14iZDfbB4bvS1vVJ?=
 =?us-ascii?Q?ekmzKFyR3i/iB2rYYjQsH3yfAfzORY36nlfLjIqqOQgLCYef1OCJx1KYj6K0?=
 =?us-ascii?Q?e7pZQXQVS4Z6x8R4hHC1JAkLs721jVIh88fVTJvO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a12d332-2c69-4e6c-56a4-08dad2293484
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:46:06.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDVqw21/WmRDnkBPK3rCmvzeqnztnNKhPUaTFQR0tfkWog26VdDlV1O3oAFSYPgTT+qt/TsuWUzBu4yKqpkp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
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
 drivers/iio/adc/imx8qxp-adc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
index 36777b827165..3cfba5c0fa34 100644
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
@@ -265,6 +267,7 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
 {
 	struct imx8qxp_adc *adc = dev_id;
 	u32 fifo_count;
+	int i;
 
 	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
 			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
@@ -272,6 +275,10 @@ static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
 	if (fifo_count)
 		complete(&adc->completion);
 
+	for (i = 0; i < fifo_count; i++)
+		adc->fifo[i] = FIELD_GET(IMX8QXP_ADC_RESFIFO_VAL_MASK,
+				readl_relaxed(adc->regs + IMX8QXP_ADR_ADC_RESFIFO));
+
 	return IRQ_HANDLED;
 }
 
-- 
2.34.1

