Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B081F6328E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiKUQBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKUQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:00:56 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2083.outbound.protection.outlook.com [40.107.103.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5CD1C3A;
        Mon, 21 Nov 2022 08:00:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6RLsjsSzM2uHadwq4WQDnsdd8YhjuS3vsyZcoH39WOpnn/lwcGYAAZ3rgYj8/WSuTdfYIh7asJvyepJnQwrAIXyLoES3ek1+Eu2DXv0d5v+W0IqJZgH+YeQu+Dw3qHrDP/cFUXWMuPM3F1TLmMFI1fz8vM1eeVEUiCa2du+rN9hjff2okmKamGJW5G/N5jlY7Z3ZhfgO0WG0N/rdnYpcnr2pMVudK8mKdwCtrEZQICZk9EZtEFOACQuECpTbR4CnGr/3YfWQ+jy5QjayEE3aK75LlJVBT7JnRz1qgp6Py9kPk8CNHT0UZKreDEwg2dRSaMRR6QUzNuXH8Zio9jOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUeV1z9AD13kNEpNO01FT24cCsIcugPFaYbfLMLa2dA=;
 b=ebnYTjkE9SD6GZ0HwKCvcuLG1RxwgRif8kPHRydR5+4lzY4n+hqaWyXPuTlZN9/DiEQQ59eAXaUQkqlevCy5nMNXeXKbMsKPcFWCOTEKrz9tKwJsEJ952dxiTyKDKroKNB6HR2tKDF5S3xaIjFyb6wfyzoxo8YQpo7Ws0wEEiuqiH2Ot23Tn13MTrdorje7K8LF4rUP6ORNplHO5ppHal9gPR01vFghknk7yRp0rPl1vnVpeXbol0e8Ip/g/GANPXSe39IVJmv7KcKnJ8T1r13pagGV96AN81Znl6kcqJS/m2qPG+BpDTaFbcz2sIgbwR9DPf9utLl2DxHPTAPb/WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUeV1z9AD13kNEpNO01FT24cCsIcugPFaYbfLMLa2dA=;
 b=MUYlVtwMAwDFu9gG8DVuc/Bo/Cg38uiEGM16WuCPm/JrdlkbuDMZKoJXppumkk0kTAeD0tGgqlBQEesbUHTV3cEHmgyX9TO77xfBWRhROtviYZBAa6m4mcP/s3SEzzNtsd8hDZeWV3yJRYzNzslyOH6Gku+HG0+vw13gE8jShHc2UnC10oAYMlUf1mvSXY7V4s9cmkbd9D7Hl7Uhs3Ee+mnBEyCZ7aKmwrkpTGbvFtwnn7lqVeA2HL5TTelo4ayzobjX5im5sFtmaj8epJzeM7c8YjA/7Q2wEhY4Y54piHOsCeKLt6s6jCwcxNk/m+Le6S7ojEO1aPWOjhNtcrYZZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VI1PR04MB6912.eurprd04.prod.outlook.com
 (2603:10a6:803:134::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 16:00:52 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 16:00:51 +0000
Message-ID: <049a8f8a-baf8-744d-6250-575fc0dc533e@suse.com>
Date:   Mon, 21 Nov 2022 17:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Prarit Bhargava <prarit@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
 <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
 <Y07xX2ejlg0oFoEy@bombadil.infradead.org>
 <d0bc50e3-0e42-311b-20ed-7538bb918c5b@suse.com>
 <Y277Jb9i2VeXQoTL@bombadil.infradead.org>
 <e070839f-c224-047b-9411-91143c1d8394@redhat.com>
 <Y3Jg8X7qv2AKPU1J@bombadil.infradead.org>
 <5467e66d-55de-ca8f-c1ae-ffe6efe7290d@redhat.com>
 <Y3Pol5H4kJioAV9W@bombadil.infradead.org>
 <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <c2e841b7-e2b3-09f9-8187-328131d72c5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::20) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VI1PR04MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 29343155-428f-49dd-8668-08dacbd98fef
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PczAtxjNbDysD1Ypu9pYy3jT8Dq6yhLXFQFdYg/92BlMxTvh181D78t/oXjtDA2q0tGxskZ2GLTeCyDseEcnJmBFxdhoX41hp7CX1T3CWGTMxfKGAKrjrArcoPLCQah1UzQd7PhmiTsIi4GuwTJeRkqX2y6uPLEXkai63jgn8ebOxVA4d05obzlGiBmGBJM2GhVACAGz+uwnqLBu4slrFbZhW9Cu+HTuhy/Ly98jfOmirOpqKeHGuALfS8l0atpSSm6q5L5IVpaWXE4wll1quQRKaRRgNHKo9picaBIYl2GWtaTAEJUtbGtsiJeklw8gbc7C9vfVxQvZ2i8C0dGdDuKqzPnzfO4ISjvTWUxTtPs7xFWstPJtCPrD330D2imly6wD31wmoYcNLugjyfCNJeeMWzL96RPjVKz9+3aA/LxbHfPua8FWaFQXKxwUJfq4XbMwoUxvognfJo4MNiZHWjuzLq3i2xr3L9re24yWlRifJ60RRtlI+lxD5yPrAhQbWkvRYxZkVyuy3NSbWazMQX07CSBlNocQjJlSKdmxncRIdkpcxBjDHNqb+URF/JZR4dS5JU62X56oeYWGQUlDa/xVvwHQR1mJ50lStiqj6C+n/qkJRTu8mn9d+LPzMaZMFO5Jyeui1Zm75oXUkYlacdz9cCJwrUKaqltLzqfiCd7k8YkFRFg2bgq90NtKFI32KiOqlc4HsHFYCQGCuv6Ku2j7v7epxJyQQnnV9O13ps8/KOiTPvEtpEkQNHvxoIiD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199015)(8676002)(36756003)(55236004)(53546011)(66476007)(38100700002)(66946007)(66556008)(6512007)(6506007)(31696002)(478600001)(26005)(5660300002)(316002)(4326008)(41300700001)(86362001)(4744005)(110136005)(6486002)(966005)(44832011)(8936002)(83380400001)(31686004)(2616005)(186003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU03TGN6YzNYRmRaT0IvNldRQ2VaTUFhSXUwRGthZ2JyQlI5TEEwZU1sZS84?=
 =?utf-8?B?Z01zbndRR1Y5UU1OZlR6a2Izc25DR3M4ZHVOVXVBZTQxVldyMU5Kb1E3YTN1?=
 =?utf-8?B?NzJiRmx5QzFVazRXWHlhTmxKTHFuTC85K3NPTFJhZmdJY0dDQjdRMVpEQXlK?=
 =?utf-8?B?OTlKREUrb3pRQW5BUHdCT0dJTFJ2bmVsVEVWZnVONVZtY3R2a0dUMkxWeFNF?=
 =?utf-8?B?dGk5a3Nqc0xCU3FtcG1zQ0M5cmE3QkgrVjloODl4RlRCSU8zQXo2bUp1R3B0?=
 =?utf-8?B?M0lVb0s2WjcybGlaVDBIalNwWllsMHJVYzhxcjI3WmgzNTV6VzlXcVRBT2Z3?=
 =?utf-8?B?ZGZrWHdVOFJBMFFJbk1PTWNuOUlYSVRFcjRueDJ2bWUwVzFjN0VYaTBGMU40?=
 =?utf-8?B?VzI5MEtnbmxNSkZES00rTStiYTUyUWxKalQ4UnZiRUFQZ1diMkN6WUlja294?=
 =?utf-8?B?U3ROSUVvQUNSem1MYXFnNFIxem9wNm5FTWRheGxWMmFtQTFpWDdyaTRaZTZY?=
 =?utf-8?B?Y0EwbHdXV01BSDhvcTVaM00veHBZZENjUHhNQkZVRytzVnpxQnErOFBnMjRO?=
 =?utf-8?B?RVpveVBCT0FuUmxsejBTMm5GTkZtUGhMcG8wOXN2TmxSRWc3VGRTcWdjTWtE?=
 =?utf-8?B?MGswR0FWV3ZkOVR4ZE1kSlkvcEhTNzNHdjZCT1R0UGhhQ1JYYWI5em9wZjA1?=
 =?utf-8?B?VnJWeTRMUWt1U2trUjl4L2h4YXBsQUdOaUtNYmpQbnY4d1hYL3ZHVm93c2Nl?=
 =?utf-8?B?dm1VdnBIRkxFdjU0cTNZRzFIeHRPa0Y0VVY5WnpzUnB4YVp3NVpNNGdyZkxw?=
 =?utf-8?B?MFphZ3dReTFPek5Mbndlc2hvN3MrQURwMUhOVE5NZ0tSN1dOczVJTkEyMlBr?=
 =?utf-8?B?STZ4TkEyTnQxVjNJMHJHUnFxd1dWWkthR3VrK1VtTGVPS2NzUDE2dzVxQjh1?=
 =?utf-8?B?R2M3UjlUR3ZiYnBlV3htS2JzbksyU2NrcmpFM2tSdGVQVVQrQUxKQUFORnJD?=
 =?utf-8?B?Z05mbTdCOVo0OFhYa1hIOWh6S3NMV0YxSndtcUR3K2NUNTBYbExEWnRFczdO?=
 =?utf-8?B?c3RYcUhuMkd1c3YzZ0VtV1VNWElUR0pjaXZ1SWgvOEk4WC9GZXVjVlAreG4z?=
 =?utf-8?B?cVZhLzFtd3I1MnNoKzhFZXo1YnkzWnhHaXpURXlWN1lMbUd3SFFjTDIyL1lR?=
 =?utf-8?B?MzJqb1A4b1g1Zlg0MStubENiREowRWhOU3FieWw3OXJPZjFMZ2FoMlFqU1Fr?=
 =?utf-8?B?MFVWVGFib3pRdEZ6dzZUenZmTmRjb0Zod0pDeHhOVEsyTS82WnRFUjVqbEZo?=
 =?utf-8?B?MnltWTFKZkQzQnQxU3RIYlNycHNnNm8zdFRXTTFvdmNCZDJHMEMwbmNjR2N1?=
 =?utf-8?B?Y2NpckJGZ0RlTUtTZzBRRjV5RDJXOExIVm9iUjdJL3d3ZmtrbC9ybjhxV3Bm?=
 =?utf-8?B?a1Q3bm9GNlRCMDRWV2VKSVJXQy9YWTZPcG1tZWIrRE5nb3dybHlqMnFzelMy?=
 =?utf-8?B?bWdrWTZVL2duaVJaVDlLYlloM1dFRE0vdC9TZjlZQk1wcE9zYjNRYTBXYlh0?=
 =?utf-8?B?dzFpbFlva0k0bVJOellsWE9QQUxMYWhWa0x1WE91cnhUVjJtd3YyVHNiK2hN?=
 =?utf-8?B?WDMrTTM1bFZHTXhkVEoyM21WeGRkMG1kZnJvb29zdTRFOVR5RUNScVd5THlH?=
 =?utf-8?B?WFhwdEdZUFZSZlhPUThGOUpUaS9NdzQwbWp1elBnT2xnTW9EamtlK0NGbXdO?=
 =?utf-8?B?S1RBV2hNRzh4R21jeEZrTjU0NEp5SURmd3p6bmZxbkhKVXYwekNRSEkwK0Vz?=
 =?utf-8?B?bUl4b3hnZXV5V0xXVWgxTituUWhqYUF4bW1lSG0ydU80SVVyMk9EQk1uVkt1?=
 =?utf-8?B?ZVlXQUFGa2xUTjM5bWZObENjcVRJWGJsVktFS3lkMTFSWGEydW5UMzFzVjcy?=
 =?utf-8?B?U0xyYkNGd2phQi9RUkFxelhsRjJ1ejdSZk1ROHJxQW1tVk9ZVXAveERnRWhu?=
 =?utf-8?B?WXlueXRRMnJvTDM3M1lyZ3JvdGk1YW1nWjFzMm8wYjk2TjFWbTBNWUdLYnlr?=
 =?utf-8?B?c3BQNnNvVkU2TVFINkZpblRBMzlyMDQrYytrRFpFRjgvQXVnSm4wL1ZJUnVl?=
 =?utf-8?Q?f8fZfj6dl6xHNZxAm4k5rAb91?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29343155-428f-49dd-8668-08dacbd98fef
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:00:51.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDWfAIGMwXBoYdmBAJB4ThN6JaTCmOLNk8ou05UCxHW3n5ukqWdInqnsxMiFhJDYQJgBgR8d7Lde+K2nZmmw6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6912
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 17:03, Prarit Bhargava wrote:
> On 11/15/22 14:29, Luis Chamberlain wrote:
>> On Mon, Nov 14, 2022 at 04:45:05PM +0100, David Hildenbrand wrote:
>>> Note that I don't think the issue I raised is due to 6e6de3dee51a.
>>> I don't have the machine at hand right now. But, again, I doubt this will
>>> fix it.
>>
>> There are *more* modules processed after that commit. That's all. So
>> testing would be appreciated.
>>
> 
> Can anyone tell us if
> 
> https://lore.kernel.org/linux-pm/20221102195957.82871-1-stuart.w.hayes@gmail.com/
> 
> resolves the module loading delay problem?

This patch unfortunately makes no difference on my test system. In my case,
the kernel has already intel_pstate loaded when udev starts inserting a burst
of acpi_cpufreq modules. It then causes the init function acpi_cpufreq_init()
to immediately return once the check cpufreq_get_current_driver() fails. The
code modified by the patch is not reached at all.

Petr
