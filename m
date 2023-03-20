Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483D6C127B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCTM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCTM7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:59:30 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FEE2685
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dslWETo+G8jpuj0V9Wly3RB5/P9CKIVF6gQcLv0GRyKj/YaX08mSnvgQO3t3VeCWdQ14EK5E+6FBG+ogfq5JytuqFeoxY9sI/6sl2rHFHHi00hhYZU6rVNeWIoXYnc35AU+B3xpTr+EXyzCDYOBygf52ouhPyl/+alGIeoQu83xarQ9Y+5iGCrIRC50YnIqiKdRLsYfs9tsPe8P1YGoHpoV9ct+vtxpeRlUkvGrYZ6RLwVLxMyYFpafTMV7HvpQRudSlBk6cf/60AG3Lc5lq3JMlOK2NoR9KeQoIkqFJCe6gtB0eObKESBcYMsc9jzcoS9seKkIB3JENb5BhMbOn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1yNvMDkZOBJxg3VDY5pRd7hUMGd4d3paDwDUtWlW3o=;
 b=EBkPTG55cxOOFAIDDy6sDPO2rMRK/rY7QWN3zZlHlMNAy7BWCkDva+BYhGvZtJaYLOV3KnilbxqCO8jbovwgPrS2pVseinPlRpw/X8cOTE8Y5QeD9m2iuOtIvHdpRVE1+Ixwd0Ep3sN59x32JbzIsFNPOmsnQfC22YmL4CGn/9FvR5gSjcLUPdkQuJku4bhTDH1L4XjmmQCVFC4XDV4Ic4k/HjQHyU+/Q8nqIdmtjSqqgOjL4O5aix4GsPxR/jrl/y8/WbjWlNlgk5JOPvUCTnEfqW30Jua2LQuK1H/E30Wz6qR+ob3C6L9GVcWkFhfXAtvBnK29oFkXh2fjzVq3sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1yNvMDkZOBJxg3VDY5pRd7hUMGd4d3paDwDUtWlW3o=;
 b=GCoe5ytojtZFfj0HQ/j1wXaIUdyGmKcI23AYbmioiKHvGvbUj7MNwnUyHquQTk9i1LyXNNOFJATyccq/evHLQyiJ8HajIOOZHv28NxGrmz/Bq/0U4hKLTV7oSVLMSHh4NYVYgJyDfU4dPSeCgwQqy8CCQhWu5M2ryIDOP7d0zH6+maMPRRYWGRujk3++uBRFhCQeifjM7hVDc/R6SRCCY7EryZSKFLwquD62iQkOIg9xlyRXQWPKCud+RJubpaQo1ovEhh5egrolyH2GEv6zTyxPXThM1nbXVD/XA1XfHMUTr8mofO7edtEO6hpQtVLf+H9DoQegSyxqhjTbJ/d3lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:59:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:59:25 +0000
Date:   Mon, 20 Mar 2023 09:59:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBhYq8o4gqFZVb6k@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0450.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4865ef-32b5-4e9d-d267-08db2942ee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPFODBEKUNFleB5RiRLlDEB11Bt72KZXopSoGY/CYkrXoGgBM43iqqeIyZQvmM/nWW2mHQdKD62ToEpG9pNFNJ6CZioRUSvHLWg+CEY6OEa0njdwwaCBcKjhR+HCm748y/APsenBepYzj0xOS6MWqzuE9FQ2mkzSv/Ll3Tl2N2ZCnxFKhIdBJuIfa7PTkWTPS63ciCe8ShBydfDZavcYzOz3D763DksMQ2QwjVif3QDvrvieS7nZ+PwAA3KrCBhrln8lp5nmysm+5IKdzH4Vijh3oSFH4aYO8v4AmaM+9s1QaqSJYSA15eJcZXzppUiimqEEqr5ZUO+J6aBpRUqv9MTV/c1gMioxqqYNprKf+1Zr5v/fZ0JGTB6XscIuMjlshQG483Y+FNI/w8ZrVkFpGgMJzVGlW5oJJV2hERA4ORxO/YMidMyvcEGJi/o+tk82yTB4vLVFp+bTs8WgTbyvzRy56Yfq8MmO/oGtBr4lsGlHqDCE2/O2dKqELdl3bqhwlz5K/v0XOxYhcfOmZYwxWpg79zPFIUQnW2Tz7u0hSTAdReq3oQjEwkNuveb/JRFlKvh8z6voTssgzBXY7LK0QfiKizfziOBqcJDuW6XhKRXnuvzyuYjs+b+RCdER+yzq+h8UGunJx5iLrEjpXNZyXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(86362001)(38100700002)(36756003)(2906002)(5660300002)(41300700001)(8676002)(4326008)(7416002)(6916009)(8936002)(66476007)(2616005)(66556008)(6512007)(6506007)(186003)(26005)(316002)(66946007)(6486002)(478600001)(54906003)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PFSYoYnShXE14aJgNdWzocLqxQc8dv90uUJ8YlRfmPwAtIVwQsYmAZitvzBt?=
 =?us-ascii?Q?bGg5e/T856m3vzXaKKMuR0sYu4g3cHV9k60oOMOJn1vkLO24JC92/pakt85Y?=
 =?us-ascii?Q?TpcZleI9UD3eOGNg/95CBXrxSE5wzM31LxiVYIyOchTXX41eZiRmSrAyGUSu?=
 =?us-ascii?Q?go9so2UOlQXoCF9mV6Ql0QOeVYfUuWjqUNTIzzO3K9OAQ2cZYFHKvxAWpFRn?=
 =?us-ascii?Q?YGpIJDgrE1+avyW48KaNabKlcRWID9Or1yeKIc3YiK47G86b+thdFZvEtoyH?=
 =?us-ascii?Q?jsIVwyFP2cwIgqWFqZc3dtd8RAH55BETccIw4mWlpU+a8uASvFC5Kneo29v9?=
 =?us-ascii?Q?d4LFmMDWqH2mbcB0/UJmaxwu/OQomLj0477owXCs5cjlb0pKx1/wMk5+bfhM?=
 =?us-ascii?Q?9a4iaZn4mHN7CClCx7EBfzYZhd1+BOgS6lF5IA4ebJtsGdC/tNgAROz9wTnY?=
 =?us-ascii?Q?Y1SC5+Qk9OzdfVk2KE44bG3ItykSNNwf+D98qx9N4kaVDJY9ck3F48LKz0sR?=
 =?us-ascii?Q?wAdbLmluq0rqsDZo1Z/Hcmt1xdnO5WQQuCdx7MzIV/LUpkuvS6W0w1ER0nhX?=
 =?us-ascii?Q?U9jzLd4msju7UjsZj2BfP0TLrukcYIs+Wg6bjyZEY68DWWjO95pujQYouqwL?=
 =?us-ascii?Q?tqKgA9PxnI/aJ9RnnMvkBTHJFPsN0bQIWVcUABMvRfSVMWruvR1oUzt5m0XP?=
 =?us-ascii?Q?NJfmkHv0eBCydJlGbxbKIdIp2boFmI6mSl6LwHCtSe+fxUnQRqBw9timCvg2?=
 =?us-ascii?Q?macAJcjTMTkr28IVv6FZ+haBC9O4pQKzw/B/+82mqVE+O1ThT4jh1esjb2yX?=
 =?us-ascii?Q?EPJcRKNoSP0NfC7G9BpOLVfxyT6bWNn3IP2vPs7dGeTdNcOV6ccnXTp1OSM1?=
 =?us-ascii?Q?m2xkax0lt6LPKUWMqFpKChX3U2j9pNgtNyPw7dQq/9b8izgcD4uj25bSgbhn?=
 =?us-ascii?Q?fbkOPT2DVQlVrAqQA/zaSvuCqjlwEEYYVO4WkmNMT7XDov1LV7AoShdZbB5b?=
 =?us-ascii?Q?JCAheah/QVlRAu74B7/7Qa5dk3jeT5dqI1rb2Vz5B00vseh/od9EvBAy55tb?=
 =?us-ascii?Q?PgPqZ6GdYx/F/xUdgQAR+hIAVAW1A9J+eHy0noGo6vauyaVYy4NnHoKJiSws?=
 =?us-ascii?Q?HTBRKcVBYrUBOJuNi0+BAjZ5c9trWIYFAKU4TiZTWxxRgUWFI9zgfnxmREO9?=
 =?us-ascii?Q?6v8ToedrFoVUdSBG4rEuKU9z8LMPrUUylIHXJx60c8XNuB7p3eCrDk2fX3hf?=
 =?us-ascii?Q?c/PAK2wO3qwX/J1J1oybCgDF/JwUQhNfb++bq34STV/mp9Ed+Jixykfi9l9t?=
 =?us-ascii?Q?YymoL1svKupydaPRcYO5Je85e+ntz8gcGkG5nDIMU1ltKMnsR0XOp5mLfuw+?=
 =?us-ascii?Q?zkjV+00a9z2UUuDVg8pEvvoV7zvkfwT+1aJkVxg1s54N/KKDzJp8kBzvvHch?=
 =?us-ascii?Q?Yx37qtQnHUmuIZgsWp0CwFWHaUFZLLznKAXnRWHJjzN28t2S4kSUORPOXfbv?=
 =?us-ascii?Q?UgSSNacEs3RtmRUs4NFvyEuI7KUD4SnJ2uC27cE4CeDQDQpv9sc6wN2uvEU3?=
 =?us-ascii?Q?QzYKxRyvpSYHIgrtvs8IHVtsDlMFphTZD0s6Ema5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4865ef-32b5-4e9d-d267-08db2942ee68
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:59:24.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZ+kpNqRqytg2W5MGHmzCwjbrrjP9ElNknmS/rvV+uPzIdAib/00cjoyNobusqAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:41:34AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Saturday, March 11, 2023 12:20 AM
> > 
> > What I'm broadly thinking is if we have to make the infrastructure for
> > VCMDQ HW accelerated invalidation then it is not a big step to also
> > have the kernel SW path use the same infrastructure just with a CPU
> > wake up instead of a MMIO poke.
> > 
> > Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> > support.
> > 
> 
> I thought about this in VT-d context. Looks there are some difficulties.
> 
> The most prominent one is that head/tail of the VT-d invalidation queue
> are in MMIO registers. Handling it in kernel iommu driver suggests
> reading virtual tail register and updating virtual head register. Kind of 
> moving some vIOMMU awareness into the kernel which, iirc, is not
> a welcomed model.

qemu would trap the MMIO and generate an IOCTL with the written head
pointer. It isn't as efficient as having the kernel do the trap, but
does give batching.

Jason
