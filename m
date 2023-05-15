Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968EE7028A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbjEOJdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbjEOJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:33:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EFE73
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de2EzCg7CcnJUdCak2lnCTC4n7ruMsQyP3G7FyxHQ/fevatZ54rsren2CIPEauO5XW1f9vlWmHsSk3SHUaCbiZMAx4Ui+l40rYBTMEOdoiDdwXBrdl7+3awNsB9W4HD4gI8CBaUsw/vqftpDCrCDTMfqP+YJ6bbEnyFYoeip0LjDBwHOp2gYIeX8SeojsSI0m27VuYnH9Rk3635Wr6RYaHZpBoYOxBhSqaMOyWVqW4wPtzdGgoaymEMyL6tL2Dxj+Kf1fD7UsfWELGh9nuqc5dXzh4wlSZWup9dWRhx4c3+HZ8OCdxtwrUZBW8TrDDQDWggC02ajMk79aQJ28pMBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muurQAPjyjXqGPWHdH6sVBI8CvZ+bqQc2ms1jNfUkuk=;
 b=N6uRkLtesk0sbtsG/waXwiyFcGJ3CAQN0LKWl45L/XdTTWjFA2QrB/ZilWIcdIade5JAyOY9Xl0wmIAjDehHgx5iAg5hNf27pw0wxLt/2dhixkd09NHL41086b8HgFRV6W7+o1osc/zN0JhQwpSDU5xuhxfn7rsAWv1+E/+TGD+PhVYH/8/3uIXRK4kcbq5ZXMq/OcbX1aVlqf7rRBCknsQY4Hdk/PODws1iavwvySbGTqAftAVmOQKNTgQvIhxcDxoJOtQiD1IJqbfI+yx0x1Lp3uiDWapbPS0gn8vd60qtucMvK/Kjnc5iKYzLvTtCOEvNL8Sbr/+/ApLL1WgkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muurQAPjyjXqGPWHdH6sVBI8CvZ+bqQc2ms1jNfUkuk=;
 b=IpzN2fG4kZCps4sWMAAHFWvMTY8+4KZxBwXdnBK4Hvcgu8dqxTaUX+fmGrF6Amdc/onabIyN2GuXLIGOyCRlmry0bJVxM+1bgslJMVrVaT0kTv60Zn11moz6Vd4Z4cC7MLs03vygAHTyku0IeJ+1+q0rpUPQlp515DUN92WIneY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 09:33:35 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6387.022; Mon, 15 May 2023
 09:33:35 +0000
Message-ID: <da73ff53-a1ec-ff6e-a811-6da71f8cc756@amd.com>
Date:   Mon, 15 May 2023 11:33:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] misc/xilinx_sdfec: remove redundant _{open, release}
 function
Content-Language: en-US
To:     =?UTF-8?Q?Bo_Svang=c3=a5rd?= <bo.svangard@sylog.se>,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230422195933.523874-1-bo.svangard@sylog.se>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230422195933.523874-1-bo.svangard@sylog.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::33) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: f76e5a80-f0e2-4111-6dc3-08db55277401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGI8dvbFSnhs7YD369/5wBx/8X9u6a525nzDIs23PP1zLi1OA/SH9zoFlZ8BxQOydJp4iFIF+LXUyUhVNmrq2DhI0b/CW/hnbcTQ/rxUImOCbDEHfJWaDOCa9I6thOQV1Wnebfu7sBijmawTfn2AYn7757uV6QJJjj3gSEy5YdLt+PSPRyWs0E27XMj3hS+qfKtMnLMF9VrzD7IwG3OAQgNHZ1ZSlqDrOesJcnqywEmuBUU9UMOadmAUTQjnEhiJ9hqOAa/ibGsWgC8I1gdIMvwyvTtOQhRXGo2a84JCEcuEYrhmG+Jyt58OxGaYEyBBAx68IDgcN3qtu2ChkYbIhxkFGErICKjEUT9PANyQt8Vai5if2j1Ztjlgh3+9kif1km740fsvEfy4Ph4a/+eCzD4Ejl/wOB6Dd2laMg3+i1Zz37NdIJf5wVh4x+dxNtWYhsF1EWEmK8P2ZyGGrSmcoIlcQJWczEdCWXkb2UW2lmtBO/xAB/m3TqPbfItqqn0xqVe8e/a6gV/Hh2ShpY6TYjl0AlSMH/hpC87HmCx0H2VjkwtcDB1kt47R0L1u8aEL1jcp0otxLQpWUHsm5FPpuMfzLNtyhR2jOUsVo/1WBbn4IbfTIUZIhJjtxLmvMyLqf12OKQ6F/Bf3xGXa6GT0kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199021)(36756003)(316002)(66476007)(66556008)(66946007)(66574015)(31686004)(186003)(26005)(8676002)(8936002)(31696002)(44832011)(6512007)(86362001)(6506007)(5660300002)(2616005)(41300700001)(6486002)(6666004)(2906002)(83380400001)(53546011)(38100700002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxZYjNxeFQwcnI3ZTdndEUrSmZtMy9SUWxGOUVFZGVwLzB4TnNnY21OWTZr?=
 =?utf-8?B?SWRpTU9qVlE2VS8wV1NzT1hGWEZSRG1ETndidzlPME5Bam1iU0tQNmorckt0?=
 =?utf-8?B?OUxLa0E3Wi95aHdDdk9aZ3JZQURmeUFPV1lxR0JzRi9JWWI1V2xhbWNhQzNx?=
 =?utf-8?B?bU9NbW5QcURZZDZEazJ4bzNFRkhwckRVb3MyTTlkYVl2N2xRYnFzZlRoczVJ?=
 =?utf-8?B?MHdIMkpsdjdhWU9aNTh1WUt4RDdTelNNQWVMWXE5bFBzVXpDTXcyeW9VSWcx?=
 =?utf-8?B?VGoydTJkWGMvM2x3QVZxWjFUWTJqYjcrN0FHYXIzUjJobCtNdm1hRUVscE9o?=
 =?utf-8?B?N0QxbnNaSTdFTmxZcG54SEF3MSs5VjNxS0FNWVFpYWVrNUV5MHNQRW5qL1Ni?=
 =?utf-8?B?MHdyQ0dWa1Y3QVpOZEFZN0xLL2pNVktPeU9qSW5XMU44YTV6MUxGL3dkNzB3?=
 =?utf-8?B?KzZ4UzRKbW9IQmo5VmtoVDBsL25TUHBkalRDL0VZd09ES0hZNGlIVEdJaEw1?=
 =?utf-8?B?QVpjYzR1aXVuc1FZTU9BOWswQ0tISnJUYWhRMC9HVERnRmJWSS94WEFPWmJP?=
 =?utf-8?B?dWVkVVgvS2V6N1dMNW1wSTVpcHp2TWtpRUNiL28wOWFFSjJVc3kvbzdYSFZF?=
 =?utf-8?B?c1MrTjlSYjZTTm5WMG1pVWRqeU1MN2Z3WDJjbVBxaC9HYUZoQitlWWpnbkhn?=
 =?utf-8?B?eEpadEZsTGl6emdrRnJQVWRlM1cwY1RydHVEelV1UEd2SlNPNjltY0pTSVp3?=
 =?utf-8?B?ejFpMzEzNTY5dUxIWE4xc1ZiNlBmS3ZyV1NUY3dpOFEwQUFzMHNPV0tsdDB6?=
 =?utf-8?B?d1lZSnR6NldRRmhZUy9TL0N6aVBzblNtcmdwVnRZR1ZxUGNHRkNJL2syUmhW?=
 =?utf-8?B?blVXNnhLQzcrL3VsOWthMmRrb1VzSHNvUjhqdk9sc3RUUndpY05QanVWYWJQ?=
 =?utf-8?B?YXdvT0Q5YnQvNkpiNGV6c2kxRWhUSVB1YUNLODVTWm1kYVd2Nzk5ZGxEZzVs?=
 =?utf-8?B?NVhDYzZvd00yS3c3aW9jZ09odCtKdzd0VEJMQXRoMHFWL0d1enB0eStVRjRF?=
 =?utf-8?B?QTIzTFk2MUNBTklKcm5YeXhzN1RtWlVUend1d2FJUGRsR05SeXNuWlhCYk9a?=
 =?utf-8?B?S1c4aFUxWkJwVkltOHY4Mk53R1pGMEp0UFBMTUZ6YVlIaXlQcE1TUkVwc2I2?=
 =?utf-8?B?a1YxbTZTVi8ydFhaV2xET2ZzS0VOYVJrcGhxU1V1b3dxd2JZMXRkRW9HOGVJ?=
 =?utf-8?B?K2src2s1N1dRcHpVTjZ0WmNKeWE2eS9RelBoOURsRmN2bzJ1aWgwelU2WjJG?=
 =?utf-8?B?cndRalhGU21KSW56ZnYwWlZYbWkxUzBQMU5weWdKZ3JyNjVKdnlNK3AwY09K?=
 =?utf-8?B?dGxHMEFYOTRYVlZHbTFLL1ptQVFuMHgxYzlFbjBrcW0ybE5qYm5oT2VwbzVS?=
 =?utf-8?B?VjgxdmdoTjlMSGg2YURxeXd2NEdTM0lYbVdMRXFhRXB0aG5ERkY3WWlvS1Zi?=
 =?utf-8?B?dnZLV2p1VW1ZeHpLWmtHNXNvUXF4NEd1Y1Z3UitEdkhGQnFqMWJOSElVK2Nz?=
 =?utf-8?B?eXBnczE0UUZUY0tlSUljMGZEdEdWaXMvWVN1c0YwQUZFYkJDendXVmRNMUpz?=
 =?utf-8?B?S0djS2hOYnJUZC9zVU1kbkpzQzJDTEdnQng1czM1VThJemlBc0RpMjFqejZ6?=
 =?utf-8?B?TzVsdXgwb0h6Sm9KUksrbHBEUDFaOXRMYTFFbDZ6ZGdRTkRYZFUwQ0xSUUZa?=
 =?utf-8?B?WnV5TDI2VVAwekd5N25zVWh5SjdyNVliZWlNMTZxSlpBcjBmVFdnaFNnUmNx?=
 =?utf-8?B?b01JNTY5UzhUVGQwNVA3WmFPZkV3UzZWOFVtVHAvWnlsaGllN05xUDN6dGV3?=
 =?utf-8?B?M0hQVEFaTnkyczBVY0w3SHQvSVNydVZ5dU5pa3BMa2QzM1I5UHlyaDlMRU44?=
 =?utf-8?B?cGZBMzU2S1JtcGg4SDBmb1o5NkZYVkZ5Sk9Bb3RLeHpPNnRwSU93RXhaNGxj?=
 =?utf-8?B?QTBGd1dNSHlTL1AzNll0ZFZKZ3hUeU1lMUVadDBJRkwzWGJMZ1g3VU9YRWp5?=
 =?utf-8?B?NU00QndYdlpRN3V3L2RyYm1DNHVJVkFBN3NFd1d0OEh1elBpOWxIN3ZDZ2JG?=
 =?utf-8?Q?odbYVtT2sxiwyNGtdKJZcpLwB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76e5a80-f0e2-4111-6dc3-08db55277401
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 09:33:34.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1Xyix+/EKz7gcoYxo319a4UkftvqNIjhKbFVfWvCFdq0ApjtJMGBQOFp8ZlYRDf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/23 21:59, Bo Svangård wrote:
> 
> The functions are redundant as they are empty and performed by the misc
> driver.
> 
> Signed-off-by: Bo Svangård <bo.svangard@sylog.se>
> ---
>   drivers/misc/xilinx_sdfec.c | 12 ------------
>   1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index cb9506f9cbd0..270ff4c5971a 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -855,16 +855,6 @@ static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
>          return 0;
>   }
> 
> -static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> -{
> -       return 0;
> -}
> -
> -static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
> -{
> -       return 0;
> -}
> -
>   static int xsdfec_start(struct xsdfec_dev *xsdfec)
>   {
>          u32 regread;
> @@ -1030,8 +1020,6 @@ static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
> 
>   static const struct file_operations xsdfec_fops = {
>          .owner = THIS_MODULE,
> -       .open = xsdfec_dev_open,
> -       .release = xsdfec_dev_release,
>          .unlocked_ioctl = xsdfec_dev_ioctl,
>          .poll = xsdfec_poll,
>          .compat_ioctl = compat_ptr_ioctl,
> --
> 2.40.0
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
