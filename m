Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53376666B82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjALHSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALHSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:18:11 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7AC55BE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:18:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coPer46sI0g89MLQw4m0dv+DsSj3cjl44FnDSqQgt7cTwDnvEW3LoZkedOBUT36pJaJcmyPnS9yyVc01ZMdfBZZ7tBge1v1+DE6iZZetbcjxsx+fd1L9bnJk63+jxbGXnCSDx7KmkiPeZriPZ7j9tYLNNquV4s7PZkNdW002LkRqDNSJ9HEvbcicaV/41NjrQ5pYwnrJDMl6g63/DjBncVI/7NVLV/T27dHNgFZXuhAbPPQSQd33VI7pgu/mYds5kFVykwIu5/77Qz4WAQp7ABoNZylwYw6fVgFS4/Dzh89T4HcJRAWrwHEhfds0Pd5XLLOtv1KR7GE2Px9/QRR0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTcLxkw9IBcghfrCm33j0Eai1yQi6026UzvfYb7uiIY=;
 b=ZkrX7Ue6/a/8+aqfjUU5/2yTW3qqbswZmkRRx6DwDxqR1krFwAtQQlwX3yrzxdHW6oRhyek20LKdt91KRn0zCvMPvHaPPOk4jmAW93ymQPho4TYYmRceLBXaAazjDQC8918wB9lIOlid30h1oGBXpG/lXmyVAI9IuaWmpAdwEez+9IpULFBpvlnabK4zS3C9PMj1OGVyPRJjlHt1Ze/mnm2RTnbCU4Ux9dxnQVlj/MKjbXGdn5c8+E4eLRGFddWeO1pAA3RC/HeQ4bcRtcxfpU+ESkfDCp80XeqYDYSkHghNFzzLt99rXKUZR9CWM6R4opSVq3N514FdDeS64svULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTcLxkw9IBcghfrCm33j0Eai1yQi6026UzvfYb7uiIY=;
 b=rsXQi81Y5ag4nYciWz7fCZU8iJxSScSl1WL6R2xFdKoR0FHgvI6bYGd461ZwwnEdi0KobWLuYeMTG1fGKdCWzM4USRcdH2touWP7ffzLkdZjAiwdhzkYiQNja55nORfAN8QUh6Vx1evPXsDOHANO1votsAPTQBYL9nywoYUZwpNxe1fFgzpE8LKq2E5dvMw8UtrRM/gk1pixLFTQT3gg2HfFbgZP/LLqrhHrHO6O28nGvo6V8R5+O6EKYbDPkQsqwBqqQ2jfxtzl1MOcmEYGpxnQH9k4LiPDDDR1LK3FBY6IUV1PqPhkldPrMxPY2VhJF9Ec/Je3SAO2eXzWWPIlbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) by
 SA1PR12MB6970.namprd12.prod.outlook.com (2603:10b6:806:24d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Thu, 12 Jan 2023 07:18:08 +0000
Received: from DM5PR12MB2485.namprd12.prod.outlook.com
 ([fe80::bf24:f5ca:72d9:cb50]) by DM5PR12MB2485.namprd12.prod.outlook.com
 ([fe80::bf24:f5ca:72d9:cb50%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:18:08 +0000
Message-ID: <48867b62-bb26-5efa-e04b-696a0f2065b9@nvidia.com>
Date:   Thu, 12 Jan 2023 09:18:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: drivers/net/ethernet/mellanox/mlx5/core/en/params.c:481
 mlx5e_mpwrq_validate_xsk() error: we previously assumed 'xsk' could be null
 (see line 478)
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
        Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        "Adham Faris afaris"@nvidia.com, "Gal Pressman gal"@nvidia.com
References: <202301100424.sL6nSNSL-lkp@intel.com>
From:   Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <202301100424.sL6nSNSL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To DM5PR12MB2485.namprd12.prod.outlook.com
 (2603:10b6:4:bb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:EE_|SA1PR12MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9236923f-84c9-4a39-f338-08daf46d276a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dm5mrd03DxJQvdetuooV3Y0cU1WXdIr2PHdE9j9khMW+br6hFRbAlIE70ZAsQvQjMFilgiQbIpKwrhVSjNcY2/HPmxzbXUoa7tZY/oRKhFLTefAiGjzYLsuOZMw8QFbiWS/HTL5yxKmeaVwW/AWSKivpQX+iF/X2nZIb78m+PLsODQ7hjlU5InP6puK/MXYw6EwszQxjppqcCD494TamfqkHt+CRNHWMqARrd2RDD5suUq+3YE7PpMZyws8cU2CPfzGHpiedcl4Dr+2hSrBfPAsUcwFA7RUyqbs5lBvDYq9jxLQPsxTbmxzTQX/vz+sDD9XiZxGI/SugPCFPIMAIIMN/R3rriToT8ehlKTJRWTP5x+G3cHhZHSTqRaXGOq3ezVLiSHJoFXoVcW1wPqX4nLZ89V/8RAuSyexOfjTpML2FOX1gVPszYh9KwIQSp7BZXxh3poSa+Im1sBIh64f2y6y/qxh2TDV0Ih6uaxgoMA6vABqVBkxmQFgOXPr6WwRlv5H2/8P5mWToz9j/GEBMp45LrnnZeYDEid9T3N6p8znNSNMUQ3MqNSddN9C+lxC9py9yxeUVaXAf32qDCmVX7WysNymfbs1tjQkpFawAF11XbXFAA213fdwjyMDMYN6UyaspkCrCyUW4J8YeyggQ0m/COeG5ByBavjCkgbVtl9WYCYeU+dy2yaL3MEoFQeWBPYwv70KtyAiWbRmVBisAScRgMB0HtxMtquzHYYcTgYgenXBZQ1xtENA4UHzdqg7eBZNETOJO7RI+qq0akCgsIk3CQk5zUtlA8GB+x1W4fZZGvn+T4sJYpK3RveH/tuhw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2485.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(26005)(6506007)(6486002)(478600001)(107886003)(6512007)(186003)(966005)(66476007)(2616005)(66946007)(6666004)(41300700001)(8676002)(53546011)(110136005)(6636002)(316002)(54906003)(4326008)(83380400001)(86362001)(38100700002)(31696002)(66556008)(31686004)(36756003)(8936002)(5660300002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJDK0RwbGNMQ1NaMk9Xb3IzbjJSeEJqWmNHMjQ5bkd5NGZJVDJpdEhNa3Qz?=
 =?utf-8?B?eHdXa2FvbnF3M2xwZzJEZTdjWkxaOG5TUGZNcElVTjJnVWFESk0xZFRTOGx1?=
 =?utf-8?B?RW54clZSQ2dZMUdud1dMamVUSW9BSXVHZGFQSzlGblR6Wk9MRkR5a2JkSWsx?=
 =?utf-8?B?Y3ZIZXphR1ZQNlNNWkdhNURZa2RGTmJZZnFhYmZJUncrQUpDSlMrTXNNV0tr?=
 =?utf-8?B?TWdDSzdEd2MxR1A1eGJoaGFpY1R4aTVqWGVmMjhEQU05YTM1M0ZrdnVWUjhK?=
 =?utf-8?B?a25nOURHa0hLWXM1UDNZeWVIUU1vWHZVQ0NNSk8wMjkwL20wKzA0UElPRHVB?=
 =?utf-8?B?QTRmWWdBMlVNdFFVZXppU2E5Z2hEN0d0azc3ZEZJaXBTNEdqY2NkSXFlRlFn?=
 =?utf-8?B?STV5N0N6dGVpeTlyL293NE1mZjg1UUtKckFNWkdNZUlCOWFETXdleWZSNFc2?=
 =?utf-8?B?aE50NitqZGhWbHE5L0hNTTlDeXFIMmVwNmVMSXVzRFJha3Nvb3ljZ3FqdXFr?=
 =?utf-8?B?WmwyNnVkQzE5WkRXbjdZOUlKZUhOck1NaVhxTXJmVXA1OVo1aXVPayt0eERy?=
 =?utf-8?B?UmViOFliRU5RVk5HbzFYQ2RpQkpuSE92UFJLSDdFbm56OUNJS0hZUmJBNHRq?=
 =?utf-8?B?Q3pEQUlsYW1Hem44L2NJMU5tOStEQmN4RVp0TmJSV0VvdEJNSDFiVDNvNTVX?=
 =?utf-8?B?ek5RUWtNekRqenZ5RmJaUlZDYjBicW1SSS9uZ3JFQWxFN3h4VndrNTdmRUg0?=
 =?utf-8?B?SjRUWUtXdFlMdEtFWkpnSkVJajR6bFkvUWdOUnU3QlY4b1NPZVc2T015OVlm?=
 =?utf-8?B?eE44Tng0ZTMrMVVCNmp0NllINTd4Zjc3RkNsMFVEbXUrVVhYSXZNTFZPMFN2?=
 =?utf-8?B?R2FnTlJUQ0VUZ0ZLcWZvcmpETlhmTnRvNW5iZHAyUUlOVm9vaGZYM05FZXY2?=
 =?utf-8?B?ZXh3QkdGb3cyYytUdTgyaG1vZSt2SDhCN2FBVENLVmpXV3lxUzY3VXcrY2h4?=
 =?utf-8?B?Mm91S1hGSk9QN295Z2lBeE9tbWltUmpHNzJ6QmlJSUVPeVV3T0V2bDlJaXBu?=
 =?utf-8?B?SUI1ZU5zY2FVNDBOZjA0LytaUjByRDNGYkhiVzJpRXdTL0Q3aUd5S1I1aFVZ?=
 =?utf-8?B?bjJBZFMvWEF4T1RKS3BpWXp6WHV0Wjh3N1dsNWFseHlmSWJpUFZBdTcvV1Nx?=
 =?utf-8?B?OSsrRE5ydmFlZkY1b0ZtUlBKVlZ1ejZBeTRmR3FQRTVRSzdjemNjbk1ycXc2?=
 =?utf-8?B?Q2t5SjAzb010T3JYaDdlcUtOVU5xeTZZd3dzalJON3JsVHA2UmN1c2FqTzFX?=
 =?utf-8?B?VlNqL3piM3NCbE8zNXg3ZG1QcWZDeDU2R3UrWXQ5NFFMN2xzTlBsVFZJWVp1?=
 =?utf-8?B?LzE0MnVjblRWRkdyYks5UEV2V3hXTWVERmg1aWZnR2FOYW5DREJwcVZ0WGla?=
 =?utf-8?B?VTlMNVRWNElkQ0JjV0pvUk1ZeVVOaDRTdDJkbmRFWjZmMjFCRVhKbXdXVStV?=
 =?utf-8?B?clErRXJHNFIrK2haVnZNWjN1dFpIMnN2ZDdVamtCYXNQOEIwRjlYMFd2VGtJ?=
 =?utf-8?B?dTVmVEFmM1JmdjRrUjllNnN3OGxMaDZjT3NjSmFtckczRGhGNys0QTRBR3pZ?=
 =?utf-8?B?MDF6TWZIRjUyc0N1Mk8xWDFiSWdOQlh4cEJuY09VNHNEdWxrVTFVR2NGQisy?=
 =?utf-8?B?V3pXYis2VGRsaDc3UU1RTHpnTlN0NHQwRFFXSC8rZWVFK1pMWm5ZZTNaUUto?=
 =?utf-8?B?dmdjTEdhUlJEU1VzOGpob3IwaWZ5UGxMTzhWSXQ2aDRhMDRVejdhVVFNQnB3?=
 =?utf-8?B?MEJuQ2JXaHVMOVJFWW1SeVBuNW1GcmkxUE85cDRjMmw1SGlUdkF3RlgvWG13?=
 =?utf-8?B?WTZ4MlRqdUlKNUhkRkJQaG1hZExNY0NHVDdSNnlva0Y1aVdabGFuMUJGQ3N4?=
 =?utf-8?B?TlVRQ05HWEltNTdZUFVsNWlYYnhQMmUzTU8rclYyWDVxSlNBMHNiUVFkbDdK?=
 =?utf-8?B?TlAySERLN0wyWkpxWk1nVW9wL0xaWm84bEtUMkhNbkRhdmlhSnhVbERYMm0y?=
 =?utf-8?B?RUcwV1MwUnJEWjd1cTF4d09qZDRPM3dDU256WHhsWi9KT2IyVFJLVXA5WlFT?=
 =?utf-8?Q?UHPUpqdi6P4g5sPpqeuk6+VGw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9236923f-84c9-4a39-f338-08daf46d276a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2485.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:18:07.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iel8XT2nLZ/NKQuIYdo85PcEilE0Ep2huIVMhCHrWgERfxaxmuRu8gJmuFCCykS3tygtcEO3d4dFsk0qeBUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6970
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2023 7:10, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1fe4fd6f5cad346e598593af36caeadc4f5d4fa9
> commit: 6470d2e7e8ed8e9dd560d8dc3e09d1100a17ee26 net/mlx5e: xsk: Use KSM for unaligned XSK
> config: i386-randconfig-m021-20230102
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> 
> New smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/en/params.c:481 mlx5e_mpwrq_validate_xsk() error: we previously assumed 'xsk' could be null (see line 478)
> 
> Old smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/en/params.c:314 mlx5e_mpwqe_get_log_num_strides() warn: signedness bug returning '(-255)'
> 
> vim +/xsk +481 drivers/net/ethernet/mellanox/mlx5/core/en/params.c
> 
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  474  int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  475  			     struct mlx5e_xsk_param *xsk)
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  476  {
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  477  	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
> 6470d2e7e8ed8e Maxim Mikityanskiy 2022-09-29 @478  	bool unaligned = xsk ? xsk->unaligned : false;
>                                                                           ^^^
> Assumes xsk can be NULL
> 
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  479  	u16 max_mtu_pkts;
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  480
> 6470d2e7e8ed8e Maxim Mikityanskiy 2022-09-29 @481  	if (!mlx5e_check_fragmented_striding_rq_cap(mdev, page_shift, xsk->unaligned))
>                                                                                                                        ^^^^^
> Unchecked dereference
> 
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  482  		return -EOPNOTSUPP;
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  483
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  484  	if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk))
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  485  		return -EINVAL;
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  486
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  487  	/* Current RQ length is too big for the given frame size, the
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  488  	 * needed number of WQEs exceeds the maximum.
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  489  	 */
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  490  	max_mtu_pkts = min_t(u8, MLX5E_PARAMS_MAXIMUM_LOG_RQ_SIZE,
> 6470d2e7e8ed8e Maxim Mikityanskiy 2022-09-29  491  			     mlx5e_mpwrq_max_log_rq_pkts(mdev, page_shift, unaligned));
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  492  	if (params->log_rq_mtu_frames > max_mtu_pkts) {
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  493  		mlx5_core_err(mdev, "Current RQ length %d is too big for XSK with given frame size %u\n",
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  494  			      1 << params->log_rq_mtu_frames, xsk->chunk_size);
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  495  		return -EINVAL;
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  496  	}
> e5a3cc83d54019 Maxim Mikityanskiy 2022-09-29  497
> 44f4fd03b51705 Maxim Mikityanskiy 2022-09-27  498  	return 0;
> b3a131c2a1602e Tariq Toukan       2021-03-07  499  }
> 
Hi,

Thanks for your report.
My team is looking into it and we'll reply/fix soon.

Regards,
Tariq
