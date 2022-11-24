Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34305637A04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKXNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiKXNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:33:36 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0526BDFD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:33:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUqYShr4uJUGOyIBzTDee+PsKQ439PbhabIgxybnecR038zApqYwl/GxRAZrhBTWHbkdbNcIm6qlpxHVWeRREZj2n73b9JMjc6h8CFS96yrjqB2F+oLc32lbA84+EZuLe1UhQet0LzSaQX/QhOBCMYd5CQa2WUCB2ShgjnvirruneF/2ePLh6IA5pb3VpvaEh1QrVjQgEDQPmTt1B0eQHTmw10NX9MoozTFQncRK2fuTY9MyfUm5+OUgmHjhUyv3/TB8LASwdjfYBzJTpF5maQgXx5QzxlPXAr6+tCdWTcgzr9p+32KOisJ3lppcFUzcrtusMzKxVVWosTEiv/Tz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyoOXqQXBQnEz7neCjXPt4eHfjgJxDy/tqFFfYneRyY=;
 b=m3vjfcAukU4vItdNxbUanXzFSs0fP5NqqkRXHoLX9th7OxEMXYQ9l35Z6QUemK1w05oFZDTOOkwZ9A9Pe7CVfGAL1L43SBjafznkTQXwpMKa7E/sgyyP9IbmRph9v+i/x8IogJNNYQd9eUU7K7c/b75gisobM+00V2B4UTHFgjzEI0a3fMnuq8GkgZ4qxtsMTXT6ngmMFj1vpU/2UK2bCmo+h52OjYAYmJ8CqIYtZ8klI/w1FHR/Sr+yqhqvZAvV3OsHQr1/HZAXTLohzPZtBf+NaPrVXIGTbC7OiY2N/jGKFs9BeVhNqoNk7lf75Y5c8iZfBpeahM8vz/7TQVi41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyoOXqQXBQnEz7neCjXPt4eHfjgJxDy/tqFFfYneRyY=;
 b=snapAERFOYAZPrRRCaaS5sHklSKtb0iNtGeyS19b5+fSns1aBylaMhl1s+vYwBbk4JRbf8Xg8rvzPdfvd5voqs+/NDUAoGRRvlXLgsG0YD3Drbu834kK6Z1Np+PYE8itz+JLoaFnUEQLaopyFKyqzG0su1iNbODBprATYbR0SoriXOuF3F9b1DEPZ+j0aFasBA8KoHepmWLwZxId2CTJydUeuaniBlkrpKtP82yDXOxdxnrVhpQ2/hxL9eF6YYH/clYyI/bTPfu3zb1UyXxewsmb8vlgwubucenZzB6sMu3m6UgyJWJHTY/HniqE1NajS7R7kg4kHVqzDSu6701qNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by DBAPR04MB7302.eurprd04.prod.outlook.com
 (2603:10a6:10:1a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 13:33:30 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::14eb:6506:8510:875f%7]) with mapi id 15.20.5834.018; Thu, 24 Nov 2022
 13:33:30 +0000
Message-ID: <1cc97d84-da4d-c8cc-dbcd-fcdc34c6d11c@suse.com>
Date:   Thu, 24 Nov 2022 14:33:28 +0100
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
 <Y35CNdPVwq11NCYN@zn.tnic> <765e1e78-c540-0753-7a19-7d335bcc998b@suse.com>
 <Y39lwk3itVnsADrP@zn.tnic>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <Y39lwk3itVnsADrP@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|DBAPR04MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5a52af-a846-40d5-3f14-08dace2079c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zsZrKFWpt3QSeISFUkUIFTmTscmTFqJ5NlC8mQYeaz+i4VOZw8J4NrJo70Yg/8JY0/KFHIdxPQB2HOEBU9KN8/imXnPs7pbOLcjcZjl4ECHZx18hYv9yLH8qVk5ioeQAvjFbnmBTyuuEukU9L1Jyqv3L7y/6PQ8XGFuEx243vSFv4wGpjTI6gIvYnF3Hc1dzAoBvroEuMiCkcW7RA8Cp3djiz5lD695lZIbvIJWzJbZDEhXCN7eCKelTeRtXFVxGj7U+iUOTTmQ0aVli9eJHykzo3x4aP5N64T/UZAnnYjzJUb6w4GdYJM1lSj6CmlffsHutUq45dLLaTDTBW6aTKO4qOiMy2fHJYYfpOuBGAazyajY1NDmYxZAYLnmrptiAAtRH9X8lKdbDaz87OckvorsIfD1xZidsoM3wiNbW7kHV2FBKwOQRF1Ch4Cvam24ZmsHDoE17rBH0euqMKToe0a3dPGgaTBbiDUXG+4nWpZUYv7vpc1bdhSbZE5j2o57mYte4kcLVp4Crs+NKwqspzJy7l3bB+uplgVDgxO8azAgxN4IWMhgvczfB+89xBGL5fazt48waqlLEsRN453KmVLaagjhiDMgYUGmbczmEhfdfmLr+FTIVg9MGF0D4EmPMuGi8hAKZBwiWMuswwDYxKedkkrgHPIz8Tt2QGuF/bmA5kB9DBqe++9rv1S4LnC4nQ5j3mQivOErkHYWLUpeuTUchbESnBgF3Ch3gf4vGQ70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(31686004)(36756003)(31696002)(86362001)(26005)(38100700002)(6512007)(2906002)(5660300002)(6916009)(186003)(8936002)(44832011)(66556008)(7416002)(55236004)(53546011)(2616005)(66946007)(478600001)(6486002)(316002)(8676002)(66476007)(41300700001)(6506007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUlJUmtldExRR1RzeEIzc3pNU1ZCbTRTZTQvNG9xN3dOZ242OEd2cVd2d1pU?=
 =?utf-8?B?eHI4SktXVWtjOGZzRG4zaFJra0s1NW45cmttRWRWc3JrMFh3UkVxc2lqQmhx?=
 =?utf-8?B?dU9OQmFZZTBLQStySnJrKy9uTDZYQkJHbW5ISG9NUDdZbk1DbURTdDFUdUp2?=
 =?utf-8?B?VUFHQVJYMXpBLzdGS3A3Zlc5a05nOGVMcmZ2V0piYUNPRERJNVByZ3hpaDlM?=
 =?utf-8?B?aGxmeDhobTZ3blZTQ0NHdHZVb3JtSy9IUVA1MFhJeWJoditpMHQxWGdncTl2?=
 =?utf-8?B?ZEhvdlFYQUNkb0tqRzFWWGk0TWFHK0tvQllDa3U4S1d2QXJMd1BzM2RxMkEz?=
 =?utf-8?B?Vm5jNmlQOFVKekhQSEo4ODMzQ1lHUjdVN2NtUTlrODlDQ3VZOFNwOStEc05W?=
 =?utf-8?B?dG9tcEM5SitQeUFtNDlGcEs2TzhuQ25jeFVIcDdqSHhCMjNLUHZDeEx1MS9v?=
 =?utf-8?B?VWltaWxUSEN1Tyt0djYzMTJxYXpZSVovNlVudEc1c0VFYyttTnM0YzlneDRR?=
 =?utf-8?B?TGJQWUpDbmduaG1pTFNmT0owc3oyRnkvbG9ZRFdQWW9hU3JUOUY5U25MSEZz?=
 =?utf-8?B?Mkh2T291QmVuUjM5RHh2NVoxS1V1NkNJTHNob0NVaGVqb2NSMS9KRXBDTjRn?=
 =?utf-8?B?R09kSmZINnlFbzdpZkMyN0x5OFNsNHJ3eXpFc0lLeTZJd3hqeGZzQ1lNeExX?=
 =?utf-8?B?NEczUTVld1h2YVhNNm1CdkdBM2ExTXBsRk1SOEJENURoYUszRjFEZ2JYaGIy?=
 =?utf-8?B?eGJVaU5mODNjcWh3c2FYTjZYcUNsSVc1aDl3aUtaOHROL3Y3OXFtYVFRdmZ5?=
 =?utf-8?B?WTlqWnZiOFRvYm11Vk5HdmFMTldLeEJYdE8xWlM4VVJITWZqYnpaWHFkK0Vy?=
 =?utf-8?B?S0grbHZ5K2NnRHE0RmZ0akwrMXhIcXpjQURYL21kdGdMbkI0eklabkJkeElU?=
 =?utf-8?B?VVV1UVduZW1VWXdSdE1Qb0wwcDNOaENFRnFtVDk2RFZUaHV5MEE0QXRrbFpo?=
 =?utf-8?B?OHRabzMzQmtwK2p5amEvSUVCb1h2U1B3SzlVWXZ2RkNKcXZGbFR2V2lxaURH?=
 =?utf-8?B?bGFPbytLcmxKS1l2S1VqQzJ3MU0yMFBPMUsyUVorbUluNUN6N3R1RFdZRHBq?=
 =?utf-8?B?YTUwbk5pMWpHT1poVFRGV0hNLzdwME9CSHRPOFJ6QXBCMHRlM253dzljUzBO?=
 =?utf-8?B?VDR1UmoxYTdKZDhLdXRpclY4NXcrRGEyYTU2WUs4RUl2a3oxeXVzVHJXRVFu?=
 =?utf-8?B?cnhpRHRyWmtxUk9KVGw1bFZZcUlMYjNlRUN4ZVovS2FwcllwTVZZNG1rZFh0?=
 =?utf-8?B?SGE5VkFXUCs0dFcvUzF0R28yYzA2bmJJWThKWFI3RmFJWHNtdlYxdEI3Umho?=
 =?utf-8?B?Ky9nWVdBUFpoYzNJaUZYM2MxQUxhNWs0c0E2WjdwRVJ1T0lJUkw1dnp6QzNM?=
 =?utf-8?B?TGFud3dFKzRyL3Z4OTk5c0xSUTFNMWZRZTFuOGhieWdnaVlHWWU3YThhbUpp?=
 =?utf-8?B?NVBsSmNnU25XaEpxZ2xORjVIUno4d0F6cldvdjRiOTg1dGVWbTBTMHNJOVRE?=
 =?utf-8?B?c3pGWWh6eGZjVWhYZ0N4TEVuT3k0Qm9nTXgwNmdwZ3NIc3JXcnpPQ3lhcHJ4?=
 =?utf-8?B?NTZZTFFNUkx6V0VCMXMxYW52MFkzV1FsQnAvQWU2NFprNDlNSC9GZ0NIOC9w?=
 =?utf-8?B?U3I1MHBab3Y4aGhEYmxTRHBNVnR6eVNCN0RuS0l4REx1eWNVaHovcnQ2UzVN?=
 =?utf-8?B?OGVsS0dHZmZCb3VoMmNSTkVvL3F3U0E5MHdDRVB1WGdPckJhbCtOY0xCZE9m?=
 =?utf-8?B?YkhyMjE5SXdZdEZiS0MxVU9BcWtyQVFKZWwxMHdKVFNlbVJUaWlacW1JelZ6?=
 =?utf-8?B?WTBKSkdxM0JiS3BxVTV6TTNVVVlMZjhucnNYSks2eW9EOHVickJrRU02T0ZT?=
 =?utf-8?B?a2FvWDIxMzU5ZVQyRGM1TXh0RFMyWDJiMHpJME5YSmRER202MW5VNUVLNXlK?=
 =?utf-8?B?VVIwZHNCMkVyTVY4UWVoNml2bWlyV0ZRd0Q5NUEyZ0RsZEM2V0U4QzlhTzNP?=
 =?utf-8?B?VklzNmt1Z09uOWs5bHBVK0xNTVFMdmhVNXRoV0NUaU03THA4emJhbTJDeXp5?=
 =?utf-8?Q?vra/KPxvf9RiXaN2rePDtdt7f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5a52af-a846-40d5-3f14-08dace2079c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:33:30.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrUq1YqOcp3e1VllXxixbXZErP4w9DEw+4y88NntuZMYSWkY/9qKkHm35HVK+odV+YhXD5doNHc1kjxNJOkXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 13:38, Borislav Petkov wrote:
> On Thu, Nov 24, 2022 at 10:21:33AM +0100, Petr Pavlu wrote:
>> Option CONFIG_RANDOMIZE_BASE=y needs to be enabled. Switching it on should
>> automatically select also CONFIG_X86_NEED_RELOCS=y which is what actually
>> enables use of --emit-relocs in arch/x86/Makefile.
> 
> Yeah, as I said in my previous mail:
> 
> "and before and after .configs simply have RANDOMIZE_BASE =n and =y,
> respectively."
> 
> I just did it again to make sure:
> 
> -rwxr-xr-x 1 boris boris 377666112 Nov 24 13:28 vmlinux.before
> -rwxr-xr-x 1 boris boris 377718768 Nov 24 13:33 vmlinux.after
> 
> With
> 
> $ grep -E "(NEED_RELOCS|RANDOMIZE)" .config
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
> CONFIG_RANDOMIZE_KSTACK_OFFSET=y
> 
> that second vmlinux file is even a bit larger (~51K) ...

If the before case is with RANDOMIZE_BASE=n and the after case is with
RANDOMIZE_BASE=y then it makes sense the resulting sizes are similar. With
RANDOMIZE_BASE=n, vmlinux is linked without --emit-relocs and so there will be
no relocation sections at all. With RANDOMIZE_BASE=y and my patch, the
sections get created but are stripped eventually. The increased size in the
second case is likely due to the logic to support the relocation process.

The case that the patch improves is with RANDOMIZE_BASE=y. Both the before and
after case need to have this option enabled. Comparison without my patch and
with it should then show that the patch significantly reduces the size of
vmlinux.

Petr
