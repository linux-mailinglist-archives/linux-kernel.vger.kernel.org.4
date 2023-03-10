Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6883D6B35C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCJEvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCJEvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:51:12 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF8D106A07
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 20:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeROcL7gowCLLIoqjJtIRvWEfdw3OMxxt2TkX1RE63YsPV6yun61KmIOfzSY/renGxDQ7LZFDjYUrRZOq8RuTHnupL1PdbiKy9Bdh5c9LPNVa6UzDKSPAewgHTj6vA8fAygm5fzZPTnCKnwWN0hkPY32J7SGjuN7qT/+EtwmY1izwgNirdm1l/WyqpTpQbmbD8NjnzpWa8+u4xzwQSkoljadDyzYN4AcGC67yVyL/JHPkE/9mQb1dABXVKFcrYFlPmB7eN2H5TKHHfdYYRemHZgeGNWpMtUvtziXFksipHHoiXXixk7/lrp6RVYSGZ+hhTXeEIH3voGIGLXwnwTwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uk0ME+gRhKs+kI7f3SGoDG7qtH4PyjZGIuVnT6WoGI0=;
 b=J22djEMlQpxKO178h4siwnwj1A3ByDlLTm/Rfqmxzo/M8P1W3fwlNyRhQZ6n+dUYmDgWHhR4HFqoWS/CSDet9A+3Jp8hR1vMa51wHqFlz+VF6FinmhH6uTipO/+DLMa5/u4Td7lZSfM2UW5qadVS6PMuBJuqJU5/lqm+g7OY7dHHSX4gaxMvHt1U7rbnV32a8GyI4wO5OXapXrkDggOLoWDaBW1fYP9njvf20huHusftX8XjPnNhozbn7MALWHMOMNEFvdz3aMr7vtiEkm2YIU6OXSDFd/yD3+uWfAlEw/em4MwxBpVftUJHYRLEm//PeJtX6Zn94tVsS9pwtWzkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uk0ME+gRhKs+kI7f3SGoDG7qtH4PyjZGIuVnT6WoGI0=;
 b=LMUovUXyVK8MOdTGsgIlwLPvgZrg5DhQ8O723RtrDmmPURlEiAv+RZp2uW5MeyCcAjg4YhaAoPiNesgHCMD8tlYrp6PQKzOk9Y/zlnBWfjXh8lHtkIbRTZnvOkekVUUdhC2nQvD7eBHk1LBjtjmiworfoMEClwr5XH29HXY4HsxgGQU0+yboEO3gKEuWSKY38fK2/+JlHbWxWmYEQDLOnIpzPDboPAcLXO9LoaC+AbJnHNKJZ3s9PLXfjiFTdm/oGd1LlvPqjq0cCt7uar0FiugOY2VYtOzB8OP8PCUGPSbcBOIknOFTMlMSNvwVUnjXUiiUSLvT84Ef1n1nQXoE2w==
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 04:51:08 +0000
Received: from BL02EPF000100D1.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::c6) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 04:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000100D1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.17 via Frontend Transport; Fri, 10 Mar 2023 04:51:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 9 Mar 2023
 20:50:54 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 9 Mar 2023
 20:50:54 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5 via Frontend
 Transport; Thu, 9 Mar 2023 20:50:53 -0800
Date:   Thu, 9 Mar 2023 20:50:52 -0800
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <robin.murphy@arm.com>, <will@kernel.org>, <eric.auger@redhat.com>,
        <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZAnx0lUkw02cVTi+@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D1:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: b693a080-787c-44e1-f643-08db21231075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkyrm4YNEIhUg9uVV5HRgBs04RfMgr8cC8rcZZ18MeG8E4zoYdMDZ7NLOf2gqe6+8jHJ8btFG3s5TcF9Jj4+wwY62ZdK/ZCQlawcT5JyAwctetPLChUfTp9K6CtatOvSJU8Rl+aTO6izsJAyN5ELJB/rYPLqCJToh5A2snBi8KihJGpeAFYtCcI0r4t+1429nhJQDQTF2fveVM8khGdnEhH5O+7giXNO3lSh/ugYXJv3SH/Dh7YF/s1sHcb83jUCGixQAkxda3vWpHqpfS9JruBBugi6IjZHzKqEfr6NZwP56jVmoB3g8ebtcg/HbvpOv+wCkB9RSdCF8X+3xbsFjZN3fS3CMsPOAim+kahn04Dw3FBFv1lx8yt+jGj+xfhdxxq1RJnohMjhiIJk016hOuIo7CooUXChriafQeJ5PAjGtb/IFFVeE8swqgZRWkg2Hs8TuZjDUI3QRV34t1/uZ2uRGRzVVjMMGHPxakkzIr8u3bRF3kpY2seC4P+1hNhIfhbbFEfE47JHUN/mknxJ9ktm88STJq0N4LH1w8HPzdbJWl1wKxsSBDkisaw2AGVhOaXmHS9xXwnrEU8/ndPRbdBWzhllxO3KGpujMYK+PvrMldXfr2QxzX6mzlL/85FZ8P/KGU/tgUEzbOKg1Zs9aRtCGu4F4YZQ2qChU+mKaiSZnaQ2VdvlgNvOP1Dzl/wuqHRdY7cUTZK0dIhvHc4rJwH8ETRohB/9JBmVoZZiDxxFia3VQiW7Ip9GT7Ir55Rl
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(46966006)(36840700001)(40470700004)(4744005)(40460700003)(7416002)(5660300002)(82310400005)(83380400001)(47076005)(426003)(26005)(33716001)(336012)(9686003)(186003)(356005)(478600001)(316002)(4326008)(70586007)(40480700001)(55016003)(70206006)(6862004)(8936002)(8676002)(41300700001)(86362001)(6636002)(54906003)(36860700001)(82740400003)(7636003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 04:51:08.4764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b693a080-787c-44e1-f643-08db21231075
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:

> Nicolin, I think we should tweak the uAPI here so that the
> invalidation opaque data has a format tagged on its own, instead of
> re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> tag and also a virtio-viommu invalidate type tag.

The invalidation tage is shared with the hwpt allocation. Does
it mean that virtio-iommu won't have it's own allocation tag?

Thanks
Nic
