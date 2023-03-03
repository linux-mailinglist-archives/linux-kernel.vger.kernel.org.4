Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9419D6A9838
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 14:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCCNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 08:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCCNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 08:18:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02768D532
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 05:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlUNoX6necJwUraABv5PUopXIFgeNS+OTSAHqTgrdGl6H2QgK+FPy1YQ4MpWEZ5hYsO3IsMxEGv2ebQgtpiHLTR65Y2h88LUw1UYzrgPrv2OnN60HNlNL2KVi47vqbIsVYS/Auu4nZq8wKl9aVvTI7/zT+W2bCgQ+0WmNWuUrxzUUGEtBj204pMzzSmUEbOhnaK2RFcOnf60XEVHwie8dfMGmiYQQygw8MmhktEaheRnln2c8MOMW0RF+8zqKDGlgqH2m8E4Z0kDyCFbTgXOlm7yEZJkfTY1q/3XCnD8v9+h4x8tKGMQj8u9aEGfYpS9Lk/BevUE3uOV3nuMpms5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8ARX9SBpxXEUP0oQo9F5PXDOnN6ljLqFl+ymH1QyXE=;
 b=AgjIcO9em2BmNJmT2aE27wTARbQMsKqEm+VxaK+7m6ROXkcC8wTxiPsuLtXOAe+y/+fqn8Zd0GnL0gufxy6HY9D8anpjQ+h45Kih4Zi8cRlXV2bG2/cZNWLd1b/urHuBhoPcsuusV9ae3EkLkhxMM5Ner45Ao7o6Ee5Z82q52N73kBvho1umeMFG6dCA2xXm6kElMxEZEOw12mzH2Q0Xl5BVB3F4J6xW/2MmAOV9S19gcBGQBIuUkYesL9eqdY+8fan7OkFX3CBslH49nLgv/e5qyvwoiSF+l7VHR+Mc3eIlqy4Y5mBxk+5YlfPjO1eHWyX3i0KEurJ9Z20QKYArhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8ARX9SBpxXEUP0oQo9F5PXDOnN6ljLqFl+ymH1QyXE=;
 b=glH0I8bvCLysh0D7pmw8nRWhNt8/ZvWsAM4eGQRQXeGvWw7ykHZGJAAQGUQmggmzbs818fcYvscNCSERBv5+nDDsdJl+0Nq7BBuxr6bo9lyiKZlQvBLn6BfS5mTaHpzruOedObThBK+kSxNZ8RuWPPvap9CGIWxDyl7XKKp9jHBEEeTHoQK+RJqSLHKYwQuoYs0Q9lgqqqNfHoHHOz0axkny0ac1zRZydN5G0N/3FqPmE/r5iXeqjobYxJblpy3Jsb1tiRwJHYkYp7gzE9qoUz2QUv/JP36uzaYa8htwCg7vBixfuxUlxXvhJKpNjt/kdzv3lf/xYRjnVdmVloAKxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 13:18:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 13:18:03 +0000
Date:   Fri, 3 Mar 2023 09:18:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add opt-in for ATS support on discrete
 devices
Message-ID: <ZAHziAcvAozFJ3Cq@nvidia.com>
References: <20230228023341.973671-1-baolu.lu@linux.intel.com>
 <Y/3yNaQD5Pkvf61k@nvidia.com>
 <3891a9a8-c796-2644-9473-aafc9ecea64e@linux.intel.com>
 <Y/9bWMoAYF10ynO3@nvidia.com>
 <0f162421-479e-6ab3-bbaf-0090b1a2472c@arm.com>
 <Y/+OobufnmGhg/R7@nvidia.com>
 <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276F192BCECE567DBFE21C08CB39@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SJ0PR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:334::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d9ebd4-826f-46cc-4ad6-08db1be9b83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HnAh35nnYLQEK5TW3EPS1X3WaWYFomPeKyKDaWjm47gXA37OQZaKQ0WtHFJhgP2Gz6U8ISwMaM+pt9wwnV4DUj+DWh2M7LcIngs8SZCNcf9Jcfa4WAFszi1jDdpj5w30w5F+NmeVI9dyXT1P6XWJqFMSt47zeyRDXPnK0wMy8s61W5/RIMsmYGi1mWtUnyPgLrGnQQq1vY2tIeZm3n/prayjhdDn29nY8V8yNx1m7y7FEXg8YD2SovSCwn+eaP5n+yGfvTHvDFgWWKEB+N9pZoN43VCNnjVr1yRcDvlG8soQdxtbEqbWAi2mnO/u9lhMUnyPLbk20lGG/nQrb37f9LJCpLdhC1rGF+gL7gjnwyZBtb+SVeEDOzmPLecPAi+ob+vnUm0d7AUJORQ0MdATHsCuhXUfE9nxedzB/q6Fksj4APiU9XvX/IdkGZx7bWjSMC9W+n7DWmxT1oQJ8xeQTE8BUe+qGc12/SL9MrFeawMOtjNqjOu/AUQLfKkwwtnrd/8EkqdUTAkyENBANYkuO2rDH2bdgwferDNfHZegfgaBIeU7+o9iLjcXQAJupcCO1OrfAISq5udyf2ELabz/zlPsjRe19t6ErzRrvA7monll9bhT+zMujXqUUMEy3wUswFFps7Yy2F/LX/AV3m5lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199018)(83380400001)(36756003)(38100700002)(478600001)(5660300002)(8936002)(86362001)(66946007)(26005)(186003)(2616005)(6506007)(8676002)(6486002)(66556008)(6512007)(66476007)(2906002)(41300700001)(6916009)(316002)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eV19s3R87d28Ue3UbJ2cQK0pVbD2j61scaNsPPmY81YgvjsoVfkpYcm4/g/H?=
 =?us-ascii?Q?yblpp/dfRWfKqewFnSBYdrEoj9ecHGPk57CzVTCa++Ar77kTRQ5B69hiBhB7?=
 =?us-ascii?Q?a15Ptww9GkU6gxr/klDUQi+x0B4zTfL8bk5Zn/aMAeST33KmN84mH5GQNxhd?=
 =?us-ascii?Q?ULuSKfVf/y8zlhCPQyDRIHVyVxudy99N8i7dgfu3haFuNPJIdA1Qcshe3qC/?=
 =?us-ascii?Q?FZjAG0iDT+1EGD7oPn31eI0exw6Vb8OiB5bmuvmmTiekyxiYwuMOQTZVv7ei?=
 =?us-ascii?Q?2AbTgcyhtwdP7+UnUx8b1DPQQ2eZcoQxfqLJs51xDJz8vibBKmm7BvCqkDBZ?=
 =?us-ascii?Q?hsC3a8EE468sq0Sd3v+fWcL0xl0wy15Uacuhk1YdIiwmrVjCBqb2UcidyG3e?=
 =?us-ascii?Q?3VQfHmswFcwvYuI63NoXqs9tCOgMOcuKKBWOceC75G7vCa6W4+8pL82bSFcS?=
 =?us-ascii?Q?4ZNxxVNaM7VWKT1TVL3MRYc994yuboRMSQUgdCMU6nVqUNwDu/TkHtZwdf3U?=
 =?us-ascii?Q?UiR9tTpp3rySDqKQrmxHVcOR0/fcspC1/QE4OeKP19VbjRmBbG97/Hx9Q7D6?=
 =?us-ascii?Q?/tT9cbQdqht62DFNOcX6/zghxv+ovh8HTCHz0mX5cuKQk0DWCmM2zzQnwDe8?=
 =?us-ascii?Q?U+MlZe3oJ92UBTFMWbxhrLLz0qRttF+AYX3Vj181K2Mj7Fi2oobxfQHVJ9+m?=
 =?us-ascii?Q?ZSgmpN9S5frOpyv1e9i6KBKEoOqP8sLFDShJPP73/SgQXD80D0M9S9FlKE9J?=
 =?us-ascii?Q?JIq9hzekObOI6jrZYkCv7QotAhQJBaZHiwFBRbpDoF/lF7QvmQmPit1WgsjO?=
 =?us-ascii?Q?mDUvOvsTuxerYJcuZIO/yk2vI1QeFcZ0sYx4Lqj6hNfd96kWNGckYIoizNOl?=
 =?us-ascii?Q?ete21YQ1BmArssmdjoEZwhLSCTV30hJERrNxF04b5KLUQKREseqCnmCODPaH?=
 =?us-ascii?Q?vzrCGRZ6k4+l27Vky05StcUt4sQyomaoTUL3JXNaPNJTr4P0TFsfqcfzER0L?=
 =?us-ascii?Q?YN2VJMd/c9wLNrn2o/+h9klx3Brl61ULDI9TGnYPPEqKrr8qpSkSsOoMqdkk?=
 =?us-ascii?Q?Kb+QqNLKMoXqslhC8IWC5XN6pBFCVFXq3d0yZ6OToCG95qiYSOA3+oPMp+eA?=
 =?us-ascii?Q?ItlhSFtWyu6iZC2e2jkV+2IDBhdMRkMZkuBoZFDXurT+EPUnqxHLAzbKcVfH?=
 =?us-ascii?Q?1/eNw13smaHzvGtze4YEPluAyxrk2QlcfqsNH4lvNC0PlWIgb2hhN6c/HUP/?=
 =?us-ascii?Q?mdit9EpnnPCLKtJ9r2MeiWAGZy7WKNxAPstGjQ74y2k0Npc1MT5NESgVVEqQ?=
 =?us-ascii?Q?7VhBXIcpeP1ejrEdn4a0iM4AFL7+1oxJCHpg2+RYwjcJLyvVIkQgToJ/Pm2F?=
 =?us-ascii?Q?CVP9H8nYGyA3aQIY8YbZG5es8EhbgOhftDdZBW/SnKFyVsXLoVy7DpBe3/EG?=
 =?us-ascii?Q?UgdsBg2M5gUBl367mqoVTQjiEAQPkEtpvo+qV2Yu1OfVErW8duZYtjP6anl2?=
 =?us-ascii?Q?gBfkL3+hSnupH0VuuId3uRDqUzfVl4dVIL3pcf870eoC33UmtzNkIYbMpNpK?=
 =?us-ascii?Q?kN4C6tfstL95Aow5/muwBD+cMAdncOlIk+cyn+vg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d9ebd4-826f-46cc-4ad6-08db1be9b83d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 13:18:03.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtPbbnWCo3WA8eufC0W9QL1Jc1PRbXP0YxzoIXyAJIPSN1omOsFzw2VmFc9by+jC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 08:19:29AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, March 2, 2023 1:43 AM
> > 
> > If Intel BIOS's have populated the "satcu" to say that ATS is not
> > supported by the HW when the HW supports ATS perfectly fine, then get
> > the BIOS fixed or patch the ACPI until it is fixed. The BIOS should
> > not be saying that the HW does not support ATS when it does, it is a
> > simple BIOS bug.
> > 
> 
> That is not the purpose of SATC.
> 
> The ATS support in VT-d side is reported in two interfaces:
> 
> 1) "Device-TLB support" in Extended Capability Register;
> 2) Root port ATS capability in ACPI ATSR structure;
> 
> A device gets ATS enabled if 1/2 are true and !pdev->untrusted. Same
> as SMMU does.
> 
> The main purpose of SATC is to describe which ATS-capable integrated
> device meets the requirements of securely using ATS as stated in VT-d
> spec 4.4. 

Then it should be mapped to pdev->untrusted and possibly
pdev->untrusted to be enhanced to be more descriptive.

iommu driver and BIOS should have no role in security policy beyond
feeding in data to a common policy engine.

Jason
