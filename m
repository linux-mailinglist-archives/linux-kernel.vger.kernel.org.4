Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3836BEADD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCQOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCQOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:16:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8D60424
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVP+BTqugZDMW4SnR9BGsi73X3zFrQD1RqT92GRH2byGZA1s7yWUWXv9bFHqqCh1xLyOgWG2CX1tLpawYdv0qiMGmI3WxUlGtdNtzgW4dlI5oeP55b63uLl7ix8+5nHOf7ZmNOypDq88mcTcfpC1Lli9Seeg8BtwqUZeqJDhuoCyriyZDFpR5qRWJ+GTkWqZQP8I13fAVckk2rMQXvuXOiAs6ro1LrWw2FklC1x4pJ523w6btmf4piEJZUL3c+T8hwxTdvqUXu12CGePEzZrAGTg7ijEHeKT1eg0b8a/RHsZE9sjvPIc6Ho2t68rSWQpsq5TbFnZiOsb+N+TCjHLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1ps6ZeCFVU6wQhaePDy/qA9wanHLSMtrVfaWydH8Ck=;
 b=KuV/NxEMciaxYBri+iCwAbUmBLgXxu8v4mldwVtC3FFT8j0BDkDEYcY3fSJwt/PcQsiwo+kIiycbcEI65M6c6RX7Omcyuz41yBPIHs+wY+hO6tmePWK8AOWXtcAjUz/df9H0xG0Hxh8K0PS+bu7b1aYFnuC8Buy23CT9WWKwK/Dbw9rnLiUbwMB4E4FOzYfASGEp+rOFJ0EV11GaU7jv8rUVGqMM/YXk226B2826vT0Z+LlJhl9ePtH525EALY4NYwA3w2/M2wlrnGB262mI4FIR8c7fGCZHFCG/q6gmNITuBHh3+BRshtpa67NeUh9erECbGEvLBjIhiE76qavfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1ps6ZeCFVU6wQhaePDy/qA9wanHLSMtrVfaWydH8Ck=;
 b=Thl9fLATpGSSoBkB2jVy1XPxFkCVKKop65n6gzVJ5x+pI2wSqkQeUbwZto+mPX4+mfZWImoYDnlUvS/A12ZVnFxljGV5bft3XDXBaJfJUAG4NUsEqaqe5PwxcwW7YFUMMrfoCNdnlnYEMqNEDzjVeeo9EvAhLTPNArTnjwMuJSy50hYk1yKfvlLPKINnZ1bD/zm+G8DIHhk+Nhjwovj7NtV7tNIq0MYw7x3rrdi5+Xfp3v8Yj2g1tKBnEuYaMv4Q8Z/Weosm6NnHPpPeKePUFrgDZ7Nhl+lg0ShAU4WxCUZ9cOPLGZ3eVBXxHQr+Lf9z9dAkuFKGDnJVsCvlfYHOVA==
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Fri, 17 Mar
 2023 14:16:19 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::e4) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8 via Frontend
 Transport; Fri, 17 Mar 2023 14:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.16 via Frontend Transport; Fri, 17 Mar 2023 14:16:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 17 Mar 2023
 07:16:17 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 17 Mar 2023 07:16:16 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Fri, 17 Mar 2023 07:16:15 -0700
Date:   Fri, 17 Mar 2023 07:16:14 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Message-ID: <ZBR2LvtXM1c1lDNS@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
 <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
 <BN9PR11MB5276CC29BB979D6093CA91F48CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276CC29BB979D6093CA91F48CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 28606912-4630-40d7-bce3-08db26f22db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxNcet+HcTkJCWH6bopBmiruMioBBsHBDgHk6ZfFxDXAUYCQECvg41KId//ryPJ84AXAVOB4ScW+VR91BElIaJJRrWUkdJf6dlRbmeusDE6imxEQ94QD9Ri+bXgDQ1IS/BK/CwjMNDtlh2kVnHiKzEWa01o0uZQHPkk+sQArwI06OWPgxwptL2Wi8SAJo3f9C1/BY7izqbWtLNwOmC1NwNLernOaipnEfqIG5VnX0KHnU6lQEiGmU+uQl4ik84cFC+CIfqSrZya0H+cCprVFqsqJZHuc9LyYQEKuLgSZM6rauwrxQsxfY9fa9yWixcdnNojxmz8U5s92qtjwyetBx2EYz7XX5Q3A7+GMljwaP4yz7t/fH4MdTDZOgW7EZYlaKenZkQus+ccYEZmKr6s2ZVXdvoDFSO32giNL7t0L32N5a5KFGQhMUJuiWSbyJsA8k/Me/nRgH+G/5vpDbpxhvJfGe9W+QIk68zb1Gr3BovkCCwXBciBnub3xqF1o2tp94FvOTXDGkSVKOmBgDVK+dMIITX/cxngoqBYGCunzfH7/3vSfL3cmWPH9ubvkiZASzuqBU3TL9JXWPR22Q4MJyiCowrkfnHfm5lVuRYMQrpm0R0I2BckrmZcpzRBCMTCRRoIIKJGrSx4ZStneZnPxvgCVw7b3RQYgJX+Sjw9WqNEF1vaHrMMVUzg9nFNpteUk2xUMA5s0GWXChcq2uZBvhw==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(36840700001)(356005)(82310400005)(33716001)(86362001)(478600001)(54906003)(8936002)(41300700001)(70586007)(36860700001)(7416002)(5660300002)(40480700001)(70206006)(55016003)(2906002)(316002)(6916009)(8676002)(4326008)(7636003)(47076005)(82740400003)(186003)(26005)(9686003)(83380400001)(426003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:16:19.2567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28606912-4630-40d7-bce3-08db26f22db4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:47:47AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Robin Murphy <robin.murphy@arm.com>
> > Sent: Thursday, March 9, 2023 10:49 PM
> > > +   case CMDQ_OP_ATC_INV:
> > > +           ssid = inv_info->ssid;
> > > +           iova = inv_info->range.start;
> > > +           size = inv_info->range.last - inv_info->range.start + 1;
> > > +           break;
> >
> > Can we do any better than multiplying every single ATC_INV command, even
> > for random bogus StreamIDs, into multiple commands across every physical
> > device? In fact, I'm not entirely confident this isn't problematic, if
> > the guest wishes to send invalidations for one device specifically while
> > it's put some other device into a state where sending it a command would
> > do something bad. At the very least, it's liable to be confusing if the
> > guest sends a command for one StreamID but gets an error back for a
> > different one.
> >
> 
> Or do we need support this cmd at all?
> 
> For vt-d we always implicitly invalidate ATC following a iotlb invalidation
> request from userspace. Then vIOMMU just treats it as a nop in the
> virtual queue.
> 
> IMHO a sane iommu driver should always invalidate both iotlb and atc
> together. I'm not sure a valid usage where iotlb is invalidated while
> atc is left with some stale mappings.

vSMMU code in QEMU actually doesn't forward this command. So,
I guess that you are right about this support here and we may
just drop it.

Thanks!
Nic
