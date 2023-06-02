Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF60720422
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbjFBOQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjFBOQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:16:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8871A4;
        Fri,  2 Jun 2023 07:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLoYNL5Bc3E1DC76CfRCas17JWy++bp/VMH84z1k8oEiq57JNZ4Luuw2HNIHZ5pn/YawXiGSP5zCluyq2nCL0MXAbFrMek96uizTEuWM6DiWzy9ImtaY8v4wD3HduP7oxmjhtMZgqU46XXysWK3cFW+ps6TFl7UcNOLTxm47STaRUInlk6aymNfwAQz8x98wtBZ0xi2RAb+dQOs1jXXmPTaUDDng1/4ERabysyH9nFYRQY+8l/Udu3N+xcSHk9nAahf/3rBImW1izho9GPHk2vIzMrZmmzKlGxyv6/N4lDt/39dAlyLQ5Qr2CoV7YLaf0YZfQdLho9o8kepbaX0xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxJdJH7KJuWU3tJ2igpIZ0922BMVESU82njhQzdKBbI=;
 b=mbq5v1fNyipBBwm1v1ztOK+wBBUdHEdInynIk33UH+dduyAjBlCoTiR7OimIMv+PNthcSXsmOiU8kQH5Ux7RoBnwRrhSA+Q4QYQE0jr5lKEXoR17vLS7RsOdrxX62t0BUawso/ELze1WWv8QbG5+XxqAbRdvLRBMzmj3TsKfkzv3KmKZlcuXrC+QcMUwNa7Le8O1q47BqZKJw41T08t+Qh2RM2DJlbnDdAPpTn8I4DewfHtlryQuuxuUmu/fY56l9toCCoAZrlramS7XWrZXG6TqZwfnbiMu6DE/PO3aUt6hF6an2RL5zjet/Q9aPJ1yI24JmEH7WHwNCGE9Yic1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxJdJH7KJuWU3tJ2igpIZ0922BMVESU82njhQzdKBbI=;
 b=Y+JMiDX6MQh1Lji10Ow0TiKiTuvQKK8lngfA0dogRGzeuIslWHc128Io+MncYgVgNgaBwAKVM3HAAQeFmLp5s6VTHL2nDnTvu+FthapRcQtx31Qqw8zLimZdWCm1Avz00nlRnuhnRAGlGumY4x5XQ2AxPB5ITFYimzicd5i/olE=
Received: from DS7PR05CA0040.namprd05.prod.outlook.com (2603:10b6:8:2f::33) by
 SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 14:16:37 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::a5) by DS7PR05CA0040.outlook.office365.com
 (2603:10b6:8:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Fri, 2 Jun 2023 14:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 14:16:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 09:16:13 -0500
Date:   Fri, 2 Jun 2023 16:16:01 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 01/23] cxl/acpi: Probe RCRB later during RCH
 downstream port creation
Message-ID: <ZHn5RwXFuQOSWXaF@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-2-terry.bowman@amd.com>
 <20230601111328.00005620@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601111328.00005620@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: b50031e9-533d-4299-dbcb-08db6373fa04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhXMxxLHk5GOZLJZdL4n95BMgYHqzCTFcLdXqJWKuEskZoOp2RfWDDLQ0/QF8yT23bqJ2/la3Nw9EawXtyK0oFRyin/HfZwu9svpYs9y4Npr0duoS2txqn7cwFTAwQrlLy+CDRnxYJbNnr1rSAiQgIvaF0nX0Effv2bSXU7sG4AGcxKThwA2ur0ERowcvCEDXE/EYMpZccKat5xwCCIiHgnwh/a15fDYaBzoy/HCumgzb+3g/urRVcIVfX10L/qw4jUh3DNjvrtNsNoicgel39Q5oEJVdDN5D9Sp1Rl81+/Ex9u4ryx2DRnkEPUQ6SGYlXsmprUGtq2FMUrWeMyDWWdYQF9jPsZbbmzW7TBniHiPYPD8/8APNMfYwbrArQJkErHF/h5KmdPMPu7TPO564YAmn78gXmSSioxFk6HIDx8WiRxyyJZw18LWSSQmCQSL7gb/qC/tS8tpoaDoAJe/hvJer6f0hSiOA+/HaxDsxLla+EyCHFGEMi4jhgfVhM3uey+pMg9ug42dQS+XXsfaS9gmwGkkAm8oBuYoI2LaNx2UaJvx3atYhiMrn4sBUfFPWliA9wuq50vHuT3Ij3TxootJrjQCpa98fh49rFQi/zUany3Xqx60YKd775PJ1u1+Kp2EsyZGdzX5UPhfXVhxKpw08AKjA+h9GLAZyx0P4Yr6T4OY/Poeq+TXm69WsF20LqGEWpf6lAZUWdWeM7MmCxbzXbwpSP5AWl03KN2psge79CpPCrplAGveA4MsOdaQU/YWbE8UXNscSKH2p+OA1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(47076005)(83380400001)(316002)(8936002)(81166007)(6666004)(70206006)(5660300002)(4326008)(7416002)(6916009)(70586007)(82310400005)(41300700001)(8676002)(356005)(7696005)(40480700001)(55016003)(82740400003)(54906003)(2906002)(9686003)(186003)(53546011)(16526019)(478600001)(26005)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 14:16:36.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b50031e9-533d-4299-dbcb-08db6373fa04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
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

Hi Jonathan,

On 01.06.23 11:13:28, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:21:52 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The RCRB is extracted already during ACPI CEDT table parsing while the
> > data of this is needed not earlier than dport creation. This
> > implementation comes with drawbacks: During ACPI table scan there is
> > already MMIO access including mapping and unmapping, but only ACPI
> > data should be collected here. The collected data must be transferred
> > through a couple of interfaces until it is finally consumed when
> > creating the dport. This causes complex data structures and function
> > interfaces. Additionally, RCRB parsing will be extended to also
> > extract AER data, it would be much easier do this at a later point
> > during port and dport creation when the data structures are available
> > to hold that data.
> > 
> > To simplify all that, probe the RCRB at a later point during RCH
> > downstream port creation. Change ACPI table parser to only extract the
> > base address of either the component registers or the RCRB. Parse and
> > extract the RCRB in devm_cxl_add_rch_dport().
> > 
> > This is in preparation to centralize all RCRB scanning.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Hi,
> 
> Some comments inline, though one of them (about extensibility of CDAT
> structures) applies just as much to the existing code so doesn't affect
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> for this patch.

thanks for review. See inline.

> 
> 
> > ---
> >  drivers/cxl/acpi.c      | 52 ++++++++++++++++-------------------------
> >  drivers/cxl/core/port.c | 21 +++++++++++++----
> >  drivers/cxl/cxl.h       |  1 -
> >  3 files changed, 36 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 7e1765b09e04..39227070da9b 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -373,20 +373,18 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >  }
> >  
> >  struct cxl_chbs_context {
> > -	struct device *dev;
> >  	unsigned long long uid;
> > -	resource_size_t rcrb;
> > -	resource_size_t chbcr;
> > +	resource_size_t base;
> >  	u32 cxl_version;
> >  };
> >  
> > -static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> > +static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
> >  			 const unsigned long end)
> >  {
> >  	struct cxl_chbs_context *ctx = arg;
> >  	struct acpi_cedt_chbs *chbs;
> >  
> > -	if (ctx->chbcr)
> > +	if (ctx->base)
> >  		return 0;
> >  
> >  	chbs = (struct acpi_cedt_chbs *) header;
> > @@ -395,23 +393,16 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> >  		return 0;
> >  
> >  	ctx->cxl_version = chbs->cxl_version;
> > -	ctx->rcrb = CXL_RESOURCE_NONE;
> > -	ctx->chbcr = CXL_RESOURCE_NONE;
> > +	ctx->base = CXL_RESOURCE_NONE;
> >  
> >  	if (!chbs->base)
> >  		return 0;
> >  
> > -	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11) {
> > -		ctx->chbcr = chbs->base;
> 
> Trivial: This is a functional change and should be called out -
> previously the base address was stashed even if the length test
> fails, now it isn't. May make no difference because it was never used
> if that's the case, but would be nice to still mention it in patch description.

The logic changed but the intention is to have the same checks as
before. The length check is in only for the CXL11 case and no check
for VH mode. This is implemented as before and no functional change,
note the check later below in the old code which was the CXL11-only
path.

> 
> Also, ACPI tables are designed to be extensible and I think that
> applies to CDAT tables as well - so this code should not be
> checking for a precise match, but rather that it is greater than
> or equal to the size we will read from.

I don't think the spec will change here as this is limited to RCD mode
only. Other than e.g. capability register ranges this is a block size,
there is no intention to extend it.

> 
> 
> > +	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
> > +	    chbs->length != CXL_RCRB_SIZE)
> >  		return 0;
> > -	}
> 
> >  
> > -	if (chbs->length != CXL_RCRB_SIZE)
> > -		return 0;

Note this check here.

-Robert

> > -
> > -	ctx->rcrb = chbs->base;
> > -	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
> > -					   CXL_RCRB_DOWNSTREAM);
> > +	ctx->base = chbs->base;
> >  
> >  	return 0;
> >  }
> 
