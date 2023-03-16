Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300066BD9D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 21:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjCPUG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCPUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 16:06:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2CE41091
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 13:06:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaUn6SdUHkc+wsE9oJcHHh4o/DnFB7uWGjDmxGNH3uossGu6cFXr4lTpS8ztBxFou++F4rznBX/RpgRMpzQjT0e1NHJX7/uQDVwXPloMz6igS51nvIxagyfij0/Tm/Q5V5sDM93e9nv+jlgpJd2PeCTVFrhAroQrF+/t8IGgrMBn0RKOF8S9lyGeb/ux7Pj1xWITZy/uWwiBkaU7AzvR2dtnt2ynCzsb+5/4MhSFOKQcUwjh8TkSfq2GrohbLH8A0I+TZwLaJGpaNQAU48rf2YoKGyABvBg9lj/sE7EbC8zez/Cy6GUUC7ynkRp7bV7j3N22ppiqV2no5iFRyW5Gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hZVjjSF1qznhVfAth1Z2DmHdL7k/h9SQ5CmoF5F0y8=;
 b=ii9tUxpMiy6vbRO8gkMLdLQxGDToh5aKIKWL/vZ7pylo0dMWPfv3pD4W31gDtZBKWdkQJ2cRDlnZg8Oro0rwlKGWrgUtbpHXrZnMuath1atC/qE2uY21FxZt8tzJYOloiqHQZK+Lts1LB7c43xYDbUhVBS4ongxIoqb5++ltHV883J2jvtzjuvIc9bhvjQU2DPB0maAc3DjlAuIQmXhNOfiBvLhSvPhrQpNUjr+EKeb5Rdc8Tls6BHluqw9Mjkq4u/PybbYcaf4K0tb4Ewsi/KVbWQMJfsaQpVZ8HeCt82uT/EIeoKNpKiV98VVjX8gYpzjP2vpzGTM2JNbC8hDH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hZVjjSF1qznhVfAth1Z2DmHdL7k/h9SQ5CmoF5F0y8=;
 b=EYKlNBoNsO7xQUg5qIaBh/LTOZj0rNSEzHfkvvK/eXAaHr3jmgAJtKMVR/68L4uKlrMIhRgSuQ90kpOB7/5bed5rhbG3JW6Mib/AINCoyBzysnoBm82rJRoD9OvZpjfyYPnwAiLQJ9+Ig3Gs8SUuJWda+t7XGzVzcqX6lv7UAH49i4R+r1+9TZRvVGh/nC+K9GZXo4i2GlWMn70XU4HU8Y6WMPIJy9hY/4P+RZWvbwcDgOoaDowbEey2SwptE7oFAXCgg0uKeZWUUbLSV/hK5a19diXGecvf/ngGnn3NmqmJX7/w36sHUOAU0IdDQReUOQ3Sa0wqusdUasxBT+H96g==
Received: from BLAPR03CA0051.namprd03.prod.outlook.com (2603:10b6:208:32d::26)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Thu, 16 Mar
 2023 20:06:31 +0000
Received: from BL02EPF0000EE3F.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::6b) by BLAPR03CA0051.outlook.office365.com
 (2603:10b6:208:32d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Thu, 16 Mar 2023 20:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0000EE3F.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 16 Mar 2023 20:06:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 16 Mar 2023
 13:06:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Thu, 16 Mar 2023 13:06:16 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 16 Mar 2023 13:06:16 -0700
Date:   Thu, 16 Mar 2023 13:06:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <jgg@nvidia.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <jean-philippe@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Message-ID: <ZBN2tmWoRURvjarc@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
 <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
 <ZAqFFolbw5xoJDfb@Asurada-Nvidia>
 <5cc56149-965a-bb47-f23f-6aa9d0ecce4e@arm.com>
 <ZBJfJUjbAUId68s1@Asurada-Nvidia>
 <1d4ff93d-a97e-85bb-4259-9da259bc2ab7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d4ff93d-a97e-85bb-4259-9da259bc2ab7@arm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3F:EE_|IA0PR12MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d6796d-44c5-4efe-49cd-08db2659ef73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 442Jb7ByR6lxco3aAmq+x4hHgfYXpMyNV4c2iP9+Q1k4E4gFtFV6YsxBotBNywaS468j4SKJ+2xMPz7RYWGut3dNAhbJrNnBSNoNqtkHpEz590556JSDz7Nzm52CTSNMRMPzCBodTNVzlHOsjWZ5rdAs9KCfk4RDtP9DzWR78Gh4yOhCXEomJQedHDdKGfB+qJvHGPhSHx9pFIo4MyN3VyQX/OnnZnjzpnBpFQ88hN5CAFFSnupfA0QZ7a5f6mcpmfU3nQg/fJuCVTt7YIZtnY6Bw2ZlPl9oS9i2JwlxxLK3OKoMfB045Rsc6yegKIFRtPsvBaKv7dEXXhMOOfhdISWs504VT7jtPIC2MWUiNjEbMFw87KBYTaSjSsjcOs8vT9NcdaMdQjsYiNmzwKy+NeKAB690YyxlrCZYMsroqpA2nUUFYRm34evGuJPiauzKJaQABfzc/7B/j8cyLY2naqsw70TqgtoEPE03kMZKtxux4XgjpkrXWXArbkiZqHLQSZq7/xnADMNHiYsJmCii+l0SJgYdmrkv6pClqRPHQvSiQ1bKTVZRI4sAeAmvMcdu1LzcsNcF0puRn2FR4iV+0uGoKSwkYSdhWTSmcxDtqoABLJMqxXEzmAQ2OqmGeC7beyDIFyI8+jP7nmEosF1XvJmZjP0L9S/p2qasQBRVg9syq6oaTGWeMb32yIMMqpxWvERSc/tKxqN4ySZi2Y4kxk3dK4C0+p7N6AVHegn11xnAymkrBHvkYcBg9n05h8Yh
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(47076005)(356005)(36860700001)(55016003)(2906002)(41300700001)(478600001)(70586007)(40480700001)(40460700003)(86362001)(54906003)(8676002)(6916009)(316002)(70206006)(5660300002)(4326008)(82310400005)(426003)(7636003)(26005)(336012)(7416002)(186003)(9686003)(8936002)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 20:06:31.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d6796d-44c5-4efe-49cd-08db2659ef73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 03:19:27PM +0000, Robin Murphy wrote:

> > > Note that until now it has been extremely fortunate that in pretty much
> > > every case Linux either hasn't supported the affected feature at all, or
> > > has happened to avoid meeting the conditions. Once we do introduce
> > > nesting support that all goes out the window (and I'll have to think
> > > more when reviewing new errata in future...)
> > > 
> > > I've been putting off revisiting all the existing errata to figure out
> > > what we'd need to do until new nesting patches appeared, so I'll try to
> > > get to that soon now. I think in many cases it's likely to be best to
> > > just disallowing nesting entirely on affected implementations.
> > 
> > Do we have already a list of "affected implementations"? Or,
> > we would need to make such a list now? In a latter case, can
> > these affected implementations be detected from their IRD0-5
> > registers, so that we can simply do something in hw_info()?
> 
> Somewhere I have a patch that adds all the IIDR stuff needed for this,
> but I never sent it upstream since the erratum itself was an early
> MMU-600 one which in practice doesn't matter. I'll dig that out and
> update it with what I have in mind.

Nice!

Perhaps we should merge that first, or include in this series
if you don't mind, so that we would be less worried about any
affected platform when releasing the new Linux version having
this nesting feature.

Thanks!
Nic
