Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41E6419FB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 00:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLCXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 18:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLCXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 18:11:42 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF2A1E3DA;
        Sat,  3 Dec 2022 15:11:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSib87Wzk9UgbhDr56LizA537ubyMSycrTdcN/aCqKYUABWu3zjb8EaiUYyCN05r/yx0BIBz83ufBQY+kRFWwHHWlgfJLTQSMlSoRKveZvcIBF17dkNXhtzn7qWSyW3sEXdg7+WyrVqj1HyvAry5zoXuXQqu/spFmzIM983BOPdozdT/FowV1tZOplxGIu2twQxIeB4sG0GOor1z6qfCzrvjRVQffEtbgNGqhYlQ5RnUZjqjMU42MbPX2n5lZDHjLV27s1s8Sxvusu87Fr32P/phTnHtPv72YYB7GsTBn1txm/7FniVQ/zzEUyWwEbBhl+AFEYA19fyiyfHITLTC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F69XYNTkAgrF+T29XEsqpnQsmfaSY3N5Mxuna1TWRE=;
 b=nZvWOCKICxOWVpzmjoORYyvR0PftUSKGREwJopjzdhSUSwskKL46iwCo4oEA29W7McLKn7ds+wMlRw5EI4JJUDPBjxiPKUAqtPVE8UO5Gyqa0yippcJi+qpaRojY7R7amcQHj1Lh6HN6wSPX9OdhOTX+cbNWjcqY23HyI//gQKVQ/wIIA3J4u0mjotGJw7rFWUq2xzlYBzPcIDb7nhMO/VlbMoPHb8NU9AVgQW3m4kVN7p56mH/kFBFKzUh0tPgBilDro8X08u4Q7caTqUHfTt0m9sqCWf1/LaNhy9fmUfXXnr/8g7uMe4zri9QnoYM7rfLNKM5CLp8R/tcoT5NM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F69XYNTkAgrF+T29XEsqpnQsmfaSY3N5Mxuna1TWRE=;
 b=UJs2g+1ir1GOSyaYTQseEeJoWczQIQwWLsAZh+60llKlgg8w5Uw8gZrlCB+jcjLtKRZ5ygbZYLCdqIp4P4701Sf+PvEaOQBc1Ztky9NjbWqdQ/h2ry0tcYZvEPQCt3Lk6TMMwE1b23wSYchApY+fWsspKv6tmB4q9WE/L3m2kXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sat, 3 Dec
 2022 23:11:37 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::45b1:34fb:e14d:96e4%4]) with mapi id 15.20.5880.008; Sat, 3 Dec 2022
 23:11:36 +0000
Message-ID: <a3ea1633-98bd-0748-e5a0-774dfe8875d9@amd.com>
Date:   Sat, 3 Dec 2022 17:11:33 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2] docs/sp_SP: Add memory-barriers.txt Spanish
 translation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu
References: <6b1d95ed-3000-3baf-81ae-7794c9515e3b@amd.com>
 <20221128152323.4080455-1-carlos.bilbao@amd.com>
 <878rjoohy2.fsf@meer.lwn.net>
Content-Language: en-US
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <878rjoohy2.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:130::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ff0334-f949-4f2c-049f-08dad583b9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VKXzscbZqRIr/h1TkrqQBq+OcrWsz5X+kZGLe342FsuJNhcscQV8GJTzUAMPP8OHfgWtpwU5f214V9nH5cm86OCeJp0E67v5b/ujRFcyavWaXaFrUybOg+n5VvSq9yy5P02IRDLIh+M49zurNzDtGS50lhi+6fcxP6hjlJILaNpj1dlchePLrPePtCtLd7QaAEf83Mw4jX0UmhetyXJ1UZWt4Ay79gskQc0UGmZiYx1KAsa5Fw4nPTLEY8G5abLF6hbwjpIAmXbmaqJjpK/qdqfAyU6Ci0E/zvGpKC/x/tyLEvMJFoDu94gjTzNqEdcfPaPsN/T4BI/zahOs5oNnEN875XQRyvXjZ7Po4C00D3Etf2Z6PAeT50t+k/v9MUotwr9NMnpsAfbDK2pYJVX2b3zBBTCN/beaaWuDG//HIGl9EeOvhKo+IwN8h7VUaPOeG4ycQGK9bBjn2uS7OZgvGlxXjuVwKYD+qauA6BRAsaPDbrSZ3TtJkb4eYFv7E8hSWz5e1nYlvZk6nF6+TNEvg1aHYfe106A2fxfWXOzlWYnKPe3y3Srm77ac9Z1/tyFXcpjWwW4PWMGP2m4ftJ3aip3hSppxRCiqi8sJTRC//czuMESXpJkHwdFFTql0JHZ7BN0sYPnRXUSiUn+TlTYVHWo8aPKFwKTgmYzpw63EAVTUOu2sUANCqbWbqIkKf//HsS1Xy6yMXXMPrJTGSnl7eGKqro+wMDDfDYsv8Ld1USE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199015)(2906002)(31696002)(86362001)(316002)(6916009)(6666004)(53546011)(6512007)(6506007)(186003)(6486002)(2616005)(478600001)(41300700001)(5660300002)(4744005)(44832011)(8936002)(38100700002)(4326008)(66946007)(66556008)(66476007)(8676002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytNV1FyODR5UjFDcG9OOUVBR0F2NnJkNlRLZkJDQkFCTmp1eEQxTjdZNHNp?=
 =?utf-8?B?U2htenBzSTNZNUdKTW9CY2lRaTduTmFDTHVCWStSbnZxZ2JsclFLTFVDRzNy?=
 =?utf-8?B?VkZibERoMUkyR0pmb3ZXM3ZQZWVEUWV0S0RIcnAybkRoYk96NnQrRGovRnNC?=
 =?utf-8?B?Q3RwZGNSZ1g1cFdqWUozT1YzQzUvVjM1bGNadUxOYWQyOEtpY1lDTG9jMDNz?=
 =?utf-8?B?TVllM1BRam9iaVRwdnNGV0wrd3N2a1FzT2ZiUU1pV3lHNVE0QzhnRG8zUDVm?=
 =?utf-8?B?RmZwMjVRU0JoSlhmYXVVcGpyd21IaDhyWjNsMDZPalk2M0RVbnlhK2owd1NH?=
 =?utf-8?B?bENBcXk1UDFiQ1ZNNUVxRE56VVovWUpveVFuZ2dXY3pneUFYYklycHFGNHlF?=
 =?utf-8?B?ZkU3d2hReVMvMEhjeUI4K21ib01HTWN1dkJOY25OYklIcTJsRU9vVFNQSkE3?=
 =?utf-8?B?dndneU9EdUd0MFZCSjlFWGEvK0RHQXRwTmU5dS9Gck45cThOK1BUU2dVUmg1?=
 =?utf-8?B?T01adEYrKzgrd2M5TXNKbzMwNWRKZy9HQkRWMGZoQ0F4MndxeitlSlJaeGQ4?=
 =?utf-8?B?ZW1QQkdETXZlVjYySFNZTm02YmFUemQzOFJVVDkrK2U2QTBtVnVsK0dKc1Q4?=
 =?utf-8?B?T1J0S1FSd0dpQkl5cVd2ZnJPeEFCNXRqbU0rOUZ3WmhqWFA5NEpqR01wWk96?=
 =?utf-8?B?Z25RNVNJalhCN1k0eWFXMWp2L0JSa3MwbDVuMHVoaWFhQzBnanRnY2FlN0lx?=
 =?utf-8?B?a2FEaG9aZDE3MVprT1dHdVVwY2ptTEpGVFRWSVdLanVjSDhUV3NiVHkrTXVl?=
 =?utf-8?B?T09qZjFYREJCa2JvdXMwN3krdVdpMVZCcVU4TjZwS2l2T05SVDQvYzJFaW1E?=
 =?utf-8?B?Tit1dEQ1YjhySUs3Z0lPSHhaZUxyS2xBaGFlYnZZU3RzMXJVMnlNNEkyWG1v?=
 =?utf-8?B?dENFVExwNVRBVjJSRitrVGRiQXBaWm9Za2M4VGVXOWR5QUpUMTZ2ejhRWkZX?=
 =?utf-8?B?UDM3U1lQVzNZMER3dmk4N1lGSitzSkFUUGxJTEFteW1NbzlsRDJENE9qbUtE?=
 =?utf-8?B?THJ0MTU5Y0JPNXNzaDF2NnZVTjYwTjhtbm5IcmtZbGpTYTJvT2N4WDNlUTZp?=
 =?utf-8?B?NG9tNlNOWUpxajFubnZMYmdPNkdER2Q1QWlxc2htQkxsRW9raGh4MFE2Ni9v?=
 =?utf-8?B?WE9rcDZHM0VRL09mWHRCUGlnNG9TclNIYzRYSlpyUFdMd1dTTVFYOHoyM0V6?=
 =?utf-8?B?VjRiTE1PM2hTQnJYb1gxbzRsVU1aYmlKQ3EyOVZkWlFhTUJoYkJXU3F1NUVj?=
 =?utf-8?B?R2phdFpBSlhwUmR6ajNlNnhscW81NWdTbnVqM0Q2TU9HQTdiaDl5bHplQ3JZ?=
 =?utf-8?B?dWdEQjh5WTRKVHBXR3J4NE40dVNGUElvMWRQUm94YVIwSk1JRWllbVF2TUQr?=
 =?utf-8?B?QkZpNlRZZTVrekUzNVVQRVhJeFBQMDk5dnlMQWMvbTRpZS90SldCanM2QlVh?=
 =?utf-8?B?L3pQUkdEUjBFU0Yvei82cnlHSXNhT2pqOTZGc1FQOWppTkQ0Mi9YUmdMNDVs?=
 =?utf-8?B?THFQemFTU0FodnJpaW5LTTR0WER0S3NKcitWMWpyTDZTbWp4NENiMk5hWHhI?=
 =?utf-8?B?OFJpbGg2WDBaT095NW1jamJwRlptZkxFazA2UVJXR3VxKzJGYzFLNnY1ZkM4?=
 =?utf-8?B?aUMxRGcvUW1DaHg5NHpjYzhqU3V5OGl3MFNXZkN2enNvdjNqZkhtMDNKaXVV?=
 =?utf-8?B?YkRQc0JpZXhObHZoWGpwbmhCNGxWS0ZtektKcnAzKy80cE8zaURvbUFQdlNW?=
 =?utf-8?B?aG1WSTV4RWR1bTZUUTFHSDdIb0ozV0RUaXRJRytDZW1QdDhNNXE5dWlDN1pl?=
 =?utf-8?B?QlhFQjJsa21lVllQYzgrbHlYSTN4aEwrblVJTy9xcnd2ZmN3OWIrUEg4N1Fa?=
 =?utf-8?B?Q0w3bEFIZ29GZTNYMlA4Rnh5MjdNc0xjRWRrUVFvOFRCVnN1NW8rNyszbmFB?=
 =?utf-8?B?eTdLN2dOTFBwVzlYZlpIckdpYllhZmJRekVPWFpJeVFacFNlck1paThUa1Ex?=
 =?utf-8?B?NG8yamRXUkNQQzl1eU9qY1AzNG8rRE9JcU92bTZMZ3NtZXRZclhXQllpV3l5?=
 =?utf-8?B?dXNyUmhCVlJ1UkYrK09lYVJXVWM2Zk5HMkFoV05ERWZRc0RyRU1uVmhhcktF?=
 =?utf-8?Q?2r3M6smYl8Y0LTu4zcLjcRprlG+Nvx8cnlsU5Aaqwt84?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ff0334-f949-4f2c-049f-08dad583b9e8
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2022 23:11:36.5424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvqSwLnX8FpCO1FB8i0vbmv2mo9OeePkCg9OqigtRi3/jx1MJt3FYDBwIQADfTwJ51nQShlfLrqSKhXd5KZs1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/22 5:16 AM, Jonathan Corbet wrote:
> Carlos Bilbao <carlos.bilbao@amd.com> writes:
> 
>> Translate the following documents into Spanish:
>>
>> - memory-barriers.txt
>>
>> using the wrapper documents system.
>>
>> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>  Documentation/translations/sp_SP/index.rst    |    1 +
>>  .../translations/sp_SP/memory-barriers.txt    | 3134 +++++++++++++++++
>>  .../sp_SP/wrappers/memory-barriers.rst        |   19 +
>>  3 files changed, 3154 insertions(+)
>>  create mode 100644 Documentation/translations/sp_SP/memory-barriers.txt
>>  create mode 100644 Documentation/translations/sp_SP/wrappers/memory-barriers.rst
> 
> I've applied this, thanks.
> 
> For future reference, it would make life just a little easier if you'd
> put patches inline rather than as attachments.

That's weird, I just used git send-email. Maybe it showed up as an
attachment due to its large size.

> 
> Thanks,
> 
> jon

Thanks,
Carlos
