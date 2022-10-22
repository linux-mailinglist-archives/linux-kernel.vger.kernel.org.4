Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB1608F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJVT2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:28:28 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF801D8F7D;
        Sat, 22 Oct 2022 12:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQKFc7gi1j8/U23814QvOYr9TN+gBHdXl2T1OkFFVBNjMj2IkkqDKKEz8moC9ndIoII9xz2C4IB+D+Dtlq9kpkZh7bMe3dEZueOCMCHTxqadqspbGLCeSg9EmxElj0uAjvglkyJeaG3Y2AKi2c8FDVWDbRFT9iTZiOdNNBYZdZE6vHzXt1K4QvGgUuxYjUh18JYLKhbRrWebaiPAsfDx1saMDvBDrDHaNKUM9O7N2DzYeWOqVAx23BCH2UYOSA6IO0KzQ44jnxWifEG78FumtgZKPA3v30/N/w0APTUK+mObhtnA1I3t1DMPONFBc9ARNW9n5qDZYMNF8Pkdl2PdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=cshcZwNVDBsTFYciqx3J2md66KMxfE48/SN3kez69XNHG8Y6MiV0T/POW5wsAok5hTJsmivQUzR2ucNEvz7L/EGbt5aketCbh6pEQ1vqV3MMh3AVClk4Z14glaTFMdGHUfLdqA5my8179Mh49L4jJoj3VLecWVuy1IOnjqS3jdFkVy7h7CrWVPgTTcBWHbS/JPgDlu9TiURec3yimCFYGQ9BXXLXs9R7olItQP8n2pH1UImBUV3pJr5KeAm27sA/SlZagnDjXVTcq6+HLTNLBHwGU8m2iLb3lJlig/LcYAY2ZluVNoyC0KNniRvkfkH5UMgVaX/uhnkWWu6eNZKdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7TV2Yh0je6pVVsH3QCx59DI87he9aJmHrnfel1EOxE=;
 b=YazVJVMKNxqmJWlJJhAqKjG3E61LFaf4qrTpV4nAmrIV4hhkm6EsUL0JfkTh4zLS0w0uPMzmB+IH6IeppjkvcN35Ji+cxvqvME6mYr8zQdu0mZwF81WqU4znSIIdnZo0SEFSadlzhsWPUd0gQu1LPZDue2kTv+Fo67jLWrU4ZdOQPSLVNBHuhWB7L0pyLoHbHagRZ8jRRUeLwpIyjS+4mLQ+SRW+wlc3AE+ta3SegKKYXqCdLOa5hqnLyvpNomW1lPrM6Ox9q2i/ixyqXxYBX0XMT9ClI48Te56sr/VGQfrtI7EB4Z09EOIWo6aW7jq9M2BUtkpFoePEWu3kmOmhXg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYWP286MB2369.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:16a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sat, 22 Oct
 2022 19:28:24 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4de9:f94b:b58f:948f]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4de9:f94b:b58f:948f%6]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 19:28:24 +0000
From:   Shengyu Qu <wiagn233@outlook.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shengyu Qu <wiagn233@outlook.com>
Subject: [RESEND PATCH v3] Bluetooth: btusb: Add more device IDs for WCN6855
Date:   Sun, 23 Oct 2022 03:25:19 +0800
Message-ID: <TY3P286MB2611D3672C5664AB862E10E8982C9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [JLgY3ruC6qe5DKEz5ysknfBrzQtCEfJU]
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <20221022192517.173-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB2369:EE_
X-MS-Office365-Filtering-Correlation-Id: 96908c36-3bec-4394-75fc-08dab4639573
X-MS-Exchange-SLBlob-MailProps: 7J/vb0KDx3iHFoU7Sqe6xPc744zn6sl7i1OqWmqZ/H2zZJd7SQifZ9ONM1T/AYlwL3FexETxA+wNsMPiXFO5vOsDUx5a1A+V15kNqezwaAzZ9tn057gbcr480iPrlQIIn8FFcbMvsFt2pGmLpjPjyywfwac095W06ehCxforeopEUVxgkVxyxN0Fxjqjgyq2zn3G9R1rJZf+rMPu6sfxs0XfWR+H3inpD0ZAYw3rvwYNSK0LgkUAfkhPqcgQZKYe9/hoSQ6QdaJtZZwvCE5F+zmeBMLpYgoxmR2R4NIL4ocpDCSn+5yF3wZ/7ZUoLssXOXMJGiNc1XKvGQu4azSPfzJtiRhCyH1uiLK2dBDMHC/VziDd5bGMLBzZEgYhuKxhQdpp5JBVbemCBcSA/3heZmSQ60tQHvoB8OAuwCRcdFG/sGw0DQ+eUaWtnVWcJeb8Zc1h8Lz8LNQpSPvKDWmJ7ICMje1cQEVi4QMPiwh0R77xeN6WfZBLcSqru4Q+zkc2+LEolhhjdewJkShQxUoar7VKSdBWRDDRb1xSrkBNqDpa5TbWE4LbJTZtss1/7FUFFre0Zrojfj+blgWxYshvEwDzQDoTeLuY8BxTZjEbAJ7G8RXbn2ML0G/8b6fLZUslXSP3jEh1re5R03lMhefbzcW5DhegEutG2ihhwNvtUpgz4/R+f7ZNoFT3VZi7h4aB9DuGyEOzj6xOjw7BgzWYLwrzfsQRu4B1u2uP5AJuIW6p3ukCnaccHlOZJZrmz65HVpa+s5ifQ1m/ZMZ9sqqLpF+aM/qjC8D7GZbaY8cGfpE=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHBLXkFQYE3gh1V+0uRm2/Mvdjm4PPqtZIFMk+TGtztCdY9KTeUvx3IdP41cPlQ0C8G2JqunJdX6SUMxPkBUWAqW5z7L+dUKK0B1Ifl7v9xdYhZyPhTXcO4LbIJQOmLWTl23+bCM4M+WAk2oRRZeThaikymGqGKjls9mfxtI1h/ftMruHHjMI2Poup+bSBAamzWy4LXFSuErNXCXM3+gOf8yXf4sGBt8vBwqR8javxHxG7+g1FuMgrLvk1K9AY1waionw0E/FdK/HMrAjWMQUAUeGBMWsqRil7f0lbu7jMWTTtPkn4kszLR1kZuvaz3DoP6URHt2rv9S8TiEVE6zO/qH/M7/sqWYuZ6mCORY1T9qXJM/mFbFZIAUzXlM0gmjlx2uLoBbYkHHvzWp0tUD/9afX7mQRPO5XE97LRKWKCs0Xn4acGJeEdsYBCgd8qPZH/RkFfPampnRIMNUIM/w0ymaVqNbOlPstGzDZDwNQSs0fnJXN4hY1JNIfifR+aO+cwoBl7eXwHCMBNXS60jAHehCjVfTQhSW3QZokVQg71l8uAIBvH/RpZ481MhElL9iuJZUG1w679MO6oSjGsn2rKmB84j3jxiFE16Wd6Q5gIHdp6G1+pDo6vqQlCUAhzECW00COWjCmsdGHFd3oR2MARnEyeKfLSaG0ky/lYsN4Hp/6HthMyLTDPbTScyZ0AqP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoL0u8rLbihAswCVNeBzLn3pJXxUvkaUlZ6jPlIBugAWd8aQiCLW1QLAHDus?=
 =?us-ascii?Q?cZgLdmiJGVYQDVd4bFcN0+mUW49DDCYAk8AOtT85c8aSLa07O1sW6vCOwn9o?=
 =?us-ascii?Q?1at0a0TvLBJ7iZnDhmGILPAHRCdIj4EhBTSLEL9Cc3BIYs+Pma3GN+UqVB+j?=
 =?us-ascii?Q?KfhUltlexK+RF91QlyPmhJVoQPC9DfERpJgVeR4uVNwPtPhlvKchWWgEJEVc?=
 =?us-ascii?Q?7q7fFpFbkBqTQgTh/8zK0ALpo3tzlWeDMDAhhw1IYC3H8f8PJ8NDMSv5ojuW?=
 =?us-ascii?Q?LczyxEQvfZlfWsWM7jf4RQTopMs3cO1tFHYo2KMg0C50/UPEu5GbDAmDyY2g?=
 =?us-ascii?Q?2/tZQvONrzmKkjNEMpDWuRpKasscOEsNJ9/AYKeqTiZfg5oeiVEA+zXOeGOC?=
 =?us-ascii?Q?YqWpfJO7jl+mFHcgugrRcSfTOszu+g+PWgyiHw/5gr151DOp2UC81og5Y5kk?=
 =?us-ascii?Q?lmlRXmEOCadk67cklgpdJzfegUIP7ZA2gUY7tq6/mLDc3kAlpPax+Xj89HV/?=
 =?us-ascii?Q?l8dIEnO16xMabNpzH9juvaTJw4IrWhjiwuDzq5S3K6I0F1UBCCexh23X3Wj1?=
 =?us-ascii?Q?iGpktLhsNz0fFyeS8Hm1rlpILfabQlV4bQk7PMFtTUkLWePiguuajwEbxLDT?=
 =?us-ascii?Q?1gAxBCaNG8k13ORBXSPfDS59QnVVwqX1YQpVWSuXaGttnttXTkiKGQhga2fi?=
 =?us-ascii?Q?wQqYdfYoZnTwENuGc3J7zN7Ph6nSQ+oHMXIo3lYd8TqolIS1YLs5386yXrZR?=
 =?us-ascii?Q?i4CHfRDJZQ8mICMin+DERY2SwU+waFxuJgQLc/iBiiQphPlVtVNfFmp15U7y?=
 =?us-ascii?Q?VlCOYnrQDKVz3kCETXlVZ0n2Whnbyqs4+9OSpNHA9ZnEH37RwHNsEwh8TMzH?=
 =?us-ascii?Q?N+eSmRAPg792D11GOvhwCVFuIsat442lfbQ+4sH6qtg17IA/l6h3I3cntrEL?=
 =?us-ascii?Q?0N2GNkOd3a8nAOmzpXF/1/ytV9rKvpax8PS6HWCrDozWbApPUVqcEn7aLSN1?=
 =?us-ascii?Q?dgTRG30LvBBjJs3yh0fFXUAe6730SG/cq/KkTACpuzuwDnz/9jULi5HYlHj2?=
 =?us-ascii?Q?TwRaceKJcOJdMpKvzW1BTvAPwyAF8lQI1n8ZBCAt+D7rYmKljsYv41Kuu1aw?=
 =?us-ascii?Q?p+lM29oq7EeEokauuFfy14j2RdJ+y9NX/15ex2M4lMW6iwqys91t1whSOtWi?=
 =?us-ascii?Q?NOO1YkchWppA42iXGJFmRehk2aFrckSNyQc9vcqgI/KjISYXf5HEExUj2mEc?=
 =?us-ascii?Q?tUKDMLO6Dvhbebc2hvI2oVXxHWx7s2zp7te2pOfj/w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96908c36-3bec-4394-75fc-08dab4639573
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 19:28:24.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2369
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IDs to usb_device_id table for WCN6855. IDs are extracted from Windows
driver of Lenovo Thinkpad T14 Gen 2(Driver version 1.0.0.1205 Windows 10)

Windows driver download address:
https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/
thinkpad-t-series-laptops/thinkpad-t14-gen-2-type-20xk-20xl/downloads
/driver-list/

Changes in v3:
- Fix too long address for windows driver

Changes in v2:
- Reflow commit massage line width
- Add driver version and download link

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 drivers/bluetooth/btusb.c | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 15caa6469538..adf68affaead 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -316,6 +316,90 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d0), .driver_info = BTUSB_QCA_WCN6855 |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9108), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9109), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9208), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9209), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9308), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9408), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9508), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9509), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9608), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9609), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x10ab, 0x9f09), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3022), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c7), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0c9), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ca), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0cb), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ce), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0de), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0df), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0e1), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ea), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0ec), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3023), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3024), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a22), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a24), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a26), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x04ca, 0x3a27), .driver_info = BTUSB_QCA_WCN6855 |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* QCA WCN785x chipset */
 	{ USB_DEVICE(0x0cf3, 0xe700), .driver_info = BTUSB_QCA_WCN6855 |
-- 
2.25.1

