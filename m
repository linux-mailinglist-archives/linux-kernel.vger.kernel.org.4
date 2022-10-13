Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F05FDB60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJMNr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJMNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:47:51 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A7E114DF1;
        Thu, 13 Oct 2022 06:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms4iwMpHMN5yIVEhwOsW2csxUeROOZOrA9mCQFr6gH/ItWUZZyPgQZV4WyyvdLVblYtuuuHUYj7KG2i9puvg1njw7XwwT5xE93GuS0C70RyS4LVhGXzElxuyBsMFomjmAEpEVDHyqfweCMCjgaal+E7b3xYocqb7P+TZtV3ejAyvSkxWYheorZEfUeRKbsff/JNb1hMWfd7UTrkCBxbd0TZIzIG7WToj9FVazE5Y7n1YuUBOEIpwblp5qdFxt443Lj0fRlvCafaup+LitlNcdLdmKEParA6vDAvQLsVcKxf/+OCb3WVyD5PaeK9XIIx3abBuPjB1v/5l4yTZuyRmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHrgnFWICyoV4d4tlPUXeUkaBedpOckYcLb/ZSK2TW4=;
 b=SLGM/4UKW1QdXP03kJE3/hhu1D8Urkdz3rYeOz8m9GeAhokELJDxW8Klx2zNZKe+KDD/MvABNtHKmR4rdKJKQdYBYTp0i9QxAV1E4W/Uoc0fcYiEr22tTHiI0hy+qLRP5MfX8NOEZfPA6IH5MdMSzaujrxFRCK6/oBEZHnc/90iqkQVA9E7umQRG3/EP2cWaBUug60deyh4FHGOqLhYxQNNw1Fj1W7v4KWrQjNtuBGDnrQhbQgtPozlCYi0bsJB9oD00DWDk1IF4zSPL/ouMjgGRl1OIWFeWQqKnEZPOK7aSIeNMtgZTgqWJ0QFRS8xGNC5SAe9qQ5xxLsis99Lkug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHrgnFWICyoV4d4tlPUXeUkaBedpOckYcLb/ZSK2TW4=;
 b=Ek+MZuUjUbx9DqTRMzKpfiLmFz6Rq/1GCemXIzz7pDaYhIhyMFhfJXl+Uo0TlHFWqSuEapXJOdvSRXz+CjFY2iZ69TUdVB4xoUL2MhXpIIzTBgqCp2GipRUlaID/TQ+fwwODAdotemVTAwippKRenWRn4WdK98998kWJag2H3hM=
Received: from BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 13:47:48 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::9a) by BN1PR12CA0009.outlook.office365.com
 (2603:10b6:408:e1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Thu, 13 Oct 2022 13:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 13:47:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 08:47:46 -0500
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
Subject: [PATCH v2 0/1] Improved debugging for active GPIO causing wakeup
Date:   Thu, 13 Oct 2022 08:47:28 -0500
Message-ID: <20221013134729.5592-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b6637e-adc9-4ab6-7c99-08daad218371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+JwaT9kccl6Kw4cb/L2+eoOAW6LxPiaet0ME5EEFtvFbIxiujX9LcO1fImmvQLQuo2uYa8j/8BVKQVXu83qqv9y27eKIMSy6EtfLOzNdbMivUo8IgIN260LW6ACrN03ixt1MrHsgfUSOlPY2pndd0lgmiGjG0ilzMT4gmpeZvnRZf7BfEKzzCj1UIwGBC40vYUiqzH7mY8pxi9zr2VJ8Tx1OutS32uBpzVQB8aCmiBrLIXm6EoAE3DoLV0qXmkzwDT2uiNPifsKaZacDQeBDX/EAaLJqtab9hKdvp9OrB3RjZT4baGEP+Rr9RzERWH+qx7+5RI9y6tmXYSbdis/USjptFZYgj5/boIiMqQSbjpf/hFW+TW1dMX3EuBap5nzj2I/a4qg+gaBBMBXt03E8oA3SUsQWhyr+uF8e6xs16pa55id2kxSFLKz9WU4kYsbjq/sHD9AfzHH4/oxlwCefE8Et1uRDnsFHGIMbqJZtPBHYjIXCA7qzl9ebaWIdHeb2zWrjF430SnscLrhmHw3GLpTcih7tO8qQeOwmJDXUd0b9SxPzVO4kkEvxQIgts/J6VJefhzsEDvUJiWYypZfcozY0E7S4Y+zrBMkW6fcPDrkHChtuzyBfIB0Lno2IwmGKXgAguLdu9FzW6RLxeezK6oEx+tt86yTOL8rPx6/yNOUv70q+mot7xa6obUq08oPqxhMaz4z1DT/9b3HX7wKU5AHp/J/nhZ+lZUpwK+g7db6ePsBEHl444WaFGBszncjb6DcnYCcw9QqZxrGQJyyIpSw2J2pzq0NQYuxG3WSIyi44Yq6teWYuV2s6NKraO6sYvycn4ZsC9cw0Skw0g0qaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(47076005)(426003)(110136005)(316002)(70206006)(70586007)(4326008)(8676002)(8936002)(41300700001)(54906003)(336012)(86362001)(16526019)(1076003)(186003)(40480700001)(36756003)(2616005)(2906002)(82740400003)(26005)(44832011)(40460700003)(4744005)(81166007)(356005)(6666004)(5660300002)(7696005)(82310400005)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 13:47:47.6656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b6637e-adc9-4ab6-7c99-08daad218371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

 drivers/pinctrl/pinctrl-amd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.34.1

