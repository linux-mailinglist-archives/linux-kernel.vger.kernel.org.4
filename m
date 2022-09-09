Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB415B3558
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIIKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIIKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:38:36 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE5134C05;
        Fri,  9 Sep 2022 03:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9McqXzSdkTx2uFZkHvIFX25Hm9PwZjZ14Mmq3giveY2al7nhfplcnQUVaZVaB3ON59kTKJABlgSi1TJC+xSMlPuQtHaEhDZaBGee3PvfYrSW3EYgH0ueQ61O7OvMX9LbhvYCmnmrQSj2InOA6oNaGZN2iwLmNRUvN8HwTkhVWLhXDypX/J1egxS+rRzx2LxrMOfxAKGPz1Va8khZ967XNf5wNDIIf+zfoN/M/IQocBi0GpHDKuzlHJyw1uIH/Krv499+IvvjW7JLzyk8LrdLI0fi45MM3PPAOOWNqXzZUrutusUHHXZwrkjv1CMfPxlDsDib4e/e2uooLQlkc6+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPazzFm/14Sovur6+lmIGQo4cWvcrmUx1/Jfz+urxqY=;
 b=FpJfdPE0au078Xx6ZlJ1XgHtYJe9+7c4hwL9NMxlOOK20fuOq1cq0oAYp3z6i0j2L/xndFhX98VvZVFL8bZEpGpcWkERRYcZWBwSKgMm4baw1tUbaqg1AxPpSz7SHhSSEJGUVpGyvibFaY8nyaPNDkFf2153Aai/t6n4JQETY+pn9sofhoUp1dav+BW8DNANivZTNOnMkgEWjzjGHIvd7w48XM7cKmvt2yjo4Cp7XG5Len9qOiaTYoYvAyp2tsYBfjDz9+u7GCXwMpJBl4si69ND/26j3appW+YQc3BUOtwYQ9AKDDlL+cq3QYAvOdIYzj0ZONDNNIYAQLcINd+Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPazzFm/14Sovur6+lmIGQo4cWvcrmUx1/Jfz+urxqY=;
 b=2PlgY6PGO3eCbfbIEHSFx5uiq0z5CAnAp13LfziM2yVr8MCCCpInKscXw+wM51tWegWQz05P9Ea6F0PiwVdZza1ZgyrTr/bo5qAV0f4WjJH7l0k6jwMaGuLx5rOvMDRB6gH6NW+Rm0EIVGxlJa0CsvTiDfliHmHM5hHgHEJBNEo=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 10:38:33 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e6) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Fri, 9 Sep 2022 10:38:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 10:38:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 05:38:30 -0500
Date:   Fri, 9 Sep 2022 12:38:27 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/15] cxl/core: Remove duplicate declaration of
 devm_cxl_iomap_block()
Message-ID: <YxsXo09JCL8fbDBn@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-2-rrichter@amd.com>
 <20220907161158.iaqgvqkgvdwoc5l2@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220907161158.iaqgvqkgvdwoc5l2@offworld>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT019:EE_|CH0PR12MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9e3a94-9aae-4be9-d5fc-08da924f719a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZUVNVrO9RlmYf1eXkMoqza1SxYLr4R3CkQlKiBy1D7Yl8CL9Ci0hEtmtQAMezB0DxfiK5x5XHp3+ZQgJInAxwt9ZRSciRsb1ARJGcOlIPQ0ZmnDyhdtsBJggbtzBTVH+7zkSYpaXlQf+HA0hWzJbEiW7HneBlWEig8/gEXcoTx3qe4FOYh/baHLuT30qS4gs4fcMlNe0vB/QqIx2E7E77q6lcsZfqphAA/HqMbz09jY7TyA4Z56KQCYJgcS1TX0e92sd/IFhSsEVb5/1jBJEZQqfrFj2FaaZok3iFBWPqW8oevidfUXAGqkzmoR/DtyJ026fqGq4H1rnCVUVtXNjcNqYVv7I4ymm2+uJvZroPLsigeML1EKrQYGLx0EAEp6cQzcsBW93VLSM9FLHXLn9i8DM/RadO10hPAmWAJNwwZPVFcfMY5JJNPXVJX8clqHluy95pr9czXSZYzoledeYPOXA0qMDiWV77VFf0USZrViVDfZHnK0NHy6xQUG7WNm1lQ2zbFQm8IaTK7pXqZm8SlvjyOo4a7RLGGSPDAZM9gi1/3DgrhxtjhdBYGE88q0WKVs/6hXs8vtZXU6pYUu2GICIeuHbIvFvhFwnbc9kw8dR5oMpFns11kW9H/CxLctdwaz44FKG812ThcID2XTb/YWEmkjNTgUkDXGYHhjFoQRfAYX3CVbfVAESJmOO+JMQmEggAOdLF3rkJJ+jcN6V9WLPkPXFI1hg4ypGEQWQIL64mAmAVHkA7u2Wq8IIsnc6XlPMjyc+sOGNMOT4GMIHyy7WRhRP7eLzVohyC1CCH2k70tynmo/cEENugkgxpqN1
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(82310400005)(47076005)(41300700001)(426003)(186003)(16526019)(6666004)(9686003)(55016003)(478600001)(26005)(40480700001)(53546011)(336012)(7696005)(40460700003)(81166007)(356005)(82740400003)(83380400001)(5660300002)(70206006)(316002)(36860700001)(4326008)(70586007)(2906002)(8676002)(7416002)(8936002)(6916009)(4744005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 10:38:33.0672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9e3a94-9aae-4be9-d5fc-08da924f719a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 09:11:58, Davidlohr Bueso wrote:
> On Wed, 31 Aug 2022, Robert Richter wrote:
> 
> > The function devm_cxl_iomap_block() is only used in the core
> > code. There are two declarations in header files of it, in
> > drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
> > declaration in drivers/cxl/cxl.h.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> Does this want a
> 
> Fixes: d17d0540a0d (cxl/core/hdm: Add CXL standard decoder enumeration to the core)
> 
> tag?

Looks like a code cleanup to me, nothing worth to backport to stable
which the fixes tag would trigger.

Thanks for review.

-Robert
