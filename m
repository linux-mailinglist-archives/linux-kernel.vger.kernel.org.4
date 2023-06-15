Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69FD7319A2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343637AbjFONMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239033AbjFONMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:12:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48A6191;
        Thu, 15 Jun 2023 06:12:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UruNbhjiOCgfpxavI+a9qWaGzKtYoQ6TacwzJZ8A7Ppp8xw58+xiy5HBBVunD1nbcUN44qqYwkd66yfKguhwYXSsXGf/domNz74+g7tuufUv5Soz2GKlfPnTc4n1Zj2IOsmICc3Qa2E2mpe/jRMsb7r4FkJOkrJCW2XG3FsBSqOGLdNwPdzi1In4Yu6Bz0v2O8tCndtvUg3qYlrm2dAMQ1YaIFUfe6NRq6K8n0v4T+JxRf55xBUm7m2wWVLEIw6DsNcIWIfLtd2QrdxVplrLO1pHp+drbxk6cV562gj6XJz/0KdI2PXqzbJMzkWn4pvFTtwgqOBNMV+2oGSzbu8yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR1L78tyU6KV2+zsnGbsDjNVQGgjubUtfoelPFPd7jk=;
 b=SaZbiltsOXqCbaeXgMpmBb/GUR91bzGMdfgcTBbW2hLP1Sl40wZYa2Y0JniQsMN0wHzoYH4qepLJ9FbsoIQ0W7geVtuNTJf/P/kbexHoARpe8I4A4oQBrry76QweNQEEIp386ZT1uy1kN2pYWgEU/+s9OPFVKBCJXxmBjuKDghjeNnITvkFVt/VmT8EskuiVfX4HyVXzts0q7Olt+YApF6fKhhymPHIzGcDACGsEZpPuk85mlurphYdlONDUon7tTVKIfz+QiGhMJhjUCs7H0UO5az7LN/eV9ROjeUGh9JDF3rZka20HKi4AAi1rVfZiPB5bnqFGh8ox4Y7+E398xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SJ0PR01MB7313.prod.exchangelabs.com (2603:10b6:a03:3f3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Thu, 15 Jun 2023 13:12:15 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 13:12:14 +0000
Message-ID: <a7fd0996-ceec-54d0-b87b-09cf07bfb7fe@talpey.com>
Date:   Thu, 15 Jun 2023 09:12:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] smb: fix a possible data race in cifs_can_echo()
To:     Tuo Li <islituo@gmail.com>, sfrench@samba.org, pc@manguebit.com,
        lsahlber@redhat.com, sprasad@microsoft.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com,
        BassCheck <bass@buaa.edu.cn>
References: <20230615063853.15500-1-islituo@gmail.com>
Content-Language: en-US
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230615063853.15500-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:208:36e::6) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SJ0PR01MB7313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f06a3f2-8c15-4593-4758-08db6da2224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBvqXVFdYDUNfwZWm8wPwmDe+jMF9YydSC5+7vCA8J9aEhCeIJazjHwMZLQ5j8IfTRdVvVg+BipHzRpt1/Vr/wDik/o24W4VdENr6Fj++Rpy8Wdc3P0YuIMahlNqTA0y3M8yHZgl8A27BRTRAMTx6Nswmup5pdoyg7UxrI2O+iF131iBuuRgOpizenQnic6WOZpWetm/8vm98v/XC7nLoVya9BpHn82648NkX+0wACU5DBeaWm4O7U9Qq4wttJtbbuCSD3KXaXcP5+ZoeIPsVjFjMElneR7eC94zWQ9wfpNLfCFMrnQXyYrJQpfw3W0iYbJvC1kgNtQEBEZlwmahCbXId692KIF7eRzuWbI2/1V68PBRmxQhb8gWEn+21LSs8bHw8MDxfrXNCc9jbYhOaG6U2RAcsUCVKpHx0mR0nUfZmt4Cb3KmIVWAn2tIXYQE9A1K3378gyVH2BEk08cSFFMqxUWjv9vwID9YJpBBOCOn+p8mCGDRLl/v0pGBXvy6hKJKjr4Dy/X6xFB0YBU0wQXMVMAFTB8BeJjHSrOZRYNDMfv9jtBdXXA18XvYrxm8QAqWC+EIuybrbHxuTMIjJ+jAvT3H1GosxksUM6V6A8WkiFhGaEvPBPvnitKb7veIxZGpyVgk8MNOyxv5NQss5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39840400004)(396003)(346002)(136003)(451199021)(2616005)(83380400001)(86362001)(38350700002)(36756003)(31696002)(38100700002)(478600001)(41300700001)(4326008)(6666004)(6486002)(8936002)(2906002)(8676002)(5660300002)(52116002)(66556008)(66476007)(66946007)(31686004)(316002)(53546011)(186003)(7416002)(6506007)(6512007)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXBNTEM5eG5BOU1PajE3Z0pRczgzMDdWVEh0TlhocWhRRkRYSCtPQVlsWkVR?=
 =?utf-8?B?b3BoMWgyamVQSThYcVNObEZwRGdRYUR3cUpFVjBzMkwvbFMxS3ZheG5FbWdB?=
 =?utf-8?B?RFEyTzhqcGVDcFVvdEIxZUwwZEtEQnh0VEozTG9TWHYwWnpaYlpPWGtBR0Y3?=
 =?utf-8?B?R3g2UmVjVGUvVmJLOTl0dHVCN2l4d1h3eWJnaVhKcldSaFJ6cmpEY2MycEVV?=
 =?utf-8?B?SGx0b1pXNnRkcGtkaWdSbTZjL1EzNythR1RqekxnODJINlIvQWJQVFU2NGlR?=
 =?utf-8?B?UjMxWnUxVXpGUjRXS0hmWDJVLzFGalQ1bVF4aC8xTjJxTk1VcmVaZUZNOWZI?=
 =?utf-8?B?K1UvazUyalE3L0RUUkxYa09FdlJkeWk5Q0hGa1lTUFhGTk1QRmhnN0dkM0t4?=
 =?utf-8?B?K2c0dkFuUjM2NnlJRnlBbEpuUTFibE5rNTFuaS9JRTFad1k2cnFRNW1XUDlI?=
 =?utf-8?B?dnduK0M0akhZekRqZm9kTGhKdEg0TlpKSi9BV3Y5eFhHZ0sxVHZYREtmcFIy?=
 =?utf-8?B?QzVQd0ZlR0E2YkNjTExlc0dTQmFtY3dkaUd3b2xyNndwNnpubGw4VStoOUtD?=
 =?utf-8?B?c2wxK0h6Tk5uTWsxMVJNblZBaElENkMyRXRqa1BQTS9WYk5QZldQUVpRZFZl?=
 =?utf-8?B?V0tvcTlDVzJ2bndvdUVNV0VQUmxXd3BpN05PWHpSS1pwb3Rod1BFK3lQTW4v?=
 =?utf-8?B?U2ZjVVEwR1c5ZGdVSVlVMWVGRTNuSlc5bEVXTmJwd3gvRXZpYTUxczNCQ3BB?=
 =?utf-8?B?K1hab0hNbGVMYldtcnBzVUpKKzR3L2NFMlFvNTNmbG96dDQwc1Z6QkNiWkJj?=
 =?utf-8?B?T25ZQituSEhLSmZ3WC9CNjFObVlLdE50MDlzYU5EMXdKdjh5eUdNYy9ZajhR?=
 =?utf-8?B?RE52emlrTFpQbHRPUWxPVUlWQ0ozVDdUbGViMG0vUCtQaVoyTEUwQStMSXUx?=
 =?utf-8?B?QVFqTFJPd0Z5ZlMvRnJCS2tEUzFXVEt5eG5SV1ROLzIzYkxjL25ETU4zdlhB?=
 =?utf-8?B?R2UxSTFXeGFsWC8yTlI4TWdaamkwQldhMGhUK09rTlZaRmZ3TlFJVDVUeFVC?=
 =?utf-8?B?cGNwRW1Id054YktFT0lEcW5QczJLQ1ZRWCtIU242MmViSndQQTludUdwMVNM?=
 =?utf-8?B?eGM3QUkrOTE5Q1dLekdjVkVVWTIxWm5mZmJrNmJBbnVGWGRTRXdXejBmcVhu?=
 =?utf-8?B?ci9rZmpKRkFBSGw3c01YV3pIdm1OQW5leDFMeFI2TWxBYjgycEVFNWh1NlBi?=
 =?utf-8?B?cy9iSmJFL2tLbFBNY3BrVDFTcmhPcm1nUlhlcW9CRWh5c2l0UUd1dlV5Nlgr?=
 =?utf-8?B?d0ZnZ2NCZ1RCby9QcXNvSVFGbVdXbFNtM3lGaFJMU2Y1NHhCOEp1RUxjaUFV?=
 =?utf-8?B?L2E2S1RDUmhRTEZERTdURUswYTNqM0hEamx6d0poeUdITHRKR2k0TlhJYmhy?=
 =?utf-8?B?T1FkNTJ0QUh0UStqSUdOdXNDSEF2NnFPcFVtcHgyMWhCanBtLzhPRDd3VVoz?=
 =?utf-8?B?ZEIxM0ZZR0V0TDg5V0RDRTlFZkxBOE5iK0FyVzlmcG1EdjNEQXRveEgrZHlY?=
 =?utf-8?B?TkdWSzNUenZ6OFJLMkQrOVI4SlZSc1BpRlJmWEJmSy9RNGVJM1g4a255RnhG?=
 =?utf-8?B?eDJwWXVNRTRoSDJraE4zU1hjaWxkeHArMVNiV2tlb3c5MXBlc1YwS1kza3Nj?=
 =?utf-8?B?SFFOZ2Q2aFNkMUp2b0xLRUhtcXlvdUZDTTlyY1Y1bWFpS3JzbUMvY1FIQ1Q2?=
 =?utf-8?B?VGR4akVrbG1WMFZIeXcvbmR1SmNTT3RxdXpYNmQ4WHdiNmxwdW04NHRCR2Q0?=
 =?utf-8?B?K1MrOXpLRGhQb3E3d0JHRlM1bnhDYTJlYkJPY25VWHdoa2E5UW92QWFLQkk3?=
 =?utf-8?B?WW4vam0xazIyUk56bmVwUVNTYS9nRG91d3ZQUExDbTVSZWlXWWVaOWZydUUv?=
 =?utf-8?B?WmswVHlCNisrcy8zMmNCN2R4c21YSkt1RXdVZDBiQ0lpa2M2a3dIS0o5WTRV?=
 =?utf-8?B?MFJmNko4MFNMRG5CS3FPR0M4bHhtQk5DRWZKdHBtL2xlMjM1S25iUjA2RkU1?=
 =?utf-8?B?VmdjekhQeEJLM2RTWUROQVhYcjVSTjZnRDJQZVlhYjBZK1RqSlozWmZ6K0FY?=
 =?utf-8?Q?8YXiJrpl1+Afe/X7qk0Ra73kX?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f06a3f2-8c15-4593-4758-08db6da2224d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 13:12:14.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cksw2DEy+xE0qncVZsUFUkmWSRz2xDYNcJjdn2IPkSgpmPNNWUQP5K0mHYMOpV1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7313
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/2023 2:38 AM, Tuo Li wrote:
> The struct field TCP_Server_Info.tcpStatus is often protected by the lock
> srv_lock when is accessed. Here is an example in __cifs_reconnect():
> 
>    spin_lock(&server->srv_lock);
>    if (server->tcpStatus != CifsExiting)
>      server->tcpStatus = CifsNeedNegotiate;
>    spin_unlock(&server->srv_lock);
> 
> However, the variable server->tcpStatus is accessed without holding the
> lock server->srv_lock in cifs_can_echo():
> 
>    if (server->tcpStatus == CifsGood)
>      return true;
> 
> To fix this possible data race, a lock and unlock pair is added when
> accessing the variable server->tcpStatus.

This is a NAK from me. The tcpStatus field is not being modified
here, and the race is trivial because the lock you propose is
dropped immediately either way.

Besides, this is SMB1, and the entirely unimportant ECHO procedure.

Tom.


> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Release the lock server->srv_lock in the false branch.
> ---
>   fs/smb/client/smb1ops.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index 7d1b3fc014d9..5120241d3c0e 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -1049,8 +1049,12 @@ cifs_dir_needs_close(struct cifsFileInfo *cfile)
>   static bool
>   cifs_can_echo(struct TCP_Server_Info *server)
>   {
> -	if (server->tcpStatus == CifsGood)
> +	spin_lock(&server->srv_lock);
> +	if (server->tcpStatus == CifsGood) {
> +		spin_unlock(&server->srv_lock);
>   		return true;
> +	}
> +	spin_unlock(&server->srv_lock);
>   
>   	return false;
>   }
