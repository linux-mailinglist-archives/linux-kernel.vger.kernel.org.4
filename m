Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760045FCE35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJLWMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiJLWLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:11:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBCA66856;
        Wed, 12 Oct 2022 15:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITcEGa4UfX0K8VT+ltyJsItXu2zSLcXrYNpTHDvpLi9eCmYMqqyQ74k40mei7B1a9k5vMIe8ciPi1dnQXeLKtD5peBdLMZqqZRVqt9bpn4NuLmku5uv+FxxDrqslgyHTxENrXizjP/it/5pGoFGaItHGTQdUcWKALdZQpx4sG6b38rlc8qzHfeb+//at1Wbj1uScnXA1MlNlzN2runhS7Z0wfX0g6erhfAeOq3t7LG9/Hq/B5kb13Xzc2m6kr1yCAFSWejo5LYQOFlcJ56IJozLe5cnVPJfLP1F88D1R+CoNvwFPOi6wBkk272k2v2bYLpPr+EZPARAUANrT86HGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN5QQ7ZzO8m86dmFzq24hvyaE4P+lK294QHquTx4TTc=;
 b=O8boo0wign2uSsFQaSUUsgZP5+6BqJyU/1Cs2xXoCErkB8OBa/2hiALDxYjwZWGEYZet84Np7m51KEqdXzbQbFCtCi4OaVw/2HT7JsQAfyo8mT6TQK8c271L8SzEgo41M1PRJeTfEZ/tzbcyRHMuEwiQJ50535MUGTBu+AmWGwhjHbgBOlxB9BW9rOX5w8kGNYRbG/QTurhZvNXTO6gVM4P60kwh3Giz9qCAfFBpOTD/4r48lnRNvs3aX9So0RlGLeQqrnY1awukslMCu28oD2MMvSevOPOpmc4qM/jTPGJAZ41pFtQ6nekJKvdLH076ocgBxar1LE3xSRsSJFsFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN5QQ7ZzO8m86dmFzq24hvyaE4P+lK294QHquTx4TTc=;
 b=3NBrGHKcetppcpNxfIrslMFH9lgoE5o+RgUs4VhagBhEDvHK7bLMFx09L5bGRc3WmW57wZERv7rMU5df3VPdfwL/GQ5xShaUGfWMNIJcYQkV8JVjmi4ahA2AsITkgxSxEn/xzP13rljhY18vQTTVlxtbiKWeqt9noCdZ10ZGRVg=
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 22:10:44 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::5a) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Wed, 12 Oct 2022 22:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Wed, 12 Oct 2022 22:10:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 12 Oct
 2022 17:10:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Mark Pearson <mpearson@lenovo.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/1] Improved debugging for active GPIO causing wakeup
Date:   Wed, 12 Oct 2022 17:10:27 -0500
Message-ID: <20221012221028.4817-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 12108fad-82b1-43e5-bd45-08daac9e9bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyXazXl2M/FKIh7s2r0khVIuB7PkdtduO9FEXDYfSBQGNNlEh8L4s6lZTyyTgAcd6vpEoIVTo2hnytRXvFS+ytILBXa7YxYafdaczMYjyOcVBOt3udYZawK6Gyp4f5XDxHgmE+2tVWrfQc7TiCGBR/jfMmiQ7A0BC3LrRM9jcMp1xgod98VVcth7Zhl9i2Q1R7IqGbpRcDYzbvjD7DfQuzPNp3u+lIc2iXtMBt+7/8zudBuQaZCXTeFC8bdqWuXTGa6Zn7LnARmd/9PHRKzgiZsl8uRQ8wZdkdQ9P5rhYx97YH0w3y0pAl/vcgneNTeyjCrlYqKetuxR3ut0/W/jaNiSlEN7CHI9J+mexbjIAXrU3fKRlHb7HbB1WLjK3/0EQ9TMDV/B5x4XGZRRHjD/F4DWplTuCevLxOTCoaibcUK5uewqWvjnoqGUo6NWE7lo1FfTC88ITPOEMtOEdwQIFnRG/hHZFFAj6jhJh157B/96ZjYTf6VX42cqjJ0ooObBMTGgsOvq3cyqRlhYTsXr9cX2/RbJ2Q3ItmEma7XDQiPh/wV8gss3fHfErzL6dw3SRhNtI+WIIxMBolJucP9gzhBANS6A0aoOaSNTPD5UEBPGO09XULpFQjr72Z6ji2Ay8X3RoOyAVR+zJ0e+Xp1OPDOJLnuQ+Sa9XTnyQ+WIe/EXNBYXfL+Pp9FrMZhEf5h1tixTjB8rEe0bjikeykoVQQZ2bAG+4QF5FxSSza3PlM1DpOFkotJp/FO37wUtyc5cYUBtkezE9PAKV/TnA0NosX90XZ5txBzulUj3f5ggypF65qY2u8Md04KrOGRq7jIhpRUg29h5K5l5Xs2kwvc/BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(16526019)(426003)(40460700003)(47076005)(83380400001)(186003)(336012)(1076003)(356005)(41300700001)(8936002)(82740400003)(36860700001)(26005)(7696005)(36756003)(316002)(8676002)(44832011)(40480700001)(478600001)(5660300002)(110136005)(82310400005)(4326008)(2616005)(54906003)(86362001)(81166007)(70206006)(6666004)(70586007)(4744005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 22:10:44.7548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12108fad-82b1-43e5-bd45-08daac9e9bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some laptops have been reported to wake up from s2idle when plugging
in the AC adapter or by closing the lid.  This series adds support
to better debug what is going on.

With this patch in place we can see that this laptop woke up from
the following GPIO (which on this design happens to also be mirrored
to GPE0xe):

amd_gpio AMDI0030:00: GPIO 18 is active: 0x30057a00

The use of this particular GPIO is OEM design specific.

Knowing these details, it's possible to workaround this problem with
the following on the kernel command line using the parameter for
gpiolib_acpi introduced in commit 6b6af7bd5718f ("gpiolib: acpi:
Add support to ignore programming an interrupt")

acpi_mask_gpe=0x0e gpiolib_acpi.ignore_interrupt=AMDI0030:00@18

Mario Limonciello (1):
  pinctrl: amd: Add dynamic debugging for active GPIOs

 drivers/pinctrl/pinctrl-amd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1

