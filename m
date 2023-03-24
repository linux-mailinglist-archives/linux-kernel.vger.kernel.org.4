Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD46C807F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCXO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCXO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:57:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3902101
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 07:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VckeSvEnyvrYW940c66zD6WvzBLmjy18MVbPWTIWO0tVsbsX7GmvUkRxGYW9OWpSw4RaeJihnbatIHp4t7gPNdRaujXzLg/tqjROa2mChlWwpWTg5OgLwhngZm79NqC9x5albGt0Mri5lCo4AyuCj9lMp75UVwyZkU/HYrj1iJMyGSnJghd2mjMjWDrCwEjrS9NzhVm+in/dKhzyhNjH+2CrylHUksypDuv6iddfjVdKTGG19lzTaMkfe8LQ0nzDJj9QK1HP3l/Duw5wLvjAsVDKbPN71oVthMUpmvFmJKX7MwWGgt+mmQRS6NYAT15JW6rYUbRSTuC1yvWe0B/+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnP6EJV7+nArb1p78Gs57m3JaocZxF7e/jxXzQ+shNw=;
 b=XYGWP8SICWQgSgTGpD41nQ6FTGUesTrRap5q++QCh2omUhUchYyfSjWTplIXP9ueHAvoUwxlhLWviMpIN0NmlaFPFzOlE19mxBT3ZftAud/bOPSpzd2Kt9owlJGKaxM2JerczaLADNmmBqlu4giwh5BA+353/gCi6u0FPsnW0I5fck9deMS2rhE2ijaqwTVfr3gz5X9brWJHaKzPjUZfeLwylrxBPKFMVqHCF9Bp1wqSy1cRoKoHQbIMbTyDKaUtuACMQuGt+3Rws3vYYsFbIxKS8TcnJLsuhOu6bgtsTH97W4hurQZk6NEr5DjYdyqts7dRaLu+YcNdrjmZRUmbAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnP6EJV7+nArb1p78Gs57m3JaocZxF7e/jxXzQ+shNw=;
 b=PZTRd2ES1C9oXQqrJc1qEfpWk6u5FjGCLLXZdbIpYFsZtYfz4DwpR8U8j5XvFfrw6H8SXz5QpmFEYOqqtopoEg39wxk6w2wxDH/A9AFBpOhuuEJthYvzZXhemA9tutCjWrHoewY2snhrziXJAr3z0rlCUUSrUakT72I2S9AjUETkUqHonlM372PqJyRruxsebaz4SdY94fdzguebCIXCGnMCONG2VVOH76QgzMrsDnw2xmEkgdlnexyfNp4RCGYnKaKD8GOb4GI9sgM0sNg2NIH7PyW+EA19LJM4S7JChHtEm7BNMcF9+T0KtekkjeHUEojnbJTEKBBPGdHNiUL1Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6464.namprd12.prod.outlook.com (2603:10b6:8:c4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.27; Fri, 24 Mar 2023 14:57:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 14:57:13 +0000
Date:   Fri, 24 Mar 2023 11:57:09 -0300
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
Message-ID: <ZB26RWV53wYtc2L2@nvidia.com>
References: <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <BN9PR11MB527622D86AE048D3394C12A28C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527622D86AE048D3394C12A28C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0207.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: f409679b-441f-45bc-1aad-08db2c780cde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9EUtnEp95/tgFAKFrTkPG2hm0/cgDA4fhn/XZib71cJG2RDZSPrkWPnqlEZ8Qja5Gn1AXKqAb408KQfQIiaTj8RGFTpQjX/QWO/0i32WEcWKtsWcAaIQ/uIbeJssdN0TYcdkaYgoAce2yvOvJ5l1zQRgChdwEaevNuHzSHnfyTAix2u7OJcWvFPxf/hhgYrLtKFmlMtP4NziSDeGPcvSlhFmL1tG8z7qjgpY2C91RL2zphZn4GqSjK2vBU9mCNh4fabbt1dua8MqQfeGNVkenQuSdG4fTOnc0G76sJUQvywGY4+V5RPxPOY3hVwGVKhM7mnlcNWnCTa5bqCYkucpCEnYH8+vVV6CyrDSxZKuOQUW4kRgLZ8iniqqCyaXBfHY1H4ZgWLSOZ/9Ldm5lk4DwbceJB/muNv68WBVBi89YTIdmLgyBtvFccenW9WDC3OqZ7sIrTjdnK0ZWh55nZ+fFcIABh79FZFpNVLvedY7PocT//16ddOEO+BLPf1OGD7J+PL8B6ZDSjm6o24fyHpDj4qHBRezexA49LY4J2bupyegIbmjp7EWIWtX1nOdQRiw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199018)(5660300002)(66946007)(4326008)(8676002)(7416002)(41300700001)(8936002)(66556008)(316002)(54906003)(478600001)(6916009)(2906002)(6486002)(26005)(6512007)(6506007)(6666004)(83380400001)(66476007)(2616005)(36756003)(186003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sETZEzhFUo5qOGl1eVsOPceP1bsriXMawZyi/kDJn1qJMUwV6dJdFNxapVVr?=
 =?us-ascii?Q?N1ITa9DmrFEeE6bZ2M4/hPvUy+0cuGKZaUuiLxyAeYhTknycJmScDMv/G7s5?=
 =?us-ascii?Q?3+WKGR1CcuHf5EpWi0OAZq1X6vromD+avzohO2rrMA8+R6Q/HHxJsbHQTdZX?=
 =?us-ascii?Q?03V/errFIlAEukmV98TXh/rK7w7O0Y7Euc9plB6g58MghXJ9rPZ85m6jpDyN?=
 =?us-ascii?Q?6O5Ck1+RvgJr0ad0vOtIyukpegh6sqeL1Z3epq+D3eyxW1pxstJH1S9xmYtq?=
 =?us-ascii?Q?PiRDv5HOxpTc6ylvRu+YCcQ4HqZu3DZhtHk9//IuyLbHUBnq2JdPCJYBPtqE?=
 =?us-ascii?Q?JkUHgCgZsobb5K531v1VSzpCYgd3qXucPD9zPVthL1eVNeyTqj08EPDokOqz?=
 =?us-ascii?Q?X+9EmIX1YWl0mZQV4ump9i/jFx6TPcwK2MUQrYTwliXHrAMz07Nosn6QArBp?=
 =?us-ascii?Q?bjo+AQm0143IwBGcmG7ulM/CfTDWVSzHpuEPosmvvto+lXMPOOqvH1/fI0Bo?=
 =?us-ascii?Q?tb11BrWDy4zEK8ljKur5yyHq32xmLcOTmfu8XS7Kbhgo/V+C4J/eWVchmi7l?=
 =?us-ascii?Q?usHeYy0v+IXH7gwTHM0gbYuiyRDC4d1TPmWMxk1LMFH9IPeALafXNSZXwJhV?=
 =?us-ascii?Q?cX4b9jOvXGKd2wYlaV9zp/lms3VK2d/hmHigMqb+1yEYFMnr7S7xAxuBy++/?=
 =?us-ascii?Q?vQrfifjDqav4i09M35kxJZr76lDYju9wFxKY8gYrNGBRZBzjimWDkUl3y7GC?=
 =?us-ascii?Q?iLiJmBbJdiPdxbRntzVcASR7ielf0wrcR5cJ9QjTJLGiAm4jb+YKyDjPCcua?=
 =?us-ascii?Q?78USBEavxDHaHLkSTTM4SFyZ599+jcaQKKW+4a9oGceEP8axjhf7Cc28DOPq?=
 =?us-ascii?Q?HbD4C4Ypw9heevF1kEJl7OmaABV6elSLlSHOmyQXaXqvQ19FzzWuSvLOZ7Px?=
 =?us-ascii?Q?rs0F5BmUXpI8jk4EB80RRqoXG7sUmMcJInhsLMz4mnB9+KvM8syLEVIoJdap?=
 =?us-ascii?Q?yNZIkmuIIMvZhS30J+TfnowxrqQkTJfNj6LbqSpXcQdRSDcFEeCnjmY/wGvs?=
 =?us-ascii?Q?n2tMXaPqdPGlZitpRObftYg0isoWAqyo0ee1EkJNrKstFhSMOyRJIXxgFjV5?=
 =?us-ascii?Q?yqlo2uGYD4tnZYRtYcKWwW3MXnbn70hVSYC1u92h5TI1W464pOTyUNBphvBh?=
 =?us-ascii?Q?xE2AO9nOXvEnEM9eIR77pTpsHgbIx2Dgiy3mK2VgKoKLmHS1AOFpCCWymyDg?=
 =?us-ascii?Q?gWnq3i+GaCvDhZ9lKqjNZoRKPQWBHMkWqxSUbMrBQaaLbd6vO7ps1aNFmOBm?=
 =?us-ascii?Q?9YvvB/q5k2RxOSyh7pbMB3vQLmf7xWtj5u0CCrKL01PtFq3g2xX98Eo5DACx?=
 =?us-ascii?Q?gKdpWvN44te++CpCg6xYnhhnd1liiMKmJPdA48HMWAU/Rsao91DfSf7gZR8t?=
 =?us-ascii?Q?qpazQuE4OJkTpWB7f3XkWBZv40b7u6EC7SJz7xTabD76ASKkP6yY62wXWouP?=
 =?us-ascii?Q?nUhL7LOWLeE8Gnl0dwDIl6g0rsC6nli61i/P+LEfHVDME+D+f7MIvPPvjGxZ?=
 =?us-ascii?Q?EHlV+az51rA0E2lzarDxufDK44wBYkvTXHH/r92B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f409679b-441f-45bc-1aad-08db2c780cde
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 14:57:13.2417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0rsnVtzl6nnxEXiDFmJ/YtNHcgyVvF7zgpSHjPRBGk1W9/0CMMqKsp1rbPqo40w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6464
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 09:02:34AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, March 22, 2023 2:42 PM
> > 
> > On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> > >
> > > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > > user pointer to the queue, the size of the queue, then a head
> > > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > > commands between the head and the tail and handles all those
> > > > > > invalidation commands only?
> > > > >
> > > > > Yes, that is one possible design
> > > >
> > > > If we cannot have the short path in the kernel then I'm not sure the
> > > > value of using native format and queue in the uAPI. Batching can
> > > > be enabled over any format.
> > >
> > > SMMUv3 will have a hardware short path where the HW itself runs the
> > > VM's command queue and does this logic.
> > >
> > > So I like the symmetry of the SW path being close to that.
> > 
> > A tricky thing here that I just realized:
> > 
> > With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
> > CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
> > invalidation IOCTL, and the other hardware accelerated VCMDQ
> > handling all TLBI commands by the HW. In this setup, we will
> > need a VCMDQ kernel driver to dispatch commands into the two
> > different queues.
> > 
> 
> why doesn't hw generate a vm-exit for unsupported CMDs in VCMDQ
> and then let them emulated by vSMMU? such events should be rare
> once map/unmap are being conducted...

IIRC vcmdq is defined to only process invalidations, so it would be a
driver error to send anything else. I think this is what Nicolin
means.  Most likely to use it the VM would have to see the nvidia acpi
extension and activate vcmdq in the VM.

If you suggest to overlay the main cmdq with the vcmdq and then don't
tell the guest about it.. Robin suggested something similar.

This idea would be a half and half, the HW would run the queue and the
doorbell and generate error interrupts back to the hypervisor and tell
it that the queue is paused and ask it to fix the failed entry and
restart.

I could see this as an interesting solution, but I don't know if this
HW can support it..

Jason
