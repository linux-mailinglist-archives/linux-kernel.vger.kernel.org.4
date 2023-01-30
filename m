Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D94681AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbjA3TjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjA3TjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:39:03 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF85C45893
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:39:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajOWtpY5IruTWOg1XrH9B12Wx8LoySck1hN1ray1Cl1J2xvmka8GHbGrS+y7dW3v8h1TdFI1aIY8pk1G2U4uac4/QVdyQ5rn3NJwt2Le4jGiP4fEQFrh/PcqkiD//vyAsCc4JQ5aY8HwWf583u7wnYkKi9dcYThWKOlinYWivqoNfgXoBAL8UjcU27+84SwWuIjLq9uQelslUDKOOdWrtPkA0RljoLHDrpgpykfJNfRSc4txbQfRl21xtivwcnqVtMMrwPnqJX/4Gr2fagG/nzwc8noUFrZnbhUMUc1f406bLM2B/4B092uMcSh2teUZlB25vfu74qA4Ei2TcwKbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaANvi0n3qthRQoFTFt3EF6i8qKjmtsi2W/YkinkEy4=;
 b=Mh+ecKAlJKWSKHiWbqn09dZLFGH57Syo7RW9UgqkSbSH+zGhMc/ReapvCU6IZ7Ho7bVKaX/XccMrIfLnPLFQUHT2yZAbkQnbd5jxKmOsWnHCevyF/5kHdulFWZnrYOAUov1YtA/Qv9idwfUnHQtZVah5zGNr74Hq518zjANbpr6uCls2Y/vsOLYZarKMbbf4waQrybq4H6vUSZY2y22Y9Pii8x1Q3bZINGIkA9vyb+0/zxc8R2lkLxUtj0SGvMgesKchxyfWGHGZq26hQW6aw8ox0wosSZuD2czQXnSoHevhXjLjJJkftO20gVi92anumAI2J5rCbuw7XBLxRf/WLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaANvi0n3qthRQoFTFt3EF6i8qKjmtsi2W/YkinkEy4=;
 b=LHQ5aw5qPzCVUaLV4ob2zgaUf0RS0o27KA3bVwxkvLLdRS5XdKSHcXJC4HlKC61QGPHSljPV5TYXsyry/IbEKwHBzX70zlD4jdRZSm/AaNYNH+0HrmTPPYVS5uPy6ee2/d1meE3bChNLs3BBFHDSueqBdU1ZyUcvwQKPzHmU/zUafIVu7OTNaYlxSvkDXEb/WqvpeyO2bf+Wr3RucjCgB9i209AihMHu81Hap2wIY5zEw8Qo5CYi24AD+8/Ol1P9D+aW/V/OykC8iutAvOpM19/CZtHWCsTx79vHDvdm4i92qOWwvtNE5eGmSHvotJEl0fD8VTv5UCOJYiNxbFM18A==
Received: from DS7PR03CA0275.namprd03.prod.outlook.com (2603:10b6:5:3ad::10)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:39:00 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::9a) by DS7PR03CA0275.outlook.office365.com
 (2603:10b6:5:3ad::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 19:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 19:39:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:38:51 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Mon, 30 Jan 2023 11:38:51 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 11:38:50 -0800
Date:   Mon, 30 Jan 2023 11:38:49 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y9gcyX0HAjaxoBJd@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
 <Y9fbVHytj12rpmZD@nvidia.com>
 <Y9gUbftU6BRqFc9b@Asurada-Nvidia>
 <Y9gVhqCIl1xN3seC@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9gVhqCIl1xN3seC@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b30a70c-e360-4906-b610-08db02f9a2ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rQXvHbzZEPypTAuvvkCU3TrdYUmZYqgs4e27FIW1sOqGNljBOoUkXGeLNXJdoHRvCAecLYFbiE2gmiGCxp6jq/zSJ5buXzGHE2yrZtWIcGGBbWdcXKwUjctE6+s03GfBkk9ZQ6Am6YqJRbzLv0uzH9aYwK1B5Bug6rcm/+/1+sw+RwjyCBlqiXC/orwQ/697LAbBbS6eaSbxw5BDoSsSZbcK7cYh9/b55R3j+y0vuJxTKHaTdpuMWbegNUMPDJ0fUAqC+q+O/nVl7JYBrVF7jeX+/A9xscvrWpsH9f1WS8ySmfvfw1G2v+bzOZBM/+ISAakNJN0KsxiRMIhKlRbqZn8cuirLjQlMV6IbG0+xtwP1onZQADzkxm1qKKO0Sj92MgIw5xlAW8e4sHxpLtAeE0/hyZOoKLHBjJXNbxxXhmL1l9hnjmAxsAg5qWPdlJRW+u2pnmZ5WxjHCd4Mb/6T8A2oV69Br9Sunnoyfy5k1dPHv6LLM4WbEUAnthn+h7y5hCexKj3PzE/0QP1t6ZPs2rGXs+Ag3ZdghwcGFRlH/qyrzKy7X0wUCqniTP0w85w9H1wHAxWo125ETl1MbnNcsNn/ggU0DU42REP81Duwet6HcN/XHy7yZZ5dy3T6nI2TQv32fGqMOqso73RYjvXrlmMXEHoKLbQM0szsZovMOANyzodaRwueQiOjjFVcHLazx8n8kb16HolZxUGp9lwwQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(336012)(7636003)(40460700003)(36860700001)(82740400003)(86362001)(33716001)(54906003)(82310400005)(8936002)(6862004)(6636002)(5660300002)(316002)(55016003)(356005)(40480700001)(426003)(47076005)(2906002)(83380400001)(9686003)(4326008)(26005)(478600001)(186003)(70586007)(70206006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:39:00.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b30a70c-e360-4906-b610-08db02f9a2ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 03:07:50PM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 30, 2023 at 11:03:09AM -0800, Nicolin Chen wrote:
> > On Mon, Jan 30, 2023 at 10:59:32AM -0400, Jason Gunthorpe wrote:
> > > On Sat, Jan 28, 2023 at 01:18:10PM -0800, Nicolin Chen wrote:
> > > > Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
> > > > its list_add_tail() to a similar place in iommufd_device_do_attach().
> > > > 
> > > > Also move and place the mutex outside the iommufd_device_auto_get_domain()
> > > > and iommufd_device_do_attach() calls, to serialize attach/detach routines.
> > > > This adds an additional locking protection so that the following patch can
> > > > safely remove devices_lock.
> > > 
> > > That should be two patches then, this is just moving one line of code
> > > from what I can tell?
> > 
> > The mutex is used to protect the list. So moving the list means
> > we'd need to the mutex too. What this patch does is to enlarge
> > the protection scope a bit to cover iommufd_device_do_attach()
> > and iommufd_device_auto_get_domain().
> 
> That doesn't explain why iommufd_device_auto_get_domain was changed
> around, it already had the lock

That is trying to make the code look like this:

iommufd_device_attach {
		...
 	case IOMMUFD_OBJ_HW_PAGETABLE:
+		mutex_lock(&hwpt->ioas->mutex);
 		rc = iommufd_device_do_attach(idev, hwpt);
+		mutex_unlock(&hwpt->ioas->mutex);
		...
 	case IOMMUFD_OBJ_IOAS:
		...
+		mutex_lock(&ioas->mutex);
 		rc = iommufd_device_auto_get_domain(idev, ioas);
+		mutex_unlock(&ioas->mutex);
		...
}

If you don't think that's necessary, I can make things intact
in iommufd_device_auto_get_domain().

Thanks
Nic
