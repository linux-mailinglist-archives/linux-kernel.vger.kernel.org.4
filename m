Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4E7087E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjERShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjERShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:37:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE621B8;
        Thu, 18 May 2023 11:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JM4RtECG+Kv/JigB8oB5qbKf8Ct69Zs0R2SS4qi6d8XRVWj5ev4sywlSlNXSy2xIyT0k7kAbVD5ZLJvBwFrccO5t0fDAaZScyivHVeLxcDnZ6WXfxPQJiD279SDCj+mIaWkbMXhnWHkES99ww1nIbg6QSJGNg4jzmMp1/a605aiTKuM3QMSpdRBGk1cU9eh6PX4hqGskPSGkfjBFVl9o3Dnu3G9FD/Whsc7l2sItRj/sboQi8XGZtPQ5KLZWEKxPF6+IS685QhCgpNoMrGyYT63f4C/rKZnNbt1PojxyqzaaR8ZkEUjJGSzOt6sd/vOg6bolhwLna5iSpCHIxBeYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feTUEp8wP/YBAc3M+QxtV4TehTbQzZizd1izVOlhxF8=;
 b=MUoPk3Fss61a5HmX2FKqlzWYRBm5kTmSJI2O9S+mrV8e8N7UYXtbQPSOKdsvxlHa14Ar12NMuBkM5XpeFUiriQESqq//1A3GWwQ+F9Nrz3btR0UWIfyKw3OW4V8LZj7vhDdolKSO3UlxjnAhS5TDrE1ooSsamIzhHBxBtliR+65Z6QMqAY2FuMv5N2ndfVS/WeB7QVpeeCpuPLM+qBpbbjHw/auEVTUhLzy0HmctVrq005lPMFOgaB1ihaoBATGHSTOHyBN/+D2AQWo/Yi2AP1MGfj3jLowd+HkZ2mldHH7uE0MYrrUrY7gqL76Uhis1tS9vQjvfuxiP24o9sEZFsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feTUEp8wP/YBAc3M+QxtV4TehTbQzZizd1izVOlhxF8=;
 b=raxJB+0KhGYj71CZNp/CESzQf8k15EeIHLGOULhu6ZOJ4LhRQtWDPIEXoQgfNl3VhmPQ/+AFu5/nX/NFY7gUDOYaKgn3P7otMi3I8GAmXYlhpoDUBSjWtO1RA0vkPgaGxSUW3XWLfBFssy67oPELmOHcxlrnGOUyKN7Y8FBggNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 18:37:35 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8018:78f7:1b08:7a54]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8018:78f7:1b08:7a54%2]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 18:37:35 +0000
Message-ID: <0b358a84-511f-f607-336d-9d5b49068972@amd.com>
Date:   Thu, 18 May 2023 19:37:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: Need suggestions for smp related properties in cpus.yaml to
 support smpboot for cortex-r52 based platform
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        konrad.dybcio@linaro.org, andersson@kernel.org,
        mazziesaccount@gmail.com, conor.dooley@microchip.com, j@jannau.net,
        mailingradian@gmail.com, me@iskren.info, lpieralisi@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, Julien Grall <julien@xen.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Michal Orzel <michal.orzel@amd.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <c5ed90c7-7126-0757-a0e3-e3d1fcab2ecc@amd.com>
 <20230515100810.ctebdbqlienbcf7t@bogus>
From:   Ayan Kumar Halder <ayankuma@amd.com>
In-Reply-To: <20230515100810.ctebdbqlienbcf7t@bogus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0408.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::17) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2621:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b8a866a-6bfe-4aed-c946-08db57cef29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tp+iGecedQSgIW8GO/8tMQ6cjE1rTQEwL+Z//EDeNTPvtPUEO5xC28Vd2evdmHdJl+qYRdIcSfttU1pnufPvx9zczuWXwk59sUfsp7fIQwZHwkrTEhJrxNrHhboTy1YRJEsb6bAkC2cwd9sUfHMrCZ9dHHOwBx5Ts6NoOoZ4A11YVrc8FGlpIBq8k/2koo2bzQIZc72PKAbBIy53XvFZPk2cMT1Pt3cYnRQw+y8uD9lRxluFTIH7Pvcx5CHY40T1U3iWNV5s3mZmKP+G3dPs1e2OaQO5JkfjnSez1jE2hhTpwTEziiEov3rlJkJTbjQX4+id1/uthjIr+sXlzVoxzzKvdy1VfvvwnTKBzRDHtnhMe3RcMOj9mM6+FgeWKuNXMelrH/1dnAeB75R9GiiWmQqqHvMiDxmeazIZK7hx888XMWd8WZ046mGdcumnYCc47xT+0Q/+gs926uWkv0nZW9efNrNrTvVltF9UWKUTZ/uHKe6Spy+4jm+hiTKcs0/DUdklAV5ufr7tt/MkaqKzhl32ovWvLzPJ3u4xat58Rx6hsRLKwFoPPouI6THYS5vL+FrGrRk5B0tgaQiPF8j0fNO/98MNLcBEXtAF7aDzugL8a2+5eVKvfNVuiU5BD6ERjgY5QyUzKHv846/zSrfm5Btju843n09dQYgEV5vDcGpOAxuOCQFhXyOnWKAvByF9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2621.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(31686004)(8676002)(2906002)(7416002)(8936002)(41300700001)(5660300002)(66946007)(66556008)(6916009)(66476007)(4326008)(54906003)(478600001)(6666004)(966005)(83380400001)(6486002)(36756003)(316002)(2616005)(26005)(186003)(6512007)(53546011)(6506007)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0JTYzZXWGZMWWR4TVE3aS9FcnNiYzJzUTNUOXpOTWVWMjEyNzV5bEZ1ZnRy?=
 =?utf-8?B?M0RGL3dwelJoK25GYmsrSkFWbWVDSmJxcVRCOUVyR09qejVRZTYwM2k0anBI?=
 =?utf-8?B?VmRNK2I4d0NpbGFvNVlCY2JnSDNpVFI0aEdOTzVNYllzLzJrdVdKOUpmZ0tV?=
 =?utf-8?B?Z09zaWxEK24rTDNLT09YcWFDdGt2V2FJbjA3RWkyNy9pcklNQkI4OWZlZ2Z1?=
 =?utf-8?B?T1pYMVFCdmQvMnREZm1qdWZRS0xyQjB3alFsNC95ZjlhMnZkcTQvS1BpUGw4?=
 =?utf-8?B?ZWQ2OXZidnd2RnRZLzJobDAxOUtLaWVBWnprVWxHR3QwRGw1cjFxTEdmQmRk?=
 =?utf-8?B?Mks1QTdYNDc2Q1lsZSt6TndyOHhGRmZMakFmNU9TTGl1R0JCdWpvSjJtNkJu?=
 =?utf-8?B?Zml2VmpxWEpVNHNRUkZCemZ0RHhwQkpnVStmWmFhWElSSWFoL0FYWWcyRUh1?=
 =?utf-8?B?ZGk2aE15aTMrWGIzelhrT2x5ai9ISjRTZUZ6SmZmdFJKRFk1dkROcjVsVzUv?=
 =?utf-8?B?dzBxQWphbXdQYjR3S2tUUjBxc1JiM1AwV2FWck13RCs3UzlzRGlPYTF3S2VB?=
 =?utf-8?B?cSs3cWdBSnl5YjBkRUdvOWhRNFY4SkhlS1BtS3kxd0VVTG5DNitHcHJBK21i?=
 =?utf-8?B?SVdrUy82SFhvSEU2Q2M1YVlzZWhsMXVBejVveEhjTFZPR09GcmZtRVM5TnJV?=
 =?utf-8?B?WHlzVmxEQWF6R080VUNzTHYwV0svbGxrUU43OUR3eitqelB3OGhzczRjSUdM?=
 =?utf-8?B?ZmVON1JUNjZXbG1odlZ3dmVyamJkUElGenE0Vk4yRjl1aUs1STUxL3RlOUJV?=
 =?utf-8?B?Unlpck1mZFFtc0paZ29QTlkxQkZDYUtOUHpQZjhNM2NsUVgySDU3TkVqKzEv?=
 =?utf-8?B?MFlCS2JGMkhjQTRkOUt6MkMyTkp3STRUVnRvcHdaSG9YYzRDNnlUTllTMHpZ?=
 =?utf-8?B?UHZZaUpwZFNZQmtqM3JvbzhMbFZtUmtEb294UWZSSGJtek4zWWc1SlZMcUJm?=
 =?utf-8?B?ajlqUytkL2lWMVB0L3dVYU5GREtPY2lnTkZpSlJlc2hJeXpJSmk3SXJXZ0RY?=
 =?utf-8?B?NWhTTTVEMnpBMlhML1IyRnU0NkJhOXpCclhQNWZWa3hkdmNHc3lXSnRaMjdH?=
 =?utf-8?B?S1RsR0phVnp3YWwwd3hRUnROWm5INitXRUZxZ0RJVWZXdTkxWjZhalN4RGRZ?=
 =?utf-8?B?UVdSZmJjd1FVTUlscFZiZzZETExuZmZCSXl1Rmh4aUJTWXRaMmZKZUZxS1pn?=
 =?utf-8?B?ckN0a2VZVWdYNEh3WGtrcklIbHFxYlppeHBKaG5oWnZzdWp0bHNFOFBCakFM?=
 =?utf-8?B?di9IWkdSMy8vbXh1QzM4aEVqYVNxWnFHZFJuUkVNOTV1R2xHdkE2c0hWWVlU?=
 =?utf-8?B?SDdNTFNCcjd1Nm1MVFRoZndMNWdZSXdYa2ZwQXErT010SGFVTUYxSlRRWmRq?=
 =?utf-8?B?bmordm84Mm5adU5hZzk5Nk82Nk9Uc0VWMlMvVFRFNWlZNjY1MmZHSTQyVU5F?=
 =?utf-8?B?S0hMU213UmhkMHVQTUlPRWh0ODVtbmxyY2NiZFJRVmtISXJDZ2FUOTNQZGg0?=
 =?utf-8?B?WEV2YUd5UUNsSFVEdCtseTVDYm1xY241UklBb04yZTBjQlN2UHBUaytlTFZo?=
 =?utf-8?B?ZVYrUkhoT0orZXgvMEpZTmc2ZndSVlFXbHNGS3E3ZTNLQjk1dXJzSnQ2cG1S?=
 =?utf-8?B?eVBtbm9SZXlXTkphZHNaU0piTmVNQVZPbnZDdEw3UmNsL3FPU1lIN2ZtWDl6?=
 =?utf-8?B?MzVaYmxGVVRJY3V0eTNrUzFPbU01SkgwYTlGWWlUZGpSN0FpMEViTTZmdFlD?=
 =?utf-8?B?aXlHK0diaUZONnRFaGpNK3JMUmpMTGd6L2pEMWI3REdUUVdFK0dJaXl3NXVj?=
 =?utf-8?B?UkZYa2FPTnk0TXFTcXlTNVFSVk1LSHphMkQ3VFViYXhKUktlRzJlY2Zydm8r?=
 =?utf-8?B?aFBPWHRwTUsvMW5ZQ2J4MmtzcjJYRnNNRk5Zb3NGOWRvamc1QVhkdFhtOENN?=
 =?utf-8?B?Y2Z6ZURqbzBEWDczMk9URzdUd0xib3BDUHhZby9uVFVFSmozOHhjYVk5TE1J?=
 =?utf-8?B?V0ZvelcvdlcveXc2dkN2cm9XaVViaHRQWkptODFlUC9rUUJaQTZlbzJTYXlr?=
 =?utf-8?Q?sSOHYEhTTGNEP7Yd7nmJfKdcg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8a866a-6bfe-4aed-c946-08db57cef29b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:37:35.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrOYJy8l73SEZzfI+j4qMNE32ENtcOjks4Fo4ezkgjWAhb9F8/d/XTr5Zf3yZahxW4Dg9FBgHChArXUH5QE5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 15/05/2023 11:08, Sudeep Holla wrote:
> On Thu, May 11, 2023 at 10:35:37AM +0100, Ayan Kumar Halder wrote:
>> Hi Device Tree engineers,
>>
>> Recently I have ported Xen on Cortex-R52 (AArch32-V8R processor) for our AMD
>> platform.
>>
> I remember that there was some exploration on feasibility of using PSCI
> here. What happened to that ? Any summary why that was dropped ?
We are discussing internally with other Xilinx/AMD engineers about this.
>
>> I was discussing with xen-devel community about how we can properly support
>> smpboot when I was suggested that this might be the correct forum for
>> discussion.
>>
>> Please refer
>> https://lists.xenproject.org/archives/html/xen-devel/2023-05/msg00224.html
>> and the follow-ups for context.
>>
>>
>> The way smpboot works on our platform is as follows:-
>>
>> 1. core0 writes to register (say regA) the address of the secondary core
>> initialization routine.
>>
>> 2. core0 writes to another register (say regB) the value "0x1" to put the
>> secondary core in reset mode.
>>
>> 3. core0 writes to regB the value "0x0" to pull the secondary core out of
>> reset mode.
>>
>> regA, regB will differ for core1, core2, core3 and so on.
>>
> Sounds OK but will you ever need to support power management on these cores ?
> If so, just start with PSCI or provide reasons as why it doesn't fit well
> before exploring and extending the existing spin table bindings.

Power management is not in scope.

About PSCI, we are discussing internally.

>
>> Currently, I am trying to bringup core1 only.
>>
>>
>> I am thinking to use "enable-method=spin-table" in the cpu node for core1.
>> So that I can use "cpu-release-address" for regA.
>>
>> For regB, I am thinking of introducing a new property "amd-cpu-reset-addr"
>> in the cpu node.
>>
>> Please let me know your thoughts on this approach. I am also open to any
>> alternative suggestions.
>>
>>
>> Also I see that in https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/devicetree/bindings/arm/cpus.yaml#L87
>> , "arm,cortex-r52" is missing.
>>
> Yes that should be fine IMO.
>
>> Can I submit a patch (a one line change) to add this ?
>>
> Of course, it makes it easy to accept or reject rather than this question
> hidden as part of other discussion.

I have submitted a patch for this.

https://archive.armlinux.org.uk/lurker/message/20230518.152730.c91cc994.en.html

- Ayan

>
> --
> Regards,
> Sudeep
