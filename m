Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE956E22A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDNLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:51:25 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB110D8;
        Fri, 14 Apr 2023 04:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ2vza74SygvWMyg0GiIM4F4Ixux+iXjtdDxzCq58AdGI+uFHTeBQia7EMOoEF03ki5mMVRzEJN7UdLE6lRxA2Pg0tloVA/0WQy8RwkaEphaVLM50iw1LvUyCi9moEmMUVhao6bc+SV6MkSq1c5mbns0Zbk9hWjsOnqAs+7zA9aN1IYsN+GevUaIJp9NjkkJxkx1lnycz0PZQpuC8IGgc30a5PtgU4R0b9V6Fu/145Mu1ARobi+0cN7FCbbPErDAye+yIdrEyFYJtqXYcKl1I16/Oo0l220/VOaNGFC38VllQAbLHfQyB0KtXwtuKfIyHSjNFlnaq2AvLJenHgcyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b/1Ahy2EY2yQV+rC4RJAuTqPvdUvEplVivHOCh1hfY=;
 b=nSrO1139WzLUni0fKm7c3PbcLssLk8fcrWsPQeRYb373wCeF4aRivmyt7/nWZIZvOhsT6Mku4iLjbkjk0iD4CAgfYqZG4uaGlRS4YUiOw6OrMDl1kj+R8HEgYLkE2IhNyhcwPLz4zzxO2Ku/+kDRBS97UK7I+Z6GPRUD6Li24m7PTmbf4uQwuRarI6OqhhT3bt+kyn3pMWC4FEy45FqBu1txpd6IKrlwwv2NqRF8af9t4J4m013hg/CnFk7lyyWBq/oQ2fUGjE2sroqpERXDKQRMLlZfHJ+D9U9Dkh5He94+uS4KG7ravsooCWVzETZzZvTPjDfGTMblB0hxdCWBMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b/1Ahy2EY2yQV+rC4RJAuTqPvdUvEplVivHOCh1hfY=;
 b=loKswZsDs9tKihKZkBITruVVlbXjS8AvopOkkx4m9KadpXmFTQNTtme9d4/wIzbPWMnOMZRIQ6Qy/0ggnD88zSUQfi5X+39NMcU7POnHidlbybFLtI4xdyu+KomQcxZ5dBkEp4DZkM7+qK1I74dCZiw8uWsGQoGK/u3IFxJxkks=
Received: from DS7PR05CA0071.namprd05.prod.outlook.com (2603:10b6:8:57::14) by
 DS0PR12MB7927.namprd12.prod.outlook.com (2603:10b6:8:147::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30; Fri, 14 Apr 2023 11:51:19 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::82) by DS7PR05CA0071.outlook.office365.com
 (2603:10b6:8:57::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.11 via Frontend
 Transport; Fri, 14 Apr 2023 11:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 11:51:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 06:51:16 -0500
Date:   Fri, 14 Apr 2023 13:51:13 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Terry Bowman <Terry.Bowman@amd.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/6] cxl/pci: Add RCH downstream port AER and RAS
 register discovery
Message-ID: <ZDk+MYcrtV3fTHsN@rric.localdomain>
References: <20230411180302.2678736-1-terry.bowman@amd.com>
 <20230411180302.2678736-2-terry.bowman@amd.com>
 <20230413163050.00006bfb@Huawei.com>
 <8d2690d8-9418-e2da-8834-6457a60a67cb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8d2690d8-9418-e2da-8834-6457a60a67cb@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|DS0PR12MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: d36f5ee0-9294-4997-be66-08db3cde8f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whiCJ+j3MPwbTDLTIboO7kNZI5dbQqm5PcW88EkyP8X8DqCnR33qQ2y5RWzJoJuTTzZFD8FWpQswr29IqqBxNk6s7nC6CCRmcODdSxG0ISsL5NKwn5aCP8J+p4i4JtAcbuLFnq3DN4NaTSbjabZvUH8o2HNf2pUVWQvanwwPApa4Ch65BxpX+jftivqkloNuIywc+FoTxFZGQZB761zdyPRztFpsqIkwRD5/k/6ui6daS7pYjv6fyzda1nYLNQ3mCxXda0L9Zjq+13Vmr+hYmYWcfh+dm1W5Ed1vYZTHftwWL6toPMAfI2ZZWrt4ihJZCrXoXxApil4GDlenxZI107uir9GBn3FsjOEbVNMC5v1zfo3i2hBAeWI9Dimqr2IrOJ4YYcghdkpupQQnIFUqCdXdNx3RxPAgbqeTaWeWZwJn9Esfnsx0/2voMsw23/0wQIg5pTxxa1qz6qfloLU8tnfmRgCW5tUmeT8sqvVXLLHhCSnJh2SP01hXShnjSixy03Zux9zzHs5/MjNd0u2ig5D/552/rsZYbmETK8Ccaa/qzcXRjYnq4E2tqha3QxS4gaO+qbMmM/JxDkh1TGNN51jM8B/FlfdK2D1QM+Rc2RmpQGgTtLkE0wl8p1ekoIiDnM5nbRDLTmbic0HBHYwA8W3r6z3p2u3FpV8DtoN/E8zKweB7aU4Hg3DvfAHalFPTHrh5Z1Nwlj3P5msObrZ5Ji3vs8Z7nRbvXvSXkHlkkgcq2bjsRmgOyN0QHIULb8XSQhrg/TwZGiY7YXJzLg5eow==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(70206006)(426003)(5660300002)(7416002)(336012)(82310400005)(8936002)(83380400001)(47076005)(186003)(356005)(9686003)(53546011)(16526019)(26005)(81166007)(36860700001)(82740400003)(8676002)(7696005)(6862004)(40480700001)(6636002)(316002)(6666004)(478600001)(54906003)(40460700003)(41300700001)(55016003)(4326008)(70586007)(2906002)(67856001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 11:51:19.2227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36f5ee0-9294-4997-be66-08db3cde8f9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.04.23 14:13:16, Terry Bowman wrote:
> On 4/13/23 10:30, Jonathan Cameron wrote:
> > On Tue, 11 Apr 2023 13:02:57 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:

> >> +static void __iomem *cxl_map_reg(struct device *dev, struct cxl_register_map *map,
> >> +				 char *name)
> > 
> > dev isn't used.
> > 
> 
> 'dev' was used earlier for logging that is since removed.
> 
> >> +{
> >> +
> > 
> > Trivial but no point in blank line here.
> > 
> 
> I'll remove it.
> 
> >> +	if (!request_mem_region(map->resource, map->max_size, name))
> >> +		return NULL;
> >> +
> >> +	map->base = ioremap(map->resource, map->max_size);
> >> +	if (!map->base) {
> >> +		release_mem_region(map->resource, map->max_size);
> >> +		return NULL;
> >> +	}
> >> +
> >> +	return map->base;
> > 
> > Why return a value you've already stashed in map->base?
> > 
> This allowed for a clean return check where cxl_map_reg() is called.
> This could/should have been a boolean. This will be fixed with the refactoring 
> mentioned below.

The intention was to have a shortcut to get the base addr directly
which could be often the case. While the remaining struct map is only
used to unmap things. To be precise, we do not check a bool here but
instead an address to be non-zero. Please to not change the return
value.

We did not use devm_* here to allow temporary mappings during init
(which might happen multiple times). With devm_* only one permanent
mapping would be possible and we would need to store and maintain the
base addr in some struct. This implementation here allows a local
usage.

> 
> >> +}
> >> +
> > 
> > This is similar enough to devm_cxl_iomap_block() that I'd kind
> > of like them them take the same parameters.  That would mean
> > moving the map structure outside of the calls and instead passing
> > in the 3 relevant parameters.  Perhaps not worth it.
> > 
> The intent was to cleanup the cxl_map_reg() callers.  Using a 'struct 
> cxl_register_map' carries all the variables required for mapping and reduces 
> the number of variables otherwise declared in the callers. But, I understand 
> why a common interface is preferred in this case.
> 
> Ok. I'll change the parameters and return value to match devm_cxl_iomap_block(). 

See my comment above.

Struct cxl_register_map was choosen to keep data in one place and also
for paired use with cxl_map_reg() and cxl_unmap_reg() (in the sense of
an object-oriented programming style). The struct is widespread used
in CXL code for similar reasons. I would prefer to keep the struct as
argument.

> 
> >> +static void cxl_unmap_reg(struct device *dev, struct cxl_register_map *map)
> >> +{
> > 
> > dev isn't used here either. Makes little sense to pass it in to either funtion.

Yes, dev should be removed for both functions. Thanks for catching
this.

-Robert

> > 
> >> +	iounmap(map->base);
> >> +	release_mem_region(map->resource, map->max_size);
> >> +}
> >> +
