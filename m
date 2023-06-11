Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F30E72B0C8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 10:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjFKIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFKIT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 04:19:27 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D5EC4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 01:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvD/hd7z6i3APJ1441LlNQti7vmLC2OyPXVvssqFXjJG0g2UOk1UFmIPWUbA1raP2JKprmURwmimky+z0booZb3QrRiHKh4qLIk1PSa3gqeu3t34mBvMAjRSghk1Z0YZkL3q7JvjoCqemC1DI+gIarDVP+bj/LuUukXS/LUekMDExL0jMi3hmj8HGgNp/wm3xJ0cBlZnwRJyvJqVN4mEhmZEjNcy8M7HB8FAZsjnEXN8mcrjMhhk2qRBd7AuJsozCgx/6FItcQ5OfIio67mN3d/is8Ed5sH4LdXfKaQ0pFMwwkaeo7Zs2PetHK5ykm5Pk/u3/jUKrv3P87ni9X5upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNVnwfija7Qab7gwfiqST9bQHur/OwOUq88Ww0+QYkM=;
 b=ifuoFntv2Heq3JtkvAq2MMHHNucYdNmSUecJXLoglGm7JpGl9tGZkJ8cQTLW6Nyw1+qG1MsOOtB8OjkAPBShHzoayhioE0JTmxB/IamI5tVx648qJ//NhUJ+LotPHFPa/ZtTFajOCaun1XBOWKEW61jNBd7vvbe9LA8t1yCvLM8qMPbZwFTw+bDl9eALHpGSvVv3EZw7fEn+UISiND65qRYTOOMbgd1HTqXnYtgKfYC/jZtGmcRtA/StEqjSce4eLRTaH/1qoYosJtpZY0ZqWrVRCx40PT46U0c6oflUOOfs0Rnqed7phr7N36F3fE8iqmZ/Lr8dXsAF60JTY11PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNVnwfija7Qab7gwfiqST9bQHur/OwOUq88Ww0+QYkM=;
 b=MiMtwcWH/O4/HNAeald5KOyQZ8zGVGd5oBZL6Kb4LWczqEBynTZimuqfM3A9rlOu3zHcMNlhgBGJ3Ny9qka776EJ0MQ9F3OvOafaICb7IK6lr956FfI/WifCfggfV32xjz+bjqEcwbhrC7FLUEKFGPO+FB1tPDRZqTMOPxCBvMtbDFSdybp7FA+NdANk9aJFYGDB1CRazxPsQBHtbUGCwFzRzvHqIMCdawtaPQUciiOjrpOCRX3tcUo4PhJF7PlSWmUiNQJpeZIErgHbj4fNdp/AiABdB9eGD6x9+6LS5wl7ZCZIwSPBA92ptDhBCkTcKxQi5o33dJuMZYp3jJslcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DBAPR04MB7382.eurprd04.prod.outlook.com (2603:10a6:10:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Sun, 11 Jun
 2023 08:19:23 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6477.028; Sun, 11 Jun 2023
 08:19:22 +0000
Message-ID: <95a3bf1b-96cf-5341-e3e1-828fd4210ce1@suse.com>
Date:   Sun, 11 Jun 2023 11:19:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] Make IA32_EMULATION boot time overridable
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>
References: <20230609111311.4110901-1-nik.borisov@suse.com>
 <930ebd9ac94843129781ec208a0dd69f@AcuMS.aculab.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <930ebd9ac94843129781ec208a0dd69f@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0159.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::16) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DBAPR04MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a58d51-5947-4384-b0f7-08db6a548f9a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXuP0Ubx4cUxcYsWF8uRWHduqJvbQ6Odf9yJOEm4g/nEINpCJnICc9QNb8icbvePJVIfEr/L2QucNE4sKpNgIqXXaSNf9EyT/qI+yZ0D47awAPqlkf2HKckKbO9s//MqzQvlm3H04+FGkODFbrR2zCRMwE2ZFqBq17xSlEuivWykLE/VexyNQ44509/C9myfXqUsJQladGQlrTffge1g9I9cCcIBNXwbNW9Gt5rcJQEa9ghz5W5ozYwPsKRfWSH5tv9h5MiEmomO/1RZJVzl1Jx+8HS/7IbfMjXtXslp+AKqgoUBsq/6ozvFWy4lI545+cwiY58GmqMvh6kT/B+wSTUj1teMfWiQp6o+oudA4ZZn1/8TwasBwlQ1IwYxqSG3dPPVGogAqIfXGj7x//cE0i/JHWnJVPQbKoVFwrca3sB1lTlMJZGJERzpE+fAN2nOV3mUtqO22vqMP2TGlq2ij+DrwL8GjC459NDkeRqg5TSUM9W/lRaAeEtfZTbSXpi1Hoo/I8FuYvTpJ6WC8b2VeCbyUTyvCB9UefxsfRBZ4QSgHT1FsGHntBLr/afmrSzAEpAW12eWXrO3aH7xYr07gamZDgHDcXPAJkrB6XJHIraqDDg/Im3kJpd+UPKtoXIowxn2P03g/HMpzb4tB3Qy6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(376002)(346002)(396003)(136003)(366004)(451199021)(6486002)(6666004)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(6506007)(6512007)(186003)(2906002)(54906003)(110136005)(4326008)(316002)(66476007)(66556008)(66946007)(31686004)(41300700001)(5660300002)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkNMZHRlVWdXTzhITlRIemRtU3JrWDNzSTJCMlBlQU9EYzM2Y2NRVmNla3B4?=
 =?utf-8?B?U2RTYU4rUXcvSWhKQkdqS1MwZ1d5dHpNdzhRd2tnTWhVYW5meWxrUGVxYkYv?=
 =?utf-8?B?SXFJTFVDUFhOQ0piMVdBY3FOYVFjTXcyQ0dHQ050dExCeUgraEVEVXh2NGRv?=
 =?utf-8?B?YlVjNzNjR2JGQlBKMXZzOEFZNXMzWWhXKy9PYTN4TE82QmFwQytWTGVYME1i?=
 =?utf-8?B?ZTZSNEZudk01S3Bmdk5EMzExZjUyKzA4TktGOTcvOFZyOUdGUlliS0lxNFV1?=
 =?utf-8?B?U1ByK3liTFdMZjlUc0w1bi84MG92Nm5NUWZSdEt4OWRBRmVnOEFzektjTEgy?=
 =?utf-8?B?d3c5eWZac0p6cWN0Rk5UM29VeWFraWEzOVdTSENDK2djMEFaVm82UHJKS3NO?=
 =?utf-8?B?THM5bzVxMUp5Ry9LR3FTY0pZOWY4RFlKTW1sbktQU0sxZ01sWlYxcDdja1kw?=
 =?utf-8?B?YVpXd015VTVkRkxMT0lxb3Jpam9sRnZoVThFamFMVTQ0Um5vT0k0ZGZJSEsy?=
 =?utf-8?B?SWFjSnJNVjRmSitqN2xacUxnTkN6Yk5RcHhTSGJuRCs0L05pRlltdWlSV0FH?=
 =?utf-8?B?bVUxem9mU25NaXh0V2hIaWwrRnRvVVF2dHYzVS9INW5OSXFlOUVlcDRiT1hO?=
 =?utf-8?B?TzhpUXlKc2YyeXliMXNQMlRPaElZbjJMZWZHV2NMNkpoUk14KytpeExFRmpT?=
 =?utf-8?B?Y1Uwc3o2QWdIbnphU3F5ZzgrMFRzYnFvOEpBOTI0L1R4K29wMVE4Sm1Xbm51?=
 =?utf-8?B?Z3ZBa0UzdVcrWXZzb09takoxejhNNDY4d2lmVEplUUV1SmtBUlBjVDZSZ3lj?=
 =?utf-8?B?TnJoOXhHTGZmQ0JiMCtxZjVUalJNemM4VDF5MG1mRlRGMWhGWk1ZbThNTmsx?=
 =?utf-8?B?dm1SVTJZTk40WGVGRTAwWnNuZlVUeDV1RHlBMHdjTVBoTld2c2FZNG5UdHV1?=
 =?utf-8?B?d2xpM2MwOFJzRVNLTjNMdzRuOTNrLzMwUzNicmJ6SXhTVnBORHF0TlcrMElJ?=
 =?utf-8?B?Qk5FV2ZINVlWV0hJTkUxaHNxT082NmNDQTFjWnVZeVdoNk4yNDErUHBaeG4z?=
 =?utf-8?B?UGFRbi94WThsSzU2WFVjUkhHSmcwYk5XZDQxdXl2QzlHT2kzaHlBclRNZVZj?=
 =?utf-8?B?YVdtYWlnMXBjUi84QzZmQklHVnhkMEN4NmZ2QmQvUzRtTHR3VXc5QTcyRFND?=
 =?utf-8?B?QmpSbll3SHRGWVRkR0JaRE5NWGJVV29zMUJaRS9ETlRyNVZsdnZtVGZmYVg0?=
 =?utf-8?B?S1RFbUJURW5MMGhtUzdNeWR3aDRxaWJONldYQytxZXVhNG4vb1BLKzAwSi9U?=
 =?utf-8?B?RmJXTG5uZ1lER21FNFdQY0hheHdmR1hPK3daZ1NpZTlaa1RGMlMybzFHSHIw?=
 =?utf-8?B?VGI4MzYvWCt1dERZUDJSWGZRdkNscUlna3V4a0pEREQvWHRMRFZFVmJHMkZV?=
 =?utf-8?B?WHkxbk1uWDh4S2xLeGZibUh4amVnUTJianJFSVdob2NYU2tmQWI1aFhYZDNw?=
 =?utf-8?B?RUdjSSsyQ243QUUzVU9IdzU1UlVPUWlnRWxRRjIyNWVRZ2FDMVNxYzVjQnd3?=
 =?utf-8?B?dGlFdTZtQlo2aE4waVVBVmM0b29IQXRrcTVrcEN2c1llUG9nTW4za1NSVDBh?=
 =?utf-8?B?cjZaYTFYejlJcThRUXJaREIxR1pvWmpmSHhjWEtzS0cyVi9sK0lMUWZLY0tV?=
 =?utf-8?B?SCtGTHdySW5zSThnMzQ2U3M0NmViYTZ4eE1Yak1uMzRYcnJ2TzdFMXFzci96?=
 =?utf-8?B?aE9oSHJCMDBtT0JsUmtsSExlcitmK0pHVUlraXBqNjJsa1RMZUphTXd5Q3I2?=
 =?utf-8?B?U1lycEhwL1ZGK1BpaGtqM1VKZzlPVTRLMUFPVWRmNkV0NEpvTWhXSkVndDFT?=
 =?utf-8?B?UmdYdkcrVWdiSE1lTUV2U2xoOFc4bU5Gc3VUQjdnUkdISEhzYnVRSFZjcVdE?=
 =?utf-8?B?T3RzSGV5aGlCUnhmaWhNb3I4VkR3c2VjWVNlTDBsT2tERVExZmx5dzV0WHdY?=
 =?utf-8?B?Z1o5d2k0Wk5IdTZlUHF4azg0bmlveGUyK2tNMTJyVlU2WThvSW82V1FrZ3pZ?=
 =?utf-8?B?a2R1WG05WnFvbnIwZFUxamhRbTU4OUVyRWMyNm1HaGkySzFVbnpYRUY4THVH?=
 =?utf-8?B?S1VCZzAwMmI3TGNDSU1IZnJaUXhPODR4OEhnUEFNaVVSa0xyazZ5SkZFVnpM?=
 =?utf-8?Q?jxtSprPqi0RQtuNunSutkBRo0YASfOp8hLvhShSXviJO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a58d51-5947-4384-b0f7-08db6a548f9a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2023 08:19:22.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lw9Aa72K59sSKbOKQQtiSqOQo037p3DMHOVFXJw0UGafx3rRQ+szJRQKMsdQo93IM3057x+c+12ZDEFeNbYGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7382
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.06.23 г. 0:46 ч., David Laight wrote:
> From: Nikolay Borisov
>> Sent: 09 June 2023 12:13
>>
>> Here's the 2nd version of the patch which aims to make IA32_EMULATION essentially
>> a boot time option. The changes in this posting are:
> 
> Does it make any sense to be able to enable/disable it at run-time
> (through a sysctl).

I'd say now, because then we are losing consistency, that is if the 
sysctl is off, then some 32bit process is being run, then you flip it 
back to on and suddenly this process dies (if it's using syscalls that is).

With a boot time switch we'll ensure that no 32bit process can be 
loaded, which at least can give the sysadmin some assurance that the 
machine is 32bit clean. Am I missing something?

> Perhaps only if enabled at boot - where it can be a 'soft disable'
> even though the cpu is initialised to allow the 32bit system calls.
> 
> Remember, if you are root (and the system isn't hard locked down)

Well, if you are root then every bet's off?

> it is pretty easy to change a global boolean variable.
> So it doesn't really affect the attack surface.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
