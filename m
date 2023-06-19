Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A04735895
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjFSNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFSNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:30:48 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9990E101
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:30:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oF47ca6jEVeSd7HLiunS0eNuwmDKQ2eEiko+B8dPyBUqrW0pJlaNE4M8lqjXMTgF9uDbiWHonHVVsSVvc3g3/0yllCmRYNJe2ccb8RCcO7Hl5YZyUY8hW7AHQ9BMkSeAA2s0wy8D0mKoskpOMIuDofthHlJ2tXTBvt62EPcekf/qTeifFOwst4F6qfZecA2rOI5nwOTJD3vgaCxJ7JUt6HrDmelZR6tVFjvcwBqmZeOCHKdSDzkJQtEDklufHRSS1QJJUTzSd5ci0cjWiLL6RE/goQI9fyuMOCFxlxfLEs8AMNs4UBUuSkxDJjIIn2LLqXMz6JxHAPFJeEd0EX8Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDa/LnUfcWoTd6qthPsTRy737vFeXn8akuWyZL/JlL0=;
 b=Vsn7/m+kkCAw8ObqDUaD181o1031oj744Njb3GjSJmbunquCEKsA5PZT/DJ/7CkXZKpfv7qvQbzimuMsiRuNLjoB/xmGjQitnCE/ph28QT3U0nzioerx86hM6M69UW8aTM75IKMzEFcjI0iCJlwPHJ7fuP4RCfHUhmVBiqblraevlKAJ9Nw4jk03wqVpLLPCQfQa52zpn9C4Du3WIdaSig/H+q+eVFpGHg4ij1ky2d5J43W6JG1nz1GFEwplU1w10XvNXGbUrX9W3HbsU4ph3U6tg3Lb7ErIY7M0zXZAd0Etc84fGbTUBoIUJFT7UUV+PrbtA20qLJhm1OuLXpa2PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDa/LnUfcWoTd6qthPsTRy737vFeXn8akuWyZL/JlL0=;
 b=Ey6CFJlNm4U4CrryIX/l0L5dPBqJJRYWQ9lxYcXHqN0DUFyQH6OyK0qZn2umuO2OwH6wMBWgBj0eTKlehj5INszbwvIcF/F8ZbV+oapEVK15t9VOm/FLhV1wj8+7KJ/wLF5DedXqrozwJLt3rmaX8/ipdvB0x+7zW6wVUqWI8rrENkdEi5liX4iGICk308vehq5C6YK7kD0k5cXDM3CIgTjkiY/3RyAoPmeaY+HCPdlo0tFHCp01x3zSdaeXkAE+/A+aA9NDEnWLFkfCgyNajUWxA1Lj9r4rGOlnPKK7py9q1eudVDeatDblkKsyrjsyVZXTnxrB4c36I7b1pCSj+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB8235.eurprd04.prod.outlook.com (2603:10a6:10:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:30:43 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 13:30:42 +0000
Message-ID: <0957c090-9904-2826-97de-8953efc75220@suse.com>
Date:   Mon, 19 Jun 2023 16:30:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] x86/entry: Rename ignore_sysret
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz
References: <20230616125730.1164989-1-nik.borisov@suse.com>
 <20230616125730.1164989-3-nik.borisov@suse.com> <87sfaoqyt1.ffs@tglx>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <87sfaoqyt1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0212.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::33) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2baae3-ddbe-43ac-b4e5-08db70c96131
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wf4AHfThAA5WEzTrQ6pnAk5csXO14KY8aflv7UQaEXXgqEJsmeF20990HmzSvrErMWMGoLmkP5MmjtVmedJ+W/O5StCuZ4fP+mHvGR7Nh5TXa9WHzfjn1fBMj59GV2JhwotgRc6y2aMPuftsiity1lZv3nhWLqo59fpvzLZv4Y/ITZrzs9lfl8L310MPbJhYH5jeXT9vhLc9vGnjSG10XHUWxqnHkF6SL3WGfrd3ZpLnpKY1YyfbzszFkepd3vJbO3Dyklw95a5S4TODGQyx6UV0KylKGC/XaFdpkESOMKdiYGKDIx76xZ0pue672D2+GWCzucUEx9BY57JATl6UNScQ1BgfM+7q//Bj1kPkMQWLfxHQpghxOS2CbxFL5Sxd9tl9Bm3dwmsbG0eLZB4kzEcaMb+xKoZTVKOUEqxMHTByZmbt8B0mDe6tv/jL4hBuEZG5Rap7Gc0vLUqNIQKiSVZhRrx9K3qNAS3oPr+x25e9pmARvAzUD0zh0ueRiWpNHOgJAs3H0D99HqfDb5V7n5it6yw9GAnfJWNc07gqdtihGz7dJzvlp/BtS4Wqhcx7CFbyyg/O12FY5+8gehWVTi31sCPH0+hqyLRqvwgoLDu8NB+hiDfsXROXOH31ko+Tj+R8+pnexB3BqhNfcRIRbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39850400004)(136003)(366004)(346002)(396003)(451199021)(31696002)(478600001)(2906002)(4744005)(6486002)(2616005)(86362001)(36756003)(186003)(6506007)(6512007)(8936002)(8676002)(66476007)(66556008)(66946007)(5660300002)(38100700002)(316002)(4326008)(83380400001)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkd3bHlCR0Zrc3ZFYmZoeFBYcEE2Y1hRUE0raGMxZE1GTkVBQzVsMnc3OWEr?=
 =?utf-8?B?d25UaHQ1M1BvaW5IRW0xVjl5eGpWNzloQ0xuSG5UTFE4RUJFSlJGcWxaaFYw?=
 =?utf-8?B?aGJWTVQyVElZemRYeHl1Y2hldUl0SjErazBkNCt4eWpNdGR5MEUvdXV1dXpS?=
 =?utf-8?B?YmRyei9HZjh4MmRmcmtRMlhmdk1tS2tCUjhPemdacFlsWmFFM0JlbmV3MS9t?=
 =?utf-8?B?bTg0eldaeXRHd0lKNkdjOWh1Mk1hQndPQnk1dzBPREUwSUtqZGxWdTVNQk1j?=
 =?utf-8?B?cVlwTUkyYnpvQlEyS0VVUm9JS3hFeXZsd3dJelV6ZmtWVHh1ckpDdHhQWVpE?=
 =?utf-8?B?M2NOTWZCYXhxYmRFeFZZVHNrbVVQa1EyaXJxL0dJbThsZlJvQmhQbVlKUFhh?=
 =?utf-8?B?TThOMS82cFpMZGtYQWdDY1M3WjhCa0tHS1ZBSkVJRkl4eEc4eG1nMU02bUpX?=
 =?utf-8?B?NHZQaTE3Ym1pRGJpTjQ0NUR6bFo1RzJwVGhDMmw5UkRuU1AxbEc3aXBJZnVO?=
 =?utf-8?B?QnFvRElmMTlYSC9GdFJwOXY3WmVaTGs2SUxmZVc5NUg3aGRLYXVLTEIyZ3U0?=
 =?utf-8?B?ZDVDTDFPMkpaVUtiVmRhbDJ2R2tDU2dsRDJhNnp4NG4xck9vVjlpYTVhYktG?=
 =?utf-8?B?SXh4K01zem5YVHZuYU1OeGE1cWlSRDV6d3FuckVEZERKWjhZZlIyUkV1Ly90?=
 =?utf-8?B?TjNzRHBwVEx0OU9paXFTQnhGRjFaUGhTZDB2WU4wVVNwUUxURjhUaFlXYVJ4?=
 =?utf-8?B?UGJweWkyYmRnSGFKWE91c082RThNM09MbEJhN0gvWnFhOWwzU214OWxNNXZH?=
 =?utf-8?B?SGdFQ1FyOVVHMVZhRUFKVjl0WjBGQjZIdHZCNjlNN2ZCemNZeStmNkpHYkhN?=
 =?utf-8?B?UXBSYVBQZE0vZGlyL1Z3OFdUL2VJRVlna3BVYi8yc3ZQWFlNbXpqUjU5OGE3?=
 =?utf-8?B?NkhCeUNiTEt0ZXBUY0wzNlJQNlVFRmV2M2hWMFpFbExtTERKQzNvSzB0VXRh?=
 =?utf-8?B?YUorRjhEeElwNEtMRnE5YW85bW9paU51b2R2Mk0vbHV3Ri9Uc0p6djJtVjV3?=
 =?utf-8?B?OENsdzFuVk5teU5weVFhV0VPbWlSNEE4NXJWQitSUDVCSUllM0l3c3lYSWFQ?=
 =?utf-8?B?akdZNGo1cDhsejk4R0xrU1o3cHJlRXNSTjR6YVBQZ2N5bGJnYmJVL2pDU1dq?=
 =?utf-8?B?UEU4UGpsY0FhN1VDZ2FZZEZYUUh5VDhQYWFyZk1UM1dOSXJlS2Q1NFYxaUFB?=
 =?utf-8?B?aHUwQ3lUbllwVWl0VmY5VldSZXgvZHJWLzNGUWJlS0t5QXVzdkRUMXRvYlEz?=
 =?utf-8?B?cHNZQktUQWo0MWpUZElPMVV5MGNuMG4xeGtoNytnU2tGaGlHRThCa0JFMGlt?=
 =?utf-8?B?b2VBdkFUbjloa3hDWU5uMXU3UkZyT2h3RDVaTEZuSkN4R1pxbmQxTzQvaXFW?=
 =?utf-8?B?NytYcTZzNGlTaWp4VlV3dkNmaGoxWEY4WUpPQjE1dEx4bGV5WjZnNTk5YUhG?=
 =?utf-8?B?UVhuanVvYzJLNHJJZEJoV1c4clFDVVdoaGhGOUd6am9WUGZQalJMbDAydERP?=
 =?utf-8?B?UitYemhKYWtOMnlRNFh6MzgrODV0SWhhY0VtYUsyVlNBcWpGdlc2eVBBVm1i?=
 =?utf-8?B?MGdYVnUxanlpVFphc2ZvcUR1a2FRV0FyclFFNW4vc0ZTbG0zaHo5R2I5cnhR?=
 =?utf-8?B?dnpkeThzS3lSNXBzYy9JcHBLbHRFK1pzZ1FGeVZDWmxqa3ZpRzJVK09LYnY1?=
 =?utf-8?B?M2t6d2V5TVBIaURCMTdKVkpPWms1Y1JnM3U2SHoxVnA3TEhGWCt3aWdZeVRk?=
 =?utf-8?B?My9wWVJ4bnFDYnFKamRTcHo0NjJVTjFuTW1WbkVoc1pXejBqSmZVL3c3WGVV?=
 =?utf-8?B?QzNQNWdaSzdYN05ZWmRaVWlBOHBwQ21NRi90TWpwcnhmVDFFYWg4VGZ5dFVZ?=
 =?utf-8?B?UzJybExTeWduZUNUeXVDVFNrR29DS0REU2t4YWljOUM3clQyYTRJdzlNVnhP?=
 =?utf-8?B?MStLYmE2V3NubWNzZCt2dXdzMmdIYW4xZU14T2VDalRaOWJKdWd6Q1R2VTFG?=
 =?utf-8?B?VzB1aHZpNTFjeDBkcFU1dkVpQUJXNWR1VDl3VDFnWVhHS1pNYWs3SHNRUkN0?=
 =?utf-8?B?M2tPdWdKUlQ5dHMxdWRXVlM1cG5zRkdiMW9DQW5ycVVGdDJad3Z1dVI5UzNm?=
 =?utf-8?Q?3abUcDdKDvrSCovoc00KINgdWhF39EnSQ2wAChIhw+S4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2baae3-ddbe-43ac-b4e5-08db70c96131
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:30:42.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUGUFe0PK6t1pBY+YrNhd2hiI+QXxEUN4dcIgDtYPf7kRbFakan4P30CiqmyT2exESYKeIjLTKzI+FjKUboGpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8235
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.06.23 г. 23:51 ч., Thomas Gleixner wrote:
> On Fri, Jun 16 2023 at 15:57, Nikolay Borisov wrote:
> 
>> Give ignore_sysret() a more descriptive name as it's actually used to make
>> 32bit syscalls return ENOSYS, rather than doing anything specific with
> 
> That's not really correct. This is not about 32bit syscalls in general.
> 
> It's specifically about the SYSCALL entry point on 32bit, right?
> 
> The reason why this is required is because 32bit SYSCALL cannot be
> disabled in hardware.

How about:

"SYSCALL instruction cannot really be disabled in compatibility mode. 
The best that can be done is to configure the CSTAR msr with a minimal 
handler that returns directly some error value.

ignore_sysret is this minimal handler in the Linux kernel. Rename it by 
giving it a more descriptive name."

> 
> Thanks,
> 
>          tglx
> 
> 
