Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F7F6C8028
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjCXOo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCXOot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:44:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90387F974
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQUBPiHlpN6mYKfVcHOKXcTve8/1PC4Whw4u1N4RctB2U3e9VG+Vgh6siaCa6jrmQpvsZGaMEbD87yijkDT2haDyku9KDXPAmTMQLU706gNppNStOTacIzIecTUTSme3OO2S89gsPU9lnrOBD+RG6Btmr5ad0N+dw8ljj7HO8DcZaQFwjrQgN9qr+Mn2IXbatQk81YR4WEOZShMwH6Hm3ijvCySog+BSYwMi41AVOkBqVwIPRfWhge5MWwxdBQ/z3HyF+hGWf3PdYCtnZ/gZ+2UoIXjdYqaxUjaUr8d8a2QQqJpPVCaXO1C5u/wrEPpQ7yMmg0qUnoBNqGyMuFYUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRJVY51sfFVDIgTUzqPwz8YZcQXhngYm4rB+95fbn98=;
 b=NjTqqI++PQDtah5QT5Y8E0vyjm8C6BCXYBi/w4yUpqt8G3A2rTVGvL8SmC1OsZ3JHsN+YU9njTnmyuEyC8KpBlE5SkLEgK/KwYHMZgYZkXCnoRPAfzmfHDuDCAr4NlUnqMrksR0ykQbnMPRbGJTGQmK7qoieWvTGp6dMQnRGgGvl+RBM7Z0HGWxDNxmc4OVDtd9wzrng/6630ez5Iy2OCnQGJyftWEXR910MtUeEnoKJ8YetGVto3H7idwAGC1oGfLKgO+4QVSvtfRvYWBkSEBo6pCud1UJpmUuX1HDZ9KDbcm8paXK34YbNY4vbRdJ9zz58F1O5CyFu67CmPwoqbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRJVY51sfFVDIgTUzqPwz8YZcQXhngYm4rB+95fbn98=;
 b=P95UKr0QbeEpGjFrQCyTrPhU0SwZmO59Xm5eyw+gxCdUNnVbzIJ9+MlAwJXDTOfTO/wJuiWtq0YQ7odgxA+QKI4u915T06vsSKJGCUOvWd1k0nsigwcBNoTIhws/ZAf2GUsl71e9ebDHLNvfcxvklVAMvtwoSudjrN1o8fPdGmGbvpM+a+4dMWxtRJpkmIIRSG70RTzNHCO1T0b2BTRHjRjU9m7YoBhIjROG+oos7y4GBWbMOneJ1PeYG3968KfhYA1Rrfsu5df6b9+a8MlzsbiksRbo331OCS/lyG6Ec0TIGO7549IX/DQvueGbi3plrbi7EbJURRaw5hmvnuft1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 14:44:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:44:43 +0000
Date:   Fri, 24 Mar 2023 11:44:40 -0300
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
Message-ID: <ZB23WJu2BEH0yC/y@nvidia.com>
References: <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527663094F21D3DCF8A3038C8C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cf7c2a-0a6b-4f19-fbcd-08db2c764e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZA7FsHZ2Oh9YWGJM67qsiL1FfBPkGPovf1sWxV1vyXA1t7VtKOhk69EC/OP9OoAPsInrnLP/UFY1Yj9rNhWkVnwfsc5rbryFJXPZJcgf7H8BpHnHpJ5jpcettiP9hJeaglX9jxOTml8I0CcNMFk9gD0ygamXmZjKZxUVm0hAXZT8Z9Vv//f3XR+9BB0PibacXQnq1RIdKXMS6Bqs9dW5mO0vF6IOaTU46P2BuJQjeR/iOuJl+KJ+mtvDPJYCL0KmPdHfQ0Ggg4W00QZbFx7FZJ6PnDH2pIyqyaYgh0Q9qXac1RkU+68wx/CjRF+47ky3W7Y9SvOIIb67N4JSQLGfIqROSt9Y3BoOwqmf0yjFkUrBav2pcS/e1hmEonBoMbqqSTYn454p2WYfH9isZT1n6ZbPmoSBm98bem3zyZgB0tztAQ+W/vwUv7HAJvBHXkvBd83EqB6Z0vOX91YKVYeWx03/qEullfBrfglC1X352X17QYTKvdFcD01EJI6Awv4J2tmrcEzZSOO2YMqxDZW+SXYHJJ0U6mmpxYcJj+jAZI7pC84nugINTaE0KqrRjJf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(8936002)(66946007)(66556008)(66476007)(41300700001)(6916009)(4326008)(86362001)(8676002)(36756003)(38100700002)(6506007)(6512007)(26005)(2616005)(83380400001)(186003)(478600001)(54906003)(316002)(6486002)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3Pms3V26pC6soAQYack+c3PII+Lf31mV1VrgHeFEqtg3svopv1RTtiUlSS1?=
 =?us-ascii?Q?x5kGUg8RGy+kOjfWJnwc4Azf8ybAW8ciyDJdIavVd1uG/rg/DKgIJYK1Iwez?=
 =?us-ascii?Q?TVQkpNyYyo1msEYkmP9VHLKs4Q5e05sF/+F8X1udykNeBzz9RBKVh2aehScx?=
 =?us-ascii?Q?67CAPam9s/5eVrOEcVgfjnJLTeRr1Rdt90hDgKEA9uDhceD8Ch/DIEjIL4ym?=
 =?us-ascii?Q?wkVbsQu0FYxPPe9idjBPTR1LEj4fq8OrPMQqq7qVJSHPJt+ebEFRKLRlrzl0?=
 =?us-ascii?Q?cNDbQm7IhPGVH5RBWclgd92+9RwFNNSnkAr9J1o3UDINqvfFN0Uol/Un8QM5?=
 =?us-ascii?Q?GtbrnYJMvBHTo4kvToei1uUkYiiV3qnQfdz5qJe8Vi0623Lmkc5bdhqYrszK?=
 =?us-ascii?Q?BqiUSZgbjxXCJYyrLSdQo4sJntN4tS7k2A4luDzS1umyA3IgqgRTkCfCD7w+?=
 =?us-ascii?Q?0wf2sMagQs1sGLIPZPn30XRB2XwXmbkYWuVGczyDLruGdiRAvKlZHUto6Khn?=
 =?us-ascii?Q?5+aB6b8BHcwzQQEQfOB9YMC/PSMxTTkpvf/NE6aa9y1Qsc1L2D9WLXNFyFuD?=
 =?us-ascii?Q?LJ+6i6ysJeNIPucZXzDsFKZK5kH6ntCl7EFdaOcHlsJ7Q5esL4dH1YGVTh8w?=
 =?us-ascii?Q?1Zi24Q7nhqfnqkqUq50A+ohwiIa/UBqDIRb1rnSkdxijXOXlYirf84yg8MR0?=
 =?us-ascii?Q?46AKOdmvz0XtmWvyyTJqNOkoG37fMBlc6EP607Z3z6Fx1FiQIYxVhPJK1p1y?=
 =?us-ascii?Q?KKK84fwvJQb6AiEzy1S3lCdzk21+l1ln1KoFshMKa07UR7B1vz/DM6+SzfXY?=
 =?us-ascii?Q?qOD0TIfXdr4CB29/JBK+lATLmMZldhap9NCDUiuRN2zyRvAKRwIZj/qvVoZp?=
 =?us-ascii?Q?MtQF+hR/lyt9i95SeRyzTJaIATv0s+j0Hps7NfciwUMtT/OEtS1G5MUQRzSN?=
 =?us-ascii?Q?YJr/C4jYha2oB4fTGpAPyf6W7J7ON4NdMCjCEPLfzA4Q48I4QgixNmBZIPWU?=
 =?us-ascii?Q?EJYwuyLdOWnK/07MOmwGpm5nrA5nvUYZ9pzSEdg6bTswnMdzlI/dwzMi22YV?=
 =?us-ascii?Q?x6+cl7WidsUyzXYpo+UQlrGHlX9U+5j6z3uMkHGdpZTQ38/mnd4uNyrnPAhN?=
 =?us-ascii?Q?SsrRiphsR19WVtQ+F79k2epi6yjrRFOQZ421bWyuqoebYCfR7NJwl0SI2E5S?=
 =?us-ascii?Q?puoCSjbA8MlYroWTxuJHXb80VrWtfD4CRXFrklNbQHtehuE0cz0JDkpoQG24?=
 =?us-ascii?Q?4sjTvVDp7b3pmWlvB7ttOLzeN/nxJFF9ZHIteMME8/3Knd7O5zTgw1+NvZwJ?=
 =?us-ascii?Q?CIkjKzPT8NUrPnhU4EJZhNhg44r+AXDSihyNykgG3iy6byAmDDb9pymh+vqo?=
 =?us-ascii?Q?X1Y/pvbghpIwJryz49HBvOTb2Q0fSeL3Kk5bxDhhbgJXJaKsjaAPU9Esto+K?=
 =?us-ascii?Q?MQg1asuC+fXOeP+ZF4jLFkMPgsdiLhePJS+aX6fB4CONo9seldsNO+vpJKYu?=
 =?us-ascii?Q?kmwtOo2L/ZqEIsAzygUEdUYUF71sOAfibScZy/hdTTMOd6rE/xSVN75DhHEf?=
 =?us-ascii?Q?JHPObnmmWGAVFKCLAGPBTYw4YvxQDTQxaj6oTzQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cf7c2a-0a6b-4f19-fbcd-08db2c764e45
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:44:43.6529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pUPr3OFxZk0+uPjUCX+p5HMlcA4rPfg+dz4cNCE/NBWAqorKqEOWXGXZ0n2UX/b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 08:47:20AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, March 21, 2023 7:49 PM
> > 
> > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> > 
> > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > user pointer to the queue, the size of the queue, then a head
> > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > commands between the head and the tail and handles all those
> > > > > invalidation commands only?
> > > >
> > > > Yes, that is one possible design
> > >
> > > If we cannot have the short path in the kernel then I'm not sure the
> > > value of using native format and queue in the uAPI. Batching can
> > > be enabled over any format.
> > 
> > SMMUv3 will have a hardware short path where the HW itself runs the
> > VM's command queue and does this logic.
> > 
> > So I like the symmetry of the SW path being close to that.
> > 
> 
> Out of curiosity. VCMDQ is per SMMU. Does it imply that Qemu needs
> to create multiple vSMMU instances if devices assigned to it are behind
> different physical SMMUs (plus one instance specific for emulated
> devices), to match VCMDQ with a specific device?

Yes

> btw is VCMDQ in standard SMMU spec or a NVIDIA specific extension?
> If the latter does it require extra changes in guest smmu driver?

It is a mash up of ARM standard ECMDQ with a few additions. I hope ARM
will standardize something someday

> The symmetry of the SW path has another merit beyond performance.
> It allows live migration falling back to the sw short-path with not-so-bad
> overhead when the dest machine cannot afford the same number of
> VCMDQ's as the src.

Well, that requires SW emulation of the VCMDQ thing, but yes
 
> But still the main open for in-kernel short-path is what would be the
> framework to move part of vIOMMU emulation into the kernel. If this
> can be done cleanly then it's better than vhost-iommu which lacks
> behind significantly regarding to advanced features. But if it cannot
> be done cleanly leaving each vendor move random emulation logic
> into the kernel then vhost-iommu sounds more friendly to the kernel
>  though lots of work remains to fill the feature gap.

I assume there are reasonable ways to hook the kernel to kvm, vhost
does it. I've never looked at it. At worst we need to factor some of
the vhost code into some library to allow it.

We want a kernel thread to wakeup on a doorbell ring basically.

Jason
