Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C86A6DBF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCAOES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCAOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:04:15 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3AA2DE52
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEpz4qYlzUUKi1Zg6tO/CtTjfMc7al1hJOiSK3Bkr4Alj9wygbEBaA+fMGsX4ilfTqBYnpHkjYNHX3CxkL7se069Va1UvcEqpi70mKGCVjgMhWPvnVkQtgWnHgk5zbKuNjQjNNBhO+A9lD4ux5oB1Kg3zBpDoxZqmUNAtE/sO3cyilUg3KtI2KdnGii9LZj9vtvGxobq3N/dLbGZy6cv0ye7s745vh1vY3W3xwtOyoXM80hsjcFHLy//p0e13y1PKcjXDrj74cHmPBsHXQBGLOE/v1OLZR0AAbO4RdvfEnCVXj2ePIPwhAOZ+qg2M2XQizZwNHhytdKKG5Jzv5Ir8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab5yjHx6AO/AEFyeYbO5i/3yCgR3WLwfY89rr9rQZH8=;
 b=RbxQRhPONGqJToJEm+EYz08K2NjVkZzE7HF8n6iK+5CEGJUklEBZ8PvbuXOqSQhUjmOjB3sbKnR9VIPNMCAVwx3QDLTvix23YdSW79UvlEZ9dAuqjdjgM2VaSYTDCNyOxgdnRmt63AtHF1Jkb71bwfm6eM5Uym68bd6z3K3ZkRU9hIxV+by50dQCLFMmaoeo78mJh9epN0Y5AYU1fraJE30FKcAjv41ty7g8SMXG73aWOAGGEYuQrSMrEHVBHH54lTqzsRNRcw35MeYiNrQZrO5lroPym5bKTqjjdTQj2zWyF2eVth3nnY+mHC0T9/Qn+UCX7RG/zO9f+9rYl6xvSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab5yjHx6AO/AEFyeYbO5i/3yCgR3WLwfY89rr9rQZH8=;
 b=Qq555B5I8obalb2WCH21JXbM5jqU1uBPaiWnsRtmpfJIedGW/ymHshOtip0QrXBaN4USAscg2ooaz6WFYfZ32/hze7JFjbG6SimIg6zTcrNIqJ+xNBGk9PQ7KhDcXqlvjEXJxH0j/efacnAWuZjJMMXi72hNtbSugPcDbLhHjGHs58bRoQLtVv96Qun1Dp/64ZWxdCZtuWyJwnAbLMVoxiK226XAu9rtymbn+s6rzoyivlTYe86XdlKwSRw/bK+79+gDQZ2Zf3cIb/cJfepBOmL0VSJWmPrlQwkUwETTtkgplnw1qjXjFB5jeCbhxeMWkfn14C/Mjtrfy+IYamI5Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5034.namprd12.prod.outlook.com (2603:10b6:408:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 14:04:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 14:04:11 +0000
Date:   Wed, 1 Mar 2023 10:04:08 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Message-ID: <Y/9bWMoAYF10ynO3@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e89a7ad-7921-489e-fff2-08db1a5dd4f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lhc9NXMeTlEaG/F8hG2JnAuHVTF9fueFHapVflv+WKVopspAiVKAAJNvz08/M/KQXcqcipxUZFRDMCG1Z/kM4PzeJl3zPW1eQIZ0mBR4BLVJ1VLzrwrjxEZyBDUImkUJqxurDKRpTylBdz1E0lf8tFvLaMPILkOWy4nr08iigVpm4E10rWHk8ltBtbVTVSl8GGTqd1OydIij6JAMfBPNxVc5ZGC47P0uUzJaIYucEhQ5wOVzX6VixgnnzbUraPwjI7U9qq285wtBjKVCnISS7nV0lWymSj5gDCbdb8RTCpE65Sh852WGR78lj9Febk6LzlKet26QeJeTIcAw1SmBaOuNu8hJOTSZjyerLMGOqwHBeYsShw5xHW+vkfUFaelI1/OzAKyOJA7cY+Qva5ts/EJnKjxMT/zLxwxEFLnYOwAE8JRovH+bUiBhW2wIJrfp6lDzv4SRKXcxPQ7jTXrLVCH+yaPunr3mdJNdvDA4P8Jf6a5J20JFXQlNlhzRscpDFMwL8+cqN7Ow+Ru1Mh6oy7hh5tWteE9evNZz0JVPJXgvIn29mjh5vq35uqRNOmYqC1Rw7hQ0lNl9PWcpl708KC6Q+obX95w5/q5jiIjJiHHK2vp8efSoVom8VSojw2jNZKKsJ6rtacWwvWbsN17Kkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199018)(66556008)(66946007)(66476007)(2906002)(6486002)(6666004)(36756003)(54906003)(2616005)(478600001)(86362001)(316002)(26005)(6512007)(6506007)(53546011)(186003)(83380400001)(5660300002)(41300700001)(4326008)(8676002)(6916009)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckY2eDM0ZTZtUjc2NHdvTVRmV2pIMnFqMmgzazNDb0h6N1RXVE1rdzlIYklE?=
 =?utf-8?B?bDFPNFVFQW9UYlI4VVpodENkZjQ1a1NJSXNyc1k2RFpaK0FKTldIblpjUjhK?=
 =?utf-8?B?SytsVHBpUFp2QWFSb2d2L012VDJOSzRYNFdYbkJiWFlWMWdmc3JKMzZUdUJi?=
 =?utf-8?B?UHBBYnhBRkNBUHEvMWo0UjRtZE5sWHJuU2h4NkdqVDFXM3Roc3NuZ1V1NDcr?=
 =?utf-8?B?NVE1MTZmZDVocURuQnJEQU9uOVRsNUpiYU5LQzdIVmxSRVJXODR0RjI3eTM5?=
 =?utf-8?B?SWVIZkZvRjMzN0Urd2JnTUxrRVJ6ZnY1VzFjMktLemw2QVlUV3RUbjVRZ1ky?=
 =?utf-8?B?d0NwOXJpZjU5SUNyUU1zSkpSM1lQWGVQdTRIYnV0bkhyTmEyQTNaSjcxNFlC?=
 =?utf-8?B?U0RQRFZjeTBVV2dXVGw4R3BkZUdOZEl1UGp1RWc4MmozU3hoaThDWXJ3ZWhz?=
 =?utf-8?B?em0xaVhIR1NQRG4zSXIwYTArVUViREVBbWV3akFDWHZHaE55VzVTWnJjWTNz?=
 =?utf-8?B?Vk0yL2lCb3hBb2dYUXZqZnFURnJENklFdVAvODdUNHcwYlZHUEg1RE10YSta?=
 =?utf-8?B?QzJuenFKbHlMeWpJb1ZKTWpXYmFKK2dRU1NEQXNyUTZNRmtGU2pRYUp6aStJ?=
 =?utf-8?B?emlEV0UvQWF2K1haTUtLazNDeHUvMVZmLysyYkVRVkhTMWpFNGdNb0lGMUNq?=
 =?utf-8?B?ZzhGbnVnd3lNSkkzSE5KSUQzQUd4RTdHQk1IZENaTUNJZllVSDc0ZUU1dUJV?=
 =?utf-8?B?MkRoZXp4Kzl5QXcrTjlVNWNLQ2NFSUMyMFphUXI1WlB3VVZ6TWE1MURYTG1j?=
 =?utf-8?B?RGJYWkZ1SUUzb1hxRjNPZzVreEgrR21JUGRmQmRYUUpXbEdYY0lzSlF1eTRq?=
 =?utf-8?B?bmpTWVljTGNwUnZiaFg3KzhHeGNRNGdvVTVvR2liajZQK0R5QVQwZWx3WFFw?=
 =?utf-8?B?NnNpRHo1clhUS0U1REhPNjNvblFOQWRnQ0VxYzRLSk5NS3F0Q2RtYzBiRVNp?=
 =?utf-8?B?L015a0pwdEs2RWh0NUViVjRsSW9QVkVUT0Z5d3c0dXVvVkxNQ01GOXRrSVNv?=
 =?utf-8?B?b0Z4THYrQk1ydzdXcmcyaUZ0MW9qVjRhQ0pLb3lRaGhWcTN1WmdLWE1hUEF3?=
 =?utf-8?B?eGlyMGlnUjI2RGw0VWFGb1BHd2sxaldEZXlqdWEwSDM0aXVsbnZwekdQU2pl?=
 =?utf-8?B?MnkyekJITWd5WlFZYjJpZTZmNHY5VzkyZ0t0YmR4Z0Z1UnB1NWNnZ3kweWZJ?=
 =?utf-8?B?UzAzdTRwUncrNzFMa0Z4a21GMmoyK2txZG53RTZ5VndxSW51czhlNjc4QitQ?=
 =?utf-8?B?Vy8yTExzY0s5TmFPQVRMdWo1NlozTTBFWEFvT3pOMU9BQS9ybmNBcEVobGxX?=
 =?utf-8?B?SUZyU2ZPQnlpcFRDenI2U1ZmajVsOUNYLzFDNGYrTGhnMUJjUTNzSGY4VTJx?=
 =?utf-8?B?UzBOcmIzb1ozd0J4Y3o4cVlEQmlkOW1OUGtuOFhLRXZOZUpSNWp3TGIrcmJO?=
 =?utf-8?B?bHpEdmRJWGpoYnVBRzludXdaRlB1SzAxMk42NGlPUlByUVpaa2ZQVnh6UjFJ?=
 =?utf-8?B?cGd0M1RCY1gyeTVjNlhQUVhUK3d5YmliR2d1cUJqR3IrTEhEVmY3TFp5bUI2?=
 =?utf-8?B?NSt6aGJuWTlhK3k5dy94ZUFSbU1DTGphcHZrdkdBakZXQ1F1bHc3NjBWdTFh?=
 =?utf-8?B?WWk4dXdrVENWZmdyeitKeGRFb0RMQnVzWkJFVmEraTRYbzkyWU8wTjRjeFZQ?=
 =?utf-8?B?OU02UUNHSFhJOFF6K0YybXc3cDZWSmdndEF0VXBadURrdE5LMSs1Rm15bU5m?=
 =?utf-8?B?V1BMT0tGUit6aDR6b05sM2VkOWNwVG1ydnZlb2lNdmJYelZyMlBsRFJYUVhH?=
 =?utf-8?B?SjJMVTZlbEZKV1NxaGpRRnRXd2JmVVpiNTcwYVpDZy9DeVFobVo4d0h3M0Nm?=
 =?utf-8?B?emRkTk5Ud3pnUTJ3THV1dFZmMXdmS3FWU0MyMlI5NzdYTFNOdUdVODRwNS9S?=
 =?utf-8?B?VDFhM0JUOVkvYTlsN2ZTem14Ym52WFhNaUhMR01vd2NTRDBHbWdOY0ZJVkln?=
 =?utf-8?B?SFJBaGVLem9QTkhETXlBR3dIRnhORUs0QTJxelJTaUVmUzVxTXBiNDI1UThM?=
 =?utf-8?Q?2PBmyCh064HIe6OobuAiUIw9A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e89a7ad-7921-489e-fff2-08db1a5dd4f3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:04:11.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpNfUT36kHEYKuaOV+xED3GdCiWWhuTfhUbIz43/4bthG/ATot3yu13FkPRAngfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 12:22:23PM +0800, Baolu Lu wrote:
> On 2/28/23 8:23 PM, Jason Gunthorpe wrote:
> > On Tue, Feb 28, 2023 at 10:33:41AM +0800, Lu Baolu wrote:
> > > In normal processing of PCIe ATS requests, the IOMMU performs address
> > > translation and returns the device a physical memory address which
> > > will be stored in that device's IOTLB. The device may subsequently
> > > issue Translated DMA request containing physical memory address. The
> > > IOMMU only checks that the device was allowed to issue such requests
> > > and does not attempt to validate the physical address.
> > > 
> > > The Intel IOMMU implementation only allows PCIe ATS on several SOC-
> > > integrated devices which are opt-in’ed through the ACPI tables to
> > > prevent any compromised device from accessing arbitrary physical
> > > memory.
> > > 
> > > Add a kernel option intel_iommu=relax_ats to allow users to have an
> > > opt-in to allow turning on ATS at as wish, especially for CSP-owned
> > > vertical devices. In any case, risky devices are not allowed to use
> > > ATS.
> > Why is this an intel specific option?
> 
> I only see similar situation on ARM SMMUv3 platforms. The device ATS is
> only allowed when the ATS bit is set in RC node of the ACPI/IORT table.

It should be common, all iommus using ATS need this logic.

> > all it does is effectively
> > disable untrusted?
> 
> It's irrelevant to untrusted devices.
> 
> Untrusted devices, with pci_dev->untrusted set, means device connects to
> the system through some kind of untrusted external port, e.g.
> thunderbolt ports. For those devices, ATS shouldn't be enabled for those
> devices.

Yes
 
> Here we are talking about soc-integrated devices vs. discrete PCI
> devices (connected to the system through internal PCI slot). The problem
> is that the DMAR ACPI table only defines ATS attribute for Soc-
> integrated devices, which causes ATS (and its ancillary features) on the
> discrete PCI devices not to work.

So, IMHO, it is a bug to set what Linux calls as untrusted for
discrete slots. We also definately don't want internal slots forced to
non-identity mode either, for example.

This should be addressed at the PCI layer. Untrusted should always
mean that the iommu layer should fully secure the device. It means
identity translation should be blocked, it means the HW should reject
translated requests, and ATS thus is not supported.

Every single iommu driver should implement this consistently across
the whole subsystem.

If you don't want devices to be secured then that is a PCI/bios layer
problem to get the correct data into the untrusted flag.

Not an iommu problem to ignore the flag.

Jason
