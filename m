Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF83744E26
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjGBOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjGBOqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:46:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA25E5E;
        Sun,  2 Jul 2023 07:46:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/VE5IiaGa3+th3g45fVj6gkS3P32PTtPo7l/vPkcWZFyV1rEzxzondyeyDT07sXjlhjoYAU2h/eEEzNK3M+XOjygMxvF7btFPBSpSrvEViTqgFyJEWhh0Bj9Dk4RIe38baWXbNBacCy1+dYWujhNvPyvOwFgVNyL304HH55eztHq4rNO/3j4VTSH4RHlw9pmb9wzWWBY5KfQ7tLN2ZZCuGZlNVuvRqjiuU5ZotXng8D71kpx/ifcBlQOHOC60zz8FKOd31pCWdaCcCFHXoroelH2IViC/sgtXVCy6lXyBMOsw6ACn/N9RnvIHnfYiHSRkXKUPz7NZlhmiLJwDEp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN/ArEl2frTZeyLMYA6CAcN5IfIF4UJcxViL0l0/Wsw=;
 b=l+F8i7+7UTKEbsouxACrr7hdcfwJ8HQAMAvLca3lBeGr6/FPZ5czGtG7R6sCWpXPh8/CZFOMCFPSrDt2I07I8w/Co1MBQu1L86mlZcXe4JL64Gh9hFGJzowKvLk14DpbJI5VIiL6X/Ajzhfavxnxo7Qq5GJo/eLHw2Gpj+CBbeI1J2WZphc1p1B0mrqVP8ZBtgosqQN5NA/cBf5p3+fvmEsBtay5uiUGkB84Qwg7FvwA0IMtKGBynQIv+iMVGHtW250JmUbn2Gky7lGPxob7t1WH0a41+8G3krcBhykxZ7gzgL8aKUvyPp1R0+t0GGDZeDrzb8LJxIBQ+pVxEKYTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN/ArEl2frTZeyLMYA6CAcN5IfIF4UJcxViL0l0/Wsw=;
 b=e4FCZIgQeF+wXWVIAOQYhGeQmrxUCBS0j36h0SpoH4fH2Ji+6xAahb+7gH5Ws7DEq5i2TjFxVCCmIIFo/OPlFzVWKIGAGQX0odbMUZkVAvy2XcW1sIK5DXy/mSqRYbOLQzFkrmvRPma+MNeZwB5YofCXApBp9KSgwtpKcfWZosMNI/7owFHG+IIs/Db5Dkqs1SE/1XMghlHt6/kUnCDY1iiYWABbP5moS2YAIBUojYZ8tFWioophTb/8IXzO3fL2el/srkHYHuQxQUYc70fn+tNgG4TyTPXpNUP5y++CEECLT6qzj1muOHu2ZFwZsPUj08mHZQVr0PwxXQveSSsOhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Sun, 2 Jul
 2023 14:46:50 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6544.024; Sun, 2 Jul 2023
 14:46:50 +0000
Message-ID: <50181937-19ea-ccca-057c-eb6931f4b2da@nvidia.com>
Date:   Sun, 2 Jul 2023 17:46:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
From:   Gal Pressman <gal@nvidia.com>
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
 <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
Content-Language: en-US
In-Reply-To: <fdc1d609-5604-f372-6e64-1ea971fabe84@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::8) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: fceea5b1-fbe6-4b4d-2543-08db7b0b2b03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LepiLvdAb7DRWQXBjGi57wU8U6GqOTd1U9UkCjsSQGPn7Owu8O9DT9tAfUwslzNfVrU2HxjfoOsx3WvuwT7cCR772SEV9ot7nEJ1ml6qDGurWUZhzBl1HyapHHBstW2qBqSj483sg2jGXp7NC/BdBYuP3pKSGq0NeHL7vyN2+VWF4DR/pbsxBwLDNwL8mUsPcHqufARS8rbTXmWZiN+6BL22HQ7nVSz8lvPb6NPlsoa26vkEvI4JmuqW1wfN7wMJdyjonTDxbLTXv4gSCxfG2i/tJOKDOR5d9N5hee68xVXwI2Ux4BCu9dTgiSBn0s57uV+0u77kNnyZp6Kvyude3HB2J4RvDXZ8VH3VuYcYHUgOVGdc1Az3XbuSoDZ0p8RP9C8zU3mpw9OQpqdJua3r7q3aaEvRHgxrCCl32o1kowGaa2MMPW4kk3rTsmZlRwN1vyi/y+F3tTRz9vdeSy+3IsgiVozGYUu//fWMwvVmcf4tICghIATiNPYVOiDsU4durglCIqdKzMxRm4LV6idzcU3E0uh93nSPfNby+rMxi8kRwvbjmtDGn4GScoDVhSzy4zJbf6tuDk1yiW5f7HPuupr6+tdHy0DnwPUzaF6PqSjDvYIPDgiPFQU1Ycij2qlzdCYboYalpqRGo6S3B6ikLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(7416002)(31686004)(6916009)(4326008)(66476007)(66556008)(66946007)(478600001)(316002)(2906002)(36756003)(8676002)(8936002)(5660300002)(41300700001)(6512007)(31696002)(86362001)(38100700002)(6486002)(6666004)(53546011)(186003)(6506007)(26005)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N25TZGlVaVY3Z1o4cW8xekhVMUtHNEh4RkZ4V0NaVXdhRUE5djRoa1B5SU5R?=
 =?utf-8?B?VS9HSFNtSmpmY1RDK2hWYW5McHlieUhaZ3hka08xTTNoSTMzTzRoQ01wM3o4?=
 =?utf-8?B?WmkzQThnS3pnNzMrL0ZQVzBjZ0VzUStPODRxL05lc2xQU1JoeDRCeW9SNVRl?=
 =?utf-8?B?RkIxdm1MSjh3VGluZUY5VzQ5Z2hLdy8xQkdobFI2bXovU0xwMitlRmt0Wmtu?=
 =?utf-8?B?N1RXYmkrYW96Ynd2ckRweitnVnEzSmhRTkxONWtmd0pFLzJZSXRqVDh6andQ?=
 =?utf-8?B?aHlrejVVemZEcUI2L2NzT01Bb1MrNmlKMDVCR3cxZnY2c25jbG1uOERvQTVr?=
 =?utf-8?B?aENtam53S0x6WHRHYkh2dG5yRGZkSHFYOGdabHdBNVo1bnRWNi9MejJpRisx?=
 =?utf-8?B?Q1V4OXpkcTJwMTdQZndSZ2hONFZ4cGUxVUtaT01MdUJuTnRrdk1zOWtwQTE3?=
 =?utf-8?B?WlZ2MWlvYW9XNTl6bWVib0dxZk1JWXMzMFlNWE5yaWMyTHJaZWF2RVJWWG1D?=
 =?utf-8?B?VFJ0OWZQa21LbnhIYzJsZ2R2RkFDb0xIR1BOeWVWdDZmTnBqdEFZejZCblJY?=
 =?utf-8?B?WFhhMVU0cVMrUm5zN0dKUFJ5QmhZVnJFVUhJVHdzaGM5UHZDWVdnK3ZpZDBn?=
 =?utf-8?B?cHAvMmo5ZGI2OFA5L1daSXhVMUdlZ1I3ckRqenREam90SFo4TTE0SHF6ZWFQ?=
 =?utf-8?B?OGJTeGZaZi8zY1Y4ODBTUFVadmdhMWRDVDAzNDJJNHFobm8vcEJYNndHNDVy?=
 =?utf-8?B?emJPZ2xsS1BQTXA0eVk5T09na2kvLzVzdUk4SHRtT1VhOEoyMDh0WDZxYzVY?=
 =?utf-8?B?VXFJa1FzRlNlbjd2aUdsbWZWN1lUcThUTS9aRG5kYjVWNHpNMnFZeWlOa1Mr?=
 =?utf-8?B?dmpXc2pWdTV3VTF3K3B0Y0kzWVZEVjRwdi83VFdoQmxpKzhPSllxbGVvUmlj?=
 =?utf-8?B?LytwL2V5dC9ZbnFkVXNqQ0JaamM5NnBoSHh4VVB0bzdPWlhhWnhIdTlrSXY1?=
 =?utf-8?B?TUxCNUFtR1QrbG50WGhOb1JFTll2dk9qZW95ZmNXc012RGNGUllObDRZVlJo?=
 =?utf-8?B?KzA5dlF3VHJWbm52NEY3eXJWNzFxWHFTRlNRR2RYVUhrYnBXYWw1ZkVGNmUy?=
 =?utf-8?B?ZTQxRUdaem9ibElteFUwT25qRmhWQ3RZdVFPdDJ6a1NEaU1hZ2FnK2Mvb1pv?=
 =?utf-8?B?L0d1Q3R6VFd0SUFaWW8yVzA0SjFGR3RncVAyOFRaMXpXSkd1MWR0Q1dFd2Fy?=
 =?utf-8?B?c1hFOEVmMkRQTFl4WS93YXJlbFoxYmE4bFFyNEt1eXN5cit4MWVvSjgwVTE5?=
 =?utf-8?B?VUg1Z241eVkzVk9ZaWdCSytKOXR4ZGdMTVB2UDFsR0ZWMHFFNUxqN0tZTmpO?=
 =?utf-8?B?c0ZYMGJ2UFNrd1dZQ2RkUmhoNWlYVlVjRUV5T1ZtRklhMnR3aWwyaWlsL2Uz?=
 =?utf-8?B?aDFpTGxXK0ZMak9YcTBuc1ZaV0JIRTVkK2hRa0dRZ2RSZERnZnhGWHRsS1F4?=
 =?utf-8?B?UlNiZmkyOWE0UHQyVXRVTVdkMnlLcXpZeWdTYkx1YXRmc2hkM0JXaWZaM3Fw?=
 =?utf-8?B?WFloTU01d2JiRTljSFB5UkZmdGNHdUN3R000MUxFUTl5WDVGYUFrems4RC85?=
 =?utf-8?B?VVF2ODloN0xxZS9XLzIzUTlnZXdMczAzNTB0d0w1bmRKQlJDblJHbS9xYWZ2?=
 =?utf-8?B?bEJ1YmV6UHRoVG5CZ2FPcnlhbnk3cHpIdjJkZkdmOXVYbVVvNnBRRWJuQ0tV?=
 =?utf-8?B?V08zRGtyd01LMFl3ODN0aDFyeXpjQWVFbVkyeTZMNmZWQ051ay9ZVFBYeVZP?=
 =?utf-8?B?NlZYZ1haQ2dBa2xCeDhIQlI3TG10d1VTVnJvSGlzMlVoNXdVbnNMd2JhVExS?=
 =?utf-8?B?RlBiNU84N2hJcmpmQm9RajB6VmVnTm9KV0FNY0pTSW52R3pmRXB3dDZtTzRE?=
 =?utf-8?B?R1ZNdzBFazJ2SEtYaWZkVCt0VFkyQVNiRXcrYUNBUVNwUTV5QnV5azRqVHli?=
 =?utf-8?B?bnFGK1hBNlB2Z3pYRUljbjdEeWptaEZQQ2d6b2ZkWThkcmwvUFJ3U2V4WjQ4?=
 =?utf-8?B?NWhGYVp6NmsrZEV3amNnTk0vSFFpSi92SHRhNUw1aWVrY3UwdGV6ZnFTZUli?=
 =?utf-8?Q?ZoKe8y4v+vHtkRxtafg1XAN+Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fceea5b1-fbe6-4b4d-2543-08db7b0b2b03
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2023 14:46:50.1691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBs/9+B6kwV5l49ldvhEQXB/t48K0hhpTGOGTCnWMnVAlgOp0xUTimuVSthQlN5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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

On 02/07/2023 17:41, Gal Pressman wrote:
> On 30/06/2023 18:39, Richard Gobert wrote:
>> I haven't been able to reproduce it yet, I tried two different setups:
>>     - 2 VMs running locally on my PC, and a geneve interface for each. Over
>>       these geneve interfaces, I sent tcp traffic with a similar iperf
>>       command as yours.
>>     - A geneve tunnel over veth peers inside two separate namespaces as
>>       David suggested.
>>
>> The throughput looked fine and identical with and without my patch in both
>> setups.
>>
>> Although I did validate it while working on the patch, a problem may arise
>> from:
>>     - Packing CB members into a union, which could've led to some sort of
>>       corruption.
>>     - Calling `gro_pull_from_frag0` on the current skb before inserting it
>>       into `gro_list`.
>>
>> Could I ask you to run some tests:
>>     - Running the script I attached here on one machine and checking whether
>>       it reproduces the problem. 
>>     - Reverting part of my commit: 
>>         - Reverting the change to CB struct while keeping the changes to
>>           `gro_pull_from_frag0`.
>>         - Checking whether the regression remains.
>>
>> Also, could you give me some more details:
>>     - The VMs' NIC and driver. Are you using Qemu? 
>>     - iperf results.
>>     - The exact kernel versions (commit hashes) you are using.
>>     - Did you run the commands (sysctl/ethtool) on the receiving VM?
>>
>>
>> Here are the commands I used for the namespaces test's setup:
>> ```
>> ip netns add ns1
>>
>> ip link add veth0 type veth peer name veth1
>> ip link set veth1 netns ns1
>>
>> ip a add 192.168.1.1/32 dev veth0
>> ip link set veth0 up
>> ip r add 192.168.1.0/24 dev veth0
>>
>> ip netns exec ns1 ip a add 192.168.1.2/32 dev veth1
>> ip netns exec ns1 ip link set veth1 up
>> ip netns exec ns1 ip r add 192.168.1.0/24 dev veth1
>>
>> ip link add name gnv0 type geneve id 1000 remote 192.168.1.2
>> ip a add 10.0.0.1/32 dev gnv0
>> ip link set gnv0 up
>> ip r add 10.0.1.1/32 dev gnv0
>>
>> ip netns exec ns1 ip link add name gnv0 type geneve id 1000 remote 192.168.1.1
>> ip netns exec ns1 ip a add 10.0.1.1/32 dev gnv0
>> ip netns exec ns1 ip link set gnv0 up
>> ip netns exec ns1 ip r add 10.0.0.1/32 dev gnv0
>>
>> ethtool -K veth0 generic-receive-offload off
>> ip netns exec ns1 ethtool -K veth1 generic-receive-offload off
>>
>> # quick way to enable gro on veth devices
>> ethtool -K veth0 tcp-segmentation-offload off
>> ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off
>> ```
>>
>> I'll continue looking into it on Monday. It would be great if someone from
>> your team can write a test that reproduces this issue.
>>
>> Thanks.
> 
> Hey,
> 
> I don't have an answer for all of your questions yet, but it turns out I
> left out an important detail, the issue reproduces when outer ipv6 is used.
> 
> I'm using ConnectX-6 Dx, with these scripts:
> 
> Server:
> ip addr add 194.236.5.246/16 dev eth2
> ip addr add ::12:236:5:246/96 dev eth2
> ip link set dev eth2 up
> 
> ip link add p1_g464 type geneve id 464 remote ::12:236:4:245
> ip link set dev p1_g464 up
> ip addr add 196.236.5.1/16 dev p1_g464
> 
> Client:
> ip addr add 194.236.4.245/16 dev eth2
> ip addr add ::12:236:4:245/96 dev eth2
> ip link set dev eth2 up
> 
> ip link add p0_g464 type geneve id 464 remote ::12:236:5:246
> ip link set dev p0_g464 up
> ip addr add 196.236.4.2/16 dev p0_g464
> 
> Once everything is set up, iperf -s on the server and
> iperf -c 196.236.5.1 -i1 -t1000
> On the client, should do the work.
> 
> Unfortunately, I haven't been able to reproduce the same issue with veth
> interfaces.
> 
> Reverting the napi_gro_cb part indeed resolves the issue.
> 
> Thanks for taking a look!

BTW, all testing is done after checking out to your commit:
7b355b76e2b3 ("gro: decrease size of CB")
