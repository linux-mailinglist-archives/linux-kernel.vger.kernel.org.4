Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA766592C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjAKKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237980AbjAKKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:39:39 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3BDF57;
        Wed, 11 Jan 2023 02:39:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx961YogQICjqGstCGyPyRurUomZFmpGo9pHCqauCAsLEdiRlltYiazsUbjjM2mFyN/49WV4ifAA7Ul/3rnk1CDY1MODlHP2Fv2RfKK48ahfswUU7+vhHpXeUYXYBA/7fuEDGa29dylf81ukNdGhwMu89W7DRrLeE/b1ozoZzoi0LLNxXSLSp4zg+EZUiMg+Y0TKPwAHoRuW8yzClD+TwtFazQEWoK7SGrndJMTGOQVTgc6YLaJcNJP3lZ8YidYq+SIO8K8b83ZoOvQLCWDT5W7pNCs8ohqCxbcpjnUW17UQBo0YVT29WS/KEEuPR06r/qYFl25S9uBUiMt6CQ4YPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uQX6iVlVaEEE29Sq5+dcJh6aecIyQ8aI7UqNxbxe84=;
 b=BMbEuev2ARCPNSz14n8Xo1jvMoaVp1bhkSmmTcK774qDM2V0wdKjQeD9c/GUFrQV2hZPTBdf605bt1ytJQ9q68DHDZWOAMLudVI8LXFnflF6dYxJyr0U1LHBW7BO5xiq9kUlLnsQ8tylEBA7iesFzZm5RALEbrKVcRK+DaFecDug7rAER62dzCz4a34SLlCFPcytqPRVbmgn2YHKy2md0CaWFtzAdLMyPE27S9SEXoaaVEk0qbt/F0aRTsdUGOHxv6bsmucboPL8UpOvy3NcPn5ZG4O7yBQ7X9NlGgSB6b30hCrGowMFqiT8vPK0Ey2LUem1ygvWwS5PZ6Isl0hZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uQX6iVlVaEEE29Sq5+dcJh6aecIyQ8aI7UqNxbxe84=;
 b=sFYAOHKDh750xuDqtBRT7O6rT6r2j1akboMZOIaL6w8LwSEdWDiImOOTN+4QDJeZJ7rVC8wgp/KS/1GiINycHwApHr3bKuO1xZ/b8TWupt9JIRpup7ejITyJtJgOEqcAJMgDlRl6NiQYh64ktXxjKFi1xN18VK0hzsPYurXWT3pta/7Zwx2tGFDJVdQ94tuLezrZdnVLr9hdJ11XNaegkgN8dNmU5B9XrH32SEsq6ise5xa4A7fRptGFRgyLhXOilV0sV5MCk/nNE7E+k1RQDysE4kv2SyPbDXIktHCWlA7QDOW9TuZLBicrcUT/gq/tWk+apoyydyVvrUc8GyFy+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Wed, 11 Jan 2023 10:39:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::f1be:5d:f297:e2f%7]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 10:39:36 +0000
Message-ID: <e1a29bfd-7553-ec43-431e-0828191d2127@nvidia.com>
Date:   Wed, 11 Jan 2023 10:35:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: gadget: u_ether: Don't warn in
 gether_setup_name_default()
Content-Language: en-US
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230106161759.66019-1-jonathanh@nvidia.com>
 <87cab5a1-a122-2b10-43b4-7a5819ff55ef@collabora.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <87cab5a1-a122-2b10-43b4-7a5819ff55ef@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::7) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ad0752-5910-4ba4-d710-08daf3c02225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u5Hh0dSVRWzA7yHvRWlnl2JIUYy+j/5w+S6Jr3L9I1HsHN91cNjgtQIDoGg30dr+zgNwYII7KNbX10k1OFWho5ZB6Wg5uCMeT81OeBev+I//EZ+Cl7dn+5D76ffXF8tYUIUZ+NlcIslgHybSBhJp7iI09gELttQV2EbKSXzdlU4yXXFG6L3Wyelz+pbo0GhqdDY3pBIyw5u4llN+gBjxM4hwUVqYukkcej7LOpklTi9iSt711ojFyMQJSGkjTv7jvCyoVEsR9WVybqNdHQsxQIb3sXwk7XZhgy+UkrBMjTEgBA1NR9yoAY36PKwrbr8AdPgMMPL7tsCzAxC/3toX4nzQtD+CmCrj+9nvO+VIMdfl/LVful9PQyBAPPNGUo8UuXVjV85YyTSp2MPkfXw8DmGsQDzOCaXV4VYzStI19yKsFKzhPRRtVvj6jSNsTiG05vc7frCaGAN7/5dDeazEESN/JiFIyEoeWnym/V4B4SV7nRI0JfniuNPHuzF5HypU/JZ3rNCH7Ds+KTST/029aFiZhWHqvkwe5dRU3nqXi3nURZFhufdkO3edRxNes/Jw3nFPK7yOnVe8SXRHAMk4r3MGMRhKAlynd5+u7F6MApaZwxdP1XwZ/zA+sT8XUEFW+udlQ620yrqNUjeDqMVyUsuP0cS9r7q7QZQbGOwtj/q+I/mFRwrO3zlZwmCGsbX+b2UXf9lJJrofrr5xlHWj6N7heeiDBNrByHcO307L3R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199015)(31696002)(86362001)(31686004)(110136005)(316002)(2616005)(66556008)(66946007)(66476007)(8676002)(186003)(26005)(478600001)(6512007)(6486002)(6506007)(53546011)(55236004)(6666004)(38100700002)(36756003)(2906002)(8936002)(83380400001)(4326008)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTRTT0UzSDBkUVptYWl2YXdZRU1ESjN6MndaWjhHMlo5cFgydEhyK0FnM2JP?=
 =?utf-8?B?WERYN3ZORXVta1l2UDZXVkdSVzRhcFh3cFRKMmczTGxpTDQ5bEVWOXJJdXFT?=
 =?utf-8?B?dEdwZG4vNEJKcGl2K0NFMUl0amZRdFJpMUJVQlZIVVNhaVRHZmUzMU5IMS8w?=
 =?utf-8?B?RytKWlBFSW1QUi96TmxabDhZK3VtMFdkbjc3U1lYeTlaTDM1Nk9ySXFYNEQw?=
 =?utf-8?B?RDZWd0EwNStPd3E4a0F3Z1krRzlURjl5RW5QQ2ltdFlmeVdTbUlzSTBkWmVi?=
 =?utf-8?B?VThlSDFUbWZoVEdvMDFsL0FYWklOQWRlU0ZJTmE4bFVGaWdXV2ZIeUZnOFo0?=
 =?utf-8?B?bWxkYWs1ajAyL0JVR3ZteUp6ZFVpcEVsSnFkZXZXKzhEL2ZqWGN4L3pmM25u?=
 =?utf-8?B?STR0MUtqVFY2ZEprNFZ3RjZja0hEbGlPVUpOSkFpYVFmbEVYR3JNMTVKeG5F?=
 =?utf-8?B?STZ0UDZEQ21DVDNNOXhCTkpaVU9hM25BVUF3K2JTVHQ2dXhlZk1NUGRBV2hp?=
 =?utf-8?B?K3R4Q0pBblBJeHlrTDRacGh6YzhYTUpXeDhQZ25YRmJNd0pjTzdVRm5TZkJZ?=
 =?utf-8?B?RVQ5dnF3eFl1Z1c2S1hTTlpWc21JOC9HdWdvRjcvNDV1NFRaOXV5YTBVNEkx?=
 =?utf-8?B?cGNNZVh2NFRndFVKL3plYmRtYWswVW1NSklmYTdYdTNzTWE4RDllNElJNHFp?=
 =?utf-8?B?K0Q3U2Mxd0JPMWZkYTBTN0svbjR3WnphaklOSllOUEVSc2FPNldwTTF2dGcy?=
 =?utf-8?B?N2pWUnlPT29UQ3MvZjhzQnB5TVRJY0t2WnhtNUJjRUNtYWlmQzhCSysrTkkv?=
 =?utf-8?B?V1VhSkxTejRXSEQ0cDJWSnlXZmZOWEN3Ti9Za2lvcjg0MEtpMTJqTTVDU3h1?=
 =?utf-8?B?L3k2OTZmK2lRYXcrdEN6THQ4L0t5RWkyUG1sMU1jNmQzeHdRdmVHTG5vR0hN?=
 =?utf-8?B?RXJwdlFDY214aFQ4UHZIMllUNEZrTDh0RkdGMFdvemhZaURla1M0M3JENnY4?=
 =?utf-8?B?TDgxRWk4UjJxVEhCZjQranlkWGpydU5QTVpBRFYwTE4zSWZ4UGp5L3MzdmVi?=
 =?utf-8?B?eEVoR3FRMU5JczhFcldQRWNmcHZYemFHaFdlZHF6b0pQblhlVGY4V3FlS09Q?=
 =?utf-8?B?T2FLMXN6Y2V5WlZKYjNiNGhiRWtKZE92Vll5ajRFVEZwOW9Hdm1obDJUeGE2?=
 =?utf-8?B?T3F5RDJ1ckNVc1FsL3ExSjJyYjNTN0ZIdkhyRnd0RldtOVlaTStVeHQ3Zmcz?=
 =?utf-8?B?NlE4VUgyL2xPcDFMTzRRdWRSWjFqejVaNVEzUFRsYzBkbXV4QW5lWEJPQVdJ?=
 =?utf-8?B?cHpqYXc4bDR4TjhCMUE2QzVBUjZXZkRhZHZqMUN3aDNVQ29TRHM0a1BTNXhX?=
 =?utf-8?B?YzJVT3g4YlFWRmduR3YrRXorL0l6UXV2ZURXZXllZXZCVnc4SmxnaTZNQ0Jr?=
 =?utf-8?B?TCtBcDREd2FvTDhSVGFZQ2RZbjlKR3pyMzlTUW9PUWIrSE1JWnAwV1ZmTElE?=
 =?utf-8?B?dmtlWUxmZjcweSs4ZEN3bGs2bWhDMEhSZVBVRFhZWjA3cnVmR3VRTHVzWlpi?=
 =?utf-8?B?Z3pEeEs5L1VrOVBERVdITlp5ZDFPaGVRNFhSeDB4T3Z2MGhyMGlhbEw5L2Jn?=
 =?utf-8?B?cmw5d3laMGZwbmVsdEtVSkFGajNuRGlaSTRxdnRvbjF5MDBwdGRHK1BFTnIx?=
 =?utf-8?B?aTU5Mk9pKzVDUkEra3FXcHVabzJVVWFvWWd5cml4MzRWYlJodXFkN2dJbmRs?=
 =?utf-8?B?MVVVNlUwanduNW1vMVFRNFU3dDJRUExRS202citNS2pqMWVxNHhtdExOczFT?=
 =?utf-8?B?U2R0ZE1KRGtDUkxQUnBvWWNBV1VvcWxla1pBTFJNSGNuYmZGblNXYVBwUHBp?=
 =?utf-8?B?VnRIeSt1NGNjcVVHWHNrMTk5djlhZjZnQTVyWlFVcmJKN0xRYkFmL2N0QnJS?=
 =?utf-8?B?YnYwQVBrQnlRUlhycURxNG9qRU1JRmp5c0c2ckdrRlJuMmFhRnR6ekRpVk1o?=
 =?utf-8?B?QVpCSCt3RE04a0lsWjdTYy8zS1ZHL1Z6aFBERmdsOUlCcDNIR3MxTUpaUXBy?=
 =?utf-8?B?d2ZYQkU4eU5kWkVubmpNNDhSaXI2d0JDc0JjMmRjVk5aV2lLSFppRHRsTHBp?=
 =?utf-8?B?RXdNcURiN3AzYnIyY0hSTFFiUlZ1Yi94eXpia3dRWldYWXFBQ0hncTZqaEF0?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ad0752-5910-4ba4-d710-08daf3c02225
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 10:39:35.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P0T3tVX3BEB1F03OuX1PhdUqWfDl98NpCj/3DOzVrK7Ol6ikmnikRxXIRVk9M3pOyA1rP/rbTplj+WzT9qqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/01/2023 16:31, Andrzej Pietrasiewicz wrote:
> Hi,
> 
> Hasn't there been a similar patch already?

There could be, but I was not aware. Do you happen to have a link to it?

> W dniu 6.01.2023 o 17:17, Jon Hunter pisze:
>> The function gether_setup_name_default() is called by various USB
>> ethernet gadget drivers. This function always generates the MAC address
>> for the ethernet gadget device and always prints a warning when
>> generating the MAC address. Given that these messages are expected, make
>> these prints informational instead of warnings.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   drivers/usb/gadget/function/u_ether.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_ether.c 
>> b/drivers/usb/gadget/function/u_ether.c
>> index 8f12f3f8f6ee..c19d66cd1446 100644
>> --- a/drivers/usb/gadget/function/u_ether.c
>> +++ b/drivers/usb/gadget/function/u_ether.c
>> @@ -845,13 +845,13 @@ struct net_device 
>> *gether_setup_name_default(const char *netname)
>>       snprintf(net->name, sizeof(net->name), "%s%%d", netname);
>>       eth_random_addr(dev->dev_mac);
>> -    pr_warn("using random %s ethernet address\n", "self");
>> +    pr_info("using random %s ethernet address\n", "self");
> 
> As far as I can tell this function is called by all Ethernet gadgets,
> and using random Ethernet addresses is the default behavior for all of 
> them,
> including legacy gadgets. Why to inform about the default situation 
> happening?
> So in fact maybe it would be better to eliminate the pr_warn() altogether,
> instead of replacing it with pr_info()? If the user does not care to
> explicitly set some non-default address(es), why would she care to know
> that a randomly selected address has been chosen? Note that learning
> _what_ specific address has been chosen is perfectly doable without
> these pr_info() calls.


That would be fine with me. This print has been there for a long time 
and so I figured people wanted some sort of message. I would be happy to 
remove.

Jon

-- 
nvpublic
