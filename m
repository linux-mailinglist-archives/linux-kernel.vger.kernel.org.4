Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D605FB27C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJKMen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJKMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:34:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C0399;
        Tue, 11 Oct 2022 05:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCzI2QO926ZOflYayCGRsRPSSH83yBW3s33x+2KvGe4VtVoW2Z2oWIJ/j+8ipiYS7DMn7iadm2JpCX1fvy72XkRcBaRv9VmK7wkP0mid0DvH2alLNznucXDotUaUuybE/AoB/noGdyOtU00p77yjOwM7pcOQDydVAd2B2uiIX5R8w1PYCGSJ8oBgxLlX0lhwRgz7vJF1z1SUX5KcCfGW7H3Waq6pp9XDmvUNNaekVh8m4Rv3pFmKit5zVMjPOUS85uE4xoZs4vhZs7mnUjLfktF61xE9Jc8kFKwUiW9Sk3yEROj/wLbcdzQhV2eyq80UU7QkYIeNrHtynLZvvFuhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=herC/DjJiHeEv40ZUrjfqwwqalMDb3xPo2U0Mj65jVs=;
 b=W4EIDlMQ4Gpwd4kFEz+6ZogTbGd92VmwLaja18qf5Jvje9t3UV8tRIA0ShJ/mB5W7Efxw+kO0ABofeUqu64fQ06yUY0gL/aaPgvIgGPULubJRgQLeL+dqcRfhwsPE8LAq7MqRsU07UTw7TF+OF6F9U5ts1q4DEaznp/73oogp4H7f8bwmbCIdqJhjQ1p2fs1C9/eEfr2cXcCuDde4kqe5Bp42ioE6mhPLy6O3dp4279duBvM/x/wt1JJUTWnbc8Sqd0W+qfgvxqdCm2tKXj/2VhZ86H8KVwa7nIKQ/908qqeXmqXds8gJy7bF+3QGRKBziOwaL8nVPeJmer+blj0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=herC/DjJiHeEv40ZUrjfqwwqalMDb3xPo2U0Mj65jVs=;
 b=tgVY1ciT7vQT0hi8fvuLM1QaniY9VPEt7mrGQPWUbDVbh+vUBnCaIGe0MkkTKb24UhlKAeZq06iMzy5MmlWckGNZbTmJxoUZf4tpZ0LUjXirMCVZ7FYv+NnS1zJOJriKcgWBfqNLxYsiuwAbgBuWvGCw3NlJtnSbBJIvCUU5CdWSYBe0IkDtk9OkXG0+Ul8tl0bERvEHVHxtlF3aerMyPSwnw9su5IA0QD6Oa775C9FOtA76kRn1bo2MB7SIhh8IxUhf4T3Vm+aVv+3zKykCwLdZp5D1ms9AZqSoOdlYtTrgGeJlgs5y0No95p2kf+ry1BHgAcG6fivpFt286sv8kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4562.namprd12.prod.outlook.com (2603:10b6:5:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 12:34:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Tue, 11 Oct 2022
 12:34:34 +0000
Date:   Tue, 11 Oct 2022 09:34:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/6] iommu/s390: Fixes related to attach and aperture
 handling
Message-ID: <Y0Vi2dzYrMsACR1x@nvidia.com>
References: <20221007095005.2017126-1-schnelle@linux.ibm.com>
 <838e7df1128e52ac5229307dde6690c2e26b830c.camel@linux.ibm.com>
 <Y0RoXXclqRiMzN9T@nvidia.com>
 <fa42d70524225e37bd221f13276d8e75d4d711c5.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa42d70524225e37bd221f13276d8e75d4d711c5.camel@linux.ibm.com>
X-ClientProxiedBy: BL1P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d546e6b-541b-4b9d-0d9d-08daab84f41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUbr7jUBtlGcCN6kjnr22juYCHaVNPE1xanMOGLF2HNA6znxNRBG/vPGUZ3LJ5/OaWu7X0b8if0w0mbPfB8ljTrX//3v1rwdS1Wubgy2XFppPmnAPybpayuaUnya/2hB3w6n5C3pixsx9QaxLtX7UFkANaCWH11ZSBiFhd5kre0e7AQAHpkAoYChp2r6Dazc3GdFIsXg/e0apd9tXC5fnh8uY3kDoqPumujZCbBFv8NC+26XokpGVQ/bUf724swjGDFG71D9smLgPp+ljDevaO5XZQpykhmGav6g1LTTXkGmds8QRITQ1tBnuL32cDFwH9wH8ePXXMRCZp9oSI9ePsPIWkIB+kTFi+78l4rfLbTuMyNKkKssBQrhC8AbU/jQwWc3l3uJAIx8J9Lr8rA+ceV7UyAYWfmjI6GN7xdPZ2LX6e7lL32T2aZR4b88h6sf/P7b9m9zoEIGwNaou/CHma9958p+Kj0f5QXrljsRHhe6RRVizFj1D281vninl+C+W/IYNYPP3xFXHVPWYit7GK1LqS/ddOdqNYZcjhJetB2J2WV46DY09XOxPO8Pa6YurbIm4i1TcutV9iMB1jmpb67wWoCju3wEBbZjSy/90Weub/vOnOLjSgDxsNlXgzE6B0bSQ5d+iSJXHDTJrWH5OF9kZDazJMJ29K9RuRvpG9vTTW6y5JIYYksqypWFyS36YMOIWMQgZGvpe9Zcp8hLAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199015)(36756003)(86362001)(4744005)(5660300002)(7416002)(38100700002)(2616005)(186003)(6512007)(6506007)(6486002)(26005)(478600001)(8676002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(8936002)(41300700001)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oR+IpPj8GiMTUMkBg2u/37zrAbJQ8bQJFKOm+AWMP8XE41PcgQJr3dqHsbxI?=
 =?us-ascii?Q?Gt69RV62Jkx4Y95EpKKhgGxMG4tPj1RU4l7lIvpu68Z9X1o8mrtX6m3TmX+L?=
 =?us-ascii?Q?LQk1YC6yAp8bInZHXWbZnl9ES9GWm5ZJuQLBQYMiAzvXIiKIFlNuTMvgOGN0?=
 =?us-ascii?Q?B5ZE1neWlKPItw7fo2WMMj8Cbd5f7aY4Qh+vu6Zbr51PaUsS5hRFz097zUH9?=
 =?us-ascii?Q?z/y8pGWCxCGu+ZJ+J+AuDOEN/ghU9VbKt2dmJrBoKHEk2U8VSjkn9H4AKW5Z?=
 =?us-ascii?Q?fatOKT+X5SxR9jVnXpfeB8yy3Shi2YHbX0hAIMR1/6PyPQPAcOWRaimJQx65?=
 =?us-ascii?Q?yluDgAE1dXuMTVKP4tjMdNm5BJqL7eQSu6frMRXPflGBXKs0PqQyT8Ra05V6?=
 =?us-ascii?Q?UPTplFKIVwEooCdlGfYK3lh5p66Oufl83yJEML/yGndVohkLSxkszmWX3SkF?=
 =?us-ascii?Q?SqOONRrMVHrl4yTpxhPUYq80QVwOIxy7jZdRjasaLdctKRt5MNnoNy7O1mcD?=
 =?us-ascii?Q?nF3Yr9zcQI2BJPnFQipevZcRlBJtIRF2QwiEjmN+zZDf7GXc6vPto+4ZdeVg?=
 =?us-ascii?Q?Jap6vxftZQjwwYqq39aVWfPa5VrBMb5HvssSK75eP0MsX+rWOjrZnwGel2cd?=
 =?us-ascii?Q?z/HpSXBWtpyu0WjR2U/ZJW1w3/kav7cDigh0p69CjQXx5J2L20EpSr2R4yPL?=
 =?us-ascii?Q?c4Id1hiR6LAFKt42FQ3hhuwgWF231NeGuTcrzbBYz6vR1H/m1M+hjQT4Jbfe?=
 =?us-ascii?Q?7SPF6/3rJXczvPBrGViXUb54d5ZhXiloOTdEmLaPWAnscNyPzR5G9xqGiESe?=
 =?us-ascii?Q?ee0LgF2RcaRrzSnmOejv66wNOin6pv5DTQh4e8SQZpMyIXXbll8pMD4Rp26g?=
 =?us-ascii?Q?xaBNJolqgARLiIT4/riEmiLLyc0XIbzI2m0qvGtQBdna27/wWYsfRE+pn1bT?=
 =?us-ascii?Q?tN0IUbxHATdIkdt31syItqEde4DUWsU0/Z9tZfz9EUWBbHqGYcnIRoNR4IYy?=
 =?us-ascii?Q?SRD9g1sXEP5l5vJntYhawcDKAAKETwM675BZenoOoXC4nf8zwez2wJKlXpj+?=
 =?us-ascii?Q?GlmudkUH+1Cy7q89kBNH84YO0JoIpW78DB+8j0mzPv1VZz/pTFY73j4PQ6Si?=
 =?us-ascii?Q?Z7SKjRkivcDSgNWme0mkTuI9XXONHzVgtzSOHp6asNaMoyTRufmNVTgGmEZ7?=
 =?us-ascii?Q?pbuLEuANX4Hg6ayT6nekk2EFTTBJacHTx+tW6FOOvaeuA6S1PnynG5xS4cQB?=
 =?us-ascii?Q?N68kisNh0z/3q1mPVVqS1+k7eMeo/mcC/WtKRgo6TSx8lvOFy3iDvK6hlAAb?=
 =?us-ascii?Q?7G/iuTRQM37ggRuHRZTtyTI/b6DX8SfWIX3l2w2zlHxrsZy+khium0+n0gY1?=
 =?us-ascii?Q?yhdSUXkfGyq2EI097DTbzv2FaYxfNZ0ItlBqHcWxTq005Gg3vppJrIhas05Y?=
 =?us-ascii?Q?6luDkGhST+GfTI+R04/fbJjtadAgfsHLw+yq3SWSM9fNim2WX2mHu74iJDQk?=
 =?us-ascii?Q?ObmeW8Xc0DQjt4jjVtb39R9H2njFZkI2t/yqapjra9WWSuJ4+v/ERRhZ9QTN?=
 =?us-ascii?Q?ELttLdXJJxmcBrZrBBk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d546e6b-541b-4b9d-0d9d-08daab84f41e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:34:34.7551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHw4FZ7ucjVw/i64wvSZ5MFgux/6Ej3j559IW4HnIFIfXEY2ZQJNMB/8/RHhw1xd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4562
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:03:27PM +0200, Niklas Schnelle wrote:
> Ok makes sense, I don't think I need it on an extra branch and whatever
> is easiest for Joerg is fine. I hope that since all but patch 6 are
> fixes and that one is quite simple that this could maybe still go into
> v6.1.

Oh there is no way for 6.1 at this point.

You will have to respin it for 6.1-rc1 and Joerg usually waits until
rc3 before taking any patches.

But I would post and origanize all the things you want for 6.1 next
week.

Jason
