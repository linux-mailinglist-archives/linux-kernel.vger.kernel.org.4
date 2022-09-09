Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803125B37A2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiIIMVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiIIMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75391C12DA;
        Fri,  9 Sep 2022 05:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px7XgMpxhCUw/2SpoJ3iyUF+cZoBVH5aRVkgT57oJ9wkKCSmfwrmjlcm8Q2TBlbBjAUmQGTTQVh9//wiYCstermYMGfb/QWVwaYnITxvVeKiXz0txEln4auTZBvvgOzWWe3gWu6jsGgxhFQlkg1ErSsKDzEfAegzB7fqn35hszL/ci3AJlFPkEQaZDLb0d4xwQiwrqHLvuTFaVk4Pu46Dm4dfqjpPrvzN54qHuVk6Z0YPOjsUJvoQVSuj8NFqM/cgRjUVZDH9PAUMyoSOHszWNP/+X7IhgC1VcdKSFE68KNF0mju0qdIRjwQY6Bm7G+uPh2Yp2PkWsEJeOx+iEtZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXu5+sId8wYzErbaOpQSr2L9PFwRfCbFFraneaQyUz0=;
 b=eiD/6qCm5ublMsdzkEtzttWS5bWnGZgBLvsjikSMyI6EdTiL7EecxrOcxAYbmiV2ismTDybg4gTM/9elJdADAhOrVITSm70aR78JAklVyyxu+cqUvQwlfoZWFlT3AsvQe7y9WuOF/jLkT/TznkVEB5xGT9SVuXRmq+Dtk1zIRCdBH1cfDvA4ouJR2XjeozbEIqRY8k/0rmUpD/WKJ63V2MKk7j+xmLR7DkDuP8StKYO75Ume/e5JGUl0rs2w41VgdR9FHN2PUrCXfgoN98gLfM8OpBm6PB+mAMTDvTEiwa9IlTy02fGulwdothY9a/JlHzJ/zNfCJDAxt+2MPhkRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXu5+sId8wYzErbaOpQSr2L9PFwRfCbFFraneaQyUz0=;
 b=L3A2WiwcgZ27pV0zozPRtjzmFkwQ/+xUeVxqj6X/AEeduYMot4XSkkzRIIN7W9g8puRd1iUQGbbo4JP6sbI0YiDum+KYXL4jGvYjrgr/IqayZNG258pRujV2djPoOTZDuWsNNekktPF623h5UD7ruX7GxTSKs+z/H2Tj9g0TujY=
Received: from BN8PR03CA0035.namprd03.prod.outlook.com (2603:10b6:408:94::48)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 12:19:17 +0000
Received: from BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::57) by BN8PR03CA0035.outlook.office365.com
 (2603:10b6:408:94::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 12:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT113.mail.protection.outlook.com (10.13.176.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 12:19:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 07:19:14 -0500
Date:   Fri, 9 Sep 2022 14:19:11 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 02/15] cxl/core: Check physical address before mapping it
 in devm_cxl_iomap_block()
Message-ID: <YxsvPwzxoYBMnN2y@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
 <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT113:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 127ce637-dca5-4b98-3725-08da925d83b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QyEgpB7vG8Uor8cAiuvq15gcuqPkTnDztcrSoE9U6SCEuddsHaAx0u86SlbSUVme6OCkVmM4fEvd1wrifmNvV2tEsZ9IQNlPUMW13TfMiGTzJcjDR4tb5ZMyEfc2JDnA0Zme5oIAPnlRNL69r0UbvMgUmYVk3AZ/f8xPBsNZlVFKGZxXiSkn0JpHfpK8DYfZS2ROmAJvPAoFJU3YM1oevDa312EufFFj/EFGMROLj9cfVgG3qFeUOEIfFeKKptTwqHzCZFysYzYqAs8nAqOp6pIR0n4A1iPR7uRMcukol+wFnULUUDlfOmh5GIa8qJsOIh9u5tBF6xrOmYSihKBI3SVAflwHgNJewNb9+IozwwvrL0TQ5UqJH4DB98qyMU/Mp6Psx0DgNMxbvHkNsz/gRkMJsCdVFseK0xNH9Svsq/slMFVVcNH8ReklHGW10OVQURbbshbdWNLFQwe0u6kJBinI9jid8vF6PTa0BPIHlkuh9ARve9eC19pq6uFgk8p2CcjGRMqUa2FtvrG8Kw464xyPo1suX878GX6YDWad6IxBN4iCPbtydfRFdbtgQHpDboTgkcx8VGt30mYWpmPeuq6MNc7hy90q9WJkz3L9MVSYaYpjvdgYQywzj3SwHY0IsWjlS2t7WUd8M+VT6MYNDS81h4Q7f2Y9+OSRUrXSl/vf0EEzKxNgnJY5RKcODXPGVMtZuoxBMn/VbKPpfuEPo/g5jjfusQRvFv1qOxSTOVwOkFM/oqKu2AwjN/P0Mk6R0jmItsvlJA1PbcGCbtaxWM//y1L23Tu/hXeoq5K01iP9hU6SHnLaLVfSX7LjMBC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(70586007)(478600001)(8936002)(16526019)(41300700001)(5660300002)(6666004)(336012)(47076005)(4326008)(7416002)(186003)(426003)(70206006)(9686003)(82740400003)(36860700001)(40460700003)(26005)(55016003)(6916009)(2906002)(81166007)(54906003)(8676002)(7696005)(316002)(356005)(53546011)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 12:19:16.4608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127ce637-dca5-4b98-3725-08da925d83b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 22:48:57, Dan Williams wrote:
> Robert Richter wrote:
> > The physical base address of a CXL range can be invalid and is then
> > set to CXL_RESOURCE_NONE. Early check this case before mapping a
> > memory block in devm_cxl_iomap_block().
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/regs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index 39a129c57d40..f216c017a474 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> >  	void __iomem *ret_val;
> >  	struct resource *res;
> >  
> > +	if (addr == CXL_RESOURCE_NONE)
> > +		return NULL;
> > +
> >  	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> >  	if (!res) {
> >  		resource_size_t end = addr + length - 1;
> > -- 
> > 2.30.2
> > 
> 
> devm_request_mem_region() succeeds for you when this happens? More
> details about the failure scenario please.

No, CXL_RESOURCE_NONE (all FFs) is used as address. A broken range is
calculated that even overflows. I only vaguely remember the exact
error message.

This may happen e.g. if the Component Register Block is missing in the
DVSEC. cxl_find_regblock() may fail then and returns
CXL_RESOURCE_NONE. There are a couple of code paths there
component_reg_phys is set to CXL_RESOURCE_NONE without exiting
immediately.

I saw it during code development, when I pre-inititalized a port with
component_reg_phys set to CXL_RESOURCE_NONE. Since that case can
generally happen, I think it must be checked.

-Robert
