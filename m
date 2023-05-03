Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7156F517B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjECH2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjECH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:28:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1473C29;
        Wed,  3 May 2023 00:27:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ierKvdj8PbsMUVslsXdhvAz4t1IMPvSBFbbvpYaCQWgTj889ddBu+/dJZKJ64d8D1JdB3tfRaDwAvQJzybYjx8p7PcTT+/WboRqazixMhLgAP5dOaZnGt4L5yOG5YoC3OdVJJKFmm92mfdHSavZ37ONDD62QjZhLW/qkxNcFCZYLPDiPmSnZl7kljdV9p/g8m3KrfwzZvfrx5vxq2ULS0HermrFLCgavbZDyKQLMDPPvgjxtTcpiugrUtPQtkM5+OrZotKO06zEx8N7IYPj1ekA9qSCDedueIQK9yy+Pbla1WWqZ/sBLUPDUwDacj7ktgAmjimO9bEkp8FRRstjb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g5wZJ4ZF6DXIjp8HHSN3hpXo+PnAQ01s+8yvRd6GEk=;
 b=MZKm0stlPduXDhjkh2ZiP2i7zzq3LuyP8wTBao9jf5q5oTXMXtV8HZaDV4xWZZ4lVd5xD3er+jUzr10lEY0SBuV9Lo2tOcrZjzy2tZ3Kf9wewf6ePtN9NyGcgI+VFXdRz8Y/FMqFnIbrKu/V0MC+dAx1r7+uD1LJF3nxb9rahZJQt+hU8VEpowzbz22yXRAfWc7004NXA/Ii8BYIOxZC24aGZ6Kjx+1Y2TJqyRzF6EiDv0B5UxMyN1TyrcmEeXfJuDWiIwoEEpZRaeYUj4UNjDPn1jcgca9iHGHhdG1q7wNFH3hySHJPTN13XHCgbOQrK5fHQny7bps2S6z+YrLAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6g5wZJ4ZF6DXIjp8HHSN3hpXo+PnAQ01s+8yvRd6GEk=;
 b=nAz4sjXvxy6pEcPISG2WST4tWRbxJaNO47YijGFRvh2YvZX/7jDNRTmZZbDt8ldoB8w3LEhcbiuBUtR9WnXxP+HyVlEEPVePxxY2mJ7ynI2Vlv/HzuPcxhEZ5bO7qOPPZ8dOJ81ejs0hv0bWW5rMVCA9MVLPXHZql518GEIzKtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 07:27:46 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 07:27:45 +0000
Message-ID: <958f4336-8c38-4cc1-4313-06a54e397d42@amd.com>
Date:   Wed, 3 May 2023 09:27:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Varalaxmi Bingi <varalaxmi.bingi@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <4dde5d1eb8e4572dae4295a19a4c83002a58e5da.1683035611.git.michal.simek@amd.com>
 <e0b50ae1-b501-cb41-829f-736903e5794f@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] ARM: zynq: dts: Setting default i2c clock frequency to
 400kHz
In-Reply-To: <e0b50ae1-b501-cb41-829f-736903e5794f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5aaac0-6fbf-4f0d-9df1-08db4ba7e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F0K1rWHtQ1BVoE3G1DLlPGnK9vSDVmIu97LAUrAEdbScE1R3IWOr6Njq2qVkewkP5GrTj/uIxrHTdGjqdEczASA2AgDvP63R3Jai6BO5kuONkPPLylpBZx6Rfqt9osYvRNU7XaSx0dtyTmHLuPy8mtIte6vah5qxaq6eFHwo0rWY5l9YzNtlvMbjvajfKXTe0LWMF4WNuYa+LDSIIh0UpWffxLp89v96lvraqHa9cCakYwK7l+c5M71VVdWnw8jTAslBXnC/vvqR070FI5EcU3CwXKA35DvUOKc1ftIpBCl9tC6V09R+V2RZuG+ES9rTAonA+XswDsc5jMQEN5uR/FzQvroW1UfqQz+8gffSK27cNyTFPh6RXN282826x4OlQWlqO92FT+m6MJlMFxYhbUgsXtbxNF6U57fVvRlHSZoTuL2hk6HmqJteFyBsrIjrBWp1TPOLfspBy4uIZKvQkOZ1D6GNFZZjNAJUyk4T4DQ64Bw72QlnmTHYM5T1XiofzPaYcPuyeebPtDfKljImFrHVEsRDQmEBXkwJt9hhnEWN3DWqsS0KzjEjiX1t6eZP9YrjF3ddp3fNl6xpjKBdoTimFasInFMFq8NkIeRFsHw9VN6WpHRI5NDyoDXghJ1ZzOG8RIM7vTSTYYVMMLAPwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(86362001)(31696002)(36756003)(54906003)(478600001)(6486002)(966005)(6666004)(8676002)(8936002)(38100700002)(66476007)(66946007)(41300700001)(316002)(66556008)(44832011)(2616005)(83380400001)(4326008)(6506007)(186003)(6512007)(26005)(53546011)(31686004)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FRRXdxeW0veVIwUnJHS0hLV0YxM1R6M1NaUjBDZDQyZmh0ZEJGODFNSEhm?=
 =?utf-8?B?b0IwenNnb1diRDR3c1pGYXpYcU10dVNUNVpVbFVod2NMK0c0VHJHTmFweGNv?=
 =?utf-8?B?UVMrZVhXZWNQTEFJTjRGUkdLZnV0THJrbXFGSXBrUGxCRS91UnIvaTV1dVBa?=
 =?utf-8?B?dVFPdG1QOFdUS09aWmxRcUJ4SzZQcWRvQytmRHEzTlBtZ2ZISE9sRW1kTHFX?=
 =?utf-8?B?MDN4ZnQycW5Yay9SOWpRSjZHbVgxekxWWThKeWFyWHY0TnAvZzk0Z0VIYTlh?=
 =?utf-8?B?cU9OSHJWTkc3b1Jtbzcyb2JCSHRBQU8vM1NVWGtSWE83TWdHNnkvb1o0ZVE5?=
 =?utf-8?B?RHpCSUhBcENLeHZ1VXdaM2kwelhrYVFkQzI0Tm55MUNwYXoydG9lYm1iWTlW?=
 =?utf-8?B?TmlXNkhRdDNVdDRMbk5uYy9Rc0w4RTBZRVNYWlRoTTdCMWlFWkk3RlQ3bHFS?=
 =?utf-8?B?NmJTbURFU29xa29IZW1Rak9MWC9iOUFneHJlcVRJWFpONUlYZTZqMXN3NWQ5?=
 =?utf-8?B?ZnhHTzY2RXFNOU1qSy9SYjZwZnM5cjlTanhzYmU0SFN5ZmtLSk1RLzZtM3Bz?=
 =?utf-8?B?d1VWU2ZrOW1tYm9IWnMyMTd3WWJmTXpWRVlNc1ozbUJrQ0tWcS82VldLZVZZ?=
 =?utf-8?B?Z3JkeDdxMm9hcE9CRUYwM1QzRzJqbVZwMmVwSStFM3IwV0ZrZ3l2VzlxN0oy?=
 =?utf-8?B?WGZId3UvKzdaOGFOYkZJbXBia0NRQ0NTaThUVmFOZ2dBSEtmYzZlM3ZVbWdo?=
 =?utf-8?B?cXdpQ2pqM3hJOUNFNXhmc25ENTg5dkJsVEx3NEQ1ZWNQemZsUytTQ0hialR0?=
 =?utf-8?B?NzZVT0s4UkxQaHVUMW9FdFV6ZkF4UzVKbjQydkVRazlSV2wxWTRJMGxZcGpv?=
 =?utf-8?B?UGFtWjJrK3gyYUxrOWxyUVNKWkFZWXh3djUyVnJwM3U2NjNrV1dTb2NZRFNF?=
 =?utf-8?B?REJwUi9iZzBST3JkUE5RbHVUVVJkWncxaXdTcWc3aWp6L1VMd3B4QmpQN2Fq?=
 =?utf-8?B?RW5rTWdma1NzNnc5Y1pRSWY2bkg3Um1jb3lGZXhTS3JZREo3WE9LbWR3U2o0?=
 =?utf-8?B?ZWJYN3FIYkNxQ2RRM0tHb0hwb1JxQlJ0UEplVzZCSkVMc3g1SzRjK1pnblhW?=
 =?utf-8?B?K0tBNVpoYlpQdmI4SlNYbEhLYkR4ZmNhMTVzcjVPWWxNTjZaZ05Fbm1YZ2ox?=
 =?utf-8?B?WFg0bzFXU0NLbHJURWlTOEg5WDZtemNpMnRLSXZDaFd3QTBMeFdSdGFHQ3FG?=
 =?utf-8?B?Nzc1cytCeFJ3djltU0MyYnJVYjZWNUpVSXl2MUhYbUxVaG8yc2dmSllFcTlF?=
 =?utf-8?B?dG1Falh5RDZYNmJVQW5KaG1OaGhXeEpSa1puSGNLTENic2lwcndsTWNsdEpk?=
 =?utf-8?B?WGhVeHFYM0NkNk0yZk9oVDFBcExOdnkxWG9wTnMzeVY4UlJMUEREbUtrOWZ3?=
 =?utf-8?B?Qm94YXdnamJaTTMzbHExQ2ZqK01RQjNIU0NpVFVOUEkzd0pKaldWT0F4ZldQ?=
 =?utf-8?B?MUx0N3lsYzliOW81R1FGa3lIUFhDemZ5QlZyWU1FUWY3ZU02TDRjaTEraEZr?=
 =?utf-8?B?Znk3Y00rOUxDNjl5Q0VJUjJEKzZpdm9pWUhoZDhHalM3cERrdVJJSUdNZEl3?=
 =?utf-8?B?Q055TG1ZQ1ZWNGk3OTVIYlgrVGFkTWZqVWpKaUN0RWJlM2ZhekVhNVovWVZr?=
 =?utf-8?B?Vk1xb080U2JPZTN5YURPOUxUL3hyNEVhZ1B0a1krTmdaVDk2QnpmU0NxanpX?=
 =?utf-8?B?WmhNWlY5NjRvRzkzc2dkVHcrQ1F0M2k1MUtvMG1jYWFEK29BMWYxcVltNmZm?=
 =?utf-8?B?dGJVMHFFbmJFalp6VzVWTDRRUmhmVG4vRTdOdHMxZ1FReTYydGV6SGhrV0Ju?=
 =?utf-8?B?Z250bnVvWVd0Wm9CNU9neERjYjR3U1dOTGozSkNxbjdEVVlzaktweW5XM3Bu?=
 =?utf-8?B?YVpoTFNLT1ZIb1RPYW9xNm1kbVNEemg0dmIwL0FPOXU2bFZrdVoxV3I2bWNX?=
 =?utf-8?B?ZlJXRzhZcE92WWg0TGNpQ2J0OWx1M050Q0ZaNnJ6UWVBcFR4MWpaa3VzRytR?=
 =?utf-8?B?UEo4SWdTTXF5cEM0VE1BaUY2YlhMdzR1di91QUtKeGRNb3BHSlFwY001c25Z?=
 =?utf-8?Q?noRq8uMOkgpan8A7kLYg5oFl0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5aaac0-6fbf-4f0d-9df1-08db4ba7e354
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 07:27:45.1377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8buZcr+oMO2kRcDHQGVKtwAybd51ZkU/2CS3ormEtl+KmXhdrJJ6FWZxukrQWgFT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 22:13, Krzysztof Kozlowski wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
> 
> 
> On 02/05/2023 15:53, Michal Simek wrote:
>> From: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>>
>> Setting default i2c clock frequency for Zynq to maximum rate of 400kHz.
>> Current default value is 100kHz.
>>
>> Signed-off-by: Varalaxmi Bingi <varalaxmi.bingi@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
>> index cd9931f6bcbd..a7db3f3009f2 100644
>> --- a/arch/arm/boot/dts/zynq-7000.dtsi
>> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
>> @@ -149,6 +149,7 @@ i2c0: i2c@e0004000 {
>>                        clocks = <&clkc 38>;
>>                        interrupt-parent = <&intc>;
>>                        interrupts = <0 25 4>;
>> +                     clock-frequency = <400000>;
> 
> I think this should be rather property of the board, because it depends
> on I2C devices, right?

We have 15+ boards with i2c connected and from this count I am aware about only 
one configuration which is not working on 400k.
It is a question if make sense to update all boards (except for 1 and not all in 
kernel yet) to 400k or just say 400k is default and if there is any issue use 
lower frequency.
Obviously this patch is setting up 400k as default and let "problematic" boards 
to setup lower freq.
The same approach was used for modepin description.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/xilinx/zynqmp.dtsi?h=v6.3&id=53ba1b2bdaf7f481fdd878e9c18cd0e54081fac9

The next point is that 100k is default in Linux but doesn't mean it is default 
in other projects.

But if you think that it must be board property I think we should setup 100k as 
default in this file too to make it clear.

Thanks,
Michal



