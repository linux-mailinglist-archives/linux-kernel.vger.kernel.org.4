Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81754630919
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKSCIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKSCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:08:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430010B7A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:08:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kroEdcMzkprzL74VA3ydvr/umbDD3Os0E6xW2aio50QARUxF1PzmZMMofD1pHjlMqG/BnfvZf81c0Xa25r+4svluGNhOnHvkfiJQr+gFUuu0GSNt7i55U+UTG+syrqClEeXUH/Jlbd430gT92Mpnu+yZLqODSdCWGpkwvg87LOXvmaB/FkST0TZIrJf9pxpkBiWSlUd6YjqbOa9Nwb6kyT+BBI6qGfGRANqMXLM3opk94GCmGup+8YjcmvMax+EKKTwOz99/sModEaasHZcAghwFg1e+kOPBpB76/o8kjihsQnL1ENqcgE9DXk7bCBZbue7DIE/ibudqPrQ4Zu5ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8xVwP12cu3pDjJaDFXJWoxKWob9OFtwkcJ8UWSeCCY=;
 b=HNgBeIXKbyZiQ8wYvOAS1+y1wnUrUFFN5agfBkavC6JDpm2E21psX58hkRqi6pYiF5ZiUw0q+EBUBmAjThi92kW8xa8SV9ZCAOD+qlGKRkWptXBllf9uir/8Unf/h5P2dRYZrw55v4aYL5DYSfPynhndzxicJUAqxIlBClRIKQmCYlpCOJhvAvDodxWYX0XiYoridBIKE0syuDyZo4oEOoxCPzeTGWnkugbmTcHjbfUDW39gxCSEE7v4F6OeHnPYZgCS97/+fZaVtgJ5qWXle+BCsR4pBBOjQYMGCe+fnO9F4SeMFgWLBa4fvBfo0e0YT8bJFetXnKD46SlDIBhIIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8xVwP12cu3pDjJaDFXJWoxKWob9OFtwkcJ8UWSeCCY=;
 b=CfyzK74N0vC7AbBenFxyYn1tE46TI7F3ab69FeaYO7Cs9lOsehFlGym4pVVdAkj630EGDr3K4ucD0hBh9WKo8wa27gyVcn6Sm43WFuEC3oLFbAz+osF29qfgGpBT6Ds0FkBi7Bqk9gUFOaQPgImRYam2W7RHNB52b1AtEwkOAj4VEbRuA6QvTQXR2GUykAOe9/xm00QPpEYq/cQfyNZfLLzi5hQZOGE3WZkn5m+bcwzuLtw6nHqlvbfQvqplOdvvVaEQehfuEktIAyc2WYL1r0GngykBFiR499pb/t29uwpgMIV2D2BgdM8EadqlsTl1x/uo+dsNaaRC3rr9maLIvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Sat, 19 Nov
 2022 02:08:28 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::2349:ec6b:2442:8c52%3]) with mapi id 15.20.5813.018; Sat, 19 Nov 2022
 02:08:27 +0000
Message-ID: <b36368d7-8b6f-7426-9f9c-1507b22bbfe8@nvidia.com>
Date:   Fri, 18 Nov 2022 18:08:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH linux-next] hte: Use device_match_of_node()
To:     ye.xingchen@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, timestamp@lists.linux.dev
References: <202211171517291515920@zte.com.cn>
Content-Language: en-US
From:   Dipen Patel <dipenp@nvidia.com>
X-Nvconfidentiality: public
In-Reply-To: <202211171517291515920@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::8) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: bdbc12a7-93b7-44ae-6343-08dac9d2f2a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoxmAdVy0quzQmYDXYzaXmfSDPS2WjqlcOg78BWpV1pWp1nZSjLj+H2yBkly65BPlSHIeYInS65CR1Ft3pLVELZgjoG3+MxDXRMZI5ygUtITsV2P9/1o9VzDaNNNe2gfSO4eHh+WKABqA//0tYvQqsfvMKFTd0skB2XP5PCiy4Le+LZS3FPqseS4L0/PhBplc+DW30uhlJti4EkEKmd5jms7iP2VwgyFpYR+aW5tzHFzY0qO8Yihui/gnKB8/lFO6oPzWKMTeg1K4Cgxh0RXXs2XfPVlVoQP67AnEp9uDJE/EBOIWRbsPnVtvwuxZ6K5MM9YHh7GWN62fFXMoA67WbmbF+5IIL1wOMYiNkEYHLqymaGUF28nkc413sSUyUGizDPHqPUTHlZ1rmF/5EecdWDWUys0rDriXrakZBd9/1Ij8FsmZAtcPcA95GGpxb8j9AZbVmg+XgAguJ8f8g0Hk1fggm+04J7me3IGY7O1blzyRXaFdMbPUWQ/LLhkDjrouvozlrgcH3BqXIzwzTxPhcFsG+BR6FTHQAHkIPnCtoIG6ifHuQmImiVshLJ5WKAzhbWSOAsN4kW6u0AGKyDrss6Nq6sYhsmwxHVzm/yiF6PbeG4o/BbsebW07Pkik5Kl9kXWiKTZTw/AaD1eH8DUKHDmRZoYm7koeYU1JlgXpfCSIcLmlW3ReUlNwaXdvrRrr8ycK+MawRrLCnYONgSfkJjAbRFkJiVDrEnIB5XAZy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(6506007)(478600001)(316002)(6512007)(66946007)(53546011)(6916009)(31686004)(26005)(66476007)(8676002)(66556008)(6486002)(186003)(4326008)(41300700001)(8936002)(2616005)(5660300002)(4744005)(2906002)(83380400001)(38100700002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NlbWZyeUJOMll2R1hxQlkyRUpNU3o3TEVLbkU1SkJNUUtOVHBtUWNsNjla?=
 =?utf-8?B?dWJYdVJBSDBsdUtPVG54cHFGRnlpZFNiYUVmaU5SQ25xWDZLY0svMzFZZWhK?=
 =?utf-8?B?d2JGbC9TbExxV0xKTmZhTDEzbFB6S09wZ1hEZHRqYTNzSCtVVXZHL3FoWk52?=
 =?utf-8?B?dmVFNFNqOFhzRGg5TmR1dDVINWVncDJiTS92SWpjNnYzTDFrOWoxQVAyb3kv?=
 =?utf-8?B?UW1keExnd3R5dC9nUCsyK1p6UEVlUXpnY3pPdDlTZTJKZ2xXVzhrb0c5c0pQ?=
 =?utf-8?B?SFZza1VHNjVMVU9TNStoNXpMV3pPdmIxUmxjRFVhTURNbkczbGFsOUxsajF2?=
 =?utf-8?B?THBQOHVBOGoxWFFzWEhtR2ZrVHFGVGZ3eGc3U2hQUVJMempQK1JaSEt5cXNu?=
 =?utf-8?B?dm8yM1VMTWp5K0dod1laQnpvQzB5Sjg1MlFWUHVadHdZQ0h5NjhjUGtJVkd2?=
 =?utf-8?B?a2JIWEhtc0h2YUh3KzRjQ1BPS2JHWDh4YkloN2J5MGVyMi9uVGdFUmVIN05I?=
 =?utf-8?B?dWZWMVhha2FhNThQK0o1TjN3dFIydTk3QVVtbEJZcDJUWnhrWmVIazRodXhj?=
 =?utf-8?B?dHZSV21UQ3ZzYThlQXVwZjFVSUxXSy9rWkNNYWlYQWFEYTUxNDR0MWZTdEpZ?=
 =?utf-8?B?UVRLSHRMcXExSGhYZFJaMDZ5WHlGbEl4UGhxcCs5ZDgrWmNITG00alNhUWda?=
 =?utf-8?B?ZGpJUjl5dkVxKzhTOEhsSTN5Smp5Q0dON2xuWUFYelcyd1JPTjhldWtEb3JY?=
 =?utf-8?B?RXl1STJHdFVMRHI1S1pKdUVMc3pKaUMxeUxpd1FKVVluWDNsTHB1RzdmSThI?=
 =?utf-8?B?Ymx3REVOTnN0Z3cxYi9LV3lyUUNYVW11clRMZVFhckR5SFRKeFVDRG94TVpt?=
 =?utf-8?B?RnRyclZRdWYvMEZyUkRwV0ZxRXJKRFNBcE4zR09PUCtYcVdCVFlRVzYweHc4?=
 =?utf-8?B?RVVac2tJQmFMVGVuZGZQSFdCSU5aSlEzWVczZUVpbzA5bHBhU09kVm9PdXpH?=
 =?utf-8?B?aTNxM0Y0dXVENUlETzJSU2FtWlFOUEtzOGx2VnIvb1h5SDh0blBieGpZTFpF?=
 =?utf-8?B?cThSTk9rTUp0b0RRVjl2bzdLdXBSTXZZT20xNVFtbW94bWtXTU5pWjBZS2NZ?=
 =?utf-8?B?TGZUb0hkT0VRUzluVVBsWVNlUjY0UmtwTks3ZTQ4YXNlb0sxR2U1QXJZMyt5?=
 =?utf-8?B?MlFJV2ZlRmY4ZXFRT250T0h5eUZRcC90a1V6MDJCcmZ0ZUdPR0VEZTZTVXJG?=
 =?utf-8?B?SFRxZ0UxRVFFMW5xV2F1ZHVGa2o0dEQxTWw1Y0IxTm9ZOEptZENYUWxCN0pV?=
 =?utf-8?B?ZlJFSG5Gc3dwZGNpdlR0T1VFbC9zc3FDVjg3NU1GNmE3TGVyRTMwZmJsZ1pz?=
 =?utf-8?B?Y3JuRytlS2NUYStqN2NjT3kwbnhTOUlKYTNoVzJGdlpkV0lGbDhBRTlKRDFR?=
 =?utf-8?B?c2ZSTWRsenhsWFdVUjhtQzBGcmFNSTlkL3ZxNnFqOVlkUE1rSkNlY05mRmFP?=
 =?utf-8?B?UGxsS2xGRVFPYnZDb1Rwd0d3aXBXaDJTbit2VlhzYzZZZExFV0ppSDd1OU1L?=
 =?utf-8?B?SUozdVZaRmhkVlJxd3lySGlkS1BwVHVWMFRDS3RNUzUreHpwK3pqUHZqWks2?=
 =?utf-8?B?ZVVHaDZnTnpmZFZ6c3pxaHhXUnlFZ2JjRGVpTXFqLzFpUWwxajZkbEFXTHBo?=
 =?utf-8?B?VWszQ1cvbzJ1dm9pZlVQbWhHU3JvKzdQU25VVVIxT2VmMWcydm5TbGZuN1RH?=
 =?utf-8?B?Y2dxLytJSnIvanFPc1l1ZU41VEJORWV3SHhuekc2QmcxQ2w4SlE5TGZYUWUr?=
 =?utf-8?B?Z0dzNU9zOUlMRUpkcC9yUUwxZi9PMHpTWHhHU0R5Sm9pdWNFeHplS0dGajZW?=
 =?utf-8?B?L0NiZTAyMWg3RFJDZ2dlZURaVHM0WFFCeU9INjV2a2h4Q3JQWlZXdjBSbmZT?=
 =?utf-8?B?N0FuQk4ycnJjNDczM2JqWDVMZHRaSnZzRGVUR1Y1WU1oRHUzMDEyOWlWWUVR?=
 =?utf-8?B?bkdSVnlDa1JTUXRNckx2UFR6bTllUkVFNlRNU2pXVXF1S3ZxRW45eEZkaExB?=
 =?utf-8?B?U2pqYnNpTWZ1dTVaam9obXFPZmtieHVpb3J0L0RCSjA1V1g1OGxESEdVdHJ1?=
 =?utf-8?Q?DCsGQpb+A/MiY9/bRwzo0CJRR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbc12a7-93b7-44ae-6343-08dac9d2f2a6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2022 02:08:27.9214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dv1PWInhkOVZc2Hyjv07yZee7OPSGktbWuCnrE+RMLzvPzJTiyOqYl925bDdsEoddNS720TJesrE7xYOKy7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 11:17 PM, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with device_match_of_node().
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/hte/hte.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hte/hte.c b/drivers/hte/hte.c
> index 7c3b4476f890..5ae81fb31683 100644
> --- a/drivers/hte/hte.c
> +++ b/drivers/hte/hte.c
> @@ -444,7 +444,7 @@ static struct hte_device *of_node_to_htedevice(struct device_node *np)
> 
>  	list_for_each_entry(gdev, &hte_devices, list)
>  		if (gdev->chip && gdev->chip->dev &&
> -		    gdev->chip->dev->of_node == np) {
> +		    device_match_of_node(gdev->chip->dev, np)) {
>  			spin_unlock(&hte_lock);
>  			return gdev;
>  		}

Will pull changes to hte tree...thanks

Acked-by: Dipen Patel <dipenp@nvidia.com>
