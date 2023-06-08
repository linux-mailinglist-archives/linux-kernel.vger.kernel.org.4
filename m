Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4922C727AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjFHJHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjFHJHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:07:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E61734;
        Thu,  8 Jun 2023 02:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJGZ3EMZ10qTWsw4hFrFCzn4KbdXF+8sUUubPAJplkKg7WpYUrZXBe01TunMaK85bYnNNSkIaSYbm7a/FZOwrRRPtBLCwOjll4NkA00U/Nng5tyoac9J8hin161MjwngwFvPixdG6991pxNwXh8wt12XblPJnur/dO2VKKR8GzvVC5vElXWNCN9+S1Ev3p6rwfw0ePULN8hOoIPOcPkyPuYhA5/vydF7TqcLfkNsaDSIL7cIY4NTzZVDw2WPJ+mKHPnAzz/6p+yFWXXsm37KLxo84d63cenNHuP25q0zFdS9V4G8QG5snsdETfh2tCvP5lf1/BWAQqXXXEYr1xOWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRbnayNpo3dBeUWLhEkQJsnxKwdOEEe5t2sT36Lps1A=;
 b=XabIVumtClK7frzLBpXL/o2ZWOnDZgJaO6SRAqzQ+lpqwQ0X8EvoFQ3MGDy4jwgPlYGWfwcvKIKefKYHEnSbDYZ5+2Oj2vv8mYGfRBh+LySSNedF6byL8Qnc77cxVdjg/RlnmEdKriJG3Jafz5G/PHY0WpOdBOYpO1MUjo8QJXxIyecgsAUcyI07Il8ViPFrCK3jDgoULt6niQeebXybgG4llbwVdiVg8jhKd/cJIxFKgrQ/PqYvS5KEhHw3vIcjbOng/J2lpP22xahJeTtnc0HQqjoITPEJZ7RI3uRWyg+Clb4eaSwFrcDS6NYa0IybCwp/ho9jqcOv99JMWKBsWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRbnayNpo3dBeUWLhEkQJsnxKwdOEEe5t2sT36Lps1A=;
 b=Q2Ds3whc4XCUqYTPqiKGNWt8yuGS1qMWy7TyYY8x8op08FufDCvN93rzcpB6TspATFE5ozUq/Em7Zq+Bk97KRU/FK8JSCYPOBpqiDitUsNiNHMKOYUIoHfdst9qHiTU9drljW2nnYE7qGohCCHeFvF9BsTWPq1uqgcnxsKTpxnQ00Z6U7bq7OM+vZrtzKZe0/7pMZItrnmnyosh2WiCjHFtv2UWUgL90nQB1JgoBfID8MTlTRC1huzg4cTBfiH2PAXlvjeUHGVeJONLmOEmoDpao/+feWWYMq7TLraMaApJAG3ZK5BZR2Re2qhrEoOFo5vJH0U1YZrrLyLziMBS/8w==
Received: from SN1PR12CA0057.namprd12.prod.outlook.com (2603:10b6:802:20::28)
 by PH7PR12MB7871.namprd12.prod.outlook.com (2603:10b6:510:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 09:07:09 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::bd) by SN1PR12CA0057.outlook.office365.com
 (2603:10b6:802:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Thu, 8 Jun 2023 09:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 09:07:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 8 Jun 2023
 02:07:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 8 Jun 2023 02:06:59 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.181) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 8 Jun 2023
 02:06:59 -0700
Date:   Thu, 8 Jun 2023 12:06:58 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZIGaMntRUmgatjZE@44189d9-lcedt>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
 <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
 <ZICo8wYqM8tmCEob@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZICo8wYqM8tmCEob@orome>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|PH7PR12MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: bf414593-84eb-404d-0b62-08db67ffbdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBAlpkPmiBgwtmWGJ3S4RkLqPlOh+aG1gJ/dfpn/driNx1OQqrh0h0EJ29Rm19JMBe8j1Eg8QxBzKaoeyQ9PoF7dR4lZRojRb3SeaIde3BwvTJ8TsPrpgDtEYx/d/1qHwjVr5MmLcmZWjs89g0MBXWEHNDc5sA299tlxEbChquJLMV5M27aNF3HEqWJieD6rec4CFcf/2ZMRacmmRAuh/SLRIPf+/mbJiSb/W87psiz10C7PVNaIwu8DUzcZTzdFx8lpECJ5XoS6XohPLX4uQhfz1QRByQ3wrKrGgniuwDm9XF9p4EEEA6NvBqjPUwPSDaoGyOchqpQv7xuO7kuaaFMDDk/6DdZ/NMCM/9kXD2Iei6oEnaVW2AxVXKWiwPnbghjv4xlDu7mX2VWobPbkgm661CgsB3Z8vMpzV8Ogm8NxxCxGffo0f9gCv/4tA7hv14T4VGlIOuxnZjprU5JAUCV5QVO6kjgnDTKRQQI+8U3JhDwc8Zvlyretrk0HmoBCdX/wfcQ1rYUXMd7PQjhSaSZ4MCM7fHTpAPqP3aLjvhnBTn1mq9G+G4SZFXtOmAwTLtzV0fHLHu4ZQKZUo9ESHeQ9azE8YpvvpgXH9AWizX+RM6VvKiUpqIR+BfDwNwAtpRd2QBHyfu91XL1VeMRf7hmgP8Q3Bv9k4zrGwp0bVK8cTh+QtdiesvvN/Dr4qIWDEC6CSaBbDngYBnYNYQIFvzf4zD1RjbBh1JKbnpSD2pSn8shEEWdYpatOFQEsVigN
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(316002)(5660300002)(2906002)(478600001)(41300700001)(54906003)(66899021)(70206006)(4326008)(6916009)(70586007)(8936002)(8676002)(9686003)(26005)(40460700003)(356005)(82740400003)(33716001)(186003)(40480700001)(47076005)(83380400001)(7636003)(36860700001)(82310400005)(336012)(426003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 09:07:09.9451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf414593-84eb-404d-0b62-08db67ffbdc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7871
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 05:57:39PM +0200, Thierry Reding wrote:
> On Tue, May 16, 2023 at 12:55:03PM +0300, Peter De Schrijver wrote:
> > On Tue, May 16, 2023 at 11:35:24AM +0200, Thierry Reding wrote:
> > > On Thu, May 11, 2023 at 04:20:51PM +0300, Peter De Schrijver wrote:
> > > > Implement support for DRAM MRQ GSCs.
> > > > 
> > > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > > ---
> > > >  drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-------
> > > >  drivers/firmware/tegra/bpmp.c          |   4 +-
> > > >  2 files changed, 168 insertions(+), 68 deletions(-)
> > > > 
> > > > diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
> > > > index 2e26199041cd..74575c9f0014 100644
> > > > --- a/drivers/firmware/tegra/bpmp-tegra186.c
> > > > +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> > > > @@ -4,7 +4,9 @@
> > > >   */
> > > >  
> > > >  #include <linux/genalloc.h>
> > > > +#include <linux/io.h>
> > > >  #include <linux/mailbox_client.h>
> > > > +#include <linux/of_address.h>
> > > >  #include <linux/platform_device.h>
> > > >  
> > > >  #include <soc/tegra/bpmp.h>
> > > > @@ -13,12 +15,21 @@
> > > >  
> > > >  #include "bpmp-private.h"
> > > >  
> > > > +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM };
> > > 
> > > Still not convinced about this one.
> > > 
> > > > +
> > > >  struct tegra186_bpmp {
> > > >  	struct tegra_bpmp *parent;
> > > >  
> > > >  	struct {
> > > > -		struct gen_pool *pool;
> > > > -		void __iomem *virt;
> > > > +		union {
> > > > +			struct {
> > > > +				void __iomem *virt;
> > > > +				struct gen_pool *pool;
> > > > +			} sram;
> > > > +			struct {
> > > > +				void *virt;
> > > > +			} dram;
> > > > +		};
> > > 
> > > The drawback of these unions is that they can lead to ambiguity, so you
> > > need the tegra_bpmp_mem_type enum to differentiate between the two.
> > > 
> > 
> > No, on the contrary, now it's clear you can either have void __iomem *
> > and struct gen_pool * or void *virt but not both.
> 
> No, it's not clear. You can have one part of your driver write the
> sram.virt field and another read dram.virt and they'll end up pointing
> at the same memory location but with different meaning. That's why you

No. You can't the union in combination with the discriminating enum
tells you you should only either sram or dram.

> need to introduce the enumeration in order to specify which one of the
> two you want to pick.
> 
> And that's exactly where you start introducing the potential for
> inconsistency: now you need to be extra careful that the enumeration and
> the unions are set correctly. You effectively have two sources of truth
> and they don't necessarily match. You can also end up (at least
> theoretically) with the invalid value, so you need an extra check for
> that too.
> 
> You can avoid all of those inconsistencies if you reduce this to one
> source of truth, namely the pointers that you're going to use.
> 

I don't think pointers should be used as a discriminator.

> Your variant would be slightly better if you omitted the invalid value
> because then you could still have an internal inconsistency, but the
> likelihood is much reduced.
> 
> > > If you change this to something like:
> > > 
> > > 	struct {
> > > 		struct gen_pool *pool;
> > > 		void __iomem *sram;
> > > 		void *dram;
> > > 		dma_addr_t phys;
> > > 	} tx, rx;
> > > 
> > > you eliminate all ambiguity because you can either have pool and sram
> > > set, or you can have dram set, and depending on which are set you know
> > > which type of memory you're dealing with.
> > > 
> > 
> > No. You just add ambiguity. It's not clear from looking at the data
> > structure which fields are valid for which case.
> 
> That's easily fixed by adding comments explaining what you use them for.
> But the code should make that pretty clear already.

No. The code should follow the data structures, that's why unions exist.

Peter.
