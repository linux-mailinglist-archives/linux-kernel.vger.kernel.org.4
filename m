Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94F3604A40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbiJSPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJSPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:00:25 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7621178;
        Wed, 19 Oct 2022 07:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZdah+f3LKtkx4Iu6yO9MWgcJ/oz9JMAWQLWgmxaJ8EAgviTMxI5zMGc3dfSqr+JW/KAxH3cBUCQNv1XANwdQ6yCkaPLE/xvGTtiNt+IdhfNud8uzqzImYKvRMBDCINuLFy8yCJCq6xk5fKPO3e8AcKDkaUuavXS+Nd5Ezqr1Fdy78QHkG497b8dUBX9OnoXDc+IJDuo4KpXc2cU5u2iHU+j46Yo+edCkCUX+RFzwXcxGpuEqsfLRYnYLehVhpPTa0jiaPR/j1BccR+0q2efzOcNpSGNwArOeSDMVzhJCw35RYlTBP5MmqRvShuWtpc9jwqCqY6hDhB0soEK28wHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8teMvBfn5C4OkI+7QkBtpsjF5sYh9l/bhNY0BlsiAg=;
 b=ml25dhl0Dy4zhUjd/OZ9CrbmEk7RgGb7N3KXO6rW585AWIYzWR8lTmnPVPFXIY4vuUw2+soziyQgSrOSi7UoW83324IcpONaU8YMjeAVuh2ECMETMIhUTbY6Vth2mbPh3iAsW4oAOkXsQXGSzLDRzTgnYn4jIKaKguVOAqe2jB0VP1wnJy/tDYDXaZRcyuBXjZ/ocLC8YbqIA5rXEozRJgaBfPfleVWXsFiYouIwIrWpLwXkqI4RK+6cXL3pmVOza1wS/aeDDFFlTDnDbhAqErgoMWAwV0ril54PP97ujM7+Sm3rgdw6lmWO1uUc1ULhKoSXBvG93qysjXOqtHHuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8teMvBfn5C4OkI+7QkBtpsjF5sYh9l/bhNY0BlsiAg=;
 b=JdKnPSU9/j+t92So8wIJIRq4mkZxjfCQqKI9rEqOJmJLUZeEOOsAjcQmevhUD3nMPydpXq4IV9GU0kd2yNFgXczEslXrhYvUtNq8J+Ne/X1Y+VzRvPohemfV2uE2tfzrsoXYaH1VFOZIXOWWoxFDYSK+jls1pwXAIbtk3+0jqyo7qJm9xCNqhKLyh5wRSDAV8TMy/2puFXX3AQNmiyW8/4iRVCs28AZIrTDJJR2L9xn/FRGQDbEg37hN09/qgtdFHFivU3WtM6Io3EgdaFQ8GvD1ITcKA3GPFzUxhxb67DZ079nOTnm9pAxgooI2+U47h49gZL28yDIr1SNTGLQMNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Wed, 19 Oct 2022 14:54:20 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 14:54:20 +0000
Message-ID: <3c75ca82-f889-a346-a031-2c417c57e2b0@nvidia.com>
Date:   Wed, 19 Oct 2022 15:54:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc: core: support zeroout using TRIM
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@axis.com, linux-block@vger.kernel.org, tytso@mit.edu,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prathamesh Shete <pshete@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220429152118.3617303-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 177403d7-82d9-4283-acb5-08dab1e1ccee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G91q/Gw1rCwEqa36dY0dwcQO+Ut3bWoSDNRGsK+TlEJCOKMfce4lbeHXYn5zgzA79WtIZ1zzkjoO295SFY8LvPzhIPKJH8jt5BE6YRKmm5D9YxLpVfT2J2LGpgHha6pTWMwYkBrjgqEf6fp4kXYbZYWDQZmNAuNAkLmkrl6Yo8ag8ThXxhJmzjijBIk2UUYPfThV2q9HQKhQrxY/L4TPyCO8vylE9nYmwVhap5/9vkcxbHaYeEnMiBi8YjVCLHeVIL+cvdnBdnl7CDbDPcsaTQXrkzV8QWv5gA15Di6FxHLKJWs12zjRqjR0fwsKH7VIgGvnrOucQQaaNwLH5h/zBbTrzXTP6B+kJwmN+KRL3/bbep5M/oh0pbcDsW95yU/6EfOGHZ2rTif7TRFNlcNvtD4diZ2GJex9BYZmD0IPrLVfVTIleIr0NZyS8L5MozbLbQ9D3nyhATtJR+ue9Vca72+gQTg7pRsWTRrA86EnvSxA3LqXV+LfRX+8s5eZ3GXQYon1AuBcyvVmO0X54HH986R4t5wfhXWSWi9BUzx5e++G0ZJD2P5l17B5Al4rI39QJOTp9kU1FInUdF1JXsnFDsfs3qxtFCSBkePnYDUyapi6vz33vXUuNAVYrgoMHHxRcXgmlT1qbHUX5amRuWvynySX7MoXqKdwco9mwIEpWuZ6gLqoIt293XklQ66CoJWBQ3c41oygsOuNibQud9ofgBdgY2hMRK+5LDE8q7BNvKqfAflbUru8msWctxJ3E+9+YW2QWNz5quW54/i4DE2lZZrufdmpOYMqpYJb0tLkQAm4FCPQbzYOnkEW4JbqOF82AnXdPVlPT9jQC0NFWhUJ/barYHKsvJoEMIfhBru+EbTbcQb6TROpnhZh1MKPVWXPE4E+WhRz3NhJkOjFJviVvQzNujVrG8slocttHipnJ5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(2616005)(6512007)(6506007)(186003)(53546011)(83380400001)(2906002)(5660300002)(6666004)(41300700001)(110136005)(966005)(45080400002)(6486002)(316002)(478600001)(8936002)(66556008)(54906003)(4326008)(66476007)(66946007)(8676002)(31696002)(36756003)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzB1eWdGNEFjTUwvZ1dBajdZWW11cnN6WUd0Vk5zUGdoZG9XNnBiT0pja2Ix?=
 =?utf-8?B?em5WdHBHZklrRFVyOTk5OW9BbnZkSytmWWN1K1ZkOHJWdmZxVDRlOGVRV1Ay?=
 =?utf-8?B?UHJrT1J5d3paMEF3RGpJOGJweFZOWFZEUFB0TE5pNkVvQ0hPbTRUQzNaM0Z4?=
 =?utf-8?B?ZnV6Y3h0Zlh0NW5paTk0L0RRdnVvUkhxU3BGUytyTU9OTk9WNjF2REZaWUpX?=
 =?utf-8?B?dmxkeGRMWVhzS0xXV1JUNWFDRWFWQ2NQZHRjYW4rTS9nTFlCc04rSkdyVjNk?=
 =?utf-8?B?TVZnRWhiLzgybXAyRWx6OWd4NUtNd1ZIZlBzckhONHk0RW43Yk45MndYMUpB?=
 =?utf-8?B?bXpXdDBRU3RjdG9pTG10NHZpb1liV3IyTjhxTStoUFVjK29lMVFxSnJDekdh?=
 =?utf-8?B?dEJwNFFQNnVCV0kxSmx6QlFyRVJNNFFiTEVGMjM4eGI4MjVlZmU5eFNWNTdS?=
 =?utf-8?B?VlJqYzRQV0trcEdXclBPbk90NHZnMndPdzhnKy9VQ0xFQ1pvbzhSV3FQN095?=
 =?utf-8?B?cUNHclZHb0wvV1pkejRTdDl3OXpZQWo3U3VyWnVxeXFPNm5INTA5V2RCRGxn?=
 =?utf-8?B?ZWlobnZkVnpIS0ZyMVppTUQ1MXJ3NURSUkZ2dWx5WFZlbXZIci9KZ0FTOWlX?=
 =?utf-8?B?UFd1WEVGdGVqdEJBMUlMNk9mbmVxblpReU45NW1lM3Ayelk3TVE0M1VSQ25r?=
 =?utf-8?B?eU4vY0FKeC9lK3hpVEF6ZnlKV1krK29JMzlKb2dDTlBueXRpbURYNmNkVmh0?=
 =?utf-8?B?RjVKUGVCWk1yd2hIU0FKSDljNEpNUUVaSTBlZUFSajFDcDBPb0pkRzlBeTVx?=
 =?utf-8?B?UklyZCt2Wno5U2tlQTlCa29jRS9KeVBwcmVBWHNIaStINTc2cU1TSVhrNHh2?=
 =?utf-8?B?Q3VjamQrMVdtclZ2aUtzbndOaFo0QTRnWHJiTXdobjZoK0xoaXdpSW1oM1BX?=
 =?utf-8?B?dFJGdURrSWFUR0lScjhzYk12NFFYdlVraWQ4QTZqMEpMbVRCdHkrcGZlTHFH?=
 =?utf-8?B?akVvcHd2WGFoejFnaTJUUk01bVprUjl4b0RVVmNjTWg4ZkhScitVUHpmTWNm?=
 =?utf-8?B?bzJmMWdBYThIdVc4VUlBeVFCMFhJd1Q4NndMNnBaRW1xMVYydXdTaFJYMVlR?=
 =?utf-8?B?Rld6MVQ0QUQ4Yks3K01PaytrakpodEdjc25LUkJGUzJrVEJEcmN1U2VySnNH?=
 =?utf-8?B?c2Q4aE1SOHM3MEhlOGVUdFJ4cGJ2T0hyOGRDTE9vbnUvdXlzeDg0VzFkUzBi?=
 =?utf-8?B?d1VCeXkzSzBBQWtQc3dIN0hHM1RhTkMzUnZFWHFVa1czY1czTTBoYVQ4dm1J?=
 =?utf-8?B?a25vdWlWaWpDa0xvVTZpOUVGTTVtWlZ1MVZmbXdJdkdOdVFEZ09MbEZwQzNh?=
 =?utf-8?B?d2RjWTVKOWs1Qzk2RW1nZDlGeW5IV3VWQmJYMUlYeXc4amZLRUpEcVBJTW5D?=
 =?utf-8?B?SnlVcHFEYkNlb2taOTRUOTF4QVpDajdkM3JsRFNMWm0wcXVjNVppRlRJK3Fn?=
 =?utf-8?B?V3pYNGYvZG5Ia3VBblpJekJTZXRyb0RBZHRWOEF1emY2dG9PSEpuSDBRVFc3?=
 =?utf-8?B?VzdQYnN6RHVZQXUxRlhTanBkSnAxWWx1OFVoWFFGUTU2NjQ5Y0hTVjN5STJW?=
 =?utf-8?B?djJiMThrOWl2Tkt0UlE1UkcyMXc2NzFUK0lEZGprRSswQWtRSFhNRUprRlFq?=
 =?utf-8?B?Wnh6ZVNKTGhGUEtJK0JSVHBQOVE5cUFpb2hTNkcrTWwrNlUvRVcrSEkzSUdp?=
 =?utf-8?B?Q05RWmtVYmw2M0NOVEZONUYzY2psYWJ4SU5iYzB0aFhzd3pmYkZHaThscHJj?=
 =?utf-8?B?WUcwa1lZdy9iZlU0Y3VHOUFPZ1ZSMXFmN0kxMmZubk4ydE1lenRDUlVUemgy?=
 =?utf-8?B?UGVLemwrL0ZUZmk4S1RKVHNIcTZORnYwdHRYZ3FHQzhoYmpUS0txRFZoQkdK?=
 =?utf-8?B?ak1oYWM3dGthQVE0RTFXWFFseUJBWHpoa3Mxdm45aENXbVhoRk9MbVU0aStp?=
 =?utf-8?B?MjNTTlUxQnkza09lanJ1T1BuVndXc2ZtczhSMDFzakVNYWNZeHlnLzVBb0pD?=
 =?utf-8?B?eXFmV296TmU0RDRYTmlUZ0NMMlh6VElwZmJMMUlTd3ZZd0VxdTJCaDNuNDVy?=
 =?utf-8?B?MjdUVm5OTVJDeVI1VCt3Rkx1SllQSDl6dHh6YmkxK3NNRTRmVVhmYklMaTNN?=
 =?utf-8?B?TmZpQzAydjIwQWMvUVJ0ME5XQjU3d0tCTngycEUrV2dBZitVeldJWm5YL3ky?=
 =?utf-8?B?TDdjNmZ5cUhMZU9CSkNpcXQ0NVJBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177403d7-82d9-4283-acb5-08dab1e1ccee
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 14:54:20.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUdiyPOe2a7tm6z+1F2i3RTWxAALweBG49jIe0qBQrgOwqMlWPNICVZRVrjLonB7t9dYz6HnH9ZIHGfmoPghvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 29/04/2022 16:21, Vincent Whitchurch wrote:
> If the device supports TRIM and indicates that it erases to zeros, we
> can use it to support hardware offloading of REQ_OP_WRITE_ZEROES.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>      https://lore.kernel.org/lkml/20160303182146.GG9772@thunk.org/ seems to agree
>      that BLKZEROOUT can use TRIM on eMMC.
>      
>      BLKDISCARD uses DISCARD when available so it can't be used to send TRIM.
>      
>      If TRIM should not be used for BLKZEROOUT for some reason I guess the only way
>      is to use MMC_IOC_MULTI_CMD like in this commit in mmc-utils but that's a
>      rather low-level interface:
>      
>       https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/commit/?id=43282e80e174cc73b09b81a4d17cb3a7b4dc5cfc
> 
>   drivers/mmc/core/block.c | 26 ++++++++++++++++++++++----
>   drivers/mmc/core/queue.c |  2 ++
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 506dc900f5c7..0398b205a285 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -126,6 +126,7 @@ struct mmc_blk_data {
>   #define MMC_BLK_DISCARD		BIT(2)
>   #define MMC_BLK_SECDISCARD	BIT(3)
>   #define MMC_BLK_CQE_RECOVERY	BIT(4)
> +#define MMC_BLK_TRIM		BIT(5)
>   
>   	/*
>   	 * Only set in main mmc_blk_data associated
> @@ -1090,12 +1091,13 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>   	blk_mq_end_request(req, ret ? BLK_STS_IOERR : BLK_STS_OK);
>   }
>   
> -static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> +static void mmc_blk_issue_erase_rq(struct mmc_queue *mq, struct request *req,
> +				   int type, unsigned int erase_arg)
>   {
>   	struct mmc_blk_data *md = mq->blkdata;
>   	struct mmc_card *card = md->queue.card;
>   	unsigned int from, nr;
> -	int err = 0, type = MMC_BLK_DISCARD;
> +	int err = 0;
>   	blk_status_t status = BLK_STS_OK;
>   
>   	if (!mmc_can_erase(card)) {
> @@ -1111,13 +1113,13 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>   		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
>   			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>   					 INAND_CMD38_ARG_EXT_CSD,
> -					 card->erase_arg == MMC_TRIM_ARG ?
> +					 erase_arg == MMC_TRIM_ARG ?
>   					 INAND_CMD38_ARG_TRIM :
>   					 INAND_CMD38_ARG_ERASE,
>   					 card->ext_csd.generic_cmd6_time);
>   		}
>   		if (!err)
> -			err = mmc_erase(card, from, nr, card->erase_arg);
> +			err = mmc_erase(card, from, nr, erase_arg);
>   	} while (err == -EIO && !mmc_blk_reset(md, card->host, type));
>   	if (err)
>   		status = BLK_STS_IOERR;
> @@ -1127,6 +1129,19 @@ static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
>   	blk_mq_end_request(req, status);
>   }
>   
> +static void mmc_blk_issue_trim_rq(struct mmc_queue *mq, struct request *req)
> +{
> +	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_TRIM, MMC_TRIM_ARG);
> +}
> +
> +static void mmc_blk_issue_discard_rq(struct mmc_queue *mq, struct request *req)
> +{
> +	struct mmc_blk_data *md = mq->blkdata;
> +	struct mmc_card *card = md->queue.card;
> +
> +	mmc_blk_issue_erase_rq(mq, req, MMC_BLK_DISCARD, card->erase_arg);
> +}
> +
>   static void mmc_blk_issue_secdiscard_rq(struct mmc_queue *mq,
>   				       struct request *req)
>   {
> @@ -2327,6 +2342,9 @@ enum mmc_issued mmc_blk_mq_issue_rq(struct mmc_queue *mq, struct request *req)
>   		case REQ_OP_SECURE_ERASE:
>   			mmc_blk_issue_secdiscard_rq(mq, req);
>   			break;
> +		case REQ_OP_WRITE_ZEROES:
> +			mmc_blk_issue_trim_rq(mq, req);
> +			break;
>   		case REQ_OP_FLUSH:
>   			mmc_blk_issue_flush(mq, req);
>   			break;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index c69b2d9df6f1..bbe2ea829ea7 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -191,6 +191,8 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>   		q->limits.discard_granularity = SECTOR_SIZE;
>   	if (mmc_can_secure_erase_trim(card))
>   		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
> +	if (mmc_can_trim(card) && card->erased_byte == 0)
> +		blk_queue_max_write_zeroes_sectors(q, max_discard);
>   }
>   
>   static unsigned short mmc_get_max_segments(struct mmc_host *host)


On some of our Tegra boards we have noticed the following warnings and it appears to be related to this change ...

[    4.168317] mmc0: Command Queue Engine enabled
[    4.176723] mmc0: new HS400 Enhanced strobe MMC card at address 0001
[    4.189609] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
[    4.207660] mmc0: running CQE recovery
[    4.215332]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27 p28 p29 p30 p31 p32 p33 p34 p35 p36 p37 p38 p39 p40 p41 p42
[    4.249403] mmcblk0boot0: mmc0:0001 HBG4a2 8.00 MiB
[    4.255457] mmcblk0boot1: mmc0:0001 HBG4a2 8.00 MiB
[    4.262063] mmcblk0rpmb: mmc0:0001 HBG4a2 4.00 MiB, chardev (511:0)
...
[    9.034384] ------------[ cut here ]------------
[    9.038985] WARNING: CPU: 4 PID: 199 at /mlt/kernel/drivers/mmc/core/block.c:2379 mmc_blk_mq_issue_rq+0x370/0x820
[    9.049100] Modules linked in: ip_tables x_tables ipv6
[    9.054180] CPU: 4 PID: 199 Comm: kworker/4:1H Not tainted 6.1.0-rc1-00025-gaae703b02f92 #1
[    9.062399] Hardware name: NVIDIA Jetson AGX Xavier Developer Kit (DT)
[    9.068821] Workqueue: kblockd blk_mq_run_work_fn
[    9.073464] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    9.080318] pc : mmc_blk_mq_issue_rq+0x370/0x820
[    9.084872] lr : mmc_blk_mq_issue_rq+0x70/0x820
[    9.089382] sp : ffff80000b5b3ad0
[    9.092643] x29: ffff80000b5b3ad0 x28: ffff00008467a288 x27: 0000000000000014
[    9.099733] x26: ffff000082d49000 x25: ffff00008467a240 x24: ffff0000802acad8
[    9.106758] x23: ffff0000802aca10 x22: ffff0000802aca00 x21: 0000000000000000
[    9.113810] x20: ffff000080fa0800 x19: ffff800009824000 x18: 0000000000000080
[    9.120858] x17: 0000000000000000 x16: f8ffffffffffffff x15: 000000000000029a
[    9.127918] x14: 0000000000000000 x13: 0000000000002000 x12: 0000000000000000
[    9.134980] x11: 0000000106d66000 x10: 0000000000000001 x9 : 0000000000000002
[    9.142066] x8 : 0000000000000009 x7 : ffff000084650118 x6 : 00000000000000ff
[    9.149171] x5 : ffff000084650000 x4 : 0000000000403082 x3 : ffffffffffffca4a
[    9.156240] x2 : 0000000000000000 x1 : 00000000ffffffe7 x0 : 0000000000000009
[    9.163276] Call trace:
[    9.165737]  mmc_blk_mq_issue_rq+0x370/0x820
[    9.169993]  mmc_mq_queue_rq+0x134/0x270
[    9.173900]  blk_mq_dispatch_rq_list+0x14c/0x8d8
[    9.178500]  blk_mq_do_dispatch_sched+0x330/0x348
[    9.183169]  __blk_mq_sched_dispatch_requests+0xd4/0x170
[    9.188440]  blk_mq_sched_dispatch_requests+0x34/0x70
[    9.193456]  __blk_mq_run_hw_queue+0x58/0xb0
[    9.197666]  blk_mq_run_work_fn+0x20/0x28
[    9.201673]  process_one_work+0x1e0/0x348
[    9.205672]  worker_thread+0x48/0x410
[    9.209326]  kthread+0xf4/0x110
[    9.212462]  ret_from_fork+0x10/0x20
[    9.216025] ---[ end trace 0000000000000000 ]---
[    9.220899] I/O error, dev mmcblk0, sector 12624 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
[   11.500035] I/O error, dev mmcblk0, sector 16720 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
[   13.804317] I/O error, dev mmcblk0, sector 20816 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2
[   16.104063] I/O error, dev mmcblk0, sector 24912 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2


Reverting this makes the issue go away. Please let me know if you have any thoughts on this.

Thanks
Jon

-- 
nvpublic
