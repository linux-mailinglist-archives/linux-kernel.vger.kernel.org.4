Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22411746CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGDJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGDJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:06:33 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB2B1B6;
        Tue,  4 Jul 2023 02:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2HxpnVyQ3xhthm+sCxnEGyBFAAyzA3c/2uHXVvBaGXeUBvoeFCCAzmOmVqEnnOl2DdiPqgv+zTciqNWzvNmDK2JlLrrtLeqDCiT9OHzj7tylks6vVQsDfF90noXGbpctuoAxaInw6Lf3DSjpkmAjXm6PJ/r4srYRnnKrEPAyzPgCjizPWRs3Vf9K5onYOGaGxL/ertcJjnrZhVZfq9W84+QXIgvf8udt0fr1g9XAu/XRAakb8hQj8QBy7uU+ic8IdeMOG6a8TOHsoAc62zjqbjHWw4jqf46hfFkiRMQYDS1vi6iBRd+b28PHRZOmzypxaYLvxjquzCJvbiyRM6ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB05fvnQ6454a0Ptth7Bjq3CQuGMrioEU9zAHDtZ0AE=;
 b=RJc21nEtfO7VZnkVpKxZo5wLyK8uGDdY5+xFb+UEAEmBbBzPGbsyLDLykBRFmaLbgDJ0vll1LM9rwNsRTh6jyazOVoVNWeDBn8dbQOfCToBk3nLkOLMycWu6K25qp4x/cnim7WeLsQhKzVmYSU8Tkdtm66r2PR339/tTkCJaYmtGyBHFPZUr3D+dui/uBPcpkNWSRXdttBNbp6KJ7OGY9avOXdbdwRlcYCRdq0UOmuU5/xDsbdwWhthtmnMs3jJk6R/WRxid7rz9lzEP/iof4CzLCTl+KZsrQ030J2NmieTCxy9M65obo0OmbgKhDA8xteG2vNiAn+1mMsLCqD0otQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB05fvnQ6454a0Ptth7Bjq3CQuGMrioEU9zAHDtZ0AE=;
 b=Xc4XVPIY/SWPfLRCv2uUKC38WEyJiSvFKtJ7lloF88zg6v6FfN7t42RTFfEh4c2LYxxxrgQipYr+lYv5gCFl5JZ8/o5OHjw7tm0Bb9qqO/r/dZTNFzQr37FALkpYACmzo/qkU6U5HTGOsdKw2zRBcIPAj7n1Hz/xkljT2jmYcl+dEjZGWYLH4ONNL+Z65U5Pqsv7nWz/wdrB5jRLvVqipt3mH/Nw7FpJMVijA/VsWOkPgOaChAIdhkKgy/SiHX3/9Lh5uf5Cpbc+posHrO9g+nh2PelrTkpiugJzOFNVH5/xz6jN2+rIyXQUCOt86rpskaZIv+XnNrv8lOfvtwVQPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5062.apcprd06.prod.outlook.com (2603:1096:101:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:06:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:06:18 +0000
Message-ID: <20805fef-d6aa-91d8-999e-04b1d6b7a37a@vivo.com>
Date:   Tue, 4 Jul 2023 17:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/5] genirq/devres: Add
 devm_request_threaded_irq_emsg()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        miquel.raynal@bootlin.com
Cc:     miquel.raynal@bootlin.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, tglx@linutronix.de,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, wenst@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230703090455.62101-1-frank.li@vivo.com>
 <20230703090455.62101-2-frank.li@vivo.com>
 <f4873823-fd7e-c6dd-fbc0-eac4a9be52b1@kernel.org>
 <20230703174347.4m6hcmify4jwsozv@pengutronix.de>
 <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <11052797-b006-11bb-e4eb-987ddd568b24@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::13)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec8b286-88bf-4ec9-687f-08db7c6ded52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3OCIyWtcIxQvDUojkfVkvRn+twZHvSusHtaLkHpNceNlpDSjaIRi8iyb/BIu/oKCwTtsQTqzo1ITvzUYyL+/kyJrIwvHvwGFhqUHEocScSLFPRt5+SFmogE3crxYzDpbsQsxFaho0+1ZrTP1w1hnslHeu0ebwWKb29OhxghVXkszPxYAiW1W0tw4lbKRy6g4G/qUNeswW6b7gWdAhp0s1P99s7AdF22IpjLPXpk/5NxIfOh5T9mZWFTjrDS+RoUgZzUNBR1cQuCOIvHKw2f+KQPhgaKO2esKxaFdwaHB+oKuVCdeOCc16I8uFOIA3sxHHTNUwevPyhEJtjlr2MjiBPDejHRPpqa2C22mqbeWUR7NqlLhumThggrNrEBVcGEWYZhCt7KFYvaE8LJvdtpzWmT4+JaJP1b5ar0KboTOFikC98Q/u9L6BCF9mohVOkHJ0VrV7yEPJVyjcC+Ym567wBZSdbpm3BeC1317SzokNCiHNZGR2yIeoVJMDXXWdUm9+B+c7eo9TyklLz6YXdIPWr7InDJ/P1eqCU7X8kipYoocnLoy+3HmgZzn0N6pCcZTwVwLOfYURFsWCVYgDP7OOX6HeDRUfpyW2zHc5OklXgsy+X3KK4BY80M8WOLoejEeDOSIZRHynLpnmdx14nxCyJHpjsaZRpP2IjbtuQdeyTP13VSK34EccqLEE/Hy/fe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199021)(2906002)(41300700001)(8936002)(8676002)(7416002)(36756003)(5660300002)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6506007)(6512007)(966005)(6666004)(53546011)(6486002)(52116002)(316002)(66556008)(4326008)(66946007)(38100700002)(38350700002)(66476007)(66574015)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZHbDJaeERSUHZ6NVh0RkpOdThBOXZndmtBRXZpRS9uRWQwelEzOHBJMWdo?=
 =?utf-8?B?d2FqVnZxdG9jRHhMdFQ0alJ3YU1WUHJSYk0vc29DUm1JYmZGOXE1ZzJXT0Fy?=
 =?utf-8?B?M2pUeEwxY2RBYXFuYkZCZ2pWaFZaWXBjOTBnL0NqMk1oR2lBME9nTFptNkIw?=
 =?utf-8?B?MVVwdm9LVlM5RVVITnhoTE9vaW9pTzlXRWdYLy9wUTczQVFPWTdRUFN4cVpn?=
 =?utf-8?B?Mm5maVVPS0FCYjhnWnlUQVhEWHdobXF5c2txV25vZTBtNDJyQnBqaDNKK2lM?=
 =?utf-8?B?ckw4U3JSZTFseE1wSlk0ZEcxazEwOU1HTlEyVmxnOXptMVZCM0p6T1pGeWlo?=
 =?utf-8?B?TEcwcFN4MUhZTVVReDN3cjRMRzZPVFJQNm9XaithT3FZSkJwNUozTHNpUzRx?=
 =?utf-8?B?QnJQU0pNOE5Mcm9QVkRVbjlKek9UbWtHRHkvclNic0hveEl0d29hcTE0RDJ4?=
 =?utf-8?B?NkpJZ3pnRHI2SVNrc0k3L1lXZ25oODZzakQyZitMNkRuVEJ6UFZKdm5wVTF4?=
 =?utf-8?B?V0ZWSDk2UWdlUFozeGRQRVZZelRBQVNSb2VhT2xoWXkxUXBwT1h3b3BWaFV4?=
 =?utf-8?B?YmRVTGg2cHlzRXUvNDlMRHBzMFZCeFhrSDRLV2h6SGVTUFJSTVIvYm5mZ1hX?=
 =?utf-8?B?QTVralBTak92VER6ZFU2aFJmdnBBWHdpMjVYcEFoWHVLeWsrRTJPNDFYTnoy?=
 =?utf-8?B?V3ZveWM1b3Q3SDdjWmx3OS9iNXJFamppMjczSnlIbDlnZTcyZ0ptVllJQUd0?=
 =?utf-8?B?T0cvWVZrQjNjTmkrcWFoQzhEalJEdWNqbEdBa3Uyb01yN3dZYUkwTUU3SnVW?=
 =?utf-8?B?NkIyaWdmeUVJbjB0NWdGRDdIK1h5b1JXZ0tIbmVNMy9lR2dlaHVLOVkxS21h?=
 =?utf-8?B?L2QwZTFnRDZlWFlISGpiZi8rdk9qSXBoSFlmclRMZTQ4YzZlSkdHWjFLUGZj?=
 =?utf-8?B?aGlkQ1ZLOEtUc29KcVRhT3R1MDVsQlhKUjRYWGR3R2JvQlh4Qy82TVNsbGVL?=
 =?utf-8?B?ZEZOQVhaZFp3d3RteVE3amJUZGJlT0orajhMMTl2RGVmUVE3a2FWOFpYOUE2?=
 =?utf-8?B?RC8rdDJyQmFNdmpHWEtwR0RiNDhORllHNGtRU3ljWkVCYUthcUVrTEJZdEdM?=
 =?utf-8?B?ME1hZ3p0WnJqTUdPY0JBdkg4SituRDN3QVdNbkllTFZVMy9GdXo3VXlydlpk?=
 =?utf-8?B?NC96Zk9LOHdtMS9wOXk3WGRrR0c2bnU4U0hFcmx2QTBZdmRra1JTVGhIS0Fw?=
 =?utf-8?B?NUh6NWFjNmd5bEYzTGM4c2lEcFY2WklFbTE3bkd5ZUJsa3NrNVVUTmhOUWxR?=
 =?utf-8?B?bTBOQzZlcnV5TDZpcGU0Q1ZUbHVNenQzZUt4NElaaUtmTWZyVVZoc0hnaFZF?=
 =?utf-8?B?Zm15c3E1Ukh5Mmw2MzR4NTVFR0xRS25pa3pmRWZudGlsU3pGOFJtZ2Nrb3Zz?=
 =?utf-8?B?SXpLN3I3OTZzN0dqK0Y0UmtZRDJLQUJDM0pXZ296MmJkNlg0eElBRlI4bmpk?=
 =?utf-8?B?c3ZFS28zdzlkbC9adXJNc0owQTExNzNBZnRhZm9RTWQ5M2I5eE0zb1lDK0pZ?=
 =?utf-8?B?eS91SFNkYmdjTVp6bkRtdkpoQVBUNmpRUHYvdyswdjhPT21vNkViTFlqYUJp?=
 =?utf-8?B?UlNUZXlvM0p3UFRlK3JWNGdGZUtoUnlOYmtuSExaeW5DQXBicmI0a3l6UW9V?=
 =?utf-8?B?STEyZXZIY3c4N09yOUg2Z2pCeFV6L1M0VXNCd05aalJma2N0MGFqdnMrZHNs?=
 =?utf-8?B?elNrRFBQa3ZZcy8zSHE5Sm1RZlpJeDVaVkVDdTNmWVg5bTJhcmtKTThVNW1E?=
 =?utf-8?B?cngyNVd3azYraVVDMzZQOHBubFU4YkttQnI3ekIrNTJOOERoUnBBVHJ2Sm5W?=
 =?utf-8?B?VGwrZ2VHOTN6QnNkUVZtZTFoWnkwZEJsdG5iTzJHaEZzOStNck92cEt6dFhE?=
 =?utf-8?B?aGRLR2JpR0RsQzBrMUhmZ2RBVk14QXJ2ZE5uY1hmT1ZoMzJrYjFyWjBENjNM?=
 =?utf-8?B?eDVvdlZKUUdrK05IcmtwejN2ZE5SQVhjVmRhNHBxTGx2ODhZRG5yUUxvNHFZ?=
 =?utf-8?B?VS9obWs0UDR0YXZxbFFnZGtMMVAwR1pNeGp6M21JWGRyU1BoN3RES00vSmtC?=
 =?utf-8?Q?kYRMdJZD8W5VrWBVg423scfnI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec8b286-88bf-4ec9-687f-08db7c6ded52
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 09:06:18.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRP6Z0l3V+LtL/rgIUS4xA3wbnruAmCH/wHQY2sTkEsqNJy9IqxMtPqvECN0NEOxWToGlzoxwr0VbMqUIFF1dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5062
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/4 16:48, Krzysztof Kozlowski wrote:

> [你通常不会收到来自 krzk@kernel.org 的电子邮件。请访问 https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>
> On 03/07/2023 19:43, Uwe Kleine-König wrote:
>> Hello Krzysztof,
>>
>> On Mon, Jul 03, 2023 at 02:31:59PM +0200, Krzysztof Kozlowski wrote:
>>> On 03/07/2023 11:04, Yangtao Li wrote:
>>>> There are more than 700 calls to the devm_request_threaded_irq method.
>>>> Most drivers only request one interrupt resource, and these error
>>>> messages are basically the same. If error messages are printed
>>>> everywhere, more than 1000 lines of code can be saved by removing the
>>>> msg in the driver.
>>>
>>> ...
>>>
>>>> +int devm_request_threaded_irq_emsg(struct device *dev, unsigned int irq,
>>>> +                              irq_handler_t handler, irq_handler_t thread_fn,
>>>> +                              unsigned long irqflags, const char *devname,
>>>> +                              void *dev_id, const char *emsg)
>>>> +{
>>>> +   int rc;
>>>> +
>>>> +   rc = devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
>>>> +                                  devname, dev_id);
>>>> +   if (rc && rc != -EPROBE_DEFER) {
>>>> +           dev_err(dev, "Failed to request %sinterrupt %u %s %s: %pe\n",
>>>> +                   thread_fn ? "threaded " : "", irq, devname ? : dev_name(dev),
>>>> +                   emsg ? : "", ERR_PTR(rc));
>>> It is open-coding dev_err_probe(). Just use dev_err_probe instead.
>> dev_err_probe is supposed to be only called in probe functions, while
>> devm_request_threaded_irq might be called in other contexts (e.g. when a
>> device is opened). That's why I asked to not use dev_err_probe() in v2
> True, but then all the callers of this function will forget to set
> deferred probe reason.


So let's use dev_err_probe?


BTW, any suggestions for names here, keep using 
devm_request_threaded_irq_emsg or change to a new name?

I am afraid that after more drivers are changed in the follow-up series, 
the name will need to be changed again.


Thx,

Yangtao


>
> Best regards,
> Krzysztof
>
