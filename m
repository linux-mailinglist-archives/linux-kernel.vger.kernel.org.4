Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFDF5E6047
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiIVK6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIVK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:58:30 -0400
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2082.outbound.protection.outlook.com [40.107.116.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F01D58B0;
        Thu, 22 Sep 2022 03:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWnZvUxr/zWvgcy6rW7d8hjLNhyrougZ29p7n66NLmWjieHmvkdmaZgWKS3+8Cp6EUXPdBnx8D9tjWCyHfECtXq0HT8+u4/xxPZsUy5OX/FEXBcZyQAU5vS+hfLmnScpRpSu3HLqre2T2Z30F8lPkAGhfpECTH1L3FFacmjYUdAzEnWDHXEbY/sxDetxWyFnLv4eWdZkFc1TMQgntOHABOU+mjrQU8NXAyBRC31sF0dFjd7+GxfNiyyZDZvU+d+ateG4Hrt8nrSbK9HHXgTpM9SEGpsiMSrBF+b5L0TZQbLLqOpQMCtH0r8NqqtUO1Fw5dKl+rd5ahH36gtiJ82vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BqGeFHcIQaXlDhNbxePNxH/IgkYFcFDpIYmQJ1U0rM=;
 b=UanpQcJVO0HEXAohoECDAgjqvFGYB83AabaA7eMpAiPxXT6V/m9Mi9synh/go4L6aK540hqI6dzt/aMltp5FWzx1C6vG/8M5DegaVG5uwlnJO86DmSO+ZwaemQnR2sC06IktRWs3tDt3VZQbW+Kj2jwiJpKuwr7N48/2ybZgoH7SSOCg5c9ajt+mMDrCuHVaeusKRiEzQGqisV0XT8bk+M2Lu83vd6NSaHNzXQ/HQiEKURm4D/Q2gb6hhY0kgu0fSlqOyCUEaOUky8RTXMIepUg+PGjNaXrBs3ElSuQ36X0erM0c5KpPXK67UxvcpVXamjus0VFoDJmsGbuVJRSnPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BqGeFHcIQaXlDhNbxePNxH/IgkYFcFDpIYmQJ1U0rM=;
 b=eoPzKnFpKScrQ4ffNQHVo5vwHfc4LMBuqWWxY5WFigy9yiIN9JnCGaxJ6smBwMXNTi+zLx7i+wXVa3DgCpBoo2GZtNXkNOPqNkeGICgjxPM2iojRZ9bASBpe3JL279cUnMcG2845tux0iC1yOf44I1YkEAL3og+vfoBmGcnU/2CuEbE+51y3vClcNMyJkJz+EGxPOJIF8nrWMD49XYH1qF0Gypt8DgKDqNT/jBu3iWvQSpwDwG/yD7dauQLRiHnkrCtGETCRd32ZYw4gk5ypgMR+PLe7k8019RzpNQHPU8xEA/AJv46BivA3BKggf1CgmqnB/shYb3aUPCnWoCrnBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6454.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:71::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 10:58:27 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::bd25:7243:1b45:3fb9%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 10:58:27 +0000
Message-ID: <8c628a55-7b03-4c89-91f1-0bba973a5480@efficios.com>
Date:   Thu, 22 Sep 2022 06:59:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH v4 00/25] RSEQ node id and virtual cpu id extensions
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
References: <20220921192454.231662-1-mathieu.desnoyers@efficios.com>
 <14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com>
 <YywYWSIocrDDntq3@hirez.programming.kicks-ass.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <YywYWSIocrDDntq3@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0255.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c635c16-5011-44ec-edbe-08da9c89608a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Of30vlbSsqjxiVxyodgTGESJlC6+96qnb/jY+m/v1gGXoZUQKE8kDAbd0BZAW1ksABT8+P+2FxXpNA5sklqmQD1MOGMqQQZ+0CcdgeG06IYQv6TOun/29/OpkcV6y0W3coA9YhFjxHsiyMcj/xPYy6y46NLF2VtdfykWWLqD/Ws32GqKljYvNWKob3yogRURdRJAm6IIir/a3ElOqRlbG7tbrLqiCqsMVRCeYCYRwAFZn/EJH6Lpx8gaLNfQp6HqJOIk2uhKwtQux7/C2RA1cxBTMXgYDN0eG9qYqALKxYJqxomEMN2G8xivW7GoyM/878t7V2Hn6AivwWvI8s1+KdvP7PjBO1L6+bbiDZBHyGJGBU3UTz2V3JO2h5Xe9dVZWovWqnbCx9pcD0+M7k0mkkcWrZm6SSoXntIZViMGn/cNwU5KdgqdmdzmNKptrns+KQB/PPMVXpmrjUZr5ZRxyDXd/z1BDw+4RvcffOq27/go26XIHgJt0hkZ2zkdUfLHNqravQbODAFGAFGjOOC4dPPngAOgeMQiHI8FZ5QwvQ9dxzV9iwdxd4e5MKTK/12ZYTkhEZFgKNbBlLCFEoO4xwY4OrTQwHnhSUSgbf4GXSQXUQx4OdCWuHXScKKpMd7bpdM4/z+Au2HqxJwSMQ9xjyPuRAKaODU+pU6cRBUkPR0CQ2R/l+Wf79JPrEII7/OSZkFAITqpNT4UTsSCWTjxUq//D8seZ+uP8lqTYuZ7uh5XVl1pCu9/dQoZD7tnsrSrOFKIQr8HTWRPkyP1qHCag3DaYFjwuFC9o/214nrhRz6Br9VxbU8RJ+lzfDuwqyLT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(34096005)(396003)(366004)(34036004)(136003)(39830400003)(376002)(346002)(451199015)(38100700002)(31696002)(36756003)(86362001)(31686004)(83380400001)(7416002)(4744005)(2616005)(2906002)(44832011)(41320700001)(586005)(966005)(6486002)(38610400001)(6666004)(41300700001)(498600001)(26005)(6512007)(53546011)(6506007)(186003)(54906003)(6916009)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09aQWR2eDh2VnMrYUdFM2Ryc1pyc29adG5iU2FTSXpNT2J6MEcrSSt2Qm9o?=
 =?utf-8?B?NHZUZFVoVWg2MzRxYVFNSytOemxiMEhjOHdVUFkxbkwrQ2lRNXkvMmU1a2NS?=
 =?utf-8?B?cks1YVY1S3Uzb2tpSEVPUFpHb2hDNG9uUG9OM2hIZ1o1azFlUzZTVjhPamdy?=
 =?utf-8?B?QXVuUi9pYVFrbnlpdTFFbkZnU0NwSmxMUDBhUXZZUHBmenpaTW9HQ0ZYdEFk?=
 =?utf-8?B?ZFl6VDhQMDJoVHJyUzBncnFLUUtiK0hiSVFOWXg4N1A5cXNFN242UCtLTWc0?=
 =?utf-8?B?T0YyTTNHTmtLSTF1aVZEVkpwS2tTTmlIRnBoYjRpZWFFMTc2Y0FUTUFERDYw?=
 =?utf-8?B?enhsU3ZBN1FYV2lHb1ZKcVZwaFh3NDdwK0QzTGRtdzBZRTVnN2gyay9MZUNi?=
 =?utf-8?B?RG4zc1QzQ0p2NFovdUhmaDRPMERVdzlYc1A0bTJudit1b21NY1lHdTBwTmFo?=
 =?utf-8?B?Skx0TXVPMmh6VlhXSHRNd1RYSGR5Y1JabDhNRG9mVHZWRDZvSVh1ZHllNzZz?=
 =?utf-8?B?Ympia0lnTzZucy8zclJhclV3WWl0eVdITThua1A2TTVMcWp6TDFSNmRBc3Bw?=
 =?utf-8?B?YnlNRk04b0MvZyt6WFdwZUpQU2xtSU9wTmhaMXM5ZjNTV24rSFlYSSsxNEdU?=
 =?utf-8?B?R2NqZDNJYklYRTFtRE1kY2F0THZCN3M0b0V0ODMrMWQxZjgzbyttUjVvWGo0?=
 =?utf-8?B?K2l2QWM2OU1tSThKNTNoTnU3dnFWQ0dTWGRva2pjSHJzRUFjUUlUUGVtMFZV?=
 =?utf-8?B?Sk9md2JkNkkwdElJOGhjemUvN0pFcXd3NEpBUml4a0QxaUpCK2V1NUMzNWMz?=
 =?utf-8?B?aHV2NHlOSER6aFE3SWdmRGcyb0FKR09FN09MdG8zeWpnanNzQWJJVHRvZ0Rm?=
 =?utf-8?B?d29LWmxrUkp5ZGxMTWNaNGduVzcvTlJ6Ri9TWlJGTXJlZzFMVUl1SUZQc09o?=
 =?utf-8?B?djRSTHFlaHZpbzVLN3MvYVdMRHZBVFdKRlhkU0xEWWdpbjF4QjVDVnUrc1Vy?=
 =?utf-8?B?SjFTdFFxWWk2SWpmMmVNMGZxU1FKZzlhNW1ydCtKYm93L3pKKzc0RmtHakY4?=
 =?utf-8?B?VVZPOXRXdDgzU1cwdDNnU2w3Rko1V2Q1ZXRNWlJXcjQ1QVFMcDZsTi9oQmdX?=
 =?utf-8?B?UVZtYzJmOTIrM3ZtUm1WQlZkMkEzYjNWbHdDZnIrVG83R3F3bmd5c280NU9O?=
 =?utf-8?B?UzJBOHhUMWVuUmZEbG1xclFvSWhwR3F1N09IT0szZjArWHFlNEJKZmVjL1lk?=
 =?utf-8?B?UG55SkVCcmJVUFR1eS8xTytJYWxybFV2THRSNzljMEJzK1pJZHFndjVQQzJB?=
 =?utf-8?B?VWRNRmMzTzBHOWNUY3ZOeXp2M3M4YXIzRDZPdmpnMGxGY2RPazVlcktVNWFo?=
 =?utf-8?B?a0ZsUEcyRVllN2FwTnFXS0VFUjgzTlhvamFPQ28wam9TWXRUdkg5UGRRcXRI?=
 =?utf-8?B?QTd6MEc4WHJTTm5mWlZmZWl6dHJBOVZCOUlGWHNIeXNNZ2JYMlhySWxZS2VR?=
 =?utf-8?B?Si9DVVZIYS95Nnd0bXYxbitZVXlEQnlmWVAvbVF0SFJBd2tKUGxZTURSek9l?=
 =?utf-8?B?dThNWGorWW1Ndyt0bi9MOU1ZUm1kWkRpemg4c0pvem5HbmdoaWtBUURYSGdh?=
 =?utf-8?B?WUdEbElBbUdwakJCUjFOazQwRDZ5bDNsa1ZMcDZrUTEzTnpFQ056Zk1HZXRF?=
 =?utf-8?B?YUNoUU5GVm4xcTIxeWpoVWZ1MkFIUUFCaEtRU1Y4MlpYdjNqeURiZXlhTHQ3?=
 =?utf-8?B?UEs3YTFKSTV0bnk5VVVabDcvNVVFanc3WUJwTUgva0Z1d0J2T003RjNSWG1Y?=
 =?utf-8?B?VkU3V0swcVEzYjBycHZTRzd6U2Y1VDBwWnpvd2h6YWZHRFV2QmZrR1MyNkNO?=
 =?utf-8?B?NHB1c2J3bzhGUW03UlVIMkZSS3VONjlySE9UZ3hXWFdKaGY2MzV2UzlNdE5R?=
 =?utf-8?B?eGxXTG5UZ2tsM3NhZTJ2TWl2ZXFZS2dxRVg1VjZORVBPbWRSZE55eEFSMmZ4?=
 =?utf-8?B?MTZMZ05GRmNwemZ6VWovSmRuV2RCa1FtZFZKOWZCVGgwanFNV1FXVXZ2S3Vk?=
 =?utf-8?B?Qmx2VXJOQ1ExQVFwT0VBdzZKVmxBQ1ZjV1NEaWxiTCt0NUhhUG9RS0t4RjFq?=
 =?utf-8?B?WnZwVWpRbndYN0dKSWUxTWJNNUpzalJxOUErOU5uRlYrYkhsUTllQlpLaHd6?=
 =?utf-8?Q?GScGWISn6uNb0fc10A9+OYU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c635c16-5011-44ec-edbe-08da9c89608a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 10:58:27.1610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2cIbycFnqMal3+kQO6nH0ydKS78zL2uTkXm2dBfJxWlmOWonpvXuYpH+Oo7m+6tjdE5AVzbBx4iKS86UMvWyAOowItGMAZmsLIpHf+KP2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6454
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-22 04:10, Peter Zijlstra wrote:
> On Wed, Sep 21, 2022 at 03:54:18PM -0400, Mathieu Desnoyers wrote:
[...]
>> Hi Peter,
>>
>> I'm having MTA issues at the moment. I will resend the series as soon as I
>> can get hold of my sysadmin.
> 
> It landed in my inbox and Lore seems to have received a copy too; as
> per:
> 
>    https://lkml.kernel.org/r/14ba275f-8ddc-33fc-2669-1c336436f473@efficios.com
> 
> So I'm thinking you did manage to send out mail and all is well.
> 
> I'll try and have a look later today.

AFAIU my ISP's MTA only sent the first 7 emails in the series, and the 
rest are nowhere to be seen.

I've hopefully managed to fix my issues now. Let me try to resend the 
whole series. (without RFC tag this time)

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
