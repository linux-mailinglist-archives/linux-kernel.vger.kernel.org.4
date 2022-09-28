Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498725EDA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiI1K2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiI1K2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:28:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC62FA284C;
        Wed, 28 Sep 2022 03:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9seOEU/IaxfQenqYAc+ghZGyTYY6d1ADBB2LlgnlJW47IUK1ptMUQZBH6+m/gUhUufrnwEn9r08sNr0UuvyTaWpNHporrz6kBihtVCb6uqTIYm1zm9yDDNutDmSDuD3h8FVizdOAxz6v512FOcQIeseg1CR6tezdv5z+jV5sJ7GPwEnFc0edaK9m8CbDvKDODiNXAPYSd5X3PYsomA0u4oy3YnNL0yW5ibMl8iKaYgPyOPiMT+FfABHJfSAWCYW4hY6JboW3xSk5osQ33vbcfbAftJr/xl1E8yh38oaCw+8TNmczhQok8r6mZB8QQawtG7/tm8wB93XqQcfnqV/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuLugTyefMvj0HhlARpOMibJkuqHSWY56Oicmbe4Ba0=;
 b=LhAA9Fvb/nZe3UFhJMmSXHE+BK0ty+RPuBvEpIf6rcygDWeGCHB5mecbcZAmTnzk/uHh3EAlBhQW0rms+XcDDXsDdxS+r++5gXHWMgD0KS/6zczqbgjgKZADOIvZUQ8vf9eh5wthpMBToD4RYRqTjteg63YzzOGSSp3L09XgmcbguQWTy/UVsBRkLmHGL4ufbOr9FuLgM0yu6Ack8yfdz6FJLbO40gwDsLgft/P8+C9KPhidDaX3Mqy+tR1cl8DPtjeZvlOpxivbAZI4QVueqs2GydCSG54m+BGZaJb+K+yR5jtHEeAd21Tq2QxKjxjzcmv82yHxmY1kDAQoHgtGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuLugTyefMvj0HhlARpOMibJkuqHSWY56Oicmbe4Ba0=;
 b=hU6yNchmdeRd48b8s/IJziRzOUzB4nfu6s+n7RYFGu6vCD468pVaHOE+7qij2/WvYzUXlPmXTRz0JJdCuXWjxrQHPSIUr82krD3Nmew+JfKkYebcW46hSnyvi0cJ60eCL9lLzYk3xqxe30RM69sd87wMpGE/Ql1ALmTxW5OUwBc=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 10:28:37 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::42) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Wed, 28 Sep 2022 10:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Wed, 28 Sep 2022 10:28:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 28 Sep
 2022 05:28:34 -0500
Date:   Wed, 28 Sep 2022 12:28:31 +0200
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
Message-ID: <YzQhz93rqX+1NAQH@rric.localdomain>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-3-rrichter@amd.com>
 <6319824968fa7_580162946f@dwillia2-xfh.jf.intel.com.notmuch>
 <YxsvPwzxoYBMnN2y@rric.localdomain>
 <6324ba91a05cb_2a6ded29457@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6324ba91a05cb_2a6ded29457@dwillia2-xfh.jf.intel.com.notmuch>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2a42f1-ade6-4fa9-e364-08daa13c3403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eW/iaRd/76bkrQ1Sh3/tCorBZDl8NvHKAA8FNh0S5zPSDQhs9UIVwPTl8MzAM0VEZGOIUWGG3ivMUg6QeJNo24Untlv3XjhQBN0TEJCKlRhAWApel6rLA88J1gfTuG3ZzHPOn3SG+YWjXFdIQ7Ju1o13irPyp/jmePNGEI3X3uMYTDU6CgpmBN9VqocVoL6Ln9p7UacCcIzrmVtxyUpoOpaMuro+eE1uxl5RTsoPMt5n7jXvzVHtcnyLZI1ahOTRfBKj7Gr/nN6NBzvzZs6SWr07IwYwqfrvt6EUdKMIc8bEryUVFx6slWjYr5+U3YT0GHNQne6qwCS2sa85ZHbz/YXiu79JIL8CFPlHfzU8kkwX6nbpjZ2pQvOAslGrOGd5AUZ/84v2F803yogIgOyWvZ3kT7Oznp3Y3tbz6wOIWUhCtNaYIx9Ko7WCmYc1WvB/5GnbsnGMHrgjG7Z9OO+7UbHhCFHBRL5ok3w+YUD1Cbpo5/qJ0fadIu88lvvO4OQIWufyZn0OvHKDb6pMQWopHOSzsx14D6DhrbKbvI4SmVuEekVUHDkEg0sK/qU3olk9lNVt3GvI9lc36WwR8r0QH2nqTDg/3crJPxD0HTgoh7uv9salUqoqcsmkMigRujkoqByUF+K8QP4rE2uITftigt8kELeJK8uzgsxP1u78zmc41Ltuw8lkxqKXekAajWF0T3974Muj55+Oy7n1BWcIwilRCggkrYWDx4Jw176NaKmMnKKAmvaRunLWCOW7B47AuLfcDOxdw+Wll6KHWbQ/Uz/dH3lp/tboJ4AnssjBU5gZzXfzrvmQIxXoDOT0HTVIwAtAFLojXJsScSVebctVBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(7416002)(5660300002)(40460700003)(8936002)(26005)(40480700001)(7696005)(9686003)(6916009)(54906003)(55016003)(82310400005)(478600001)(4326008)(6666004)(83380400001)(53546011)(186003)(16526019)(426003)(8676002)(316002)(336012)(70206006)(41300700001)(70586007)(47076005)(82740400003)(81166007)(2906002)(356005)(36900700001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 10:28:36.7876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2a42f1-ade6-4fa9-e364-08daa13c3403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.22 11:04:01, Dan Williams wrote:
> Robert Richter wrote:
> > On 07.09.22 22:48:57, Dan Williams wrote:
> > > Robert Richter wrote:
> > > > The physical base address of a CXL range can be invalid and is then
> > > > set to CXL_RESOURCE_NONE. Early check this case before mapping a
> > > > memory block in devm_cxl_iomap_block().
> > > > 
> > > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > > ---
> > > >  drivers/cxl/core/regs.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > > > index 39a129c57d40..f216c017a474 100644
> > > > --- a/drivers/cxl/core/regs.c
> > > > +++ b/drivers/cxl/core/regs.c
> > > > @@ -165,6 +165,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > > >  	void __iomem *ret_val;
> > > >  	struct resource *res;
> > > >  
> > > > +	if (addr == CXL_RESOURCE_NONE)
> > > > +		return NULL;
> > > > +
> > > >  	res = devm_request_mem_region(dev, addr, length, dev_name(dev));
> > > >  	if (!res) {
> > > >  		resource_size_t end = addr + length - 1;
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > > devm_request_mem_region() succeeds for you when this happens? More
> > > details about the failure scenario please.
> > 
> > No, CXL_RESOURCE_NONE (all FFs) is used as address. A broken range is
> > calculated that even overflows. I only vaguely remember the exact
> > error message.
> > 
> > This may happen e.g. if the Component Register Block is missing in the
> > DVSEC. cxl_find_regblock() may fail then and returns
> > CXL_RESOURCE_NONE. There are a couple of code paths there
> > component_reg_phys is set to CXL_RESOURCE_NONE without exiting
> > immediately.
> > 
> > I saw it during code development, when I pre-inititalized a port with
> > component_reg_phys set to CXL_RESOURCE_NONE. Since that case can
> > generally happen, I think it must be checked.
> 
> I think Jonathan had it right when we posited that the code should
> probably have failed before getting to this point. For example, the
> scenarios where the driver looks for a component register block via the
> register locator DVSEC are not valid for RCDs in the first instance.

I am ok having the code reviewed to prevent such situations. But the
handling of component_reg_phys is by far not trivial as there are many
locations it is initialized and others where it is used. Call chain is
across multiple functions using various data sources for
component_reg_phys, so it is hard to proof this may never happen.
E.g. in add_port_attach_ep() I found this:

	component_reg_phys = find_component_registers(uport_dev);
	port = devm_cxl_add_port(&parent_port->dev, uport_dev,
        	component_reg_phys, parent_dport);

find_component_registers() and subsequent functions (e.g.
cxl_regmap_to_base()) may return CXL_RESOURCE_NONE. But it is written
to port without any further check in cxl_port_alloc():

	port->component_reg_phys = component_reg_phys;

It is then later directly used in devm_cxl_setup_hdm() to map io
ranges with devm_cxl_iomap_block().

Just an example, I did not go through other code paths.

IMO, the check is cheap and prevents weird follow up errors and log
messages. But I would be also ok, to just drop the patch. There are no
dependencies to this change. What do you think?

Thanks,

-Robert
