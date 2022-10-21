Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40EE607304
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJUIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiJUIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:54:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F746DAF7;
        Fri, 21 Oct 2022 01:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUipMEwi67ISVK0LXt/UkTqTRxLyD2pfl2v0cA4gaAlYK5/VbKvYE3qyfWEYmdDvh8+TcwxFkcNQ8iffluhX1byFHEBL59WhWyHr4AHoHDaT8c76hv4G/Kty3xszfUot8m+bjijYby3dKgExAc9Gh871VuNOitECj0ByI2BFuRwfKLZT+us841exFzZwpO9ry8NolBcVZO7+fz3kzmFYpGr1NzmRh7kE6o14apT9lEFBrCuLji/6ptifW8T9bciEuGyqE1xZ09vuWWEDzrYl5alYMF/47w51Dy0ITiX6FHnfqSjL3EhWE1sVkeW71d6w3hHWJ+M8BPQkjiF2ZncU6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wTmMe1AfYfsmFDxHZloQvUWbwME5SYC1vrIXNvNuhQ=;
 b=DUrcRciWdAxOuVlaUChiR+DfEtNk6gJNNvhQm59OXkbzqQUd22aYcTQMzEoQKVrWtoWA+asB0Rm+hZojwVlj9pfs1mAuD8BzO4d9c5gZOQ8/MqvdRrC/DB0Z4EYjm8Na7UacLh7Ye8jo1bFJvHwW/s29Asi2EC7aKt4QDdK7Vrj6DBbz9R7E/qRNbdbcnxAk3oPRxw9FMuWSVPhiZbEal0oGFu1rNVS7As0buqrzXpntElTBcE0thU0tPDmkLhjz6HYfDTCaVzAfwdEUXsIBUfd5y5YWfZgQcDYDtZeQ2w5pvi96ffUomZrY7XQLQFzwV9BmwxWL8l/37z0anYxLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wTmMe1AfYfsmFDxHZloQvUWbwME5SYC1vrIXNvNuhQ=;
 b=Ez+4uxNROppfO7rkgqh/FY1k1YDR5A0LyEyH/LjdMMzGOxHgjzXqk78A+XfZXpSouehOnebBCN7LdnnZUqNrh2138Jn6AwYbUMDrrPnYd1TVAsebp6m6belKg7J9OUSlAuoxejgUOQ64kZ91ayVt/3CTz1QEseN1Nx3Z45QqZ/8=
Received: from BN7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:20::21)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 08:54:48 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::29) by BN7PR02CA0008.outlook.office365.com
 (2603:10b6:408:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35 via Frontend
 Transport; Fri, 21 Oct 2022 08:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Fri, 21 Oct 2022 08:54:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 03:54:45 -0500
Date:   Fri, 21 Oct 2022 10:54:43 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 01/12] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <Y1JeJOjc0BlcN6az@rric.localdomain>
References: <20221018132341.76259-1-rrichter@amd.com>
 <20221018132341.76259-2-rrichter@amd.com>
 <6351e043e52bf_4da329422@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6351e043e52bf_4da329422@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 7154d6cf-4ed6-4eca-7956-08dab341e8b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7YUSAnvJcuQr10MWMm0Lw30NGFwEHSN4YSxl/6VyYfHMgp5ebmQrkosMyw3aU7BsN++vyyAjkEK1+3uGKy5GPNFIzDFLZsng+kkcN3qUtnA7Ji6xYwrMgo0MOSyfpIaMycYTSbvV5TNKbADHOmKZNgepcFlPY1iM1/VTljxVuvTNC7wX4yJBlFfVEYrInUSN+DvXviXDy4ye2DwKTIC5TOqinLMwPx29KgO6FDv0C8Fp1gspZYB/M2ILv/xP7H90n5MxxVq3aLx/sYbADgLKs5L8nxFaBe7p75Vbbn7fWl/BLDD4qj8dul/Ysmr68jO0pbd5Tj2NCv65AGpu4dt5H8jjs7wzwvzic9lHvW+upAU2DW3Kcnc+OYzoy2tadqoGl/+3AkWEITfDHpaokkIc6Es8YU35fXmjhbctH82caZQF4x9G0kxsihDLhe9nyW9f0ogkn4uzEJwscVFfwjGI3Ulsb1/rRl9grOX2JjSeAIfwdLd/qN2R7y7LgogBurcopsCxgLfQ9b/4f39lXF8QgP4jq7OpaJ/Md9iuOyL5eEZHyHGrT/26uQD7EY0EAMejXSpz5jmIk+OKw627U9gMsx4W5gSiUPHepEbIqukKa2jRriy+IIj1EmaF+Kunb8zu09U27KpozZKpnS2c8N7qxE59IhnmJnudVxsqB8wORSvwbUgnBevTvzQ4EFf/+AwydIb7uuS5mgVf9JUwCu+Y9GDijD/UsSEvG5qycwImWV3fVlRsasNA73tPzIAI2TNOerGYOphgos9k/1H1kLYdpR4iYBnyLMiyDwXexNFsSWIarM2dsoP/0qfT1l9PxWa
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(186003)(81166007)(16526019)(2906002)(356005)(82310400005)(478600001)(40460700003)(70586007)(47076005)(70206006)(426003)(4326008)(8676002)(6916009)(41300700001)(26005)(9686003)(82740400003)(83380400001)(4744005)(7696005)(53546011)(36860700001)(316002)(54906003)(8936002)(55016003)(336012)(5660300002)(7416002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:54:48.4134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7154d6cf-4ed6-4eca-7956-08dab341e8b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.10.22 16:56:51, Dan Williams wrote:
> Robert Richter wrote:
> > The function devm_cxl_iomap_block() is only used in the core
> > code. There are two declarations in header files of it, in
> > drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> > declaration in drivers/cxl/cxl.h.
> > 
> > Fixing build error in regs.c found by kernel test robot by including
> > "core.h" there.
> 
> Fixes a build error only with the new code in this series, or do you
> have a config where this fails with current mainline?
> 
> Assuming the former, this is applied for v6.2.

Yes, a build error in v1.

Thanks,

-Robert
