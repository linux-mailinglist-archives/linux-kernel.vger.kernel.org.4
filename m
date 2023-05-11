Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E26FF53E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjEKO4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238339AbjEKO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:56:26 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0729.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D563F10A18
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBgMjA+rQYJUY1nZqINf098lLWtIqL7lEKlJ8DPcVBVy5cT0WWDW29mjjhC3vZpKPz1Ax2/269NnRqATQ4eWLJA3wvBUDh6GmH0bB0nMEzlHLyQQwlV5Ue9I6qbSV6NZ9gYeOozC2Mw+zFlfn+0TALcXBdOYocD3fXl4lw9tbDus+G0kVhQAcPygKpis1T5LnkXomNKoAhfVMTD6TVkHEIddMS3V/S8/rq6JyNgjEXvllCTN5tgUwgzgX6KdptMX9uq2eBPqoWWVFGsm4YlQu8aW7NJRG34jIh3a+4t+4AihDyIZLTsaw/h8RqUwUPBkUd/GlsyK6fn9QPkUGaZWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs/+6PWPiBGOlqdSstlKPtpWeA6pyMbktLDMS/6xj5w=;
 b=R2DjFA7/DCCQreWI1qizPTtZvTD330MqUuzioMVdQ7Kj1T4hIaalHWN1hBYxl5ctJwgK2ZhSZHYI6AKiOZYtPOYz8iK8uKbl7xMovuVj4/8GsESHQ7U8GWpbBRwSRhkYJRbNDDqtFPEf9N85QSk9xVHbl8iljPxDIlzfx5rAmX4LZw6alLUiW7f4tHP9VarJ0V5KsotmBJS1mcacir5cwWILj3BNPToRDtxZvpYM5jkSsDMo1+dPtewvUdP2Y09ceUXt4xqorxrEt0u3pkAZ+AOw6UmKYgfZd1YsGvuGLVVltDPHB2tpZMAIm56KmJ+RGJ8VhP91Mv3og7qm+OFDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs/+6PWPiBGOlqdSstlKPtpWeA6pyMbktLDMS/6xj5w=;
 b=Ibfg5kjFDq81/Dk79smJmCgCzTOMIuNlg8FMnLCL0Gfb3F+wjo95AhRP6fSL/4GuFxrVAbAL/LvaEwjU8GFD8ep9UvavM5dACTU9LF/FdpJePiKGaUBTkwBEa2AmFXGV3usHObhUhuYHTxz+/RCvph2ETKlk1BKh7EnSi/Onsrvjv0xwUzMJ6TFapMVZn9Hi86rIPvlt9YRTqR8zwa+5XIX1/kaenO80jhq3pDbjU67bBimLMz9yx+F8mokE1SxqMmyUUAMsd9KY16PRbm/LxPqG+OTC1ovxpIbeYg88YCf3+IsQukYGnEw28FMpu5Jg097qgTbIW98RNfmDrKAszg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by DU0PR08MB9025.eurprd08.prod.outlook.com (2603:10a6:10:471::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Thu, 11 May
 2023 14:54:44 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af%5]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 14:54:44 +0000
Message-ID: <ece41415-868e-9068-c8ff-47f0f1b46997@virtuozzo.com>
Date:   Thu, 11 May 2023 22:54:33 +0800
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
 <c25b958d-f843-41d1-7b68-5d069f5c5121@virtuozzo.com> <87ilczc7d9.ffs@tglx>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <87ilczc7d9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:802:18::28) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|DU0PR08MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 1338c6b1-0dcd-4494-04c0-08db522fa7cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIcpCRzZRDrk3okB/SFCPrBow7K+ANA37GJYSWz6vAcVKaF7YRh84Cx8KBWowW3kVfMZ94cUq8q3PaeCIAI7iZjCQF4f62OzDSk2wivGlZxdK3zDXUUgoyD7P6NC1lG/j2PUCIDkw4wwI8z4Qy3+OI4fFQFwyodScZ9OK5L1hGStanYE1gfaegnXda79RwWtLVHzwZGwSp6S+NsQbpwfU4tgJQpWZU57Ifihqo6zLRGs0IF7zzkJoUS53GGmaEFu89YtZ67SRIliaJTeibSLTljYPBpR2wiqiuqYYLPcmJ7n8kici4H6a437eKRo2ekz2sbPyFDMHHGkROHyhzmbhH5k4jZbIj9AE6SvnKQaa7Fb/Qg+fydaCKlXQKd9Kj3DT8AuA1pXcx2MIUBHWqXkAaP8Wq7unjMWYuT6q7492UVgKuYPkL1BVXu6A/odXEWqlKwZkVEPHg1f8Rl4WhPmmYuVyKJu3YdeTnTGVRLLDwonNuzf+aQmDfgWQQag0+s6qlV0EzPCERdG3qctnFIVAMKCCpGYoLej2rEK/ufS6q75hTi22LvxdISijA/G9vvO8WPF+BShfDxX8dZ1nPaEiBHF3sg8Pzb+jLFqeXbglsrbpv3zkWhVH3yz6REG+Vzr8SPAaqFAoJewdelOaJTISA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(451199021)(54906003)(110136005)(86362001)(31686004)(31696002)(478600001)(316002)(66946007)(66556008)(41300700001)(4326008)(6666004)(36756003)(966005)(6486002)(8936002)(66476007)(8676002)(5660300002)(7416002)(38100700002)(66899021)(107886003)(83380400001)(6506007)(186003)(6512007)(53546011)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJPcXV0L1RBNXk3OU1VNzV3WS9XOTRPYzQ5RmFBOVFvcFoxeTdRUTl4RUUv?=
 =?utf-8?B?MXJrVGlNOHM5bWM4T2hSYVBxSkd1bmVZVHc3Y2srUHFDOVdmQzZpQXNQcllj?=
 =?utf-8?B?TzFpaElGRkRRV0F6NmpJNmYyeCtnK25oYUVXKzVJQUpwOU1KOEZ6TGVHUzNr?=
 =?utf-8?B?Q2J5UkVYd0pqZWVjaXYzTTBqb09GS3dwSnZCdnFkL3gycTNlTjl0alptZ1Ex?=
 =?utf-8?B?MjYxcFE3SlNaSmNTQ3o5dkdYYWNnZ1grYnJWQThVVGVuRWphMHVjOGMzR3J2?=
 =?utf-8?B?TFZkWWo2Y2V4OUFmUFFSL1dkak5VZk91dUc5dVM5MExIdUJzR0EvMEFVeGJ6?=
 =?utf-8?B?Z0hHWjBKZTMxQ2dNUW5DYlBpMHNPc0lweHJvWFA5STd2bUdvUjFoNEJRQVZi?=
 =?utf-8?B?L04zT3hsTUloSnMrYzNVSlZiN1dNUXNaRGpGVmovSml5UGo1cWcwMFd1R3Rl?=
 =?utf-8?B?RGxwQTR3M29ia2xXRmY2WVAwSkF5V0VsdFhxOXFlRXdUTi9BRE9PdlBGb1VQ?=
 =?utf-8?B?Z08zN25mVDJPeFFtZUlQUk9PbEU5UnZUWEVHa0NwRExrbHUrbkh3VjhOcFFr?=
 =?utf-8?B?dzhlRTFwamxIZUROckp6c05FMUM5dXA0V2Q5MDY1MFJUdHY5Z2hYSEw2M2t6?=
 =?utf-8?B?WGNJdENQVk9FL2VOK09FQVIwYlV2dkhjOWExc1lORTk3NEFDeGR5bVhnL3lr?=
 =?utf-8?B?ZFp6OWNUMzZZcWo0TkhFcDR1QXJrOVNvNzBUamF4Mzg4WUZXa1pNNDA3RjZp?=
 =?utf-8?B?b1dVd2ErbEhlRW85Y3lVNXVJeXNrVDNQakwrR2RTTVR3OTZZQXFYLzIva05P?=
 =?utf-8?B?Q0RpNVRrRW8vV2Z1WGlpblRINlFYN2krakxBMkdBQko0czZHNFVlc0lOdlRl?=
 =?utf-8?B?ODlkQ3RmOStiVHFaVHNsMnJWOG5jcUhXaVJPMEdtOGlpWmFKR1pIS2QxWXVR?=
 =?utf-8?B?WTRRS3RWK2RSVUgyUFNHbUFMNGowNHYycEtJUDg4MFRRbTZmU0pQbG1md3A1?=
 =?utf-8?B?VmI4RHA1VDhsMzBTV1IvSmJ6YXhwR0hpRkxQbE1uQVZQOVI1Mm8yL0FZeWRw?=
 =?utf-8?B?djhPMDFHSmNQMlVCaU81LzJCWlJOK290UThHTVZYZnlTbldBRzJINFVTSCtZ?=
 =?utf-8?B?cnhKOTlxWWFFdHRiRFljbTlhcmNXdmgyMkRUR3FReHpqc2Z3Rnd3dlV0TmdT?=
 =?utf-8?B?VDJmQTM1Q3RVbTRabDBmZWZjM1U3QzRvTjlQYVZiOXBsWG8zSVBtZU9scEc5?=
 =?utf-8?B?MzBLNmxnclI1Ymc0alVvb3hWUi9IRFk4QXltbHhJRlZYTE9NQVh6UmNvaEFV?=
 =?utf-8?B?RzBKcHlia2hTenlNOGg3TjFkODkwazZ2Ly9Vc2kwNlJ6WHhMeUdpMDk0b3V2?=
 =?utf-8?B?M3V6c2NnWGFiQ1o4bUF2Qk1ES3BrcDBWejdBZEdXNlJqMElyd0tsK0dTckRU?=
 =?utf-8?B?RWhGdnp6U00reDdlRnhWbkF0a2NJd2F3czQ2YjlHOG0wR0JIZXJ2eWdGR0xp?=
 =?utf-8?B?TFNsa2VYaTBjWlFTT3NYcEdjRWNrWXZGYWxTQ3prYi9NZ0RnamluV1MyUHF6?=
 =?utf-8?B?RVk5djBMYy9yMEpGL1VZMUlueVB4Rzlua0FhYUIwRGJ1MjdPd2FpaFhGeFNw?=
 =?utf-8?B?VG5McDVFOTN5dXAxNklGNDRhbnArelRSWDUxWUkzT1pMVEZwZ0FvWnhkZndN?=
 =?utf-8?B?czRNQzJmL3RKMWsxbFM1SGtoYlowZFMwYVd1VlZCWDVsamJvdWlETU5BWUZj?=
 =?utf-8?B?b0dDd1E1eTBTdjZHWWQ4ZU56MFc0NUFESi9Qelc0QkcyNlRrKy9CRjYyY0RR?=
 =?utf-8?B?YnB3YkRXTytTVGdCazhtbW9PelZDSmRSZVNCTGVKRHA2YUgvalpnbVVxVmNL?=
 =?utf-8?B?Z3lnSFFlS2tDWUQ3WjlOTmVDVXZJNVFCdXpvWmJmVkNEc0lsWkhBc1NnQngr?=
 =?utf-8?B?Q3FKZFhxNWhqK3FmdEVYdisvcTlXNkxCZzB5cFN5b2pCcUh2QUp6WmpCV2Ey?=
 =?utf-8?B?RmZITG42OE9VRGNSWjhHTEh5R0xvRXdWK2REWFRJajRmcWRzeWRHZzZ6ZlZZ?=
 =?utf-8?B?ZnUwQVIyR0RVQ3UwTDg0bDNsaTFadVp4QXdxcGRZMkxqR3Z6MmlaQUkybDNP?=
 =?utf-8?B?Wkhob3NrQXNWS1BRejVReWlRYWU1OFcxRXhFU2UrTTliM2dxSUlrRVlNaEZL?=
 =?utf-8?B?RG1FUlhDdVJ4YW9iNjE4bHZmWjFKa2hLelNtV2ZrdlAyVUQ0OFc5L1BvMGFy?=
 =?utf-8?B?eVdIbUgxcjRCZnBjOTlYaGVqRmRRPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1338c6b1-0dcd-4494-04c0-08db522fa7cf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 14:54:43.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dx47k8Bx/Bkm/auXgDBMflvUy9r5fQOQd10LD0189Qzl9bG/ZgyFkmlsS/6NnjjD/X/OyB5m9mPtXFWeN3mztl970Ua9OwAVa+NUc/51r00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9025
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.05.2023 21:42, Thomas Gleixner wrote:
> On Thu, May 11 2023 at 17:52, Pavel Tikhomirov wrote:
>> On 11.05.2023 17:36, Thomas Gleixner wrote:
>>> On Thu, May 11 2023 at 11:17, Pavel Tikhomirov wrote:
>>>> On 10.05.2023 16:16, Andrey Vagin wrote:
>>>>>>
>>>>>> So because of that half thought out user space ABI we are now up the
>>>>>> regression creek without a paddle, unless CRIU can accomodate to a
>>>>>> different restore mechanism to lift this restriction from the kernel.
>>>>>>
>>>>> If you give us a new API to create timers with specified id-s, we will
>>>>> figure out how to live with it. It isn't good to ask users to update
>>>>> CRIU to work on new kernels, but here are reasons and event improvements
>>>>> for CRIU, so I think it's worth it.
>>>>
>>>> I agree, any API to create timers with specified id-s would work for new
>>>> CRIU versions.
>>>
>>> The real question is whether this will cause any upheaval when a new
>>> kernel meets a non-updated CRIU stack.
>>
>> Creation of posix timer would hang forever in this loop
>> https://github.com/checkpoint-restore/criu/blob/33dd66c6fc93c47213aaa0447a94d97ba1fa56ba/criu/pie/restorer.c#L1185
>> if old criu is run on new kernel (without consecutive id allocation) AFAICS.
> 
> Yes, because that "sanity" check
> 
>       if ((long)next_id > args->posix_timers[i].spt.it_id)
> 
> which tries to establish whether the kernel provides timer IDs in strict
> increasing order does not work for that case.

Yes, this check is not perfect, but it does at least something: It 
detects that posix timer creation missed needed id (if you start from 0 
and increase by 1 each time you can not reach number > N before reaching 
N).

> 
> It "works" to detect the IDR case on older kernels by chance, but not
> under all circumstances. Assume the following case:
> 
>        Global IDR has a free slot at index 1
> 
>        Restore tries to create a timer for index 2
> 
> That will also loop forever, unless some other process creates a timer
> and occupies the free slot at index 1, right?

Yes on old-old kernel, where there were no ids increasing on 
create/delete, CRIU is broken, but CRIU does not support kernels earlier 
than 3.11 (https://criu.org/Check_the_kernel#Basic) so probably we are fine.

git describe --contains 5ed67f05f66c
v3.10-rc1~171^2~9

> 
> So this needs a fix anyway, which should be done so that the new kernel
> case is at least properly detected.
> 
> But even then there is still the problem of "it worked before I upgraded
> the kernel".
> 
> IOW, we are still up a creek without a paddle, unless you would be
> willing to utilize the existing CRIU bug to distribute the 'deal with
> new kernel' mechanics as a bug bounty :) >
> Fix for the loop termination below.

It fixes the loop for new kernel, I agree.

> 
> Thanks,
> 
>          tglx
> ---
>   criu/pie/restorer.c |   24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> --- a/criu/pie/restorer.c
> +++ b/criu/pie/restorer.c
> @@ -1169,10 +1169,10 @@ static int timerfd_arm(struct task_resto
>   static int create_posix_timers(struct task_restore_args *args)
>   {
>   	int ret, i;
> -	kernel_timer_t next_id;
> +	kernel_timer_t next_id, timer_id;
>   	struct sigevent sev;
>   
> -	for (i = 0; i < args->posix_timers_n; i++) {
> +	for (i = 0, next_id = 0; i < args->posix_timers_n; i++) {
>   		sev.sigev_notify = args->posix_timers[i].spt.it_sigev_notify;
>   		sev.sigev_signo = args->posix_timers[i].spt.si_signo;
>   #ifdef __GLIBC__
> @@ -1183,25 +1183,27 @@ static int create_posix_timers(struct ta
>   		sev.sigev_value.sival_ptr = args->posix_timers[i].spt.sival_ptr;
>   
>   		while (1) {
> -			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &next_id);
> +			ret = sys_timer_create(args->posix_timers[i].spt.clock_id, &sev, &timer_id);
>   			if (ret < 0) {
>   				pr_err("Can't create posix timer - %d\n", i);
>   				return ret;
>   			}
>   
> -			if (next_id == args->posix_timers[i].spt.it_id)
> +			if (timer_id != next_id) {
> +				pr_err("Can't create timers, kernel don't give them consequently\n");
> +				return -1;
> +			}
> +
> +			next_id++;
> +
> +			if (timer_id == args->posix_timers[i].spt.it_id)
>   				break;
>   
> -			ret = sys_timer_delete(next_id);
> +			ret = sys_timer_delete(timer_id);
>   			if (ret < 0) {
> -				pr_err("Can't remove temporaty posix timer 0x%x\n", next_id);
> +				pr_err("Can't remove temporaty posix timer 0x%x\n", timer_id);
>   				return ret;
>   			}
> -
> -			if ((long)next_id > args->posix_timers[i].spt.it_id) {
> -				pr_err("Can't create timers, kernel don't give them consequently\n");
> -				return -1;
> -			}
>   		}
>   	}
>   
> 
> 

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
