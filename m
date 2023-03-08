Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8F6B0670
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjCHLzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCHLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:54:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D8BE5E5;
        Wed,  8 Mar 2023 03:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVyLhFLNOrGvht/qzqUh/u+fSYYu5iK8t5gWLUrz1rm2/0e/gefz1MC3H6Me4xKp9qHnOb0gUP1Dynx63WArcVJXmoL4e8c1eYpK292ARyWTzPU+qAJ0ncoy1rZ7D+HqKlhH2UAEf8LJh9PusDJe2a95xsakkibmU1Brt9xNVF19Ud4Fp0SvMQ7E36U1K/EnMCfJEGY8YtM3/j41vzGDho4HYb8r0fXVsw1wxJlJ34oNbKY+D324Dzuor3FSWqsnR2kFaUBnH8L4gPHIjKUyOHMTKsZX1rlZFiqoqvYopud9R2k48IGQvg7UtMmqLg1dRrKVz70ZbXteKr1VrQtX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUIe3FZ11CpJtm6aAcU/Q8d4qpuiSR3uXZn0J8IjjrU=;
 b=QvQp/lDTHqtUvQhTdDgQ8eHK92uZOtO9JFX6l+wHRh/ONBMuHAUFi2pwbJpJVY9f6TI9snBtai+sddAs3j5BJQLuQjpjseRkrxxlQm6QbH/8tGLF8oSMdYu70XWFZ9JkV3n2CSwV7b8nVQlR09xVTI5Q4xnju6O+d5LMSlH/r9hvgB4BYvvn/aSRiXxsdz2BekviXjypUlyZwRPgqlwiNMzm+R12C2aXY6Wb0qfWSU7xDYEl4Zgp5qqVbgxyW41OdynoBmqn1A7ftnu3VAuUESuyI+F78uHpTzm/IDc75hLJnp2QEoclLdhGs43DZFyThby0x8Q4hnBglN+3BYqn+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUIe3FZ11CpJtm6aAcU/Q8d4qpuiSR3uXZn0J8IjjrU=;
 b=XPlwZcW+uh+rePLS9KIPS2FokyiN44/4lsrZyzgPO6M3EpiydVUVpyFRF/hSbm7QJzmHcK6XqSi+Nt27P44gKloM4UWiDwzltllWvohyeQTEE7zhyndQOjtEk1FKd/jRgHDUrGlQJy2KH8ARplzUa2lL7aWFTJ4tTP+XBxRsnEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by MW4PR12MB6683.namprd12.prod.outlook.com (2603:10b6:303:1e2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 11:54:05 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%5]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 11:54:05 +0000
Message-ID: <d410d181-a94b-40e3-5c3c-50625fbb0196@amd.com>
Date:   Wed, 8 Mar 2023 12:53:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/5] mailbox: zynqmp: fix counts of child nodes
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, jaswinder.singh@linaro.org,
        ben.levinsky@amd.com, shubhrajyoti.datta@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
References: <20230228210216.447373-1-tanmay.shah@amd.com>
 <20230228210216.447373-2-tanmay.shah@amd.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230228210216.447373-2-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0259.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|MW4PR12MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a511ee9-8843-4c7f-59d6-08db1fcbd14d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nl8g0/82HUw1gi3XwTsWOwr4EyyiOUifANUWND/NwWYmHHzil2JYbpLlnaLujC9seq+JFVhc/m3U1bdasDjQKA8Amx+B2+XNNv+I91zhuZfbW1OMzQLIob9Ior9nrDw8XR3uRrqxm2X6hPLB4YTUhBfV0phddVAdV36gjTFRvbDAKBHO1cykm7PhCfdDrZv1ZzNyq5TTQja0UWr7fAZN/qVy7pia2odX/vluaTkABgQJGBX0cdey8clzrnJpROshCd1tuY/VJ39RlqtKmBArTmXZiAmQ9adfi1a4MO9NCFSEp0e4VQfslrrZiRJxv4KiN8pRMVr1AR8Zzv/UGsj6fiC3Tdnm6fiMynmula6bGWp28KXe1UZx2elYRncsU6BRgU2kCZ156/wVHUnBmDqDHpmvg9HKjLxMUqqMIg4P2ijyjQXPNPz9pQj2U1IjDDYOSmL/5fDKr8tafJHfTt2ScGtDKzI/mH2r1upWx9Xcg3p1slaeC0+LRlnnoNstE6Rd/jBG2IYZpscftCKvHNWs3dZj859WxH09daJFQB972SSjH0YF6Nd282/XYdVLofXEnMrnCFhvvBmCCK0oxBjaLeJxow8mFnfaIYGUV6gBY+51D+QQW/UgEaEdOL2lQTXfSawoHhKJU06xlQxOTOCziOtzUtwEMXorktH0s1e4oGnk+jcqhqlRk5d2dOfrfQWyZXjqwkWQIWtcNdGlFL+hYeOi7oqOxpqplzFQJ2Q6axY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199018)(31686004)(26005)(83380400001)(36756003)(478600001)(6636002)(316002)(38100700002)(6486002)(5660300002)(6512007)(6666004)(41300700001)(6506007)(53546011)(2616005)(186003)(15650500001)(4744005)(66476007)(44832011)(4326008)(8936002)(66946007)(31696002)(66556008)(86362001)(2906002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhEUFNCNHp1aTYyN3N1c0RHMlA5Z0pqRVdpSk9ETzBPSGl3YVBnYk5XWnE3?=
 =?utf-8?B?NVY5ZTVjdFlPOHpsV3JzTzlWMEwvbk90MmM3Z3dESTJNellCeURkNk5zd0FS?=
 =?utf-8?B?dkRuSWZZODJkZ2s0Qy9WVnZ5bVUwSWpLTkRwQjJVU2Z1c2JGNllPdEZ1VkJ1?=
 =?utf-8?B?VGFVRm1WT2tSSkpyK0FpSStSSFkrUUVQY1k3UkJGcHlQdVV5YXNvZDgveXZw?=
 =?utf-8?B?SU9ROXovS3N2STJweG5OK0dKM0pnWE42SWs2YnhOaGxnUlVlbVlIWUdRc0hx?=
 =?utf-8?B?RFJCWWVLMFFmRERsMTZicXo5QkRoNk9pcHU4V1M2WHNYWjVTT285cXlFaXBl?=
 =?utf-8?B?OTE0UEFPY1BQaUtNdjN6MVNqSTFSMTYyM0ZQTUw3eXlvZEFGbm1ucmhqNUxo?=
 =?utf-8?B?TjVYdzdJQ1U5U2NkR25rM0dvdzhqNXBkSzhmK1VGTTUvK1M0SGlmQitsYnpm?=
 =?utf-8?B?b0hpbzJKY3hHamlRUjN0Vkg3R0FPaDdFNG9jSEtWL1AwSGkwZEMyQUFkYUM2?=
 =?utf-8?B?dVFOSWV0WXhTdGxvcUdla0pQb1RLRWxsQmY5Nk1kL2VLSjJORmhQekRBWkFQ?=
 =?utf-8?B?NUZadVQrY0dtaHVyNUtPeDJLVzJQSGlwcWhPbllBakFMbW52aWcwUmVuZGVD?=
 =?utf-8?B?NWJvVVhMaks4NU9wN05PSFdtQmpleHVUZ3hIaFZyQkFlRTl5ZjF6dzltc1ZV?=
 =?utf-8?B?MU14a0NJYVFNbFJXSEpCZTBITHA2ZUk5Y0h5OHJyRlhSbXpCNVJ0em5ObjNa?=
 =?utf-8?B?SDJTTWhGWFN5bFdudE5rZ3RXZjExRUtPa0NDOWVYNEJoT1krZFFmaXlSWmFh?=
 =?utf-8?B?VTIwaDNLT3BvYjdkeGZRWUJXTkt6cEErZnlmLzh5eWx2L0J3OXlaVWlnVVdw?=
 =?utf-8?B?ZFRuR1ZQMzZBaGRqS2dWZWFPTG52a3dsRDl4TzRtRVJLWHBvN0VyMmVRc0xy?=
 =?utf-8?B?MEJVUTY1amtHTFhiZGJJUURxc3JNeGEwc0RvaU53bXlaTzRRaXRxY1lJWDZC?=
 =?utf-8?B?NFJ4VXlFa0lsQkFBQTQ2UVpGdS84aVoySm0wcXF3azZNNjZ5eEppV21QYlBC?=
 =?utf-8?B?UHY0ZU04OEdweVk4TzVFN0ZleWE3Z3RidkY0dzBWR1Vub2M2clU0UUpWQml0?=
 =?utf-8?B?RUdkbit5YUxuWTFLWGg3bXpFbFhWYzAwVVU5bmwvbFZqdnZGTWxyNFBJcURI?=
 =?utf-8?B?eW5MUi8yMEU1UTRCd1BZaG9Oci9OQ1UvU1Q1US9YRmZpQ2lEeWRFOWd0Q2tZ?=
 =?utf-8?B?ZW9oamRCYm1Od3dTcVJ6bEgrUkxoSVZOU2NOMFYwMWl0ejU3eElDaHQxcENr?=
 =?utf-8?B?eGRmTGllb2tSMGRTeDBHKzJMZFp3QnFDVVQzTktWSVNBODFiZmNNUFVBQVdo?=
 =?utf-8?B?YmRtL1dJTC9SaVRtNlRpY3RRVXJCQzRYRnVEUHh6S0V0bVhqdUFoRWVsVEM3?=
 =?utf-8?B?bkJIK3lGZ3VrdnpYU3hTSnFqaGJWbDhkWVNRKzBBMDQ2R0VFSjErR2RCWWZY?=
 =?utf-8?B?U25zV21aL0ZLM1QvSXJyWTkzeU1SNUlJS21NdTZUMXZEQlAzY2dnQjl6OTNk?=
 =?utf-8?B?ZzFqaTZCMy85dVFZeFJwMDlING9jVUM1cjZoVzkwc280b0IzZHZsdkVnRTF6?=
 =?utf-8?B?S0dEVGF3L28wc3BNRmdGR20wb1ZrVi9zZHhTSE53c29GaEoyKzhOa0xSQW9M?=
 =?utf-8?B?YWpKVGFVQnY2VmQ1ZkJRTVFQRTJZUGxPSlE1dUhXQ1FsOEMwSUJGcFNmS0l0?=
 =?utf-8?B?Z3d5dFBmcXp2cHJEb3NWcWtpeHA4bVZ6bDUvbDF3SGVzaWdrekI5TXI3TTBw?=
 =?utf-8?B?MWpDWFJYWmI3RzJQdGszSzEzU1poRDJtcDRCWVJwaXdUVmNnb2wrdEFZcjdk?=
 =?utf-8?B?MlVpWU5uTEhtcnB4MW9Rd1FUckhiakljSFJuS3NMRFYyeVRpS0dXM01MdUwr?=
 =?utf-8?B?M3hDbmxpVms2Y1U1THhPTkJkdys4aXlUa1dBRFN3aFJHV2pJNml0bUhWWWNa?=
 =?utf-8?B?TG1DVEpvTVl3dnhFOUxZaU92RWNMeDNMZGRZS3BjMnhlemdpalJOdG5ncmZN?=
 =?utf-8?B?YVBsd0N1YjZONkZIbzYzRlFXaEVVS3M3WlFOdkovZ1BlZTJEK3M5TVUrZy84?=
 =?utf-8?Q?jaQR6Pz8wt9g8WDkAxZi3X4Hw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a511ee9-8843-4c7f-59d6-08db1fcbd14d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 11:54:05.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8xk+hIWMvb8/X9dAyZ829zwqaIzQKnb9A9Gm14BWwFVLdwC/wnoInRwmQSSSZ4JO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 22:02, Tanmay Shah wrote:
> If child mailbox node status is disabled it causes
> crash in interrupt handler. Fix this by assigning
> only available child node during driver probe.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 12e004ff1a14..e287ed7a92ce 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -634,7 +634,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>   	struct zynqmp_ipi_mbox *mbox;
>   	int num_mboxes, ret = -EINVAL;
>   
> -	num_mboxes = of_get_child_count(np);
> +	num_mboxes = of_get_available_child_count(np);
>   	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
>   			     GFP_KERNEL);
>   	if (!pdata)

I think it will be good to also check that num_mboxes is != 0.

M
