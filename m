Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E66744E24
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGBOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:41:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FCE5E;
        Sun,  2 Jul 2023 07:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7PCmIEi+G/o+JVwd6S0aPRMjM3vbsEC62GNv0oU3KM+Kn7VHBoVGdLfaxEbcdx+/vNKlzdYCpBNrqOgyRIUw6FbrMY7BTm6L6MhMQzfo8kVVA8mkdHbbX20ri7OHDNl/8BP/LDoLnAs66OSDM/NhxQZwjUdvZh1v4g8nIAeaMo2MWpYPTV7xBlEgMyeltqW9xeuiTeyIfJgVbZYE8RliGdz6EzIbIEjclq45+CMSslqneQwr4sUWDG6HslUEjzISPd7OL9lKS5x+8RydckxLZbodm0Huz8Zot1zzd+FuRlrusvCphDqTVl2MO11ExR2mGG4/0dznWxWV9hBVnQgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zptmom+ACg/jeOfEBezZojKQ23mypAcaYw0qk0uAO0k=;
 b=KrfDnhzm2hw4MFluSC/Xw2JWPu7mxMfICYSPaVm8btTmrksGf33nlwJ0a0uyzfjK6XmAUVGwLL3WT570ufpNibDEeVJUvHwGPrrs/H7tZoJ7FSClh6i+7ZiQJO6atQPFXuqLuCr1sSuCCrY+zUolJ/04/3VUM3mzNUDKl8zj+ITQVE8n9OuAfFPrRe8nBPtOHBPpsQPgjLf9lU/2BqDW9+TSeZkFh8/QKeDDiGb3bCOM02uBzRQBznQYbHDyzzbknrfk5gktyWE8Sv2nbAF5uP2lmgRkSE906+rUNQUGUuVKrQg8dk1TQI2m6b54RPjqP8+z3sJNBGaUQpTmpscYxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zptmom+ACg/jeOfEBezZojKQ23mypAcaYw0qk0uAO0k=;
 b=AIYpHJYoYJesUkGp4+PjhkEDzaiSiY+ksh6K9bXH91Iyz4BItDV9E/3xSya+E/bzr8evSkGgMPI4HhHJFIqdXa6DK3U1vJG5ZfOVXs7yBxRAt92jnwzTVExp+2CbeoXOQ5cgPcHvnoMVVmgcn8JVWU1W30yn1SoFQ+iXNpJRw5F2cEHIgwbwcRxrBunJct9Fq4WtZVCCRqgYb+/AZPNaDcReQmvdbzU6P6jXNE1yn+Mt296OwrLDO/bDtr52Di81KtWHnHUGAA+60TB3i6egNR2OgsG8FT3tiUrzRCh37HCXEk+m4hpRE6g54hasQ1yCltgyT8CQCbdGkILYT3AVOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 BL3PR12MB9050.namprd12.prod.outlook.com (2603:10b6:208:3b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sun, 2 Jul
 2023 14:41:36 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6544.024; Sun, 2 Jul 2023
 14:41:36 +0000
Message-ID: <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
Date:   Sun, 2 Jul 2023 17:41:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
To:     Richard Gobert <richardbgobert@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <20230629123559.GA12573@debian>
 <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
 <20230630153923.GA18237@debian>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230630153923.GA18237@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::20) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|BL3PR12MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c6ca67-2f43-4d2d-5dd6-08db7b0a6fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4O9O7q6G458VxkNvAzseNovdF5w1fu3TRgv/Z/lBsStF9OyKhOyeJ2d60y1LFiXjgCenm++TzQmMuLQBqcUyL4YQbPpQabJYXXLHsVZTFHHdpr0nrWzrN7CD3872OyUq7JZqyu2qTMxvqndcKvBFkcUIxxFbLAUq3cuGTEqnSG2+6MAT+ch6ryrO4xvLE5eTUbKXi9MYefykcWeCycBOeYBz4G4HcLZX6hPdJmRQnTSEDepj5rh+Xg6jvc9Lv8xeiqMCZfJtqB0Z5aSkfpeFTd4tyScfG55ErmcVXnGc2WJ7x131ciErX1M2XGAe+yLilF3GaNC7e3oph71JIu23xAjX4craARQt73zY4a7uHLtVkDaG5fi5ag6t2InlYjE9BoiFKOXPHb5n4P6QFJkD4bsMjUYdpKFNBROFxs9UQlEJxRHhSwPCVeER1/At3Vfj68pP3M6eRlRNB4yDplfV0DcPcQMbAY/lshLExcdArx5p+imGcj4uyUmyanbJJO2m5VibYVYnl+Jwn7y0zwpC6kJq3jGZCAkf8W7IJsr4XLu+gHNqGpTpFWV5838Ow4MrSi6OZG9m0FM0IYKQVKC2aUrEdcxYDXN2G6foHLS0yYfICQ5yLE5wQvhTKGxDAnsGmFGK2gjEAJHS/NFjDGPuDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(2906002)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(8676002)(8936002)(31686004)(31696002)(5660300002)(7416002)(36756003)(316002)(66556008)(66476007)(66946007)(38100700002)(6916009)(4326008)(53546011)(6506007)(2616005)(6512007)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGNEWGV3VWtMa1FOSUZPd1cvWEluYm1KZkFqTEJCeE45bWgyRkNIV2o3QTk1?=
 =?utf-8?B?SnF0U3AzZERqWkUrZWNzanNYMGJyQWtJcDRQVFYwUTEyamVIQWxiRmE5TTUw?=
 =?utf-8?B?K1R6SlhnOTNzR20wYlFsUUxJbEk5WlYzcXo3bHkrbWZHK1ArN3lLaXMxNHIy?=
 =?utf-8?B?QWtWUlBEUTJ2cVhLU3NsRzBXVFhxUFdudEFMMHdZRnpQbTF3RHlDdVorRkVw?=
 =?utf-8?B?TDI1S00vYUhMY3k1K0Y3R0RCUFFYM3pYZXk5MzVyVjdMWDNDRFVBcEN6MG9O?=
 =?utf-8?B?dXpnNTVsMlF6NlBaMFN6VWwxcGE4b0hEY2QydE5CcVV1WWI4NUtlZnZ0N3l3?=
 =?utf-8?B?VXdFTllRbHNLdEhjM3BEUnA3TVRGWU5yVHlJWlZMMnc5SXVaWVJObkJRR1VL?=
 =?utf-8?B?emZIdEo1NnovUXA3N3hxUVVoekh6eU4wUk9TZkVGOStBazJKbjZOTXNUblU1?=
 =?utf-8?B?amtnZzIxU3ZsanM5a1NPNW1OOVo0QjNkNHpNdmk1WHdWTk1rc0ZLMEhQanBq?=
 =?utf-8?B?VXlLN3ROMEs5TVkzejErWXg2OU1nSENObHNlVTBHcGtwU3g4UkVQQXV3K1lk?=
 =?utf-8?B?dEpOUTgrV0hCb2x0OHNoeCtEUzR0bnNaT0J5d29XN21ZcFl3ZFdvVEFCTzA5?=
 =?utf-8?B?ZEJQdTRJbkZKQ05kQWk4aTZkSTFLOUNCLzlMbkQ3Smg3R2xmTjJtcTJZQ3Jz?=
 =?utf-8?B?RlRzM1V5dnV2R3k0SkovbHNaRHBSQXNqQ0dJTWMrUFJ1c2tFMnVOUTRPZXNa?=
 =?utf-8?B?RmJQK1dSSWgzN3BHbFBkS2VDTjQ5d3lucFd5em5KWTJ6dzlFdGduRjFjZDNX?=
 =?utf-8?B?ZVE4amtFK3AvcXQ5cTVPRjlwVFJhaWNWdi8zd2tHRTVoUkxtSWRoRGRNQlcz?=
 =?utf-8?B?cW5LNEM4bzI4cG10QnBRaTNrNjEyYnpNdzQvMnhkNDVWV2RuR0I0eXp1am1t?=
 =?utf-8?B?RWErb3JUSmRVb1ZtbzY1U1NEd2NyaC9ORDc5Mml6RXllWkpLU3ZvV3NxYWNG?=
 =?utf-8?B?REYzNEI2UHVwMVJXeDQ1SE1iT0UydVZaUTk3dTZaRkd2dlU1SSs1WVpIdHJ0?=
 =?utf-8?B?TkFRMWlCRjF5TXFEdjBsZ2hOcDc2Ny9aMXY5MGZMa05PdkJiUXViNU9GMTIx?=
 =?utf-8?B?K1NNT29YM2VwajZYbmpZejlZb2dsL3VMWm1tVDJZN1ZoTWhBUTc1Yk14K2NP?=
 =?utf-8?B?SVNyS3hpL2ZlYXJtM3QwQ01UZGNTenpRWW1zeEJJTC9qd1BORXRYQ1pmekVl?=
 =?utf-8?B?M09iUlhiSEFkU1NrOFVzb1NWR25uVmVTLzVld2pQSE8vdWg4dU94TGRBdkx1?=
 =?utf-8?B?d1lOVnZ3ZzMxZ1ErV1pzaDZybmF6emVqUDJCN0R4eC91bWlMeVFZVjFWdWpi?=
 =?utf-8?B?NWxSQ3lIRmZKNWpleXpQTElvWVNPNFRzdDEvL1FNS0d0ZFcxbDBidS83TjR1?=
 =?utf-8?B?SmVNQThqYWlxN0dXcmppMkR3djg0dXRPdHZzbElsQXlGVzVUeTkzRW4vdjlG?=
 =?utf-8?B?dEZDWWYvV2doZVFGWFp2S0FHMXduREVGelMvcnhxQUZ0MlFkWGU0QlFYdXJE?=
 =?utf-8?B?eGE0Z2ZRbzZ0dGFnb3RxSWN5QjN5MWdrSVNaUW5kMXhGR0JVeUluQkJkVmFJ?=
 =?utf-8?B?TkJNZGpmVW1wRFFQQzNtaHEvWk1WNWwwS0xHVndFcUp5TnpCckNrYlNtOWZi?=
 =?utf-8?B?bHFNS2FDQUlENHIxODFpRUhneFp5TmdIVE8zTFlzN3FUbXBWdzkvdDhjTFlK?=
 =?utf-8?B?T2lkWXdYQjg0c2F4cEw1b0YyRVo3cHZVNGRBMHNiTXFOWUZIek5BZmxGbmhL?=
 =?utf-8?B?S20zcTV5SVZJZHEvZDdZQWVOYlJNN3BGSUpER3djMTBaeUtweTFUQkw1dU5l?=
 =?utf-8?B?eFViMFdsQlB3K0kzWVRuOVI1ZmRiUXYrWlVHZjlTZHBVSHNuVm0vNVBlQjU0?=
 =?utf-8?B?c2tkVVAvaG1JNnNDMWRpSVppdjY5TWVnVmN3RkNYSFozRE0rK1ovdlhrSzZG?=
 =?utf-8?B?K3MzUnJKK3FzaDhKRlJGNTlmR21QMC9PbGlxZVBpYVhpVU1lbnhPM2NOcE1I?=
 =?utf-8?B?VGZRR05tb2swbGhEQlBzUS9pTGszZEhtZ3JtVUl3UEJaSTd5bjZ2eCtOb3NT?=
 =?utf-8?Q?p8b8fitjQYofTs6uY5C++r+yp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c6ca67-2f43-4d2d-5dd6-08db7b0a6fef
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2023 14:41:36.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVfoOd/dlvB1xQAYdbwYzjdLf7bZZXrcdJrLt3+OLBTCH4bHxZFsR/WtWU7Cdt8j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9050
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 18:39, Richard Gobert wrote:
> I haven't been able to reproduce it yet, I tried two different setups:
>     - 2 VMs running locally on my PC, and a geneve interface for each. Over
>       these geneve interfaces, I sent tcp traffic with a similar iperf
>       command as yours.
>     - A geneve tunnel over veth peers inside two separate namespaces as
>       David suggested.
> 
> The throughput looked fine and identical with and without my patch in both
> setups.
> 
> Although I did validate it while working on the patch, a problem may arise
> from:
>     - Packing CB members into a union, which could've led to some sort of
>       corruption.
>     - Calling `gro_pull_from_frag0` on the current skb before inserting it
>       into `gro_list`.
> 
> Could I ask you to run some tests:
>     - Running the script I attached here on one machine and checking whether
>       it reproduces the problem. 
>     - Reverting part of my commit: 
>         - Reverting the change to CB struct while keeping the changes to
>           `gro_pull_from_frag0`.
>         - Checking whether the regression remains.
> 
> Also, could you give me some more details:
>     - The VMs' NIC and driver. Are you using Qemu? 
>     - iperf results.
>     - The exact kernel versions (commit hashes) you are using.
>     - Did you run the commands (sysctl/ethtool) on the receiving VM?
> 
> 
> Here are the commands I used for the namespaces test's setup:
> ```
> ip netns add ns1
> 
> ip link add veth0 type veth peer name veth1
> ip link set veth1 netns ns1
> 
> ip a add 192.168.1.1/32 dev veth0
> ip link set veth0 up
> ip r add 192.168.1.0/24 dev veth0
> 
> ip netns exec ns1 ip a add 192.168.1.2/32 dev veth1
> ip netns exec ns1 ip link set veth1 up
> ip netns exec ns1 ip r add 192.168.1.0/24 dev veth1
> 
> ip link add name gnv0 type geneve id 1000 remote 192.168.1.2
> ip a add 10.0.0.1/32 dev gnv0
> ip link set gnv0 up
> ip r add 10.0.1.1/32 dev gnv0
> 
> ip netns exec ns1 ip link add name gnv0 type geneve id 1000 remote 192.168.1.1
> ip netns exec ns1 ip a add 10.0.1.1/32 dev gnv0
> ip netns exec ns1 ip link set gnv0 up
> ip netns exec ns1 ip r add 10.0.0.1/32 dev gnv0
> 
> ethtool -K veth0 generic-receive-offload off
> ip netns exec ns1 ethtool -K veth1 generic-receive-offload off
> 
> # quick way to enable gro on veth devices
> ethtool -K veth0 tcp-segmentation-offload off
> ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off
> ```
> 
> I'll continue looking into it on Monday. It would be great if someone from
> your team can write a test that reproduces this issue.
> 
> Thanks.

Hey,

I don't have an answer for all of your questions yet, but it turns out I
left out an important detail, the issue reproduces when outer ipv6 is used.

I'm using ConnectX-6 Dx, with these scripts:

Server:
ip addr add 194.236.5.246/16 dev eth2
ip addr add ::12:236:5:246/96 dev eth2
ip link set dev eth2 up

ip link add p1_g464 type geneve id 464 remote ::12:236:4:245
ip link set dev p1_g464 up
ip addr add 196.236.5.1/16 dev p1_g464

Client:
ip addr add 194.236.4.245/16 dev eth2
ip addr add ::12:236:4:245/96 dev eth2
ip link set dev eth2 up

ip link add p0_g464 type geneve id 464 remote ::12:236:5:246
ip link set dev p0_g464 up
ip addr add 196.236.4.2/16 dev p0_g464

Once everything is set up, iperf -s on the server and
iperf -c 196.236.5.1 -i1 -t1000
On the client, should do the work.

Unfortunately, I haven't been able to reproduce the same issue with veth
interfaces.

Reverting the napi_gro_cb part indeed resolves the issue.

Thanks for taking a look!
