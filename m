Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF29374BDC6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjGHOSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:18:36 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48F183;
        Sat,  8 Jul 2023 07:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HojFrq2xJJ3eoagPmc8mJ6b3CtM9fH3nFw5v0Wo1eHanj1nnOmBDNEU+uCMHWmi5yQdP+tfo+4zLs1eOf96p8GURvIOAiaGIvgirByjF83oRSlNv6YMBNe3CTJdu6C/6TPdIusM35TnHnQAf9tTqz+n7q0tqDyu6asNRTsYpiPYsQWLyF0gYIQFbn1dJ83n0WUq152JenDW+SUHwbpWmbx8FFlCCb8YvLPXYuqGU/VNgK4/DuwQ1Fyo9uASfllpmeafH9Dlc9xooYKCjOzrh/w4q7W5Y8NkKD2uxO0BcHMMpCsKqhbVnPdXJ5KuMCfWp/chmc1eJPglG+yVXVfM3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bmxntlbqHaOC9BfMfdOJ8wPYK0L5P6UuBfaQwOCkTA=;
 b=YarGUrN82SmwQep9JGPvJYrcVaI3TMFP0gKTsU7C/whqmsSxUAj3RDF+8VmuHJmdA6XyVjjs/tQjtcUtqZA4zNe0dcPZJp+YSHzDy60wrzElgZnihmSsgPPsSPi6AA4h5/nwjU4hT7AiuU/FELG8ufYqITC5unjz5VH1vrVXWsliaJIrqQ6q/NSnprD1VomkR9tm4ZcokkWCP+qahNrMyxBG4F1X4HIUE4FMu8uhWDrwCr0vlW4XHzw5QpMB8jsQ+HCfCgFHrdIQT4+z7+HPNVYxAr9a8Nw64A9metQTNcUNVWTmqUdS2mMWKsdcefAYCQ8nzao69hZ94UbyDVDWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bmxntlbqHaOC9BfMfdOJ8wPYK0L5P6UuBfaQwOCkTA=;
 b=mFgqKVG0URVVqH7Ik0UaM9VMyhjuYtynpIZaYeHbVi9MKHohm92gPxGeEluqNzsk7BAYYDojtPpIf/Dpe7VAShgPMNg3bFJNehXs+GwzynxqgKfBAauPD1zw5GaGFHBh3hw/67qQeYQJd/cE1XKHTNUwm2v+09A31XpQqHdO/B2yDn6IWRvq+HgPLErQ77q1LD5Jk32uXx5sFka+kitfddSlE9ZvJcEuDeKmA2t6+HU4Xf7j4B0Gjzt+mgCuB2m/qV7Wz6RnE7MIw5Pi3HZprQ52ppN9305m1VZxwNyGVYxhKgEioAyUu9MibOrcFAjC3UKiuk5ij0r8HZt1WV8o7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by VE1PR04MB7375.eurprd04.prod.outlook.com
 (2603:10a6:800:1a8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 14:18:31 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b%2]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 14:18:31 +0000
Message-ID: <9dabd1fc-7445-a305-6632-04f64e012648@suse.com>
Date:   Sat, 8 Jul 2023 16:18:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] x86/retpoline,kprobes: Avoid treating rethunk as an
 indirect jump
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230705081547.25130-1-petr.pavlu@suse.com>
 <20230705081547.25130-3-petr.pavlu@suse.com>
 <20230705085857.GG462772@hirez.programming.kicks-ass.net>
 <20230705232038.3a6d03e18f7bafb14cdfed42@kernel.org>
 <20230705145017.GC4253@hirez.programming.kicks-ass.net>
 <20230706094723.6934105e03f652923796bf7e@kernel.org>
 <20230706071705.GD2833176@hirez.programming.kicks-ass.net>
 <20230706180014.06705096a594b71250ff3c94@kernel.org>
 <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20230706113403.GI2833176@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::22) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|VE1PR04MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6defc7e9-50e7-4c89-4475-08db7fbe3498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1hyE+KcHy0L+v1Y+UsP/Ht/KYFh5iKTwY9ElAiziSKzfjEDkQ1h8xyXqkBcnDPXEGv7wZtrIadimxTw5iZv1SiacSVSEtMvKyTCXBAjgDh58mD06f1rnzaT54uaiU4mOaJ/145j9g8BWKXfw/F2nQyxSk7x/9YSy+ftxLGWGXA2QAesrdjsUbnLRFO4wYx4ExK0rZfrx/8I796MlgC5xuLWwsb7nqTiGplxJolqDJbPTRNMJRLY4EPO3dbH4oIMoZwhqEnnlLN008LpoGoYcvzRfnu1LcPzf2snt/4TgjUoHfjm4EpvloqyhWA8omiQEyYWt8sO3QJ8uMZqlD32CjYQE+QSWhXcQ3QZ4XOfdcpt4U/rW8d3tBUDkmRM0bcTyGbuqjZm/ZxQeFKhVDkBwKkuFf+Hc50wBKg9EArI/Pzq+IONbsUv417ZDwwO7Gbv0sGoMHadT9OmpCrPTPkRokEhNboTib63xAsSxMK9cGoyMyKOKPZ8ZCoL4bdpdsU6M/QXK2h3oJ9im9ZeUlfsWcuvzrd4EnFbG0F6NJYdldKBQi15+mm9BvdByeS5BapAlAPhvpS8h961IicKEyxQhZbfl//M1RtxYalcntDoBPkCLjg+XpQWGNz/XN+BAC2CTnslazW7HZPH1k51FK+HIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(110136005)(478600001)(6486002)(55236004)(53546011)(6506007)(26005)(6512007)(186003)(2906002)(41300700001)(316002)(66476007)(4326008)(66556008)(44832011)(5660300002)(7416002)(8936002)(8676002)(38100700002)(66946007)(31696002)(86362001)(36756003)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHhFdkd1OEZIUEhaSGM5K1RrYzhpcThsWXhSTHlsRmt4dVRWb0hJYkJSc21k?=
 =?utf-8?B?R3NQbVFobGx5Vk45YUd1ODFGVVNqZjlqeE5JUkk1S2MyczVUNlR5ZTdMYk9N?=
 =?utf-8?B?WHA0Ym9Xam1IbnE2Zms4Nkw0VkRTK2hsY1I3Wi9XTW1nRnBJZHZMUWxhNWxB?=
 =?utf-8?B?OHdaTllMWXZaSERqcERsb1JqYkpQR2E2NUlIc3VjS1FuNmVkeUpONkpsMXRu?=
 =?utf-8?B?dCtWNGNLTkRoY0xNeCtLUm1VSDBOQXgrd0NyVkxpU1E5bVcvWThZRlJ3SG1L?=
 =?utf-8?B?L29xbFpvblNWNEZFb0JoVmZMVTBBc09sNGNpd0hWTEROMUtQZFVRWHpVaWNW?=
 =?utf-8?B?aUFFZ016bkNhT1VvUzk2a3dvOXJOc0ZhZWw0NlVTcjNxVEZKUEJsQTlyMEpp?=
 =?utf-8?B?NXJEYWRNVm9uY3RIbkYxam5ZWDNKRFlkM3RHRHIyd0JzT3RBUGJMSXZOeXBr?=
 =?utf-8?B?T29aYnRxYmlXUzJsclVhMnozSjAzZ1p0dTY4WFJzMXZkdEYzaEo1VStwOUd4?=
 =?utf-8?B?TDhoMi9XT3BxaDJGQ0lzSUUrY2RmckhxcDJ6VEhYZFBIUmR2VkRkNzRqRlFI?=
 =?utf-8?B?NHo5Mjd3Yk9PVE9rOVRCLzNkOVAxRG5UbGpKdXBpRUs5R0dHcklQZS9aY2oz?=
 =?utf-8?B?bmY1cHpEcDFKUHJVSTk5UG9MZng1UDVGZ1p1OFNDK04vdWpwRnd5Y1g2cnd6?=
 =?utf-8?B?aFpqb2p5M0FaYzd6a1g3bHBzU3kwLzlFNUMyaWFEdWpkMHV2VW1YM0JuWjMr?=
 =?utf-8?B?NVFubjc0SGRKSUlvRDJFYmZpVlByRTR3cWUrTEpZTzV1YUlEbzI5alR0ZUVu?=
 =?utf-8?B?NVlGb2ZJSXlpVkRvUmR2V1ErN2lhc2UxZWxTNkI2ckwwOCtDeVo1ckhyYU4w?=
 =?utf-8?B?MXN1VEU4L1BUanVrQmNSb0w5bUtQYys5WGxtWnRRRkFhY0dQbWEwYUJrVkRy?=
 =?utf-8?B?ME1kZG1NQUtsRkl0bVBNbTlvaVRQM1lXT2swMDhWNVRXYmExUTdPQktXbFNP?=
 =?utf-8?B?V2RwSnNVT1ZXYUFZcEtFTmJLNCs1SXk1MHRrbzJseVVjaGNDQUR1aWtiNVRE?=
 =?utf-8?B?WTVYOGRDMGJ3dXoxUFhKMTQ2dGQ5MjIrbjZkTnoyb1J1YmdYOU5sZnF1dDBy?=
 =?utf-8?B?ZWlualhUUnhKT20xZnFmS29SNllnUXNmQW4zeE83Qlh2QmgrOUNRdW9Nbzdn?=
 =?utf-8?B?TXF3YTZHQ1UxeVdTMG83WmJCbk5GbUFQaEhTUldzUTFUVkgwUmNNcUtxS01P?=
 =?utf-8?B?aUJnZzlFVVc2TFh5bjhvMC9sYWZrY0w4U05UMXkzdEQwdVdVZmVrMUtFdmRp?=
 =?utf-8?B?Nzd4VUlRRjNPY1pFcE51ZmZOWFdrYWg0VmxBTkNqb2pvcEI1U3pTMHcvbzJO?=
 =?utf-8?B?eCt4TXI2TGthL3NKSE1JOGZlcmgwQ2NncnRoSVY1MjgxcExKaFBXQW9CNllN?=
 =?utf-8?B?WHVxNzNsVXkrRWpyMjIyd002VXZ2eEVPK0ptQ1hQSk1WRnBFSW9IL2dpa1Vj?=
 =?utf-8?B?UGpkK3VFdTY0THhrNVRrS2hwTGJvZzRFNysxWktLOGU1bGZ0ckdJZ043R3Rj?=
 =?utf-8?B?S0xwRFc2QUtuSmRkVUhYUlRONjFtTFZLZ3ZVSnN1d1hHVDVZNFhtV0s4c28w?=
 =?utf-8?B?dHlZN1JFSW1QTDF2cEZtUzRzYmR0TlQ1UzZwdEZkc0lObEdwSnk2OUpGQ0hX?=
 =?utf-8?B?dkdaVThmMFR6RVJISzdrODlQZXJpZUZYNitnL3BueFp4enlxUjgrZ0hHUUN2?=
 =?utf-8?B?UHNIRm1mVURQbUdsUzcvd2NCWUNNMUR1ZTJoWVdUY2l5dVVVbDdLcmNCa3JL?=
 =?utf-8?B?NFh1cmIxZ3pGWjFhNmNRRVludkxBWlE2VlVSNjUyRmRJSk5UWXdIczRFRkZm?=
 =?utf-8?B?TktZWTdqcjY5UmVYN2d6UitybHR5bFhQSHFNMTdDZ2tRdHNqbmlxZjg3SHZh?=
 =?utf-8?B?eTY4bHFPTlMzR2N1c1RnS2hBNFNhQUpOSHdjQ3ZVUGpVWXhOSkxIMjUzeWJz?=
 =?utf-8?B?M3RaVENIQXU1Z2NIQ3MvNko5VWpwMFA5dC82OWxVeWcrTnR4OW9wY1ZENm9u?=
 =?utf-8?B?V2dUVnY3QTUrSlV3U2VBbm9uMnJmSFEzSmk4MFYwZm5aNDA1bFptRHVmY0ZL?=
 =?utf-8?Q?R/63vwKtmYTyv3WgtL1/1j8WZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6defc7e9-50e7-4c89-4475-08db7fbe3498
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 14:18:30.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfJx/d7GM94am7YNT53A4EDLGWhYR7mtzf8G+vmyNOt+neRlQu3SSN715+YTNsgZoPrpw9JH8Qwqtl8WXz9zOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7375
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 13:34, Peter Zijlstra wrote:
> On Thu, Jul 06, 2023 at 06:00:14PM +0900, Masami Hiramatsu wrote:
>> On Thu, 6 Jul 2023 09:17:05 +0200
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> On Thu, Jul 06, 2023 at 09:47:23AM +0900, Masami Hiramatsu wrote:
>>>
>>>>>> If I understand correctly, all indirect jump will be replaced with JMP_NOSPEC.
>>>>>> If you read the insn_jump_into_range, I onlu jecks the jump code, not call.
>>>>>> So the functions only have indirect call still allow optprobe.
>>>>>
>>>>> With the introduction of kCFI JMP_NOSPEC is no longer an equivalent to a
>>>>> C indirect jump.
>>>>
>>>> If I understand correctly, kCFI is enabled by CFI_CLANG, and clang is not
>>>> using jump-tables by default, so we can focus on gcc. In that case
>>>> current check still work, correct?
>>>
>>> IIRC clang can use jump tables, but like GCC needs RETPOLINE=n and
>>> IBT=n, so effectively nobody has them.
>>
>> So if it requires RETPOLINE=n, current __indirect_thunk_start/end checking
>> is not required, right? (that code is embraced with "#ifdef CONFIG_RETPOLINE")
> 
> Correct.

Thank you both for the explanation.

If I understand correctly, it means this second patch can be dropped and
I can instead replace it with a removal of the mentioned check. That
will also void the main motivation for the first patch but that one
should be still at least useful to make the LTO_CLANG=y build lay out
the code in the same way as with other configurations.

I will post an updated series with these changes.

-- Petr

