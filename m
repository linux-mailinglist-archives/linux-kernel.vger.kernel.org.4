Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA2649BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiLLKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiLLKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:19:07 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8D564F0;
        Mon, 12 Dec 2022 02:19:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En/j7J772sctxNBURR4qOD9UNgcU1e712eXKzH1kfdQ+dHsTxNt+vWe0RB3u8Fjh57Rrjqm37EnF6N9uFMeP4I8ODisAMTTLXe5/420PCQlEw/GbcO9Egc4zdEWDa4GffZ5db7iQAZwKLFevlJWu71erDo0tFZQEEmC1whFX6clJ29276IG6RvZnhw8hMY3HR3v1QfS5vFEIPsf3r7Ee4Hwijup0SoZzUMmX3pz2+23IGb2xVbUzFzCCdnGHSqp9R9Mhy3TJgha2Pf5nbIOtutDPe60Dw7qh0+2AcGC/bVoTAKAClRRKFLlTdSlf3AGBI/siEVWojgFYlq+WL6XfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQgBKud95WNzFsppl4nS1XYbf+6cTkEEmk1Jp6uyU/U=;
 b=lTE9HxyxJtxepKzc8sMHN+SbWKqv/SAvsUMfk3D+JErW1UkOl0YIa/E6uEaKDUIpdH3smi5opYm6EL/DBM2v33tjYTsVuB82o6blEc58uNT6ZdaWiB8461+b7f62lUpDW7ae1Rju/XXuy0YnhE+j4KOQQpQwkTmiWYMWbM4QHR7cjhhaGXbj8q4RmQTKwyeQ7KCc+QCEpN/3QDymgztS8w+9T8ZbxygioSP+iXwRugSLEL0CQh12eOKw7df8euGx3MPVVkX2RSz4JTHX4Yy6IuloA001Z8YaV86uL9tM+GbT0kHOKELp5XIJHcYo410wcKR75u+TFR6L2sbq2PZznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQgBKud95WNzFsppl4nS1XYbf+6cTkEEmk1Jp6uyU/U=;
 b=RGkc17IDaeZzb9ttKX1FR+uTfxpUKRjas1bV3SNxxTgxk2nT8PkaTDqR8WCjF7OGrYSyl2OeTxRdz6jtHIuEKtfKjuZlENd6sBCej6T9kxp3HaVt4+uSQEuCURNm35TD7BS9RvYktszbXKj2SCVyM1LUGd9IHkofJbEr9caivHaSeyqojnJDZBbzhsATlm6gvW4QFaJ3OYiGnk6Yd8eeZP53lc4DVVDMN50zxY02+GZ5hyjXbPU+hADjBpQzGzSdzfidGuSSKChTaGdbp3bfYJdgs7Vi9uW9fxHNivzQtIfLR1GVDJpQ9z5MqNZsL9h5yq77t6ll9vjBX43EKx9SZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 10:19:03 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::ae59:a542:9cbc:5b3%9]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 10:19:02 +0000
Message-ID: <efca6b26-fb20-ae38-0fc4-8612f1ee150b@suse.com>
Date:   Mon, 12 Dec 2022 11:19:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] USB: drop misleading usb_set_intfdata() kernel doc
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221211120626.12210-1-johan@kernel.org>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20221211120626.12210-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::20) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bdff9f-2a83-4b5b-e8a5-08dadc2a4aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hU9ZDnIdIyetgCJW6JI3HB4azQIAbbOt7JlgRmYhbpNNIN+7dMave+SdXffcP+XUuscZouhNabr5w3gXDNthAV2XvnLys16BNuePzJvPNsT60PJOAxkhivUxQTWgnQ+z5L97oz88HK4ftbQwGRVH7K5+tZfQtXtuUxXffc4f71elgMDv++vW0R8xBsq0djXruhYglb+WZYLUkQVZgbvWEQIWoML/C7KzTy2oppWJvMP6N2YfTKHsmJCvXP/iWyembGTd9qWeudupjakvcZonGFPT/XNklTqjUQ1Liejd+7McubVvOMA51yrdIvt1fCr6c/YcE0xZ0zHbgWJEEzFTvVuouf4dAPwsU3EUJf3Lpd4NPob/2zV601Yv2cmrNBvygbbcy5jP4N15yAhP1VNdFqvWwkMAlkyY+N0rW1ExaPUQJVBJHYYOZSsv8MUekIIHaZEPFTj1JFQaE8csrSynCnIomiBWNKukgFjApsnFbI6rjNvU96Gdl9ZkIIuVRxeRdSVD3xmqPKn7KfHxh4ZjXYiKzxeWeGB5XwgH2T5cpLg/yIntuRkn6S0i5nSOwE71NzICNfZcjdPHToLqUI2cEe0DNoJ1fcHnuFOQD7QF/WRZYcaFBCwOymg45QXYuOnl+UN5koU/UHpoXvtFdD79BhZUNGtPRM2S97tDRTPe2taY1zG5VG6WqU8rYM/I4OMkHCLT3vUUb7lBYkmeLMQXf7i0S3/3Vi6TOM9HKliKtR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39850400004)(346002)(396003)(376002)(136003)(451199015)(41300700001)(66476007)(4326008)(8676002)(66946007)(66556008)(316002)(8936002)(5660300002)(53546011)(86362001)(36756003)(38100700002)(6486002)(2616005)(83380400001)(478600001)(6506007)(186003)(31696002)(6512007)(110136005)(31686004)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxhYmtiMUptK2hSMlM3c3FvUjZFOFZHK2Y1bWpmOUVIb0o1ZGk0VVQwc3A5?=
 =?utf-8?B?dTVzdnNZbm1EaFcxZEM0dUVIbWkzT3FuZ3Zhc0Eza29MMHZ3aHprdG04djVl?=
 =?utf-8?B?MzhoSEZWaUU3Z1ovdFg3ai8yWEQ4SmVLY2VUZFdNTVdZZDd1V1hjT0JUVE56?=
 =?utf-8?B?RGlXbVV3ZDdQdDNoaFk1OTVYNHhadjl5TnRsd2kzOE9Hd2hFYjRuV3RGSkM3?=
 =?utf-8?B?OTd4Q01ma05kYktMbzNLYlhKMnphaEZWS2dweU1TRTZzWEk1RHNoTENTRS8x?=
 =?utf-8?B?UHJWT3R1VmtFMTZULzBqL3JDQlVhamJzS0FGcGcrdUsvQ29KODBBMnJIbmU4?=
 =?utf-8?B?bEtqWmkzeDJlWldtUUx1emZ5Z0NleTRMUjFSTGZwNzhXMEFQUnpDS3hteVVy?=
 =?utf-8?B?VGlabktlV1RrcXdhK2gzWjRyR1dVd1dhTnBhK0xscXRYSXNsaXNJRGx3Umt5?=
 =?utf-8?B?Y3piU3NRRDhyS0ljMDdJV0JDNjJENXljVjJSZktvbWxnU0tNUWdyV2UvOXZK?=
 =?utf-8?B?Ty9jMGUyY2pWWmp2R0ZwaVp5NU4wRno3SVhWclBuY1JTTnYvL0JuYmRGVnRM?=
 =?utf-8?B?VXNOOE5BeVFBY29TTkxRbzRCbytPYUVIZFZoSWZXK3E3NEhLa3pNUUp1SUZh?=
 =?utf-8?B?b21YM1YzVDJwVG9oRHh1U2x3R2JMNXNWNm8xWEdZbVk0MUw3ZjVmejFINkIw?=
 =?utf-8?B?MGlmOHZ3NnRQdjJLM01mOWhLYTFLN0hSZk1nYi93aUx6aEIxUHhxN0t2Q1Yy?=
 =?utf-8?B?cURaM3dHZ2ZmSGxuUVdLYTBzakczandSS0lBclN1T0dqczV2eVowQU1ubFJR?=
 =?utf-8?B?OUdBbjROd1dSOEJMd0xnQVRtaHc0MG5PWW1pOWJXMzJxZUZXUVEydzlXYWNU?=
 =?utf-8?B?K3lQeVZQRUE5UWV2YmJuQnk1aGcrSTI0d0NQZUIzSHpFR1o2b25TbUpOWndp?=
 =?utf-8?B?NWU1ZGJWSmZyNU5jM0VtZ0ZOL2E5VkkyMWZLSmsvTGUrakhTaERrbDN6c1p1?=
 =?utf-8?B?ckNuUXpYL2RTVlBjZTE2dzUzVkd6T2hQQjl0NFhvZHVoVmVwbUMyeUY0RUNl?=
 =?utf-8?B?ZVVOSFFtZjlLT0dQOEdleVczaTRLdnpQRW4xMXpPdFIrZ3lIYmhYYlVaUmF5?=
 =?utf-8?B?MkxtVzNUdVpVNXFqb3I4dytiVDMwdUkyRmVkZURyY29vVlNodFJEeDY3N3N6?=
 =?utf-8?B?QVIyb0VGdUM3eExlNEtuS1FHTHNXdjBqK3ZSZDBKMExrQ2RsN1drZ0NJQUhD?=
 =?utf-8?B?Mm1ySzFlTGV1NWgyWnVVMWlUdmtsY09TbUZLT09lWHZDVk1Mc1huSVcvdGV3?=
 =?utf-8?B?OEZWZmMzNWdXUGt4Z0sreFZhNUR4cHZYdWZDU1IwYUdqTkZzdms0ZjhVL1pR?=
 =?utf-8?B?cXVVbEovM0grUGJLWVlORXRXcTM0QWs3eGtyS1ZYckhreFF1N1ZyL2dHZFFk?=
 =?utf-8?B?M01na1k5Ri9aOEd0WHRiVUdDSHA4b2gySkI1cWhERmJEbjhiNVdCdmI5WkJq?=
 =?utf-8?B?bzVIeEVySEVFTGFLMzlCbEVFbkdSeFBIS2o4UmJvY0d3RUgwN1NYVTFaMzQv?=
 =?utf-8?B?ZTl2M1kwMGFIRVJoRC93Yko0a2hVNklxUi9RMjZNQ1RyalBCaHZCUUhJTTlt?=
 =?utf-8?B?eUNCS3N4SHhuWlZOLzh2Q2FKenllM0JVMC82QUFYVzVOOEVSbFV1WUZIV0ZY?=
 =?utf-8?B?dGNkcThyRzVtTWE4NWxnc3dTWXg2R3pmNURUR2xoUURudGF0NnNGMFVRNjdF?=
 =?utf-8?B?WUxzaTdzUzIzZkVUVXQ2ZHlKOE43MS9PNzBzY1lHUlpUOVRLREJkUzVTS0Nt?=
 =?utf-8?B?MzhhekZwcDRYSUttVHlvdWVBakFOZTM3dU1SRzJQVXMyeWRPbmtYVUExbzVq?=
 =?utf-8?B?UGpMVHVoanI5MlhOdzlmVllwVHhmendXQklqcUJObm1kK3NyRXQ0b1B5L3JX?=
 =?utf-8?B?djhDclBJYitQOThDc2RPNXlwYU9DYm9maThpbmV4REtWZUVRS0s3V3NhSFNn?=
 =?utf-8?B?ZzcwNVV0MldBVCtoajROclMxT0ljemlwQk81MDFobzloVk5KUDNUdkZ4Z0Vm?=
 =?utf-8?B?eXJVbng5Um5NTm81Zmx0QkRhRGdMQ3hSNUZ0MFVSTmtUSFZZWDloV04rMVRl?=
 =?utf-8?B?Mi9BWEliQUZLRGNSL3NtN2VHNFdNU1RuQjZNU2NjUXFKNWRYejkvcXkwM1p1?=
 =?utf-8?Q?XlmhNOJX7iKn8CEyC+7wqJTbn6AioGgdQDS14CTuvv2s?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bdff9f-2a83-4b5b-e8a5-08dadc2a4aaf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 10:19:02.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmVQhseMu6LL9JelfKeYyMFQ8FGl+dkFhQBri8c6jW4fG39+VbmjbfUu0pUNL0OaPxOwU/xYCge3OVG89ezw/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.12.22 13:06, Johan Hovold wrote:

> Due to a misunderstanding, a redundant and misleading kernel doc comment
> for usb_set_intfdata() was recently added which claimed that the driver
> data pointer must not be cleared during disconnect before "all actions
> [are] completed", which is both imprecise and incorrect.

OK, but is that a reason to remove all kerneldoc? Kerneldoc is generally
a good thing. And if a pointer is NULLed by driver core, that will need
to be in it. IMHO you'd better just remove the questionable part of the
kerneldoc.

	Regards
		Oliver

