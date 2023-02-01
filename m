Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39CF686E3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjBASjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjBASjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:39:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B991F125AB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 10:38:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtcMcNYD1QujZCbQqCz6eKzveoEy8NvjycpjHEDClDsBKnzRiaY1qvPCS832fP36AIEsOSpG+wvQl0/SZWgQEYVW9/dGFztcu1XO3Bw4PdRgQ3Fshg6wXuUSCUleditsfYvru6xLeQz4h/vv3dKjGoxUEOlKOYzxfXEyT6oNRphHppGDqqmVn5YX9ldyFiyWxf24t82knh9JqompBz0w2H2W94x7NcAFMquEbWgXo8kcfG19IMinOBCdlTg6NoLwntfcXk7wqwK8qKJ/x0tya4jKzfaKjaKqCy3MHrwTvFOZAZWq3eO2K/rJvDAQRmw2eJA+ZZr32MWFioX5KYDtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqGlX3RovztdkxN334ojDrJvkQj2B4n88xgvNVUgzRg=;
 b=COUYMjWpv/H+Ame8DstoK4hXJDBumEF8aF7dPyII9BP9Ch9Tr+3BmieLPftWgwis6FZ3Ny7Hb47Preb3DwwO0g5DfFolE1nrSVfwBOf81OTQtl08fddy9TgaZSho4qWLWyWMqmFaElO/8EYgnw9wchZcnBR81V4k9hlbG+VQL2texy3DG23EzkFnocjmTELkOLxdJiPOZf5YNZeHTdO7mKYRoXqexhZTfesjIihFc5hifX2WLGG+s+O5yyNnwHqB6zKgjEcJMbLfe8FsTuFIO+qv/rmJU02GUrAOA9fE7xSDC9HcHZML3E/Nh52phIOmXi5+FIvGmW5oLK1LdIeluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqGlX3RovztdkxN334ojDrJvkQj2B4n88xgvNVUgzRg=;
 b=YFmXS+sEXB+CCBQBNvCtQB9uhEOmq6hMFgUVpM8VTaaqh4cP90yGOm/LHfrBmASWW1Xy0yUiouVLJu8oiqZ0dHgFuyqPaMQ+cz7RWNr5RDKpjecV6UhuPOtf0I7/CrzvA4iuKuAn9ciWshfFB8wLCc9tuSmwSGLTvjXqTLaSY2JA6uxkHkx7nf/mGvH0YiWFKz8eClzaYkwDV5jW4zOXGGhYhHOJGB2sFJS7qwsyVYTpazzKHNqYuwrAtpf5NHhk3i0+uET2zfO0oVPr9i63/EZsgSXuijoImo3qcuTbl1lCSVwfQkw0mYzDDjzj6MsZfM6/DbU8uHsCbpkeRk1wyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 18:37:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 18:37:43 +0000
Date:   Wed, 1 Feb 2023 14:37:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9qxdinaS6anoWhH@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
 <Y9fcAdFxl7GVSH9r@nvidia.com>
 <Y9gaKaMKOf+P2NtK@Asurada-Nvidia>
 <Y9gfbx/fszb0aTJn@nvidia.com>
 <Y9gi0UaE1PlKVzmn@Asurada-Nvidia>
 <Y9gqFwDNd3VKQvC3@nvidia.com>
 <Y9oNSUbDe1YOTj+b@Asurada-Nvidia>
 <Y9qK3nJHjU4Bvxaf@nvidia.com>
 <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9qlb0SZWEpJs0v1@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 731413d7-38e1-4eab-f8ab-08db048367bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lxV5CuVCjCHqE430JwIXKCeirzfajceP/v3wMOOSYF81Ag9Bnm5j+HeAKWn2mCuH/5LIwGQ7ugJyHU1RrpbIMUUPdlXo477c6yxT6rjqriJNvjFm3gqhN/uGT23T20KLxw9JrI997Yz5O9d34lBmqrgpPDu9yGOhtonSwGcn69TCucQrjE3gWrM2nUGfM/Yc9NEAV7K6RYmsnkB0YpWhTDKSdrgzRzHmriyVQ40hHda7IXLoOQqUhUqDZiiJPJqMv98wGg7XQTImJ/tVjGISwXix9wkRpuHJ3VmFhXbWCSg2A1g2FqXOeKOj30er6gUv+jC/U/4RGaN0mIS8RdZqgGqYkqi2lJPAFeh4QRVJ9AwQJLpkDM+eNXKVOU9Ve+2A4MGaNTRBkSMiXqnCcfEKplZSFPa069cC18olEa3tkosxb4Lgbhg8wuC3kJzOPI2scwexL3W+ezBOmhtN3Fw4rwnZNOK/eFlVFduTnXmFhyIk7cru+eD6LJd7pV+U16IiMd53/HIMZUZZeOiD5ydSyaob/+wjj2rTUxvApbmnKQvVZLsbJ9PfN6LuDIR6KCJ56s+sqemV+bSaF+HXJVYcgunBJ53Ey7bF8WEreTuCMUWkT4QMxlr6It3d1B1CbU4woMKI6pqjM1CKqO1b3AK2xQ1mC7B17VfG0QTkGGqNQSta9Fwdnhmi7XmYPz3KBJPR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199018)(38100700002)(6506007)(83380400001)(186003)(6486002)(86362001)(478600001)(26005)(6512007)(36756003)(2616005)(37006003)(6862004)(6636002)(8936002)(41300700001)(2906002)(66946007)(66556008)(66476007)(4326008)(8676002)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/tzN+i15uwI0lsRR4hhOpXp+TaUrxFiNFoRBLeb1iX4tQr4frHdK6l96FI9?=
 =?us-ascii?Q?kXSACDZy3qjzTm7LXSjfDaKBNT6EGdJzD1Nj5pkZeWX/2kHVTyqB0IvWhWBS?=
 =?us-ascii?Q?yVKxX/GUidCZq0aDVNAVqSXfdukiUBhyygEi/pnqxEiAWgqAwYDM6qCHVrxR?=
 =?us-ascii?Q?IU+IA0EKWCWKcKwPpZ93jtjSJrtvYpmgQnlS9MjP35LwEcPwO0CH9V7twBwC?=
 =?us-ascii?Q?l1+4+qso5OQKcXGICDJ70HwZdcjpKk3pEPawtO+EDqEaxYkOf4RsKc3KJNrE?=
 =?us-ascii?Q?i0rVHx4EGZKgA0zW0+ua0++gd+8AUU1rFLM0OCJkY3i+ImfjpHYr7iFOXmks?=
 =?us-ascii?Q?m7KfoN6Tm9l8tfdbTHZRs5SLx0qoXS9PIblPgOpGXkUHemk8pzSSHK671iJt?=
 =?us-ascii?Q?34OXAK+BaU98CY7xKBnvFdzhToeloMcqunQ0PC9Bi9yuGgV1JQCAEHn2d003?=
 =?us-ascii?Q?C3+biQgWeYdAwrrKvMJULBHn0iYP3xfgCc2xZY+SEkC5oLtCVKTPWeZtDIll?=
 =?us-ascii?Q?b4F6fzfsg8P0v6rGvb/P/so7kPowGaKB3wpvVtQxCNzekISnx3aWcTN5U8oc?=
 =?us-ascii?Q?z0CNfMkCfWQmq2PfZF4LyFI891JfxM/H3tuHSLuVjTPcontUwdg8GVuksdMR?=
 =?us-ascii?Q?DlNYMvNusiApCXJoIG3kO3T8Ct3603xGGccebBd65ZelQNzD38BrGJEuuEPU?=
 =?us-ascii?Q?n3CbH8rAtejskvJiW+ManeLP8hqt+Ci9ycCp4/P5YKBSYHRqpMr0VCyW/vP6?=
 =?us-ascii?Q?GX4fEB1nIzdW97Lg5LVufuA/YcxAJkMOCpjchrHuhQCaicoXtTHFHgZ2S0B4?=
 =?us-ascii?Q?oUTjsI020Z/iMaAoOUfyi+54VYkergHS6qPaRLMDln59sllnXuX3u48eP6+n?=
 =?us-ascii?Q?NWbKWmB5KB0HK3JbEUfeAC8iL5/mg74qS4YhtH1SAyj1EkvlOzj9yQB3ga5f?=
 =?us-ascii?Q?RsVcmbIVg+HKMFPlpURbsXTEENkuW5tY/RFJ6/DQKcTe9SrbqKnj5FWQ3M5y?=
 =?us-ascii?Q?TUZYUJ62MrgIDRgl8Gq6Z3tn90Qp5012LHxq6pGqG67n6oWm9aMuBRFe9q2e?=
 =?us-ascii?Q?IUr7I4kh+zpu3moXdWfwoisasE9DoisKNt36o7HJJ/WpsW+MH9cNrbWi8YOX?=
 =?us-ascii?Q?WcoqJPGwviNdkwpicOV0klxkXmP5+wsZYY32TzAj4okwI/uCK8JnePVCF/qU?=
 =?us-ascii?Q?pIDyZ8RAFFHtwiuxKiQk7xMEDcXN8ynVaXbipSkbKgI+2lsHt3HKVLUdLrxS?=
 =?us-ascii?Q?kTr3+a0OHM3xv6DM9L/tPgj7UZ6OFh2mbSjftNhhiSJjuruAjfSew5Iv0EDD?=
 =?us-ascii?Q?cRrUaedE8meK6gT/xBZlXuH5DZaEg5XUWYH9SMksN9vmXt6BMt9FXQF+PNCw?=
 =?us-ascii?Q?VvoZCgVPL0dlBGGumarQLMmVOkOeDXO2nWzqxn3j3kBmcZR04Mdr7TJw/zTq?=
 =?us-ascii?Q?5f8l7/iIhIgqSqoV42C0oBkXgYJK+QTbgyLm4dxdxjiFPnxxcmxgMV/P3j60?=
 =?us-ascii?Q?JNKuafyUnCzCyuexy27FhHZZ9QEFVYPiRw4xw/XmWNfAidd2zUv7nWUCn9/Q?=
 =?us-ascii?Q?oS1kBPvREkX+PrQOiXpUBich/axf8VmSG+hB+pl9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731413d7-38e1-4eab-f8ab-08db048367bc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 18:37:43.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WDdS5DVBU8S9PoFo+H7bM8YcErEnnsQ6EtktTZUdOYxTuwwMI7xcX4wYJxe+RLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 09:46:23AM -0800, Nicolin Chen wrote:
> > So the issue is with replace you need to have the domain populated
> > before we can call replace but you can't populate the domain until it
> > is bound because of the above issue? That seems unsovlable without
> > fixing up the driver.
> 
> Not really. A REPLACE ioctl is just an ATTACH, if the device just
> gets BIND-ed. So the SMMU driver will initialize ("finalise") the
> domain during the replace() call, then iopt_table_add_domain() can
> be done.
> 
> So, not a blocker here.

Well, yes, there sort of is because the whole flow becomes nonsensical
- we are supposed to have the iommu_domain populated by the time we do
replace. Otherwise replace is extra-pointless..

> > Is there another issue?
> 
> Oh. I think we mixed the topics here. These three patches were
> not to unblock but to clean up a way for the replace series and
> the nesting series, for the device locking issue:
> 
> 	if (cur_hwpt != hwpt)
> 		mutex_lock(&cur_hwpt->device_lock);
> 	mutex_lock(&hwpt->device_lock);
> 	...
> 	if (iommufd_hw_pagetabe_has_group()) {	// touching device list
> 		...
> 		iommu_group_replace_domain();
> 		...
> 	}
> 	if (cur_hwpt && hwpt)
> 		list_del(&idev->devices_item);
> 	list_add(&idev->devices_item, &cur_hwpt->devices);
> 	...
> 	mutex_unlock(&hwpt->device_lock);
> 	if (cur_hwpt != hwpt)
> 		mutex_unlock(&cur_hwpt->device_lock);

What is the issue? That isn't quite right, but the basic bit is fine

If you want to do replace then you have to hold both devices_lock and
you write that super ugly thing like this

lock_both:
   if (hwpt_a < hwpt_b) {
      mutex_lock(&hwpt_a->devices_lock);
      mutex_lock_nested(&hwpt_b->devices_lock);
   } else if (hwpt_a > hwpt_b) {
      mutex_lock(&hwpt_b->devices_lock);
      mutex_lock_nested(&hwpt_a->devices_lock);
   } else
      mutex_lock(&hwpt_a->devices_lock);

And then it is trivial, yes?

Using the group_lock in the iommu core is the right way to fix
this.. Maybe someday we can do that.

(also document that replace causes all the devices in the group to
change iommu_domains at once)

> I just gave another thought about it. Since we have the patch-2
> from this series moving the ioas->mutex, it already serializes
> attach/detach routines. And I see that all the places touching
> idev->device_item and hwpt->devices are protected by ioas->mutex.
> So, perhaps we can simply remove the device_lock?

The two hwpts are not required to have the same ioas, so this doesn't
really help..

Jason
