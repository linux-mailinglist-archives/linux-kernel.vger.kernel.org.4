Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8AF63ABD9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiK1PBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiK1PBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:01:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CC1DDEF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 07:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDSTwfpNcl8xck7zUd8x0xBMKH3Zq/VpoLOmXar37C341sBOa7ViK8yKAPOmB+BZbo+cj5VUHbUinrWAxElpp1OylNPt0ESkjoNDvnCqGJpP0G2HolWU961O6eo76HV5pu0s5IzvNT0W5syiTUF4RDhWhlKiU1Dnyg2QyCJYV1LcUSz5a23TUTn94O34qUXtp+rBL0vwRARWpvWxYqrCPzxPptC9deOMeoeok8kzgGOndK30Be370eB2iPjDONWAwCUBv98UPuWKbeJ7tOTKL9gHZFjIuONCBf/nOybjUyxFcXS+2Dox+/KAROIgHBLrd3jIcfPhz8Qbq2qMGdhkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHrkxLwpVYRBiQbyyH5juZErwgijm9lL+/ZNblRwMlM=;
 b=d6kxGEeJXU4SUnzipCqj68uAC15MErMgf42r4UAQGrNfvKKYI9X+RO8rJGZLbQcWk6gGnNsKErigMZHo9eUSsqCfnZDYesX/mMsWbLMSGPXGO2jUopls/vh7StfBa2++8ffG4AKwHiIqAjpJFxQMqOOQj1nPdmGNjFfAtb99/67N146+z/yFga63huf110VGrUqNFR723mf+M2QC6NjDenSzXV9sbY50pXh+OEjNLEaxkK/TQ81svVTL4i28d8gCyQkNDsJGLHH5scDmr+opoRt7MP/zH14JwNWI76NtfiVr+iPrhRuxM14v+Ekywa1Qs5e/nX//ZULysL84iiCcMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHrkxLwpVYRBiQbyyH5juZErwgijm9lL+/ZNblRwMlM=;
 b=Zonc0NvrxRXnC4ga7yL/K2IzyaD7SoxEGHF5x+hshG2aQ9p2i3/3e4hZjOnUWh+Bh9jYxVgwu8JokDVr1qQt66SHcqAW+7PpMomm5YHN6Zxc5fW/jHJ29ILwsumVsyEJgQib8JpXBFuZlSQWX60yoBYBpH7Bh8ghFAlf97smoGNU4coetNQf9EbXYYuwpeJlFLG+CnoxHk7grpY0b33gDyTpjQawne2/acxFvUkCvgni1BSrcSgdlfryMSrS/n3Kwv9DTwcuczHSMeSbjzqfoHWB4Xy6QheuPRbxDtAMsruiSdAbLtwpwqNzUxj49G5bVPAjChj2hluYgBCPXO6wgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6858.namprd12.prod.outlook.com (2603:10b6:510:1b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 15:01:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 15:01:00 +0000
Date:   Mon, 28 Nov 2022 11:00:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] iommu: Rename attach_dev to set_dev
Message-ID: <Y4TNK9J8NijPbOVZ@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-21-baolu.lu@linux.intel.com>
 <01296f25-b507-c965-9840-119487a00534@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01296f25-b507-c965-9840-119487a00534@arm.com>
X-ClientProxiedBy: BL0PR0102CA0038.prod.exchangelabs.com
 (2603:10b6:208:25::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b0a6ed-0dac-4ffd-ee4c-08dad1515c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYE/0GItT1nSdoU9qMazVWEXJ7It3sT3wbA4s5rIDohHGqAMmAkX07KrlX9QCH5wf4rMbDbmv3tIlKJCmYx8pDCYrlGaTERoXsqfS3JNXb5pUSeULgMr7xfPODrt4SyJ5asLHXP517hWlweFI5wYvEk/YQ5rK+KetO9AcFpUbQBg4dLzgWXAaupiiDPdu95V4Uw7K4dw7GWMgLIHASr8bnc0n79BacKK/S4qjCNmpBwJF4NA3b0CUMc8GUwEPoOVfsM6SLTO+wLGzJ0HgirwGudhoKr0Jl5mDOCCIu8IvuEodsDQ1uaNbSzs/aUTfEhkc1DRBCWMlRwMwqe+OA+6ukurzCMvnZFfoMLu3a6HzuPhWXbMn3isFWuqUx4bt9GPoeJnmzCdiRX6ROc51hRnBSHKPUbylY5GG5l4lFSH5PKIFeitkLl3am9TXo7wyvfqKpasHCZfDVfyz6D2TRGGpPJXQ8wuzkOnelVy1d2L/XJzaIAS2e/JlrjAGGiPU/GhZMIb4iXhv3/RT32HP8bJZd25j0/bmXE6UnE9Uo45/0q1w5bMJVy1b8vj9gOzyVyAWdDTtP80r9XfOHUc+u8YqehFplNr7mJEWhLpQ4K/v6jMI1uKMQgEYsYmrNx+EDzcABukIS8XfWklyKYkVLd1cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199015)(478600001)(316002)(36756003)(66946007)(4001150100001)(2906002)(6916009)(6486002)(54906003)(83380400001)(38100700002)(53546011)(26005)(6506007)(86362001)(6512007)(2616005)(186003)(41300700001)(8936002)(5660300002)(7416002)(4326008)(66556008)(8676002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GR0tl6tbp6jcVoI3ZkaYF6cediMPRHJnJ/f9GvnqdbXCn0qgyGxAv6WBUjZ?=
 =?us-ascii?Q?H+lCwh8R6Aug+iMdirsMG9SCbT5seGvjjkPhoJ9drgS1632AA0EznEewkkuE?=
 =?us-ascii?Q?P5KnECFxYMBz5BSMokFtzK/Bu+yGForKcEV4BCl4x5tCbAMQEsN51bj4Ds4W?=
 =?us-ascii?Q?3V2kkS3C8soWcKEMxwvJfFyB7IZqyEx0kzYN1Nw4Jbj6iJYRrzCVKoZnfoqM?=
 =?us-ascii?Q?4mZ9HABEyS1OqKy8hEFW0jThabEIY0rWHMDq37NKuCNVF4CiEIJpXkvIZVPn?=
 =?us-ascii?Q?z9de0i02REQT6Ib7Ms2lydwhetN4uKNeFA/6Ws40UPyO04y13zsFMh4Ranu2?=
 =?us-ascii?Q?mCKdIJxuM1uK/w4DNSdoCkXG71kzk13DEVrTtoVBquzJ6QBk55DP9l4P/29Z?=
 =?us-ascii?Q?xt/nSGct7Fn91zyidhJEgRohrDLhRaSW6uQO00I2UzbdptTYy17RfEMChD/+?=
 =?us-ascii?Q?cVgK6pTpsZkRt+8Bc6iwZCl9XdeIS3iXsAmOYmG+Ry4yzWI87bHu8ulVA6fR?=
 =?us-ascii?Q?l5ZDuDtt9htYFhccCBQOF44XjS6yrCs4ZD4aNRe/WrXytKxHTcrhhXWpmskT?=
 =?us-ascii?Q?TZKesWJ3WvZueIbl85QiHkAfRJ5XbkMTpwLTP7hizZ3J2PE/oTLHq2ALrUv0?=
 =?us-ascii?Q?Zq+s5dh6CED5/7ctWudbhayjatLCKqzJLY8PQt1N+6xMqggZ8PS+l51Nvz/G?=
 =?us-ascii?Q?4+Th406/38J5PFDGl1Ug2wC9w+mxT3jOSB7P5p20w/C8YCHoWJ1HO4Qw0hBX?=
 =?us-ascii?Q?bULn20+dVZe+RSxK3wEX3blR2RgpaCrfEHD1HhJh8vkPRfvF3dPCCtM9m/kj?=
 =?us-ascii?Q?R8Jil2HhW656oilA4tQuBMsIza80nzLjZos6N1+WLOpciTSC3Hct/x/QvkG1?=
 =?us-ascii?Q?TSuri7F/3zmAPN6LqTzMwCEYU9pVCwRjqhC+iSVe4fYe7zSyQ9pK6Qf0+CyP?=
 =?us-ascii?Q?byzB/6rUwiaTZtN58In8IZpLOtv8cyb9fSg9B7kwFYLz33Mf70qo1RW3hGFQ?=
 =?us-ascii?Q?IFCzagMv7Jim/0TiibTGfoolAUtwW+Etde+8GJ8AFgtqxsZH1g/65Te6CbgO?=
 =?us-ascii?Q?pwm+WS5gjk4CWUDy0k6c5nyDvRBnenURlO1O6QB5bbNG70o6+1ZCwegF+8M3?=
 =?us-ascii?Q?DRzYRmVFvy+eogBm4CP1tYkdyqkiAIFi+lR9l46vbj0k2aqxhj6eaM4Qn//L?=
 =?us-ascii?Q?6RSDRDn+wC7eJuVtizAUbjV+yH7valIsQoDQPwUXpQahbtyQrkq8i0NJjWrp?=
 =?us-ascii?Q?KdkyOJ+8M5c4i2crnNC8F20QAg7B+wgkkEm0ZSHSfXekJLqBF3Qgb87BCUUn?=
 =?us-ascii?Q?ncL1b3nU19L0E91aAnhbLCNr0LRwoYWR2peFbOtyFTpZXPOE2NYV7EzqdPrP?=
 =?us-ascii?Q?dHhbopUwwBknq20isvtabjfq1tVEZTh9YFC4UTG1SvUhTUdE5pBwEy0vERaF?=
 =?us-ascii?Q?nuFh5gQNXbt8dMkm00jCKoHcsJ7oADwgPcLiWA+FQX//4Q9Ows4DsGpWAlV5?=
 =?us-ascii?Q?xTxr/dURn71urHjWJTDoa8Q8GGX5oL0Tbp50VS45GrbOHQZ6NLTdUEg/miAe?=
 =?us-ascii?Q?LwnV0b3YCKS4HHqw3Bs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b0a6ed-0dac-4ffd-ee4c-08dad1515c5c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 15:00:59.9277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1Nm7UrCKuOyFJblO+yuPSnXW/qkwid7wugGbtpOR1hjkIOnwIodEwcOwpHiPHEr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6858
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:41:56PM +0000, Robin Murphy wrote:
> On 2022-11-28 06:46, Lu Baolu wrote:
> > With the retirement of the detach_dev callback, the naming of attach_dev
> > isn't meaningful anymore. Rename it to set_dev to restore its real
> > meaning, that is, setting an iommu domain to a device.
> 
> English grammar alert: this part is confusing, since the usual in-context
> reading* of "set[ting] X to Y" is going to imply assigning a value of Y to
> some unique property of X. Given the actual semantic that when we attach the
> device to the domain, we are setting the (current) domain as a property of
> the device, I think the most logical and intuitive abbreviation for this
> method would be set_domain(), where the target device is then clearly
> implied by the argument (as the target domain was for attach_dev()).

This is the iommu_domain_ops, it seems a bit weird to call it
set_domain when it is already acting on a domain object.

set_device_domain()

?

> FWIW I also wouldn't say that "attach" loses its meaning in a context where
> an equivalent "detach" operation is only ever implicit in reattaching to
> something else, however I do agree that it *is* worth switching the
> terminology to clearly differentiate this internal behaviour from the public
> attach/detach API for unmanaged domains.

+1

Jason
