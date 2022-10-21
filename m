Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A3607A13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJUPEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJUPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:04:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90C495D3;
        Fri, 21 Oct 2022 08:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToW2ZiHkDTfIUkwJJj4080D2g68CQo/mz9rgz+2HS1x5VkkmIvyw796Ifj5A5QhzWyo/l/t3nKjzxNYIiykmBtm6L1flg5bJwb0E1pJHicviP5cADEB2mERikI8ad59rpbA8zz6LZLx4rjKm0gPiEfOXg9unZV57o0k9tw1+k/sP41ksliMGDQqHJP9tmHRh+G1g0Qq0Z1YebD4ZwmcSjZ/IDf2C5mYEH6Zsnsje3mGWzeJp+sjfJeN/ynkiglEnPqKpqQ3aSm6ceTRBqSy61SATWr+94rGWqeCebQwHYrsEYyUGiu1Y0ohRfPxHDj++WYpCVAoPmFhqXjD9VLtT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0XoFxYJ8lkvSQqP+NRor0yAzQL+Pvth56++3KGJMp0=;
 b=kd9Sdktn23zJlabCukX3nRO94Efap2ejCkcEM9J79zZqh72ar5UJeQlCBfvKQQpCD97uE3FbefOr/YWMWy4cw4WOYchUu5K7nFMVyYPpa2hNgI/EOT51deCoKFiNVvsmbe3//8dGWxunIrgLCZXcFQIzy8WIMRwcm71ipEVShRELbFfVftflCzV/gb5V/h+euIWicvQ9DuZcHGcGZ5MUZmbl+sMpi7mQ/H6Dpi10nPHaQ8XksSC/cLaOVo2arC9lu0OVaqBp8j9kXhvi/0tXzwmZtM1Yoyf1T2gGCkzpNvjfArLtgdNXJdFtBHb4x9VWG4O5Tb25CG8ReNY6Fuxh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0XoFxYJ8lkvSQqP+NRor0yAzQL+Pvth56++3KGJMp0=;
 b=Sw79VNyps3Es3+x5fLJ3GN+HOUWEifAQ/jOxZbm5xYiG0njocLlJYkEsD9BF9QUioYMz8EuHoejBpOaLLTTx4K2BRJAjmJqx6Fjf2g7uxDRTgMWipRFxVzmxlwTMYwT8ticuCDkV7lyHs3UIpc7byJBR1cZOilY9wxwG2vrezgY+O2uImKftFxIWHJzJ3vYaScCD49HeYTl+Q4Tz1g1fXZ8Z6G0Pn/lNFnZNZXFfrfHA7bYRlx6KgxAnrjwNSpELoWKdtRT24sg+LuighL6vZt3RMiCHx38rOZE+lfflzCzfztpz4o7zC1WqX+mwcE4JxwNGmZB7LzBN5ZXnxQFj5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Fri, 21 Oct
 2022 15:04:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 15:04:35 +0000
Date:   Fri, 21 Oct 2022 12:04:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/s390: Use RCU to allow concurrent domain_list
 iteration
Message-ID: <Y1K1AqVWEyY0/Uqy@nvidia.com>
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-4-schnelle@linux.ibm.com>
 <Y07Dz/NROAMI0Hku@nvidia.com>
 <8e268ab5e0dadf86be5fd7ffaa9debb76cea67f3.camel@linux.ibm.com>
 <Y0/lMCQ8oeXJ2HTg@nvidia.com>
 <f3551bb461b3ef3cfc1a0c644093816be1835b3f.camel@linux.ibm.com>
 <Y1ErcEe82yjJI+ET@nvidia.com>
 <68d91d7a5aadbd46dc34470eccd6b86a84c9e47b.camel@linux.ibm.com>
 <Y1KgX8EwH8T+FgWC@nvidia.com>
 <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a748fb5caee8be5d91806aa5dfd131e92d5d82.camel@linux.ibm.com>
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: 779ee8a8-e08e-4a04-bcf2-08dab375914c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eZuHEIj8dyqs0sY3k/o/lRjiB++BECVs1ecH7KIaQg0kkbtnjIZFU6YXKNseCHd5dZZhAzm9veNQl5m5lZHijIgLmbNpynZYFz92PsLj+F7AZpqUQBEKMt2DUBl5kH2AeCEf4yxcvee0jdfZGN+qSjsOsYl6+dWRtOmvjotlSUpxj9ZLuAvWyaMToA1+JbzcHwew9vdEqAf1J7wtOTFqzmrnhH/il3kkvxbLjlk9HQa/ujKI+Plo0IlnU2qB3CFpb7D2hrM0LCCRJL2KxFugOdS0rZT5/08SL//Cab6Azo/NRYioBHSAr7udPHUM1//k2HLHsBfENLICDTsh9JOUJ+mnWVtBDV+gb0VrsU/c5vxIYkCAF3zbM3+H9iqAP0COiEffEFLIAcN0l4sGJ8nQV6s9CWv5muxFvzm4ErTELwKCR7RF68oRCMlZP9nZFAXi1ozZ5dR6eVW4YUeBomloMVK/O+YJsSGMj7asXtaM/1bfaVo/EV/gFTzLCOmEvY5C5fxl01Xgpf++LTay+I2tZ9jKrA08pdFQQy2TuK8u4EfKDQ52qH8QqSnR75UDubC9Gwh5m+jKFO+3exqAwKzRNQtXJqgDWd7GJGxeZq0QXIvuXxaItWH/z0O8Bdw7dv0kIDfsJbm5t/eUDgVF3XKNTT7frjfmgbdzky43G3v8f1W3rIVozUpy4jeudGm7pNphA+wwZNArgLMdbO7Em38dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(478600001)(6916009)(316002)(38100700002)(54906003)(6486002)(66899015)(8676002)(66476007)(4326008)(66556008)(6506007)(86362001)(8936002)(41300700001)(5660300002)(66946007)(26005)(2616005)(7416002)(36756003)(4001150100001)(83380400001)(186003)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVQ4JnFqo/RCvi52QAQ+pC2ZQs3EfMVAUOjsBbWQbDKSgms/SAXN+263gmG/?=
 =?us-ascii?Q?K/9xhHyovmjUjYei6F8ghVf42GqLSzaSVJ2D5G4Qk7jDEoxMKz5xMwhb23mW?=
 =?us-ascii?Q?bkvP4ghtsNjKsxjLqd43TcX0VsW5ZUgAhW1TfDTtRNZyigcrxLqJgZoSSPmD?=
 =?us-ascii?Q?1O9dhfTTa6kcb6D9eWOol97sR9+GuhGfgQ0HYsBpaBOzgL8el94QqZe25zI9?=
 =?us-ascii?Q?H9VMuAn2Olhao8NMV9BxZgcwyVoj+qKkNY/x6SR6++EJDpmCqT6A/dTBiMzs?=
 =?us-ascii?Q?NN4SqPw8j5bMXMXtCAgGblHVOKFtcOksgOBGZDL3oF9A8Bbw2tKR1M+TLkeL?=
 =?us-ascii?Q?WsEJMwmHSQ1TcRT44JcTtpIveSbeCLsOE8JXJAgksqrV0CwzpYXJ50Ec5bN2?=
 =?us-ascii?Q?cWwKqSB/RyUoYdmMFVB+UM/h4Z37GheltMvzjSYgF9AIMzLRTKGZ1i2+Qebr?=
 =?us-ascii?Q?EH6DT8UhvoggEv0V5/D2HtNby2RtXuSzrI4quWyL15oZgu1zpY3gEHC6Hn4/?=
 =?us-ascii?Q?h2fkP7fe/nufOkQxQiAdc8/y1v/Xq285PFp+COzsg8IkrsrfF23jnM9DXWez?=
 =?us-ascii?Q?CjtaExZX2Gv+RUAQ+GP1owhLwphXxaE0odhnrhuRv2BvUBDooTB7aaMhMahq?=
 =?us-ascii?Q?38ds84Afqwt7QwUtj6z8ZAamtv9hBMNU5PPKd22sjaIdyIxzsW3ioreaT7E7?=
 =?us-ascii?Q?PeMm71dELolDmBbXHmusQXBTqYVhXdLAJJ05Bpm4wO3oO1ODbB71E+xHbxM7?=
 =?us-ascii?Q?DqqOfqGnVeAEJvAaijMvl13XOnQri2UlkmwRKcK0iysjdkOQEv0IUXD2rwb0?=
 =?us-ascii?Q?yyxt4joHfhxoA8+j3NQR98WygcMW29ooHIJf1cv/JKRbYdQHVqAz9nAHpUhF?=
 =?us-ascii?Q?5/7mZJZ3rarfkAfH+Nwd7U5a1er/ycQSWYnHxmzyIp0g4vfqXlIhUxTi/2uW?=
 =?us-ascii?Q?ahygkHKfsHN0kEWYV61GW6fTDh8F8C7jFXcF8+EcIB9TGfprwZmvhc7Z2kNU?=
 =?us-ascii?Q?jH+vqaqA3zsXzZW+VXx47XcYrFTNL0opRJ/hgGaEq2/gildTGYxa2k9k3hT4?=
 =?us-ascii?Q?EBEBiCgGXrAdqsyNDEAiStm8N24yANa1+VMElyTmL0ANvCzhior9LmhLcRh+?=
 =?us-ascii?Q?WUNX1QT1O74jSWkcLmgqAYluS/rxcmPxQqZW06Wc8q6egX+lBLpn35K+Z6X2?=
 =?us-ascii?Q?PjfwCqdHbe/WLkookdEMGxoIH58gCrhmPBrTi8fgHNzMTgp4z58P3l4MGM9f?=
 =?us-ascii?Q?yCpepJUkezxhmJ6X8ykSSYSewsWy0yW426zyYrdShfAkCr3SPXSR5/cIy8qk?=
 =?us-ascii?Q?/TVHnA4KVFNGVXLfzb8i0cUiFa16aHkTqxbQIoSLqVIPAN+NfnM0TnG7YM0v?=
 =?us-ascii?Q?c17HPeyu+EgqCnOCNUohVvMLtTWtIkBoEXUZiO7253xMi98ZKFoU31QlCDnj?=
 =?us-ascii?Q?KEHjJP2GcuWQGmx+qwoMgipKqtbALIweODwImwUw8PsFwvw1SVJypXf5bn7o?=
 =?us-ascii?Q?30jZvdKYePSALstWLG7zdB4saw7ntftU/X5N669inC4EILwRHN4r8yGFjwUk?=
 =?us-ascii?Q?5dr+KmTyjZdtWBYVWIs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779ee8a8-e08e-4a04-bcf2-08dab375914c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 15:04:35.8179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwryufGcVIgnNnjEkBTOEDfOMrYRnr5CDp+rZtMEGYltfSek+NaiRM2rShHhiI7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:01:32PM +0200, Niklas Schnelle wrote:
> On Fri, 2022-10-21 at 10:36 -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 21, 2022 at 02:08:02PM +0200, Niklas Schnelle wrote:
> > > On Thu, 2022-10-20 at 08:05 -0300, Jason Gunthorpe wrote:
> > > > On Thu, Oct 20, 2022 at 10:51:10AM +0200, Niklas Schnelle wrote:
> > > > 
> > > > > Ok that makes sense thanks for the explanation. So yes my assessment is
> > > > > still that in this situation the IOTLB flush is architected to return
> > > > > an error that we can ignore. Not the most elegant I admit but at least
> > > > > it's simple. Alternatively I guess we could use call_rcu() to do the
> > > > > zpci_unregister_ioat() but I'm not sure how to then make sure that a
> > > > > subsequent zpci_register_ioat() only happens after that without adding
> > > > > too much more logic.
> > > > 
> > > > This won't work either as the domain could have been freed before the
> > > > call_rcu() happens, the domain needs to be detached synchronously
> > > > 
> > > > Jason
> > > 
> > > Yeah right, that is basically the same issue I was thinking of for a
> > > subsequent zpci_register_ioat(). What about the obvious one. Just call
> > > synchronize_rcu() before zpci_unregister_ioat()?
> > 
> > Ah, it can be done, but be prepared to wait >> 1s for synchronize_rcu
> > to complete in some cases.
> > 
> > What you have seems like it could be OK, just deal with the ugly racy
> > failure
> > 
> > Jason
> 
> I'd tend to go with synchronize_rcu(). It won't leave us with spurious
> error logs for the failed IOTLB flushes and as you said one expects
> detach to be synchronous. I don't think waiting in it will be a
> problem. But this is definitely something you're more of an expert on
> so I'll trust your judgement. Looking at other callers of
> synchronize_rcu() quite a few of them look to be in similar
> detach/release kind of situations though not sure how frequent and
> performance critical IOMMU domain detaching is in comparison.

I would not do it on domain detaching, that is something triggered by
userspace through VFIO and it could theoritically happen alot, eg in
vIOMMU scenarios.

Jason
