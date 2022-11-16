Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB262C737
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiKPSGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPSGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:06:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891AEE1D;
        Wed, 16 Nov 2022 10:06:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkWJuyo8RvJ5qFJz7MlrwBHe9MG9yufYpdI/H28aBVBt8vNN5SIc5cjbiec6VFgyYThzMg8CwvFLekwOnmgLDFidi/pw9PBakVfsQgHfaLgqk/9++JBFY2cpytGJ3678ZNpNRIkVYApzhEgN4OT+AlvTktML6OIUpnnwwcWDe+e/AWIgERTVujytMj9hzTa8QeVgHef4DrYLjAz+YG6iWEZZrx+DjLNcuesN+OfR6mBTD7QZgMjgod5uCO2eMYmGNSOiQTFy6ewBYyDvWJ/nkmkRKr47vCVBbMQj8BYLbzaANrAKACFxxHR48SzZIXDdnFMoMix4w74Sqo+ivcCbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAUtjP/T3hM7Ta2wpLbIvyHHfK4AYDTR+nFn9jTQZbU=;
 b=gew+QIFX3xc83nu0lvLuk20rS069b5DM79FY/q2pnGdv13AQH99f1U0KuaCCEJCjbHEIDmFG8f8M95/nwT+TKHZYoekjC9cZ4GTLaXVI8ixP/sbJqHoIn+CFmuBauBkiPHY5N0Krhw9Tc/5AnwZwLTVXZGQImnEwPcD5TdUQaftN5i51NO7sLZAZ7Lexm+E8TiXIg0EQIzX9s2vFteD6t4LP4Y0Z+5kvDtsmtHJZD01+rr8P1T6lkVyVtgFoqPa0JjWXMp+d2LPzuuskOdF1/1NDW8bN7HzbnXWvXj04UQ3B2FcmKiJ9/qCeOZPEHQWERHYXGKeCx8k2gfqji9pJug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAUtjP/T3hM7Ta2wpLbIvyHHfK4AYDTR+nFn9jTQZbU=;
 b=pwalP8OlR7XAX3PW/ZtE+O1tpHfiJV4twUMuqqrHvkRM0iAbVa7Fel4jBPqZHaqv///ZRz3r5Lee2OLf14X3joGXLaTGbAdPhzh1rGjZk9Au90lXcfBNpUoADb0KPyPw1r+8EidkKtJgP3ni8GuhZU25GW1qu0/xxg8JFIDsg8vhlbvNM+KFXmdqkqEfJcwE9nguBwX+CMqBGkeLqdUHlMCIKFf4mLqDl2/sX9LdiA749+C7lXFVwcB9Ml8J9Gw5HJAiY15xOquHqoNexYK494I4aBY415Wf2cUs3lYZwe7IqSOwSHjdvJJSDsCdhuhUjwuGvlggNgjqX8tUBA0ibg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 18:06:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:06:01 +0000
Date:   Wed, 16 Nov 2022 14:05:59 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 39/39] x86/apic: Remove X86_IRQ_ALLOC_CONTIGUOUS_VECTORS
Message-ID: <Y3Umh+Pa1WSJ33fD@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122015.865042356@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.865042356@linutronix.de>
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: dad55b0c-1a9f-4ba4-ff94-08dac7fd3862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HpCFMvIyNFgC3ycJ2MkEtlDFn2cQkXeFWb4+OMJO9kmVLWTmMFvJYE9JQX5gF7p4EYYzz7ANoXQn7OvNHYcYMnQxErbEaZ3ylzzCCRGRtPzOa0xVjuWT0AKFko5OWdWhJZgPIpwbaeHHeY4u6IPBf+Z59mbxJhj0uDkkCH4D0kRwAJIJRjk3DxISzsf1vqREv96uXaG7EcLgqpoPH6JLO4cscHriG+vavkFecFr32l0B2BrCBnNLSpJpgfPUFCpsbxLl5cTKflWgSoFAW7VCH4hyJKTHvFgOjPaaDkFRoNPkcY30eFfp9qk1I9KvEbvii/1ikHW1bA46rmQTl1mZOHlFfldp858kx3uQ9vvx/68gkAi0WpPSTZxar7zRq11evvvn7bAFkQ3ksgE2+26Ep4qjGA1gaNCVTkpEiRz8cKiuPoK4Cb5gr4gG+PVAGy90oMH2WX3Lca97x0KnDG2iWGX2hvfYYvw4V7L3T7676JoQaumjApUNZgd0WXhEbVou8OWuwacL38PxdkTHEJCCn4ka5gm/T0dwxY4kEdmc7K6RVvVU5MWHnVlgq8LibW4TG89K1qyeC05SmXx6P8NExPjIMjLIOpZ2gYnkD4m0k+2Ymbnh71aWPyw3/fgH5MVqAFqOsHNurgdy7+6dsJb8rWUcjydZoTheosGHo3yOeYT/QELh8QdBZUkB19a+CsqYZ65IALxteYXEJU+xgLm1wilm2eBP6vQ1LXkVApDtC//lr/1ZP7t3GPW6Gie8XGHC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(8676002)(4326008)(6916009)(6506007)(6512007)(54906003)(41300700001)(26005)(478600001)(66946007)(6486002)(66476007)(66556008)(316002)(2616005)(86362001)(8936002)(2906002)(186003)(38100700002)(7416002)(4744005)(5660300002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nf3J1mrEMyRwxwMxrkmswE74DKJoLdfLPtB1Jm6d6T3MxXN3XscBI6whH6pn?=
 =?us-ascii?Q?tMxFnlp24Uong60aRxEmHPZm7ZxBVEnbeEbIWCHoyobusJAjPeByhXq17vM9?=
 =?us-ascii?Q?QYQC7DAD0I5vxPvdLEm1cBVLqn/Yp9+W9Lvq/rC3WkRCnRrwXc7r/3CXGAop?=
 =?us-ascii?Q?Py5nbBbUotZPaxluILqiw2jrKLvLbttdvtjUx1be5gohsAbJ/WGe1MqlrSDc?=
 =?us-ascii?Q?XwptDjmqp1PDLYggoghcWqlB+Ta1xW4SVk1goGoteQJO4+UXOXNHrIoPuIpq?=
 =?us-ascii?Q?eaRMzaqI0fpiGMMbkTwLgBw86T7DxdmqWo7SLlkGvqHH6WlKAO5F0CfexEzz?=
 =?us-ascii?Q?1seMR5khk8R9+DZvci1UyS74SwaYtTyjdRiDId7/96At2FCgUC35SKvLUiZP?=
 =?us-ascii?Q?+hg0Ct4vEVN1nyrFdkXHXFIwY1Iz1qub750IXrW+lZehKM0WrhkD1cxz/Qvz?=
 =?us-ascii?Q?Iuq2JwXGGA34MBuPBoQSbdlTws0H5hyEKa4TPLkdWtjd6ykpYhTSIP55bL8p?=
 =?us-ascii?Q?TReu4mlvdOBPpGbweuYcdvs3oyFpjMdN0wiSLZTYZoxdG4QePN5WZxVJiZun?=
 =?us-ascii?Q?dwdYUxg/13ZHw/2iKnw5KRhBoiv8OLWfU669Yjeg+EhmooP1eXkOx6qoGUCY?=
 =?us-ascii?Q?P2yZlbHl59binSEmMgCtMxCfg3nRRgdnD2KmrL/iTozSLqOqKyU2oelnrvDm?=
 =?us-ascii?Q?NL1CAF/+Ya5/Dkx+MZl9KPLWhuqh6tHLlZFQoBR6hnw5aaS5uPKt4fTgubci?=
 =?us-ascii?Q?q9tu0DxMoFnkNOD9nBtGb+A58vT9O3N3e+wFxSMX1n7tV4IDc0o9ANxV+QDv?=
 =?us-ascii?Q?L/p6WX2uLDgZdSfkkXz2SbUItjxGJmME0oNFyGuxadnhLJhoAO9TqQLKiGoQ?=
 =?us-ascii?Q?3PtsdpwQABM0gsBwONHA7/zyOgHyc86oyEs83ANE8iPTYttSDHfdU7toiKKE?=
 =?us-ascii?Q?wMwDYnJrTZcGrOKGAgShDlTV77GFYdVAOTNFzl+EQYlUmVL4aLyDb64WraoB?=
 =?us-ascii?Q?kw+FwOm5TJylAGJlU/Oy4w9OH118IwmgWkGrGnuv+PctRVIutHhq32oNH9vo?=
 =?us-ascii?Q?9z3F8fAay3bCwTpxsgu18jOn0P8CASWNF6/jAIxamStom6TH2XWr79cN6rsC?=
 =?us-ascii?Q?BaSB3wvvCdi0syyFOBne0lr71ouNHWFG38L4ikMp5RR+6XjqAjBIxiZBraWQ?=
 =?us-ascii?Q?fsrY89Dp3b8+xpRUZ1Cjv5QtjQcnEz7WKCSmCQEcQVlLC/v32Oer4R8K2PfV?=
 =?us-ascii?Q?edzbx+A+iMQBdWjBFM6UBGEQ2K4K+1NvOEKwaqYImBt2LxPNn0EeL/tuozx6?=
 =?us-ascii?Q?Zl660XNZqBxXNprmROBh6M4XsFSp0unuJ9wzMJMAIBaGJJ7mPwvoT80nxh3B?=
 =?us-ascii?Q?WWCWISmSBczyYzWgGcEZzaeUPMctghYlEA7BXLtlCvjupjG6IcbXhig8WO7k?=
 =?us-ascii?Q?jC6e2lusFglF1QtqrhEW2gWiexJjwM4UJXTd9Y3u92qFmZOtjvjJqrjImUOv?=
 =?us-ascii?Q?OirjfGoVwwBxLWTqkE9ocCUtHL4dK1BLCGsAqAw+m2GIAE9aaoBa94QniI59?=
 =?us-ascii?Q?V0X+ed4QGz1WYegBicroXeJ2DN8pdwQHezrQZhUR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad55b0c-1a9f-4ba4-ff94-08dac7fd3862
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:06:01.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xt5L//ELUnDMt2oE2KWiLsNGZIRfCE5W+cnCIkBK/mMymvZliEWXyhQF5lgIaZa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:17PM +0100, Thomas Gleixner wrote:
> Now that the PCI/MSI core code does early checking for multi-MSI support
> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS is not required anymore.

> Remove the flag and rely on MSI_FLAG_MULTI_PCI_MSI.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
