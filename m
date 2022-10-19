Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B446040E6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJSK21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiJSK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:27:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496B127929;
        Wed, 19 Oct 2022 03:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz2j+izSuWX3SVWlpF+KLdxEUagXBTaRB6PXhAql4suaKZLkip7/e0Xhvfb2n2pZI4K5Z+NVxD4+PCLFNZUZG6pQpB+Fk+9+m6T7S31VXfCkZi8Rh+CLG9ECnPhfBHrqgutKdJxB1iiaNMfsq1i9PshmBAjTo9X8wRaJfP5j5Y+2mQB+yE5NLon0efcuyWvU4v59+zdSzrCjjMiNJX4WvrkV7TGAj95mTnxXz/ud+mi8vfosZfZ0RNx+UPpGW9Hms4L2xs6Wm2+NeDhUDcjsZltmRsd0wXxSnzaDT8imlm8xhbh93zNFYTqfx8lp2nPwAAnzXrN1MJTnp2SYAHFWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZ3cdsHv+U6bzHS01DGQL877QhMFIPbdc0PDOhncvtw=;
 b=mAjlYvB+60uJVv5un5O+2xnux4VrCTmicdYKauwi7wnghEsnK8y1KfKJyCC/YEYvCwegTPAcwk9UmNdFxNRsKuH/oW2vTcs9+06uClCXrbIaxnNmeQzs9NPb3UuJUiFphGXCck01FON9Hw7TV1yw/KhPrV19beLvUDzjUwp3npKizZL4GBiV3daxAvqQZiMFF32+Xo0EtNmscfNYM/DgVFo4DB5uPJAGu5oZVQgARfvd6IwldUzAUSpBkwOSH97gEpMkrdobSx7wbtoXTAqQuSK+kKGT0Bqi5O7MVd4GvDKtFrQlNMw4o8exim4/BbgfJlhEKWU/3sLhhOJSVam3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZ3cdsHv+U6bzHS01DGQL877QhMFIPbdc0PDOhncvtw=;
 b=E0uK7sQXDsQAr0VHwoWhN9b1Au51Aoyl7X37zhvcHiclVLpbFpHmNfydKEH9aq5S0gs91LsA6DnuFBi6reDiGlT/UXOvFHVuYh/zzca8SwibsPKcfd5vrUWLE/b4Iys4qW+6m7aGMSp3uXQGmB1RzwwvGaqYThj9EVx+IhgDjFuSzHxp24E2t+Rxgt/G1Zk9IqtQr7+7aB4O7h57e4ompxgxQHliXpieg+PDSacnddfZrgYNyfQ+ooc/kq5UVPQVQgWPx7sXdeGR4nnYmD2PBVHQS3aHKTYM6h7hYBxZUznKYnhzDW1pSpZ7uNXW1DsYSxd3tMNClcCOVbcZMSFMiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.43; Wed, 19 Oct
 2022 09:48:41 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:48:41 +0000
Message-ID: <1ff2967c-b047-a799-0db9-124a79bb8ded@nvidia.com>
Date:   Wed, 19 Oct 2022 10:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] serial: tegra: Read DMA status before terminating
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, ldewangan@nvidia.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        thierry.reding@gmail.com, alan@linux.intel.com, swarren@nvidia.com,
        akhilrajeev@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1666105086-17326-1-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0341.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::17) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d3a67c-6b8b-41fa-603d-08dab1b71ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+MrdtKrFveMUwUt7QvI0pYsykoFqAEn308Zm16KpYKExCX2/k7lr5P+Qa6VgzVi9jtlMdalHV7QERxkG2c7BObjtsy/wvMTJLOJYXV9IatHcdxiSirkhdJfi7QEQk2Ore565AzsTwB/gVe5x+i7g0ttIH66zwtRsbHQOnBFi8EWwkDZgHQcd8K2uAb4QqaY4WciuspuWQrroVFgQ5sgXMwVd/tw9eQt9z944AiLjLkl9KkX77SZOI3THyg7IiYKWgGGFnWBBD6HYLdo4BNjl3k2cNz4nHfzovv1GtElLPcJcYR2rMgID7SrmviwQXOlq4+m/styEWEE6fkikgO70hMH2z0V9Jk7phzDZaZEpsZBt0sVsIgjiF9rOv0P8HYgULqWgtpHKeRj9g54poYQYIvCPm6iySnVIS6PidfIXtD/dYbJ3Q9DBwAVysPWXXr8Na9/pIcFKz/W84gD5QrfpEg9fkRDx2RCB71skBj8kzL4rbkXfuj/FuO8owD7I16F7pkCQgRt0yFyjVDiJp2QKt/wdyjJOQOgZT7GUWt7W2tvVqx9RGywvecIzjTNzLZij4NiU8YI93i0H4aZ/J4iHAfMtNDBAZsC+VXMOyGjfU+DwRUTFTaT43SHXX8PGGeQRNxg6HHJJCochthuss/lzkhI0Db5vFH+4/DSp36uXt1m4PTYIJiOr9ChTi/xIRxNFG+Bi6i3WrxEzlMjLNy7Ngtlhw/3+F90Ealng7T700yCFchV1LXAz04Vo5KCrKqU10LvacOpwpiqR/QNvXctHtWL6JfVoeZ84v72NciXkP3IXkpKJCzoRepWiM3hiJvF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(31686004)(921005)(38100700002)(66476007)(316002)(66556008)(31696002)(66946007)(8676002)(478600001)(6486002)(41300700001)(53546011)(6512007)(2906002)(186003)(86362001)(36756003)(5660300002)(83380400001)(2616005)(6666004)(6506007)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhZd2RDRURFSTlxNjlNZ2pya3J6L0tjY0VnZEo2RFlxTzl4dklndGhkZ2xk?=
 =?utf-8?B?YUZ3amVsalpoelB5WXgwdUo2L2RTWFp2UTZWQ3E3NlJyVkVJelVCWlFBeXNn?=
 =?utf-8?B?ZGQrK2hqOWNvQVJzd3YzWnAyL3h5OGNVQldJY2hwc01Zd2k0MWFZbUpTMkM0?=
 =?utf-8?B?eGNCYURWTXhnMEFCdlY3bVdWMXJpTW4vK0JZQ0pIVDY3MXJXelFzWUZ2SXli?=
 =?utf-8?B?R0hmRDFnYnZjZ1dWRU9iMGduSmRHbWVhd1dZTU0raWg2aWdDWTRhTGlva3Z4?=
 =?utf-8?B?V0JQcmpuSm85TWZZSzdqcWVSMlhWeXF3aHNYY2ZFeDVrbkdhSWNSd3d3U3hD?=
 =?utf-8?B?S3hWcFZJcG1tU2d6MFNxejB4WTg0YzNuaTZzU29LSzRESnFBL0xFYmtjdFgw?=
 =?utf-8?B?ZzUvZHJEcG9CN09Jd0k3VE1JakF3UEJZa2NzLzM1dFpFQnAwZ2hWYkpKd1Rw?=
 =?utf-8?B?ZTZqK21ON2YrZGRUcVdKaWdjQ0FycXVxTVdYUnFtSFFpK2tUOFd4N0x0ZUNh?=
 =?utf-8?B?bVJ2UTIvSkNScjBxZ1U2akRBK1dJL1YzQngycEhzSlMwTEUxdEZjK2tvVzd2?=
 =?utf-8?B?bTlyQytRUzhDbGZsN2xSQlRhVUorSzdHbnA3L0NDT09wek1MTGxLZjJMVnNp?=
 =?utf-8?B?R29MbUd6cXZnbGZkcjRVWDBPb3dzeHFJRnQxOGZyVkZWRWdlWnhMdzVXVWhQ?=
 =?utf-8?B?U0N5aWNLZnZlK0FWUCtibzBjcHZGSlFnQmQ2OENwUGdLUC9YZ1BLdjBhOUU1?=
 =?utf-8?B?dkp3UjBjVlIzbCsrRXAyaUxkOWJXRHhZZUFrYzJ0UmxtbXp6TTZCem9JZFNl?=
 =?utf-8?B?dWFQUFJEUEhNTlcwRkt3dlRVekk0RVArTjFBQnkxSlBZaU4ya0YwcWNmcUFq?=
 =?utf-8?B?ZExpSk1EM0k1UGlQUmtkRlJMTUZuemQ4ZXh0bGlickkvb3A0U2JVVWZUWGxX?=
 =?utf-8?B?UVYzeEx2ZDZ1ZW1kYUlIOHp5NUlNa2dCUHpMcWpUSXNONWVQMHk0WWlMZ1Az?=
 =?utf-8?B?ZUhWb2tKVGdaZFpsSnc0OC9rSVhQa1g0ZVlqZWdCMVdmb3RsK0tXRkgxZkli?=
 =?utf-8?B?WUlVRXpIb2tEdW9rcnc1aFMrYk1PZWlsZFJDSnNGN2pnVnh1bms4aGhMWmpM?=
 =?utf-8?B?eDJXbkRMdkxDemdSNjBGQXl5My9ZU21qQmNOSXNXbHFsRmV2d1ZPL2FsamhQ?=
 =?utf-8?B?dWFMNWE5d2pQdVZIWWU4ZnhpMjR4OTlBTXU1Y2pBOGtQOW9TUTIvREJuWjdW?=
 =?utf-8?B?ZHQyYXkyRnF5RTh4MTNMTFdSRnRlak9QUEY4WDA2b2UzUEtPSXpRVXl3MGJT?=
 =?utf-8?B?ZmdaVkRCNm9neVpFUXhhb2pZMkNoWTlGQklBaUNZbUdzRzdWWlBCWXZTQWox?=
 =?utf-8?B?WFdjOE04MGpkRGV5bTB0Z2lrVTFzTWxyK2NFWVhCQVNEdDB0cnZSekl1QUFD?=
 =?utf-8?B?UHBsdlFwNVU2U3Y3ZmpsMDhZdHYzcktuMTh5MGViSmVZYUlHeWQ3R0RNdU85?=
 =?utf-8?B?cTluNVd4cGt0bkdvbElvMU9iakIrN3VqSFZyYUdiVzArTWtnUUVTb0ZmcmZi?=
 =?utf-8?B?MmNVcXBYZkUyWHVibU8rcmxObFhQYmk4QjROSi8yVXZDemI3VTVPQk9acXBH?=
 =?utf-8?B?WE5vU3laTXdiUUtqMmx5QTdsVW5LRnZSM3hUcmoyWlhoQTRxS0dIR3ErNjFF?=
 =?utf-8?B?eXNsQ3B0Y0c0TEthVEw5alhIUWVwZTY2R3BENXhNUGVDOStkYkcvVStpZVJj?=
 =?utf-8?B?V2VrT3drcGVaMWJhbkNPZWRnK0duRW00ZkJlekluMVJ3UjRkOFkxTStqVU9V?=
 =?utf-8?B?QW1JMGg1dTdkdC9QNHkzcERhZm9RWkQ1REMrVlN3L2plbEpzbGloenhQTmkz?=
 =?utf-8?B?UXZ6V2VOcjFpV2k4TWZLQ0hRZ1dxZFpDWEJSbWZqYlFHYlJBWktReXVSOCs5?=
 =?utf-8?B?RjBlc3lJUXpKd1Y4cGZQL0hIY3RKQVNDVmU2d3VoSkhydFFiTXlYTzZLNHdR?=
 =?utf-8?B?K2JZNjRQRmVtZ0lUeXBNQksrOWlVV3I4cDU1cDJMVS9lSEZWNE9kR2lITXJu?=
 =?utf-8?B?alYrZ29mOWFFYTB2S3pjOU1yQTc4SDZjUWZGbkZmdG1mTTZTTFpaS3A0aHp3?=
 =?utf-8?B?STc3NndhcXMzeFNHSXB5MW9OMHBISm0wSlVXeUZIY3ExNW5RL2RwYmZSR3Nj?=
 =?utf-8?B?akdTUGVDY05mRERNb01zNXhaYmZuMTI4eC9ITlBXNDBUYk5vUThTTm41Ky9M?=
 =?utf-8?B?bTlaUlRpRHJqdFhVUldOTmRzZnpnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d3a67c-6b8b-41fa-603d-08dab1b71ab5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 09:48:41.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqp0ENKZdHJXWMCSDc4Ase/4UT3wgtwV4jw4yejAwZwOBCTRvsQ0X+R5OsolF8Gq/1KSdnNdKDY/PjY4D0imyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2022 15:58, Kartik wrote:
> Read the DMA status before terminating the DMA, as doing so deletes
> the DMA desc.
> 
> Also, to get the correct transfer status information, pause the DMA
> using dmaengine_pause() before reading the DMA status.
> 
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
> v1->v2:
>   * Pause the DMA before reading the DMA status.
>   * Updated commit message.
> 
>   drivers/tty/serial/serial-tegra.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index b7170cb9a544..cda9cd4fa92c 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -619,8 +619,9 @@ static void tegra_uart_stop_tx(struct uart_port *u)
>   	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
>   		return;
>   
> -	dmaengine_terminate_all(tup->tx_dma_chan);
> +	dmaengine_pause(tup->tx_dma_chan);
>   	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
> +	dmaengine_terminate_all(tup->tx_dma_chan);
>   	count = tup->tx_bytes_requested - state.residue;
>   	async_tx_ack(tup->tx_dma_desc);
>   	uart_xmit_advance(&tup->uport, count);
> @@ -763,8 +764,9 @@ static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
>   		return;
>   	}
>   
> -	dmaengine_terminate_all(tup->rx_dma_chan);
> +	dmaengine_pause(tup->rx_dma_chan);
>   	dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
> +	dmaengine_terminate_all(tup->rx_dma_chan);
>   
>   	tegra_uart_rx_buffer_push(tup, state.residue);
>   	tup->rx_dma_active = false;

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic
