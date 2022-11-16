Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601E62C6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238999AbiKPRzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiKPRzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:55:01 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749061757;
        Wed, 16 Nov 2022 09:54:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvkFsXdzQfNtdcTS/xKWevSB6dUWivgMtZbSlso5aBZWJubqZRCZgmJwg1yGLqGLWAXSDP/69Pd8Kc7aBD4l5eJReFe5dbhLo3+NyeMImvK4l2pe4iTZdVB0Rdlbjb/9Um49CCC9XHs1gchvY9ijSmFewzrx9o9yAic4TVwQRF9lt1B/A5CeyAbotEBIU7UEvg8skSfyqMIrnN4nshO6dAY9DrivlohaUcoSi7SCo/azin4XH7tklIv8gpWwcRD1VU2CO9Sk/etCCxMBPSbYyrV2I49nyJWaveCh/JvuxVNO9DKEbgrHwzL5XMUPTqCPAZ3N626/YLb0Yh0Zlydigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXcCnLQ6GTnGgVVZOFZffwN2N181HbDhfOwJytlM5Cw=;
 b=ehk+HifM7gs6hwFVYfsUV+ZT8c1J22YyJo29k1vigR5w5Iglhh2UVICFgRaCgO0AEGzzB1eAspjAGnYjRdHjXd9XFDDrHzAQO3gwcdMdIXWRJkDYvUdTbIkA4Ft188toov+82lz8AsjnT6t0UMDzeulJFi4C8EwTpUCA+drCrKxvv8WF+nH0E80aN5RkveuLmgECWNPXgmls45v25yoGFtX1JciUdfUj6/ETdenlAbZB6wiGEJWMEGRVkV4h6cZmjOgnF/U9btYdVglLFHvE16C4vfH4es6TYcWipVnzPWJK4hfkSx9SqAREr2UMlbBlYMyo0EMW6s1I927BcK63SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXcCnLQ6GTnGgVVZOFZffwN2N181HbDhfOwJytlM5Cw=;
 b=fM1t8DsQMHx89sn+C6d1V+oeEqO7JwECSY5TkjDcgSgvP+p73O1Dcwu36bzdsmKjdeF8q5UAd7bwTTlt8KF7EhUOC/Lb4DfFTB03SY+gbjwcCTgr0JLdi4aCy+Dl9XXgZrP9yKVRk4RxvUds8iCSltfdgEgSFQJFdnQ2go5lEJ20wEcyPec6YuAiIXO+LBLJMcrOhIZqgL8e8oEtj2/Na6NpXjQ7nEz/psBsOXwcWMiT0f7WkEOPCnwhZhzcTaA9lUvTHz1QaDiFjCohr6Ejj28yOUn3mFnFKIw6bD4lREzDnybcRSci0fPT+NbUUisXLWvgD7MSU8mwrSpUlUIiPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 17:54:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:54:58 +0000
Date:   Wed, 16 Nov 2022 13:54:56 -0400
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 17/39] PCI/MSI: Get rid of externs in msi.h
Message-ID: <Y3Uj8FC4vPSkClsO@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.582175082@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.582175082@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: dca1a07b-3a8f-449f-999a-08dac7fbacf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+rT4XfLAu5PJGUrFAGofZWxD9oSkwE2nDCiuEH1Naa+NJI7ocESPDTlG24priVhJJNclpXT2Q8ujn9ebGr4sW1AMxd3ynsJqnSbHV6bx/d1X+YGKnyRqij1gkm+lFaodjhmedsQsyfJ/cyLdo4ox0+kWOVWjIhm/9yroUAq2QuQV47zCFc4l5FNTXwEQgGV3KuCzFSNq9Kd4IfjwmTeHDoDiuTIwF83lND0qPUSpXa8satbxi/MCN9KGJ7a+dAITh3OrT3rZu5148zgEw99n+IR++2pjLWB1S+rF0eubysQ5kTGy9dzVKXcAUU+KexR/e5WOKKp4r0LXRhZQfXEWUjySUWKi64wjFk9Uefxxsj69JJ6msJcPEwSpEBr4r04WaFsbFwXw7jq25B/C3+wL0G0EfHhmNc5Cg/0pj5U0epu27wwZEX1fea/LigUkudt81zHXZ6KV9J7Z+HA7mAUQlqBdsKS3U7ACxcbdxVv8XmrMrMho3Y9atnFod8TSOiIl29rvJhzOWBOTS4+o+4yoxig+iVd7JXWqUw71wHcSTyzuRf5PodOYiXxMm4QPdSL/nGmOZep3VeTU2YT9C4vXLb6GR/8oEwmHQixiSL+i6nQIX/JFhz6gL2KSh6ARL9Z2XmM8VbuqA/fMFp7dKe3Yxex8CFZGTjowQhIOkHQ/9zQPDJzbsfFZNtRzH2zvOS/dMWyEIfjswydZGNphPSbUWBEfLJJQX5nS6TXABCt021JUaKVU2Hg4KeI65BnC+XX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(38100700002)(86362001)(6486002)(5660300002)(478600001)(41300700001)(6506007)(8936002)(7416002)(4326008)(66476007)(316002)(66556008)(8676002)(66946007)(4744005)(6916009)(54906003)(186003)(2616005)(83380400001)(2906002)(6512007)(36756003)(26005)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pK6vsjJ+Efc76/1H7RiJypnSKGx0u0fJ3qdhr18CTkwdGTWi1OECeN26iVE9?=
 =?us-ascii?Q?b4VpEfP3j4zq6ZOEVHH6ozd7dCagiXHncejbJ5qdGP8f5yOiLELvrhaWPi3b?=
 =?us-ascii?Q?w62zMbDmYDNAPHDTYPuFS7YyKZoN+KfcD1RI5eA2HOfenHL+nQT2kEXZMkh+?=
 =?us-ascii?Q?BkV8WNlGG9IMpiKi0rR5OEcfD+TVKWlYcQdsgERjN0mBf+OpkZFK5fEM/1ZR?=
 =?us-ascii?Q?ZNn7oMlAuMJBb4Pd0ewj44DRMjmBGdKSyfNpxdJifw+vrBH2tv1b7QtPR5oq?=
 =?us-ascii?Q?Q+BWvulpmncOukzyJE0FkjmBwYkmPqYgcpPM8wTcc0vWgNZJ4eWxDwZgw3OA?=
 =?us-ascii?Q?5gWuRV+T2SV75GIwV1vZuqlapsBQYbBbhbdD8NDR7GAtVvbPzNtSKP2ltbRw?=
 =?us-ascii?Q?qRrhheQnghFSj9Q3ukBcxhXDijtYUTIkqBHm9VMhNjyjKnyr+ik8yUI9+sMP?=
 =?us-ascii?Q?LRRZ5MCUIpQFhZW/brlluT2BgUr3MyhLfHGCN6GKnD0oi+Vax0XEdusTH97O?=
 =?us-ascii?Q?QLPKJ+ehUzABJIAsWVrlChL5R5BIb4H8CyNvbtRJeA2z4XcZ0Ua3SKBKboNo?=
 =?us-ascii?Q?37cLoKQ1G11sGZiQz37R2LewUkh4OmmGhwUoRXf3I6EIOEX9yJhmc3liWb/+?=
 =?us-ascii?Q?n0kqqeoo13pBjnpMAuPD3EH/2Rr5pjPl0DFC636dm2qocQYTOVGP7rrfvHxp?=
 =?us-ascii?Q?0M1xfCEq2/RnUMEBnRPYnZj8T1CWN/TF6+62Pm7GQ/03tPToK1RTNafb+XKf?=
 =?us-ascii?Q?Iv9NrrG1sE9Lxh5CBU91mPlpm80ji+/3jMm7TIo9y8pvXg+qJyDVYGiusUXJ?=
 =?us-ascii?Q?FzuksQJbDVrgTFWYlEfUB26i9/2sXbKWN8O3sRgFQzOScbeBGfJT9b85F1Ve?=
 =?us-ascii?Q?ZLHQub+9iVRpNclHWxyZmw+HnJHHud4XTiHxPU19Fp4Tzq3V8Jfoe7NORUlq?=
 =?us-ascii?Q?LpyhwMSZD8oP6yRG+RaAxLVxTIj9Jc/4T/Rr4NRfWd4ONW473EP6KZ30hYhR?=
 =?us-ascii?Q?Zgv41iwtj9y0Pe724DvTgbRDUFeOBKKfX7jl72whY7wBA9/8YBNBkCnetDEH?=
 =?us-ascii?Q?Xcq52+QvPlQH+VcMmXCQS1xkj7UfCw5XX5N3/pQ53cMo3ci3+OaSqcEKIu3u?=
 =?us-ascii?Q?PT2GJXmsFBkXxB/R+QoRQJs4Epsnj/SQebiakqJ2krWnB+H7q1BfdjoQPas7?=
 =?us-ascii?Q?dc7kluPhrIW+95BAhdooaNkUODmLHFxjCvZQI4voN8gpRs9aOVXFi8WK89n1?=
 =?us-ascii?Q?HFCPh+ZIRXVOHV6+xp3dZhdlfPv6Mm1SUMSXfo+uQ9Rt/i7ZMacIe4UGOI+D?=
 =?us-ascii?Q?wfv2bataBtSS1MXm92WC8KeHo8jQm5zGAzppjlFPMx3CMXeY9jdV6dqk1cdx?=
 =?us-ascii?Q?4H5RENALO9DuaHljIFsisNI3cKYr5cGNhtug8z1w6SIILgK+ifpfBg+wBvK8?=
 =?us-ascii?Q?64Xru4lZLoP4z0xqo0f9f5+haBoFt20pzGW083xBKJuCmt2IHHjUiQNUYrfK?=
 =?us-ascii?Q?cYYhEQtcR9ap77ASTUjoQ7wjVyyzS1x8xHnYScA84lKEpDe/UDteC6JDLxIX?=
 =?us-ascii?Q?OjhVxvKIU49+I0dNlqLMGP9DD5rlvDqu9oznwH7L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca1a07b-3a8f-449f-999a-08dac7fbacf2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:54:58.0520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odyn94AlNLgbiNCy5rPuroVGXIiDJpD1MwfW81OiUUmIsJKAlZLjN3dOusN8Njuo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:42PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Follow the style of <linux/pci.h>
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
