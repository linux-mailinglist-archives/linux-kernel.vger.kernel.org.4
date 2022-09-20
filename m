Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF685BE128
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiITJBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiITJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:01:18 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EAE1A3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar4f7QKLYdmZ0buHLrb3qokUG2BjiMOx9ZicaJyFg3/esq0rdlYax0SXuhbIAmqyKQ4TMPfoOyWWMXuLt6l+X5P1XZ6L6a/3ik5nsuXSkTBl5gmXqP9PXODBMI5jycJ1IfH6Ar6mLzA0ozLXLT4wldeRPc5xvTNDlyxjQliDNuUZr5WbPzCyEfu0HNAlmSavOiPUkltkNuIdQ8YFZAaX4HMk/NapCnCV6nvueYjZEAKe/8SHy/ZDEvXlCtCVn7TeuNNJF3sJD8oR1EZ5EYI3tleRdZaoePkGASwobHZGGNE0voxxB8/Ph+ZdhEVbRwMpHlpJlzame0Df4Q+bHkWjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1g1Wla4VvZn76sIYxjdMRFfahmutyp/+A2MUHOw0d0=;
 b=XDmKtPwcHlcW5SQYIKrnREoRm8IuEMUq98dLpWXoAlBrWFlztbG+eSPeKxzcwnbwIDnjY7IiLqG/76iEm6fN4BiDnH50/k0Ux2oprNzejELNOuA+tA9RaqlKByMfs8EhKCDJGdFJ6jhDgJpwaNWQND7LoDOb40at5oA3sKxrq1uRp/ACzYYXGWL+yJzt+aykO1+MKscOiSNZxGspO7daRZnRBEOWWEY9LbTf8kMnH1lih7flAS9RBGB4GmoQ6i9+Md53rYT+yVjJx/5DvsE+COSt8H2uTNERfDc5pDCQ0OWXoG6oFJJlXbi8fY/2838YT5XFvJ9jZiRCvJkn0WLyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1g1Wla4VvZn76sIYxjdMRFfahmutyp/+A2MUHOw0d0=;
 b=1zY3QhRG21T9eYgxuPatKwB5gdnMyJg3XPG8qr2GM6kd5ioJe6QKw15Nun3A/J3kAEydy4RdqRy8NxBP+fWC7sO8jMYOL+jzHucgxs6S5Ve0SIGoXtFzSs0KGp7mGDmPTSsLLJc3jdpzL6J6+ZoA6OILU1x2K1kXefExhQe01YH36KbOIraPfbPjEol6SKWuRRmp1GpnDCiSLHAInzakaDaFFWmRARW3PGppnWk/LvOtbT+oyXz/fHcUEN4N5RmCF6JBMgMUncJMKwVq6chITwbBXtvdoU3cG4Nj3ZoajvuC2cCkVHtQBDNvN/+r8PWDfaUZ8loYLproQDm72KSDMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by PAXPR04MB8573.eurprd04.prod.outlook.com
 (2603:10a6:102:214::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 09:01:13 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::e798:4d3a:3839:5261]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::e798:4d3a:3839:5261%5]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 09:01:13 +0000
Message-ID: <f69770c3-e108-7968-e866-c1e85959aec5@suse.com>
Date:   Tue, 20 Sep 2022 11:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        nicolas@fjasle.eu, masahiroy@kernel.org,
        kirill.shutemov@linux.intel.com, tony.luck@intel.com,
        michael.roth@amd.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org
References: <20220913132911.6850-1-petr.pavlu@suse.com>
 <YyEU70K1aY8b/EXZ@dev-arch.thelio-3990X>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <YyEU70K1aY8b/EXZ@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::16) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|PAXPR04MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c1f593-7be2-4bea-b8ca-08da9ae6ab45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5Y/tQlsk2r4AFLLEMIjGH99xmw0Z/YomAuq1lAng89FRr/R8iI94UaXj49V47RgJ8+dEpzczssPhdn0I9wvaBGt36Kpd1frPs44rv62kJXFqPAra8lOC34TirfSZm9Vnk+DMqye2MpRuxpUV5AiONqBAjkSLdggtgziL0xfz+0QDS0Luzae4PdFNoGW8FJREzZVyN/ywkVds69utkNNCuJI7bK3uFKm5mDwlH+/6JcWB2UMMmIOpkHiUASYcQ5uLWS4ycAUho7k4FTnbZJ5un9OGNS+GIyKCznTfGn5PwxFYEIH7nduKgQpF0phdz/e23qMXmwNNrwKXxxFl0/SudE4soCnQYiLw+ab9AIIiuty3vF8akKLXyJstS4mRkND4iIpnBYbXzUCdAIuni9QEwHi9ZvSCltDoM1XEqn1th2PFDnZOpFiQ9SPFt9LfB7k4OjBq/RFWRXqnLZMSza7RAVdkcdecd8RBPf9rl7mPVZLy4ZaJIT08FvWVsBTDpT8Hgit1crVOPKm+d0+r2DxNp7yaUr/Gv01pJryWYivwXn9g0RV6Rq7iYQ8Kp97b6UlEU0JPiyaaLdS3AmZciAoqKHOl/WbbqG+X1aRgKrjCeJuQk6a5/AgWfAIqdVMavrO/FU49W9bANGjmooPK0c05vGf2g47T22h+ACFI/eEP+4Wbhurhk+WNIahz3LqCfR7/fa1IPxK48nVoFC0241+keumqDsobeh5OB9KUdG3E9SSiyl/EAClEASTSzBuMmwdb22hr0eQCK7onVitwz7r5jNiiVXbFDVCMOl/vs0U5BI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199015)(2616005)(66476007)(66556008)(66946007)(26005)(8676002)(4326008)(6512007)(6506007)(36756003)(31696002)(55236004)(53546011)(8936002)(5660300002)(41300700001)(83380400001)(86362001)(478600001)(38100700002)(186003)(6486002)(31686004)(44832011)(316002)(6916009)(2906002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRtY2VIR0RzdmkzTEdvN2VncE4vTjdNQXpMdmdVWUFmWk56UXJzRE92TXJ5?=
 =?utf-8?B?NEFqTHFVOE1WTTU2NHdiZ1kxWjZhY1lUSVFueWUvVEdKZ1FTemNBR1QxOWh1?=
 =?utf-8?B?dEZ2MFdZTUZFNE5qY1E1TytNdzdSeFVrY0tXMzhsWktaTVRSUHlYRDJmcGlr?=
 =?utf-8?B?cm5Ray9aN3hJTklBY0hNbUhlU3h5dG1WWTF3NW1PVkF4Qno4T3grSDUwbnd4?=
 =?utf-8?B?K2pIbUx5amcwY0UwL045RmxaemlPTFdNekZFVHBOTVhpWnhwSmdpVlUvaVpB?=
 =?utf-8?B?Vkw5eHpscFFDNG5RRzlJYVEvdkIxS3ZuL0JsVncza3M4WHZMbVJ5TjJPYmVV?=
 =?utf-8?B?dEk5OUdReVVGQUxVWWhhY3NDL3JjMW5Nc2lTeEM1UTlzS2Z0TDRwODl6N2Uy?=
 =?utf-8?B?eUdKZ0tTUVNMNmpyNlJGUUFiRDBtZ1NLMlJ2Tk5Xd2VaVmFvZzVmSlZvckl0?=
 =?utf-8?B?azRiWUo2Q2VCVDlYOVBucWdHMithMC82TDNTNXJ6NWYyRkVNbk4zLy9JWnJV?=
 =?utf-8?B?d1RUSHBaeDJ4RGFiSU9RdHc5dDZqRmpUWW1MSHVwaTVLNTRYbDROM2hpY0h4?=
 =?utf-8?B?aU5aTXNzK3hiQ1J1TEFwVXBhUmc1S25XVzRrNzRKek1rajVRYnMvVXhBVUp2?=
 =?utf-8?B?Q25qeHFHZVN5VDZ6TnljTWVnK0Q3Uy96VitDNmxmdkEwQTdSUmdmbjQ1enZ4?=
 =?utf-8?B?M0ZvWVlEQ0Z0QmlmUzZrRlpMV204VlFaSEtpaFFsWTVmK3REWDFZSUJFNXRH?=
 =?utf-8?B?NXR5QnFyUTViUUdxaVVwUGgrRTZ1Zy84MHRGNTU5OGlxVEJ2ZUVwNlRlVGNl?=
 =?utf-8?B?eWdlemJ3WDZwNGgwaWRxZ25DTE5hcWozVFhnMS8vbURRbjQ4OXkxVjNyRnJh?=
 =?utf-8?B?MEF3aGp6QWp0WVVHa3kxRDhNc3dzSG9GeHBhZzNoa0g5ZEE0dDBKcjdCT28x?=
 =?utf-8?B?SnJWT21temxyUHhseGpxeDAvOFg0UEpKQ3RHdEFjMlRBTlFLUjR1aVNDSzRC?=
 =?utf-8?B?U2ZMdDBheUIwTTl1TW40aVlTb3dMRllpNjF6Rmx5Y1JEUW1ydkwwQmpTSlFH?=
 =?utf-8?B?OXpUVlk3N21Ld0JKTHNYUmtPR3l6RHpBNmtrcVdLU29Kd1ZGcjY4MzVFV0hj?=
 =?utf-8?B?S1BaL3VnYnhMQmxkUEFyK1V4eWorSjRtOTZrNUZkZTZ0WTJ1Z1VmVEFMQXhk?=
 =?utf-8?B?b080R01wTWs5MnBLVzhEZjYyaFVOVzdUeHFXdEJ5SEZ6VnlicDBoTDhvblFi?=
 =?utf-8?B?U1B1WVhOWExIbG9RemhxVGtzRmJJbmV3bExuVmJQUDRPUG9UclpvQW5ONVBZ?=
 =?utf-8?B?MTBHR29lOFIrY01vcHp2RWFiTWtjQzZIODltdmhzbDRIckR5a1BNZWU4aFln?=
 =?utf-8?B?SGVHS2FWK1BmTlpycnhybGZTTTd4MUdNYVp1SzhzclRGM1lZa2E1b0Z4OHJD?=
 =?utf-8?B?Vk1uWGNReXJlZXVzRVUwZEZ5MzlzUnNsQnFhMDBTczlzcHNqVUVaQnVNU1d2?=
 =?utf-8?B?K0NIc202ZFlpRjBvejUrMlJyRlpDOTZ6aHZjanhPVUlpMHluN1pZY3FhVTBh?=
 =?utf-8?B?NFltamdlTVFkaEtWZXBzSVlEaVo0cmhtZVB4aHdnSFFFSEt1Q1QyUFZRY0hD?=
 =?utf-8?B?OHl5elcrRkNwaFlqb0dkODNnRHZCZm9NbWF2L290aXh1OTBlbkIrWlBHNko1?=
 =?utf-8?B?NEpkL2NDV2FyY1U4c1ZydmdhUEdMandqVTNoWHBDRkNlUFlleTZTWkZGREs3?=
 =?utf-8?B?M1d5cUUxMTdUVFJ2dlNndmU5czNveDVxU3BvbjJ3SktYcDE2SjdXc0NNNHRO?=
 =?utf-8?B?Q3NnOUZjWmVYNDczalJiVHRIaWdENmd2V041TjlFT3NmRTNTSEd5Vk9oVkVU?=
 =?utf-8?B?R2orSlROdEM5N0l3a0k5UjhuM3JSblRFTVRDMFRXaDhueFMxVHJxcERrRUxX?=
 =?utf-8?B?OUcwUis4b0pCd2xldkRwSGd6dXdLOStSRncyYmgxekdEVS9OVzNYcUczUkxn?=
 =?utf-8?B?cHZ4WEtVemhoOHlZQXdkeVFzallvS3d6dE5rQVgwcVpWMjM1NGUyVlFENkZa?=
 =?utf-8?B?ZjNRKzYwSXQ5T21hY1dENk5YY21sWktDekp0ZHlPOXc0MnN6MGVwUm1UcEJR?=
 =?utf-8?Q?NCE9agiENI2Q7XEHXzuTiMqo7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c1f593-7be2-4bea-b8ca-08da9ae6ab45
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 09:01:13.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gT3v54p9xEbYV7AkQW6e7fTFDI56orGsKmPKJG4MhMnd9cwCK2c+R916a8lzNo1bhMqjdkT8NQzRiUrmwf9dCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8573
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/22 01:40, Nathan Chancellor wrote:
> [...]
>> diff --git a/arch/x86/Makefile.postlink b/arch/x86/Makefile.postlink
>> new file mode 100644
>> index 000000000000..4650aaf6d8b3
>> --- /dev/null
>> +++ b/arch/x86/Makefile.postlink
>> @@ -0,0 +1,41 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# ===========================================================================
>> +# Post-link x86 pass
>> +# ===========================================================================
>> +#
>> +# 1. Separate relocations from vmlinux into vmlinux.relocs.
>> +# 2. Strip relocations from vmlinux.
>> +
>> +PHONY := __archpost
>> +__archpost:
>> +
>> +-include include/config/auto.conf
>> +include scripts/Kbuild.include
>> +
>> +CMD_RELOCS = arch/x86/tools/relocs
>> +quiet_cmd_relocs = RELOCS  $@.relocs
>> +      cmd_relocs = $(CMD_RELOCS) $@ > $@.relocs;$(CMD_RELOCS) --abs-relocs $@
>> +
>> +quiet_cmd_strip_relocs = RSTRIP  $@
>> +      cmd_strip_relocs = objcopy --remove-relocations='*' $@
> 
> Just a small drive by comment, prefer $(OBJCOPY) over objcopy so that
> the user's choice of objcopy is respected (such as llvm-objcopy).

Ok.

> Unfortunately, llvm-objcopy does not appear to support
> '--remove-relocations'. We can certainly file a feature request for this
> upstream but is there a way to accomplish this in a different way? Or
> perhaps this could be something that is controlled via Kconfig so it
> is only selectable with GNU objcopy??

An alternative is to use use --remove-section='.rel*' which has the same
effect.. or to be more careful, something as:
--remove-section='.rel.*' --remove-section='.rel__*' --remove-section='.rela.*' --remove-section='.rela__*'

Thanks,
Petr
