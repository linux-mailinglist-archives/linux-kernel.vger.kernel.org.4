Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBD6C8370
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXRfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCXRfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:35:41 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4481C64C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IahTdNXSqwo7coEMWOlgEhBzTtipnblkFeH+A74Va/zOsvaZYEcg3FP4Qq3xWKnCBgKeBp+KCA9T6njasKw3jGUaq51GEo48d8RURXfo9Pw/yR0Yg0XjRJiVEqsyvm9MiJTE5uVyN45kKaCUt6w7v8FpJeS3JVCN9XT6le9sS/xj8HMwNr4HBxynDq7R7lGHjTgj7seAM3ymeaYo8OynFQmoTnF5jJX1V7fLIRDAFGKEDfzLyBCUKOWobyADmJ98bYiGPkvD2A6ZgX7cHubh6z78wXy4Z4yoDtma/R6vH/nayGISnCgg97exsdZwldyZYx4WB4xqWbKnA2MbQiH1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng+STecmltNDc5W09XBbAUWaGF4r9zPy/Vf6PcQwUGY=;
 b=mKoKUIk2YOvqOJuC5lmwxmjlWgnLw6GlUBcwxFTWgK8akI78STYzYNRkXpyaJpysJXieWfWbvMxJACIfoDaWXRHPVMBdPZkJ2usPwQPxD2g1uNVNsUm2tItOm8FMWDsbPp1xZRU7MVc2MG20aGf+vz8vII6m8+mzXFmh9sThfhRJJgBhQrkLwweSQsHNIR36viklnMSJErnpYj2m0f6F6/P/nzIFEkVWGDxq/gxBI/XObh3AUrHxeMQrrq4AxvKfgSm9JTBDf9EHpzkbKikKMhxduMlqH3QuSO8jc0YA04qh7H3SLkEvbRXpN2lvZi1BXQSzPuGzMvl4svZnN7dAlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng+STecmltNDc5W09XBbAUWaGF4r9zPy/Vf6PcQwUGY=;
 b=d/YKhw5hfYgEhnplaN84NFWQK1zOKuDYgv2PFCzucL3qVx1gs5SkOmiNxL3qoAfeRy+28WJxvv3qXZZ4MlpoJyz/B5PHRxjXO9YPzNF6kbomhl/wFjZOiBS/h1WVcJyYteG0/EOfQkZpR6KRVkJXzhRIlCBwQZISvhbpPR7AKZRc4kLFmumpA3HlnlAJbw+I06NlVfq3GP8N/46tumVd6nXV48grE6G/HViVBVkg8CT1eRJ9eJRYYi4ezNsGuYxr+6vz+FSXTIVnhIitm4RWgCIHVhEKUMyyf+ruPIZvIU4jjQAPXOSKXA7JIIJlvmhQAFz0Bd8S71QlyP8/PJImZQ==
Received: from CY8PR11CA0038.namprd11.prod.outlook.com (2603:10b6:930:4a::8)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:35:37 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:4a:cafe::a4) by CY8PR11CA0038.outlook.office365.com
 (2603:10b6:930:4a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40 via Frontend
 Transport; Fri, 24 Mar 2023 17:35:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Fri, 24 Mar 2023 17:35:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 24 Mar 2023
 10:35:24 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 24 Mar
 2023 10:35:24 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 24 Mar 2023 10:35:23 -0700
Date:   Fri, 24 Mar 2023 10:35:21 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <ZB3fWVD/Addk70zY@Asurada-Nvidia>
References: <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <BN9PR11MB527622D86AE048D3394C12A28C849@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZB26RWV53wYtc2L2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZB26RWV53wYtc2L2@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: c4982393-5aa3-4336-fc11-08db2c8e2db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: up+Ej3Fop7BrsEDFxJFB8mQb9oKIFZJAzNGQOP3ZyU5ubIW1BPfqZil7Gpqw4bhp1yyq8Yfm6OYhbr1tPMySCPGzhyZLhr95May19i6wuehNKJtizXkoYLP9jlHOvrxReYsUDtaXYw2YPeWs9QYdco1Vuu1rleEjTPcTvjM8HeTo98+hfIboKU4kdoZoc4B+8ROEVmBIheRZqzIc6blHXtapv5AkWy/i0p5lyux1AtGBh2nR/wqEEogcB2mmb7LDnYOzN9ZaGjeEQy6p1emrQIfLfIovfgg6BC5SxcNbIA/LXeHISNNa18pSXM0XgajXMa2PdeB1w7OUPd6lQ2xXITTOCjMmjLU550AOR+SdqdZQghjgiZNO9I4eQjgerE6wrB3KiQXiVFNmg0lS+Js6z09b/acowg3t3BDfzZaos/J/45bnQNpr0v8xOztjlILIQpLmpDO/jofJLdR/REwLDbOuCelVF1GuvJQfN8kPGaF7+hT+12M1WCvUR2t6L2XKC2ogJ2YUhtp0EpftviBkCJQ9xYPIyq8hNXsooQ5/nvugQ0x6YZpxj4RZea5m7j6QaGOr7WRAY+Bwxl5qPkrcyEags7sw960UB1NOfSWc31FtJlLDyGWlBrYDcqD5d7uwC1M76DNKQbwWTzDAFEcM77oMRWFjp4BAdqIVzwefrofooO+SBSPrOEaYc0xDAvPCY7193LRTJ8TF7ZzYrhe1I2DmDYzSawQ72cYkIo/vzXbeQEyPUuWle2zWxuW0cR/h
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(4326008)(8676002)(54906003)(5660300002)(8936002)(7416002)(70206006)(70586007)(478600001)(2906002)(110136005)(316002)(7636003)(83380400001)(47076005)(426003)(6636002)(82310400005)(36860700001)(33716001)(55016003)(86362001)(186003)(40460700003)(41300700001)(40480700001)(9686003)(336012)(26005)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 17:35:36.5177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4982393-5aa3-4336-fc11-08db2c8e2db2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:57:09AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 24, 2023 at 09:02:34AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Wednesday, March 22, 2023 2:42 PM
> > > 
> > > On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> > > > On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> > > >
> > > > > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > > > > user pointer to the queue, the size of the queue, then a head
> > > > > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > > > > commands between the head and the tail and handles all those
> > > > > > > invalidation commands only?
> > > > > >
> > > > > > Yes, that is one possible design
> > > > >
> > > > > If we cannot have the short path in the kernel then I'm not sure the
> > > > > value of using native format and queue in the uAPI. Batching can
> > > > > be enabled over any format.
> > > >
> > > > SMMUv3 will have a hardware short path where the HW itself runs the
> > > > VM's command queue and does this logic.
> > > >
> > > > So I like the symmetry of the SW path being close to that.
> > > 
> > > A tricky thing here that I just realized:
> > > 
> > > With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
> > > CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
> > > invalidation IOCTL, and the other hardware accelerated VCMDQ
> > > handling all TLBI commands by the HW. In this setup, we will
> > > need a VCMDQ kernel driver to dispatch commands into the two
> > > different queues.
> > > 
> > 
> > why doesn't hw generate a vm-exit for unsupported CMDs in VCMDQ
> > and then let them emulated by vSMMU? such events should be rare
> > once map/unmap are being conducted...
> 
> IIRC vcmdq is defined to only process invalidations, so it would be a
> driver error to send anything else. I think this is what Nicolin
> means.  Most likely to use it the VM would have to see the nvidia acpi
> extension and activate vcmdq in the VM.
> 
> If you suggest to overlay the main cmdq with the vcmdq and then don't
> tell the guest about it.. Robin suggested something similar.

Yea, I remember that too, from the email that I received from
Robin on Christmas Eve :)

Yet, I haven't got a chance to run some experiment with that.

> This idea would be a half and half, the HW would run the queue and the
> doorbell and generate error interrupts back to the hypervisor and tell
> it that the queue is paused and ask it to fix the failed entry and
> restart.
>
> I could see this as an interesting solution, but I don't know if this
> HW can support it..

It possibly can, since an unsupported command will trigger an
Illegal Command interrupt, then the IRQ handler could read it
out of the CMDQ. Again, I'd need to run some experiment, once
this SMMU nesting series is settled down to certain level.

One immediate thing about this solution is that we still need
a multi-CMDQ support per SMMU instance, besides from a multi-
SMMU instance support. This might be implemented as the ECMDQ
I guess. But I am not sure if there is a ECMDQ HW available,
so that we can add its support first, to fit VCMDQ into it.

Overall, interesting topics! I'd like to carry on along the
way of this series, hoping we can figure out something smart
and solid to implement :)

Thanks
Nicolin
