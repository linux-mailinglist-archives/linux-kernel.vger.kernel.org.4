Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE286C54CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCVTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCVTVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:21:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EE462FE7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 12:21:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIAuYREY5uOrmWsqDW+tiSIfWj0acpNH38mxDBu4T3trL9Y4sgda0ZMrqDU5I0PPgE71MBaNOjy162YrEUcpmWRlVpzNhhwIpQ0LRpS/I/0WnThfrCKgpcuwiuCn9rgIVJndfKq2I6vJrtFndzFjjDaKoQaQ/5yfvFXXtGfXoXJtodFjv23PW6X1tbWfpjOtQNRBJvgk0Gp1X3sSrzmA/jbUwG8xI2BrlES5SbsIPFad7cobqv0ytAANTRmET0kKBpmgHhbe5G1wyAKhCcYijDi+uhNiBuFDbfBr5E3wGhi00VYepkA7w2Z2+buDdpbcG2iIwC5RAFjN0OcTvpjBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbY4GvLK8fSNI5wDmjGUsvQHr2ojjqsM0a1zm/zhns=;
 b=N+C6N3/5aqzqQuKrIkfloO81wDsKVqs9/cEmCTk1khmXoJdKBa0K8sJULwQlPZqJO5KzQfQD0OrIXS30+HHhOn3efouBixY85Z06z9v7Hzs7rUiv+L7XABUFMjkGNkZXv8TAeJ3ruUP9/ypmSHvmJBHZ3leIV/F2YCtDf24hv93R9ZVbAtSkD5cXpXQYKY2TwybUFHa5IPnM7IlmH4aodiqYZzW+koIz3+e/hvRG9hOM2/fx4tTvjNaifsgUAJyp6DTD5iGsYMlHAm8iZN8Za03R+s/+EBKzJGyTaQ6sOOTzEwXU4409FZ1B9joOY6d4lSfdXZq9PWfz16c/4D3U8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpbY4GvLK8fSNI5wDmjGUsvQHr2ojjqsM0a1zm/zhns=;
 b=pkS0GaTOGEGx00RAaz8qiU0GQn03k57ZJXEum6wzBktGoOZ9KCwoq7NUuqLwpbWPp1SgMDt/G7E4is4NqJmkdBroC1hmzJTGqzD37/u7SN66FtMflMtYSMv0mjh6qTMF46MSKxEA1Op/vR8CvOUPEIcavfcdCDfAnwtITmmAVyfWN6bWsGtqidIdnKKHi5TuW4DcBufut9TctZ381kEHW6f2kbU9UIbv8KYfFszcRwRfeWRv0Xu+E4Kxnf5/uj/XuIn0BWWGZthw6acX1KmL7PzPiw6jPwYZLewPnJe41RG3L76YUpcfMryuqP59FGNfRIPZXcXPbiHmsZCc4DtJAw==
Received: from BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) by
 PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 19:21:46 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::d7) by BL0PR0102CA0007.outlook.office365.com
 (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Wed, 22 Mar 2023 19:21:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 22 Mar 2023 19:21:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 12:21:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 22 Mar 2023 12:21:29 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 22 Mar 2023 12:21:28 -0700
Date:   Wed, 22 Mar 2023 12:21:27 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <ZBtVN4o7GhjHF5Q7@Asurada-Nvidia>
References: <BN9PR11MB52768F4D3E21C5231C1A04D38CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBhYq8o4gqFZVb6k@nvidia.com>
 <ZBiF1hZVrp/aJRM6@Asurada-Nvidia>
 <ZBifWkY2Lt/U1Z7R@nvidia.com>
 <BN9PR11MB5276E6E3FCA90582AA61BDDE8C819@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBmZj2pscX0hx2kQ@nvidia.com>
 <ZBqjUeEjjtCclgLN@Asurada-Nvidia>
 <ZBr3/1NzY5VvJrJQ@nvidia.com>
 <ZBs2xaa7Ow1pnB3C@Asurada-Nvidia>
 <ZBs6xlqMGYhLbI27@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBs6xlqMGYhLbI27@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 070f8469-1f9a-4ffb-e384-08db2b0aad97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGQHjZHIjpdC6brptJ1cKSSjtlcQlclIz1Kd0cPzmhMEVC2xuws2mzgXnsawgA5CECnlbq3uWdRUZVZMDfZ9L1v5ShXhLGkHwISedA8JUx9/wIdP4HltNXseDGJ6/ZF/koaqc+WaLDScdoJkwtmRier3Q6iqrtLM2VD+JByXpLz3mVJPVRfqKa2jeUewLsy9uxRpKiY7FQ0FniIUyOmgl9mA8lXmWID0VKGfFASc7V1mlxC+Kg4m25+020KccpUnUj64KE+VDd6qYvHxtyzAhKkzfxRifKSR/5DBq+NIw5yiiC9clvKqJ5qX4uNOxs9Ah1ELVpPczdDO3dTV7sYmxd+EJl7Mwl/vM1jLaLoEfcYCHqszxENJhv5uxWLFlLs7za9JkGU44d5IPfdlR1tr0ri0PV6l+AbmrSvrxwxWKr0q8H38jTi415xCPgdV6z5Wopo9rqFwh9g43t9y9OpT/cHhrDxQaXKomnQHCd2szQwYAh0jm5UBbmLsPe5oDec2of+5hAX0JliW5RStc5HKCGpQNTSmUvclqUr90NSrqg0rMR9vNnSKWZdMu0Rsr+cdFK1K17giL4CZBTOHeJPBlWnGDwI9zj+PTZLClewFUr1/8twW06/XuddbtfobLpRixcpIeaKK4uJ0lqEAbc8xGOUt7RwB5Lx1KiMEEI9REHp0WPY4T/2H0Qc6EhUPygf0cnUAf5LX42GlPBntOwqBFN8e1TPMx8uQKwr86kXfm78=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199018)(36840700001)(46966006)(426003)(47076005)(336012)(26005)(82310400005)(316002)(6636002)(54906003)(478600001)(9686003)(83380400001)(33716001)(86362001)(186003)(70206006)(4326008)(8676002)(70586007)(36860700001)(41300700001)(40480700001)(8936002)(6862004)(5660300002)(7416002)(2906002)(7636003)(356005)(82740400003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 19:21:46.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 070f8469-1f9a-4ffb-e384-08db2b0aad97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:28:38PM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 22, 2023 at 10:11:33AM -0700, Nicolin Chen wrote:
> 
> > > Yes, there are a few different ways to handle this and still preserve
> > > batching. It is part of the reason it would be hard to make the kernel
> > > natively parse the commandq
> > 
> > Yea. I think the way I described above might be the cleanest,
> > since the host kernel would only handle all the leftover TLBI
> > commands? I am open for other better idea, if there's any.
> 
> It seems best to have userspace take a first pass over the cmdq and
> then send what it didn't handle to the kernel

Yes. I can go ahead with this approach for v2.

> > > On the other hand, we could add some more native kernel support for a
> > > SW emulated vCMDQ and that might be interesting for performance.
> > 
> > That's something I have thought about too. But it would feel
> > like changing the "hardware" of the VM, right? If the host
> > kernel enables nesting, then we'd have this extra queue for
> > TLBI commands. From the driver prospective, it would feels
> > like detecting an extra feature bit in the HW register, but
> > there's no such bit in the SMMU HW spec :)
> 
> You'd trigger it the same way vCMDQ triggers. It is basically SW
> emulated vCMDQ.

It still feels something very big. Off the top of my head,
we'd need a pair of new emulated registers for consumer and
producer indexes, and perhaps some configuration registers
too. How should we put into the MMIO space? Maybe we could
emulate that via ECMDQ? So, for QEMU, the SMMU device model
always has the ECMDQ feature so we can have this extra MMIO
space for a separate CMDQ.

> > Yet, would you please elaborate how it impacts performance?
> > I can only see the benefit of isolation, from having a SW
> > emulated VCMDQ exclusively for TLBI commands v.s. having a
> > single CMDQ interlacing different commands, because both of
> > them requires trapping and some sort of dispatching.
> 
> In theory would could make it work like virtio-iommu where the
> doorbell ring for the SW emulated vCMDQ is delivered directly to a
> kernel thread and chop a bunch of latency out of it.

With a SW emulated VCMDQ, the dispatching is moved to the
guest kernel, v.s. the hypervisor. I still don't see a big
improvement here. Perhaps we should run a benchmark with
some experimental changes.

> The issue is latency to complete invalidation as in a vSVA scenario
> the virtual process MM will block on IOMMU invlidation whenever it
> does any mm_struct maintenance. Ie you slow a vast set of
> operations. The less latency the better.

Yea. If it has a noticeable per gain, we should do that.

Do you prefer this to happen with this series? I would think
of adding this in the later stage, although I am not sure if
the uAPI would be completely compatible. It seems to me that
we would need a different uAPI, so as to setup a queue in an
earlier stage, and then to ring a bell when QEMU traps any
incoming commands in the emulated VCMDQ.

> > Btw, just to confirm my understanding, a use case having two
> > or more iommu_domains means an S2 iommu_domain replacement,
> > right? I.e. a running S2 iommu_domain gets replaced on the fly
> > by a different S2 iommu_domain holding a different VMID, while
> > the IOAS still has the previous mappings? When would that
> > actually happen in the real world?
> 
> It doesn't have to be replace - what is needed is that evey vPCI
> device connected to the same SMMU instance be using the same S2 and
> thus the same VM_ID.
> 
> IOW evey SID must be linked to the same VM_ID or invalidation commands
> will not be properly processed.
> 
> qemu would have to have multiple SMMU instances according to S2
> domains, which is probably true anyhow since we need to know what
> physical SMMU instance to deliver the invalidation too anyhow.

I am not 100% following this part. So, you mean that we're
safe if we only have one SMMU instance, because there'd be
only one S2 domain, while multiple S2 domains would happen
if we have multiple SMMU instances?

Can we still use the same S2 domain for multiple instances?
Our approach of setting up a stage-2 mapping in QEMU is to
map the entire guest memory. I don't see a point in having
a separate S2 domain, even if there are multiple instances?

Btw, from a private discussion with Eric, he expressed the
difficulty of adding multiple SMMU instances in QEMU, as it
would complicate the device and ACPI components. For VCMDQ,
we do need a multi-instance environment, because there are
multiple physical pairs of SMMU+VCMDQ, i.e. multiple VCMDQ
MMIO regions being attached/used by different devices. So,
I have been exploring a different approach by creating an
internal multiplication inside VCMDQ...

Thanks
Nic
