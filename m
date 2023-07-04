Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D87D747076
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGDMHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGDMHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:07:46 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::618])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF2E6A;
        Tue,  4 Jul 2023 05:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrrvMp8y5SpqvHziuIW8e9ZrRLRoPHom9s4xk/YBEWs5km3UcyJl2+ATa3wHMDcFTZAITQUN/Puk2Hym1myA47RkbI1qlJeQl5JajTLr1K32LTwIy2lMkIhrnU8X8hHBzmnnTVPRJAWEH1WSLYnF803m29ypzYRkJKHZuxy7iEP609mVXGuFStLUIlOmrYv1gdaDHuvI1tCuySB3vpNAOOlqT8VkJMu0vhZJkXPvUgy2V1oHRPKzbpo/IpfT6dTIZl3kKmv0/wLg2WOPqe7bZPIvKwO9cuj5vU7X4bz48n3z7Lwfcg6GeZe43jpdy0N6LSfCT0uX9WI1OwnAeO9DhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qz0Ee1j86xIJGrzBSV/HnDcjBMkJZpToooyiz0wtQo=;
 b=DVngeMZbVrKSyMViuzQnRx9P74YGDgVoD0e4WyFZ+SHHjgXUGaPUwM2CjwdsIxMFmnJ+9OcqJ1qMlexrripPSeWhhIj4RfEf4D0mZ/wEf1mgRJWTtyb5vPqdYDqOY9NqJ4F2SNKhcEg56veqYxL1txGSU06xm9wN3EKY8Wrlgvh6PAyyqiyxfEFO9HZCRSOlR9QygWiNgoxfjtk8LQx6ymf6PDd+ELU1dsumgsoBjR1ybBceJt/RL7LcVIoaCGWDjhCSAd0WrP7nXZmYTGJTuUyyobkh6emU9rM0+TchMZIOmp1GuWpIzqHm57+j/vzOFvlkCrFn6ntToZWsuFE3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qz0Ee1j86xIJGrzBSV/HnDcjBMkJZpToooyiz0wtQo=;
 b=YxbPP+LdQ6/ON3uSNCIdxSwVFbnHjyTo3+bVqgHQlmyqnxDwLYzQIjmIqadeW8DywPvHysSC4lhWGtTII/+6fN/VhjG0FgLwg/Iypka1hooYi/18+jWQJfYYWdE/ttWY90lQVMaIICIyx6htYLdjLyhHt/rqJ0QHH4fISIh82mRgg/wkHAOv6Yx5drlzTH/nLAfld07ngETiAtNkZqEEhBQW6VDj76HgNIJiwFvS1tqEgsGPFEnmO8sDmz9lk7tl2Hghm4Kn9AHeVmmaRTRPfTa9hDvQHGBwRd6ihSysSymga43ca+VQUHynRl7JyGxqWsxnINcizoQeUfLi62zIwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by AS8PR04MB9125.eurprd04.prod.outlook.com (2603:10a6:20b:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:07:41 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::9bd3:48c9:ff58:9880]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::9bd3:48c9:ff58:9880%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:07:41 +0000
Message-ID: <c11f1c6a-795d-2245-0571-ea956f7881d2@suse.com>
Date:   Tue, 4 Jul 2023 14:07:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] xen: speed up grant-table reclaim
Content-Language: en-US
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Xen developer discussion <xen-devel@lists.xenproject.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20230627172216.1359-1-demi@invisiblethingslab.com>
From:   Jan Beulich <jbeulich@suse.com>
In-Reply-To: <20230627172216.1359-1-demi@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|AS8PR04MB9125:EE_
X-MS-Office365-Filtering-Correlation-Id: 82306e69-13bf-497c-52ee-08db7c874448
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJzCE91NMvGnE5tj1xskNk7hGUDCCs9Lj5Mgcts+SYrLABUIs92x9ouBMI+Vcg2y/ePSlzCZPjW+xAloFEbhvj17+51o77JvjlXIwLYLIUGnWgx2RmQHiVzO+S+VvtUCblF0XhhZbbYjN/t/53IRPnAHG9hOPT4Cujv+gMrf83Kes9bPU21en6LAt7oEr1DwWEL/PeWbVv3iMpBL2f9VtpF+JTR4CEHZRCMeqg0N8cSySgl6TBapCyA4qkoevkGG9m4SbR0PUM9LNsZyfb15wbvXxy3i50iXDNfuzBo32YK2qsW2boi+jjBJhybMWAtOmM2akdY2K8ltYnD7foZ/HZM2qalQKz3ykyhW2z8D3wUpbaFnuZ1sqy4qHtXs0rC9NGUq/p3UFPAZIlyqyX0ecn7eBluaYbIuA4twGDfcC2sLH4yyuLU+caCm94q9fu/Z8jxfv+QFRgdwvaZBV+GoAqyrrhKjxcU5YXRTZzf9cK0Pum/JqDKDvA2/tzYe24zB3kItgrA5DjWcXvltEJdPM37vzeDsgGBW1gJ9sLeXisx8Nzl4jXr+sjs7eC1seq37KbhZflPUIvUUk0p9Uy005Fa89xujH0JRWbUnw4LZOTchxBVTgdRlL57ZA1iInKqliRS8qBlm7NmDhJDvKaSwQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(2906002)(41300700001)(8676002)(5660300002)(8936002)(36756003)(31696002)(86362001)(186003)(2616005)(26005)(478600001)(6512007)(6506007)(31686004)(6486002)(53546011)(316002)(66476007)(6916009)(4326008)(66556008)(66946007)(54906003)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVF3ZTdQcFdmb2JhQWRpRmtSVWx2ejA3aDZCUWZhVjdIeEorZWU1WEs0cEhX?=
 =?utf-8?B?K09seGc1NjNIdFFyL3FjZFZPeEE2dHNac2VJODBWV2dYaEZqeC9DMkk1UDI0?=
 =?utf-8?B?UjJycnE3U0xhOWJyTWVtWkVSdnlON0ZIVHBDWi94YWY1WVU2cFYwUkdjcXp4?=
 =?utf-8?B?SWQ0WGZnSXpzaEZwMlJoVlB1YTVuWmtRS0x5bVZDSnlsbWh4UzFqOVRqVk5N?=
 =?utf-8?B?VHRQWHVZeExoWDNzSkNqd1hkYS8yNnFOR2lkSXRhN1JzYWliVWxrTVpzOWVw?=
 =?utf-8?B?TjZBcFQrWjhYbUNZLzcxUDk2NTRmRERlNER2N3BzOGI5YnFpdFlNTFJCYkZY?=
 =?utf-8?B?KzdLTXVQR0NONzI3RjdzeDNDNkI3Uks0S3ROdVRlWU5saHc1aFNmSDRvbnJv?=
 =?utf-8?B?QjBlRENrVTBCUDBhZW04QlFHT09zSlVkdllSU2tidlpMVzRCN1M5SzhmTEsy?=
 =?utf-8?B?dUo1bk5JVkRqVHJyQnZhSjhlZnRrRW94bHJxYkREOHlXY1EyNW1XQnNDU3Qv?=
 =?utf-8?B?OFFuNHBhYmdCRW9oM2QvZGtJRHErdEVuQVQzeWNqbkNFWkNaZGl0Z1FzeFo1?=
 =?utf-8?B?OUpYdEQrZEhoWjF3VGcrZ2JRWFUwSVlnRXdKRnQrY3F0NGo1NWNIOEcvMlN0?=
 =?utf-8?B?VmpFcGp1dDByM1BXbkpSc1hKVlFHMldtSWlqa2xTTzVWQWJwNUR1ZXpwT3Zk?=
 =?utf-8?B?ZFRNUFhTa0hNTGl1cXFLMDREOW1yTDRQQkV3RjR0MUl5Y0paeUV3YmNHZkVU?=
 =?utf-8?B?ejEvTE1NV0h5U3YrQlUyUjR3RjFZWTRmeGxpUm9LazNWWGZYRHdPTFlsWUY0?=
 =?utf-8?B?T3h3SUZlMTJSaUZFN2RpYUpXVmRGcEdubksxVlE2c2tiY3drRXYrdXQvZzNn?=
 =?utf-8?B?L1dEWTFJc2dDVThZTmRycWdsayt2Yno1Zkh1UGwrZzQ1VnY5RnBsZDVhaDcr?=
 =?utf-8?B?VzE1TUxJRUNadDhJSVorRlYxeldwYzUrRXljRkJPRFlDT0FReEcweFVkeFNP?=
 =?utf-8?B?bW5KRmNSc1E4S2RhektSUnpXeW1QWWtQcFBGeTNEbWg5OVV2anFvSjFGcmVL?=
 =?utf-8?B?Z3k4K3cxYlFOREd2SGVoSmF5NjZPaUgvelJVK0Qxemc0NnJ0OG53aS8xSm83?=
 =?utf-8?B?SFRLZFZ5TUlVVXc3NzdDTzVOcXdLT3B6dVBKNWJMYXFyNk0wMlJVK0VNb244?=
 =?utf-8?B?anV4b1pZcmw1UmlsQ0dCZ0xyRkloWmFGeGE2QVFnRHBRL1A1cEExSjgvRWNS?=
 =?utf-8?B?QUlkaWo5V1pVTG9CNFVzM05Oa2swaVNaQ3BzRmN2RFBocDRvZ0Rtak9PZFpR?=
 =?utf-8?B?bmxQRHVkb29YMWJFTkhlQW9iYytYdHNaNE9SR0xFRUcwYmM4dEdMaGFpK3hH?=
 =?utf-8?B?c21BaWV5M1JhR2xOdlFWNktscmpMZXdTcHZRTmdQVXhaazBLcnh2Ym1CMFBC?=
 =?utf-8?B?ck44bHJGTFRpTFUzRXpTeStQZEZOTWdZTzdxeVdOVCtOeDh1VTh1dnBzRXZu?=
 =?utf-8?B?Yk1PcHc4d3FPL1RwMkE0YTdScWpKY3RyWm1wd3lBSDlvMmFrOXk0cUwrYTFM?=
 =?utf-8?B?bUpCNWV0KzlhdEpSTmoxMURrZlhzdHNDd3dMZkMvRkhUZHRMMmxDenlFSjg5?=
 =?utf-8?B?MmZnZzBrZXordGpwTTlxWEZBSWtmSTI5WG9UYWI4WU5iaklCQS9VUUhKQzVK?=
 =?utf-8?B?YmVKai9QcmVaYlZHZHZEdmJEOUY4aU5iZWlUM0ZpRnZQdlRna2pQZks2MXF2?=
 =?utf-8?B?M0tYcnVqZk1BYm9GRjFIelNhaVdRcFluYnpHUUpXN0lBMWxnUElnTTdYcHdu?=
 =?utf-8?B?dDBlcE1WVHMzTkk5VkZpRm5IWGRKUk5iNnFpei9YU205QUY2NkxHT0lHV0xD?=
 =?utf-8?B?eEE3Y0dqdWdMQUlSMTJQbmdUdllKeklQdldIU0EvbkhCbFpQTzhzUklmRUVC?=
 =?utf-8?B?ckdxeEtJUWorMngwTTIzajNncGVKSExLd3ZZekxRaUpUZGc5ejRIKzFtdFdy?=
 =?utf-8?B?VWE2ZnRlcHRqOUdiYkJFUFAwMHdQOVcwU2VEYVVERkU2b3Q1WmtGMkdCSzJj?=
 =?utf-8?B?V211anlKVUh6VFdERGNOK2x6ZHZkUU1lbTZLUERZakRzY0VMMmZKL2doWGFm?=
 =?utf-8?Q?Y4UDppws+b2EZdIeiDXu2l4ez?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82306e69-13bf-497c-52ee-08db7c874448
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:07:41.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJV62KrS4qg4GuebwqjRxegd+w56YZImDg1btei5ax5owMe51Z0IbOm899TNSXfnfl4jHauTs/W9VdIc0x2ebw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9125
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.06.2023 19:22, Demi Marie Obenour wrote:
> When a grant entry is still in use by the remote domain, Linux must put
> it on a deferred list.  Normally, this list is very short, because
> the PV network and block protocols expect the backend to unmap the grant
> first.  However, Qubes OS's GUI protocol is subject to the constraints
> of the X Window System, and as such winds up with the frontend unmapping
> the window first.  As a result, the list can grow very large, resulting
> in a massive memory leak and eventual VM freeze.
> 
> To partially solve this problem, make the number of entries that the VM
> will attempt to free at each iteration tunable.  The default is still
> 10, but it can be overridden at compile-time (via Kconfig), boot-time
> (via a kernel command-line option), or runtime (via sysfs).
> 
> This is Cc: stable because (when combined with appropriate userspace
> changes) it fixes a severe performance and stability problem for Qubes
> OS users.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>

Why am I _still_ - after two earlier private questions to the same
effect - on the To: list of this submission? Please can you respect
other people's time and interests and properly follow patch
submission rules, applying common sense when (like has been the
case in the past for Linux) those rules result in overly broad sets
of people.

Jan
