Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A6A6832EE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjAaQmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:42:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC9746D70
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:42:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+a95klYU3P77gJ06vzfbU4rvF07uOBhVCWI1eBaqfCjISc+2l40AO8sTAwWAxhxnEDC1BmQR6yE8WeqfJ0zWFtwW7OsJ2e4Xox7M8eJJHkjVPLGtJWpehr+YKONXhIKmHIt7+d/08EzGeFR9K/1qcjxdimbW+yTySTbEBr4eH0bCF7ee8gZAXmlkeu8yY+JC0sK5KquR92R3mBeHkL7CP5snmxE9P1wC/8IXtuH7GLn6UMR4ZdQlhBzLCZKGCwvKTngUPzDqM8EXIfalieYvXFUiIXx6we9EzThnjeLHWkPARLgRLs5QX62qShOCpHRsFJzLgEReNsVOFCflF+TPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EIjG63h6CaFUV0nYHwuugiEtKuYfMR/KYXwgOaRFtQ=;
 b=c0vw7OcZX2hc+cr+nAfxKBQ17JNXm1BKMeXV8gv3PwyrnV+NsDbjpRtI7jFtQVylg6n+ARIDSyJyYTTcKGHQ7YBnBZ841lL2cFzLO1ZzDz24fAhkwYCZ4usdvPruTgeItCgZVeuo9T5pa4ZxQYzIrV6l7ELzZqA1w+Uua/Ch4pA8kbCTJE1MQq/zwT+1CzWJj6wkSMCbM7jrxUte0MtNSmqZmQ5Xk+5bxpu2EWfTKV8iKGHQFhcdoo2M+4mT/xcZKZ21QeMOE6jT24HWjOQxA97mtN6kiKA6K6DR/Dezk/q1+a7Zd1lKzKx6kbrwD3ug4eux3I+OQaozh7yVyNDoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EIjG63h6CaFUV0nYHwuugiEtKuYfMR/KYXwgOaRFtQ=;
 b=t6A5EwsePlqxYAUjY76vYY79Xr9pWpr+uHxv8xB+e6YuyH3kMbNO4Qv2eBERc2ROdUvIT170pbgDkYhjsbhAitnVFmlhrp/73eKMcYUH4pEWGOQi94bnMqBbeHE3UWJcCg3UoSoMj4KTRnSL2zxLTz8Uj4Gz9jYYGO+eNRf1rSrunogt7sEDKla43fkgOCATrkcenBryseofUScVczb7hAREZrbaCJ0Mx+c2e8zprtux9bTe6hxt4dXZY2hXjfvkzbngOIRa2IpbS8HpjQoqNEXtENvlDYi2pXUfIXNS85sMVx1rsPVVdHNED1gMjjYkGzM+2IfeAh5S36IsLmLS7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 16:42:21 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::6fa0:875c:39b1:1960%9]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 16:42:21 +0000
Message-ID: <7a3e943b-c767-61dd-7710-daec82897be9@nvidia.com>
Date:   Tue, 31 Jan 2023 10:42:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/5] genirq: Introduce two helper functions
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Michael Walle <michael@walle.cc>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
References: <20230130005725.3517597-1-sdonthineni@nvidia.com>
 <20230130005725.3517597-4-sdonthineni@nvidia.com> <87k01312mm.ffs@tglx>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <87k01312mm.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::6) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: b3a35c36-ece4-442a-895b-08db03aa1f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dpr4Ac87smgfhKyZB2rQZGVGcsZ+lsYuflwvUJ7NWTFMs8L8h4P/pTqkgysfntFhINHuPV8oE9ADco29IO/+BVaVYNXr7VKA93bzzHwinTQ1/jjTlak2jxwYYlE7WvilKk1OOCcLG2Rc7wmtSjuMszDg4pTEZFcxxntzgU19YCQyRiWkutbVlz63a0jiyTAwzS0f9XsI8kzeYTLLCGhR1nAuGWc2X8OLwTBWVyxkkN+zmIMFG2DHuN3MHP/9Oo422uiK0MGGljpkc/7KSNYir+CMQbERwEWwjizTSMdhON1r4M0Aoe/cnsvS3s+FVPYykJ26YmZ74nULEdytwiRG6FqiJmZPIHLabU4rthcauV28ZNEi/EZVUkTy2hfHT1c0ZHpNKewCNLb25+JSgwhAdJRcSsAe6gdWLKjNVyfcwNw4nxLkr8Jt2siKi8roY26UnvK4328hFcxPTiFN40s245Y1S6QibkEXJM6I7SJzV8ihZKTl/IMs5VBlB+R7JVoUNgnnNHV+KpdJY8A4VFA+zZfV1Z4vpTVXTUM3LytwKdruEBKwBDKHQut7gdvCDxiZbMmXkOVyv/VUiHCnF/mD0niGzcEX/WkoRvVwMu+yMKJrBOiceMjzmIYiRLBHWZuK8BtmAw37iaPkEIBKYKRm9++Uqq/f8dQJHpJQDI10dgvm/Garf2XemKNCTbqxixgJJEJLidpjOp7jDwtaqrIJQAY9Y/rhLQTb30kYdfbrbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199018)(31686004)(36756003)(31696002)(66556008)(316002)(110136005)(66476007)(54906003)(8676002)(4326008)(41300700001)(8936002)(5660300002)(66946007)(38100700002)(86362001)(53546011)(26005)(186003)(6506007)(6512007)(83380400001)(4744005)(2906002)(6486002)(478600001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anVReExxTTRVRzVoMlJMTnZndjV2QUo4VnYwdTczSk1pYjI4c0hxQWlzenlE?=
 =?utf-8?B?cldPSjFWdkM0Ym96RzhhQ2w5a2FSOTFxSXROQmtxVTkyT0tNR3hseU1JY0JF?=
 =?utf-8?B?N29GTEhWUVgrcXB6S1RiNi9HM3JyTXZTY2tITXc0QURuYTF5d2hjWWNLU0ZT?=
 =?utf-8?B?dnZ3bTcrdmp0OFBuWlZNUysxaXpMTldXRE9qM0xlbFFKR3RFSXdlNnpvdDIr?=
 =?utf-8?B?OVZmbWk1U2d0Wm5oeElmRFM3TVNTUHdiazhsRkxhTXJpSUIreTVUMGlBUEVI?=
 =?utf-8?B?RHJlUXpGdHBOeG9mQ3R6RjBRalZXZEpubTFjTUlZUU51N0o5STVuMUFCa2FF?=
 =?utf-8?B?U3pjTkVHbDByT0JOZ1N3MXRvOEwrUVlYZi9jRmprWkRIY0pzdy9TcXZVdHV4?=
 =?utf-8?B?VERTQmh1TFR0WVg5Ky9OaUtRUXMzcDFLa2VHNFlFZFF5UGVjeUJaejRISjk0?=
 =?utf-8?B?aXJORTVvSlgvd3VIbkg3SHl3b2JMUG1WNHlNQTlpYWdueWZLM3REZURuTDcr?=
 =?utf-8?B?bEY3UjhVOEMxQmIyaVdLczF6L1BMMU9xZ3hzekpGcW9jUzBtVjNEeHI2eHRC?=
 =?utf-8?B?eStwc2daeUNhWVN4d0Fnako3eE5aMnZFaE5KMVMxVEtJbXdob21jQzV3c1pG?=
 =?utf-8?B?K09IKzE3a05rR2dJL0hMWStyaGFQdVBjcVpybGx5WkxBdVJoTFAySXZnVWxp?=
 =?utf-8?B?NC9xK0VmOEFRWEhXSlVZcWRqNFlXVEZPK01NRk5pd0owcEx2dStyeS9aTDRu?=
 =?utf-8?B?T2RsOENlMy9rZVlsOXY5NlE4TmI3LzgyS2ZWUVU3c0xoS0o4TVNxbWJITURp?=
 =?utf-8?B?YUVFalAwNW9rRjY2amlOU0JydjFNYlFUVjFlOGJsWjF2WkNTVTNBc2IyUTZM?=
 =?utf-8?B?L3Zoa2x0a0tqdXZGR3N6V3dMTFRlcVJkZ04yaWdWVkpNNWEzM0d6RlJ6ZExG?=
 =?utf-8?B?amNmS1pKT0NuZ0xoUWtxQXBUR2JaQ29BRitpd0Jjb05SUGE2MGZYSGhKbDF2?=
 =?utf-8?B?NFhXOHlvNjdyZDdEcG5GYlNwY0lMUjg3dWtMT0RLaUVpeWJNVFV0UTdCT0pw?=
 =?utf-8?B?MlJiVXJadXJZQ0VoRytuTHNYeEFULytlbWdhNEw5dFRJSWQxbE9lY2tKazFI?=
 =?utf-8?B?OEpZeEoxVmVwRnJxWkoxSmM4V3BzbUxJdm1pSVdBNW03Zm84bVNWK25hb01j?=
 =?utf-8?B?Y1cxQ2o1SElXYjdGTGpDREZXVzc4UnpKR0ZOVTdmSHZVanVLQUxaYU96cXpa?=
 =?utf-8?B?blNIRGlKSkNnNEkxUzI2Q2VLemtSZXFWSkNMWVdKQ1JydWp4OEZKUjNFNnpo?=
 =?utf-8?B?aXpUZWwxSHpGRSt0V0txUGFVeUN5NGxKN005WHV5ZWN4aVhHNjdoK3JNSUpI?=
 =?utf-8?B?T29HTFhPR0xUays0Q01qWUdxT09kSTNzRk12UWJBb0psT2VKMGJxR1prdjM3?=
 =?utf-8?B?Um83NnV6SnVqM21ENXZvbjFNMm5SbUNQNm5yZk5vTDc3UDY2VU9Ra0N0TXlC?=
 =?utf-8?B?MlBJeDdRN1hPRkZ4bVk4Q1F0SldBdTYwSVlKL21pRGh1RWpiM2pqNGlzZEZs?=
 =?utf-8?B?SXhZRFFzTXJQQ3RFN1hBazg1a2tLUTRkZmV1dnJ3ZVpXNkpoWUx2S1d1dERB?=
 =?utf-8?B?UDVVWTdEZkZ5bUwrSWU5b0UxbTYrNWJ4VmZkNm9VNFVzTUR1RzdPMmFaWGIw?=
 =?utf-8?B?T1g4Z3hHRXF5NTF3RlViL0dRZTBlZ1FxZzYwQ0FsekhGMnBaZmltL2xyTVdL?=
 =?utf-8?B?T3NSblRGdHlHZVdUUkFnMmMyVm9iZk9vK1AwcEMvSmwzemk5Y3RJWEZ2bFht?=
 =?utf-8?B?emJLcHduTHBMSWVveDVnaENvQ1RPRkEyRFhkeUlsV1VGRlY0ZlJrMTF4dFl4?=
 =?utf-8?B?S09YdjFGZm90WlRFSEJNbDgxVFF0V3JnOFdibk1LN0hNQU02Sno4eGsraG1Y?=
 =?utf-8?B?QzRDYU52cytXRjJMYmhvRGRNWnNEY3Y1cnRnRDZ5NmJlUHdPbU1wQjV5dHNw?=
 =?utf-8?B?OGFoMXc0dWhDUjVlejRiWmpodnoyOWhlc3ZPRjFZOTFBU1J6VVhQcTJ5U3U5?=
 =?utf-8?B?YUoweThVMU14NmNhSlpKMGNvemQ3ZEtIMEJaMXhtT0hkWitPMldRUUZJYmps?=
 =?utf-8?B?dm5Gazc2Y0RiOXdjTFRKdlVpTTVNTGNyN2lwTUJkbU9ueHpnQ1p3dU1VZHhj?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a35c36-ece4-442a-895b-08db03aa1f95
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 16:42:21.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7YDiMQSIF/+keoOeCdtzz7VxyOG+lGhIYs7zJUs2opbjlbwpPHYy7+XM4YnuUjdpCXHZ/bULfunmeCh/CXlmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 03:20, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Jan 29 2023 at 18:57, Shanker Donthineni wrote:
>> Introduce helper functions irq_find_free_area() and irq_find_next_irq().
>> The first function is used to locate available free space for a new IRQ,
>> and the second one is used to find the next valid IRQ.
>>
>> These helper functions will be later modified to utilize the Maple data
> 
> So you first introduce helpers just to modify them in the next patch?
> 
> What you want to say here in this changelog is:
> 
>       genirq: Encapsulate sparse bitmap handling
> 
>       Move the open coded sparse bitmap handling into helper functions as
>       a preparatory step for converting the sparse interrupt management
>       to a maple tree.
> 
>       No functional change.
> 

Thanks, I'll update in v2 patch.


