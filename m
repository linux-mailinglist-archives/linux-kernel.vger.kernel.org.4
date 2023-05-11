Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5E6FEE13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEKIyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjEKIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:54:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E207E47;
        Thu, 11 May 2023 01:54:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2bEEEzpvRqwJhD13Fl6jrS/lzvOeOa8wRSBWOfjX6u6ejJ5dCKjhJa2Syk1IqGo1XjqHT6kPcQShx7NbsyDmCSjRHNkW4P+0K8KCdrzates+0AdwBXPpinkXVBEXRqPgwpUXPACuV1TkII9ZSBfQ/8jts1MKllBOkwyIA6gKTzCbb8ycNcCXkh1izO+kFI687i/OUkeeJt5c9anHCdquuZhihozmQ1qrDl36ZZ1wzx723SpCs1r+7/KaMOquJ0j3EGXLRvAJ2zKX4qTgM2TlHs5fueDW2PHwyNIHzQ1YJ6VV/X0RUXewoCoXPnRhamr5wVCivynxWL44CjdyjFWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nNP5UeK3Xud8xe4b8BhFtQKT0ZFd7aeTrRXNCfBFTw=;
 b=UE96b14yn/Y5Jr98jKVRcmsV71afsBktkHc0QoYKJvd+sqfBLLlpX4Pj7Nxr/oqhnz9g8dk4XgYz2+37N+1UQ6E7D2V72qYOkgM/Ig3wqA9YIRUqGWDC2KSVGSag0hTom+6UEXelW7nzmjnKe0Od/CSw8Ls6UVZiyHRnuI2M+0vXOF2bCOTDkxYvVeVwR8OaCu7U7MoTfc0c1bzojsm468HAuEs2dPDZtydgf/gxWdAItkSi3BC1qa8IjEURJsls53/VMtBYaPJrxo3JYOhBMSw7oVVjqLCgDafwsnA3XOyTRlAQqD0xef6Gu1LXAjOydaY3yMIfkSk00w4JNN7UNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nNP5UeK3Xud8xe4b8BhFtQKT0ZFd7aeTrRXNCfBFTw=;
 b=kjuWUkzDQ6LrzQo7cgCYCUGhikYZfpNYW1Z1+/bSKmoYJeLwllLcT7h6bMo7BAiKN/57ER3Xd7EyRnSKTF6Gye2hOgno8jkjyxLuNUPCvnKrGxPHvVXwqpBxmgq4UeyIMTQVuzNwDxf7hz3LTTSVCe2viLETds9HUVHjKLxug/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB10065.eurprd04.prod.outlook.com (2603:10a6:10:4c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 08:54:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 08:54:33 +0000
Message-ID: <28629bcd-d01a-92ab-b27c-0b8ae8bfdaf3@oss.nxp.com>
Date:   Thu, 11 May 2023 16:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
To:     Greg KH <greg@kroah.com>, Peng Fan <peng.fan@nxp.com>
Cc:     "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417FE67ABF9A2B1EE4DEBA088779@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <2023051027-wages-feminine-cb5d@gregkh>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <2023051027-wages-feminine-cb5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB10065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af5caad-c628-44ae-6299-08db51fd56fc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3T/1IP+YpcWGT0Eu9LRtK6lb2NksHXXjjt7UGjK+kj4e9IM46HUejSld9n2dAyMBy0hXrJz3Irb+gSujVv6uJ3VOnFzAr/D2PPasODZIeDGa6bHqgGOSbDHHjWvJ8PR1LZSLKov9LujxiDPvaii5qK2Z/3+sgaozQQR7novzMtwcqsNXBSaFhoC6R7SvAAyf7RJjePrS8Wstjj1Iiv6h2m4tp5/Xk0BdyBevYyhmTyza8Tas6qvSnodqU9AdOEdr5QXlMMThyneYmicsriog/mgYQDWfvL0JthM9G/9+Cl1OdwerrJYCRArHJ6Cpvid6xX/LP4TRb+TzhUxgGE3MB6tho+hVkQ8LhmejhtWTSuaGu24cQ/lRTcMyu2o4aY+XGXIh/4h6AhzLvGZjM1AbA6PPp0WKC6tgCSNFxUgxvsVFcf6E/Yvh4LhRs6Ci6mldECUvfn15ashRAlKvOhMA2WThLXCs+QrTkjDy47Twoas4vhzsLnLUtngOxdgV5TztGz7NvjJ6CA5QrkdNOJqLamA16QzwMpzp6hK8EMQhicrk2TeJuHu73/dPKcQQPawMvbvzOWdmnCf8J1Dt+2sAdO/2x4Bk4SxlQYajA6u0bsxzqWstJR8bvCy56mT+tKwFmVXmMknDG7OwJCtwt/zpPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199021)(5660300002)(44832011)(7416002)(966005)(8936002)(8676002)(83380400001)(2616005)(2906002)(186003)(38100700002)(86362001)(31696002)(6512007)(4326008)(6506007)(26005)(6666004)(41300700001)(31686004)(66556008)(66476007)(66946007)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRxMlZLckl4S1F3dDJOWkdWQ2V4VG9KcVdmdHJTUGZKdTlWMW85U2ZUR3lE?=
 =?utf-8?B?VzZXRWNsczV5TU9tSUJjVm9JVHRiL3I4WlNNamJjeUgvUkF6RG0zT2NiOWFl?=
 =?utf-8?B?UkFCUG9qSlk4QkhrMks5WFMzaDdqQm1TUnBRVUw0TGxGaEk0NDdmVnRQVlJW?=
 =?utf-8?B?VUhSd0dETWcyOGJLRmlNVGxNMVVFcU9NcTJ2UG9pa25CK3J5cllwUEhBcmZN?=
 =?utf-8?B?bzFzTDJ5R2VzdHJnb0xRNFo4TkR0WDQxd21vRU5rZnU1ZGt6eUliTmVoS2dn?=
 =?utf-8?B?YStPU1hXSnRBOGdUUm1NenBUUWt1V1hZdEVVeENQbmNJRFhBVi9kMzUrUmcr?=
 =?utf-8?B?ZzIwakRiZ0xNY1N4aFVmR0JZQTZ6QS9hWU1mRU9wNEttMEZZVmxkUGpMWUk5?=
 =?utf-8?B?dFpZMmQwelphYk4yREh4aXM4bnNIRHovS1BIT2NGTnZJWDdaOVVISktNNkZQ?=
 =?utf-8?B?U3phUGlaSWVwTDV5dGdtcHduMys3NG4xakV3bktEOHo0L3p3RER1SHJGTkRx?=
 =?utf-8?B?OUR2WmVQYmpFK0JSa2ZlQXI0Q2hSbnc4Z0tWazh5Nms1VUp1S1dpNjdPK1FW?=
 =?utf-8?B?S3Nyb09oekNlSzRkdjZzUkwySm1LTm82WEJrNFJydHZtNHNRUjhwa2ZCZlRa?=
 =?utf-8?B?bDFRZEpNQkgxLzFmS3Z1blloc05DT0ZPSk56SE83Yks4aXAyNUtwdmJ0Z0U4?=
 =?utf-8?B?enBqZ0xoSCtVSEt3Sm5BYTE5M0RxdWg4WEZzWlM3U0FsWk9Lb1RUL0Mybzcv?=
 =?utf-8?B?NGhURWFYbFJqNnU4UGJQVDcvZk5mNG5OUkhTOWNnaVc4ajVDdDlqS0FPYWlE?=
 =?utf-8?B?YkNBdk9MM29VYlZkTUtQTEgrVXJQeDVnclMxb2VMYSthUWF5SXgzWFRKdGV1?=
 =?utf-8?B?TDdDeGsyZ21QNFFmZ0M4Yzgvdmh2VWtuV0JVY3VtamU1ajh3UFdmazB5Q2Ix?=
 =?utf-8?B?R2RLVmdpcmNmaVRCSEpGaWh3MDNGMjJjd25pblZSOTMrRStXSWh6SDRPYzVH?=
 =?utf-8?B?d2tFRS9NS1JYakxGL2k2SURVb2htaXhCYjhPQ1Z3Q3YrQUNwVUx4VG8wYk5R?=
 =?utf-8?B?UmZxQXpJdVZ6akdBR3pNbTVqcDMwUXBIVVhaeGQxdXpCdGwrMmxoN3FPWFNW?=
 =?utf-8?B?dzVGWWdyNkU2VGpQR1dIMnBKR0VQY3pDaGt4RmIvV1RyRXlxOThySTZrcGlo?=
 =?utf-8?B?MjRraGhVNzJoNWVnbERlZnk3QVdObi9ZcVVOOGRMZkxJV2htUi81U0FSQ292?=
 =?utf-8?B?cXJXakFHMlZPRXNyQ2NXMU5YOHZoWEI4dytWYnRKTTI5N1VVZ0h6cXpicnVE?=
 =?utf-8?B?RW9hbkFqL0h0MEJaRVdjU0NsSytqWEpCbE5wSDkwZy9nRVVDaXNEanRvQnln?=
 =?utf-8?B?WVVwYU94K1F1TE1JemRWQXpQd1BSK1BSMEJldlJuLzF5Ui9ZNVJMTWMybGJW?=
 =?utf-8?B?MVovNzZWRHhCbzVCOWpYRmFkVUpzdVloVE4rZ2ttRnRrTUFRTmRpNXYvQ3Zr?=
 =?utf-8?B?QkZjOHFmQXdRa01wYWhjeDhrUTVYeUtjU2JCVVNmT3VDWlRXdnFQNWExTE5l?=
 =?utf-8?B?emg5Y0F4bUFXeHg0L3NYMVIwTndjSDdwU0xmVXI3SDdGRytHOWJxOTBCNUtO?=
 =?utf-8?B?SUNKRzlwOC9ORlh5RWVnTVBPOEF3V1RHcFBsYjdpL0xRNEczTHBjNHgvR3Fz?=
 =?utf-8?B?Q3NoSTJlZDZLTk9jKzc2cWVEWkNhR2paL0V5ZnhRZHhnVkJmbGkyVzlneHhs?=
 =?utf-8?B?QXhvM1NCdWZ5Vk1jbUgwbGlJU3JaemxBSkJBYXZRTnpCd2hPemovWnhIWWtZ?=
 =?utf-8?B?MGZFbkNRQ25mWVFCMEpGOE9ORUhrQVpPcFRpOWVXSEdwa1lNQ0lxRUk5Rlgw?=
 =?utf-8?B?K2NiRmNWWEhCUkN3RmNaY0IxeTI3dE9CL0tLeHh5S01aWmJaUlgyVXliaVVD?=
 =?utf-8?B?Vi9JbSs4cjczdUdwOGZsb1lRalA4djdjU01NTzFHUW96dG9aUzAvZnlkOFBx?=
 =?utf-8?B?SlhFbmR6bmZKQk5lUUxZaTNUOTNBN1Ztcm5MNjNQOW5leDBFL3JwbnJwemg3?=
 =?utf-8?B?RlhEcUZ1KzRxZE9ua2Jackpyby9NU1BrSkRXaEFzOWROV2JGZzcwaHJHZlMw?=
 =?utf-8?Q?vZdlNNtrHbaWkidmpaYlB2F50?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af5caad-c628-44ae-6299-08db51fd56fc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 08:54:33.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwj5JTU+KoE2T/5foeMEn1A2yhS5mkFqVzAQGtNgx5vROy74vGvSXLJvAHNmIjsLjoDCrbXRWNXQbcCgnp9wyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10065
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2023 5:13 PM, Greg KH wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On Wed, May 10, 2023 at 07:49:20AM +0000, Peng Fan wrote:
>>
>>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>>> parameter
>>>
>>> On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>
>>>> With the clk names specified in clk_bypassed module parameter, give
>>>> user an option to bypass the clk from managing them by Linux kernel.
>>>
>>> As I said on another email, no, please do not add new module parameters
>>> for drivers, this is not the 1990s
>>
>> After a search of the list,
>> https://lore.kernel.org/all/?q=module_param
>>
>> I still see many drivers are adding module_param.
> 
> And they should not be doing so as it is almost always not a good idea
> (note, some subsystems, like sound, do require it, as that's the api
> they use, so this is not a blanket statement.)
> 
>> Is this is strict ban that new platform driver should not add
>> module_param?
> 
> You need to really really really justify, and document in the changelog
> text, why all of the other methods of configuring a platform driver will
> not work in order to have it considered.

I just wanna use the module parateter to give user a choice to choose
to bypass some clocks. There are 100+ clocks in the driver. Different 
user may wanna different configuration. With device tree, it is
not flexible.Such as user A may wanna bypass clock X, Y; user B may
wanna bypass clock Z.

With module parameter, I could easily set it in bootargs.

But anyway if this is not preferred, I need to find other way.

Thanks,
Peng.
> 
> thanks,
> 
> greg k-h
