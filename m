Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA085B99F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIOLnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiIOLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:41:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130085.outbound.protection.outlook.com [40.107.13.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC26A4CA0F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls2qn0BPueF1GQ3UoDnD1o6Y97R06CYERPGYlY/38Nw5isIH+1EFpnmJMuOxhuo8WTaR2msF7vF2Vmv1DmvEV7WyCXCkS3vW6q7jgHERBiwNltn4cf9zPDaKJKxhHN9ofj04ZBx51l5PUkhjCQvDOO3ASlsSEwnJIMdHmW9rZGylCwayfdEAjFpobvNRfEvJkEcV2xxb37bRtO8COQOHhvtcDDZ2X2IceQdC0U+AeDQ448WXuYlcf0gcGiNBz6hMZ/rpl6iVVp3zlU4i9WbyLMMuyA7FWQ7NR+zWcS3a7tyyG/xVjm9+q0DuF7SW4JewtQswxiPBbynkZEjwMqFwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEDtPBLyxRAzwvS4ZpZPQXdOoxrxvOZJYF4RBHGODMw=;
 b=NiIUKVvF48i2ltEQAWm7SVuue4goOFY6ZKF4qCzwKLBK9puxyIEedTV1Tqd5BRP6k+tr3O5epvRbPjWuwaXsh7Kh87j16B22Bi6bU8R4CuHmYnWMlbGHIXst3a85oWMQwPS48wmuN8xs+apKin7x+xsyT4VmM+3rAcCIhrxl7ZszD/BD3gvHoTrxYOWtGeCLJMCloupugFHpnjrmjZTk50YKD9id2fzKSP/yeFwnQZVUNYhdGjmaMGq+AntgJkt09zmXP81QWSr314Mgy71w0QlcB+DtnTB/vk4uB5fAwoJ9yVJAIwcdPWi6hCMkmC3uMGw7Q8bfT6byy0Mei7YwbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEDtPBLyxRAzwvS4ZpZPQXdOoxrxvOZJYF4RBHGODMw=;
 b=e7rwbaq9ses9dkwhMkJZ6+8UIN3REaL3XFPf9W/JvyHunoWxzgxQf525Hr0XyM6LB92LVzffRcERCEqlKsl8LCK4Sf+BEE8rT9C0AaOis5MsE/L0x9yUEY3CGne9B8dhCMEZ53A3L/42F6T8sEvn7KbdBhqj4fh8nolT0Dl55XSUKfOYBuKqvIfFTfK/hzc1gLZMq0BS6+WFUQq6CkUGmpB/FEHyeIOCtPfBixeTG1KeAqEGMgGueIy5DQvJp1IO8OO53QPA35r1fVZX0RnGA6FbjvS4cWSxvK09QVlwAsgdJ1oSLRT5If70nMR9ZG1WG5aa1CV9SqTLRbUR03XuhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com (2603:10a6:803:122::25)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 11:40:17 +0000
Received: from VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4]) by VE1PR04MB6560.eurprd04.prod.outlook.com
 ([fe80::59bc:901a:98a7:76d4%5]) with mapi id 15.20.5632.015; Thu, 15 Sep 2022
 11:40:16 +0000
Message-ID: <b5c83169-0b92-1ebe-ae5f-fc7bd4e19b99@suse.com>
Date:   Thu, 15 Sep 2022 13:40:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] xen/privcmd: remove privcmd_ioctl_mmap()
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20220915083944.10097-1-jgross@suse.com>
 <8137166b-a4c2-aa26-84f9-7b9b2a7e028e@suse.com>
 <4a95c3d1-d4e8-9b59-8db8-231b59cdb8f5@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <4a95c3d1-d4e8-9b59-8db8-231b59cdb8f5@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To VE1PR04MB6560.eurprd04.prod.outlook.com
 (2603:10a6:803:122::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6560:EE_|VE1PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: d837bdb9-ad4e-4751-da6a-08da970f0f6e
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8xmNVQvUPBgmZAlIkFaYFPasm+6Xg8GsRaW5Fn8y+eWDUGA2vRen1trS1QjIsThrB5H/c/4Ri20ZvTlc1Z7JbVDyr7JgbtzH0ZYuK01ZPAXx2HJ9vLIHqWZcV+N0F+AeKou7l6TeTif4VIAASS/o7OByrPgbPggNecGUtVcDDxOSUV14M4lD1mRDXeoZ/lBJrzjQ43SbZF0nqhm7L82hDcLRd6LKvTNQ4VzpgUGP0aYh12NuWdObk6Te2bje45orsDJqUJh/xl0dGJ8fryfuteqCAmgOabExwe/a6kV3I1hGzg8wUig8/YO1YRkqbVWGFeClhSFuzU45egCX8MAqS7Vu9p7+uvPlPXU1bHzPiy5WFG5T4ZR/Ihc+PcjkUY2ydKNouDUUd+KjjEcSiunN2xS51Ya5QIXY5b1QsYzgswK3TqQ5kPHtXj4O4Dupuy+Z761MMy2DR71wt5Oexwz204wa0td5M1H93bD2EwiMJ1H4T5QRJuhsOQFQysxjQj00RTj8m8xVZl+jL702bWv/YsyEVotzpf6LmxF8EUj9f+E+aBC8j4cMVZbsfYdQpl3hdPTYqV1xbXzSr1suMqf/reKxlHb4EjUvSYCfja3wveiC+4LEQNhSTZbIpLTYJR96U/kOkxcQRvyjf/MvdlX9yr4ZterfZol9DvjXNW2sTEqI9GK43rA9RkkW3s27KoCzh8AcnBKU8TcJdPoqFbCWGBP7MhrumRfG2ZCR4t1ag0hjgYh/z/ROuONODTCwLhxMzGuHAMp10d+X47otbwUsR9KODc/M7Jq2RTf+SV3bc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6560.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(31686004)(36756003)(31696002)(38100700002)(86362001)(2906002)(4326008)(186003)(8676002)(478600001)(6486002)(4744005)(8936002)(53546011)(66556008)(66946007)(66476007)(6862004)(5660300002)(2616005)(41300700001)(6506007)(316002)(26005)(6512007)(6636002)(37006003)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnAyUFZQZURmZTh5RDJCbGVmK3l4YzFUVzdLQU1TSzB2UlVFRmZvTTRBbmox?=
 =?utf-8?B?N2NmaXhjb1JNRzdyeFZEWmVKdlNLZjBYRlYzditwY3VjWGZQeldUU3Z1cktL?=
 =?utf-8?B?cVhTRjRhWTMrLy82dmRLTW4wcjZUWkdKMm5PcXVNeGRzMDJKTmwxVlVSbG1E?=
 =?utf-8?B?SHU5ZktFWTQ3QmJrb3BHR29FaE0wcndIR2VGUzRsUGNsbHgvQ2RxaHkwdk81?=
 =?utf-8?B?M3VsTFZJL3RwV1VTSUxNbHNyWm45MkRicUdQYU1VbkU3Z0Rvcm1iSTlqUGFo?=
 =?utf-8?B?ZWFDL3RSeG5wUDFQZFZHU3NVRnJGRHhlV09HeGJ1VDlKT0MwRUZJY2FPZ1Nz?=
 =?utf-8?B?Vm4zY0duZUlKOFhBMkl5T1NDRmtlUENsZXZqT3QxL1VxalRJTDVjQWhlVHZW?=
 =?utf-8?B?bzQrRnRNNXk5QzA5WHlKSDB2RW1MUlRnaXNsdmJ2R1FxL1hTcFc0SzFXcFdL?=
 =?utf-8?B?bEFMT1NqNTY0MlJtQ2JoTXpuYmVYdzVvWmlxRm5pdy9MS0tpN3dodWdPMVlN?=
 =?utf-8?B?Z3c4UDI0WndYbmdmUzhCUW15K3JFVUVSVEZ1Q3d1MldBZnBpL0VaZVoya1Yv?=
 =?utf-8?B?c2Vxclg5bUo0WWE1TWpycGJucjhSSE8ycE10MUdSVDhnS0lQcTdsc3NCTjR1?=
 =?utf-8?B?YlJjTmdCZ3hweDd2RkZoZVBUL255L1oyODVjQ3ZtcFNWTWtEbU8xRkVHZTY4?=
 =?utf-8?B?QTZXQXJVQXFva3NFZ0JHMDEyS2ZFNkVRRys5dlAxSWg3SW9NV0dmL3BzL3Y4?=
 =?utf-8?B?Qk5rUDFYV0R0aUtrcGE5NGJYUlEwNUVURm15RktYMjlQL2RjbjRJQUpzNk9j?=
 =?utf-8?B?Rm92SDltV2JwaWxXL0NBclZNR0tXVmlnVkRHVlg1T3Y2cTVocHlDNFB2N1pW?=
 =?utf-8?B?cmxZVHpkOU1JTEhpUXFiRVh3UGdJWkdQcksvUWxpOFNjWW95aU1wWDNQSnpy?=
 =?utf-8?B?U2orc2R1Ny90bHFITStMaUpkOWl0MWhkS0pVbVhHdElMRjFrRU1peHNSUndl?=
 =?utf-8?B?QTJKV05oVHArNyt1UGR4ZFNzNVljRm9jbVNoWC95NTh2ajVIN0V5Mis5ZTk2?=
 =?utf-8?B?cjdHQXRsdUNSUDVPOWpJSFZJb2xCaWcrc1UwK1NtQTZVV2I1dmFic1BrL1dm?=
 =?utf-8?B?LzJxRnJQWjR2SCtLQ2lieDR2MWJKRnVJNW9lN0FzbUxQaWluWURmMGdDWmRk?=
 =?utf-8?B?cUxWdFhSTERLdGg0Z29iRHRSQ296QU1rNjUyZVBscU0rTnVnOHY5VDdER2ZB?=
 =?utf-8?B?VTJodVR0d3lZcVM0anlCZi9Gc0tBOTdzYlZ3b3JFQ2xuSk5UdFd4VVpJZUh6?=
 =?utf-8?B?aVdDV0RESWZPaXBxaHQ0NFJtblZ5UjE4dTRtb21KVjFtR2ZLL3FScTdndmpU?=
 =?utf-8?B?WHlhVEVtd0src09Pc0U2NzZOZkc3ajJVd2R4NEFjUUl1TWxEZEk3cUh3NDFy?=
 =?utf-8?B?UlNqSE1IVWx1eGxrOGRzSUVUQis3WUxEVnNSYVVGdy9NUWJOUEVXcW5FZVFB?=
 =?utf-8?B?YXBYLy9hS1kxMEJ5eWZNdERtd1pNUW04bkNWVmtYOHNxdTMyeGNTOUdIeFh6?=
 =?utf-8?B?cUlZWm1uZmFZN05lUTZBVlVvRDUzd3Q2aklTa0xDaWdtaEdyS1hKYndIZkRY?=
 =?utf-8?B?MXQ2d1hHVFdHMUlJRGo4M0M4cHpvV0hySWRxYUtPUklCaGREdTlRa3RCeUJY?=
 =?utf-8?B?dVkzSHZZbHBSVitkM1VYdC8wMDZXMWQ1bUFWUXNhcTNzZWhvUmtHcFBzcXJY?=
 =?utf-8?B?cFNDTExkZ0NRK2pJbWlYbjJLazZqYVp4cHZXK1I3THB2U1NNOHlBUjdzRnpE?=
 =?utf-8?B?L1NmSVZ4bUk4YWxOS21oSzZNc2Z4NEhjaVZWT2JYWHRvNW9SbG1oK0JsK25T?=
 =?utf-8?B?djZTT3ZvWXVLNFhtdVFvYVVMTDR1N3JEWkpoaS9wdUhuc0U4WnIxcEtKcVNl?=
 =?utf-8?B?OTl2WC9odUs0aVhNR25tVHdlMm5zUlRMdXhVU1FVemRoMWtGQ1FJbzlvTU5i?=
 =?utf-8?B?UTZTdmdzL2phcWovRGhzeTYybHJzdU1VOW5pb3hhRGpya2w1K1F6b2lWVnJa?=
 =?utf-8?B?WW9TSWVkemFtMElDYjZjY1l6blgreVE3UEFQSEJuc2FlVW5JUmFjUXllRkR6?=
 =?utf-8?Q?wtKUJC374seM8+MuTwrgw0WZJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d837bdb9-ad4e-4751-da6a-08da970f0f6e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6560.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:40:16.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXP2p3n6ND3Zygb8WhVB3r3bTuEQ3tR0S570EA0jglFDrDHTSXVC2gYg7A+l0qyDXoGQVJDgVwS+8KFPARuOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.09.2022 12:20, Juergen Gross wrote:
> On 15.09.22 11:32, Jan Beulich wrote:
>> On 15.09.2022 10:39, Juergen Gross wrote:
>>> The IOCTL_PRIVCMD_MMAP isn't in use by Xen since at least Xen 4.0.
>>>
>>> Remove it from the privcmd driver.
>>>
>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>
>> Can we reasonably remove an IOCTL, without being entirely certain that
>> no users exist outside of xen.git?
> 
> This is a valid question. I'm not sure how probable it is that such a user
> is existing. Are there any Xen tool stacks not using the Xen libraries?
> 
> If so, why? Do we want to support those use cases?

I'm afraid I have no answers to these questions, and hence would generally
want to be conservative with removal of functionality.

Jan

>> Even if so, shouldn't there be a
>> staged deprecation process?
> 
> Depends on the answer to above questions.
> 
> 
> Juergen

