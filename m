Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2416FD800
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjEJHQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjEJHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:16:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DC6593;
        Wed, 10 May 2023 00:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jgr6/6IA6qw9ipJYF4E81RRqd2kaMScT7v7Gf17t60zDgIUK/ZuALt6ewRj3uMf4DN8OGdSnh3KA76nN/4z+wGWvobd08XX+3nEazO5PyXlHitTtmvsuapws4A7dSIcWQ1rA1H39GTtTCR7eIo5QpYGRF3XSQLUmkNnOQfRiN3x4ElIKzH+GPYvN+SlB0TYHhzac+E9gp48zxo6YahpYXDvo087GtLGY15Tq/wzlSmRzPM/tzCdpHJzuKVGOrFuLDFBbkRwlSudqur7/zDaaWK+iS6PMWjo7UksWCRZRYC/fVAZzgZkQmwEY28JL8BzgkQUfHiV+fPnS3AURHtIIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCs6TeK48CrPxgOszWxcBXSme37r7Bt3tSPDza8aDc4=;
 b=cnA4kXL6R39NBueyz7VqQW+JHPJCNJyeDhQspIxp4jI+Q4S7k/p7ckDf2QsU1lPLUGIi/wEkHFd2mTyIph5RIStIiKC0c8Ze7i7kDo3wczjMY9ph8fq4NkOMKbuW5rVF0JPGqp0Ul1Jg0q3J8h9fFd/oxu6wLzUX9Q5YPfpCzzLYvtVoAv7eEUeQpSD2bQxgHjWO7ucKRgSMl/GNDHKdZjScFO7wjpiNQogRgaMOoybDHVpinNwvLbYs2XAn0hbzxchpMMsrv13BubuYY5A/b4GHrjOF/XXMgttzh2cYYFoEm7nkG1NlXalDNvEcu7XS+3KRY/A72qm2NIClpGhjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCs6TeK48CrPxgOszWxcBXSme37r7Bt3tSPDza8aDc4=;
 b=b6+ApGYj3gT1TfUxuap8U3Q8Tvan639lP0FVu0t6tjdh5qfdaNIatsuCC+A+ALc6CLtifWMoUIkUQt1nTdpGzkFhY+sGxcccUOMYfGOEguzu1XPhUHyqYB/DgT0hryKKQ+nSvtoBak2xR7EMn8hDhWKCueicmt5HzVrJsL8DMdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 07:15:47 +0000
Received: from SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae]) by SN6PR12MB4765.namprd12.prod.outlook.com
 ([fe80::edcd:752d:df60:d4ae%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 07:15:47 +0000
Message-ID: <9da13d84-b6f0-e606-6467-a545bc308c12@amd.com>
Date:   Wed, 10 May 2023 09:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 05/23] arm64: zynqmp: Add L2 cache nodes
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <cf4ced33cb7dc8d43b79bb9d4ad6acd3b8ecc09b.1683034376.git.michal.simek@amd.com>
 <20230510065750.GD11711@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230510065750.GD11711@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::12) To SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: f00f3c63-6219-4c90-6d0b-08db5126608e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkKnjPudiUkRi0zqcNDyEr/yU3f3Ydnzxuwf/Zagng/39Ru9+vAadr+0lBfpePa4j1+XCKeaVQHdA5/ykXidsfaZCa760ikdICKcXs+uPJ+/Hzphlgy6q+lqGD2MoBURGSnwyrOgSqmmAwto//52LYcX+4iVpJv0TLpNSNZp439EbYLEC+K8+yOIQKP9dN2xKGhTOGaO8kEmY+4sbuorN7E4eh+r6b4Simxx3q8e1S/pZ2SXXwcTpv6igA6y1f4H5lZY4GSZSG9AK64k8N7fp/mYY4hTjBSS36VU+fch3Qsawwcimi3Ef4QhgjWrHH+f/Ic7uemvDPTFWSbRXgAY12JyW5klp3HqJuya3xyk2rjBx9HxnbXQorgES5jrtvGXDglaQBQVokp7iBALC3KOEAKBV8k33wy1kLcPKYHJY32ZCwdSKiCt2UhDYTzqLJ0A4sGwN+1Epf9BgMYwzZjBDmqUKtRdH5l6abSLc9WOoJfasegsECTUjJ8JtRS3M7MLRomGQEIAFJY8ESOFDx0kMn9M2Bd2VcNTvh/pzqn1yrTltP9vbrFKhx1f6u2dLF9ZSNs2t5nHCf+TQFo89kFQXoboEQCirVeeXOP1JzcPwIvMYLOGJtwSL3tHCP97zgXULP+nrP/qzHL5lGmtyaotqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199021)(6506007)(6512007)(6916009)(4326008)(66556008)(66476007)(66946007)(316002)(41300700001)(6486002)(478600001)(54906003)(31686004)(26005)(8936002)(8676002)(53546011)(5660300002)(6666004)(44832011)(7416002)(31696002)(86362001)(186003)(2906002)(2616005)(83380400001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hYcUIrREtTbzRWcExQd1YzVU5HemhCU1V4ZXZySndYR2RUZEh2Mm1oYkU1?=
 =?utf-8?B?Mm5IVnJMVnpVbENPZmdScThGTFcrU016RW5xbFRwZlgraWhJYWJycEZSaVk0?=
 =?utf-8?B?RWhLV1VxVFhZc3JkT3FSV3BZWENmbis0aklCQ0xvRmZPVnZWb0ZKam5UNjMr?=
 =?utf-8?B?ZTBGdU9yZnZ6V1ZmRDY0Z0dtRVYvWDlFak80TzViL3M1bmJFMGNwQmg0bVBQ?=
 =?utf-8?B?aldrQ1VoemdmNzZGM2RqOEwyOUlpR0FoeUdEQWJweVFVOUVXRG0yV2FmVWY5?=
 =?utf-8?B?QlVtRmJKNzZXSTM1U2R4cGdUWklnbW5YM29jSEVYcTRpZFBHTkdyNXRVSDli?=
 =?utf-8?B?MGpZYU00OUVLbkFBNVFZblNxRG9LWWxzd0crRk01VDJqQmluTm1iSHFDajV2?=
 =?utf-8?B?ak0ySXNnVlBSbXlvSFJReUJwSk1jZUxPWXI3eHNoN1B1cDZybk5mcE0wanZ5?=
 =?utf-8?B?UkRtcWdoRU5SRmwrTmdYSlZPdXVZR0wyUTFXUUxYT1Y3UkNZVnAxbkdMOHpL?=
 =?utf-8?B?QjBPOXQrRitaVnBHZk85SmltTnRHMVozc01GRXJXUlkzL3UzSEhObHNyUFY0?=
 =?utf-8?B?M1hJamF6eHVFTFVscC80QitnYXNIbFYvdFpYSE0vaTl1NUhpM1VyQlRBUE8w?=
 =?utf-8?B?Q1JFRENORGJ0YTZ2UHBadktzcitLYmZRR1ZDTk1IY2pZY0tIZDlJZ0MvZmhr?=
 =?utf-8?B?OXFxWW5Fekw3NndGdWZPTDViZVdKRVdZL1hKZDZGNzE1bkhDU0N1WlZWM3ly?=
 =?utf-8?B?QjlwQlQrbFBYU1RlVm9FSjhXNDZOYzRkcE80MEVsYlRKUkwwZjg1UjlpR3NT?=
 =?utf-8?B?WU4xcDlNWFJVb1JKb0J4R0dXSjdadU1ZRE5kVk1wSzdQa2ZuTkpuMWFtRERk?=
 =?utf-8?B?aGY1NkNCYWUvUmVVWkRNbTNQUHVXZ0ZyUldzc1ZlcHBNaW1nbk9McE9WQ291?=
 =?utf-8?B?K3YvQVZmbVo2b0RGWG9WY2UzWDBSWGVQTnBaZDBNR2liME4vUERzSkcvUUZQ?=
 =?utf-8?B?WGlTdlNVekFNRW1lTlp2MjVqdzdiY2RlL0ZDZWRWZU9qNUpMNEFNbWVaazBY?=
 =?utf-8?B?RUFCQVovTnJFMWJPTnBWZnY3MXJWOEsrK3owWVBuYm8yaXg5c3hXZXpiSlZL?=
 =?utf-8?B?UDcvK1lYM0x2R1FKcTBSSDJmWisrYzZOcnIvazlIenJCMVB4Y1lwanU3cWR2?=
 =?utf-8?B?eVVPSFhhRG54WUJFQnhmTkdGNWsySVJZVGtuOUVvaVpDYkdiZ1o3MzRKeTVk?=
 =?utf-8?B?R0U3M2xWNnN3RXBkb2RjNjN3YktndTQ1WkpOWVVHZUxnNk9ZQkF1MlhMLzVT?=
 =?utf-8?B?dHk3Vm0wdmZadTEvNDVzbmNYOGZqVVh0VVg0dU03dkV0aUltUXYwanZ0bTNo?=
 =?utf-8?B?YkJRcVZrYm1IaUpMRTZNS2pZYjdsNktQNkQ3aGJSN2lJMjMrcThKK3JaRXFp?=
 =?utf-8?B?aVFtdHB0QytZQTFqUzl3RndNUjlBczdpMWVpaEgxejRLY0NRRmIra1R3Ujhl?=
 =?utf-8?B?NGRjbmRmZTdUODNxVnF4UkpsMUgyZmdSVmZURzFSc0RVYytOS01tdUM1Z3cz?=
 =?utf-8?B?N3RodG5XNFZkUFE5SFZLcVBISlROVVM2eVNLUHZtUFlOaFRJTXZKbWJLMWdr?=
 =?utf-8?B?NWhpeklOZW03RXFiLytQZGlhWXhoaDFFSzFjVXgwbmppN0gzcE9ZRW44bys4?=
 =?utf-8?B?aEZSMXcvZjJvbTZKUk03RWdpR242bitQOFZJc3V0RE91dGRFbzhON3hENzZo?=
 =?utf-8?B?WTZkOTlvRHZ4aGpJdDBDL2lzMmZYYk1Cb2t1dDlwaEdtTzZQMkRaalV5UnAw?=
 =?utf-8?B?MDBzRnhzaGY0YzBHYW00dzQ2bVF6SHFVN2Y5dU9ZbVhtR2JNbUxPcjVEU2Z1?=
 =?utf-8?B?U3MweVMzRmQxR3RVTWl6Z216OTVYK2UxbWZCMUZKT2ZUcUtVMzZMVmxLY1Bw?=
 =?utf-8?B?YlQ3TEZicDZjQzFrV2Fjd1pSb2pOa0tnclE3dlk5Z2Z3VXhRZUMyMjBwS21E?=
 =?utf-8?B?TnF0Q3hvejFSaFBjTU9BdGN5bWhVUVU4L2NvRjc0MllBOUEvckpYbkZSdGJt?=
 =?utf-8?B?eU9XL0hjTXd1cHpWNm1mMnBXUWdraFp1UGZVbk1SNVBGNUp5ODFrM3NRSXV6?=
 =?utf-8?Q?9EStuK2iKvLjmAY04pNKHomr9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00f3c63-6219-4c90-6d0b-08db5126608e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 07:15:47.5986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W5r3XNNKGDadbgcQObKPHCtN3ANu5fkiyL9AHGDcu7Sd9PUlriONUBd+CAY8OUz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 5/10/23 08:57, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Tue, May 02, 2023 at 03:35:33PM +0200, Michal Simek wrote:
>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>
>> Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
>> CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
>> node and let each CPU point to it.
> 
> The commit message should focus on how this change brings the DT in line
> with the hardware, not on what the Linux kernel does.

ok.

> 
>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index bb0d0be30aa0..c2d80c7967e9 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -33,6 +33,7 @@ cpu0: cpu@0 {
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			reg = <0x0>;
>>   			cpu-idle-states = <&CPU_SLEEP_0>;
>> +			next-level-cache = <&L2>;
>>   		};
>>   
>>   		cpu1: cpu@1 {
>> @@ -42,6 +43,7 @@ cpu1: cpu@1 {
>>   			reg = <0x1>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP_0>;
>> +			next-level-cache = <&L2>;
>>   		};
>>   
>>   		cpu2: cpu@2 {
>> @@ -51,6 +53,7 @@ cpu2: cpu@2 {
>>   			reg = <0x2>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP_0>;
>> +			next-level-cache = <&L2>;
>>   		};
>>   
>>   		cpu3: cpu@3 {
>> @@ -60,6 +63,12 @@ cpu3: cpu@3 {
>>   			reg = <0x3>;
>>   			operating-points-v2 = <&cpu_opp_table>;
>>   			cpu-idle-states = <&CPU_SLEEP_0>;
>> +			next-level-cache = <&L2>;
>> +		};
>> +
>> +		L2: l2-cache {
> 
> Shouldn't labels be lower-case ?

Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:220:        L2_0: 
l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:241: 
L2_100: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:257: 
L2_200: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:273: 
L2_300: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:289: 
L2_400: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:305: 
L2_500: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:321: 
L2_600: l2-cache {
Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml:337: 
L2_700: l2-cache {
Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml:116: 
L2_0: l2-cache {
Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml:151: 
L2_1: l2-cache {
Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml:77: 
              L2_0: l2-cache {

And in dt spec - 6.2 chapter uppercase letter is valid chars for DTS labels.

Thanks,
Michal


