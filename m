Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A135E6AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiIVSam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbiIVS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:29:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF61114C1;
        Thu, 22 Sep 2022 11:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0YEntDAhz3bz3tby4ELONej4UYmJyS6bv5zNwiFuChOKtlv+NzRZ/wUpotWqC+Po5BxD62TvhHbNxmYEHERo8TBEuxHuLHjxfHLQqZmjLs3DRbhUe8yBwZoIUHTQzsQnEmG2iBf/ZSkDeFB2m/b33zGZMDs1q1g3ArOVK5QDQJj7MAvgGXNnj2UuUZ6WDVuSP1VyT4ike4DKYWK/VuOu2sYid7mhLyURLxrzOvQ64e9PiggpCleB1yobX2B+HuIFj2NKsdfzNAQBhW5ekrDAhTMWwTgTwqLcBLXtQ7+cL9pE9pof/pM3ZaHikggiKd8X87A53eucVQPMJWGyeYNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/SN6MeI436hc3x2x4LgJjvZdPynOabv811mJYXlk8E=;
 b=H4dfEU797l9Y+3xckfvLc2MdCL21bxP+hR88Tjn9DmYjQlwCeu+tTClMVu1GIebLv6ZLQBF39CJ3eWi0JbBNOYdccFEnGx93/k7UfmbKQ8P7b6hiMsVJMzEIWvB7XyynQsZTa5PeGwZd6IpEzNUdmsH23ABjmjrE+W9CMjqvt6V5SkIqCHpsAe2QXYSA+GMps7KFx+tX+TKKJfYlBfgJpI7/xC2ZO376cqKiwuG/5MNopl4rMO9qlcMSg9KQEtaQ3wN6iTAFFc7Tx1yw7jbESVBlEqeL85MASTRAz1lvT7pW/v6T6LE63r2OyJrjr2D9TttemGvlx25t7ACo1Q1bUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/SN6MeI436hc3x2x4LgJjvZdPynOabv811mJYXlk8E=;
 b=Nm6GNiv0JNfGlYzN+a6TAjyoqpjAorD7BKK+oU69pMW9hswyPIqVTL2zqGH617pzh74UbFecdWdmcDSJ356/FWwn+KuqxFJC2ReJVbrpVuhriIHa7sCBlZXTWYVHfLMAQxNL2aBKqeHmEzJEgs0jjD59AfSICvv8szDdB5IYbJy6CYMQMiaWsXijv85GKgdtFrm4ciCfyCUSbcOnBBo40REWdjWXx7hHf7La1OFeptA2deZvpWwlZaNAGH/QNKW+Lv4fcmewAf9XYNlNEBFTimgw5VFXjsgmYxhh4nPfSLg93kxDepQj4pPlS+N7EhMvbwNETFU92E0h1UUAxESimw==
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 18:26:50 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::bf) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18 via Frontend
 Transport; Thu, 22 Sep 2022 18:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 18:26:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 22 Sep
 2022 11:26:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 rnnvmail205.nvidia.com (10.129.68.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 11:26:32 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 22 Sep 2022 11:26:31 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29 via Frontend
 Transport; Thu, 22 Sep 2022 11:26:30 -0700
Date:   Thu, 22 Sep 2022 11:26:29 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <joro@8bytes.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <sricharan@codeaurora.org>, <kevin.tian@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] iommu/msm: Fix error-out routine in
 msm_iommu_attach_dev()
Message-ID: <Yyyo1RvzviIJLPMb@Asurada-Nvidia>
References: <cover.1663836372.git.nicolinc@nvidia.com>
 <23e009bba72c3e46320c59acefbbdd976111cc8a.1663836372.git.nicolinc@nvidia.com>
 <YyyaCoHC95yyJpOK@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YyyaCoHC95yyJpOK@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|BL1PR12MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2b1d2e-1454-40d7-dab3-08da9cc80425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2thHa96HD4O5hCqZxGbYjhH0v3X+S3VeK7ayqEOmk1BnhNQakodjgc6qgsOge19rAIW59u5UpeglFoSaEf1ymy9uTmmKyw/TKfhldJVMclIzmgHul0nwANf1DjzThTiv4xcRp+EwtpjzGsLNCPOy9pCNeKJ677+/vi5ZymaxIIq0CsJ+y81htIXiD8CJu6OJdsy5zp1P3mufEExv9FKrxVA4djA99p3w+VpDoNEjNFpK4Nz8NUytMvfY2HVX65R+/JNL2sEp+ZRmoaaLwNnpobFXsaNp8lFKWK+4WpTcOQtT3xluIFI1isXfoyXuNy4qaHRYO9wc/EdzGG3evvFUfv1Wt299dG037jIljJWsUHM9ZJw3IPgDeYimtZ3LrO73l4a04oUrAnAOKhX2P++ITXoXLKfzBWw+l+XgXrlxhxn+48Pmr+C7ARHQSme8n5i7Lz4inNrhkEbMOMe9rSv59BFrOToji/U9HHFTeN+yCS683kCh3+FD9Q+tMwHelxYcPVc43Uf2hh0FY1ECfHsq3xNl7AxX5Ci2pSgYcTm3Iv7uDjtxuyZymUMCPc27T3Be3whc/Q71Lifej597aibSEBZUXqUfhm8klUpuzJcalNXX/3UfwlRruwzNYJk1isVcp4BvCGizzI9nfIpQ2lqm6gEzuYxLxVQSDY+XxWLTuYyEikjDtqIwAWxqydYjPCB8rSPywcHUZIj+N4nrWMG+rWJRrOh6sCjzcfnQyliOIVnh4x8ZPVgUKJ7VAd/8WmMDIaUq6qN7DlO3/rKCCPxSAg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(6862004)(7416002)(70206006)(54906003)(5660300002)(86362001)(6636002)(316002)(8676002)(336012)(4326008)(82740400003)(83380400001)(426003)(70586007)(186003)(47076005)(40460700003)(36860700001)(41300700001)(7636003)(356005)(26005)(9686003)(478600001)(33716001)(40480700001)(66899012)(55016003)(82310400005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:26:50.1609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2b1d2e-1454-40d7-dab3-08da9cc80425
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:23:22PM -0300, Jason Gunthorpe wrote:

> > +static void msm_iommu_detach_dev(struct iommu_domain *domain,
> > +				 struct device *dev)
> > +{
> > +	struct msm_priv *priv = to_msm_priv(domain);
> > +	unsigned long flags;
> > +	struct msm_iommu_dev *iommu;
> > +	struct msm_iommu_ctx_dev *master;
> > +	int ret;
> > +
> > +	free_io_pgtable_ops(priv->iop);
> > +
> > +	spin_lock_irqsave(&msm_iommu_lock, flags);
> > +	list_for_each_entry(iommu, &priv->list_attached, dom_node) {
> > +		ret = __enable_clocks(iommu);
> > +		if (ret)
> > +			goto fail;
> > +
> > +		list_for_each_entry(master, &iommu->ctx_list, list) {
> > +			msm_iommu_free_ctx(iommu->context_map, master->num);
> > +			__reset_context(iommu->base, master->num);
> 
> This isn't safe if the loop in msm_iommu_attach_dev() exits
> early. 
> 
> Firstly the it leaves master->num set to -ERRNO so clear_bit will
> corrupt memory
> 
> Secondly if the attach loop gets half way through the remaining
> entries have master->num == 0 and so the clear_bit() will corrupt an
> otherwise valid entry.
> 
> Fixing all of this properly looks like a big deal, I think we should
> drop this patch from the series.

OK. Let me resend a version dropping this one. Thanks!
