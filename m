Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90C46CB817
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjC1HcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjC1HcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:32:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED7B4;
        Tue, 28 Mar 2023 00:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUo1W7Tttsf9/ZrwH8uFCPzGXnBLS3W/3q1wN5IDviGJFYbhpiohE2scUtat5DHApy1oyI33bSCUHfWDU2QcsJHu5v9MxjUlLc9wBc7Gdq1J4vrKC8AWoLbV/+psgLq9uoGvrD9hFaL1k5K0P0QSVgNQa6dCtCr2Fier7z0BLEx53SP7PLopvL0TPQ5Ea8une8/4YCo4xasAy2b+VI7XwtjYTru5XDDzl4hIs7hj3eXqzrLlUr4aSTSHBiYFGShUuBwNhlXZtswe9aq3TTrXEFS+rrwIN3rbmfrq5nNtJ0uXkeOzZeupszqqK7Tu/6vFajDCmasgBrci8/YG+7D8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBHpQGTrC9TJw55y8fpvwbHyg/OGW/UWU0esCJNB6ps=;
 b=TF7G+HR6eKR+DbXgKnLnb/E1BE0LWwAU0d/j+OjEju140LixAjMT36JMGcUNaNfLM0xYa/d4NbkbC6RqJx50zjkk1+RINYAh4CtzxqQk+jc7sYFkQRmSHTs9rlyxUKP+Nqi0hg0rK/2RyBTdK/BNPUSVd2P6jTH5NeSXOVdDmX2zbxKhVq89+zcq5HC1nibEWwTlA7LZNMHBdC4DpvpXdT6CPuI6W9OB5TcaQQio7kiDU5YncNSv/N5uALsAM/6nCLLhbngzNbh1qACe3vo169eVA9ClML9sMU0IWmFQ89aMaD4cLyBJ0TXO5UiccCilS7RTfz8bd/CZsewd6yYYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBHpQGTrC9TJw55y8fpvwbHyg/OGW/UWU0esCJNB6ps=;
 b=AUSMyjWFyRe/zjZOWl2Rf6Y109O0Zbq3nHrsnbs8CWJMyjIRwOK09LvtO73RpXh0hWu2ho2B3xwIxi5Dh50mQ+BOQ0Tkj/FriVaP+SfyRr70t8HAWY1Rchr7Q+4nbXtbIGjKjEpANrDE8djRqHRcIvHG3Jf8xm/9CuIa3GIZpEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 07:31:59 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::4d07:7f52:c833:9603%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 07:31:58 +0000
Message-ID: <84d34a5a-c29b-f38d-2a71-6cf39447b03d@amd.com>
Date:   Tue, 28 Mar 2023 09:31:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
 <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
 <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
 <BY5PR12MB425806889EE700C1FCC8A465DB8B9@BY5PR12MB4258.namprd12.prod.outlook.com>
 <1f97dec8-d30c-ccc7-3026-713bf9a15850@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <1f97dec8-d30c-ccc7-3026-713bf9a15850@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P193CA0008.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:800:bd::18) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e326805-faac-4cb0-a5ba-08db2f5e8338
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blk0jLwfjd45zTO6Vj/jo7Q11fAp8Ud1DK7MQppv1YU9+s0PtKAnZ5W8ign3oZ5bN5UPIUvuPWD98xpOs6SDTqC3EZzXrsUkXoHr4OHUB5X8Ntb7jlUoEudTr0QbwJqizaMpy/GQRtvgBTmCZEBxHMXkAFJXjLJj0+Q2PlIEK4IyiCkXJ4avi14H3hyBJhmEM8fuHAN91k/F8lokQOVTvEy4+4utnOujQHZOe6Wo+oHwa/NFV0a/ioYc4PKAv7Kw+30hEUxRqCeglho0AwYQLcapCFrWfEXYea6G17esHcpLW70XiAGKRTAWZV0UJ6cwgIy6Masp63K/jMuQvTdf4n2sTHww2JTRvRoICUqC/HJb70p/1g8PxzS0qv9sBGA1aqFbuyx+aw+sU1QF74Hh+7cgc95zzCsEIGHAF9C/tffsLQYVTPeza4OXhTR2JnzEBLxLwTRtk9p9M07XLQPRvGLiKSUXa2rYIBgda7d4SHCX1e8hYpqzyc9/MWPDIEnkn4i2bsB94zaxqZYX/JmKLvntzneJWtopRN7bCoUs5mP9uz8Gf9yfNMi0Z6Tk4pLJhqpHBpvNAU/G71CvQP9BZcSQQGO7ufG0pY+lxj7DDx+sgYUj7qGanptzbzNL4Vx2/CbBSWHXua8sWkQ0ZKkX2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(86362001)(31696002)(44832011)(36756003)(2906002)(31686004)(26005)(6666004)(83380400001)(2616005)(6486002)(478600001)(66476007)(110136005)(316002)(4326008)(6512007)(66556008)(66946007)(8676002)(7416002)(186003)(8936002)(54906003)(53546011)(6506007)(5660300002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5KQnRPZjdLOEtYQWgxUTZ0T1l3QnRseXRnVStkTmcyNjJ4TGFZZGlFNGFy?=
 =?utf-8?B?TFp1cVA3dk1TMkNnTzVUcFE1SngvWDRDdGp3SXlRckN3NFAzRFJaYjNocmNL?=
 =?utf-8?B?UE5HTlk2Y2RGY1FjOGF1WjJ0YnRZajl2R2RaaERva25vNXYwUzFxK3BucTYr?=
 =?utf-8?B?MGxQdDVQVzRLTE5jVThYOTBoMEsxZnluaFFiZnZER2ZDdUIvdGo5Y1ZvT0ht?=
 =?utf-8?B?eTFIUXpuL2poNHArQXkwNUpWdkRiWjljUldXbGxzbTlub09uRnAxWENXV3hL?=
 =?utf-8?B?L0tOQVZQL3JYenZoK2NUYllXcHBVcTZhUVA2SVhNVXZPbUxHZjYyMjFNZGI0?=
 =?utf-8?B?ZGdqV2hDS2hwMnBTa0tkVmtDaFNiZkw4Q3FhK0tNUnp4T3R1K3pTciszeWI2?=
 =?utf-8?B?UFFmRVVET2p4b0orZGNreVdlTmxhNnN4NXQwWXVocnlST28wcUVCQ0VjUy9Y?=
 =?utf-8?B?RGM4UzUzZzhHOTlLMExuWVRreVoyS1pNTzhVUnZGc2xGd1JxVGJLMittSERZ?=
 =?utf-8?B?WW9hS2FpTmI3bCtia1VuVThMQklYT3laRmhmU2NIenNrckpPQzVQc1oyYzVI?=
 =?utf-8?B?bnBzOGQ5TTFudjJsVWxQbG9yUEg0S3AvWmlUM2lwd3NwRnJWVm1BSUdYNFNs?=
 =?utf-8?B?TGQzaUhXSkZFWHBuSm0xSTIvRmFnclBtQVFOb0JsVllYVVlaOXliWjMyRTh6?=
 =?utf-8?B?MjBvaTFuOFFGMTU0clIxYTdLTzA2WXdPbkUyQ0NodzZLVDdqOVlJKzBTK3ho?=
 =?utf-8?B?NkFKdE51cFZldk9TUEV6ZHJ3c0IzR3IxMVdoV2haL0MxOXNMUmxYd3N1OWtq?=
 =?utf-8?B?c1MxOXdXR2JuMEJXZFNPZnd4eWZRbTZuRlA4NDhaekxDWDlkeXFYdUJTeWox?=
 =?utf-8?B?cnNGUWI1eDZCeFVZeFZHdlN2SDVPbEh1VUEvRmtoV1lDenBkRFp1ckpBbVRn?=
 =?utf-8?B?TzBpc29nanN5cGppcUtDTWQyUWpCR1pBcEJGQ1lLODVBYjYvQTNkMXI1Z20w?=
 =?utf-8?B?RHFtSjZhczFkeVdVaFI2alc1YkxsZHl4VmFhYWswSndVNWdBYU5RaVMzMlc5?=
 =?utf-8?B?UzhSOUJmSGlBZjgveFVYWWVoQVhUWGppemE0d2VFVmFSQTFSUmRBZXF6MTdF?=
 =?utf-8?B?V3JWektoaGwyTGZ0QW5taGp1T3h5UHd4bEx1ek5EZW9IT3dvM0JDUnpFelQx?=
 =?utf-8?B?bElqbEY0dWRObG0rVmZNQ0JyYmpVUlNXOTB6bVpzQVVYV0YvSTlWbll6ZUNl?=
 =?utf-8?B?RUhEaU1KY3FzeXZzaEpxRFIzejFOakUxaXcwQW5VQUwwakFnVCtLOWlrbGxl?=
 =?utf-8?B?azJRNGtaMXUxSTJhbzRTSEU3U1ZVdm9nbWwzT3lFNW5PR3plbnhzaEg2Z3By?=
 =?utf-8?B?d3JoRWFMVVkrQ3krbHhHdWk5YmtPNVU0bU0zeld1STVWZVJpMmdRWnhuT1Fy?=
 =?utf-8?B?N29BOHdFdGQ4YWxEOTNJckRya3MrdUxQUk5ISlRxYWQ5TmNjaG9kVEFMTFVN?=
 =?utf-8?B?Z2xsVEdFTDUwRzZjVEJ4L3RhY0NvejRSMDM5YmtwZjZ0OTl6a25xbVp6Vk9G?=
 =?utf-8?B?dEp6WUhqblluODNYdkZrY2xqSWR0clZNYURtOCtab1FSekRwRkx3TExFRHpt?=
 =?utf-8?B?NWUzZDhGUkc0UHR0YTIrbU41V1gva3liV0Vic1Z0Nk1CSHl5OWlPNzJNVld2?=
 =?utf-8?B?bWpVckNGSzdsT2x5d3NYR0NWSU8wcU5HYzR4WmxUcS9IaEtJNXBUbWdEOVNE?=
 =?utf-8?B?OVJicDZ3SHJkUjJvZk5JMXV4anFJaTdrZ2Z0bWRXNmhhTXB3SjFxMXMxWU1a?=
 =?utf-8?B?M3NDWE16MjNIM1NMOUtKa045Y2luQklGQ2tMMTNlVzZ6NzBKblkxWU0xa012?=
 =?utf-8?B?elNRb1Rzb1FiRGJFdEpEZ1AxSldUZDVtWEdQa2dxM3JjcXYyd1hJRU0xaktl?=
 =?utf-8?B?bUplM2hBTzJlWHUzdGJrbGc3SE9BTCtUcTVrNlFzcDV4aVhrTitXempoaTBP?=
 =?utf-8?B?ZmxsZ2pVenNHVU1yMks4R2dNZTRsVHg4SnJ5K2N1bFVkcFVuNFJjTGtBM21E?=
 =?utf-8?B?U0cxLzFMcU9DOWJWWXAzWUdrbktPcm0wYUo0WE5HMWJocW4wNkhtRWhRYS9j?=
 =?utf-8?Q?7rlvV58OK8triJe1ZpAUee3ZL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e326805-faac-4cb0-a5ba-08db2f5e8338
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 07:31:58.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KclbZVmCGnMRn/B7RI3WDJlNvmnmSv1VoAB2X++5bsNcXOK+4V2+WN0Nskw74R7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 09:14, Krzysztof Kozlowski wrote:
> On 27/03/2023 11:58, Potthuri, Sai Krishna wrote:
>> Hi Krzysztof,
>>
>>> -----Original Message-----
>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Sent: Friday, March 24, 2023 5:14 PM
>>> To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Ulf Hansson
>>> <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Michal Simek
>>> <michal.simek@xilinx.com>; Adrian Hunter <adrian.hunter@intel.com>
>>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git (AMD-
>>> Xilinx) <git@amd.com>; saikrishna12468@gmail.com
>>> Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
>>> compatible
>>>
>>> On 24/03/2023 08:36, Sai Krishna Potthuri wrote:
>>>> Add Xilinx Versal Net compatible to support eMMC 5.1 PHY.
>>>>
>>>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>> b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>> index 8296c34cfa00..cf44a4b988a7 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
>>>> @@ -27,6 +27,7 @@ allOf:
>>>>               enum:
>>>>                 - xlnx,zynqmp-8.9a
>>>>                 - xlnx,versal-8.9a
>>>> +              - xlnx,versal-net-5.1-emmc
>>>
>>> v5.1 is eMMC standard or Versal block version? If the first, it's not suitable for
>>> compatibles.
>>>
>>> Also, what's the difference from xlnx,versal-8.9a?
>> V5.1 is an eMMC standard and this compatible is defined based on sdhci arasan
>> eMMC5.1 Host Controller(arasan,sdhci-5.1), where as in Versal, it’s a different
>> controller and it is based on 4.51 Host Controller(arasan,sdhci-8.9a).
> 
> Mixing IP block versions and eMMC spec versions in one binding is a
> great way to confuse.

What do you suggest then?

> 
>> Versal Net Compatible is defined it this way to make it inline with the other
>> existing SoC compatibles like "intel,keembay-sdhci-5.1-emmc".
>> Please suggest if the compatible need to be renamed to "xlnx,versal-net-emmc"?
> 
> Is Versal Net uniquely identifying your SoC or IP block?

Yes. versal-net is unique identifier for specific silicon with fixed set if IPs.

Can you please refresh my mind if we can introduce specific compatible strings 
for this SOC or should we used existing one if functionality is the same with 
previous SOC family?
There could be currently unknown issues related to SOC wiring out of specific IP 
version.

Thanks,
Michal

