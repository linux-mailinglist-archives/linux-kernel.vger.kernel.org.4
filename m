Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562F763C5A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiK2QvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiK2Quf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:50:35 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AB6F34F;
        Tue, 29 Nov 2022 08:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNpRgw6jflx0sQxuoSkYjkcEAr6zRO0fbigEo5n1uS9tOHSMN/JCF9FW5IiPCgzfujnnU9LmvaF/Pzi/4vZBPN5xVWt/rPEu4HvWBJkOYZNEmVxvGTo2mDFocEtZ1DxY/BtMRZ/FWDU+ZJaBYEPt3gmqw8WvSq+NceiMc+RwUlMBSxegUZUH32TZ4MBZ83N038OsQFSU7oZKyR/SAmetMSUyFVKKK5hD9GVZsoa5MiigM7Iz7MvM0xtk3TrEzmjk53md5ipFrwDa56PKayV/vPb/1+FDTIpRZhnV1qJricnc2OB2xtiT1OnejUJaKBhkUbin3QtTo72e2EB4aGhpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV7YRljoDAwIJhgPl9u7KFxJUrKL7D1aNBoYoEw6BzM=;
 b=JStEFySggGwy9qzmaRSjgrGXKBEupmlI032/QURaw996Zhh8AgNrsJ0GIf9yCPXAGC8dXWEUyhyxVLoVpluSDPkjnnLrosWWbBUu2CdDNtFqosJlPtJwNWS2bNtkp0QEdPu4HSAde1ZEIFpQfG1aFo0EeuinnCe8g5toBaO0qfdhSIj5IFJaJW4iEMMT9YBylekdyenHgGubJOR/xbZGB2PNeUslDpQOpdV/ujsF3yEjlSCJf0+UQhQS3YGvA513r2y/rNi/N1BT31p87/ggA6Yysw7Ajxsv93J5vMuxDbx+OxsGB186g86pfPRy8aSkeDZ0LA03O9haRsTdqGJV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV7YRljoDAwIJhgPl9u7KFxJUrKL7D1aNBoYoEw6BzM=;
 b=YflsPem2Sgyc8pmVyUIb8I1irRRPydzKn+XDuUOuoKhUEajgfEA9bFqTefkySToGzB8Uyrhoxta0bqn1uXVSscBaW9Tu6RQb0fp8DqmZiXBFjGKtKfLzdyIVMyAnKUOGBv8yWB6xcALb+I0kOtqI6sUmrK5wbHKJXaFDx30To1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PAXPR04MB8735.eurprd04.prod.outlook.com (2603:10a6:102:21f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:46:10 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:46:10 +0000
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
Date:   Tue, 29 Nov 2022 11:45:30 -0500
Message-Id: <20221129164531.2164660-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129164531.2164660-1-Frank.Li@nxp.com>
References: <20221129164531.2164660-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::34) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|PAXPR04MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: c75d06f1-7e82-461e-cc22-08dad2293817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgN4EVvh9LZUjwF8gaHVch7seTvHn4ZXgGeHlhMjUeJSmwNU9V4f0gFXobI/87CYW5vJxYn1yfBEBfd+IlKhyghblrQK6lw2M7q7qe84954V6nvIt7XgXWtQIVoc1N9uxGsmz8pVymZsv/IlnXIxVhkrcPgaUcSetktTKv5H9A0JYZDVks4SPsmNgL7GNEgHrSP5heDiF3YQB4AE1xHD9s4PRZxG+qodILGNe6kEsdLu55rWAwkcVBklptbbYKlbbBxPvypXdtVKXqSw/o7MjPaYR02LeEfsc/0sUO9P6MgXSTx08ztmqHS7V4yAiTsGKnna8YDKqArnOmDSN2I/VYkmaLehRcnTXV4ddLATDcWXzU5CZdNAN7i04au49R9nxPka+3AyJb9dAQkskjAgRCTr9WjCnzyhAOi+GN0aP6qTmXa1jjN9t07rYb4IrAKIUccgSWoQPYFHhP4307hNyTtIi0UlN0/EyG78LQyrmm0qJJ1VQOiAEsrYiriyIkyvckxlCGKi2LyhsomFrvqLEPOkRezkCHXdmK4XP4gXozn2X+I5xHourzzed8GVtbW9oo9c487taXmxzXMD3/jmga4spQA/MrlpZheFwd5hq9Al9i0W2fNPuPDKwEwVMEp+7VpUaEodC7/utuhYXp0eWvHJJP+ucYD4rc3Ub6Ijk4lgKZU2gwWk4ak82zUGjstrRjRhxlL9B5udvYdL75JcI2ush652W1AbTHF26UlUtQlHCJaM8oVjHqi9tL69Sw8A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199015)(2906002)(83380400001)(36756003)(1076003)(2616005)(41300700001)(66946007)(186003)(86362001)(26005)(52116002)(110136005)(921005)(38350700002)(38100700002)(8936002)(7416002)(5660300002)(4326008)(8676002)(66476007)(66556008)(6486002)(478600001)(316002)(6512007)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ybh6MhmVX52MAmLnqh6D7JuFStIScQV9P1wslwaOiChOM9KpOXSG7k+g+9t8?=
 =?us-ascii?Q?CtWHL4A6Ff2aXX3Dg52hQKragitSZgiNETJC+2Jglmkl76cfmPYsk/dZWWvf?=
 =?us-ascii?Q?Zzi+OOgZAU+HnCvykbw0KjjpexJ30oD8P1ksv1kZUFU30tbAbvQoCgk8H8qB?=
 =?us-ascii?Q?si9C85yFqbRID7i2w5aGW6oGV4giDlur+18mv2DbCLWlmQVmyWg/4xLX31TE?=
 =?us-ascii?Q?X20CK2Ku09dfE4/qMvB9mpP0zuGgEXaf6tAxgq+XT2LEGGSKTQETGYl+cQ/a?=
 =?us-ascii?Q?3s/i6dTbSSflVdUQWHzgRjvxqJ3FVGnlVGiz9E5VbssVO2ruZX2dD/H3daoq?=
 =?us-ascii?Q?/DyXcB0v4FKpCs9/d/6Gx4DfdaUp/weHPWURKE1dC4p46GxDpKtDKQCjeKeD?=
 =?us-ascii?Q?nvlVbP3ExQMzPDG3NwiKRdD8PvkbIz4tQFr2e2I8vdU5yk8nXcxM2K7vlI9k?=
 =?us-ascii?Q?hIaqpY7htv4FN6wz1dHpnhghj4VLnUFylmlqCb32rr3ZqNROC3kSTyueJSBg?=
 =?us-ascii?Q?kqHHwTLFowFoxCAsNlL0xD9u8+XhFePLuZ2DgotqMgZ/WZxpjh6YcZLPlCud?=
 =?us-ascii?Q?ARzMSTHQHZ+JQL9+68rhit15bAwxpqM9pB45DLhDxHumPUEuqIVhBdSs7oWR?=
 =?us-ascii?Q?3wIlJS8zhLmIkLldVehGR03YQkVhfE3huqKBLZJW1yn6kXx/WQvI/USfifpy?=
 =?us-ascii?Q?dpZnyrvC3xyZCjsDZj3A57jiI7FFF1hlQBR1BaVOe8kHOa/A7zXMPwu2QbPS?=
 =?us-ascii?Q?09GWgJxU1VBKgjpNoZgYVwPGPBCRq2DPl2MDgQgWTlWxuNcqo7bRSRXHZofU?=
 =?us-ascii?Q?Wc+a4sc3YsZHBXatL+F1uYxWILbx5dUZy4wtwyHn3qJL71Pn3YkWe683vIV+?=
 =?us-ascii?Q?EOM199q6ulCgiIimguVQ8pNGA19J4kxC2odAynE1jHNKO0LvMX0+H0fc3Uvx?=
 =?us-ascii?Q?JasdF+1wFWwv2v2BnTgJlFrYfRaTySm5SMTcX5LGcUfBJ3By5oX5bl7TSwdF?=
 =?us-ascii?Q?9CU22rdGp8rwL51skPRvHIBHrMxlZLpAOINl8Rd3u7iV6PB4oEMJIzMIWG4q?=
 =?us-ascii?Q?mKPh0htXQuC4I0+97ruDBp+zYculVAxpd6LswNqQbyo8WJQ3RGHoCKSALPS6?=
 =?us-ascii?Q?yKK8yKozt5naqfb1dkrd6slMzEKuRtIPL9ipXi1Yr8hNFf/2U/2JgQC/cYVb?=
 =?us-ascii?Q?DZ1gDQyIt8MVBJlo4/RX8GpUjeoEb2Bm9IguG0MSzCb5oibgwXpi/MI7b9SF?=
 =?us-ascii?Q?X4UTglZaRjJhHf/ti4jhqgIJuKlmWTUu6RvzCDR+tPHHowJD3A4w5YkLR9v7?=
 =?us-ascii?Q?+r33x5/oq9QR372JyZqsFy2/33zxjLRoz5l98wQ6Hzn0eDmS4TzxLdOSYuQ4?=
 =?us-ascii?Q?6u4T3O4CxJ/3jC2AZlw8UfZMf8Fdx79gq7jLysrv7rqtkA5vgkmfPoUjk1TB?=
 =?us-ascii?Q?qNZmz3DS8AEZWiAJc2UAyeANajFKC1AcNjxmQ22p9R+x7KZiUjkT4iHZK6Qa?=
 =?us-ascii?Q?dO+t1kE2Z5M/rjCwMaYQT/Xu77BB2UtzW0tvWxs2Hn2LkqM9S2WJvjs3r3Do?=
 =?us-ascii?Q?VHTeWd8W4hbuyoxa5pK3nNadmxFKpxNrGCW7vVQG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75d06f1-7e82-461e-cc22-08dad2293817
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:46:10.5422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ7X9BBJzwOQlHRUQVqa1RlJw+06eI8zJmWq9jSyHGlRrYXxIG8uGhM9lRvj5PRjT9FXuTOa5nEhOYUMBsnglA==
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

