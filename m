Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3B56C1F13
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCTSIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCTSIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:08:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2249F746
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:02:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHkouSwXV8tnhd/fiubRenpN8J7rcStftJgDUssRp2DtZMaUil2VQnOCGYvcsUBBVHlVwsk7gAm1eokP2Xg2/ZyhRYANG97/1bJn7NcfWAgwcKu8ND8hbbTkIRJmgUgBK3jvR1QONGUj/TF8GtsBI9NjkFwV3Azly/QccsvfVWEg76HPSKAGfTFZpc2xE0Q/aDBRp+2SAEteeaK/t4UBHy3dtpjWaaeteyMtzaLT5PHM9mio2KedFMfNAkZnQeLZSqgGV0d3TPANfAHoLeXJQMaMPTGxltBCx4KlkSB4tRulSi7z1WfpihnAnb3xcJNVlOlnZBRfU7X45Kf/0dLC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcUWivWuDVUP1wVlia6Kvijq7ZSoldPhm5+UdvfWUX0=;
 b=IBE85iMyu/yW1fgO/J5CkEeQHu/9y+uutkxVLJcrqObiDsYFxvYGaSrL8A1A/ftxkItbj5hAXqB1yKNnWsjikCyc+iz14MxSX56jdE4FKX0Y3bnkif4RCipAFSnJlNcKBU56BP0x7qEqkGvcNZQfQNw0x84b+82ok4SAbONxn/ohSE6QiPhWFmDMsY50YWiFE2BJkk6LUaBRzAEdx+fOyaTfNJa82jnCLxbRYfQxZrFN20nUcPXKRhuCV1MLPw1jlasHxIHM9KsyxcyUJXXfRt+8Ic9HMsZKb3VeOlmfeGBvMDvPrhZNKqjOK007m+QoEXJFnqeGyVSyYDcEKFYC8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcUWivWuDVUP1wVlia6Kvijq7ZSoldPhm5+UdvfWUX0=;
 b=isNTinxWdwpydKKWxY946beepFf4FJFtNET0ebv3AsonGFDOglLr1lnTK+52y8/G5oXuhUO5Jv7d6bZKEYSKr/eRB/EwRLik9QlTWm6T/WNCeyyb6kYaCNkvyjRoT/8oY7YxdbpsMyy5+o1U4HXC+/OIxiMfrlxJiIS94IzKlBhwixSXMrMHhtHn6umyktjUNRcaiYNphtMgVxazYeXa6136mnTgHqoI7nG/UGdmm02851EYIH8hNoT2yfWTyZBF5DzgUR/qKppDl1gdaPwkBA70idpsx/zlvGtEoQ/ZCPcCeuYkrBsQsNt5xsFu7x/1ssrmvM1Cmq+R/flTZrxy6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 18:01:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 18:00:59 +0000
Date:   Mon, 20 Mar 2023 15:00:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
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
Message-ID: <ZBifWkY2Lt/U1Z7R@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:256::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 12af1c4c-00ec-4203-2bd8-08db296d0fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UcH6WdVl//gesCJRFElNSazu2G3+RPDLqa2AN3sLeRKicumM1M6JzRaL8OpKj9FG0OK4ldeSGgdeu23SLaxTiUWgshuLW06bZbEKB9IOMi9j00Vk7yHsA6kmw142RPUrBHcND35QFKBo5l7TI2MzFj0rhk4m5Bjhgo1ktehMxO2EgzxFfADT1PjqBoHjowKgjJ/ppFmdXT0gHzwIuu1SvMsaz/RzJ/obmTC0dejiVKqdRXsqUY7E0VjijSKlbViKNCfWlIUnAhsei9u4yTfIlWwfNQhfd2UXq8Q+KGqjUGK3ZtFsSd8wIYvcTx1FdwJNPsGYn2Sh7EiCmWQnP5E/TtS6vF4gX2Tk7iu+C29/+JcnLv2mHRjJO4fBqWfBb5h7ZJ4UX62aDhJtr5VJyJKmyGNzR0reX1RWIsQ/5twPY4xSaE9Q8rRq9Ju62J40RXuzqGxbJBA3Eqt/duLacHLCVrwou6puzjqDT3D8s2mJ4DAzYOnRLfyG5aeABUYrS7cPAR6csbvreBz6NY1fYk2GZyzLKMOfS8bNiP4pbmDayBz+U+5SZqOuy44q4p64xkQ6Qxx0zh1U7H2IK6Lw8F3UIvjxkPH+s5A3Zs+ZwSHInStSjiE6rallwK9PfnqJgcTM2Ea7CWj4IaGVesEDa/Djog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(86362001)(38100700002)(4326008)(6862004)(2906002)(41300700001)(8936002)(7416002)(36756003)(5660300002)(8676002)(37006003)(186003)(26005)(6512007)(6506007)(2616005)(54906003)(316002)(6636002)(66476007)(478600001)(6486002)(66946007)(66556008)(66899018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eXYpRKfDEkTnZf1QAL0YEXrIT6ERFpZNT0762q+nTqCpj7nll+aAj1MEphDR?=
 =?us-ascii?Q?GLd+20tnDAtsKmJaAS6XVecCRZANqGsEAas7H7d61HAVfIGDIs0fTY/5OJ+p?=
 =?us-ascii?Q?DM6Ctmx2vh3FTi3zP5c5nfI6YZOcBEnxhudlI/GYMYWrnUEBub0yE8vCWkdL?=
 =?us-ascii?Q?sYlxMAofsNqFMX6nSfa4caY8ceohNVK30IgrON/vmR2rF3myEi7zjWRtMTTf?=
 =?us-ascii?Q?2UOBaAzuvF1dB5y3urM9SPkm4mfdsGWWdMUFEchpAurCC+sMlz11izQkH+R5?=
 =?us-ascii?Q?tSECe9cTcMVdHjSlbjKMKpjKvpW9BIcx7nXVKya2sdDDFSFydQn/oCUgrzgF?=
 =?us-ascii?Q?dGS1s+8OFUSRjcM8fLmPABhT2jzz+nIdaBCWbPX0QUMJTnCE6EFNri0XsvC/?=
 =?us-ascii?Q?XPljfTJ4A/eDQrGhQy8utuvbb5kz1wD3r9VAxvE2PLfQErxJpfp8cAz7n/KH?=
 =?us-ascii?Q?qLHk5KPqulRNYa+7NTqdpwD3fBIOZaSiyN6v4QkybTpRKkU444kxB56oXd1Y?=
 =?us-ascii?Q?wU/jPbkjxyaydR+AUd6XOelsRsGR5cSKpBTrDcOv4q0iCy7yQ/ORgM9bon6B?=
 =?us-ascii?Q?XyvZ4l9LY9sGnPQMu796XROhNbTP5LdH8izccvQJ5Es6igfaZ3XpeaKYayV3?=
 =?us-ascii?Q?A/mL0r8VHprw5ru7yBbGOPyFMxOPvgjV6vughoEpScxlVgR9ozcQhWKtG7W+?=
 =?us-ascii?Q?ItDHM4Rt6gjgP3K+G1bvKIBJreUhZX5LXdF7oh6mYFxAFMRPH3Mv1T+mRbSJ?=
 =?us-ascii?Q?49kTPSEdEl8lMq5Vh/sgLeieuAFjhnlSKuitTtatOY0BLcTwLkfX4vOMljlq?=
 =?us-ascii?Q?fojaiDaffu6xg+ZM2+aENgbnfm0gDl0GJaHvx4VO01dyhLw2KmC0eUBowzG6?=
 =?us-ascii?Q?w3mxGt8o0ovD1WwaGpoR0PoXHt5G1WAvf8HtPqRFKjU7Dmq/7eGcvJGnNxT4?=
 =?us-ascii?Q?3iWFKVNgozgkKAixmvs1VaFjvfr9GuZD8eGy4zr6z95+iq4gQdfv00wTRYVB?=
 =?us-ascii?Q?u1kiO4Jz1ip20wTQp+VQXeIFRO1eIov/Zpq9Ca7qfFOJ+FrqAX8DzyrBocjH?=
 =?us-ascii?Q?x8kI+9ZCTrK03nlTVM0RrhdQxxugSUoWOBzHYaAlJV2llejwRxy4LUYCxPB4?=
 =?us-ascii?Q?T1C58PP0K0Iti+ZRN2dCzM7dkN+W9A+B6JqUo53yljX0btgMsOIuqstShG3C?=
 =?us-ascii?Q?chX91e4k/akrRmycpJW0Xq2W4yPRFMkpsMIM7lK3RPuKrHMgqh7sf4ZCOqP/?=
 =?us-ascii?Q?l5a4T3NEmC8XllljiNzDZhzwk1iEpXLnIeRfFmIkFhv1t1lHLmGEdJ6pOSW+?=
 =?us-ascii?Q?Ml0lid0GWe6ZccGeNIhSvWTeeXT0URR35fvni0/h82wZoFsQp343T/BXxfqY?=
 =?us-ascii?Q?AYHtN3ELx6ghauBie12LyyIB5Ck7RsC8nRG5/SRSifvod2hdxqjUebbaNNAm?=
 =?us-ascii?Q?LgrLFcGarAK7NsLleOoCOVSgEjpDq35qVX5pJDAt2cor9sWNqtNaCr/DXHPt?=
 =?us-ascii?Q?tnUnfS89hYIMIqXmkKtyUDnP7k2HyRLQJCuZP1rTzi+sVBhYEThKS56Caws+?=
 =?us-ascii?Q?O0t3uKCtpq2F9hfQR+MDjrPete8okLYLPDDUPm5q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af1c4c-00ec-4203-2bd8-08db296d0fcd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 18:00:59.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M176XkKn5NIacZIaHi5VeeylPM77QLElmI/iJjmOxr4Yr2YGN28mWXtmmqi9w80+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:12:06AM -0700, Nicolin Chen wrote:
> On Mon, Mar 20, 2023 at 09:59:23AM -0300, Jason Gunthorpe wrote:
> > On Fri, Mar 17, 2023 at 09:41:34AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Saturday, March 11, 2023 12:20 AM
> > > > 
> > > > What I'm broadly thinking is if we have to make the infrastructure for
> > > > VCMDQ HW accelerated invalidation then it is not a big step to also
> > > > have the kernel SW path use the same infrastructure just with a CPU
> > > > wake up instead of a MMIO poke.
> > > > 
> > > > Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> > > > support.
> > > > 
> > > 
> > > I thought about this in VT-d context. Looks there are some difficulties.
> > > 
> > > The most prominent one is that head/tail of the VT-d invalidation queue
> > > are in MMIO registers. Handling it in kernel iommu driver suggests
> > > reading virtual tail register and updating virtual head register. Kind of 
> > > moving some vIOMMU awareness into the kernel which, iirc, is not
> > > a welcomed model.
> > 
> > qemu would trap the MMIO and generate an IOCTL with the written head
> > pointer. It isn't as efficient as having the kernel do the trap, but
> > does give batching.
> 
> Rephrasing that to put into a design: the IOCTL would pass a
> user pointer to the queue, the size of the queue, then a head
> pointer and a tail pointer? Then the kernel reads out all the
> commands between the head and the tail and handles all those
> invalidation commands only?

Yes, that is one possible design

Jason
