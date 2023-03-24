Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28B96C8383
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjCXRnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCXRnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:43:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2D59EFE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rc4LZY/JNtkWHgUFvZzjgbjzL/9xGxRBpEtNqkKLFTmieOs1ZMKh23jhQyXCuvxbaPrEkS35zTHQhR8k6A62tg6zr8Fg0XzKh3Sqatell9rTTAso5lE2NFZZoUqntpmAWSuLe5QdIi6fl+MnpK2nJQJNZ2nEQt4IFPJd+lIQutXT+mnUTl3zspXZ347WkHeA1VzuQ+7mpZzji3a5kNPDfvNAU1O7ulD8PIxodVP7qmZR1mjJ7ujPEsawQjhXdCaRsp1zMqcCSV/WSzbobaJjgIsuI75zXFlIu0x3OBoXi4W4mWyiTZtKdLYA5dPPkwZpE7bhBF8tzVpUBLBMeLPTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTYXb0o9t89KDtlsjIEqzpv1TIdS/fyK6vkL5TFSbss=;
 b=BkRzZZAiIvGShHDg0W4323WMY+U8OKf0MNP8bp3mt93vt/Bi6LaT15GTKC1GZu6UM1wv9HVdtaVAqDgCeGJSc1L+RCj2+/VDhWxv0QfHE+MDhBEfMBb1BIbLjTqVrXzFESUtv4MIizGYHkWK4cTLYyriBe/7T3MLJQoI48hDEDa6vU2zRmxKYoL+5e7UevX/IxoRrGClgE64Ck/2vHphVNvggn2ZE9tKC/Nw2zMKV4kT653c3cAHgWIiR9W0CcPZ96iA8RV486OAFBpqn6+x6/JDnVymWWPz0EYBqYChTI2rxij1HKLwkcMAg7c4aa5QK2ReFtUtR9H0DEyNBa8S5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTYXb0o9t89KDtlsjIEqzpv1TIdS/fyK6vkL5TFSbss=;
 b=nRfPCk0nFxxhnlHuKvD8nbmG2qXAYR5ddwkkygNFM6N9myV3McISHVMJAhAoikEb4vF+E0L1TrIsvhivvT24IGnDNk3KhRTvQODigZtJaHdHERS2FekkkaM3woQQPr4y4Wk7JsqrQt27Os/XcXUUksLuy2oyyKJWkFZYscpKr9gNOrBm0+UIOfQiLBvFiYEQ4AEfPiSPtglmAxEdfV3Cyjn4lY0aSfGMeZFG6LBt0uZXrZREB/OF7d0M5PAkurZ5IXpPNBu9v7B778OXYXIzoQM7vRUYwXiGeGpVJSOanYWDaM0OrXf1QqvIec5M+ih6xHvqvCCp2QCECN8uqKGvJw==
Received: from CY5PR13CA0054.namprd13.prod.outlook.com (2603:10b6:930:11::18)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:43:40 +0000
Received: from CY4PEPF0000C981.namprd02.prod.outlook.com
 (2603:10b6:930:11:cafe::1e) by CY5PR13CA0054.outlook.office365.com
 (2603:10b6:930:11::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.9 via Frontend
 Transport; Fri, 24 Mar 2023 17:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C981.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.26 via Frontend Transport; Fri, 24 Mar 2023 17:43:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:43:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 24 Mar 2023 10:43:27 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 24 Mar 2023 10:43:27 -0700
Date:   Fri, 24 Mar 2023 10:43:26 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
CC:     <jgg@nvidia.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
Message-ID: <ZB3hPrWvw7a+ckru@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
 <9700988d-ae86-06f7-33e6-f079722b63ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9700988d-ae86-06f7-33e6-f079722b63ff@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C981:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 3347bcd1-b1df-4ec2-7f93-08db2c8f4d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILLHATA2Z4kycRXmzzOQrOU5VzKJVZCdv7/G0Rqu/IdfnZ1qIR4PMqN7eOR0+km9nhKMWAtHASb/lGuHxaELWXbYaRh6CD4n/po3asAwyav8YnrNwHb+y4/TeId3UhziYPT9qBrT/oTzZdPlrulCxiwE4beRnAqgqgvuWYtE7m+hzZYXUprriHW77YuE/rrRlwnvCPhypo8tfLxOM3sZIBprLWcvLRqipTJOazmcSXbfUi7izc/vSUIUP72U3MLGsnXpjNjpL4K0Ls4+yd7DWRFxJY2eEhi5u8SazC/YBzukWWjKV2yroJhiVYnZ3M5oEYo41qfXvriVNnOsZqLLgJQKuUUBtXlP9sta6qFMJJUsrO/bn1xuJ/vD3u+7HjDJz85pLgbVFYMjH0rCl1PSTCOASrbxEc7OPmRAeq4hcwFjIgn/O3IKk1hnaPoilcRBXuzFjFrrvZUSc4L/j0LnZ3Q7f2MRqwBbJ7BIjw3XBiaLQr57UL9hgHG/Mnrw2hOB2Z50JG+YmvG+Jr4TsPXpZo9yblNSgAoAIt5ZhBDzcUsx0H5oGPTQloWvQLsbe5EO7r2BUp9ODLNVA55k1KlIxwmipTuvUYWw/PWvz146mDlZdJKN0poztALwhlqLctWPcpdO3inehsoW7STrbKvxdFJYg5xMZx6YMosifkKBynmFu+7bOZldvVHgAtv+ginr65v2T9YHd6gQ2tb8eE/SSwJmjs6tCC64OXPY1yvUdoLcitY6OeLAfWdMyXj+lbcjmLYWD33KY9cvtFztjQMxTw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(356005)(8676002)(4326008)(6916009)(70586007)(4744005)(54906003)(70206006)(36860700001)(41300700001)(5660300002)(426003)(7636003)(7416002)(82740400003)(26005)(47076005)(8936002)(55016003)(40460700003)(478600001)(82310400005)(86362001)(33716001)(9686003)(336012)(186003)(316002)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:43:39.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347bcd1-b1df-4ec2-7f93-08db2c8f4d6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C981.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 04:33:31PM +0100, Eric Auger wrote:

> > @@ -2893,10 +2863,75 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >       arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
> >  }
> >
> > +static struct iommu_domain *
> > +__arm_smmu_domain_alloc(unsigned type,
> > +                     struct arm_smmu_domain *s2,
> I think you should rather introduce s2 param in "iommu/arm-smmu-v3:
> Support IOMMU_DOMAIN_NESTED type of allocations" because it is not use
> at all in this patch nor really explained in the commit msg

OK. I will move it.

Thanks!
Nicolin
