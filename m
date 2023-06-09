Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0744729FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjFIQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjFIQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:13:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81382D44
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTZDfm55vpT/5cupXafd7pvayK/oQI17naHpuDutzteNJyMUHNzeq15TOkGwBAVRm8rIMCD6pSzh9Gx/tkH0fKNGcKDS4KtV4eAMemOtO/ix+tMN1nUGV5lHH3pxTrprwDz3oswJ7c4803b7rFkh1OkHBwKvqNYKR3XgWjQJtp0aYjOzpqsEonlaGimw7+t4i0dB8gBlki1ZJP1YTnysBDDIAvqk2s5+0t8VDektH3lDCeW9ij7VSDgCkbwBhfSj6hfx05rPb9WZg0fwA8k1CFQA6UtHgfLA6enswLR1tfn3pbIkb4y6lPFk+3CDzkCO0uXiDAbqxQGaz5ijryPl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D37oaurnZWMP7VH06uWXPhGA46iV1fCwiiJmgSxQshg=;
 b=kPW/BETxBi4wXM7WIPH7XkNinCyMDoBevAPFLjgVtM7PzXrg/mYEYRsz01BT2+b0EJP9dnbbuQ99cdTkWHIyrAtOA6c0hUyOgqC+IXITD3E37OLOvQC7ot9v1dzZVAUJ0gZZaa1KXP8l/1B0NLKs0QKtiGleWuJBzvVKiyLvDvdtI8dkTYSrBJblA8SWFFZdYPlbnvlPZkd4GUxtskmjvIT24yhpC8qvjwzTj5hN1qfUlD79BtzVmClYhtuWaOEU9UH0ohTmAUv3OoxV7emxAKFhMTbEx/GJqsgenSXAoADwtDSgn20kCz2OYNDtMkdEbojg2Yushh7R4H0nd0g2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D37oaurnZWMP7VH06uWXPhGA46iV1fCwiiJmgSxQshg=;
 b=Yvgm7753+IPOvs322aoH3Z6e7wG2bdPOOgE4GeteYaJeyX5UH5JhL7EBeQOMm1ErNSld35ENLuqBHCCuzLTgN8LQhqXhJNPHGYe7mm70tEfNgGVjk/9J5+k4V6OrD2S14BnNtmtSWUZv5A6qtmnvckeiny3d3YPz8sbxs4vSXlwg+6Nxi1MUIWQCu+xp8yxXYQyganwniyPILc63MV1ZuVGNe17aHWqV0RDZq0XcmImQHjsdIRJVz+fcHjmuAGXmU7b3w+uXIjII3PBvXGNjRsizA1FtABpT4o29gp66xrKJU/8vU4rUrikwpi81CNpf48mBWsmmoTDVvrQOAGEorg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by PAXPR04MB8208.eurprd04.prod.outlook.com (2603:10a6:102:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 16:13:38 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 16:13:38 +0000
Message-ID: <a05d8ac1-d34c-6ce1-3616-22c3c18f5c4f@suse.com>
Date:   Fri, 9 Jun 2023 19:13:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] x86/entry: Disable IA32 syscall if ia32_disabled
 is true
Content-Language: en-US
From:   Nikolay Borisov <nik.borisov@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <20230609111311.4110901-4-nik.borisov@suse.com> <87edmkirtd.ffs@tglx>
 <599dea2f-f158-fd67-2c62-d5372d1d18a0@suse.com>
In-Reply-To: <599dea2f-f158-fd67-2c62-d5372d1d18a0@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0155.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::33) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|PAXPR04MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f2839d-b4c4-40fe-02e8-08db69047c29
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZGqAgLT/p8jD3OcLE3plQ6+tm5wIFBtWOnWzLuXM9GoriGtBKB1XvVaR0wDQIM2EgUcsEtFDfRuunwDMWU2JED7LQ7HlPiWzXL/g5tj0xtB32/iHUyIfW8/Ni44b2clQjXiCkTJGToeN14UuekApFHpXaaXUqP+gO1QvzeHQUlOZAgz2XdPt1nDg7BwwTwm8sKjZQDjHS0Z5eiduvjFxWPXaBxYV46ptePrbd/btlKb9UWYvzFEe1xz477R1ZjQf/5Qus0BzWcSNa9j1JrdWhGClv45QqHWZFnXmZxMTAjllOH4b/NmLnHaMEE5a0WWv5zNGkuTV5uiFtzBd9ex1/dEhplzWQjdGc6wOHxyfvQPZLxIIcZD6xWM+cmPvW6sJVKUauLWrOpj3JhO1lcimEZ+NL6O0tTO9gqt0O+dSqQh7VmkvmHcH8WaZHD0upoTCvjuE44z9a1ozOzwgYHsXM4skNuzLcZIdq04VX2Za1v24x+su10krpWLItO0FJVN1YwuONjx6PqWcKkeWJ4MCv/0wTy8cX1wM8zRC9CtDKt0CZEuno0n5uGFeQ+VZ5SYlSjj6qpTQeTOrc57KpEgzZsmPQBF2EwrmbAyL7vFuYssxom16t7vb8OB67af/6M4l9MM+Q7ptp+m1TJw49bouA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199021)(66556008)(36756003)(4744005)(2906002)(31696002)(5660300002)(86362001)(31686004)(83380400001)(186003)(6666004)(6512007)(6506007)(478600001)(6486002)(4326008)(2616005)(316002)(66946007)(41300700001)(8676002)(38100700002)(66476007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REFZVUorWU5vc2c2TUVGSCs4Sy8zUDgwM21xQ1o1dDF0WkRsK2JobXYrVkda?=
 =?utf-8?B?YVY1NG51QjlVQ0JHTlNUSFFLUUhTdldQSlZzTVRSUEFncnVtM1hnTUxsQjRs?=
 =?utf-8?B?MDFWcWxPQnROL09FUXJvKy9MUCtuVDVTN0VoelR4czJCbEhZcmhEd0l5b2Fn?=
 =?utf-8?B?ZXZtOVA1N04wY09FTDNJVXh5akdYdHBaY2ZvOFdPK1J5V3NXOUc3RUw1Mmx2?=
 =?utf-8?B?cER4azJNNDEyd2YwckhwSEhYdHhWdG5LVHc0QlVxWERhYStmYzl0N0VwQ1dW?=
 =?utf-8?B?QWwrWXI2Rmc2NkxpSi9vYWptZWVoeDF2S1NTZThDajZEM0tsUGp1TEM0bjcr?=
 =?utf-8?B?OHhCQUlBeWRXTS9sa01RUkE1clZQUnhMQk9NQWRkODcwRGhSQzdXR0ZxZXl3?=
 =?utf-8?B?MGNOa253b1pHd05rdTY0VmRvRDNHWVcvL2w2Y04zSjUyR2kvN0RuU1l1ZXVp?=
 =?utf-8?B?Q2VBRmlLWlNIS0lFSXV2cExpZVc2R3QzRjNZTTZMaVFpVkFpU2s3elFzc0U1?=
 =?utf-8?B?UzVVeUtoUnNrN1FmWnk2R20vZEJQdTRzdnFzVEZnSis1dzZWRXd0Wjc0c0lE?=
 =?utf-8?B?U1BGT0NrTG5ERHFKd2FTM1pHQUIzalZTeEM4b0t1cmJ5NGtlWDVJZHB1NnhM?=
 =?utf-8?B?M0plaFFLWTVuWTVDU25OUnR5SndvTzNIa1hWQktuUFZVOVJhcmVlc2xsbmZP?=
 =?utf-8?B?WEg4dTNRZy9DRU5JbmFnSzVNdEV1VEdPMWRudzBFbEJVNG91KzZuUHhSb09l?=
 =?utf-8?B?dkNOUE5EdGlGT002bTRNMGZQdkVPS1hCd0lzTG8xaHY2Wit0NWJXQmhtL2dr?=
 =?utf-8?B?TEdRcUpWYWY4Nk82bHdERmUvUzJWeXVyU09RUWNITHJnT2xzTGZXVVVpMHpR?=
 =?utf-8?B?bFVRV0ttS1o4bFU4eFhPaXkxbEhqaGZlNU94K1poUE45d3R0Z2twV282amFV?=
 =?utf-8?B?dXdzMU9pdEt6NnMxdTBBSjRsK0s0cnNCWGNtR0Ezd3Bpelp5eWsyUUdWbWVj?=
 =?utf-8?B?SWNWTWRheCttNlF2UURIMkJzSUJyWU9DeXltTnNzdzdTbVlVU21wWndYWHdI?=
 =?utf-8?B?b3E5aUQ0RU5jbUtoc2NrVTFYNy8zQXJyb1dqanI2ZVVZbGJVNlZBMWlCaHNZ?=
 =?utf-8?B?eXh6RWdNSktmOWd6Vm5aK2NmWHNVODNUQmduVTJ4S0tiSnVTbDVSYUtkVmx4?=
 =?utf-8?B?eEZoWG9zSC9mbWRpQ2ExcCtLckdLYUdwU3Zhekg4dkRGbUVFRmdpT04xeTJW?=
 =?utf-8?B?YnFDUkY0RktIejZuR2l3aXBXaGw5MXpIVzY1T0wxSnBWR3FMb01BYWhZUnhv?=
 =?utf-8?B?ZmE3TXFmczd0c1I1ZlBPN2N5U1VjVEo2eGJWMHBET2ZkS2JTaG05MlV3RDB4?=
 =?utf-8?B?VGxjL3QzMENjVTlKdDU3c0VPeDA1eXpvS1NCRHgycDF3bHM1UXlNOHlydzBu?=
 =?utf-8?B?a1VMbE9KOXdYZXNUQ0tTYVJEdDd6VldKYU5hdC9pSEtHN09vdzZHaDQ2ajJ5?=
 =?utf-8?B?RnF5VmgyTGlkcGk4emdhQ3ZsZDBDVXlYWjZISVpjSTZ6VkJ1VXZSYUJ1VVBP?=
 =?utf-8?B?T3dPL3pHbTVQaFlMVkViVXo2ZGFEeHhGNVNrdk9uaW0rRDkremkwcnF0dmxk?=
 =?utf-8?B?L2hOYkRSQnZ1SlhnbGVOUm4yTFF6YWU0ajBGMW9SWC94OVVkV1cvTXVhTDhC?=
 =?utf-8?B?Y2xXN0Q5a3dvWDR0TFZ1eTBTS1JoN09WMUtLZ2hETU1kN1BFdDQ4eTBkN2ds?=
 =?utf-8?B?eDUxMEtFRFg2T2RSbmREeS94RnNrclpKVTgyUkRCNDJ0Y0wwdGUrK3ZhVjZS?=
 =?utf-8?B?TEw5a2pyWk4vMGpsR3k4ODM3QkxKY0lkSUVtdWQxY0pEaGJieW84bnZ3c2tt?=
 =?utf-8?B?MEhYSkpHM012YThFZXpZRjNWSUpqQTJVYmY3K2xlcjVqelNFWnRhK2xOS01E?=
 =?utf-8?B?S3l0Q3NLQWJkNURBdUhtTWNackR3NllJYklZZTF1REEySzN4NUxUNUlMakdh?=
 =?utf-8?B?bkZkTjU1ZDVVS1RoVnVxUXhMRDM0RDk4NHREM3o0VDZJL1JqakdMNWVwOWEw?=
 =?utf-8?B?bXpBcmI5RmhjZDIxaVpuODFrNHREa2IrRXNjeGUxZWNNRVNkbVBkbytwMk1F?=
 =?utf-8?B?MSt3UUxDa0JlMUVSQWQ5WU16NHg1MzFLcEJxUGJwUUdsdktGNU1rMlh6N0V4?=
 =?utf-8?Q?1Oj9pVbMdGQzwTklRCMGpcX0b7uIDHAunrof19YqOjD7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f2839d-b4c4-40fe-02e8-08db69047c29
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 16:13:38.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GcHAJpDyFa2UsQvCAtwMXXCUhckg6JBX71gqErlrgvK8Y+FYziLA1Iv7yGwgvW+kjhZ3HPJGX38cDixLnhbtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8208
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9.06.23 г. 19:03 ч., Nikolay Borisov wrote:
> 

<snip>

> 
>>
>>> @@ -226,6 +226,13 @@ void __init idt_setup_early_traps(void)
>>>   void __init idt_setup_traps(void)
>>>   {
>>>       idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), 
>>> true);
>>> +
>>> +    if (IS_ENABLED(CONFIG_IA32_EMULATION) && ia32_disabled) {
>>
>> Ditto.
> 
> This actually doesn't fail, because if IA32_EMULATION is n that 
> conditional expands to 'if (0 && ia32_disabled)' which is eliminated by 
> the compiler.

Forget this one, it works because I made ia32_disabled always compiled, 
hoowever, the problem in syscall_init() remains because now 
entry_SYSCALL_compat is also compiled in iff CONFIG_IA32_EMULATION is 
selected.

<snip>
