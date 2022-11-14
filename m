Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35104628407
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiKNPei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiKNPeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:34:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FDD26D7;
        Mon, 14 Nov 2022 07:34:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhgv1dupQbBSoIXl5Zk6y9PIKIBKr6yqXdrnRbMt4+LVfxyqOnPTzL8M1zIlXY5J36Prb8+Pj/2HejSXC+3o6YE9v3Tu9mAmgGffz0ph9fSKWqZajR0jEaZ/vFrDSIhdfNlUuIArKzyo3MzKuU3jftG5sUFiw+Q8bemgBASqQrxugBzowBUX+CHggv9BFn4Vs8YYfT9XOcb77hsrBdbr3O53ak1OMYLJs+KaT/W3pM6YNURhZ69B1+sbajunsPPfhOwCwFmOX50V91R0yKJCbaZc/9maqxvfMrLmbYrRQLI/ZxkKvQfhLGvJ6phwkBWIs7LW78y44xa2ALCyhUUb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVdHVDiRbwmZKbgjTqucKEUEjQruZdPwetr7N3VCXRE=;
 b=kZeP6JPBdTG5AU+lgDOxF6+RLsSm7JKRdi0yw/RtGDmfIQLJmIVJ9UfWBABEG5+HPxmmtroEr7omcUwuZDyPoXTuRE4x/7+G8EhTFubP76Wvp2HwXuUZcontKOACeHiwrcinFR6HrpknnkbHRlk2ga0seVNBfsM5w0H0/0BNR/Vo+Z3rOzger/wvp2XJ0/0mwhGZDRiGg7iIicdPfNE/SCrxVXU13imGlpq9wJToeYIkfbCWzMuedqSM4NFf0NIa0S7XEy8ppHnBMPt+KcbT3raLp2ZyY3mSKY0o7WUbWhbwYCUfv04EykzrqzAjQGo4siXXeebGeyxijuz/WPOS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVdHVDiRbwmZKbgjTqucKEUEjQruZdPwetr7N3VCXRE=;
 b=Z0T53IOPexKoFsrIjqvj/Vxki5QPn+W+6YOX8tNHgU8zEgSrF4Vv2L+xXIn4Bax2W7FFicqQDTbPJdmgvyNNcz9cPNgckkAljgqYc6EBi9/qJcDjvRrenqnCPW9R7KjxOMwuz90dCuPzAyFS1fIIrW/wp1vq8ESmzmsht3LZIfINllu7UwnfjW9FeYAL0qw6zgA0mmp/9zXoXZlOjBN/dcl3rPJOPP5TSq+sGIf2LHGsP/TdX67q5KdLvb+gpxCyWzggS4cniukb7XKkgigOrW1rRwdC08ePHgmCg7mBKx5lMEj0eIU6BMYoZKE8wgdl+s+7WEkuT/PLPv3MbQ2yrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 15:34:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 15:34:27 +0000
Date:   Mon, 14 Nov 2022 11:34:26 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Anthony DeRossi <ajderossi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the vfio-fixes
 tree
Message-ID: <Y3JgAr62abZPVPn6@nvidia.com>
References: <20221111153735.07a2bee1@canb.auug.org.au>
 <Y3JEK376qqpBcYAq@nvidia.com>
 <20221114083207.49d2274f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114083207.49d2274f.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e9c0fd-0e6e-411e-70aa-08dac655b703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZM5bT0DGoakVvYy8jZf5YMOKNnrG/04OXaJZmgVdA4caXq6Mqe2Y0Oego65SX0a9ELntRwZ/UbUUOR11MuWE76j1Mb2Tz/KvQNqBvFx67f5mcplAeFHkIgSwQqjLXcQJdVyDI6t1tfIlSOvs2IYE9uscY84ee8R0FP3aWQ1BWLjNwRVhZ04dngiZ5YjSyxytbClgDjxDQ+wZYvl06NWNgpRLNv1Xu0hzhutRjU3Mh/7a4jMZQEf0ZUA+nqBXZqs/DFBj/UQixcDXRU0lmLW6MANu875XRiHu1DrC3Ru31k80rsrLG8jjijCNqnB1VVNV/gmiEzLeI6igdJ2YdCDavL3zIWv8e/Y5wTLyX7H+3tZIsn7btZWUPTqeRiY4qAKY3eN0nZDECa7FhpfGpNUmhuusTRlCHTB/vl53Is6PAil0R8CTlmzq3ozU7fpFINIpLDKA+6eFzLeFCf0LM4SmLTCVtQ7sCamD67q8OeFNCnfowtBIzv83npw+4NQiiNG2vj7h/BCWn3dLYv6a5SIkOmd8Kycv9O4XektA9zomAzwM1IVxG5eMCu3TIgMsZGlWg3RZg25qgFJB5d3T+eor422ZjF4jKyYLO1Mg+0zzYeTYwoe2NxC13zOA/xt6cElqf6a8KidjjhiyZHb6lygxOEhrhj6FYHCgB45PPpIm/9msL44A4YwIXjPhcFYf0Hr+q+t3s9Jq7Gs0IU9boVY1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(6506007)(478600001)(86362001)(54906003)(6916009)(316002)(8936002)(66946007)(66556008)(41300700001)(26005)(2616005)(6486002)(4326008)(5660300002)(8676002)(6512007)(66476007)(2906002)(186003)(36756003)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZ6xB/P5pYwehkMq3njNr1RUyXybMYvnUDZepXJknQtQWxy+xRtQ5toqc12m?=
 =?us-ascii?Q?SZYzY3mDXpRXQl0XnOgdc9Uym0Px1xqQWTSt33KxL34imFrkseLFrW7e+TPp?=
 =?us-ascii?Q?o74oSL3Kmj8BBmgvpGHcGTu9YkaEM0Br8WE1FiWxieSZbya2RNnbkpdaUO02?=
 =?us-ascii?Q?pYGqd/vBduDGdHNQoUJj6pF0yXgGb8rOfODtf1bjweJZ9taOpZOu0GAo+Tg5?=
 =?us-ascii?Q?pBkGpRzvfdovynzKxY8FueHMqXMxFcxznigZUN0TfY6dU/KMTTJ6LEdFn3r7?=
 =?us-ascii?Q?4HKvTfppFj/hmBzAYKGHhqUFovYXIepPl8CT9NexF5+Jfp4PFIJ3KpqTMwl9?=
 =?us-ascii?Q?1L6kXDA/kWD3m+WtAo/tchfZmr7Lj8E48AptV+eirSMKjA25hp3HGa/fEUPE?=
 =?us-ascii?Q?FsO6BUWICMPSD9vJNi7ogC0q9vvrISdOPAESfgy8NgD+YZz7ZSi6fNQRKP0e?=
 =?us-ascii?Q?fA3aQyJbfDHrlE8GReZUgw1zastsXQpNJ+Vuo+rocIGJjeBu/uoO6WyblHCH?=
 =?us-ascii?Q?2VPmhk+t1anAdb8n0V+AAtpRAZ1jFYFG+E9yExpbiDm8rg47uAnwpH1tLJQf?=
 =?us-ascii?Q?6iDzoKkBC3MegtszkPihiReSVS4RmfpNbEcQaYC1qOanlRlNJ67TbOXF59oL?=
 =?us-ascii?Q?U6DbOHFRYfExn2Fq6Ek2KXatr1xODMZiqBm/hbgT/ccmvlT5Wtt7dR+V1F6W?=
 =?us-ascii?Q?OED6hh8M6p19iqPa4l/8SSLMADg+h208gekxulhtFKMG9oOHxSW5tCoMhnAl?=
 =?us-ascii?Q?UCjtHqdF4oQmnBZUpRPR8491R6jk67DEIUH9csIVrmWbd6zielWkgIIKpfGY?=
 =?us-ascii?Q?JJ0bp0iEAESCb5+jMKaTjI9kHkg9UwQ3z9fliLBldH12c0d1zdOg6Fo9q7H8?=
 =?us-ascii?Q?6bsufx40J1yFSIJwl8GqAkLLXIBscEnBynxaiL5yVd854XB6COMQkT+xBHDY?=
 =?us-ascii?Q?t3q6lanNFpTnx4prSsCY6MlsbBgV2ACNULHxv9tdtdzW0VR+5/aZLex1/Ppj?=
 =?us-ascii?Q?VCyhgRf+LFjbQ504VHVskoS4FMjYYVKb5GuurE0UX/hS637XgK4EJ5bvY3fc?=
 =?us-ascii?Q?8bs48BhdOZ8YhKQBsDI8Q3zRWIJBiQoku6+jLfUXU4bvi6hG6gDAXpH6bdYy?=
 =?us-ascii?Q?h3xrCKWaffZQSIhf6KomElEyhWiY0tMwOFxZtzj/byALBDAXFLjbUdbiAgmm?=
 =?us-ascii?Q?uTsTNgIQL/9R2AAWr6410fV+wI4bwjZNbJXSG7pyCF6CiaImwoGiCdgNXza6?=
 =?us-ascii?Q?2/HPccy5MzE4+valp1utaWg8BGSnbXWyBvzgaMNn3N5GvekfV2TloLIho6WS?=
 =?us-ascii?Q?eFxcSYfrNuUSnMHxPzyDcVeK4Rjd+9h04tkbxXFvix8URGOXnfyZbddnJ+Yz?=
 =?us-ascii?Q?qLEzWDK/ALAc7AwqdGyobZDJ1werUySZ/4VJWsjCnO2zeP3a8V37ToSqCH0n?=
 =?us-ascii?Q?yzMQ7rQozcSW0kyiUMueYEnA1f5evzpGG44luR5YhTIQG0HVSDNsso2p4MYI?=
 =?us-ascii?Q?EHcEj1BHkH7zHJ/h4TEXixJygR+kvlHdhm533oSU9J33tb6FDXxpOApNwybk?=
 =?us-ascii?Q?7vW9TBSZIYwAJaLvCKo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e9c0fd-0e6e-411e-70aa-08dac655b703
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 15:34:27.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFsW8gvxmcaRjKRTf6C3GQcpG8waCt6omfMj5TXjM0J8hhS/TnupC7CvNuGQnoxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 08:32:07AM -0700, Alex Williamson wrote:
> On Mon, 14 Nov 2022 09:35:39 -0400
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Nov 11, 2022 at 03:37:35PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the iommufd tree got a conflict in:
> > > 
> > >   drivers/vfio/vfio_main.c
> > > 
> > > between commit:
> > > 
> > >   7fdba0011157 ("vfio: Fix container device registration life cycle")
> > > 
> > > from the vfio-fixes tree and commit:
> > > 
> > >   55e16a188913 ("vfio: Move vfio_device driver open/close code to a function")
> > > 
> > > from the iommufd tree.
> > > 
> > > I fixed it up (I just used the latter version since it seems to
> > > incorporate the former change) and can carry the fix as necessary.   
> > 
> > Yes, that is right, it is as Alex and I discussed
> 
> My plan is to merge back my fixes branch after it gets pulled into
> v6.1-rc so the vfio-iommufd support can be re-based to avoid this for
> v6.2.  Thanks,

It is fine, I will just merge v6.1 release into iommufd as-is, at the
end of the cycle, as I often do to fixup these rc conflicts.

At this point, due to all the testing, I don't really want to rebase
iommufd any further if I can avoid it.

Jason
