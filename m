Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D346B4E60
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCJRVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCJRVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:21:08 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BFF8C581;
        Fri, 10 Mar 2023 09:21:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DINzW6SHtdRm+BXBgvPWBRDB4pTZchuTHukteuJKZ1iEY6+W9nUGcIpmaMWrQ4Xsh+jPc2JKoAGmlDkpsVFSCOsJcEGJk4I/hb1quAxbCt5mcRjuMpVL3eTNmgkjfBg70LHGFmykGPeekXjl0QNoB3JKha6YqtLG6Cjwr0qM9pMsaVRWN2W9DRX+yijxUo6WjQkFqbTmkiLlR2e3qIibg1utnHl4PvX4nvl6qRMAVL6hdsK7ZjJwjIfexcj0tPGcEpvSRDGIxImkhF5PnygVu/mnvmcXD1AnztwqEcZR6e/y2zJGchUG3Jgu8pYmhxj/CMMqi335Usx4JEoAOIYhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAP3ABshf968UKTuJXoVMAjhkT7EmKh8s3dgq8UyUqk=;
 b=UppdW9dROVUTE4poxNxibKthjK0bUrDQbn7f+hJrbcQRlMSAXB6OyQ8tQxOJcpHNNba3rUuiQoRsKXCjdaY7XuEh5xzWr4rZIck4WdDNfJjxB2fpzlzVH2sRB5aCma3xWCkAY8vJRJajd+s3FCXYU0+nv7zn24N5+EiIxAAYExRyPXM7i5dYc8gwY51Dav68H7wii4OqJkYeNbkE9lqbNjTAWsuXXuvLM91amQVr6Gjw6wiRWvgfDdkgaE2LACYRt1KrlPdw7k8R0ic1Sx1NdpHu76syYIo27h4WBu8MpDNQGFUAgFSgAl61NmnK5ztcSHJIry4HA0kphckdJM0mMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAP3ABshf968UKTuJXoVMAjhkT7EmKh8s3dgq8UyUqk=;
 b=UI1m9bnGPMNv35VJAvsBs9cf/HCCuikEH05WxdE77LObOSLiKnaM0NwF8aIUf9DfPQvkrWw1MO9ZcmtQ+EKBLwUtDeISeaubAeEOiDPffjxksnpeZBxb9Z3RL73WNSQO3CQD4uQHJYFgbjNRCTIzmLn5OYCeWfwP0EeoVVs/jNs=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:21:04 +0000
Received: from DS1PEPF0000B079.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::7e) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 17:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B079.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.12 via Frontend Transport; Fri, 10 Mar 2023 17:21:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 11:21:01 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sanjay R Mehta <sanju.mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-usb@vger.kernel.org>
CC:     <anson.tsao@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Fix TX/RX interrupt handling
Date:   Fri, 10 Mar 2023 11:20:48 -0600
Message-ID: <20230310172050.1394-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B079:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 80546cd0-5c6b-46c0-3ffb-08db218bd3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q0nAA1djPAz4Pwk1ML9RugpJ2izLzpyyfCorvhvOFbL9wwLOone4l33PN3qnKd4K45KBD6HjRtCT78WXPBvEmn0ZwO4WTBoMNJC14Pg3qGKjrp484MQNPznBklWJoqBaPB5vudCjnJzrvH2U59N9Wccvx7mRJamNreUKIX48yP+34cACjOTIqmrX9bHsvQNQGOFzXZ36SVs0Y1X/sYKQlqXB23PpBltT9vHJmo9nZMpeoIJct2nd06o/3qj+uXOMHu2E8ZQ7MnBOPewd0FL9/AuuxBTuaVqw9wohncJrOvYYmmpKd/PPPKUuxZslaC4u+q7Wd0VRa75g2GYAziFPchU1Nf6pPaPofOof3j8yjxfqPfgBeWcF4D5XtJXaJbx86pCCe5lTjtvQ7DkrzIjqif9KJXQu9BlqD6z5NrQwVgKfJmWrZSfSRWQRUHJOHoF//cfBdQRuTYOIb7rP7xfEi6F7OQamNmmPXwxXUwP7SYO0M5Vble0H4dxrqYSqbn6OE8H5FChz1XuVbfCcfyJorrOYCrPlxhm8kTpFzqeIFG7UcBO3MGLRnHSw6nbWugjGcEsJXDEQvT5cpHHN8EVzTLKW/n4uMKxkpAxdSrqCcPHgMOjcs9MqPhrsk2ch0cFxProrknVJ0OoDMHY4h6gYknQr49Y3T5WZLbfGnrDVBY2VlcjOYQ19DHzpvU5kPU3RgkX8gXhqLRHPW69iMhlHXnqyKf8P/KSou3k1wROxvjM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(44832011)(5660300002)(26005)(2906002)(8936002)(36756003)(70206006)(4326008)(70586007)(40460700003)(8676002)(316002)(110136005)(41300700001)(356005)(40480700001)(86362001)(7696005)(478600001)(54906003)(6666004)(81166007)(36860700001)(1076003)(82740400003)(186003)(336012)(16526019)(2616005)(82310400005)(66574015)(426003)(47076005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:21:04.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80546cd0-5c6b-46c0-3ffb-08db218bd3da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B079.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously a patch series was sent up to change the way that DROM was read
to prefer directly from NVM instead of bit banging.

This series was produced due to issues found where TBT3 DROM CRC wouldn't
match.  In looking at it from USB4 analyzer the DROM wasn't corrupted
before it arrived at the router.  In analyzing the failure mode, every
single failure occurred during a retried TX because RX interrupt
"never came".

This was actually a smoking gun; when the hardware responded too quickly
both TX and RX interrupt status bits were set before the ISR would run.
By the ISR using auto clear on read to process the TX this would make the
RX interrupt bit get lost and the RX interrupt was never handled.

To fix this issue, disable auto clear in the ISR and instead only clear
the interrupt that is actually triggering the ISR.

This fixes the communication for a long series of transactions such as
bit banging and probably also fixes other situations that control transfers
were retried a number of times due to a missing RX.

Mario Limonciello (2):
  thunderbolt: Use const qualifier for `ring_interrupt_index`
  thunderbolt: Disable interrupt auto clear for rings

 drivers/thunderbolt/nhi.c      | 42 +++++++++++++++++++++-------------
 drivers/thunderbolt/nhi_regs.h |  6 +++--
 2 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.25.1

