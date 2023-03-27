Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34B6CA3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC0MU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0MUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:20:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6246587
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvZHdpsQTUY/xgSJterBZplxdwJpjBgzwut5YeerOIixiDUsLmflIY07g2mXUpDOkWAakl31id6H8lgpJIAuIyB2p4GVXQTzkAb3jzup3m7yC4HjSjCzZK9bVaMONfxL29g4IyGJB8r3zRN9XAgXKhQnp8snacq4hb9dyTjScu5TIOTruMSB4jiCuhl3fQC1UZ/kaCCyRrT7Lha6wX2Tzoh4PfdTUkb/VctxPrYT6vtI1tmTRlL1Le4kmmjq9MFTHWdyXaMQG7zVyqIgeLnQry7b09o8CoKFSJ0d1UaAqmLkHOelGga7SfUWST+wKb+gkXmcORaR+3PPFXgo+9Bo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1/54azDOZYbf6akFSOucCqlqXqxQd5M1NPSRq05LV8=;
 b=RjqoLWGP2jgyTB3KZIfRcmWsrNGDPwi7ELw5SuZUjFNwqKHt99phQdpbVY04uqc6HSKMVzgFLww6eanpR3ixMOpR48Y2UI6urJhrtOcX9+juZYLVGoR3GgZL3YPTYi7JT6EEsAielBF6TiYDmqvOWYp4bT2VyZOuqDWGbJo9caE5sqDb7D57nPCNQzY+yvTFSOSo3EMNuzLt6jv0yxAUr4j5sOtoTxgpdqHrQ/GabLad0c+JXuN6ZgUZRbzrr587559z/w4Nb1r4PP5stBjzmq/l0HwJZA56bJIBz4yznUB2R41jm6+LFDRjwQjFC7XcwlFmb+O/ggRoZx9maOEBpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1/54azDOZYbf6akFSOucCqlqXqxQd5M1NPSRq05LV8=;
 b=LVgH/mZrDolTCsjEn4RxsyXSQhV+7QNXtTqTLeXMrA6A0H8yMSHS+VG6ZKak0bCAqhgCvlo6Q2FfHsVMrR4DWsFF1NpE0EaQKOmu5kAdYbDGlmrRJlZhwiMzxLSj05Qfa/UBKQca+lqWoaEGd55wnAS79ngkWWPsxLWeBH3ZFEn35EHMfXiTICClreFIk2EX9cvkHdeBCuU3ud2jNbgH6SdBG5OF1wLdY7K6BdfdgnXkxMXJp+2b27XSKJHsQF6N/jYAqgv5HUkn+wKLiOGdmMu0/xPxN/b9PirqS89LWgaNRPKjK3g+YqVw1pUQ94DNvLPDQNHNEZ262zfuQIPWgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6562.namprd12.prod.outlook.com (2603:10b6:510:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 12:18:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 12:18:41 +0000
Date:   Mon, 27 Mar 2023 09:18:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Remove unnecessary locking in
 intel_irq_remapping_alloc()
Message-ID: <ZCGJn3QWhQl4F1dI@nvidia.com>
References: <20230314051836.23817-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314051836.23817-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: CH2PR18CA0035.namprd18.prod.outlook.com
 (2603:10b6:610:55::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ad122e-f86b-456c-e189-08db2ebd66df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wI7TAQllAuiPS5jpVgax1NqfTV7XW/MGsSERiDb38q1jbpT2Jc81lyVMpRHbYHSk5ZPH1AgRR6LBV7fefBGFUrDgiyLuraeshrIKi60m4YlEHvjhKK2pdwyCyYalYFLCYXIdJHrdMUWPjU13wYnWVyZzodaQDdmxYoy80DU1yEgjX2Kf734SJU1Qq4vHvkaLKKNNqO8DCQMDpLVi57VHbV574UHQM/tj1bseai+dvh02I82cBOzMSJ7CW5wx8FnP8ArgJRCZgGaqY4ohkFa1a4FSlUJLT8gh2UZl2rHcohP7qK/VHIKrKxkJd5KsU1L4/TfGXdZDnvl+E07lukDcj++0bkt4jZN6k7Y6Wc6Eb62VzRpx2qUXy71imA7o10MxQJAUFSwcWtAfxG5puUiCFEOuKQKr+obOkHZ+thkHtQt2X0C/LG/kFMDhWbd1om/gdTpCofMPZYpZZhS1God/frXpF7RnoHpmERHknCgvwKshWr2YRSLq0z2iKGn7vn1HlBMb5OoUzIaeH7g71fwMLuykzfCIHciTNk+7PpkWx/T6nSqI9GdBQJWP+xhSBiyy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(66946007)(66556008)(66476007)(6916009)(4326008)(8676002)(6506007)(316002)(5660300002)(8936002)(4744005)(41300700001)(186003)(26005)(54906003)(6512007)(83380400001)(2616005)(6486002)(478600001)(86362001)(2906002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oTfT+Biwo4VTjxxrKm4xJhFXp0JZy0YRq0vbJORBXrE32MRYsD9SccUL2+hU?=
 =?us-ascii?Q?t2F2Z7w0gmSXyoP4UvG1NXhPp1TR/Mi+fe2rgJOmowo1LVr9uxAVBKEvt+NQ?=
 =?us-ascii?Q?NKwsDpiINGEj+J52BMy0l046M1hMxPB5Smt2zXjRR3F7OBCyxKiyJIBHu6M9?=
 =?us-ascii?Q?YN6nIzUIkGsoMjN/++5PgmmYQpQ5Ed/NzSY1Oqt0FBHUWBsTEcLmzqqlEM2C?=
 =?us-ascii?Q?lx7UT5jako/3WL/79rmLkypJPc13FHSuy4ZeTlfoC18cHswXpxKw9Q/q72oX?=
 =?us-ascii?Q?iwFWYYUHx+xQXTg/tFbTBA/trAsT/6GGtHWIzrOsU2GH8EpqeHM1qQduvgI/?=
 =?us-ascii?Q?qlkm/5noh9iNwYTMK5YC6FBWC4gdEYLS1/4XsVXCPv1Fz5oJElbp0VLEz3eI?=
 =?us-ascii?Q?z2OdckuADfgDIJexvORgCXatl1lad7LqqQdb6eqv/A2QO9nLs6sfxzgYzBAt?=
 =?us-ascii?Q?sRvv8+PREwb+ZcqN4p4Qgrfp6kshSPyCVZ1oXaxPW5bKg8XiGHbyZh4pF979?=
 =?us-ascii?Q?+vg5AxPrKK/MWFLtYkiEtCNQvyenztNkPk2/fAcDbrgYY3DFqFzEb5ApnhXe?=
 =?us-ascii?Q?aPB0kpM17WCSd/XfoeH5U617AGv5QrGkpVZ27RaFr++Rfkh5/t3ftWM4wJub?=
 =?us-ascii?Q?ipNMLGoWvH2yhUlNp2+AkgiUSTzWLGAG4niW9S6lHzPabuvz+cCou8SixUms?=
 =?us-ascii?Q?zxk3FtXnDvpuuGD5cCvhCseq//2OMLEQvwcU+weBeU3KltmqLVqxneX5ESdR?=
 =?us-ascii?Q?K2qEaQWqJO7ZslESaN55Ar26Q5Nap1kVkTA/yB6nrfe0pXrnefW/IzBVWvRI?=
 =?us-ascii?Q?4PypSKh11lKzfX70xfQ9WJRsFCo85etH95ed1SSA+0sw/307IifB+vMf0gUh?=
 =?us-ascii?Q?jICmu9Wfw/As/K2W1dHiMB5wD/ZjhZILHTdbtDxw3KL3/rZq5rCDNfzIviEK?=
 =?us-ascii?Q?j5ZDyxOPp/YkDDLuV8KP8YbJB5WsN5QU4FBmxQrkIZ46j0AbZj9DSsqYYuX/?=
 =?us-ascii?Q?UkzbmX58TRgdaJ05o/+juobKEtLqKY6eGdgq+SxvqM7ZFJ8k21R9+nzX0Jvh?=
 =?us-ascii?Q?AoC67TVqtjgZjcwiFksEmZxt2LC3cLE49kGYb3ZOdOpJuYldDRdPNTXqnW8G?=
 =?us-ascii?Q?52fQrTUqQJ4mQNjqRai25M4XsRa4/XgLRIuuxXTJgklETjEubjR0+t2jzsd8?=
 =?us-ascii?Q?L4Zjl0blN3XsudITNAinfxXtuvzBaScjgLWjXUNeYUf4TB23TSIMEfYoqiz2?=
 =?us-ascii?Q?uxuEot+TKFqiDCwTKs2Yr2qoH7hM2knmh09jZSsDk2AQ921J4bPmUUTuO1HY?=
 =?us-ascii?Q?ss3xylGDa6WBUGmkJmR+mnWI5cfNHBh2JXHFKOGhlq9WR3yy0No0DVFz97NP?=
 =?us-ascii?Q?zIxyD/dTowyy5akGBtpzamW0HHSOe+Jz7bgtiGjecBQIpztrKSaqs1HYluPd?=
 =?us-ascii?Q?gWME8d4rwK52gbb5fOCz6gKJf64q5zhmtJqC4FjouXiSd2d92ZvXbl4MMD4T?=
 =?us-ascii?Q?QRc17C2p5gM3dwXWBKDO3ZFWPxQNzQTca4S4V9Zfik8NdC4Z9kMlqxtFMlX8?=
 =?us-ascii?Q?sg9x9TfH8ZhGu7BK98o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ad122e-f86b-456c-e189-08db2ebd66df
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 12:18:41.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4KfEENiDPk9s+MkJKVuPh5Y0xUiRnQV/0G+bARftggNEXG8iFMrJWlStw66d0P7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6562
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 01:18:36PM +0800, Lu Baolu wrote:
> The global rwsem dmar_global_lock was introduced by commit 3a5670e8ac932
> ("iommu/vt-d: Introduce a rwsem to protect global data structures"). It
> is used to protect DMAR related global data from DMAR hotplug operations.
> 
> Using dmar_global_lock in intel_irq_remapping_alloc() is unnecessary as
> the DMAR global data structures are not touched there. Remove it to avoid
> below lockdep warning.

Tested-by: Jason Gunthorpe <jgg@nvidia.com>

Solves my splat too

Let's send this to -rc please

Jason
