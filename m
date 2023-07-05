Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E047484F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjGENa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjGENaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:30:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1BF1724;
        Wed,  5 Jul 2023 06:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+oHlvC3hFakHzraXUxUIlnqyrcJ9ELjxkx7J2VEHUqsSFRfqFwWZ1ddgaxXtGepJqM/okdIK1LWsBBIa/X/kD1KGG1cYFkEMASxKdG/HpY70Irm/IOq/05xvP52FMY96bO3sBQ6Af0MKabLtqszNdKIRn07ll8nudxxwNDrB2i+tCTsft1mzoNeaEfhD0g1pmpsp2JwN4XlqhfSgfRSrFhZ2W6zQD6KCsvaYwXHznr+E6JlH8zzE8uQAzc/nNTxSIeCVbeAuXsQ1NFbE4rfIjRdXm+QZmxmca2tCw6SPqvxaXBvLIY7mU7AmXh7+xWLdl9i2T9g3VrIsfMaQmhXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zBmAkfShfa3aOlbUa2g7u329PmFDE1OgQWiG8PFadM=;
 b=IvBaEsJfzYsqVISS7Jn3WtFcqI32DzQDsP7zkziw4Ri2ufy9I1hQ1aOgoFMOFf0xt8FmJ6DZ+cGw0bzTf7keUay0Ov1Uk2KUHhTMRlzqUOI96r0nQfFVlk20KN/s4vGu/RZkh6ZbK/Xu/yfs2UgROZvqwfQ7pl3nofOls+VQuFlTz6Xj222pns0V8WAXIxclj14fP/KHwDIN6XZXoB5CDOgRKicd8eF5/rTqmV7QBs9pr4Md1pooLcgGC+RlBksx3h7W0f9jws1+YTj002QQlrv8h/tSAJvyUjdnu8qwzQ4GwzlQ29HLgGMKYMJfrsuXfLQyQCkylpSW1Z+e8qyKuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zBmAkfShfa3aOlbUa2g7u329PmFDE1OgQWiG8PFadM=;
 b=lhk2CC85SSQxduCA8e5UEbUQATsNOJtVrVFjmj9N0cO5RCvvl9c3K8uNz2r5DJqqcOifBTah0waT3gvGsUmu+xdVRRGAEEGgHE2jlMu3u/isndV1oZhIvrrMQn+xkZO5yGN2ynrldM0FIBeJ0RTc7dT5ZkZbNZCf19iUNRAdsJM=
Received: from SJ2PR07CA0021.namprd07.prod.outlook.com (2603:10b6:a03:505::23)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:30:28 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:505:cafe::53) by SJ2PR07CA0021.outlook.office365.com
 (2603:10b6:a03:505::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Wed, 5 Jul 2023 13:30:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Wed, 5 Jul 2023 13:30:28 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Jul
 2023 08:30:26 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        <linus.walleij@linaro.org>
CC:     <andriy.shevchenko@linux.intel.com>, <npliashechnikov@gmail.com>,
        <nmschulte@gmail.com>, <friedrich.vock@gmx.de>,
        <dridri85@gmail.com>, "Hans de Goede" <hdegoede@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list" <linux-gpio@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/4] Fix for interrupt storm on ASUS TUF A16
Date:   Wed, 5 Jul 2023 08:30:01 -0500
Message-ID: <20230705133005.577-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: fffd8344-e668-43ce-e1b9-08db7d5bff6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /txmKQNDcvxOVolX/x8MWarhlvFuRJfFv6iWsaXDWF7F8UskeKQ5Aqt5+oZOb0odXurwevKv4CHiYN9gOL8F4JO4buGL0XL8gXEiXwIcyiYvOMVjq8CuK2eNl2d6/B4OYfA8xxZ+FTL0wPMn9uKJTuidPcyy2aaWIuVqeW0Ft2oWGSMwW9qy4w8R+vldHvpiLhVlHvBpeVrLBT7H9ICnMemciOO3Fzw6UjsUt7hyVrmONXXhdLMRPXWvSWpiO7+xQsLuDwGJ3yfW40jlCROishP3icIrelb8jSojFOnnUOoWoGMWNX2R0BGF8hL9zKbw/eGGpuClTrmwVbQyp8wIzuttpjc8Hz/sXRfuBqwcw6ZLmlCCxjaae5w+hONkl1R/vsfKAdr5GZRcgSafaAy5ppUreUzjsfwQgyjdtE4x/d1BbBKXzkk+XRE/LooJMF07BRCdHvP/IdCWnL7mAf1yJxQS5g/MNPBLARbvCq2N4de+ULY6osS5HXjUMSn1+Dc5WK2NsbTkYomOV4GhPm3ssKL0AS38ja0WpNGgcPqGkykbZZoNNJQFZ8nnFuaCybxgein6lS4ItYu34F/5qnoDphwJ70+R1HiAhH3cxzXKd89y8jziVhi/jHlvPPXy3+lkDw4zaRqNyqGhDgkIfEGa0J8dOElZy0JOQNT7Pn4RJi6IhMYRgr5qA8qPdDvHBsahemTeqwlhAf9yrlQ+McWEZEv98QBs5vNAfatee1dtqmqqHTD50vVMgXqLmHAGGf2h/OypXNS1GarXPY7Q0prFoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(110136005)(54906003)(356005)(82740400003)(81166007)(7696005)(478600001)(6666004)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(316002)(2616005)(426003)(336012)(16526019)(186003)(36860700001)(83380400001)(47076005)(1076003)(26005)(82310400005)(86362001)(44832011)(5660300002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 13:30:28.2966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffd8344-e668-43ce-e1b9-08db7d5bff6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An interrupt storm is reported for the GPIO controller on ASUS TUF A16
but only on Linux.  In comparing the GPIO registers from Windows and
Linux the configuration for several bits specified in _AEI() was never
actually loaded into the hardware on Linux.

This meant that many values were taking the default hardware strapping
for pull up/pull down.

This series reworks the programming of various bits to unify the
expectations for the hardware.

It's confirmed to fix the interrupt storm on this system.
This series is based off of the tag pinctrl-v6.5-1.

v1->v2:
 * Update for Andy's feedback

Mario Limonciello (4):
  pinctrl: amd: Only use special debounce behavior for GPIO 0
  pinctrl: amd: Use amd_pinconf_set() for all config options
  pinctrl: amd: Drop pull up select configuration
  pinctrl: amd: Unify debounce handling into amd_pinconf_set()

 drivers/pinctrl/pinctrl-amd.c | 61 +++++++++++++----------------------
 drivers/pinctrl/pinctrl-amd.h |  1 -
 2 files changed, 23 insertions(+), 39 deletions(-)

base-commit: 9f0648f13e34a01f2e1a7a0d5801988a7bca6988
-- 
2.34.1

