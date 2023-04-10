Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA66DC33E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 07:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjDJFDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 01:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 01:03:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC321BEC;
        Sun,  9 Apr 2023 22:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2liaYebFm6ukQ94AjNAZy/UnRWT1Xj2AKOXdskziN2JLHvyHvD7LYgUH0v4N0HT2+9UjGOumS2TaJE9f1KdwQtxYkqbb97ipBZKhcQxMfQivyurlYFQx7aVvFaWazVPoaqUSTfSjdkOH6STkYEwMPorh3Up4SoC6QwgLn/AHYSkoy8JTXzcVqQktDGpORCLqou48Xcb99/BwXzXeclC6xUkQDoRlkAWRPrJNKPn8ZaJwpOdV4fGXeid+dnD/rUozkcl+QCr+RP4upyIHZ7GVO4j6mLmouS92j4UA/OcbePacJDBRg/Mk20L0Pgjhs5ozyyDq7a1PUzRcQzJfkCmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgB99kyUY0SU65X7+hXWL9ynZie+01jJhUGw/jwcwho=;
 b=CENkaODZw5KsQNppZPsURgE0efqNLK1glKEQokTtGHxP5n4esYH9RaEi9MzRmsTBNiY7Xzes7rFklHxNCOK7K1vo5GwOOTj1Ah+rjelcknbTfZspChlmyjbaL399o5POj/Uud90daB2G+qwnj9TQkoYlxYDH2bEMSGBcce95Ub1M/Nb+XZw/KHduMJofs4SH+74zdXB+xi7mO+5srDc51F999qTWEPuZCR7yfGshcpvgJ3vx5juyHYtUmJjUT4jJtx44ctblOHRQtKzWev0t6fagoV27XAMG0rrgnt72BSnjbIfguB93u4UtEYldtvT6EQBEavh6e3WJdGsVbG63Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgB99kyUY0SU65X7+hXWL9ynZie+01jJhUGw/jwcwho=;
 b=3pMhCUxtzoT09g4VNM2teo49NLpN1j+f6CQIpMf8SHnmL9JXBdrLJaGDp91BQi05sxAHmXNjqGrzJYb0dc065m+Kc8zWgby2RZhUGSn7v//cPOM+Gg36KFpJXaMAY7IGqn1/6OpsiwVGfGm8+929Y7rHs0O2yZgvhBr874EWSCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6420.namprd12.prod.outlook.com (2603:10b6:510:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 05:03:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 05:03:34 +0000
Message-ID: <d1d39179-33a0-d35b-7593-e0a02aa3b10a@amd.com>
Date:   Mon, 10 Apr 2023 00:03:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] pinctrl: amd: Disable and mask interrupts on resume
To:     =?UTF-8?Q?Kornel_Dul=c4=99ba?= <korneld@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        upstream@semihalf.com, rad@semihalf.com, mattedavis@google.com
References: <20230320093259.845178-1-korneld@chromium.org>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230320093259.845178-1-korneld@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0975.namprd03.prod.outlook.com
 (2603:10b6:408:109::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 761c18a7-e979-4d41-1a96-08db3980ef9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnYzIB3JE7SDb6HW3FrhLVMkp7JgfElsrBMxiKjGm4N47B5qkD3MJGJ9hJLki8PZwh2EO5d9F8hM4HXRW7r9d/JkheNvsE+f8YotM9Jeq0lCUvcsXOiHU9cY16e96nTH+KEfvOZEeSh+zgK32RAErCqCkm6vUQ2QFOHTNVc1x4jLHuRJbZZ1af/JeR7CGzhZDHrBYgZavyQJ/1+aqFGhfyyVb8S5pxKKjld/U2tjqnW6b1LvihUtrG3BE3Cl/n5vNTEC6DdU9cwPBfGf4SExK+zjedb7kYImbCqKkVSG1MGiHK0YOF7KQWPDBBWHOu96di98TpsBQTr/ioDYtzFQRfWWbf+ENYFZkRu7/MFPbHLgvVvizehAiZKQjB0BAwxycL99saof82TG6llWCQQaRCzSh+C3I2agn7cWM6IAqrqq8RHRxSEsg0U1EqQwCAkYBxeuc/s1el4kl1TqMxRsrPkt+kZmNQUITwVf6jtIlN/AB1eFgOhIxCAciUYd/NLTiiBWKXn819H3vKFbqt06BZNUuiwGYca3Vfp0QIvqybA33IEcp2rphN1r1Tee7lKPQTp7WKDhABOhpTDJufJ3j8S2hv1l0GN/zSLyY9PgHgk4UaJLu0a2vljat4zhYPSwo2RdHq+ZaAfPAPw7Dc9Cdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(316002)(478600001)(54906003)(36756003)(66556008)(8676002)(41300700001)(66476007)(44832011)(4326008)(8936002)(2616005)(31696002)(6486002)(966005)(86362001)(2906002)(5660300002)(66946007)(186003)(6666004)(53546011)(66574015)(83380400001)(38100700002)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1poR0pJYUx0WHloZDdGYXkvZXd2V0FpOEcwM1BEeFRMSjZwaitzUGxqeWM4?=
 =?utf-8?B?TXNTdDlUMVA3QWk3SVlyRDNUKzgrOWhWRUp2d2NrbTh2N3NMQVZTbms4Nlc2?=
 =?utf-8?B?WSt1Rm00U1licHQ4aGhnN0N5cGIxazNreWFhNXdocTVsTGxkenJpZjMzQWFQ?=
 =?utf-8?B?VSsveEdIbnBiTEhDQ2c5K2JFalZ0bFlXc1M0SGtBQXBlYVJpL0FnMjZ1NEJL?=
 =?utf-8?B?UnFKQnhVS2IybHFMYlgzYjFYTEQzRnF1cVRlUFhBc0NzY0czL3Z5NGNONlUw?=
 =?utf-8?B?bng5MklyczZDVThudzJYYzFvT0E5bDBGSGhrRmFxdWNRTXI1OHBJR0g3blhk?=
 =?utf-8?B?djMrN25FZlRZNGcxWFdZbyt6clVFaDFwdmtUMENmbzBYNFlGSit2U01ORFp1?=
 =?utf-8?B?TE8yWFVoTnROdFJGNTBIUjF2czhZQXJLR0ZpOUo3UG54WUVBYlVzRXhydEFh?=
 =?utf-8?B?RnY1eHFjSjVFT0MwV3YzV0JiK2djUFhvK2ZqcmFndzd0cnJRRnhBbFBYbVB3?=
 =?utf-8?B?dHY4eitoOHMzNmNxY3pkYlVqQUxlM3g2U0kxem1GYkVVZUd5Yno0dVMxOHZn?=
 =?utf-8?B?NjlLSUVrcWlVZ0V0bElCTTVGVWkwZjZNaDJFRHJPOFR0SGw0ekhOQ214V1pL?=
 =?utf-8?B?Z0U0RGlTVFNoY2xkTVNHRVVoYm10bGFhZFlzWG04K0RmNnN0MEV3K1FxZUVB?=
 =?utf-8?B?VGVlNTBGVjdZcGg1RUNnN1Y5QmJDU1dkOFhUb1kwQzFNQmVpTUJ0RExOUGZT?=
 =?utf-8?B?NkV2TmNCTFptUUtvTmxvK2c1ZVp4N1hPYUZ5NUNrVC9PTndveWJPUjJwRHVN?=
 =?utf-8?B?K2h1TjVVWXM2Yk1SQnJjTVdVa2VrZW1yb00rR3hraHJqSkFsT01yTzF4Z3FF?=
 =?utf-8?B?ZExINUFsa2QzZ0hleFdwNmhtNHVLekFqUlNQRUljTlRqZWVvZTM5K2xJdklt?=
 =?utf-8?B?ejJ2UndhWFlML1cwWGpiZnFmQTEwejlsajA2WUdXeTN1MjcxNkU5dmtORGhL?=
 =?utf-8?B?YzdvQTRSakZ4Z05HUisyY0Jnb05BMWg5ODB1Rnc4bHRvRlVWR0VnTFZwOVhm?=
 =?utf-8?B?MTlvdVUvTVcwY214ZXZ6empTd2Y4VG1QTDhsZVZycU5iQUVSKzQyR1Y4TExp?=
 =?utf-8?B?ajNaWjd6NGtGNEVLdnJHaUgxMEZKL0t5Mm1NMmZ3dWZwZWdJUTc5QmlrbU1W?=
 =?utf-8?B?eXBZQWU2QnJ1QjJkK3ljSmdwMm95cmd3UW01MU5naC9jSnA0d0ZmRjlaU2xC?=
 =?utf-8?B?ZGM2alE1TDVQaWUwU28ydmZPUlRiSEFmZ2JoTEtrdStRMSszTjQ3Mlkrd3V6?=
 =?utf-8?B?ZXFtR3RYRDA5V3g0YW5rc0hLV0lmaVY1QmpUcUdVa2F6RUU5aXhLcmp0YVN0?=
 =?utf-8?B?VlZXQlEyMWN5VndWNXNiNFprbkQ1N2ZPZWhFMVZFL1pNbkNSS1lSblBRR3U0?=
 =?utf-8?B?LzlNeDFHVEJTRE9tQW5RYlZ6ZDgydis1OGdrbytiMjNkQkNyemRoaWhsZGF0?=
 =?utf-8?B?a3ZKR0VQejZaa0thYVBnOE1YQWZQS3RLKzlsSFBpSFAycktSUHd3blBncFIz?=
 =?utf-8?B?VFBxT01jbnlOVHE0OTc5UWovUlJSYkd3ZXRlNTdPVk5QUFN2cGZoK3FrY0s5?=
 =?utf-8?B?TXBGYXlYalRob2FDdDAxN0tJRXk1UjVrcVBobGRidlVEdzdoSGl3Zm9nTWFO?=
 =?utf-8?B?Q2VKeEl4ZU1PQ0krb2lGMStrTVAxc2JOTTJzTDRzQUh5ZE93OHM1RG1RTDdI?=
 =?utf-8?B?TlRpejhYeDFkamZwQ3dremJqQldROEVKMzg0OVdzdFBOZVNybUpDWENmdGlY?=
 =?utf-8?B?eVBJYlVLays0am1vaXgwU1JnSlRnRkpIOFRlaWJUc2NSWk5hK015RVpreU9z?=
 =?utf-8?B?ZXNlVVFuVVcxelZ4YWtmV0JSZC9SYUx5TW1ONC9TcDA1QXh5czdLL09GQTdO?=
 =?utf-8?B?OHVsdEttdTB2MFlhamFUc2E4dWl4UFE1Tk50V05VY2orVytadWFMc0wzUkRj?=
 =?utf-8?B?bnFPOUR0cFVFR0NMeXZjT2RqTkNCcG8yWm54elZibmVDcVRZcksveDdIQnFN?=
 =?utf-8?B?Lzc5b0ZHYTdYa0R6Yk81VnBlKytWeWZFQXhFZmJZWmEvZHdnQm81MG1Vb3VC?=
 =?utf-8?B?ZS9LT2NDY3g3eDRnU3RGQlFQVnJJeUFKdDFuL21jSThoelVSVFVmYm81QktP?=
 =?utf-8?Q?uC6t1ySfzmVh8dwfbIdRmcBtJEvPsots6mLgBXnK897A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 761c18a7-e979-4d41-1a96-08db3980ef9a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 05:03:34.3821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atqqSDlOxQsFOaO1NyudtrBoqMa/iHzi1I1AuZD7w2tmqFJ1xQW9p/Qk4QspAc0KXMJhAgeoUdnNTRykp7hhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6420
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 04:32, Kornel Dulęba wrote:

> This fixes a similar problem to the one observed in:
> commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe").
>
> On some systems, during suspend/resume cycle firmware leaves
> an interrupt enabled on a pin that is not used by the kernel.
> This confuses the AMD pinctrl driver and causes spurious interrupts.
>
> The driver already has logic to detect if a pin is used by the kernel.
> Leverage it to re-initialize interrupt fields of a pin only if it's not
> used by us.
>
> Signed-off-by: Kornel Dulęba <korneld@chromium.org>
> ---
>   drivers/pinctrl/pinctrl-amd.c | 36 +++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 9236a132c7ba..609821b756c2 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -872,32 +872,34 @@ static const struct pinconf_ops amd_pinconf_ops = {
>   	.pin_config_group_set = amd_pinconf_group_set,
>   };
>   
> -static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
> +static void amd_gpio_irq_init_pin(struct amd_gpio *gpio_dev, int pin)
>   {
> -	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
> +	const struct pin_desc *pd;
>   	unsigned long flags;
>   	u32 pin_reg, mask;
> -	int i;
>   
>   	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3) |
>   		BIT(INTERRUPT_MASK_OFF) | BIT(INTERRUPT_ENABLE_OFF) |
>   		BIT(WAKE_CNTRL_OFF_S4);
>   
> -	for (i = 0; i < desc->npins; i++) {
> -		int pin = desc->pins[i].number;
> -		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
> -
> -		if (!pd)
> -			continue;
> +	pd = pin_desc_get(gpio_dev->pctrl, pin);
> +	if (!pd)
> +		return;
>   
> -		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> +	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
> +	pin_reg = readl(gpio_dev->base + pin * 4);
> +	pin_reg &= ~mask;
> +	writel(pin_reg, gpio_dev->base + pin * 4);
> +	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> +}
>   
> -		pin_reg = readl(gpio_dev->base + i * 4);
> -		pin_reg &= ~mask;
> -		writel(pin_reg, gpio_dev->base + i * 4);
> +static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
> +{
> +	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
> +	int i;
>   
> -		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
> -	}
> +	for (i = 0; i < desc->npins; i++)
> +		amd_gpio_irq_init_pin(gpio_dev, i);
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> @@ -950,8 +952,10 @@ static int amd_gpio_resume(struct device *dev)
>   	for (i = 0; i < desc->npins; i++) {
>   		int pin = desc->pins[i].number;
>   
> -		if (!amd_gpio_should_save(gpio_dev, pin))
> +		if (!amd_gpio_should_save(gpio_dev, pin)) {
> +			amd_gpio_irq_init_pin(gpio_dev, pin);
>   			continue;
> +		}
>   
>   		raw_spin_lock_irqsave(&gpio_dev->lock, flags);
>   		gpio_dev->saved_regs[i] |= readl(gpio_dev->base + pin * 4) & PIN_IRQ_PENDING;

Hello Kornel,

I've found that this commit which was included in 6.3-rc5 is causing a 
regression waking up from lid on a Lenovo Z13.

Reverting it on top of 6.3-rc6 resolves the problem.

I've collected what I can into this bug report:

https://bugzilla.kernel.org/show_bug.cgi?id=217315

Linus Walleij,

It looks like this was CC to stable.  If we can't get a quick solution 
we might want to pull this from stable.

Thanks,

