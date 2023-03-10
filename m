Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38096B3502
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCJDtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCJDtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:49:08 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FA2F2090;
        Thu,  9 Mar 2023 19:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1678420140;
  x=1709956140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2abykTWpR0ENKG55IqlsBmqaMEGn9vMFBySAdWovi1Q=;
  b=V277a5cAoMbtgr6Ex0CEkWVRcRztISZWM3wEw7oeWIwvuln7fQvdHm40
   PY1dDpto9nAjJF/01709tiX1qUu61LXIkkRpFJqG7VWgXOEGA8NbP/OwO
   JzcODEw8xHNw3/I5bwc9iTKiyScQPTKtEHFXwJRMsqhxKhVvTQHLaDB/K
   rlQDjMsjI/29jSIEu5tsuTlFHyDa8f4iVSPkamG+JCYpC/95GrZCZr1H9
   OncMirrVjCxD+HKvWIFJPn1VVlr8vv/BbJ47GiJEWraU17UAc64qfxf0x
   qyeQAsQHjWou0St5biFHMlLV5GmDNEmz7uLtSobavE/LBR+TcnQfaO9DJ
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4OIqVFcY2vEehO9BiptN/E5wl/cKLCES17G97CQ1M+O0Awo2A0inKbKwCfs7PN/xh0tKsnwBfM0MtZIesV2fr66yaWucAofM8VZLmEIY640yi8GWAqoOEG6c10FUx309pZtQ8T/zypSygDwxpfB6Wd2iZaSjYHBtNRNk2YBgLI7M64uLn8tYHyH7/0RaGijVnjR0hZtsETi0/KmBs/5ONMYIKNHlyUvSzo/N196yNVvKTIAreSoIPzuUid8r8u37A9BA46OHWRezstnqkPKrzuDhiRXNatl8vvWnIIxatzatr3MFCUlqWlgX6rhHG/t0p+qQ5OW6K+p1AISxQXeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2abykTWpR0ENKG55IqlsBmqaMEGn9vMFBySAdWovi1Q=;
 b=g8dlaXioc/6l7GTUQQGT4kMDOZzsOGcQvznrKpF/gc5GvU+lzoVG2mxQFzcSYzaYqydCxUSbFHDrX3ubkC/2jhpX1rzyvdLPeuWOTLPbj28Ttp4j8HPEd50vOy/EV+CtAHqy6QrMiwIXIbPmE1ixiXKk3dd7GSsWk3U9xhv7mfjDuxi51uMJFE6QTN4QIjueEs5vNmBKzBalQzr5HJbgwC2hvWtPytuP/j2y0RMqatJOFPmiS82+h2fd9NJpr0tb/45TfEj225wFmiWk/miLuqvfqZVB6DVmvwDmia2u0F6hFxuj3NiuyDtSbCENDzhyjn+7NU6B4IyN+8bLza28Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2abykTWpR0ENKG55IqlsBmqaMEGn9vMFBySAdWovi1Q=;
 b=ZRkws/tELJMgm2FcQnAGK9zs8AjljVtd/2VWw8QxaDpxOhcA/AmOTIKnYlkmkp7aRmkKrXTMgmmSaxx40cIQwI0vSmycQi1pC9ZCLP0HNc8h9hbQFqyPedDHKtvoWcKJu7AyPATtg8lIlY0sNonbAcM7cfdhMgOpiiQzye59zwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <b2ac2d1f-3e9b-f96d-3724-020f7140b05f@axis.com>
Date:   Fri, 10 Mar 2023 11:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: power: supply: bq256xx: Add ts-ignore
 property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <kernel@axis.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230309023926.38682-1-chenhuiz@axis.com>
 <49e67fb3-4ef9-5d50-c3e8-3c7857145bbc@linaro.org>
From:   Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <49e67fb3-4ef9-5d50-c3e8-3c7857145bbc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To DB6PR0201MB2440.eurprd02.prod.outlook.com (2603:10a6:4:35::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2440:EE_|AS4PR02MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8893479f-2993-4eec-0357-08db211a5f44
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnW3Qq2przXiHKpGQKeziBtXPlyVjlSl9/i7rUTgmsjezUGkt0dh4vgovHngu8OhEKPcWyJwFpEKjsB0XTJlCJWXGWkQHy5oWo3qCMMNgrO7hEn/gyydrDop6d66nxsCnHbMFGLFndA5DP1S6oO3R5/AFthhC/t2e2SkWT+Vd1OICJSSvsYE32877LsLgQUtAz4elfDBOT/ouspzJoPwjNad+qRIJZPcbPw1cPx2Jj2P16oWb8MSl56cS17KQ0XKAFTuYruRatVH1eNyza7VQnbrTN92Cip1EqhMg0iD3DbKd+59UB9LF69R4E62JKWZbC2qFyszIDdEbjvVPWIe8NxolOzu3h+oG7opZbooHfyQDlOxq9xgqqE5qR4NXycKwpo3VolcfOxNceYKNDOfv5tSbWvYUD3v6KtbM7898JXC2aPD4q7DZGRupiU+63dg/qlvboaLX7RbvG2NpYH0Vmoe1kCUZG4KyNxFbtjhYanmzoNv3YbvWN5go1DXVtXS32F6aotvMtUTIRLl28Mty93sbuU6QuNO0/L6W7Bt5QhS+bp7LvzH61PEz+IdnnLyjWqu4sxC4s+fInP8fCIxpHe4LpPgXXnb91KW7jzJ1DS0amMU3Bi8zCm7uH5qvsBzlZ3HWMnazm08fnGSMm5kin26ncgllyvWKqxGflRWl5BFmXfYdYCc3IzYwXH7LbJvajdTEhDS5bWp5YZRpdsy9CNfnsOlzNVR4wQPq75ttGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0201MB2440.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199018)(36756003)(110136005)(316002)(478600001)(8936002)(6486002)(5660300002)(2906002)(66476007)(8676002)(66556008)(66946007)(4326008)(41300700001)(6512007)(31696002)(38100700002)(186003)(2616005)(53546011)(6666004)(6506007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FtakQ4Yk8waHoxSkVXc1d6OFFVUWlKTG9ibTNzSzllNGpzSlRMSXVYMUtV?=
 =?utf-8?B?Q2sxNFdDMTZ4aGxuMTVpbnJKa1BGcW9oNTl4RCtGM3Qxang3cWErKzNUeGF1?=
 =?utf-8?B?SU02RWgrZkV0Q001SmEyb2IzMkZOUk1BQ0NNME5ic3FzRXc4cmphZnNPc0Js?=
 =?utf-8?B?THdMRDFQanJxOVU2Z1g2NTVBTHhsZ3hpbzUzUnNZeW1BeXM1YXBZbVd2dlJV?=
 =?utf-8?B?TFAyU29hNXJIdE0rYjk4M2ZlUTBpVEZFbTNZbVlXNHpkSFdWekdhMzgzOUcx?=
 =?utf-8?B?MVptQ3EveHVRN2NJOWJzR0RjamlCZlpFZnpsZlBBd2EybDYwK1d3dWh1VXNF?=
 =?utf-8?B?UnFHajFGMThHT21DNWt2Und1NmZLZVI1UkFRbmdvdVFXdUFtMGs4cXNsWk5D?=
 =?utf-8?B?VjV3OW5Jdi9EcDMzak9xbExkNEhTT3VQNzliTHg2MWdMLzkxeFRPSGlUYVNG?=
 =?utf-8?B?RWdqMkRpU3lQLzByL1kxU2VMU1g4M29ESmUybVFUekpuNWJlSmtPZjJRSm5s?=
 =?utf-8?B?NUlZb2NZb2RGNlJVOG5sZGNvV1JPN2FxWWoveUFVV0I5YW5sZHdQc0MwcUM4?=
 =?utf-8?B?bG1QcUVORnhOejhSZ1hlaEN4UFVVeU1kNUU5VDlkS1o0RzVNL1pydTdTU1lE?=
 =?utf-8?B?aG44ZW5BcmtvYzRnRkJCc2MxYkVlQ1piN1lZcGtacTlKUmhlYlZuRjZhUFdp?=
 =?utf-8?B?WU1VWWVXTGJKbjBEbml5YVpTUnpBNTlOMTBoeWFRbHVOUU1BbkxQbzc1TzZR?=
 =?utf-8?B?ZDNkWnlaeENQSGV6aGtISHpxZmozandjZ0dYVDgrK2FzT2pIQmNGMGFQSlNS?=
 =?utf-8?B?QjFNRFExM1VLRDl2NmlFUHRvb2FDbjJSWFZKNmZCSmVpcDRmODIzYkZNNEpH?=
 =?utf-8?B?UVRXWVZndEtNd3lFQXMrVHRETEtlaENxcXQ3QW5DUWFyMEU0MjdiallYRUxp?=
 =?utf-8?B?VEVWdmZzdzczU0lyTnpWMGExbG9TUEJ0OWhmRG5aSmJiUlFWYmFqTS8zTHlt?=
 =?utf-8?B?eVlvMTBjTmRkdlJUbUFhczJzdjdGYjhJZTd0dTk3UUlwRGQ4cFdRc2pJSnpy?=
 =?utf-8?B?NFdHSnZnc0NYb0kyczNaU05zTEFXV2w5cU5rbG9NVC9jdHJ1UlozeWJkRU1J?=
 =?utf-8?B?YjM5WlFGWWFqOGRMV0RJczNkWEpWZjNaeVp5SDRyaGlFNy9DSi81Y2lEbDlR?=
 =?utf-8?B?U2VTNURKYUV6VkZGMks4WTJPeXg3cmx6U0tNQ29qYXBZbzJVaVJZRE9jZU01?=
 =?utf-8?B?NFJrVjVBeFhNelpERWNOYWFFRHdsVTZORW94bEFxREhEem9BWlJPMGVDK3o3?=
 =?utf-8?B?Wmk0SDdQaU5qWHlTakpEYnhPUjl6RU9mbCtKU2Z0cnNxT2dYc24xRlVHaVRF?=
 =?utf-8?B?b2FyZit0dnR2bTkvdnd1TVFwMWZCbEU0d1ZjY1hnWkpCQzN1cmRPVldkRHhJ?=
 =?utf-8?B?Tk80bHpGS1o5WHVHNkI0TitqK1orYUp6aU9tcVorSUhaTTEySkEwV0VaRVNj?=
 =?utf-8?B?cUV0SU5KSjc0ZUVHZGJHS2hHOTdMY2tKdU5FNzZESDdGaUpoSHplY2JBd1RQ?=
 =?utf-8?B?VmF0cmJPQlc5TkxkNWpKQmlwa2Z5d0YzNzNsMkRpVG9LcXNzeEtqM2xLN1gz?=
 =?utf-8?B?UG9zMFh4U3dSRSs5WEN6elZJY0NUZGU2K05QazhVR3hiSlFsK3R6aDFyNC9K?=
 =?utf-8?B?M1o2UnZIWHZhTTlPNy9lVmladGExMG1EN0ZpeXRKSk8zRUVzYjNROVk3b1h5?=
 =?utf-8?B?ZFN6YlZhTzYwb2NSYjdld3FvUElZREMyNkxCRFM1OXJqU2hZZ1g3L09SdXNa?=
 =?utf-8?B?dEFUazNWaGMvcE5KTmVEbmhIbVlqclhXN2FIbnMybHNlRlduMis4Nm8yaU5u?=
 =?utf-8?B?MG5PYWdPN3Y3VlVmQThLdzRmMlRONHg2a1c2YjNNeHlLb1lMcnF6ZWU3WmlC?=
 =?utf-8?B?b01MYVdQTk81UFJFaGFlSExxYkZjMzcreXFBTDRPSjhrNldMZndzeGJvQ0kz?=
 =?utf-8?B?bUlDWDZ6bjBCcmVRUWwxemExVzFRR2p4VjkwZVdHY05EcEZPVmgvbVp6WEk0?=
 =?utf-8?B?cUp2cTZpYnBtdXVBZnU1bTJMWURIaW5ybnJabTdxYVB0SktxdlkxUDg1WTBj?=
 =?utf-8?Q?qdNVMi83H5snVRnsMe3teweY4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8893479f-2993-4eec-0357-08db211a5f44
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0201MB2440.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:48:55.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFlGFB64pn5fhP1mot9DayTheN4e1tzuEcWvo0i4hA1qd5Fp8DV3lLNqAnpsPd+/DgsVMHaWM2Go5+14xb7ACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8741
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/9 18:12, Krzysztof Kozlowski wrote:
> On 09/03/2023 03:39, Hermes Zhang wrote:
>> Add a new property: ts-ignore to allow user to enable the TS_IGNORE flag
>> in chip. Ignore TS pin will allow user to control the charging
>> parameters instead of the default JEITA profile in chip.
> You miss users of it.
Could you give some more info about what I missed?
> @@ -68,6 +68,12 @@ properties:
>         Interrupt sends an active low, 256 μs pulse to host to report the charger
>         device status and faults.
>   
> +  ts-ignore:
> Missing vendor prefix... is this generic property? ts-ignore is very
> cryptic. You should describe here rather desired system characteristic.
> Why anyone would need to use it per-board level?

OK, I will fix it. Will "ti,ignore-ts-pin" be better? Yes, it's a 
generic. To disable the TS pin, actually we also could do it from HW, 
but from software, it could be more flexble. But if HW already disable 
it, then you don't need to do it again from dts.

BTW, I find I may miss some information here: the ts-ignore feature is 
not support by all the chips list here, I will add some comment for 
which chip support it.


Best Regards,

Hermes


