Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C596A7D94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjCBJXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCBJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:22:35 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC0410B7;
        Thu,  2 Mar 2023 01:22:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4JQAW9bwKeeNYpEn73xtfJkCzeWWg4r/FYPgKn0nenF9smoWpJDvmprGezdllufJGiejeg9rII6b2JrIJq4g6PZmnRgAM+v9vIU/WUIlW/TAlt/4bRQvyDnQuaMP+e7tjyzhnqdXuDwtrCLwDSYF87ulAaEPBAfSxAeFx6ORGFRjG/tQe2Tiai7V3lvNRlhAMQ1OnS8kmmCqrPFV470l2weDAb4QNE3O+zUhXnu9dXsVLvKrQXvOEM6aNeJ6WtiraMj93K+3f8vRoFd+27n3YLJOwkOwxu+WuZqlLz5/4MtBBEqKHaG7Y87RXFRLNFPlyqpro24r+QjExbA5gCbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5GwyyEz0CxOu4K+uVKqVsG3raMsVp4JNKQIZqu4fYY=;
 b=TGbEhnHB6C1J17CcbBMEtPKs94Fr8iJS/gyLYo6uCMejN3+l5slOLN9P22fSldpsHDaFo0AxovY1jTBO0GYgju7wn2JbZHqe81c/bvJ7KFTiQEVARyxSkG+fs2Y6KKyam8Z/Jb5J427VnoeeYmdykhOGVZBf4PaGYNGJbtOynZJEFDHiFbil2A+jEKW8/xeLTDUGukKrWmIPaDSA7e3z+6MaXNjrTFkUZUBoj/b++MKRNx3/S6WvG461MfU9i1Q4OItD4r6epUEYt/O92k0TqohohVt3Mw23fNlOUtU3gTFABxEQAHHGAvTUhWfIgss0WP0Wx1oJRhFw9LrYi56Uag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5GwyyEz0CxOu4K+uVKqVsG3raMsVp4JNKQIZqu4fYY=;
 b=o3i9Y3i1HfQd6hNp4xaKomSs9IDiQc4NulQ3UnDmSkKeeC5rVfyjxU6z1yE+zqrR87hoao37OyjOkb1Vz43IQ40dPPOUDKlQYGwJHlLIQ95xuUoWyWXhXmOMF84VTMr1pRgS4HXgXJSo9aAJoboShYZlQ0XeTN8C1ajKmNlGbL8=
Received: from BN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:408:ee::26)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Thu, 2 Mar
 2023 09:22:09 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::19) by BN0PR04CA0021.outlook.office365.com
 (2603:10b6:408:ee::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 09:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 09:22:08 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 03:21:55 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <peterz@infradead.org>
CC:     <ravi.bangoria@amd.com>, <eranian@google.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@kernel.org>, <namhyung@kernel.org>,
        <irogers@google.com>, <bp@alien8.de>, <x86@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sandipan.das@amd.com>, <ananth.narayan@amd.com>,
        <santosh.shukla@amd.com>
Subject: [PATCH 0/2] perf/ibs: Fix interface via core pmu events
Date:   Thu, 2 Mar 2023 14:51:07 +0530
Message-ID: <20230302092109.367-1-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: e58c8566-c36d-4768-388f-08db1aff990e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB/9uszZNiKY2hpntT4d8U5GPP+ibUKGKvIjguh5Ksl/v0gNDnY4GYhCWrJt/iI09YnIxHkyceUDr2/1Z9Z+S6UjZl+olyFGI71PagjRiYHYGh8EICNvqSBvRSnVl5fMY12pfHbnu4ocMtQNajnJG1AmS5j9ChhkoC3xKSx8hI52a/030+FgTRfYzUGqZTeRJlk7EkVVUzOncRuRctRpaoFJgL5DhSdOwyV/Q0wM0zp7LCtsxsfROSdr8Vqp6hIYeiYnKIWtTOcCO2oSosjzM9luDl0/o5zLb9sb8UBzI4ToNGi22k2EaMVFB8GOyBvqNaDl3rq2zFDLX7DmzdL6H/apr8wytY+3HB8UjtpnUxWe9oksioxgAcy6sknYzBD02R9i1NzuIy01JWRBXHu3Wdagxn4qnRwGLS9ERpJBqetq8WSZS7qIN72CLoyn8NNm8zlAGWSBKHdMdKJBqndQZFKB3ZhgkoL3YJdSmOswugvNDqRG77OFLt/F347iukjJUf7+vCOxy2TC/2qt3dxELFq4qpaiG2/uula4lMUVWsi61WudKZd0W6LftVQThdJIIhAjqPP8Bbwjv/HaZ0WYzhji78RJ0h9mJ1XP5Sl1IalQR9cIW0t8/uwQVc3da1J4FglkCLxZWqAc58owe/z0N6TdadV+ijptLl4yhzWCOMwLNM3+RjD+s8b0RNlm81k01RjFWZF6BPYfHafQHrAjQTX/dCR7lKp7CtOXC25VQlk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(36860700001)(81166007)(356005)(82740400003)(36756003)(2906002)(44832011)(7416002)(70206006)(5660300002)(8936002)(6916009)(41300700001)(4326008)(8676002)(70586007)(4744005)(40460700003)(82310400005)(336012)(40480700001)(26005)(1076003)(2616005)(186003)(16526019)(83380400001)(47076005)(54906003)(426003)(6666004)(316002)(478600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:22:08.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58c8566-c36d-4768-388f-08db1aff990e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS used to allow event creation via core pmu events with precise_ip
attribute set, but it's broken since late 2019. 1st patch fixes the
issue and 2nd patch adds simple perf test for the same.

Ravi Bangoria (2):
  perf/ibs: Fix interface via core pmu events
  perf test: Add selftest to test IBS invocation via core pmu events

 arch/x86/events/amd/core.c          |  5 +++
 arch/x86/events/core.c              |  2 +
 arch/x86/events/perf_event.h        |  3 ++
 include/linux/perf_event.h          |  1 +
 kernel/events/core.c                | 11 +++--
 tools/perf/tests/Build              |  1 +
 tools/perf/tests/builtin-test.c     |  1 +
 tools/perf/tests/ibs-via-core-pmu.c | 70 +++++++++++++++++++++++++++++
 tools/perf/tests/tests.h            |  1 +
 9 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/tests/ibs-via-core-pmu.c

-- 
2.39.2

