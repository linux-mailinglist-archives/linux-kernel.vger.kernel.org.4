Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA27049BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjEPJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjEPJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:55:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6062F1713;
        Tue, 16 May 2023 02:55:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0mgTMDHnuLL9H10EH0n0kGJBxPMl+tKOGKyPW+mOXnoMZSe4JJw9mXcsphxte7r1M80ojIzGULgP/5gh284BNEQ1s9INWjI2AayuvlAByRWhQvmZccqlvfQQSIjuwdyfZOuNVB5ix/iCqRoNA4BNQGn5N9tnPRHdRjLmoWl3X3zbjvdRFoBfmOHadOmfzw0iE+Nuxw7z1469H1x8Vpf4++lOrr9feowMLDDJ1h/aKkjDlbCaZi03Ij9Q77yJ2xHjvQ7vGNHjH7/R/O/X15FF2GMcRhQ9tdQilSBdUfjy85rOvdcUM/XWHDSOQenUDIgaL1J/pZrnTMykwDSHJ4WUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+j5MZRUnYmXi7IcD6B/kQsIJuStf3M4ZEVIFfPndpM=;
 b=CpIzRG3nYE8qgBmhjsnpXUkFZlFuFvT7qBLGgWru60UPmcXSjbz/k6uvj/sPLkpbu/1d2h48NUWXdGmWqLIy4pELXHipRfZwuKDUe03CNCiPuQSC69ijSxykeEp26lNIFAJq4SSeFd8pw6sDKfxnik1j15UxAxVq0FAH87dGpgDKSbpE3Zo1i/1a57iLaXJzmydqO3HJ8zM8u5btQJUZP6UyPlZRbiUd3ux8lZeiCNSTEiPJnLKclsKsNjC08bOH00FzTtTmzpDW0h3wcmtbzj6J5OLyp1nLlJNUbeU4FCsK2jIrU7s3qS97wYg7eowrxjb6cDDU7IAl3Xxi1colmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+j5MZRUnYmXi7IcD6B/kQsIJuStf3M4ZEVIFfPndpM=;
 b=iGUJt2bQkpFl0GsY1MJn171mI8Lr/ppbunZIa8MXADDrbFe7Rl330LVnpe8eb79JE+oVElIB3zgnPDIqAjcfvQj/S1cwRcVGNQvO6WOHKEGghsezjOp62CIrRqTHqsdfK6b0agTPnpQqUo2Pmx7T2DtKEXYUT8MRUkn5KCAjVs63mL43iQMYCHoIjAG9SUYmf7eZzDxNTLaDRCRLQziwh5okDDU+/bXaeaJ40UR57t4Wi8bgsAke+4HaqUzSNWAEhV8sqHcqSqCu/WJE0RhBI+PTkn7PDTtQgw+2H6Voaf5VCdW5AXg1Uz2Wicu4NQbnx+hGI2ZjrChoqjLrs9LbRw==
Received: from DS7PR03CA0355.namprd03.prod.outlook.com (2603:10b6:8:55::30) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 09:55:15 +0000
Received: from DS1PEPF0000E64A.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::74) by DS7PR03CA0355.outlook.office365.com
 (2603:10b6:8:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34 via Frontend
 Transport; Tue, 16 May 2023 09:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E64A.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Tue, 16 May 2023 09:55:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 16 May 2023
 02:55:05 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 16 May
 2023 02:55:05 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 16 May 2023
 02:55:04 -0700
Date:   Tue, 16 May 2023 12:55:03 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>, <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZGNS9w+i9Y9gpz6R@44189d9-lcedt>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
 <20230511132048.1122075-7-pdeschrijver@nvidia.com>
 <ZGNOXO3rRtFx_12R@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZGNOXO3rRtFx_12R@orome>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E64A:EE_|MN2PR12MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d28380-073f-42fe-b5f2-08db55f3a5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d14dlrQdlhKZUh1GptFW37LBO5nS4tNRUWe4pfqTkqny5EXrtLklNlxPjZGGl0b8+r4vYqTfC9DH6SElrDfAfmmb+T7lWakDTbIVLLaDHMKMNTSwjGzZobFjdY4Ts7CjzzsZnnsp/qlSDUSZWPanwbhMvmX30kR18BdavgOMI0FL5mFYa4NmKfkaKnorKwPA6QEushZwmRePogqsvZJ0YfzSg3AoKZrgNdSYZ1kWGjokyU/ilJ0vFhUATBZ6NvZgSIk5yDAuFXDFFmhb6LQ047RldxujZ3oq43OUlJOdM3kEMVuEQaIHRwH6CQUxv0qXsVJqInC53K2EnT4aZeYghJqZIgR3ZHa3j7x1Y7t+jzCjCBZ93Zuj5RtrEVETTueJ9WgxOnlvdYQb2vrPYzDh4CcP61rfjG4Dru57JX8FQxFH4s77PbYWVcAJ63BFbk8vjeLnemIe6qviXL9YNDdxC+pR80x8YxYX02sXFJN2+4TytNCkEDPDvMxT2G+gIQZqqBKyl5g/zVn1TF039ubjSuik1heCTPjtWkxoZPUQSTs77IqR4/lJj8CzhjFqMnTCTfIlAoGZLnvoaSibqfaG6WGzSXFmoie4ndX9f4X4xogQ7nYOqEzR82b5/e0OUa+aOcOqsujnEIrh6TsybkByVdt+2wQj+P1faDoiBZ2m5WbSQOn9VmkM4NweiXjLUIVCIbT7hdoDuDbXi18WWFh8aXvXlClu/ID21dkR1PSwusVD6KH7pwoLEVbR2tDxVwEZWpTwca44ueLD8PX4IAQzZw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(83380400001)(26005)(36860700001)(186003)(47076005)(9686003)(426003)(336012)(40460700003)(5660300002)(82310400005)(33716001)(7636003)(356005)(82740400003)(54906003)(86362001)(41300700001)(316002)(70206006)(70586007)(6916009)(4326008)(8936002)(8676002)(66899021)(478600001)(2906002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 09:55:14.6034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d28380-073f-42fe-b5f2-08db55f3a5a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E64A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 11:35:24AM +0200, Thierry Reding wrote:
> On Thu, May 11, 2023 at 04:20:51PM +0300, Peter De Schrijver wrote:
> > Implement support for DRAM MRQ GSCs.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/firmware/tegra/bpmp-tegra186.c | 232 ++++++++++++++++++-------
> >  drivers/firmware/tegra/bpmp.c          |   4 +-
> >  2 files changed, 168 insertions(+), 68 deletions(-)
> > 
> > diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
> > index 2e26199041cd..74575c9f0014 100644
> > --- a/drivers/firmware/tegra/bpmp-tegra186.c
> > +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> > @@ -4,7 +4,9 @@
> >   */
> >  
> >  #include <linux/genalloc.h>
> > +#include <linux/io.h>
> >  #include <linux/mailbox_client.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >  
> >  #include <soc/tegra/bpmp.h>
> > @@ -13,12 +15,21 @@
> >  
> >  #include "bpmp-private.h"
> >  
> > +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_DRAM };
> 
> Still not convinced about this one.
> 
> > +
> >  struct tegra186_bpmp {
> >  	struct tegra_bpmp *parent;
> >  
> >  	struct {
> > -		struct gen_pool *pool;
> > -		void __iomem *virt;
> > +		union {
> > +			struct {
> > +				void __iomem *virt;
> > +				struct gen_pool *pool;
> > +			} sram;
> > +			struct {
> > +				void *virt;
> > +			} dram;
> > +		};
> 
> The drawback of these unions is that they can lead to ambiguity, so you
> need the tegra_bpmp_mem_type enum to differentiate between the two.
> 

No, on the contrary, now it's clear you can either have void __iomem *
and struct gen_pool * or void *virt but not both.

> If you change this to something like:
> 
> 	struct {
> 		struct gen_pool *pool;
> 		void __iomem *sram;
> 		void *dram;
> 		dma_addr_t phys;
> 	} tx, rx;
> 
> you eliminate all ambiguity because you can either have pool and sram
> set, or you can have dram set, and depending on which are set you know
> which type of memory you're dealing with.
> 

No. You just add ambiguity. It's not clear from looking at the data
structure which fields are valid for which case.

> Plus you then don't need the extra enum to differentiate between them.
> 

That is a limitation of the C programming language yes..
What you would really want is something like this:

struct sram {
	void __iomem *virt;
	struct gen_pool *pool;
};

struct dram {
	void *virt;
};

enum half_channel {
	sram(struct sram),
	dram(struct dram),
};

struct tegra186_bpmp {
	struct tegra_bpmp *parent;
	...
	enum half_channel tx,rx;
}

> Another alternative would be to use something like:
> 
> 	union {
> 		void __iomem *sram;
> 		void *dram;
> 	} virt;
> 
> if you want to avoid the extra 8 bytes. But to be honest, I wouldn't
> bother.
> 
> >  		dma_addr_t phys;
> >  	} tx, rx;
> >  
> > @@ -26,6 +37,8 @@ struct tegra186_bpmp {
> >  		struct mbox_client client;
> >  		struct mbox_chan *channel;
> >  	} mbox;
> > +
> > +	enum tegra_bpmp_mem_type type;
> >  };
> >  
> >  static inline struct tegra_bpmp *
> > @@ -118,8 +131,17 @@ static int tegra186_bpmp_channel_init(struct tegra_bpmp_channel *channel,
> >  	queue_size = tegra_ivc_total_queue_size(message_size);
> >  	offset = queue_size * index;
> >  
> > -	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
> > -	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
> > +	if (priv->type == TEGRA_SRAM) {
> > +		iosys_map_set_vaddr_iomem(&rx, priv->rx.sram.virt + offset);
> > +		iosys_map_set_vaddr_iomem(&tx, priv->tx.sram.virt + offset);
> > +	} else if (priv->type == TEGRA_DRAM) {
> > +		iosys_map_set_vaddr(&rx, priv->rx.dram.virt + offset);
> > +		iosys_map_set_vaddr(&tx, priv->tx.dram.virt + offset);
> > +	} else {
> > +		dev_err(bpmp->dev, "Inconsistent state %d of priv->type detected in %s\n",
> > +				priv->type, __func__);
> > +		return -EINVAL;
> > +	}
> 
> With an enum you need to do this because theoretically it could happen.
> But practically it will never happen and you can just rely on the pool
> variable, for example, to distinguish.
> 
> Thierry

Peter.
