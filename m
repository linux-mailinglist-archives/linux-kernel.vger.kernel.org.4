Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DE166CF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjAPTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjAPTh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:37:26 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5162B615;
        Mon, 16 Jan 2023 11:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECBaEOu+zG83bweBJPRuujfsxFVd3bG6kXvq70lqIiTslIRGQzj+qq1xuuoGv6pdh02RXjEiQ2ADl+cWM2cflZ3iZtADBur8rQIuYwujDvmhFT/ANccCViPn9h52ZDMnbWlNEDMwWDjZWQrpzikKtBkwgdXu79WDbu4060e+F03AA1jtmqG9LhxR+kdA/548hHQGc3R8MQlZEi6NJ00eughu4k917iAhCF9aaurHWAN5foiPhESVIenm7/xdx4oUruRhPXQTY8A3vRhog9LtSFRPyPpflzdQna9P+1H2+GscIsxHDMJFpLvPCkV6uPporzSRvdGNdeAyc4HxJQ2LjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ47lhKQqIGsZ4KANVU3g2b4eXIyyf7yBWbmXFlKTzg=;
 b=du2GYdgUFzEeyPDlSmVNaJgs8IOsHMJ+aN9fFkf8AmjkdForJLT7lH7/k38uY3CN592SVhFh7uFPw7W+b88KMSMmUtAZkJAyCKWk85AUoNx32YtPTl3hrWy58L9Q6ziuNJTMTpdXniJajVSsOlGbJjRpmDoroWeRt9264+EPtk6EvarJkwO8aQxsNdFo1UukQs1k60E+cfmuveCw4jyQb/1TQBHB6Twj4H0Dxrc9qeZ1Tv1E7JHvOFpXTvVynx2FYWxYB5+pilnPVDPiIHOI0/c0d9r0sWOWAz/HyCneLzVNuiwjl+qdYN9O0Kmlq1hgcBOkQP5ya7LzAZe0CzY5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ47lhKQqIGsZ4KANVU3g2b4eXIyyf7yBWbmXFlKTzg=;
 b=DPRZVU09FyxxAgbkPK8ni98s6PInxDH7W5n8BAcwvH9PPMJJbVRJGjS9wS+UINytzO8mDvH81OUskxrjXOkxuxFaMZoX5ACIGCc+qFRg+6e9/KexSXb7rDtgs/jYIt2AsgddiQmAguozUKI3IZPy6KQ0KuauAZ8y2efv61BY6Xs=
Received: from BN8PR04CA0003.namprd04.prod.outlook.com (2603:10b6:408:70::16)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 19:37:24 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::5e) by BN8PR04CA0003.outlook.office365.com
 (2603:10b6:408:70::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Mon, 16 Jan 2023 19:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Mon, 16 Jan 2023 19:37:23 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 16 Jan
 2023 13:37:22 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Raul E Rangel <rrangel@chromium.org>,
        <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix a spurious wakeup regression
Date:   Mon, 16 Jan 2023 13:37:00 -0600
Message-ID: <20230116193702.31356-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e65e1b-850b-40f7-1857-08daf7f9178f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTGqOe62Cf8albc0LVKbxeazanVq0Ik/mVRlg6fvKbL6upqFQDWHhApkGdA7Hc/P3VjWX21LTIBm5PJr+nIT5ZDSO+LJAJh4b5NHPxqBWfX0hAME7XQwfXpxZwQAWq4cRPsjWsqg5Xbe7eHMy6ypbf0pl6rDWViwCA6k1QM0cL10FJ/O8eP53blaBwIb6P6sU1cai6MDNLj9oHW4e2gevng9/aLqpYSh8sKrhj405jwI9ktNKqbF3zfX9v4D3/zTSO4eM5HM1eWLpg+bJJ34DlY8I4k/PZXRb233ePRbZt3t/4UFMmlS6OAp23Kn7cjG4449zthRqAQg/7+iOea+5OHLGgMExMmXnry4f/NJYei+hcx15OfYki4impVEnc/5W+8rGzPeH6hAAddShMvm+tiMZFZxUXXNqZpO+ytFXnITnxONlB4ltCrU6VIf/K8zMuyXiU8MCwdJ+Sex/csPQgRsuzPoUC3qIWO934m//yEygcxKKsqlDpcYTXbC6h904iY9ZMAsA28kObfhuLruqDpoZXZ2/MnSPWtxgyfdqu7yz1HrlhZOA6EX3Xg4LmLYjqtbqWpFZxEXMxI+98lViK+7YNoqTM6B0L3JpgxHZzi6pDpAkbKYjyM+pihTT2UOnBgBqpXlETxwJHUhbGXlWkIT8qMLSGg1gLjRH/63rounq8itfrDBBui0MwMzDRVtEbH1Xv+oaottFYZTdgyEtH2nM4uQtbSchmtnjDqvlRk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(356005)(86362001)(8936002)(44832011)(70586007)(8676002)(70206006)(4744005)(4326008)(2906002)(81166007)(36860700001)(82740400003)(83380400001)(5660300002)(7696005)(110136005)(40460700003)(316002)(6666004)(54906003)(41300700001)(40480700001)(82310400005)(478600001)(426003)(47076005)(2616005)(336012)(16526019)(1076003)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 19:37:23.9736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e65e1b-850b-40f7-1857-08daf7f9178f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1796f808e4bb ("HID: i2c-hid: acpi: Stop setting wakeup_capable")
changed the policy such that I2C touchpads may be able to wake up the
system by default if the system is configured as such.

This had an unintended consequence on a Clevo NL50RU where the system
would wakeup immediately after suspending the system.

Reviewing the schematics and ACPI tables this appears to be a bug in
the ACPI tables, but it was exposed by that change.

To avoid the system waking up immediately after suspend disable wakeups
by default on this system.

Mario Limonciello (2):
  gpiolib: acpi: Allow ignoring wake capability on pins that aren't in
    _AEI
  gpiolib: acpi: Add a ignore wakeup quirk for Clevo NL5xRU

 drivers/gpio/gpiolib-acpi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

