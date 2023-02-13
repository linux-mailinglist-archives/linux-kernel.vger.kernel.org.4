Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B586950CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjBMTj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBMTjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:39:24 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15943591
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdadhnTJmmRiXptT2bbJWZFnw0VctAINRh3xe8Pkn1e7lFNdH4hIcKOKeAuHR/CHPifBym1++7HH5GnI3t3maJT8mJuySrPLSaK5fPzFKkpBazJvi50n7r24h0Mf+2qjG+jFW2gndzRdrO47x8sk6zD1mtgUsQ4ES78S+hHU4tQ2BCSKU4vbre335JDQaYiFyvE+rw8M2Efwtiu0cFJi5yMICKDfLO7Iy/MaFCII1iO5OQn/mZmvCY4xno4//ccJVI/WaUVGa6rTTByMqLhkZSeZ9yT4eZsjx7CElUtIGO3/BWPd85KDEsl/BiM4/KE8DFZhIg1fnT9zDZ6LwS725w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XktDnU8sSr+fQes4S/YXF3ntnWSXP5brkbRYadKHNfQ=;
 b=fFt2uMv2YQ+lD3Uq8Dx3t8wEJsl6c0/GISILci0EtWO9Nt3lnM+4ToHbi0AlVR+zwRrYHVpJ6PPhhZIS5ysJTY71zyPn0H6ORN+8QUfVBw+Y1E37dpzd/LqU7VNrtTkhAhXwWwd8bybTv/v/DOiT5sOgNbCvh/Rd33NlJCBkq3KwfuIvhK6v2Tdum7Ho4QUFRIbbXr1ENTjdPKI3BOMQlyDbfaII7E1+oOeSSlMK9J0hj/I/SJj3eeR5j9RZnDi9rGkWYSMIixJTGNWvVA2c5vkXXvwW2Qvc1EUQgo3FDvwLQx+GCXXUQFl19KuLZ/ypWfzmxm0EqJcH1vHuIQ6Irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XktDnU8sSr+fQes4S/YXF3ntnWSXP5brkbRYadKHNfQ=;
 b=Dw4P0l08HUNF1nDiLawafcc4YobPjBl4/Kt9bOONKuU1+QhTRsFYG5lqLxzB3WYn17RI7vA2SnZ2zDd+kIeggR7b4EppySP8gzf9ZEt+K5mBHlCqEpyyctuH3Ex5Yb7C+EJqFgX9RjigITGGKUFpMXtNDMCFX6eyjlw5UOkAu0ftcd79RpgAimq1j9sdgDlfnZQFTvMNU2CZ+ewV/CxsnzWEKZ9Wfy05Vmwv5CGFJtrlBot3JpixNfxfM6ae5JHnq2/PDvsnB24NCncFe8WwHYFWC/Av3NQp5WwmspLb6k0CSf8o7z2jGACtDQtG1gXiTRIjGN8d8PvZ0CYm8OhVSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 19:39:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 19:39:20 +0000
Date:   Mon, 13 Feb 2023 15:39:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu/ioasid: Remove custom IOASID allocator
Message-ID: <Y+qR5zC8ZOkVphgv@nvidia.com>
References: <20230210230206.3160144-1-jacob.jun.pan@linux.intel.com>
 <20230210230206.3160144-3-jacob.jun.pan@linux.intel.com>
 <Y+pjTR80bnl9rMK1@myrica>
 <20230213103455.02f3ac37@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213103455.02f3ac37@jacob-builder>
X-ClientProxiedBy: BL1PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: c4323be7-dcd7-44e3-d5e7-08db0dfa0084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzKx7iIfc8kaIKpzOFWYWeHYTtZ88N5Gj5vq3O7cxF95h1tOBxXsXNS1MesUA9/Ig/ivw6FsK9KCg39F0K8rLu4LSdlHd+shOHrHzb5+WkVHv1cm2ZpFmxANNll5wkLb5N1JGvLAZBSBc4vI+4jULsBTfK8onE4VeuJocu0TBCA7qhiI79EGlM3m+ONMd/SmeI4k9qxuBT61YbeFYcViIvTesr+cdJRn45807YFTPesb+FgLtAf4noNigQgfF6xX9s7O/X/Uz7LOOcvLovg1a0whicaqJLWOHaOsXQFvWVEO2WOs0OlHK7kxbIesNVeMASecm4vAE9lrXhaYuYu/36USvi1sjlHJw6VNqNHluXFlTxVC/UvEHWtbTtggrsjlIQHVObeRXLBZQ8NOI7LDfwHfjDW+4uI45Z6exzQy/6ZNn9R0u5dqvV2h6ybr+eKakfDukOW9LdPHYMHV+AMiIgXSkY88IDEOq3hTYmMvBBthZJ5Nfxhw2L6SfZrNJ1NVRzrUZU3ccL2jwYxL+8Yh8TLWnzT0kc6Vmn4VXhdlQIYn/ENfdHeCLB/kfJmLf30fEHNYxCH1o15TkgPGY2M/NjwqmMuRyVPv1qrgwPoPpDrwEc8RZgg/dqBVLndC4dyiCzFinuxRIn3AtLzHt59BniOBIWfMLbq96voFcQ0lQkpLhQMJT7OKc4QgbBs8g7w2G4yzXnbkZoKzqU7FmhQk2hcfanfxSRyArNv0HiQmhsNNmgZxhPT2/zflAa86a6swmqUwHf5YDFZBiUt4/SnsRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(5660300002)(54906003)(7416002)(316002)(2906002)(478600001)(6486002)(966005)(66476007)(66946007)(6916009)(41300700001)(66556008)(8676002)(8936002)(4326008)(6506007)(2616005)(36756003)(83380400001)(26005)(6512007)(86362001)(186003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ULYXKrrwDdNIf/axHCXiBqHSZAyYEZogUxe2iFu7u6D5ZqYXfF02oIPUYEqD?=
 =?us-ascii?Q?ON5cRq/DP5vBwDvjKuIbzFiHNLRaUAs0nSzC8rU/HBQ3mLm2QNUPq80mT2dr?=
 =?us-ascii?Q?DdzirG1bgAHCaqzkSXUGWwByg99SBtPvmd0s0Ovhmwat0t+RxlaNj50DEwts?=
 =?us-ascii?Q?gtY/kvs3DxDRI76f3jqVqlPWF5RYZtG8MWwUa17Ek4aCvaol7JOY3IkbEZD0?=
 =?us-ascii?Q?muKPG5ys3CKcPZOrl9MONk3RsHbLy06wpluajtj7ecVmMLbshVXnSEhdBdiq?=
 =?us-ascii?Q?jt50XbfjQh73hOHn2Ba/3bqZPotAEKuHafOaabjLJcfD3toJJH6jxtF4b2r4?=
 =?us-ascii?Q?Kp8s92YLPhC7uVOdE7HArpBZUkHWjP/XzcZ8LuVET6sbHN9VhqQqby0OgjFG?=
 =?us-ascii?Q?P7021D9AOab91FNvGaVlKhAchYaoJafbztH92QKEKSZF9OVbewsg4mChgLyI?=
 =?us-ascii?Q?/JWCMmFWlnx79S7pA+NlJOCK8srvi+9VMY/C2RLh9YDcCMCxc6Z8onD5wI3M?=
 =?us-ascii?Q?QiDjVMjgALE8EqqdfbHmS7eEUZDQu9up24zkpQPgDcK+A6tayv5PlfgjFQwi?=
 =?us-ascii?Q?PrhS7qO6Ocs4KSNsjueFvsh9gofJShvHACorr+XAGS3P43rF5hYzfyb8sJoR?=
 =?us-ascii?Q?VRZuhvJX2qPM0Lk7aTW2z2VeMcETdHmbIr4w01hRb40laRvIUAS1JkURPASb?=
 =?us-ascii?Q?3l46XMeQLprgo01Jo/mH6yc/9DLz1F8BLzEJsDbKODV9+YcvyhrC4T55GB2h?=
 =?us-ascii?Q?We18AjSw8VZxZ2GKdtnkzCHXQ3IhTyN9TxoD/W/Wrg3xpynBtsg4BZ3Qkvjg?=
 =?us-ascii?Q?/fC56eLPgNRLPJIcYMTZUIAmUgvXsLlfOt9h5H3xaxSHRxZP/Zij9VlHeALH?=
 =?us-ascii?Q?Wjpafy5gJ1fiszkRI7jEaewn7CRZlIYDvxiIaUfB3wp86Lm2XjECMZxWdT2R?=
 =?us-ascii?Q?hz/5p3up9F99LOkGRIf8bGlfaxXQR+w4P+X+o65xi8M7ouOcl6tQAslZlFzs?=
 =?us-ascii?Q?a4d0Wmm4KVVxY+GhiHO71nwTKB8DWNR5SK7fpghKq9hL+O0wpyEjVgt9MDJ2?=
 =?us-ascii?Q?PmxOHkrPFxz2fXz1L/FOR69foCZuVVWxD4zDWqg7Jo87sODoDJMhmwwYAInr?=
 =?us-ascii?Q?JKxi3QAvLOW2cG/IFxOBVPDtgbBRs6z/7OdEyHpBUtSI45voZDBDFsSSnOqE?=
 =?us-ascii?Q?BUIXlIOzHXTJrENGzqjLuAaXPMIfct1zINhsY+KO3e60xAZs3IGfV4fn55vO?=
 =?us-ascii?Q?e2ehAqGcpMEe4ERJQsIAXchpU4LUUR3hZbGIhiTOUnwYJFzOwHpMxnobqNFI?=
 =?us-ascii?Q?lZ3vShx01cCjOdLo3UCIcv2O8hXHhNUO1as+Zgz/+D4Q55z36F2ATWd84u7s?=
 =?us-ascii?Q?n+FIO8ZCl0lsDsMfGQX7EFC3Bwaqr89pMjrFumwOHeaKGMf7I+E7nFore2mL?=
 =?us-ascii?Q?VfZKL8uIMZJyOcifPBqQyIr5T1/FbpXhWAiqCunf15IxdGi/gFg8c2gDNl5M?=
 =?us-ascii?Q?rfBxfnw8B8yX6PiRn/Nr3jUsfctudRTS7mjDdNQek2/sjVA0qMipsKcvmVct?=
 =?us-ascii?Q?pTSupLX8bpwiubDLaGW0+arnglD4pKy4F4DKTE/j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4323be7-dcd7-44e3-d5e7-08db0dfa0084
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 19:39:20.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdLOjD6Z9MRxnMxz9IZNI9XwXsFUO+POG8gwHWEjcbOcqUkX5rm0ywp3X7DtxiK1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:34:55AM -0800, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> On Mon, 13 Feb 2023 16:20:29 +0000, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> 
> > On Fri, Feb 10, 2023 at 03:02:06PM -0800, Jacob Pan wrote:
> > > Custom allocator feature was introduced to support VT-d's virtual
> > > command, an enlightened interface designed for VMs to allocate PASIDs
> > > from the host.
> > > 
> > > As we remove/withdraw the VT-d virtual command feature, the sole user
> > > of custom allocator, we can safely remove the custom allocator as well.
> > > Effectively, this will return IOASID core to the original simple global
> > > namespace allocator.
> > > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> > 
> > You can also drop the spinlock.h include. With that:
> > 
> good catch, thanks
> > Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > On a related note, it looks like 100b8a14a370 ("iommu/vt-d: Add pasid
> > private data helpers") removed the last user of ioasid_set_data(). I guess
> > that could be dropped too, unless you plan to still use it?
> > 
> You are right, will remove.
> I was planning on the other way around which will convert VT-d's private
> pasid data helpers to common ioasid code, but when I look closer the
> private pasid xa is just holding a list of pasid/mm which could be per iommu
> not global. Another cleanup I suppose.

Please lets just delete this entire ioasid thing, it has no purpose
anymore at all.

I did a sketch on how it do it here:

https://github.com/jgunthorpe/linux/commits/iommu_remove_ioasid

I wasn't very careful or elegant with the last patch, can you tidy it
up and repost this as your v2?

Your DMA API PASID thing will simply need one new API to alloc/free a
PASID from the iommu_global_pasid_ida

Thanks,
Jason
