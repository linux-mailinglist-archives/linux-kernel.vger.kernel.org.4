Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6D62C71A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiKPSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKPSAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:00:32 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3665623BB;
        Wed, 16 Nov 2022 10:00:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKZ1eUNM9n0+Y1Lb+w57u/JPshbOWTXaUqxdLw2cdaPgxmsErS/F6FeS/8jci9JJIYuSYrDtJNq1WpqNCC9bsfcyqBxpBvEZ90cP5YI/x8T2NnPfoCQXGljF/JyEoNLCIBV1Em5Tf8jyB5Z9ZQ1BJRF2oUTAHEoRIhBEoz5vpQp+5905QiwmQJyoUz2DB8YBMP2ObxoRAiEQsDdtgJXBEoK5C3KCwpOAycc1cCMqPbEIU8KW2jh/WznZbbPDTdGv4h49nV4s2GYB3FoVInV8+vhtiVavm5xxdRms1P1u6sfSWx4cx0aoEaX6RbtYtuQGgyl9Mp9ozEktGpX7xjoZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awNqB6LPfP9knjII621IOrXW5btg9c+hiIAq0R58rRA=;
 b=ndk7+1Sa4+EqGtw5eB/Q14OOO8e5IWLJph640at38GIeF83EyN1lcJUUMSPw2KoLuvHeZL1gNj95wn/uVcIzDRbNrcJ50uoVADz0UYxsYgUN+moY5gJCj/VSZtDZWv8c3DZAusxl017VABS2/3Oghhc9u7/TmGHqki1A+7tjhBri+I5cs8IajNpq0fNhXWwkTBWcNh1xroFaG9U2iWIgbzuV5dygVY1A+I/tSs3qwzEh/nUObyXPDeUvdH5ODy+YTiYt5bXMPm+kAozRzB3vGOzDoqcGbK05dFIZ5dxPi1aHuIROUHK4S/GaOIGRGcOCp6YrdmxNUh6eTfgUL/u/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awNqB6LPfP9knjII621IOrXW5btg9c+hiIAq0R58rRA=;
 b=tYqCw0FMhXEyRpRluZiY0dNKhSm/4Zgjx7m9RGRVF4dqv2e87sTe4z9vjxsrfv7gsh/RPMzYTfaOoKVa0HwvOo20cuPxZ3G4Ts0uIGWIukmPDyqiKlHPBt4YfaiOw0A3Xxl1KeJoKGP5Fggs/prHiAWQaAdSJI/VONbhvAuYzRBHLxJMU1T3QRKCrA6SSF5ND8QNx/e8GLfeEEpjqMGz9OCBXGQjYCH/4ar7io4MYc71LbECxVZZ+x0/712AENxebS5EDjuZGhuJ594FwztfhhnzwGGDEHbpKhicQcGTHWzDrgI0ehdn39iTLZGMWCmOiZOKhuWuU2wl1Ag9w8cIQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:00:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:00:28 +0000
Date:   Wed, 16 Nov 2022 14:00:27 -0400
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
Subject: Re: [patch 36/39] PCI/MSI: Validate MSIX contiguous restriction early
Message-ID: <Y3UlO6+IaXdpb0VR@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122015.691357406@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.691357406@linutronix.de>
X-ClientProxiedBy: BLAPR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:208:329::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7938aa55-0797-44b6-8d94-08dac7fc7217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Fkyy7BE5CbxQugFoNA2QC223SQ92EIWQR/4Le5ZuFupfLaVT2gRvT9EYcDbvAlYgr6x08b50Cl7Zyz0ojUPQGHWQAj0w6mZdbELiF4lcOgDyqxwAfL42cxoDje51uv6ADBMaMZmiSzfTHoOZzMO7VdzAVY0qFFymRasVxkIB9MmFNKIVPQsqAX7HLq4kIc0066l2O+hJCvGvI+WsPP2GBHJHetsHf+258wmECNUltv0ArD1SsJi+lgkaqR6V4UpVfqmjqByVdC0RH6JGisugUPNOR3HTBx2XJHdHGUbsBRgl/tGjZpbFrKzE35HUNj8Vzd4GzvTDXdj1yLztxfw0LDZvhDjNb/ud34JEjYWOoWoOjDyykTeHL2DqdneLIAdCrJswG+uF9TW4aWuPOFlM+J9UahbF0Ov6eBDD1kO1v6ZICy7JuR1y1Nj41xLBkrQLB07kewxtrZ08X8Ec/Uq7KE4OZefcHQ1La811i6uXHe13sG461lrHzAgx4oNdVQ+eyV7DJ/Std+SW4Wa0lZ3kotPgj8KONOLHmlFSv0PZvinGJC0gqQQgFVosc9wbN8PsLGSSNhMUZMz3AjrVgQ55uFpu+mekwuPScecBt6bzeyob67jnwO/6PbEOJwbTLpAf7nYKkUFq4Lvm+RkqbajWbiTcggdzOjjnl6IzKQPCUPLQy9aUQatLlXzKU1Xj9Bnw/pIhmTMCboNk1noy69Hab7lxtuP7O1cfhRkwIUA57yIttirvOZkeg26sUHMpMoF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199015)(8936002)(186003)(41300700001)(86362001)(4744005)(7416002)(83380400001)(2906002)(26005)(6512007)(38100700002)(2616005)(5660300002)(316002)(66946007)(6916009)(54906003)(4326008)(66556008)(8676002)(66476007)(6506007)(478600001)(6486002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QDnn4vHvOCnwrAtNgCm/XbqeP+HzVvYQLSSfmT3hsHfWnvp/Xaq61dHTuNdu?=
 =?us-ascii?Q?I0ayj94W+xyTa/aQ8Sa98Z+Lg7HVUbWBSDHXFzlonAdeUPah45frXZ2LgAiW?=
 =?us-ascii?Q?aM1T1Te7tdvYW9hnjgzpX0rWKyJikfPpYnkxyWGvUxk2Bo6k7RrWWXTlMMZ4?=
 =?us-ascii?Q?wMvrqZzPV+btuHoUGaZXRO9MbO/wy/blPqxUahG39O/+B4+Suy+knVbrM52W?=
 =?us-ascii?Q?8oH3gun9mi0CmNW0S8QaK3SyfXbMYbLy/9QDhvh3ynHJUO2szPCAIkFByJL2?=
 =?us-ascii?Q?Os+kjb5t+w3wZRfbIoF6mWga+TvrWYOWTnYYmQg/8sAMKDr5jsvxS3K+dqJL?=
 =?us-ascii?Q?NP+NyGQ6oyBUIZT/ST2DH6ak/i6bnTblffd4f1P06AduHCAjEmJbvAADmmPs?=
 =?us-ascii?Q?fgcy9Wu1VZK8tmd16a8MmXucRz8IdjWsTCPcdwAPW+I78PkM16WtOtcdXY5/?=
 =?us-ascii?Q?wh+q2lgGczwP0GP5/YmBqkloV0lSr21XzHwZNBJdb5QVuVLD9h/qag3x7Z+W?=
 =?us-ascii?Q?CyRFEUW4iHBXGpw2dpCvx1rWoXDoRadz8XwpYrRkhs813VDFwfDxqq1MdBhm?=
 =?us-ascii?Q?HbIZPncMSAMGMG92B1rYdH4+n5yyh5qfhzRepC3tn9PPgD8F36AXcSly85ca?=
 =?us-ascii?Q?zKYUsNLrTJKh+wIe1C1RujD/bYOZta8xWnoEPgZTnex5Z2SOzBWgSgkEPK/0?=
 =?us-ascii?Q?pcPDCJ7/+Snj8PrbvZ/2ZcsQf7okoUE8nkGKovydXTZM6TyVXKXNe83J9KS3?=
 =?us-ascii?Q?9CC2FhGXvJayZ3EK3oTOoQeEHnUdVDhcNUBCapk+umI8zN1xi3q+JOXYRrlo?=
 =?us-ascii?Q?qkGJQIcoSrHo+XL7ufJFbXRCcWdjzdjzDMsdmCUIQwwJliNCR4z+LAkINf08?=
 =?us-ascii?Q?ZG2p/O6fRTWMzJrcM09knWKmVRoXvUBdkj1CJcJczGV6Xcx8DsS0rOFFsyvy?=
 =?us-ascii?Q?MR/ltAyNPsM7MbcIlU1I/3V8KXZFLXwP5o2i6Aws9HBwhFznByqQg09c5D+o?=
 =?us-ascii?Q?Ndpkflaa5DYC6/5i7/72G8Fd0gmIhN14IMf0LbzgjWQC7wwur959BRWAbG7l?=
 =?us-ascii?Q?xT7O5mvOFRHDjhQ4D3+SxkX12GY23V24NiWICCkFxMv4sLTkCRa6xp8z3lJl?=
 =?us-ascii?Q?xO5Z2ZtfOmdW8FeeylE4IA5+YUXHjKmPgNJYhFgq7jhUJmCmDneJcfWofgyx?=
 =?us-ascii?Q?kqa4rVH5QSB+PI2DpIfwQQUbW5ZLOiThP6YTGWaVnmrrchlXSaQ55p9i48x2?=
 =?us-ascii?Q?1bDPpSEEtG/hJEVT6Cq824Qe8mVzFYWMJcVyLv9elSV8RHDu5ZOOsMS96l/k?=
 =?us-ascii?Q?pR+4ck5LNCGTUN5UP/o0LnjhbUJFdo0n2czBmbWkHd3d1yEJVhie5y5pCO5q?=
 =?us-ascii?Q?O1fNzkUm9UzIeqcz+eig2kUnFAcZvL1hLGgHPU4J5BzK7DRwef3I+Drm3EEc?=
 =?us-ascii?Q?RLGqf1bXKeccuMdBqd3e2u/45tMuiG3FmdI332ecIwj2++bk3c4IEDnXRJ3x?=
 =?us-ascii?Q?RADpYgvHmv84bwLMWT0dTp01jTuyMcGlWoD9C7201UgaFG8IZ3J97xb6+Ead?=
 =?us-ascii?Q?tuOCdBzXWKAUvnJbotRpc5123twN5KGwsT9hvF9M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7938aa55-0797-44b6-8d94-08dac7fc7217
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:00:28.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvdXwnJy+HOS2djjVtVyKRvIMFZO3BqzymD9WXtXDcefV9eb2J5szXRDhrbxqJLB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:12PM +0100, Thomas Gleixner wrote:
> With interrupt domains the sanity check for MSI-X vector validation can be
> done _before_ any allocation happens. The sanity check only applies to the
> allocation functions which have an 'entries' array argument. The entries
> array is filled by the caller with the requested MSI-X indicies. Some drivers
> have gaps in the index space which is not supported on all architectures.
> 
> The PCI/MSI irqdomain has a 'feature' bit to enforce this validation late
> during the allocation phase.
> 
> Just do it right away before doing any other work along with the other
> sanity checks on that array.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
