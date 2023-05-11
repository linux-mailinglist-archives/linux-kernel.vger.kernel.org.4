Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6646FEF5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbjEKJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237161AbjEKJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:53:15 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0716.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::716])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB3E716
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDaarxxMB8Rk9z44xDb82x1hsJdv618OLUtlDP2RTmLIHCKkQD6HqPKVrzXiKrWcWo+ElzqlhRpQ2NakqRwWzVBZuNtpWyY3CAlwDSA/qx+lvfLF+jpqxulG4MRqc5qje3kO/BLoUh+7UFUDDOmvGMeEXa+T/eTSALAPIXMR3gN2LTQwT2YV0WtNpB4Nl/2Vn/uPeR2MH6yNsjRwqQMcBXVCrm3Y8+DPurxjKaLCsFU2yw+fXsckkpQhOD7PK/6X93/G6sHErg3lEvH+JZ1WjP1ti6u6H7qs0liBsVSogBoalkO6uw7p/KrENDfScltBIqtc0rpGLJrQn2Hr9gtM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+PM7nGS4yD69CamF9NofpboTTtA6eNq1gHY9hgVrJE=;
 b=eexy5hhL/Vd8bXAPpXbIh0BFM4543l+0efvuxbZV3magZRX7yGB7EDh317Ve/NnFahJKZn3Iur21250jSlXRH68w1y8xpcoF1HKWSdOrEGVh89mYeeREufXKagfNmv7C1ntNt8k/fu7xAWS1obMFj6uf0tVFNV+8ipUcej6kbxppyHdGAfODF/44vA3s0jP1DAemr6o1/lDzLRQtWsDKBFogxXIQ0piRVxb3LuwtGhg+W6nHTqcp1BCJWEYoOMzr7Z5NNMDxgmuMynr/Aacz7qjxK6ZGIgUZUt22UIHwPxXZqRcxI3ZQx8mWy4II3OSy5myfuAnTpyjNdk8npps/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+PM7nGS4yD69CamF9NofpboTTtA6eNq1gHY9hgVrJE=;
 b=vcOBZ2zY+REq9cwJoxnFnYbDhc+qVWpiM8Wg7RlEbe6G1zRQwc5MbaLRdkKO3qCH2xzcenBgHoJCOsGsmP6QGWax9yIxwBjciDcfTNOKdMIrZ/Joqvv+AhfUhoy3ZKeOpbCfHDIzGwJKCYGD2WcvxIFZ2tYPGzEtvWB+fPsaJ2fngLBpBZvufvL5bVBjTWZ9Qx5dWSC+ROTvaiIDfeOX85rkiacvpKADoiXfwXl9GW524NYg33ew6kmXi3XkAr6Y4uWxDbssDGpj3U9ftFauqwDVT6rnlmmJvie0fqF3RUmy8i+J6MFK92ciNkiCC7mi5de7ATGRIFJyRwlNTYTohA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by DB9PR08MB6571.eurprd08.prod.outlook.com (2603:10a6:10:25b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 09:52:31 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af%5]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 09:52:31 +0000
Message-ID: <c25b958d-f843-41d1-7b68-5d069f5c5121@virtuozzo.com>
Date:   Thu, 11 May 2023 17:52:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFD] posix-timers: CRIU woes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrey Vagin <avagin@openvz.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <CANaxB-wV9iUT6=Y9nZCWbJhiscMrnAQh4fUXs7Tb8pr=-HwSYQ@mail.gmail.com>
 <cc8aa6a4-a187-f3ad-fec9-05f037a3886d@virtuozzo.com> <87r0rnciqo.ffs@tglx>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <87r0rnciqo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0058.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::18) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|DB9PR08MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: c810316a-4b54-4a81-a0b5-08db52056ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1PfbKB5EaavT0EhdAvkUt88g9yyODCDQooI8i1AK2fjzKdM0YtJSLMVv4A51w2C99qM1RIuzMKsLFhdiAB+BR+rpCxGjVJjukxg/TVIeL5nEV0bj56YpcdvxRtVFkOEmpOLu8/VkBLFxKcs8cZJEQMNSAESb8KnCIYqVWLwhaKakeqfPYZdWcPXTrdapz3bM1Zdy7iONQb/p2O+PJctMPjSPiAqs2vnR9XB2FquCrMObqBGtFy+g3Gvui2OuiYaoJn0JCXByEMsgOUr1pLIDScJiMahaYr/CvCMLI/x2MrlF5d/L6zfzsVgr7/kMLJCfIuJsF5DdhGmfhsoEThRjIK/5UQqymsdPw1bGqEZMMav2RxBlMhjMB5rENNRAe90mS9GA8TZL7AK+wyS5eHIdPvq+2YPjDxQ+MgMHFpjl3Ta/7QGgnSuQtPGrrQLmDaI2HrqpFYzYcWkHjfQlAVSt5pdVf6HVUBXwgv1Y9Z4dImD8OKhDOl54Gr7UudbjQiGOaIBED2VgZd41I0T8u27KQEqfmiSijwQ5meTDwEwxeE/xtGlh1gcaZUUe5cOcdU3s+VBb+pVvAvI+F7TVnxAukT12c93/GjuXyZ5WWh3iUWS51kgPeZ9RsPTnztKm0b3gaq1u9A6YpZYqfGbxDKx/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199021)(66556008)(66946007)(66476007)(31686004)(54906003)(4326008)(110136005)(107886003)(6506007)(6512007)(53546011)(316002)(6666004)(41300700001)(478600001)(6486002)(8676002)(8936002)(5660300002)(966005)(7416002)(31696002)(86362001)(2906002)(186003)(2616005)(83380400001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hiVEJNbWNzeXNrRk9mZnBmU21lSUpkN29telEva2pwU3AwNktKRmRGdnNE?=
 =?utf-8?B?R2hSNTRHeWtLbm16RzZSTzNvcEpEdFM2RHJrWmtPcWcwV3dtVDYwZVFqNnll?=
 =?utf-8?B?MWovUWdFU3ZDeXpDSjh2em1TMTNGTytvRCtxVXpQazl1UzJvL0xJU20vcUNm?=
 =?utf-8?B?blpsbEN5ZFByVXZjSUNIQW56azNzUGRTU3FnSysrZ0doS2xERGlrdXlqNk5L?=
 =?utf-8?B?RFpmVlBaUEt2Vi9JbHVHR3AzNURVVTlWL2FucW9sR3dpZHFkbW5Mc1hsZmxZ?=
 =?utf-8?B?ZC9xd1BHTWVXek1PaFM5dDlpTGVMY1pHTTM4bjcyRlJJall2N1FFc05yZGRM?=
 =?utf-8?B?MVNxWjRDcXoxOU56L3VJQTkwV2FaZWdNNDdudGZCRmVsWkZFSjQ3RVJOejVr?=
 =?utf-8?B?Z2NhRjZXalRmVTlBeTJMdFBTWEhhTTVJeS9hQ2tPbW9EMDFGWmJoTk5UQ2Vq?=
 =?utf-8?B?aWl5ejBPc3k3a2tsZkNkWVpjU1ZzOTlrNUNtU0FpMnhkbmIzbVJSNUJXM25l?=
 =?utf-8?B?NUNMckRwbFhET201TTllK1hLUjhsdzVkU3Y4enhvSkIyNFVocG9Wb1B0azBG?=
 =?utf-8?B?Smk5SjJqSk9rRUcxWithbVZEck5vaDVRc2RPMUd5M0tHdTNrNEh3UWZRc3Fp?=
 =?utf-8?B?L05zUVUyMldLQUNtQnpIbVNwdGhaeU1Pd080WTZnSU40NHhzbFR0UzVWeTdr?=
 =?utf-8?B?WHJUWFM4STFqTVZCZVlqMWpOd0xibkEvWEl3a2FBSFFUVUszaExlK0cyMDVo?=
 =?utf-8?B?Zlk3bURRN2ZsbDlGRG9JQUtxYzJValR3cFZtR3RLbVFnMHAyanRoejRmT3Vz?=
 =?utf-8?B?MVhYeWg1cGpPd1JVTkhxaW8rNzRTa1pjZkQyaG5XejBDNHgzb2FlV3JsRUxV?=
 =?utf-8?B?WnM1UjRoL2gxVGpxRDlpaW1XQ29KYU54NlNpN2E4dmxoeHQwNmcvblk2N3Vo?=
 =?utf-8?B?UFYvNWJQMkxYZEpEQTIvZXl0bENvMkxZR2ZIVVlkT0Z6L09kUllNT2U5U3dT?=
 =?utf-8?B?WmcvbUZaWENScnZIaXpzQkd4SHFtTFI5TjNCdllRYlVKWnRlWHIybWNhYzVQ?=
 =?utf-8?B?NTVVZGFKSlhsMkVha3RKUElhTXRxQktRWDNmS0o0L3JUSUk5a21DM3RjajFy?=
 =?utf-8?B?M2FIazZTblVhbGt5WjdGM0lmT0dBcGJMakdZdnJZN3c1M2k2cStJSGR5VFRO?=
 =?utf-8?B?NDdvRHo0bmphL01aTXlsZjNFR2xnK2JKbU9RSWIranBaaWhYRWpXdWZoMVFm?=
 =?utf-8?B?M1U4TnFiN1Y0blQ3ZU5sTWtIdEFzWEJQVm1keGs3eFp1cHlEM3dSNUgvWlZm?=
 =?utf-8?B?bldaem16aWdMeVBNMkdtZWpub1BGM2NrZGpoQzlHVHlJaDRSTkpmY0lFMzZR?=
 =?utf-8?B?aVZJRUgxNHBLcGplWDJ2MjhiaWFrL3dGYUZYNkhmN1lLb0liUEdVSVFWQzFO?=
 =?utf-8?B?RUVadDNzdGV5UHJMbE1ZUEpNKzUxSG5ZdWxRVDZrOU1GcjdWWDhrSXlMUDVF?=
 =?utf-8?B?S2JRM0doSkZVeml2cEV6ZHBzR1ZkOGdtb3ZiOWRyMmtEc0Z1SHdtM1RnQ0dK?=
 =?utf-8?B?YnduRlZOU1cya1oyYlpxZGNvMmM5SFZzbkNBNzJ1OVFDL1ZVVTdjWTdSa1NG?=
 =?utf-8?B?SUx2UHdzUmk3SzlKRnA0SE1zWDlYeHA3N1NXMDlrM3hodGxFeFhyL0lHU0tt?=
 =?utf-8?B?dnpFaWIvYTJsSXVjT0hqK1ljcVF3Nk5xUXdwSXI4ZEJxbEtuR2FNdGxkaWNS?=
 =?utf-8?B?OTJ1dEVJL2k0RGF2eS9UbEUrcXA2NEFFZ2dtQ2N0M1U3TWVWQmlCYXFQeU5E?=
 =?utf-8?B?anczNjhqRlBSK2pFK3VWNkRpZXgwbWtHc1A1R0MzSVJIVCt2c1A1eFdTMEtH?=
 =?utf-8?B?d0RQZldab1dmcE53ZkhCeE1EcFJrdm9nWXc3SlR5ckpTa0E0aDdLcGlzNXgy?=
 =?utf-8?B?Sy9qZEc4WStvNXVpN3RQOExUOW0wcEdQaDlwOXkrL1NWT2E0bFNRc2Qva0Fy?=
 =?utf-8?B?VVZwcDZvZCszNXJZbkN4N1lXY1dZaVp0Y0Qwc3B4c05DNUQrbHdybTIyb0J1?=
 =?utf-8?B?bW9NN1RTVW04OHB2aml0N09VakZnNGIxSjVLakZ5NzFUMitsRkw1WEtGZkd3?=
 =?utf-8?B?MGtTdXlySmtvZnVyM3JVN25aUUp2V0VuZFNPTzhTN3ZJQno4RVpBYzc4YzFp?=
 =?utf-8?B?cGh0eFU0azhjZStWVnoyVjM5cmhCbTEwRnpPSHlyODRnK0ZPcDJPeUcvQXRM?=
 =?utf-8?B?aEZIVFFjd29paWNmNUFrTjR1VVhnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c810316a-4b54-4a81-a0b5-08db52056ff4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 09:52:31.2992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgOcECNKUMs075vZpBPexFtiS185ytKQ1IIyc0wd64L/rCSrZjB7HHQEDfHYIoEeqNAwW1725WQiMIUnDXXWzt9r2DxnFC+HvBneBmiCj/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6571
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.05.2023 17:36, Thomas Gleixner wrote:
> On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
>> On 10.05.2023 16:16, Andrey Vagin wrote:
>>>>
>>>> So because of that half thought out user space ABI we are now up the
>>>> regression creek without a paddle, unless CRIU can accomodate to a
>>>> different restore mechanism to lift this restriction from the kernel.
>>>>
>>> If you give us a new API to create timers with specified id-s, we will
>>> figure out how to live with it. It isn't good to ask users to update
>>> CRIU to work on new kernels, but here are reasons and event improvements
>>> for CRIU, so I think it's worth it.
>>
>> I agree, any API to create timers with specified id-s would work for new
>> CRIU versions.
> 
> The real question is whether this will cause any upheaval when a new
> kernel meets a non-updated CRIU stack.

Creation of posix timer would hang forever in this loop 
https://github.com/checkpoint-restore/criu/blob/33dd66c6fc93c47213aaa0447a94d97ba1fa56ba/criu/pie/restorer.c#L1185 
if old criu is run on new kernel (without consecutive id allocation) AFAICS.

> You know the UABI regression rules of the kernel...
> 
> Thanks,
> 
>          tglx
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
