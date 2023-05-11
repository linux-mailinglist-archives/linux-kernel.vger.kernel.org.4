Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7106FEA89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEKEND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbjEKEMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:12:51 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2101.outbound.protection.outlook.com [40.107.7.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02F49FA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 21:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j77ZB4iTVCaXKolVO60gosGbdXZPUQuYYqU/qhwPBojXvUItrys1HHy2mUCfBlH6RmBD8wlMqONlDQ5HSfC0MKwZSMPjPe47xKjF8+OSB2M/1cybjopd5z0S5t8MArjWgRJSXrlTbH7rvSQTTHf/iXJSsnfeS4DydAo7KLsRXj+wY0JBxQCmsO8vPhQHDTNznAEv5wYgmwaFaqrYFTzBk+nIZecav4B3tDyNuoSiMYR28ccaveQ0x7W8Q4z2ObTtfKM/pza2tgfPaXvDAV0iB+Lk32i1k7x0dr0Rjbc+7CZEGmamrgtB9qlJ0ZAOMy0fbjl0v2+cHrmCfzKfGeAK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ/+qqYx4I+9s2iNjMBWRy9/a6960A13/TH+G8Mf+ho=;
 b=jGRJs7XQSsBe+A32nd3bFzMuO/LMXq9aNF2rFIh8ssTNEQxaCRmpvi3wvdljQpKjntM+57dG7lX1iwx+R4y/1MwA7gtog8ha17zkmdNvlWDDjA0Jt2MhTdv7yKsfMu1n2BIr7annhkTO0Xo4f1USC81hEvpe2XOtHeVUoRI0q7MjqF4J/bVhw+m/pnTxfX2lEtLhdlnppJRVjSFbUuUpSbunpIy23XbA25pA/akRTyyjo7xxS8AYat4w8XjAfomv4lTrmvMCfCZIZ93FhibGmCqHkGeVr9bHRrXtm1O1X/5vgp+gmv7iEZDEQ0si9IbKQjmQ5EzvgzJ3w+Z0u2vSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ/+qqYx4I+9s2iNjMBWRy9/a6960A13/TH+G8Mf+ho=;
 b=jjuIDLXDkDm7ITPCVO8mN/Z8z7ehfEczQ3nWLyslWaD0BG6LJNN2gtByQzqN9fLnO92xwMVr3P4JAO6lfEp8xVZcSOgcUrX7SFKVe5j7gWDD2s+A6FFF5uIsShY2SKLb/5utkoyW9WvMWraf2svNW8kViZ0NvE0PjlMpYt0/Gls3S1lFVsP0GmF4G4JOF7xefZuNesz5QGwDtaRX8nje8q45jhVuQsvcBOmjr17K65ClG0OgtjAoIEW8zl/FzK+gsN6x81u44jTDfkST6qq/hUwpNvjl5kjE57Xl39QRGIdqeOoqm0uR2oEKSLT4UzyWXEFGb4JaMU1nMbnfXcXcUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by AS8PR08MB6696.eurprd08.prod.outlook.com (2603:10a6:20b:395::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 04:12:43 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::cc7e:f565:88eb:67af%5]) with mapi id 15.20.6387.020; Thu, 11 May 2023
 04:12:43 +0000
Message-ID: <005a944c-ed2e-6010-a534-26d5947402da@virtuozzo.com>
Date:   Thu, 11 May 2023 12:12:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFD] posix-timers: CRIU woes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com> <87wn1gy4e6.ffs@tglx>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <87wn1gy4e6.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:820:d::21) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4989:EE_|AS8PR08MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: a4454c33-0721-4dbf-9919-08db51d5f786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dk6Ebnw0heUBX80biQ4B9iVhhAK9HIpX175YbZmgAja8qEAxeM4REVfZL5WnJV0xuOOiJWmaYVAl3LQsABXKWJwkktecgNKKL3w5plSTtbmgquwACJwB2vJCt8hOZxoZkgfnnDTGURUJnk+bDCis+dkgUG1KrQbd7vcQqksYpULug7Y/kQbdeMr3pBNdcr61vJVuGzJs2A0zqdRKo4/bYtKQi9LVMiP7ZFCdi6xi00EnHVoKQ5NpcD6DmFckkBkZzGTxxWSv2K5209856ADO2TYhfV3MrRpzTLEeOvcoLfeqlrKfKtpvWsnI2Km8AL8eRN88tG+gd8bEC1VLXg7gd60gUXin0n+sxfukWaeDWL7ehn3JfX9r/xNnv8LqRKW2ZrWlfdHkdsIioXsll14VGurk+TH+XhD4dMdfDcIcUB5d7NBGmaBx3WY4bYKo5J9XhpgWr7nqaGfAca77c8ZBJaKgpzcsQOcMKZQoPDEhd0Tva+I/dkhnWQ1BH9Rk7Pjw8MsuL/KurPd0dgZzicujJl2xdaUWWrROfTVsdiq5EskOef4hi2np9vYWMLwRrbvhGWVyvFo6idvAoiOJvJEu6LJ46mQjPn1WlBuj7zPoSNFrSUHe+7lqDjqNLh9s4SBdqbh9y3J7b5FngKPPbBlWGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(451199021)(54906003)(110136005)(478600001)(31686004)(7416002)(86362001)(6486002)(6666004)(31696002)(316002)(66946007)(4326008)(66476007)(66556008)(83380400001)(36756003)(2616005)(8676002)(41300700001)(38100700002)(8936002)(186003)(2906002)(6512007)(5660300002)(6506007)(107886003)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFZT2diY1k3UVUvSWdrdHM1ZDI3RVJZanAxbFFtVEJESC9jVXdtUE03M1k1?=
 =?utf-8?B?cFExbUFCZDhsU2lHUWs0UW9zUktEdjMvK0VaazduSEpETHJOUnBjZUVqdHo4?=
 =?utf-8?B?ejR6NUpkd0crTE45ckNrU3F1UERzNy9JWVZyNDJ5VjFqdXlyZjV5Rnp0cnBm?=
 =?utf-8?B?cVR6RHRZMXQ2UU1YVlFHMHRuQXhCVVR5OWlzbExUTytkMUxZcVFOSGltYjZD?=
 =?utf-8?B?Rm1tQzFHTG1UYmo2VHo1MENjUUdRTGJjMklnR2EybVRlVTh4UXY4eWVOdHJU?=
 =?utf-8?B?dEdTZDFDSEg3dFpueVg1MjB2TTBUZzM0U2llQms5L283dnFOUkQ1dmd1YXRG?=
 =?utf-8?B?THRLWkVJL3BWemNCS1RRUFRpcnd3NjcxY1kwK0tQYy9WbHdBcXNEell5bzBQ?=
 =?utf-8?B?MzhwdjlmbWlxNllFNXpJUEtSNkpVNURELzZzREdpOXdxb2RKS0VmbGpjL0Rt?=
 =?utf-8?B?RDR1YkVEc21ZQmEvb2tIa1FXWkY3QkFGeEVmWnMweEMxelBxT1RzMEhCY0RS?=
 =?utf-8?B?QW1TbDA2c3lxd2lLRkc1VjBCNFloTjQrMFBVNDhrZ3Q1VlFscnBCeFdsVW5X?=
 =?utf-8?B?MXVtU1ZWZlhXbWl5Ri9Sa0dXR0EwTXlTeHhHOU5BNWJvalk2WUszYXhTc3VJ?=
 =?utf-8?B?d0owWm1yL1dSdWNYd0Riai9ZOFVZT21DdDV0NnR3OFoyL2xzWHE0bHZkMStl?=
 =?utf-8?B?Y0E2cE1VVWFVNFlWMlBJcStmMFloeExRUWxoUStDVGY0L0hpTVgzeFUvLzcr?=
 =?utf-8?B?NGJoZGxYb3NEMlV6U0lxMGFiMi9OSXVzM1dLU2dnWFo1cEpVTlNhU21DOWNH?=
 =?utf-8?B?NmR1T3pjUUVlRmNIMVM2YzNaTkc4NWRyWEE5VS9ERWVsYXlqZWZic3NrbnNY?=
 =?utf-8?B?eHlvWU4zQVgxQ05ISFhGNDdjaUwzMGdGWExwWkxkMENNQm9UUytUTm55L3ll?=
 =?utf-8?B?TFhXcmJmQTNEeUFEQjdJZlJ4UnBtNmVTNTI5OFRPaG9DU2NSLzY5RzliNFcx?=
 =?utf-8?B?QWUwSVBwb0FJZUE2MzludjgwU1A1S2p1Q2t1djV2Q05jNEZRcG1Pam9FVkVy?=
 =?utf-8?B?bUtJQWlZNlorS1cxVnFUUE9HcjhKU1NKOEhuL2cvR3RXaHhWMDR6N3EwWFhq?=
 =?utf-8?B?Ym5KcFFBVHVIb0xQMjBDZUdIWTYvK0JFd2tROStWWFFpQ1V2TzFsMXFKZE1B?=
 =?utf-8?B?eHBjdTlNVHFpY0JqN3VLeG5VYkJ0ZnhuSlRFdmtTV0ZKSC9kRXlNalZHRVZu?=
 =?utf-8?B?M0ZZN1d2ZnRuRmErMU5SZHBBdE9zbDV2QVRvT0lVZDlMSFFLUmJYOE5zOXlS?=
 =?utf-8?B?ZUNlMVVSN2ZXRE9rODhDd0xHKzVLU2NubTRjdHk4QVY1eWZmQm53V2FTdE8x?=
 =?utf-8?B?a29MNEpYRUk4b0VSV3pWaExzWkFHOGcyeEZ2cFYrMXplelozTG9SbzdVcjB6?=
 =?utf-8?B?Wm1lRnBUV0ZtSnNoOXFpRmZZU1MwUWtnUm1ia1BoanBOOVNrMFgvanFtdDZL?=
 =?utf-8?B?d2pkSXJqN29aUVByb0tqL041b1RLMEp4VUF6YXFGNWFaNTFoVlFOYi80YmNr?=
 =?utf-8?B?U2Y5cENwR0tRUU4vQ1NoRkZSTkw1UWhjQUFTcFovQmhHdHdBY3AzRG1RZjdm?=
 =?utf-8?B?bEMvOWxpZG1KcHV2TCtZVUx2QXBPVVVKMzB5ZTR6NHJRclFTM0x0OWFVcmd3?=
 =?utf-8?B?VWJqV3N4WHRtSVh4bVVXTzFRa2hvZ3B2QXU2ZHBTYzBDMnZ6cURDUlI0TE9S?=
 =?utf-8?B?aGpnYkpKVi9PRDN3WDhSSVlJYU81UURlekRvaDJtbDRaM0h6cU5Vd09kcXY0?=
 =?utf-8?B?L1dCaytqSzdqN0Z1b0tRQkI3Vno1L2lhUVE3V3RCUm9GV3lUTjdLcU0xVEwy?=
 =?utf-8?B?b2pWQk1vRmk1SnhQSGtKeEZtNm8zbUdVdGdENStDNlR3cE5ZYm8rWHpzRWV4?=
 =?utf-8?B?MnJESzc4UXJ3ZE1NM1BrNlB0TTFyaVlCbmZSUFJaUmVQWFpKU0xVK1IydDV4?=
 =?utf-8?B?cjFLRnVTaWhUYkRjQWNuVHhuTERkTzBHRU5aQTZQWTViRzJIWVd5L1lGNUdM?=
 =?utf-8?B?WHowZGJYTHYveWFyUmFKRjNOMkxuTG8vY0xiNW1GQ1hnUlNrcUhTR1ducis4?=
 =?utf-8?B?Tk5rQlNIc1RTTFMzRWV2ZnR6SjNtVUErR3VkdnNRaXJBdVNMVWY0TDArVTds?=
 =?utf-8?B?VngwM29MMStMc081RjI2RW9kcm9CUmFrUWZoT0hoRGx2aFZEQzJsS0NnQVlI?=
 =?utf-8?B?TnNYbVhXK3huamRCQ1NZcXFtVXBnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4454c33-0721-4dbf-9919-08db51d5f786
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 04:12:42.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: so4w6W4Ddw82daQZyfScUqVNMWKSR378oNdYsqNMWNJDPpE3Ni5w+oh5z3o4WUoBTBTLvOi+MPBvAagg2MsY63m/WNSQiEpbrA0olAVNwXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6696
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.05.2023 16:30, Thomas Gleixner wrote:
> Pavel!
> 
> On Wed, May 10 2023 at 12:36, Pavel Tikhomirov wrote:
>> On 10.05.2023 05:42, Thomas Gleixner wrote:
>>> So because of that half thought out user space ABI we are now up the
>>> regression creek without a paddle, unless CRIU can accomodate to a
>>> different restore mechanism to lift this restriction from the kernel.
>>>
>>> Thoughts?
>>
>> Maybe we can do something similar to /proc/sys/kernel/ns_last_pid?
>> Switch to per-(process->signal) idr based approach with idr_set_cursor
>> to set next id for next posix timer from new sysctl?
> 
> I'm not a fan of such sysctls. We have already too many of them and that
> particular one does not buy much.

Sorry, it was a bad idea, what you suggest below is much better.

> 
> We can simply let timer_create() or a new syscall create a timer at a
> given ID.

Yes this would work for CRIU. (note: in neighbor thread Andrei writes 
about adding a bit to sigevent.sigev_notify to request a timer with a 
specified id, new syscall is also a good option)

> 
> That allows CRIU to restore any checkpointed process no matter which
> kernel version it came from without doing this insane create/delete
> dance.

Yes, for CRIU this kind of API change is a big improvement.

> 
> The downside is that this allows to create stupidly sparse timer IDs
> even for the non CRIU case, which increases per process kernel memory
> consumption and creates slightly more overhead in the signal delivery
> path. The latter is a burden on the process owning the timer and not
> affecting expiry, which is a context stealing operation. The memory part
> needs eventually some thoughts vs. accounting.
> 
> If the 'explicit at ID' option is not used then the ID mechanism is
> optimzied for dense IDs by using the first available ID in a bottom up
> search, which recovers holes created by a timer_delete() operation.

Not sure how kernel memory consumption increases with sparse timer IDs, 
global hashtable (posix_timers_hashtable) is the same size anyway, 
entries in hlists can be distributed differently as hash depends on id 
directly but we have same number of entries. Probably I miss something, 
why do we need dense IDs?

> 
> Thanks,
> 
>          tglx

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.
