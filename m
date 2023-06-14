Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DED72FAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243785AbjFNKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244013AbjFNKYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:24:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADEC2968
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE0mzebnMdPDxeuCGzWgaHtykl2gFhONZQRaJXdBLzdQ7VgncJJLSKmK4JQmj+9FgkdllPCHVuHsmyrlG4euHYxhUz9wZXBMsR2lws7IgxZ0M0zSMr1X6rKOdTklVYdx1Rgrgx43Krebs8s5kdxqOHb1tEf9AW8KfRGk/hLtaMuU/0PzEDiMvRR4bjPFt3fYFQjuue4nmEkQ8atpJpXZV0Hn1THeazSCZl75gRketGaHThC5o+30CF+Yxf0vIAJoE7yeR6Wd3mzGGD/zsMsMCpSFrrdGB1kL9eNozz70Cj3akOR7kZ/VuQZxnA7MYW2avGnlYyvOO4IyB0o3jNJGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GROfBlriO1diP0r1032z8cJCEOwqkIaL10Pp8F+Sulg=;
 b=By0uZ84426hUZ+OXEKmS34ZHSW8jpgQF8K50XC4P8gefr9b9CB7AhtI7crnMnUB/TNAAtpFxT3bOHlqg8xIHa/zbGdvwDLMGH0wYy7fqAZdMp/qSIam104DHg9bIlBFfWyKU2r0u7/v6R+Uur/ZdjnfnA8lXyBGqKG2UsuzMh2IAy7nVPBl4NBy//CXoQzYBvfMXOQjr47pG0IXQ1mlkPfysm3M8yTrghHGJmr05xF2OGNh8pKor9CKaUdXgoryArP9M9LT0f5Eus6WSU2M6koTZ6O8gGnUrQkPbsVeKCzDa4YvFXlsAvfsR/rKZHwKi6QfmOJcOB2Dtfjowa1ORxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GROfBlriO1diP0r1032z8cJCEOwqkIaL10Pp8F+Sulg=;
 b=b3KOgdbl0aNllLehYdg7nslU5jlpbm5Zkko8TG1bwezRJgJUhtYeGCYJ10GFK6piHgTXt4e6C87nvivDFtVJiRzFggqE/X9hQF9t2+MzqMWqiq3lEmqvKb7/UyCw4HF3KWxv5kclSDLwjHNXn1YNYk5Huygi5vy5ywyx0v2WevQ=
Received: from CY5PR15CA0221.namprd15.prod.outlook.com (2603:10b6:930:88::14)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 10:22:59 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::eb) by CY5PR15CA0221.outlook.office365.com
 (2603:10b6:930:88::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 10:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 10:22:58 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 05:22:56 -0500
From:   Swapnil Sapkal <swapnil.sapkal@amd.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <gautham.shenoy@amd.com>,
        <kprateek.nayak@amd.com>, <wyes.karny@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
Subject: [PATCH 0/2] Cleanup and Fix for wrong accounting of migrated cache hot tasks
Date:   Wed, 14 Jun 2023 10:22:22 +0000
Message-ID: <20230614102224.12555-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b01400d-6478-43d2-1f4a-08db6cc1536d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wbeoPJ7TbOVAeRnenXYsVZ2vhg4jhfXcAn6lfx2rfOd903wCX2oVwD67jRoUnQNTHpx3QhipVsgCnAK90Dx7v10AaA421Wj9OYrTuF8zO10XfJB/jtReEeO4wzhXy4/8/WKd4o7aere0xagthy1TvmvIKpB6QniOy12Q3vW5DmjpqfwMCtU20NPs5WRlqb+FkLAfx+1HAToqHaREcZOCGl+0F6SDU1+dZWe5kBSZRJTOM7ZlSEc11uD92cAUSHJe2xKdETPQn0RMhvrRn8Gls+MuyoNL1Q5lVtliPZoId2uY5cvRUD1JHOTV43+YiLEYmBDo0B1eQUxeQbJCaVI/bcQArPwFBoa77SVQklHr5MrQONXZ+1aIW8MBuzzdxy4oy8JInVso8/QOoBdOAhJZyzAk71hESxOOIZ+uWP1OoKAga9TzJLgGoVAEAa7A9e739rJ3lZSPT3Z59Iqfbdh3Byepk9UO1ggS9cxMnUvhwafyczsFZtvgWJZeefvMm/DW0H9f8PTlDAwLssePkvq4PXtBN4o+76l7AuDDzi8KZmrDWLQQAl9/V1bWhk8o5EXOfp0s66pyFqGD/MjsyNTrZocRKlPvrHy7tBvm7Ikeh+F/Z3cgHJ9y4mVMa5OIKpHcAwSkI+YYjatC40Rs21tkzuiqCgsdJ95BnV9t9ygAdrAqUdw/EWodd1UmryoqdwuCttP6uIDAFBai176cTdvPWN0MFs4DQGsMjwPfJYIvqgo8oWe4CnugWrO8UaGkghIfAIkK1B/7+oczKREfBPud2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(8936002)(8676002)(36756003)(5660300002)(478600001)(4326008)(54906003)(110136005)(6666004)(40460700003)(7696005)(316002)(41300700001)(26005)(356005)(40480700001)(82740400003)(81166007)(186003)(47076005)(1076003)(336012)(83380400001)(86362001)(44832011)(36860700001)(16526019)(2616005)(2906002)(426003)(82310400005)(4744005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 10:22:58.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b01400d-6478-43d2-1f4a-08db6cc1536d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
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

In /proc/schedstat, lb_hot_gained reports the number of times cache-hot
tasks were migrated as a part of load balancing. This value is incremented 
in can_migrate_task() if the task is cache hot and migratable. But after
incrementing this value, it is possible that the task won't get migrated,
in which case this value will be incorrect. Fix this by incrementing it
in detach_task().

While at it, cleanup migrate_degrades_locality() by making it return
an enum instead of the {-1,0,1} to improve the readability of 
can_migrate_task().

Swapnil Sapkal (2):
  sched/fair: Fix value reported by hot tasks pulled in /proc/schedstat
  sched/fair: Cleanup in migrate_degrades_locality() to improve
    readability

 kernel/sched/fair.c | 100 +++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 34 deletions(-)

-- 
2.34.1

