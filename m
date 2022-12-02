Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC54640979
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiLBPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiLBPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:36:12 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2138.outbound.protection.outlook.com [40.107.7.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8342AB2C3;
        Fri,  2 Dec 2022 07:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ9sOQTk4ygyLza3SllShkXh29KzDyx9eoRykHl1S/8RCMDm7A/C4KQFCL7CYsW5qPAhTU/xyGdHPWZkAU7yPWcq3GchUdUdZQydZSP+MIItOutzhwguKn1mXXISpAteOli1aVRYgDQKTKBYdqo3cvsJfhdaDWMGk1tILGIlpQCI1lX4Don0hibVVy9Cue8X2ue8MDvtMjMUaz7KiMWE9IQiSpM7EwFE2vH0qtTVN3DMpyuNJHzZB+1F3ZRVb2HXTTKKOJZB6EVXsA9sGu7jXhdkEJG21J578WQtAXbQZXX1HrJXCj0fIfa5LncJ7br69DKOsAKJ86uw+T6XiKe9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qr8MIPGh0FfjbImNIllqUKgyKweNqKeUlwgy1qxUY4=;
 b=XRYCLCttxsbaEVlSaoeui/DX5hf+hEa71ZT5skiWSsAGjCsRJSY9sLLdYgKyNnJ4CBauFX4moW2PVwEewx0guXFQE5dvWWKkbLQEe8y5kCGqkj5rIVi5PcAi8gKxRsXJNrIftitMV+3Q6rNuGUVOZLtFI/1NJJwvpo5nTu4NRaROoZXbq9n7ooPOEjtiUSWGjjDi16JrmNszDMjjzpcIw0ydYDD1L77IKN8ZgSloD7s5qGuZ7NUr3jB0LOs23CGquMSQqQQDYQ0M45hEEud8ZWNwfBdkv8X1hSVGZT8diHUcSUZ6h7tNY83K0fiSMdR6gZl8pJyr3GKo7CrmfH14yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gpxbv.nl; dmarc=pass action=none header.from=gpxbv.nl;
 dkim=pass header.d=gpxbv.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpx.onmicrosoft.com;
 s=selector2-gpx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qr8MIPGh0FfjbImNIllqUKgyKweNqKeUlwgy1qxUY4=;
 b=gqLTGOscdRD62JuFDejeopWG+mCcA0Pvsb3arnTMi695mvI872z5HY7sJM8xwvdpRiVbb1zQKHM9iF5A56EjhylZky4n9+zMh1PuFd0camvCzc2zNLjs1tbkanKQhl0XxygqCq980IgOrxwBJ5TLMLoUlXr4wEqS3PBzAaiZ9ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gpxbv.nl;
Received: from AM9P193MB1348.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:309::20)
 by DBAP193MB0874.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 15:36:05 +0000
Received: from AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 ([fe80::7379:848a:ac29:c305]) by AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 ([fe80::7379:848a:ac29:c305%8]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 15:36:05 +0000
From:   "Bart Groeneveld | GPX Solutions B.V" <bart@gpxbv.nl>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Bart Groeneveld | GPX Solutions B.V." <bart@gpxbv.nl>
Subject: [PATCH] acpi: allow usage of acpi_tad without PRW
Date:   Fri,  2 Dec 2022 16:34:55 +0100
Message-Id: <20221202153454.83185-1-bart@gpxbv.nl>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:309::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1348:EE_|DBAP193MB0874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4d01b5-e914-42fc-0804-08dad47aed06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoBUoIyjGKEsFohSll9ie2nqb5bU0o1U0vOuqzxhUfg4TIPdrC6iiuZOt7LiPpPlm4N9XcPaVyjmZYTNEGFDi9cfsF4saVEcxqhB87RCWa9PGcOvOp4RLnCr7dstLax7X8j95wIev3F9igiJLLvkX1HjHwm51fTCbSIBFeWnN6aJ4h3w1NrWJhaaFsP8OFYemeFZF2clQ3L1F1euwh6ky0wBYeYuaBlcYwTwSs8G0lEV7elRPClCgWrIERH/eagIr1jB0/uQVYnkejGqgY8BH+7KNwUVnZZZGNLOSxL2zG9BoYPUxuii8tAPE2OO1L+eZ6ukZO7xSFhYUIzyeZJMNbNpPucbsMD4H2CYuwW07wm/qhw4jsAuhT9hmVLmxxbt7FqkoVV8264WyofsmqnlUVAbjy0cMHi8CJdGCoAHCzPeedgFxz6q67DFMq95x8f67bNioVjUIc8uvcAS1Anr9pSV830O9kXm9HDY4bQvv3rH1AclPSyNEPMxSyUKJRxdEJLuoQkJpXNiyDajQpQfNeE90HwrvLFXMn4oYaJA8SNVThtHsUqx6m5PyMDoyq9RcFEf3WDx1hA31XsxicJF/nY3Fk7X7XtcF1+EDZFiNDNZ21Ec9qFGtFo7eWYejlEB1nz55dgNUv1DSynNzBTQ2Mi99ThWwYpi3WoSrm099PS2ELZA2yg4dK4Wc/jihPE0mypI0ox3/k4Cb0HG7ZCRm7uGWjs32ANCr3Sk9u4gC1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1348.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(136003)(39830400003)(366004)(346002)(396003)(376002)(451199015)(36756003)(6512007)(52116002)(86362001)(6486002)(966005)(6506007)(110136005)(478600001)(6666004)(66556008)(26005)(41300700001)(107886003)(5660300002)(8936002)(2906002)(316002)(4326008)(8676002)(66946007)(66476007)(38100700002)(2616005)(38350700002)(1076003)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/zQCq22Z0eV81CXk/Af2nW/eKRwWWgzha9wUXjV2cD0nPX6QdeVZrLo/V8RR?=
 =?us-ascii?Q?BB+ZA/j1uMQyLP3V+DvKb4Z9qDVaDy0xMHI4BakRVz9t9BXc/MJJncJEvA00?=
 =?us-ascii?Q?KnfOuJatf60XcmOHDCDu4nF66T8Wy+qu6nsiNySsb7P82XrugDU1kRzCb/66?=
 =?us-ascii?Q?+SQOYAnASuErF6ntbRI23mPTjQV62/+q9gAiZ1ZQMNKzDaaVE+3hBYaqHMGi?=
 =?us-ascii?Q?3K0WZ83tJQ2NifAyb+yWBVGosJFH6k6H5uNva2hNWe+Zk2aJsUmexEch6MdY?=
 =?us-ascii?Q?2feYXbBWwNAueKXABWNy36NVzljbXPyE32JMzukgYVWtmuHFWiob4Hcxc0iR?=
 =?us-ascii?Q?zHqEz+GMjfX9gYfPmlNVvvXiqhn6u2AHwudzlxk8OT+M5uvolbZDZyW9Vqsg?=
 =?us-ascii?Q?12RVCUTRGy8oFOlZ9DRrLKz8dV/7SygybDnEc9tJ0hV4TfOIK6SrAoaNXd5O?=
 =?us-ascii?Q?gJmklA1kEHPyDfJnvXak88RZxQw8tMtEj2aK7HsKe3GZmEuRgmMrbnvty8Pm?=
 =?us-ascii?Q?RFRvtBUsH9/OukYKKGlCWARcKDhWAZkP7Gvbniq6esNw+bdLTePYw8tAZkAv?=
 =?us-ascii?Q?BYa5Qyb+fEYky4ZCqUN9OtEGFlWaVSDJKFTPpkGQKGKZqsykHSzo3iSvQllo?=
 =?us-ascii?Q?2sIHV9zpYdhPRw4MHvSjO2waiEY/2heB8Hg+QdfLs07Yb9IQ2Wa4xySfr5pW?=
 =?us-ascii?Q?2zGR+/oLnDmMtZ3e1F58z9ryQD1Vwe4riHandihcRbRnSph6dx+W/UdGwRBQ?=
 =?us-ascii?Q?DWIQkssQ0IVSDyr7dsR9Hraeg4f23Ioi3RPB0A1a93UMC2RGW7vMkxkBGW+O?=
 =?us-ascii?Q?bfKI14FIHzOQoatlfe1k7/e10L7i3DlW0XotjIhJLcKdQQ6Hh/ukDZKTbgQS?=
 =?us-ascii?Q?9GTxErNWWHgIjxdhVdhIubbE2SI9XtlorB/8NhBMx9+4Nwa/sJdnDhHZFZ1d?=
 =?us-ascii?Q?ciXmXPY3jbmezY5wsSjZdZvXzED0fKJSZmxKHUuag5697UuyTYWhBz/xWbow?=
 =?us-ascii?Q?K/Xv4IqiDS7zPOn6uwdEo4zUfR1e+YaArKs1AQgTTja4gAazvlW4bgEP5U84?=
 =?us-ascii?Q?HVCNsIwYdpvMnbiI72zu7EsvE4mEBWOiMWqirZZzwrpYCchz8Cb/f+1ISZHm?=
 =?us-ascii?Q?VICGQiJB6b/LqfkpSvo4XDqMKoHY+164UF2P/DOZi3Lqct5DpzJ15VNN14Ln?=
 =?us-ascii?Q?QJTSuN1kX2WQUOzBAuGcv5fkEwXsgGOuOLsLBTBghk2w98lLzrXaZGQnGVzb?=
 =?us-ascii?Q?3vA8BU1eLycul7XzpMBChSQiU3sQ1+0Ms2cpmcT7hcNPtl1b2eQ71RCk5oQ0?=
 =?us-ascii?Q?IMg2q4VTaOObeaqhBcTc6x9Tz3+STtGpJERTNDQ7JuUDF07yFDkOaZq3on3F?=
 =?us-ascii?Q?6n+RbKz/R4RR4ugoS+N28JS1gXEqlKdjv5v9K1MhDZAgBQA3BetFiIyBZKLy?=
 =?us-ascii?Q?AjQYBUidE3P6XFQ29IxdLfL2wM/JSv78H+VaKE1DRIo17JBfrlQSk/guz3th?=
 =?us-ascii?Q?T2IeqhK9nIuQzKR4WRLSnYK3a4f2gGwun7gWhs5fPUd7XwJN08K+gicpIThj?=
 =?us-ascii?Q?gHYg0yzlpBZ48XJ+fLc=3D?=
X-OriginatorOrg: gpxbv.nl
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4d01b5-e914-42fc-0804-08dad47aed06
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1348.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 15:36:05.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 96472e6e-8450-41c1-a7c5-ce4263c73b54
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaQzQZXGGonpcYhUUOwMq8inL/9GFPtcbGDe/9E+lN3gkpBjtif0GgZcUVIClTCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0874
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Bart Groeneveld | GPX Solutions B.V." <bart@gpxbv.nl>

Not all tads have the PRW capability, which is totally OK,
according to the ACPI spec [1]:

> _PRW is only required for devices that have the ability to wake
> the system from a system sleeping state.

This partially solves [2] and [3].

[1]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
[2]: https://bugzilla.kernel.org/show_bug.cgi?id=212313
[3]: https://github.com/linux-surface/linux-surface/issues/415

Signed-off-by: Bart Groeneveld | GPX Solutions B.V. <bart@gpxbv.nl>
---
 drivers/acpi/acpi_tad.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
index e9b8e8305e23..67f71fa4362f 100644
--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -604,11 +604,6 @@ static int acpi_tad_probe(struct platform_device *pdev)
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
-- 
2.38.1

