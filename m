Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD7D6813F7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbjA3O7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjA3O7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:59:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4323114EBE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg6lQM8y+Xim3ZVJf8k4QjRh03oZY9O31c3Z9Owzg/7qz+/K7ccHHzOIFtP7XC/54GtwFYeGnrhENM3pCo7R8GaGu4CY6KWkA+jJQp14EINKaTgNyg/WJQ8ibXypIuckyforxkNfoJzPN//yrMwcxlrjYc6OGEqKzc1/RTN/2pChZurh+E1a8MbEbLL2fWiWz2qI/91Ux2TnAgNX2lMF+AoD6i6vyyMsC6j1GWWH2iTcFzY0tGzcZrVj9KIilObvfsMf1jNgNdZ8tuU2cEgb1KegVKkWqt+jYbY56HeVKRD1l1ycoGMxtIaIjfL1cjm9FXUI7UVkNarEienjrczAVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoBuYTFDRPGeLSt8c5R50YEx0DuhGcyBe4ZCQeb0yHI=;
 b=Y03E7t28EvU/1RkPpOUn3wyRk1ImCz4QDIIcZih3hM7uwBP/mcedwaoaXwnCoAt3BcG6EOUQHk8Un5WEWeR1MYR/MCWBqBnOfLEnO9k7UbS4USs9mHdPVWWq8Xm8OoB0gR7MAU+nIc+IfdqHAKlenYN6WDXyM1/ebEH6e4Ryo3//cPZWos3xoxl9ogb98ighqqcXisw//pKCFNs/tnO0BryJ6GHVo1vqFgFosVN3/CAhSgFFHCCXXwlDrZmvdPyVZ5CYTPiyFtH8rh8rCJ7/vMhZk6XTqfTfTyTmWtEyM7u7PXgYX9nJHMmxwX23JASOqQPVs4qd/fGK9fvZWw/7Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoBuYTFDRPGeLSt8c5R50YEx0DuhGcyBe4ZCQeb0yHI=;
 b=ZwSHkmMPh5IlwiEQmXTI2DqrFRtNINrg+JgEiR/YJ9LZc7ANZuPDhSgDApKxV5aUDU87MnZ5awiBLPzf9Gd3VNTZuwoycD13hA8yppZ/zyk6ViXJGOIvZAzGQdcu/QiIg0OPMHFUzpAObim814K1dSjQvZEzKaduLwreJXRgIVJ9POAqQajGgePMrDhTgh8hryF8vS5wZe65S3dCkK7NYi8rspGrweNh4J6nNI+ysj39EM1NtaDazj1ajsrFxca4mFKtVxYZs1eIgPAQm9excI0Y4o0LKB/tFGk+Mzi0r4Irc3gNe8nmSO7Fp1UVueKfFABUj9lTXMvjloWA14eWuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 14:59:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6043.033; Mon, 30 Jan 2023
 14:59:33 +0000
Date:   Mon, 30 Jan 2023 10:59:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iommufd/device: Make hwpt_list list_add/del
 symmetric
Message-ID: <Y9fbVHytj12rpmZD@nvidia.com>
References: <cover.1674939002.git.nicolinc@nvidia.com>
 <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f388b1f20622957518ec5a9ddc7f0037e7671c4.1674939002.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: deee5172-f75b-4029-838b-08db02d298e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HILuOM/wGk0+LuneqL6v9KpjZphG6/J56vSqim9ddN/4xnJqLwSd7rF9/ZE0ywesSi7QG+Ra8bwb3arzwd7rNn7cTZ69PshwtrYdZZ8a+rASZqUu0NZX9iPe/Taez+7A9J5cZdr9Qi8PoHEY/We7w38K754+e6CK9yXimmJEXjv3M0sFOKWQuJAjFBsG8tQQV4SEo2R+s+/GSrYD+VWUJ9nGLC69AgBsicRNxZ9oyq65EEGU5S2z9Fr1SU1Wv3Gsb/MwPyS/6ymP8046C+giuRgOswBiOlzoZtayCxY0K6sp56hnOsq6thaQ3WW1h1xV7onPELUx+cQRTXkBIVooXGl3z6lv9QdBNi8KW6NGMJF/hekxyjICYH17b/dGgrDYi2HcC2FVGE/HqTTD9zCdR1i44158G/8AiLvLkNqUTn5voIeSEfYdWTHug7A+VQpeUA2H3kUKTTN3e/2gSd9dsr+f4wag1/Pu5n3CVONe4udtdhjYph2mPDlToNJ00jkzuOS8zCrGdQAp9iha9QpqOMWzVKn+ui0Mqp7z1AaEaNn0o2BOdRw0R+AN97azTe/SibfXibR2X9Y1YGoN7UoTTMOtA2TeYm3OLb98ZpuUEdxmFq2TFpJIkHf8VQjW+UzAMcih/As510yaRrEntf415Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199018)(66556008)(66476007)(8676002)(4326008)(41300700001)(8936002)(66946007)(6862004)(83380400001)(478600001)(86362001)(316002)(2906002)(38100700002)(6486002)(26005)(6636002)(6506007)(37006003)(5660300002)(186003)(4744005)(6512007)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qknc3sg9HQ55UPzsG8G7f6guiUPp5K0yiJiA8dcOO1pxW/nlGnnYuBbmFBst?=
 =?us-ascii?Q?+uuWq8cp6CPRc7BWGM1bRroWan5Y269sU/Yrpu5y+zRrx6TrV7Upppt6UaGx?=
 =?us-ascii?Q?RluRcH3UEjKLnOaKbdtjHsOANaeS8DOq3go5MRxZuyvd5tDeYJr1EyUFRfu/?=
 =?us-ascii?Q?dsoFSYtE9kjNbefxXrOE+zVxN7KafTS8q4orgUP6F9BRHrGFxuC+p5pW+bib?=
 =?us-ascii?Q?fN2f7+NQA7BVGUY3Helc2LZFAZRB/DOujj/xtJYC/n0auLIAE6pA1HCcxKAm?=
 =?us-ascii?Q?kmuivs0PokdB0B0BVSx89Uql8K2UoXYIWrdjHbYyvYLx6ZJh+jr/K1WdqL/j?=
 =?us-ascii?Q?gr+wfYgfdg3gyNYyEeQ7Jm5ENE+QgJuAuG87s7T4O46sKiJxZ4Eizvb3Vye4?=
 =?us-ascii?Q?BS5nqdn+IVgR9WLlqbcy3sf3FlSW1q/6CG5oa0OJ7tn5OdyIUn/h7Gj1Epti?=
 =?us-ascii?Q?dJsmy/bANOvB43dgAFwnH+kPm1DuXRWpZ3d0l10xjf6eh+D6lJrOaWB0mtoM?=
 =?us-ascii?Q?w8osw0ZiBaxYNng3pFRJxgz4ATzkjmM+dBlsEd5PdHA2ZikQEVBbnMuLEx+D?=
 =?us-ascii?Q?HpfBsDYNrW52HfQuStccrSkjen7ovyWFqqlpFdraKKL8CEKowrvgpgWTq9L4?=
 =?us-ascii?Q?qOXpOgq+DwLqTW5Paafs8NJ4pKI+yw+3Yb5v3ARbucCI0X9K0BMFxp8ohb+h?=
 =?us-ascii?Q?joigx/PhLaiw1MgOnhP+zvzfeXldsiB3fN7KRE2zwh+t4kcyXjT3MW02rWn4?=
 =?us-ascii?Q?YEnqW4kIdLsZVHQGqBaoFOGuQovjio2+swuoFgoSprx/8vvARl54JXMlwBne?=
 =?us-ascii?Q?XX4on3kGnqsSPJIUI5+jtTZB5xxvfHMH1BTyy87pvq5crpkXTD38Bco+EbsK?=
 =?us-ascii?Q?bjwd+KS/sK6CLFp3LKwB6jgIdAqmzjDFBwtNTuKJKToX2gaR5MB1H4Q0UVgH?=
 =?us-ascii?Q?0EaOY5IMooFH3Wqv1kG8qngmFC0tW7u1OA4ABee1EbvtjdPgsVciTqR7LIKN?=
 =?us-ascii?Q?wQEH57WKueejBIDVjbAQOLa2kXcFjD/w5V9S2Mqsm/P2DOgxe5DjSm7SaHlK?=
 =?us-ascii?Q?wY4bhwfsGIGoEze7O8x6FgedUIl6fM/yq1c8ffjfcXS48SgvqNyqOTTzkf+1?=
 =?us-ascii?Q?ZdRLpJ2VNTGikj+ixWRBPTxw91LwC+KjqKpa1tLP4oesyQ1ne8WzQ/As+a2E?=
 =?us-ascii?Q?ySwTvEQeoTroyYgIDba3yZH+WZFk+XEuVW0Qvcd/TMy/DkpNDHUeI0GrgrKb?=
 =?us-ascii?Q?pLfTwEwAg2fZ86cJ81Mb6foSoFPSiFAqZpt/pEqua/p228x+YiZfH04SMvTJ?=
 =?us-ascii?Q?hINq2fs7U5CtMqblYE8T6SpHIZ/Y0fRiovlUxyZYOsvN3tQWC1IvQF7USTD2?=
 =?us-ascii?Q?l2z3yzWrJqILYv80I5VtcIK+/r1y0mVqQ4xZpE2GreeuwOieme82kdlHxdYF?=
 =?us-ascii?Q?2UBUjI76FiXVHa+QLY2I5+6UKFuKG5KbXdyua/BFb7E5f6tBunSmlneTgFav?=
 =?us-ascii?Q?b+jD2lrj4FaXHT40Nk1qcV0+tcm25VzDaLsTvlrDJL3QEpfWY6V+ZaczzhFW?=
 =?us-ascii?Q?cQAOKSUK33MkUwzifVSs6RXkScVeaT04WNjqLi2z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deee5172-f75b-4029-838b-08db02d298e7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 14:59:33.5860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xfwi36dhaM3F+cHLWIKoliRuU/WdArv1qAWTIE4f7LwmH8aDpzlNuRKGxZKQEhb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 01:18:10PM -0800, Nicolin Chen wrote:
> Since the list_del() of hwpt_item is done in iommufd_device_detach(), move
> its list_add_tail() to a similar place in iommufd_device_do_attach().
> 
> Also move and place the mutex outside the iommufd_device_auto_get_domain()
> and iommufd_device_do_attach() calls, to serialize attach/detach routines.
> This adds an additional locking protection so that the following patch can
> safely remove devices_lock.

That should be two patches then, this is just moving one line of code
from what I can tell?

Jason
