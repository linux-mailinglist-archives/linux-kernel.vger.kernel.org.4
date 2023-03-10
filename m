Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8332C6B4DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCJRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCJRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:05:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A99BA5CF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOwchkT+lc9ib3tg2JcYsiWxNTJrelFmuqWL3GbM08dVy9uytXzMTNxnQNpnwyTt8AIHgBGFeCd3JSjsuHT6V7zzJcH921mBuaX+HNajBN4IzmCqSJ/6HzKlmUR+72O9vrWU1XsCyW8ygi9bPCZYbb+VSexaN8eotRPiMUlVh/dPM7VKpjFtUP+ER/RxABOiKmLhsBQzwqpA2LXkxYZGozvAD06GBGJb/JrBpzz3eWU2sB5aexEF3yq4FRWn7lHWv4/BSJ6Sz4+UAarwkkUdztwv0LiV90ha5ja8U2FzX66rUj4cakrC93knfO41OZa5VZL8LrviGxQDEqdEieVW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mTxJFoUeKQnTvmi/3T/2s6GjKqSHO0wqFtJ0gMiGrc=;
 b=BJXM85Wu4/HAUoYn+U+UPh/LJt6qQ+QkoWVnELDbzk6ELTb7PA8sV3od5Eu+05vk7kmPgxcEutrZ6XvdSDNbqz6ISoafHYeFDabhcWVKoyALBR3riTONdWeB6/vX8XfLnXGA2dOPDSPEdcBHGl/YURoiuhxvIw1wJzbAkOL49keRKfbUZd8wvW1KjswFQeKSPVMmDgJc+DccmauaU9bzC4jEmNTRsLg9Prl6jqs5uTzCh/OG5dgjmMIxP3MLxMAhKo8SDTSGAC7O5I+fKhwDuX9LbQpIUQM3oy6Gb5R0tLtib8hBsCuCOXs5igykv/nXXh+k4QNPtLVpFxY62MOcwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mTxJFoUeKQnTvmi/3T/2s6GjKqSHO0wqFtJ0gMiGrc=;
 b=DAtNUVB+W8pt8siPEWjmIgkBLYKCH9kMq+Alujz7Be/+Bfv0zuP00PGYbcluZEtUHUTQmPVE8s7HCPKO6v4wparzGX7uSrX/MBxUsGgCX+qpvL5TnroGk0rwCzLkhjtGZazOwG50jP2u1pPyx6bi4utcXbGTqTkaWtRLxRbMnLu07RaKPPH2cJ0km3w0TpgEw86v2KuMU9OTGejIozo9mFBcK/Kq6p5jOdhCha5Fj9B0tx1fi42uYrazCU+iHb6qZZiOtHBm6vTZ0s4B/9n/vC+I8prD5lUlrkq0zbYudslquVbscD+HspXxzgY4/e3ykF1jivRBbdkFq+QftEohcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:03:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:03:50 +0000
Date:   Fri, 10 Mar 2023 13:03:47 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Message-ID: <ZAti8wy9wXwtIqLT@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
 <ZAtNrFAEHvmM4FOW@nvidia.com>
 <f61ca5693d8845eba0a2139324e52d98@huawei.com>
 <ZAtTNK1NbMJ4iyE0@nvidia.com>
 <b9e850a91c494a5397a0ae154e9ef1da@huawei.com>
 <ZAtY8S53//5P5egd@nvidia.com>
 <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba7f4b9f81264832842a6c7486cb6dd7@huawei.com>
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ba5026-367c-4f22-2016-08db21896b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xXKC9Axgsn4ye2RYhI5r8IBGKNo0Num+toqx18VNdNCcqRxTlG7xp/6b+BUeMomfLQw93TK4YcicXkohQ6n6byBBqWFpSoCVoUvY90GGuTHELiJlCcxNEcq5jAAwX6U3eGJ+2CuYW1ay22xUuFTPIQjzeRv0KigoUPI+IQwofxx+0NjPxkrEEZCgTXNNFO8EMuCAoepdckHtIqEyVELIwUNRErUny26127SAOSgbat8yCmw1ipCiELoLFvd5+5HI/QTmX7f05unWnMZxYA7lGQBB56HkOd9zreyuGKobmlyAIKs8+T+qos67iCDIOOmxKzQEWgHG514Ry09uBS+otIuLAaD7zfmWJ+slCHfHdRnVt0/wD+hia9uOSg99B5W99AgBX7Zy/GsWrO51JL77XTM0XkOFw800x4DFCGVb5gHwW/sD7wj0qYILskEABUwO0CCHU7mVgizruGrL8uyamKxO06d2eBOKGbspfptyST0FDdkTU+C7MpoxPU4Yia3gklnIrrIzc4kL7sMQL9uK12OjDjJ1X9ytDnLLbmpQkpBdajNP0clfT3brANM/n4V2ssI3NbrM1oC1hiSVMJYJD77cFCkVlvuX2VE6Q2WPxWlwhlz7rl1c1RnKHt5P1iCrznSBl6i38+0X8LoqkPjiMinUzKXhWKd8RTbSkibQk7kCIWMDAHteI9duLr55Ii6/DksO7UFtSsQlnnvMyEZIeC5VaE53r7trw1WjU+1LAdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(86362001)(54906003)(36756003)(38100700002)(6666004)(6512007)(53546011)(83380400001)(186003)(26005)(2616005)(6506007)(316002)(7416002)(5660300002)(478600001)(6486002)(966005)(6916009)(4326008)(66556008)(41300700001)(8936002)(2906002)(66476007)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQe+cRxYQz0dkeoztbJBDuCkoO12Z8dHDEjc9GiWLUSzX+6x4Njk7va2sCFG?=
 =?us-ascii?Q?mccyuG5NVHjgXWVBpLQwYzDakIG0+oF2TCPNCdeulu9zzPVnyq/ufEZR0Mmy?=
 =?us-ascii?Q?mVsG5SN1f82i5mx10f3jpRoOL+yGc81DgO43ZOXf74O9sW7n0478EleG90K6?=
 =?us-ascii?Q?o5LoshrtJhAauNzQhoZxiyzvz8comReXoYICIqZvI57p+aHHeNe24t6Z+Hlh?=
 =?us-ascii?Q?Ua/SyNT4rAWfdHaZV5pgo8KAct8ZQrjMgKWfxsTPFvpQCrv1+Dv24BvOEjl/?=
 =?us-ascii?Q?T7j0gLcoG6u/+hW5BcqMmFDxKZg1lyzEdJ+QyVWNfwg0MPc77sJLIqB6S/mz?=
 =?us-ascii?Q?Ju9ocStdEXkEJTRLzRTyptOqbDoADfC3864PNYZWbbq8GhvG037K9CA1Ruez?=
 =?us-ascii?Q?3rJ8xlMUOMXKDAIzSU716bGHM/zM3z3BXQJ38NAc0krTuONLl1kFmNLBsy0Y?=
 =?us-ascii?Q?iI5itYEqbsvivkEFtabGLpJZL9NghjREteZAUI7Y0dspzwb2ujDHBs/3xMh3?=
 =?us-ascii?Q?UoNmIATbRHxqo194wNxz5Ze/2sz5QV6a9MOcR4rYpU3wOmYlY+Zi5ZQAYk1x?=
 =?us-ascii?Q?J9ZjMqY6YWxow9eMv7ua4m5ZBO4AbqhMqcosfzRvywl4tiYLgDjVV2M90T8x?=
 =?us-ascii?Q?RSNWMksA+Xi8t8Vuy1FYW/8hmxhUqtVlMWxeeNigFUGs9oNPZDSA5n11g2Kl?=
 =?us-ascii?Q?f3bEQTeh8MGaAHLqXFxod8WYw570x5+Pqd4bIIQxxR2iV9epq3Ew9rHqtFq/?=
 =?us-ascii?Q?8j0kJhXHlAQ+9yXLjQnbxPlEj728WP4trkQKLYECqTaVXGPUdinYqDBiv/UE?=
 =?us-ascii?Q?FhB2k8IwWKadSiHZE+K19lPVdp3rk76O5VBkn2sFIE6j0g7Y9qbJjKuB/mEH?=
 =?us-ascii?Q?rkXxlbznbHx4e79ODh43ETVZHcaOFoPvF0oMEX6mEnqaUyDroHQNjeZ2p35E?=
 =?us-ascii?Q?5n9gSgbiGhNUlZQBghPTGPt8riM0MxCRe9anMZdZ3YvPcH+j9rACH+Y03alb?=
 =?us-ascii?Q?TnJoVhwf9Tby7+k9i9cKOA9EeT7CpVeTiSiRGt+naCR3IES0keaYvpPaJPWh?=
 =?us-ascii?Q?AKYRKENxx/4O2J0StgfEs3RVaouRaqsZm7a2OxFbNqP0Fxgzx03AfJJpSZ3k?=
 =?us-ascii?Q?mYelJovzgXQGIEIP0gES2o4QHzu+bBGs83XnTU2goS7sO+wZoexRlt+EJkNW?=
 =?us-ascii?Q?S1psiYUYJkWbL+Lx9W6nkNqVQe/GnT0hpskK2SddCLMEqLeZQi0iKG/hbHIy?=
 =?us-ascii?Q?eY375vN2AwQxiz8j+rA80bMUZ4uSFv6xJDLFb8tI8lxxpW4Tnir0ifdr07cV?=
 =?us-ascii?Q?rwH0qZMCCgrby+x5WVgQ3N8SVtJoKEwRITPXiuXXMz7JERYR7IkP7ErPbfny?=
 =?us-ascii?Q?PyTED2Yw6b4d4ve4DCfJxsWwbn7ww8b9EckXZH/8DTxH6OlsHu8iYz4YnVSD?=
 =?us-ascii?Q?2Ojqyqg9tIfBblHTTBBICBhvoFGzexOIVgfJhKv1eDNDIIY0PNk8R3mlJQK/?=
 =?us-ascii?Q?aZYcsKMFuqj5WUUAZXNoaw68Rw5iHWjIkFT/dxYIz3jtK/rQCe/xFJvLe3o0?=
 =?us-ascii?Q?3XwT8XvXSBmPlf9vNLt8ymzalo9HZcnVnXZVEINk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ba5026-367c-4f22-2016-08db21896b9b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:03:50.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOiDvzpad0easxF1igdp8divV+MYRjwY+vq4ZarXwXtq0RfI1TEVl6gTZuDbs7TY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 04:30:03PM +0000, Shameerali Kolothum Thodi wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > Sent: 10 March 2023 16:21
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: Eric Auger <eric.auger@redhat.com>; Nicolin Chen
> > <nicolinc@nvidia.com>; robin.murphy@arm.com; will@kernel.org;
> > kevin.tian@intel.com; baolu.lu@linux.intel.com; joro@8bytes.org;
> > jean-philippe@linaro.org; linux-arm-kernel@lists.infradead.org;
> > iommu@lists.linux.dev; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain
> > helper
> > 
> > On Fri, Mar 10, 2023 at 04:07:38PM +0000, Shameerali Kolothum Thodi
> > wrote:
> > > >
> > https://lore.kernel.org/linux-arm-kernel/20220420164836.1181-5-shameer
> > > > > ali.kolothum.thodi@huawei.com/
> > > >
> > > > So "boot configration" is more like "don't change the RIDs"? Ie don't
> > enable
> > > > SRIOV?
> > >
> > > Yes. Don't think it will work with SR-IOV if you can't guarantee the RMR
> > specified
> > > SID.
> > 
> > So I think we are probably good them because vSR-IOV is already not
> > supported by qemu, so it impossible for a VM to change the PCI
> > configuration in a way that would alter the RID to SID mapping?
> > 
> 
> Provided we fix the issue mentioned by Eric. This was discussed here previously,
> 
> https://lore.kernel.org/linux-arm-kernel/bb3688c7-8f42-039e-e22f-6529078da97d@redhat.com/

Ah, I see so that we don't renumber the buses during PCI discovery..

It seems like Eric's issue is overly broad if we just want to block
RID reassignment that doesn't impact MMIO layout.

But, still, why do we care about this?

The vIOMMU should virtualize the vSIDs right? So why does qemu give a
vSID list to the guest anyhow? Shouldn't the guest use an algorithmic
calculation from the vRID so that qemu can reverse it to the correct
vPCI device and thus the correct vfio_device and then dev id in the
iommu_domain?

Jason
