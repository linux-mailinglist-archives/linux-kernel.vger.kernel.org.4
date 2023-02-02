Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470796875F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 07:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjBBGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 01:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBBGgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 01:36:13 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BBC279B5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 22:36:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJ7426T8rMlwNdQ8PumresMzcxoglFBYwFwaQFvBrPSMEIQNUBOehY5a0lquD96S11JAVkb3RtIb8tMX824niZYzE/kbpBrvH5jqsRFMhBEZj6A0zph+4S46fAHjAme3GgX2jO4dVxHzv2goTJhgOUrXxiteb+uRu716K+3HLPPlAdeMffAYiMgLOeU/VMExDY8pPHygzCpp0J5ZgDunMdpmdUaiIu9aAL3cwqRj16P4GZb5xWay6ptOEsPgujAIgCOm0grRUZ/RQO9VI/MhrXxfq9fzx8wP4mLhAK4n01cmU10hV7CUxbFGNLXyb+UT3sOXBtx2iNHZ9rto5iu74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX96ZVMcmrsyEtnGYFOgotRqhyO/WBBSRVLZfmHInO0=;
 b=m+AM4L5ooK40g6cskab9A8COY8njRDJJBMpcgYsDlFRu3nrc+x2pwjT6EmFreXYgpFfhJDEVIp5P60CR9JU9rZ2xhDcrCe2fISZh0lk9VPAJEoCtVxND2J476keBa1/yhtmh9psO8eaDjM1KYA3sAFXA2eyx5Rs2N1SbH5NElE+m/UXOC1JnhzCY7PVkx7Qk44rrgznYoGFVflfz0fzJZ97SKiZw2u/CRYVmXONYoUfOWKY4j1rEEiA3Wd4rsA6qDIeCiAedMSmDH4eZas9SHWLB0DnkrLhcxxDwV662IGRlFMJIY7bbbU10Qz22qPTRp4eB1r8WtTzHFu3mJDC3UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX96ZVMcmrsyEtnGYFOgotRqhyO/WBBSRVLZfmHInO0=;
 b=aZKEjG47IltbSitCHBe3ZKdsxnDNkKAKj1H+FNIQOafXxDjJAkkPH2/xfWBlERWyXXiaBK+MmBQz+yBZQDlBB5hWuchQio84tdpmUdtTg3H2vbqEiFpzqXspFqgNoDBjUCR7rrOuhmHvYF/vhV+N70P2tFOUj9jJBFft7zUjlrqbj83sa5WpZyhXB8UKjQmsNAqSufwrPjqUtZUW5wcuNdNlI9i92swbCxRul3NeG5X7Lf/taShvML9CURyXhWE6yY3uJHq0dcB+Dl7J+H5zZILSqn6eRbagSKw1aw8MwEMLJ1Yx3oV44Fqs51iXz8ZwmQtt4x4uld+CrL44K+QvBA==
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 06:36:10 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c7) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25 via Frontend
 Transport; Thu, 2 Feb 2023 06:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27 via Frontend Transport; Thu, 2 Feb 2023 06:36:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 22:36:03 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 1 Feb 2023
 22:36:02 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Wed, 1 Feb 2023 22:36:02 -0800
Date:   Wed, 1 Feb 2023 22:36:00 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Baolu Lu <baolu.lu@linux.intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Lu, Baolu" <baolu.lu@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iommufd/device: Change
 iommufd_hw_pagetable_has_group to device centric
Message-ID: <Y9tZ0MVHdwS7AejR@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <002911839dd30990d5e3135f8a0f8d41f14e856b.1674939002.git.nicolinc@nvidia.com>
 <BN9PR11MB527697E1E24784576C3FB7628CD29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9ZMulxEyGvnvW0X@Asurada-Nvidia>
 <Y9eaLpD1XIvE/3Nh@Asurada-Nvidia>
 <BN9PR11MB52769883FEE25F0BA731220B8CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <df494d34-d804-e743-023f-d1effc881628@linux.intel.com>
 <BN9PR11MB52766EAE924EB5DC320FC1488CD19@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y9oSs0TJ/KZKWCw1@Asurada-Nvidia>
 <BN9PR11MB5276076C2048581CCBA6011A8CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276076C2048581CCBA6011A8CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 169148c0-8756-4b72-0254-08db04e7c57e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hTexnfBLZ9n7vrpRDlFkvs5Y4498czFhg2bz0AOWUzuTWiKzz0GxO1DVsmSTp7V9QN/7A111/gN03ZErYfMxAJco5ntHHSUD4Q4t4V/UcYBoaJIqTguxktPQZgeUIVyDlByPIYvTGF/Xsba4FB1ra/QPvRtqEMzonoqr8dJ/59MekoIImWaLULRY+Km/ytnNS57XJU/iNmOZYGGM3eXMWjIKsEpbsRCijQ3w3QykoUGlkzkG3IamfIh/5QJSeY791+gBPXh+FUwHh4I7htfiHRqENV8w1xoJErioz1oG51eCXqQKWcRJhJgmBVy7WK70zENmgU3oNQ6P6AK5nDLIzoZIrFSWex/UYvfSUiFW8tMpYueox/PzvYNPnaNZQmLr6cXxfQeYTgWC8lU1uMgnYKEpxTiFcZS4nNbxt4kNIczgDBUVVuiIgrOyDdd6aGFcM64rvIcr4lk44tAIsbJerCa7N5pRx+9cdIusCXA9AnzlzZ45b3s6o1Fc+n0Ua2bzr+aNIdZQxN5SBBjpMkQ5zvM+1h/sSIKFxnz1uFwVWEiO+qQ8BKs4weUFkEiZGPFrw35ZjeAM3w8yOVFb6iw2x8oRg4hdt3Vk1EQ29uB4d5R/Nwue1mdNDSoW4q/l0f74ZIVSg20HaRgGtDQGGGPkXivSRzxT7uW8jgnT8xzmYT0HWeoR3ze0iauHpQ5doUE0Njiu2l68giObJ/gZx59P+g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(46966006)(36840700001)(41300700001)(47076005)(426003)(336012)(70206006)(70586007)(4326008)(6916009)(8676002)(40460700003)(83380400001)(316002)(54906003)(7636003)(356005)(26005)(9686003)(186003)(33716001)(86362001)(82310400005)(36860700001)(40480700001)(5660300002)(8936002)(478600001)(55016003)(2906002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 06:36:09.9445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 169148c0-8756-4b72-0254-08db04e7c57e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 06:32:36AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Wednesday, February 1, 2023 3:20 PM
> >
> > So, assuming we drop this series and move the first two patches
> > back to the nesting series or the replace series, one of them
> > would end up doing something ugly:
> >
> >       if (cur_hwpt != hwpt)
> >               mutex_lock(&cur_hwpt->device_lock);
> >       mutex_lock(&hwpt->device_lock);
> >       ...
> >       mutex_unlock(&hwpt->device_lock);
> >       if (cur_hwpt != hwpt)
> >               mutex_unlock(&cur_hwpt->device_lock);
> >
> > So, perhaps we should discuss about which way we want to choose.
> 
> from your discussion with Jason I think this locking open has
> been settled down.

Yes :)

> >
> > Btw, Baolu's version has a similar patch as mine changing the
> > iommu_attach/detach_device(), yet also touches _group(). Could
> > we bisect that series into _device() first and _group() later?
> > Given that we only need a device-centric API at this moment...
> >
> 
> I'll let Baolu to decide after he re-catches up the comments in
> that thread. But overall I think we now agreed that removing the
> device list/lock can be kept out of your replace/nesting series
> and let it cleaned up after Baolu's work completes, correct? 😊

Correct. It's not a blocker. And I am going to post the replace
series today -- running some additional sanity now.

Thanks
Nic
