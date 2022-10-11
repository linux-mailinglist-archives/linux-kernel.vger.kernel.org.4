Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D8A5FBB2F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJKTMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJKTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:12:29 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8318243AC4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 12:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfXEyx1tv/AS+3ZQfJaLIaRlq7REbLTP01ky5iObgOUAE/zy6tBjatcfH9EMUZBoPCS1CXujIRBAmAqLNQ+Uy8hhe3EYrbmsKn2uh9GqJbEWTLFTbBdyy+0GGDJHQAdxD1peMksR2B0cjtYtIxUIp2a+PfNUMtJEBw4pX/OYvcqMsBApKQ8IzNRdjrnWihTrxGy+f9JwrIlb8ItDnb4d0ClgqNJDon/FwNg/dRO5fsqMiJDkvCOkLD4qWBxjTOgBdo8Qx8kl3CYzlWfTDBnO6j3BS8n8FZAvTKQFGVURF5JCw3ASAD2p3L6lKe2Py9ySSGC4OEfMLoQ9oiI/TdkjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4krOkPcFUBfNXpW7+cwn/6MMYIegB69Ik/Cj6LKPw4=;
 b=jQc/wws33GkLCy8ywAkBaXbjHl7AtWff18xaJbGwoSkT5cn5KfjEyHDwpobte/GBSvyromirxScdc0CcQPZKsYUOgQWAMm+qdvfU+MdBKQj/T+TgjTFuIcFGdunWDZvvdk6QZPs+HsqfSNHtZrfSrwqpIrj7EerPF5Wgfxb/E9cVJ2J15ZTsMks3Msj+5hQ7ktIw/ptHTDEOq9NP9S6qKob6vjyNJtkQD4Du54H0b6VsRAETvVJ9oVTc/Z4Vn5yUnGtBg657w9WY63dfK2UBHmXF/9C/RlN5ZkoQybWg0f/hzHMpeKuk5HSh5vgJwWiICk7dRIgdKm2FgQIzdTynBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4krOkPcFUBfNXpW7+cwn/6MMYIegB69Ik/Cj6LKPw4=;
 b=BKxQLcQJmVbg2ASacGWCQ30QZiMKQyLCPg0t070QeWm4BUMMGoOG3ozDz/5pTJXTtFKKCKHBCFH4fQcrbLrGZaEgDvTsVqufZc19GTDFJuBXf6MmsQoCFp5LslvH2XOLOinB059AUU4yazcK9iW8Xh5fQsoxrbwh42RWz9z+doM=
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 11 Oct
 2022 19:12:23 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::2e) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 19:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 19:12:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 14:12:22 -0500
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 11 Oct 2022 14:12:21 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <ricardo.neri-calderon@linux.intel.com>
CC:     <bristot@redhat.com>, <bsegall@google.com>,
        <dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
        <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
        <mgorman@suse.de>, <peterz@infradead.org>,
        <rafael.j.wysocki@intel.com>, <ravi.v.shankar@intel.com>,
        <ricardo.neri@intel.com>, <rostedt@goodmis.org>,
        <srinivas.pandruvada@linux.intel.com>,
        <tim.c.chen@linux.intel.com>, <vincent.guittot@linaro.org>,
        <vschneid@redhat.com>, <x86@kernel.org>,
        "Carlos Bilbao" <carlos.bilbao@amd.com>
Subject: Trying to apply patch set
Date:   Tue, 11 Oct 2022 14:12:21 -0500
Message-ID: <20221011191221.3254760-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: d55be369-5592-47e2-f3cf-08daabbc86b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hwv5fg0MnB5KHVOLAYcuuvsJ2VmpaZy8/0pxXRV5LrYZCWeKjGcWc/ZM6yrYrV8WjVvt0H+3AZ7CFNY3egp8vSXVi2H//Rj4IynsS2CJGkCgdVLPNZgxeMFZZ64da3bcw/etPBjiCMb8Hox83Z93bpGyTSxE0/gW8hfXFipBgjshI0GW8dibzcTp99BAOQc4Ue2ihqpnnhv0NA8UC3MJYtDBdM0S69PLOKSWFUpY5mbnuw08eKFftptLBZZfwqFxfagpkjXCH9SovirizIZYMSuE8fpsjJeOKNPL5wBSm1AAWa6jJy4jBiLRbJD1bzcS94t/vBTPejFYcqJ/CIhLnyeFIsGgZQVNi3tL8GoUqZQKnALq6R0oyNZQyJWOmqi9qcrotHD4/uITjJgymSndXnuJV4Ml05U2TF6ewdEhCUAjhkWhfrZYC3YWT5lnzqW3ye2n7WTG+aywbGDzWh5ePVrfT1jKoWOL0TxVh4SwJf7y6I2leWUQDf9ZOtlKyS62CtCWF81bJhR//4z+UFep7KSRIHKgcgKL4I4WnLg2HOe+xkoB/lStfzumiEoCwenvUUXY5vQ4qv90seFgBI1l4hXWd0h3ANp+QJCpEaLLg8kXZcX99en3sfsemYpfXf6SodyD1A+RNo+GUdeXzZnxhUpmWqmheqcL9t14lhUTisukJY++WGR6JnDaIH8/nfJxMVz1GBve/sdLCH0UVO5h+GkUiVkU33mMAtX0Eoyl1+K8EbSgfj8+fOaqVyG3i0jlLZtzSpOsx84HbN0uyOqDADG/VhLUK+7o3mat0y/1bbF/FjvHN9nrHIVDgwwSlHlK
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199015)(40470700004)(36840700001)(46966006)(8676002)(70586007)(70206006)(36756003)(316002)(6916009)(82740400003)(40480700001)(54906003)(26005)(36860700001)(81166007)(356005)(86362001)(40460700003)(558084003)(47076005)(4326008)(41300700001)(478600001)(7416002)(7696005)(186003)(44832011)(8936002)(2906002)(1076003)(82310400005)(5660300002)(336012)(2616005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 19:12:22.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d55be369-5592-47e2-f3cf-08daabbc86b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please tell me on top of what tree does this apply? It would be
great if you could provide a link to a patched repository, given the
depedencies on other patch sets.

Thanks in advance,
Carlos
