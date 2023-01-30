Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0D6805BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 06:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjA3FtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 00:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3FtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 00:49:23 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DDE3A86;
        Sun, 29 Jan 2023 21:49:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fonMIBt1yP7YCMBfnD6BnTBucoCI7BaWJIpL0cWPI8D+xmkitgr01m3YS0m01CGXqwF9viYN+msF7YzmiqH0Zrpl+DiHilAsXSEy0V9OMT5a0yd4z1nnnx8qDbsu2r8yU9GT8fpOjAJ9cNeIXveZ6C4iO8aq66e2On1I9LSafsrD/p1i5XVeQ+wadVjoB7OfcW9dQUPwxw3KFxaF/FYhVmWWJl5u6GVbX5Ckm3N7rz5mbuEc2v4SDEPZVL5ktH2ezLtO922Q/gK6XxEGXcBKwJ+JCr7aBBCJ7HE7BRaXqSVxhXj78ZfmwBUoZ98r1hEjh5YcOh+9rbsYoE9sTZs+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m27PHhmgLI6k1k5GtC2gNu12WqxA4VqoTOePD0gnqQ=;
 b=ExHBe5iWawpQI8PEqlUG18WG2KUzgh4dGsz+6BqMCwEAYVPWg0dCBur7iKsgsfrmf087KY6LjpIpuvnHpt5MQiceiXZXtA+xzIqqdCll+/yR2l3jGuRQ0NCf3YBYSUKWznOpJN3ZqT+DybrEK3aSrptTxO5AICmEC90q3dKibEB2lQdDqMJkBJ1Wvw7kGGvK4lZEunycbRR/ObPAfJhXLV/5My9IHr8ajlFugAyUOK4xUBPzvIVRThWY6w91mUMxBqpam56GTl7vKIDwoO4Q45jQOAvBVtcITgGEZb5NMyhsyjOd/NG/AuV/XCLKwcvRY4NpfoNZ2OE6f7LzAK3zsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m27PHhmgLI6k1k5GtC2gNu12WqxA4VqoTOePD0gnqQ=;
 b=KGyXvBfUisQriRZI6MwE7D0FYPKt6mPwe3lYfu+933utxOCoiLLdfa1G37lrV5ZUY7SuQU0LyUhBAtTDVzaztWz+h2yfQJAq4kE/81oFFkRb249Py6XICmrzNInwpLSxVhs4sBLVqSo0iCrNYCtiZfgzVTyzIC0aMDJJufx2Dy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CH2PR12MB4264.namprd12.prod.outlook.com (2603:10b6:610:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 05:49:18 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a0e2:652:d7bd:58f%7]) with mapi id 15.20.6043.023; Mon, 30 Jan 2023
 05:49:17 +0000
Message-ID: <2cb6bb4b-fd04-556e-0790-524bf174cf89@amd.com>
Date:   Mon, 30 Jan 2023 11:19:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/1] perf: Fix warning from concurrent read/write of
 perf_event_pmu_context
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, peterz@infradead.org
Cc:     syzbot+697196bc0265049822bd@syzkaller.appspotmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Thomas Richter <tmricht@linux.ibm.com>
References: <20230127143141.1782804-1-james.clark@arm.com>
 <20230127143141.1782804-2-james.clark@arm.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230127143141.1782804-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CH2PR12MB4264:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab1cab0-f02a-44cf-c691-08db0285b9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8Z2ByTSQMh0fhluFQHJX/TnIXuLJHkfilI1W4rB6q2xryYldHFx7qiSSpO7fpJCUAxsmXGy8q3RTROsozDC0qFETN4Z6Y9HS8BxL+0cUlsZzxQNQ5Rz+RcHlgBvnU8kyoK0GWA8AoENVToY3CyCKuM3DH58coznS0hC9EQASFcS5QOktvIPGy7MiYDiyk0M+pI2SRFpQY/un41fKBx6HXQKGWlL8GxdsdUWeVKZ3SEZXtGntjZfhv9mPtI0SOTVdvgBOa72KC+6uDltSo34Z0wHT20tOSeBoGMRRTzMFuEJr2MwNjZ6SsfaSkjpH6CpNwyEUV4r+rAFFKi6BnlsIuEW6xcGe4KJMtGKNU0JJI6DF17FgUPcXsfSsplUu0SV6qtgLWvbMgdo7z7Ol0q1c8ubykraPaHeGtKnpZawP+sonwy8s9dmTG6Sl/qRdaFAfwp4wr8+Y/Gzko+zKOuo/xSPrL4xP+u0IeDG6fQoYboQrsKwhfsm5laYlnDw40qtJUiYmx+twNnCpteuLa7rOVnJOITXRLtvEJKs9/15n6mb36BE4ZcEGE04AmbfVn3hU4Qs+ms1jhmnRS3vwY7o4LjH8VPCUqfPeZYPPsmhSlX4nAH5szVl1NiXTp3K3DnKRplRdi0BkpwnUmUyekiOGce8C/rbTWtzVervf3dpjzflA72VXtbS4fHcEEF3w/xczG3yk4YB8Z9unZA7je6ve4DrKraai2yNeNyL0gxf0HiGog2hJ5I2kkFPJjNZgKXxKU6bk2BHXcSPc2pTs6j9XB4aRzyNNYxsIu0FgO6S/kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(451199018)(8936002)(41300700001)(31696002)(44832011)(86362001)(5660300002)(7416002)(83380400001)(2616005)(45080400002)(316002)(54906003)(66946007)(38100700002)(66556008)(66476007)(4326008)(8676002)(6666004)(6512007)(26005)(186003)(6506007)(966005)(53546011)(36756003)(6486002)(478600001)(31686004)(2906002)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDN5cHFnODVjWlY4VGZDYW9rbWR1WXd0bmlUamZlTGh6VGVybG5pRi9mZEcv?=
 =?utf-8?B?eUJ1T2U2SWZvbkdBU0dwOVJMa0s2QkU4MVQ2SkpZY1dQS3JycC8xS1ptSDE2?=
 =?utf-8?B?bkt5MElnWkhxOUYra2I0TmlMaHkvaEUvek10QjRLaTFMZ1A4eVpzaHZKSjlY?=
 =?utf-8?B?S1Z1bFBlUkt3bC9WVFNERW96UHZZMjgwNFFkc1UrWTdMZGdUcjF0NjBqK0x1?=
 =?utf-8?B?K0VwbUlleUpySjRsR2lPcnoveWdLUW1KRExRYkpMbUh1K1ROU2g2U0N3MjNU?=
 =?utf-8?B?TjE2YVAxc0lxR3pzVlRxdFpiT210d21WS1QwV09RY0pqNGt0cUErK0ZiR25a?=
 =?utf-8?B?cEdDZ3RtQzc1Qzl0bUpYY2xVQVhjZklqbTJCbWtyUGVSLzhLaVpCL0VzWVR2?=
 =?utf-8?B?SjR3TEVnb09FQVdYcStMM3R6M2tua0FqSGxsRjZoSUlqanRZQ1pNS2szVTJt?=
 =?utf-8?B?dDVtclFTSU14Q0Zvc2dRZGJTUFVlaG55SHJsSDlXYmpsNXo3UDgyWXh5WUhz?=
 =?utf-8?B?bWZ3cEk4bmZVRE5FNVl6S1FKb0NFMmZhZ3dBOFJpTGRYTGpDZC9VOG1ORWx0?=
 =?utf-8?B?N3NwYmg3OVBQSkQwYVI4OW1ycVBhcWg4WHFQSnlFZTNQaUttUnh1V0w2MEla?=
 =?utf-8?B?ZFNPSGdsalg4N3NIM0hvZkZsUzFMNGFmcmdlTjdUY2lBRnhXcUFrMjFtNEk4?=
 =?utf-8?B?NUFYWExSQ2xoL04wa2JrblFoUU1tUEtTbjhCTDV3WnBNVnRPYUVNOHZaeFVh?=
 =?utf-8?B?SzViS0YyZ2RrMkxET1FxL2FLd2FBWjVSd1BYNkdFOUF0OUJTZVRkMXA5OCtU?=
 =?utf-8?B?REdxTGlFaW8vNTBqRmtwK3ROZWQwNGRnZHdrWEJMdUJvUEV4MjVaV1lGdXdH?=
 =?utf-8?B?NS9Jay9zeGRtTHN2NlJ5NjJlM0lBYW9XMXBIcVcxMDI0WDNQL0lSUkNNckRu?=
 =?utf-8?B?VjFrQUlRSVdmRjA3TFNDREZrdG1OUjZjMldDK2RVbHA0VWxTbWRISi95VDM1?=
 =?utf-8?B?WU9VZlBrd3RCT2x1cEdlZFFLOGJWdlpYTDI1b0tqS0gxVXRxcnBDUVc2ZFRR?=
 =?utf-8?B?RUc5UUJMYmVuRzgyNWFpNXV1ZXVVUlRIbDU4MnJleVhEdUdvREQ3ckphYXpi?=
 =?utf-8?B?WEdkc3NrM1FVN3R5UElxc2hrNXFPVlZhSTVJSU53d0dYOVZDK0ozODE5NTlG?=
 =?utf-8?B?ZHpUMEhwdGo5M3YvWWRnSW55WmUrazAvL2Ric21TcVg1cFdxUm1VZTJYcW5z?=
 =?utf-8?B?aDBiUUUwOXowSW9uYm9WYVFpVDI3OFFrME9kYkw1c2VRcW5PNmtYaXUzS3do?=
 =?utf-8?B?OXJWelVITkRFUkp0aVYvMk55cXIxU3dxOUl1dWM1bWxPTDdjWXNNeCtpVXRq?=
 =?utf-8?B?STVxTkYwbXlISU5EZVVzQ2VQY29vOEU3ZmJXZVFMdnNWWXlCM1RGaVVLMjl5?=
 =?utf-8?B?MWk1ZVBaRzZ6citBMmJFT2xxZmlhdTNDVEtSd1ZrSTNwVW1lYjlQelRYQk9x?=
 =?utf-8?B?R1dFbkM0dkh1UTFZNWQyTk1wNTE1ZGxxZlNsckZPZDYxMC82YkxJUFhpUzJK?=
 =?utf-8?B?LzRzRlFydjBNdFQwSE5FL0IwZjluSWk4a1AwY2ttTktCWW1BQ1JCOFM0eVQy?=
 =?utf-8?B?NEt6WWV3TUF0WEVCVnY3aXp4dnVGaWZtYlRzTXFNWXJxa1lLc0hHbm1URGQx?=
 =?utf-8?B?ZkMrOVJFem5kUjNqczZURmgvVVMzTmxsUkQ5ZWw2S3psT2tYaXBadmU4RzZ1?=
 =?utf-8?B?blRZRTU4UVZpOTJVNnZFY21QcDg4NFIvUGhkUmNDVkRJYXhvOTFkbUtTZ003?=
 =?utf-8?B?czA3KzBFZmR4bXR6VjlLUWZTaXNvRC9TNnhXVU1TOHFaU3daTDByb3paWndS?=
 =?utf-8?B?Zm41WVpURTdaaWhrMlFza1lSeklqQTdYYkdTYzhIWldMUTRubVRHT1pEZHhP?=
 =?utf-8?B?NjRtMlZ2Q2lZUHJDb1l0WkZyYkp4ck0rbGlJVzZpZktSdjl2Nlg5R0pndXBv?=
 =?utf-8?B?NWtJWW1tMlg4YmZBNG5taUM3Ty9NenY3WGc5QU9KK281cHNpOFBaUnh3QWZ2?=
 =?utf-8?B?UG13L012MW9IdStvalhXSE5xeXZnZ0Y4ZEp4YlRiK3krZ0NXREhoOEZrWGpk?=
 =?utf-8?Q?y1vX/hZ/MFSag4b3RXDe+FhZ2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab1cab0-f02a-44cf-c691-08db0285b9cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 05:49:17.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ty4xgf1T9CZtqAHE9gqG1hJgD6h3C8uBWa6WeuFkw2BGTKOV2m/fUN20dC3H/WISE33BZOYAkUz4pN0JJq++Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4264
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 27-Jan-23 8:01 PM, James Clark wrote:
> When running two Perf sessions, the following warning can appear:
> 
>   WARNING: CPU: 1 PID: 2245 at kernel/events/core.c:4925 put_pmu_ctx+0x1f0/0x278
>   Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack libcrc32c nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter ip6_tables iptable_filter bridge stp llc coresight_stm stm_core coresight_etm4x coresight_tmc coresight_replicator coresight_funnel coresight_tpiu coresight arm_spe_pmu ip_tables x_tables ipv6 xhci_pci xhci_pci_renesas r8169
>   CPU: 1 PID: 2245 Comm: perf Not tainted 6.2.0-rc4+ #1
>   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : put_pmu_ctx+0x1f0/0x278
>   lr : put_pmu_ctx+0x1b4/0x278
>   sp : ffff80000dfcbc20
>   x29: ffff80000dfcbca0 x28: ffff008004f00000 x27: ffff00800763a928
>   x26: ffff00800763a928 x25: 00000000000000c0 x24: 0000000000000000
>   x23: 00000000000a0003 x22: ffff00837df74088 x21: ffff80000dfcbd18
>   x20: 0000000000000000 x19: ffff00800763a6c0 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>   x14: 0000000000000000 x13: ffff80000dfc8000 x12: ffff80000dfcc000
>   x11: be58ab6d2939e700 x10: be58ab6d2939e700 x9 : 0000000000000000
>   x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
>   x5 : ffff00800093c9c0 x4 : 0000000000000000 x3 : ffff80000dfcbca0
>   x2 : ffff008004f00000 x1 : ffff8000082403c4 x0 : 0000000000000000
>   Call trace:
>    put_pmu_ctx+0x1f0/0x278
>    _free_event+0x2bc/0x3d0
>    perf_event_release_kernel+0x444/0x4bc
>    perf_release+0x20/0x30
>    __fput+0xe4/0x25c
>    ____fput+0x1c/0x28
>    task_work_run+0xc4/0xe8
>    do_notify_resume+0x10c/0x164
>    el0_svc+0xb4/0xdc
>    el0t_64_sync_handler+0x84/0xf0
>    el0t_64_sync+0x190/0x194
> 
> This is because there is no locking around the access of "if
> (!epc->ctx)" in find_get_pmu_context() and when it is set to NULL in
> put_pmu_ctx().
> 
> The decrement of the reference count in put_pmu_ctx() also happens
> outside of the spinlock, leading to the possibility of this order of
> events, and the context being cleared in put_pmu_ctx(), after its
> refcount is non zero:
> 
>  CPU0                                   CPU1
>  find_get_pmu_context()
>    if (!epc->ctx) == false
>                                         put_pmu_ctx()
>                                         atomic_dec_and_test(&epc->refcount) == true
>                                         epc->refcount == 0
>      atomic_inc(&epc->refcount);
>      epc->refcount == 1
>                                         list_del_init(&epc->pmu_ctx_entry);
> 	                                      epc->ctx = NULL;
> 
> Another issue is that WARN_ON for no active PMU events in put_pmu_ctx()
> is outside of the lock. If the perf_event_pmu_context is an embedded
> one, even after clearing it, it won't be deleted and can be re-used. So
> the warning can trigger. For this reason it also needs to be moved
> inside the lock.
> 
> The above warning is very quick to trigger on Arm by running these two
> commands at the same time:
> 
>   while true; do perf record -- ls; done
>   while true; do perf record -- ls; done

These dose not trigger WARN_ON on my x86 machine, however, the C reproducer
provided by syzbot[1] does trigger it.

[1]: https://syzkaller.appspot.com/text?tag=ReproC&x=17beacbc480000

Thanks,
Ravi
