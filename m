Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7AA625D51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiKKOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiKKOji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:39:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA3654C5;
        Fri, 11 Nov 2022 06:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoKHMbp6giilkJYauEIvgP+YVSpk03B455n7QhHL94t8KoPM68HNXiEXmFN/HCFIc20F3WXq0OcwEGXudonZt0gzBSMr2SSOU0UaQlaC8NMQOyz4i0Kg3m+inJKO5WtaqN/7O6NE+Ls1f/RFfz1EmYhPm0k4G5/uH+iQW0hsb7Q3jZVwCxTzlFv9vr+qmxJkjEfa2mdOtjLVwQJ5x/CFZsUa6V1hE1QG659cy+Jnam1vQwQNhdt9qGPtBoqun7f5eWLduN+QWB7h0CoaFRvjmXV8Z6eGuTsMYZ5mxz7ZS41tZMM/2IeZ2EFkTxgHZjih3M8/wTCm66Nj0dR8KEF/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DB65WcI7E1Bc55DkWnvXO+hjlWgOfMCVGeMzX8e1bUU=;
 b=djD1clCvkOssbUF+a984+VxP1Z+q8mv8TRKygzuvg2GpVjw/nnL94Xe0kJk2I00TwaGyW6ndUfXDJ3SR05xLaFaQ5yduuEuA+rmlvrKlCzglMSVT1clFioW/ii+FAl9CbryE0fevPsBwragVlkG36o3U8CEcwH2k1v2aejV9o59sEOv3TLucP4G+8UQLyv3eR/bZ+KGMLyi5Flw5McJHHTLhgveOaXrl82gf9gZ5vathX0RpzFwUHr6jpDtGMMU5djs0AhQ10KHQUqeI1YKOvqQ5GkMjDgNsYYn6tWS1d61nd3nUP5QDhCbje6cVQ+TdHirHHDz3CvgzXvB2GarqcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DB65WcI7E1Bc55DkWnvXO+hjlWgOfMCVGeMzX8e1bUU=;
 b=eaZ+EKubb1tviS9bdVob/inhyweCuAP2Ct9vh0gzT7sT4AFBSdKQrzWOSJ4k5GE+RM8oIGbKXN25R8b0jbCeW/FsTvy3ZQzj/t4FTlhZ9HVOUNIxrO8w51xyPosJSsxMpI7+2cdm6J+1siiDfpVqUUce0D4s67KaZQILQ294SXwkstijrdK6V1tgidALHqiH9ujkHgsECbL1s6eA5Y795j7ebb/MrloV+UkL0rzepTXvGWkURoYxYDPUmVkpGQNA+fMRulgLwJbenmG0CwsvJT7E0XhCdqENu2Ud4L6kX5kwO60K5+U1pJ9ij1z5JFASnK8OKIOviP+qwJ6sCUtgHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 14:39:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%4]) with mapi id 15.20.5791.030; Fri, 11 Nov 2022
 14:39:26 +0000
Message-ID: <0cc025f5-0e1a-3666-9c39-3d09a37cea2d@nvidia.com>
Date:   Fri, 11 Nov 2022 14:39:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 1/3] xhci: Add hub_control to xhci_driver_overrides
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>, thierry.reding@gmail.com,
        gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20221111101813.32482-1-jilin@nvidia.com>
 <20221111101813.32482-2-jilin@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221111101813.32482-2-jilin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0086.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::26) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 5240df62-a48b-4e9f-4aaf-08dac3f287ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QA7CT07/Tf+9f5VohswYuXWqUNCI6wC2Y4JBDNYNSCrICM8fl8GpDdI+HGu3e/yb4tToMnjFlPVYLgycySp9fAaPQF3Ocq1to7NH8iUVnTMRlTlJSxwDoazGD9yjIYfzJnJwPAqL2LLdo2sb4QVPtvXPnichx4stZj8S6zKmKmQo3dBz+YvaOQHiwHnpHzZomYNlYlGYNWwu0kt5txtzEJH/M6Gx+mcWrAuNnKlh0W1WTiSZxE8Alip2vi4pZ4K5fr8FTYiKlwOqawmyHokExGF1f187WGcN7r3hwCX45GGuPKGmEs6+PmYSMOrG8LKIqQsDo/C1Dqce/S5emSA0PLK/gZqXXPgrD/BA0J1QPNMI/enz5U9MJh9mV0TOlL1xhU25GnJfpPGHI6VFhcdLgGc6fP3Mm4yGDfM/2v7O3RnFTJZjuMQA9ZaVWjkN0btMvDFmuHBe2ydXvmfclVn+s3ijSA1KPFXN/DCAU8ybAnfp1f1JHkgqxInj1CK52EofaS63sxXM+oHByCEdGhr0y4tWoKjwMnQxu/u/CXiPg/bXcg0SHbqOkIms2SlkgzLk1zDkHBFhQxlZgCf7WOLFHCkIzkL5RtDunv2Aw6mq65xWsm4H3BYH3SxRYKkb06oJjgk77x69TEBPr1LO71OVv9W1o+4zwhhQp81YifSzWrSLvsmlrGJvGR3ixU1MI4i01BBBYzFIz0DNXmIStdFOint/tywrQmRdLFn0ehNn9FbVsJ8cP6JJR/7AW+DjpilDvZs0SqDsC838fDlj1m1OmOqjY4Pr3InhnsFsjhiulnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(31686004)(41300700001)(38100700002)(5660300002)(36756003)(8676002)(478600001)(66476007)(2906002)(8936002)(66946007)(6486002)(316002)(4326008)(86362001)(66556008)(83380400001)(186003)(53546011)(2616005)(31696002)(6506007)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3AyWkk2T29WUWdQQk1WM0cyR1JDU090WEhpWTlScW1qSTV6Y0JJaFpNVnFz?=
 =?utf-8?B?ckFTUWpOd3dVOG1HWVBQY3JzOEZhMUhYQVV0Wms0RmMzQ3RSMXMvUExWNXpm?=
 =?utf-8?B?Sy9RRXFtVXRleDRMY2VtZnI3RS9HRHBpcElsOEpPTWluMHgra3FXOUtUYlp1?=
 =?utf-8?B?THdvUHBMSzVpL3pqS0JWY1YyRXhqRUtFVlNrakFNWFJ2MHZIT0d2b3k3b0tw?=
 =?utf-8?B?dWFiclovU1hSSVBudDRjU3hTTkNTSkc0aTdPbitxYzI1b05YMndCUThEUDFq?=
 =?utf-8?B?c1lNR2dmVmNRTktzTHZQakdoTlZjUUd3WVBxNlhTTWpIM0REcGtFK0ZLV2x0?=
 =?utf-8?B?aTU1T2tOVWdGNC9Ta3R5UisyWXMwSExlY2JEWjFPa0RtMEhjOWNLRUZmeG9I?=
 =?utf-8?B?VXVEQWRSdThQNzFxc216Mm8zcytsaDN4WmM1QXB2akFGVTdOdzF6bW14SWhZ?=
 =?utf-8?B?NnJ5L2FVclhmaG02b1RuUEx0Z0NuRTBHMG1QeHI2bGhsUUFlZGRUdU1ENWNC?=
 =?utf-8?B?WlNpSTE2SkFzSkhCc3g0cS94OXVjZS9nbE9MV3pPMmkwNElKRHJyTkN0VEVY?=
 =?utf-8?B?UmhGdFRGNExMN0h3R3MrZUdJZ3o1Skt2enNqNFBKS0U2MklMT3V2YS9xeDlz?=
 =?utf-8?B?STVXN1M2NWRjR1F4Sy9UTkRWWWJNcENWRDRud1ltRUhhMzUzQUljV1BuTUZK?=
 =?utf-8?B?d2VEd0pRd0tpSktBU0FPckhkVGhkN0lLajBVdlMzZ3I0Zmhud2d4TjY0WXVn?=
 =?utf-8?B?VTRCbFA0NGdwNHI0UVlaNHhGUWNBN3BDWDBVdnZ6bzB5aWgwdDdjcjI2ME42?=
 =?utf-8?B?dmw2RUhyU0NtcGR3djZGckpIcDlKZ0hhRUVRa2ZkZVJvMFB5U0cxMjc5alc1?=
 =?utf-8?B?TjRhc1ZjOTBiQmVOWVZNeGttOWMwTkxaQUFROXMrVFprZG8xZnZIMExOekpi?=
 =?utf-8?B?bzNYOCtlQkVBMHdGQy8vN04wZmtBYVBTalErTnYyUlMrSWVTWExKMmZPY3JP?=
 =?utf-8?B?Z0Zsd3ZaYjlQNFd1V0RQZTlQbHhueFVCaDROYXJmeXJ5UlI1NW5jMTlJcWgx?=
 =?utf-8?B?TE5aMGw5NkE1eHhPMFJMaEJ6YytKTlZ1S3J5emE2SC9yYXYvMHNIL3A5aWpC?=
 =?utf-8?B?SWtLeHRadStSa25RdjllNlFscDZaWmlDdkZMNTdqMld2S3d4YjFjT2VLVnJp?=
 =?utf-8?B?cTh5Uzlmc0RDdTVkeUhpeHJ3alVhMnM1b1N6ZTRMM3pmdjRFQlhsZC9uSE9r?=
 =?utf-8?B?TGVJM0JKYytSN3VRYVVmMW85WVk4c2pjYWtpUlNaUXptNnU4b0YzMTBSUjhy?=
 =?utf-8?B?RXR4QkcyMzU3Mmp6cnZZYU5EWTlkVEtRUXpxMjUyVi9pd2taQWk0WFlQY3Zl?=
 =?utf-8?B?TlJMLzBNSVB2NmFCUHlLeUxDRTVIdFJWV1N2M0dkUytBWkQvd3N6YTFpbnNY?=
 =?utf-8?B?YXZoUGtkakQ1MExjclVDZDJReStWSG04MnQ5bkU3MDY2VkpPeG8rMWxHUWxF?=
 =?utf-8?B?bE5WdE1FR2VqZnNiZmdTRm8wanNXTlYyRkxma0FJbWNtbzhNa2RjVmR0OW9D?=
 =?utf-8?B?Y25wbkFINGpoU2JRWXVoemNJSkxKU1ZHQitjdlQxOFNib3NoSE94MWQxQ21Q?=
 =?utf-8?B?UEJvd2pkWWUxa2xCNENUTWwyRHBkQzV1UUp1cXE2MGhOd1dLbWc5TEJzZDNj?=
 =?utf-8?B?OENOVUZNRXpkbk4wVkI3OG5VUWxwN1MxZzRGaEdqNG9DV3F5U0owUm5JUG56?=
 =?utf-8?B?bi9XSTQ3Smo0YWwyWklxa3V4VkFqbXlzVUVhbGczdzdoZUJuYVpXWEFPQWV3?=
 =?utf-8?B?NUZOYnp6SzAxWmxWS2dNa0VPakNNSzdqNk9CRWIwKzNrN0UwYTB1V0FhOC9Z?=
 =?utf-8?B?SU9qOU1tQkg1bWgxVWo3c0xYZ2pMWWRwa0lsK1FvdlN0czVaODY1QXNEeWdN?=
 =?utf-8?B?YXlnelZWTGFxSjlqazV6S1NsMUM0cFAyeGFaWExhMDBmYjQ4dForcWo3Ujlv?=
 =?utf-8?B?NDNDQlI4Q3EybG84U3prQzFBS0VZcVVQdVhmdEVKNDZPRU1xODNXMFk1aEtP?=
 =?utf-8?B?ZTZkbk5OaVNoaHdkMDcwOFVwVjEzK2NKcmFsSElNNnB3SmJYUndzSHR5K1VV?=
 =?utf-8?B?anc3R2N6b1pmK3huNkpZamFzZ1RSaWVKMUp5eFdUUU1WZG9jaCtiekFpM0ll?=
 =?utf-8?B?NzZGdDh0Sm9CZjlyYkxwenlTY3RJUTVHbTgvVzczMmQrdmlXYXZwUXlSL3E2?=
 =?utf-8?B?MWhTeFBmekt1aXdpTHFCbTdDNE9nPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5240df62-a48b-4e9f-4aaf-08dac3f287ec
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 14:39:25.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBwVnmR0YiqfIXLpHRpLbAXdkGNOBK2sN7hp+5zUK26+wEbkRgPziu2ILQqPRzIr/T/2Q1va3gglTmxGs1rokQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/11/2022 10:18, Jim Lin wrote:
> Add a hub_control() callback to the xhci_driver_overrides structure to
> allow host drivers to override the default hub_control function. This
> is required for Tegra which requires device specific actions for power
> management to be executed during USB state transitions.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> 
> ---
> v5: new change
> v6: adjust parameter alignment (xhci.h hub_control)
> v7: change commit message
> 
>   drivers/usb/host/xhci.c | 2 ++
>   drivers/usb/host/xhci.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 902f410874e8..3c7bf0a0e0b4 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -5461,6 +5461,8 @@ void xhci_init_driver(struct hc_driver *drv,
>   			drv->check_bandwidth = over->check_bandwidth;
>   		if (over->reset_bandwidth)
>   			drv->reset_bandwidth = over->reset_bandwidth;
> +		if (over->hub_control)
> +			drv->hub_control = over->hub_control;
>   	}
>   }
>   EXPORT_SYMBOL_GPL(xhci_init_driver);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 5a75fe563123..f51b674fc10c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1943,6 +1943,8 @@ struct xhci_driver_overrides {
>   			     struct usb_host_endpoint *ep);
>   	int (*check_bandwidth)(struct usb_hcd *, struct usb_device *);
>   	void (*reset_bandwidth)(struct usb_hcd *, struct usb_device *);
> +	int (*hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
> +			   u16 wIndex, char *buf, u16 wLength);
>   };
>   
>   #define	XHCI_CFC_DELAY		10

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic
