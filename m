Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713EF60AE98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiJXPJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJXPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:08:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82120ABF0A;
        Mon, 24 Oct 2022 06:45:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJlESgWuz2LxDoZZDrwqmJopthEl5b3nDH1arCtky3P/hBHzycXANQT9U93/MqlO8Cix7xZIhrjer9GUZATf2CyJRzcbSvS4dsdrsnm0ofxnFD4vl9IFBBoz8KBBfblaLuv1hsl7sWmuk76kVLNSKFpXGcqUvW9XE/K+81gVeyWnQDeg0DEA66OESNI6nUb9JqECoNTCLtewOJQQaBrvDpAHqh278ZjftsoepirpYSLx05IK9E5+OOuNYznSbQHs/qFFKvsBOz+Yrt62vAPxmh1zEiKIyh9i01vPxgTWE9Vl/6yKhgDQqWEdOyslvIpq3TTBfREYHZKnEsr7HQj+dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niOnhDCmrF2cgZWe7FOf6zCZbQlRu3H2Qub3lyQL8Z4=;
 b=YazMpaVXtmL3tYaCRxOSkdo8oUEiaqcZ1hj78/+idLOO4nYpOjwWEtu/uENynwjK2R8+J3ZbvOtjt0HFHX0DHMkudZai2etayefFqNrqCo3Ek/XmVC/OAEF0nCM1b9anJA7eKlsxJX098e/g21NSxpHB5Riui4qrOtMV0zTE3jzUDLL6nTgjCxclJs8+jqaJv+a9Q69F+5EDEn7BU3wnXE2tGS71YbJAFu6qWuo8UvH2vBFkxjVE3KBEwH3XG1y3iId4tfw1MMYR4W/CXpD99kvt0gASUtWQ62bOzLCSuDKU/lkiTEUMQk+UOLsE5L4zciMkIplH+3SjjD9cF6sumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niOnhDCmrF2cgZWe7FOf6zCZbQlRu3H2Qub3lyQL8Z4=;
 b=mnzlObXfjJFZ+7BYtqzTfDrZ1HxsSizQbglE9Z0VYYcWD6t4hL1Oxr6YIx+jSKY2Du5biTjeoV9FYLqEWz7mtD+jHbkBMjNREXYBUzmkVLt46QChgvnoBcc5L7UqXZpHdofLJjtj1a4DRkkCBsVR1TXIsF+bfvWn1N3Sf5EW20M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Mon, 24 Oct
 2022 13:40:45 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::9eca:d454:d407:7ba2%3]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 13:40:45 +0000
Message-ID: <9e65ba16-68d3-8d11-c6ac-c35c29026688@amd.com>
Date:   Mon, 24 Oct 2022 08:40:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] Documentation: Start translations to Spanish
To:     Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bilbao@vt.edu, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com
References: <20221014142454.871196-2-carlos.bilbao@amd.com>
 <48b4a5a1-2a52-4159-699b-9db73a012892@gmail.com>
 <Y01pkubcT7FOwCjL@casper.infradead.org>
 <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <8e2a1da1-2914-b223-85b0-a769339d9c39@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:610:20::38) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3840869b-c979-418e-e1f3-08dab5c55a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6edjE+9jw+Qd+rOKF8Qq1LtL/UBE5q2WxpY5wPfMJKBqDRallrzV+c69E1Hq5uElqB7zyB8CW5ZQz8pG+uzkEMDd3UPzgyvsWdaDGN2XNXssgzKenIDFkz1h3a4zXsq6oOLqYsGfuQmhO457yTgChqpqhmWasBbW25azs5niMIlsE1XkVw71RyOrR4kiuUIXvj815q6iROe3qF4odHkxE0fv+VmkbvEh53uRt0hIU3tLB//oUYyzCQAZ9IWmFOwfk7/jIpQyE+I1FuFz4P33um2Va4jiobmdO5UkwlsY1FMx7Hr6hnztBcHd1pb+vI8/OhKBZHV/6Mryd7byChRrwkvdnAcHad9C5WsQlli5ByDQVw9LyU97qQC4arrLq3T6B0Uo8euUwoB9uW+4Whbd0Xq+muukZIxBcQ9VUzp0KVrmqw59VN0Sq0sbR4PKM+HkTzYFdjzd7mFt6cojfLA7XdaPgRhyOVUOvIzkFpdhEI3ON1i+K/ipkMA+aXxnf+z/+inHQY/JWz+7Hm6OrEIl/g4w/w5i1HGLXojDmY5Ow6wTLwnT37f7ddzU7GMvulWOhQwfZ9PoBV8aRgwL1pFzd5FFYCTW7rJJkjCzphMyptj4p8jfhLFUmdKXr78S/rZJXg0sOmkQ13q58bVuoTnX2VhjN8o1AAdeQVigSX1jtFhCMX5MmHHqDo037zzuTf6LLyMaoPEGaa0n4frr1EdOqEnZD+KBCaToehsuf9rTzbvYe/O5aZD6BuYC18KYQts1X83RINVsETPTmxGKXor1vD9uf+c/08mhaYMdvPsXaGiOOZ8dl7YyqNSxMemr+Nhv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36756003)(26005)(41300700001)(6512007)(86362001)(478600001)(2616005)(66574015)(66946007)(8936002)(6506007)(186003)(2906002)(66476007)(6666004)(4326008)(53546011)(31696002)(5660300002)(966005)(110136005)(44832011)(6486002)(316002)(38100700002)(8676002)(45080400002)(83380400001)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhjbGg4dGpUdG5aejFkeDF1NXNZSlg5OXhCMDhMQ2xabHhCb2t3SWsyUWdz?=
 =?utf-8?B?eFZzNncxYk1QYXNaZCs2Y1cwL2NGVFBBbXgrMDhmYUNVOGpKWFJvRzU4enBT?=
 =?utf-8?B?aFg0czVtWWpXSXdscFdFWXpKc1A5Z3FmRXJGOFhUaktvQWRGNFZUY0FRdzRH?=
 =?utf-8?B?R1BaeVZNRnBLRmRGV3Rhd0plS0RYV0JyWXYvSkErZ1ZiSjdsaHBrd2YyejZy?=
 =?utf-8?B?dU1wcmV5NGVFMXBkRnk2RjJxM1NMV3JhaW9YVUlCdVBITnFjZGhlUzd6aVlY?=
 =?utf-8?B?ODZXaFduNG1acXhnb001MEFlWDFXNEdmYkt1UzF4c1d1dHBOc3BSQnNVTmNk?=
 =?utf-8?B?ZnFTK1BZa2lpUWdQNVV3cW9VN2oxbnlQQ0UxRW9RbEJMZ1RjbzdvV1J5bk1G?=
 =?utf-8?B?V2x5Zi9vNE5pS3JvVlFnM0ZRNlpzZ1pMaTY4SGVRMWMzVWdSRm5XSDUrZHhj?=
 =?utf-8?B?TXJtZzU3TytkRTlVVEM0bG1BZmMyVURhbWVmUExsWC9wVGN2OFZwNjZuZjVh?=
 =?utf-8?B?NERSYTE5aG5jTVZweGpGSEttOERaZEdCYTY2RzNQMUlYTDMvVjQzRlZiZlA0?=
 =?utf-8?B?bXdBU2laK2F2TE82SFp6M200dHZiTlUxQlB5bmY1aS84Q282SDN5YmZZbWZy?=
 =?utf-8?B?QmJERDZyYVJWVlhjM1BKNkYzbjQxQmZXeDc3cEsxb2tYZThWcDdFUVFSRkFX?=
 =?utf-8?B?TVhZNmk0bWFWbS9JZWZHZTBWRHRvcCtTVnNuZ3B6U2RtRmpOdWthaFljMnJE?=
 =?utf-8?B?Ulh1dEpjemF6UG5OSjdBOExTMStHNGlNdnhWWFJSQmFmQWl4UUJVcnl6aUd0?=
 =?utf-8?B?dnRPSHBPZzlpM3ZsNUFWTkFqcldNWUVibk5tbHEwVmdLcW10U2VwRVBCK2Rn?=
 =?utf-8?B?SEhZZ0o3SDZLZWw3SWs0WElTem9xUzhuS3dvSWhYcnRRMFh4RmxUdGIvWkJV?=
 =?utf-8?B?c2dRUFFIS3U5dFlHazFRMzdSZ3doMFJ1UVQwTUtnSmw0ZzdGSi9OMHh3VC9n?=
 =?utf-8?B?N0hySThINnBhcTl4YVVHaUg1eGZjQUE3USsvRzN2clNJYk80V3NvKzk3bmxy?=
 =?utf-8?B?NnBjQ2I2U1pSdExWV2dBejdkcFFLSEFCNXJUbzdybkVmc3BocVZKNTJ4Vmlq?=
 =?utf-8?B?N1lrZ2FRMTNNN0g1eFBkRHF5azFEQ0ZkczhsbVE5Q28yUFBpOGsxKzYrcml0?=
 =?utf-8?B?dHd1cDZXS3FyQzlEa0tPbENNWUxZMmhMSFNycm9BSzlMMjZOcjJlSEVNek9o?=
 =?utf-8?B?WkMrWVVoZ1pScDJPV2JwTjJmR054amZmOE84N1FSTU1kR0lWeXJybmc1U2dy?=
 =?utf-8?B?OUVzY2JHQXovQ0k4bGplZGVRY3Urdjh2Z0VsejZXaDErMk82a0JnaFYwSlVJ?=
 =?utf-8?B?SjlZU0xpOWJxc0hCWEMyQ1ZlUlBEdWlGeXB0NjhxZVlVRHZ6WFBtdSt0UTRP?=
 =?utf-8?B?ckxFYnBxZ3dxblJWWFRTQTN0Vk5qY25NdnNvRkY3RWdhKy82SUZoWWtRbG9s?=
 =?utf-8?B?d1lzQSt6OHAvUFY1Ti9FeEJCdXZ5OW00RE5xSUI0Vk9GS1pyRGM5MEZFY2lm?=
 =?utf-8?B?cHpGRkc0QkNJbWxlWHIyeE5Ia0dtNks0a0JDUDNMQytYazNqc3NneE5Lcmxm?=
 =?utf-8?B?ZEwyK0hXRmxYajZWUFNBeXB2TFVrR0h6Z29Hd0JmS3VscXFuZGlwMTlsUFhV?=
 =?utf-8?B?NTAzbmZuOXdOTk9reWdGQ3lTWUV4OTM2V1ljLzVSejAreXl1bmRMcm1tbnFY?=
 =?utf-8?B?dklhL0VmOEFqNFhsckxON0RoaU1oZGFHK1c2U1IrdWZvdTdMRmtyRlZ2OXdl?=
 =?utf-8?B?SFFISFhSS0FFUmpCSEYwRklDOGVlYlZSb0x5TU1iNXpoa3pkM1dKRkZ6cG5Y?=
 =?utf-8?B?Ym5RUEJGZVhuMFRXTXpFL3dXTkNZd2xPK0Y5WWZPVk9ZL2hKeUU4cktkNFBP?=
 =?utf-8?B?c0Fzc081ZHZ0TDIyMW5Ta2lXRGk4bUVpRzByMWFzSTBtT0o5WjFubDJRZUlj?=
 =?utf-8?B?NFVUNzdvQU5QUTJoMVc1bkF1WEJJYVF3b1puWmhONys4bkNqdmc0R1BKYlpo?=
 =?utf-8?B?Z1FPeXR2NVNxczRmYVJiYXUrOG1ZNUMzZWR1ajBVSHNzTTJMdDdFS1NlYTNS?=
 =?utf-8?Q?02hUEBkMfsuWInJjozXjcuP91?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3840869b-c979-418e-e1f3-08dab5c55a14
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 13:40:45.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAAY/ylol7Ew+aQ/sj8uDR2NfCksTSYPD8i/XDwVjlPoUlZBNw5dXx6Hv4+dToAB0CXP3E64DTKtBANsE9OFWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 21:36, Akira Yokosawa wrote:

> On 2022/10/17 23:41, Matthew Wilcox wrote:
>> On Sat, Oct 15, 2022 at 01:06:36PM +0900, Akira Yokosawa wrote:
>>> Hi,
>>> Minor nit on language code.
>>>
>>> On Fri, 14 Oct 2022 09:24:53 -0500, Carlos Bilbao wrote:
>>>> Start the process of translating kernel documentation to Spanish. Create
>>>> sp_SP/ and include an index and a disclaimer, following the approach of
>>>> prior translations. Add Carlos Bilbao as MAINTAINER of this translation
>>>> effort.
>>> IIUC, the language code for "Spanish (Spain)" should be "es-ES", as is
>>> listed at e.g., https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.lingoes.net%2Fen%2Ftranslator%2Flangcode.htm&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7C44c226d534f44b4afc1f08dab0b1893b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638016573808784843%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=bTm9yjEtum2LkTFkN1kZphytfVKN9Si2Ypk7j6s%2FaVw%3D&amp;reserved=0.
>>>
>>> The other translations use directory names found in the table, with
>>> "-" replaced with "_".  It would be better to be consistent.
>> I don't know what standard we're actually following.  RFC5646 suggests
>> simply using "es", with "es-419" for Latin America specialisation or
>> "es-ES" for Spain.  I don't know how much variation there is between
>> different Spanish dialects for technical documents; as I understand it,
>> it's worth supporting two dialects of Chinese, but we merrily mix &
>> match en_US and en_GB spellings.  Similarly, I wouldn't suggest that we
>> have separate translations for fr_CA, fr_CH, fr_FR, just a single 'fr'
>> would be fine.
>>
>> We do need to be careful here; people are rightfully sensitive about
>> being incorrectly grouped together.  If possible we should find a
>> standard to follow that's been defined by experts in these matters.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FIETF_language_tag&amp;data=05%7C01%7Ccarlos.bilbao%40amd.com%7C44c226d534f44b4afc1f08dab0b1893b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638016573808784843%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3T9bPQzcj9hEuZiPkjIU%2BPCEaxAivgaNKZ2gL5m3OQA%3D&amp;reserved=0 may be a good place to
>> start looking.
> I think generic "es" is OK, especially if "es_ES" can have such a
> negative connotation to some. I just wanted to point out "sp_SP"
> looks wrong.
>
> Carlos, if you go the "es" way, it would be better to mention the
> reason of the choice in the Changelog for future reference.
>
> Subdirectories "ja_JP", "ko_KR", and "zh_CN" were added under
> Documentation/ way back in 2007 (v2.6.23).
>
> As you might see, two of the three language codes needed region
> distinction and they were reasonable choices at the time.
>
>          Thanks, Akira

Answering to Akira and Matthew below. Thanks to both for valuable feedback.

I made the conscious choice of not using es_ES, because as mentioned, it
references a standard that I don’t intend to follow myself or enforce on
Spanish translations. es_ES is a standard that comes from “Esp”-aña (Spain,
the country) whereas “sp_SP” is as in "Sp"-anish, the language, not the
country. Regarding this, I took the liberty of adding an extra paragraph to
index.rs. I would translate it to English like:

"Many countries speak Spanish, each one with its own culture, expressions,
and sometimes significant grammatical differences. The translators are free
to use the version of Spanish which they are most comfortable with. In
principle, these small differences should not pose a great barrier for
speakers of different versions of Spanish, albeit in case of doubt, you can
ask the maintainers."

I also opted for not using es_ES due to its geographical connotations. If
someone from Peru, Mexico, Argentina, … submits a translation tomorrow, I
would review it and we would understand each other just fine. Even within
“Spain” there are many dialects and things change within regions. I
reiterate that all dialects should be allowed in this directory.

Fortunately for us, versions of Spanish differ much more in spoken form
than they do when written. This does not happen between traditional and
simplified Chinese.

On top of everything else, using locale es_ES may imply that spell checks
on that directory using the locale es_ES would be clean, but this is very
far from reality, among other things, because all the English terms we
inherit regarding computers. As Miguel Ojeda pointed out somewhere in this
thread, there are terms that is better if we do not translate, to favor
understanding of code/other documents.

I will update the corresponding commit message to clarify why we are using
es_ES format in this particular case.

Best regards,
Carlos

