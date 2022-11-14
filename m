Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890AA62790A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiKNJdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235793AbiKNJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:32:57 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD58BE03
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:32:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO+qjfbMaBiuBcjcz7F4Tr/siQZyOBc2BfuvUCk4FkpL9z7yGbiV7iy4T6iKIx/GFnZf7p95CsLPvXnQUMB3UaPD9LPuiKKukhknXqu2wJqxQvv7KZWgVjtDMw/SZrYwOIA1HxInJ18UE6hDCizBeFH8iVqMH6G1/WUpEYK0qn6D2qZudo8+O97fwUZhOXM+0lcgQwux9EBqLG7aKqL163x2PDRv/DRLLsvoFJKKopbrJHg06elg8y60bdeEwDX+4pPSTVum4IFsh+yNOkPqiLNPoAbNJM9i1dhyYXvoeVKcb5J0jgtlE1kYOstbvuhpMPlBIjO5IYIqIx+tnBpUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kd8rI4gWaybIXfyrl2buRn0IJO2ZUf0e+JRjkHL7QEw=;
 b=Zh7aEhxYmEhECungSXCgnQKT6i6zRIfy/Y6prvCLtAxB9m7NX72SlTWxaxG+0LSdyoim7M8KRR9njao1l7I6s7vqf4naS85ocLsDioVRvZnQvaFbaT4IST2gPxTpf3wLkHTxNW3JbwoZhAD9QjXD93+j7XPoXdQB66wt0kcqmXisorHciE5q2wuiFssOQYPjE64UpOsrmL8n6x2S6P1CsrF+soyGdKCUwkbDgRX0AP3c3/Scmakovi70bwLU+WZVbURCCQbBM4sYASbG+pYI5AbM9pjkrpLP/+tupTa7LneoId26g8GDKd8Sxj8aOjgPF9402mNDmJiNxCkoRIwOYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kd8rI4gWaybIXfyrl2buRn0IJO2ZUf0e+JRjkHL7QEw=;
 b=rSQHHoLipmZQAkIwZcKToGmRcPVFb1qOiFq5K1sErD0+73fclcSMatCNFCvNgMhobcN/QLMH1ED/iotlSwbkfD2TnHUaYJHb8NQXKYo8wT0H4nFvKSWCtESNSZitQkkof78TWLsOrAE1TngU2zugJKT+Jouy+1P3qJHHNUHpaxSkcas7vPYfVbt3mNQg9i3hBY6R2ukAjb4m1HcGx+t8/RSMPfGdqydU4a/aQehbNaijo4sl/sLgok5BuOmxgYSPnv3PRhD417E7Q06jYx8iFQku0mnncgcGD60h85TbBrAfeIgF64fSoa0+uOx+6g6YLYYWO8EqVxsfwPYgZd+KbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com (2603:10a6:20b:fa::20)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 09:32:47 +0000
Received: from AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::48df:9a8c:c706:36b5]) by AM6PR04MB6551.eurprd04.prod.outlook.com
 ([fe80::48df:9a8c:c706:36b5%3]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 09:32:47 +0000
Message-ID: <5ac0cc88-fb43-120c-975a-f1ad23ed30fb@suse.com>
Date:   Mon, 14 Nov 2022 10:32:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] x86/xen: call xen_set_upcall_vector() only after local
 apic setup
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <20221112132336.698-1-jgross@suse.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20221112132336.698-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AM6PR04MB6551.eurprd04.prod.outlook.com
 (2603:10a6:20b:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6551:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 444aa9fe-700d-4dc7-b440-08dac6233109
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fj7KIwcWkqKLgv57/PlDiL40x4OCnLks64ja8iucNx/rN0Pf4PN8L/Z8kyyCGt6OuBgHsGHjTS/R5PmA/JUW+qFFelexA9uuE7HQSFwK7x9TVz2ENgliILnJZfDNBGn9XC9ygX8jdaMECvHLOchu51hFRvWplwfNjUjceKrEIxH/cH2Dlu56KRyGG0RbV2eUjIy4Tci5SAaIKCIGYXM7ZPZX4hs+2fZ7gDL6+GH0jHDKLeBX7+dtJBYEgZcZPmkp74e6pJLuhSt9JQxjb1qZMl56WqAKjWffug46d2b3Yg/C7FSJs74VPGaVl2usGh5iWwV2y2V/2GW+xVEx1XfA//4xNL2SEEsHwyWjZ7xQafSxb2LR3fb/ZGHKmahei7DucBJ/KzNAjFDb3I123HApeAsVL6w2SRucj6aJZAlYt7PPstDFkLRgKas7PcYPOWycHpQgkqowAvzZr4sZjToA7EwABcT7K77GUo0cA6vYlDdORLjel34wbRrABc57RGyYwa2RUtth3VNMuxKdNqjoyX65iKEulzxfzYk+P6l+Vk7CISlS/UV44tK0e/oY61Mv6MQjNRVebVZZpiylOzCvF/iYyuzTNpri7zrKox8DZwTp7KEYuDfZc9B1NG5UTYS49pdYmt+EDAe7+nbc0MOmaVA4pZe/ze1QYL9+hwvnp/hvalxcVPLXthTRi8cEIj/qCdlVb5Eztk4CALr4sMtB4d+Woh669J5tF68/2xpRV3QFKaG9hWHPyNivT/pMmHhGXrR0CyS5iIIhiT/JE4t1E/4ge+FteyCTfYDEy/E533+U26vCeLGkz1UXqLc7llhl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6551.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199015)(36756003)(41300700001)(37006003)(54906003)(2906002)(53546011)(6636002)(316002)(83380400001)(38100700002)(4326008)(31696002)(6512007)(8676002)(26005)(7416002)(66946007)(86362001)(66476007)(66556008)(186003)(5660300002)(6506007)(8936002)(2616005)(6862004)(31686004)(966005)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VMbzFJWldOcVpncnRmU0lEVnRCUlhMb1crZExJSFVFYTdwWXVxajRTamZC?=
 =?utf-8?B?VUMxTE03QjAwRHdPQ1kxN3lxSEtLMDZUQW1mcTcxeCtvWG43UVJCTVpER0xz?=
 =?utf-8?B?eXZ4ZDR2MW9BNXJ0c3dGRUFQbWl3NHZWamw5alZUR3M5djRaWFhKTldyaldH?=
 =?utf-8?B?dndMQXJYdUwxRlIrL1hhWkltYm4rWmV1YnAxdUYxRzBNWHlTUnQxRzgvcmFy?=
 =?utf-8?B?Z0pmSUJhNHk1ay9LTjVkYmtBNmxhUmgyeVBrTVB3Z2FsY2J1NURRbllqcUh1?=
 =?utf-8?B?TC9PK1pnZmF2L2hqTnlZdU8zTnlzcnNqbEV3c1VVOFZrcUJ3M1BsUHN0SGY4?=
 =?utf-8?B?MS8xS3lvYjAxcHYxNkNkOVV6bldReGloUm5kRWxsTHg5cVk1Z1RCSHgyd1U3?=
 =?utf-8?B?UmRZMTBPZDZsc3g0eGdLTmozZWVYdXp4RXRiWFlaMWhZajlpaXZLcFRlTWw3?=
 =?utf-8?B?VjR6Q3ZyeS8xbGNwSmVGZ201SHA4YnAxSEkzZTZUTFVRblN0RnRZZUI5Qnh1?=
 =?utf-8?B?djJrQzNoZ1JoNG5nSGpScU9zWjR0d2FGTytMbHRMeERnb21uMVp0WHROSGR3?=
 =?utf-8?B?L1JoZGttMkQrQjVoZGhGbFcwRVJlM1ZxUkpPTlZzUUdERnhEZmhFaDVQZGpl?=
 =?utf-8?B?MHN3UXlEcXZ3bnNJSGhFZm5RU2VzNmFJYnk2UEx4bkVidzdLWkZRdUxOeWdj?=
 =?utf-8?B?OGhqS1kzQm03M0wvYkRtTnhOLzVNSUk5UUtxTjdQekpPTXhrbzF3Y25oTTA4?=
 =?utf-8?B?K05RakdhUkVETk5SOFJMVEIrd3ZxV3FSeTlXKzNFYjJlM1Frbk1vOFRkZ1Jo?=
 =?utf-8?B?Wk1VVVh2R2Y4SmZqemtJb3hCTUZGNXlOY1hwLzFZcDRYM05PZlJhWExkRHor?=
 =?utf-8?B?eHY3b1AwUUNjYTlqYUpiMmlDdDNyVEcvVXRlQkMvL1pDZ3duRmN3YzFHTUp0?=
 =?utf-8?B?eDJwOUVlRVAwY2plNjZ2WTdSWEMzekIwWldzdlcxQXJLNXdMdXUxZTFQTkUy?=
 =?utf-8?B?WFFYSU5VNHM3c2lzcHBVc2pTWDN1S1YrUUttNEEyc1VOM2s2OEZVeUJCWHY1?=
 =?utf-8?B?b3UvVXgrWDdaNTU1ZjdHN3BPd202ZnoyWmNucGFxWVFiY1lRYXZ0Zk43QkRm?=
 =?utf-8?B?RXdaeUdvZXIzWlJudWcvS3hXVWgxZlorZ2hZQ0xFeWdwOWs1TE1CU2g2aEpL?=
 =?utf-8?B?cTVtNHZNUFdyWExuQmJQZ090TXRQRUZqRjBFRWFhdllCVWlqZHZuODBjYnJX?=
 =?utf-8?B?MG1scm5jSWU4ZC9OaDAyRnJzWGJiK0g0eUNBSDJNYktlQ0VkajZLQTZ2YkNY?=
 =?utf-8?B?MVJCZTBkdjRVYUttM2Z3YlJJTE5YdDkrZnM0enMwcFI0RVNURkJCcDZKMDRW?=
 =?utf-8?B?ZEltOFdycWIvazhpQmFsMThkQmo4YkZIRXdEV3ZmWEUyRlpFMjY0aFhPRjdr?=
 =?utf-8?B?NjA0azMzMjYrZGtId0EzMVlWeitoc0hkN0JsbXJoZzVwaFRmamorTkkrTlZF?=
 =?utf-8?B?NUpWNTl0d1RsdHNDYU9lUzlpb0wxMlRUeUoxUmQwcEkyRkc3R2RmcWVqUkFY?=
 =?utf-8?B?ZGdVTnNENmZxcENRVVZoM3YxNTk5cldBWjBmRjdYRzF0eG5qVnBadDl3QTNm?=
 =?utf-8?B?VGVjSnE5YmlObXB0ai81L2k1WG16eU4rUlRpYWZzWW1mak93a3RYRWpGeEZH?=
 =?utf-8?B?K21INU0yWWk0MVVzZ1cxVENaa3hscFFsM3o1cGVSdkdYUSsxNHg0eTl0ZlVF?=
 =?utf-8?B?WHpLck5PY1ZtSG15K29PM1ZhdjZzYW4rV2lxWmZVT0ptTmlXelo2OWtpMVph?=
 =?utf-8?B?UFNuRmFQaW1Hc1o0TlBHUitpZndQR2hXVTFNSHNGelBwb2JkSDNjN1dEOUV3?=
 =?utf-8?B?emttY2M4TnZLWlpzUzI5K1JkWmtHQW5aZWROU3JOSVBUMFdjMDRFR05laXAy?=
 =?utf-8?B?bG55ZG1BTVpBVWdUK0NmMGRGK3BIZlBDVVlmNnlwYlpCcnBaWDFpWUxleGpq?=
 =?utf-8?B?ZjZnRjVlRFM5Y1V4STErWE9mSkFzWnZPVkt2YjhldmFoRU95LzhzZ3JOUFNi?=
 =?utf-8?B?dG9ZZlFIUkRSRjh0a3hWaTRMOEZRZlU2WHJnV3JzYXYycGdZVDZHc2hETk5M?=
 =?utf-8?Q?1N/YfeGKuykaG2WsuvrvaivaG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444aa9fe-700d-4dc7-b440-08dac6233109
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6551.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 09:32:47.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOn0sE4iRL9rVxHCTe0PB5MGwEajW9VaSGDp3ou1qiy/zezMBtBKqR//bxNcgvx9+VOZ6Zz4Oqu2HkBjv3nGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.2022 14:23, Juergen Gross wrote:
> Calling xen_set_upcall_vector() before the local APIC has been
> initialized results in warnings when setting up the local APIC:
> 
> [    0.037322] APIC: Stale IRR: 00080000, ...
> 
> Avoid this problem by moving the call of xen_set_upcall_vector() for
> APs from xen_cpu_up_prepare_hvm() to a new hotplug callback called on
> the AP before interrupts are enabled and after the local APIC has been
> initialized. There is already a Xen specific hotplug state defined at
> a matching position, but right now it is specific to Arm. So rename
> the CPUHP_AP_ARM_XEN_STARTING to CPUHP_AP_XEN_STARTING and use it for
> x86, too.
> 
> On the boot processor use the x86_init.irqs.intr_mode_init hook to
> call xen_set_upcall_vector() only after the local APIC initialization.
> As interrupts are on already at the time when the hook is being used,
> modify xen_init_setup_upcall_vector() to disable interrupts. This is
> needed as the xen_percpu_upcall flag is set only after the callback
> has been registered, and the flag is needed for correctly acknowledging
> an interrupt.
> 
> Fixes: b1c3497e604d ("x86/xen: Add support for HVMOP_set_evtchn_upcall_vector")
> Reported-by: Jan Beulich <jbeulich@suse.com>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Just to mention it here - as per [1] the issue may instead result from
hypervisor misbehavior, so I guess we want to investigate that route
first.

Jan

[1] https://lists.xen.org/archives/html/xen-devel/2022-11/msg00783.html
