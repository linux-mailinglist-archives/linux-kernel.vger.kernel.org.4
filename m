Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E26C24B7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCTWWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjCTWVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:21:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D4936462
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mugHdm4NJybmbFH8MiX3xllqM6DgPuayj4lUwQb/lCZVnOynYBSfb1CP8iy6jsNk8BU0xreFhkuurzWw/mpgVj9RHS1j/ls58TkeRrraqjbX1i4x09AWLZPJDGg/H6lTwSKOQoRQ7XhgTBeaPqDbtxb9Ibxtf3lzgxdM4l4Jr8t61P+VHvtK1VQBT82sOBewZEl8+HNjGd20psqcQxmbXUyXxYBLH1o9Z/14g1ennm4FuauzymDFAQyiGUPki+pFCA8t9kLW24ODYFPDnkDf9WCxBqNZKt/RO4gzGIgl5pAVDgzIb5tr6nyVDdob7StcRBhHfE7ukaGd5RLjxbGTFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0SEglbUNmUyiAMDpgYdDy1RYvv3GPeMOplBrhzUpWg=;
 b=BBVXugtL14kJGpDmAOseVWMXhAuczYp/BWcDy1FqPsRJwVHgOlpsZNPhKTDm06kGKVqnIJHK7NdpO8bKZxju4cCgiqiVUP9mIYjKnt0DPym2rQHQTwtBPO26xnU2u6rZZrhgMFOyMtDqXrJcN3idAlkKBxqT5LKKCzeg9/PqMe35B+qJx8cGKbRB84dlREuHDBbTnLQtjcIrjAPgSzh/iqM0LRY7vEMVRLO6OPGqVBC5BxLJGJT47GnLJ/eOxoyOAq9XhnVFhzfWroMfJY0jo9a18EXdQ4qX1mwmImDGr9QM3GkTQN4oDY4TOGHgRVeKf6KRgwgHdB5ozUzEeI4FCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0SEglbUNmUyiAMDpgYdDy1RYvv3GPeMOplBrhzUpWg=;
 b=FV8kjLlsQNMs3h7v7mgeMNNngI6zW0u9NKHEZmpEzSAfDhrlxXLzns7vO4DJMQaQ8tGtoW8LY5qUaREaMpVhE0xgCGlMhOfvnXMgi5Pussy37/UuEpeT6vaP2GMAm5DLQqyUUjkKejuAAxMzvQA6p5lBDgFOVt1cxPoz4JOQzaX+pZo/3/5PkeYyO7nMSxS0+hOSP+zL1WYGtIdJWHhhqhKevcS0a2UU3hF+ADIteiWsBuSTo9zN7aBn9x+yByBe1XvptuShesDMlTBVbCM0AUuxezILSSgnK6VM9Y1SfXBGvNiVyMCIRuW1LWH90R3oyeCfleoCVZm2aaH/Us9v/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 22:19:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 22:19:36 +0000
Date:   Mon, 20 Mar 2023 19:19:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Message-ID: <ZBjb9sKkAddFmtOU@nvidia.com>
References: <ZAn7uC9UweiNdGkJ@nvidia.com>
 <ZAqv87fjbdynVaHA@Asurada-Nvidia>
 <ZAtYphmOuEqQ1BiC@nvidia.com>
 <ZAxsgjuuG3ziqs9E@Asurada-Nvidia>
 <ZBhZiCOQHAxEaamy@nvidia.com>
 <ZBiCEAqP1OU5EvoG@Asurada-Nvidia>
 <ZBiEE+QLjPpxBjkQ@nvidia.com>
 <ZBiRAVROma5/Os2S@Asurada-Nvidia>
 <ZBip4sbxUQo8RjGv@nvidia.com>
 <ZBjOooJZcUf182ES@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBjOooJZcUf182ES@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: e748c4d3-7967-4821-281d-08db2991305e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqnO7KT99D9q5ycXFR2PEbV/xv4ZmwcCISGSClMbrhxn0X3K/zjc/2x7QVFhr/GR7YP1MiIeNuUUiJ9edcYsGlB0XQ2P8aeFFDPGKHjW+I8/+zsuuAf4NZVYWBBNAXVt6Ktslb1R6GplD2Hl0UV7BZE3FcM5kMUWJQYRI4eDO+ZlJalSAex+r80gcxLxpewsUPjltizeRCjUy0+z+y5vMYuNGN7ltz1gOnAJlCxr/BLxmXExaQgHk7m43Ld/5xqYCOOzV6tIqdsvAfOpIFzMUcombHF6xAOmifr6SsL5W9GZhTg86FS1XDNlCTI+YV37onh7lb0cU6L8InwS+RWLg0raKQeocsSX5agNYAPlv4KH5Tvs2TaNc7qFd0wJaqWkv34s1swC8IU3uc/OX0qpxcI4+SgAO8UNWLprDjckcePGq/FoySbZlWaOv7b39hdTjSAhjV0jCrshaxbV+Ab2Da4UxxWrY4ZM8p3+T85Iu9Vez+LklyB4ORxXdghetWyn39cKG2Kd7pnBU557rzdJQkypMHFfcL4vupRj8STKcVgU1jDFPZ2Fuorkm1bWbTPpRLHkN7Gb6V3d1PO7GTtxOnBeDlbTvXhD//H5tzMTFeM2qpInHamUX4wXfYyA1JTpQLiu3xwnyAAEyfdSB+SVDKeBufeIrzpAaCc6f3iOhjZyWX6oKc8MG0gOpscfpaXkwZMRs8YubgnxZpagNp6bTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(2616005)(478600001)(6512007)(6486002)(6636002)(6506007)(37006003)(316002)(26005)(5660300002)(186003)(7416002)(86362001)(38100700002)(2906002)(66946007)(41300700001)(6862004)(4326008)(8676002)(8936002)(66476007)(36756003)(66556008)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8cQKnIyDEZW2nVnSTJDSiuWKcNRpgQJFxS8a6czB5r10mekoWFHS/SbmYHcc?=
 =?us-ascii?Q?SykMHO+hFnHJYjwYzrgoqEF3KYfNt/hEtGV43vQfsGPSsKKWQlFN98/4Nxql?=
 =?us-ascii?Q?hxdeXo3rOQj1OdgNjmABOOhBRpw4Wiif+TvdDq6YnpXcl57WfJCBSA2ioK4Z?=
 =?us-ascii?Q?gQ9hdUouO+MoGed7wwn/4dgJoGNlDSoHN2qHdvcIhXZhAgUwhgVK8jvJFI/u?=
 =?us-ascii?Q?zJjxCcR1t3Fh4deNcsVKkQNOS3uDIUYRENA8jhqaC2ttKfGARGA9DuugCLGD?=
 =?us-ascii?Q?4Hjuc3Pf6vuRwrGpoqWr1oJW1tGQ4XA4oJsJF0q8NbcWPYboVtTiJZ4qLD0i?=
 =?us-ascii?Q?4cjzy/ON2DMmvZrTgZ7mw1dTNgN31ipNrZbvOBVfVpmZOaMcvZyrtn+FQOWF?=
 =?us-ascii?Q?gNL/6xQPmhJ+MbS5OJlCG9zW9sRsQtc8k4B5QPOCAVP1sYcN+nf8gQ70F/6u?=
 =?us-ascii?Q?R351wGQf4UxpuXMe8jSwyMTDDJ9lsiz9OeQPkQlhMvjKTgIUOok/kvMBqaB8?=
 =?us-ascii?Q?81d0m0J9kYttWwTszapyDXL7pXnWUbMImDWsvBauAhGXz78frUi3EFycTLl8?=
 =?us-ascii?Q?beqbE//kjqU5BrwROdD5tjdsJm6jzOljvnM94Wmzvq6+dssgHAU23qxB4+XZ?=
 =?us-ascii?Q?5g+KqWRjBjduuTx1X9c+9Vjy6wmy/1e3cAC2aFWLSKGqwjxdVEdCdKiZSblU?=
 =?us-ascii?Q?xDVLHYIhY1Pw4MLwOXmApaDcSkE+LO3KUx3bazbavv2Fff80RdY2VD029/Qg?=
 =?us-ascii?Q?UNv/ivK7I5HU2RoDWW9+8L/mx1kzsZqU/ol12HQNSfO0dEurxh0SvZYTKZxp?=
 =?us-ascii?Q?2EhpkYTh6AP8KhudwZ6VMqzYXhM4fg6ohjmleCX1hSG+dytRUfpZM2JUouJ3?=
 =?us-ascii?Q?AP8c42e4fC3xkw1L2TN6ZK2qHEHuUDs86vowA8E97mlpN/L8SOZzkJzPBt08?=
 =?us-ascii?Q?CoKd5z2N12TKSY2Lp68EQsKQK6r38JKnK/HZZi6APEStfFUFF1jr6587yjEV?=
 =?us-ascii?Q?X9CzKQOLbrNv5H3hOzSGIUlT25WUkHBIK8B/DrcIG6ivFFSloK/JaRTDikLe?=
 =?us-ascii?Q?amNmLVOLSX/0dpbHG2H2TrxTcfMXqoK++nMMeiLiuNcIq1tDw4k1vRQTrLki?=
 =?us-ascii?Q?Ru+vnMHS3lgXgoZ7HFt+9p8M4s+q3ASVPIt8g5R7ZhzZI3UwqnkNC71R225E?=
 =?us-ascii?Q?4AldN3aWfH6+asq5306tXoVmJGP6i/JAMwxp9uZOzuLln9/QG+IF54W2N8Qd?=
 =?us-ascii?Q?4z62uGJ8ls+Pmkc/4+AoZHl3p+VFu8zASpFIaHqmJaZ/GAaNQU6MkcVTSrf8?=
 =?us-ascii?Q?stC679Xk8VaxB3j6VbEJtcMhzEVhzdrgqNDdsqknvxD/uhKMHY6xvH+6ysJl?=
 =?us-ascii?Q?PM6PNSVpYhOFSSdknXNr6XejUzknBNL58Sos/WE1Z8iHipqWffZBkzP1w3Da?=
 =?us-ascii?Q?lDgSQ3sC18xFtneBR8VAZ7h5El4GHq6PICJ1IznFWxK1wYmNCC+hW4MD+sKE?=
 =?us-ascii?Q?2FGgXb+iN+rZcqvzv91WRIjswKboHXhbE36uDTJI3Qxgbf/mXXOUyRRK+39n?=
 =?us-ascii?Q?9v+zIIhk0XF1LaTsmnS4pauQdwbqXdjmcJ4ak7fx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e748c4d3-7967-4821-281d-08db2991305e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 22:19:36.3093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2oB70yffUWAe1QMnSHEi516OTq1n+TyK5+4EfXgNqATikptggvJkV4LyybfMZ5v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:22:42PM -0700, Nicolin Chen wrote:
> > > What QEMU does is trapping an SMMU_CMD_CFGI_STE command to send
> > > the host an HWPT alloc ioctl. The former one is based on an SID
> > > or a device, while the latter one is based on ASID.
> > > 
> > > So the correct way should be for QEMU to maintain an ASID-based
> > > list, corresponding to the s1ctxptr from STEs, and only send an
> > > alloc ioctl upon a new s1ctxptr/ASID. Meanwhile, at every trap
> > > of SMMU_CMD_CFGI_STE, it calls a separate ioctl to tie a vSID to
> > > a dev_id (and pSID accordingly).
> > 
> > It is not ASID, it just s1ctxptr's - de-duplicate them.
> 
> SMMU has "ASID" too. And it's one per CD table. It can be also
> seen as one per iommu_domain.

Yes and no, the ASID in ARM is per CDE not per CD table. It is
associated with each TTB0/1 pointer and is effectively the handle for
the IOPTEs.

Every iommu_domain that has a TTB0/1 (ie represents IOPTEs) should
have an ASID.

The "nested" iommu_domains don't represent IOPTEs and don't have ASIDs.

The nested domains are just "shadow STEs".

> > Do something about SMMUv3 not being able to interwork iommu_domains
> > across instances
> 
> I don't follow this one. Device instances?

There is some code that makes sure each iommu_domain is hooked to only
one smmu driver instance, IIRC.
 
> IIUIC, the ioctl for the link of vSID/dev_id should happen at
> the stage when boot boots, while the HWPT alloc ioctl happens
> at CFGI_STE.

Yes
 
> > > What could be a good prototype of the ioctl? Would it be a VFIO
> > > device one or IOMMUFD one?
> > 
> > If we load the vSID table it should be a iommufd one, linked to the
> > ARM SMMUv3 driver and probably take in a pointer to an array of
> > vSID/dev_id pairs. Maybe an add/remove type of operation.
> 
> Will try some solution.

It is only necessary if you want to do batching

For non-batching the SID invalidation should be done differently with
a device_id input instead. That is a bit tricky to organize as you
want iommufd to get back a 'struct device *' from the ID.

Jason
