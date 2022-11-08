Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473746208AE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiKHFBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiKHFAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:00:53 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309926ED;
        Mon,  7 Nov 2022 21:00:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCzYCn4fs9OUzd74DxNYvnZv/s1Pb0IyQV2QLeai2XOaRpmZLK2CcPI50GJl2tvFUK/ddH+ysPDEq5FAN3oa+NYPJeju0iKcW+9EVeO4/1qoSdc4T80rlk58ZbNdn8tBGiakIXfBSUjIFx+g+y2bV8tFdio40yWV5ccsZ6VvJ4fpyLW55ukNcVK/+HK+0bY+IFc6fHnDzu+yD1TRtgxTEfwLhCNaGL1CvmZRmUEAVWtLjYWqMStgiEhxqwyn0Ej2Ie7NdElWpEc77jwwTiNnUmSwEn7uFshcK3j/uFJ2FiqvsiV+LEDDg8QOV2fds3WSblhBmbHzObIbyIzBegBytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwoecyA6nfM2pTprTeqU0eUBVNOmadX4DEObW7GmXQs=;
 b=nMxGpSpj6du2/jJz31AxkkAWXPAazybANZplSZY67+CW1i5ZpIz9YFf+lzIT07J9HqGNUx0YbmISYkbbLn8y/o+W3JsANj57NpSj2UBGY1hHGoyK3DvuUjdsUDFUiYvOoqYTEOZ8bF0lZtY0JmnvdM+jN3O6SRL5NxezhvEKhUN4LaeIEOL4MNH3zYoXOsmGP5F+40fmQJFeUcegM7ge9Sbpes6KrR6Ag7fVhEw9zaLVJvZ0SwzNfOvuvlcfr4anhDGJxP5ktm7wvW7/96D89osKCrasx6RNH251d6P1WPU6UDr89yATrqVs3lcI8paP8Rlbp2gslITrq5V2VvEVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwoecyA6nfM2pTprTeqU0eUBVNOmadX4DEObW7GmXQs=;
 b=s6Nhf1XW/fajkJxiq4/mydI9BLdyAykJkbw+PHake1u5rXOlpAjVJuJQMaMhSBZnhmev4rzxahawEX+WUh7YURXBHsMONu9r1/qv4QAwNj+KFzOnpqyKnpOFJp+/uHvWkHCNJPJz7cbfdDRC4orMJTl1xR248cu6hEWc2mjiUfO9I+Ju/BKQ5mQn5/6Zv3VCB0Kd8/2DzU9MeJ8ilmnrg70/7U7wqgo0rG658thzCTo2uDdFYP4ZhOjMN7hSuW7qlN78G9OL3wSQ8cN9CBkzRvpIUdKzZYKpiTGbl/wjKXjYA4zK4/YehmqKClNh+GZ36adGX4YGWasN3g1u423pbQ==
Received: from BN9PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:fb::10)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 05:00:49 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::17) by BN9PR03CA0035.outlook.office365.com
 (2603:10b6:408:fb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Tue, 8 Nov 2022 05:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Tue, 8 Nov 2022 05:00:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 21:00:34 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 21:00:33 -0800
Received: from nmalwade-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 21:00:32 -0800
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     <nmalwade@nvidia.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <nicolinc@nvidia.com>, <rkasirajan@nvidia.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] ina3221: correct the update_interval value
Date:   Tue, 8 Nov 2022 13:00:29 +0800
Message-ID: <20221108050029.24576-1-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ceb3794-2a15-41f0-c2e2-08dac146344e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzFgEPEBGEGB+NRK4WClRUALLeki3SDU/SY6+3lEqeF1t1D/nHLXrF8oTSJLMZTsPzdTVfLH1HaYJMFzs5PTT1nJ5SCcb0DTgpQLta+9pLY/QUos+W9ynrqvWDvAD9RZ/URngDinSudlsCQTVRjGG7ogUn2NUdNuYYsR8flSm6Sq8A/3HyQO7CMato70TX4puLQZRdNgAJkTFgqmSQaiqah9LyCM4L6K+jGPUVaKerO8Ua1zUUQQY4H5n1l1VvG/wgErSfMw4sX5sjL25XSOW696e4N8NkonRCfedGDQikbJnMXKo1LkkSVcJ1gxQghoMZ857VQrOl127c33EbZKpzT2VZM3TU6GPyXYOjmn4tGWZO2jHDi7GvPCRSuVlZi1/hdFM4gFS+Kn4mZ7ymC9Ub9i6i/mDqemQpQae5+RB+aWMp2GwlESQpQYibVJHxN+9WaNqb9HRbDwOhyrvPwoztEyX3ECJ9EoGDuTlY//Kw4xS9Ks2DXWBgw82Z8L49XudbYsGXKOprOo/zNJwbLGBNkbWqZGIeKwXZi03AVLXpMGWxREIh+oUPOvEuYygqvUBHkwNDOYnFDgIDQDrghdVlPdZXgAl1XTgutACMENIai2oxwe3Qxqfx5f11uli3g9xp/gPkydsKwkYvJtSFU0oBUVvOJ8wNdniWcEp3+OqbsdvchK7mT7dmQ7MRwt8BL3r8PW607JU5aXLC6QxPSmVSodsFe62PgTMbxmuvf4EY2xYSGR5lCFfI4SCUwn89bDXvpUmAWkF6p8Wwp7LK0mgQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(356005)(7636003)(36860700001)(41300700001)(86362001)(82310400005)(40480700001)(40460700003)(36756003)(8676002)(70206006)(4326008)(26005)(70586007)(186003)(7696005)(336012)(15650500001)(2616005)(8936002)(6636002)(1076003)(54906003)(478600001)(110136005)(5660300002)(82740400003)(6666004)(316002)(426003)(2906002)(83380400001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 05:00:49.3763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceb3794-2a15-41f0-c2e2-08dac146344e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the INA3221 datasheet the samples value should not be
considered while calculating the update_interval value.
Section 8.4.2.2 from datasheet says - "The conversion-time
settings, along with the programmable-averaging mode, enable
the INA3221 to optimize available timing requirements in a given
application. For example, if a system requires data to be read
every 2 ms with all three channels monitored, configure the INA3221
with the conversion times for the shunt- and bus-voltage
measurements set to 332 μs"

As per above only conversion time and number of channels are
required to set the update_interval value. Correcting the same in
the driver.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 Documentation/hwmon/ina3221.rst | 3 +--
 drivers/hwmon/ina3221.c         | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/ina3221.rst b/Documentation/hwmon/ina3221.rst
index 8c12c54d2c24..a4f107d1e489 100644
--- a/Documentation/hwmon/ina3221.rst
+++ b/Documentation/hwmon/ina3221.rst
@@ -61,10 +61,9 @@ samples                 Number of samples using in the averaging mode.
 
 update_interval         Data conversion time in millisecond, following:
 
-                          update_interval = C x S x (BC + SC)
+                          update_interval = C x (BC + SC)
 
                           * C:	number of enabled channels
-                          * S:	number of samples
                           * BC:	bus-voltage conversion time in millisecond
                           * SC:	shunt-voltage conversion time in millisecond
 
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index 2a57f4b60c29..e3aa57e3b039 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -183,11 +183,9 @@ static const int ina3221_avg_samples[] = {
 static inline u32 ina3221_interval_ms_to_conv_time(u16 config, int interval)
 {
 	u32 channels = hweight16(config & INA3221_CONFIG_CHs_EN_MASK);
-	u32 samples_idx = INA3221_CONFIG_AVG(config);
-	u32 samples = ina3221_avg_samples[samples_idx];
 
 	/* Bisect the result to Bus and Shunt conversion times */
-	return DIV_ROUND_CLOSEST(interval * 1000 / 2, channels * samples);
+	return DIV_ROUND_CLOSEST(interval / 2, channels);
 }
 
 /* Converting CONFIG register value to update_interval in usec */
-- 
2.17.1

