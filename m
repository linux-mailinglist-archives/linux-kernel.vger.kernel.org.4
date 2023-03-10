Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9776B4BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjCJQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjCJP75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:59:57 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF5F110532
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG5EV4NKTQy0SbWf1XHLE32D1O//5rz9x8DhMlztSoctvSER+//huzr7JomHGnmLRj0kCXOmYc3D+QZdHhadier77zaSusP3W4zPLNKU1jxCgRkOMR2Bu+h+fYlg2AYBOleLs7BXpMo6vU0UoLs1Ttj88GaxpQUl2c+Ic/phnwcGa27/pZq5EwjhfyhK0f6uMrQ4LmUCmQqJZV6DLEFt5TaxLLmR8VJ5q5n1aWIk4ktTk8XbnSxI3VevMw262gVk1lEf4zoxt2EY7lQ4ZAy9qEuYV4mp8EU+5HvRo+U6QGIUpMVqHrYHIWVmkZOt33tkmpMhnJKufs+AIjiECnaV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6afviQqBNdGmVbqbQdXQx2WmD5ppnShuAvSAiBGFHI=;
 b=GvJj6S2UlQw2Zxp1SSoOMlQbXM6i4ypGZlbhGlNCdhVOGNzPypSDTWKB+2UkcJySvZO6ktAq/4hMS1vAwiVJBZoEXa0/ltfkUCM5a5NHNr1D6o79GHUY/g/eJz6qyc4m6kQHobqRrT7BP3uI2WQkH+HeQp2SPo/NXbdrMpz7tr20NtK7f1bTyZsTGYAHuqwwR4+Nrw/5hqqG5s+YKePMrGRMgxaB/Dco8IHZ4oxt/kzsCmnV7zpxQL7K0Lmfjq4ggUpUDxL1j6FOgBgBjIfnoBaFUxwVUBsqLDBUlEA6ON48Ytuc7lLvlr5vT/XXmF0hNumBFWI//be2J1ORNZol7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6afviQqBNdGmVbqbQdXQx2WmD5ppnShuAvSAiBGFHI=;
 b=g2qF1QAaS/AQNawHXQcF2PVjE48ZGtS89dl7KiMeMzazKo7FjsvWoxC7D4ic2XDMGFkmiMZnQ4/CANkin0Dke+okrYsARXH7wbc7BguYd/sFD6zmPlgjYYXuZ+WdifSoZoJGWPz4Hzlh3kEP7nm2hvVAGhaMbgZ7aPnLAW2CpZCBHwDKM8w3G2u/ofLQj3XqLYdmMTLu7zs0ZtC/XQEPpxS+P+cyr+CmPsukau3dO857Lz8Kr4ESrnp/8q4laKUDVAEjgyw2wDYq8A25jjrMrEdNweL6aHQFufIWpGqg/qX/wnoEuF9FKpqHAHlwehHrzXUYdc5Nb8cm+N2bRN0JWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5832.namprd12.prod.outlook.com (2603:10b6:510:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 15:55:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 15:55:10 +0000
Date:   Fri, 10 Mar 2023 11:55:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAtS21vqhp7LqA+B@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
 <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4938b20b-14d8-86f8-e80b-9d8ed9d8f28d@redhat.com>
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 61aa3871-61ed-4a9c-a39d-08db217fd40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOz+/SHBN/2yrNdXtwkeJVQXOqqoUK8rOPZc8u1gY+5MVFBuzSbKKKy04Q9Rd/DwSRbSWnwd5jZpZUQ2DS/qg6cuxcBT1obWUC46SFeG15XpSNqdJfuE0xpEPyW5/dShavttAtcVV74XR8ZS+qsyBwSxYTjWhOWCPcTYXaWNq1yP3pkyLNnIPaVrCUfvUDFM3I7RFkCNudixwuCw512hNNblcfAB0NFzAT0OBMh3++XgX/6/rNMdivICRuCLxbmL8OTGQvo/NAS/W7n9Pmz7TyFAeSkBBwefJMxAFtLZdqqOSy4hzJ9oN/wGtRWy5jxCYevDm1N/YLcMjrJXTSkOjNR2HQYMKQBrdBR6XQqniOEMQk1G9nAi/0oRfEmFjaTFpAHAprh6Fq4gCqWUpAemWSVVs003G0jPQv9E0RLEt0oZiTcVZqTW06ba8sLyAb5gKy2DWXWXY1KeewhxzWvxa1t2yDwYDd76e92MC4C33a8eOAozxPCyIh75GAJ8x53P+eVrDxQjinY2Yo0yaVsw0yLRpxN38PNWa96B08/wF7WLj/TCpM7uSX71d8YVZKyfWsNo3C6w0h5OmTxwmzk7+bMEno1RgJkOMyMH7LYCr51rgybxCvO6Gre46RNZI/hCpa65uUxdjQXw+HXC8JUTs8XLRGP0/UfWz8V+ID16kgzox5Ns9zpmUD0kNVTRGAgMSyFogvQXTHRTXkA4V5JhKCfGFeq7hC59K/hzkQcJu4tvxVmq0EByeU6FCGP9hFTOnaz92JM5J9ypdJueOUEcRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199018)(36756003)(54906003)(86362001)(38100700002)(6512007)(6506007)(83380400001)(6666004)(26005)(2616005)(186003)(6916009)(6486002)(316002)(7416002)(966005)(66476007)(478600001)(5660300002)(4326008)(41300700001)(2906002)(8936002)(66946007)(8676002)(66556008)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eDD/gKd2LgDZ94UVmRslS6N+BehZv27Ic5VYhvsLqONi2wXCt3vMQjb2s9dN?=
 =?us-ascii?Q?eqJoGyrUpiLRoXPWeyC548w3GJiezbNkp+9B++w3kZyAnPAEjbqay3FAJU2+?=
 =?us-ascii?Q?mqwqWfp5zE8OQNMiefQp3+MZogjZ1Ofx9tzaE+GGmQzYXnZPhHBPJ2289+lo?=
 =?us-ascii?Q?yzjHiVRT5Qhq+Fh33k46TLdhIuBH8UULnduyxr3E6MST/Afa2Txio4ycXbme?=
 =?us-ascii?Q?1AHeuX9F0FYuzqmw8GSDFBtbB0mHIimCpLSRpodwRVvMREQSJqCokAw+TIhP?=
 =?us-ascii?Q?iCrlQlEOM1Wq7dJ3WnV+hfkPGHWV9AAcM5O0/IgKwp4+DdS/q4my7OlXB1Rb?=
 =?us-ascii?Q?H5WzOooHm69ir4bC54Ru4Qhrxl/XP2ewWllykKkmexCOvrSUSKbei1uw3asZ?=
 =?us-ascii?Q?agEG5lqCB9Zqxshaqpn9SFjogUAzbxl+RqPkPEcWgwwxyTZVhXdhYaoqJNX7?=
 =?us-ascii?Q?3OibUKVCmvocVMthkm1fCcTK2XBsJT76wD8oqJzJjd7fF56wF8EXTrkd6TeA?=
 =?us-ascii?Q?7GEIWHc21D0jkUW3NS9yeczL+0qb5QT131QyG8sahXwJvpJGQ/AWW7FS66a3?=
 =?us-ascii?Q?utDd1vx1TtjGV34rmieMIGa1IjR4sn0EMHJhkf9CQ652oJBK+cIQVlURJzQ7?=
 =?us-ascii?Q?fnafGhw133yF2P7wLthLWc3mV2oQfFM5PJQjbmErQuVTfht0cRDsCvf/oqJP?=
 =?us-ascii?Q?iNxfs3+jWi9edGl3EYvg5KepXUnBcYzNLFcTnwF/hf+uM9iMfXs8/TB2392q?=
 =?us-ascii?Q?9HE46Bn27lBQxRMNMyLRWHRRJxkBOsgBjKqWDuiAosCb3vRaAu1Qp+HRepYe?=
 =?us-ascii?Q?pVf8V+141hRU4pj+gpbI6Obm0+o3NiQjcU7bO/joXTWUX57wztX0gbGDbsXk?=
 =?us-ascii?Q?e6PjAWJnO/2p2CNqPiJp0o1ELbwqc16N20+d+OjcRFUZKsWaUuCSGW4hzFMV?=
 =?us-ascii?Q?hCgmAYB1G21E6kSZinF7/q8fT4D8LA5EymSSXmmIaEWS/Aa7KZ6lS2LjykJX?=
 =?us-ascii?Q?di8gL4gtAqh2HH1b0cZ9cYoC+GAExiiqervJxCeHow5UlEFs8JVAHHx05CoE?=
 =?us-ascii?Q?JhuOjP17Pth71OS7JNsbSYgkuU7GaUu3K91mnWLPuPoW4Bi4ZL2FLnaubMWc?=
 =?us-ascii?Q?yFTe13Fc1oeNCnghJS3boDUiHqVQOs5ghT0oMB2xiNDIvwi8pVFy6rzIfvs5?=
 =?us-ascii?Q?xLT2GsIARoTj2zxKKFckXYvOUzjgnDY9b05GkjgYb3dH0eSAUAhHboqEsgzj?=
 =?us-ascii?Q?xyga/z+ozoGAYHfO+cIrKdNePZJopnL9T+q1PgkwuviJVjfz4fSDwsCH+Cpa?=
 =?us-ascii?Q?20GWBVoV7mYKKGxzwbnTV1Bp27kwv9e7pa9lpFOJWqUKaSzpZlEn2lth2Yyd?=
 =?us-ascii?Q?78/l2IitveHGQJJqFMid8pVVltFLWxg5ZqWCNXkZhe76W1bBBaFzHRLAZQon?=
 =?us-ascii?Q?FvNRXnOmWwvOTOaSb9taTr7vz0dIouu36aYKnLu4WEzNh9eazAFWTZZRyEC3?=
 =?us-ascii?Q?X278rxS4tsilhtGFpZCsQEEx4EBhshpiodnUjrkGJ2uZfrhlYF8UO37XaP3l?=
 =?us-ascii?Q?VkwP7Oz/vY2p/t4aSOAL7hiqBnH+J9Abd1SbY0VX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aa3871-61ed-4a9c-a39d-08db217fd40d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 15:55:10.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRsW2ZIAt6HCg/RueIuVmFiK7WpET0QdN7+lCRX91Wqu02hXJqkgSNxrVqXErfSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:41:01AM +0100, Eric Auger wrote:

> I tend to agree with Robin here. This was first introduced by
> 
> [PATCH v7 21/22] iommu/dma: Add support for mapping MSIs <https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/#r>
> https://lore.kernel.org/all/2273af20d844bd618c6a90b57e639700328ebf7f.1473695704.git.robin.murphy@arm.com/

Presumably it had to use the iommu_get_domain_for_dev() instead of
iommu_get_dma_domain() to support ARM 32 arm-iommu. Ie it is poking
into the arm-iommu owned domain as well. VFIO just ended being the
same flow

> even before the support un VFIO use case which came later on. So
> using the "unmanaged" terminology sounds improper to me, at least.
> Couldn't we use a parent/child terminology as used in the past in

No objection to a better name...

Actually how about if we write it like this? Robin would you be
happier? I think it much more clearly explains why this function is
special within our single domain attachment model.

"get_unmanaged_msi_domain" seems like a much more narrowly specific to
the purpose name.

int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
{
	struct device *dev = msi_desc_to_dev(desc);
	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
	struct iommu_dma_msi_page *msi_page;
	static DEFINE_MUTEX(msi_prepare_lock); /* see below */

	desc->iommu_cookie = NULL;

	/*
	 * This probably shouldn't happen as the ARM32 systems should only have
	 * NULL if arm-iommu has been disconnected during setup/destruction.
	 * Assume it is an identity domain.
	 */
	if (!domain)
		return 0;

	/* Caller is expected to use msi_addr for the page */
	if (domain->type == IOMMU_DOMAIN_IDENTITY)
		return 0;

	/*
	 * The current domain is some driver opaque thing. We assume the
	 * driver/user knows what it is doing regarding ARM ITS MSI pages and we
	 * want to try to install the page into some kind of kernel owned
	 * unmanaged domain. Eg for nesting this will install the ITS page into
	 * the S2 domain and then we assume that the S1 domain has independently
	 * made it mapped at the same address.
	 */
	// FIXME wrap in a function
	if (domain->type != IOMMU_DOMAIN_UNMANAGED &&
	    domain->ops->get_unmanged_msi_domain)
		domain = domain->ops->get_unmanged_msi_domain(domain);

	if (!domain || domain->type != IOMMU_DOMAIN_UNMANAGED)
		return -EINVAL;

	// ???
	if (!domain->iova_cookie)
		return 0;

	/*
	 * In fact the whole prepare operation should already be serialised by
	 * irq_domain_mutex further up the callchain, but that's pretty subtle
	 * on its own, so consider this locking as failsafe documentation...
	 */
	mutex_lock(&msi_prepare_lock);
	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
	mutex_unlock(&msi_prepare_lock);

	msi_desc_set_iommu_cookie(desc, msi_page);

	if (!msi_page)
		return -ENOMEM;
	return 0;
}

Jason
