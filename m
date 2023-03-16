Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEA86BDBD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCPWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCPWjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:39:22 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2055.outbound.protection.outlook.com [40.92.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7335D44C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbiqTpmZNsUtSCCxTINavQd6i7YCooELIlicOzUQYbEzvUIZHueX2xmgg+hHkokMTRKz1kz/7CEuedlc9BGCIMFWaxUq9XD+7npqT8ugEgvVxRcIvNL6mTgPzLxDJ2TnYcFZTVs0IDbfDatrGK9oIvd4KizN+9mAysx+CxkeUnvL7XnVlvNQw78U3ndOaUwfFu0t0yJvwOJZ3bAg4337IwLma3YqMkN09NX5WlThxITS2qrSCBMYHycNnpUhiWkv49RlsW4gvBgslnwFXyh5e5hMbtlDjNZKr1mxPT0IGEmvcZVu5uJLuU3m0Y8AJUmxoux2Is+HYuBt27eTflLhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOQFLPl8E4s8n00ctCnd4Rc52pRtzLNCNKs2bStTWBI=;
 b=a6RWLFxUw9S6O6wx0pwlt9gumFtaHkrwa/CJusNPk2nKnjOzEAoiSZdgbzcEdoZXjCoQAeQrwj9j+AJLQ6pGYHZZpiLXvzeAV9foszeFEe4fgJcoKBcjPmZTqZmK4NWrx5GYm19ZHqBfhApXQ8HmherMx/pQgobizWSp6OEnD8/iDfTidhkFDkyUXJWQgUWxq4luqoG7XQvvOEmDyfi0jqMLXe/uC1LYIgEY14hUd7kI0Sb0e+dJ2nSIj6TqFpe2TvnPFttlxqEc/ENJ4AK+KvJagIkUFJ/U13r2WD3DvRKSYiKfOzfu/79RutX1IWLxuyuNYEqzSfxGEafA6ADX1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOQFLPl8E4s8n00ctCnd4Rc52pRtzLNCNKs2bStTWBI=;
 b=LtMWbLaLUJaSbKpvVVNKeBrL4GcauDpm5WRlXmdwt4aSkehK8Sofr9amUrRJ1Mkvj+LhQC06CUaKwfohIOKRDMf9ZNatsP8wRrDM5mIE+dqKerPSXvhIotNpRatc049F4CK3EfbYD/lgz3hJIE0vCumHAMTJ96J0QQmDxNknbv80oJ+NIDxe4Kzd3NbvxJFXXR+9qeXYfDiSiSfePaP12SKv/fcbZkqj8ErRpAh2liSLkE9FqWgWO77Zcn4KHxlqe7+aYN4fRvshqkMEy8tyEr1N47VQEP+3vOW8fHrw65hXYvR40foPakE4E7mglvabz6z3BJD8nbakKIDwTCzHUg==
Received: from PAVP195MB2261.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2f5::16)
 by GV1P195MB1642.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:62::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Thu, 16 Mar
 2023 22:39:17 +0000
Received: from PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
 ([fe80::4b22:b4f:eec9:6ae2]) by PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
 ([fe80::4b22:b4f:eec9:6ae2%4]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 22:39:16 +0000
From:   gbrohammer@outlook.com
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gbrohammer@outlook.com
Subject: [PATCH] ASoC: amd: yc: Add DMI entries to support Victus by HP Laptop 16-e1xxx (8A22)
Date:   Fri, 17 Mar 2023 00:38:51 +0200
Message-ID: <PAVP195MB2261322C220E95D7F4B2732ADABC9@PAVP195MB2261.EURP195.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [gs0NXW+Ju4tHG8l5ctLtQLGx0X1a8qg0]
X-ClientProxiedBy: CTXP275CA0038.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:1::26) To PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:2f5::16)
X-Microsoft-Original-Message-ID: <20230316223851.18249-1-gbrohammer@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVP195MB2261:EE_|GV1P195MB1642:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a89b0cc-6fe8-4e04-26a9-08db266f460b
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrNBSJh5gWD7Y2D50/0fISiDKMecnPLMEIfvVLMe92Z5qEr0h/FrqcLFmiukb79kF+GFz2x9CT+CfemjG/WPC/sISiyBzSVm4JKzNvhbJEYmmcQwWu58wbKlyzp8kCFE87UBTgVxb71QniYSjKG+nZPLGNpc9y4rG1iWg3QNWj2th7OfIbvODI78NIlPLfBY9Lgz+WNjjkT6uBAlnu5JDj9BfX7jYCW8aooi8ydVoL+pOUgaEBGyTdIMI617tB8SdS7uUFVK8byWzzUJfy5Dv5kPSqTPWmv8zzgwShq9i/9CKRzPRm8QKGoRvvS/bTAdAiTEaARj4sZq1PI4F3aAqPGWUXJE2pbujyiDO6kHcf04BKAtfIblt1S5J+ZT7F1wcXFGcMy9ZLud8TFZngqRTeyQjZWH19nNQIx13sJRES913EgzHpUffCv/9VQiG6bv0VRniByfDxrQixhZLqhkN20aJDb3I/LTxjMJmUtRG6GsTcAW48Mn4/St/Vou2o8JtMfvh3IgEWrhSxLTjYShO5TfWeNEcJXwyaQrDyhel8ZJfzLKw7l3Alji+h9JSxl5QRXjfu1ia7OkcySNRfo5YyrPqY/w8UkWN+Eh/2BEzfK+4oh9LyHURrQy0KBPL/7cQAdf8S/IewDnEgOFqPmneTChicJhQHcaHCmD9sBF7uE91HDRKWipvTNPjuWX5+hbtPK3NmiPe5FDUUM9YMMnWBC47DA3nc1HTGjQjHn64SDSxzA2na3IWpN2QwK8P3EvkXE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxcBQiEq+v41Ow3ecUVktG8chXKqmZ9QRcvPR0eSOYsOpQP1l/i4tIPX9iYNj2zdpMjdgHauvglYmDgdN92GIriy1jJrW8kDvx6zQIRyYAVwomB6vxnRm6OCQ2JUgAsbn44aZGdQ08wYMkjctIX/iwM57TGz4k8IJZqyFFexJgES8zYSyQNEbtvdYxy3wghTGXRP6f/6NuGq07kL0oeLzTu91CQZ4W3csI/tw3qGFdTpnKQfQYHdopSqw5vfYI+mFBoGH3qOdEU0qdz0sLjksaF1hxG5aYj6y7AUoFRp1IJ8jQQx6RL7KhK/WDNzm3gxSJcXmTFdDyYVMxK9xTpFYwhByDZTcMOnV/IS0Q43IzaoX2V4o0OLaN009eAWa8q/jIOTutNiIB/RhVySB0h27ZiOdx9ZmY+ORBFFJa/pYK3I1TJQ6tbTVhprXW5wKP3UKsk1xQUL+9Vg/9iofhqZiWmkKmQtl4Obmw1gGVd6DzajV4+E/z9V7P+6OMxu6GeY1X8+8hJBG2MpMjdYBlkDaGCgApgJJkHFoNbYa8KPK4BLaYm1kcxrpTvzFssiszZdvIxf4KT8NIJ3Yz7tl/Q6fViS9d3AkRy5Q6ZPYnNuj70gbAG5PnRFE/LFW0PHhDuiHaR4OG5y+QI+R3IvsEGaMw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F0w34LTAQGapc45xvrvZ7+WuGj51+eeFM9rFvmI0FmSIYvhH9LI4dQrvA9fR?=
 =?us-ascii?Q?AtOHGVXuQZ2syvYk9JDGRCXieDb8Ts+CB1REESFXGBebkXK7i8H20NAvT3HT?=
 =?us-ascii?Q?/Nt3Jg6OClvmVcAp6tgIcY2LTh0dtNEwNYHUR75xUQ436vMei/Ba94gDKcCn?=
 =?us-ascii?Q?MXqWwVgmDu0tQ7gnozLJJsaDCU6MMWt2cmQ/Y4L/+CFQJ++r1qzojVMMBYsg?=
 =?us-ascii?Q?Gtv+33koUcHEqyNTDc908rdOWbytorqcwBVZcZ/FGOVJ27cOF4NMHY/SOAWd?=
 =?us-ascii?Q?RV5rvFNH9OCsNAaIm1IsSBB5+FyU6JNjt3+Vc6k43hhVYaoL0YAc9BEryY8X?=
 =?us-ascii?Q?1olZvZC22idDg8KYtpcw36tqAnd4WQrd9aIn7ZGgWy0BKuD4b3131HmCjX9h?=
 =?us-ascii?Q?pkIlpMHBmnLNDLaXyLezCiYgR0+b49WB3IIlR3SqhxoQduX9RDxdSHCejhJQ?=
 =?us-ascii?Q?YNcq6Ok5HtV1Wj1oaHj4+LkYtUBU6LbhGCZ3u1xlJurrimZJJ+dhIFGY5+Wl?=
 =?us-ascii?Q?nACLi2VRnZvIJgWiYVKPlyviIzc5+vdow5MRyICUYK0S5GHHX9Tp2cl+Wsy5?=
 =?us-ascii?Q?hbuLoiMVCvhO8I4mkZL5kx/NExp9jFuyJQkWPBI2PtnWv2AzgRyWjJY6nGD2?=
 =?us-ascii?Q?xdA/o15OQJUW9NT/yWA3DSSFgsiC+knYiZpifBS4oeBBxylS7LH/kD7JBUEO?=
 =?us-ascii?Q?PHjKo8XjZtlpwYUfkCNnNgS8zSPStLK4AyraSWmeYDAH7JUBFEknBAPf2Kbc?=
 =?us-ascii?Q?DA+qIhUJ5Uey5rQrib4SX2dHLU/g5kZGii3Qy0L68ByYUYIYNHW0ms98AaZA?=
 =?us-ascii?Q?iRdYWyyV9XaAljsXCNVy1XX7YjZ7t7acBnAzb05RVAjE0NjDXqqFwXsX+Pme?=
 =?us-ascii?Q?oDylXkmTCE7wLEQGgZChIK3iai24IUBO2nR5Vrl574/fb+chEe74SSBeHN+b?=
 =?us-ascii?Q?wyonYmKbKg1N4K5hxUWsY6dICT81XhuJM/huupGOOdcJz3BpMouL77dGjWF4?=
 =?us-ascii?Q?2Lm1eWVgQGiiDTSiIjUfPaG+VpC2gNluiPgCFb2vkqMRSXq8PBNFMBGpgpc0?=
 =?us-ascii?Q?V9S/tyFrlpawN0UYjxQ48dRoZXeFWoXxFGPbHa289VkNI7ivXqgWjKSHtvha?=
 =?us-ascii?Q?yk6iUJme8sxF/hcawb5r7xZLhsOd0ZsgMnawyOcjAYrntJmFZ9+LIww4GdtO?=
 =?us-ascii?Q?EqTI/JMdYEvc6MtkiINwvlc/RelkGWiDuHGKh4fUrKBaX06pCN9jT6XbAu0/?=
 =?us-ascii?Q?kX9fta+CQX8yI5wwoPPKF7JF+8qwyhQOIF4G8Hfrtg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a89b0cc-6fe8-4e04-26a9-08db266f460b
X-MS-Exchange-CrossTenant-AuthSource: PAVP195MB2261.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 22:39:16.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1642
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ge-org Brohammer <gbrohammer@outlook.com>

This model requires an additional detection quirk to
enable the internal microphone.

Tried to use git send-email this time.

Signed-off-by: Ge-org Brohammer <gbrohammer@outlook.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360..0acdf0156f07 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -269,6 +269,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A22"),
+		}
+	},
 	{}
 };
 
-- 
2.37.2

