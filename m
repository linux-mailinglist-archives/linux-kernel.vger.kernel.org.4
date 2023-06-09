Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F052729612
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbjFIJ6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 05:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjFIJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:57:34 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084EA1725;
        Fri,  9 Jun 2023 02:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KESo7C2R3zf72fy85ktXooc/ZsCPH8sc4voLuLJ/CP5aVT+80kp5QqJ9BlZDgQkdOfRW/6YYK/aJhWbm1j4nN8nrLiRk7qMl60b0X0KBz/zv7mtFb0kr5ONcd8r64MIThKgfZdFKFZx9Ocr1ZD9jNPhPK4TF+DoA36G7qxFASsMAiXrpuBoseGrIK33tG9fKwm612MDcMjhyyG34dNNMq07qvnZgL1BTsFpytl19LNfVqsrFYKMPZ18GjfN7bj3hqJF/A5iz8QWkucGpKDefIerrjaHv3XsxIuMH6DjHrbENUMSp+VucPTtNxiynyWshKk8XEfOGKnDsVhqD1SJKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weihhgV2kBZcOiLMt+rPmXjO2vjqwwl4dsYJBeSRdlw=;
 b=V9puRsWubhDPgvLlEJSy5S8S/O4obhNqvuILH7FuEO+BiHp0KAS7yyinxzMIAH4vL7r917KR1QYc5yY5lAMS0I9k4m02m3LPByOsbxRAfkPkyNTLovbnX6YDI/5LbwOs4BYTXpMh21AkTzTv3Xt0BoZYsFRPP5ZBwRzjTohzKV3ILcjz5IEMIpdPDY5KHb6kpC+wgLZ4AgmTHXz1p8ESIxyygsl6vTUoaR8ZP7Vn38qJ4dR2+oDz8swhguwilHHEhRyTi3YCY/elr9HffVQKH+xmMZ2dt4gfdGPJ/ZKFAiTfgY/RvX2+b7GYdwGentzXpvlLXUWDrmDnVkKbDbvPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weihhgV2kBZcOiLMt+rPmXjO2vjqwwl4dsYJBeSRdlw=;
 b=NqZVE/wct+60P2ZaMFWma6kEdH4yi5n7nlpt1M8/jHae9EdBklTDqRAzzL7vHMSVjzoGlaEarJTV9EvVXZvvvYM3UPsNdBuxiLtJZc39MPAjq8ueVbdk3kDMtdFoUAXGb1vyoc3jKMniVOdrOq+kkkS4mHutY5Md/cG7BFJZWZ61D4I43Rwg4TiZAyQB3VKK0uNM2D20we8XZQO6UWufzk4926SDZMtSgxZOWIATAUX8jLGXrYqNkqxVYE/6lVDTBtMOPYPTiDFprj3rHNIOfodklqK2zUX0RfKF8WcK9X8/5Lsud4xc4VAB5BjONCqWWgADFedGpNpqzIfr9MwFYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DBBPR04MB7770.eurprd04.prod.outlook.com
 (2603:10a6:10:1ed::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 09:49:08 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b%2]) with mapi id 15.20.6455.028; Fri, 9 Jun 2023
 09:49:09 +0000
Message-ID: <db70b460-ae5f-5a8b-bab9-aae45ebc87d1@suse.com>
Date:   Fri, 9 Jun 2023 11:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] keys: Fix linking a duplicate key to a keyring's
 assoc_array
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     jarkko@kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230323130412.32097-1-petr.pavlu@suse.com>
 <2413881.1686233574@warthog.procyon.org.uk>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2413881.1686233574@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0028.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::19) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DBBPR04MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f610fa-1358-4e81-1253-08db68cec55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShR7NqA6YTjlIx7GbCEjcBo2jQXaGgZZLlF4dbmTaGXLGgF3vtxB5866/4pFgXwrWSeLFOfu9138zorbE6ltTKIHgtLqn4ieVJ+ezKOrBfrj/iI+ZBGH/G6X/mrARxohZckp47G2RkEBKvJVKRooBEfMygev16rznrEB+70FvVPGtDBR1O8yQPNBgj+ymVplsdgcNMsW7isARtSlWGUZK7HVAa9mHU5CGbTCyH+lIAu1f/HRGoIdF/aYu0TGf4PH43Si78ELbX0357kQWlIVmSl9I+pKXpQTXjbpYjrW2sZrmhSSjFmeX0UE19lyBxse3rAQAe8SQZsRjdLPqryDIA3Ef93Cm6q8+5zo3X6ZCLmOZL6b5yZuL2isvD3gDMmXYGksgJ5kzs1d7uEAQnfFc2knwnQ1BxeR9xcH3UHqJz79tTOvzrQwBzCyAXXKX5CqBU25tOt/UdjKYFJxwHhZjukbOYtczEIjj1Av1GzxVBADMVr5OrUPMk6/ssjJAjVFjMbM3Lfoo6i6WaE4efvLDbCFrksyXVY/DmjooaElAzHsFfPqa/8TmU1wGQj9mRYM2t9bC6jpuM4wdpjw1v3YFKPlwVDCV/fOPBLPRqqChmQWHcrtfBALey7/JnJ70a3wiyaOTvCZ4JAUL4qbFIhG1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(478600001)(8676002)(8936002)(316002)(6916009)(66946007)(41300700001)(4326008)(66556008)(66476007)(2616005)(38100700002)(186003)(83380400001)(6486002)(6506007)(26005)(6512007)(55236004)(53546011)(31696002)(86362001)(44832011)(5660300002)(2906002)(36756003)(31686004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEUwYWpFZ0EzS3FYMUJzMG5IWGVHeTFsNjJ1NnNyZ2pGemV5ZmlJWFZDSXg2?=
 =?utf-8?B?NmFyQjVvcjViS1pYbm4vRTFUWjN3YkxENkFYb2FaUHRPZE54U21iK0tMS0lF?=
 =?utf-8?B?TzBNMVFaMUtnaytKdXZUeWtvTHBrUVI4UWs0L09INVdjb1dBeWM1RHFNbnQx?=
 =?utf-8?B?OVhGbmJZUy9tb3p0RndIUDc3eHRiVnRneCtVU1pFcTI0dytlaXUwc3pMY1JX?=
 =?utf-8?B?UVFzczZJNXNLcHdvaG5KTnZhQ0VVYUJlRXBCZ2hOMGVlWk82enVRTGxTSkY5?=
 =?utf-8?B?ZzlVQTVSeFpWWW14aFBib1UwN1NMSmZhLzlReENCMGRVTTdxZ2FsaFZ6anJa?=
 =?utf-8?B?QUtJbDVYZkVtNWRoL3VxMmprNnhDMFJOMGdxd0k2aExVZWQyZE9sUWYyZG83?=
 =?utf-8?B?d1B6TUpmdUVwdUluVEJEYytBOXp4UmM0WElFRjk1QVRacEROdkN1MkxUWWN0?=
 =?utf-8?B?TS9MSkYxbXJzTk91bjlEeUU4R1NtRlZ4WW1HTGN6RVhTK25vdUVxNzRhUHFW?=
 =?utf-8?B?MWJJaFAxUWkvWCtTZ2UySGwvZkRtQmV6ZkNPdkorVjJDUmpERkdJeG90Sita?=
 =?utf-8?B?Rmd5dVFjNVdXTGNRRExyaU5Ia1JqWmx0em9JZVVzOWllQ1VzUVJ2ZEZBS3Q5?=
 =?utf-8?B?ZGoxTkpaSmpoSlYrcVNSbjVUbFd2R1gxdk1YNHp2SEU3ZUx2VzdWRDdFclBG?=
 =?utf-8?B?UzNJaTMyN2QwTHhBaE5UZ0RZMWhOU0dTNllCTzdEbzF2Z29WWDJnejVVdi83?=
 =?utf-8?B?d2RIV1RsODFjSDRXMnFkK2F6ZXp5K2xyQUJnQ2ZoNGgwa2Fmei9BTDgydXFJ?=
 =?utf-8?B?SEF0TUVjT0ZJVkdxZ05tRDNDZXZxekNVTTRnZm10UFR4aHJTZEJlZS9iQXM1?=
 =?utf-8?B?NEdoN01IVDk4ZzBUUkw3QU5NV08rUkdxV2NMT3N5MlMzVU9zWFpITTNPak9s?=
 =?utf-8?B?TnliM0lwQ2lHaWhERUNCUGZ4RmlHWGtWdTNEb3Z4Vm5GbURhWTFySDYzaVBN?=
 =?utf-8?B?MWU1b3ViU0hRN0FTRUZMOHpYSjN2dkNER0NBTG81c0tyMXhHeS85Wk14VS9T?=
 =?utf-8?B?SGlRQ3VQNUFqK0FFLzRmNlVjWFpMM0xGenYwR3hGdWZIMk5nazZ4QW41UzIy?=
 =?utf-8?B?RWpSalNTZVlMZ2ZSM21XTGwwYU5IVnU5WTNLMWlLalI1SFBzYWcxTWFMMkh1?=
 =?utf-8?B?QlpnL29rWFFJWmduaTJ5bkRCTkRmcjRVbUN2dUZlWUhYd1ZtUEJVVEZoMGY5?=
 =?utf-8?B?SFVWcGpkSVJvcUwyOXNtK2YyTFdleG9sam9MbE43eW1taUpuMlpoMHoyODdz?=
 =?utf-8?B?dlo2MHJxbzJxZGZQYWdYQkt6ekRlb3VudGt3YW9vU21LNHRIMHZEakkvUFla?=
 =?utf-8?B?VXlKcE9KVjh6UHhLVVhrYlFqWnNGSjR4a1F4SzhrN09oQS9FbDhyRk1yYTRs?=
 =?utf-8?B?UE9XK2dDd3NsbVRucGQrOWxtMm56RGpFQ1dISzRrYlJKM01QajhJT2JCdkNh?=
 =?utf-8?B?bkdUa0tLYWRhQk5CS3Q4UFVsME4yUXdWOGdWVUttRDJibGZJeXExRUlaUTRQ?=
 =?utf-8?B?MFQxRDFCcWozekdiYmFlL3I3bkVqaExtdnk0SmJrVnp5Um5pUm41U3NSNU1i?=
 =?utf-8?B?VHZraXRZNzNiSWlBL2JOOCt4VlR1YytINlM4bEhMWmx6WUpvL1JSZHIrR3NK?=
 =?utf-8?B?bkFQUko2ZW0xZGhBOXhaVWRocmQ5SDlHQ2liWllKQ2ZYYWhZNEN5ZXlUTDlU?=
 =?utf-8?B?ODNqbkE3M3dBWDY4ck0ycGtnRFdqWUgxQ0xWUWUza1JRQkJXazY0WTkyUUVq?=
 =?utf-8?B?NmtiVEl4OE9vVXVoS3Mxb0VGMVVkRnkrdSs4OW1XVithSUdjd3pCOG5uVHFk?=
 =?utf-8?B?MVMrT2hrZ0RPMVpZVUFoMERMR2Z5NmFUR3Z1TlJjMFJVeHFvUFp4ZnMvVFRM?=
 =?utf-8?B?VWprNWtoVllNZHpFOEdUSmhxUjJjbllIMlV3ZEtaVWQ5eGQ0TlNuUjVxVUFC?=
 =?utf-8?B?eHNBMm16RGNFVHoxbHJWQ2c5N04rWTlBQ05WODNEZUJjcHI5WWRZZzA4dWxs?=
 =?utf-8?B?dVRSMmxnakR4enQ4YUZqR2hjVm92ZTdjTzVmRTR4SGtweHlPSVB0YXZqSWRD?=
 =?utf-8?Q?epZmov4/+a8G4sYDZpteKgThA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f610fa-1358-4e81-1253-08db68cec55c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:49:08.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8qSPX7nnUN6TjecXfDZX4TN5g+eo5sm3fCDn14qkXKa8qgp9o6eAj+qgofQ8qSPtnasDHNxNwMCWhNbIzdUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7770
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 16:12, David Howells wrote:
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>> * Back on the first task, function construct_alloc_key() first runs
>>   __key_link_begin() to determine an assoc_array_edit operation to
>>   insert a new key. Index keys in the array are compared exactly as-is,
>>   using keyring_compare_object(). The operation finds that "abcdef" is
>>   not yet present in the destination keyring.
> 
> Good catch, but I think it's probably the wrong solution.
> 
> keyring_compare_object() needs to use the ->cmp() function from the key type.
> 
> It's not just request_key() that might have a problem, but also key_link().

The way I view the current design is that it kind of consists of two
layers. Lower-level functions key_create(), key_link(), key_move(), etc.
are built directly on top of assoc_array, use the exact comparison and
benefit from the assoc_array speed.

Higher-level function request_key() then provides a callout
functionality and offers an option to do approximate search if a needed
key is already present. This gives a trade-off to potentially reduce
a number of callouts but on the other hand requires a linear search over
the underlying keyrings/assoc_arrays.

The patch tries to only provide a point fix where the request-key logic
in construct_alloc_key() wrongly interacted with the approximate
matching option. If my understanding of the current design is correct
then I think key_link() shouldn't require any change in this regard.

Just wanted to add this point, I can't really comment on whether the
whole thing should be designed differently in the first place.

Thanks,
Petr
