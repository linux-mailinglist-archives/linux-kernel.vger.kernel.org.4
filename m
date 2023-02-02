Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30F687E58
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjBBNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBBNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:13:23 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB066CCBC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV+BJAqf+NWIcCyMy/HwNYKoIUpOA5M10U8K+YWV79/QAfRnOzRuS12DCf/eX+VyE6EdCwKTHogeqR8XzYcMsFl5HP4/HSz3X2ztVdcQ9TVhg9sGAWI/7mmQg4wJSuNMI5jEOXJ02rtir/dqFDlCORiJRvUHSGnA8+BHdhGjn8jE/4rwl9IXB3pjjklEnbLQxu5nNRW5GOxTnvnZXplAIyf0O9g91qcW1DGNt6I6O3VfnvcPv2jaoKgwHZ3+2rbYB6MMRrF7+mWIDddoBBLIFKn+oXUY7RjKxuObYuBMzgbD0zgUchgNhP5t68GSMkBvREWlrl0oe2gRBWSSQZiLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DLb1taFcyyD/8FZH2kEiXlovFPlIPXgJ9FszW6bLwQo=;
 b=OgXgBSO+7vfsuLz2aLwiTMfXyNSuWrYB6NN76mSHmXbZMf5nq/Hvy0Miohlb5Rgv4v4saw8SxhjJtatuD0si/Uxuwn799wqbmXB+QB9NFn9bdR8MP4Tkab27T04Q4xbq6etOnsU7mcnKMkql/J7TCtnZljl/IHbj4nO9YPcGwMNnQbjopQgYFUQ2QnUiaZVuFOpJ0hn2r3zXdPaQY83a+aVXW9SXzkGal1DR1iQc9SFr3jb0ib/L9XnqeL+bvXmta3msh1ZPwGQ8uxvWLj8Gxi1wQu3lKqT0Je8YVxiI6a0zVyMnL5yWfnrrC+Tk7MzkImUe0KLer7ty2upnmf2DBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLb1taFcyyD/8FZH2kEiXlovFPlIPXgJ9FszW6bLwQo=;
 b=XvOKuGeIcKdWCtyLjkVtQotYx9rRK5+GnRVb9USv4feZbmX6CWeFXGInASGxYfCfbMVspCdFiEKXiJybD8F3LTUGn0CCq0xEaFe/1TSyFSpQwqIXk7hfEMx4swRfuuvjBQzoee/Wj65ReedONymPeCSDXOhwD8CSUeVOPAp+aYHJliiaeHkZdqP51HedP3lMAmsHFArpRBtQBBBFxT/Ob6EeSJYhZJbFqXysWB6KNNJ+TYeYVNjIYdZpsTHNIR6FgT1CDiQlYyXMNGumV3f8IWf3/KGHR2ElZKGyxcehy6jIDusqCmamBk0qWAxnkT8LLzv5sVYPlu//qciHLrZvYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.24; Thu, 2 Feb 2023 13:13:21 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%8]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 13:13:21 +0000
Message-ID: <77fee1c8-510f-d890-249a-ce9ac132e885@nvidia.com>
Date:   Thu, 2 Feb 2023 15:13:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/7] vdpa: fix improper error message when adding vdpa
 dev
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675207345-22328-2-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SJ0PR12MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: 96bb46ad-7698-4283-6b2e-08db051f414e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gc95fDAAhIks+VRitIc2SodWDnnfyyAoaEfdvrb3Ks8JlCF1LFx/X6JFby+DKqSeehQ/eSVh2jumoEMJiPA+v8d9ymowMf/TcLluXCKzR+PGTYkgGTmTpm5v+4+6bKR1uODUYgZ4kdYhQGWdgwrEdT6MdC6kd6ddMDK/oFDHEte1qJMBdQ0htJAxG783hWE9nPVPfMVmbqs+ERCh3XwfAuiAXoEKIt0diREP5KG/IjAJ9YeVXuhUxjrFGCFLDMYL7flZPUDSEGdf9pnr6ERIn4Jj0BaliJJoklm2ZyfuVfx9kx4MnRj0ePm0+zqEojslGHQPoBzNlL2DFviiu6FSzXiE5uHIVpNRyHkpc4dsxtiEK3ik1kvzYzj9eOnXHhkDGvhPOrVfItXxwgs7215a/OiSiDjcOhO6IN40zdrtx2sndHeTYZBFvu02OU1ICqDhMjlRLpWPu1OQTr3mY02vQ6hEpPTNvnOSePxDqe89T+mGX62+Cy5UvZm5jAFC/VmjFksISYkuNYcK+LEhK7fJ/9nSE6EKhfhfn0faRNbeJyajka9cAgCdN8eaFek8qNRWU9daT25eU1IuB1NNycU5CZeJMO5zuGih80MrPSC74PdrjtauIYBWcQJWg1KlnlMG4JK0I/8oT5ffBCjZCdEiYef/ErnUeUDGVeu1H7Hcuv0AMgrVFCljKICn1DSALWQsMbTW2shzKvWe9cGlIWzp2Ji+a3x18EeXRAfTK1Q6GZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(41300700001)(8936002)(8676002)(66946007)(31696002)(478600001)(66556008)(86362001)(6486002)(66476007)(4326008)(31686004)(316002)(36756003)(53546011)(6636002)(6506007)(6666004)(5660300002)(2906002)(6512007)(26005)(2616005)(38100700002)(186003)(83380400001)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUFmSE9yTHlkTUVJbU1ocDdZMzBnM2s1aTcrQWIzV1lTRmp0RWlFL1B1eHZo?=
 =?utf-8?B?MW5HSjNwd1ZzeTlMeWpLRXhwTDJKa01CSDJRcThVdmVwTk1EV01ia2pnT3Bi?=
 =?utf-8?B?NzdKL0M4b2NUZHVUemZTSmx2NXdwV0V2UmhjSVY0MFV0SEpqMlFhWW44bXps?=
 =?utf-8?B?TGU2cmdwYXNKaEdnWUxqYldkVjM2NUhQR1VWYit6SG9MTWhCUTN6dWk1amNw?=
 =?utf-8?B?NnVpektVY0JsNXVhWkppajdTTXVNQ1Y4N084aitxOE9pWnZUOGJUeEhOQXg2?=
 =?utf-8?B?RWZXc0JWaHdLNnBvRjhNYlVxbHVGdUFnL2VDeFFtZ1JMU2cxQkxleG15d01Y?=
 =?utf-8?B?dkpDLzJtYzFUUk9XYjVVc0RKMDY1LzNRWjZvaCtuZWI2YWVJVkYwVTFUSitK?=
 =?utf-8?B?OGtRbWdkNmVFVFpGZFlJTnBXdHJKR0hRbmhtbUFSeitwWC9rMkNQS24xQUc4?=
 =?utf-8?B?MzVHajNpWldyWnVOdGp5K0Urcit2YzIrQUtrRVJ0azlhL2tRTkpmUnFIR2FZ?=
 =?utf-8?B?RUltY3dWaVBpdFlNclg4dG90QXZwUHhaKytRZXRQNVFVczdiaU5CcHdNS0c1?=
 =?utf-8?B?UStyTndWdy9KOStXdWVWNW92aFlpZVdxbVNsRmk5NTZNdjJuY0xMbktXdEJx?=
 =?utf-8?B?SzhDMk1TWFZ3MmRlb1VRNEVVYkNLajR4SzEyWmxLN01idStlL2x4enF6KzF0?=
 =?utf-8?B?Q1c0N2NyRjZMMkQxcWhlUWhSWXRsSjZHRmNrT3dWaUR0R3Q0ZDRrMEVtYjFl?=
 =?utf-8?B?VnlQVkJXdXRWNjZlbjM3L052OHZnNitadWI2RDJDV2E1aFlXTmd3OFB3dm45?=
 =?utf-8?B?TkhISnhPWHRHb2tSNUxPVjliUUVSQVFmTjBndFo4SXVvc0N5cVllZG8rNnRX?=
 =?utf-8?B?cGRkZWdvd1hwZk5kZFdISUJZQnZzdkFEZFhJVWxxWnpoL1UzNFcvNnRiUE5R?=
 =?utf-8?B?ZHhwb1JWYjVoN05ZOWx6eHZVSEhmWDRIRkdhbHRRRXE0cGRsUk5BdHR6VktT?=
 =?utf-8?B?OVh0RUZaN0QrUlEvbkF0RkVCZERMTHFDektIN29EZE02QVFOT3FwSktIQTBp?=
 =?utf-8?B?UGRrWmMzbVNSUmVsZ0FjYjdEek44Q0E4ZnhwY2dwQzBrUWZkaXkvTmxaL3VD?=
 =?utf-8?B?WE56TVc5cDZoQVJjSDRBb2RXWWo2SE9Fb1NZQmgydTRyU1M5Uk1EZEx2dUcx?=
 =?utf-8?B?WVgyenc2dDJqTkZJeWZGN3dTd3BWOTBPTytaRlVraG04L2x0SHYvaEhlM1VM?=
 =?utf-8?B?UVIrUjExL0VQODlMMW9MUUNNeFlUMFYvcHNEb0dGRVpGazdkbEtsT3FCY2h1?=
 =?utf-8?B?V0c2WFhRYXdRWnFnOWdsa2d3WHIyR0J1TndtNU1mRjZPbHBXQStKSUJHVGY3?=
 =?utf-8?B?aFNUTFBBTGF1TW5FN1FNcEovMjVveW9KaGdmdjEwVjFWNE0rY2hZSHUwNkp4?=
 =?utf-8?B?c1hiREtjN0FleHJPbUxyMFZxVzhaejVxYnNXNHYyZ3poQ2xHd2NLMW9yM2JX?=
 =?utf-8?B?SEVKVldhSVNHcm5tZ3pZQzFiYWFmUFBkalhCNVpjR04rcE51UXNFaWNNMWor?=
 =?utf-8?B?YW9XSGJ4NEswTzk0L3ZjUlljQzdyWkZjVVJzTzQ1YXFkWjUwSlUrTEVlY1Fy?=
 =?utf-8?B?eW8xNTZFVnQ1ekY3YmVmYU05NUVKK1lhdk85ZDFkaFA2Ly90ZWhCSWphQVVY?=
 =?utf-8?B?R0pDVWl2c3hJcTY5b0FKTzkwTEZKS244RkNBQmRvMHdRQnh1NU9LQndReGc3?=
 =?utf-8?B?bVpWSS9DbVdQem1vUUlZM0QrU2lMampGSkxEQlpPK3JtcVBVTGswZnowQUk5?=
 =?utf-8?B?YzI5YXF1allnMGVYT0Z2Q3VJOElSWGE3UHFsRXpodmZTZC9kMDZ0QXdBaVNF?=
 =?utf-8?B?UXZETWRNbTdvaWZZTHhGcklUYnBmZHd0TVNJR3ZaRjk5cXVXc29WOEpOOVM5?=
 =?utf-8?B?cysxNmRUSzd3YUNSREtLYmRxU091c2tOanhsL2R3SU5JUlJKN0NGcXpvQi9P?=
 =?utf-8?B?VU1aRjh2NTBES3NLalNBUW02bU12cW0xYWVuUWlkTm1majIvdWlaWm0zclpH?=
 =?utf-8?B?VjJ3YUNydkh0Wit4YlpSbm80NHNhZFpnYzdwQmEwS3VwRndmVVJZMnNEWWlM?=
 =?utf-8?Q?Y8gzUrVE79BNddHUMGirvYhoB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96bb46ad-7698-4283-6b2e-08db051f414e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:13:21.3963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOxqgBQV6LzqHnwnob7IhZcfEKlXugg6EggeIRLypVNw5+NFfPHPkMHzyvKPPKtT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/02/2023 1:22, Si-Wei Liu wrote:
> In below example, before the fix, mtu attribute is supported
> by the parent mgmtdev, but the error message showing "All
> provided are not supported" is just misleading.
>
> $ vdpa mgmtdev show
> vdpasim_net:
>    supported_classes net
>    max_supported_vqs 3
>    dev_features MTU MAC CTRL_VQ CTRL_MAC_ADDR ANY_LAYOUT VERSION_1 ACCESS_PLATFORM
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: All provided attributes are not supported.
> kernel answers: Operation not supported
>
> After fix, the relevant error message will be like:
>
> $ vdpa dev add mgmtdev vdpasim_net name vdpasim0 mtu 5000 max_vqp 2
> Error: vdpa: Some provided attributes are not supported: 0x1000.
> kernel answers: Operation not supported
Reviewed-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/vdpa.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8ef7aa1..3a82ca78 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -622,9 +622,11 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>   		err = PTR_ERR(mdev);
>   		goto err;
>   	}
> +
>   	if ((config.mask & mdev->config_attr_mask) != config.mask) {
> -		NL_SET_ERR_MSG_MOD(info->extack,
> -				   "All provided attributes are not supported");
> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +				       "Some provided attributes are not supported: 0x%llx",
> +				       config.mask & ~mdev->config_attr_mask);
>   		err = -EOPNOTSUPP;
>   		goto err;
>   	}
