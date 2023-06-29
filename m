Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5217426F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjF2NFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:05:03 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:14272
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231537AbjF2NEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:04:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nd4ZexZcZy0b/2s45QEJXjeIyzJdcq/0Y9Gs/slDLPhT99EAU5F54xsmFAjjD3SvSch0oLHTCUgP63XpypB5JSEnvR5HxKRGqd0ArLOyQYcz1Oa3RD8yUH8QMZs5ZUeARzkTrmkZFIcGzdgIr1oG+La9wcrra7AVcEmEFsJvMsh8dshJHOSoEV8qzzG9SwDp4U7mIg4Ka5VCmt0In6ffGm9UwLRZa5p+xsq9UOW04B86ujuvmiLplVdg9/LZyXFVpzuFjGiX/5DzpSRlifZLSIhtpdtn+thfaWoW0GfOr5wLNEHIQh5QyUiVj50y0QM0JJQm1tQ7KffKnOkk44jYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXNtECV2G3edbSZOjWnMHqIJXAqSYJ50rgqkR707VIQ=;
 b=UPri2O356KPpBFddz65BzLIY/ANJD+JIk0L+cfmkT04DpXudabO11Osb6Qgrd6S3lJdJHJXKRVJ98+HtUqYUVlnhPXOaGu/3vVhVOaOrDm53GlhpHupx2XxZ/Rm6XG8/16dcYjBVYhWlSYWyKVN+Q1YxJ8FaqEANcldmVUdpJyWlwsQDFvuIE4AS/oRroq82BhCa2JDOWnYOfaeK3MU3LWxAe+7DOHzIhMhABdIM8lqtnsXZfWQxIHoSpVDCUJAzIz+mQQGnN/Voz6+373IV2wpIRl6p2XK4gIUxWFn+JBDfPLG6HbFzVSfUSqEvPwOF64J3KeW9jBzBJJ0c/i6lCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXNtECV2G3edbSZOjWnMHqIJXAqSYJ50rgqkR707VIQ=;
 b=CXrg/Sod7iGJT36mikGgzXg2Uaa+1YqEi3WIpuB5AYEoD+3fTSXJKkU3cnjWNi+1AaAmBlwrFmP1dsQq0BTNyn5MvhBGmPgnulgHpVnKluYE0Ug+HIN6sUNgutLyb6OT1zdMIJ814Pp05czTzRUJjTuCQ6DwBxYQTtBR3NgXqhLdG2M+Fet5xiFnju6sHNAoTnkYgRGpbk7GCmbU7OtLA9QzpZjo3sQHOCXPOR4Y5g+2swHAwjMuL8fVgz85Dyhn08h9uL9G5q8njlcez2Ug5y3niPwJstZI1Kku+fNMHzQVh4oFLxRzc2FTyzLN1TD7q1L0Gc+Tlg+99P25mXF9ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.19; Thu, 29 Jun 2023 13:04:32 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::12e5:730c:ea20:b402%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:04:32 +0000
Message-ID: <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
Date:   Thu, 29 Jun 2023 16:04:21 +0300
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
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230629123559.GA12573@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:803:14::21) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: b20511c8-de8d-4598-339a-08db78a1614b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1eUXvt5AWviOm3/WT1IXqCjdsXPh8VRm2KTwemyJuY9FkIs/1iidZSp/30lqyUjYnSoCP2sP2r9/v9n9XCe7X+TDMVueuZAaueDo364ONllo3k7rFPjkJo3CBPvT8doDx7cjUvvEwoMLJveXSNandRmQWQMWODc6sZJVov47Kdkg+gCYnuli5oXH271oapQ4MJA/b4Cmx4uXOQw95U0kjLX9qPpzWF+jsOYWqNfY3uDsk83F630jNRrd9D4uDzL4lLJ6jtdkf0khJNcQkax0H4G85a2h1nJW9dnAki3cNAptlBQr5xftB9649hTh0UGRAPRry/vSrG9IX9wSKIneSYsby8gfc0ZoOxtMC5FDmxsUvPA7lvj1iMLduKLq4pbjIDHjIVm5TyOMOdRckhHu/vpXxeYFp6Db43oXFUGT8Db57oJh1hq9DegwdxL5s2HUvzL2TYP34EzQu9LXCeytILOn+a7tlAbtQmdMQE8/tyGlc7XGYBpyZ3yvbdgINNHT/0UyU5icqkKQpKjZ9W35poh/JM5vr06VzugKeVm1prXcmnp5VathdNtBk80UNJa8g3fPKu5OHmSAcFSjdDpzQ/BTB90YruCO5y+XcxY0Sev48IEqvjuoJFbOqPxUseUijO+M9woqWdnx2z5sQqAjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(41300700001)(6512007)(316002)(83380400001)(86362001)(66574015)(31696002)(53546011)(186003)(6506007)(26005)(7416002)(30864003)(2616005)(2906002)(38100700002)(5660300002)(36756003)(8676002)(8936002)(478600001)(31686004)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(6666004)(43740500002)(45980500001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTBFRjFwdmhGRjNPNVNqVy8rMlFPSWtKcklJOWpRRFBQN1Y2MzRaUG8xVm1x?=
 =?utf-8?B?Ym9ITlpQRmlWRkk5N0F4YkgrVEJacndtS0R3MjdLUENVSWwrUUYyQzRGYUVJ?=
 =?utf-8?B?emh5UGFxWXNwTEZoT29TV1dTU1RVOXdFRE96bXR1VTlnNGZMdExrVEZxVHVy?=
 =?utf-8?B?SHlPV1NyTDkraHFlWThUN2lRNU9pQjNyb2NkaHdYQWVrci9qU0swZFA5L0M3?=
 =?utf-8?B?SnVlTXl3elNZQ1NXU3RLRjNVV2VkR043dmlxQm56ZEVKOVhkSUhmcHEzMVN3?=
 =?utf-8?B?TmtoTEZUa1VNaWJJMnh0b3AzSm1GZ05DRitnd3U3bEt6bWt0SW81dXR4QXRG?=
 =?utf-8?B?aytkeUZaSlhkNDdhZnM3Q2dkOER0ZmFVVFJEelRId0NYQmcyM3dBeHpMTEVo?=
 =?utf-8?B?cW0xUnp0WitmVUt4KzBrVTUycUZBT2ZaeGd3ZWN5dlo5cjg2QS8xRjdndk1a?=
 =?utf-8?B?MnpBVFdUNDQ3QXJaVzRDZy9weGlLWVRRVXFpUkZxME9QVVE3cEJIM3NSUUVI?=
 =?utf-8?B?RFlEd2Y3cEtESURjZ0lHWEdkMnJIclU4TXZmMWZkc29JMmd6bzJOWFBkb3gz?=
 =?utf-8?B?d2FPZXhrcXltdDJhQTY2MGlSUkVTSE9QWXIzc3QxWUxDNFR5bko0Rk92T0Zn?=
 =?utf-8?B?SndNZURLa1F2aXJGTnFlMExKK1M0Nk9rZUVUVGdUam95Y3Y4NlVxd2VmUWtX?=
 =?utf-8?B?ekNPS2RvL0h1bm40UE9UYU56T0lsZmxmSTNqY2hrNVcrUU5rYyt0OHNZK0VK?=
 =?utf-8?B?N2RUWDEzM095Uk82dWt3RUUwMERmN2VvTWVDTzFjcEZtSzg4T0RrVGlZN2NI?=
 =?utf-8?B?UWxLV2hkZEVxWi9SZ0NZVVJFbzR1Vm95cFhNWmtRY1BzVFZMUjByb2FNZWhs?=
 =?utf-8?B?NmI4Zi9iZHNsYW5xV09zOEZBY3Y5NUtJZ2FCc1d2OHhVUHp1aWo1c3Fjb1Ay?=
 =?utf-8?B?T0pEWUFGTHVTV0tYTHVVVFVVSTdEVzhyT3lqNWI0NGk1TEJSVTc3ZGtKbjd2?=
 =?utf-8?B?VVN1UGg4VnlHMFJnU0RWbWYyWlZwb21uWlliT3dHWVVkQk5ZQmpXdmpuUnJo?=
 =?utf-8?B?WVpsRU5kRGY2SFVqRE9DVGhqS2k0bkJGbWdLN2RyNDJuSGRTYkFWeVNwdGUx?=
 =?utf-8?B?bjBvNHZaL1c0UWg1RFcrTEpGdW9RMUxIWFNkSzFDSTFKRlBwTWlHclo0ckFE?=
 =?utf-8?B?QWIzNmZ5SWRhOUg1dklTNVlmRm1SVHp6QjdqaTE2K3JnWlMrL3Z0dUVWdDJx?=
 =?utf-8?B?K0Y5aTJCMGpjL0RsUWE0Y0FWTVdndXlVVEFCWG9rZ2ROVllZUnpIdjhUUlVo?=
 =?utf-8?B?MDErc2tBZm12djdsQ3JmN01KR1ZGKzJwMXROcGhXU1BXRVZGUFhrWlFNZkRp?=
 =?utf-8?B?ZENDNndjWEtMbFV0Ni80MXREemhPaCtBNXlxdVdTN3Q3ZVlHYTJEOUk0dzZo?=
 =?utf-8?B?K1FiTjNLYkRYdnJnL25EVGJxODc2Mi9KUmNDTG02MW9hcWJLUTRld2lsZG4w?=
 =?utf-8?B?QW05aTlvOEVranhRMDJ3YzYvQ0h1cGVlT1gxNG5ZUGZwZGdwaE15bkFxWVBx?=
 =?utf-8?B?SC9HcitQd0NFdVpzNC9mTi9NUUljUkJ4NjdwSEFRU1g3WjBrVTVjOEZjSThu?=
 =?utf-8?B?dzZGQ1NxNDRlZ0FLYllNZ2pzYVVISWtjSU4vNkFXYUpRZVUzZ3gzSDBKUjlq?=
 =?utf-8?B?TVJ1ZitKdnBrWkdrZmNrZjlpcEh0YWhYSmtTdTBhZjNheDNmNDg3emNReHQy?=
 =?utf-8?B?MDI5R3VjN0hUZkhmaE94Y3pSM1Mzd0liKy9JSGIwTjdoWWVHdDNrQTBNaUwz?=
 =?utf-8?B?b1lWaDkxcEtiSzU3STJuNzVhSGh5RDFyZmNGMnk1SzRFek5mWXVzSGtoY2Zv?=
 =?utf-8?B?dUFpNE9UYXg3bWZXMHRlR0xTUGZNOTJvNFFvbmg0VGRCZ3VlZWRid3lMejQw?=
 =?utf-8?B?MEpCYWZ2WlgxTjllekpCSkFZWStURytWUVZScTVOdm8va3owbWkyL0NEYjJt?=
 =?utf-8?B?U2pEeFUxOHpBUG1YdjV6YXF2MGE4TUZXazRwRzQvb29uRThFdVBTVlU3RU9K?=
 =?utf-8?B?bDJvTll5aFpFNmpCY2NjV01uMUlaVWFvSkdnWlcrL3dKQVFWbk01WlJZWitx?=
 =?utf-8?Q?l4GvQ8JUvz+OgJ2qy8UmKck6g?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20511c8-de8d-4598-339a-08db78a1614b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:04:32.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIowor4bITG4eDFy4tmLKesEOmacM/im048wDifc0cL5ZRoMRoSEa5Z7Nb81vIqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2023 15:36, Richard Gobert wrote:
>> On 01/06/2023 19:14, Richard Gobert wrote:
>>> The GRO control block (NAPI_GRO_CB) is currently at its maximum size.
>>> This commit reduces its size by putting two groups of fields that are
>>> used only at different times into a union.
>>>
>>> Specifically, the fields frag0 and frag0_len are the fields that make up
>>> the frag0 optimisation mechanism, which is used during the initial
>>> parsing of the SKB.
>>>
>>> The fields last and age are used after the initial parsing, while the
>>> SKB is stored in the GRO list, waiting for other packets to arrive.
>>>
>>> There was one location in dev_gro_receive that modified the frag0 fields
>>> after setting last and age. I changed this accordingly without altering
>>> the code behaviour.
>>>
>>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>>
>> Hello Richard,
>>
>> I believe this commit broke gro over udp tunnels.
>> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
>> is pretty much zero.
>>
>> Turning off gro on the receiving side (or reverting this commit)
>> resolves the issue.
> 
> Sorry for the late response.
> I am starting to look into it right now. Can you please share more details about your setup?
> - I'd like to see the output of these commands:

Sure!

>   ethtool -k

Features for eth2:
rx-checksumming: on
tx-checksumming: on
        tx-checksum-ipv4: off [fixed]
        tx-checksum-ip-generic: on
        tx-checksum-ipv6: off [fixed]
        tx-checksum-fcoe-crc: off [fixed]
        tx-checksum-sctp: off [fixed]
scatter-gather: on
        tx-scatter-gather: on
        tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: on
        tx-tcp-segmentation: on
        tx-tcp-ecn-segmentation: off [fixed]
        tx-tcp-mangleid-segmentation: off
        tx-tcp6-segmentation: on
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: off
receive-hashing: on
highdma: on [fixed]
rx-vlan-filter: on
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: on
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-tunnel-remcsum-segmentation: off [fixed]
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: on
tx-udp-segmentation: on
tx-gso-list: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off
rx-all: on
tx-vlan-stag-hw-insert: on
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: on [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: on
esp-hw-offload: on [fixed]
esp-tx-csum-hw-offload: on [fixed]
rx-udp_tunnel-port-offload: on
tls-hw-tx-offload: on
tls-hw-rx-offload: off
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
rx-gro-list: off
macsec-hw-offload: on
rx-udp-gro-forwarding: off
hsr-tag-ins-offload: off [fixed]
hsr-tag-rm-offload: off [fixed]
hsr-fwd-offload: off [fixed]
hsr-dup-offload: off [fixed]

>   sysctl net

net.bridge.bridge-nf-call-arptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-filter-pppoe-tagged = 0
net.bridge.bridge-nf-filter-vlan-tagged = 0
net.bridge.bridge-nf-pass-vlan-input-dev = 0
net.core.bpf_jit_enable = 1
net.core.bpf_jit_harden = 0
net.core.bpf_jit_kallsyms = 1
net.core.bpf_jit_limit = 796917760
net.core.busy_poll = 0
net.core.busy_read = 0
net.core.default_qdisc = pfifo_fast
net.core.dev_weight = 64
net.core.dev_weight_rx_bias = 1
net.core.dev_weight_tx_bias = 1
net.core.devconf_inherit_init_net = 0
net.core.fb_tunnels_only_for_init_net = 0
net.core.flow_limit_cpu_bitmap = 000
net.core.flow_limit_table_len = 4096
net.core.gro_normal_batch = 8
net.core.high_order_alloc_disable = 0
net.core.max_skb_frags = 17
net.core.message_burst = 10
net.core.message_cost = 5
net.core.netdev_budget = 300
net.core.netdev_budget_usecs = 8000
net.core.netdev_max_backlog = 1000
net.core.netdev_rss_key =
60:d8:27:5f:2d:0b:db:ad:3f:6c:8f:8b:e3:18:ca:3a:78:83:24:cb:8c:a4:f4:77:5d:d5:31:82:44:2e:a3:10:6a:00:25:ec:1a:b2:81:43:5b:45:3c:ef:bc:49:02:93:a9:bf:a4:e0
net.core.netdev_tstamp_prequeue = 1
net.core.netdev_unregister_timeout_secs = 10
net.core.optmem_max = 81920
net.core.rmem_default = 212992
net.core.rmem_max = 212992
net.core.rps_default_mask = 000
net.core.rps_sock_flow_entries = 0
net.core.skb_defer_max = 64
net.core.somaxconn = 4096
net.core.tstamp_allow_data = 1
net.core.txrehash = 1
net.core.warnings = 0
net.core.wmem_default = 212992
net.core.wmem_max = 212992
net.core.xfrm_acq_expires = 30
net.core.xfrm_aevent_etime = 10
net.core.xfrm_aevent_rseqth = 2
net.core.xfrm_larval_drop = 1
net.dccp.default.request_retries = 6
net.dccp.default.retries1 = 3
net.dccp.default.retries2 = 15
net.dccp.default.rx_ccid = 2
net.dccp.default.seq_window = 100
net.dccp.default.sync_ratelimit = 124
net.dccp.default.tx_ccid = 2
net.dccp.default.tx_qlen = 5
net.ipv4.conf.all.accept_local = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.arp_accept = 0
net.ipv4.conf.all.arp_announce = 0
net.ipv4.conf.all.arp_evict_nocarrier = 1
net.ipv4.conf.all.arp_filter = 0
net.ipv4.conf.all.arp_ignore = 0
net.ipv4.conf.all.arp_notify = 0
net.ipv4.conf.all.bc_forwarding = 0
net.ipv4.conf.all.bootp_relay = 0
net.ipv4.conf.all.disable_policy = 0
net.ipv4.conf.all.disable_xfrm = 0
net.ipv4.conf.all.drop_gratuitous_arp = 0
net.ipv4.conf.all.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.all.force_igmp_version = 0
net.ipv4.conf.all.forwarding = 1
net.ipv4.conf.all.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.all.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.all.ignore_routes_with_linkdown = 0
net.ipv4.conf.all.log_martians = 0
net.ipv4.conf.all.mc_forwarding = 0
net.ipv4.conf.all.medium_id = 0
net.ipv4.conf.all.promote_secondaries = 0
net.ipv4.conf.all.proxy_arp = 0
net.ipv4.conf.all.proxy_arp_pvlan = 0
net.ipv4.conf.all.route_localnet = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.secure_redirects = 1
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.shared_media = 1
net.ipv4.conf.all.src_valid_mark = 0
net.ipv4.conf.all.tag = 0
net.ipv4.conf.default.accept_local = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.default.arp_accept = 0
net.ipv4.conf.default.arp_announce = 0
net.ipv4.conf.default.arp_evict_nocarrier = 1
net.ipv4.conf.default.arp_filter = 0
net.ipv4.conf.default.arp_ignore = 0
net.ipv4.conf.default.arp_notify = 0
net.ipv4.conf.default.bc_forwarding = 0
net.ipv4.conf.default.bootp_relay = 0
net.ipv4.conf.default.disable_policy = 0
net.ipv4.conf.default.disable_xfrm = 0
net.ipv4.conf.default.drop_gratuitous_arp = 0
net.ipv4.conf.default.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.default.force_igmp_version = 0
net.ipv4.conf.default.forwarding = 1
net.ipv4.conf.default.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.default.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.default.ignore_routes_with_linkdown = 0
net.ipv4.conf.default.log_martians = 0
net.ipv4.conf.default.mc_forwarding = 0
net.ipv4.conf.default.medium_id = 0
net.ipv4.conf.default.promote_secondaries = 1
net.ipv4.conf.default.proxy_arp = 0
net.ipv4.conf.default.proxy_arp_pvlan = 0
net.ipv4.conf.default.route_localnet = 0
net.ipv4.conf.default.rp_filter = 2
net.ipv4.conf.default.secure_redirects = 1
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.default.shared_media = 1
net.ipv4.conf.default.src_valid_mark = 0
net.ipv4.conf.default.tag = 0
net.ipv4.conf.docker0.accept_local = 0
net.ipv4.conf.docker0.accept_redirects = 0
net.ipv4.conf.docker0.accept_source_route = 0
net.ipv4.conf.docker0.arp_accept = 0
net.ipv4.conf.docker0.arp_announce = 0
net.ipv4.conf.docker0.arp_evict_nocarrier = 1
net.ipv4.conf.docker0.arp_filter = 0
net.ipv4.conf.docker0.arp_ignore = 0
net.ipv4.conf.docker0.arp_notify = 0
net.ipv4.conf.docker0.bc_forwarding = 0
net.ipv4.conf.docker0.bootp_relay = 0
net.ipv4.conf.docker0.disable_policy = 0
net.ipv4.conf.docker0.disable_xfrm = 0
net.ipv4.conf.docker0.drop_gratuitous_arp = 0
net.ipv4.conf.docker0.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.docker0.force_igmp_version = 0
net.ipv4.conf.docker0.forwarding = 1
net.ipv4.conf.docker0.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.docker0.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.docker0.ignore_routes_with_linkdown = 0
net.ipv4.conf.docker0.log_martians = 0
net.ipv4.conf.docker0.mc_forwarding = 0
net.ipv4.conf.docker0.medium_id = 0
net.ipv4.conf.docker0.promote_secondaries = 1
net.ipv4.conf.docker0.proxy_arp = 0
net.ipv4.conf.docker0.proxy_arp_pvlan = 0
net.ipv4.conf.docker0.route_localnet = 0
net.ipv4.conf.docker0.rp_filter = 2
net.ipv4.conf.docker0.secure_redirects = 1
net.ipv4.conf.docker0.send_redirects = 0
net.ipv4.conf.docker0.shared_media = 1
net.ipv4.conf.docker0.src_valid_mark = 0
net.ipv4.conf.docker0.tag = 0
net.ipv4.conf.eth0.accept_local = 0
net.ipv4.conf.eth0.accept_redirects = 0
net.ipv4.conf.eth0.accept_source_route = 0
net.ipv4.conf.eth0.arp_accept = 0
net.ipv4.conf.eth0.arp_announce = 0
net.ipv4.conf.eth0.arp_evict_nocarrier = 1
net.ipv4.conf.eth0.arp_filter = 0
net.ipv4.conf.eth0.arp_ignore = 0
net.ipv4.conf.eth0.arp_notify = 0
net.ipv4.conf.eth0.bc_forwarding = 0
net.ipv4.conf.eth0.bootp_relay = 0
net.ipv4.conf.eth0.disable_policy = 0
net.ipv4.conf.eth0.disable_xfrm = 0
net.ipv4.conf.eth0.drop_gratuitous_arp = 0
net.ipv4.conf.eth0.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.eth0.force_igmp_version = 0
net.ipv4.conf.eth0.forwarding = 1
net.ipv4.conf.eth0.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.eth0.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.eth0.ignore_routes_with_linkdown = 0
net.ipv4.conf.eth0.log_martians = 0
net.ipv4.conf.eth0.mc_forwarding = 0
net.ipv4.conf.eth0.medium_id = 0
net.ipv4.conf.eth0.promote_secondaries = 1
net.ipv4.conf.eth0.proxy_arp = 0
net.ipv4.conf.eth0.proxy_arp_pvlan = 0
net.ipv4.conf.eth0.route_localnet = 0
net.ipv4.conf.eth0.rp_filter = 2
net.ipv4.conf.eth0.secure_redirects = 1
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.eth0.shared_media = 1
net.ipv4.conf.eth0.src_valid_mark = 0
net.ipv4.conf.eth0.tag = 0
net.ipv4.conf.eth1.accept_local = 0
net.ipv4.conf.eth1.accept_redirects = 0
net.ipv4.conf.eth1.accept_source_route = 0
net.ipv4.conf.eth1.arp_accept = 0
net.ipv4.conf.eth1.arp_announce = 0
net.ipv4.conf.eth1.arp_evict_nocarrier = 1
net.ipv4.conf.eth1.arp_filter = 0
net.ipv4.conf.eth1.arp_ignore = 0
net.ipv4.conf.eth1.arp_notify = 0
net.ipv4.conf.eth1.bc_forwarding = 0
net.ipv4.conf.eth1.bootp_relay = 0
net.ipv4.conf.eth1.disable_policy = 0
net.ipv4.conf.eth1.disable_xfrm = 0
net.ipv4.conf.eth1.drop_gratuitous_arp = 0
net.ipv4.conf.eth1.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.eth1.force_igmp_version = 0
net.ipv4.conf.eth1.forwarding = 1
net.ipv4.conf.eth1.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.eth1.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.eth1.ignore_routes_with_linkdown = 0
net.ipv4.conf.eth1.log_martians = 0
net.ipv4.conf.eth1.mc_forwarding = 0
net.ipv4.conf.eth1.medium_id = 0
net.ipv4.conf.eth1.promote_secondaries = 1
net.ipv4.conf.eth1.proxy_arp = 0
net.ipv4.conf.eth1.proxy_arp_pvlan = 0
net.ipv4.conf.eth1.route_localnet = 0
net.ipv4.conf.eth1.rp_filter = 2
net.ipv4.conf.eth1.secure_redirects = 1
net.ipv4.conf.eth1.send_redirects = 0
net.ipv4.conf.eth1.shared_media = 1
net.ipv4.conf.eth1.src_valid_mark = 0
net.ipv4.conf.eth1.tag = 0
net.ipv4.conf.eth2.accept_local = 0
net.ipv4.conf.eth2.accept_redirects = 0
net.ipv4.conf.eth2.accept_source_route = 0
net.ipv4.conf.eth2.arp_accept = 0
net.ipv4.conf.eth2.arp_announce = 0
net.ipv4.conf.eth2.arp_evict_nocarrier = 1
net.ipv4.conf.eth2.arp_filter = 0
net.ipv4.conf.eth2.arp_ignore = 0
net.ipv4.conf.eth2.arp_notify = 0
net.ipv4.conf.eth2.bc_forwarding = 0
net.ipv4.conf.eth2.bootp_relay = 0
net.ipv4.conf.eth2.disable_policy = 0
net.ipv4.conf.eth2.disable_xfrm = 0
net.ipv4.conf.eth2.drop_gratuitous_arp = 0
net.ipv4.conf.eth2.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.eth2.force_igmp_version = 0
net.ipv4.conf.eth2.forwarding = 1
net.ipv4.conf.eth2.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.eth2.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.eth2.ignore_routes_with_linkdown = 0
net.ipv4.conf.eth2.log_martians = 0
net.ipv4.conf.eth2.mc_forwarding = 0
net.ipv4.conf.eth2.medium_id = 0
net.ipv4.conf.eth2.promote_secondaries = 1
net.ipv4.conf.eth2.proxy_arp = 0
net.ipv4.conf.eth2.proxy_arp_pvlan = 0
net.ipv4.conf.eth2.route_localnet = 0
net.ipv4.conf.eth2.rp_filter = 2
net.ipv4.conf.eth2.secure_redirects = 1
net.ipv4.conf.eth2.send_redirects = 0
net.ipv4.conf.eth2.shared_media = 1
net.ipv4.conf.eth2.src_valid_mark = 0
net.ipv4.conf.eth2.tag = 0
net.ipv4.conf.eth3.accept_local = 0
net.ipv4.conf.eth3.accept_redirects = 0
net.ipv4.conf.eth3.accept_source_route = 0
net.ipv4.conf.eth3.arp_accept = 0
net.ipv4.conf.eth3.arp_announce = 0
net.ipv4.conf.eth3.arp_evict_nocarrier = 1
net.ipv4.conf.eth3.arp_filter = 0
net.ipv4.conf.eth3.arp_ignore = 0
net.ipv4.conf.eth3.arp_notify = 0
net.ipv4.conf.eth3.bc_forwarding = 0
net.ipv4.conf.eth3.bootp_relay = 0
net.ipv4.conf.eth3.disable_policy = 0
net.ipv4.conf.eth3.disable_xfrm = 0
net.ipv4.conf.eth3.drop_gratuitous_arp = 0
net.ipv4.conf.eth3.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.eth3.force_igmp_version = 0
net.ipv4.conf.eth3.forwarding = 1
net.ipv4.conf.eth3.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.eth3.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.eth3.ignore_routes_with_linkdown = 0
net.ipv4.conf.eth3.log_martians = 0
net.ipv4.conf.eth3.mc_forwarding = 0
net.ipv4.conf.eth3.medium_id = 0
net.ipv4.conf.eth3.promote_secondaries = 1
net.ipv4.conf.eth3.proxy_arp = 0
net.ipv4.conf.eth3.proxy_arp_pvlan = 0
net.ipv4.conf.eth3.route_localnet = 0
net.ipv4.conf.eth3.rp_filter = 2
net.ipv4.conf.eth3.secure_redirects = 1
net.ipv4.conf.eth3.send_redirects = 0
net.ipv4.conf.eth3.shared_media = 1
net.ipv4.conf.eth3.src_valid_mark = 0
net.ipv4.conf.eth3.tag = 0
net.ipv4.conf.lo.accept_local = 0
net.ipv4.conf.lo.accept_redirects = 1
net.ipv4.conf.lo.accept_source_route = 0
net.ipv4.conf.lo.arp_accept = 0
net.ipv4.conf.lo.arp_announce = 0
net.ipv4.conf.lo.arp_evict_nocarrier = 1
net.ipv4.conf.lo.arp_filter = 0
net.ipv4.conf.lo.arp_ignore = 0
net.ipv4.conf.lo.arp_notify = 0
net.ipv4.conf.lo.bc_forwarding = 0
net.ipv4.conf.lo.bootp_relay = 0
net.ipv4.conf.lo.disable_policy = 1
net.ipv4.conf.lo.disable_xfrm = 1
net.ipv4.conf.lo.drop_gratuitous_arp = 0
net.ipv4.conf.lo.drop_unicast_in_l2_multicast = 0
net.ipv4.conf.lo.force_igmp_version = 0
net.ipv4.conf.lo.forwarding = 1
net.ipv4.conf.lo.igmpv2_unsolicited_report_interval = 10000
net.ipv4.conf.lo.igmpv3_unsolicited_report_interval = 1000
net.ipv4.conf.lo.ignore_routes_with_linkdown = 0
net.ipv4.conf.lo.log_martians = 0
net.ipv4.conf.lo.mc_forwarding = 0
net.ipv4.conf.lo.medium_id = 0
net.ipv4.conf.lo.promote_secondaries = 1
net.ipv4.conf.lo.proxy_arp = 0
net.ipv4.conf.lo.proxy_arp_pvlan = 0
net.ipv4.conf.lo.route_localnet = 0
net.ipv4.conf.lo.rp_filter = 2
net.ipv4.conf.lo.secure_redirects = 1
net.ipv4.conf.lo.send_redirects = 1
net.ipv4.conf.lo.shared_media = 1
net.ipv4.conf.lo.src_valid_mark = 0
net.ipv4.conf.lo.tag = 0
net.ipv4.fib_multipath_hash_fields = 7
net.ipv4.fib_multipath_hash_policy = 0
net.ipv4.fib_multipath_use_neigh = 0
net.ipv4.fib_notify_on_flag_change = 0
net.ipv4.fib_sync_mem = 524288
net.ipv4.fwmark_reflect = 0
net.ipv4.icmp_echo_enable_probe = 0
net.ipv4.icmp_echo_ignore_all = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_errors_use_inbound_ifaddr = 0
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.icmp_msgs_burst = 50
net.ipv4.icmp_msgs_per_sec = 1000
net.ipv4.icmp_ratelimit = 1000
net.ipv4.icmp_ratemask = 6168
net.ipv4.igmp_link_local_mcast_reports = 1
net.ipv4.igmp_max_memberships = 20
net.ipv4.igmp_max_msf = 10
net.ipv4.igmp_qrv = 2
net.ipv4.inet_peer_maxttl = 600
net.ipv4.inet_peer_minttl = 120
net.ipv4.inet_peer_threshold = 65664
net.ipv4.ip_autobind_reuse = 0
net.ipv4.ip_default_ttl = 64
net.ipv4.ip_dynaddr = 0
net.ipv4.ip_early_demux = 1
net.ipv4.ip_forward = 1
net.ipv4.ip_forward_update_priority = 1
net.ipv4.ip_forward_use_pmtu = 0
net.ipv4.ip_local_port_range = 32768    60999
net.ipv4.ip_local_reserved_ports =
net.ipv4.ip_no_pmtu_disc = 0
net.ipv4.ip_nonlocal_bind = 0
net.ipv4.ip_unprivileged_port_start = 1024
net.ipv4.ipfrag_high_thresh = 4194304
net.ipv4.ipfrag_low_thresh = 3145728
net.ipv4.ipfrag_max_dist = 64
net.ipv4.ipfrag_secret_interval = 0
net.ipv4.ipfrag_time = 30
net.ipv4.neigh.default.anycast_delay = 100
net.ipv4.neigh.default.app_solicit = 0
net.ipv4.neigh.default.base_reachable_time_ms = 30000
net.ipv4.neigh.default.delay_first_probe_time = 5
net.ipv4.neigh.default.gc_interval = 30
net.ipv4.neigh.default.gc_stale_time = 60
net.ipv4.neigh.default.gc_thresh1 = 128
net.ipv4.neigh.default.gc_thresh2 = 512
net.ipv4.neigh.default.gc_thresh3 = 1024
net.ipv4.neigh.default.interval_probe_time_ms = 5000
net.ipv4.neigh.default.locktime = 100
net.ipv4.neigh.default.mcast_resolicit = 0
net.ipv4.neigh.default.mcast_solicit = 3
net.ipv4.neigh.default.proxy_delay = 80
net.ipv4.neigh.default.proxy_qlen = 64
net.ipv4.neigh.default.retrans_time_ms = 1000
net.ipv4.neigh.default.ucast_solicit = 3
net.ipv4.neigh.default.unres_qlen = 101
net.ipv4.neigh.default.unres_qlen_bytes = 212992
net.ipv4.neigh.docker0.anycast_delay = 100
net.ipv4.neigh.docker0.app_solicit = 0
net.ipv4.neigh.docker0.base_reachable_time_ms = 30000
net.ipv4.neigh.docker0.delay_first_probe_time = 5
net.ipv4.neigh.docker0.gc_stale_time = 60
net.ipv4.neigh.docker0.interval_probe_time_ms = 5000
net.ipv4.neigh.docker0.locktime = 100
net.ipv4.neigh.docker0.mcast_resolicit = 0
net.ipv4.neigh.docker0.mcast_solicit = 3
net.ipv4.neigh.docker0.proxy_delay = 80
net.ipv4.neigh.docker0.proxy_qlen = 64
net.ipv4.neigh.docker0.retrans_time_ms = 1000
net.ipv4.neigh.docker0.ucast_solicit = 3
net.ipv4.neigh.docker0.unres_qlen = 101
net.ipv4.neigh.docker0.unres_qlen_bytes = 212992
net.ipv4.neigh.eth0.anycast_delay = 100
net.ipv4.neigh.eth0.app_solicit = 0
net.ipv4.neigh.eth0.base_reachable_time_ms = 30000
net.ipv4.neigh.eth0.delay_first_probe_time = 5
net.ipv4.neigh.eth0.gc_stale_time = 60
net.ipv4.neigh.eth0.interval_probe_time_ms = 5000
net.ipv4.neigh.eth0.locktime = 100
net.ipv4.neigh.eth0.mcast_resolicit = 0
net.ipv4.neigh.eth0.mcast_solicit = 3
net.ipv4.neigh.eth0.proxy_delay = 80
net.ipv4.neigh.eth0.proxy_qlen = 64
net.ipv4.neigh.eth0.retrans_time_ms = 1000
net.ipv4.neigh.eth0.ucast_solicit = 3
net.ipv4.neigh.eth0.unres_qlen = 101
net.ipv4.neigh.eth0.unres_qlen_bytes = 212992
net.ipv4.neigh.eth1.anycast_delay = 100
net.ipv4.neigh.eth1.app_solicit = 0
net.ipv4.neigh.eth1.base_reachable_time_ms = 30000
net.ipv4.neigh.eth1.delay_first_probe_time = 5
net.ipv4.neigh.eth1.gc_stale_time = 60
net.ipv4.neigh.eth1.interval_probe_time_ms = 5000
net.ipv4.neigh.eth1.locktime = 100
net.ipv4.neigh.eth1.mcast_resolicit = 0
net.ipv4.neigh.eth1.mcast_solicit = 3
net.ipv4.neigh.eth1.proxy_delay = 80
net.ipv4.neigh.eth1.proxy_qlen = 64
net.ipv4.neigh.eth1.retrans_time_ms = 1000
net.ipv4.neigh.eth1.ucast_solicit = 3
net.ipv4.neigh.eth1.unres_qlen = 101
net.ipv4.neigh.eth1.unres_qlen_bytes = 212992
net.ipv4.neigh.eth2.anycast_delay = 100
net.ipv4.neigh.eth2.app_solicit = 0
net.ipv4.neigh.eth2.base_reachable_time_ms = 30000
net.ipv4.neigh.eth2.delay_first_probe_time = 5
net.ipv4.neigh.eth2.gc_stale_time = 60
net.ipv4.neigh.eth2.interval_probe_time_ms = 5000
net.ipv4.neigh.eth2.locktime = 100
net.ipv4.neigh.eth2.mcast_resolicit = 0
net.ipv4.neigh.eth2.mcast_solicit = 3
net.ipv4.neigh.eth2.proxy_delay = 80
net.ipv4.neigh.eth2.proxy_qlen = 64
net.ipv4.neigh.eth2.retrans_time_ms = 1000
net.ipv4.neigh.eth2.ucast_solicit = 3
net.ipv4.neigh.eth2.unres_qlen = 101
net.ipv4.neigh.eth2.unres_qlen_bytes = 212992
net.ipv4.neigh.eth3.anycast_delay = 100
net.ipv4.neigh.eth3.app_solicit = 0
net.ipv4.neigh.eth3.base_reachable_time_ms = 30000
net.ipv4.neigh.eth3.delay_first_probe_time = 5
net.ipv4.neigh.eth3.gc_stale_time = 60
net.ipv4.neigh.eth3.interval_probe_time_ms = 5000
net.ipv4.neigh.eth3.locktime = 100
net.ipv4.neigh.eth3.mcast_resolicit = 0
net.ipv4.neigh.eth3.mcast_solicit = 3
net.ipv4.neigh.eth3.proxy_delay = 80
net.ipv4.neigh.eth3.proxy_qlen = 64
net.ipv4.neigh.eth3.retrans_time_ms = 1000
net.ipv4.neigh.eth3.ucast_solicit = 3
net.ipv4.neigh.eth3.unres_qlen = 101
net.ipv4.neigh.eth3.unres_qlen_bytes = 212992
net.ipv4.neigh.lo.anycast_delay = 100
net.ipv4.neigh.lo.app_solicit = 0
net.ipv4.neigh.lo.base_reachable_time_ms = 30000
net.ipv4.neigh.lo.delay_first_probe_time = 5
net.ipv4.neigh.lo.gc_stale_time = 60
net.ipv4.neigh.lo.interval_probe_time_ms = 5000
net.ipv4.neigh.lo.locktime = 100
net.ipv4.neigh.lo.mcast_resolicit = 0
net.ipv4.neigh.lo.mcast_solicit = 3
net.ipv4.neigh.lo.proxy_delay = 80
net.ipv4.neigh.lo.proxy_qlen = 64
net.ipv4.neigh.lo.retrans_time_ms = 1000
net.ipv4.neigh.lo.ucast_solicit = 3
net.ipv4.neigh.lo.unres_qlen = 101
net.ipv4.neigh.lo.unres_qlen_bytes = 212992
net.ipv4.nexthop_compat_mode = 1
net.ipv4.ping_group_range = 0   2147483647
net.ipv4.raw_l3mdev_accept = 1
net.ipv4.route.error_burst = 1250
net.ipv4.route.error_cost = 250
net.ipv4.route.gc_elasticity = 8
net.ipv4.route.gc_interval = 60
net.ipv4.route.gc_min_interval = 0
net.ipv4.route.gc_min_interval_ms = 500
net.ipv4.route.gc_thresh = -1
net.ipv4.route.gc_timeout = 300
net.ipv4.route.max_size = 2147483647
net.ipv4.route.min_adv_mss = 256
net.ipv4.route.min_pmtu = 552
net.ipv4.route.mtu_expires = 600
net.ipv4.route.redirect_load = 5
net.ipv4.route.redirect_number = 9
net.ipv4.route.redirect_silence = 5120
net.ipv4.tcp_abort_on_overflow = 0
net.ipv4.tcp_adv_win_scale = 1
net.ipv4.tcp_allowed_congestion_control = reno cubic
net.ipv4.tcp_app_win = 31
net.ipv4.tcp_autocorking = 1
net.ipv4.tcp_available_congestion_control = reno bic cubic westwood vegas
net.ipv4.tcp_available_ulp = tls
net.ipv4.tcp_base_mss = 1024
net.ipv4.tcp_challenge_ack_limit = 2147483647
net.ipv4.tcp_child_ehash_entries = 0
net.ipv4.tcp_comp_sack_delay_ns = 1000000
net.ipv4.tcp_comp_sack_nr = 44
net.ipv4.tcp_comp_sack_slack_ns = 100000
net.ipv4.tcp_congestion_control = cubic
net.ipv4.tcp_dsack = 1
net.ipv4.tcp_early_demux = 1
net.ipv4.tcp_early_retrans = 3
net.ipv4.tcp_ecn = 2
net.ipv4.tcp_ecn_fallback = 1
net.ipv4.tcp_ehash_entries = 262144
net.ipv4.tcp_fack = 0
net.ipv4.tcp_fastopen = 1
net.ipv4.tcp_fastopen_blackhole_timeout_sec = 0
net.ipv4.tcp_fastopen_key = c8240665-597927c0-7915b17e-b650917f
net.ipv4.tcp_fin_timeout = 60
net.ipv4.tcp_frto = 2
net.ipv4.tcp_fwmark_accept = 0
net.ipv4.tcp_invalid_ratelimit = 500
net.ipv4.tcp_keepalive_intvl = 75
net.ipv4.tcp_keepalive_probes = 9
net.ipv4.tcp_keepalive_time = 7200
net.ipv4.tcp_l3mdev_accept = 0
net.ipv4.tcp_limit_output_bytes = 1048576
net.ipv4.tcp_low_latency = 0
net.ipv4.tcp_max_orphans = 131072
net.ipv4.tcp_max_reordering = 300
net.ipv4.tcp_max_syn_backlog = 2048
net.ipv4.tcp_max_tw_buckets = 131072
net.ipv4.tcp_mem = 226611       302148  453222
net.ipv4.tcp_migrate_req = 0
net.ipv4.tcp_min_rtt_wlen = 300
net.ipv4.tcp_min_snd_mss = 48
net.ipv4.tcp_min_tso_segs = 2
net.ipv4.tcp_moderate_rcvbuf = 1
net.ipv4.tcp_mtu_probe_floor = 48
net.ipv4.tcp_mtu_probing = 0
net.ipv4.tcp_no_metrics_save = 0
net.ipv4.tcp_no_ssthresh_metrics_save = 1
net.ipv4.tcp_notsent_lowat = 4294967295
net.ipv4.tcp_orphan_retries = 0
net.ipv4.tcp_pacing_ca_ratio = 120
net.ipv4.tcp_pacing_ss_ratio = 200
net.ipv4.tcp_plb_cong_thresh = 128
net.ipv4.tcp_plb_enabled = 0
net.ipv4.tcp_plb_idle_rehash_rounds = 3
net.ipv4.tcp_plb_rehash_rounds = 12
net.ipv4.tcp_plb_suspend_rto_sec = 60
net.ipv4.tcp_probe_interval = 600
net.ipv4.tcp_probe_threshold = 8
net.ipv4.tcp_recovery = 1
net.ipv4.tcp_reflect_tos = 0
net.ipv4.tcp_reordering = 3
net.ipv4.tcp_retrans_collapse = 1
net.ipv4.tcp_retries1 = 3
net.ipv4.tcp_retries2 = 15
net.ipv4.tcp_rfc1337 = 0
net.ipv4.tcp_rmem = 4096        131072  6291456
net.ipv4.tcp_sack = 1
net.ipv4.tcp_slow_start_after_idle = 1
net.ipv4.tcp_stdurg = 0
net.ipv4.tcp_syn_linear_timeouts = 4
net.ipv4.tcp_syn_retries = 6
net.ipv4.tcp_synack_retries = 5
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_thin_linear_timeouts = 0
net.ipv4.tcp_timestamps = 1
net.ipv4.tcp_tso_rtt_log = 9
net.ipv4.tcp_tso_win_divisor = 3
net.ipv4.tcp_tw_reuse = 2
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_wmem = 4096        16384   4194304
net.ipv4.tcp_workaround_signed_windows = 0
net.ipv4.udp_child_hash_entries = 0
net.ipv4.udp_early_demux = 1
net.ipv4.udp_hash_entries = 16384
net.ipv4.udp_l3mdev_accept = 0
net.ipv4.udp_mem = 453222       604296  906444
net.ipv4.udp_rmem_min = 4096
net.ipv4.udp_wmem_min = 4096
net.ipv4.xfrm4_gc_thresh = 32768
net.ipv6.anycast_src_echo_reply = 0
net.ipv6.auto_flowlabels = 1
net.ipv6.bindv6only = 0
net.ipv6.conf.all.accept_dad = 0
net.ipv6.conf.all.accept_ra = 1
net.ipv6.conf.all.accept_ra_defrtr = 1
net.ipv6.conf.all.accept_ra_from_local = 0
net.ipv6.conf.all.accept_ra_min_hop_limit = 1
net.ipv6.conf.all.accept_ra_mtu = 1
net.ipv6.conf.all.accept_ra_pinfo = 1
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_source_route = 0
net.ipv6.conf.all.accept_untracked_na = 0
net.ipv6.conf.all.addr_gen_mode = 0
net.ipv6.conf.all.autoconf = 1
net.ipv6.conf.all.dad_transmits = 1
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.all.disable_policy = 0
net.ipv6.conf.all.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.all.drop_unsolicited_na = 0
net.ipv6.conf.all.enhanced_dad = 1
net.ipv6.conf.all.force_mld_version = 0
net.ipv6.conf.all.force_tllao = 0
net.ipv6.conf.all.forwarding = 0
net.ipv6.conf.all.hop_limit = 64
net.ipv6.conf.all.ignore_routes_with_linkdown = 0
net.ipv6.conf.all.ioam6_enabled = 0
net.ipv6.conf.all.ioam6_id = 65535
net.ipv6.conf.all.ioam6_id_wide = 4294967295
net.ipv6.conf.all.keep_addr_on_down = 0
net.ipv6.conf.all.max_addresses = 16
net.ipv6.conf.all.max_desync_factor = 600
net.ipv6.conf.all.mc_forwarding = 0
net.ipv6.conf.all.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.all.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.all.mtu = 1280
net.ipv6.conf.all.ndisc_evict_nocarrier = 1
net.ipv6.conf.all.ndisc_notify = 0
net.ipv6.conf.all.ndisc_tclass = 0
net.ipv6.conf.all.proxy_ndp = 0
net.ipv6.conf.all.ra_defrtr_metric = 1024
net.ipv6.conf.all.regen_max_retry = 3
net.ipv6.conf.all.router_solicitation_delay = 1
net.ipv6.conf.all.router_solicitation_interval = 4
net.ipv6.conf.all.router_solicitation_max_interval = 3600
net.ipv6.conf.all.router_solicitations = -1
net.ipv6.conf.all.rpl_seg_enabled = 0
net.ipv6.conf.all.seg6_enabled = 0
net.ipv6.conf.all.suppress_frag_ndisc = 1
net.ipv6.conf.all.temp_prefered_lft = 86400
net.ipv6.conf.all.temp_valid_lft = 604800
net.ipv6.conf.all.use_oif_addrs_only = 0
net.ipv6.conf.all.use_tempaddr = 0
net.ipv6.conf.default.accept_dad = 1
net.ipv6.conf.default.accept_ra = 1
net.ipv6.conf.default.accept_ra_defrtr = 1
net.ipv6.conf.default.accept_ra_from_local = 0
net.ipv6.conf.default.accept_ra_min_hop_limit = 1
net.ipv6.conf.default.accept_ra_mtu = 1
net.ipv6.conf.default.accept_ra_pinfo = 1
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.default.accept_source_route = 0
net.ipv6.conf.default.accept_untracked_na = 0
net.ipv6.conf.default.addr_gen_mode = 0
net.ipv6.conf.default.autoconf = 1
net.ipv6.conf.default.dad_transmits = 1
net.ipv6.conf.default.disable_ipv6 = 0
net.ipv6.conf.default.disable_policy = 0
net.ipv6.conf.default.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.default.drop_unsolicited_na = 0
net.ipv6.conf.default.enhanced_dad = 1
net.ipv6.conf.default.force_mld_version = 0
net.ipv6.conf.default.force_tllao = 0
net.ipv6.conf.default.forwarding = 0
net.ipv6.conf.default.hop_limit = 64
net.ipv6.conf.default.ignore_routes_with_linkdown = 0
net.ipv6.conf.default.ioam6_enabled = 0
net.ipv6.conf.default.ioam6_id = 65535
net.ipv6.conf.default.ioam6_id_wide = 4294967295
net.ipv6.conf.default.keep_addr_on_down = 0
net.ipv6.conf.default.max_addresses = 16
net.ipv6.conf.default.max_desync_factor = 600
net.ipv6.conf.default.mc_forwarding = 0
net.ipv6.conf.default.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.default.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.default.mtu = 1280
net.ipv6.conf.default.ndisc_evict_nocarrier = 1
net.ipv6.conf.default.ndisc_notify = 0
net.ipv6.conf.default.ndisc_tclass = 0
net.ipv6.conf.default.proxy_ndp = 0
net.ipv6.conf.default.ra_defrtr_metric = 1024
net.ipv6.conf.default.regen_max_retry = 3
net.ipv6.conf.default.router_solicitation_delay = 1
net.ipv6.conf.default.router_solicitation_interval = 4
net.ipv6.conf.default.router_solicitation_max_interval = 3600
net.ipv6.conf.default.router_solicitations = -1
net.ipv6.conf.default.rpl_seg_enabled = 0
net.ipv6.conf.default.seg6_enabled = 0
net.ipv6.conf.default.suppress_frag_ndisc = 1
net.ipv6.conf.default.temp_prefered_lft = 86400
net.ipv6.conf.default.temp_valid_lft = 604800
net.ipv6.conf.default.use_oif_addrs_only = 0
net.ipv6.conf.default.use_tempaddr = 0
net.ipv6.conf.docker0.accept_dad = 1
net.ipv6.conf.docker0.accept_ra = 0
net.ipv6.conf.docker0.accept_ra_defrtr = 1
net.ipv6.conf.docker0.accept_ra_from_local = 0
net.ipv6.conf.docker0.accept_ra_min_hop_limit = 1
net.ipv6.conf.docker0.accept_ra_mtu = 1
net.ipv6.conf.docker0.accept_ra_pinfo = 1
net.ipv6.conf.docker0.accept_redirects = 0
net.ipv6.conf.docker0.accept_source_route = 0
net.ipv6.conf.docker0.accept_untracked_na = 0
net.ipv6.conf.docker0.addr_gen_mode = 0
net.ipv6.conf.docker0.autoconf = 1
net.ipv6.conf.docker0.dad_transmits = 1
net.ipv6.conf.docker0.disable_ipv6 = 0
net.ipv6.conf.docker0.disable_policy = 0
net.ipv6.conf.docker0.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.docker0.drop_unsolicited_na = 0
net.ipv6.conf.docker0.enhanced_dad = 1
net.ipv6.conf.docker0.force_mld_version = 0
net.ipv6.conf.docker0.force_tllao = 0
net.ipv6.conf.docker0.forwarding = 0
net.ipv6.conf.docker0.hop_limit = 64
net.ipv6.conf.docker0.ignore_routes_with_linkdown = 0
net.ipv6.conf.docker0.ioam6_enabled = 0
net.ipv6.conf.docker0.ioam6_id = 65535
net.ipv6.conf.docker0.ioam6_id_wide = 4294967295
net.ipv6.conf.docker0.keep_addr_on_down = 0
net.ipv6.conf.docker0.max_addresses = 16
net.ipv6.conf.docker0.max_desync_factor = 600
net.ipv6.conf.docker0.mc_forwarding = 0
net.ipv6.conf.docker0.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.docker0.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.docker0.mtu = 1500
net.ipv6.conf.docker0.ndisc_evict_nocarrier = 1
net.ipv6.conf.docker0.ndisc_notify = 0
net.ipv6.conf.docker0.ndisc_tclass = 0
net.ipv6.conf.docker0.proxy_ndp = 0
net.ipv6.conf.docker0.ra_defrtr_metric = 1024
net.ipv6.conf.docker0.regen_max_retry = 3
net.ipv6.conf.docker0.router_solicitation_delay = 1
net.ipv6.conf.docker0.router_solicitation_interval = 4
net.ipv6.conf.docker0.router_solicitation_max_interval = 3600
net.ipv6.conf.docker0.router_solicitations = -1
net.ipv6.conf.docker0.rpl_seg_enabled = 0
net.ipv6.conf.docker0.seg6_enabled = 0
net.ipv6.conf.docker0.suppress_frag_ndisc = 1
net.ipv6.conf.docker0.temp_prefered_lft = 86400
net.ipv6.conf.docker0.temp_valid_lft = 604800
net.ipv6.conf.docker0.use_oif_addrs_only = 0
net.ipv6.conf.docker0.use_tempaddr = 0
net.ipv6.conf.eth0.accept_dad = 1
net.ipv6.conf.eth0.accept_ra = 0
net.ipv6.conf.eth0.accept_ra_defrtr = 1
net.ipv6.conf.eth0.accept_ra_from_local = 0
net.ipv6.conf.eth0.accept_ra_min_hop_limit = 1
net.ipv6.conf.eth0.accept_ra_mtu = 1
net.ipv6.conf.eth0.accept_ra_pinfo = 1
net.ipv6.conf.eth0.accept_redirects = 1
net.ipv6.conf.eth0.accept_source_route = 0
net.ipv6.conf.eth0.accept_untracked_na = 0
net.ipv6.conf.eth0.addr_gen_mode = 1
net.ipv6.conf.eth0.autoconf = 1
net.ipv6.conf.eth0.dad_transmits = 1
net.ipv6.conf.eth0.disable_ipv6 = 0
net.ipv6.conf.eth0.disable_policy = 0
net.ipv6.conf.eth0.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.eth0.drop_unsolicited_na = 0
net.ipv6.conf.eth0.enhanced_dad = 1
net.ipv6.conf.eth0.force_mld_version = 0
net.ipv6.conf.eth0.force_tllao = 0
net.ipv6.conf.eth0.forwarding = 0
net.ipv6.conf.eth0.hop_limit = 64
net.ipv6.conf.eth0.ignore_routes_with_linkdown = 0
net.ipv6.conf.eth0.ioam6_enabled = 0
net.ipv6.conf.eth0.ioam6_id = 65535
net.ipv6.conf.eth0.ioam6_id_wide = 4294967295
net.ipv6.conf.eth0.keep_addr_on_down = 0
net.ipv6.conf.eth0.max_addresses = 16
net.ipv6.conf.eth0.max_desync_factor = 600
net.ipv6.conf.eth0.mc_forwarding = 0
net.ipv6.conf.eth0.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.eth0.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.eth0.mtu = 1500
net.ipv6.conf.eth0.ndisc_evict_nocarrier = 1
net.ipv6.conf.eth0.ndisc_notify = 0
net.ipv6.conf.eth0.ndisc_tclass = 0
net.ipv6.conf.eth0.proxy_ndp = 0
net.ipv6.conf.eth0.ra_defrtr_metric = 1024
net.ipv6.conf.eth0.regen_max_retry = 3
net.ipv6.conf.eth0.router_solicitation_delay = 1
net.ipv6.conf.eth0.router_solicitation_interval = 4
net.ipv6.conf.eth0.router_solicitation_max_interval = 3600
net.ipv6.conf.eth0.router_solicitations = -1
net.ipv6.conf.eth0.rpl_seg_enabled = 0
net.ipv6.conf.eth0.seg6_enabled = 0
net.ipv6.conf.eth0.suppress_frag_ndisc = 1
net.ipv6.conf.eth0.temp_prefered_lft = 86400
net.ipv6.conf.eth0.temp_valid_lft = 604800
net.ipv6.conf.eth0.use_oif_addrs_only = 0
net.ipv6.conf.eth0.use_tempaddr = 0
net.ipv6.conf.eth1.accept_dad = 1
net.ipv6.conf.eth1.accept_ra = 1
net.ipv6.conf.eth1.accept_ra_defrtr = 1
net.ipv6.conf.eth1.accept_ra_from_local = 0
net.ipv6.conf.eth1.accept_ra_min_hop_limit = 1
net.ipv6.conf.eth1.accept_ra_mtu = 1
net.ipv6.conf.eth1.accept_ra_pinfo = 1
net.ipv6.conf.eth1.accept_redirects = 1
net.ipv6.conf.eth1.accept_source_route = 0
net.ipv6.conf.eth1.accept_untracked_na = 0
net.ipv6.conf.eth1.addr_gen_mode = 0
net.ipv6.conf.eth1.autoconf = 1
net.ipv6.conf.eth1.dad_transmits = 1
net.ipv6.conf.eth1.disable_ipv6 = 0
net.ipv6.conf.eth1.disable_policy = 0
net.ipv6.conf.eth1.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.eth1.drop_unsolicited_na = 0
net.ipv6.conf.eth1.enhanced_dad = 1
net.ipv6.conf.eth1.force_mld_version = 0
net.ipv6.conf.eth1.force_tllao = 0
net.ipv6.conf.eth1.forwarding = 0
net.ipv6.conf.eth1.hop_limit = 64
net.ipv6.conf.eth1.ignore_routes_with_linkdown = 0
net.ipv6.conf.eth1.ioam6_enabled = 0
net.ipv6.conf.eth1.ioam6_id = 65535
net.ipv6.conf.eth1.ioam6_id_wide = 4294967295
net.ipv6.conf.eth1.keep_addr_on_down = 0
net.ipv6.conf.eth1.max_addresses = 16
net.ipv6.conf.eth1.max_desync_factor = 600
net.ipv6.conf.eth1.mc_forwarding = 0
net.ipv6.conf.eth1.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.eth1.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.eth1.mtu = 1500
net.ipv6.conf.eth1.ndisc_evict_nocarrier = 1
net.ipv6.conf.eth1.ndisc_notify = 0
net.ipv6.conf.eth1.ndisc_tclass = 0
net.ipv6.conf.eth1.proxy_ndp = 0
net.ipv6.conf.eth1.ra_defrtr_metric = 1024
net.ipv6.conf.eth1.regen_max_retry = 3
net.ipv6.conf.eth1.router_solicitation_delay = 1
net.ipv6.conf.eth1.router_solicitation_interval = 4
net.ipv6.conf.eth1.router_solicitation_max_interval = 3600
net.ipv6.conf.eth1.router_solicitations = -1
net.ipv6.conf.eth1.rpl_seg_enabled = 0
net.ipv6.conf.eth1.seg6_enabled = 0
net.ipv6.conf.eth1.suppress_frag_ndisc = 1
net.ipv6.conf.eth1.temp_prefered_lft = 86400
net.ipv6.conf.eth1.temp_valid_lft = 604800
net.ipv6.conf.eth1.use_oif_addrs_only = 0
net.ipv6.conf.eth1.use_tempaddr = 0
net.ipv6.conf.eth2.accept_dad = 1
net.ipv6.conf.eth2.accept_ra = 1
net.ipv6.conf.eth2.accept_ra_defrtr = 1
net.ipv6.conf.eth2.accept_ra_from_local = 0
net.ipv6.conf.eth2.accept_ra_min_hop_limit = 1
net.ipv6.conf.eth2.accept_ra_mtu = 1
net.ipv6.conf.eth2.accept_ra_pinfo = 1
net.ipv6.conf.eth2.accept_redirects = 0
net.ipv6.conf.eth2.accept_source_route = 0
net.ipv6.conf.eth2.accept_untracked_na = 0
net.ipv6.conf.eth2.addr_gen_mode = 0
net.ipv6.conf.eth2.autoconf = 1
net.ipv6.conf.eth2.dad_transmits = 1
net.ipv6.conf.eth2.disable_ipv6 = 0
net.ipv6.conf.eth2.disable_policy = 0
net.ipv6.conf.eth2.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.eth2.drop_unsolicited_na = 0
net.ipv6.conf.eth2.enhanced_dad = 1
net.ipv6.conf.eth2.force_mld_version = 0
net.ipv6.conf.eth2.force_tllao = 0
net.ipv6.conf.eth2.forwarding = 0
net.ipv6.conf.eth2.hop_limit = 64
net.ipv6.conf.eth2.ignore_routes_with_linkdown = 0
net.ipv6.conf.eth2.ioam6_enabled = 0
net.ipv6.conf.eth2.ioam6_id = 65535
net.ipv6.conf.eth2.ioam6_id_wide = 4294967295
net.ipv6.conf.eth2.keep_addr_on_down = 0
net.ipv6.conf.eth2.max_addresses = 16
net.ipv6.conf.eth2.max_desync_factor = 600
net.ipv6.conf.eth2.mc_forwarding = 0
net.ipv6.conf.eth2.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.eth2.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.eth2.mtu = 1500
net.ipv6.conf.eth2.ndisc_evict_nocarrier = 1
net.ipv6.conf.eth2.ndisc_notify = 0
net.ipv6.conf.eth2.ndisc_tclass = 0
net.ipv6.conf.eth2.proxy_ndp = 0
net.ipv6.conf.eth2.ra_defrtr_metric = 1024
net.ipv6.conf.eth2.regen_max_retry = 3
net.ipv6.conf.eth2.router_solicitation_delay = 1
net.ipv6.conf.eth2.router_solicitation_interval = 4
net.ipv6.conf.eth2.router_solicitation_max_interval = 3600
net.ipv6.conf.eth2.router_solicitations = -1
net.ipv6.conf.eth2.rpl_seg_enabled = 0
net.ipv6.conf.eth2.seg6_enabled = 0
net.ipv6.conf.eth2.suppress_frag_ndisc = 1
net.ipv6.conf.eth2.temp_prefered_lft = 86400
net.ipv6.conf.eth2.temp_valid_lft = 604800
net.ipv6.conf.eth2.use_oif_addrs_only = 0
net.ipv6.conf.eth2.use_tempaddr = 0
net.ipv6.conf.eth3.accept_dad = 1
net.ipv6.conf.eth3.accept_ra = 1
net.ipv6.conf.eth3.accept_ra_defrtr = 1
net.ipv6.conf.eth3.accept_ra_from_local = 0
net.ipv6.conf.eth3.accept_ra_min_hop_limit = 1
net.ipv6.conf.eth3.accept_ra_mtu = 1
net.ipv6.conf.eth3.accept_ra_pinfo = 1
net.ipv6.conf.eth3.accept_redirects = 0
net.ipv6.conf.eth3.accept_source_route = 0
net.ipv6.conf.eth3.accept_untracked_na = 0
net.ipv6.conf.eth3.addr_gen_mode = 0
net.ipv6.conf.eth3.autoconf = 1
net.ipv6.conf.eth3.dad_transmits = 1
net.ipv6.conf.eth3.disable_ipv6 = 0
net.ipv6.conf.eth3.disable_policy = 0
net.ipv6.conf.eth3.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.eth3.drop_unsolicited_na = 0
net.ipv6.conf.eth3.enhanced_dad = 1
net.ipv6.conf.eth3.force_mld_version = 0
net.ipv6.conf.eth3.force_tllao = 0
net.ipv6.conf.eth3.forwarding = 0
net.ipv6.conf.eth3.hop_limit = 64
net.ipv6.conf.eth3.ignore_routes_with_linkdown = 0
net.ipv6.conf.eth3.ioam6_enabled = 0
net.ipv6.conf.eth3.ioam6_id = 65535
net.ipv6.conf.eth3.ioam6_id_wide = 4294967295
net.ipv6.conf.eth3.keep_addr_on_down = 0
net.ipv6.conf.eth3.max_addresses = 16
net.ipv6.conf.eth3.max_desync_factor = 600
net.ipv6.conf.eth3.mc_forwarding = 0
net.ipv6.conf.eth3.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.eth3.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.eth3.mtu = 1500
net.ipv6.conf.eth3.ndisc_evict_nocarrier = 1
net.ipv6.conf.eth3.ndisc_notify = 0
net.ipv6.conf.eth3.ndisc_tclass = 0
net.ipv6.conf.eth3.proxy_ndp = 0
net.ipv6.conf.eth3.ra_defrtr_metric = 1024
net.ipv6.conf.eth3.regen_max_retry = 3
net.ipv6.conf.eth3.router_solicitation_delay = 1
net.ipv6.conf.eth3.router_solicitation_interval = 4
net.ipv6.conf.eth3.router_solicitation_max_interval = 3600
net.ipv6.conf.eth3.router_solicitations = -1
net.ipv6.conf.eth3.rpl_seg_enabled = 0
net.ipv6.conf.eth3.seg6_enabled = 0
net.ipv6.conf.eth3.suppress_frag_ndisc = 1
net.ipv6.conf.eth3.temp_prefered_lft = 86400
net.ipv6.conf.eth3.temp_valid_lft = 604800
net.ipv6.conf.eth3.use_oif_addrs_only = 0
net.ipv6.conf.eth3.use_tempaddr = 0
net.ipv6.conf.lo.accept_dad = -1
net.ipv6.conf.lo.accept_ra = 1
net.ipv6.conf.lo.accept_ra_defrtr = 1
net.ipv6.conf.lo.accept_ra_from_local = 0
net.ipv6.conf.lo.accept_ra_min_hop_limit = 1
net.ipv6.conf.lo.accept_ra_mtu = 1
net.ipv6.conf.lo.accept_ra_pinfo = 1
net.ipv6.conf.lo.accept_redirects = 1
net.ipv6.conf.lo.accept_source_route = 0
net.ipv6.conf.lo.accept_untracked_na = 0
net.ipv6.conf.lo.addr_gen_mode = 0
net.ipv6.conf.lo.autoconf = 1
net.ipv6.conf.lo.dad_transmits = 1
net.ipv6.conf.lo.disable_ipv6 = 0
net.ipv6.conf.lo.disable_policy = 0
net.ipv6.conf.lo.drop_unicast_in_l2_multicast = 0
net.ipv6.conf.lo.drop_unsolicited_na = 0
net.ipv6.conf.lo.enhanced_dad = 1
net.ipv6.conf.lo.force_mld_version = 0
net.ipv6.conf.lo.force_tllao = 0
net.ipv6.conf.lo.forwarding = 0
net.ipv6.conf.lo.hop_limit = 64
net.ipv6.conf.lo.ignore_routes_with_linkdown = 0
net.ipv6.conf.lo.ioam6_enabled = 0
net.ipv6.conf.lo.ioam6_id = 65535
net.ipv6.conf.lo.ioam6_id_wide = 4294967295
net.ipv6.conf.lo.keep_addr_on_down = 0
net.ipv6.conf.lo.max_addresses = 16
net.ipv6.conf.lo.max_desync_factor = 600
net.ipv6.conf.lo.mc_forwarding = 0
net.ipv6.conf.lo.mldv1_unsolicited_report_interval = 10000
net.ipv6.conf.lo.mldv2_unsolicited_report_interval = 1000
net.ipv6.conf.lo.mtu = 65536
net.ipv6.conf.lo.ndisc_evict_nocarrier = 1
net.ipv6.conf.lo.ndisc_notify = 0
net.ipv6.conf.lo.ndisc_tclass = 0
net.ipv6.conf.lo.proxy_ndp = 0
net.ipv6.conf.lo.ra_defrtr_metric = 1024
net.ipv6.conf.lo.regen_max_retry = 3
net.ipv6.conf.lo.router_solicitation_delay = 1
net.ipv6.conf.lo.router_solicitation_interval = 4
net.ipv6.conf.lo.router_solicitation_max_interval = 3600
net.ipv6.conf.lo.router_solicitations = -1
net.ipv6.conf.lo.rpl_seg_enabled = 0
net.ipv6.conf.lo.seg6_enabled = 0
net.ipv6.conf.lo.suppress_frag_ndisc = 1
net.ipv6.conf.lo.temp_prefered_lft = 86400
net.ipv6.conf.lo.temp_valid_lft = 604800
net.ipv6.conf.lo.use_oif_addrs_only = 0
net.ipv6.conf.lo.use_tempaddr = -1
net.ipv6.fib_multipath_hash_fields = 7
net.ipv6.fib_multipath_hash_policy = 0
net.ipv6.fib_notify_on_flag_change = 0
net.ipv6.flowlabel_consistency = 1
net.ipv6.flowlabel_reflect = 0
net.ipv6.flowlabel_state_ranges = 0
net.ipv6.fwmark_reflect = 0
net.ipv6.icmp.echo_ignore_all = 0
net.ipv6.icmp.echo_ignore_anycast = 0
net.ipv6.icmp.echo_ignore_multicast = 0
net.ipv6.icmp.error_anycast_as_unicast = 0
net.ipv6.icmp.ratelimit = 1000
net.ipv6.icmp.ratemask = 0-1,3-127
net.ipv6.idgen_delay = 1
net.ipv6.idgen_retries = 3
net.ipv6.ioam6_id = 16777215
net.ipv6.ioam6_id_wide = 72057594037927935
net.ipv6.ip6frag_high_thresh = 4194304
net.ipv6.ip6frag_low_thresh = 3145728
net.ipv6.ip6frag_secret_interval = 0
net.ipv6.ip6frag_time = 60
net.ipv6.ip_nonlocal_bind = 0
net.ipv6.max_dst_opts_length = 2147483647
net.ipv6.max_dst_opts_number = 8
net.ipv6.max_hbh_length = 2147483647
net.ipv6.max_hbh_opts_number = 8
net.ipv6.mld_max_msf = 64
net.ipv6.mld_qrv = 2
net.ipv6.neigh.default.anycast_delay = 100
net.ipv6.neigh.default.app_solicit = 0
net.ipv6.neigh.default.base_reachable_time_ms = 30000
net.ipv6.neigh.default.delay_first_probe_time = 5
net.ipv6.neigh.default.gc_interval = 30
net.ipv6.neigh.default.gc_stale_time = 60
net.ipv6.neigh.default.gc_thresh1 = 128
net.ipv6.neigh.default.gc_thresh2 = 512
net.ipv6.neigh.default.gc_thresh3 = 1024
net.ipv6.neigh.default.interval_probe_time_ms = 5000
net.ipv6.neigh.default.locktime = 0
net.ipv6.neigh.default.mcast_resolicit = 0
net.ipv6.neigh.default.mcast_solicit = 3
net.ipv6.neigh.default.proxy_delay = 80
net.ipv6.neigh.default.proxy_qlen = 64
net.ipv6.neigh.default.retrans_time_ms = 1000
net.ipv6.neigh.default.ucast_solicit = 3
net.ipv6.neigh.default.unres_qlen = 101
net.ipv6.neigh.default.unres_qlen_bytes = 212992
net.ipv6.neigh.docker0.anycast_delay = 100
net.ipv6.neigh.docker0.app_solicit = 0
net.ipv6.neigh.docker0.base_reachable_time_ms = 30000
net.ipv6.neigh.docker0.delay_first_probe_time = 5
net.ipv6.neigh.docker0.gc_stale_time = 60
net.ipv6.neigh.docker0.interval_probe_time_ms = 5000
net.ipv6.neigh.docker0.locktime = 0
net.ipv6.neigh.docker0.mcast_resolicit = 0
net.ipv6.neigh.docker0.mcast_solicit = 3
net.ipv6.neigh.docker0.proxy_delay = 80
net.ipv6.neigh.docker0.proxy_qlen = 64
net.ipv6.neigh.docker0.retrans_time_ms = 1000
net.ipv6.neigh.docker0.ucast_solicit = 3
net.ipv6.neigh.docker0.unres_qlen = 101
net.ipv6.neigh.docker0.unres_qlen_bytes = 212992
net.ipv6.neigh.eth0.anycast_delay = 100
net.ipv6.neigh.eth0.app_solicit = 0
net.ipv6.neigh.eth0.base_reachable_time_ms = 30000
net.ipv6.neigh.eth0.delay_first_probe_time = 5
net.ipv6.neigh.eth0.gc_stale_time = 60
net.ipv6.neigh.eth0.interval_probe_time_ms = 5000
net.ipv6.neigh.eth0.locktime = 0
net.ipv6.neigh.eth0.mcast_resolicit = 0
net.ipv6.neigh.eth0.mcast_solicit = 3
net.ipv6.neigh.eth0.proxy_delay = 80
net.ipv6.neigh.eth0.proxy_qlen = 64
net.ipv6.neigh.eth0.retrans_time_ms = 1000
net.ipv6.neigh.eth0.ucast_solicit = 3
net.ipv6.neigh.eth0.unres_qlen = 101
net.ipv6.neigh.eth0.unres_qlen_bytes = 212992
net.ipv6.neigh.eth1.anycast_delay = 100
net.ipv6.neigh.eth1.app_solicit = 0
net.ipv6.neigh.eth1.base_reachable_time_ms = 30000
net.ipv6.neigh.eth1.delay_first_probe_time = 5
net.ipv6.neigh.eth1.gc_stale_time = 60
net.ipv6.neigh.eth1.interval_probe_time_ms = 5000
net.ipv6.neigh.eth1.locktime = 0
net.ipv6.neigh.eth1.mcast_resolicit = 0
net.ipv6.neigh.eth1.mcast_solicit = 3
net.ipv6.neigh.eth1.proxy_delay = 80
net.ipv6.neigh.eth1.proxy_qlen = 64
net.ipv6.neigh.eth1.retrans_time_ms = 1000
net.ipv6.neigh.eth1.ucast_solicit = 3
net.ipv6.neigh.eth1.unres_qlen = 101
net.ipv6.neigh.eth1.unres_qlen_bytes = 212992
net.ipv6.neigh.eth2.anycast_delay = 100
net.ipv6.neigh.eth2.app_solicit = 0
net.ipv6.neigh.eth2.base_reachable_time_ms = 30000
net.ipv6.neigh.eth2.delay_first_probe_time = 5
net.ipv6.neigh.eth2.gc_stale_time = 60
net.ipv6.neigh.eth2.interval_probe_time_ms = 5000
net.ipv6.neigh.eth2.locktime = 0
net.ipv6.neigh.eth2.mcast_resolicit = 0
net.ipv6.neigh.eth2.mcast_solicit = 3
net.ipv6.neigh.eth2.proxy_delay = 80
net.ipv6.neigh.eth2.proxy_qlen = 64
net.ipv6.neigh.eth2.retrans_time_ms = 1000
net.ipv6.neigh.eth2.ucast_solicit = 3
net.ipv6.neigh.eth2.unres_qlen = 101
net.ipv6.neigh.eth2.unres_qlen_bytes = 212992
net.ipv6.neigh.eth3.anycast_delay = 100
net.ipv6.neigh.eth3.app_solicit = 0
net.ipv6.neigh.eth3.base_reachable_time_ms = 30000
net.ipv6.neigh.eth3.delay_first_probe_time = 5
net.ipv6.neigh.eth3.gc_stale_time = 60
net.ipv6.neigh.eth3.interval_probe_time_ms = 5000
net.ipv6.neigh.eth3.locktime = 0
net.ipv6.neigh.eth3.mcast_resolicit = 0
net.ipv6.neigh.eth3.mcast_solicit = 3
net.ipv6.neigh.eth3.proxy_delay = 80
net.ipv6.neigh.eth3.proxy_qlen = 64
net.ipv6.neigh.eth3.retrans_time_ms = 1000
net.ipv6.neigh.eth3.ucast_solicit = 3
net.ipv6.neigh.eth3.unres_qlen = 101
net.ipv6.neigh.eth3.unres_qlen_bytes = 212992
net.ipv6.neigh.lo.anycast_delay = 100
net.ipv6.neigh.lo.app_solicit = 0
net.ipv6.neigh.lo.base_reachable_time_ms = 30000
net.ipv6.neigh.lo.delay_first_probe_time = 5
net.ipv6.neigh.lo.gc_stale_time = 60
net.ipv6.neigh.lo.interval_probe_time_ms = 5000
net.ipv6.neigh.lo.locktime = 0
net.ipv6.neigh.lo.mcast_resolicit = 0
net.ipv6.neigh.lo.mcast_solicit = 3
net.ipv6.neigh.lo.proxy_delay = 80
net.ipv6.neigh.lo.proxy_qlen = 64
net.ipv6.neigh.lo.retrans_time_ms = 1000
net.ipv6.neigh.lo.ucast_solicit = 3
net.ipv6.neigh.lo.unres_qlen = 101
net.ipv6.neigh.lo.unres_qlen_bytes = 212992
net.ipv6.route.gc_elasticity = 9
net.ipv6.route.gc_interval = 30
net.ipv6.route.gc_min_interval = 0
net.ipv6.route.gc_min_interval_ms = 500
net.ipv6.route.gc_thresh = 1024
net.ipv6.route.gc_timeout = 60
net.ipv6.route.max_size = 2147483647
net.ipv6.route.min_adv_mss = 1220
net.ipv6.route.mtu_expires = 600
net.ipv6.route.skip_notify_on_dev_down = 0
net.ipv6.seg6_flowlabel = 0
net.ipv6.xfrm6_gc_thresh = 32768
net.iw_cm.default_backlog = 256
net.netfilter.nf_conntrack_acct = 0
net.netfilter.nf_conntrack_buckets = 262144
net.netfilter.nf_conntrack_checksum = 1
net.netfilter.nf_conntrack_count = 112
net.netfilter.nf_conntrack_dccp_loose = 1
net.netfilter.nf_conntrack_dccp_timeout_closereq = 64
net.netfilter.nf_conntrack_dccp_timeout_closing = 64
net.netfilter.nf_conntrack_dccp_timeout_open = 43200
net.netfilter.nf_conntrack_dccp_timeout_partopen = 480
net.netfilter.nf_conntrack_dccp_timeout_request = 240
net.netfilter.nf_conntrack_dccp_timeout_respond = 480
net.netfilter.nf_conntrack_dccp_timeout_timewait = 240
net.netfilter.nf_conntrack_events = 2
net.netfilter.nf_conntrack_expect_max = 4096
net.netfilter.nf_conntrack_frag6_high_thresh = 4194304
net.netfilter.nf_conntrack_frag6_low_thresh = 3145728
net.netfilter.nf_conntrack_frag6_timeout = 60
net.netfilter.nf_conntrack_generic_timeout = 600
net.netfilter.nf_conntrack_gre_timeout = 30
net.netfilter.nf_conntrack_gre_timeout_stream = 180
net.netfilter.nf_conntrack_icmp_timeout = 30
net.netfilter.nf_conntrack_icmpv6_timeout = 30
net.netfilter.nf_conntrack_log_invalid = 0
net.netfilter.nf_conntrack_max = 262144
net.netfilter.nf_conntrack_sctp_timeout_closed = 10
net.netfilter.nf_conntrack_sctp_timeout_cookie_echoed = 3
net.netfilter.nf_conntrack_sctp_timeout_cookie_wait = 3
net.netfilter.nf_conntrack_sctp_timeout_established = 210
net.netfilter.nf_conntrack_sctp_timeout_heartbeat_sent = 30
net.netfilter.nf_conntrack_sctp_timeout_shutdown_ack_sent = 3
net.netfilter.nf_conntrack_sctp_timeout_shutdown_recd = 0
net.netfilter.nf_conntrack_sctp_timeout_shutdown_sent = 0
net.netfilter.nf_conntrack_tcp_be_liberal = 0
net.netfilter.nf_conntrack_tcp_ignore_invalid_rst = 0
net.netfilter.nf_conntrack_tcp_loose = 1
net.netfilter.nf_conntrack_tcp_max_retrans = 3
net.netfilter.nf_conntrack_tcp_timeout_close = 10
net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
net.netfilter.nf_conntrack_tcp_timeout_established = 432000
net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_last_ack = 30
net.netfilter.nf_conntrack_tcp_timeout_max_retrans = 300
net.netfilter.nf_conntrack_tcp_timeout_syn_recv = 60
net.netfilter.nf_conntrack_tcp_timeout_syn_sent = 120
net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
net.netfilter.nf_conntrack_tcp_timeout_unacknowledged = 300
net.netfilter.nf_conntrack_timestamp = 0
net.netfilter.nf_conntrack_udp_timeout = 30
net.netfilter.nf_conntrack_udp_timeout_stream = 120
net.netfilter.nf_flowtable_tcp_timeout = 30
net.netfilter.nf_flowtable_udp_timeout = 30
net.netfilter.nf_hooks_lwtunnel = 0
net.netfilter.nf_log.0 = NONE
net.netfilter.nf_log.1 = NONE
net.netfilter.nf_log.10 = NONE
net.netfilter.nf_log.2 = NONE
net.netfilter.nf_log.3 = NONE
net.netfilter.nf_log.4 = NONE
net.netfilter.nf_log.5 = NONE
net.netfilter.nf_log.6 = NONE
net.netfilter.nf_log.7 = NONE
net.netfilter.nf_log.8 = NONE
net.netfilter.nf_log.9 = NONE
net.netfilter.nf_log_all_netns = 0
net.nf_conntrack_max = 262144
net.rdma_ucm.max_backlog = 1024
net.sctp.addip_enable = 0
net.sctp.addip_noauth_enable = 0
net.sctp.addr_scope_policy = 1
net.sctp.association_max_retrans = 10
net.sctp.auth_enable = 0
net.sctp.cookie_hmac_alg = md5
net.sctp.cookie_preserve_enable = 1
net.sctp.default_auto_asconf = 0
net.sctp.ecn_enable = 1
net.sctp.encap_port = 0
net.sctp.hb_interval = 30000
net.sctp.intl_enable = 0
net.sctp.l3mdev_accept = 1
net.sctp.max_autoclose = 8589934
net.sctp.max_burst = 4
net.sctp.max_init_retransmits = 8
net.sctp.path_max_retrans = 5
net.sctp.pf_enable = 1
net.sctp.pf_expose = 0
net.sctp.pf_retrans = 0
net.sctp.plpmtud_probe_interval = 0
net.sctp.prsctp_enable = 1
net.sctp.ps_retrans = 65535
net.sctp.rcvbuf_policy = 0
net.sctp.reconf_enable = 0
net.sctp.rto_alpha_exp_divisor = 3
net.sctp.rto_beta_exp_divisor = 2
net.sctp.rto_initial = 3000
net.sctp.rto_max = 60000
net.sctp.rto_min = 1000
net.sctp.rwnd_update_shift = 4
net.sctp.sack_timeout = 200
net.sctp.sctp_mem = 453222      604296  906444
net.sctp.sctp_rmem = 4096       865500  4194304
net.sctp.sctp_wmem = 4096       16384   4194304
net.sctp.sndbuf_policy = 0
net.sctp.udp_port = 0
net.sctp.valid_cookie_life = 60000
net.unix.max_dgram_qlen = 512

> - The iperf command

Just sending traffic from one geneve interface to the other.
iperf -c <ip of remote geneve> -i1 -t10
iperf -s # on the server side

The geneve tunnel is created using:
ip link add <dev> type geneve id 464 remote <ip>

> - Your network topology

Just back-to-back NICs on two VMs.

Please let me know if you need anything else.
