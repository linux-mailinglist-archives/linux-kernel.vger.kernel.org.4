Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E76B7332
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCMJyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCMJyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:54:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AB123664;
        Mon, 13 Mar 2023 02:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjBk5rXW1/OPdhVYQE/IGMtBedx59MD7IwAD2YG7/1q8Co92wshXwiDYxo5pXm5VswAwBClGIW/hkfDW5T7MAnM4Kpz04ojgqZ4luld9VkhMfe0LXLn+hxNGKV8iSfOpIGFqUuo2aYK/zKocc1aqGnZ/qXMqcMrRI1qL0aV2EBwT9E2P0FMD2z5uEJ5i6JzyGgsV5Q66cUQjYI+GRMwaK0nXMbtG9R74gDUHMxDXsOOhraPNEtp6MdAavRghy+yNIvf318z3UYVMJwDAbNEfrIobwcUnXM7Mc4VGewsklVFmgjQSCm4pqnmuJspFVVfkEAuKa9dmq7ilff3ky0Rnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ONMUFDtm9FIMrA+MAfIq8NsEISHFW/4140pXRo35Bw=;
 b=neRaHdoNeMLHLq4Nn7Ju4rt8fgfXj+7tr1mawyfB5aR/hUd4rOfumgLFywwLqIkrEpGLXgxiYbxME9uHsrmZShqkAw+6k43KgwuESoxrv158CGdV697a+zLY2Ygbs/J3DUq2Qbwh4aixHNrZ7th4/pQUtZ+Ps16UlQphrdhiF9cL45Rd1BZJ5rDvlGeOXjYVVkZzpKLbGWb4V4rF79wXqyRutXC6MiwOpufH49CVi4Vv1NUzKjS+CpECwZiFoGue/HgriRwFy4V3xvYpLPqeW/LkeBDcU2udoPOk1Mux06nDnkGkSJm64rm0hgRPJj6BtXgk0RuvHmL659QAvFSBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ONMUFDtm9FIMrA+MAfIq8NsEISHFW/4140pXRo35Bw=;
 b=A7BRK7IEkmYY7cmRij/NZkpe3M6ENg5BWEM5rj56uqRT1bhR4rvpiuVHP7Al0JM/gxsA3eZWMZwdAYwVKQ2o+1ADZ1Toef7iBkSWPw/4902SecNWDjzX+2yEu3ciqCRslBdi4W8UNeDj7Naop2o/F+/wzlU+3V6FmyJRQWM3sNwNDDTrlNQMdgsu/rbwU0SSVXohRRxFOm2UBVofKqR7vtiaFY4fl/6797lF4p/7WiWZb3XQvSfPO/YiphWhdx5/4K6wNLo5ljzh8skNNJF1dMvUyMTGZydvBEAJVi8mwQNZNndm7ineVhWUeyxQoqAgrxY45RCvaZaelTPebQJ2tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB7594.eurprd04.prod.outlook.com (2603:10a6:10:203::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:54:04 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7])
 by VI1PR04MB7104.eurprd04.prod.outlook.com ([fe80::2ea:4a86:9ab7%4]) with
 mapi id 15.20.6178.024; Mon, 13 Mar 2023 09:54:04 +0000
Message-ID: <e426ae4c-4e49-5773-e8da-919fa2e3dc33@suse.com>
Date:   Mon, 13 Mar 2023 10:54:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
 <20230313082734.886890-1-kasper@iki.fi>
Content-Language: en-US
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230313082734.886890-1-kasper@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::6) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB7594:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e695dc7-d49f-4707-c6e8-08db23a8e0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tvcOAMMgzdXCVQBwb8Y9ee4CfOO3QP5AzV3bBagJ9meSVAE0Z+EGiqmBjUQOlPx4qPKmqMLUHoD8kkWQu2Ezo7y7WZmxZQzQ+4dvNTZwFQybdurGD4C4DinCPpt7CnbSp0BQUdh2c2ZIHrk6Z0711CtSuEDNXmDaSK5U4klYaNhC0jQohMzi9PJsOjCh8sFm0crUhn8XoCMOZB2wwBmE3VMxfd15z17HSc9GjKFDP31wF5ckXuoWObC3okk3UtmB/m27kP7lJPsNyI/7gSbYuJkOGZcvtFtlaK26kJxGq8Okgh9mEhS/p7yrCIQR84s3zZhKejwM2N2evQG2ZXoy01PkdinF2hWjwPZ/E6qYq7tA9i6byxWNOBEvaqLMzUNO4pMQ/Ffm4a+JtX1Px8LjAaGuhiuik+8LKPrMkujNVoC+wCC2hjf0ZiFM0TMmVpf5RSNp6hVr33e7dKVYOYn3TRnee3mauoofIbCna0NJz8XTP9K5y+KXq9++qy3dlIlxrjOWIEFPCVf9MEY3Ed8EUN9UoPTeHhL7s3vZ6nZMzT58uwuzc+ykCeDGpEWw10jfXOLwwJrugsol47NpMFNWwUO8pnwMuKbNxzVXpLU0NiY/GZALwUspT41InLT4HCplN/nhmqbq6CRSmT62zRlUWthOvc0kzJSXyg3YmPsnUT0rIkyWhavxeH/jMF9qmBNTR/cwPx6t5xDeMetI0gZuDPqhCzpTnrkx610litNTZGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199018)(36756003)(86362001)(31696002)(38100700002)(2906002)(5660300002)(4744005)(6486002)(54906003)(8936002)(41300700001)(316002)(478600001)(4326008)(83380400001)(66556008)(6916009)(8676002)(66946007)(66476007)(6506007)(186003)(6666004)(53546011)(2616005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1oweUZqQ2FqT3A5enNBYU80Vk4vamdrbHRFYkhvSnFXOW1WQWNFeC9qOFdL?=
 =?utf-8?B?aWZjMTliM2NBMEJXVi9SMHhaUDBlWUhick4rdXhuQjhLbnFKb3NQQWNySWkz?=
 =?utf-8?B?QzZDN2NxZmk2d3Jmc25QUFpaRHlGRng1VzU4Y0x4LzJIQk5SOGdQa0hNbkYx?=
 =?utf-8?B?elI1L1ZMSmhKNzk4WXlvS1ZDRzVFMFNqZ1BvZlNDa1U5czFOYTdjUjd3MjUr?=
 =?utf-8?B?YlNWajFpajBCWUxENXAzaFF4YWVwSmpDQVlKcTRnbVpiYXZuL0NjK1JmTmZx?=
 =?utf-8?B?QjloVXBXWTZSVHVnMWdjVHJQZFp0RDZUSE9OVzc0UWJJN3NkaWlzcWUvNks3?=
 =?utf-8?B?dVVNZ25ocFc3OU9YTXJVZktJcWdVbUNPQnJNRjFPNGJNMHJ3VXRkcm1nWVhl?=
 =?utf-8?B?aVVGZ3JLd3A4bmFvVC8rZUM3TzEydDJUWEVPdjFtQW4zQ3NaaEN2TEx6MmRm?=
 =?utf-8?B?bnlacTZzVXlhZ0JiakM0L0taTU5FTWNaUjRaWUNjVzBIcTV5R2ZrdG5kZlpU?=
 =?utf-8?B?a3VzOXkrSmNjK1RzMlcvT1JES1kwU2JCY2o2TE9lTUNzcmtpZUViOUdBNllH?=
 =?utf-8?B?eXJFckg0K2tiN2M3WDJmOU9CSy9aKzk1QlVzWjVrMTZwcFZNcTNjdUtneG12?=
 =?utf-8?B?ZjRmeXhISUJHVHUvb0pQZ0dXWmhOY01kVTdKVzRhMmhWeTFZVVJmNm9pdXhq?=
 =?utf-8?B?cEV5SkxQTG1sc1ZiWWhlZ2RnYUtSZDVaM01IUEtSSjVjVGV1NEtncDJMb2hL?=
 =?utf-8?B?RVV4Q0pjUldBTDY0bWdyNFdCc1NBcWxxbmV4eldyTFRQS3VMYnY4R1dyYlF1?=
 =?utf-8?B?QmpXWjVUeDNISWxFRjFPR0ttUERXMWsrR1g3eldwbTFyVXcwVnZKK1VHbllr?=
 =?utf-8?B?Y203d1JtWHB2VW9WaTFHL2c4WXhKbm5FdEJ0TmYxNXRXcmQvYSswVUx2d0VI?=
 =?utf-8?B?WlN0YmRzT2VuRDJPUkxadW11YjAvWThYRm5sUnV5OXA3c1prMThnMm1oQ3E1?=
 =?utf-8?B?VUk1WTFyN1FXakw3cG1MODhYK2JsZ1NoU2tCVzVralI4NGtCOG1wNE5JSElE?=
 =?utf-8?B?K1ZxUjZUNU9ZWjRXQm5vWWlKQ0ZwR1d1Sk9YVDI1bkpxVlEvY0FPQ1pURzZV?=
 =?utf-8?B?QzFyZlRkODlZenh3VmdoNXlGSlJ0WGN1YmdvbXBqZHI0bHBjNUI4NjloQUlZ?=
 =?utf-8?B?SXQxVDVBaTVxaU9FcnBOVnhkeDZvWlFmQmRJRjc1bTF5OS9xQ0hLb09YWlJ1?=
 =?utf-8?B?MUZEaDNrSXRnMFlwZHBnUWwxTi9qSjY0MjhHd0lNemJndWtMVVIvRkxyTTh3?=
 =?utf-8?B?Rk02MXprRFl6c3VnTS9nQWlkd0kxWjhyYi9iNVRXc1JCY0k5N3BQaVRSNWxH?=
 =?utf-8?B?YUtqN2NKVXZYc2tsa0ZsVXRVVndqUlh1OEZvcnJQcHJCU0RMcnZWRnMvTG43?=
 =?utf-8?B?NDlGamMxbVJJb1QyUmhKd2dNLy9NZ1QyZTA1VDkvS2dEOVpOUlN1a2I5MUc4?=
 =?utf-8?B?aG5mdVRpcFZ1MmF1WXBaU1V6MVBxdUhudlZ4UTYyemNNYlF6UFpuY1RiYnlZ?=
 =?utf-8?B?c0ptSGwra0RwNzZPSnBacGx0L3R4T3NhVElXWGN4UWxpSk1sejlSMDlWUjZ3?=
 =?utf-8?B?Mzd4Vnh3SnJMNC93bTdFL2Nsc3llT0ZEL0hLbWN1S1pza2p3NkFBc29yUjdF?=
 =?utf-8?B?eEF4SUwzSy82Z0R6OWNVekdyOU9LTVZHQ2taSGhYWmVtb0Y0ZEd2bTQraFFt?=
 =?utf-8?B?Y2EzVnBNZlBmY09WdW43aHB6aFdSYkhwM0JKY3RkeDI0ZU13cTErSThETDFZ?=
 =?utf-8?B?dkl0bHUrcDdTeWlSanI2Z0lSSG5QYUJmZGlSSHRLWWxiUGM3N2VES3ZQYlha?=
 =?utf-8?B?VSs3Z0JrQXBSeEhHRTdMbWJ5dDJ4M1lFblpScjZGbW5BYkhoRmFqSDI1RklE?=
 =?utf-8?B?RWlVZTNxYkU1Qmt4a1lnQmg2WjR4SjRBV0xGOHFONnBNeGsvcldwdmpPMEFw?=
 =?utf-8?B?cVNCR01ZUE9YbkE0QkZuZVN5Wjl5Qk9zOUh4MzRVL0VuSlJoWG41dXdob0FD?=
 =?utf-8?B?OCtyKzVyaGJUcDNhb2NjMDBLR0FibjcrTVlrZFNYbEtGU1lWa0gwQ1cvcUx2?=
 =?utf-8?B?dzYwdjFpSUJja3c2RSt1aWg5aXNTTDl3WEdmVnR3MnFGVDdYdE5LUlF1dm1H?=
 =?utf-8?Q?U3O4yvTNWPcs7rrA7HWoLxsH4WwDYagrFyVIJWLakRLu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e695dc7-d49f-4707-c6e8-08db23a8e0fb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:54:04.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbAYwUnkaliF94Qk7kiDg4cJYi+M2JAtC2B7flJi9SUCHXcUykL535CBEj3+v9HKGLSIUnEYl5cGApfQSTCWHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7594
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.23 09:27, Jarkko Sonninen wrote:
> Add support for RS-485 in Exar USB adapters.
> RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
> Gpio mode register is set to enable RS-485.
> 
> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>


Hi,

I am sorry, but locking is really broken here. All these contexts can sleep.
There is no need for a spinlock. As far as you need locking, just use a mutex.

Secondly, if xr_set_rs485_config() needs locking, so will xr_get_rs485_config()
or you can get the case that you return half a new and half an old state to user
space.

	Regards
		Oliver
