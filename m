Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7D70C152
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjEVOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjEVOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:42:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E7CCA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/B5cP9QC3aE0XvAKtJv26ixgFcRZpkHDrmtns7EnnmqA6XQHhErmSDKioJW64KiUILhlObl6oLIVPMAipsDkG7GWzkrP5nnJd01QuWUhUNAQQvCXanTOpmWvjGzXnoKNG43lvjU8PS5FDhABqKqo2yKvJbJGCBsj/NdYmDtbM74/Grln5fljGhwjTteJm/OM8dB6wvygwOfF0IxJRKUZJWnv9GG/+u8W8ocs3D8FYexEWacL612btGDvG17D6nFD+48RwN9EukSoR1jfv6JMRrdm5FJA1q7h7iTWbByrvkr9DBt4faIyShERXK0AsCGLN15L8fCPfXz1gONGY904w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbkMYlUBuHLcyPvnL8zL5Dpmc0IxEUq+p6HAOTi8IGo=;
 b=O7ztXaSvxmJP1PnubGB4WeQ88fsa5qJyzXXkj5frTUvIqpjMUJNB9kIY+C+6OD83xFHwASpzujna0xLCaTO+KU8PxwimShWs5WQUt2PZYSUaAmHfd2Kao0f1hHNfPM+XkKMRNBHLWAqClfhWqRR7JaSbCk1VxWKBTTRlmdg9a5rJL5njMTYvM5IfE/r0YpyoADDMHAc9sXUggzNwO3UVPGco+YUBHuDFXOf6skmMUdgGO6FbzUiRYuqT5wkoc7QrWz02iDt9s+Aaje9TBZ0CaT0DVgoPVnV+u4lGW/EdrPwrj46udzw/vxYGr1WBfyIpqbr8JoukwfPokV1c+HJj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbkMYlUBuHLcyPvnL8zL5Dpmc0IxEUq+p6HAOTi8IGo=;
 b=WUyJFE5DPnPL4tlg7O+Iu4xCR4aSz8pI/AEV0hca2RD22rdSSlLpEMYX2ErQG17o2Y6kMW5Kf+UJ9JVwaAHmk4y0kA1wP9gN9w9H0mFO+RnWlJ3FtKV3xuwpqOzgRMXXoFjhvTFW6xaQyBqusW8MU3U4nySE280uPjJpg7f8Fq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 14:41:53 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::e78e:b7da:7b9a:a578%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 14:41:53 +0000
Message-ID: <0fa18795-f621-7511-8297-37f3c9bfb433@amd.com>
Date:   Mon, 22 May 2023 16:41:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Remove Hyun and Anurag from maintainer list
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org
References: <18700dda117076510baf87a090acbb29cb3ba3ba.1684244832.git.michal.simek@amd.com>
 <20230516144516.GC30231@pendragon.ideasonboard.com>
 <c2ca465c-6fa1-7852-26f0-6489fde52226@amd.com>
 <20230516162033.GD30231@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230516162033.GD30231@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: f85129d3-5685-446b-1c62-08db5ad2af3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maWbE9HydAmSY9n2UiFyo9NkLVwcB3xx/AQNF+3tONtElxYqmytjIwJV1ZuZHuc7seIO2XIeLr/80h0bxYI0Gp+irQpuqHFM7b/uHVQIJksEsBXNvyIdgHASGwgDTl3VLo2FseJBsK1XoaLltzGBmjaS5L8cedk3mm+nVxkqDWGzbVy854LA09HiWMc1z9O3iTTxEBD9uQUPMiVUyT567Zf3bOmQPTaRYQJV4/BHlPty2kw4OPYrCTrpmHAez7nhlDRhDm45Oksv728YJPwW/HqE/I4bIX10zo6bA+k3lnXXfp6bHC5PLYfEo8Fyl26k3A9xhXlo5sTwQAqkdv3hLMZXH/olikLJxjexbIImspJSmTBtZrA8WMVruY1erRtmEQDDQYuqxUiIznOs4PEO7VokYECso/lgMWUmSeInBUsOerRkzEufHRqvRhuuWiQxVAfsWMbuwrvuRVC2KOKKwYH6HcSY7aXuosNLv2ClOxLEcbksPrxPhtqTAXLOQWnKY15XIqJIyzU0vdvt5h8e8DgVNYjY2De4KVpnS0EK70/+Y6x3PoEP83TkKXyXwg2RQEYgi7fZxhe/0Hz09NdfOBGA1s3gINA9HtpWXFNcOFZaeMjzvR0uhJd28k6AfOrYEFrOWeNHcNxYBQKPRvw/lA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(8676002)(8936002)(5660300002)(44832011)(186003)(53546011)(26005)(6512007)(6506007)(83380400001)(86362001)(2616005)(31696002)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6916009)(36756003)(4326008)(478600001)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZ5WEx2QklQY0pwMmd3TWMyaFdsRUd0NjVWU3Z0UHVvN0RqVFZQdzZvVlhm?=
 =?utf-8?B?TEFzeFRZSkcyMFU4Y2gxU0VmR1RaL2JXOUdQbHRjR2lHYWRtQlFjOTMrdTAx?=
 =?utf-8?B?aDUzRitTOXFPcExiWU9UUHRRWnRGNmR4MVpGemFDWUU1eU1xUFpZMUpzMitq?=
 =?utf-8?B?aGMrWG5FZWtJajR3ZC8rYkVpSkVHTGJyYlhHTytRNEVVRjV5OUVFRTJoQXA0?=
 =?utf-8?B?TUNCdkRCa29VVzdlZHlDRW90cWpERXd1VW5xL1Vvd1A3RU1DMnJSWHRQOXZC?=
 =?utf-8?B?a2hDMWI3V0FsZFMxSEFERjNWd1lLYnd0a2dScDA3aDZYMWpMUlMvcGxEaTRi?=
 =?utf-8?B?MFppckVrVVY2WHhhZmNSMGUwUDZySlA3WC9obXY5UWhGby9XTk11OWQrTjlw?=
 =?utf-8?B?L2JIbkE1SWMxTkpESXNqdDEzdnhmSCt0OTcvNStqdVY1VExiTHJLQTVUSXFX?=
 =?utf-8?B?cjRsWDZrR3RiM1VpVVVsTDVuWjB1WU5BZTJ2SlpCOEVWc29vTmYzNnM3QytG?=
 =?utf-8?B?ZWJERGxaMUNLc1NubzFEQlpia2dJbEJ4N2k0SDBmb01TV3gyODB2bzJtZGk1?=
 =?utf-8?B?SlNwa1lEUHpKMlpiV0xaZ1psWXlJNjJSOG1rWUhCQ2FZMitHN0RBUTJlblVm?=
 =?utf-8?B?am4waDh5aDdhWGZIYi83MlpmN2VWZTBsWUdkR0VPL0p4d0dQTUlhajYxUDgz?=
 =?utf-8?B?MXFMRnNDeC9ScTVMTS9xOVZaZWNJVUZPbXB4YmdqbFlVbzNPWnM3SHAvRG5P?=
 =?utf-8?B?ZGo4RkpPTlpyazJ1eDJ2U0VZOHBrakg2Yk1TK1lwMVcvNWk1RWdIUlBOem91?=
 =?utf-8?B?OUExMGpJeCtLanVSNCsvQUgxM3k0SHFIQmh0bzdqVGY4Y3lZL2ZrT2NkMC9W?=
 =?utf-8?B?Q2RPdVNlRjJzMGN1amUzSmJILzE2UDNabzRqSXZvUkVMWW5oY08yTmViNDdJ?=
 =?utf-8?B?dGxSKzZFMExMcnlhSlgvMVF4NWFLdFA5ZENocjFlQjJPaFJtU1BHQ3ByUVBO?=
 =?utf-8?B?L0x1REFFOXNDanQ5RGdra2FXUXRwVzBmMjBhdTc4UWpDdkZBaFd1UjM5RGxp?=
 =?utf-8?B?WUNjOTNsay9ZZDQvZzUxb2tKMzhSai9ZL05CUmtNSnlYRUdpSnM0NEhuZ2FT?=
 =?utf-8?B?QUpBanZZdlNMUnBjRDlTTXE5YmM0cWtPUXZ0bHJDQjJJN0pZUlVjZ3J0d2ll?=
 =?utf-8?B?dVdwc3ZSK0dqOXJMOVFHMWovbHNYN3VjQzBxWFBRNEcxQ0YxQ3JUb1N6YnRq?=
 =?utf-8?B?SEJxZGVocEFkd3dyTFpwZlEzK015Z29WNU43OEVIT0tmMUsxYmVkNE5FK3VR?=
 =?utf-8?B?a1VXRUFaZ2pZNGlHdHpSb2RocU9Mb0VkTDJ3ZDkxbTdqVXlXdTQzL0RuVFlt?=
 =?utf-8?B?ZWxCNGJ1ejBFS1VuRDYwNUNCOXlpS3UvbGk4TzJqUHF4bElsU3BnVGY4MEEw?=
 =?utf-8?B?VjA2Q2hURlFZaUNaUUdLZkRTelhjSUNUOTJUUXppbVNQR3QxWnM2S05sRnRt?=
 =?utf-8?B?MnhKNXFybzNuSkh1Y0d1dXUvaEpCZkFBVzhkYkQwTCt1TjdLQXhnREZ2RzFZ?=
 =?utf-8?B?QTFCcFFReVJ0RTBEMGM2Y09ObkREZk1jUmZpSmVFaFJkNFJLWmQ5dVhweGp3?=
 =?utf-8?B?MVpIQm8xRXQ1VjNPK3pianlKVUwrSklKOGw0dGlXanQ2cUxlQ3NUWEc4TmRQ?=
 =?utf-8?B?SnYrZlRpTVBpWlRnWFhYcFdFUlBFN2hLeEFaVVc5Uk85NjBoYldVRlVteWlU?=
 =?utf-8?B?dUd4clVnaEN1Z1lZWWo4em9jOXVKbEFhVjBhMlFjME9vc3RLTHdpZEhvanhC?=
 =?utf-8?B?c1BCcmsrQTVOSUNVaDUycDBydnVURlFEeWh2cGhReVduS1BER2N0MVRUOC9u?=
 =?utf-8?B?N3F0RlJPK1NQSDJoRUVPc21oaFRxVnM5cTd5WlN3TisvbWUvemNERkwrWUg1?=
 =?utf-8?B?RG11VisxVHE3TFgrTndMM2lwMlBmdHNFY25WN3pxQSthSWlTYjdraHFKWkM0?=
 =?utf-8?B?ejJrQjVkVHU3cEplM09mbkRJcHQ4ZzRmbEVsTU5Jbmc3UFFzSkxLMkZSbi9R?=
 =?utf-8?B?RGNlejk1M1UrRkg3S1FjbTRva1hlTXdjZENCWnhVWWMvWmNqVTYxQ1VWQitY?=
 =?utf-8?Q?9cuV+HOFWV8cATxGO9QqdIXPo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85129d3-5685-446b-1c62-08db5ad2af3b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 14:41:53.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw1HG+T78UX8OV6pr+KY+LO8FVhUDFFh46q2baNEzzBcppFpYCYchO6h481puz/K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/16/23 18:20, Laurent Pinchart wrote:
> Hi Michal,
> 
> On Tue, May 16, 2023 at 05:07:04PM +0200, Michal Simek wrote:
>> On 5/16/23 16:45, Laurent Pinchart wrote:
>>> On Tue, May 16, 2023 at 03:47:15PM +0200, Michal Simek wrote:
>>>> There is no activity from them for these drivers. All of them have Laurent
>>>> as active maintainer and their emails no longer works that's why remove
>>>> them from the list.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>
>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>
>>> Will you merge this yourself ?
>>
>> That wasn't my intention. Feel free to take it via your tree.
> 
> The commit touch four different subsystems. If you can merge it through
> your tree it could go as-is, if I have to include it in pull requests it
> may need to be split.
> 

ok. Will take it via my tree.

Applied.
M
