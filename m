Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184574581F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjGCJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjGCJKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:10:38 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25896CE;
        Mon,  3 Jul 2023 02:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWU6cFT0YyPw15SI2AHl5+c7/Ib13RCHXMeuzEgkf6tHC/VPK0OiOZ4YNfH6rYNzlMXD0kD7+8cnZul615Bf1P1mUp6eRCRqZoOlgdJoRUdRfWdi42XEUkYutNmrWaYuD8yG1ugJOAdSLvlNXF6h26+/8v1GbQnpO2n6kNaS+xYkg2SCyEVB8k5+R21CkvWVesddOa2F3y+8K1nW3Vq673cUDHbBmjqma8nB7k6HYw5Rdn72Lxu8uw183Ayl9hyQ5c5HfcuulMd8zIA7PcBEfAgV80mUOvtJ2sbiRUwUicyAD8sEAlOIHZcH3D/J2ckgWluARm2wNi1E2FFbs7RPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kTEICfvZlWArhXQExtpRh1wsCPBwmSLMuFnRrUqvfg=;
 b=TzduVwHledEseTbIy+Eo+223uparBYUtpTjjwHOtCFPM+6qYGK89Fe7F0GGKE8DyMN+zYbq675eHL/Kmz8kFL/MHwOseDznoXhPZvOp7duBiC9Y1FsvKDpQJCkAto1xHedhE0OWrdIDwLHDjRMUWgMoG1Bbjk78Ezt24IVh/45V8+WnpbFcclY+UeLj1A/zK3rK6zQRrNlB3UWaj0GACQqhzPNKoOg/ETMSRDzrLv9oYAloq4G4B9pnNOM3r49tyenu5cXCnFfqEu181NslS6Zh05X2h7LUQsJKnFLPJ8b8OXHfRLO/Jy6NLnMZQlRM+RZCuuFZBTJfCGUubxM8ASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kTEICfvZlWArhXQExtpRh1wsCPBwmSLMuFnRrUqvfg=;
 b=Rk1+SEfYBzbTGHFSo5BIRSffs8f0qAxW7lQXtgDNGIbxaV1oese5AE7dyATqzyyFQ8+YFTecV03TccQNyKxrxXW6fxRftTzYMFAes2EA7duClGwGPmIUY/KOrv6a7ZReoj0UTnGxxvSKbhkVmzAFfW2qfYp28//WFlzo9IZl6AvY4N0av61uc+2xmGOOxD0zK9SkiKIHOVNkBCVb4k1ULObIZNU37SLsbwIdbx7unOjpHytUXSOzmdr7q+UNXG7UwzuI3/PABVS8Gka/7fYGPNkKEQXNuEW7Ezmj6zjRFbyLMroscn/kbLc+23OVTvskOvUFB8EKGMZzafzf8KyqpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4003.apcprd06.prod.outlook.com (2603:1096:820:26::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 09:10:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 09:10:32 +0000
Message-ID: <db14ea3c-c224-e263-e134-70e9acc5008a@vivo.com>
Date:   Mon, 3 Jul 2023 17:10:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/15] genirq/devres: Add error information printing for
 devm_request_threaded_irq()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
 <82dc5efc-35fe-15ff-d0ea-e1a19da71c5c@linaro.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <82dc5efc-35fe-15ff-d0ea-e1a19da71c5c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4003:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1a2b51-0417-45d4-19f5-08db7ba55a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnA23rMGUz1VtpvhOHB0HRLXA4hjj8e7U3BybAuxiRmJO4xC/eQFV8/51RyZkXSkMju6bfHc6sWhEh2ybCfOjRZldBG3KFU34I4vJ6PnuZFkLnESN06eeZRq0xJsYpt0Yfj1jxc7miPwcNL67R0uNc1mxO2Ii8dGvH14eBGJqF7q2r5PpB/1FiL4hLN5asPw2sr5TfJURPF4GOAHYok5kDMyYR4OF85oUUHj+iyyY/EVaXzo/hfoONHZvcL+ypOhU8iO3PpXleV0bki3YJwvYwCLLN+IDhAm6X3d3Cais+/wazWBhGlAtRSCuuNn+9Fe3daFmj/+OXASV3GWf4Oqyje6zpLdQIUEkcDy7gzdG0xmL2Tg704eFLWWkrTpYuiC/1nzxB7jWh7pb9580qKmaR3+Uxgbne2nr7SIm7lPk8YiVDkAcHpcYcGXiYjhaXU22s5Ocq5PrgUGIboYn2uNGNhWR0A76hjXzboBi6XwX/KnqW3wOthFT9K8jpSZeFlZtZFzy2wzc8QmmMerWcrOLcc/j05o9QKfAqGBsRzdynhNjMB5luTAJ6TiQYVTuB7hspC+KhBEbDMEZlovdJYJVdAyfoEfkp4yjrLgBJt85QYHjlZ6aPDjkYKl0jTMb5EVONceHjjGophCE9bscb/a9R+U6oS2+61DoVgdJsuWKf2NKwQIGFCfS1pp6/3FxaNlrXKmPWIKbvVCDMXvCx6Q/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(2906002)(41300700001)(8936002)(5660300002)(8676002)(7416002)(7406005)(36756003)(31696002)(86362001)(186003)(2616005)(31686004)(478600001)(26005)(6506007)(6512007)(6666004)(53546011)(6486002)(52116002)(316002)(66476007)(4326008)(66946007)(66556008)(38100700002)(38350700002)(921005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2I3QXBKM3JvRGVKSzEzODkydlgrYytGais2VCs2a21PdWhoYWVJSEJyZmlC?=
 =?utf-8?B?cTZaNlcwWldGc2tmVEhtMUFPR2JVNUlvQVhhL2l3SlY4TUI5cjJTLzV3aGEr?=
 =?utf-8?B?VktmTzJueFV1Mnd0VmNqemVjcERva0xuS2xsU2l2QkRVUkJSSzcxK2RHZ3lQ?=
 =?utf-8?B?d3hlUzJHbXFOT2xjVE81bUFhUmh4UUdxb0YwZXNhOXYvcTZuMWdjM0xkTzA0?=
 =?utf-8?B?bHhBWHZ3bzJXRnROZ0gxZEp2UG14czdUNmhwa3JSbUtXVnhsckQrU1ZFQUJm?=
 =?utf-8?B?MUI2b0NiMnhhY3FPQVllMDdvSGQ5V0dpM2F3WXFBMGFRcXhJTjVwY1BsU0o4?=
 =?utf-8?B?UkNYV2lRSXl6SVAyNys0S2wrYVJhbHVLNTBSVFhlZGkzRmczQ0ZDUU1KQWZZ?=
 =?utf-8?B?MjNlK01OS1FraVNIelNWUnU5bEFMQUtrT0tRNlhPRGdma3VnVW13eG5SRzV0?=
 =?utf-8?B?QlFoMzB2Z0ZEakNJSlZBUXdKR2F3cXdjc2xONXR4bUVXZVNQZWV2SjdIdm1S?=
 =?utf-8?B?WWxrVkhpaGhXOS9BZ1pRWVZQQ1B2UzRLNnFTaXZBdVJtcUZwMk1NTkYrVHU4?=
 =?utf-8?B?QzVqR3M4TU44eDN2akQ5OFkvV2ZBY1FWTW80d0FiU09iRnNQbUdPUyt6RHhM?=
 =?utf-8?B?cmxSN0oxWERyQS9hM1loZXJFU3pOL2xSLzlWQ2MyRFJ0RGE4TW1GTGVnSVll?=
 =?utf-8?B?emd2WkNMWU5iclVFRzAyZys3UnQwLzJyQmxHblRPVDVyWEhKZ2hBSExPSmVh?=
 =?utf-8?B?aTdzanVJNStGZzlQeWF0ZkZ3MG4xaytCMTZ2cXUyaXUzeDV2SXAzL0NWTFJG?=
 =?utf-8?B?UVRtTmFwYStqVVVDRmdvbmNoYzd2RUNSSnRFMEtFMmRkVytMTTAvTjg5QlNp?=
 =?utf-8?B?Wk9jelBucVh0Z0NKZW51VEZzUlBsaFhrcnQzclllS21xWEdqUlZZTzUzbnpo?=
 =?utf-8?B?TGlWOHZHTjFubHdQK241QnBOZ0hrZVNlOHVXZEJyT1A5RjlwOEVJRFUvT05z?=
 =?utf-8?B?NFdiZkxaZHpNbEZMbWQ5YTUycDFDQXh1ZkoyWkV6akEyQ2Y1TlFIU05ScU1I?=
 =?utf-8?B?RlZQNmF4ZUV5QkRXM0JDOGQxQmRMMjBERnRDVnIrRllKajBlalpBTms3WmpW?=
 =?utf-8?B?VzV6eUxVYmVJVmFtT2o0aWxDT1ZLeU80SlRLZ3ZBOHlXMDBvSE1BbFNBVGxo?=
 =?utf-8?B?c1lYNnBabHRHZTBSWlAyRllUWnUrYnRTRUFOYlVGTGRKWHJwTGJDL3VyOVd3?=
 =?utf-8?B?blF3OW05bE9MZm9XTXdXbmhTeVZJODI5aWZ1aktaaDFiQWhtcXRvcWlRUHJ5?=
 =?utf-8?B?c01aYjNNZGk2RnhWU1FjMFdsVGQ5QXUxLzlFZVdiZHpIcFhhRE5sUHJiellk?=
 =?utf-8?B?UjFUUjhRaDVOMnZJYjB5dDhsa24yd0JFSzlxY090K0NSUi9ubjNTZ0tLL2NR?=
 =?utf-8?B?NjBydWJOYjNDZ0RQS1ozNkNmOXNNY2M3QnNscW5XTkYwcWlTaUZ6c240cUdr?=
 =?utf-8?B?WGxCamJ1QS9EZEQ5QWFuQ3RHRG85T3ZaNTJqb0R5UjlxVk1nc2dmZjZieFRo?=
 =?utf-8?B?d3BDRHdXVkF3enZhZnR2b29MSnFFMDBIanZSRFJ5ZC9ieVRwaENHd016eTVK?=
 =?utf-8?B?NDhhd1BXa2E4V1ZhNnlvbXhTcEl1SmZaRUtZRHhpM2s2b0lRT2h0U1poOExC?=
 =?utf-8?B?WFVoWTNSbXl4Qm9EcktDZ3hVS0Q1MzRqbDRBS0dzRDEyZmpacmZQRjRqczV1?=
 =?utf-8?B?NHpHK2NwdTVZTUkvQzBKWXV5RG10M0ljbEJ2bDZLaW04anpYNXVVVWNYZ2Jm?=
 =?utf-8?B?cGx4YllYMWkyUm90eHhaS1h4WnROMlNiM2R2WUZaNEllYzVnOFYzanQxN3E1?=
 =?utf-8?B?ZStWSzliKzBJUnVYZjJPU3ZnU2NpOGZzL04yOVVibnZucE9XbGljVkFyWlhP?=
 =?utf-8?B?dEdreTFtWkJNTHd6dDc1TEFKSWpyMlp2T1hHK1FjMHZMbjhVQUR0NXdUU0xu?=
 =?utf-8?B?ZldUY0N4bE4wYXVUZUJCWHFEUlVIU2lSY1JkeFk1Q2RubUlRbzhZd1Z6OUNU?=
 =?utf-8?B?eUtZd2NOUlVNTkExUDB3RUMvY29NRWFDR2k3WW1SbXdKMWxObG13ejZWd2Zi?=
 =?utf-8?Q?GiR3mxpqHIYOLSBWms3m5HVui?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1a2b51-0417-45d4-19f5-08db7ba55a69
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 09:10:32.3597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUb5rdTLbhzZbvqSLtxZDAKYnZSkv8u7Nawtgyl7S4A8fuPidgyg6to7dXdRvDq9KeE9wACBT7J5CR7pbNgRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4003
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/27 15:43, Krzysztof Kozlowski wrote:

> On 27/06/2023 09:16, Yangtao Li wrote:
>> Ensure that all error handling branches print error information. In this
>> way, when this function fails, the upper-layer functions can directly
>> return an error code without missing debugging information. Otherwise,
>> the error message will be printed redundantly or missing.
>>
>> There are more than 700 calls to the devm_request_threaded_irq method.
>> If error messages are printed everywhere, more than 1000 lines of code
>> can be saved by removing the msg in the driver.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   kernel/irq/devres.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
>> index f6e5515ee077..94039a915218 100644
>> --- a/kernel/irq/devres.c
>> +++ b/kernel/irq/devres.c
>> @@ -58,8 +58,10 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>>   
>>   	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
>>   			  GFP_KERNEL);
>> -	if (!dr)
>> +	if (!dr) {
>> +		dev_err(dev, "Failed to allocate device resource data\n");
> Just like any memory allocation, I don't think we print anything for
> devres failures. Why do you think we should start doing it?


And tglx point out that:

Having proper and consistent information why the device cannot be used 
_is_ useful.

>
>>   		return -ENOMEM;
>> +	}
>>   
>>   	if (!devname)
>>   		devname = dev_name(dev);
>> @@ -67,6 +69,7 @@ int devm_request_threaded_irq(struct device *dev, unsigned int irq,
>>   	rc = request_threaded_irq(irq, handler, thread_fn, irqflags, devname,
>>   				  dev_id);
>>   	if (rc) {
>> +		dev_err(dev, "Failed to request threaded irq\n");
> I don't like that one path - devm() managed - prints error, but regular
> path does not. Code should be here consistent. Also error message is too
> generic. You need to print at least irq number, maybe also devname?


v3 has been added.


Thx,

Yangtao


>
> Best regards,
> Krzysztof
>
