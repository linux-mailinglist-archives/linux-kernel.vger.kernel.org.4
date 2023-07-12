Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0174FD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 04:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLCvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 22:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGLCvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 22:51:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7E1734;
        Tue, 11 Jul 2023 19:51:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMe9jgT6P0d+ENuf3Rtdd45i++xOQsu4IJu8ZEZKK0K2CM7nY7sqGwMSs8hLGittZkTV8gnSKpxzT8vQ0J2Uljq9XcP12v+twVOFqQLjkrSQYae6Me284W9rbH+x+zpdf0fGGtj4y1aBizK+fQfsHwF4Jh5Nckwv4f8ZwxTZpBSKHgC11n0x2EBoztAT9MsvDoYvBBaxzE0Zzw7p1Llg9ErqdKlpoORUa5p+dncveVTpVw5bGxjPvgccilApzQEf8VV6Y8ANcl9g0qiP1sjveb9FkOZCib7le6MtAIE1Q+V2c9KWAvZ18gqyvbiuoRnm97lMZqb4r1e8eKHECpWcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRUeQKztVF3ecCqTYzuJri9e5VBuN1RmXFBs8o6V/mA=;
 b=k2A5hW45hvlsqRW1hz+xDs5zZBLFkwPk9tlfPOiZQ1YUQR6llRgjIekIKQqWVdNSkZUfAVLEVOWGRT0ou+zekk/fWnI9j8rvYt3zB9Ijyp7dMFi/7kJrPBQ7TVm9JtgGwdTcyN3Uw++A5OD2oCjL2hR/sFBQSKAm4Qyq5JoNTBff9YWkBXOc4qF52EkE3euIMpuUeRrUTyUjGF/1VmySV8i8Q4A0d+ZetFznKxPvKJvB6m8M5TVFPQp8vbvb2h9Wt2XpW7TdEbeEmezUsy1LoaQbLHMYysjlaOZZvWE0GklhHf0T99GnVcXTndFstXyL1dZZXcDbs/c4IkFQWRrCqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRUeQKztVF3ecCqTYzuJri9e5VBuN1RmXFBs8o6V/mA=;
 b=bdQAyaB8lTinyhBguMSIKkSTrxkWPldYsE0LeP5Br3JX0CTInk/wuryIsCeztzrlyN/ikNoh1caX3RI5OExZ0ib4B7zWJn0UsC3G8PABziyqy4wP4A9uNOKhwoV0eJDUBP8ImwQCQd2N4RvZpIGQ5HXTg52AKUgr6B+HAs3GAA+SBaSyB0zTMCtlKDYxch24xjzTUH6n627okGnd5XP1sIWrH5nCvhGJRw3UF66nKGNOa9xazjjOFRTQEbdDz9lZAjXMJPvo7MlIar9kc8a/ixgMiO1d65kb9lXGLWZEoyb9QppNSHJ9ckESl/OjDKauzBQ3WcFnGy6IAbC3PhwPCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4435.apcprd06.prod.outlook.com (2603:1096:820:6d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 02:51:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 02:51:32 +0000
Message-ID: <28998a88-2db8-9ae3-c1ce-2d05c783db42@vivo.com>
Date:   Wed, 12 Jul 2023 10:51:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] thermal/of: Add error information printing for
 devm_thermal_of_zone_register()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711124513.47771-1-frank.li@vivo.com>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <20230711124513.47771-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::32)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2072b6a5-3e2b-46bc-05a4-08db8282e629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NjnMPZnYAOQ9gQMcDuNFkj7te3daN5nsxG/7PVFHcyp4cviGl8keUrVl6NdNvHVPqJrwsXbuncvnfPX4ll9Ua39xU7lSMNVGOu8iu2YR+SGXiLwbAAG3OpbhBlDjfVfSxZSdGuDEb2r4OmgFol9xY3juImq051M5ec9MWs2UsTlEW0OXNn3WfuBAtAsiCsncGDMYDqY9Ch9XonOdZbkW8y0wvNbFbjPMKnuV2N8z6Q80xRzq9YQaSgbsQOTuSLK3JiZN5nPkrG8KBBJCa3W9DlSbCOLEymAq4nKw4uIvY3ebhAx+U6PNGRAJeUVkreKsNv2l6qZionmVS9IS6zeui/9BlQJv8AainDfGxZU+OGNcO+VhrxqmF8myB/+WhIXerzzVbZE/YjnyZexlmWB9WR6+KHNdHJ1vwSczBlFHLAa/z/HvMe+MjMgvU19SRnYF2lAiGwVzfgNw5r8OoBXu8hItnjrMIDoAlWsdngjUoTAbDg/Jc8leFAkFdoyO7CIjwiIjPYdYzNy4BQN58rdHQ4OU7e2vr9TLNQuKi2v3eCdJAW/NSz16/uHII6AnqkXNEgkfM46DVw+Fz0F4CVFlF4lnyrT2TgnTLLVtSoVTAlsEAmPDsX5mn5Q6vw9Ga20/DS2ZGH6dipiP+hbKPPp6ZhKWrkk+SuuXRsBv2Tyzx5HmdXyA2CdLt9pz7iYrgvsy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(451199021)(41300700001)(8676002)(8936002)(316002)(6512007)(478600001)(110136005)(66476007)(4326008)(52116002)(66556008)(6486002)(66946007)(6506007)(53546011)(6666004)(83380400001)(31686004)(38100700002)(38350700002)(31696002)(86362001)(36756003)(2906002)(26005)(2616005)(5660300002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01teHhQMnpJdjZZeHlhVkN4N2tybFc3VjlVMUhNWWQ4QWpIMkpYYnV0eU5z?=
 =?utf-8?B?bzk4eVdGMXkvNlVPYWthajJQbU55eEZRMWowYUVuYTR2c3VQVFRhOCtSTnhu?=
 =?utf-8?B?d0FRMlVJT2diKy9hR2RibXhRK3BSdFVTSVNoVVpzeFl0ZDBRZmJlS2UyTkUv?=
 =?utf-8?B?WmVVTmVyR2V5R3o1UnA5bEJ5U01ZUGR5MTByWjdIeExLdkJPdU9xV0N5OGRD?=
 =?utf-8?B?U2IwVW1kcEp2eGcydUJhTGpXV3pIbDJPL2twbWVaYzFBNldiQlIrVjNxM2dn?=
 =?utf-8?B?dCtkWW5qdUQxOW9la2xGNkZMajR6K0ZKbStwY29RdGx6aTM0YjhMTHljem1C?=
 =?utf-8?B?VUdUMFgvVW50ejhQaVBVcDI5VVBLa3BQUmswVmpnUCtOc2podmI3ajMxZWhL?=
 =?utf-8?B?UlhwaWVQak1OMklCci9PUitvcmpIMFAxT1h3dWlRZlp4dHFkOFlJT2pGdDZW?=
 =?utf-8?B?dEpYZGxlQ1g1emUyRWpNSGRzb2t3MjZJYjZVQlV2OUtaR3NyWFJpanBPQURV?=
 =?utf-8?B?YitpY0dCZ2ZEYmIxcmlQelprcnlaY1U4RE8zKzUyQTRFRW9XOURBOEVWa2J5?=
 =?utf-8?B?U0ZHdE1MMStvSVl4U0NxNEtGdmwrVlIrK3dqaERhN1FuenJtQUoySWFFMVdj?=
 =?utf-8?B?akVHK05vTjhWR20rM0FLS0hIWG14bkl2amdFemlYdFkzQkxWMnN6cXlwaDQ0?=
 =?utf-8?B?eVd0Z2dCOWt6TFB2MXJJblBPK3djTzk0elozeTVUcWNXdHpnUTNqcTJFQW1u?=
 =?utf-8?B?ZTJRNjdHck9obW9jRnU2NEZpVzlyTEVzc2VUc2ZkeUZJRndnZHpJaVZPeXRQ?=
 =?utf-8?B?VzZZRUlFOXJzLzJWejBlcTg0ZmI3Q0FqSnlIMURaUWQ5emN3dWVVT0lWZUM0?=
 =?utf-8?B?S3JnL0ZIR3VlSnlFN3MycXVWYUVRaFFQTXRUNk1lWkF1MVMza2RiR3FwTnh0?=
 =?utf-8?B?Um5zWlZZRXNuOU50eE5VekJTZU9EV1kxRm92U2lKM09HZVphUUpYSmt4MXZr?=
 =?utf-8?B?eWZwREcxUnZZWjBucTUwMXh1eDFjYWxYakRSTEs4VGc4bG1QTzFLMkpKSmMr?=
 =?utf-8?B?OUZkNEJqOXdwSGd3Qk1TRG5wWHhTd2J4WVJ6L2hTeS9aczkyVngreUx6eXg5?=
 =?utf-8?B?OGFxQkNHZ3hlcDNwcnFjdG1YcGttN09GZW00d3RnckQwRkU3N0hEaUhVcUNS?=
 =?utf-8?B?dkpObWN2UlNWSUw1cGsxSGRtNk9tcC9FVVpEVm1ncDZIUVcyZ0RUbVRqbFJ4?=
 =?utf-8?B?bnN5eVNRMURUaCt4aHBBSXBCL08wdGppa0pLN01laEJMMDc1NW9EdXFYc2Yr?=
 =?utf-8?B?T2lLUXU1Z1pXSkRvbWVIa2FWOTBJbjBSVEkySC84WmVmN1J3RnNMMkdMVTR1?=
 =?utf-8?B?ZkRVYkxuR2orM2taR2ZTWG1lOVNkTE53b0VpKzA0WHUwaGZuRXZVcDU5OHN3?=
 =?utf-8?B?V3FBdStkU1d3bVdRNzNKWlEycnZCZkg3WkZiTXlqa25obk1UZmlpVTNUMnFx?=
 =?utf-8?B?R0JyT0xpOUIzVGpkRndXUjlwZFBDRElsZzR5ak8reXpYUy9tRDMxWDQrdkl4?=
 =?utf-8?B?bC9NQjE3S29PQk01VW1NZlVSZTJTZTY1M1I0L3ZoN1JFVGRpNmlweGd5NElj?=
 =?utf-8?B?UjgyVEdZKzRiRVRWOEVnM2tqTEtKTGxFZEVPRjJuVDZnUEI1VHY3bHpOdVBv?=
 =?utf-8?B?YU11VzBwLzNKVU9pTzcwQWFxd2dFczRJV1NudFd5cFJ4MjhwUnBaeHJEa3VW?=
 =?utf-8?B?cVZDZGl1ZU1QWHpTSVhtSzZveGNhd1pKS2JQYTdFWDFjcm10dGx3eUM5a1o5?=
 =?utf-8?B?Z0QxTlp0WlJETy9MUXNUNDhlNzIraC8wbGcvdTZaNG9GQzUyZWFjTGk2Wm5i?=
 =?utf-8?B?aEdDY200eFMrT0NOeXYxR1pwZ2hveit2QWJPYWhiQWxEc1pCVVdQbkpGTVpW?=
 =?utf-8?B?QWFrQ1pHdExNeVRoT2lkbzFQQ2RRUHJyeHU5Y3NNNE1VN0NqZHBPNEhtNTF4?=
 =?utf-8?B?Vk9nZlVhOWFHT0wvU3FucDBlVTdNNmFkZlZ5aVIybWQ4Y0JNSGVqL2pGUm0z?=
 =?utf-8?B?Y210L0xLT1VsRDBZUHVYMWxVeU9jSnQ5elpNZTVnUVVkVGpiRFFCN3lXT09N?=
 =?utf-8?Q?tjuy+s98jSn0r3g2O8sx322Uc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2072b6a5-3e2b-46bc-05a4-08db8282e629
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 02:51:32.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HULcwR8gW5mdFpfnjmSd0Aj5NFMn4gq20MrJcc4224vHSBZv2lBIEjq/K9Go2b54KAnsdsRWDgNYHvnV0WCEhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4435
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2023/7/11 20:45, Yangtao Li wrote:
> Ensure that all error handling branches print error information. In this
> way, when this function fails, the upper-layer functions can directly
> return an error code without missing debugging information. Otherwise,
> the error message will be printed redundantly or missing.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/thermal_of.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..8ce231f7639a 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -583,11 +583,14 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
>   
>   	ptr = devres_alloc(devm_thermal_of_zone_release, sizeof(*ptr),
>   			   GFP_KERNEL);
> -	if (!ptr)
> +	if (!ptr) {
> +		dev_err(dev, "Failed to allocate device resource data\n");
>   		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	tzd = thermal_of_zone_register(dev->of_node, sensor_id, data, ops);
>   	if (IS_ERR(tzd)) {
> +		dev_err(dev, "Failed to register thermal zone: %d\n", PTR_ERR(tzd));
>   		devres_free(ptr);
>   		return tzd;
>   	}


Do you agree with the current modification?

Or if you have other opinions, please let me know.

I want to do a cleanup of the code below drivers/thermal this time.


Thx,

Yangtao

