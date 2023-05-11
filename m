Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD136FED6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjEKIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEKIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:04:34 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD82684;
        Thu, 11 May 2023 01:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+sNtsH48pUOjG6XGiBDRLwMbmMgTAUcqYggrG10aMKU8uEjRC91kK3eI+FbpJVLo2+WqKZaxtQlvPGDoZcI6mQ4AxY8XFGIWr8AnfQyckK25A6BGGIdIOzFN/ctJWSIM0mDlYjdfd4ylJqDpYwWlxnvnD9XXS2KoeK98Se2AqWDjCq52HFKp70KoamuDcpdgWK60yWuXkqFNaIO/gy9uLJlbKJislBJUQwHPDvhHhaQCQWMQo8ef4cbDYU8e0zP581n/98TeiwZFa742YgL1wCPNvsXBKUglLPj/mJloj8gaN5vi1YZYfi9mW/9WsuK5iyFgLOrOp9WhzW91Z2+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd3FfN2KSWugMn7UXmjYvjBj4KwOhauukXosJfuenFg=;
 b=EfxRDWQfXOcjH/adZfRRJX/ct4Ddtj7jxUEsPAp+ClHcNpKG71Khws9QPS4wLITfdZBkrklHeW/aC9wBQv4YU5CcpBv2IASl7ZPnVyEyhWn50iSwQSgJpWgL+EnTjTs265FwnktyQbbeztGYE6j3qndeYZkYNvbl5QkydpRegqObuI4rvWUBfdfZ/J6uvXVCldH78/qxVF8meyZr2y0iuF/pxNjkb7mhkF3O9KEsYKgAeqRlASXPETgG12ZG+dIoOag1+O8jqZgp10yV1Mmpvw41SmgIVnD+RDGYIt3xNkeqOfvJyZcLyr26w/zIVCTujOE98jM4oRJ0BxwVGwJ1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd3FfN2KSWugMn7UXmjYvjBj4KwOhauukXosJfuenFg=;
 b=Nl6ovHRHMqDjpfGrXnt6wvxDlDICg2Cd/jCxKqDr4R1XL6rGeqrZ1WkQ0xGBaaNffTW2utr89tJHMT4ZaMhpeslinZYaXO8d79zKHZ6fXmzA1LRCU+Fq7fYR4YmdO3BgivcSfO+1OAL309CzI3tWS5K04Vyk1f7dSOw+d++tcPbzfFKnkGFfuntQdPRQ3Ckkpyk+PzuVNrXFK82IU4PWW7zrs/TYsiHJpP77q5TcfvA8gmg9lW9AmEMPBhAl5LUIP2QdHyq5eISqM0tc26VoDmx05L49TOZOOs1vM1hOibFUpKHBEput9Ff3w1mCrASrcZ3nhRJGAbuOIXY2WXw8Bw==
Received: from MW3PR06CA0003.namprd06.prod.outlook.com (2603:10b6:303:2a::8)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 08:04:15 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::a4) by MW3PR06CA0003.outlook.office365.com
 (2603:10b6:303:2a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 08:04:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 08:04:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 01:04:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 01:04:02 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 11 May 2023
 01:04:02 -0700
Date:   Thu, 11 May 2023 11:04:01 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <mperttunen@nvidia.com>,
        <sudeep.holla@arm.com>, <talho@nvidia.com>, <robh@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stefank@nvidia.com>
Subject: Re: [PATCH v2 6/6] firmware: tegra: bpmp: Add support for DRAM MRQ
 GSCs
Message-ID: <ZFyhcYyV0qCZqLzE@44189d9-lcedt>
References: <20230510113129.4167493-1-pdeschrijver@nvidia.com>
 <20230510113129.4167493-7-pdeschrijver@nvidia.com>
 <ZFurPwSFixGsXfyN@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZFurPwSFixGsXfyN@orome>
X-NVConfidentiality: public
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d419e6e-bb4f-442f-c3f4-08db51f6508c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tybDQYsMEowOKCpVV06b7TXDy/nlSITnGSEv8SB9AR/t7JHCDjPFMxdR0yw60ZCIU8idZkggzyAoHYX3YKN+j7EoYjbgUBPH1ZYhHoOxLSLZFpxu0ah5umsjh/jClsoOiziP0yo/pQtTptwyl2kGjaczQoYnDqQ+AbS/QbVsem8gj5fYZ8scCji+pcyiC6lzVF90ngghoTrGCSBgjiALnpd2JOBZkj5sqtS1KVDzPQkHSvjlfzIQnu6aMsy37uQjCdFrLmz4G+7oAVMWlv6l3LCQ5HZ0poo3Ulc82ESCvNDZ0LbeOCMW5yh6hn3AcaiSWPeDAE7bDv31nC77q4JNImBH7f5m2e7kMqc8STq77Wl2iJxfp/zeNtmwbi2sHS1KUNspLdAgJtkazD1Vc+m61mozSLyRGZGUTrk01iHU4DwDXzpV93zIc7B1k2N+JsYoTN+pHQW6SJa5UxFEymwB5BzrNRBZ86kczvtTraXzSlzK0gs+eguTe7sc0ODczp+mH5nGL8seOz7bpMX8eSRg9nOQJwytAN36WndFe0rMBQ4nIRmkCyeVBafXhPO6MYuzSB+wKI3ph8VSxTK1oJwF85yebSALz27aS6n60mBaIKjlleSb3efwXFcjPMe3LnGcpoO7qYNBfFMWBuZqoWTHVFLu9P2L7FKySGP6npw6R6DqPZ0oDM2gyuHcX5waG00+GFvQuslCLTva4+lDPO2kHgY/DVUFdwmEJVhwqtzncKu9D9oYQwgEqOPbi7kywW6E
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(7916004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(186003)(86362001)(83380400001)(30864003)(356005)(41300700001)(7636003)(47076005)(107886003)(26005)(426003)(36860700001)(9686003)(336012)(33716001)(54906003)(66899021)(5660300002)(8936002)(8676002)(40460700003)(82310400005)(478600001)(6916009)(4326008)(82740400003)(316002)(70586007)(40480700001)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 08:04:15.7170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d419e6e-bb4f-442f-c3f4-08db51f6508c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 04:33:35PM +0200, Thierry Reding wrote:
> On Wed, May 10, 2023 at 02:31:36PM +0300, Peter De Schrijver wrote:
> > Implement support for DRAM MRQ GSCs.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/firmware/tegra/bpmp-tegra186.c | 214 +++++++++++++++++--------
> >  drivers/firmware/tegra/bpmp.c          |   4 +-
> >  2 files changed, 153 insertions(+), 65 deletions(-)
> > 
> > diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
> > index 2e26199041cd..43e2563575fc 100644
> > --- a/drivers/firmware/tegra/bpmp-tegra186.c
> > +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> > @@ -4,8 +4,11 @@
> >   */
> >  
> >  #include <linux/genalloc.h>
> > +#include <linux/io.h>
> >  #include <linux/mailbox_client.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/range.h>
> 
> Why do we need range.h?
> 

We probably don't need this indeed.

> >  
> >  #include <soc/tegra/bpmp.h>
> >  #include <soc/tegra/bpmp-abi.h>
> > @@ -13,12 +16,13 @@
> >  
> >  #include "bpmp-private.h"
> >  
> > +enum tegra_bpmp_mem_type { TEGRA_INVALID, TEGRA_SRAM, TEGRA_RMEM };
> > +
> 
> This is a strange construct. We can already use the pool pointer to
> determine which type of memory is being used. Your usage of this leads
> to very unintuitive code when you're error checking, etc. and prevents
> you from propagating proper error codes.
> 

No? How would indicate SRAM and DRAM are mutually exclusive?

> >  struct tegra186_bpmp {
> >  	struct tegra_bpmp *parent;
> >  
> >  	struct {
> > -		struct gen_pool *pool;
> > -		void __iomem *virt;
> > +		void *virt;
> 
> I think what we really need is a union that contains both an __iomem
> annotated pointer and a regular one.

And then add a struct gen_pool * in the union and use the enum as a tag.

> 
> >  		dma_addr_t phys;
> >  	} tx, rx;
> >  
> > @@ -26,6 +30,12 @@ struct tegra186_bpmp {
> >  		struct mbox_client client;
> >  		struct mbox_chan *channel;
> >  	} mbox;
> > +
> > +	struct {
> > +		struct gen_pool *tx, *rx;
> > +	} sram;
> 
> Please keep this in the tx/rx structure. This would perhaps be useful if
> there was an equivalent "dram" structure, but as it is there's no
> advantage in keeping this separate from the other memory-related fields.
> 
> > +
> > +	enum tegra_bpmp_mem_type type;
> >  };
> >  
> >  static inline struct tegra_bpmp *
> > @@ -118,8 +128,8 @@ static int tegra186_bpmp_channel_init(struct tegra_bpmp_channel *channel,
> >  	queue_size = tegra_ivc_total_queue_size(message_size);
> >  	offset = queue_size * index;
> >  
> > -	iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);
> > -	iosys_map_set_vaddr_iomem(&tx, priv->tx.virt + offset);
> > +	iosys_map_set_vaddr_iomem(&rx, (void __iomem *)priv->rx.virt + offset);
> > +	iosys_map_set_vaddr_iomem(&tx, (void __iomem *)priv->tx.virt + offset);
> 
> This completely defies the purpose of using the iosys_map helpers. What
> you really want to do is check if we're using SRAM and use the _iomem
> variant, otherwise, use the plain one, something like:
> 
> 	if (priv->rx.pool)
> 		iosys_map_set_vaddr_iomem(&rx, priv->rx.sram + offset);

Even the current code does not have an rx.sram field, so I don't quite
understand what you mean here.

> 	else
> 		iosys_map_set_vaddr(&rx, priv->rx.dram + offset);
> 
> And repeat that for TX. I suppose you could also do the iosys_map
> assignment for both in the same blocks above since we don't support
> mixing SRAM and DRAM modes.
> 

Currently the code does:

iosys_map_set_vaddr_iomem(&rx, priv->rx.virt + offset);

and priv->rx.virt is initialized by:

priv->rx.virt = (void __iomem *)gen_pool_dma_alloc();

so we cast this today as well?

> >  
> >  	err = tegra_ivc_init(channel->ivc, NULL, &rx, priv->rx.phys + offset, &tx,
> >  			     priv->tx.phys + offset, 1, message_size, tegra186_bpmp_ivc_notify,
> > @@ -158,64 +168,171 @@ static void mbox_handle_rx(struct mbox_client *client, void *data)
> >  	tegra_bpmp_handle_rx(bpmp);
> >  }
> >  
> > -static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
> > +static void tegra186_bpmp_channel_deinit(struct tegra_bpmp *bpmp)
> > +{
> > +	int i;
> 
> Can be unsigned int. The preferred ordering for variable declarations is
> the inverse christmas tree (i.e. sort by length in decreasing order). It
> often matches the result of sorting by importance (i.e. the "priv"
> pointer is more important than the loop variable).
> 
> > +	struct tegra186_bpmp *priv = bpmp->priv;
> > +
> > +	for (i = 0; i < bpmp->threaded.count; i++) {
> > +		if (!bpmp->threaded_channels[i].bpmp)
> > +			continue;
> > +
> > +		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> > +	}
> > +
> > +	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> > +	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> > +
> > +	if (priv->type == TEGRA_SRAM) {
> > +		gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
> > +		gen_pool_free(priv->sram.rx, (unsigned long)priv->rx.virt, 4096);
> > +	} else if (priv->type == TEGRA_RMEM) {
> > +		memunmap(priv->tx.virt);
> > +	}
> 
> This introduces a bit of an asymmetry because tegra_bpmp_channel_setup()
> doesn't actually set up the pool or reserved-memory. Since the memory is
> only used for the channels, we can probably move the initialization into
> tegra186_bpmp_channel_setup() below.

This is the teardown, not the initialization?

> 
> > +}
> > +
> > +static int tegra186_bpmp_channel_setup(struct tegra_bpmp *bpmp)
> 
> This name could be confusing because we already use the
> tegra186_bpmp_channel_ prefix for functions that operate on individual
> channels, whereas this function operates on the BPMP object.
> 
> Perhaps something like tegra186_bpmp_setup_channels() would better
> reflect what this does.
> 
> The same goes for tegra186_bpmp_channel_deinit() above. Maybe something
> like tegra186_bpmp_cleanup_channels() to make it more obvious that it's
> the counterpart of tegra186_bpmp_setup_channels().
> 
> >  {
> > -	struct tegra186_bpmp *priv;
> >  	unsigned int i;
> >  	int err;
> >  
> > -	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
> > -	if (!priv)
> > -		return -ENOMEM;
> > +	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
> > +					 bpmp->soc->channels.cpu_tx.offset);
> > +	if (err < 0)
> > +		return err;
> >  
> > -	bpmp->priv = priv;
> > -	priv->parent = bpmp;
> > +	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
> > +					 bpmp->soc->channels.cpu_rx.offset);
> > +	if (err < 0) {
> > +		tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> > +		return err;
> > +	}
> > +
> > +	for (i = 0; i < bpmp->threaded.count; i++) {
> > +		unsigned int index = bpmp->soc->channels.thread.offset + i;
> >  
> > -	priv->tx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
> > -	if (!priv->tx.pool) {
> > +		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
> > +						 bpmp, index);
> > +		if (err < 0)
> > +			break;
> > +	}
> > +
> > +	if (err < 0)
> > +		tegra186_bpmp_channel_deinit(bpmp);
> 
> See how the name is confusing here? This is very close to the call to
> tegra186_bpmp_channel_init() above and the common prefix makes it seem
> like this would undo the effects of the above and then immediately
> raises the question why it's only undoing all of the above channel
> initializations. You then have to actually look at the implementation to
> find out that that's exactly what it does.
> 
> > +
> > +	return err;
> > +}
> > +
> > +static void tegra186_bpmp_reset_channels(struct tegra_bpmp *bpmp)
> > +{
> > +	unsigned int i;
> > +
> > +	tegra186_bpmp_channel_reset(bpmp->tx_channel);
> > +	tegra186_bpmp_channel_reset(bpmp->rx_channel);
> > +
> > +	for (i = 0; i < bpmp->threaded.count; i++)
> > +		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> > +}
> 
> I think this now matches the tegra186_bpmp_resume() implementation, so
> it could be reused in that.
> 

Ok.

> > +
> > +static int tegra186_bpmp_sram_init(struct tegra_bpmp *bpmp)
> > +{
> > +	int err;
> > +	struct tegra186_bpmp *priv = bpmp->priv;
> > +
> > +	priv->sram.tx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
> > +	if (!priv->sram.tx) {
> >  		dev_err(bpmp->dev, "TX shmem pool not found\n");
> >  		return -EPROBE_DEFER;
> >  	}
> >  
> > -	priv->tx.virt = (void __iomem *)gen_pool_dma_alloc(priv->tx.pool, 4096, &priv->tx.phys);
> > +	priv->tx.virt = gen_pool_dma_alloc(priv->sram.tx, 4096, &priv->tx.phys);
> >  	if (!priv->tx.virt) {
> >  		dev_err(bpmp->dev, "failed to allocate from TX pool\n");
> >  		return -ENOMEM;
> >  	}
> >  
> > -	priv->rx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
> > -	if (!priv->rx.pool) {
> > +	priv->sram.rx = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
> > +	if (!priv->sram.rx) {
> >  		dev_err(bpmp->dev, "RX shmem pool not found\n");
> >  		err = -EPROBE_DEFER;
> >  		goto free_tx;
> >  	}
> >  
> > -	priv->rx.virt = (void __iomem *)gen_pool_dma_alloc(priv->rx.pool, 4096, &priv->rx.phys);
> > +	priv->rx.virt = gen_pool_dma_alloc(priv->sram.rx, 4096, &priv->rx.phys);
> >  	if (!priv->rx.virt) {
> >  		dev_err(bpmp->dev, "failed to allocate from RX pool\n");
> >  		err = -ENOMEM;
> >  		goto free_tx;
> >  	}
> >  
> > -	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
> > -					 bpmp->soc->channels.cpu_tx.offset);
> > -	if (err < 0)
> > -		goto free_rx;
> > +	priv->type = TEGRA_SRAM;
> >  
> > -	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
> > -					 bpmp->soc->channels.cpu_rx.offset);
> > -	if (err < 0)
> > -		goto cleanup_tx_channel;
> > +	return 0;
> >  
> > -	for (i = 0; i < bpmp->threaded.count; i++) {
> > -		unsigned int index = bpmp->soc->channels.thread.offset + i;
> > +free_tx:
> > +	gen_pool_free(priv->sram.tx, (unsigned long)priv->tx.virt, 4096);
> >  
> > -		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
> > -						 bpmp, index);
> > +	return err;
> > +}
> > +
> > +static enum tegra_bpmp_mem_type tegra186_bpmp_dram_init(struct tegra_bpmp *bpmp)
> > +{
> > +	int err;
> > +	struct resource res;
> > +	struct device_node *np;
> > +	struct tegra186_bpmp *priv = bpmp->priv;
> > +
> > +	np = of_parse_phandle(bpmp->dev->of_node, "memory-region", 0);
> > +	if (!np)
> > +		return TEGRA_INVALID;
> > +
> > +	err = of_address_to_resource(np, 0, &res);
> > +	if (err) {
> > +		dev_warn(bpmp->dev,  "Parsing memory region returned: %d\n", err);
> > +		return TEGRA_INVALID;
> > +	}
> > +
> > +	if ((res.end - res.start + 1) < 0x2000) {
> 
> resource_size(), and maybe use SZ_8K instead of the literal here.
> 
> > +		dev_warn(bpmp->dev,  "DRAM region less than 0x2000 bytes\n");
> 
> Also, better to use a more human-readable string here. While at it,
> perhaps we can make this a bit more assertive, maybe something like:
> 
> 	"DRAM region must be larger than 8 KiB"
> 
> ?
> 
> > +		return TEGRA_INVALID;
> > +	}
> 
> This doesn't allow the caller to differentiate between potentially fatal
> errors and non-fatal ones. For instance, we don't want the absence of a
> "memory-region" property to be fatal (because we want to fall back to
> use SRAM in that case, or at least attempt to), but if "memory-region"
> exists, any of the subsequent errors probably should be fatal. It's
> easier to deal with that situation if you return regular error codes
> here. The !np check above could return -ENODEV, for example, as a way of
> letting the caller know that we don't have DRAM support in DT. For the
> of_address_to_resource() failure we can instead propagate the error code
> and so on.
> 
> Also, I think it'd be better to use a named constant like SZ_8K instead
> of the literal 0x2000 above. 
> 

Will look at this.

> > +
> > +	priv->tx.phys = res.start;
> > +	priv->rx.phys = res.start + 0x1000;
> 
> SZ_4K
> 
> > +
> > +	priv->tx.virt = memremap(priv->tx.phys, res.end - res.start + 1, MEMREMAP_WC);
> 
> Another case where we can use resource_size(). Might be a good idea to
> introduce a local "size" variable.
> 
> > +	if (priv->tx.virt == NULL) {
> > +		dev_warn(bpmp->dev,  "DRAM region mapping failed\n");
> > +		return TEGRA_INVALID;
> > +	}
> > +	priv->rx.virt = priv->tx.virt + 0x1000;
> 
> SZ_4K
> 
> We should probably do the same thing for the SRAM paths, but that should
> be a separate patch and can be done at another time.
> 

Yeah, this is basically the same as 4096 in the sram init but I think
hex is more readable.

> > +
> > +	return TEGRA_RMEM;
> > +}
> > +
> > +static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
> > +{
> > +	struct tegra186_bpmp *priv;
> > +	int err;
> > +
> > +	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	bpmp->priv = priv;
> > +	priv->parent = bpmp;
> > +
> > +	priv->type = tegra186_bpmp_dram_init(bpmp);
> > +	if (priv->type == TEGRA_INVALID) {
> > +		err = tegra186_bpmp_sram_init(bpmp);
> >  		if (err < 0)
> > -			goto cleanup_channels;
> > +			return err;
> >  	}
> 
> As I mentioned previously, I think we can move the block above into
> tegra186_bpmp_setup_channels() to make it symmetric with the teardown of
> this in tegra186_bpmp_cleanup_channels().
> 
> Thierry
> 

Peter.
