Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38C658559
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbiL1RnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiL1RnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:43:07 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7323178A8;
        Wed, 28 Dec 2022 09:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPUCBElThg5NT8lHsSdIFifYTNmI9qGnLqx8rL0wJZoPmkiBLcBR9EtWNraS2/k3yhG9rfHr4Wy/V3HDfVqS2TTx/a2ZB3/rbHLkcv8XzludWS4bcUf/Z3IAfaLQNz6B1eA2TktxAZivW7T673NI2Ak7gRQMvUaMvxBGIYx2jkwwUbOXJT5FS/Y1zn58/aPzps98CIKofKczEeLiYWdLkXlDHE9nUehtSPzYb9MOd9nkvrp5hJUR/Uuvg6ln7Yxh8QCcz8PCHVIlPtD+tvKSRNhxlBq19SnEMAyb0cW07OOXwYVPhcQjqLxZbXVKZY3AhQxQnKT2lSEw6pXxq7Pc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFY07MZ3QnZidcv26GhYNRjK7lTgp4SZndXq4TsjGC4=;
 b=BWVpAq3owX/w2b+/K4Yr1UxAxJ46Cs5SyHfxQdSiRCU12x+x+LtAkcdpIEQQWvh0RVeNKVsWeDXX5qpXpHldL+9OznuQOJqKRGBei/EAPMNk8PTj6UbpSswA8KkS9CZRMCV9et3QATFmJMOp0vwNmUS7FEM1Vtfh3po5B06kNkhbPrwcJBSsAhufWVlO0WR8+30K1+tPOootGei9TCxqM/MbEp2FcM3ORzWfvtTQl1xWfIeU+XzhxQvJ8BIBWz3sQYiOtELROoi0cCBDTdgckQdN7Dg3HTsdHmT8pcKHCM2bYebe9CgDu0Y5CzovM24zA8oH4LzZ70391nB/sGqXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFY07MZ3QnZidcv26GhYNRjK7lTgp4SZndXq4TsjGC4=;
 b=mHBXOKb0qg6oaJuBSQhjXnmJcls2w0ZwcuuaqymT7M9OkUvJahJ4lw8oSdaVjLy+VQNOoMjfEttqDzRJfr4LvGXxKXewP25Lq0EBRjz/DpbEy8yqfUjPpJ2GwVLCI0ETZQxYeC5YbX0UJVgEBjnqw54IZK2JPRqtS9q5fz+amyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 17:43:02 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 17:43:02 +0000
Message-ID: <914857e3-1844-0303-e34e-c85a05257cdc@amd.com>
Date:   Wed, 28 Dec 2022 11:43:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] docs: Move rustdoc output, cross-reference it
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, ojeda@kernel.org, corbet@lwn.net,
        jani.nikula@linux.intel.com, rdunlap@infradead.org
References: <20221207173053.1463800-1-carlos.bilbao@amd.com>
 <20221207173053.1463800-2-carlos.bilbao@amd.com>
 <e3d15de9-521c-5017-112a-6cc7fcd54437@gmail.com>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <e3d15de9-521c-5017-112a-6cc7fcd54437@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0062.prod.exchangelabs.com (2603:10b6:208:23f::31)
 To BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f63bd1b-a091-4968-2784-08dae8faf7d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcdS5e29Lgj+/5TJ0isJk2xQ+nbROWj2ZwzRAbnHJ+8wfCvaEPDoj07iJCqOGAJOya7pE6YyxkxNtiP6EkgS14nJkyJxSpY5c59dtXyhZo/cNrVnfAAQg+jez4AcFk/T4hqCjOHbuLF6QeeppOjoTV4ocRzOqr1aGT3dJi4KZunDCE2AcrFLJPK1QqNOL8sdDo5CcFFHmC/8dv+NLK5sM78/FnjWaaMmJAg77nHnVxxnIJ+LFjYwy2m6A616ZGqwAezRQgi9+azt/pfnMrwKanXP7J4d8Sj7A9SVaFIX8xADExSyaD3WdurrIo0t1kCOc0S0CpHKZyrsPjF4RGG3hq5AYkt0AaC/ARl/aIQihj1FqIbaovuKqKRZaWw5fuSwfeiDUmrIXFnvG72eNfgl6L9VRn1sqVPPA9qOOFdtx+gjgKuf3JfAk4MSFujeFA89sHomA5YDg9EiTigWTLlqkCgtZ3b8NZaqObUOPxA6WqW/wcop6U8WkMShIDLex4HodnH1CfHPzqoqLQy1e799DTv6kX9enCEmd/gopYT9stHFMrILmPbMjUryZ8dudrWMReOZTnEiLkh7i0abHmY1AVpeUOQGv+wQshjJL4Og7v9iR2u5RplrXf/Yeqxpkqbc8eztnwO4lGQn+dyDOnHLk7tWjfY1NZ94rA1Yrf9jtqwnUGGNMZicUA2vYeSvIyTXFfGIfDpKbhH5EyrypBaudk6sYDT5+z4hCKT+0FFGYRoq2IHgzsDEPSrscXnrJLYw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(26005)(6512007)(186003)(53546011)(478600001)(86362001)(6506007)(31696002)(966005)(45080400002)(6486002)(316002)(36756003)(41300700001)(6916009)(31686004)(2906002)(8936002)(44832011)(5660300002)(83380400001)(66946007)(8676002)(66556008)(66476007)(4326008)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBGeFZodnJwVkFvbDFuaFlHMDN0OE1ZNHJISHZYTzVoMWlaQm1RSElZT3h5?=
 =?utf-8?B?NHR2VFA3YXQxd1FLUWxOY0JUd1JycnVTSUh0Wm9nL2M4NXVmL29TQzRLUTJ2?=
 =?utf-8?B?dTRXaEFKNkU0V20xM0F4Q015ajdJU2JLdVRyTjRyM1cwVTdGcFNEOFRicGFs?=
 =?utf-8?B?OHpKbEI4c0Ira29US0ErcUNscVRhbHNTMjlKbTN1Kzhzc1B5MktoRkxYZnZn?=
 =?utf-8?B?elIwY20yMm1Ta0NqK1Q5Z3dxMG9YZ1JCZ1gxRjRVNlRMOWZzVzRzVjVhN2Zl?=
 =?utf-8?B?a3ptR0FXMEl4MUtKSmQ3MmJHdFMwTWNYRy9XZksvZGZEKzQ1dWxHa2FBRlR1?=
 =?utf-8?B?dWExUDNscFR1Z3FGa1hacmFmbmljSDlTWHhsVHNMZjFsOEl0RzkzMEpvWE0x?=
 =?utf-8?B?Uk1DMU5iZHVwbE1ZZExyeis4S0FvR2Y4c01MVFcvbC9sQ2kvekhGcXNxQ3dO?=
 =?utf-8?B?OE11QitlckcyOXRhMVBOOE5RTnl4aGkrVlRxMy9VcTNKbHR2VUtYQXZOc3BH?=
 =?utf-8?B?TGNka0FlMUZIL0tQNzdMM0huTE1tV2U5UWYyUVlxNlNGTUhhY1hUbEh4SjI5?=
 =?utf-8?B?WGk1b20yN1Q3bXhrcnN1ZlZJTkJ2QkFidVJRT21lN0xBL01zL1hPTTI5TytD?=
 =?utf-8?B?VE1UemJxZUE2UUkwZHJCejQ1bGVDYkJ4UkJMbTRYWWFLdjBJSTJqbVJCRkJU?=
 =?utf-8?B?SzhSVXh2TURHNGlIUjlWcjRyZGtnTXh0VW43cVFFVHBmSk5nNUM5UWl5V1VM?=
 =?utf-8?B?YkkybDd5cWV3endMbVRCRllsajN6VWtPcVJCWEJHVXJzTUh1bnpUVGxzbHla?=
 =?utf-8?B?U09vb1dNVllkVVVSS0F5ZDh5YlVSTXBJY2lTcHZhYURtYkVhVjM5V1VoVXBC?=
 =?utf-8?B?MjdTTmdxRXBUdEU2cXBnWS9QVFJiSFNpRWdzd0tqQVpwblRJSGJ0bWh1WkQz?=
 =?utf-8?B?TXU2SzUzQVdISFJlU3hIOUF1UlZLeWp5enBTUHlWNTR0cE9ld01QMEthSTY2?=
 =?utf-8?B?ZlZIaW8vVDYxMFFWdXc0eG9YVGE2N1pHaTlOMnNON1hQODFneDJFR2R3TnVy?=
 =?utf-8?B?TjBuOTJHclphWENUSnNmUitKWEJOeDRUL0dxcVZmblFFQjJqYlBUdnhVYlNI?=
 =?utf-8?B?MnBHcWtXQm5rYmRTMmF5QXZVaW9GM0wxZVhuTnpDUFYvUUtKQ1M0STRyZnRE?=
 =?utf-8?B?WDlVWGZIRXRwTUllMEhocXpSRm9wekdndDhJZTNEL1E5WmxMM2YxRllUT1NI?=
 =?utf-8?B?VGYwWGR2dlozd3VCaWhlTnRoNUFVQ01YUnI1L3JVRkNsSWNIbzJ5aCsxSHJk?=
 =?utf-8?B?S1VNRXRoVUMxSXkzSm91MEdFL1Z5THIrWS9rWkNCaFJWUHVuSTdvQXdyM05u?=
 =?utf-8?B?VGpaODcyRWh1MmZnNjFjTUo0Vndpay9BZ3ZuVUpvcVZKcy9vL3UvSW9FSm5D?=
 =?utf-8?B?UDI5RldqTU9XRTF1blBiUHhVVG1LRkNjVFZGQmVuNTlhYlBtbWRyeTBUdzhQ?=
 =?utf-8?B?R0tHT2xCZUtkOGoxZFpWVU1pWi9QTXkxU3l4RDhTeXpDVXhCa0c3Y0Z6ekJS?=
 =?utf-8?B?TERjK1E3WEFtNU91RGF6bW5LRzZKQzJIQzZSMzRiWDdLTjBIUEhBU2ZCTDlm?=
 =?utf-8?B?Z0tvdnVBZ0ZkTUJSa05YTDRtYVBrMis1VHg2bUFkTmZPWlhGNmtjY1RRa0ZF?=
 =?utf-8?B?NHE3TFZDcWdCWGl3NFBPUmluRDUraEpGUG5ITU9XVWtBRmwrTTR1bytscFRD?=
 =?utf-8?B?cVRCenBzYlJ6a1BpeDRCR2xIbGpnZVduc3lqY1FVUHhrTEliZUZwa1NDcUFu?=
 =?utf-8?B?cVM0WmxlOENtQ0VuWDkwbnVoV2VyTVA4NGRCaVZ5TlFRTi9HU0ErK1o4eWYy?=
 =?utf-8?B?RUNteFM2c3VVUG1QU3hLZTdNNGNNTUlVS3A2dmx0UjNWQnVwdXZsM1FtT2xV?=
 =?utf-8?B?bkxGL0cyd09jRkoyVzdUMXlGNGJTb0s5MWhORWxpTHNvaVl4Z0hJdmI3SXRy?=
 =?utf-8?B?WTNPMmlRMi9LK0lIVzY2UzNqQTJVRTFrRVNIbmFEcnY1bDV2Y0t4c2xBYzk3?=
 =?utf-8?B?ODJ0NjNENm4vUHN2WnBneVRGcUZUWVh6RU5DODF2UXFNaXMya3J1NGV3d3RV?=
 =?utf-8?Q?Yy4/W/tWsKPObH5PklTPmmwao?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f63bd1b-a091-4968-2784-08dae8faf7d1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 17:43:02.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUh0vEn1REl1AJJaGFkinZQviy8BsvxUprY6fuQDSxCByiCF4nADlKJ05mK1PuwbcVAcCzpDB048+Q38fd2qiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/22 16:57, Akira Yokosawa wrote:

> Hi,
>
> On Wed, 7 Dec 2022 11:30:52 -0600, Carlos Bilbao wrote:
>> Generate rustdoc documentation with the rest of subsystem's documentation
>> in Documentation/output. Add a cross reference to the generated rustdoc in
>> Documentation/rust/index.rst if Sphinx target rustdoc is set.
> The note on rustdoc won't help much in non-html outputs.
> Please apply patch below on top.


Makes sense, adding, thanks.


>
> You can keep my Rb tag.
>
> When rustdoc arrives at https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2F&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7Ca141a966f51d493262e808dad8a67a5a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638060506786726160%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=BB919zHtKyMyQ5T8dLaMwkquTzvjVhV%2FuxiSgeRXABU%3D&amp;reserved=0, a note
> for non-html outputs directing people there might be helpful,
> I guess.
>
>          Thanks, Akira
>
>> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   Documentation/rust/index.rst |  8 ++++++++
>>   rust/Makefile                | 15 +++++++++------
>>   2 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/rust/index.rst b/Documentation/rust/index.rst
>> index 4ae8c66b94fa..4fc97c1eb1d1 100644
>> --- a/Documentation/rust/index.rst
>> +++ b/Documentation/rust/index.rst
>> @@ -6,6 +6,14 @@ Rust
>>   Documentation related to Rust within the kernel. To start using Rust
>>   in the kernel, please read the quick-start.rst guide.
>>   
>> +.. only:: rustdoc
>> +
>> +	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
>> +
>> +.. only:: not rustdoc
>> +
>> +	This documentation does not include rustdoc generated information.
>> +
>>   .. toctree::
>>       :maxdepth: 1
>>   
> --- a/Documentation/rust/index.rst
> +++ b/Documentation/rust/index.rst
> @@ -6,11 +6,11 @@ Rust
>   Documentation related to Rust within the kernel. To start using Rust
>   in the kernel, please read the quick-start.rst guide.
>   
> -.. only:: rustdoc
> +.. only:: rustdoc and html
>   
>   	You can also browse `rustdoc documentation <rustdoc/kernel/index.html>`_.
>   
> -.. only:: not rustdoc
> +.. only:: not rustdoc and html
>   
>   	This documentation does not include rustdoc generated information.
>   
