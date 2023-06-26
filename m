Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FA73E05F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjFZNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjFZNRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:17:20 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2B1A2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:17:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrftI9YAseXHsl4ZzUA6Z0AOhQXTg8BoEVkty0KAgIxiSyKTywVwGq/L1eccJusWnleddboaEZAYaBosEMnf4BEeo8JCuc8erzkgBDLPGJSuDVRYym90IaTz4s4QE2qssH9q8nC+UABz5xAzSXL+fyD4BOpF6briLFsWl/rSG9UCm1uDneEcYjmfM/skw17xLQt902mVTQyHbYxleKryMetj43Ml2cB+pXLSHH3/Xq4UYEa+GkMthDDAHZyKxSZZscFeaMT27jymncANmwqqAuqP5EO+rVEyA48xSd4WvYrlW+XTmDCKeCWHhZmzvQtsMXLuvktiEMgYlVV/xkjepA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YYsqb8fAGwighP0b6BGte+MLWO683Qx6jkr8ncM5BA=;
 b=IXJBNCpvUfxPETEKcVpJaNcmJSmh79Cy/aIS/CQM6b2jsQurFuZ9DKrtog5VsAZT23RJRAGiBblsL6fdZsQg/j3icoUClDu3SyPmxjEy4EHwNN/JBs+zKoFngpZ+ZYpq3x1djOhdxXl+rRqdD91xmvfPMFxIc7anE+gBzb12Dc1cUOYf7Cc5UaLnSqtDkitEOkhbt2FctHX97P32SvtugjNSV8sSyOMm20GCv28Tk6DCTdOUDxgnV1rNyRJtPGBCZ+xrZR9xmvHVrv6ghzLnK6vVdqqGxybDjfPiJt8gPXMWNlZXuScF/tIWHiiPDQ0gauC7dV4qQ9kcisvTIJBNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YYsqb8fAGwighP0b6BGte+MLWO683Qx6jkr8ncM5BA=;
 b=y0JIJXq+4pzOGKTOu56AhDvwACmnz2W6kMJ3GUf3dmyCA+q58Mq8Q26dhCrmMvQMYVC1NTwARKkoAImiXHJWQx+599sRvYCOnMD3BHoAHHRAvQVIyuLNOPnEqY5AywEmAPP95loBRIn3OQEpFPpYCrPesjnb4VHqdKdIl96TeAiY4OgCGYVfObKSdYGL+GpL/41EmzPI1Kh98593ek3UTpd4Th/4PTFnk2m/vPZK7cYA3VENRhEEVSlLgt0qtte7gXiAbdfdcnkmnYkVJiL979X0KFErF2bi5Z7KWakTXKgqLAKT8NkFHlPlTqTao4EcoBv2NgC1nD83I2ON/afPEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM9PR04MB8555.eurprd04.prod.outlook.com
 (2603:10a6:20b:436::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 13:17:10 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::551e:9fcf:5b65:ca5b%2]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 13:17:09 +0000
Message-ID: <551a1594-9c8b-d447-6bf3-a4a208d5550f@suse.com>
Date:   Mon, 26 Jun 2023 15:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] xen/virtio: Avoid use of the dom0 backend in dom0
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>
References: <20230621131214.9398-1-petr.pavlu@suse.com>
 <20230621131214.9398-3-petr.pavlu@suse.com>
 <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <15e31609-6c45-7372-76ee-0adf7a64fe88@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM9PR04MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 1968c6f5-7125-4b43-090d-08db7647a57c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAY+yaBua0SAjbp0ARjtBlOO3Zo9SlO1oAvREc7ZQ18lZsln8zlOQyzKC1J61WjzQ20mq/lCucewmOF6QH8Uq6bU2Bx2EAzQC1oyYKksjCCNfgzzYzlEiXTNcKsxa+rDyXLAaqy2tNh780LiXSd0r9kdAIxUpLTVke3s/s2iN51dKYLBSlg/Qp/qokopLHG4OpGbfGQmwt2l+oCpGyT7Qb/DcLlQH3sb2oBFNyJHJJyIROUUghVTSbr5VltNMu7y/s6Kt/76nk882O52QV3krnM8OQvSumfZAmCoCFxzmUQPlokwefExAaBz8+4e8JyBjOSLmGHsZwJfqKWA71qP0BZcIipXxb9APpYRji6JxW5nYNHMs8FXyvHGLDewQrTItKj2NpgmKbypw8JVchp9zHi/vEfgxaerowXSjfiVzTxy9G2lZwI8/G6zsx45FmBkhSvhj0+S5RAWAXLaKyxp4FEEefiehGgBY/IcRXCJYS+PPEasvGz4hjhkCjBRaquThzWdCmQKs2JmVUsyPGQ7+9vg3oJTuCsU20FIOVVPLB6A19DGkHdVIPxxz+U4h86yVrFEk8n3ciT859Ol/4ib7AfGN5bGH6w4IkmFsfKSbGIfVNdJH9S2u1HOJ1RxxFjY7ov5zwZqxdmiHoUhIxfIpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(31686004)(2906002)(66946007)(478600001)(6916009)(66556008)(66476007)(6486002)(4326008)(316002)(31696002)(54906003)(86362001)(186003)(83380400001)(6512007)(36756003)(6506007)(2616005)(26005)(38100700002)(8936002)(53546011)(55236004)(41300700001)(8676002)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU1YMXRBYkIyajBhRmVWWWtDT1MrS2N5cmM3MCs3TUd1dHNwaWpET3lBeFJW?=
 =?utf-8?B?YXNsRWFZaGpaaWlqYTFxdlQrb29SWDk1UGQ2aFp3cTVoeVJqV05kZFRNaGxa?=
 =?utf-8?B?VExWYlVZT21HZVhZTCtLa0F2Sm9HbURUS1Q0Z0FnUTJycFFpdVVHY2hKK3Ny?=
 =?utf-8?B?cDFEWlFTMFlRejgvVVlCRHdxMUF3d0xNL0ZxaUlvbk9sd1AvSzZhZlRBZDdj?=
 =?utf-8?B?NVMvdWRPS0hISW9HdHc3dzFWZVJQYTVQZ1RZRTFUWWg0YXR3TlgyRDlUK2Qy?=
 =?utf-8?B?b0xyTEd2cUFvRHJnYjJRYjIvamdNZDd6NnVPTUtxODhlNzVKTGRpSDl4dE1L?=
 =?utf-8?B?SnVhNE5sY1Q5anZCS0JhU1JaSElGeU9yZ1Q5QmNBNndETzl2QVFGeXB5MEJ0?=
 =?utf-8?B?N0cwcnNCaFAzU29OOFpEZkl6cHI4dk45MDI1NlNINmRNY3RqbEYxb0IyOEo5?=
 =?utf-8?B?ZVlDbjZEN3E0T05KQXZTUlUwRDRrOHlqUk9nQVJrTlNrSnpzb25uMlVZbnE0?=
 =?utf-8?B?SHprY1ZUUzVrN0ZqN0Q5TEp4blJjejB5UUNPQm9DelFQdzl6cnF2WXpzUGhZ?=
 =?utf-8?B?OFNUYmNOekVkZUh6NlBuSUEyVUU5N3EzQ29aMmxYVXhKT3hTUXNKQ0h5Mkho?=
 =?utf-8?B?T3FhMGtPTllQbXFscWE0TDhDUWtWbk5kUFgzOW5CZlk0NWloN3FldFRWS1BL?=
 =?utf-8?B?N2Jucks1TVdGTlgzQ09UZGlpbnhlYVdGNnNyTjZSTGdnZG9PSlcvbWVQWkZ3?=
 =?utf-8?B?bVl5bC9SNTdFOTJHNlUvMXBZQVNUQXZqS0Jja09Zc2wvWjVrODBCQjZNcnRR?=
 =?utf-8?B?RVU0ZXVjRDdRQXVoTzJCbGF0bldMYyt6OC9kajhPaDVNWGkrNjNlV29YbnlR?=
 =?utf-8?B?THlFTlE3STNjMDd6K2EwS2VNV0tFakVOWmtYL09TT2xpMTRzR3R2d1ZKbmdE?=
 =?utf-8?B?MjBOZEFuWXNPSjlpN0ppMjlwVDR1ZXVTNnEyK3d1Y1MvdTdPaUU0VGhDdXcr?=
 =?utf-8?B?MWRYMzF3M0dBODZNOXJaeUxHemJkZXBYNE9ES2tUais4aTk2a3NJUlRNNEc4?=
 =?utf-8?B?d0ZTSUtHWndQWnZkUncvUlpUQ3VRVmREdGV1MGphQjdIMDFPbzFDZm1IOVNo?=
 =?utf-8?B?NVZDQ3lkMjZnTVNYbDRjWVJFQlFEaEhKZFR1SEE4c0RoOGtSdStIenhUYXZt?=
 =?utf-8?B?M2p3TkttMWc2V0dQK2NnUXZWQUIwTGsrMGtGWm9qNlRJTi9IbXdrZjE5M01n?=
 =?utf-8?B?WldvQkZqZHRVWjdWbkVwNFNWSXowd2l1MlcwallXVGlnTHlnMnRudnVuTTZZ?=
 =?utf-8?B?RGREbGlKRUJWQXdaUHNOL1RPS0UvUnFoT2JTSkRnWndwLzI4YXhsZ0QvSUkv?=
 =?utf-8?B?cm5ac2pCQnVsU25DQ2kzS1ZYOU9BZXVtL3RTMWJoWDBtais2dW45L09kYWR5?=
 =?utf-8?B?VFVMN2tUMUEvUFNPOHplY3VnNU5wcTlKbUhQWFRSOWI3ZU51WFZKRkE5VTBp?=
 =?utf-8?B?S0t6Q1Bqc20vai9LREVGdXlscDNJR21SNXBuMGh3dyswU1dKYTNPT1pBMFpN?=
 =?utf-8?B?WWt4d0RXc3VmdUxJVm9RU2NMMjEvVkVmQkQ0ZEdVdmpMemo2U1lSYkdTR283?=
 =?utf-8?B?TE52UWhmV0NpMkhHenk2MkNOeDdBU0R3SWx6NFFRa1J1dllIdjV2a3g4N2lv?=
 =?utf-8?B?K0JtT2syTHl2MWJYM3JLREl5U0l3WVl5RFlaKzlwTGx6Y0YzVGtDVmwyZXZV?=
 =?utf-8?B?VlZtR2sweGZNbm92VGFkSEQ4UENCZjFCQ2JjVjBLenFmTldxRkxYa21hUm5Z?=
 =?utf-8?B?cm92L095M3lmY2ZnMktuZHl0M0VFQnlGSlh2RHAvQXBTUU11WmtEVFBOb1FN?=
 =?utf-8?B?aVNmWHBxL2hzTDM5NjRLTmN3YmJsVE1lWGcxZmxpU2Z1T04rTDE5SGhQZHha?=
 =?utf-8?B?MFJXNjByTUh4QTlBMHVsQ1orSUQzemJRenNGc3NTcHJDcWhiNmdDc05uRDJE?=
 =?utf-8?B?VDI1NGpLM3d4WG1LZmwzTVRtWTRGaXA4Z1RacytJTVNjYmM5em1QdTRtRXd5?=
 =?utf-8?B?Qi9jaitjU21BT0xuYS9EeU93OUhKRnpZOWJrVmlyYzVLWm1ObUxFM05PVWFa?=
 =?utf-8?Q?Qr8pLopspSK2YiJ9Dhj1d4F1g?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1968c6f5-7125-4b43-090d-08db7647a57c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:17:09.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpI9INJF8jhfrkQz5HsSNLXr9MId8BPE4tA2FI0c/jSkUZblz8j9SRCsxA7mN4jTeImagp5KSse1jxSvYAZFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8555
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/23 19:58, Oleksandr Tyshchenko wrote:
> On 21.06.23 16:12, Petr Pavlu wrote:
>> When attempting to run Xen on a QEMU/KVM virtual machine with virtio
>> devices (all x86_64), dom0 tries to establish a grant for itself which
>> eventually results in a hang during the boot.
>>
>> The backtrace looks as follows, the while loop in __send_control_msg()
>> makes no progress:
>>
>>    #0  virtqueue_get_buf_ctx (_vq=_vq@entry=0xffff8880074a8400, len=len@entry=0xffffc90000413c94, ctx=ctx@entry=0x0 <fixed_percpu_data>) at ../drivers/virtio/virtio_ring.c:2326
>>    #1  0xffffffff817086b7 in virtqueue_get_buf (_vq=_vq@entry=0xffff8880074a8400, len=len@entry=0xffffc90000413c94) at ../drivers/virtio/virtio_ring.c:2333
>>    #2  0xffffffff8175f6b2 in __send_control_msg (portdev=<optimized out>, port_id=0xffffffff, event=0x0, value=0x1) at ../drivers/char/virtio_console.c:562
>>    #3  0xffffffff8175f6ee in __send_control_msg (portdev=<optimized out>, port_id=<optimized out>, event=<optimized out>, value=<optimized out>) at ../drivers/char/virtio_console.c:569
>>    #4  0xffffffff817618b1 in virtcons_probe (vdev=0xffff88800585e800) at ../drivers/char/virtio_console.c:2098
>>    #5  0xffffffff81707117 in virtio_dev_probe (_d=0xffff88800585e810) at ../drivers/virtio/virtio.c:305
>>    #6  0xffffffff8198e348 in call_driver_probe (drv=0xffffffff82be40c0 <virtio_console>, drv=0xffffffff82be40c0 <virtio_console>, dev=0xffff88800585e810) at ../drivers/base/dd.c:579
>>    #7  really_probe (dev=dev@entry=0xffff88800585e810, drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/dd.c:658
>>    #8  0xffffffff8198e58f in __driver_probe_device (drv=drv@entry=0xffffffff82be40c0 <virtio_console>, dev=dev@entry=0xffff88800585e810) at ../drivers/base/dd.c:800
>>    #9  0xffffffff8198e65a in driver_probe_device (drv=drv@entry=0xffffffff82be40c0 <virtio_console>, dev=dev@entry=0xffff88800585e810) at ../drivers/base/dd.c:830
>>    #10 0xffffffff8198e832 in __driver_attach (dev=0xffff88800585e810, data=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/dd.c:1216
>>    #11 0xffffffff8198bfb2 in bus_for_each_dev (bus=<optimized out>, start=start@entry=0x0 <fixed_percpu_data>, data=data@entry=0xffffffff82be40c0 <virtio_console>,
>>        fn=fn@entry=0xffffffff8198e7b0 <__driver_attach>) at ../drivers/base/bus.c:368
>>    #12 0xffffffff8198db65 in driver_attach (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/dd.c:1233
>>    #13 0xffffffff8198d207 in bus_add_driver (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/bus.c:673
>>    #14 0xffffffff8198f550 in driver_register (drv=drv@entry=0xffffffff82be40c0 <virtio_console>) at ../drivers/base/driver.c:246
>>    #15 0xffffffff81706b47 in register_virtio_driver (driver=driver@entry=0xffffffff82be40c0 <virtio_console>) at ../drivers/virtio/virtio.c:357
>>    #16 0xffffffff832cd34b in virtio_console_init () at ../drivers/char/virtio_console.c:2258
>>    #17 0xffffffff8100105c in do_one_initcall (fn=0xffffffff832cd2e0 <virtio_console_init>) at ../init/main.c:1246
>>    #18 0xffffffff83277293 in do_initcall_level (command_line=0xffff888003e2f900 "root", level=0x6) at ../init/main.c:1319
>>    #19 do_initcalls () at ../init/main.c:1335
>>    #20 do_basic_setup () at ../init/main.c:1354
>>    #21 kernel_init_freeable () at ../init/main.c:1571
>>    #22 0xffffffff81f64be1 in kernel_init (unused=<optimized out>) at ../init/main.c:1462
>>    #23 0xffffffff81001f49 in ret_from_fork () at ../arch/x86/entry/entry_64.S:308
>>    #24 0x0000000000000000 in ?? ()
>>
>> Fix the problem by preventing xen_grant_init_backend_domid() from
>> setting dom0 as a backend when running in dom0.
>>
>> Fixes: 035e3a4321f7 ("xen/virtio: Optimize the setup of "xen-grant-dma" devices")
> 
> 
> I am not 100% sure whether the Fixes tag points to precise commit. If I 
> am not mistaken, the said commit just moves the code in the context 
> without changing the logic of CONFIG_XEN_VIRTIO_FORCE_GRANT, this was 
> introduced before.

I see, the tag should better point to 7228113d1fa0 ("xen/virtio: use
dom0 as default backend for CONFIG_XEN_VIRTIO_FORCE_GRANT") which
introduced the original logic to use dom0 as backend.

Commit 035e3a4321f7 ("xen/virtio: Optimize the setup of "xen-grant-dma"
devices") is relevant in sense that it extended when this logic is
active by adding an OR check for xen_pv_domain().

> 
> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>   drivers/xen/grant-dma-ops.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
>> index 76f6f26265a3..29ed27ac450e 100644
>> --- a/drivers/xen/grant-dma-ops.c
>> +++ b/drivers/xen/grant-dma-ops.c
>> @@ -362,7 +362,9 @@ static int xen_grant_init_backend_domid(struct device *dev,
>>   	if (np) {
>>   		ret = xen_dt_grant_init_backend_domid(dev, np, backend_domid);
>>   		of_node_put(np);
>> -	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain()) {
>> +	} else if ((IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) ||
>> +		    xen_pv_domain()) &&
>> +		   !xen_initial_domain()) {
> 
> The commit lgtm, just one note:
> 
> 
> I would even bail out early in xen_virtio_restricted_mem_acc() instead,
> as I assume the same issue could happen on Arm with DT (although there 
> we don't guess the backend's domid, we read it from DT and quite 
> unlikely we get Dom0 being in Dom0 with correct DT).
> 
> Something like:
> 
> @@ -416,6 +421,10 @@ bool xen_virtio_restricted_mem_acc(struct 
> virtio_device *dev)
>   {
>          domid_t backend_domid;
> 
> +       /* Xen grant DMA ops are not used when running as initial domain */
> +       if (xen_initial_domain())
> +               return false;
> +
>          if (!xen_grant_init_backend_domid(dev->dev.parent, 
> &backend_domid)) {
>                  xen_grant_setup_dma_ops(dev->dev.parent, backend_domid);
>                  return true;
> (END)
> 
> 
> 
> If so, that commit subject would need to be updated accordingly.
> 
> Let's see what other reviewers will say.

Ok, makes sense.

Thanks,
Petr
