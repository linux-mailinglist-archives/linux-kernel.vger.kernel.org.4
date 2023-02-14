Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B473C696436
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBNNG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjBNNGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:06:24 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CBF23C7C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:06:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwvVN6hf05t0oFXd8HFshkYrpsidxc1sv/Hmr3RwELEkwmp7ojDx2/mQLjAEVA4Q0th+gPaHAZt5Zi0LHZOM8F8rlZnVNbGMwP2pprBlPZCpT82/ShdFI5IuFxebt4MmZxzDKJJvSpZH6FzWdJ+BlgaCnkgUMzgqI6N/jTttulYksvXOXSwLjJiP3vzZGdPJhnKDM/ZylF+tl5c5TPO4iRiUo5Zkqfc2ZTQXxqe6Pk7I76G5aOYcQfjIvQxzCAPNki/rVJ0eZhzQXqmaE7oKT7YfCGpMT+gKlO4IVeF0Hn4WVhcGIkqX0q4bEQyxc1kS/g1PtLRYpCfwkvvPR0muAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WxE1VQBQ5HeO79aVP2DekS8/L+qQaCy1jWAL3JmXmw=;
 b=PgXIN1Q4zo/GFTUWQ6E6Ms2I7YZBMJJInZY36/LWlQ/Cjnid6oCvcnEUmWG2T2coE7WP+fqA+LXAXp0OnL8JSRAPda/vMq56R5jGAU1bN6Yw7N53bekP9q0JDfCoaDnqYHlQ6CSnpPLYjS/nJNBL10BOg8YCd9HgBcbgewbIXkdoQhtU6Gn0MWv80FnX7SkYG2Mg7I2h+SYtrSLy3NZE29SvjlIBJByZ/mjVeoW8vFS9DlA0hn8QczfPS3JoVCkIWGQgGyXgmYxwlCIak47PFAIpwHCLN6gAxuUDATq4XbnFEi/ez/l/WV3n326o2k67tJsZG9+LilAsE6KILAXJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WxE1VQBQ5HeO79aVP2DekS8/L+qQaCy1jWAL3JmXmw=;
 b=KKRBb+hJbjXWHWhkXSMsx6/Mp3yF8n4klD9DiGPQPoSEQms2ANEXh/TVEQregidCEvoc5esBJzkPBqrFhdZsAXmNz/o/y/yjMXh+P3woORjGYSEHAm3sA7ndMSZ3IzlvHOwAeQDRsd9NzkqxXbZ2+izvzQylz9rDYcCT490pfCjgL2fKJn+FFzbqP6ns+Aa+4SPpUDi88d/BzuwunmO7ef4ie08tI8+vUmdX/j2BBqTBRoDKhQYUqVdGr/fO5TLOoQLejxql/AXE05qLFcdoYdp7bDaW6P/nfvjIgLb6Tdz8MFxnWkxVqiAouowWiNxdr7QOAKU9EsF0iwOUvoyDag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 13:06:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 13:06:19 +0000
Date:   Tue, 14 Feb 2023 09:06:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 3/3] iommu: Remove ioasid infrastructure
Message-ID: <Y+uHSry/tpgGNr/b@nvidia.com>
References: <20230214064414.1038058-1-jacob.jun.pan@linux.intel.com>
 <20230214064414.1038058-4-jacob.jun.pan@linux.intel.com>
 <Y+tVMRzRQbcc7Guz@myrica>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tVMRzRQbcc7Guz@myrica>
X-ClientProxiedBy: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a941801-6f5d-4baf-92a7-08db0e8c438e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5W2PiYNGwOWcKQaQFf9K/WFszudYe0o0gdyJFmaaIgQdWJgu/jN8PQy8yF3EhVueA7z64HRmHK7BVRWqyq+7gcDzL6h9imPUl+y+qxA9TQvjj4Esb2uDPqZpqZ0I88UL4JHS+wxTOPUiBikP8wHFAmDbBKVVeHCF4Wavu0F9UwUyLJcuVwBBF3chsPD3pzmPMgZ/nsqE2Ea8arjOlmtkH+jGrInCwGnC+PUid+kR+e8qpHqRBKmhoQVIav6nBY0mvw1IWi4ojMCBNS9EJGN+x9QPPPtCiLdlqld3hilrIKQ+LsAiEvOrda3YZszqFCR0ETrUkCUVC+ktKAd7WTn3l9WI3BZ0zsAAQkKzu44bZJgm+UOvrcw6LQFVPF1MmUlj6iVeuZjYkPlZiuTqavIBoyVRRRZDwOZ7/7XK2fZ0gmln88Emz4qi9B5DcOjE0N4Ahc36PEPH8DGSKueLxFWow6EOIXlc+HO10sTwTKEdUkKmAdm0ejzc9q4QELWGfhmt84mrM8TVqTCxPBZyBOJhzRNMtjahrfAFK81P4o2G704Fbz9TCR5aZW5Cyw4Az3vPveX1hvq/A4xzaT/6AHvb0QVfG4GoT1YyGmYSb5ReIUjAm1dpsR2P3gN35Hv5QVqb7k6K0xP9V13777Y6NU0f/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199018)(38100700002)(86362001)(36756003)(6916009)(8676002)(4326008)(2616005)(66946007)(66476007)(316002)(478600001)(6486002)(26005)(6506007)(186003)(54906003)(6512007)(2906002)(66556008)(4744005)(7416002)(41300700001)(8936002)(83380400001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rE/totnrezW9kMYC2qESI0gC8ww/EObihMuJFa1lJIPbWG3dTYfcXqAwyV3c?=
 =?us-ascii?Q?NqnvwGQv7QOUsLHjTqbgnMq75yo4a7sSn5o5dogh7UwntqCc+/Wpt8nDvnaQ?=
 =?us-ascii?Q?23c2mbmCti/4O9568UY0zjAYgbMEF+ol+82GIfp9kI+6vJGCnxXgYBw2DDDD?=
 =?us-ascii?Q?NhFY4bODwtDNc5BWWGnx8Hfvu3N99dnjuJzfCW9r8bJActcrkZYj7L1N6OSh?=
 =?us-ascii?Q?JC7IW1mKA+LJSdJvGB/Cp3MuhBL3Cxwg0kECuCwyY8BbObn0P9DnJt8WMXXo?=
 =?us-ascii?Q?Jo/miAo/vbsxgmHZ/pL9oBRvvpv5i1MiQeE10HpLDjwHZ5kUD29hN83DJKGw?=
 =?us-ascii?Q?7aw9u5Nokig0p0izGoQpNHsS/0BUuCg23wD1OcVwtOyjnM+tV2Z/CXqJ6/RY?=
 =?us-ascii?Q?2X37mw5pgcq4v4AH6J86F2qU/2DfijzAdd0j0sjA6ItRfsLnjA+yTZCa+cCA?=
 =?us-ascii?Q?X3ZQZS9TBE8wAjgaD1o6gCZPfVhWzG+0FcLA0yJqVgHAMMNpWgqepWBg0l8g?=
 =?us-ascii?Q?/JXMliNci5WozQJh7Eo6ngHlrSIdouxey+n3sIKGwQWZk3UOxq22zqNBsfu0?=
 =?us-ascii?Q?yfaDwVbJoGIfj7V2+BzTrRjBqHr3CdsJeZTlk04yGQCYpomLbJea396CORHq?=
 =?us-ascii?Q?fUvETnulkG3waO2aZyJsEvJV48NlmM6esXhT/9Dg1n6tJhphtJpDrSM1EStj?=
 =?us-ascii?Q?7oaZeBAky+sZuT8tNzgQ+vMdWEPB7IMYWYj9GN4Y4/tGMKqgDgEE7Ce4aSWZ?=
 =?us-ascii?Q?DHLO8Zot8uMFYYlgz++NJvo0SM6smALzqS6hhcQ1RX7ZrUfsbVVTK40ZkK+Y?=
 =?us-ascii?Q?A/wBgzBVWFEC734mh8TwpzxOYFf+UKhYrdnZJME9DYDSp1sLh7WZzW+V0CiA?=
 =?us-ascii?Q?NvlRq9GQLQ2NBaCQCC3PKUKeEo6wa5dI01hQgjNuZlyh3GfBdNc+cLQCvEro?=
 =?us-ascii?Q?pKwJOc+haLY0vnXit/aY8fvSSg146f9gZ2QTyBBVaFmMrjN30i1/exQLjbGo?=
 =?us-ascii?Q?wwBJ7Mwzorwko3in5Abh5jvxkKnfz6n7u3LR7KAg5pJd8VfXocn6RGl5a2D7?=
 =?us-ascii?Q?L2+BVSNkpC8bPO3gULBOT6q3+NlNACNRlOt/iV4/ZVy/FgEu8ZBbBDtO8fBn?=
 =?us-ascii?Q?L0TvvnE/NMVMFEw84YUDpoUMg7q00VC5N5OQ/MnHPDYjPZStrDy7Lv6JbVaj?=
 =?us-ascii?Q?U1qNIOuv0GDnhaRPNWIY2KtsqoBIIyAhTizXz/7eGLNOwXQi9RagLUFAE3Cp?=
 =?us-ascii?Q?BoYP0xDGlaGNnNOc/pEsTxyLpq62wWVWijtfUSDf5V6bArG+ozFPhDQwpx9Q?=
 =?us-ascii?Q?xqtogu9JKBMi5OvMFNbpavznQbu3sJkB8ijPlgvrSfeIzRPlf1nutnu2GJzF?=
 =?us-ascii?Q?XKqFIIVXQvOy1057gaFsgn7vJTi6InwMkkyBuUcWHJihpADFiiIxvph/7iPe?=
 =?us-ascii?Q?NBFYqOxssSlwU/Eu+ujcbo7yooPp0uAWFt3aH41pDmiH9gHuoT/GOfEgWdqS?=
 =?us-ascii?Q?7MnE9OIglAlDTo1FgB00gpNyk/3Jew54wHqL3vEabhi+LBaSF0hwF16Nt0ej?=
 =?us-ascii?Q?xEtj+3Pwjawlpt7dRuf2U2cvzM01pEnT/qHW8cyF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a941801-6f5d-4baf-92a7-08db0e8c438e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:06:19.5621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6XWxfUXXIVSBWZeefoxAq4IEYDdkJixHAoQ3rTk1YyEzvIf66Zzb1y42Y2Q1zQR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 09:32:33AM +0000, Jean-Philippe Brucker wrote:
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 65d8b0234f69..a95f07f0c98c 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -157,5 +157,6 @@ struct iommu_page_response {
> >  	__u32	grpid;
> >  	__u32	code;
> >  };
> > +#define IOMMU_PASID_INVALID	(-1U)
> 
> Why change UAPI?

There is no uapi, this whole file needs to be deleted too

JAson
