Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5C96B2944
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjCIQAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjCIQAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:00:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C4A2055C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 08:00:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORbu1ygey7cS1rYnfbjiOeQNLIIQB2bPIYgsqca+L/Jwx7V1ONCRheu/MSVzQla0QCd9fK3nLp5MyALQ9h6I3EUPv2rlwIT85/IggVLA+nivs8h2UlkJKSVK9vJSgTXWruDe7dTsIr6qBmrFIs8o5nXryRTlLgrLLl5nMn5j1rw1zK4tuFJEz/Ydv8iVZqSv4l8iUnS0hRIYdgApWbdrCEsUgie4YgkPMPJdEpBsW1JYYIRP8EOaNGMaf073mSdMFpelXZm8XThTE5IQRzi71BpX6mawL9kavafYikJeZYCxa6vtaNgKhYHTguH1gm2T0ELWEMSFnVhEex0e6YLLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewOrR5uQw7Oire5ntq4mW7GNujz9qlsP+tWKn1GF2mo=;
 b=nRI2G6zjPnlHNv97YP7wpQobiUsazqiBZD0B782YIvPx5eVnmGaxMbLXrRCxZdSE942nTe/5lBMxcDjqWf4WzW3wV6a/i1M2+25SEVofBaStO/DyntcjB8rK2GbNeEVYeA4LXpRlSSAIrX3jy8GRHs9gpDHWGyVEz+5t01OBeRlUg3WUE6vRgIdLi0tyvv6Wca3Gpwhl5VK8+tV/8043gAxgZORACJE/2GSnbxOO3CKFRXjTEmcJWJwgEd5EOyTjloMjku8AgjsI0+G3CnYBHRYkB1liD2Z/WIfrhCGBtsDg5NzeDpEJjZ77veMsJk5+gN0FYQ4ijySDzRqrKk+vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewOrR5uQw7Oire5ntq4mW7GNujz9qlsP+tWKn1GF2mo=;
 b=BIcfarT3T2YzDDcgBIeYUVXujJ+G3/yONs6rmKytd16AWSqtCP4cxqFoYsDa+j5hNRqlB1ppDYXrsPLAnaYx9P1yLpxiNUIvONJwZUZFEUIzTrgyYyoSjEgVdMw4+ptxGpRcYmF3Ryb9F2m330ictXkytgrw4MP9zrcI5AydQfXVlIr81qGlFEUajJ4ezObxXcnN/kqKrP9IHJWwGzR+7P41dTU5HlSEiwAqdKxAJgW8Ucbkm13//KkkAyK8PVRyZrFf+uTE4Jz8KLh4nU49oNSRgXF0WbfOu9oJ1pLCDhVt0xf0YBixSqV2/eycRk8fe/qyTp6zYlxsidBLilsXnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 16:00:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Thu, 9 Mar 2023
 16:00:03 +0000
Date:   Thu, 9 Mar 2023 11:59:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAoCf9+kpMof6R+4@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <213a05ef06944a55a148995053b187f8@huawei.com>
 <ZAn94BXkjiJKQ66O@nvidia.com>
 <39979642ba8042ba9d4de651fecfeffb@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39979642ba8042ba9d4de651fecfeffb@huawei.com>
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a7023c7-2208-4b2e-44fa-08db20b757c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGqpJ3KBXISkn3Qxe4nJVH5BQdMQXLgV+IChQjW7uLkZLKO3CZ+F7zijM+a/makrD3fiidYhDTd6eYhJFfpwPFZ3/swAxVnhe0xakk06ZIKFNIm21R7tzBamEC2w2sWadYoYIpLhUKXGAmSVVhmfuY3NAJQ7AOqpIOHz8q4+wXa/5oRHsn/Fdp3RChskj7WS920z0KrtIuJDJkKydikEHGcItJePOeLmyO8wipq6kMmZI/+MnFI1gVeij9ltOEOOAckChL+eDTte9WbqiqKeA2Kix6xdDl4n/oDqwZSKdk585FdDeSRoLtpLqvCENR0057Wz7VfyODryW1eD53gxaH1si6dzbL2vwJqjO6dDmQhVWCjvhRIege+cbpdUA5SFfuj7vL0uWsSCVRgmnlqYqFhi3Mv4iJl3mEqraFNcYogvBcxEtZTv19mHSokpSyYhKgcffw8kSPk2C48bEAyWKQFoUkNmbGH1GBn8RmJwaH+zhEdksAUGTIxGXrFUx3+8tK6SbD/8dDZefJXl0oax00SpXOqRx7GzPHEZXAE5gBgq0/hQKaYvoFbMhosjRKS+FbvXiidz7daCoalV8OFNTnqyWIBH9VRgoDWxC3Fsjleh8l/CVuPal88AlC4xhOPSdIU2C84LAjctKvV20hE81g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(316002)(54906003)(36756003)(38100700002)(6506007)(86362001)(186003)(6512007)(2616005)(83380400001)(41300700001)(26005)(6486002)(8936002)(5660300002)(478600001)(6666004)(7416002)(4326008)(66946007)(8676002)(2906002)(66476007)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bLkEbdodkOzRw6uMXNWnfrDiArjJ8pxfiSMeH+7NWkwy8KOeJnFMBf2P1DUx?=
 =?us-ascii?Q?YOtKA1wc2LkslnYs+NMXTwdl+el562CmHau+J6he/wskOlCtKCiHVD96gBPK?=
 =?us-ascii?Q?WJm8xpNVCqjd+XcXzzbASnAB0/BFHWla2gEmRi7CkA0oxxSrgNMIfz/giqj3?=
 =?us-ascii?Q?/MQ2Prtc9PcYyJoWH4AGh2BMrED9QddQovACZtIMIMHFKRl08QC3gFMdsPTL?=
 =?us-ascii?Q?HHQ0js8D8tlOon9oas45Y5gxl6tyGu+2mr07lyFrGiBIxMs8JPk0gwxTlUaw?=
 =?us-ascii?Q?GhdvRx6HYCmHRRrFcoX0YS5xyAccqOUlKYbK3ioS4mDMZd1pUg4Klb2xyzyd?=
 =?us-ascii?Q?ibQgIjbb1V6cEeqEgwxStGs9Zp0seIP3ZpWSQVVtdKqDR5dqW8TwdwK2Llbt?=
 =?us-ascii?Q?Ln72coK3bbRKZYx3xBhCZmvdQzRgnQZFKwjRKQocgzfVVxdDkKYiqDWSlkfl?=
 =?us-ascii?Q?jh6WHHMz3NS7V1gKMP8PuPjiCNAt1c9CHVH0qassZoXoMzMgMgiGb3ZGCNAp?=
 =?us-ascii?Q?s7REt3+SqzCk127xCkgzAEKYUIafp7qsJ89DVzfQFNOYPRvVTTGWdshu7KWV?=
 =?us-ascii?Q?CqWCKoY1jBORAlpO9dv7nz5tCgK1Hz5NPhwp0NxZXGGo+G1TIStdg+ntCNRT?=
 =?us-ascii?Q?Lg3bo0lDBHqocwWz9pgi1+u3KUGOgM/jhppL61uP7uQvpYNeSgX+pswGhDVo?=
 =?us-ascii?Q?4bL/+3MKOHwkFKeCUsZpbbvI92JwqDMCj8ilSi5X48LbTiMoLHVxKMAhO9/q?=
 =?us-ascii?Q?k+R7J4AOjQldHkyHXbrJM4xGdX812weHUI6Psn+rbrTvJ+kh553Fmabh4Q06?=
 =?us-ascii?Q?dE62coO/XZhZF2TuixZskGnO2HbWu8RAfuarut39Eky+cumuYjS7VjqDJKJu?=
 =?us-ascii?Q?9xmh0d9pxOU3VpabR9uPjG26j0ltkvYngUR+ViXQWv2u5oqXBi6a342rX+/r?=
 =?us-ascii?Q?d4F3pkDnvYTikfLZGmo8InhIg1/j/pwofGL9ELtVOs4WrRzZuRmeKsI2kWyc?=
 =?us-ascii?Q?cSBktfv0m7Y1hyaAM+nOucFuE0TFgeEtNWF20xeuFMkRLT1ClK7tjucc6gWl?=
 =?us-ascii?Q?iE+cydiT3yLdU7xKysKryfLnyXQJpNp5hKxdqaN0/bR0nu4cRDI77KQhwgmV?=
 =?us-ascii?Q?YXML5AtcKLMSVMVqky3a4CRYKAa/Ho5CmDczynz+AxscrMP4aACkyf20LDeX?=
 =?us-ascii?Q?CCI0qFD5KNLAIo1+0r9sMzGIC7BJGgZktSbxw+yT7yfWv/Ts059xLNI+mlZg?=
 =?us-ascii?Q?ENi7t3qMmOMm010Xt3pupDPQZcMkDgcb0ZcyVrGQBxN0OQ3SUPK8kBi3K/90?=
 =?us-ascii?Q?N4uSvX5GBsQwlHKcOYv5GnvfLXnYtjypE8DPPwi9qvHHi+kvpb5ghuqCw6DW?=
 =?us-ascii?Q?FarC//dvQ0jHN3q0FNoGZAJi8lBigABewpP5fq8mQZVKY4zuPJgH3b+/iu4H?=
 =?us-ascii?Q?f4LclpbWUwVn/7auob+bXVBnHDua8vtgPxcLoEDU3u+mB2fFD1SzJwzl6HrA?=
 =?us-ascii?Q?uV+eMB/XhkvGDAYvQr/iCz+/ur6RYPUtJRDdiUWDohAfs9U3tAa5cfGl89iE?=
 =?us-ascii?Q?Rttc+aTyAjQoeB77SI9kNXATfmPKVPasH7HCtztg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7023c7-2208-4b2e-44fa-08db20b757c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 16:00:02.7997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7rwiOWg0utrfWVqNSHXgswJ2LXm/JecJCJC4LkDx84XARqyFU6G5BlvyhYTtiWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:51:42PM +0000, Shameerali Kolothum Thodi wrote:

> > For ARM cases where there is no shared VMID space with KVM, the ARM
> > VMID should be somehow assigned to the iommfd_ctx itself and the alloc
> > domain op should receive it from there.
> 
> Is there any use of VMID outside SMMUv3? I was thinking if nested domain alloc
> doesn't provide the KVM instance, then SMMUv3 can use its internal VMID. 

When we talk about exposing an SMMUv3 IOMMU CMDQ directly to userspace then
VMID is the security token that protects it.

So in that environment every domain under the same iommufd should
share the same VMID so that the CMDQ's also share the same VMID.

I expect this to be a common sort of requirement as we will see
userspace command queues in the other HW as well.

So, I suppose the answer for now is that ARM SMMUv3 should just
allocate one VMID per iommu_domain and there should be no VMID in the
uapi at all.

Moving all iommu_domains to share the same VMID is a future patch.

Though.. I have no idea how vVMID is handled in the SMMUv3
architecture. I suppose the guest IOMMU HW caps are set in a way that
it knows it does not have VMID?

Jason
