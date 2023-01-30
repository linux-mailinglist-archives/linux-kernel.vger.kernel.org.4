Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2666E681401
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjA3PCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjA3PCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:02:30 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5541C58D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4rxFa53XZmQRV43BhweasB+pWSOCa0VFaO83vB6gibV+3rt8MvqD3p3fQVhD7FN1Om3FmaHaT1S0jxfzYtdjFKB+csLLluiWYSELesVQzjJxSyzlnOTEuv7qDV7VdBHJKDVjfiyudH//lDqA/F0pCxxyxE5ggJR1er5/5iZlQXbT/2Oue8SO2kofAoT3Pr034y6AOaELAf9c9HJw1S7zhwzHZwCvZsqyvCsd4cHuyCtHZwK3qNAGx7JS044RJ9V/IPaEHoVHEdd4GEnqSBjDYNcQjvDw0EoFka+BZ5ljFCh7JA52g9neKAJviPtzW917hNCuzBRoz7Lds3dEnxgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syx3ArbCkDj9iTPNP22RYAaI9R5qJCaKs73fdrNZp5I=;
 b=JGp99EHwvraCioox0rRlWbqYhfCFJRKBJDx6VtzieQRicyYdJPhasSJwYSdXqbNGA/TkIj+7qnhj/5XYVBC7tzHbOXUYi+CdQnQvGJ+t5Mg2gWYXvVg0NdVYQOV621VfJiOs8jxpswdEEe4wZUoMeGb0CN1r6IFUNutRji9yBj54CALkePNaBaWkbpae0cU+/zyDHsaanxfqxByE+Sr4eGSmWWLOr89jTjRHJ38MxxSKfs63oFC0Gekqz6Cujbvxh1jD33gCVlKTqj3xfbAazRFKx/DLg73JUY3djQHBCKBOCugyNUVNfTCObfDIUVZmuVf0YsvdX6tRFhui9QfqXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syx3ArbCkDj9iTPNP22RYAaI9R5qJCaKs73fdrNZp5I=;
 b=Abtgxpu3LSkeYcOPx0LEFGSoibtrm8ok3vH90hvrS/I0f7IsiI0U85Ak2QSG1w4y0ZEmi1XtKFvhWfTUhgMOJL2wXqWHbSVohiio2dHvoTmXxk+FIrgZIdg1KzU0IkBPl/ZWJel8ymJ+6Lob93Hz2m2MaSwVim9Ue7JCoARZInRFoqxeFSh2Q4sXDxHuemyT7nfLFhwNJSdtOTmUCXrAMbvIUSt+m18Cd2NTGiwb+cMLiLMy2D6iMb/PFkrw446mgB2mE9aEbAKzuIPoJed/X/Txw1F6ts7IWAouzXIMzSaLQ4lsFolpT9x+Xu5diEXABi7+mK2cj1OawjMdGru/PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 15:02:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 15:02:27 +0000
Date:   Mon, 30 Jan 2023 11:02:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommufd: Add devices_users to track the
 hw_pagetable usage by device
Message-ID: <Y9fcAdFxl7GVSH9r@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1c65ce093a3b585546dd17a77949efbe03a81d9.1674939002.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a6a529-3af2-4aec-8f0b-08db02d3003a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /phBPUzdQ3u9bnDhFZZR8kXz7jHuhgon6thOitN8ucwV4ZsGoExEDxpCN9DnLFm6Y8myISP11D6jtmv/Ueme05J+xRJkMDjPU34Y6fVDZbs78fKotcgc/tS3oNmq15d9+4FOdVGZ7BQOAcaYfZGBjGt+yT1Ci4HXU1zVeFApWIa8XuXDHVgicucAznnxS6lQDh/RbiaAfUHUhhWk8ijKx2quH+B+j8b7hQkfDqY6DteKjfdU9XcsUylJ4/tkgzdmEd481+9VWBEBgV8YP2Tt5WfNY3FGTJtsF9IVqw4tekkGTcH42klBhJfFYwmmmMGuJcxTinwTQJvq9+iKOD8YtdYs06eS7P3zHWB6uwPxcj0mwPCqVabMQWT5/P9oQZKuqmKTsDXwz2uvDk8rFLcP0vEc4YAvLqeKP4GS3z5QHPgZ7u8zCL8FOXy7XI0PGP2sChopCdkWGOBG6gQi4nRy6WUBotBua8FWOBSw6O+trkRfs/B69THoy0vW0OC0kBhTUiTnFbDG536+xWaZKihFHtvfBSes1ZiMfTGliVv69pkAfnNbly56XfF5SsCmYunSvfGyiJdXrNSlJd+q/YR/jBjKQUJqF+08wOXEtF/+r//GkIn822ezWNnLITF7hJjRXMsgXxY6M67ghz7jke44xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(4326008)(66946007)(41300700001)(66476007)(66556008)(8676002)(6862004)(8936002)(316002)(37006003)(6486002)(5660300002)(6636002)(83380400001)(36756003)(2906002)(26005)(6512007)(186003)(478600001)(6506007)(86362001)(2616005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C2/81enQStCZQVLLcx448Z07PT7mqmG0JUcJ3pB1QW/+MZXjQWzL9aL8yyOg?=
 =?us-ascii?Q?IJD6vVUpspUAQiAlxuOBaES77RkojwuOtjh6eY62nmsnD44gjmZiirzEbvGc?=
 =?us-ascii?Q?HrSjNSw5At9M0F/cm17R2VQKKdyxSpNcNb5oi4ZGQ0ly5aKJK/HhqFlMvdLS?=
 =?us-ascii?Q?wMgOlc7g8Ji2vvOfpH3odv6jsgaekn/6JMUX8/0fxPxuL3rIfVvxQN+M+Oiv?=
 =?us-ascii?Q?Mn0o/eHfrJZcm4h+03JAQAYhbP037lKrkgIMcik7c+6mph2MWwhrzarc8c1V?=
 =?us-ascii?Q?XkejZIw+v9C6Egy4vSEItZ/cEu+YwuZWMggP5tcy1K1aCAgx6Cku+gcdxVg5?=
 =?us-ascii?Q?zLLRFZXMop9hNuqZSf4XdwVGjuDxgpG2+ILJW7YqWqZd1wptrDheUTpHZtyE?=
 =?us-ascii?Q?rmEGXgo5htmxt7Wzz9C6TbHW90i58X8tFzp/oIgVAsM1oPwEZH+Z8aoefa8H?=
 =?us-ascii?Q?/u28Wl3VMhpEC31J7HjxQRVp8iwtmdlLb62SsEA0/jtL53HOLzS9IbeE+31s?=
 =?us-ascii?Q?LCcuvUpysuZQa+Qm1NltSItZKoMTTlP3oA2aOa7RcQ3r0+CIBErpkwyQniBn?=
 =?us-ascii?Q?sxsdiyIuSHl45ZdmhuaAK3/z7SbzDyihxLnTcFYSiUM83ZQxGN6PZhXbN0H8?=
 =?us-ascii?Q?tdKRvnlAulKCcuoPG5TR7duOrDrYokWJe3Z4VIBISQMYs3OR5eTIWuYTecQC?=
 =?us-ascii?Q?IaAurSEc5U9m8yU14g3/+yTlOpUJc/AiyrFRKuyUVhP3bNi93XY72WQHEGLK?=
 =?us-ascii?Q?dl/t2DbRNMSHR0Sdir3teVn4XY01LGFRAoWPoapKGZa39wEX/GUQUeRu8/UT?=
 =?us-ascii?Q?q61tEp6FkjnmmOXalZB+9nltpS/E0ruP0+PlmgCwD8qj6/NVYnYeC3G7vkrU?=
 =?us-ascii?Q?Ct8O0M7KSicbQPEWtS2KRNdQ8Q02eepwd4+cgDZTnaD7G8Sj6arlus3tCu49?=
 =?us-ascii?Q?H1I5sKBRR+HXhW/JH7rDEVhe1vl/ospwB+SporVxy77h9ugOSzNc0vgMscqJ?=
 =?us-ascii?Q?z46BPXkv7XWtiisHLCftdV2XIBAqAOoafOyb5aKozJnY9ch+VV6TSV2+L85G?=
 =?us-ascii?Q?T7PPG1/Bk9Xi8m1FK1r4ZBHPhScSSDIhG5XeJSJTBmxo3BB1npVOkq6J6ZJM?=
 =?us-ascii?Q?b8JE4n8+gU4onz+KfovGScb6hhPXPEUOum6udAVJ72v/Y1Orp5XISCI3FoPU?=
 =?us-ascii?Q?96zprahSdN4XAoXmkfpn+33deSjIocf+qKUXjBiBBU7QIT/VpLK8jNExZxD7?=
 =?us-ascii?Q?2q2Ova8ux6+BdtUlXOA1DSa0BiaGyDeqnuuz3i88CXNHiSw6RInuOLf9Q3vI?=
 =?us-ascii?Q?iGXXGSY1U3aBh5qjoSAZF5+NEQnoRtGw2YI8VH31cLPaophGwBHHwCqKgeSX?=
 =?us-ascii?Q?ED6/fYWM5w6Mb9QR+cSuA7NrCYEhmNEK9iANgibliWGfYPjhRIG7jdnowmyz?=
 =?us-ascii?Q?DvdfUMhedELja7h21U757oi4opIYQxXUcgvNfsx1gpmfcuzt9Ni9K0HkL4wd?=
 =?us-ascii?Q?TQrWWU7RcEmf+Ujc84wS7Hlg5hMpcRIU0dvHrsFlKHhkO85W0z14bmcOJOom?=
 =?us-ascii?Q?HJUySvexxyBdYl2bUSK2pCG9Dr4hbUcQzS4dSYhD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6a529-3af2-4aec-8f0b-08db02d3003a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 15:02:26.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bHlO+4SE2MNZelu9doaOWELncB4Dr7b1MGewgrv69qEJNjR8+2gaaMtJS7iMgvm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 01:18:09PM -0800, Nicolin Chen wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Currently, hw_pagetable tracks the attached devices using a device list.
> When attaching the first device to the kernel-managed hw_pagetable, it
> should be linked to IOAS. When detaching the last device from this hwpt,
> the link with IOAS should be removed too. And this first-or-last device
> check is done with list_empty(hwpt->devices).
> 
> However, with a nested configuration, when a device is attached to the
> user-managed stage-1 hw_pagetable, it will be added to this user-managed
> hwpt's device list instead of the kernel-managed stage-2 hwpt's one. And
> this breaks the logic for a kernel-managed hw_pagetable link/disconnect
> to/from IOAS/IOPT. e.g. the stage-2 hw_pagetable would be linked to IOAS
> multiple times if multiple device is attached, but it will become empty
> as soon as one device detached.

Why this seems really weird to say.

The stage 2 is linked explicitly to the IOAS that drives it's
map/unmap

Why is there any implicit activity here? There should be no implicit
attach of the S2 to an IOAS ever.

Jason
