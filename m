Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4C6C1B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCTQVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjCTQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:20:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A621FCA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doPIzMR4Ay+6vK2ADcWBPoewLyOfgysxJHfcgI8qKimHSs6+7BZPeLX49+MCApx14dxYXy8hmLTSQ1kPlSSdz6d6pr+htxDjYnDlF6tj6V5Fg9RCmkdFfDgr7afz+aatv6d6qJ/rrAvNzmfGePYQ7goHy7qui0hfoqxjRFzMKwncWZ5kUWlb5y082VIYZp4K4nIz6nuMFXBj872LJH5WPWg+EHAiAlWfXSZ8/W+MJ0Ehz76L4M+s/hon59WLt2YljETpAVOxDE+wuphDuvZrlNCpP+ExxyFcrB7keVFgD8qBFg7x0FS7eAH1Fvez1xTmgwhNud3S6yh+9T+AH7YMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9TCdkyU6yzDvfGChydrkm3wCCpAcFs7rwGl7GDHp38=;
 b=eDElH5Xovn5hzc12CJotKRag/pXS0hWHEm0gd5iV1A328wUM9GVixS+DvSpan2G9PCbvihSBqMV6iNJDGgasRTWiNhh/td3DszkCAFsGHr+JhsjwVSrzclnQ+5T7MJTp2XPW47mEBLOJuXv5yZX/nMCkit1Mu7RjuIfKVtOEEkAtykrzvvK4d1uvzHy6lUghOGTUuSvcS6dqIb6+uamU2MNb6rMjAP4leurn9WVBlC/PFBifI+9Jb3LGmuIZh0aDWAQZebxM6C4MOH5EJX/dUQsP/wnZwxpWbKausKvWb36YehVo5AiTB7gpHpqOYWFgXPXrw7ZlfATYGA+aoAKgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9TCdkyU6yzDvfGChydrkm3wCCpAcFs7rwGl7GDHp38=;
 b=a7smwq9FcIDuw3/bcurWDuP7hjzSOyJrqcDyhZTkICgnRpO6KEJuO2PIMScphTMGmMEyrCzrgaN/lbDmBmtm4lVQ/TUzWcPp16H0aNMFx+S3X26lIttANWp97ZyDcu4Hn70TgHxIoAdLzyOtj4pk1mgDcNJgcZxHRA1W+Thh0pQywyWDiwFXmIeN9nY3l027WvqqOfaiKzKNnoUlHQIJbfd8T/q+OunRXiRb6cH3WC2i1JNmu+xnam4HzONx1PNHqrzENSwPeC9Osb1ZF4x3ME1+v0OJMnJPLyJ92Tryrw5MFrS1Nrxb03cYmpplT3BnpEUjpe2qOmljIDV8IUpBDQ==
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:12:22 +0000
Received: from CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::41) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 16:12:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT026.mail.protection.outlook.com (10.13.175.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 16:12:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 20 Mar 2023
 09:12:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 20 Mar
 2023 09:12:08 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Mon, 20 Mar 2023 09:12:08 -0700
Date:   Mon, 20 Mar 2023 09:12:06 -0700
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
Message-ID: <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBhYq8o4gqFZVb6k@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT026:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 954d5365-85c4-4383-23a6-08db295de332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrYqHhhkm5iP+hpWAvauYf0BgQQ1FzjHitJE0yKpN9GnD7OwOTp7V01sLiDOGsfpQFDz12HYLclkuniCDtW25EGfXqsFVdG/dj716X154fYMDwb3Z9EJQadSB2V/REvIV408hKrKzfg5PHBRlbHWmZFCcXSS0Du6CN6bftHRHycJ1iiysZt7dc7TlmFAEJpnjb83XQcRfOCaa9quZk9xHbg5UNZlXVzmwXb+QLTKsIsLHFjl+VdekaFJlnL7CmUEhAfBX2CJZr2hMcbFfrBXlpWupw2MT3CIZm1r6VcfyXcD8gbdEo5EHypx7WMhTnFgmnJdvPVRFrppkdZ3nxl2F6EkPmGcUU1KDoibv1W6P1W3vubV8D3B083JBzI1wvhbWk5s2wXe45SQz9dhyRIR5b6mO7pxdLvNhKT9ZzU6gOYoYZqMEByHOOL3grYa8i74X1FMt9cNpWuG+tS25u/Yg1N7hH/tGpNz6PtzqwmWycVLhw5Hit/JQGa8MjUwUZOSH/gZGrpRhd+74TV0Yq8YB4Q8UMuF0N2VSYNK4xmJDlJ2zpsGv/XKn32PK9+d1WgdXu+/RAFo4aHSriaK5ZSl3YYFI0rhDEpIcvAXFZAqpY1vpsdzlXxlSm+4SxahHLzaH9l+HD93iCiEbmOAYKEzJIcnydc/MxHhi93YWfeUqefSOHHigQDVQyJLs5gU4wmpRwg5Dz7ke3DHnTEVLKMY+OWntF1MhEqMxbdRE9IMtV9qUuGex7EddPZPVnAr9bST
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(82310400005)(336012)(7416002)(26005)(5660300002)(478600001)(316002)(6636002)(110136005)(54906003)(66899018)(426003)(356005)(186003)(33716001)(9686003)(86362001)(8676002)(4326008)(70586007)(70206006)(40480700001)(41300700001)(36860700001)(55016003)(8936002)(40460700003)(82740400003)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:12:22.2531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 954d5365-85c4-4383-23a6-08db295de332
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:59:23AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 17, 2023 at 09:41:34AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Saturday, March 11, 2023 12:20 AM
> > > 
> > > What I'm broadly thinking is if we have to make the infrastructure for
> > > VCMDQ HW accelerated invalidation then it is not a big step to also
> > > have the kernel SW path use the same infrastructure just with a CPU
> > > wake up instead of a MMIO poke.
> > > 
> > > Ie we have a SW version of VCMDQ to speed up SMMUv3 cases without HW
> > > support.
> > > 
> > 
> > I thought about this in VT-d context. Looks there are some difficulties.
> > 
> > The most prominent one is that head/tail of the VT-d invalidation queue
> > are in MMIO registers. Handling it in kernel iommu driver suggests
> > reading virtual tail register and updating virtual head register. Kind of 
> > moving some vIOMMU awareness into the kernel which, iirc, is not
> > a welcomed model.
> 
> qemu would trap the MMIO and generate an IOCTL with the written head
> pointer. It isn't as efficient as having the kernel do the trap, but
> does give batching.

Rephrasing that to put into a design: the IOCTL would pass a
user pointer to the queue, the size of the queue, then a head
pointer and a tail pointer? Then the kernel reads out all the
commands between the head and the tail and handles all those
invalidation commands only?

Thanks
Nic
