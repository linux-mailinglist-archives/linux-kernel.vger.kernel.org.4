Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2806DDCD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDKNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDKNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:51:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A16E48;
        Tue, 11 Apr 2023 06:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDgfm7v0YRqXg7gL+zjirV7Ftad+Ji53Nq7bMGHB48nL5Wwa1ihFLhcX/J+gl+LFuGdCU4MuGpH4/B22OX4nYGHFLMImDT1kDZhbR6GDh2w2bYwmwBCIHe9htq2OvKpFgBmPG+Fm2orcafIgUMHL8BHcXozW3J2sfZuqFTtxqE/hZjU13HnGWQ3LX4PZ0sV7JCd/DyYAiQHhz+Oj67vfHsickFPuhegCc+2bxogMOUu8ViHRhNxEBWZegFhz04/e6rBmeJs3XhNxuqWVcC5RPCbsR7gLIqAgSGg+ItyB0DA6l5l9RyV9dynRZEpPnsbYfnt2awrhFMxkKR430H03og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i5GCRTiwP3P9a2TuBnn2GpHo6CyK2fHmM26SbiZf40=;
 b=BDeTT95Ct5hDm1gSbEIIZopeyYoBlj/rQ/EMyjK/us1+sKWC3wDIlenu21gMrOgmlejtppnba9MkbmRoKLmP7luJkK1qDCyGWT6tFDjREQPo6K+kOWTJ302Rt1WufGFoZN2h7O9CD3BszUjcEthr0NPB3X24k/SjXy2Q52ZIs7ltFsHVVzUPYFhl45QF05q4bQHDqbA52DDyfTv+ZU3H50P0H4Tn8HGH1De6rGRzRGDAmTBzcVFaQr1Uy19TIcjwcwfoIWlMpKGU0YpVcCAVtFuLjsR2CJVdHOzE0/W6aL0yruXKxhio2Ibt3pF9FBYLVK43qK91CULURKtzuXncLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i5GCRTiwP3P9a2TuBnn2GpHo6CyK2fHmM26SbiZf40=;
 b=owEiCeVRciqp2QKHHt+TGoxqKJHtk/aNqpVXgSZ4F5bfd1fVPwtjDWWcR9+cqMUFyniTpRrFKkZ78WxI1nNlD7psZgErJjPH7jRnOX+L/+RmKDEo6CUQFeyK+OSXPjl8Z9/7DyvlD4JQCwIGmSRppbQ98N48nvDoAV8tLCz64UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 13:51:45 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 13:51:45 +0000
Message-ID: <9e1e536c-9ca9-f9ce-8c1e-946c91214e37@amd.com>
Date:   Tue, 11 Apr 2023 08:51:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] Revert "pinctrl: amd: Disable and mask interrupts on
 resume"
To:     =?UTF-8?Q?Kornel_Dul=c4=99ba?= <korneld@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com,
        Gong Richard <richard.gong@amd.com>
References: <20230411134932.292287-1-korneld@chromium.org>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230411134932.292287-1-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:610:60::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b4da8c-bd3c-409c-e2ad-08db3a93e322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PRHRB6ofrFn27gs+p+hJ8tCpP5j4MmW2rybpVbyOF0WBOLZRBuYM3606RTJMAC0kBj9p2Acl4Sq2+Td/eywCU0KcHU83eRV2Au8Wxa/UkgfkwXpk3nN0QhL5Hbj7kbbQTkyGlZyRxBJjjy1Izw7HIwEr8V4E33qUbS/gYzZ+nb5rBSkJgvcLXSc5AehTq81lXujvERME3vhAeDG+BqQoWWzQDaQQCmTm3a8Fw/PBySTDCNdB3/yPW0Awvc+ceWhTh755mQP2buc9GWSPgZ8DF/1RESCSAf5m8SK5DEDZjbJV4Ad3MDV3D1oP0YOBWBUqBLoqg3tMnRNO0J5WV0TJEVUbtzeEOH0eFGbo0Xtxw+5d/RywLjNJzd4HauqdiNLslsU84JQtorc/gYwR3QenimAF0C4SMRPPbyNF667uT+wfHoXby2mPjDyhV4Wh9ha6ZEMhOmYSo0LhyTXX1nG54zlEcbR3+s9ywVdKwWc+K5xPn4LP0Tom0EzsW4SWfPxqsQO8YVgjdlkXfA+R5U0hcJ8gecLHKctRo9r3LESCe4NRkhH5JNmupeWV1XiFi9kLRjI5FwI2EqjEAm+lUMEVJOtOL8tmkVjkR/nL3K4caxaeysRQoL4cooaoqMKT8n0wP2Rm8Jb1n4UFyhrBX0zItg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(31686004)(4326008)(6486002)(66556008)(66946007)(66476007)(8676002)(966005)(41300700001)(316002)(83380400001)(478600001)(36756003)(54906003)(86362001)(31696002)(2616005)(6506007)(26005)(6512007)(53546011)(66574015)(2906002)(8936002)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHlSSGRZTlpqWVNrMXBWdjFvNlRrSkwvRVNpcUVjODEzWWw5a1lWdExKSjBK?=
 =?utf-8?B?S1hPc0Vyd1JER3FTc1FKTVIxbVZBVFBlRm1rbkFQaHhyVGd4a3pibHhObW8v?=
 =?utf-8?B?eTJ2MXBFR3BIL1VUTHB5VHpnNy9RN01ESnRJeUFhaEtMa0szTUdFUUtZYkRW?=
 =?utf-8?B?L0lSaUF6bnFYZnYzQ2xnYkhyMXZ6Z2M4TVhLZ0haZVRUMWNoajBMWFdTeXIy?=
 =?utf-8?B?cFdPd3Y2TGVzbVFWTE9mUU56anZ1b1RLWHlweTQ4REJEME1qYXg5b0F0cHFV?=
 =?utf-8?B?bUxMaHBQU2ZUUk9yeWE4T0crUGF1ek8xZy93NFlRL1FiRmo5K3o1c1p2S3pF?=
 =?utf-8?B?Si8zbXR6ZU9EK0g2Tm04S25lNjF2amtyNDQzam93bEVEWS9JeFNTN0hzRUhy?=
 =?utf-8?B?enlDVTk3N0dsMW8vK0dKTWdSdVNkNTJaeFRadzZaa2F5Y1F3NGtiVjdlN1NQ?=
 =?utf-8?B?UXI1NW5tL2FCNVNjeHpaU3AxQmdqYitEa1hSTWNYTHhIUlo0MWkxMFdnemN0?=
 =?utf-8?B?bU1wOXIvL0RWZkdsM1RDL0hhT3RRU3p6TUxOd3o3cEw4OTJoQmpaVnZDUC8w?=
 =?utf-8?B?aGJSSVgyY2N4cUFGaE5OTDdPWElZbHNjOFcwS1ZQSGpIR2dWYlhCM0p0eWpP?=
 =?utf-8?B?Yjd2L2NDamVKYWYrYnRtZzV0OG9nbnN6ekUxQUVjbkk1SVJrN1dyeXI1Y3pm?=
 =?utf-8?B?YkNUOGRNd3dNRmpvOWJpd00xME80OVN1RE02UEV1ZVdmNGtKY1c0NlpjbGxN?=
 =?utf-8?B?U2ZhUVF0SmNLV2hBUVhCRHY5SlgwbThmTlVCdEpuRFVTSTNCUmc1K2p5U3FH?=
 =?utf-8?B?NjRaZzM5S1VKSllWcnVKTmhMWCtPUUlKc3ZsT0JxcllaZHpwVEtsU0loS1dE?=
 =?utf-8?B?WW84bzBWSUQvMFNwQW9YR2twL0s3WCt2STh3cXl0ZWdPMEVRNWRLUnFrZTJW?=
 =?utf-8?B?ekJ2SGd1VXdjZU5ubHFTaWlEaG41UXNVM2ptZWtaSnNqVkgwMHdWK2dwOW5T?=
 =?utf-8?B?cS81bHpDc0VIUWxPSWphMHVVM3pUYnBnaUdxTEZLejVWd0VobjFnMTFBWXEv?=
 =?utf-8?B?ZlNJZ2IxcTFEakxZc29vbHFya0RTZG9CV2EvM09Mc21YM3oyYWNzd3dqSU9m?=
 =?utf-8?B?NXVmYWFJTGpMSS81SXdzUm96WWZiNENKQWt6QzMxYVBjbzFObGJiMVBaaUh6?=
 =?utf-8?B?QmUzWGhQZXIvekdudDJtek41ODUybmtlTDFWOXFBYXVKR0paU0s1WWRCRzRi?=
 =?utf-8?B?UmFZMzZCdklNdWdUeDhCcEpKcDBxdTJ4VzhJNUtzTll5SnZRSGkvZVhvR0Zn?=
 =?utf-8?B?cmh1NUdUR3JKdW1OTXlvSWRKOHU1alZvVFRUSHc2ZExmWG9RS0xJVGp1M2hZ?=
 =?utf-8?B?dUVTL2E4c0o3aDY0VEl2YllEQWdteFEyeEVRUnRyOExuVEQ1czFFcjlVdzJJ?=
 =?utf-8?B?Tk5TcWFxYXdyUTJmZzgwTmdzaXJZeHBLZDNoQktuZlFCbHFEUlRrWlVudEEv?=
 =?utf-8?B?S29mZ3dJamFmcitmOTZxWHlqRFE1K2F0Q2taZEtybDcweEtTR2ZycXlRYmZ2?=
 =?utf-8?B?VjQ2UXdDT1pvYWVOc1hWT1QzV3JKR1VUc00xNk1yQ2pwMEVnY1JBZU9OTG1s?=
 =?utf-8?B?a2pZV3RibU9MTElHckRHVFVvS0FKWk1pRXBGZ0syK3RDNnVPSzJuKy9kZGpV?=
 =?utf-8?B?NDZwak5wMnpkQThaaVRyY2RlOGFERTIzTTdxTVF6YncwR3A5WTVRUVpwdnBB?=
 =?utf-8?B?UWFwczNIWlFKNUVmblVmZnBTWHRna0o2L3VSYlRuRTl6bFBCZmgyVGZwN2Zs?=
 =?utf-8?B?RXVkM3Q2eVp2SnhxZjRjMGZUMmxMVkpYS2JHZ3h4NHd0UlZsc3ZOMC91VGxr?=
 =?utf-8?B?cHFUa01zVlVsSW5Mei9SMlN5V3JTaVZBa3o5VGdUVWVPWmVIZkprMHh5QUZn?=
 =?utf-8?B?dkdmL1ZWdFFrdExxV0luS0ZDd2xhVWZ5QjY3VTIyUTZtZm56bzRSWFVSVXFE?=
 =?utf-8?B?SWVOc1JXeHpaeEU5ejU2ckxIRHZBZEovS2lmUnA2ejJJakNNVGhXSWhjcnd0?=
 =?utf-8?B?R2hiVEhuT1YvSmZnQ01UMFVPMnNlai9PcVpnN3ZNQXBkaHhEdDUxWm1XQS83?=
 =?utf-8?Q?XsgeFtyBrP51S2Jr7PlJ16gLM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4da8c-bd3c-409c-e2ad-08db3a93e322
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 13:51:45.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUWtsmHLcLsjMEm+/DbxJ7voD+25rRr4yqu0HGG26H81oI9VLuuvhTa7qKdiw1YvQcIc8ZxkVqAcoVLKwdY/vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2023 08:49, Kornel Dulęba wrote:
> This reverts commit b26cd9325be4c1fcd331b77f10acb627c560d4d7.
> 
> This patch introduces a regression on Lenovo Z13, which can't wake
> from the lid with it applied; and some unspecified AMD based Dell
> platforms are unable to wake from hitting the power button
> 
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217315
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org

> ---
>   drivers/pinctrl/pinctrl-amd.c | 36 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 609821b756c2..9236a132c7ba 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -872,34 +872,32 @@ static const struct pinconf_ops amd_pinconf_ops = {
>   	.pin_config_group_set = amd_pinconf_group_set,
>   };
>   
> -static void amd_gpio_irq_init_pin(struct amd_gpio *gpio_dev, int pin)
> +static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
>   {
> -	const struct pin_desc *pd;
> +	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
>   	unsigned long flags;
>   	u32 pin_reg, mask;
> +	int i;
>   
>   	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
>   		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
>   		BIT(WAKE_CNTRL_OFF_S4);
>   
> -	pd = pin_desc_get(gpio_dev->pctrl, pin);
> -	if (!pd)
> -		return;
> +	for (i = 0; i < desc->npins; i++) {
> +		int pin = desc->pins[i].number;
> +		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
>   
> -	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> -	pin_reg = readl(gpio_dev->base + pin * 4);
> -	pin_reg &= ~mask;
> -	writel(pin_reg, gpio_dev->base + pin * 4);
> -	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> -}
> +		if (!pd)
> +			continue;
>   
> -static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
> -{
> -	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
> -	int i;
> +		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
>   
> -	for (i = 0; i < desc->npins; i++)
> -		amd_gpio_irq_init_pin(gpio_dev, i);
> +		pin_reg = readl(gpio_dev->base + i * 4);
> +		pin_reg &= ~mask;
> +		writel(pin_reg, gpio_dev->base + i * 4);
> +
> +		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> +	}
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -952,10 +950,8 @@ static int amd_gpio_resume(struct device *dev)
>   	for (i = 0; i < desc->npins; i++) {
>   		int pin = desc->pins[i].number;
>   
> -		if (!amd_gpio_should_save(gpio_dev, pin)) {
> -			amd_gpio_irq_init_pin(gpio_dev, pin);
> +		if (!amd_gpio_should_save(gpio_dev, pin))
>   			continue;
> -		}
>   
>   		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
>   		gpio_dev->saved_regs[i] |= readl(gpio_dev->base + pin * 4) & PIN_IRQ_PENDING;

