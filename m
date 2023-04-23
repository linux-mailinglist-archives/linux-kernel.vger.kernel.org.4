Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB76EBF01
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDWLDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDWLDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:03:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2037.outbound.protection.outlook.com [40.92.52.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A43F10DB;
        Sun, 23 Apr 2023 04:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJvJftYG+4sgWb6sHix7+oX15pplY5L8IA3oyFwTtJcjjkN8TaFwhQHWCwjTReqC6T6JRW1AzkdDifP+JDn+o15yj0rrMekSdUrsQxVSigrXnEMFzZ8z5Z1M2kDYtHsTnLPjF+qLtAfS4/3a2B/zAOE+aj09ll5spfktYJNr/OgDaJu9ljz0zrRWlfwU5S1NYX+VG1tX8PAl2MrRufK9bmhIXYGfs6isPEvbBHk4g2WUqrZjqd698XahmTSe1GMEyBBy6HUNdjyFexi0reU0vOhA6oN+Ci4YI6blB6Qbjq1MPfFCNL93d3J5dAm9x8Xbp23RMvNCAG0JORxv2j9hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cd61zKD5M1u+h+Fb84FHcOWxRBKGnWR/DPdIkKnoLfM=;
 b=Qor8cnN7csbjhATU7t5im5GFnf8XeggXGzv+SzkpeURln1wPP7YWhnhRQbHPSZ5+lHQ97NJMlSgqHf34bCMJM/zk9MLpsrO1PiH8P3QTCO/BC2TAAH+T7lOe019od18qtB4DHcJVp3d4+yP6/xmeWHjhutDd8naaY0/kXwxtQTdxN4t3DofgDm7hs60mkAgQRZJ602lr88BPynpGzxLcFHRvYfY3KoLSV2ttcNau6vr86Rd11nbCpN+jFmbjiOfiTzyBGX6un3Bzdzot2bgKxC/NgO/5KMPP3UwhlotVGeiw+W5Arg9Ze3QqjF300LklO6pXrao6sbQ7pfUlsaP79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cd61zKD5M1u+h+Fb84FHcOWxRBKGnWR/DPdIkKnoLfM=;
 b=SiGZInJPFzgciFBIP9fm461KGVuDr7/1ayVrVl2vOd5xGh9nn+xAx7HyAFvbHStLh/Si58ITITwGy9enpNF/ltypnSG0hI1u4Kz3zD9+WOOpww8WmX3S+4uksW3K0M5P6igWTV3EG8gpixLSSrY5AbtwZ4UOIfyrMZmMbZVifUlifArH8SObCCVlfBw6zTomEK2W2oO8gIc/cqlKb2T9kf/ioNtFjfTFaSCUgxhKNoXbTZaxbMMO2jWsjevk+D20h5s37hHRtm2e9q02GBeghhWkmD7dYIXb1G8xW4rC6S6gUm23nTDKanX1HF9CI79G5pmI8289PMjhWSTVmdQUSA==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by TYSPR01MB5471.apcprd01.prod.exchangelabs.com
 (2603:1096:400:40f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.18; Sun, 23 Apr
 2023 11:03:34 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::5bff:fd7e:ec7c:e9d3%5]) with mapi id 15.20.6340.018; Sun, 23 Apr 2023
 11:03:34 +0000
From:   Yan Wang <rk.code@outlook.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     Yan Wang <rk.code@outlook.com>,
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] gpio: gpiolib: clear the array_info's memory space
Date:   Sun, 23 Apr 2023 19:03:12 +0800
Message-ID: <KL1PR01MB54489B7A3D9D02D242B4BDA1E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-TMN:  [LyQ4LH6PMIy4ErKKWYgZHa/jlPRo9XuU/ivjybGPzQY=]
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To KL1PR01MB5448.apcprd01.prod.exchangelabs.com (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <20230423110312.8319-1-rk.code@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|TYSPR01MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: 723e6fcf-b07c-4b26-76ba-08db43ea61d8
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKx/5wRYKwbtF7hqq2E99L18eMaQIMe6A5F76rBXiU/m8RnMihKHrMbIH/sdtFJTp9unjrHFiV8KdEeO/E13IjSpPX2iIS/Re84yS2/Fsf63xDRh78kAFVXCw6kXKA32UUfDnqy7kLW0yL0lR2nzcyWTWUjpuRYwYxQ6FCL/fohmWAjIaQHpuj4II7qdST1AITc3Z6y0WnfUCLEiR0/wRKfxlR8Kk7mQo8fxhM+g5lwvg+UchjJMBE61VuWKwoSRcn+af1P1ylQerChMNYJP8lDUXQqEqtURnJ+j2wk2qS3r0suMP+ebJ9lD2IiQCRdMFiT6uvnNpoZAnwtMkaOvUnUfAHMQEkl18+TQbQ6KB8SHA8kiPLvqFLysvZqiLnF6ja4B63+Da0Gb7jHIElZlcGzIepyYbJu0i3bckdiIJFjMmAfEBoPND7zKHFkdOXZr+Yo91BzaEBa8chk+ktvgSIrU4B2XnUX/Ytp2x/1K5xY3kgYnlzsG7ZuyQpX1Ji70cKt8odM6N8waZeV7LBuPTYoVCav5nLWQtLu5bPzaz5zzX7n5ZWxEMsxNjqM0QTZb9w1NnJhMtJa+wF5W/jj6hCOkYFGFTXUnFUxGce8X4uh0Qx6KGRTGy7RX4JguimWExfg+iNvKjmRiekvGgy7bdw24vfDs6pbjUchdL7KA31oXr97VByVw9UtG/LJgvxbONPbPTBAuooQWpHkLx0gOtnLGBDhJ0jWfpFw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXXLVYoVQoibXvegwSzj9hGqwZbTa8zE4EK2KrUKJS4oByCs5dAZBCpIM8bS/T1LB4bRSISnsnaMsglHhEYr3K1TrUADK67v9VPkZHSyT95zaiLWaXcpSq+/3+NvncsUMQQei/c0Ay5T5tK88HM/d1zO0serRMxntm1pwywhD+IAXXom3swACg6XlOlF1FtxbAL/6aOaBkq1fgtZB2dMAqo5XqlMNuNlYtymXb3xZOKWDlR1exnmTjmX7sbri4l1NwX3u1GXuy3HSN9nKY3gmptGiMYl+NsX2Xukwn/8njQosrbUixq/1rDl2W07BBX8JpICxAiBe7FgToh36fX7oshiuXkkN5xJ954vi1cUV/SFrZ/sTLH+MT4nMntdPvt5QMFi37g7+pbXg7AT2kyCTL/vF1+4s5ZKAEO7yB6BMX/vs6p5+IWpYuXOXM5BJAMbO7dyKoLv2rEcrEOLAq0UBwSDL0m1xFppmUz9lYbbmycOLnEHYWE46JveWq3CGWkTj9IyEp90SSDRx9Hmus9WbOXKP00oWNaavKA+pBgzZVgdIIZcT4OceFKBhO45h5/zOKRqbY2wUNxR/LGoCDDJzFY0y27AB5mxXUD+pz+yM2bpHWGeYqxB91hjyBsOdA56
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BWvyrqjN11EnPi2lEg/DaVUyAaHTCQUyJn2j7NXGhsY5U2Kea9m03MI4gA0G?=
 =?us-ascii?Q?c+omH9f8Zl8F2OlLBxOAcmcab6I+8azb8YFTdi9dEqj4qz7caC9iAe60DWwX?=
 =?us-ascii?Q?uJnNnofY/l6Qf4JT+nW8qgOQwe7JkHi35CUPthMrqnYYQ3vvxgj3prK76VyX?=
 =?us-ascii?Q?wpcJpIotWnLdoF/uu6AA7x3Nh7yVLdOwPsB6XtpimXEczR8tv28LbG5do0S9?=
 =?us-ascii?Q?1Nj3L+VMqJceqVRt/NzTebqEkviMqzf9nLYsFwEW1mFIyeuUXzTpamLd+BKB?=
 =?us-ascii?Q?pHu49pSofXD8gJL6XniZS5KXASC/YVNEt7s82XXkSYFUccAwHwxe1A84BatE?=
 =?us-ascii?Q?4UP8sU187IQKPvTcmazk0xW6wTpC5l709+cKIrev81//aF5JpPMBQfFuLhw9?=
 =?us-ascii?Q?JVW3NBJeXb3jq8OLbtwYH0bRK/7c0WKFE7O3xQIjIeTsZIvwNmABpFL5jGoV?=
 =?us-ascii?Q?JzXi1WYe/Dx2mLQvOwc9r1FxlP7eyRw6vWmzXxcBfMXE3S968o1apkBNDnGL?=
 =?us-ascii?Q?yAoEPwEtWbh+1B9I9J/u6DvNjTd5P901fKfJFIXVvwZ7YdEATKvtGouk4hZV?=
 =?us-ascii?Q?l9dpaO17jYMFJ1qJOQQwpqlmUmWXaaYMvGWA7XPo77eNK04FEgvTh+PR6w7u?=
 =?us-ascii?Q?eEsFH2cR/RBXtkY1ixSLcm9v9Kc+4tIfNx7TUgW6hduSipyBuf+pOKvQIW2L?=
 =?us-ascii?Q?9Jb1YsVmOnx7WFC4tG5KVChfMXTcyKc1makC6VRi+jisMwNOAGeHcuBzSXZ7?=
 =?us-ascii?Q?Hsa1fLc8DFVLeZGTGoFnjPimd9fBZvLrAXljF5wULv6KM1kvEuqRIz8af7Sr?=
 =?us-ascii?Q?mPcmozMklNQcAsy3FL9EIDxq1WQO+EYhagpWcEI104+3VsRkxTAOWga3ICIt?=
 =?us-ascii?Q?I7HAbziA/eyS/GDhqaRkOFYPG0TFqq2o8AVCgl+C8XsuF/CO10HzuV5xt2lI?=
 =?us-ascii?Q?82pu1qXsZ664Nx1wgSF8j7jUDxY8a+xbqXcgIQbodn6p3wXv5zFPUVe0p62O?=
 =?us-ascii?Q?ggYuVIoo5QlBE8tvxHcHYp+NRIZHy4UrBr3HkEIFHqL65xdbsmEjcC9JZDuD?=
 =?us-ascii?Q?JHbf+eN3xOYUQYBVuTnGl8ZBBi6kixCV3hw4Sbnmz1ewcr5VtbqyZqm9Yv9Y?=
 =?us-ascii?Q?yi67NhdMeytoAlwfUzPeNW1XDgch/gTflf75KRgeET/F1mFrlESOKybdsZa4?=
 =?us-ascii?Q?lGKpbGzFPrS1GtaCLOITDkkeueR+PuCBNjHZ6Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723e6fcf-b07c-4b26-76ba-08db43ea61d8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 11:03:34.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR01MB5471
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if hardware number different to array index,it needs to clear to points
memory space if the array_info have been assigned a value.

Signed-off-by: Yan Wang <rk.code@outlook.com>
---
 drivers/gpio/gpiolib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 04fb05df805b..cdaffcdd45b2 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4340,8 +4340,11 @@ struct gpio_descs *__must_check gpiod_get_array(struct device *dev,
 		}
 
 		/* If there is no cache for fast bitmap processing path, continue */
-		if (!array_info)
+		if (!array_info) {
+			/*clear descs->info*/
+			memset(array_info, 0, sizeof(struct gpio_array));
 			continue;
+		}
 
 		/* Unmark array members which don't belong to the 'fast' chip */
 		if (array_info->chip != gc) {
-- 
2.17.1

