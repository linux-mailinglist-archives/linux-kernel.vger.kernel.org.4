Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2C9738F95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjFUTDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjFUTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:03:43 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062.outbound.protection.outlook.com [40.107.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8E1BF7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhSLk4LekLsthUqFzoldZG3ECQ2gEs+nCnz2x/5yp55j4sYVR673ngASjQAFOLuTrHnSmRr6PQ3KBhWW7I5NR6v0stfh2Zw/jCDjBzDYBU4gcCuVEGhLCaXpgcW3rV/kRfz4CtMHiUL1KfPCDp95m4xhCXeQzMzVx7gNy6NL/iOK76XvmNctUzkI3VgvdJbCFHXvcdFJSGlu+5SUqSt3ZhjKoDKmGHYoeiEUHPzyknH3ECbWsL3/3bp4JHlPCSX22Nsaw8OxiPwXiWeBEvOyVxoGmI3xrm7vskfRxvMCldOPRqIRwmE19EfGox1gNJb8BkxTCHw0nh6efktYZRn/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFunS5JDV82xeVwdZZECfrK9v0my08J/SZj+lIGeXDQ=;
 b=HFvpN/SfT1nZS/qecY0j5z2ol3aLluaOy+TZjkH9JeO/J3HzuMp5/QdDrpirU7wXjnyeLYxaLYsKSHfBGVfnQf2zXTYZhYV8UtRravwuismf1K3YGtqh+FG0Jyux3InEL9mB4WeNSdrYko999Drp7GgmEN93e5gYS43QbYb2nlnOWXOIpNDwQJ95mUh3WPfq40uQRCPP/8U02lFqQKcUNKlsDiY9OxVLVY1zdXiM7KnrW4Y4DMEAHIt60QhDxQ8O719y1/Rs89mR8jH6C6fcyYcFXDMbuS7tRZmmbUKZYH4/bTyYCKO3TtMB1H7dvr2QWRd4mFanyz5CvHDsLArSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFunS5JDV82xeVwdZZECfrK9v0my08J/SZj+lIGeXDQ=;
 b=Ucnb+paEWoGWW6opwplfZkLyqi6IPa9VQ3Rl7EkMXLxUhyzkO+ggtb1nCkmfqFxr0V5fpl1tHE4NbPlbLh4lJOf+PxJGRBZpzMWQO2ryYoTkhNQ0oA4XzjbZ+tq5hX6gU9Wd54l/XUikeZd/aOQQi1m1T4Z2eG1gy0T45nOe/qtGc6lHWlNy7/ShrR9D06fWA4q9SMC5l9AcBhSVv72TvACQqHjbAiMd6dJCCsrHrq2It397tUBYSU2ekO8aJpE+REruaslWHQcmSJC2oAMHWMdhOD9BLYjvJFpATNUZ6QKaXDP3UtvnP2FszMjOv/O2pzGy5LFyYk9kAe+cDSZ1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS4PR04MB9412.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 19:03:01 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 19:03:01 +0000
Message-ID: <84f28ab5-f812-71a0-14b8-8a2108d1f572@suse.com>
Date:   Wed, 21 Jun 2023 22:02:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/5] x86: Make IA32_EMULATION boot time configurable
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        jslaby@suse.cz
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-2-nik.borisov@suse.com>
 <20230621182710.GOZJNA/q4w1yniKeCr@fat_crate.local>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230621182710.GOZJNA/q4w1yniKeCr@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0174.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::22) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS4PR04MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 83efbe90-ae78-409e-fcd5-08db728a2239
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/qCDp5kMaVHM7ZuIBOG6U+n0cmYCx2TfreydGKMvseLVeHVTO7N9RFihFZWJ7vnFis9H7K+32DByc1cTu0ZM3Byuku5FlIaj2g9YOEenoFZBkFE9YYn7Ll2UXMWsfmZXspkYe//TIWePQEqjQirmH9+MOyC5eLXbDUisrifo7c7w5KS3Rg5vb8niWAbh6xhIlZHu+5gg5OEk4ZpLuTZvqCLDYuyrYfehn/c0pLopdaVfHVnG2G3QW90ygmOWEl+PLa0fK8i8oyBSSOrXvA8m1OqMlXHKvV91u8X/W3g8bMhE4zf/ImV+V17IaZxgCSUUrly+k4NdSlp+MKXHNlNShiJ4AuDMG/jnKmHMGiLpzFFuRr0biwMX3gj3weFtItu+teP4LIDRl6amqohjVa3ebiZCX5z/LV+Yn3GwgjIG9OcwjBzMmCUfj55qSEvGW15QxaX53L8ixujradk0dhLDCDEc58LyE9vmfYCj5cf2vjDHwpIJGWVu8j/o69zLqpmoMsph+Ird3q6lBP2binmI7uIbv7OAoXIMY64yiFRZ/CReoE0nePA3z8MsFvSyoS07uNCZNrnKECYzz0+NMNHbvQEiODiJb/SRptZFkTqXdCSXUhcW1f+lSgpa3q3LrUO3XkXGlrlieRTAJu3ftXqoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(38100700002)(31686004)(8936002)(5660300002)(8676002)(2906002)(41300700001)(316002)(66899021)(66556008)(66476007)(66946007)(4326008)(6916009)(6666004)(478600001)(2616005)(6506007)(6512007)(86362001)(31696002)(83380400001)(186003)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjZwcVJQbGhQeW5WVGcwK1JxZjVQaExEd05oUEVScHkxZmowcnBBWVNsNjZL?=
 =?utf-8?B?dWdOamxsM1ZwT1l3cEIwczBDaFBpRFMwcHVKdzRsZFJ1Z3dXTlZZMHRhSDIx?=
 =?utf-8?B?SjlzRS95MTVoem0wTjU4UzlhUnpEWFFTYkJUQTAzaHBVbU5wS2VuKzU3VGRC?=
 =?utf-8?B?QlFRL3lESWd5RmRMRjh1Z2FrN1lPTE5kY3dReVBvLytKTU91SDc2ZGRvVFVQ?=
 =?utf-8?B?NTlJdGdIOEUwSlNtV3lTVzZTcHVabU5mT1M5S0pyNElLQkdtdk5DNi9jTXBO?=
 =?utf-8?B?MTFJd242WE9ybkdVeWpER2piRWg2ajhSbXoweXM5RGdvcHl3OFdpYTVpVjc1?=
 =?utf-8?B?Q3BoZWx2SktxUjBZdUgrZlRwbXlYWG1qSFNwOWVBZ2NJc2lrRjEzVFFpYnFP?=
 =?utf-8?B?akhlaHRTbS96ZFpLVys1cEdSeHhyckk2bzJacmtNOE5GVnNMT2dUOUowbjNP?=
 =?utf-8?B?c0t1TnAzRzNRakQzQzhtUVBBb1NpVHpyeHlveURvSTBRUy9FK01Nd1hNMHBZ?=
 =?utf-8?B?dnpWRW1GNVNsN2IvLzVta3dBelJXR1Vva29lU1gxTVNvajA3dHBNUzF4V3l0?=
 =?utf-8?B?UGZqRGZodEVDc1RvNzJZN05aUkMvUDZDZXk4LzJObzBWL0NmMmtFdXBJaFFy?=
 =?utf-8?B?VEdYblBXREJTdkc4SDBHRXRDbXMybk0rZEhFY2dyVW52NDIvVUExaVp6WEV4?=
 =?utf-8?B?aXE4aVp4WjVuOHBPQllHR21welc1Nm9MdURGZzJaVlJ3MXZnbkdpMFB3bnlN?=
 =?utf-8?B?UE5iTjloalBva3dKd2FMNkZTTUpRclNXRU9RelN0YWozZU9iUm5qRTcwV1Q3?=
 =?utf-8?B?VmQxT1F3cjg4dTRMayt1OE9nTXBrcjU5NWNqZ1ZwUGIyOHJhancwTlpvRVJy?=
 =?utf-8?B?eXhnUG5tQkF6MllJdWxKTjBWN1d3VmhjNzd1R0NGODRQejRzZmZXWC9pVnlW?=
 =?utf-8?B?R1liUzk1bmdFMU0yOXo3T2hqT3dSRWttUnFQeHpPcHJaMndEMWhVbkdvZjJQ?=
 =?utf-8?B?MGd0bTNybEdCOGZxVjFMeW93cktSbGFjaGlTNi9SUTlFTGhJbi9EYlJFMlpU?=
 =?utf-8?B?UDVRTUFpWFpGdWZ3TFdxd3NQaFdieE5VVVZaQjZSQzdSejFRQUFWVWxKMVB5?=
 =?utf-8?B?Qnhza2RDbWMrRzFxclZvdWR2YUVqRTVFRXBDRnJIV216QXpQWFJnU2V6VjRm?=
 =?utf-8?B?N25xd2p6WUVKNm9EbWR0ZS94ZzdNMXg3ZzdRNkFLc0JCVldjYTJMYXkvSnVp?=
 =?utf-8?B?MXB4NkVvRzZXMHB5UVFncEpNWUd2YmlOakFMZGU5NHJrSXZXa0xMdGJRRHZj?=
 =?utf-8?B?Z3NOYkhTbjJxY2t4Tlp6U1ZuK3R3czNNR1lzTUJDZWVXOG44SU5sL29vL3JG?=
 =?utf-8?B?eHdUU29FSVduUldYWjgyTy9zUXd2eWZqbG1qMXlNTmtKblJxc2V0aWtYNE1w?=
 =?utf-8?B?NWhIZWZCYWtmSlBBVFVPRUxJd1FkSFE2Y3hOTzEweUR0Qjc1eEplVCtkczZz?=
 =?utf-8?B?Q2V0b3IrMGF2emwxL0VJRkVPSktjc0t3b1V0UEY5U2dhSzVzYlpxYkpmcTlE?=
 =?utf-8?B?S2doTDNnRG1MZm5RTTAvZGFXVkxtSm9rS1FwL0R2Z2kvUkxxUklVV1E0TDdC?=
 =?utf-8?B?NXZKM29MR3IxUUdGUU81YXNnTnhuSTcrSHBUWVpDL2Q4L3FMN0Rpc0RyM0hX?=
 =?utf-8?B?MFZZV2dZWjE3SCsyT3BETW5yNnA5MmtMMSt2ZW5qODVlUFJkcGpBUmMvSWtm?=
 =?utf-8?B?bGsySzVEZFd5eCtub05jTmp6dUdZR3h2NGJrblNVNTdrME5SeGQ4TUhwZXB1?=
 =?utf-8?B?M2ZmTG5ZQXJwWXZmWDFVVnIzcncwVEgyT2pIYnQwejQyeElacGRrZFVtWnlC?=
 =?utf-8?B?a1U4Zk92ZHBFMW55eFRvUjhoVkluYXQ5NkUxZnBybExjWkNxdUE1UU9JcUQ1?=
 =?utf-8?B?a1VkOWpQd1pvVHZzSTNwVFNTc0pCTzZQVVZkdnNaU0EvNm42L1NZWm52NThL?=
 =?utf-8?B?eEIyd2ptendUQ1N6Z2FsYlZjVEg2RFJOTWhxK0dZK0Eyb3Jhcjh5dTBTbmpv?=
 =?utf-8?B?aGZvaHpJTmJ4WEk1VnpQZlViMmZtb1FzbkZDdUNkWFUyY3cwQ0hBYjc5WjUr?=
 =?utf-8?B?WEhhcldMbU5sNG9ta1IyRE5uVmJlQWFWMnlQR3MzeWZHcStNNE9WU2JQZnhD?=
 =?utf-8?Q?msXM2aDycDtBBDwJxFjDZwQwinEroBR3uOdrFqC2GWz6?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83efbe90-ae78-409e-fcd5-08db728a2239
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:03:00.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pl8xDu5dWN6iRniUct2wQNCxyHzOUeypElvfQOxnrUf6HJCvdGLnRkrIWFr4ugskgQmXiNF1+FoloS2K+LR8sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9412
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.06.23 г. 21:27 ч., Borislav Petkov wrote:
> On Fri, Jun 16, 2023 at 03:57:26PM +0300, Nikolay Borisov wrote:
>> Distributions would like to reduce their attack surface as much as
>> possible but at the same time they'd want to retain flexibility to cater
>> to a variety of legacy software. One such avenue where a balance has to
>> be struck is in supporting 32bit syscalls/processes on 64bit kernels. Ideally
>> it should be possible for the distribution to set their own policy and
>> give users the ability to override those policies as appropriate.
>>
>> In order to support this usecase, introduce
>> CONFIG_IA32_EMULATION_DEFAULT_DISABLED compile time option, which
>> controls whether 32bit processes/syscalls should be allowed or not. This
>> allows distributions to set their preferred default behavior in their
>> kernel configs.
>>
>> On the other hand, in order to allow users to override the distro's
>> policy, introduce the 'ia32_mode' parameter which allows overriding
>> CONFIG_IA32_EMULATION_DEFAULT_DISABLED state at boot time.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt |  5 +++++
>>   arch/x86/Kconfig                                |  9 +++++++++
>>   arch/x86/entry/common.c                         | 16 ++++++++++++++++
>>   arch/x86/include/asm/ia32.h                     | 16 +++++++++++++++-
>>   4 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9e5bab29685f..59b1e86ecd9d 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1865,6 +1865,11 @@
>>   			 0 -- machine default
>>   			 1 -- force brightness inversion
>>   
>> +	ia32_mode=		[X86-64]
>> +			Format: ia32_mode=disabled, ia32_mode=enabled
> 
> ia32_mode=(on|off)

In the next version I called this ia32_emulation=on|off seems more 
descriptive.
> 
> is less typing. Especially if you're standing somewhere in a server room
> and trying to type on some weird keyboard which always has the wrong
> layout.
> 
> :-)
> 
>> +			Allows overriding the compile-time state of
>> +			IA32_EMULATION_DEFAULT_DISABLED at boot time
> 
> Just say what "=on" and "=off" does here - loading of 32-bit programs
> and 32-bit syscalls is enabled/disabled.

ack
> 
