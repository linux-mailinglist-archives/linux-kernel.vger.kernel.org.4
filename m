Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7126C4370
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCVGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCVGn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:43:56 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200E013D62
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q87XCryhAIkKkAfh/h+kd8x9Vd0WHjKmzgWJTwVlxTNKpMbjGxof274lAmXzWNdH/EvlX2352N9Ke9d+yZ5bWDgTVZycCZjCaF5Bs8tZ7t3YA1r2usFDXgRTqkv/Vpf45QYVuhxFBQWZKtKas6qCF69cAuAzvV+ZACviCGW9+jRlK7YbRtcDYifriTxT+O7AhI+mYyZyDyxKNxVCX0i8W1Pb+OwJnZJ3QAcvQio48XslGpe2BT0addZzvYLfcmyy9rCoTKUxFPopnPGN6k47VuwkLvlRXtSJARGv+kGA2zbiXL7N+RGWSrnXv3tuyhjNJNxaA569/h1byYGMvZVduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae+33puf+QEDDqMJ9sVIBPHY8M27opnwBKBF932/YZg=;
 b=ix62n092D8SsAD8gSt1QVwuLXBTnYnNAcRtCHGf+GivVgunE8prXzlv/6ntyYgcN3y0yEuSQ52YkboIPa1DrzPPBJ15eBFV7OwBt0B6/JSIrAV18ByGbr3+IX/PTkxlTJX8Froaf64wsJbPq4MtdLIaBa2zml68/ZT1t+t0BPFJFObTHqPSSUzcey7w5fA2loUJpSRCv77VQCCzxAil5x5a9ogXphc3rJNCLiXMwV/+JX88eXJWBwrWi8uE72HzvEihXGxQM5DFxSiAdhaSX+FzXXcn9Z4EUvsFf2pRKfs12uK6e3+caQTbzS5drR4gW8kwPMW7ScuwxzS2z2oPhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae+33puf+QEDDqMJ9sVIBPHY8M27opnwBKBF932/YZg=;
 b=W5IZR21JaXNMUTCdzN3u1bWZ3/4BZaCc4o34du2DDh90XJtFQ6ivRmd1JT89FhX4x2CttIYb4/I9GY5EvXpvt6R3E9ih4VIitCxzaC43f7eR1CkECG1TEHkx8CUvZBsYfOM+UDwAadUD1J31oB9A7LNYt6qIndFOOrZTSWIVlmXO07e+nBy6LyNP5KM2J45CxbcX+8l9ypVFLc/AlRWe44N8cFUH0pt3ZqDmiNmMXMHvuf+EYCt3k1XxiRCgvHLrC2SkrFxXVvHkKfmYMGy1qwgSFW4bo1v6dsRbobCfdEj22YtglfLPv3q92+VSJkiuHGQk8w7BP7xKCmx4ii6+MQ==
Received: from DM6PR13CA0068.namprd13.prod.outlook.com (2603:10b6:5:134::45)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:42:33 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::17) by DM6PR13CA0068.outlook.office365.com
 (2603:10b6:5:134::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.16 via Frontend
 Transport; Wed, 22 Mar 2023 06:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Wed, 22 Mar 2023 06:42:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 21 Mar 2023
 23:42:28 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 21 Mar
 2023 23:42:27 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 21 Mar 2023 23:42:27 -0700
Date:   Tue, 21 Mar 2023 23:42:25 -0700
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
Message-ID: <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
References: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBmZj2pscX0hx2kQ@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|PH0PR12MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c6ddf7-6ed8-4b19-78c6-08db2aa09dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oikaE4OyJP4ws89HwxUiEisx40OZTdw3pkfNagaOKbCUStj/aW735mpmrdfj85xMgnZ/AKy+bwhqbakdm757Pej2AR/JgWu2KM5X2xhTrxRlm09vc8y0pRa8lT5KUI2L/+5IHe8JumuIajhNL9EnAjLP+h/7hWoSeDbcYOHMOLjjOn20W9JXvbQyC9sP5KhfeYV1ndJsstmFhQxBsHU/qNukN2HM1ngpDYED6p8iysqOqKp4V/WIPN7Z4MRgHr7sWn9WHPm3yE4v/+8H216rPmtjrgZvIyVe4fgMUCJ1jaCDUDlzcFJDiEJ6xwpdS+SogAK8K+/l55+TX3sbeCM61ygzBp5TKTnX/XTmpF+0WvZ3UgVrLX4JocilPwV5k30RJnMGWYIcT+28Jp39J/0GgzxViYUqmzkUvURUrHAQBWd4LJ9+FSE4KkDnmqPEcnsbQO9qD6O/wjYO5x/QWMixbfTDuLrWC+Tw/ZABYmkzE53zPhlecbJwlOzb0wfbAhnrXFDdiFFx375HUYgJ5cdyv7xBr3K8pmMZMxNMfPuuo/0gsPTwi1V0tTncnTkSG3g9pFiFdYjUnX20+VPxP2QrnN48zMSViWf5XeGwZCm90ANLlRmYEJwR7BkWC877FS0PwEJl++52Rs7Z/tnbKCpKtQUm/ibXRWtSUhLf/sGoF+5zMxamh6j/ZeOh4fINedmsn2ZRNmGSgc6UrYwISbrK6hqXIyzYnr4ZoVJG+N/FTo1RQHVNcVR2SDkaRbDseDUO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(4326008)(8676002)(41300700001)(82740400003)(2906002)(55016003)(7636003)(40480700001)(36860700001)(356005)(70586007)(8936002)(70206006)(5660300002)(86362001)(33716001)(26005)(426003)(47076005)(336012)(186003)(9686003)(40460700003)(7416002)(54906003)(82310400005)(83380400001)(110136005)(478600001)(6636002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 06:42:33.2994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c6ddf7-6ed8-4b19-78c6-08db2aa09dd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 08:48:31AM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 21, 2023 at 08:34:00AM +0000, Tian, Kevin wrote:
> 
> > > > Rephrasing that to put into a design: the IOCTL would pass a
> > > > user pointer to the queue, the size of the queue, then a head
> > > > pointer and a tail pointer? Then the kernel reads out all the
> > > > commands between the head and the tail and handles all those
> > > > invalidation commands only?
> > > 
> > > Yes, that is one possible design
> > 
> > If we cannot have the short path in the kernel then I'm not sure the
> > value of using native format and queue in the uAPI. Batching can
> > be enabled over any format.
> 
> SMMUv3 will have a hardware short path where the HW itself runs the
> VM's command queue and does this logic.
> 
> So I like the symmetry of the SW path being close to that.

A tricky thing here that I just realized:

With VCMDQ, the guest will have two CMDQs. One is the vSMMU's
CMDQ handling all non-TLBI commands like CMD_CFGI_STE via the
invalidation IOCTL, and the other hardware accelerated VCMDQ
handling all TLBI commands by the HW. In this setup, we will
need a VCMDQ kernel driver to dispatch commands into the two
different queues.

Yet, it feels a bit different with this SW path exposing the
entire SMMU CMDQ, since now theoretically non-TLBI and TLBI
commands can be interlaced in one batch, so the hypervisor
should go through the queue first to handle and delete all
non-TLBI commands, and then forward the CMDQ to the host to
run remaining TLBI commands, if there's any.

> > Btw probably a dumb question. The current invalidation IOCTL is
> > per hwpt. If picking a native format does it suggest making the IOCTL
> > per iommufd given native format is per IOMMU and could carry
> > scope bigger than a hwpt.
> 
> At least on SMMUv3 it depends on what happens with VMID.
> 
> If we can tie the VMID to the iommu_domain then the invalidation has
> to flow through the iommu_domain to pick up the VMID.

Yes. This is what we do now. An invalidation handler finds the
corresponding S2 domain pointer to pick up the VMID. And it'd
be safe, until the S2 domain gets replaced with another domain
I think?

> If the VMID is tied to the entire iommufd_ctx then it can flow
> independently.

One more thing about the VMID unification is that SMMU might
have limitation on the VMID range:
	smmu->vmid_bits = reg & IDR0_VMID16 ? 16 : 8;
	...
	vmid = arm_smmu_bitmap_alloc(smmu->vmid_map, smmu->vmid_bits);

So, we'd likely need a CAP for that, to apply some limitation
with the iommufd_ctx too?

Thanks
Nic
