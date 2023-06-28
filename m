Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD17374118C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjF1Mod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 08:44:33 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:46670
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231979AbjF1Mm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 08:42:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrTMRak5F4UCKAj9PxoC5OljXShT9Z1uLCjAwY002PqFJF0OK9jQoGpDTCqiOWRPjd0QvJEiF1lZyhc4yDZUMpAWHgFfnpcfXHx1ZQrrNH+b+TcrWLSLnCjSGufGJRMdWFQ5iD/nJmmwH0Z/FxTPKYiRxgI2s0VRqtV5dD/CXmmBrOjTqSNdeF8P/sM72wYYQvorZhP2ry3qHTHz+1QGBSFzvWzgoZAvu3HToVjWJ+GOXl0xdBHvOn1X9pRe84MxVq4uHSTrSzJGUzFLk0QZp/aOpH9nIvggN7QSZJQ43iI7QSV1ZUrKVUmeY8s+z2gfvzPdDe3z5u54KmaV+vexew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZcEbM8CrpdeKFYdtJWVPG/DDu2l2hqE1AkKxlneMAY=;
 b=aIgqdiHNa62VR/atmeCfVxAUeF8Y0g0Pn/RqyRQefbC9/qTbcShmJGBIppkzeoxneADJCnuVaxb/gLQSPxOYHfl3qJQrV/0LfdxvLZ1ZAYqf4OPX1dp9IVu4ZwTjM8Bwa8K6chCnUFH5BEQEumT5XJLxF4UPgUTsh/0dhSLAxpyVZo1YXLQwjny/jZosixujSMI9P2eaSKYmEXXxlfRyeLNnBD2YasGXBevrVlyvNCi/S4b1IrFxtCudo09aaANv9f0HsDHMTuz9gSSnj36mPrVa0R6020G5kGiwEdyOrNaX+qtTW8N4dV53Y5V+esDY0j7n5D4xdcN8lyhaXijIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZcEbM8CrpdeKFYdtJWVPG/DDu2l2hqE1AkKxlneMAY=;
 b=GSXg+UnQKiltktDVAhuB5ZlXagGCjWT8dHcz3jE8W8BJr3RAz6mMr5OV+su634RfrKecvOtUL1LKcHwMk+qerWNC6eI2uUpHAiZe3LNVyLSdspdc3Eq63P9uaRxZTDUXXuUHHAa7IeIsN881SamvfxqSFZkazepACIAAkaAH8se3SyyKhzQiqc+pqmYJ/6x7nrXay03y3poThITqAp7YA1SnP4hN5Tg5oGE55eWm4OX5EV7p8sBKR4RZbgOkwnAKS9+Dzmimd7hYfDngjUaSYn3PqIj4j+YBOJS3tgZKmBtUL/LfMf+y24WpPLs+LH49j8usMuBXfk/Lthu8VssC3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SN7PR12MB6672.namprd12.prod.outlook.com (2603:10b6:806:26c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Wed, 28 Jun 2023 12:42:54 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 12:42:54 +0000
Message-ID: <b3908ce2-43e1-b56d-5d1d-48a932a2a016@nvidia.com>
Date:   Wed, 28 Jun 2023 15:42:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     David Ahern <dsahern@kernel.org>,
        Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        aleksander.lobakin@intel.com, lixiaoyan@google.com,
        lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SN7PR12MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 005381e5-02e4-4151-5f38-08db77d53155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jBlOCkSECMMuVnQetUzRbsQC6C4dejBo/FxvmyUkIAUM8QnGkiMw/ULMWb+kqEiH01ILyZdLsD+OrpZ8dSZcMlz1DKaXjNIsY3rw+TBhJp6udLcgfyL7SjDPsOFneKhYTMmn/tjcTRQ3NFtvqp2KA7Tj/6AFAnlqNNdn3H+0kX9wDqpS8EZYJMKMNo1jM+zcZFBTVUyZB2zb1zc3m797iCJcF1LldgT/7ValuRI8IBmu1lOS65YAjr9/TQKUeMqmYS/JNVEKy7r6Cdr8eorW7X2OSZMl3oU6F8lc6b7loRYsNmvY6PUhbu2mLYvuWUwKFU7tUKMHpDtoCjrbf9YCujxe7jRC+Xd23SSNQ2O659U11eK2VCL7kC9+kxsLADZX+2kt42IKwrgKLAFhfFiywsoDUDPphEYnKRNV3mVEa+bXEF40Kke7C4J6DZR+wq5VgeE8sX51Cx8QDMWeq609jx7ZwgUsVn3Dt/QbQjEaGaBO8PvwBdZEoXReb9cS5htH3bWDNDeqto5DuIyzRpwNDb/pfrkSyQ1hRHed2l2ocAJWcg04VVfG49/B2ZLd0t2q0U62/2TenOB95vMpOgoz/4dj+gUUsE6LW9U6GeG6bNIwpj+5QBt1fHlEFUOA5ESO0FDvhYMWGsYZncbUlcXQZ53TFRLXPUkOJtf3Gfp0ftE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(31686004)(6512007)(66556008)(66476007)(921005)(5660300002)(7416002)(86362001)(41300700001)(8936002)(316002)(36756003)(66946007)(38100700002)(8676002)(31696002)(478600001)(6506007)(4744005)(2906002)(186003)(2616005)(26005)(6666004)(53546011)(6486002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlg5NXVLM0srOTRwZHlRRk9ZL3FjU1JyM09FZzlUUjNuM3h4N1pMN2FJVDly?=
 =?utf-8?B?QXJKMEp4NTRYdmtnZlJNS1N3QjZtMFNISk1XL1JaOXdHeUZBZXZKR2VIVHN4?=
 =?utf-8?B?Sk9vNVBMUlhqMjRDOHl3ZmV2Qk5FKzVoLzFSRk1oYTJwOFY1bWZTYVJGMFpC?=
 =?utf-8?B?V3l1VnE2aDVFNUNsSDEzN1E2QmRoaU40NDhmZ0lFVWl1eHp1eDVqS1R1eC9V?=
 =?utf-8?B?MVFyQ0hsL0k3aFU2d0M5UzF6c2VHdmRRU1d6L3htRUhKTkFzbTVGNm5KaGJV?=
 =?utf-8?B?aGFQdDRyQ21ySEJzRzNPbWV6dFBnKzJ1T3RTeHBkN3Vqa0sxeXZreEFPczlP?=
 =?utf-8?B?d1k0RTIvb3k0UHhCZGUxNXdvYzlUbGZCMU5jbnBhZTRva3dGQS81YzJTZUsx?=
 =?utf-8?B?emsrMWY2VERjUDNHcUdUNHNrM0wrYlZWQ1BxNWx6ZjM4UjA1ZXh6Q0llNUIz?=
 =?utf-8?B?bHdrWjdyb1lHcGxic09UWmxDdGFzbFQ5WHpPbVc4K215V2ZZWXFFajY0b0ZG?=
 =?utf-8?B?OVArWmFiZTZFSGEzQVQxbTgwQjdRZEhYSWZjYXhzd1R2cXc2MnlDbVo1MHlP?=
 =?utf-8?B?NjVGWk9qcEZMN2lhdU1tQWMwLzFKNmt0VE05NlFhNE5YSnR0TWlwT3hCUno1?=
 =?utf-8?B?YlR6RjNGMVRDY0FHYkp5ZjNvcVdRbmlJbE9tUjR5YTZxcUp4ZSs2VUE1eTV4?=
 =?utf-8?B?OGJCdHFJN2w1dElJOEEyQjNjQTBzNFRNdTNtNjZXTDZESjVsVnFNUmNsRkxY?=
 =?utf-8?B?NXdFejJKMUk0VXp5SFEyeU1pTHpORUsyMkRpRDI5NWpSblViUnBRNFVPT2Jl?=
 =?utf-8?B?QVNkTU9OeCt6WUdHYkkxK2d0Q1Eyb2VrWENITStjOUJNbld0Ym1VbWJ1N1dS?=
 =?utf-8?B?NXArNkovRkFxNjgvZnpzb3dkdUhsbjhhVjhkWkxWN1RNL3loVDJuRnpoVEZn?=
 =?utf-8?B?TVlyUy8xdkJMaEQ5Q2VlM0lxdmVlR1ZSTmcrTGRLNnFETUpwWDJ2UTh2VUdY?=
 =?utf-8?B?Sm55Z2RKVGt6Rkp1bCtsN3JCaERXSmJCNE9qM2Y2UE41Z2JYT0FaUEp5aTZE?=
 =?utf-8?B?Q2ZwYjhPSzVVREVZZXpkMGRJWjY3Yzc4SVZkcDJIemVhOHpzZGJ2WjJvVTli?=
 =?utf-8?B?SUZWWFJyb3RhOWppRWhiN25hMUxWckdpdkszY28wUXYrckVOTHhtQ1k2SHFl?=
 =?utf-8?B?VGEySXE4NlliOWNLYjgvOVF4R2RSS0gxbmpuVzlicEtQWWtFbHVUL3g5Y2Vt?=
 =?utf-8?B?dW1nUVdRUzhNSnhxQU9jL1pia0Y2MlZuSlpkdGNJVFFzTVNFUDJTUms3ODkr?=
 =?utf-8?B?WkhMNGI4WG9uSEU0eHI1ZmtQRHR4V2ZkTGlTVmVPMFVsblJvQ3FqQmdqYXpa?=
 =?utf-8?B?QzE0eFpYbmxKU2xyOUxvUjV2M1UyaDRlZ0NpQXBZbXFCanRucXVXeUo5QVZG?=
 =?utf-8?B?Y3M1S0FzOS9DQ2hjYldQV0RNS051N1RpQUNhb095OXlrMlMyUVJKRFhZWjdR?=
 =?utf-8?B?TGhBV2ZLSjZtZi9zK3pEU3pYbVVMb3BjRE96eFFUTjcvVUY1RUNLak83TXRo?=
 =?utf-8?B?bHdHTGxlTmVMbFd2NzhjUXl4eEVPaVZDR083aC9Rd0NXcDFCT2VGQzlXSVFN?=
 =?utf-8?B?a3pramZ3SGRYVllGek1TZVN2MzZJZFVxM1dLcGgrYnAwNkpPTit3OFMrZFhI?=
 =?utf-8?B?dENzVThybEt6QnMyNXpzS2RtWHp5aU10bW1zdnd5VHZZTGphdXZiTFVENFBJ?=
 =?utf-8?B?c0JoVG1DcHo1RGtTVUFmQ1hNdyszeWpkK2toalc4N3hORlJuMHZ5bHZleDlJ?=
 =?utf-8?B?eHhpTUYxQnVxbDZvSXNEUzF2WlVlYjlreEZxWTQzWXR3RExzUkJOSFlLM1NJ?=
 =?utf-8?B?KzZpeWFhS3lTY2hjVUhqam1pQStrZ3pJRDZSYXdWclh3dW1oaU5qZktmK0h4?=
 =?utf-8?B?S29RM1I2ajg4Z2JBRTd5QXpEWWsxb2lyK0tXRzQ3TUIybU9ra3I1bWV0ZElW?=
 =?utf-8?B?QmpxanFrclFxNHFkLytVeUdOVGRIWGs4YkNDclloMjNXMUN5anF2TS9lZW9w?=
 =?utf-8?B?L0Z0T2U5dElhK3ZtUW1vWmxHbWNTdGRuK0xzQ3g3cVFkMGFUUklWUW9wdnEv?=
 =?utf-8?Q?VINHNfjdi57ycuxIQDswtYm8U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005381e5-02e4-4151-5f38-08db77d53155
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 12:42:54.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGeztZxP+qCbfGh/9q09yL3U8N0R5LbNHFCwHBDwqZ93/ZOo9hTg+/NpZn6t40+C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 17:21, David Ahern wrote:
> On 6/26/23 2:55 AM, Gal Pressman wrote:
>> I believe this commit broke gro over udp tunnels.
>> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
>> is pretty much zero.
>>
> 
> Could you add a test script to tools/testing/selftests/net? It will help
> catch future regressions.
> 

I'm checking internally, someone from the team might be able to work on
this, though I'm not sure that a test that verifies bandwidth makes much
sense as a selftest.

Richard, did you get a chance to look at this issue? Maybe we should
revert this patch until it is properly fixed?
