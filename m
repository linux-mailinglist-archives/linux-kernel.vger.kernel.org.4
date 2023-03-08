Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1306B1145
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCHSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCHSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:45:32 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E2B4F64;
        Wed,  8 Mar 2023 10:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INduyiSJ9LHLH0H4qQH5vEugQDX1tvuyf8eS1dbAejWRefx/pPluhrv7q6nqE4CMOZ8N6hjH5wZpn2ObCQO72ifkdRwib2LJJCZGMRMMDOEHXrHUUcT7u91wHIBQyUDHwnmiqgVvrfitRS1Mwo5YjYM/BGV+f1pEOA2kdTO01Z9gru2YUU5trYATlVR8l0ExNB3vK0Neg8SViikQd8UZVWFSNKPMExJWP2GKoBIaCh+iTOMrSQOHjVt7GDcr+DBuI99K5L3IU4Dku8mJUuJlWgJx8w86s2soWCt/RfFRBRgbxVDARYhnHS4WgXV9m89suxInfQPgW2g4eIc/BlO/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E96IIZ6xmwBFS11EJWoWrl3mG+vK+PSqP630xHPNESU=;
 b=FoCMrQEg0CbtcHGc9rhDleeZUuIMdBsyjljAa3GGDlwcYeUrHqiuk8jw/3Ag7IKUGJblFxtIOvs7dNdCsEbgN3V62vXw6nkyHcXzB0bnzzpJot2iau4oZJWZ98LgAbnwjMQ2bZrr9Jf3DdzczySMkJ5ydVaiygDGyyYiHjhWm7yQRk5uIMISBs/M98w7/vtp3SSUFQixG8L/k05eDKTF2pmBAXRq1+YRJVXNq6Sxw4zfzjQ/31IJiHCfNrseMyPZZhdCoJbgtVA7typ0TrIuj6oUKMIPJpK0cIBYIOiXYN+FY0ySZiwnPr9Ka9XkOaEaOSL2Tbdiyd/T8WTPnGygUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E96IIZ6xmwBFS11EJWoWrl3mG+vK+PSqP630xHPNESU=;
 b=ktmaiFqe+rHtOpKCn1zjaCTLouXDYa4UtMxhxrC5iaWcfR6dpieK8ZALiXNpflKutvxlfbFNd6ysnBDqYBWHaVOZUBp1yUs5LAQHDX/9ugN8XkwrB+L7QdGWQjfHOW/d+8Lc1Ktdpk9YOZnqvzPNLTxcNxQfW25w8uaYSnfKdKJnS1G4WVONxC0UDHo3BjYB6jk+21zI7FYis9bTbpVfubC33p890i2LrUoOdsMRihTUC4/Roi7IalVAct+ZaTtgeluLs2OK/8k9DGj1er7HaByXPLhsEJchszEPVk4r/tMv331HVnGmcGPlewl62mNH4lv7yKhoM8jh0cLq41AUJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by PH7PR12MB6563.namprd12.prod.outlook.com (2603:10b6:510:211::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 18:45:28 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::735c:fa9:2043:279a%4]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 18:45:28 +0000
Message-ID: <7a8027c9-dc73-3684-c5f2-3071f315b3cd@nvidia.com>
Date:   Wed, 8 Mar 2023 10:45:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/6] dt-bindings: timestamp: Add Tegra234 support
To:     Krzysztof Kozlowski <krzk@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        timestamp@lists.linux.dev
References: <20230214115553.10416-1-dipenp@nvidia.com>
 <20230214115553.10416-5-dipenp@nvidia.com>
 <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: pubilc
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <3c0ad963-ce69-bd5b-20cd-888e5fbdecaf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::26) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|PH7PR12MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad0ad9b-5775-4d68-84f1-08db20054953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DSogy+WRKnzKu5DAymcBAfKlRzGJlKOB950B/wCAW3UHMXSGnQfsFLYpVZ1t8BLljU/oe/NtJuigeShN5/XN121C1u67JAgYtb3xR+a2ZOMzxk32yunq12B69S0tMSUjEwyf0675TdeYQIB5wAAcuL0LLX6riufF4iGM4U45WVBavvV3GgIJ7qn1/1wiNh1rPxV8/NmfZkcXEhh6JbCNt1sdt6z8quuscY/a6+LTnkeJXG+DDcNY3cWaYUAsGlVpnH4S+vKblHKl9RXY90CR/eGq6xAZqHgsGTm9BW5Ph/ijr/cWhUd7ydnXI/zZHIpCHizuaDicA8gGkyXvb4/PoBV7EGI0j98kfDzNyUQbZNHXOKtz26fmrY3SDRUyxibkkLicfurfXMbXFF0xGua6O2WAVxi23Z/71T/TgdbdlExRrg8Xmw3Qn2PDE1oNmXBGss42aTxGLXj+ck6CL1KMC4e/ve+93rg+rM4Zaw6Oxjqc1m6lwnt/xLctZUFh7G60irhZog+Rrs3AZsdcbHFPvDJ97/WR2L5TTLmvmB3rYX75NUAwweNSJ3dDNjuFu4rvgAKDc42/TOMLA3aX9AKuR1nNOM31legQ9dQweQeL99UlXwhIW/VrXbnlPv3QRCcfrRMMIMjyAP40+uhEgSK0d28RFV+qfQ3UbxTRGe7FpwzjDCNOTR0H6pTepTcU/0sbVCkpqwnkvnOHFjgnCGJg5OuUI+929iM6VzcYNZG/5RDR+b/lbAzJ+VIM3usBl6jkG4rpjchdo4GNuYjrCVB22Ykf/0nDn2TZsjyDsuSQ0qdzJfcHU50QZo3ZUm3GIr5+/QTl8zy/bx6Ia+8T4NBXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199018)(36756003)(26005)(8936002)(7416002)(5660300002)(53546011)(6506007)(6666004)(38100700002)(6512007)(83380400001)(186003)(2616005)(86362001)(316002)(31696002)(66556008)(41300700001)(66476007)(8676002)(6486002)(921005)(966005)(478600001)(31686004)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhVajQzM1ZHanJpQkJrK20xVDlnbURzeW4xSk5ZYy8ycFhKM056ZjdjMWVH?=
 =?utf-8?B?NzMzeE8rVmFUR08wbWdWWHZpOTlDY2M5aVlSakJaSk91bFJIN1RLc1ZuR0NY?=
 =?utf-8?B?cVFOYVZHZVl6akFBa2R5ZTdza3cvODdLKzJoVlFiYWl4aVpLYWRPNGs0ZHI1?=
 =?utf-8?B?N2NmMFVFSnI2ZW1WUHRBMXFoaTg4M3UyR0MzRHBoYnFJdUVPM2hBR2xWak1E?=
 =?utf-8?B?eVo5UVNjSnljK2JDTndNYXlyNUhMZnlMMkJxTlJ1WVF5anoxa0pzdG5xQ1Fj?=
 =?utf-8?B?a25KTitDNmRQYW91TzZKK0dKTEhWcHdLVk9MbEVrVXJFaGdOTVhhY2hHblBn?=
 =?utf-8?B?WUZKMzU5SVhYLzFOcG5KRmlwcHNIZWw0QjEzeXI0UWRmeFkvYjZ2NGYzUU1L?=
 =?utf-8?B?cXRGdk5tWTB5QWpUVklQMWU1ZTYyZ2U4Y2NWK0hoNVVYbWxCM2szZ1JZek45?=
 =?utf-8?B?R0xMU1pEaEFjSnNhMEIvbDI0RkNQK1QyZlg5ZHJGYnFGWGxGM1QyUUtiaU1Z?=
 =?utf-8?B?Mldvd2tLbWlKQjZuVDU1QndpV2VaK2dRK09JSUNhcUI4TDRCMlVDRThRcy9p?=
 =?utf-8?B?b29oeWI3S1pRYjM3d3NoYnBhS0svUUpWelR4d0V1aTBuSzlrRjhYSnZHdVRy?=
 =?utf-8?B?VlY5cmJlZGk5SFBVREhKRXFzaEVjelZ4dUFSSzhiU244eGdqREgxK2hvS1l1?=
 =?utf-8?B?U216VTl0L0VCWlkyQ1pwblhKL0lBdkk3MlBuZHdXTk5NamxaN2Z0bjhXdUgz?=
 =?utf-8?B?U0hSVGRKUmo2UDRHYUZnNkcyelowSFBMdlhDUkRDOXQ1OXN6SGI4Mjk3cnVv?=
 =?utf-8?B?bWZTZ0VpcU1SdDdxZzJ3aWlwaU9qV0prYWxvWFhTaklTRGxXTFpBVnlLK1oy?=
 =?utf-8?B?R2h5YkxZbFg5N1ErU3VzN1Y0dDk2ODhxd3dzd1pNdlB5YmhSRDAybXFUMGxK?=
 =?utf-8?B?aU1YVGpKUlpNWEVkY3R5TXlrSktIaGpoa0N3S1ZjOWsyWTZaSTBVZlhzcmRt?=
 =?utf-8?B?SldNYkxEK0o5ZzI0K3V0YUtZeTU4RitwRFdzTExhQkltdy90ekd6SHVqYnBj?=
 =?utf-8?B?ZTE0dzNXd2RGeHVwRGtYeTZoRzU5eHRGSUhnc0xvYVdBU2FrU28wWVlkSFJX?=
 =?utf-8?B?TkZRa3YxbGRsZEd6NTlyL3NPZlVKREFqTHhkT3I5bmJhazNkQk54ejNrRGF0?=
 =?utf-8?B?M2c4RlNjV1hyWi80MUlydmYzQjE4WFFVQ2ZIK2lIUGZ5eW1NTnJIdlZ2YWwy?=
 =?utf-8?B?WUJMcVVSSU5RdzFYblQyR0xOUDJabGJQaG5xYXlqMzhpOUY2ekF6NzcrdWJL?=
 =?utf-8?B?a1VKblplaUszY0ZlMXJJT21YV0JSUFFCcWxIMngwQ1JVUFIrMWk2WlVHeWM5?=
 =?utf-8?B?bmNvWDdibC8vbWpocXhJQ0Q5UDlvd0R1QzI0MWxyU0pqTldPTW9lVno5NVpa?=
 =?utf-8?B?aXNoSkxqV25OSkczVFJqUnZ1d3JvZ3dia0wvelIzRzBOOWNGU2dqb2xBVkdw?=
 =?utf-8?B?b3hLdlc3ckhYYXgrc011R2J4M0VrcEFubVhxTXB2YTlLa3RaaDdyR3hQMU1h?=
 =?utf-8?B?YXVFT0lDeU54L1M4UkI4cGlaWExVbjM4bHEvYW5xT0dMRWNrNERwZ01EY2xu?=
 =?utf-8?B?em1xNCtnMEk0Ukh4cldBL1ZwMm8vWlYrVDRLVWtKb1R2NSs4ZUpFOUZNMkpZ?=
 =?utf-8?B?RmVCMTRzMDRTbExFQlBuS3Qyd2szZVR6ei9QQmMybzk0WlBRQ1RkVlEyK05I?=
 =?utf-8?B?bFBnaVhJOVZYcTQvLzU2bGxrdCtjNXo4TUs1djFaOTNRWFh0d0M5MW9tQzFT?=
 =?utf-8?B?Rkx4SU1iYjhLajJoblBFeDRJaGNrelNnK0FPOHF6NklXR2NhRWJJQjhvZXFl?=
 =?utf-8?B?N3lVaSsya1NYMWpSdGZnMnF1TFppVlowNWl6czU4OHA0UDFPU2c1RjZRTlc5?=
 =?utf-8?B?dVQ5bTlKSFFBRlVUTFRDQXRzdW51VVpTTDdpRXVRQnFuTVR5WGRKSEFGWU9s?=
 =?utf-8?B?RTJ1a3lSK2QvWkZORHd4SWtQb1BNQkZkOWlDcnlpM1NsclMxRFVVTEFXN21T?=
 =?utf-8?B?U1JIZytnanRJd0VWdGQrZzhRekJ4RUxmVmx6ZE1ZT3Jtb3Z0L1ZHZk0zc0dr?=
 =?utf-8?Q?Ka4nDZc7RI7JnVTGtpFzMYCaC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad0ad9b-5775-4d68-84f1-08db20054953
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 18:45:28.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytB2Au/kmlslpGW1/sPBKRQxVf2y2PwOmmtwuOKnXwcdsWGvfcBx88uERixd8+E0m8ryvheYukLr/C9wHU3Icw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 6:17 AM, Krzysztof Kozlowski wrote:
> On 14/02/2023 12:55, Dipen Patel wrote:
>> Added timestamp provider support for the Tegra234 in devicetree
>> bindings.
> 
> 1. Your commit does much more. You need to explain it why you drop some
> property.
ACK, will address it next patch
> 
> 2. Bindings go before its usage (in the patchset).
Ack...
> 
> 3. Please use scripts/get_maintainers.pl to get a list of necessary
> people and lists to CC.  It might happen, that command when run on an
> older kernel, gives you outdated entries.  Therefore please be sure you
> base your patches on recent Linux kernel.
It is based on recent linux at the time patch series was sent...
> 
> 
>>
>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
>> ---
>> v2:
>> - Removed nvidia,slices property
>> - Added nvidia,gpio-controller based on review comments from Thierry,
>>   this will help simplify the  hte provider driver.
>>
>>  .../timestamp/nvidia,tegra194-hte.yaml        | 30 ++++++++++++-------
>>  1 file changed, 19 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> index c31e207d1652..d0f4ed75baee 100644
>> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/timestamp/nvidia,tegra194-hte.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Tegra194 on chip generic hardware timestamping engine (HTE)
>> +title: Tegra on chip generic hardware timestamping engine (HTE) provider
>>  
>>  maintainers:
>>    - Dipen Patel <dipenp@nvidia.com>
>> @@ -23,6 +23,8 @@ properties:
>>      enum:
>>        - nvidia,tegra194-gte-aon
>>        - nvidia,tegra194-gte-lic
>> +      - nvidia,tegra234-gte-aon
>> +      - nvidia,tegra234-gte-lic
>>  
>>    reg:
>>      maxItems: 1
>> @@ -38,14 +40,11 @@ properties:
>>      minimum: 1
>>      maximum: 256
>>  
>> -  nvidia,slices:
>> -    $ref: /schemas/types.yaml#/definitions/uint32
>> +  nvidia,gpio-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>      description:
>> -      HTE lines are arranged in 32 bit slice where each bit represents different
>> -      line/signal that it can enable/configure for the timestamp. It is u32
>> -      property and depends on the HTE instance in the chip. The value 3 is for
>> -      GPIO GTE and 11 for IRQ GTE.
>> -    enum: [3, 11]
>> +      The phandle to AON gpio controller instance. This is required to handle
>> +      namespace conversion between GPIO and GTE.
>>  
>>    '#timestamp-cells':
>>      description:
>> @@ -55,11 +54,21 @@ properties:
>>        mentioned in the nvidia GPIO device tree binding document.
>>      const: 1
>>  
>> +if:
> 
> Keep it under allOf (so you no need to re-indent it on next if statement
> in the future) and put entire allOf after "required:".
> 
Ack...
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - nvidia,tegra194-gte-aon
> 
> This is an ABI break. Does your driver handle it?
yes, handling patch is part of this patch series.
> 
>> +          - nvidia,tegra234-gte-aon
>> +then:
>> +  required:
>> +    - nvidia,gpio-controller
>> +
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>> -  - nvidia,slices
>>    - "#timestamp-cells"
> 
> 
> Best regards,
> Krzysztof
> 

