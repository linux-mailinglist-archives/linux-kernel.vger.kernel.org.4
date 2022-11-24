Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D42637509
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiKXJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiKXJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:21:40 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296E11A73E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:21:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJZUI3M3NaB+H+TSJq8MqH9HD1OlEUjSdHBFe4BwFFfqtVGZALs+zmhq46GNulwggqcwIa14AmBXfpMlew6UTQdZ/x0W3I/iO7mxErfIG8mSblCXnVxWC1eDFG4h6byeACmt35wE3HMrN4c2PcMtLt4RQqnNWOTP3+7FKjB6qupb8mRNoatvaKMp8TJdaJf5Dejrc0WpjNm9tvZuxOy5k6WDWNyAs23Wz4HxzgHtlmvBdE5PXp76iGHqV36gK1ZLvWrnqrvak5QMVv4qSUBmBCYFs1B0BHxvJlevWnwAH15Avxk+wch+/LyBDRHC97l2MOSq0mZGUjxSPY5Ok6Bxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJBGdUopIYdpWASmLzWtBMcn3EtsIZr1+T/LUTw97Mw=;
 b=AAOb8+0a1PPXJBpUqsOEoDpzqdYpPW3vclNA/Z6j0hr2cCzapYbiEtkLmpIKqz3tf/XsGX/HDuhD1J+XVifViKe80HriqKMfN8wsMxcGylnMx3tVY2ugyjIwvuywc1Oe1LHjLtgzD8XhBtioKtThO61F2sa63nv8VyYj6g2SJ5Ex952qOjvNtL7rbFhB0248iIENuHRKLqmdArCo5Yx3lat3veaErIs7PEmA5R9Um8Su0j9jeuVhPZhDDcEFqMUZTq4Mwf7LY9R/ANPlaQCxKFJ41bLNh1rFUCvPzyAe/GOTb0QLi1uEsX3ok6MY4J5708Vyhsf8pzWnjC+RFEBPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJBGdUopIYdpWASmLzWtBMcn3EtsIZr1+T/LUTw97Mw=;
 b=waDnxeBeuZb+bWCOWUIdFkBhM6EGLcvniLs78O+0JkyXGhtypAt2ij7Ok4BG/ZoOZkQQa4Sg+wvX+A8JjZ9kFskDGJf+WUwGj4u3iJRUT5oT4O/IEMID4hllCGtlu5vCEO4HaaxF/W+st4L9BKGTt5fqWABDh5xCqFmHGhGJKF/bJi4RQhhwD/duCkEQ/H+71cA4FtkLJJ81K90NYs/8AluMK/gww/5vNXWkEEeyG8PeaLnouHUZPJysozbEXpLm7dEFZhxvs3F998N8qPb6GoWgENB2JDTVTV4fXSNJc7r4eom4/SbnVmlHOObooOXuD0IOl+NVcVPfupXpC5xIOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM9PR04MB8538.eurprd04.prod.outlook.com
 (2603:10a6:20b:435::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 09:21:36 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.018; Thu, 24 Nov 2022
 09:21:36 +0000
Message-ID: <765e1e78-c540-0753-7a19-7d335bcc998b@suse.com>
Date:   Thu, 24 Nov 2022 10:21:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic> <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
 <Y35CNdPVwq11NCYN@zn.tnic>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y35CNdPVwq11NCYN@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM9PR04MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5e03dc-f5c0-4adf-600a-08dacdfd48dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZosJrvJF5rV148WtPA5lx7ps0IsGFQnZOlCqFIQ7+6Eagk8x1OnpzP8AsqtUFL/uHlRaTfS074f/VaZV5nCgv8Jmjpj2Imdu1tfZ9OanQzvYuMSP3stbwLWUv9Ox5PFKVBZswIxcbXAJr8q/KZACH/LyZlthqBjIoqZNie+yen3SnHRxVW0Z2gaMJrn4KCkI+K2fo+Mh0IrVD3hdcBDi4/14UCMrzUihvDQ+axAMs7Z3OanQlyxeI7CVc9Nk+4b+gDbYmP7cKqTSstX/Ze+ZBWI4vnHfk/Z11FlvzELo88M9NIGmRGDL8EeVn2JTnzfnQB2xEHTQZlqQ4QjFvXwrNYLYOGv2JMo2aApiYizn4znLi83uglPBHiTHGaiO9L0SUkYPsZ4cdvoz/60BLCX/j5TOpnDwihP1127qdyAFIik7iSQ6H9H4Uhhefj4RQ3UTSDV1Ig5axj78rR1FyzC6jAlWjKWHn5naOF878Jzv5fRXXnWQpaRKZct0YM00imUsrzIxw0kQGtWZAmEXUU0frcuBm8Fv5T5mM4+vU6cfxJ3dELSEry9ieWYhKggX5EIpOLfRbAjHZbIhS/41pZSGh/AzUWMYo5x/fZseRCXbFZ5gF/OLX0XFgnMLF2sHrnyaIcXkj8Ob5WrpTTD8mfo5LG03aPEDZbhn8NShaCbZ+yXK8REwJxU/0QVVw9oF9t1LaTkL/GizLoBgP83L/DXsBu6xstysjFyoiRT4+ex9Z8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(36756003)(31686004)(31696002)(86362001)(2616005)(2906002)(5660300002)(44832011)(186003)(55236004)(6512007)(26005)(53546011)(38100700002)(66476007)(7416002)(66946007)(6916009)(4326008)(6486002)(41300700001)(6506007)(6666004)(8676002)(8936002)(478600001)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekJ1REYxNVBxWEpGNHgyUGlXYytpbFBDSVJ2UWR6UlpXUjBLN2JGc3NLU0pw?=
 =?utf-8?B?RXVRV2pQeGF2MTNMSnQzbUFsRzFDK1NoVXcxMEl5VmFPVUZXOHJNOFMrV1Z0?=
 =?utf-8?B?UmNzZHR5UGdwQVdKZUIzMUxYbUcwbkYzUkx3MkFpZXR1a1F3WjcydXZxbHo5?=
 =?utf-8?B?WmpPNGZKYlI5Z2NuZ2lDNVdvSDlHNzVWNlI4MTBXMjRJSEJvSkVnRU5QK09s?=
 =?utf-8?B?aW5CMTRHb0RRTjBhc3VFRVd0SnFBRkdVSXM2aFVFdG1JQmRYdzNMMU9SRGVp?=
 =?utf-8?B?SnV4MjNQK0dJOVBTRFJtT0dVbmVEUUJqMWE1aHZ6U0c0OHVuQlcvck43TU05?=
 =?utf-8?B?VGdETHpKVHVLTXpWTklYeVZndlV2WVp1Sk9SaXhuem5UbGJpMjF2Qmk0ZFpr?=
 =?utf-8?B?VWZ5dGZjNDh2dUh3QXFGTG42R251WCtvNElSTStWN0VjVi8wNW5tcktvSzhu?=
 =?utf-8?B?ZWhBWUlmbENETmlwVTlJVTZ2cGlLNXlIMUh2a3JlT3J0NldTVVdJczUrSVFO?=
 =?utf-8?B?R21wUWRDeWtNZlZHSUtibWg5YjYzM2czMzBqdW5nY3BtbFFOQ0gvOTZxQU9m?=
 =?utf-8?B?OFFjVisyTTk4WVBobkRqMDQzdER5R2tYcDFVMHNIRzJqZ09oQmsxQXdiTmQz?=
 =?utf-8?B?Z2JvSVlQUnYzWXBFbjJFYVlrM2lpcXlReXFHUVVmUlBtU1JFVFRITW1uU28r?=
 =?utf-8?B?ZmVpNFE2Y0xScEswLzFSbXhqY2hVUmcwS2QwRFJPWUJiQnNRMmRub1ZySVVX?=
 =?utf-8?B?SzR0bkYzNGtGRkdDOURVN2cyVzBMV3BqcEZqKzRDdG5FNEZGZjZXb0g0UzYx?=
 =?utf-8?B?N1VPSzBVZnpYYXhVU0ErUWZjV29Od01JT1BGbkh5a0RZTDNoajhjdFc1L2hY?=
 =?utf-8?B?Z3kwd0FsdTA5NmRqeXBtVlhWa2xyZjJyK2xjdDVFaUJGcmpmZGtId2QrVEQ4?=
 =?utf-8?B?WVdTL0RuZGpDbmt0MjBveWNUU1R1c3FzWStNVHEyME9ValFWb2IwV1oxaXBW?=
 =?utf-8?B?aTVlRUwrSzluK29mVkxDUjdEaDZnNGNCdVpBZGpMdDVHOU0zblB2OHVOa3Bs?=
 =?utf-8?B?NjBlanUrUGRWWkRwdmFZZDNrZkVZYlRUK3cxWDBxbkNKbzc0Z0JtekE4TmNT?=
 =?utf-8?B?REllUWJPTjNTWWlpeWhHRlplemFjQk5HdGY2eHFaR2ptdGRNUnltQXVhSE5Y?=
 =?utf-8?B?T2xRdlp3bS9jVjRuWEJROCthbHNlUUo0eTlpMUJ5Z0ZIN3JWY1UwWEg1WWRj?=
 =?utf-8?B?QlJvRjkwU0F4OWwrWEJXcE9Ya0FBUEE5M3U0MFhPendXcStzalZFMTdYVVZs?=
 =?utf-8?B?ckhHelZ0YmJkRUl6R0l1UVd6bER3dS92V0E4M2pIN1h1UFZOZGhQMGZBS2h0?=
 =?utf-8?B?V2ZFR1NBcVJpUXY0SGQrb1YzNHlkMHlPWVhxMU5ITEFpeWxmem8xVFZVNkhI?=
 =?utf-8?B?T3dHb0YvRjVvOU1DbmlXK3V0MUh5Rkx3eGU1VnE3OWRoNFZlV2FadVY0Q041?=
 =?utf-8?B?RThwU0F2dnRkMWNXSFBsUEozMWc3RDhKWmtYQlVXZUFnZW1aLzdRZWQ3d1F5?=
 =?utf-8?B?OVdzN2wvS2RUdmgvcE4va0cwNGN4OE1ibC9abEU2UUVEcVduVDkxelJhekY4?=
 =?utf-8?B?b1ExRUord1IranF2RFBXa2hoOU5peVNtcEhsY3FOeHpCbjkza2RVTWJqbDZm?=
 =?utf-8?B?bXIzKzRqQWQwbGxBQXJwUEh3dGFONzVyMnh0dU0wZzBFK0RNUkxqVGoxaWZ4?=
 =?utf-8?B?bzlscWk5U1F0cEQ1YmJDeC9TSzZMWWpBUWFpSU1qNFJLU0FqeHlDN1RuWEZD?=
 =?utf-8?B?ZUVVdXlONGdZLy9QandsUXNlMWJaVTBITklpc25aMU1mMXVaNUttSmIzVTlv?=
 =?utf-8?B?cUhHWFdiaGlnT0xnYjJrQ0FIU1dqT0IvZHhSaEhrSDd0Ti9BaWpkMzQwdVpE?=
 =?utf-8?B?UnhtRnZZdVlNd29GalhxcXRHcUkrckFJSlJwSXhkcWFZMkw2ejZ5YXdocVdu?=
 =?utf-8?B?WFBHQTVTbHdYQkpUZnVkdmtkWTJWQVBscW5mRzlkSk1yclIrNjB6SFF2b3Y4?=
 =?utf-8?B?ay85Q0I4TUg4MGcva2xhRWFYT2t5QlNXeE1YVHd3VC9ZS0RoU0xBcStYaDJQ?=
 =?utf-8?Q?q9NQ4rzQn+Rq0NaCoI+br6hMr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5e03dc-f5c0-4adf-600a-08dacdfd48dc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 09:21:36.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zSF9+ccomzLXc/6BbvU0Qgoxl/8mJju3PEWnWSvwr15lvdLUTe7NX7axhanXa8yflKPoF5Gr2vwSE/73dXRaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 16:54, Borislav Petkov wrote:
> On Wed, Nov 23, 2022 at 04:43:20PM +0100, Petr Pavlu wrote:
>> The only post-link analysis tool in this case should be arch/x86/tools/relocs.
>> It produces a vmlinux.relocs file which is appended to vmlinux.bin. This is
>> all internal to the Linux build. I'm not aware of any external tooling, such
>> as kernel debuggers, that would require this relocation information in
>> vmlinux.
> 
> It would be good to know why --emit-relocs was added in the first place
> - that might give us a hint. Lemme talk to Micha.

My understanding is that option --emit-relocs is needed to provide relocation
data for KASLR support. Produced relocation sections in vmlinux get processed
by arch/x86/tools/relocs which creates vmlinux.relocs with only relocation
data. This file is appended to vmlinux.bin. Upon boot, function
extract_kernel() decompresses the kernel at the target address and relocates
it using the vmlinux.relocs data.

>> The size command used in your example includes only allocatable code, data and
>> bss sections. It does not show size of any relocation sections.
> 
> This:
> 
> 361M vmlinux.before
> 361M vmlinux.after
> 
> is simple ls output.
> 
> Maybe I need something else enabled in my .config which would show this
> significant difference *and* *explain* it.

Option CONFIG_RANDOMIZE_BASE=y needs to be enabled. Switching it on should
automatically select also CONFIG_X86_NEED_RELOCS=y which is what actually
enables use of --emit-relocs in arch/x86/Makefile.

Petr
