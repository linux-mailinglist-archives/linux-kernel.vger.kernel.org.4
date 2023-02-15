Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34BF697C66
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjBOM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjBOM4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:56:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429984EE2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 04:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsTWTjiJrAUhD0WWTMHVFvL3WSJO6Pco+KCo+lXfkuy6SMLCp++yMAvDoBQ7yRTC51HuMpdfwpv6fVYq2ALmlHNGXwJRmu5os+pD8l2s4DbnVoM+lyngOMcT93AkZbQ5CP8K3b2iXPkIo+PU8UQQBuvZ7dmqS7GLOuDdOUZJ1zQCs5pOZpLk2sEE45pbiaAWHRe0E7LUuls+xKhtFmNMDr2dRTH4znPAXWJuSfOka8q8aZ0+pB3oWn8n0qmk7rNGEhdWJ5qJ4+lHsjDGeSI1U1xmLphfq8keyd7Tt3H6hPxfuXQ0FaPsTbu2NH56P0egFeN6t9JtzSkFjmm5G9rhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcuRoRfwkDD3KxSf8sGH3uRVJEejV/erZATL3UA1OrI=;
 b=Sd+3KEW/Bi0oOlmRS+IBNwdXePR3P422lXYtm0q3PdxhdS1mpwn0WWLrv5mUaw0HJpD1ZkYqs509ypVO4BFOGwjSb9+FI7h917Kz7d53ntrz6XdJqiLLQ73yMP+6JzN3vIvMvAwRaCgDtgDb+zcA7A4je7gv2KqIKAGGSXTYldkPiHrQX3KnzdIMgNfx74+rULvPM4MMfFjcy/V70fKRnoj5rwNKNqgzh87i11aCHHLwPd9BDZQOrFi66Xp6yNBEbZ1jsPO0SK39hlpWknGOD1r5gzO+rBEdLigyW4ZaiXJ6yx8ETgCIE9TfauFo/4WSfcUg+nfkOHtJW+17z/Bhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcuRoRfwkDD3KxSf8sGH3uRVJEejV/erZATL3UA1OrI=;
 b=XRNVl6LUgFC/mdtNQFA/VCIunKv0svicJ2dB3xW76IDSPGVmxaIhlQuXLYKqIcBed1obpzABNqtJnyhWiKuCz75DrtA3Cwn7IY2BhnNAScISiX4yItxEKilKlZUpoYlb1FmVKyMQSIrD1AmUlBMWsWvcxvkIpi/ML6s3OW/zwTpfv7eOQoPkUf/M8lQntU2vrq32b86KoQqBvkojBP7XYGkO62gKGBamQB5txkJ0zZ4KBcRq/7XwBNQPYI6dzhK6cyo2F0Wl858AOl2tMa9LUpXq2eRvBi1wf7C85g6JbLBHg+MctyIS1rde2z0FaUC7hMEYk1Wmtz4Z+RKrAh3Aag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:56:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 12:56:34 +0000
Date:   Wed, 15 Feb 2023 08:56:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iommu: Use group ownership to avoid driver attachment
Message-ID: <Y+zWgSzwzWFjGL6m@nvidia.com>
References: <20230213074941.919324-1-baolu.lu@linux.intel.com>
 <20230213074941.919324-3-baolu.lu@linux.intel.com>
 <Y+pG9kWzR2c5I9FU@nvidia.com>
 <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7f501b0-42c4-5402-7bb1-b4681b6e624c@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:36e::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cb1297-7608-4af8-f031-08db0f5410f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: skbWEz9s0tnDCgZ8Cbga49tmLtfX+qrFczrWGvDUPdUSj+JSc+Js9AYkUKo3XMSSHgpTKoE2rm0xbj6twZ6toU+SCjCzLksu8m/T2o9uUNMqnvi38gok5XKjNKugAKWjhzERqZk8Oi4haLdKdelNvnqYISu5BirtOHdigZkWa8RN76kMu9r+va/QJ07abU94PkZVmnLZ22YBL/MX7iZaHFgfSFWfic9zy0Gz/7ZPF5QlSv0Angk5BTULrZQxvVE1kofUux5QIjxykjLy3ISCfB6rxQQ5+UrrVPBYLkAoN0El70rBJOtSqpIIx1SZ98syQpqGYbI7gRDzHj2fFUh7mNqyWckr6mRV23/5yzHsE32pMipCXA04QqHkJXo6efCbtA47Tpcck9ziDIuY6BcCE8kljQIksc4xoPaoGVw13loiODN4/m6mUHSE9JQdkZjvQZrbxDEyzAWMh7PbJwgNaKgGY1mjAZgwS33wD0FxEcERnx7SXJeuqEN7cjX/2L8gT0HeSTiQfcZN1hJhBt1HjOSVVFEDJjDndcqJFa0wb9LUDL5wtUuvaJmuJAafZULysEmC2QzF8Bmv7FQltlUwbnJ9CUKgd6UyxRdQ08iRES443G6asRfvGbNmgIgEufm/hUQlkGYdHZLAIBENDobZUTTg4jlfR6Ah5JlGqntf1g85IwJE4PMvAyNF/CmH0FdA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199018)(36756003)(8676002)(66476007)(66556008)(5660300002)(8936002)(316002)(54906003)(38100700002)(2616005)(83380400001)(6486002)(478600001)(6916009)(86362001)(4326008)(2906002)(186003)(26005)(6512007)(53546011)(6506007)(41300700001)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aag9Fab4bxtn5XOfT+ygyBkrpALMrKz0v04653iMv2ZFQ7+ja0grhyirxtud?=
 =?us-ascii?Q?zt6dEfmdEnc5nW7l6v/9/NQBEHSYStUiE0xUCGglgvdTaZm1VMmp33kTCZpI?=
 =?us-ascii?Q?UP2KbrgZXrDoEv7gT4Qd7CBjPr9kaljD7IeubDCgh6k0R6UOLfYHa+z1in9b?=
 =?us-ascii?Q?N7T33iZZj8S0Um5Mk6IxM+ZmBTwtkiWp5hPBzNP9SYCoerW7tnWyKCHhAAl8?=
 =?us-ascii?Q?iAmW9U1im63RX+atTBjm/yU+xk21bBGrNdPDaz1D+XQKwB4lUpeBBLejZvra?=
 =?us-ascii?Q?ZhgCWwm2CCytSPim1uSYHOpWnHIgW196mnluu3rwhbtM/KW37nsz3s0ksbE3?=
 =?us-ascii?Q?hdFmPPiBvJqMYZVmPsI3vHMS0hG/wShKirHG5ivPIBXo0fQCs+4RA7RGPKrj?=
 =?us-ascii?Q?9RBu37nkKvTtdAdl3a2m9z5pySUKconb32trGiR21BucYKxJrgQSdsDURkDo?=
 =?us-ascii?Q?ajAmNsBzKO+tTnsCkBrhyzuthvfBId/dtQn78mNdjTWIOTATZcgvcsb2AGAf?=
 =?us-ascii?Q?0rxzoDM65xqZSUokrIXJXnrDeOvA5t4i/s8mSqAPg/e950P1KDoNba/ZF5UP?=
 =?us-ascii?Q?8jYtcAfF3qCBJH3IoadKgF3TqD5NkfQb4Qdl6QQVSDHCEsDgRy7V2lY9VmTF?=
 =?us-ascii?Q?5kcWjae/IVcxU6LFlRPK9S+sLBJ1+th38a9qnzNzzyLeMyD2VBBbBPWPFutQ?=
 =?us-ascii?Q?YSBOqSDtmFUkEtXqPHU4ZHXDyd2zDp7K+BWrbTrjz1AuEAL9bW5LNgUiPU0w?=
 =?us-ascii?Q?uLVWEIWis/a/vCBJv4MCsRJJ6WpflCu2YbVLUo8G1SICIVJKmEM3Kc1pQtvv?=
 =?us-ascii?Q?G5pTYa5Swkjc960bkMKFpaTFPgt/s73C+aqkVy20LoSu32NLG4sHGBNQHkrd?=
 =?us-ascii?Q?pJsmXL5wf+LGkpPcOIIZm1jyqvoNEeKymgnQtN6shvOYgl3S4dA2bxeJIf3S?=
 =?us-ascii?Q?/qr7sDY7on5zCnDeX2tBg+hBRZHQXXMx1YTVGZb0+OgtkK0Yd8sfYw3mxJL7?=
 =?us-ascii?Q?BfiUKfnCTdOCycUoS+7TPfWa8lnJtGdQDzggF5tPUhhUB0TBnqoAAOnkGb2S?=
 =?us-ascii?Q?XRCak7XutSHiRU2fRL0tiFcXfc0GbGoGRfz5s9kHHwGHD1+9ovh5noCw25J9?=
 =?us-ascii?Q?b0XDHA9UorWayt6ZsEPCqTbAzlNJOjPJyh9PJg4/7vFaJJykKuJrDtKB62Au?=
 =?us-ascii?Q?ujAKLOruXrtBSN/BZIdoL1z8weMHOWD6JQ2gvxNxza/vTtRAo0RnGS/MrREl?=
 =?us-ascii?Q?nOCZPWZyOnQd0vMK7Wy9a+RMysOSX3hxBW1AlvksEIHhWHOy9DTAP+/ViwNW?=
 =?us-ascii?Q?NcZkQX1LRv4TjMZoy2s/o2GCaifVpy1QoJRnFVRcdxcr312obCHrO9Xrrp6t?=
 =?us-ascii?Q?It2R8Ofqosya4h1UwzQ4j1QQFUGX7IUcSCN9aI/QDCCv4TzJ2VfW3VUQECXV?=
 =?us-ascii?Q?baep9xVSLt1oy0maZhGbTQdlKbbdAIxwsdbFmQD+UygU0wyN450JtPdePpCX?=
 =?us-ascii?Q?0pllsKVIYgHsujtgSgUHoMAZElboiXI5aNMX/glrWdQEhWnaZmeVZgK0stsp?=
 =?us-ascii?Q?RWUUvOOBqbWB56qMh0MaELBQ1Z/+l718+VcoRtzc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cb1297-7608-4af8-f031-08db0f5410f4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 12:56:34.0464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9DZ4QRd+r236iOtYtV7RgXXjxWHGFq/ZHdY0xcr9mLAEdwR4il0Cc+p/19n6opV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 01:51:14PM +0800, Baolu Lu wrote:
> On 2/13/23 10:19 PM, Jason Gunthorpe wrote:
> > On Mon, Feb 13, 2023 at 03:49:39PM +0800, Lu Baolu wrote:
> > > The iommu_group_store_type() requires the devices in the iommu group are
> > > not bound to any device driver during the whole operation. The existing
> > > code locks the device with device_lock(dev) and use device_is_bound() to
> > > check whether any driver is bound to device.
> > > 
> > > In fact, this can be achieved through the DMA ownership helpers. Replace
> > > them with iommu_group_claim/release_dma_owner() helpers.
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommu.c | 27 +++++++++++++--------------
> > >   1 file changed, 13 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 4f71dcd2621b..6547cb38480c 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2807,12 +2807,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
> > >   	mutex_lock(&group->mutex);
> > > -	if (group->default_domain != group->domain) {
> > > -		dev_err_ratelimited(prev_dev, "Group not assigned to default domain\n");
> > > -		ret = -EBUSY;
> > > -		goto out;
> > > -	}
> > > -
> > >   	/*
> > >   	 * iommu group wasn't locked while acquiring device lock in
> > >   	 * iommu_group_store_type(). So, make sure that the device count hasn't
> > > @@ -2971,6 +2965,7 @@ static void iommu_group_unfreeze_dev_ops(struct iommu_group *group)
> > >   static ssize_t iommu_group_store_type(struct iommu_group *group,
> > >   				      const char *buf, size_t count)
> > >   {
> > > +	bool group_owner_claimed = false;
> > >   	struct group_device *grp_dev;
> > >   	struct device *dev;
> > >   	int ret, req_type;
> > > @@ -2992,6 +2987,14 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
> > >   	else
> > >   		return -EINVAL;
> > > +	if (req_type != IOMMU_DOMAIN_DMA_FQ ||
> > > +	    group->default_domain->type != IOMMU_DOMAIN_DMA) {
> > > +		ret = iommu_group_claim_dma_owner(group, (void *)buf);
> > > +		if (ret)
> > > +			return ret;
> > > +		group_owner_claimed = true;
> > > +	}
> > 
> > I don't get it, this should be done unconditionally. If we couldn't
> > take ownership then we simply can't progress.
> 
> The existing code allows the user to switch the default domain from
> strict to lazy invalidation mode. The default domain is not changed,
> hence it should be seamless and transparent to the device driver.

So make that a special case, get the group lock check if it is this
case and then just adjust it and exit, otherwise get ownership under
the group lock as discussed.
> 
> > which also means this needs to be
> > an externally version of iommu_group_claim_dma_owner()
> 
> Sorry! What does "an externally version of
> iommu_group_claim_dma_owner()" mean?
> 

Oops "externally locked"

> My understanding is that we should limit iommu_group_claim_dma_owner()
> use in the driver context. For this non-driver context, we should not
> use iommu_group_claim_dma_owner() directly, but hold the group->mutex
> and check the group->owner_cnt directly:
> 
>         mutex_lock(&group->mutex);
>         if (group->owner_cnt) {
>                 ret = -EPERM;
>                 goto unlock_out;
>         }
> 
> the group->mutex should be held until everything is done.

Yes, that would be fine as long as we can hold the group mutex
throughout

Jason
