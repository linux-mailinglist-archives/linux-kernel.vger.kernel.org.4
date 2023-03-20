Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71226C244E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCTWOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCTWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:14:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB442EFAD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOihL2i3wa4GriR1j+ukiGRSZxLOimxxgL1WboPYYX1+u+ZaDvCXfst2KOiDMptITPu1uPli177kiIj+BM+nY5RPcvKstJBK9/FRIjLfta0FY7gfPYTp2d8bYj4OGaxEq0qxsv5sM2nI7fG85O3Om2RPvSqypwERNYptosrYmMqphbwcw9Ob8DWAZh3p4T/xvhJ+DwrMv9DzjOdTDEETXICgll6KWbw1a+ToMeHmu/ASSlsiNAvGs7jiXfowN6c9VgEGKjUR4vVJhAN1IbYuh4Cd+s7dehr/BbuBt4Ebl9Qj5d233XOf2biYh1oxMRP4tDGe8DN9hjupKRddDAJaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uP1lBgQsUR/qzXHw4Ka9PipaelqChuLMxUXzX3S5oqo=;
 b=FiSdBdK35+RDG55tDyJgESZP4tIakU89bemotV59zqD9cAh95+c398ty6bLezSjk2ZLAWcZaeUOPXc6UR93l0Q0Xa+yDQXcChiJ+KKVUyoJxabMAgd/7M+qZQJglBjTxGZ49lMLT6Iszqe+zZFcLjMeJupVGzJO+Ggh+RIh14oCjtGMYo9anYDEzhra1Mf1DWGdHITeOWJdmTA1mV6D7bxvVLmMQitt6HU8dBLRN1bHh3f3U8D4eprxgEkL1GjxY+bSvVXeFRaT9SzOMUqwjn7h2whKXYNzJAS7seQhBnnn+GFvHFw/uwaKOA/BEUl9ru6SGaVwlSZtgDzG0WPavNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uP1lBgQsUR/qzXHw4Ka9PipaelqChuLMxUXzX3S5oqo=;
 b=YKJ8XjYH2YdrgPJp8NinZ+GgnhqDLrkFHu4i1NpYhNenxI3roAfm+QuclCKhmz3A5NZcevgIJ+zumcwzmm+cbkGeFACcCdm0pAeYXpGaSvlxmdaFmkexuRzUwh49FD/SB1Sj4HXBSkvzUZ3iAPs+wizytgS2q+22GbcWa6yehZVPSnOpvS6DC8M2mqVk0vHdLI5FnNetqLncqh651EXY4Yl+MxkGi9EVAnTiBzkg2J7L3Iek8nbblnCkm5lc+ihRE+aC/CP9aGo9mCcTIEgSiKbYX8K+OKLxl9Se9rMYi5QYSQmNbjfm8WfxbgJGRZjiYAEhczADrsQW2h16fJSsiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8857.namprd12.prod.outlook.com (2603:10b6:806:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 22:14:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 22:14:18 +0000
Date:   Mon, 20 Mar 2023 19:14:17 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBjauQlH3TYbZQ7P@nvidia.com>
References: <ZBJcS07G3mt7gjkA@Asurada-Nvidia>
 <c753c2a8-024d-5bef-8987-96582084991e@arm.com>
 <ZBOFcenanpRsGFzF@Asurada-Nvidia>
 <ZBe3kxRXf+VbKy+m@Asurada-Nvidia>
 <ZBhbmqprnux4q00i@nvidia.com>
 <ZBh7hSX5hdW4vxwh@Asurada-Nvidia>
 <ZBiDcYwxL7eV1EmQ@nvidia.com>
 <ZBiLSJvtY5UKDJ5l@Asurada-Nvidia>
 <ZBig0fN3l7LsUlQg@nvidia.com>
 <ZBjGPI29BE/puciv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBjGPI29BE/puciv@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ff0d1b-74c7-4c27-e06a-08db299072de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h03DPeD3CtvRM4G0IwcuV+Mz6MyePBJRnS1+xAv33ruFuPyNMbXoVNwX2UJUV93/5ybzTUqtMK79atooorxLxgWvZbhglmNIfuYSLfaWu4jDeguTc8w76a9VSwwSuXy9RyhzrVXoLwzckttIxQH55aOyJRNueZbXPzqWwQhGCXu44JfFXs/jDw+aiBekcxq/ozwJuHCijUAJ/PArb0Oamk6t5rSrJhC0fS42DqPc2iMxd1nLdRVn0n2G6Q7R3IG1IpuxecnjA7SrHApajS5/fiU2VTw3pvOp9Pk6eNpYe8yql97jp9gE63b40uQdqHiskY3zKKzCR4jG7IqkBRAHISfNuOM0JZ4+dZqnUkGML+8QPxG6nqCT40h40iwbydQq77JYQ+xFzr6h+Kspi29ivMPv7IjrpIG2lWGG+eKq85YBdYq/7TttMf20WNDLiFpWb837r8HfmHXyD8WhucjcUqmXczwlR1fiU8gRCFhjf1VaNOPPicmG1icUDYHc1fhM4jN++fTtYl0nlsnXMLazc9grwG1YiIms9LqUPLeoqOUNGtlzRIok3MPr1ffraPijOdvqh4UArtMDZfcAdoa3+dLP5cIhuBbc21c+e+ueCYbI+tAQX4bOG8GIJ28SCempu++XL044/4jf/gGRfypsyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199018)(36756003)(41300700001)(5660300002)(4326008)(2906002)(7416002)(8676002)(86362001)(38100700002)(8936002)(6486002)(66946007)(316002)(37006003)(478600001)(6862004)(66476007)(66556008)(26005)(83380400001)(2616005)(186003)(6512007)(6636002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n971/+yhZhhtG1TkMr/Cc4eT9gfoj9aw784GoDacn+KKeDtstW/0xYW9gij?=
 =?us-ascii?Q?3M//fmHnogWWup1uEIHgk0WjEv6hi95qRqJJ5in8QqZ3oBcSX27jyYxx1r8b?=
 =?us-ascii?Q?nRxgRBb4VKVP9b8Iw9gM81HvKKN21hsZObQ2x5BUIdNwn2Weai9I8S0UuUBM?=
 =?us-ascii?Q?32ik8nzWUlBf0JrJzKOZI7KriPHmOvOa3oDw4EFF7Uo2syahMaFLQYqcLRZA?=
 =?us-ascii?Q?Y6zPVvab/lXLTm3a7m/ggTYZOQiOjqxFCRF29wNHBMRYRwoXvLUE7aWTi7YU?=
 =?us-ascii?Q?dGKikpcoZyCDJHahe/Qw+1UF65YRYoRRJwYO0i8u2/6jQhZ5BaM8J43cvEK/?=
 =?us-ascii?Q?z32tD4fgaNYEcy85g9MrnQFhOkq0g/0BjvTIK+UzjgeN3u9Dg8KMWviVYcj1?=
 =?us-ascii?Q?gaXn6gHsONsrZagnq8hVCZKYP0D3Ins0hR5sgnKCH9LdbRfiCh8smAfRZih8?=
 =?us-ascii?Q?tW/1zIBA09pswc18Rzh/o2XZYTfZaU8tgbS7ZyuOrEi2uFhiuVALY7qcYE/C?=
 =?us-ascii?Q?G74WXbfcYnPmEJMk/34V1EB1e6F5ahaqISh3irq8L7QXSOWgh5Kc7wOPSerg?=
 =?us-ascii?Q?FJ427WmOtOZUHZuKreFfA2bAlqS+291gPZA7R2QLlw4mYHw/StBRsm2GgKnO?=
 =?us-ascii?Q?fNCG+VmPJ4P2TsIKKccDvpA674ZRb3k5I2bUy3yO1MK/d03DaFaqQWjagiiE?=
 =?us-ascii?Q?WVrX1QQBwpP3pK246j/6xBctU6eimRlW0WL04Lr7Jao9hIZy2x40FxSpnQbX?=
 =?us-ascii?Q?DVGGnSVCqlZcd9XyWHWcWCgu+b6ljwT/kY/ShFDnOQHcdT6TLU23ZQ2SOfZg?=
 =?us-ascii?Q?/6lBKqiRF10RPhW/CCzXt0getzSrInJAkX/G38BH/5KxlSVaLvpJBX0+VIEp?=
 =?us-ascii?Q?T8WmSqMRLRLyelK7tDk8AyJPec6xKnrjRTTJd6DIwQgY/220Z7NBZXZYTqdY?=
 =?us-ascii?Q?+CF9XKHCcDULyXW2+kpP3s2n7tpODOy4VwDzsZ71Qa/r+NV1c5hW+IQ1k+MI?=
 =?us-ascii?Q?fNKkKKRJkMJFj5Q4q6j9aF0UD01Q2sSRYdEHKUqWRvRaJgTDXNKxiZbDg+uR?=
 =?us-ascii?Q?Ia2F8zYL1Gdsdo6mPcvj0lzFcalJKyJMLA2a5egC/z3wFVU4gTSCSubx0Akw?=
 =?us-ascii?Q?ykYDQ8A8ZINB9HbFT+BihGNbyTr9XaF1hTegbo+cK7Di6mgBQAfQaZA8W7UV?=
 =?us-ascii?Q?g33+9UvX2AXkSbk/gl+jcU96ZatrY2p0Ijncx0JrOHeKk9dmCC7YrE2OFz8J?=
 =?us-ascii?Q?61OPvhM40l2n986V0yrwuQTKNx1Optz5EkPQImkMkkx9kDnVzDLJqNl4Yab/?=
 =?us-ascii?Q?CC+DaBdn05RX159H9PkXo1W/oo3YdcMJxsc01hUS6jHJ702AsoSBdpstdkvE?=
 =?us-ascii?Q?MEapQNBbqsBoW4bguQNuojwVATinlTF6wl9TekE+AQA/AkpgRqX2DWo/eOLs?=
 =?us-ascii?Q?H60RtzrK/sa9+8l0pqAN+OM2i+hCmPu6t32rwv77lquZf5WDBWCY7fLC+s/I?=
 =?us-ascii?Q?WHAfNSk6LVOblsimAyvMiob4vbzvaNHWkIVG7ds3vQjUUvag5IW/JvDDQXL1?=
 =?us-ascii?Q?YBmTEa/Yd8wEQagmhMTb1YJdprFdP2S/X/SrmJEI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff0d1b-74c7-4c27-e06a-08db299072de
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 22:14:18.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIRJ71eFIPF+ii/E3LnhdjyESme157talH8oz8HjSslBM2kv7R+ZVpKvnLPtG3/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 01:46:52PM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 03:07:13PM -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 20, 2023 at 09:35:20AM -0700, Nicolin Chen wrote:
> > 
> > > > You need to know what devices the vSID is targetting ang issues
> > > > invalidations only for those devices.
> > > 
> > > I agree with that, yet cannot think of a solution to achieve
> > > that out of vSID. QEMU code by means of emulating a physical
> > > SMMU only reads the commands from the queue, without knowing
> > > which device (vSID) actually sent these commands.
> > 
> > Huh?
> > 
> > CMD_ATC_INV has the SID
> > 
> > Other commands have the ASID.
> > 
> > You never need to cross an ASID to a SID or vice versa.
> > 
> > If the guest is aware of ATS it will issue CMD_ATC_INV with vSIDs, and
> > the hypervisor just needs to convert vSID to pSID.
> > 
> > Otherwise vSID doesn't matter because it isn't used in the invalidation
> > API and you are just handling ASIDs that only need the VM_ID scope
> > applied.
> 
> Yea, I was thinking of your point (at the top) how we could
> ensure if an invalidation is targeting a correct vSID. So,
> that narrative was only about CMD_ATC_INV...
> 
> Actually, we don't forward CMD_ATC_INV in QEMU. In another
> thread, Kevin also remarked whether we need to support that
> in the host or not. And I plan to drop CMD_ATC_INV from the
> list of cache_invalidate_user(), following his comments and
> the QEMU situation. Our uAPI, either forwarding the commands
> or a package of queue info, should be able to cover this in
> the future whenever we think it's required.

Something has to generate CMD_ATC_INV.

How do you plan to generate this from the hypervisor based on ASID
invalidations?

The hypervisor doesn't know what ASIDs are connected to what SIDs to
generate the ATC?

Intel is different, they know what devices the vDID is connected to,
so when they get a vDID invalidation they can elaborate it into a ATC
invalidation. ARM doesn't have that information.

Jason
