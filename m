Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67631613B90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiJaQnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiJaQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:43:01 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011A2AE0;
        Mon, 31 Oct 2022 09:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOUkkxjFe88ogJRVYiDg73fx2SpLEJ2Wc+v+5sqwEOAtrnZrkpk+sJWch1saagj4OgPT7OujMfsk76FEYMT/XRTMxheRU/HWTQlQYGnQKYfM/ynpRZEoUGVpkJ8YbJ6PBye2zpXS43jzR7OvVtq7W28sLTz4Dw/ockDLVNG0x3pZX2EvHPxMeTnp4dFkefW8NYK0jDMRI3gXVNh25wzQoTmyFATEO593o9bQyQJ+RLKfr2NCC7+ktiG1QpTnYaPNInWjoNkMftHfeUVPdTXSYzu1gaR1ACvWmkU8So56XQRzsY8T/1eGiMol+U/eHN1SXm0p7vNNyCRQmJ4B+VY8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bd6OxvHy0mvXK3rx0XLlIizZtRUih0XMj3dQSeistg=;
 b=Fct+MnjE8pIS7dKMPpQAM3HSObVWmmeDsuW+ThuAcpCVQB5VvTaRLmNEofAkOzt1m1OjTTCb5tjl+cJmdSCwv3vGs7BYMmdu0AhT4fG66E7uIk/QolDNhGEZnbxaNM2dA33EnIp/nNfOCO/f/zsO+Ix4Fmqkh/eBXxSYMJ2zzyAPyA3Ii22MiH7m4QXolP6Bd7T4RGB0Jo6VlrD7lHU79qIqspht6kPi93sx3QuGWZJaK/ZsZmoCZUmrAa3iUPguZqlzlh8MT/gfuYe7kP42j+B9v135uClrn9ssWBvRrCc2dVlHzI98qzmCKPdm6xmjW1BF8Wjj1WHkCQlOndyB1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bd6OxvHy0mvXK3rx0XLlIizZtRUih0XMj3dQSeistg=;
 b=Rqa/kXaRUoLjdZQV7PHgIaAzlTeCEcw2ALCWS/rg1ua4RPWQ/5vmJlxEFl5wUHNPnUfphDnNh0fkzC3EXYmcWSWzsUHm+u14DxvcAFpUtlOGvlLkFkvfpcC5mJSN7LX1+P+XYVbqtfiOzqjHHl4Hb8UpgL4SD7MENBRjXNpSl6TvTGuS5klEnZx43sR8MB8VyrYngMlmNcrahcSTUXJDYwjmkUFkP++SfH/ecdtBXMiOVGKoTLUNoi98VWC+kOhWvcdRlxgAjVEo5XdWqUt1pPX7HE+DQaNphuMA1mYuIIPfkm0ufptd6sWNhDAJAWXzGUwgkkl3cqwiN+QwKqA35A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Mon, 31 Oct
 2022 16:42:58 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e%3]) with mapi id 15.20.5769.021; Mon, 31 Oct 2022
 16:42:58 +0000
Message-ID: <4f9c9632-7c2c-b397-5fc0-f2519edf5f0a@nvidia.com>
Date:   Mon, 31 Oct 2022 22:12:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mperttunen@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221027051214.22003-1-vidyas@nvidia.com>
 <20221027051214.22003-2-vidyas@nvidia.com>
 <20221031163316.GA2968837-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20221031163316.GA2968837-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|DM4PR12MB5072:EE_
X-MS-Office365-Filtering-Correlation-Id: 175ecd1a-51b3-4dc7-9890-08dabb5ef7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ahenwqVpBdcWQVyBAFelJcZUhtpiN8uaGsLrwzj+wbdUNx34qoHeEqD1trBX/lOZ5QS8G85CTcRvsCkFjp823QvmrjDDo0D23PrCXT2kV3IrjGOlUSaXP6pQYOqFIPMsFSNIzLg22u4D+Vy8QP90/25iPqfPhDNqS06Fgo2CVLzSUEDAh4ysfIVxrOaxjaQ/XbwpYCqvy+Abxv4Hpi4TIfC2BQDOA7sabRQYjRMA7VE5ZeYh0Qya4ijz0lSEXy0tY5RN0oJoWf1UZRrwCRodpHQaN3sU+oppRY7brm7cNGB67hlLd7B/ykF+27sH5F34oowexYASkdK2aONzFeycRSbm0fAowORO40tvgmdYzReQZ5fYB4BFMsiSW/ck5rBRkHGxT+tVyHTH2rFFihJh7DQsA8AXxZePBtTjq/BAFQ+guZaAuErH1vHpjnQ9SKcbo3GuQ7npCJQMrjJimGsELVXGHKqjIvSAvVV94eZ+wkmTVqjk7o7dZpGyD+EPY+ayUBxIDyYTRc6o02gxWmxn8g/wyWBWrmJSJEoUY9qS3DmxsksnDfXvg+J8NAfchmNDfA14MXdNN4K6Se1dgYMRNvg3jsPLnI9NUR9DJe6oUcRnl4+R3Ns9wNsUKyo91TYB2TCLcITXU1uFH43OtutUVqp6d/XTVFamcdi/MjDzx/r0Q89Dtq980gfaU8J6HAmPfDij2dBvCXNJkI4u3FnYq/iwLxY0tlyG53dKtpsZ4paD8NQyEbFHvngBaitv3wY6+bD+IOr/3Ate4dvEuIjya5w0Dl5OlruqIY2OLInmjDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199015)(83380400001)(86362001)(31696002)(38100700002)(5660300002)(2906002)(8936002)(66946007)(8676002)(4326008)(41300700001)(66556008)(6506007)(53546011)(2616005)(6666004)(186003)(6512007)(26005)(316002)(66476007)(6916009)(6486002)(478600001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFPeWVJWTV5RmhIUWxENkYwOHNRVzJ1T0hSR1BDdUtwQ3dtMjdzTXAvT21x?=
 =?utf-8?B?Ui81RVNzTVdDYmgyOUc1OG02cVFLRktsb2RTZHNQVFE2a1IyNm1DYXZYVlc0?=
 =?utf-8?B?NDB0NzNQTldGeTZqM1lrTjRRK0xLa1JPd3RaQS8zdVFHYmM3NFBVU3EvYk52?=
 =?utf-8?B?dU5kR1ljbmJ6SUR1bU93aWdnV3hUN3d6bDZqMDJDQm9qazhDV3VlYk40UVNT?=
 =?utf-8?B?QlA3NnlZa3dNZDFWMUhwbGlGbkdaWThOU3FUb2lEK0FTckloaW16RUJaMVk2?=
 =?utf-8?B?bVAxaVROaW9QMjNSN3o2RDMwTjBvZTFoVmdEUXJ0WWVPc1pFaGgyWU9iNzNW?=
 =?utf-8?B?Z3dlQUtlNjBtT21XRDhkTnRPbTJxTkVrb01XVTFsUEplS01teHNxTVRFWWh5?=
 =?utf-8?B?MmNGSUk5bE5oNWpKYU04aW5pMGkxSm1yNGZWRkxzeDRpQnFqS09zakJrZTRR?=
 =?utf-8?B?OENxK3diYVNNU0dzRHBuNXhnckpaTi93VUlpZUFFTzl0SVFZT2plcXJ5TG9x?=
 =?utf-8?B?anQ1RzJJQ0I5Q1dtaTllaUQwSnM0d05iNE5Ic2NFeitaUWN0VjR0QVo0bUtV?=
 =?utf-8?B?bUcvK2RHazUyR2NLMUVYQ2JvOFlVaWZYanQ4TWp2bkpZbmQ1ZW40UVh3aGVS?=
 =?utf-8?B?Umd5N0VjOThwWVR5bVhwQWxvS05qenFIZ2t0RjVWbGlyeERVKzRSWXFLdUpZ?=
 =?utf-8?B?VzNneFdncCtvZ0E1UFZRcG5zRnJsSDNWYUZRUEEzVkNKa3VjRzJscEppSVpN?=
 =?utf-8?B?OUVoRUZ0NmNYd1haSXEvUUl4MVN0RWtQMkZud250REJqaFA1dGVMMnlwb0JV?=
 =?utf-8?B?K0pjRUtOcXRnUm5yNy9CSTZydTg4dkVVTnlLM3Uyb2xGTEM3RHVoaGs3WExw?=
 =?utf-8?B?ZXZvNWx0U1JoQlgvVHZmTThHSS93bFVtekVFbEcyWnBoRDlLRHBndUJ5L2xJ?=
 =?utf-8?B?aEpkZ01yMzhIN1MyYlN2b3p6MEIyMTA0NGhnNzVLVmxEQ01Ta0d5ZDd0YjZV?=
 =?utf-8?B?eDQ1dmtDZXVTdkpBQzZtVTJXZXRQQ29MWFRnTDhpMkVQWGNqS0FxRlZTTHZM?=
 =?utf-8?B?M0tRbDQzUVEzcVlOY05MV2xWais4WUFudXozeENlRlFnakFtNDhGRzhQNll1?=
 =?utf-8?B?MGZRZ0tLNVFLSTRtaUdwckhkR3NRQTIwZlBvc1ZaQXJSTUVpa3RvMlE0S1RN?=
 =?utf-8?B?a1lYTzNvdndFa2VURWkzbHB1UkZvZ1dnY2xmNUZtdWQzQXdDSjJLdFJlYWVK?=
 =?utf-8?B?WTBXYnZNcmhnSDh4VkhIVWRpU3UvMEkydVgyS3J6RXVneCswSmdWRG9QNW96?=
 =?utf-8?B?ZEkwZS9jQm8yQXIvN3Q5TlFldnFIdGcwMVVwRG1PR1dmYlBsRVVQLzJGMHN0?=
 =?utf-8?B?ZFRyR2cwRDB4TkVCNEJPZWE0cTM1OHZjRm41ampqcGR2ZWtzbjVuU3FEdFB2?=
 =?utf-8?B?SGtuTTZrYjhRZ0RON01DcFJEMmRFeEdDMHNrUkZUYzVwRGZUOHhnRHFEOE5L?=
 =?utf-8?B?RjJuKzkxT3JzZmtlMzRzbkRDeldqQnR6U1BUVE5FWTB1MmJwa01wc2VBblJU?=
 =?utf-8?B?UUY2V2pRZUVlb09KYXBNUlVNNFpnYStiWENFSlAxcml4U3p2RWYrdnJpTjd5?=
 =?utf-8?B?R1ZCSlVuNTNOUmEzWXpHVmZheXU4alNtSE5IZC9pQ0ZqYzlDZnVyamJrcnFY?=
 =?utf-8?B?NnNRaDA5WS96VVlIR09VSFREcWRmc0xHWmFtcU81MnZMK1YwbCtmYXVxQnhs?=
 =?utf-8?B?N2doNU96NzVOMmxwM0VxQXdxQktLRS9BUTFJSTNPc1BCbkxCbkNyZm93QlE0?=
 =?utf-8?B?QWxacWZPUGZhV0Z0NnQxeDR5UE1RKzA0aU52R3dhMlNVb3lncTRyWHM5ckk0?=
 =?utf-8?B?RFk0TktZMGo4akVSUk1NL1YwdzA1QWhJTkhIZEN2MERSY2dvQUxzQTNKQ2R6?=
 =?utf-8?B?MlQrcnpqOXNIRktLaUpnNzJQbXMzK29nMk1JaCt1RUxJd21BbytBR0NHYkN3?=
 =?utf-8?B?U25IV0wwZXBuY3lmUkJ0T2dveDdYOGlxU3F2MEI3a3FPbWkyM0FlR2pPbitq?=
 =?utf-8?B?ZWFuNm1FY25YbGJJZXkvZXBqcVI2a3ovMXJJZm1Ecml2cmNxazNxczZvQ0pN?=
 =?utf-8?Q?SeIG4umPjWbrTszDrRXfpqHdh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175ecd1a-51b3-4dc7-9890-08dabb5ef7b5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:42:58.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vkp6027d9wEsEMSuKton0owO5Z3WucQr+8DrHPLI6MeEG67Eua/xUyiSrZlv7ouX7CiwtcFTwX4jGJbfoGOwhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2022 10:03 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Oct 27, 2022 at 10:42:13AM +0530, Vidya Sagar wrote:
>> Add support for ECAM aperture for Tegra234.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml  | 10 ++++++++--
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml          |  2 +-
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> index 75da3e8eecb9..15cc2d2055bb 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -27,6 +27,7 @@ properties:
>>         - nvidia,tegra234-pcie
>>
>>     reg:
>> +    minItems: 4
>>       items:
>>         - description: controller's application logic registers
>>         - description: configuration registers
>> @@ -35,13 +36,17 @@ properties:
>>             available for software access.
>>         - description: aperture where the Root Port's own configuration
>>             registers are available.
>> +      - description: aperture to access the configuration space through ECAM.
>> +          This is applicable only for Tegra234.
> 
> Is it really only Tegra234 or that's all you've tested or care
> about? For the former, I agree with Krzysztof.
It is applicable only for Tegra234 and not applicable for Tegra194 (I 
meant the support for ECAM itself is not there in Tegra194).
I'll address the review comments in the next version.

- Vidya Sagar

> 
> Rob
> 
