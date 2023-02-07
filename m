Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DE68CC54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBGBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBGBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:52:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68397196B3;
        Mon,  6 Feb 2023 17:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBdxAuMfh0824Ns5EJCfTsjgS7lAHofakie/MUrS6xuwk7IPrFGHsD2pz3bVDOxqd4/rJBiNY2g8wUeX6ZI62w8HeTvKpu2vu7DvxHRK76MB88QPBOBm2L2vku1mCcAwoGGLtuqBFKh59Ur+F+Y5yDtGDIIFa8lrrcOLwNhS2dRzKzvpUVbyXHys2vU+7Boj06FwGEPeBV2hroyr+n47KCHRtmwI4YYBosQ7VsdqL00PNp6PNanqpLWaK3Q6DkRoU/9InIB/QdLfSUPcRL0KKyp9UB6CpqXqTAKZiUjXHbyi29HfVTGdX84DhFLImlLMSTiFD4HMu1E1zHO3j5XzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSo+O0Q1IWc2rs5V3IZfRbXrBIgNx84txOMedTnfyjA=;
 b=DUzd3rPh+AbfNl9+Qzswsw/WeR5bGbL4C7nyQJdJK3bGgUVYa931B4ynVCAkCgFgwlHK3cHULdneFHSR+xGg/h3szT6SJp48csnco3EbYuqBAezvjdhgXwxYW55djmC+pKSEYhwcGaP2IZ+XXJGgL1Ap2YhKbNyDKkPT5GbraGl9Go9ceHHp0e1JZbo0hRjAI2I9/pVPFLQrmqjBsFEZe0X1quJChShj29oEVOUg2dt+lzMUNpgxRkNpLvzQVeoP9yvqNSoER0HXz4RzF4c7oinSbZ1oeHViUjQ8eMxmXcM9VuN3R8kpJ5rr5HwKowkPoKDWkwF8Mq+1qGEdlGB4Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSo+O0Q1IWc2rs5V3IZfRbXrBIgNx84txOMedTnfyjA=;
 b=y4hpl+KQZl1Jyx20wU72gi7dAmi3E3v2BrZf+ekBnvSpLHMaKz+aaVaSNhbgu5IEfrSvIwnamOwcgGb1kqZXN+wwpjghtOkRB3ck9t8FMgpnE5GeTyv83xcfo2JS3cgacdjmYGeGOFEqmp0jHHOIwlLS3k36FCDMN1JeNAH74kI=
Received: from DM6PR14CA0054.namprd14.prod.outlook.com (2603:10b6:5:18f::31)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 01:52:21 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::ad) by DM6PR14CA0054.outlook.office365.com
 (2603:10b6:5:18f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Tue, 7 Feb 2023 01:52:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Tue, 7 Feb 2023 01:52:21 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Feb 2023 19:52:13 -0600
From:   Brad Larson <blarson@amd.com>
To:     <arnd@arndb.de>
CC:     <adrian.hunter@intel.com>, <alcooperx@gmail.com>,
        <andy.shevchenko@gmail.com>, <blarson@amd.com>, <brad@pensando.io>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <broonie@kernel.org>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <devicetree@vger.kernel.org>, <fancer.lancer@gmail.com>,
        <gerg@linux-m68k.org>, <gsomlo@gmail.com>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee.jones@linaro.org>,
        <lee@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>,
        <p.zabel@pengutronix.de>, <piotrs@cadence.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v9 14/15] mmc: sdhci-cadence: Support mmc hardware reset
Date:   Mon, 6 Feb 2023 17:51:48 -0800
Message-ID: <20230207015148.55678-1-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <a958eb22-39c9-4f91-8f72-cd1db7829a3d@app.fastmail.com>
References: <a958eb22-39c9-4f91-8f72-cd1db7829a3d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: df064a35-8aba-4cca-d513-08db08adf39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ef9+sxzHrRSX19iCm3z1wdAJr8h2WynjhzVJa8M9a6WG5NONIvkUsD1Hjfu+gqP6Ea3wDyNs9brbhSZw4gs/R/+lArcDlQ67XD22V5t4HuL6SKyj1rX6p0nWHwGaB0BBYeEPQTUE+PpCNs91kBmNIUYeMB4tWQoisSyYq9Gri2mDF4AkST8FmYo57VZnRS5PJYBNVRGAd9P7g6BKxdrE81yxy3bESlqIpPIQ2Sr7zPiciDu3O6/+qe3Ra/aM/LXu/WV5S4NtUm8+1DFae4DwpBlkBI5HIiJXnmnL/k3BipUHZKSxmQJcsTbHAG+W/PRBL9rOdkNtqfgjoVx3/mXtQmI7xZ8gB95JJvNR0NL/ZWmcACboqI9mbgFk7uOwVmBdy23Ocma+7sjjbr/cbGCa9vAqhLxIKid31Zm3am6LAnh4uoXlMR5r9RLXAKN4Qypyd0HHHiayr7u1kp7JE9BzBrdUWqjolh/3LBknQ1TCLS7Nieilvod72jLwCy/FZo0s21KYmjshCJPQ5wh4v3sArxnA9LbN+EpkuwpvHsesfQj2j+ry5LjMv4lOseNoDTeJBXUbZb51+EIti4pyLXlbmha+sfAzLPZlV40ThYXKYwssqgr899aOPU22Rj92Sc0MtMFbjB5FHVkIYaskh9bZKV0jmPp9o//lhw4fh0BmJu3ayR3SKfDC9jOD7cj0DmfNySa75dcypUmWeoEbARlPPSiurjS3ZHRtqXQym+h7aIE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(36860700001)(2906002)(81166007)(82740400003)(356005)(70206006)(70586007)(83380400001)(478600001)(4326008)(5660300002)(6916009)(8936002)(41300700001)(7406005)(4744005)(7416002)(8676002)(1076003)(6666004)(16526019)(2616005)(54906003)(26005)(82310400005)(316002)(47076005)(426003)(36756003)(40480700001)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 01:52:21.1913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df064a35-8aba-4cca-d513-08db08adf39e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023, at 09:57, Arnd Bergmann wrote:
> On Thu, Jan 19, 2023, at 04:39, Brad Larson wrote:
>> 
>> +extern unsigned int sdhci_timeout_val;
>> +
>
> This declaration should not be in the .c file, and I don't think
> there should be a global variable with this overly generic name either.

Thanks for pointing this out, I've deleted that line.  It was leftover test
code to force a timeout to trigger the reset driver and reset the timeout.

Regards,
Brad
