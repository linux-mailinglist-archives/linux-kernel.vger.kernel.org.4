Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0846819CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbjA3TD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:03:27 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C909EEE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:03:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu4aJUjttWlZOmhxosjPxBUkU0GVHCSJ9TAI2ih8O8rTz21brDS9OmIxvRk/A67nbc0sh55A5RhSU++ir+wHWjGAtJI49HJLHQBfucN8A4Gz5BAGOIRlUcfcP8WskmguExmnFEbIprV8gt79ZrBnnqkZmt7GqGtJsO0eUHgAM8CvPgrA68gRTqsZKUAR+Re2DVUi7rC4RwM38AEQh7Q8VwTM5BzS3ZEfyVkHLcPl5ehiDuPmWl8Cx5I16ADPUmgCalRrsDs+wS0Whv238vu+KCHo/RwZ0ZtSXqpUSbp9jd060duRsIXKXr1aD8k7A5Mg6yj19c2nseJnjt6SYHEK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/0/xvfKRmuUfxJsiqPiyca/DrBuoD4oEVDkBhpWkOE=;
 b=TpxLWB/q3ZiWpanPKHJuJYn+X8nvilBlHG2AoFA8ru4ctw155/+JT27tbYXyocclHlYCrQr/zQgZrurM0bAcgqrtFz+eY4lzh0mlC86bjET0cdiuHAwvpAPJug8kr1gG3neb4aSZSQvoKz8UC7kLCrN2PhfLaOuIVWuo8NDsUGYwhr082aw/pXsB/Nk9PngdrPpgHovTvF2VSRut3WxGRSIAGx1TBVIjeCjn+OD8ZN6iH4P7JxvoEVwbyLhmIQsEA2c3YvXxYcMc1L0QCp6N3zrtlwXqOHgKEeqvX3mn+JB4h2MWuxiUJVUjhk8znoFF1oWMVu99BVOx3eHPYtkJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/0/xvfKRmuUfxJsiqPiyca/DrBuoD4oEVDkBhpWkOE=;
 b=qf4IBMFewO0vXEC+aT0IaYDeA1+j48XS0ZSRkIEH+C8Wy+0M4p1xFb6L4MFOI0rYVuyyz7ieg9czeFYVS3C2LPCR4eOzLatpm59jcdv9xKEFoiV2aaGYQeBcTXzhRRhm3n1BC4l6h6fr6cP8jbT2ApXX9Ab59FPe/abmBrGL0py1HHdZrj1crHvAFsqwCYE3WnYxrc7y7twXzdXwon+LJUzJzq+pphd2ZBhXDu47sY8hdNwVomQh45wrisXLBHTftuReI/lZxcBMolVlF9EChA9VMCdKw64IjHIqKl8b4QG3iqC7uOLR0rBrTn8/9LuJ2BknVqDgxUvQaUkIodC4nQ==
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 19:03:24 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::37) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 19:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Mon, 30 Jan 2023 19:03:23 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:03:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 11:03:11 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Mon, 30 Jan 2023 11:03:10 -0800
Date:   Mon, 30 Jan 2023 11:03:09 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y9gUbftU6BRqFc9b@Asurada-Nvidia>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
 <Y9fbVHytj12rpmZD@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9fbVHytj12rpmZD@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9950ed-7f8a-4f82-9e5c-08db02f4a922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9U5mwGbnyIjuA57htEo6cGXGG822gzscITv/IRmNUiKUvs+UkIfayGFYMai7dNhjpWIU21ITw7BlKITRLw4DdcxK/LVOFri98irkwvD4N4T4mNMDBhV5lLw4LF9GDfdPlMVI3maoiGCD/SpD0JRKKPYV3JLgmpy3FWLlOeo2FdtkAZPygi8FQN7AEa0ojOO+OwfJKBT97KWHeYgtxaDh6DQJMu0xsQY0VwvA2V6Fx90K2RHXjkK3+C1ZWA/C1Rzw9CNkS0JGCDXmedhx/iOHKevKSCv46hLVhkU4WDkc6n0onFGJV1pSlIrTKR+Z1Nw9egb24VysJ86I4eu17JmOZJ13oto3yw+8vktSi0jE2VfiAfZLwSCLGLWh72dMIt72n+2FOwZwhLo+HQsmfqjMVG/Q9hqA2SGRQ71st0/BS6APUoeobOjLkVPLWE0gJ6e/O2oMMbPuBbZDZPjyVwxolBkIHaxq3qCTML6HIH4HMlnAIjB4YQkbL4YdfE2pSRyr89o7gZSdtS0B9WsCe00+P/R5pBKxanFc3DpnV3HsApEbqjk0n4BysRA2d6QxgXorQLkXhsHMcgpzQFImbeQEQS+aogBg39R5rBKp7pOty9wiOSShyKLL/t0K8SsraIQz8q3XMWbU3EMPe9tCK/zJ/JBKCsHlGzFwaMOzrmlJUzwYHZV4ZGj8GpkosQSbi9xtU6x+hjt6UCsDe1p1zTt05A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(33716001)(2906002)(5660300002)(86362001)(4744005)(47076005)(336012)(426003)(83380400001)(8936002)(6862004)(40460700003)(41300700001)(356005)(478600001)(26005)(9686003)(186003)(82740400003)(36860700001)(7636003)(54906003)(4326008)(70206006)(8676002)(40480700001)(6636002)(70586007)(316002)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 19:03:23.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9950ed-7f8a-4f82-9e5c-08db02f4a922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 10:59:32AM -0400, Jason Gunthorpe wrote:
> On Sat, Jan 28, 2023 at 01:18:10PM -0800, Nicolin Chen wrote:
> > Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
> > its list_add_tail() to a similar place in iommufd_device_do_attach().
> > 
> > Also move and place the mutex outside the iommufd_device_auto_get_domain()
> > and iommufd_device_do_attach() calls, to serialize attach/detach routines.
> > This adds an additional locking protection so that the following patch can
> > safely remove devices_lock.
> 
> That should be two patches then, this is just moving one line of code
> from what I can tell?

The mutex is used to protect the list. So moving the list means
we'd need to the mutex too. What this patch does is to enlarge
the protection scope a bit to cover iommufd_device_do_attach()
and iommufd_device_auto_get_domain().

I can revise a bit of the commit message to mention this.

Thanks
Nicolin
