Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947D36B4C25
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjCJQHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjCJQHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:07:24 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392DD457DB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:06:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sqqgv9rrx7RZbx4cgDTKU+aDzMO/B7fDKZcUX4xIgz4qgwsvH4Kug3r7F8C9mjIqWyEsIAVQV8VxiERj8xcGc4/jHctd8e9qrbzlw0K6YRCa85sxjbU8KMMO4osRDkMrpnfn79O0O/lHcDf2CEmMyndiJZny0A1J1G9LxBMNkDbavrKdj9759/CdylwltrSDk6sg2kIYb4gvEAwq7IEACZLNwe3H821nQSso/Rq6oHj5cwxukQvQzkzWi8aRZ/fdGYsh42/h/w/IIgqP6fET96aBemv6JpIyABCORs6lwg3f0S7ZwQRM5hrkndhbNLl5SRgvHc98Sm5fP1RB3ZLA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMPtQ1WGLxXEUdZvOD665ufznP27Toc3UqtVqR7dro4=;
 b=oSWzwaQpkMpqdnj/o0kIPh98gh1kmvMPiII6xLrExaUP7x2jLtUnt5ZEefYrzmTMB7YF/o/wmbYsW8OhUM6FKQklpPXXFwVHCILX0+hoQ+c6BWP828UjNrjFxDnZ58CxGFYSZjy4S/DDsgv+c6h8GzOT9lmbtMq1+EX4x0y4CwTk5SbNFlr9AB+63rfZrd4tc0uEsSY33wyQ/ig8WFZ7y5hUK3u6olbV3M8kauP3XgmAJl79nnupET4HryzbhrDp9Map5+kw3qztJ+ExGXgJ6XDsPRMpg7siAjGYhSnU+wzkQDA2kkjEbjh9A10uCcFRJfiw5ppQFTR3ZhZL2hZ5BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMPtQ1WGLxXEUdZvOD665ufznP27Toc3UqtVqR7dro4=;
 b=Dmdjm/j3ueAX3V7WYhLEZeS0C8jorHeyhFLUnIA2NNRw5SH/vrKgtYRyAWAgTqbquY5WQk5FArCsLeVm2uip7YTv/7GbNQzw1qAK1OBrRZO/QNcBUcoyszbkCr9GI2369g4J2Lp4KS1ryH+LUytR76/dwjN5MPqti4ULgtvdMLgpuGzUqSBcXpxZ00ErZY/QzWlgn2LE3uskI7R5pGC+xh9lbFv1IthQx7zkrdWuTEHnKf8VnttfZdg+nMJWmQTmDW7pe8/zySgukAR0xgRm4TRyIPRUGAHOtewmMm6spdl3EoGQ8VcGltFC0Kk1pnhbzts7P7FlmwpEfZ01RxATlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Fri, 10 Mar
 2023 16:06:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 16:06:21 +0000
Date:   Fri, 10 Mar 2023 12:06:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        robin.murphy@arm.com, will@kernel.org, eric.auger@redhat.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <ZAtVet99P22FNusJ@nvidia.com>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAq3LJgbo8ApejvU@Asurada-Nvidia>
X-ClientProxiedBy: CH2PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:610:53::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9020e05c-3f19-49a5-e432-08db218163e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QBuZ8x08IlpfXZqJ0zuUUVMxfJ+WitKEgBYlEhyDNfxlA9aHPxAiHz0a3gwz2zAM2YeoiPXjoCsAKU/FsmcTxNzBvPT1p0c47TgblO8fFgF3JN2J+HyVtapC90zQT/iGouEak1TfSx2Vx+VKPJt3v96d44fvLI0ceFG/ikVlXVNjMeNLKzjIhqzaDCJfPsA4daN3X4tGb7VCuyjUmfs8i6L9m+1QW4+yNjKNgUFgA+VAJCHMMsVPTRXKG/qLu27WZvm1PdhmMSEWqOPbUX0hJYaJaSp9SMA7PDy0Z8sKtXtybOwpSAkmoKth3XGNugd8qcu/ySOu1bcA3ISga5zUlvlHLv5WL5+itc0aHSMdVXPHPvwJfW7UWwUArCVt7rU/c2y5zGLlkovfD5k5+H9VfjXYdfKQGQsfoR+k3icjb3ybqMiEplIRDpWXYbaM1ZrMwsdeqh3eVyioobg72Tmg9WBn+vT/O7XUrR8J0MCrpA7FWkwaggSdGLEyI9YMCHvHrAGyrO8rheRU0D231UWjifCoJLcQd9UaYYEIXcPtBT4q8Is+OuyreGcecNA44tzOnsAyzCvTd+TJA1uqLA6KaxGFLXn4oR4PF2wekvyuI6De8EFqae47RS8eoJfYvz7VXTVoq76kpGlRtgVS+Q6eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199018)(36756003)(83380400001)(6666004)(6506007)(6512007)(26005)(186003)(2616005)(6486002)(41300700001)(6862004)(8936002)(66476007)(66556008)(8676002)(86362001)(66946007)(4326008)(4744005)(7416002)(5660300002)(2906002)(38100700002)(316002)(37006003)(478600001)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tt4ZoHvuOONbChMJPkv94RWxgjIvK+qjxF0uZHBWHbWP7cXyh6xIkI4E6Ls+?=
 =?us-ascii?Q?tpVlh8gRFhzvQrWqQRj/Va9VtPlYyMQp5hOB10Jb4Jr5lbBkyyc0UtgwFQCy?=
 =?us-ascii?Q?wWoE47BTnlFvG9EjfNRhvBwKJCNI1jufuOxsfBoZOxv9AUFRHgllMaNlNSsk?=
 =?us-ascii?Q?dgMzXHayMGJhFJSo4xR+vja1KYTkgVt4kquxp+C6T2eiDLbXZXk4MQ0CkcI8?=
 =?us-ascii?Q?2xqiPbun4kNOgp8rekFqONseuJF8yu911apEVcdNYBliZG3UN+cfWtOaHDkQ?=
 =?us-ascii?Q?QJ6C1NovL915m793Fc8HXXXLvdWP3rBG6BSH/4tpIJId5zY9CLAcshpPdpo3?=
 =?us-ascii?Q?rhVlnij0Gphmf2tksVQSTab92ldguElWDoVkwZtl5AsTBuhXbVSAvaGGLn04?=
 =?us-ascii?Q?wGj/l+6nREuVll1uvQ9bLdk60BqZaJLjpyT3l8gMIBIUk3K409itT84UAfZJ?=
 =?us-ascii?Q?7n18aNP0VAebmSGQL+s7id6ZUInrNT6miqoztQNJev4+J3OhIfu/Uyx1RdYl?=
 =?us-ascii?Q?Q47h20ftTX6QV6eH2vM10XHEH4kuw5ckLbN+GhH0UmFp74uq89vvrc9VaMS0?=
 =?us-ascii?Q?bMu+EiHE0+wSIG7dsgQkISsUsGHGNEE3qNNiyUDVQ9/MN+3eLk9qndFDhatl?=
 =?us-ascii?Q?Z+bTCMhmH6i7yqvfyyjDAfujQRXoD8xFqJOBRJQwm9d7pGqGETulrh6/MvXl?=
 =?us-ascii?Q?/T4j/ipfGiB3Il0ZF7GCH4ITMiTGqdjPtUweg8t+9eXCNgxvMcmMMnhp9NL5?=
 =?us-ascii?Q?WKFlAoClke4o0BxxYfBVF9rzwN7mwtZud6CpI4zmkeJ/jLvHlZua9mVvSpfC?=
 =?us-ascii?Q?hSMD2LvAx1iL9BKGSQ3DWjxA0OtSSnKH2csEE7lnLkZ8ZkQF9kJCT2MbhNXO?=
 =?us-ascii?Q?c3mVhvbkq+ACXOi1gVfZGTxVwsKI3hwRUXcTOS1NL0Y/AFZVLOqBhLTLb+9J?=
 =?us-ascii?Q?UXielmD1rFgfp/IuXb7H73ZpeFCeMsFEtjPIqWEHEATcNhI6FWozf/2k+6fd?=
 =?us-ascii?Q?OIGLucziEWvShW7y2pYd+YiT3xyD7FoPZKJlaAwnOeXTrn619ufWjUYktrFl?=
 =?us-ascii?Q?dwGjikv1qCq/e/8UdVPIixEmKlCfhLO0W5ChywgZbjelzU8zFqhAlS0pNim5?=
 =?us-ascii?Q?mrtEUUdpfMb8W4Eoe5PBmiYToFP/AOXXnB35Xo4RiJ6zmzZDvfDN76uDpFap?=
 =?us-ascii?Q?ftU80L29GkTlQZC1KyUSFmyYmHIPm+9k/SXZ4FlnhMQn0FnzWydwOw6n5NnF?=
 =?us-ascii?Q?yBnWLzri7ueAaVYv2SZkRwqBIybsng1TaDICMt3KbF/ykPhhAR/M6QTLBztO?=
 =?us-ascii?Q?kwgGrxD2fke7ToCqFwD4zk4MW+XMG7uNc7g04p+HKbH4gpcff5aGYC3eHAWU?=
 =?us-ascii?Q?J4wrI40z230jsx7JVgjRlwzXQONeKXXp2XJgy3Up+GtOcwCrtM3dWOLsa7im?=
 =?us-ascii?Q?F1ZwHesJwKSbM2ygzn6SUgiUobUWZA6EMv7ZXoKOJ31U69zTaAr409NKymBb?=
 =?us-ascii?Q?SGLMZ25dzZIEy7uEDjGH/QOOQIncTYY8R7TqrjtrNbrSiT0y+gZ9mWtF3cx2?=
 =?us-ascii?Q?Z4cuX0s+ABNPq6GssWTUKPkBSE8w5SNlNAYsK6+5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9020e05c-3f19-49a5-e432-08db218163e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 16:06:21.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awuGzs+TjeOCkzFOgau6mJMVef0RNItNoaIsUAJnrvYn8gIn/l25r7pYCV0nxNfg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:50:52PM -0800, Nicolin Chen wrote:
> On Thu, Mar 09, 2023 at 10:48:50AM -0400, Jason Gunthorpe wrote:
> 
> > Nicolin, I think we should tweak the uAPI here so that the
> > invalidation opaque data has a format tagged on its own, instead of
> > re-using the HWPT tag. Ie you can have a ARM SMMUv3 invalidate type
> > tag and also a virtio-viommu invalidate type tag.
> 
> The invalidation tage is shared with the hwpt allocation. Does
> it mean that virtio-iommu won't have it's own allocation tag?

We probably shouldn't assume it will

Jason
