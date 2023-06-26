Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F173E76D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjFZSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjFZSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:14:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C337B130
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN7yqc+MiIvaTZMrj7hVlDmUCzQ1DTcjAumSS9UYGgIhcBaCssB4wMglz1fJFFV5//4IUCupH92Eitms874He7OjLS+dSoVzIR9skKcCzoHrC75e5a1qXMVsiE3vaB3YrLBZuvYLrD2eVdl7n0hMPMZgF9SmmqokeC/u3IfxNYQCj8rzsK1tLweouSMVgzdLULHzwUDB9pB3psmfa7epOS48YfXyHQc4iTktcNUWBZrzDaocNWwLhez9zhcJdnSlKcPuYH8DgkDPOTeHkH8tX66AZHzvG+XyyxqsuG5Goteko/0RxmAphTrozzEzbgV6aPrz2zj/bMNDxovs4ixtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYv9UuD7rHYsNptgWR+jFOi6PzaywRm7qoOW5XRpd18=;
 b=nZsJoo6Y2SXtbluY4Ju+UHDo1EOC6Dv2jWOiu08eraSWWeOT6XRbPoS+q84FdYOGMjGPt0H4pSqbhTyDz8s021z6qWnTytKNCyQd4vwEZaAijprHHha+28Pf2k2IJiFptfahon9jK8ZJJeMDA6M2WwrZJrIZ+V1DiVQ9bW+BeJ6CPNOeeqRRt9EVBYGcz7u69pAS/A+fiArgYLfkHbxGGtMubvxIIPvZsBxTAWcTNn1XBRXTNtXOe/Mlb+LB1ZPA6s+Dh4wt8S/ntgH2ho8GrcHxSmPmkct+hO2Yu+buqsn9+Tux9RLAhW9Q/Kojf6WTt76uRzesM729RvQHhSM1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYv9UuD7rHYsNptgWR+jFOi6PzaywRm7qoOW5XRpd18=;
 b=t/UVLECOrXFxa7iqYntwIBn1xNZ7Kr/gZtSR7heSMcfFBbtTdh2zYk3jwL+xn++oY71ackH6pqZvsf/ff9UiQt4U1YCrBxtYGIcxWWhgoPjl5YD8+j7wTiPneI5/FHMxVID5MSe4NzX9hbIAh3HiyS9y9mvruDnWTaZ8/xWTixam5LAXbfb2zRneeMiImHAeLF5O91lPGztQYiwach0LBLk/ijMkT98u1Vcm4kQfbrSDBTmJ1QsNiwkB6j6zlqPzy6tKTHzNx4aK/jcDjlLCJLKC2LaEJBNqFOX6ZHooqEbe855XdVqMZLWgIqat7T7tjL0eN7J6xR08YDyDB+I4Tg==
Received: from DM5PR07CA0120.namprd07.prod.outlook.com (2603:10b6:4:ae::49) by
 CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 18:14:51 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::eb) by DM5PR07CA0120.outlook.office365.com
 (2603:10b6:4:ae::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 18:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 18:14:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 26 Jun 2023
 11:14:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 26 Jun 2023 11:14:40 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 26 Jun 2023 11:14:39 -0700
Date:   Mon, 26 Jun 2023 11:14:38 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <jgg@nvidia.com>, <baolu.lu@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
Message-ID: <ZJnVjvh+kdUfeMcP@Asurada-Nvidia>
References: <20230621063825.268890-1-mshavit@google.com>
 <20230621063825.268890-10-mshavit@google.com>
 <ZJToAfeKg8FF1sZL@Asurada-Nvidia>
 <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKHBV266J1S6EMMjNCRMPhSXCKnqU7-H=rhi5iMbV4D9rH7WgQ@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 785828db-9661-48af-d6a5-08db76713c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SD4iSlo6XwtYAEl+Keg8WEwfRMej3Zlc1hjQyYZGg2a4oLhwnt0Xs7PyMiXRiHsbqmUWIzuGdjvHekCTgsSQof1nUEjh6ZBdg/wfmGH2i12Wc5APDv4v274JXA6jWS8vAocx/Dv3Lu27CS88gyCWGCti0CEC6eTS10z3ueEBzc18ib2/BKQzJeFVW6MZut2KILpwEMaw36Dt4DhF2xCtYWdCsyXf9kOBcMUtKa3zerIp66YGj/zQ992snkoID042zu4VeCnB4rrQCnt8VajGzk6k3p9/vY3DU9VqIFCU25XRi8QD1ZGn2mJKyp5dcbU+e2gnlF+gJzA1Jx3IZicDSeeTr6A2m5UmY0CexqLYesT7cvjPsZ96fhVFcK/jc78IEHkRAMtMk9HBoZppkFAQn/NByKW+WPrYcy/w+AWTdtD+cDo9VsrV3lzw9VWlx1s7KfZ5Nb/bYe5ZxC94Drp7T5oIm9JbDTp+C5CdSqsUqwvURd2uhtMN4a7TC+ejef+vC83OwvIxJKcYSBCP1OAKaKPosuy7nQ2EghSFcAHe5NIT9IIpEGVT6SbdH1waD61gvpnXRmRBdCPa2q2ALLzDb6WUIZ5AhJ5A2QW0Ix17m3dkkKzZpGGAjjcjzrI3TI1YpRBA5mf3FDBEvJHE6FbdQjT01YT3IbGLT4Kjc3ZfH+kk/it+zYIO9NGSU4KEDsakjZpJ2hAarOKaYi4J4hLAoUU89JvEVFQjd9lX9so1Ac4fJL5Yl2jssIaHocRzlAGuSVn9Tshq2gVEwg6uAspzZ4LPiLV+pyfsUIsj794GupI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(33716001)(2906002)(186003)(26005)(47076005)(426003)(9686003)(36860700001)(356005)(40480700001)(41300700001)(40460700003)(83380400001)(70206006)(70586007)(8936002)(336012)(8676002)(55016003)(82740400003)(7636003)(54906003)(4326008)(478600001)(966005)(86362001)(6916009)(316002)(82310400005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 18:14:51.2744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 785828db-9661-48af-d6a5-08db76713c12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:33:58AM +0800, Michael Shavit wrote:
 
> > Would you please elaborate a bit more for the use case of
> allowing that?
> 
> In short; to support devices that use SSID to isolate different
> (device) contexts. Those contexts (and the memory available to them)
> is partially managed by the device's Kernel driver.

What can be a real world use case for that?

> > And which test configuration do you cover
> using smmute? Would you mind sharing your test commands?
> 
> I used the setup suggested by Jean in
> https://lore.kernel.org/all/20230511195928.GA288490@myrica/ , with the
> following commands:
> >>>
> # Basic test
> ./smmute;
> ./smmute -u mmap;
> 
> # Test invalid access to not-mapped address
> ./smmute -u mmap -f drv;
> 
> # Test invalid access after unmap
> ./smmute -u mmap -f write -d;
> 
> # Check smmu_mn released when killed
> mount -t tracefs nodev /sys/kernel/tracing;
> echo 1 > /sys/kernel/tracing/events/iommu/enable;
> echo 1 > /sys/kernel/tracing/events/smmu/enable;
> ./smmute -u mmap -k bind;
> cat /sys/kernel/tracing/trace;
> <<<

OK. Thanks for sharing.

> This only covers existing SVA functionality. To test the functionality
> introduced by this patch, I used a device capable of generating DMA
> transactions w/ SSID and a test driver with following tests:
> 1. Successful dma Read/Write to buffer mapped on domain attached with pasid
> 2. Unsuccessful dma Read/Write to same buffer after domain detached
> from pasid, or after buffer unmapped from domain
> 3. Variations of the above with a domain attached to multiple pasids
> 
> I've been considering migrating those tests to the smmute driver if
> that would be valuable.

Is this on Gerrit too?

Thanks
Nicolin
