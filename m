Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E25F68B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiJFOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiJFOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:01:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8670AC3B3;
        Thu,  6 Oct 2022 07:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4HdQnysHKdwQgNLxwfWnTdqWCckW4ffbp7xTezP6rYemTFPnKfHpsykJJq0I1axkTs4Ijdk5TIqqaR0QeiClcpzUFkqAsgufTpxvGrlCpbIwabENKJcUFdF/92k/WqQaCOfrlQKvV39e7mB1Kmx27MCXhE6hT+nxLoAmqh9PzdhN7+2EXJx239V48HhZqYdwel1ntKjH4Aza6KnYPGnf2Qs8//V7M9nMYouWs7Q6LhSXwCCE9Y4ECenpWMP5hRUG3ujCMUXaoPmoyMRDqc5OAfzBOED2ghqnT/O1cfE3XZsKB6M3V0mFmywpEs/unFT2sdwWL/THSSVcqz9G9vaRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrwOGSEH5Xoc0h9yVW5Nnrj60gAxTwm9FxHQeAHBwfE=;
 b=YM3+hHkilF88R2elga7nnREc9ml6VERTIQFQyho/3z0sShl5tFaMiydBHiKBpMn7xRUxd7Q7H6sOe9AbEFhyO1FTr6PkPIcWb86+myg7UTzrk99DZHz9+2OJpNm3fLuHWOF0gu85R5hgKpvvmWcboVWtO1pZnA6c4n7jalBDsyRgyI0ar8bKYOJaDQMTdRh0iy+j8z4CVX6Cj5oML+Rv5MzHM2uxM5MefYoMGh4eUYRms/W0hfp00nkpKlqmk28eD8o9PRWoQK7e+PAxOg3Yw6Q7rAcnFLACpU3L3/+Il13ARJCYEEh7lWsnM2Qvit4NNe+ABkxmfnoUbwI5wgS9xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrwOGSEH5Xoc0h9yVW5Nnrj60gAxTwm9FxHQeAHBwfE=;
 b=f0NjUQtyzRV9iZ9tU2/18e6DVRWyZh+Z7ZqrI6f7bb4EPFdvduJOLqr35pqfwQWNSjNjbtTmHp0XvBUPGiyS+TDgOPwFFPwD2K/c8L4SqXecwfsfIDgUAWZgIXUBrdEsD2eYw1o8XpTiB6IvgX6IkfsVUUpUzC3mHf6knHwxnRjJ5KGxCV3dNp19Z6Vg0YaUTMiMNUcyLZV6pirnR6ZuidWYgMUb9A0nJwpcZ717n8D/FjYv6g22fBGEk+AHuM/YAXTdpRWgo2kF5VqceILzYG4D4eH1bSS7pp2LVDUNhWHKY2dqCY26P0SFBuZCqnIJ+5YL+qwmci4wVSevxYxNHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ0PR12MB6735.namprd12.prod.outlook.com (2603:10b6:a03:479::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.28; Thu, 6 Oct 2022 14:01:21 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 14:01:21 +0000
Message-ID: <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
Date:   Thu, 6 Oct 2022 15:01:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ0PR12MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 67537dcc-7be3-4d96-adaa-08daa7a33f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejpwd05NjFcehR2mmTX1oBtvG/01vPsfKp+CkTeVJDuLttZ24FL4OlLQwHdJwEJKQuQX3GA9qKkyyaFMhHMOLSmE1Byyol/e+aaWuS8vqWat1or/o4uBLwdtFHof8KJvMSM4S0xdpKqlKYqGfG5BScpdTT9+aKdu/x4anPrf6Hq4dX6rWa14K5M5NKi27hONKfsZNL+YVXENQv03e82hZNxg0dp03OwLwxGBLAn+VN8ikoha3+HQyN1qAdi8+CgyqPxmX9pITMYFK0VvWvZolCk84dnhLJOcml2HhD06kNEKflsOJP4+B5MjJbX99MYbcOQX7cBmFAmM9W0jvoNyLSrI9NqxiPlcibtqn9DvRWgDgR6gfXsFFZUEIaqjXwOYSiwuD0L6UYmY2azKhs4+oIpO0x6+H7q7oBTMn/HxZN8+ujhqZEBlJe4Ro+L5009dabEC5b3RtHaQosP832LfTo6n/YoQBI8KtTd3aXaoQE7LUgniO3rksH/vfdlqR2uVetYST4A7OE342ez20UbmG79AOjgq7g/kzrBfb1Yz0L9jaOv/X2cGyb9TAFfP+fB6mA70WCa4Y9H8vxRY749QiVZD3qYEjQ6mLf1kRWL7OpRT+vUWFFh+Fj11XTawgH5UvIsNd0b6EpK7J23ErTUpYyfCJl9rvY0XAMSKhqR3V8OGfD9ruj/a3Wd/pRuOel9yB4G4WorAeAGlcbPQlibjxeWDtPrixHOitBznuO7o4v31DpMFGjRG1onL83H/SMWBf/i1ClY/1IF4igD6SVtcDx926XriDzaLTSAJDp1hmzE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(31696002)(107886003)(6666004)(4326008)(41300700001)(38100700002)(66556008)(186003)(66476007)(66946007)(8676002)(2906002)(26005)(83380400001)(7416002)(6512007)(6506007)(55236004)(53546011)(4744005)(5660300002)(36756003)(8936002)(86362001)(31686004)(2616005)(54906003)(316002)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdWSnZscWx3c3pYdDExMG5OYXBTazNtbHl3NjdQQ3BnUUZvMXFYTU1WZEQz?=
 =?utf-8?B?cWVlN0Y4MlMvdXdVN2NKSnJ3d0NlUkhtVFgrLzJTRFJBbUNXNjVHcWV5SW04?=
 =?utf-8?B?ZHIwU0x4L0xtQ05BNmJDTXk4V2hVcGZUZHBlMlY3UGhtaHB6VVpnNTdLTkhr?=
 =?utf-8?B?djRZRWI3Uk85Tlk0SWdkSXZEVHFkaU1qTW1UVFBveVBUK1RtS0RxWGcwd21u?=
 =?utf-8?B?WGV1UUZweFlpcEZMREdSdEM1M29KS2FYR2NkRlpXVm1PVU1SN1FXaU03MTlG?=
 =?utf-8?B?ajYzU1l1S3pQZklnVkhCbk50RWpQalMxQmk3TURCeGcxRDB3bmZObDdjam5T?=
 =?utf-8?B?Z2ZuZ0hQcDZEdWhuRzJzRDJTN2N1NFFWQzBSTC9MRVVZT0J0QzY1MkE4N1Y5?=
 =?utf-8?B?RGR3T0drejdCdktIR2Vpbm5leldYc3Y3TXQ5NzNHWUhlMG90czlyVExGQW5Q?=
 =?utf-8?B?TDg2NWkxcmRhb3NTcVFOY1hxdzZNbW82ZFQzOXY4S3VkVmh2TVFnUHJTNkRQ?=
 =?utf-8?B?MHltNWtsVzY5TWtpRForWllHaTJYSmpYSVJuTTNFZlJBQUpvSVBqSEZScnM5?=
 =?utf-8?B?ZjBZYVRIZjVLaWxkNTRCb0dNdll5MWdTT1RhYjVPbHpSSSswM2F6enpKRHZX?=
 =?utf-8?B?RWN3d3pwcDJYaDRud2ZNckR6Q1pFWndtamwwb2JmNitPUXdGMFRaaWx3KytI?=
 =?utf-8?B?NmF3bldjZW1YbXlDZSt2YXg0aDg1eU9yNVlHaHpBTGcvL0IyVnZPcnlGN2tj?=
 =?utf-8?B?MnR0SHV6T1ZDdDBnN1ZvOGVmemdYVklJeHE2d0dSZVhSTTJrZi9TNC9iZE1B?=
 =?utf-8?B?T1MzWUsxWFdIa29iY0hYazY5ZXNDMU45TVpwMWpKOXgxWHdwMjJWWGJvcW9w?=
 =?utf-8?B?djR3K1NqeWRiZDhLeHhkY0kwQUhHZThDNjlGMlZkUnJIWStYWTJ4cGwveG12?=
 =?utf-8?B?SUQ0em5GY1lWcWxjdStlZ0MwOXZ1K0FjUERnS0E0QzI5bnZwZmZIcVJXbnkx?=
 =?utf-8?B?MkVWZFIxTXVwWDJBZ3IzRFlTenNGa2lTUkN3UU5qTGJsTnJXR3hRMTVnRUJq?=
 =?utf-8?B?Ni9ZWnJiTEtnRVFMMDEvRU85WU56VjdFNXdLWnpLL3dndUE1ZkM1NXhsZ0l2?=
 =?utf-8?B?Zll1Y1EvR3h3NXhPNHdJL0lZVVZFSjhyTmRJRVJ0dlNRckpkdkNlVXNQSFhs?=
 =?utf-8?B?am8yZk1FMjJ2N3NBdzZoNEFESERrSDB4c0M5Ykpxb1AyTHE4bE1tdGUrdWJz?=
 =?utf-8?B?QS9Xc0dvQmxGTFY2SWFCZkxYbklBSXFMU1RteUVzdmlXM2VZSTVDN1hMRytz?=
 =?utf-8?B?Y2IzSDVDWEl0Vk45MkNBbklONzcvU0l0TUZRdjJYbmp0OE54MldwWEY4ZjBa?=
 =?utf-8?B?VnNwY0pHc0ZhR3hGbk1VcXBUbHU4SGw4VlRSOWl1a21xMnF1bi90ZURydHVH?=
 =?utf-8?B?N1prSXJkTzdVM2YvWXV0NUJIRWlhSEdvVnJkR2JjMFVxTnBaZDEyb3gyNjRM?=
 =?utf-8?B?anBkZk9oa3VTbjdTQVZpY05mSkRibCtHUmhJRGthSVUwZC9TbjM5TEV6QjY4?=
 =?utf-8?B?b0JnK1ozU1JvZk5GdTE4VFNkOFZLdjQ2N2ZucXUxWjh5aVorb3NxR2VoY0Zl?=
 =?utf-8?B?dlJzR0NHNk5qbExTYldRdnEraTRzb1JEQVd0YnE3ejBMMVdmZ2R0dmdPd2J1?=
 =?utf-8?B?Z1l0VklpTEZFNjhGYnVYVzdQUVRockF1NFNKdldHNnh2ZjJGZlJUUlBCSTNK?=
 =?utf-8?B?YnFBa0laY3VpbnphSjJkL2VHS0puRHJsd1o2dDdOVHpHMUIzR0c3dDZ1UEhp?=
 =?utf-8?B?anB3OWM4TS9QajVGOXBjWGdzaUs1SDJQZWtjOHF1UkZHUTNPSXNEc3Z4VDl0?=
 =?utf-8?B?MHRWUmlEN1VSSldHeUxlZUNZTldzWHVtSTlFQnFZZVdRcGVVOTJiN1lyam5I?=
 =?utf-8?B?RVg5TGZZV3RBYmxYeEgxTVhzdGd0Qm5PZUh0UkphLzJlZGZwV1JPUGNvTDZx?=
 =?utf-8?B?ZkplSG1BZEdCMXRsUUYzQmN1L2MvY0QycW5EWkZ6Y3VLbHExSU0wUHlFaWZ3?=
 =?utf-8?B?aThmOUROczdGeHh2d1U1Mng2dnJxakhUNUtpRnRPaHJySTFIU3FqSjlHby9j?=
 =?utf-8?Q?/oPpToPhQBx7L0DAR/nkoWSP4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67537dcc-7be3-4d96-adaa-08daa7a33f30
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 14:01:21.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYmmQ+E9hxmLCHYARmYwntCyoMp2WQYUs5fD0xaObWg0UZbXHtb8FaYb6l7Jui8AGPNIMRvFQzwIxgS2VWxiEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6735
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 15/08/2022 17:20, Robin Murphy wrote:
> Move the bus setup to iommu_device_register(). This should allow
> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
> 
> At this point we can also handle cleanup better than just rolling back
> the most-recently-touched bus upon failure - which may release devices
> owned by other already-registered instances, and still leave devices on
> other buses with dangling pointers to the failed instance. Now it's easy
> to clean up the exact footprint of a given instance, no more, no less.


Since this change, I have noticed that the DRM driver on Tegra20 is 
failing to probe and I am seeing ...

  tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
  drm drm: failed to initialize 54140000.gr2d: -19

Bisect points to this change and reverting it fixes it. Let me know if 
you have any thoughts.

Cheers
Jon

-- 
nvpublic
