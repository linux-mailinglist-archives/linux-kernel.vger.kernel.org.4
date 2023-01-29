Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEC067FDDB
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjA2Jay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Jaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:30:52 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058AB7A95
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:30:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj/9ecmOzw7SQOsU5wge/LBEaTlk0MqX4N4/Hst2x+49aZGyr5x1zeMlAIt2UIdA9Wpu3EQUl5jQw2MWRzPHlM8EgNgMRYNpg3X+DdfPIMO9R1gR0VWcYysHpzQ3+Yh3mruz/lj+ySrknZ0vVPCLxknWKN/o1CtvAZLUdqGmVsf15j+bD0nQQuxFzLdlXXxgGK2EhMfxGIi56bC3fgaLKcOYWtBJ5OCGYr/Mk38RAWDfIVvuSZL8DbEG9vtipobmo8fJ4uWCV19LGPlwqcIX6NLHkgK88HzKR033oo6qKkNriFKp+AD5Fcf4c4Uz38Xlvgtn6pFdwJyzC2m87Ceqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYdhhj4jkccDIfoY/tNbZqr5d7qHxKOa/u+tVwets6k=;
 b=k2oouJIrJTLx7Vvf2/eGGWZ3UtWTbAYo+/VpYDbColSD1Bbk3du7Fy9/qPVpjfkGq8EwnO7Lomgj7P5YcsD70mrjOkPlC3On5RYsS6w0YQDSwcYlfH9TCO0tBSQoG3Uixfx5pdrqwk5aBi35/iq5APaniAjQm/hMmB0E5ff/HQiOnKoZsEU4UKQpuE8v+BuctEngSqVwwOSmFMfa7x8aJdMqhkKEsc7g36xU0WWCWmfIZH1MraNVEFz0EV84355HHJTMsHoAAr5v6+altloGlZmn5dhQxL41fhvXdhBnOJWdIxJmobh/lr919TkSjPLH9whVYStroV/4BxA99+81Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYdhhj4jkccDIfoY/tNbZqr5d7qHxKOa/u+tVwets6k=;
 b=F4QAVa29NgpiQOG5utPYO3kYDYPYBCHQoDrcg2035hTLTkF8OxlWmBVcGkelDkIBxSZpi1xsQkaDdpQSDxKaTen1nb9ahj9JacuX7KKL4nmEuxbWSVkMydIpUtZR9hNRo6Gcm+fB2c0QpVVWokyg4Dz6rfMLv75MdYJPZ7VKHH7T04op3Ju1UDeRiT+XJIPq/mjqWbMpbp+xTjLe2rFjxYKb6dpnST1pXIs+dNXcAGL2udRHiLzxQA2JVqZH5y9himEJW6owVpjtJJOtW1DPurDeb6FieHleMFqojpK4alA/vKTCd/z2BhmjrH+OYfIZodb76K40uz9jm6v0K37d8w==
Received: from MW4PR03CA0084.namprd03.prod.outlook.com (2603:10b6:303:b6::29)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Sun, 29 Jan
 2023 09:30:50 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::89) by MW4PR03CA0084.outlook.office365.com
 (2603:10b6:303:b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33 via Frontend
 Transport; Sun, 29 Jan 2023 09:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.33 via Frontend Transport; Sun, 29 Jan 2023 09:30:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 01:30:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 29 Jan
 2023 01:30:35 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Sun, 29 Jan 2023 01:30:34 -0800
Date:   Sun, 29 Jan 2023 01:30:33 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9Y8ue3SR7gM1ZFG@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764F6D34C9252A58DDA69D8CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cae483-2215-4508-19b4-08db01db8278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l7/vUN/dBYnfl2bOJ/Z+7eyHAWugQrrleH/m4mAfDTyfM9CnjZv66So1IIewbPE5IBJMaO+emrHHcbcKOZ1u/2ZsMZRPQeWkPCaKMz1NQS229/1XAZR45wJFeYUMJqoAliPk6VRn2OFb/2YpyKfpJtF/TQldzGxcIIXqC7Yx/JdxeuTRIXhkWy0UM2I3HU3apu0denfw/8SIOAHg/tYNzCe/b7Xsv0IfR7pLd3jDHcjTS5zqTBr9ViHolZ323t1HYZYKrDxQKvCQXQMUXyYCp7eyavHTw7VwlYdoH1EJzeYxtRtSN0+BHltF66RmtaQmMbTSf5B8aEhsYCkBYO5lcOE4AgaL2EDhfaNDyHWQLNCAllqYMMyVZKX4HWBKGIPmswMYpezUCRQh88FBX2kA3FeE8vQo+29kzDHCX+aWKnOXrWsNRZ/MwYrpC4E+xzJxnWNDh5at0oHI5zqodUT/aL/VXZfpIdX++IMmjg786r7o/6bEm3rA3eVFKSlxHgwH/k5xEWfULYAtocewbTjQFrFlidWdt5zWihqmvUgNlLMLZVdGUHjVFQ10LQwAyZTPaR1/nzJM5nF3ZSS5JRbPNkOkIuPj+RkWXXEREWWrySaNvqQR+x8GdvnGTExDBofBWLWmOTDA+2or8o7/Fj+SGJQJkyqBSXBsoWR2p5fuOXDBPkDYqkq2lgHTvCz2A5HD/UxvFtfcjUnBAN2ieYB/Fg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(478600001)(26005)(9686003)(186003)(4326008)(6916009)(70206006)(82740400003)(7636003)(336012)(70586007)(426003)(83380400001)(47076005)(41300700001)(8936002)(8676002)(86362001)(33716001)(82310400005)(40460700003)(36860700001)(55016003)(40480700001)(2906002)(5660300002)(316002)(54906003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2023 09:30:50.0494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cae483-2215-4508-19b4-08db01db8278
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 09:23:05AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Sunday, January 29, 2023 5:18 AM
> >
> > From: Yi Liu <yi.l.liu@intel.com>
> >
> > Currently, hw_pagetable tracks the attached devices using a device list.
> > When attaching the first device to the kernel-managed hw_pagetable, it
> > should be linked to IOAS. When detaching the last device from this hwpt,
> > the link with IOAS should be removed too. And this first-or-last device
> > check is done with list_empty(hwpt->devices).
> >
> > However, with a nested configuration, when a device is attached to the
> > user-managed stage-1 hw_pagetable, it will be added to this user-managed
> > hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> > this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> > to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> > multiple times if multiple device is attached, but it will become empty
> > as soon as one device detached.
> >
> > Add a devices_users in struct iommufd_hw_pagetable to track the users of
> 
> device_users

I assume you are suggesting a rename right? I can do that.

> > hw_pagetable by the attached devices. Make this field as a pointer, only
> > allocate for a stage-2 hw_pagetable. A stage-1 hw_pagetable should reuse
> > the stage-2 hw_pagetable's devices_users, because when a device attaches
> > to a stage-1 hw_pagetable, linking the stage-2 hwpt to the IOAS is still
> > required. So, with a nested configuration, increase the devices_users on
> > the stage-2 (parent) hwpt, no matter a device is attached to the stage-1
> > or the stage-2 hwpt.
> 
> Above is very confusing w/o seeing the full series of nesting support.
> 
> As a preparatory step this should focus on existing code and what this
> series tries to achieve. e.g. I'd not make device_users a pointer here.
> Do that incrementally when the nesting support comes.

OK. I will shift that part to the nesting series.

Thanks
Nic
