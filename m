Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81896602CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiJRNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiJRNS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:18:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCFC787E;
        Tue, 18 Oct 2022 06:18:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHc705cu/17BG9LoljACLdctslky+9LHWIgUIf1Kmp1LdBkYecqN0bN/6ingcablxexeK569y1/9pCGikZmXZlLSUsNP2JJpUKyToffL+ufDgIhvWWjwvDRk83twRDafEFtg6UGor40+h1zltz9TCRKKfVbDqdFR/hy9GY53JBcEQd+qCd5sV9MANHI4+OWxNlcTF/fHmv6tJGAvmPYuuwpN2x5jawQiuYgSNR3mMNvklBUgVzBnUk1/F+9YphvbJay9vvTsDPOO+wDijfT2ny4ljULqFbyEYd0nvDiib7B+Gk3IiNIoWRNwDd/+npAn9dYshVGnDPx6XeA7b16jIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x+/DrsDzZlrY6ElNbdNmsKQfbN+FxFZi1SdQpc++Lo=;
 b=e4Z4yrWLDTsFh4nhudNeNGj6lrW0ZaGiaZwh5/X1CacbIjK53SWymatn0EnXuo0lv4bOaH5vp2qG5+m4vjuWGbIvOvVyOVUMYcbBzuIy4a9V4aVeYmHFosyu7eg58C/lHsxDwqokAoUYZjHc3bhKRxM0FyfS1lIUX0Fz1QAWpDTri77NAGV0zRUYuXn4m6VTUg5RZHzHr8dxdb/+zG4AtCGeVYVCymjULcoQyWUeym/imKyGWgyG/5hZDtouzlfwlo8UJv3spUmfApqt1BgkOHJw38ysw2h0BLDSRZl0nlS6Djj5MI9SKXSZaIeG9PlJl2kUEfa8syrigwXWYTa6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x+/DrsDzZlrY6ElNbdNmsKQfbN+FxFZi1SdQpc++Lo=;
 b=quuA/OfKjg8cXg7LgXcYVDOk+1NFsef7Ml+6Aw/3I4VwWkMdlPYept3XxpKR86POmZ4wtMCMxTsgRAPysL8u7SJx7v4yt/B1qsQ5riGGlR1KbEjvD18ipJfqrOf0J4FkNS76VgfKXaUNdh4IQZF20r4+YO9u158rTV4dlveBpIhr3l2PDCRiFZvAUoYMxqwC5vPNpMkFyGicNmASh4ukvMLqgq0qrH6G7XJM7C9G7NI43z121vy3B5HZG3MEcPVAgrYT8TQBS8OU5O12BcRSbCsVIs9e3oRnwWsUHQFoNIfwO5uKauBg60TdQBHQYdBtQIw1vqPhYYx96QPig6dJmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW3PR12MB4537.namprd12.prod.outlook.com (2603:10b6:303:5b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Tue, 18 Oct 2022 13:18:56 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 13:18:56 +0000
Message-ID: <5935afbd-ec39-21f8-1585-57a932261271@nvidia.com>
Date:   Tue, 18 Oct 2022 14:18:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Content-Language: en-US
To:     Kartik <kkartik@nvidia.com>, ldewangan@nvidia.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        thierry.reding@gmail.com, swarren@nvidia.com,
        akhilrajeev@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::23) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW3PR12MB4537:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d850f56-2a67-4c6b-9ffe-08dab10b4f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuTm9bLMDbolm4CFvrWXOxwsEZyxc6k9G2y2pciHoZB/ChOuNV3okqkiYdN2m4NiayY1wdj7E0VY0OwN2ScmRLGNUBasujgnATlTDq5XInD/dOuoKTALyHeP41j3+Q54avhlsUXzrY/h5bVtSb6hkpkmnrRoAFHhlUAOYo7Q8FyP3IvAIIyhK2uGmUxHGKNkVTErIu3aV4kR+SWxte/M9XGSXk5SFcv4bBhHif3uNYl2lFBSuU+nL2NIlIsHYUvWcV6nGxXN/7ebHVg3cS0Frov7t/GLyWI81kt7dfTeBqGJQd0IkWntg+AjQNKX98g64+cC3bT0WQKPeQ07mPMg5ssk0t/TimCj68WSBZVdNCDMl5ZEnJpWAVu4zcc7YRCihpKQG42dBU52rsA6z9IaZAVdY9BVQBTBL/FsZ130UxAI0aY10YzNQzeQXN/9Alwl6oCXvrt+zUewN68KWzKNtSBJIViDZv/YrPm7MTyBpYWGGvSvVst4MI/9JcOY7FiYtc6SIwyGsB3Y+bdQ3YxQDEnYbadTuu5tNYU4H5Atpkqds4UK7xNFW715Ah19G3D01OO66mXeyEQevx/Kw0bYCCfHtRdRSCKOK+6p34tIust8hTYgpgYHHKw+6af5LpNT0lUAKT1JtVizLGDJHDHXeDdcSo4H0H57tAM8cm/SEvwjTIYvrts6VRtZIy5nZtZ7XdWUnjEUHsC0DaoxrEgkZdMOkDs5qYO+CGlEmK0XIxMvgZR8H12MivJLPT2ePmT12j5eVnxN5WockBzkGelOkUAhj24S8p7yzHY1mqMCL9s4brxNzB7C53b9dvbjTFC+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(83380400001)(921005)(36756003)(86362001)(31696002)(38100700002)(6666004)(66556008)(316002)(31686004)(5660300002)(66476007)(8936002)(186003)(6486002)(2906002)(2616005)(66946007)(6506007)(478600001)(6512007)(26005)(41300700001)(8676002)(55236004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU1Tc3M0RUJYSDV2ZzBzWXhFSEhjRitNQ0Vwano4NEhJT1J2U25ORUc5OUNu?=
 =?utf-8?B?Um1TNUJtT1RxUjY0ZUlka1dYT0NiTkpKdXRNWG1pREhWa1QrSGJ0emJVVlRO?=
 =?utf-8?B?VlN0aTc4aFdDaUVEQ1NrQ0xBNVNaMjFiQStnMk00N1JQVlFldFlPdnBPTzJa?=
 =?utf-8?B?dlFORU9FYXpJMkRNMysrSGVvRTYzM1hxbEY2RVJDMjVhQlpHRmpqcmR2bjFU?=
 =?utf-8?B?aDc2MnY0Z05Ra0FwMWdsbWhUQkpRRkZkOG9xZmdYemNCTkM1b3BXL2hEZTR3?=
 =?utf-8?B?Ukx4UWltRE94aStsdk9ZTzh3dXc5Q2gwQU5JbkZQRkVab0xXNVNpNjFtSEdq?=
 =?utf-8?B?eTJ0OVo3ZEx0dlczU1dNY29sL0loOE82MmdTSk50NDdINEE3aDJPUk9tT1VG?=
 =?utf-8?B?ZGFrKzFhZlA1Z25GcVFiYWFMQ0VDZkt3Q1lRYWdoT3RFcTExNTI4TW1pMmNk?=
 =?utf-8?B?TzhUMHBadFc0UEhidmRjSUdCS3JMQXJkdmFWS3lwMjFJbzZNLzdJMmJMc3NJ?=
 =?utf-8?B?enhOOE5HdUxGMlJ6NmhRSUJ2WCsvQUlaaWxranVKbGptU21pNlZDWmhPalo2?=
 =?utf-8?B?ZG9Zc2ZWeUJ5UkFuOCtyL2NSSk9RakNLMHFXUTlSbmtiOWlrZEdqQkdZSStu?=
 =?utf-8?B?NzNicHNUdUM5VnJXcFFvWVlPSnpyYnpJd09BT3h5d0ZjTVRCbUtVU0ZwV05M?=
 =?utf-8?B?c0FqeFNJQ3FuVWEwajRndXkyUm9pTnR5dXpzVncwY2xuYW1UcUFaUUk3NHJ1?=
 =?utf-8?B?YjhraW1ZcEJSQm5yazE1MlRLUVFSL1F0eCtrWU1rcWhEemIycHB6ckwxNFZB?=
 =?utf-8?B?UUZqSjI2TnhlNjI0VVJKWndpeTZtNHFnMzFsdFdxNGlHMzJqK2thUENGNXdk?=
 =?utf-8?B?SXB2UzBpRDlkdTR2Tmc3Ym1SU0Ryd1J4Q1N4aUdpZjFBQmQrcmNTUlRRSy83?=
 =?utf-8?B?RjFPMjI5dUxKOFFHOGk3L0xZakgyT1BTR0RmeHZlSHh6ZW52N24rZWQwbjgy?=
 =?utf-8?B?Z2w3eFI0dmpwR0pRU2d6Q05tRENhUnMwU3pyaHNLYmFBMWRJNGxrYnNpZGZQ?=
 =?utf-8?B?d29FS1VZMzBnd1R5VGFQdHBXNk5kcWdUZFpDWE1yUUtwckRDaU9kclY2OWR6?=
 =?utf-8?B?Ri9Jd3I1M0dlQStxQVFHRkcxMXZmZHBlNndEZFZUck9iRExwbVhvdW0yWXNh?=
 =?utf-8?B?N2ZiT1hKdFJrd1dXaTY2S0w1SUhBUlJJUytFVjBaNUZUU0dTeTBEN21tVmQ2?=
 =?utf-8?B?WHkwTHpuL2pXcnpyYy9sWnNHTFNHeDl6VjJyNmk4M2kyUHJON045TmJaVzFj?=
 =?utf-8?B?RDdFamV3eTIwd3ZwMloyYTFQOEI5eGN4QnJIZkQ1YVVBbEY0WGJGMk5wYURT?=
 =?utf-8?B?VktSbkZINHdORDdESHdJZWFuQXpOSzZZc0lXNy93T0hZUUdiTXg0Y0JlSUk0?=
 =?utf-8?B?QXpLQ2RuL2VGMGhMNGl4N0lmWmZkN2YvWlFwUHgrbG9hQllMUFVYWm1lN3A3?=
 =?utf-8?B?WVl4ZC9la2xhVWxLZmxtTGtOOVZPVTZ2a09zbldlay9nS2JLS25ITk02cVlJ?=
 =?utf-8?B?Q1BXaHg5bUZDRWZ1VkJLQmhBWmJQWVIySFBQMWtWeEpwMGUxUzc4UHZwOXVI?=
 =?utf-8?B?MFM2SkFLcytVc3FuVXB3VjhLYVRhWk10VEUxTUxnVjZzZmhKMUdNMG0xblJM?=
 =?utf-8?B?dW5sUEhaRC9iREs5YWxSWVFPd2F3YUtaRVFwMGlTNkY0RlFDUFAyTXRZdnMr?=
 =?utf-8?B?S3lDYU9DbDMzbWtIZytOaExxTEhLczNDUnBHNG9UNHNmV3hRY1VmUWtjSjlh?=
 =?utf-8?B?aHRPa2RDMC9RdmVURDZMNnZvcExrNGZXcUR1NlZBdGpUNTRoYno2TFBTd1Q0?=
 =?utf-8?B?S2RCYVVxQ2xHM1JnK01SbnltdkI0SzczeThEYkdVM0JRNUM1STQvbFkrVWFH?=
 =?utf-8?B?REhMV2JVRFpJWFVzRTBUMDA3NzVwbTVQaTlwL05oUm5ZRmQzdXExYXdDMGRC?=
 =?utf-8?B?dkxrNVhpdVNmZ3pmY1pWcFViZGRoUjQzbTkrUm9ZU0dqT0xPNlV0b0Y5Qmhz?=
 =?utf-8?B?L2FwNDk4ZGpNQWpOVHRpN0U3UGtNWXBVZUpIZFNnTjFPUVRYL1RhcXRXTTlN?=
 =?utf-8?B?Rk5ZajZjUzFPK1ZpdmhEckVROTI2NU5UbGYraE9nd1A4ZEFSN2ZNMVdvK09w?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d850f56-2a67-4c6b-9ffe-08dab10b4f3c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:18:56.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: En6jpPa21fOssVmsAhe7zMH/yH0/STmuZ9m9hP2bhCmFOUef7AhfcM3Od1aM1wu4VnK/7aSdgqUXKd9/9F3FwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4537
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2022 07:25, Kartik wrote:
> To get the valid data, read DMA status before terminating the DMA. As
> dmaengine_terminate_all() deletes the DMA desc.
> 
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>   drivers/tty/serial/serial-tegra.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
> index b7170cb9a544..2779b4491f02 100644
> --- a/drivers/tty/serial/serial-tegra.c
> +++ b/drivers/tty/serial/serial-tegra.c
> @@ -619,8 +619,8 @@ static void tegra_uart_stop_tx(struct uart_port *u)
>   	if (tup->tx_in_progress != TEGRA_UART_TX_DMA)
>   		return;
>   
> -	dmaengine_terminate_all(tup->tx_dma_chan);
>   	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
> +	dmaengine_terminate_all(tup->tx_dma_chan);

The change looks fine to me, but on further review of other similar 
drivers I see that they pause first ...

  dmaengine_pause(tup->tx_dma_chan);
  dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
  dmaengine_terminate_all(tup->tx_dma_chan);

This makes sense so that when we calculate the amount of the data 
transferred we get the exact amount. Can we add a pause while we are at it?

Thanks!
Jon

-- 
nvpublic
