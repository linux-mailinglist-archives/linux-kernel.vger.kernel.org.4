Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E697133DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjE0JwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjE0JwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:52:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F619C;
        Sat, 27 May 2023 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJMACilEQJGTrmpQMNO9q/t6cq4Mf6VnWxqLsmaGzc8=;
 b=eqHV85Ovun+uGsvsMFjt3ug55O25ueBZQBkv5rbYRkb0KqFujMC3KKpZaPhxGAKmY2CGKN7q1OtL528rxEge/yt02NADcoDj28xg5WE09mSyYaRaIxcs1Hz3NYK3ypGfPJl6kfEOT7ahWZ2dQ+dJFEWJTjgD+jNtVQvMp4odPAlEozp5rn1ZgVG1QFeG6V2Bvah2jjviUMLQmAPDWcfAthowwORYbPYLPnOJ7l8cwkrra/Hf8Iy9qbmP+DFSvPZzhZ1afV3inW9Gan7Nn+9YczrNUdBeCLB8BwHatw4Vf2OMgTNiSAq6NkkAvskOZMO0iLWUYt2u37P86VU1Xn3M4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 09:52:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Sat, 27 May 2023
 09:52:02 +0000
Date:   Sat, 27 May 2023 06:52:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] [suggestion] mm/gup: avoid IS_ERR_OR_NULL
Message-ID: <ZHHSwRzksE+KukTK@nvidia.com>
References: <20230519093953.10972-1-arnd@kernel.org>
 <5b071f65-7f87-4a7b-a76a-f4a1c1568ae7@lucifer.local>
 <ZGf1hV7iEQyqAim5@ziepe.ca>
 <1ca47b8a-292c-47ab-aa6f-ca24fdfc0d3c@lucifer.local>
 <ZGiEEPXdAMnKqkqx@nvidia.com>
 <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc9dc2b-0da6-4d5c-96af-e21aa287eecb@lucifer.local>
X-ClientProxiedBy: BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4534:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aeb085b-1bcc-4708-c9a4-08db5e980574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e+TfNNBS1KqH7r4KFTAZADQmohmMs6R5McsieJxoUVYEOypzXHbQXunVB+K/KWV/gK2mt0/+6gd8POFtslYCmxRTU3zGCsSA/pGdrh5WORJvwOMge6V7BLZrXaExVmx3rKLJsazCMVrHa5UopX2x5FV7rJsOHYm3qLW+WmKtDH2i/UhS/c8Z0A2dgOLdACPiUPKKVb/6FwA1g3oW/oe3s6u0ma6zYm8mE5SjaSM4Fgzg+1a5BLlBXksXX4sW0YbQB3zYZ4FQ4IkfV5238JlwWEhM2nXjc+p0y8DlnvM1/HUSLtgtR44YOj6tzAa/V0as6JmmWYCxJEyKJWa5CdCsm7g7sqrHZfw+Y18EDeJ3LKIykTrRMYGHJ1OyWrHyrz57npN57DaE0JCIXFq7H4+WEeoRHh6sye0+KW2tXuVMe8ocltYHPDAqQYZU7ttvdgu7n3KC+F7wpw3kbVB8v194Lhe+oc9BMTild/9YqqtSMSG6IYmYV6MV6FonezU6w3dO+hFjJbT+c4uveYi7FEfj7esFo4/6LgPOXZ5PmINGgKmmBvXrYo6Sza2hz8cZYjghrZZlCu2u6pBGEeWbnuJ2QpfyF3mWYa4nQztukdcuHas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(316002)(6512007)(6506007)(2616005)(8676002)(8936002)(86362001)(5660300002)(7416002)(6486002)(478600001)(54906003)(26005)(186003)(83380400001)(41300700001)(6916009)(2906002)(4744005)(36756003)(4326008)(66946007)(66476007)(66556008)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T+CgMhijvn57ihQGtt8M1420yXrP3EjjXyLd0mueYyzFLGVLEhs51wQSlTfO?=
 =?us-ascii?Q?U80lbcbQFueaoYhHViSwXeMIQJFg2wV7g08MaOu7XeSM/rqT+GzM1wB2/fJe?=
 =?us-ascii?Q?5Dz9OXhsrbnTn9Z6wloHxE2ejkx3BHhfegBphqkatPDSqPJFxjG4xmG/Ptef?=
 =?us-ascii?Q?gfu6PZPKYKG9VaO8xj6nwZ7YPnZcA74HNDYpPJZR7nrJd2QBfgTnTlHG9XPv?=
 =?us-ascii?Q?Z+UVqGjlZmpB+cqrVvXboN+7tXS8sQt/BZuqPMO/D8YFnCWyD9gqQ+Dp0FXy?=
 =?us-ascii?Q?Wov3ul4zY+VzzCZYO2fzNHdUbRGxYhVTA8sq7wvz+q1rhZtNXymcHpit3Egx?=
 =?us-ascii?Q?+NcUmvCHbtiwfQ/RrTqmc2JMw0j5WdvQYI3ZsryAISDeI5Dtb2SAUUlNQAJ0?=
 =?us-ascii?Q?VLXpqaVBfleBU05esPY4pc2haLYsuEQ08rjzGHXrxg9s8jzGLZCDlxVnkP7F?=
 =?us-ascii?Q?Ff7vVEF+NmzxTC6RLc8SLFox73vAAMvp4bV+txBYHpc4cxyGkJsZggh4gM4E?=
 =?us-ascii?Q?XM91MhgB78FIl5R1ZESGKOjFtaAHHWLiH56sFLQb0t8x6/WOr6RvFAFJsNK1?=
 =?us-ascii?Q?iTBILbEqmQvDy0dbx+zzQ4zy0iRu8QujWr6LylWlahImpE8F6xtyayX40d8V?=
 =?us-ascii?Q?HzL4ye+liiPcEB4JJGhflQnXVpMnk4E1cpWMSsjmS7LdQWPjNqjkkkDeq67Q?=
 =?us-ascii?Q?RxP39ljRvOkO0sbFreOdMrvYaEZSzYVRIi2bVWvJfMMh69ir8kAOZhROnJHt?=
 =?us-ascii?Q?TnYI5BRxTo1Wp4JtqSu2tryCzLTrC/n9D3YjEto/sCa3itoDEAY+sokAkz1G?=
 =?us-ascii?Q?W5Kh0LREIFAz0wc2hSldh+C8brDoHhRV9r8lt7rbakgbbFP+w5/PT0cShss9?=
 =?us-ascii?Q?aVEKxj2apSSvdii8F1VGWEv5AfqRwE1qCJigebSzxkTR6xsGtXs3veyTvFBV?=
 =?us-ascii?Q?GSU3ifPIyxr6thqY4ldAUiKqixh9RrtTnSW5plUUWgVVpUkrR+BEeZ9tKPn1?=
 =?us-ascii?Q?9fK3N2wZoysuz9UDsqRd+KNNDr+KEsjqecAc9dl1TGFcjbp3D/MKbY0YZW4U?=
 =?us-ascii?Q?f1QKP/dcc4WYnx9LMO2KfPLGL3U1pUgwiP1WMxg2TeOFIKmfpt9v8VZhulc6?=
 =?us-ascii?Q?/aa7ZBrRP+WEbdBTuPlMMLhBloLU2HUaH7tejuu2dYLQZ+VixOA2ZCgJ9rAa?=
 =?us-ascii?Q?CParYk8P8NDcTXvh2oJxvvXFGizUJ7uRgNuMc+ceFffvAh3Jh0r90rVyaVRk?=
 =?us-ascii?Q?wuBS13AVBHd/EGMd8LQ0xuHmd/CByQiaJUr3sXLjRoOPHLMxuyEr0canA+G0?=
 =?us-ascii?Q?KHMjIQvdxF5WdXSp/61L57smON/MsMcFq6j2CMdqgMwRWA1GFcCQ5uZJqpKn?=
 =?us-ascii?Q?g+lJUAgK1nLNRYcDh2RbazUy6gNfLnnxQQyg62ogFLt/buvut8uciK0AjhFK?=
 =?us-ascii?Q?ZC4CueCg5SbtDOpgQ2TOBTSYbfsHmsDCeRbwCFo4SpRtLHWUTkbvxZ9vlLL/?=
 =?us-ascii?Q?VrtCKpJ6qWOohTK+5rd6wc7S45wd/Q9gJ/QZ7AghpHTIIhT1zjNAvb3INS6P?=
 =?us-ascii?Q?6fH1KEx/2i4+OrqRXPY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aeb085b-1bcc-4708-c9a4-08db5e980574
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 09:52:02.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy0KwulSDMECO5ylbspC8XqmAP9kFkZio/d5zpuLoTdVGzRHHUM1km8HsGitvbKP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 10:12:40AM +0100, Lorenzo Stoakes wrote:
> > No, this returning 0 on failure is a foot gun. Failing to pin a single
> > page is always an error, the only question is what sub reason caused
> > the error to happen. There is no third case where it is not an error.
> 
> The uprobe path thinks otherwise, but maybe the answer is that we just need
> to -EFAULT on missing VMA and -EPERM on invalid flags.

I think uprobe is just broken to think there is a third outcome. Let's
just fix it instead of trying to pretend it makes sense.

Jason
