Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690636B0676
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCHL4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCHL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:56:36 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C101D910;
        Wed,  8 Mar 2023 03:56:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCR2P+MxPl3JY/aOACvEHu0wZEAPYNGT2cNZ4YCJ+qiI0hEHUkWgUDwYTa0q1EFDicih1yd1XmUJ2UtF8/cwDn9QjOaLd2PZycQVc2NZzwHXMRsovgkC3Pe5OkLlb5tnBwJNqmX/WgWAbMlLlxHbUoz906kt8IPGQO7BayP06KeZu3S+MsJTUyjAfNS1GtrCDm6aIE5JAYrpWCHZAK7TUSHIrFO3y2vrrMS+oasS0aM59xbhANEBgr3cDTEZWKIONfUR4PC7fGDtXqJONs3IXvsiV/C1K6cyV1458y93l7LLqXcWePggq193tvAQTdVD8H+UxYc+72LGQYImM0rd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/nO/n4PjyDhbkBkHHNLJnZHU6u9koHK/t0HXZcrs+c=;
 b=nG3eaH2/3dxuQx5s8gPazFHtQue+IH2J3AyrnrXRVqqg7rA4nbM9ytsufCQnFqtmbox4WTcAwYdlBXZMtb3N88hN9dYhZrRppbPmIdDUHaeXd1XWMK3PntdR6AWoG1WLkXAbPRuXJ8kbJlxr31Y8oWV2xWG5c3JP1doCXW/vjYpoSk9nLowmOV1lspr0CmK08wMZj4d3nF6fjIIQAfdfrg6e09EMqBqBlloAFKH3SH0MpwuADR2NlUdvtEIMry2HP3wy5j0uUkGftA4nnO7obpbC1Hcay/fnN8UcC2pdnF69e7znHHOyhQOWYKtkp0/M7hjo4TFHPikVAePjAVB6dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/nO/n4PjyDhbkBkHHNLJnZHU6u9koHK/t0HXZcrs+c=;
 b=BYy6t+oFykDk184tpFVMDkOED7uVecJHr8s/f+OVYaYnRGmk3t6vg+hNBe1wPfpYalQSHbxJ+WrD+mFdv6bx/MrOn8mvCBKI2//5P+P++dqHK92gljf6EbH7rZyvgOcIcT4MnmObFxRyuBZvpZPx0jpn983Sv+YCiUOUz521jJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 11:56:32 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 11:56:31 +0000
Message-ID: <d8551cc8-bd5b-a2e0-ca4d-39bcf96d83c3@amd.com>
Date:   Wed, 8 Mar 2023 12:56:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/5] mailbox: zynqmp: fix IPI isr handling
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-3-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230228210216.447373-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc35b0e-1c12-4aea-cb60-08db1fcc287e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1TxPO2sgOUuxv7SRHqCr/8KECTnBvLzi5gtzdSzUFmhK1gdHPMR9B+nYfjVeJN/zth+hCal9raZzmrj/ui1sUF1dj5sa+RQfH40eenfEhDh15UTZBCtmowMfif+BCrpufOz04cxMUQq2M7GHNI4u+0qOboJap4oryYEADv1Iyj4uGZXyFRFWOgKcUv8EjzCSUq+xzLOKEwX3FTu/6bHRcUEO5ih/4gYJH+VXKAa23CqG7ejlsb0xwxh/vtP3hdu2qcwBugrvOkfLUCAuzxEduF2lByD6V+Q6+IMGWVeWL2cLxhavW31G71JuAlmC3+ynTHmcCVbd5XsR2uCoYpD0B0HMEqhLM/1bbyQKoS8q+nez7kMxLg+yWT/hA2SLQeksBuA5ixmRMURk5ij2SChm1s3J1gekSlvIuLRZ46JuGAhYOtfwq8mXlXr8220aft0Eih4/KXjaHPekBnOTVDfHxkL00zblQADECq7x/GSsBpRhRriueiou/jnSf7J2uw6NQ62XIXhibNtHcKja012WICTYNrRpazVRM3e+DtbQUlWpIpAo+l6nKyMf4wDrcq6QgHWstz1dbcNKE6UXgrunc1H3vc5aekwRDJCVHDB6fupdVa9PnjbAWcQfmAF9UY9CkLokK6/z376u7FCHy5pJKbVUvCAxwFsxpOASA4eclD/qQYyojDajriClYj5rtXWR8hjnLbiLvhSCz/lc4Y+YXp/5jPIoKRwyoAC8cWz86Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199018)(36756003)(26005)(83380400001)(6506007)(53546011)(2616005)(41300700001)(186003)(15650500001)(6512007)(5660300002)(6666004)(6486002)(8936002)(66946007)(31696002)(66556008)(4326008)(8676002)(86362001)(2906002)(66476007)(44832011)(316002)(6636002)(478600001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVB0c1oxOW43dG1XU2VJUHN3VVdZMlVJQlZ4V3AzeDJDY3pqNFFrcTlkT1Jj?=
 =?utf-8?B?UmFlMnNZL2ZXUFByRU14ekJqaldzZjhqdzFpeEJpVXZjMGVHZ1dtNmpCQ2Mx?=
 =?utf-8?B?NnExRjZMamM1Yk9JS3AvTzZCUWcwRWxSeVRiVkxPTVJLekdCV0FDWFlXak91?=
 =?utf-8?B?S1ZRWkl0UHIxaXFIUXdsOHE1TkxLdXNiMllnR3ZtbHFieUFYQm5pdUtwRWpG?=
 =?utf-8?B?Z0drYUIyN1c1dHJ2SmY3TFdzdjRvLzBCMWgzTmpkYUlGblkyNHBBN3FVcmZs?=
 =?utf-8?B?NXVlOWxORXJnQ0pGdUhFRlFpdk1RUlZQMVlzYjhrSGd2K1dOeFNyUElNK05P?=
 =?utf-8?B?bWdibDdiR015LzQwTXAvRlk1RndXcTB6M1ZwQnhzREF6ZWRscmViT0VaMENC?=
 =?utf-8?B?UWlJNFpGdEhxazZxTndzTUs4NXlyUTJtWTFIZkNOS2txRTV1Wm81cUVUZGpI?=
 =?utf-8?B?OGQ3RUk4dVUzUDZ5WVRWYkFUSkZ2Rzd4ZXJud0dVenNKaWlxWW9SYUxGblRW?=
 =?utf-8?B?TXpCckVIandSSDdoS01qVTdsT0xHV0VMZEk0SFUrdzVleFc3Y0wwcVpudWp0?=
 =?utf-8?B?cmRwVVdpMTdrMU55ckFVb2Ywb3h2M3pRYWJ5V2hneHNXLzl6emhPcGJhc2ZW?=
 =?utf-8?B?Y0dXRmw2bHNuTTJIa2puSis3Q3lPdDRweWVBcVpONzlRSWVvZnF3UGJsSmh2?=
 =?utf-8?B?NHlma3RMMU1oUzMvRkNpUUFOc2VmcVBZZU9NbGNGTXZ3ZHJ1MjFJTXRJRVUr?=
 =?utf-8?B?V3BWT1AzeFpPazBTSlAxQkxQN0hzMlRIUUhrb092ZUNDZkJQR1ZQUUNHdGZM?=
 =?utf-8?B?K3BUOVlCL3FGNVFmY1B3a0xodjkvb21xM0d5Q1NZU1VtM25DeXFENXVhTmlI?=
 =?utf-8?B?bkRid3ppdzdFM00yOWVjWERSeTFOMW0vSWMzZXFmQks5c2lUVnl2Y05JMXlu?=
 =?utf-8?B?MkZOZUtCWlM5WnB1NmlOd0ZUcVUwUXkvSDJEZDVrMEV0bGI5RFY5Y1FuN2JK?=
 =?utf-8?B?enRoVi9kYjlpVUNUbjkxL1F3MTd2N0hWeTNUa0VRdXFCRGpTMEVvWkNJOWxV?=
 =?utf-8?B?dHNGakloa0dmVmNGemM5cUVMRkNhaWpzWDlvRjhZNnVZaUVjbnprUWdBRlVz?=
 =?utf-8?B?eitYdEpkNFFmU1NoWHlqYzlLVEk4dGNyYkZ6VjZhbm1YN0lNZ0EwMExhZDZS?=
 =?utf-8?B?TlZoQ21zMC9yNG9WQzRsME5UcUgrS0NnTHIvQUloWWpQbTY3ZFBYY0hFOE44?=
 =?utf-8?B?OG92WEFIMnJJN0dPMUdROVFSOE9BT2dpNjdjWENvV2dpSXR0MUo0Z0tRUU50?=
 =?utf-8?B?bnlpZDFUaENKZE9QQkNVTzF0bmZLenROM0ptQ3VIUmJJQncvdW0yM0ZzRzNF?=
 =?utf-8?B?MGI3UzVOcVFuRkRCZW44OXBnUWV4dkNWUFBqeWVNM21zcVZvdWhTalJWYjRL?=
 =?utf-8?B?aExSck5laGVHak5LMkhBbldzdThJdkNTR2Q2b3dyZXF4UjJpQlZSeGZkbzFS?=
 =?utf-8?B?TEZxcjA4Rk1TWmI5ektnTWhNOVJ4WmlCSlNJMm51V25UU0kzaENpL1NaNy85?=
 =?utf-8?B?cU5VdHVXd2lOVEY0ZGZld1BwM3NyWWZTUzZpR25aRWRQRkZKNk56Y0FBY0ky?=
 =?utf-8?B?T2RleHhVb1FCOVl0dDdJaTNlL2JwZnV5Sk00TGs2Si8xZEpWZXlmdFBrLyt3?=
 =?utf-8?B?WmUyQ2lKU2U5YWV2TlAwMXNzODdXRnFsbXk2RG9yVXpSZm15WGFBSXZKazJD?=
 =?utf-8?B?TkxLMWVSWllsRG5XZTllcVZuOERPVW53RXg4cFlGSTZWR1lvUkNGSzdIVnUx?=
 =?utf-8?B?a0lmd3FIV1hVUi9iS1AxUjhiZ1JkbnlVOS9sbW5HTzZXUDBTZU5VaXJPTW9W?=
 =?utf-8?B?bDJCWE9VYy9UaVdWU2hJUVZYZzdjaklwK01SQzJPNmVpU1l4bTFsZ29qWTh0?=
 =?utf-8?B?ZlBPSFdrT1VqU1BHZ0R2RWlDcWFHRE1SZHNhdGNXdWt5Z0ZzWDNCUWNEL3pP?=
 =?utf-8?B?K0dBZlpVOWFhaGFPeFJlWE9LK3hKMW5iSjhJQ1B1c2ZHWkpzN2I5dEJsSlBp?=
 =?utf-8?B?aW12dmJpL3BCVEZFVjRFZnJPUXlNdExabWI3d3ozbDBEWmhNbzBUM3FjRWRH?=
 =?utf-8?Q?e9Nj9gNc55Vh7r2L5uJ80qxId?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc35b0e-1c12-4aea-cb60-08db1fcc287e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 11:56:31.7963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEXcmujdVA9A+eoFyoB1BAmnf5rp0rCkk1FakzkWOJmYWE6g00XTk7bxBScGUwlS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 22:02, Tanmay Shah wrote:
> Multiple IPI channels are mapped to same interrupt handler.
> Current isr implementation handles only one channel per isr.
> Fix this behavior by checking isr status bit of all child
> mailbox nodes.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index e287ed7a92ce..b1498f6f06e1 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -152,7 +152,7 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>   	struct zynqmp_ipi_message *msg;
>   	u64 arg0, arg3;
>   	struct arm_smccc_res res;
> -	int ret, i;
> +	int ret, i, status = IRQ_NONE;
>   
>   	(void)irq;
>   	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
> @@ -170,11 +170,11 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>   				memcpy_fromio(msg->data, mchan->req_buf,
>   					      msg->len);
>   				mbox_chan_received_data(chan, (void *)msg);
> -				return IRQ_HANDLED;
> +				status = IRQ_HANDLED;
>   			}
>   		}
>   	}
> -	return IRQ_NONE;
> +	return status;
>   }
>   
>   /**

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
