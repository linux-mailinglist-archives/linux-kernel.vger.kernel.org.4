Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3096F27F1
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjD3HdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjD3HdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 03:33:04 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2104.outbound.protection.outlook.com [40.92.99.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985CA172E
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 00:33:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXo7VVmZV3vHljZl44qK6v0QDBTTRR+xcqFbWCspDgQvNnUcCCP6UDn6khUM2vkoBK0npEWKZp6YIcon6w3vhvNbUmKpsCaY+5kBU/PfAQ9P+ADZykaHV6lnOTs2oHHQb1aaAF2UPuxPICPW5XvNnycxZGgGIcDxO37kaqExJJVCZZK6ujmfOwNC/fmOfpPq2EyrEOzGt+jqOPlHPxVBgPOeKh2DMh519w3bM2Bog/YEGCTvlPmksASvSwPlzoeIeOfARLOcY7OpAXzKD0kwIXeM39lePJNET+xO0Cn7raWYOQJ2DcRDKwOHeWgwJ3BsyTCWn1s/qCihaCUbDdvzOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RProTk/kZIboarZgxDkTVuHI8wf0Hn70z1xrYm1rL68=;
 b=BNp4xjXKGl7UUwWzP98+kOvWpE9vbwhi0TLfHtj2JCSHI/D/vAqIubejvfN3SPEJcfjphqtag1fHXuX6BQLo/5hpa91cpMPxukhV3BgCC2us6X74uHH0FyEW5KyFZacTayNZKgLJfz+WJILif2DwYMb3OCFJa3rsKz+vrt1ga8rpE4dHiqO4W85/ayzkcPDPcnOrCAP2mi/W0ikaQN1u6/0j4B4vJLSQ7Hf2j5GG+LOcfKl6pLQJA79X1PcrA9KfoL2irkVsqB7Np3ndtBjKwLV4tBR6kj9yLf/wWtM8oX3/R+yUHfGskUTcfEyq1PMrA5IMQjtMD+j6VnDEFHfdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RProTk/kZIboarZgxDkTVuHI8wf0Hn70z1xrYm1rL68=;
 b=jfSbJg/y2au9h4RJu1OJGuKwUUsVtYBm10pSlf6laTXBImIAuuugWPUYj0WsrLMdtIofQO2g37UNJAP5S/ct6oPIp/q6JNB8x+2KLm2fc0WARzbYkDXVBVQDJgK6DlyTbfhrZzdL6qJiIG3Vl7AoXMAb/zZYvLJGSdqzwXxGfKwLy+XJrBhf0pmN2bfI7tKFiy4/3l2/YkJoZlPhjHjWAG/yxX1lzNNCwKK5f5AI3ahcuZyuivtkoz4PhSrxe1in+qNgF3vSxGwpSJOmr4gIEUf+3xjd12JAV8d8LcNbwjcFLGEOruzkIPDL38sIhGV6/o+4i+/aon/bpGZNpdx2TA==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2448.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.28; Sun, 30 Apr
 2023 07:32:54 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::5805:16d6:6ab7:6639%2]) with mapi id 15.20.6319.022; Sun, 30 Apr 2023
 07:32:54 +0000
Message-ID: <TY3P286MB2611E946C6AE8B907DC3CD1F98699@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sun, 30 Apr 2023 15:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     wiagn233@outlook.com, christoph.muellner@vrull.eu, heiko@sntech.de,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kito.cheng@sifive.com, jrtc27@jrtc27.com,
        Conor Dooley <conor.dooley@microchip.com>,
        matthias.bgg@gmail.com, heinrich.schuchardt@canonical.com,
        greentime.hu@sifive.com, nick.knight@sifive.com,
        Richard Henderson <richard.henderson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        heiko.stuebner@vrull.eu
Subject: Re: [PATCH 0/4] Expose the isa-string via the AT_BASE_PLATFORM aux
 vector
To:     Palmer Dabbelt <palmer@dabbelt.com>, philipp.tomsich@vrull.eu
References: <mhng-7497491e-b83c-42e4-8ef7-d18c847298e5@palmer-ri-x1c9>
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <mhng-7497491e-b83c-42e4-8ef7-d18c847298e5@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [URbA6hjH5QWvBFcGK7EyP9yTyi/GAcEN]
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <843821b9-9d84-d550-1b6a-75ea2dded88d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2448:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a479b2-021c-483c-58aa-08db494d1c8a
X-MS-Exchange-SLBlob-MailProps: gCWdzk5XZlCG/LA83Y/QtvORfWh10YK49jk9BhpVRwfL3n4g7eknZyf4C29AJYHaKsYbrx6oD6ybf6ZvagT2VXaAhvFTnJdpgRvKZXBZR0AxA3KKgY3h7o5Xvxq+b7fU57qVjwPaA+mjpkw2M9wWXJUYxM2xgOzzcKSMdKaSgjEFk6Z26ps+AQqLbAYTpzRvpcWKrQ3+aF3nkGSzRvvDHdmQDOqYOOp4zWHiHs5XMuhzxFG4AvZUejXKF2TSWTxemAD4OsfKExvP/u2mEH51d3WpGaxI4Hcqf35M8/L2xICIogNL6XIsiDLlc48auY3QJ03p3RMopSmEoXBl3aFRBL71br+J3ulJl+6yP416h/1lUEzqV1O0w/DUXpE4KmztWXgItGwW5IGRddXohN3v4mORifvxBK1qI1bjIWu4R+GB3SDqlGS/0tzn8P22VhGhzkLHdBUlkatgsfl5bZOOXT8LwJZ1eOEfx9xpP1tz1mjOj2ms41y2sDq17cDCDdBfnA6bljfQmziSVGNV8oROb7XYnt3FeAsbhorXvsajgZvkegToCz6nahcOh5v5r6/z0LsF3WOFMovSYBw65Q/6dexBlLo+frYLRapk+nsyhySq5YflNcdEjNzSsfcp4nal1pO0wBBYUs37edyYBSZY/GXKcqR3mqSwFNoMHMDUvq/thY00ytpJ1zCudRn7CO8ugZI8kjfsmeAvXGHlulFTvSwOh9a9U0WY6mpqj7qxB4iHHSoE/QoZYxo8jbmw5Ax/LH6sKmJjL8737STPSVhFuv6tf29/7FZVr0Bu04luqB0nuZmBSmyZZ1qdjnRaTNAdTMh+PeinkgGF2FOM4dmSyPn/hujJireY3N1eSArVQYPK/Y7NsPKxiYoVY3QgdsmHHSJAsJhPSfX4bktYzVWxdMo2xCZ7NK1WpLUyqe85z5V8kbQcDuTdFQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zn4RX4vEHiLRY0XpaOPRNQObxhGSIV5LatKwIzpmUYmpgo205DKvL/B5zE8v2qf/S6Fi4Do431TRNnjBHs9E/vCRx3X0v7XuH0ICFY/gD8EhfFvwxqCL+hvS6zwWnP2Kh+bIYlSM9vM68hHec5+LTgP5GZL0W0+IYVsopilmiA1JUpZOBCF1tiLokH3I6klCwN6Ps68s1fTIyyQk2nBa7f+FYcNNu4vyyaIHy9uUM4JMQmmNxpJdEW4iIPJPjLSXgRq1PSCcLHVooOei1F86pfUkd6IG00SlUQ8CD87sb4wqdcKmCTRyHR+Z3r+tVINkcZ+9NzOXUK4FmJpfezSKypbHqbqe4jDCcau3SfrONQI9mjFo3zUkW7o/P6dxs3Z0taHB7xkdTQQBOd0gzR+5q03TPYj+EEjO9TqAXehXeduG+IVCRWYubjbQA0Q7VVatpWeFtz5OwX0muoUYt1xXyaPmiYvHkW7xqEYT1yOPZqpp0ajUSK/C9UdXtnYGoLufhiwBOPK1KfpLYoMZpGeJf7iSV48Xnbs3I23K/50f2+2ImNLH5fR25PbzWP5dkPLReZqXRH2jMUx4oz72E9rm7TyDDLbJ3ZxJLgS4qfhh3oWkcn+D9hJY8cfPUrMTTYlsb+vi1cmarNqoUuKKzWfaftv79SXUsqWBpupp9Lzu35g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk12OW1nSGdOeGdIVE10WDZ1cUgwM29MNWErblFEK2trbXU0RzZEeFZsM3lv?=
 =?utf-8?B?WTN5NHhzaUpGbk9QMUlsSEFMODRjN1FpQ3hGQjdYYlp6TFdXOWNISWRJajFD?=
 =?utf-8?B?NHB4K1FVR1BtWE1YbE5ZWklNckt2SE5XYlZLQTlnbkUvV2dpMEo1Nk1xNWRP?=
 =?utf-8?B?bVBsWEtVdjVOSHpVMGpGaE9SV2lORzcxU2VvSElYOHRVN3ZhblBRbCs1em5S?=
 =?utf-8?B?YWxSNzBpbnZVWXJweDRONDB1R0ZSWm5sQVlLTG5MbkNOakN4WU5pWW04Ym1L?=
 =?utf-8?B?SjNIdDNxa0dWQk1MTUM0a2Yzd0ZiYnl2ZUg2eG1oUm9pNG5nSUxSNVJaaHNm?=
 =?utf-8?B?NjgxWWdtMi9GZFVoWGV6bDRJR2hmcXdaRFFrdGhBOXZYRU5DOU1ERWdDOHRv?=
 =?utf-8?B?WlVIZnBDVmlYYXdidEV3QTRIUWd1eUZKSmdaTUFMUVY1WkorVHJGV3pCb0xi?=
 =?utf-8?B?T2ZXRzF4SWJ5S2l2L2sxUFFnZGl5SWFPVkxJL3haMGxIUUtCakRoUmtqTWRG?=
 =?utf-8?B?TUxHZUYrMXZmeEFXbHFCSGZsK1lwWGR5Ri93RVZKK1FMblhKOWl6V1FrUEs1?=
 =?utf-8?B?YVFUMnFjdEpKc2VYT2JiZ0prL3JFcjF2WUExanpxUENvZ2VGbEFlc0VNUmcv?=
 =?utf-8?B?RUd4ZHExKzRiL3hHbHBFQjNuRkRSbGNGallScHBEa3J3OEt1WFNvaTFlcnYy?=
 =?utf-8?B?L1JtMmdueWxuSUhaNnFlbmVRV2x5SnkrYnZ1ZkVUSXlaUVhWV2hoUERPODA3?=
 =?utf-8?B?RHIxS3BzN2tuVmphSGFqR3AzanhadUxVcjJldGVzUlNUU3k0RThoMmx2a2hE?=
 =?utf-8?B?ZUg2ZGJWOTR1S2RmV1E5ZzRGSmtyWlRDM0ZBQjJrWk52NEFCRXZhSTNJYjRv?=
 =?utf-8?B?SFJ6YlZzQjREQkJlbXJwcWEvSGRtNkw2TjBmWkVHb3JPczVFaWgzM0lES0F1?=
 =?utf-8?B?dGZ5TVM2K0lnek9uYnZ1OER0QThVK1lFOXhUVFl6clZWRkRlNW9YbFFTZkVs?=
 =?utf-8?B?WW5TOFY3UzM1ZGc5MGxXN1FveHhiRHErM0w5VmFvYU90NTBnWkdUUUNpaEYx?=
 =?utf-8?B?YU9SZFFWL3pjVGlPVHFRWHJ1aHQ5NlJUakxQRU5jN3k3WXd4aDBQNURUMkRF?=
 =?utf-8?B?VVNhNm1UaTJZcnF6MjIyc1g3MGw0d20rUUtWMXkvZDRFZWRPeVlkTGdlR3o0?=
 =?utf-8?B?R3NCWElGN1RvTXlxZkRyYXNnak9qbmlYTVVWaURNWlM2NWJ0eGY1SDN3b0NL?=
 =?utf-8?B?bDJBVkN3RmQ3a0t6WXBpT1NPbnlqTVRIbHNBeTI3TzhieEJ4ZzcyT0J5KzhI?=
 =?utf-8?B?cW50U2R6UDhqNlNtS1VaVGNBMmtDcWpOSHZKU25GM25iQk1jdzNFQWhnZ1Z6?=
 =?utf-8?B?Mk83VWVtRTE1NHZqQUtpY2l3Q085TzJWbWZpdWFXa2JqL01odnRlakxLS1Aw?=
 =?utf-8?B?cUZSV29uVUt4UGNraXk0VEZqQlNYcWV2WmJubXJPOHI5MlB5SmxFMnl0akRQ?=
 =?utf-8?B?YWZYcVFudGE4YkpHSmpsZDdRcXpORGl5d01Bblpqak9Obk5tRXdWK0JIQTdK?=
 =?utf-8?B?bWEvODU2d3loMFVIOVNSSXB0c3JJT0VnVlMveEZEeDhjZ2FaRHloMjhYamMz?=
 =?utf-8?B?Z2VqazI1UVM5WlB4L210R0dNWExkRXc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a479b2-021c-483c-58aa-08db494d1c8a
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2023 07:32:54.8989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2448
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 28 Apr 2023 11:59:31 PDT (-0700), philipp.tomsich@vrull.eu wrote:
>> On Fri, 28 Apr 2023 at 20:48, Christoph Müllner
>> <christoph.muellner@vrull.eu> wrote:
>>>
>>> On Fri, Apr 28, 2023 at 4:57 PM Palmer Dabbelt <palmer@dabbelt.com> 
>>> wrote:
>>> >
>>> > On Mon, 24 Apr 2023 12:49:07 PDT (-0700), heiko@sntech.de wrote:
>>> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>>> > >
>>> > > The hwprobing infrastructure was merged recently [0] and contains a
>>> > > mechanism to probe both extensions but also microarchitecural 
>>> features
>>> > > on a per-core level of detail.
>>> > >
>>> > > While discussing the solution internally we identified some 
>>> possible issues,
>>> > > tried to understand the underlying issue and come up with a 
>>> solution for it.
>>> > > All these deliberations overlapped with hwprobing being merged, 
>>> but that
>>> > > shouldn't really be an issue, as both have their usability - see 
>>> below.
>>> > >
>>> > > Also please see the "Things to consider" at the bottom!
>>> > >
>>> > >
>>> > > Possible issues:
>>> > > - very much limited to Linux
>>> > > - schedulers run processes on all cores by default, so will need
>>> > >   the common set of extensions in most cases
>>> > > - each new extensions requires an uapi change, requiring at least
>>> > >   two pieces of software to be changed
>>> > > - adding another extension requires a review process (only known
>>> > >   extensions can be exposed to user-space)
>>> > > - vendor extensions have special needs and therefore possibly
>>> > >   don’t fit well
>>> > >
>>> > >
>>> > > Limited to Linux:
>>> > > -----------------
>>> > >
>>> > > The syscall and its uapi is Linux-specific and other OSes probably
>>> > > will not defer to our review process and requirements just to get
>>> > > new bits in. Instead most likely they'll build their own systems,
>>> > > leading to fragmentation.
>>> > >
>>> > >
>>> > > Feature on all cores:
>>> > > ---------------------
>>> > >
>>> > > Arnd previously ([1]) commented in the discussion, that there
>>> > > should not be a need for optimization towards hardware with an
>>> > > asymmetric set of features. We believe so as well, especially
>>> > > when talking about an interface that helps processes to identify
>>> > > the optimized routines they can execute.
>>> > >
>>> > > Of course seeing it with this finality might not take into account
>>> > > the somewhat special nature of RISC-V, but nevertheless it 
>>> describes
>>> > > the common case for programs very well.
>>> > >
>>> > > For starters the scheduler in its default behaviour, will try to 
>>> use any
>>> > > available core, so the standard program behaviour will always 
>>> need the
>>> > > intersection of available extensions over all cores.
>>> > >
>>> > >
>>> > > Limiting program execution to specific cores will likely always 
>>> be a
>>> > > special use case and already requires Linux-specific syscalls to
>>> > > select the set of cores.
>>> > >
>>> > > So while it can come in handy to get per-core information down 
>>> the road
>>> > > via the hwprobing interface, most programs will just want to 
>>> know if
>>> > > they can use a extension on just any core.
>>> > >
>>> > >
>>> > > Review process:
>>> > > ---------------
>>> > >
>>> > > There are so many (multi-letter-)extensions already with even 
>>> more in
>>> > > the pipeline. To expose all of them, each will require a review 
>>> process
>>> > > and uapi change that will make defining all of them slow as the
>>> > > kernel needs patching after which userspace needs to sync in the 
>>> new
>>> > > api header.
>>> >
>>> > The whole reason we're doing hwprobe with bitmaps is beacuse the ISA
>>> > strings are not a stable interface, and thus are not suitable for
>>> > building uABI around.
>>>
>>> The ISA string is the main description of the RISC-V ISA that a
>>> system/core/hart implements. It is suitable and stable enough for 
>>> all toolchain
>>> components (-march string, ELF header, etc.).
>>> It is also used in the DTB that the kernel uses to identify available
>>> extensions.
>>> So it is reasonable to argue that it is good enough for all runtime 
>>> components.
>>> Also, I don't see any evidence that users are affected by any 
>>> stability issues
>>> of the ISA strings in the interfaces where it is used at the moment.
>>> Quite the opposite, users are expecting ISA string interfaces 
>>> everywhere
>>> because of existing interfaces.
>>>
>>> Besides that, also the kernel stable ABI documentation allows changes:
>>>   "Userspace programs are free to use these
>>>   interfaces with no restrictions, and backward compatibility for
>>>   them will be guaranteed for at least 2 years." [1]
>>> I did not come across any issues in the RISC-V ISA string that would 
>>> violate
>>> these requirements. Did you? Further, the vDSO is covered by the 
>>> stable ABI
>>> requirements, but not the auxiliary vector. This does not imply that 
>>> an ISA
>>> string interface in the aux vector does not have to be stable at 
>>> all, but there
>>> is certainly enough room for any ISA extension errata that may pop 
>>> up in the
>>> future. Other architectures can live with that risk as well.
>>
>> To provide a slightly different perspective, arriving at a similar 
>> conclusion...
>>
>> The ISA string is part of the psABI (see
>> https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/tag/v1.0)
>> to identify the target architecture through Tag_RISCV_arch.  As such,
>> it already provides an interface that the kernel will have to consume
>> (during process startup) and has to be reasonably stable. The ELF
>> auxiliary vector is closely related to and should generally follow the
>> lead of the psABI definitions (which already use this string), which
>> makes the ISA string a natural encoding for exposing this information
>> to userspace programs.
>
> There were so many breakages due to that tag we just turned it off.

I think it's still the best time to introduce breakage. There would be more
difficulties when more appication-level chips get into market.

>
>> Cheers,
>> Philipp.
>>
>>>
>>>
>>> BR
>>> Christoph
>>>
>>> [1] 
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/README
>>>
>>> >
>>> > >
>>> > >
>>> > > Vendor-extensions:
>>> > > ------------------
>>> > >
>>> > > Vendor extensions are special in their own right.
>>> > > Userspace probably will want to know about them, but we as the 
>>> kernel
>>> > > don't want to care about them too much (except as errata), as 
>>> they're
>>> > > not part of the official RISC-V ISA spec.
>>> > >
>>> > > Getting vendor extensions from the dt to userspace via hwprobe 
>>> would
>>> > > require coordination efforts and as vendors have the tendency to 
>>> invent
>>> > > things during their development process before trying to submit 
>>> changes
>>> > > upstream this likely would result in conflicts with assigned ids 
>>> down
>>> > > the road. Which in turn then may create compatibility-issues with
>>> > > userspace builds built on top of the mainline kernel or a pre-
>>> > > existing vendor kernel.
>>> > >
>>> > > The special case also is that vendor A could in theory implement an
>>> > > extension from vendor B. So this would require to actually assign
>>> > > separate hwprobe keys to vendors (key for xthead extensions, key 
>>> for
>>> > > xventana extensions, etc). This in turn would require vendors to
>>> > > come to the mainline kernel to get assigned a key (which in reality
>>> > > probably won't happen), which would then make the kernel community
>>> > > sort of an id authority.
>>> > >
>>> > >
>>> > >
>>> > >
>>> > > To address these, the attached patch series adds a second interface
>>> > > for the common case and "just" exposes the isa-string via the
>>> > > AT_BASE_PLATFORM aux vector.
>>> > >
>>> > > In the total cost of program start, parsing the string does not 
>>> create
>>> > > too much overhead. The extension list in the kernel already 
>>> contains
>>> > > the extensions list limited to the ones available on all harts and
>>> > > the string form allows us to just pipe through additional stuff 
>>> too, as
>>> > > can be seen in the example for T-Head extensions [2] .
>>> > >
>>> > > This of course does not handle the microarchitecture things that
>>> > > the hwprobe syscall provides but allows a more generalized view
>>> > > onto the available ISA extensions, so is not intended to replace
>>> > > hwprobe, but to supplement it.
>>> > >
>>> > > AT_BASE_PLATFORM itself is somewhat well established, with PPC 
>>> already
>>> > > using it to also expose a platform-specific string that identifies
>>> > > the platform in finer grain so this aux-vector field could in 
>>> theory
>>> > > be used by other OSes as well.
>>> > >
>>> > >
>>> > > A random riscv64-qemu could for example provide:
>>> > > rv64imafdcvh_zicbom_zihintpause_zbb_sscofpmf_sstc_svpbmt
>>> > >
>>> > > where a d1-nezha provides:
>>> > > 
>>> rv64imafdc_xtheadba_xtheadbb_xtheadbs_xtheadcmo_xtheadcondmov_xtheadfmemidx_xtheadint_xtheadmac_xtheadmemidx_xtheadmempair_xtheadsync
>>> > >
>>> > >
>>> > > Things to still consider:
>>> > > -------------------------
>>> > >
>>> > > Right now both hwprobe and this approach will only pass through
>>> > > extensions the kernel actually knows about itself. This should not
>>> > > necessarily be needed (but could be an optional feature for e.g. 
>>> virtualization).
>>> > >
>>> > > Most extensions don’t introduce new user-mode state that the 
>>> kernel needs to manage (e.g. new registers). Extension that do 
>>> introduce new user-mode state are usually disabled by default and 
>>> have to be enabled by S mode or M mode (e.g. FS[1:0] for the 
>>> floating-point extension). So there should not be a reason to filter 
>>> any extensions that are unknown.
>>> > >
>>> > > So it might make more sense to just pass through a curated list 
>>> (common
>>> > > set) created from the core's isa strings and remove state-handling
>>> > > extensions when they are not enabled in the kernel-side (sort of
>>> > > blacklisting extensions that need actual kernel support).
>>> > >
>>> > > However, this is a very related, but still independent discussion.
>>> > >
>>> > >
>>> > > [0] 
>>> https://lore.kernel.org/lkml/168191462224.22791.2281450562691381145.git-patchwork-notify@kernel.org/
>>> > > [1] 
>>> https://lore.kernel.org/all/605fb2fd-bda2-4922-92bf-e3e416d54398@app.fastmail.com/
>>> > > [2] These are the T-Head extensions available in _upstream_ 
>>> toolchains
>>> > >
>>> > > Heiko Stuebner (4):
>>> > >   RISC-V: create ISA string separately - not as part of cpuinfo
>>> > >   RISC-V: don't parse dt isa string to get rv32/rv64
>>> > >   RISC-V: export the ISA string of the running machine in the 
>>> aux vector
>>> > >   RISC-V: add support for vendor-extensions via AT_BASE_PLATFORM 
>>> and
>>> > >     xthead
>>> > >
>>> > >  arch/riscv/errata/thead/errata.c     | 43 ++++++++++++
>>> > >  arch/riscv/include/asm/alternative.h |  4 ++
>>> > >  arch/riscv/include/asm/elf.h         | 10 +++
>>> > >  arch/riscv/kernel/alternative.c      | 21 ++++++
>>> > >  arch/riscv/kernel/cpu.c              | 98 
>>> +++++++++++++++++++++++++---
>>> > >  5 files changed, 168 insertions(+), 8 deletions(-)
>
> From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: 
> <linux-riscv-bounces+linux-riscv=archiver.kernel.org@lists.infradead.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
>     aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from bombadil.infradead.org (bombadil.infradead.org 
> [198.137.202.133])
>     (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 
> bits))
>     (No client certificate requested)
>     by smtp.lore.kernel.org (Postfix) with ESMTPS id BE007C77B61
>     for <linux-riscv@archiver.kernel.org>; Fri, 28 Apr 2023 19:28:25 
> +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
>     d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
>     Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive: 
>
>     List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To: 
>
>     Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From: 
>
>     Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner; 
>
>     bh=qiUsRMifL8PB/090cQ9hkwb3ys/oUL3XSw2ZZFKrtEA=; 
> b=DbbWoVEuZBZ/a5XlwHI3dza4it
>     PytzZKI2cdZmHgELhPf+4qAGZgrphydCFDkhYbTk5PtHbW7hGG+YrSVkbukykZeKrsZLPO4CdVDtO 
>
>     wVy2gG/97xgtKFqaBxvDuZ4NPDoMLa9l+NCcjbiO+TLTpdGh+cAATMRKEtdy++JkMj5te2iYBd63K 
>
>     sDFjn3VC7kyZRcbm0QAJD2Ycb3XpSzrZ4ADKMX72PaJnzJRxn2yMfGKAgqvi0eQueP0Qi+fj2lfRF 
>
>     Mq/rEnpRtwsKsWK3k8+2Ic9mMInpBQ8Ef0wfqlXpeVYUZCIrG/FUY6FWn7g56Z2wXjxUzDdz9cx91 
>
>     +0nJahJA==;
> Received: from localhost ([::1] helo=bombadil.infradead.org)
>     by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
>     id 1psTlR-00BdNo-1c;
>     Fri, 28 Apr 2023 19:28:17 +0000
> Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
>     by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
>     id 1psTlN-00BdM1-0d
>     for linux-riscv@lists.infradead.org;
>     Fri, 28 Apr 2023 19:28:15 +0000
> Received: by mail-pf1-x431.google.com with SMTP id 
> d2e1a72fcca58-63b60365f53so483325b3a.0
>        for <linux-riscv@lists.infradead.org>; Fri, 28 Apr 2023 
> 12:28:10 -0700 (PDT)
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682710090; 
> x=1685302090;
> h=content-transfer-encoding:mime-version:message-id:to:from:cc
> :in-reply-to:subject:date:from:to:cc:subject:date:message-id
>         :reply-to;
>        bh=GJpVuRcfHsCG2v4maffZs947FjocQJccsdJlIfc4SQo=;
> b=kxBRY5VjYpEUqWEJdZGEhqUbeZgTPhMox1HPGb7MtRw2we/mZrM5NbSAurMqEJh9Ba
> T93E3GJ33v6KwI+GnuBU/GwO6esiae1RH76U1vWOIVBvRPb4cQtymxm98CzI+N8y/Bnt
> lxGXnlh/aZRWqRDsEkQn0G+PIUwbkbkHi6seU25MNKMS0DwEi+SFzkyoL2J3aLHfhH0N
> b9SizsBrbxFQRs6M+YP5PzVvQa0fafFj0RVRz5RU0v9djRRnm+p9DeO/7/xXoN7VoBuD
> r+/CpNsiEnYbk5KW6lM6gLWrMeqDoXnD/1Y0UWTwD+43iQjdlxiVkegpfCYBK3wE+4fx
>         tStw==
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>        d=1e100.net; s=20221208; t=1682710090; x=1685302090;
> h=content-transfer-encoding:mime-version:message-id:to:from:cc
> :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
>         :message-id:reply-to;
>        bh=GJpVuRcfHsCG2v4maffZs947FjocQJccsdJlIfc4SQo=;
> b=HWh3NZNLpyQXEFYjVCZOvA/3PwCNLsOPvi0WrEx3oYvmRY0tMphpLxB5qeHfQUXfcc
> oon44SnVAzvoIL1UY467XbZhtE//2xl3i9pcb4Y5RjHdmHZQ+zA69Z+JSscCNnRbo8Lw
> iS7K9S6+u7BIgKIwywxSQK4stEZuEXvY6ghfFOQenFxifUsQENzNzx7OdmPToeT3z3SL
> Lt/J+um9ZcGv5S97mapN0/FN81+8PuuPXAeVOhsRABNiy3ODOjic8T6fN4o9xbA/GnhS
> SiM3/t17r1+Uqn7ypUMSj7hVscApvbc/JcPjm0cvH0xcTcA462BdfQw2tmJ1mYhZDl75
>         GcDg==
> X-Gm-Message-State: 
> AC+VfDyKLBOwQyQzw6Buvr5uNZyu0qyoqsFzC88R9lXE3DUNyk2EVYpX
>     b0mxRLFkV7G5FjwuNcThUW/9Fw==
> X-Google-Smtp-Source: 
> ACHHUZ54sNJJrEDjap5svpb3evyFloFbSpcOjPcn3vyiLs1cvhb7wSZNDdm05pVyleN4FPyGPOKUpQ==
> X-Received: by 2002:a05:6a00:ccc:b0:63f:125f:9595 with SMTP id 
> b12-20020a056a000ccc00b0063f125f9595mr9761351pfv.9.1682710089930;
>        Fri, 28 Apr 2023 12:28:09 -0700 (PDT)
> Received: from localhost ([135.180.227.0])
>        by smtp.gmail.com with ESMTPSA id 
> f7-20020a056a00228700b0062d7c0ccb3asm15542149pfe.103.2023.04.28.12.28.09
>        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
>        Fri, 28 Apr 2023 12:28:09 -0700 (PDT)
> Date: Fri, 28 Apr 2023 12:28:09 -0700 (PDT)
> X-Google-Original-Date: Fri, 28 Apr 2023 12:28:06 PDT (-0700)
> Subject: Re: [PATCH 0/4] Expose the isa-string via the 
> AT_BASE_PLATFORM aux vector
> In-Reply-To: 
> <CAAeLtUCirBPHS+8qbeNy+4W=dzR_My58xxFMUnObRRwp=XXbsQ@mail.gmail.com>
> CC: christoph.muellner@vrull.eu, heiko@sntech.de, 
> linux-riscv@lists.infradead.org,
>  Paul Walmsley <paul.walmsley@sifive.com>, kito.cheng@sifive.com, 
> jrtc27@jrtc27.com,
>  Conor Dooley <conor.dooley@microchip.com>, matthias.bgg@gmail.com, 
> heinrich.schuchardt@canonical.com,
>  greentime.hu@sifive.com, nick.knight@sifive.com, Richard Henderson 
> <richard.henderson@linaro.org>,
>  Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
> heiko.stuebner@vrull.eu
> From: Palmer Dabbelt <palmer@dabbelt.com>
> To: philipp.tomsich@vrull.eu
> Message-ID: <mhng-7497491e-b83c-42e4-8ef7-d18c847298e5@palmer-ri-x1c9>
> Mime-Version: 1.0 (MHng)
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) 
> MR-646709E3 X-CRM114-CacheID: sfid-20230428_122813_455126_007C24EA 
> X-CRM114-Status: GOOD (  64.39  )
> X-BeenThere: linux-riscv@lists.infradead.org
> X-Mailman-Version: 2.1.34
> Precedence: list
> List-Id: <linux-riscv.lists.infradead.org>
> List-Unsubscribe: 
> <http://lists.infradead.org/mailman/options/linux-riscv>,
> <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
> List-Post: <mailto:linux-riscv@lists.infradead.org>
> List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
> List-Subscribe: 
> <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
> <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
> Content-Transfer-Encoding: base64
> Content-Type: text/plain; charset="utf-8"; Format="flowed"
> Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
> Errors-To: 
> linux-riscv-bounces+linux-riscv=archiver.kernel.org@lists.infradead.org
>
> T24gRnJpLCAyOCBBcHIgMjAyMyAxMTo1OTozMSBQRFQgKC0wNzAwKSwgcGhpbGlwcC50b21zaWNo 
>
> QHZydWxsLmV1IHdyb3RlOgo+IE9uIEZyaSwgMjggQXByIDIwMjMgYXQgMjA6NDgsIENocmlzdG9w 
>
> aCBNw7xsbG5lcgo+IDxjaHJpc3RvcGgubXVlbGxuZXJAdnJ1bGwuZXU+IHdyb3RlOgo+Pgo+PiBP 
>
> biBGcmksIEFwciAyOCwgMjAyMyBhdCA0OjU34oCvUE0gUGFsbWVyIERhYmJlbHQgPHBhbG1lckBk 
>
> YWJiZWx0LmNvbT4gd3JvdGU6Cj4+ID4KPj4gPiBPbiBNb24sIDI0IEFwciAyMDIzIDEyOjQ5OjA3 
>
> IFBEVCAoLTA3MDApLCBoZWlrb0BzbnRlY2guZGUgd3JvdGU6Cj4+ID4gPiBGcm9tOiBIZWlrbyBT 
>
> dHVlYm5lciA8aGVpa28uc3R1ZWJuZXJAdnJ1bGwuZXU+Cj4+ID4gPgo+PiA+ID4gVGhlIGh3cHJv 
>
> YmluZyBpbmZyYXN0cnVjdHVyZSB3YXMgbWVyZ2VkIHJlY2VudGx5IFswXSBhbmQgY29udGFpbnMg 
>
> YQo+PiA+ID4gbWVjaGFuaXNtIHRvIHByb2JlIGJvdGggZXh0ZW5zaW9ucyBidXQgYWxzbyBtaWNy 
>
> b2FyY2hpdGVjdXJhbCBmZWF0dXJlcwo+PiA+ID4gb24gYSBwZXItY29yZSBsZXZlbCBvZiBkZXRh 
>
> aWwuCj4+ID4gPgo+PiA+ID4gV2hpbGUgZGlzY3Vzc2luZyB0aGUgc29sdXRpb24gaW50ZXJuYWxs 
>
> eSB3ZSBpZGVudGlmaWVkIHNvbWUgcG9zc2libGUgaXNzdWVzLAo+PiA+ID4gdHJpZWQgdG8gdW5k 
>
> ZXJzdGFuZCB0aGUgdW5kZXJseWluZyBpc3N1ZSBhbmQgY29tZSB1cCB3aXRoIGEgc29sdXRpb24g 
>
> Zm9yIGl0Lgo+PiA+ID4gQWxsIHRoZXNlIGRlbGliZXJhdGlvbnMgb3ZlcmxhcHBlZCB3aXRoIGh3 
>
> cHJvYmluZyBiZWluZyBtZXJnZWQsIGJ1dCB0aGF0Cj4+ID4gPiBzaG91bGRuJ3QgcmVhbGx5IGJl 
>
> IGFuIGlzc3VlLCBhcyBib3RoIGhhdmUgdGhlaXIgdXNhYmlsaXR5IC0gc2VlIGJlbG93Lgo+PiA+ 
>
> ID4KPj4gPiA+IEFsc28gcGxlYXNlIHNlZSB0aGUgIlRoaW5ncyB0byBjb25zaWRlciIgYXQgdGhl 
>
> IGJvdHRvbSEKPj4gPiA+Cj4+ID4gPgo+PiA+ID4gUG9zc2libGUgaXNzdWVzOgo+PiA+ID4gLSB2 
>
> ZXJ5IG11Y2ggbGltaXRlZCB0byBMaW51eAo+PiA+ID4gLSBzY2hlZHVsZXJzIHJ1biBwcm9jZXNz 
>
> ZXMgb24gYWxsIGNvcmVzIGJ5IGRlZmF1bHQsIHNvIHdpbGwgbmVlZAo+PiA+ID4gICB0aGUgY29t 
>
> bW9uIHNldCBvZiBleHRlbnNpb25zIGluIG1vc3QgY2FzZXMKPj4gPiA+IC0gZWFjaCBuZXcgZXh0 
>
> ZW5zaW9ucyByZXF1aXJlcyBhbiB1YXBpIGNoYW5nZSwgcmVxdWlyaW5nIGF0IGxlYXN0Cj4+ID4g 
>
> PiAgIHR3byBwaWVjZXMgb2Ygc29mdHdhcmUgdG8gYmUgY2hhbmdlZAo+PiA+ID4gLSBhZGRpbmcg 
>
> YW5vdGhlciBleHRlbnNpb24gcmVxdWlyZXMgYSByZXZpZXcgcHJvY2VzcyAob25seSBrbm93bgo+ 
>
> PiA+ID4gICBleHRlbnNpb25zIGNhbiBiZSBleHBvc2VkIHRvIHVzZXItc3BhY2UpCj4+ID4gPiAt 
>
> IHZlbmRvciBleHRlbnNpb25zIGhhdmUgc3BlY2lhbCBuZWVkcyBhbmQgdGhlcmVmb3JlIHBvc3Np 
>
> Ymx5Cj4+ID4gPiAgIGRvbuKAmXQgZml0IHdlbGwKPj4gPiA+Cj4+ID4gPgo+PiA+ID4gTGltaXRl 
>
> ZCB0byBMaW51eDoKPj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tCj4+ID4gPgo+PiA+ID4gVGhlIHN5 
>
> c2NhbGwgYW5kIGl0cyB1YXBpIGlzIExpbnV4LXNwZWNpZmljIGFuZCBvdGhlciBPU2VzIHByb2Jh 
>
> Ymx5Cj4+ID4gPiB3aWxsIG5vdCBkZWZlciB0byBvdXIgcmV2aWV3IHByb2Nlc3MgYW5kIHJlcXVp 
>
> cmVtZW50cyBqdXN0IHRvIGdldAo+PiA+ID4gbmV3IGJpdHMgaW4uIEluc3RlYWQgbW9zdCBsaWtl 
>
> bHkgdGhleSdsbCBidWlsZCB0aGVpciBvd24gc3lzdGVtcywKPj4gPiA+IGxlYWRpbmcgdG8gZnJh 
>
> Z21lbnRhdGlvbi4KPj4gPiA+Cj4+ID4gPgo+PiA+ID4gRmVhdHVyZSBvbiBhbGwgY29yZXM6Cj4+ 
>
> ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4gPiA+Cj4+ID4gPiBBcm5kIHByZXZpb3VzbHkg 
>
> KFsxXSkgY29tbWVudGVkIGluIHRoZSBkaXNjdXNzaW9uLCB0aGF0IHRoZXJlCj4+ID4gPiBzaG91 
>
> bGQgbm90IGJlIGEgbmVlZCBmb3Igb3B0aW1pemF0aW9uIHRvd2FyZHMgaGFyZHdhcmUgd2l0aCBh 
>
> bgo+PiA+ID4gYXN5bW1ldHJpYyBzZXQgb2YgZmVhdHVyZXMuIFdlIGJlbGlldmUgc28gYXMgd2Vs 
>
> bCwgZXNwZWNpYWxseQo+PiA+ID4gd2hlbiB0YWxraW5nIGFib3V0IGFuIGludGVyZmFjZSB0aGF0 
>
> IGhlbHBzIHByb2Nlc3NlcyB0byBpZGVudGlmeQo+PiA+ID4gdGhlIG9wdGltaXplZCByb3V0aW5l 
>
> cyB0aGV5IGNhbiBleGVjdXRlLgo+PiA+ID4KPj4gPiA+IE9mIGNvdXJzZSBzZWVpbmcgaXQgd2l0 
>
> aCB0aGlzIGZpbmFsaXR5IG1pZ2h0IG5vdCB0YWtlIGludG8gYWNjb3VudAo+PiA+ID4gdGhlIHNv 
>
> bWV3aGF0IHNwZWNpYWwgbmF0dXJlIG9mIFJJU0MtViwgYnV0IG5ldmVydGhlbGVzcyBpdCBkZXNj 
>
> cmliZXMKPj4gPiA+IHRoZSBjb21tb24gY2FzZSBmb3IgcHJvZ3JhbXMgdmVyeSB3ZWxsLgo+PiA+ 
>
> ID4KPj4gPiA+IEZvciBzdGFydGVycyB0aGUgc2NoZWR1bGVyIGluIGl0cyBkZWZhdWx0IGJlaGF2 
>
> aW91ciwgd2lsbCB0cnkgdG8gdXNlIGFueQo+PiA+ID4gYXZhaWxhYmxlIGNvcmUsIHNvIHRoZSBz 
>
> dGFuZGFyZCBwcm9ncmFtIGJlaGF2aW91ciB3aWxsIGFsd2F5cyBuZWVkIHRoZQo+PiA+ID4gaW50 
>
> ZXJzZWN0aW9uIG9mIGF2YWlsYWJsZSBleHRlbnNpb25zIG92ZXIgYWxsIGNvcmVzLgo+PiA+ID4K 
>
> Pj4gPiA+Cj4+ID4gPiBMaW1pdGluZyBwcm9ncmFtIGV4ZWN1dGlvbiB0byBzcGVjaWZpYyBjb3Jl 
>
> cyB3aWxsIGxpa2VseSBhbHdheXMgYmUgYQo+PiA+ID4gc3BlY2lhbCB1c2UgY2FzZSBhbmQgYWxy 
>
> ZWFkeSByZXF1aXJlcyBMaW51eC1zcGVjaWZpYyBzeXNjYWxscyB0bwo+PiA+ID4gc2VsZWN0IHRo 
>
> ZSBzZXQgb2YgY29yZXMuCj4+ID4gPgo+PiA+ID4gU28gd2hpbGUgaXQgY2FuIGNvbWUgaW4gaGFu 
>
> ZHkgdG8gZ2V0IHBlci1jb3JlIGluZm9ybWF0aW9uIGRvd24gdGhlIHJvYWQKPj4gPiA+IHZpYSB0 
>
> aGUgaHdwcm9iaW5nIGludGVyZmFjZSwgbW9zdCBwcm9ncmFtcyB3aWxsIGp1c3Qgd2FudCB0byBr 
>
> bm93IGlmCj4+ID4gPiB0aGV5IGNhbiB1c2UgYSBleHRlbnNpb24gb24ganVzdCBhbnkgY29yZS4K 
>
> Pj4gPiA+Cj4+ID4gPgo+PiA+ID4gUmV2aWV3IHByb2Nlc3M6Cj4+ID4gPiAtLS0tLS0tLS0tLS0t 
>
> LS0KPj4gPiA+Cj4+ID4gPiBUaGVyZSBhcmUgc28gbWFueSAobXVsdGktbGV0dGVyLSlleHRlbnNp 
>
> b25zIGFscmVhZHkgd2l0aCBldmVuIG1vcmUgaW4KPj4gPiA+IHRoZSBwaXBlbGluZS4gVG8gZXhw 
>
> b3NlIGFsbCBvZiB0aGVtLCBlYWNoIHdpbGwgcmVxdWlyZSBhIHJldmlldyBwcm9jZXNzCj4+ID4g 
>
> PiBhbmQgdWFwaSBjaGFuZ2UgdGhhdCB3aWxsIG1ha2UgZGVmaW5pbmcgYWxsIG9mIHRoZW0gc2xv 
>
> dyBhcyB0aGUKPj4gPiA+IGtlcm5lbCBuZWVkcyBwYXRjaGluZyBhZnRlciB3aGljaCB1c2Vyc3Bh 
>
> Y2UgbmVlZHMgdG8gc3luYyBpbiB0aGUgbmV3Cj4+ID4gPiBhcGkgaGVhZGVyLgo+PiA+Cj4+ID4g 
>
> VGhlIHdob2xlIHJlYXNvbiB3ZSdyZSBkb2luZyBod3Byb2JlIHdpdGggYml0bWFwcyBpcyBiZWFj 
>
> dXNlIHRoZSBJU0EKPj4gPiBzdHJpbmdzIGFyZSBub3QgYSBzdGFibGUgaW50ZXJmYWNlLCBhbmQg 
>
> dGh1cyBhcmUgbm90IHN1aXRhYmxlIGZvcgo+PiA+IGJ1aWxkaW5nIHVBQkkgYXJvdW5kLgo+Pgo+ 
>
> PiBUaGUgSVNBIHN0cmluZyBpcyB0aGUgbWFpbiBkZXNjcmlwdGlvbiBvZiB0aGUgUklTQy1WIElT 
>
> QSB0aGF0IGEKPj4gc3lzdGVtL2NvcmUvaGFydCBpbXBsZW1lbnRzLiBJdCBpcyBzdWl0YWJsZSBh 
>
> bmQgc3RhYmxlIGVub3VnaCBmb3IgYWxsIHRvb2xjaGFpbgo+PiBjb21wb25lbnRzICgtbWFyY2gg 
>
> c3RyaW5nLCBFTEYgaGVhZGVyLCBldGMuKS4KPj4gSXQgaXMgYWxzbyB1c2VkIGluIHRoZSBEVEIg 
>
> dGhhdCB0aGUga2VybmVsIHVzZXMgdG8gaWRlbnRpZnkgYXZhaWxhYmxlCj4+IGV4dGVuc2lvbnMu 
>
> Cj4+IFNvIGl0IGlzIHJlYXNvbmFibGUgdG8gYXJndWUgdGhhdCBpdCBpcyBnb29kIGVub3VnaCBm 
>
> b3IgYWxsIHJ1bnRpbWUgY29tcG9uZW50cy4KPj4gQWxzbywgSSBkb24ndCBzZWUgYW55IGV2aWRl 
>
> bmNlIHRoYXQgdXNlcnMgYXJlIGFmZmVjdGVkIGJ5IGFueSBzdGFiaWxpdHkgaXNzdWVzCj4+IG9m 
>
> IHRoZSBJU0Egc3RyaW5ncyBpbiB0aGUgaW50ZXJmYWNlcyB3aGVyZSBpdCBpcyB1c2VkIGF0IHRo 
>
> ZSBtb21lbnQuCj4+IFF1aXRlIHRoZSBvcHBvc2l0ZSwgdXNlcnMgYXJlIGV4cGVjdGluZyBJU0Eg 
>
> c3RyaW5nIGludGVyZmFjZXMgZXZlcnl3aGVyZQo+PiBiZWNhdXNlIG9mIGV4aXN0aW5nIGludGVy 
>
> ZmFjZXMuCj4+Cj4+IEJlc2lkZXMgdGhhdCwgYWxzbyB0aGUga2VybmVsIHN0YWJsZSBBQkkgZG9j 
>
> dW1lbnRhdGlvbiBhbGxvd3MgY2hhbmdlczoKPj4gICAiVXNlcnNwYWNlIHByb2dyYW1zIGFyZSBm 
>
> cmVlIHRvIHVzZSB0aGVzZQo+PiAgIGludGVyZmFjZXMgd2l0aCBubyByZXN0cmljdGlvbnMsIGFu 
>
> ZCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGZvcgo+PiAgIHRoZW0gd2lsbCBiZSBndWFyYW50ZWVk 
>
> IGZvciBhdCBsZWFzdCAyIHllYXJzLiIgWzFdCj4+IEkgZGlkIG5vdCBjb21lIGFjcm9zcyBhbnkg 
>
> aXNzdWVzIGluIHRoZSBSSVNDLVYgSVNBIHN0cmluZyB0aGF0IHdvdWxkIHZpb2xhdGUKPj4gdGhl 
>
> c2UgcmVxdWlyZW1lbnRzLiBEaWQgeW91PyBGdXJ0aGVyLCB0aGUgdkRTTyBpcyBjb3ZlcmVkIGJ5 
>
> IHRoZSBzdGFibGUgQUJJCj4+IHJlcXVpcmVtZW50cywgYnV0IG5vdCB0aGUgYXV4aWxpYXJ5IHZl 
>
> Y3Rvci4gVGhpcyBkb2VzIG5vdCBpbXBseSB0aGF0IGFuIElTQQo+PiBzdHJpbmcgaW50ZXJmYWNl 
>
> IGluIHRoZSBhdXggdmVjdG9yIGRvZXMgbm90IGhhdmUgdG8gYmUgc3RhYmxlIGF0IGFsbCwgYnV0 
>
> IHRoZXJlCj4+IGlzIGNlcnRhaW5seSBlbm91Z2ggcm9vbSBmb3IgYW55IElTQSBleHRlbnNpb24g 
>
> ZXJyYXRhIHRoYXQgbWF5IHBvcCB1cCBpbiB0aGUKPj4gZnV0dXJlLiBPdGhlciBhcmNoaXRlY3R1 
>
> cmVzIGNhbiBsaXZlIHdpdGggdGhhdCByaXNrIGFzIHdlbGwuCj4KPiBUbyBwcm92aWRlIGEgc2xp 
>
> Z2h0bHkgZGlmZmVyZW50IHBlcnNwZWN0aXZlLCBhcnJpdmluZyBhdCBhIHNpbWlsYXIgY29uY2x1 
>
> c2lvbi4uLgo+Cj4gVGhlIElTQSBzdHJpbmcgaXMgcGFydCBvZiB0aGUgcHNBQkkgKHNlZQo+IGh0 
>
> dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi1ub24taXNhL3Jpc2N2LWVsZi1wc2FiaS1kb2MvcmVsZWFz 
>
> ZXMvdGFnL3YxLjApCj4gdG8gaWRlbnRpZnkgdGhlIHRhcmdldCBhcmNoaXRlY3R1cmUgdGhyb3Vn 
>
> aCBUYWdfUklTQ1ZfYXJjaC4gIEFzIHN1Y2gsCj4gaXQgYWxyZWFkeSBwcm92aWRlcyBhbiBpbnRl 
>
> cmZhY2UgdGhhdCB0aGUga2VybmVsIHdpbGwgaGF2ZSB0byBjb25zdW1lCj4gKGR1cmluZyBwcm9j 
>
> ZXNzIHN0YXJ0dXApIGFuZCBoYXMgdG8gYmUgcmVhc29uYWJseSBzdGFibGUuIFRoZSBFTEYKPiBh 
>
> dXhpbGlhcnkgdmVjdG9yIGlzIGNsb3NlbHkgcmVsYXRlZCB0byBhbmQgc2hvdWxkIGdlbmVyYWxs 
>
> eSBmb2xsb3cgdGhlCj4gbGVhZCBvZiB0aGUgcHNBQkkgZGVmaW5pdGlvbnMgKHdoaWNoIGFscmVh 
>
> ZHkgdXNlIHRoaXMgc3RyaW5nKSwgd2hpY2gKPiBtYWtlcyB0aGUgSVNBIHN0cmluZyBhIG5hdHVy 
>
> YWwgZW5jb2RpbmcgZm9yIGV4cG9zaW5nIHRoaXMgaW5mb3JtYXRpb24KPiB0byB1c2Vyc3BhY2Ug 
>
> cHJvZ3JhbXMuCgpUaGVyZSB3ZXJlIHNvIG1hbnkgYnJlYWthZ2VzIGR1ZSB0byB0aGF0IHRhZyB3 
>
> ZSBqdXN0IHR1cm5lZCBpdCBvZmYuCgo+IENoZWVycywKPiBQaGlsaXBwLgo+Cj4+Cj4+Cj4+IEJS 
>
> Cj4+IENocmlzdG9waAo+Pgo+PiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xp 
>
> bnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvRG9jdW1lbnRhdGlvbi9BQkkv 
>
> UkVBRE1FCj4+Cj4+ID4KPj4gPiA+Cj4+ID4gPgo+PiA+ID4gVmVuZG9yLWV4dGVuc2lvbnM6Cj4+ 
>
> ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0KPj4gPiA+Cj4+ID4gPiBWZW5kb3IgZXh0ZW5zaW9ucyBh 
>
> cmUgc3BlY2lhbCBpbiB0aGVpciBvd24gcmlnaHQuCj4+ID4gPiBVc2Vyc3BhY2UgcHJvYmFibHkg 
>
> d2lsbCB3YW50IHRvIGtub3cgYWJvdXQgdGhlbSwgYnV0IHdlIGFzIHRoZSBrZXJuZWwKPj4gPiA+ 
>
> IGRvbid0IHdhbnQgdG8gY2FyZSBhYm91dCB0aGVtIHRvbyBtdWNoIChleGNlcHQgYXMgZXJyYXRh 
>
> KSwgYXMgdGhleSdyZQo+PiA+ID4gbm90IHBhcnQgb2YgdGhlIG9mZmljaWFsIFJJU0MtViBJU0Eg 
>
> c3BlYy4KPj4gPiA+Cj4+ID4gPiBHZXR0aW5nIHZlbmRvciBleHRlbnNpb25zIGZyb20gdGhlIGR0 
>
> IHRvIHVzZXJzcGFjZSB2aWEgaHdwcm9iZSB3b3VsZAo+PiA+ID4gcmVxdWlyZSBjb29yZGluYXRp 
>
> b24gZWZmb3J0cyBhbmQgYXMgdmVuZG9ycyBoYXZlIHRoZSB0ZW5kZW5jeSB0byBpbnZlbnQKPj4g 
>
> PiA+IHRoaW5ncyBkdXJpbmcgdGhlaXIgZGV2ZWxvcG1lbnQgcHJvY2VzcyBiZWZvcmUgdHJ5aW5n 
>
> IHRvIHN1Ym1pdCBjaGFuZ2VzCj4+ID4gPiB1cHN0cmVhbSB0aGlzIGxpa2VseSB3b3VsZCByZXN1 
>
> bHQgaW4gY29uZmxpY3RzIHdpdGggYXNzaWduZWQgaWRzIGRvd24KPj4gPiA+IHRoZSByb2FkLiBX 
>
> aGljaCBpbiB0dXJuIHRoZW4gbWF5IGNyZWF0ZSBjb21wYXRpYmlsaXR5LWlzc3VlcyB3aXRoCj4+ 
>
> ID4gPiB1c2Vyc3BhY2UgYnVpbGRzIGJ1aWx0IG9uIHRvcCBvZiB0aGUgbWFpbmxpbmUga2VybmVs 
>
> IG9yIGEgcHJlLQo+PiA+ID4gZXhpc3RpbmcgdmVuZG9yIGtlcm5lbC4KPj4gPiA+Cj4+ID4gPiBU 
>
> aGUgc3BlY2lhbCBjYXNlIGFsc28gaXMgdGhhdCB2ZW5kb3IgQSBjb3VsZCBpbiB0aGVvcnkgaW1w 
>
> bGVtZW50IGFuCj4+ID4gPiBleHRlbnNpb24gZnJvbSB2ZW5kb3IgQi4gU28gdGhpcyB3b3VsZCBy 
>
> ZXF1aXJlIHRvIGFjdHVhbGx5IGFzc2lnbgo+PiA+ID4gc2VwYXJhdGUgaHdwcm9iZSBrZXlzIHRv 
>
> IHZlbmRvcnMgKGtleSBmb3IgeHRoZWFkIGV4dGVuc2lvbnMsIGtleSBmb3IKPj4gPiA+IHh2ZW50 
>
> YW5hIGV4dGVuc2lvbnMsIGV0YykuIFRoaXMgaW4gdHVybiB3b3VsZCByZXF1aXJlIHZlbmRvcnMg 
>
> dG8KPj4gPiA+IGNvbWUgdG8gdGhlIG1haW5saW5lIGtlcm5lbCB0byBnZXQgYXNzaWduZWQgYSBr 
>
> ZXkgKHdoaWNoIGluIHJlYWxpdHkKPj4gPiA+IHByb2JhYmx5IHdvbid0IGhhcHBlbiksIHdoaWNo 
>
> IHdvdWxkIHRoZW4gbWFrZSB0aGUga2VybmVsIGNvbW11bml0eQo+PiA+ID4gc29ydCBvZiBhbiBp 
>
> ZCBhdXRob3JpdHkuCj4+ID4gPgo+PiA+ID4KPj4gPiA+Cj4+ID4gPgo+PiA+ID4gVG8gYWRkcmVz 
>
> cyB0aGVzZSwgdGhlIGF0dGFjaGVkIHBhdGNoIHNlcmllcyBhZGRzIGEgc2Vjb25kIGludGVyZmFj 
>
> ZQo+PiA+ID4gZm9yIHRoZSBjb21tb24gY2FzZSBhbmQgImp1c3QiIGV4cG9zZXMgdGhlIGlzYS1z 
>
> dHJpbmcgdmlhIHRoZQo+PiA+ID4gQVRfQkFTRV9QTEFURk9STSBhdXggdmVjdG9yLgo+PiA+ID4K 
>
> Pj4gPiA+IEluIHRoZSB0b3RhbCBjb3N0IG9mIHByb2dyYW0gc3RhcnQsIHBhcnNpbmcgdGhlIHN0 
>
> cmluZyBkb2VzIG5vdCBjcmVhdGUKPj4gPiA+IHRvbyBtdWNoIG92ZXJoZWFkLiBUaGUgZXh0ZW5z 
>
> aW9uIGxpc3QgaW4gdGhlIGtlcm5lbCBhbHJlYWR5IGNvbnRhaW5zCj4+ID4gPiB0aGUgZXh0ZW5z 
>
> aW9ucyBsaXN0IGxpbWl0ZWQgdG8gdGhlIG9uZXMgYXZhaWxhYmxlIG9uIGFsbCBoYXJ0cyBhbmQK 
>
> Pj4gPiA+IHRoZSBzdHJpbmcgZm9ybSBhbGxvd3MgdXMgdG8ganVzdCBwaXBlIHRocm91Z2ggYWRk 
>
> aXRpb25hbCBzdHVmZiB0b28sIGFzCj4+ID4gPiBjYW4gYmUgc2VlbiBpbiB0aGUgZXhhbXBsZSBm 
>
> b3IgVC1IZWFkIGV4dGVuc2lvbnMgWzJdIC4KPj4gPiA+Cj4+ID4gPiBUaGlzIG9mIGNvdXJzZSBk 
>
> b2VzIG5vdCBoYW5kbGUgdGhlIG1pY3JvYXJjaGl0ZWN0dXJlIHRoaW5ncyB0aGF0Cj4+ID4gPiB0 
>
> aGUgaHdwcm9iZSBzeXNjYWxsIHByb3ZpZGVzIGJ1dCBhbGxvd3MgYSBtb3JlIGdlbmVyYWxpemVk 
>
> IHZpZXcKPj4gPiA+IG9udG8gdGhlIGF2YWlsYWJsZSBJU0EgZXh0ZW5zaW9ucywgc28gaXMgbm90 
>
> IGludGVuZGVkIHRvIHJlcGxhY2UKPj4gPiA+IGh3cHJvYmUsIGJ1dCB0byBzdXBwbGVtZW50IGl0 
>
> Lgo+PiA+ID4KPj4gPiA+IEFUX0JBU0VfUExBVEZPUk0gaXRzZWxmIGlzIHNvbWV3aGF0IHdlbGwg 
>
> ZXN0YWJsaXNoZWQsIHdpdGggUFBDIGFscmVhZHkKPj4gPiA+IHVzaW5nIGl0IHRvIGFsc28gZXhw 
>
> b3NlIGEgcGxhdGZvcm0tc3BlY2lmaWMgc3RyaW5nIHRoYXQgaWRlbnRpZmllcwo+PiA+ID4gdGhl 
>
> IHBsYXRmb3JtIGluIGZpbmVyIGdyYWluIHNvIHRoaXMgYXV4LXZlY3RvciBmaWVsZCBjb3VsZCBp 
>
> biB0aGVvcnkKPj4gPiA+IGJlIHVzZWQgYnkgb3RoZXIgT1NlcyBhcyB3ZWxsLgo+PiA+ID4KPj4g 
>
> PiA+Cj4+ID4gPiBBIHJhbmRvbSByaXNjdjY0LXFlbXUgY291bGQgZm9yIGV4YW1wbGUgcHJvdmlk 
>
> ZToKPj4gPiA+ICAgICBydjY0aW1hZmRjdmhfemljYm9tX3ppaGludHBhdXNlX3piYl9zc2NvZnBt 
>
> Zl9zc3RjX3N2cGJtdAo+PiA+ID4KPj4gPiA+IHdoZXJlIGEgZDEtbmV6aGEgcHJvdmlkZXM6Cj4+ 
>
> ID4gPiAgICAgcnY2NGltYWZkY194dGhlYWRiYV94dGhlYWRiYl94dGhlYWRic194dGhlYWRjbW9f 
>
> eHRoZWFkY29uZG1vdl94dGhlYWRmbWVtaWR4X3h0aGVhZGludF94dGhlYWRtYWNfeHRoZWFkbWVt 
>
> aWR4X3h0aGVhZG1lbXBhaXJfeHRoZWFkc3luYwo+PiA+ID4KPj4gPiA+Cj4+ID4gPiBUaGluZ3Mg 
>
> dG8gc3RpbGwgY29uc2lkZXI6Cj4+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ID4g 
>
> Pgo+PiA+ID4gUmlnaHQgbm93IGJvdGggaHdwcm9iZSBhbmQgdGhpcyBhcHByb2FjaCB3aWxsIG9u 
>
> bHkgcGFzcyB0aHJvdWdoCj4+ID4gPiBleHRlbnNpb25zIHRoZSBrZXJuZWwgYWN0dWFsbHkga25v 
>
> d3MgYWJvdXQgaXRzZWxmLiBUaGlzIHNob3VsZCBub3QKPj4gPiA+IG5lY2Vzc2FyaWx5IGJlIG5l 
>
> ZWRlZCAoYnV0IGNvdWxkIGJlIGFuIG9wdGlvbmFsIGZlYXR1cmUgZm9yIGUuZy4gdmlydHVhbGl6 
>
> YXRpb24pLgo+PiA+ID4KPj4gPiA+IE1vc3QgZXh0ZW5zaW9ucyBkb27igJl0IGludHJvZHVjZSBu 
>
> ZXcgdXNlci1tb2RlIHN0YXRlIHRoYXQgdGhlIGtlcm5lbCBuZWVkcyB0byBtYW5hZ2UgKGUuZy4g 
>
> bmV3IHJlZ2lzdGVycykuIEV4dGVuc2lvbiB0aGF0IGRvIGludHJvZHVjZSBuZXcgdXNlci1tb2Rl 
>
> IHN0YXRlIGFyZSB1c3VhbGx5IGRpc2FibGVkIGJ5IGRlZmF1bHQgYW5kIGhhdmUgdG8gYmUgZW5h 
>
> YmxlZCBieSBTIG1vZGUgb3IgTSBtb2RlIChlLmcuIEZTWzE6MF0gZm9yIHRoZSBmbG9hdGluZy1w 
>
> b2ludCBleHRlbnNpb24pLiBTbyB0aGVyZSBzaG91bGQgbm90IGJlIGEgcmVhc29uIHRvIGZpbHRl 
>
> ciBhbnkgZXh0ZW5zaW9ucyB0aGF0IGFyZSB1bmtub3duLgo+PiA+ID4KPj4gPiA+IFNvIGl0IG1p 
>
> Z2h0IG1ha2UgbW9yZSBzZW5zZSB0byBqdXN0IHBhc3MgdGhyb3VnaCBhIGN1cmF0ZWQgbGlzdCAo 
>
> Y29tbW9uCj4+ID4gPiBzZXQpIGNyZWF0ZWQgZnJvbSB0aGUgY29yZSdzIGlzYSBzdHJpbmdzIGFu 
>
> ZCByZW1vdmUgc3RhdGUtaGFuZGxpbmcKPj4gPiA+IGV4dGVuc2lvbnMgd2hlbiB0aGV5IGFyZSBu 
>
> b3QgZW5hYmxlZCBpbiB0aGUga2VybmVsLXNpZGUgKHNvcnQgb2YKPj4gPiA+IGJsYWNrbGlzdGlu 
>
> ZyBleHRlbnNpb25zIHRoYXQgbmVlZCBhY3R1YWwga2VybmVsIHN1cHBvcnQpLgo+PiA+ID4KPj4g 
>
> PiA+IEhvd2V2ZXIsIHRoaXMgaXMgYSB2ZXJ5IHJlbGF0ZWQsIGJ1dCBzdGlsbCBpbmRlcGVuZGVu 
>
> dCBkaXNjdXNzaW9uLgo+PiA+ID4KPj4gPiA+Cj4+ID4gPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5l 
>
> bC5vcmcvbGttbC8xNjgxOTE0NjIyMjQuMjI3OTEuMjI4MTQ1MDU2MjY5MTM4MTE0NS5naXQtcGF0 
>
> Y2h3b3JrLW5vdGlmeUBrZXJuZWwub3JnLwo+PiA+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwu 
>
> b3JnL2FsbC82MDVmYjJmZC1iZGEyLTQ5MjItOTJiZi1lM2U0MTZkNTQzOThAYXBwLmZhc3RtYWls 
>
> LmNvbS8KPj4gPiA+IFsyXSBUaGVzZSBhcmUgdGhlIFQtSGVhZCBleHRlbnNpb25zIGF2YWlsYWJs 
>
> ZSBpbiBfdXBzdHJlYW1fIHRvb2xjaGFpbnMKPj4gPiA+Cj4+ID4gPiBIZWlrbyBTdHVlYm5lciAo 
>
> NCk6Cj4+ID4gPiAgIFJJU0MtVjogY3JlYXRlIElTQSBzdHJpbmcgc2VwYXJhdGVseSAtIG5vdCBh 
>
> cyBwYXJ0IG9mIGNwdWluZm8KPj4gPiA+ICAgUklTQy1WOiBkb24ndCBwYXJzZSBkdCBpc2Egc3Ry 
>
> aW5nIHRvIGdldCBydjMyL3J2NjQKPj4gPiA+ICAgUklTQy1WOiBleHBvcnQgdGhlIElTQSBzdHJp 
>
> bmcgb2YgdGhlIHJ1bm5pbmcgbWFjaGluZSBpbiB0aGUgYXV4IHZlY3Rvcgo+PiA+ID4gICBSSVND 
>
> LVY6IGFkZCBzdXBwb3J0IGZvciB2ZW5kb3ItZXh0ZW5zaW9ucyB2aWEgQVRfQkFTRV9QTEFURk9S 
>
> TSBhbmQKPj4gPiA+ICAgICB4dGhlYWQKPj4gPiA+Cj4+ID4gPiAgYXJjaC9yaXNjdi9lcnJhdGEv 
>
> dGhlYWQvZXJyYXRhLmMgICAgIHwgNDMgKysrKysrKysrKysrCj4+ID4gPiAgYXJjaC9yaXNjdi9p 
>
> bmNsdWRlL2FzbS9hbHRlcm5hdGl2ZS5oIHwgIDQgKysKPj4gPiA+ICBhcmNoL3Jpc2N2L2luY2x1 
>
> ZGUvYXNtL2VsZi5oICAgICAgICAgfCAxMCArKysKPj4gPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC9h 
>
> bHRlcm5hdGl2ZS5jICAgICAgfCAyMSArKysrKysKPj4gPiA+ICBhcmNoL3Jpc2N2L2tlcm5lbC9j 
>
> cHUuYyAgICAgICAgICAgICAgfCA5OCArKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4+ID4g 
>
> PiAgNSBmaWxlcyBjaGFuZ2VkLCAxNjggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCl9f 
>
> X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXJpc2N2 
>
> IG1haWxpbmcgbGlzdApsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0 
>
> cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcmlzY3YK
>
