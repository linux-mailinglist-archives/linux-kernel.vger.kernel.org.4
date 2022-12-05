Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D729642B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLEPJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiLEPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:09:13 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on20704.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1b::704])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DBE0BE;
        Mon,  5 Dec 2022 07:09:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG+C73ufPWXJZ+kYUBe74eJDl7D7h1jUJOrjBo90JSAY3UJoCGI4A9OLvZu+R5wYaOGt0fFxTIUl8JE4rI08tePxWqvz//exenIBIdoIinEswByvFj9Bkoq4AJDDX0u7APjtWc60W7tbKJmt9RDl5nBh+G6DPelaj7D/qSh0qyP1RKupyNFK0oZDGctIAyRbm6JynJduSgh6m+rIE4USvvx7G9rvIK4eKQN5tP0m1YX1ANBjx88J1iwaWRY0egRCsGvqllZhfeAxfdA2g9WZLtCS6kCDatgaAHzdaWp+yMR5va4V8xUPA1ba8fmt9/V/VrwjDzmMpIE5M8h3DewUCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt/zxoipX+Z1pGyu20P8hiWbQXy68nP1aQ700dw9Fro=;
 b=ELbVixvujMQvQI5KqVKt8hTLD5G3XwU0TdDkTbtglHvZg/fPYaUUy8n/xekOCbjCwJezuEKNF87e2RSZK2XtACS+O3skV1GWIjeZFUStqp7j3iu9qqkPWErVXFr9k9rStrs34TNhgsNTSJGSxTG3v1LYI3LAZXB6/OzrqKeDSYol3JdU74DxduffuNHzUxe5vpx4hNxtGQnQz2ZOuERqEvpNT7+RsFGNAYSlZSXthk58EKG9jaQa++pFfXw1lSvu70qKV7zk4FSNgxB+22Y0pEfzxwxjEvkIaGhSWZr4HhEIdsbkmN2MSIeXLBenZivD/zvb2j8ntfQnkHVwdAN5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gpxbv.nl; dmarc=pass action=none header.from=gpxbv.nl;
 dkim=pass header.d=gpxbv.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpx.onmicrosoft.com;
 s=selector2-gpx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt/zxoipX+Z1pGyu20P8hiWbQXy68nP1aQ700dw9Fro=;
 b=oB2n5weDx91IOYyDsaOz14ABvP8TI7hB0RWVEXYLa6jt0lFTmHUkg5bvSwEcSEijjMnBPk5ThyPma2IQaJhWukO8F3HNdtSgAVWaQ+fmt1YJ2pSna3AiEE8/CIr0ZrRTczU9kKjEpFXQ5pEA5RLyI7wRkisSBJExR/ySV6RtCWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gpxbv.nl;
Received: from AM9P193MB1348.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:309::20)
 by AS8P193MB2399.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:442::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 15:09:05 +0000
Received: from AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 ([fe80::7379:848a:ac29:c305]) by AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 ([fe80::7379:848a:ac29:c305%6]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 15:09:05 +0000
From:   "Bart Groeneveld | GPX Solutions B.V" <bart@gpxbv.nl>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Bart Groeneveld | GPX Solutions B.V." <bart@gpxbv.nl>
Subject: [PATCH v2] acpi: allow usage of acpi_tad on HW-reduced platforms
Date:   Mon,  5 Dec 2022 16:08:46 +0100
Message-Id: <20221205150846.541281-1-bart@gpxbv.nl>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <CAJZ5v0hCa75oSXUsTyr5XWx6TftjwGA2qqzve3KO_YVh-Y3owQ@mail.gmail.com>
References: <CAJZ5v0hCa75oSXUsTyr5XWx6TftjwGA2qqzve3KO_YVh-Y3owQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::33) To AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:309::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1348:EE_|AS8P193MB2399:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a73eed-8f36-498c-00c0-08dad6d2a5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9f+9xXb8p1/Xg+pHV2GKHaV76Te2TtiTK8FC9EKK0FFBY8kjb1/6/5Wwh3V9FrGDNibdCbTui2+rHb3wfguuLpwTXKnvJebTGUmEAif/mzd4cpPy0XF+MtxpFqRCt7DL8qxmLeRmmOUstd7ikL+E/9BXvkTHg3c7G1xD7SjkNrPrYRTKKteuXe5yvy9KjeLwCXwRYwC9g2cJSinZRK0rOR4hqC4WMtZfaWMUACBOayLB7r9XytpzfZUbk/5lyerAIkZve+4H39sdcaQSJfkPjdXEu7L5ZX+YdauNP8DcBgw/UK9L7zkHELv+Vayd91bodRYZDtvpxvei2yBgXOIDblzzlGzVIDSZ+0T1zSU7QA3FXvfdnIKOi2iNf7gP7yFJAbq0eC8RhkvyJGB9unFkpk0zObDWxVBfNWeCbI9i7OS0NZlnwoKUuQotx9IXWNXMDPnqAJXFC8cY9qLIRckwu3GhGF9Bm1PO9CDEvgLEQtpNwICoe/jvyCN0f28iNEcmNw45ONnzdh1InS3K6eVgMqQyWlwDbOmxMC9QW/4u28peMEXsitPUX812mnNqOrTBvllr1TL/mGfbJub+giCYHlKLXYSiIoIn+bVRhIwxQSGQj+Zta3/P+udrUWIoZ4WnmpvbZoAHq4Mp1sbsdLwnnBTEdDhLP8KU+Z0r737FRE/x7z9pukFA8kSBquG43fM5bYhiWutB2ffKGKAqv9fmIY0SV6Xk9ld9p13x8pt+5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1348.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39830400003)(346002)(396003)(376002)(451199015)(83380400001)(38350700002)(38100700002)(5660300002)(41300700001)(2906002)(8936002)(4326008)(86362001)(8676002)(52116002)(6506007)(6512007)(186003)(26005)(107886003)(6666004)(1076003)(316002)(110136005)(2616005)(966005)(66946007)(66476007)(66556008)(6486002)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4fznMKWTRvJNI705hU5t0s94ajFkqsp495YlAcxRZ9LnNKdmwvUJdS7+0mqv?=
 =?us-ascii?Q?NU/eCdV/25N6JZhzZIvy0osM0p/fhkjFnOCAsVMNHzVXhNg989rSPDiUnTkF?=
 =?us-ascii?Q?QbzESixbCh80AunUz67kx3cBEg2OmAGxdRYh2sSn8Fol2ipS9pm0NgxBNIGt?=
 =?us-ascii?Q?eFNjglSJwJ89MgZhyjmU8ycaQh85vEtBPE1dNRA1hNI8JKpofqtyAAvJ9nW+?=
 =?us-ascii?Q?KILmEZaCecqUgZ8u/vu3reUGLEMELJ5XqxpjDR20bvR7R4oQv88XJL3v4P+s?=
 =?us-ascii?Q?wTUsTWPhAz/5yEUXFSTEN4CL5rYL/AMjXxM+cMzs4N4P+Q9WwlnFJkXtsV94?=
 =?us-ascii?Q?b9Yn8NoGD9jun9wLnpn0lG1fVnYAv99P51jGZpAqQYsODxq6Rq6UGWjswLHS?=
 =?us-ascii?Q?BAW+8HEHxOpnQfwr6lpWpwL26WVg1V/5uVGC6BD3oOEn3QwXa8KD8YSJNCYC?=
 =?us-ascii?Q?6YojGWomHIhVbbTnc0RBIl8ukoRgUrSqhrOuQam3v7k3HnjCJ4nL60hgJzg/?=
 =?us-ascii?Q?SIpCc5lD590ShzFJuwLRS5TtZY8OgiWG/xYuW+rkO/TS2pOT3BQwFz/rLq1Y?=
 =?us-ascii?Q?cTjS9qoC9QVcm+WDvBGLD7XiAV4rlycLFnYIMeD8j0UOnjcfAX2IIgg1hcs0?=
 =?us-ascii?Q?rU4Afkr9P/jCdBFht3uxXjy8gBauVErxmXewn/RCrXT59dWlhvEZkNBJgyy5?=
 =?us-ascii?Q?EWkG2cKzB4uSEa2N6g++1EnI7V0sSAiaI6cXsU9p4z19clH0XtiZZS2T/NH0?=
 =?us-ascii?Q?pe7IKbGyg3X4YUzHhlE1TldG+WulNAQUBaV2eMRRwiLcIWLH0Z61ymBT+WSQ?=
 =?us-ascii?Q?hBJNluRgB0v7hUT/MGP1Y0wLMjtB7GVPYHi3Y3Arnvj4xIsPZjWrgCmvATpO?=
 =?us-ascii?Q?BwKz1ewoATtSc3km2bh8Rtof8CuxM7DQAVzwggVq6PmHHCXUXn48HyDT8Mtg?=
 =?us-ascii?Q?R6otnB2PPuSiB0sCNSt8btnCNVTT9On9ahpxe4ZecJRB8GQmANEgDZ/2co9p?=
 =?us-ascii?Q?wuuMuQ3cLekV2rhY/F+nOcQNCa2iXUDZKXp4Xe7a/EmE/4CnbRtUyzkkHdCV?=
 =?us-ascii?Q?RckpSYQHfjKKX9Ie6zji0Qi3qGzr++Obu3cj3PAbY5pUIxiFohcghjndGlAX?=
 =?us-ascii?Q?zMyUyMUw/nufsPgHU8zY425J4Zu6aQGzKP4y3P0lluy1B0svTWLXRZ9k6L6K?=
 =?us-ascii?Q?xI9Czda2f3USbQF65mA60hBYcmQ4HDWau+QkjQzXMaX1+hXcZDJlR+EKCbOw?=
 =?us-ascii?Q?Wx3cRBCfLFKe3wd92JjS42hA0A4I+DRmC15xyEzC1PSNlNe6fec2ArLP5dUp?=
 =?us-ascii?Q?ZSaH6as0GEZNjS92af/qUWCxYJ4PLcOBWJCn5VmTUF9g2TIJ2Va76C0FCRsJ?=
 =?us-ascii?Q?GLj1Q6hF6HZOAjZlqcysy+8MeHoPxWfhdHyRCU05no9voZugIEZaYBJqE8ZO?=
 =?us-ascii?Q?SRowQcyD8wCS26/rX4NjPN5R7DWWSlk2ubCrJf0uAAO+TBOUJpkipw8d/Khq?=
 =?us-ascii?Q?NMQ7xhcp75U/od6uhKG6WHz+7OoJdqtV7Nc2bKr8w/mTs8FS1pUHtpu4Z45Y?=
 =?us-ascii?Q?LV2q/H84Zz6rXpqZsgE=3D?=
X-OriginatorOrg: gpxbv.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a73eed-8f36-498c-00c0-08dad6d2a5cd
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 15:09:05.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 96472e6e-8450-41c1-a7c5-ce4263c73b54
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKy5DtsU6TToBnAvFWaG2inU+MMJ/1+B8zoC8hqs5FcIMu5W5SN9oEik8KGJeILC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2399
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bart Groeneveld | GPX Solutions B.V." <bart@gpxbv.nl>

The specification [1] allows so-called HW-reduced platforms,
which do not implement everything, especially the wakeup related stuff.

In that case, it is still usable as a RTC. This is helpful for [2]
and [3], which is about a device with no other working RTC,
but it does have an HW-reduced TAD, which can be used as a RTC instead.

[1]: https://uefi.org/specs/ACPI/6.5/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#time-and-alarm-device
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=212313
[3]: https://github.com/linux-surface/linux-surface/issues/415

Signed-off-by: Bart Groeneveld | GPX Solutions B.V. <bart@gpxbv.nl>
---
 drivers/acpi/acpi_tad.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index e9b8e8305e23..944276934e7e 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -432,6 +432,14 @@ static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(caps);
 
+static struct attribute *acpi_tad_attrs[] = {
+	&dev_attr_caps.attr,
+	NULL,
+};
+static const struct attribute_group acpi_tad_attr_group = {
+	.attrs	= acpi_tad_attrs,
+};
+
 static ssize_t ac_alarm_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -480,15 +488,14 @@ static ssize_t ac_status_show(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RW(ac_status);
 
-static struct attribute *acpi_tad_attrs[] = {
-	&dev_attr_caps.attr,
+static struct attribute *acpi_tad_ac_attrs[] = {
 	&dev_attr_ac_alarm.attr,
 	&dev_attr_ac_policy.attr,
 	&dev_attr_ac_status.attr,
 	NULL,
 };
-static const struct attribute_group acpi_tad_attr_group = {
-	.attrs	= acpi_tad_attrs,
+static const struct attribute_group acpi_tad_ac_attr_group = {
+	.attrs	= acpi_tad_ac_attrs,
 };
 
 static ssize_t dc_alarm_store(struct device *dev, struct device_attribute *attr,
@@ -563,13 +570,18 @@ static int acpi_tad_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
+	if (dd->capabilities & ACPI_TAD_AC_WAKE)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_ac_attr_group);
+
 	if (dd->capabilities & ACPI_TAD_DC_WAKE)
 		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
 
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
-	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
-	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+	if (dd->capabilities & ACPI_TAD_AC_WAKE) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+	}
 	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
 		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
 		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
@@ -604,11 +616,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!acpi_has_method(handle, "_PRW")) {
-		dev_info(dev, "Missing _PRW\n");
-		return -ENODEV;
-	}
-
 	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
 	if (!dd)
 		return -ENOMEM;
@@ -637,6 +644,12 @@ static int acpi_tad_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	if (caps & ACPI_TAD_AC_WAKE) {
+		ret = sysfs_create_group(&dev->kobj, &acpi_tad_ac_attr_group);
+		if (ret)
+			goto fail;
+	}
+
 	if (caps & ACPI_TAD_DC_WAKE) {
 		ret = sysfs_create_group(&dev->kobj, &acpi_tad_dc_attr_group);
 		if (ret)
-- 
2.38.1

