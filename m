Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280327206B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjFBP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjFBP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:59:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38400197;
        Fri,  2 Jun 2023 08:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBoGrg0YqnAR7fhrEynf8K8eYYJGNktz3wQESHAaJNaKejdca1jKArwxqqEnu5jA/mzJcsrkQjOhIp0AWZQDUMozbIZeOJjR6JiX/4bY34uBbOTTbGOs5xyjRM4xkYX06JtyMmjMjal8xM56zAKpcxrO8V27PxHp4/eVeAH8evAzRgSUAw2s6gOyU8+tCKDr4ti4ISBxDNzOsP8JTft7X9u/CkXvuuq+xpaX9/XGdTXoh905goQXHqZEtdItJni9tsT7ITJrnPtGvkLoGL79Kr7joe+jjj3l+G5b79A4rnc7hIiK+8E1RrH6adPUYkB0618bZ7j4O+SCIWezegmvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UGLJEoM9D4i8/KuRxulbWmowU6VdsqF9Mm+j5WY/TA=;
 b=Xp0oOg2dw053a8yLkuvOPztRrUgtpzXKg03+IvZXvnYZJ8tmQG65ktfJ5GoeoCqZe97XkFj+tIekHvC4rcd0LaCxqaWzh9myOk5tIhBXe4OWV01hcXRBLnyjPFU+KmQXSw7Lmpeht0bq1ssB25V+lDvwaZ5EFKOSNwIpYUjGD+91nTYAAReBm5bXLAOgobu7fULqEjQ+YlL4KYAW4wfQ0Yg0iTBs1yB2B0ApAOZ/DqWvux9Rv+zcdChioAapgwYsBM3v2v95eFMeE9xlH4Wm4GXrldSVo8ECQ9UnqaO9HChCgatlXwRaNVn3bVfkMr6a9y6Z7LfG5W8Yj6PhOR2Caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UGLJEoM9D4i8/KuRxulbWmowU6VdsqF9Mm+j5WY/TA=;
 b=LzimRbV9MqzaxjYpTiU4bOhLxDalYylHW4FJssIz9fErKDcGRrJ3/mRtzjJ7vX5SuHvDykVvUjk8FAnlehF03irc3iQYeoNnLGZOKQnHEZVNAIttPMO9C5qb5u4V0Kns6M07+nYj8i4ZEolfCCvXzMP4pRew9MuiO1anB8xox8c=
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 15:58:58 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::d1) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 15:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.27 via Frontend Transport; Fri, 2 Jun 2023 15:58:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:58:55 -0500
Date:   Fri, 2 Jun 2023 17:58:49 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v4 10/23] cxl/port: Store the port's Component Register
 mappings in struct cxl_port
Message-ID: <ZHoRubXqiwlH3mgu@rric.localdomain>
References: <20230523232214.55282-1-terry.bowman@amd.com>
 <20230523232214.55282-11-terry.bowman@amd.com>
 <20230601140603.00007ba2@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230601140603.00007ba2@Huawei.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT034:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e08617-69a5-4b7b-fb4b-08db63824625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBNF0iQYPed9M4nmo+4twlRXoSohIyVIkdwieAea/HvONMzwsdFiy2DiyUB3D2b1GbfeZEhNgOXOP1RPkghEFKyT+XoM4JRPPW/OI1DJeplbyceq+WiGU4o9w463F5daL0sCheky0pRbAWLxA6aG0b694l67HwwayUU015vTo/Me4Ac4RpMdURTtLtlm0tCmL9KfA/B0N3gZISKxFZUfokIDviTkJ+tF8mRodmg5v5TITJKMDAItDbMELIoqh+y+fTHxc4Of4l6pZAvxVa0yKZyHIlysQRZV/eTdl6il6m+xX1jpDQIZNuM2QUTD73RH4rH4Qg+QeIpap5CTV63aPDG/jOBP4Jj1WZY3RTu+PE/99m4WtrtcG9cqvfe5WCcuVMKgfxGJr/Pz5wGn5Y0pYiOiuU1pZV1VUQ1FhDB+liqudXLHvKIULIzlhYxrj1tQ9Xo8Zc22k/bbk9RC0aKGj8GqSSXvxxn+txMD1Jqc1T7BYxHns5Z2HLdJLnU2iJYAb0y7vGC9UL7CVe+roiw6E8iKlOYz6KvB/t3fS91/ZlehUt2kwkEqqEToePLrwGonoRpI32+VPGvHRq7HBV9Fzs8vBwK88+DNiyKEQYHoIBsz81IDjTjXwe8UhnigbDwmmbF/u2C8XhLiA70GyNelE9jVM9OK7M3wpTeD+P8GT42XnDQLD2NlH63OmusIa68oV/LifVZAQzPJpnymeFhkI1JOJ4fHiyjnGlFv1dZC5FSS+c9VcJUJU/aLZHxHGXifQ2tpT8uv7nsijCodDXjgfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(6666004)(7696005)(40460700003)(478600001)(36860700001)(83380400001)(16526019)(186003)(26005)(9686003)(53546011)(426003)(336012)(356005)(81166007)(82310400005)(47076005)(82740400003)(55016003)(40480700001)(7416002)(2906002)(6916009)(70206006)(70586007)(4326008)(316002)(8676002)(8936002)(54906003)(41300700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:58:57.6381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e08617-69a5-4b7b-fb4b-08db63824625
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969
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

On 01.06.23 14:06:03, Jonathan Cameron wrote:
> On Tue, 23 May 2023 18:22:01 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > CXL capabilities are stored in the Component Registers. To use them,
> > the specific I/O ranges of the capabilities must be determined by
> > probing the registers. For this, the whole Component Register range
> > needs to be mapped temporarily to detect the offset and length of a
> > capability range.
> > 
> > In order to use more than one capability of a component (e.g. RAS and
> > HDM) the Component Register are probed and its mappings created
> > multiple times. This also causes overlapping I/O ranges as the whole
> > Component Register range must be mapped again while a capability's I/O
> > range is already mapped.
> > 
> > Different capabilities cannot be setup at the same time. E.g. the RAS
> > capability must be made available as soon as the PCI driver is bound,
> > the HDM decoder is setup later during port enumeration. Moreover,
> > during early setup it is still unknown if a certain capability is
> > needed. A central capability setup is therefore not possible,
> > capabilities must be individually enabled once needed during
> > initialization.
> > 
> > To avoid a duplicate register probe and overlapping I/O mappings, only
> > probe the Component Registers one time and store the Component
> > Register mapping in struct port. The stored mappings can be used later
> > to iomap the capability register range when enabling the capability,
> > which will be implemented in a follow-on patch.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Some minor comments...
> 
> 
> > ---
> >  drivers/cxl/core/port.c | 26 ++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  2 ++
> >  2 files changed, 28 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index eff91f141fde..34e929f1723b 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -686,6 +686,28 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >  	return ERR_PTR(rc);
> >  }
> >  
> > +static int cxl_setup_comp_regs(struct device *dev, struct cxl_register_map *map,
> > +			       resource_size_t component_reg_phys)
> > +{
> > +	if (component_reg_phys == CXL_RESOURCE_NONE)
> > +		return -ENODEV;
> > +
> > +	memset(map, 0, sizeof(*map));
> > +	map->dev = dev;
> > +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
> > +	map->resource = component_reg_phys;
> > +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
> setting most elements. Maybe
> 	*map = (struct cxl_register_map) {
> 		.dev = ...
> etc is cleaner and effectively the same thing.
> 	};

I really like the memset() pattern for this. See my comment in an
earlier mail for this.

> > +
> > +	return cxl_setup_regs(map);
> > +}
> > +
> > +static inline int cxl_port_setup_regs(struct cxl_port *port,
> > +				      resource_size_t component_reg_phys)
> > +{
> > +	return cxl_setup_comp_regs(&port->dev, &port->comp_map,
> > +				   component_reg_phys);
> > +}
> > +
> >  static struct cxl_port *__devm_cxl_add_port(struct device *host,
> >  					    struct device *uport,
> >  					    resource_size_t component_reg_phys,
> > @@ -709,6 +731,10 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
> >  	if (rc)
> >  		goto err;
> >  
> > +	rc = cxl_port_setup_regs(port, component_reg_phys);
> > +	if (rc && rc != -ENODEV)
> > +		goto err;
> 
> I'd add a comment on why not being present is fine here.

Yes, will add that.

"Some components may no capablities or implementation is optional. So
do not fail here if no component register block exists and
component_reg_phys is unset. Instead run the check later when setting
up the capabilities."

Thanks,

-Robert

> 
> 
> > +
> >  	rc = device_add(dev);
> >  	if (rc)
> >  		goto err;
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index e5ae5f4e6669..c76e1f84ba61 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -552,6 +552,7 @@ struct cxl_dax_region {
> >   * @regions: cxl_region_ref instances, regions mapped by this port
> >   * @parent_dport: dport that points to this port in the parent
> >   * @decoder_ida: allocator for decoder ids
> > + * @comp_map: component register capability mappings
> >   * @nr_dports: number of entries in @dports
> >   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
> >   * @commit_end: cursor to track highest committed decoder for commit ordering
> > @@ -571,6 +572,7 @@ struct cxl_port {
> >  	struct xarray regions;
> >  	struct cxl_dport *parent_dport;
> >  	struct ida decoder_ida;
> > +	struct cxl_register_map comp_map;
> >  	int nr_dports;
> >  	int hdm_end;
> >  	int commit_end;
> 
