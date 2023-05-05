Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A706F8181
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjEELS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjEELSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:18:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5D81A602;
        Fri,  5 May 2023 04:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ng7beSTpgrZwGrDs+nBxpdDfAztJOpXz0YV5ZNlp0PfiCNFkxJXMWXBPxjTvcM0n9AaqF6MS4XJNeYU2LGNZm1GDbERi1EWKDAqm1xhnNfE1wJ4IEyP3XFgN3GpjQOeZGvUaSY+ruQoIQydPhhOb9qu4j9FO7XyEJSLswbaJI73/vy0NEnhxraRlJV0YDWDJaWggLIcDlpaKuO8yJNKEHNhTum/LLe5jSZMZlp6PG128M2KhEUNFjtZWOryQBEjAe7/FWM7tQp1fXz2OC4GT6UByE5NTLCJMd9bxljesKD01P5tVk6oBlQwbOsVGyNQM66g1FSLPGxa0mpwa6zx5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7Rx6bvc98tKNsoO4OBUVVux0eCFbJEoWQ64PLzIVL0=;
 b=fubfYr/YDMt6r8HhweHOhlEo+gvtJ1eZPFtWAQWaEcoF66lJNL0VXoH2cwQt+Mh1lSmjTrq4W93xjyUr74WAuqIzoBpWXJ8rvEzWXAoeh4T0K39Gg9b2eQqUfEfGdL9Q4PtmAAfTgsm7dVcf3HBpx7JouXsizSXl4pDHaDwfnh73znBea6Gqp3ay5axF7GsC7HXwAW/sR8Un4pX3OjryEKzINFyGPOTnOfHhJmpQ80kJqrs1Uslr+3QNMRCPEpRG9ggCIkx28ZNCAm85iidevm0Z+/xfEE8tbo1sXowxgkMFWuICjeUJbLD8VGTu2bssI7ZtTWaDhktLDB4caFnYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7Rx6bvc98tKNsoO4OBUVVux0eCFbJEoWQ64PLzIVL0=;
 b=hrC84HyNuf9AAaI3yaXtq5baCjfFgkuoKw0WOBunRPz8rrRMLgHF4KGKacDymWYo5GsnawV4iQvAIEIjWa52ACFcw+WjUsIoFuAP5X/ApPKE2Zi1bzLmS2O9Vclu+saI85BrUg2mqA5IIAKzyiYd4x3euzAQ6W8tNdz8u6Go5KI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ0PR12MB5471.namprd12.prod.outlook.com (2603:10b6:a03:300::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 11:18:06 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 11:18:05 +0000
Message-ID: <a2064add-895b-1b35-639d-39e9ffcabe08@amd.com>
Date:   Fri, 5 May 2023 13:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
 <37c651c7-1f7d-fb2c-12d8-646ba3e63247@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <37c651c7-1f7d-fb2c-12d8-646ba3e63247@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::49) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ0PR12MB5471:EE_
X-MS-Office365-Filtering-Correlation-Id: fd883109-95a0-44dc-d952-08db4d5a6579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8PsJMvN1Ve1uxw02m94KDM3nDKj1L1++IFJif09xMq1PY+gRxnFRjWwAmIWcM9pv0GIrZxRKOCE4zvT2Hf58FHDuy2ItNzfs0hhXVJvnsH5aFJT8NOi1gbHqGsH6791QqhPbdW0NV99lSENkzvadHxNLtk4xhNKw3aTCRSUVoRfaJ2UWn74dxa3/V4Pz34EO99zUbVjyoN7/CBdIUvfzohrgE8zSAwwnPrwpfYF774SNLk2AtTboqVAm45CAwTJILrbrpv57AWZ5uGb7IdE4KT2I6Ua7l96WM7kK6lZRBCi/PW/IVTbR675NDK4O094atURZRNq0pJ37HavEmwUoppr6gAaTNS7CNX1ElE1IZhxK1tHS/o2Da/9eOquawXYxdjhsqdPOIeQUa6yxa9QAtfU3e7oCYlnFTYy51cN8RokcEnrCWdzrPxGm6WXFTiBgqfBrsP22Mx392Dkvo1XUYEFVdeuJC0JJTDUlRMOpJv4tRZq8TqOQ0vBANau1/KQ2PLvLlciS2bcufly1nNbOPhkZXTOLT/I8jDzEinLfv0wlmKNZILN8yYvj5E/aKrwQCzeTy/bp5CemdALIfmPl5YO2MEgVL8P7iM5sp+4y1EFXwDOZ6zCaIyO5hrL45/MUyZOhXJPv+zkgiDi8mdn1Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(36756003)(31696002)(86362001)(316002)(54906003)(4326008)(66946007)(66556008)(66476007)(6486002)(6666004)(478600001)(41300700001)(8936002)(5660300002)(8676002)(2906002)(7416002)(44832011)(186003)(38100700002)(53546011)(6506007)(26005)(6512007)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFnUm9WWThzbTRCNDZ3TXdiVjQreDJGWFBPUEJsQ0czQTFvYW9ZbTE1V08r?=
 =?utf-8?B?dm15ODRYNDhLajlsenIyNlhhclIrbFdkaVlCTlhPNjJVV3d4WXVpZ3RUdE1m?=
 =?utf-8?B?MU43Q01aYlVZRWE0YTQxazY1SXFFeGFDd3RucjdQR1Z2N1lNcUY0T1Rud1Zw?=
 =?utf-8?B?aGM5M2RnbHlDaEg4cmp6MDRodWNneG51Y1NWQXg3bkM0NjF3eTdNMDJlN2dz?=
 =?utf-8?B?dUpqdnhpaVRWdDhEN1JsWFNJOThpbjhlQjd0bmkrenRxMWN5bitacXFvaGlH?=
 =?utf-8?B?NGRjV2hUSzV4ZGFVcmJrUVJQUHhja3NnVjZ1NDFRcHhzQTR6OWx4a0VTdTBQ?=
 =?utf-8?B?bFo0OFJWb3JHWHdPNnpYbmNnZXFXWDBmemRNL3VTLy9JeTZCNFF5V3hmWnBu?=
 =?utf-8?B?bk1QYmU5ZWZGR1dZOVdwcHhTM251KytPS0NCTWdCRW5zWDFSOHpCUUZSNG9Z?=
 =?utf-8?B?U1MyK2Jva1hxYWVOUWZwNmxJSDNwaSszM0w1Mk1TdnZKSGlBMTlieFRZSWVL?=
 =?utf-8?B?Z0FyMXR4TDROUzloZDEvUktNeXBxMjVaZjllLzU5OThlbTRJNlFWMy9XRVJi?=
 =?utf-8?B?TU1rUEN5azZ2VGJRUFZFVVJhRS9HWjcwanFHRGpFbkQ2anQ4TVpZOG1LQzEr?=
 =?utf-8?B?YkpsblZLYmF5dEJJd3FkWGIrNjNlbTJ6ZGxYcE1VVDVQL29TcjFRNWh5dnRG?=
 =?utf-8?B?aGQxRjllc09iRXA3ckNhZzhPaGVrQmtoMGtnR2ZCSWM4djQrN2hteDJBZUNY?=
 =?utf-8?B?QTMzOHpURTFrd293cGhQTFJnUWJBTS9JUlJjQ0lHbTArNUJEdVpyM3orUXNY?=
 =?utf-8?B?NGx6WjFmZjliZTJ2WEdqWktkTEVyZEpRUVFsN3BsUUUwZlg1WXNLTkFDRCt1?=
 =?utf-8?B?MDFVTTd3ZjhkUHB6OEpadGpDK1hoM0hmT3JOQmdFTkFLMkIybW1aYi9oaFJs?=
 =?utf-8?B?VEZ5RFNCY1JEbytFVDU3WDVDMFRDV2V2Qld4b1BROWRSblNia2JCY242Ni83?=
 =?utf-8?B?dWxOZk9yUG1WNXpmem1KK2xVS2J6VTdyWXUyVTAybzd3ZFR0VmRiZ2lsMXV2?=
 =?utf-8?B?N0s0N1UwUmdFN1RGdlphZUVMMEZvTHNUVmxhVGhpSmpOYk5obU9ZQnJwNjR6?=
 =?utf-8?B?ck56d0VkSUE0Tk13Y0U0cmx3ek5lcUtXb3ZIb1R1Q3daeWpXc3plMWxtc0NE?=
 =?utf-8?B?MkM1M242SGNzK3pLZ3FIeWxGTEdWWWhIMWZ6a3hQUlh6bEFETjFPTVpiRDVv?=
 =?utf-8?B?NW5wdFIrMnZsdnFmRE4vUy9CU0xMOXFHR0NZUExnd09WcWgrUFJpdVB4QXlt?=
 =?utf-8?B?NkNneEFFcHBlVFllMy9GYmRuWHBnaHQ1Tk9PQXdWZGdtekI0MlkyYy9uMkVx?=
 =?utf-8?B?NEt3VDRlLzdTTHBGaWtyam1HcDd1QnVueHhhSll4WC96Y0NwdGNkYitJN3ox?=
 =?utf-8?B?SW94cVVsc2J5WWxJdGJkYWwxcFNqNGdCSFVnS21mQllEOTFNa1hBMS9EZEVy?=
 =?utf-8?B?QlVpWXJyY1hvYWRlZW8wM3JDSUdJdTBiYjZwd2pEN2xtZUV3bHRMT1dYT1Ez?=
 =?utf-8?B?ZXFxaHFXYWFYa0F2NWtlVkJpS2lnK0ZoWVBWYUF4TGZ2ZE9oN2o1UU5lcFN5?=
 =?utf-8?B?RytDM3ZqTDRmUnJPVWpLWldkZGhkYVFxaWs1cEdjMTF4VEJ3MHhuR29oLzFG?=
 =?utf-8?B?MnlkMUlBcWNQUUU0NG9WazhGbTVlRStlM0poZk14VkUvVnpNMXJlSGNzR3NF?=
 =?utf-8?B?TzZrY3paZEZpN3VsRGY5QVFCbFJCTW90Y0FqQ1MrTzBuY2svMXlYR0p6eHha?=
 =?utf-8?B?YUh6bnZkMStsTkdtMkJ5VVQ2RGZqaXh3c3l5TmFOMmNtNndnRXBaTllYR01R?=
 =?utf-8?B?WGkyZG1sQW42NDZObUhKZld4c0h2Z3ZBRmhQMXcvSVlJWnlJb0JDSVpCQ2sw?=
 =?utf-8?B?OE51RWJZeWR3TGhneEYrblluektpWkZWSVlHVGxnenhMNXhSQURkZDBRSk50?=
 =?utf-8?B?V25DZXVnNmNtckxScURnQlJFR0RNL1ZMWEFiOHBSU2FGQjAyUDRKdjd4ZHR6?=
 =?utf-8?B?MUxqcHk5M2Y3aHlhM0RZYW9CN0tiVmVsUmRwaGtLNEJaQ0lUNVpkODlYV2do?=
 =?utf-8?Q?ywG6TKKNsP77CeGxNfw9kmAzM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd883109-95a0-44dc-d952-08db4d5a6579
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 11:18:05.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5tXKga4iM2+BmTLleJHo+39H2RzF/45drVW9RQW/Kq+zCUnvNcdqvyJk0O+3BKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5471
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/23 04:34, Damien Le Moal wrote:
> On 5/2/23 22:48, Michal Simek wrote:
>> Current only one entry is enabled but IP itself is using 4 different IDs
>> which are already listed in zynqmp.dtsi.
>>
>> sata: ahci@fd0c0000 {
>> 	compatible = "ceva,ahci-1v84";
>> 	...
>> 	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
>> 		 <&smmu 0x4c2>, <&smmu 0x4c3>;
>> };
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
>> index 9b31f864e071..71364c6081ff 100644
>> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
>> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
>> @@ -32,7 +32,7 @@ properties:
>>       maxItems: 1
>>   
>>     iommus:
>> -    maxItems: 1
>> +    maxItems: 4
>>   
>>     power-domains:
>>       maxItems: 1
> 
> Is this a bug fix ? If yes, what about adding Fixes & Cc: stable tags ?

I can do that no issue.

Thanks,
Michal
