Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853A162495C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiKJS1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiKJS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:27:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9A2B1F5;
        Thu, 10 Nov 2022 10:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjM5YnTuIn4mr4DKaBApBbp2yN7hl8A2gzzNLUTkINyB6BdBj7ePNFSlZ3BxVHLE+pn5HzpsOqSPqpsFS1+/xdiTe20wqOX8ctfScH5KHMoexUqEAI53S3lccMgzw6ndkvYghOz8+gVgK4Z9tnJvEi4aEbAjAKcEzWttGpjE7d31AmoKcQhL08UzjeyEIACZjF/YaAnJNRBkXuk/4JPovU8DugV3uNW9bnvEMtFc0g+8RTJcpYVGpScKGzj9p2wESyI8a8tLmC252/QNKbnqm7ywS89vyYbf2vzGI5RXCMBTv55KdKYq8OPZdzAldC1l44KoINV3/XMIgq7TWL/31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0JKnnsetVGjL/gQXAsdjT+V+4R+fpp/y/qCZvrWj9c=;
 b=RmriNeIjG2RuCh61/l2fT1Halh6YXoRnqpmU0EmF4SxckoNKYd+fMpko5G1jqWWI3W6iL8htRaeWmZkrZFewZbgGReD26Yolt+UnCWEKaA1FDeO6WdtMybF7PWghjVFlwKmvQAYekxa7qhwFwjqOrr+KZpWW+MPzhHoHOQvuNJJIM1FuLWo9ordE0I3FrYkJSQRetotPFtEBCNdJsvNKBJGB+XcdqHNT7wusAfILzajiff7diKnVIDOEj33tFOkhJb4mySSglobUPCbUMYwazt9OIyzmqFTKLeKroBxvUsNTj6cMUC9UvKomjxv5RJCVyJO3kl3sxhaDOe4q9xrdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0JKnnsetVGjL/gQXAsdjT+V+4R+fpp/y/qCZvrWj9c=;
 b=KJ32RMexz6j88atjbI4CBZV6LH+/K0f783w4hd9ikJa46UAfXZ9C6WtugXk77PKFBFDcJXWiT4PPwDjeiG+G7gJXgyTBWT3ZxOdMm24GLpZuqdc+wAshAgGY9NhKAWnckjKRwi1Dg9clftBRV44I5qrCKRj3dHrSssZMKgsNFQWP8eLC5nK7WcUUiAcC2Cefm3n/oGyq/Xu9Cxgd0HmvaOyJ14iqINCJuytnzIa9S6BsfBvoV7ohj715MWkR36e1ZWGa2c5KkXTmdesgAxO2ARFDWAcWuByV0P8B6V2wq2iojiIYM68fiAp8VBHzud7IE9gCf13NBQyGKg+8m0VjRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Thu, 10 Nov
 2022 18:27:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%7]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 18:27:37 +0000
Date:   Thu, 10 Nov 2022 14:27:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the iommufd tree
Message-ID: <Y21CmMmp191LTK2J@nvidia.com>
References: <20221110182938.40ce2651@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110182938.40ce2651@canb.auug.org.au>
X-ClientProxiedBy: BL0PR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:207:3d::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: fae4eac1-45ec-4514-e548-08dac3493e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgpN4NWZAn3U64ValaKg+g3/Y7mnvYEv5AGV/xn/BHbNfjuH6LeITlPGOP2i+cAbmBjFjld9NrdVpC/NwJo/JBjZPTC941jC3uz+NWuFggsBsPEJfqz5ktzfos3cTkK5ZkO5niL6V9chcE3xdFcB9mmh3Ndp6jJUoOm5jXS0SUV7KEhK1H6PY0meUbW+9JMYMICKb/QdMA7Az5DhfPuOMDl2cwPCZUNnt1i5AQIti1A5SKRMT19uKCWdj/usUvec9/F+LeFnu5EuotdFKAoz4ib8AcrogZ9l1yOEcS/x/ggswmVt1+EyoyC35OJBi4CGJs5unqAoD0aztUOpr3MiZx8NeUFwUQAUezJIOlaDLXNzt1fmjHQ/Zs8jB8L/dXdmRjqoGepXpxRLXvimpPlnctKOIAWlDjrbBqDZSv4UYSQYP/m5VMoaMly+jy696UzpO5zRiJmNOw27A2UxtQinG9UsUZwyhUoVmxeV/m0ylzipeGMhw6FYIJtqun7mM54glkaF5paV94tztihImOI9sMZvFSyBHtDyV7oU0HkfHYsCxIPG0VgNL0pK3JHJNHrgniyffUWebRCgN0rW98+dVhDGNS9UiPahnmPiVtW39sDjCPZG5O6eBsxfVe0AsnmFP492xYoYg3V3fEKXEx06eFSZ+z5tIeQUAnmBEQdcMRymk2968oe0Mpdjt6+kvzDw7fM2UwHINZpWhceiw+s1Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199015)(38100700002)(186003)(6506007)(6512007)(2616005)(54906003)(5660300002)(26005)(2906002)(83380400001)(4744005)(8936002)(4326008)(6916009)(66946007)(6486002)(41300700001)(8676002)(66476007)(66556008)(316002)(478600001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XsXmPoLYGkbRM4jFaXyr/+dlAhrd89OQHpwxLPddVrSdQ1sDyaEP8qUDHFQt?=
 =?us-ascii?Q?SyG0lRJE51YzPWe38c1jex/KXu9sVEfoA/adQFiHBGq9aObm66IV6x6jwfWW?=
 =?us-ascii?Q?Y1+ggpxuV8dMvFC/5dDEf0OdQVpQQM/i6u4oYp1Go8ZovSmtECorskyS8PgU?=
 =?us-ascii?Q?SyqGUMEI5By5v40dGYAgsnvCqbm8WpMUZg14gyCXYL/B25Ya4G6grW2rZSzN?=
 =?us-ascii?Q?31vOJiq88y1YN32j0ApbvKQifW1xyzhW70hFmg3qaXjZRNi/glBrEATS7LWx?=
 =?us-ascii?Q?rx3aW2+lCpX0fFk0mhCSxs7agqI2OgUmRCg3ULcGpThHWaUqINyPLWlQTnPb?=
 =?us-ascii?Q?Ac4SG3VnDONtJ33TgeoGUItOKLHbhYUHJ+/JiPvgalCdGEUydz65bCdlYzgC?=
 =?us-ascii?Q?1djo4kYA18+fM+ihMNPrq92hrL9pSccMjGr0h7DGz2kXQYe9ceap8rPY9q8T?=
 =?us-ascii?Q?/FWGeaFpoBZ/1ugycBz8kG9fimabscleDHs6ZI88HqhvFGPIoVcdKz77GCE2?=
 =?us-ascii?Q?CkFSYrHvm6dLOoahqakdApIL+NTmMQ8MxvOvP2qOE9O1DGpu0getRykvDPXT?=
 =?us-ascii?Q?6YHqsEzhYHjfTkOfO8KlOvrjnjnQn6tVhCfxpFsB9kvvMaqjX8oYM9EiBu0g?=
 =?us-ascii?Q?7+uGyfpNUedZwXtTgEvwh8pRir9QZOs5aOWqZVUhisGiyVhO2mj2EvnVW309?=
 =?us-ascii?Q?dBiT59nYWEFc90eyp4U5o3w0ehJOABdivW3O2YMlhmfe55nHkxFLwq50s4BU?=
 =?us-ascii?Q?o70TQzQycLGieAz1S0PeQkitDJQQxw3SCgVuLyWudEz18uIuXAQL3nOCAy6R?=
 =?us-ascii?Q?H1s0hsGVAuKajdsMx8iQVDElu6CvpcEocM2fWjvYSu2AZVLNLtBBLBkuqLqZ?=
 =?us-ascii?Q?60aq0jYrVx4vgckSSF0s7RWRujpDQlvWk3OofSKkpTzBBLgK88Fxah4iUGfB?=
 =?us-ascii?Q?ZaUNYBQendtM+wnKuF5V2OIYfc56Fqp4M+Zxd3OrEtbyMxYhfaERFpOuyvct?=
 =?us-ascii?Q?HObixM9mvV2dxiACaKLwWU68ZSdQBc2JYBo6FEoaKuUn9FQx+GIQ6pSBgEn6?=
 =?us-ascii?Q?hVCzEFf7GL/DeBVrJGBLBICzAr3irWKcJbOVP60Zr6+cs0siUae6c0uQud0h?=
 =?us-ascii?Q?FmFujh6HvAHrllTB3p4s7Az5FIS7hEC+OfGa2YI7qplGodVbyUhSo7tMxkOh?=
 =?us-ascii?Q?FgPPJQf3l5I4lY1a0oDa9zmsp/iBtG3joM/RsJNYD6PqHwp049N8stGJ/YWH?=
 =?us-ascii?Q?u3s/X82aX9qpyiq/rYEFfJ2Kv+cxhZjAQz/urwaHzyTTZPYnh6IGi2M7YyXB?=
 =?us-ascii?Q?D0y+E8VGtTQXDyotFPFXIBO1Mq1MT2ZfOSlSP02o112glkYg+3wOapL9qCY0?=
 =?us-ascii?Q?8FT/aOjwU1xxLZZLoE3B8EeriaVJLJNAuEqzq237Thk1IWYCXNCMfa/YYqKx?=
 =?us-ascii?Q?wBfz6VMkxtwQP81yF5fHTkgfomxvgTfcm0R8Ce/+2pyD32in1KNP5gSgRI/C?=
 =?us-ascii?Q?WHe0IeGK5fJNSJtEDy6QA0WOVj4eWR8fDUNSmRQHggy4B8CSyuzHqOZlHFpv?=
 =?us-ascii?Q?mtO+sa5zXfqG5G5uZIs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae4eac1-45ec-4514-e548-08dac3493e37
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 18:27:37.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKeTR/EiPM7xi6L8NE1Z7+vOI/KwzwFzKw4bYaPpNBUzTzkRNS4fttOVRvpl1s+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:29:38PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the iommufd tree, today's linux-next build (htmldocs)
> produced these warnings:
> 
> drivers/iommu/iommufd/device.c:1: warning: no structured comments found
> drivers/iommu/iommufd/main.c:1: warning: no structured comments found

This fix was waiting an ack before I could include it.

All is sorted out now, thanks

Jason
