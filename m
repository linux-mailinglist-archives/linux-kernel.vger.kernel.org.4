Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5E6A07AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjBWLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjBWLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:48:04 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7919B12BD7;
        Thu, 23 Feb 2023 03:48:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5K8UYuWp7nPG74F3+Dq6Cz8EybyiKJP8WoKpe0xs1UqiBxCkzHyEmVUwCht1uSJR+xB0+qCg8xua+z1BMFZVQ9Y10Q+A+cJ2TOiv/O6ozMWmwhN8QYVrE1KlPz/5frdtAgGQThyJarpOMsaMXlFCFYp985AgvQYsQl71vFoW3DCMgpHi6ZTpqCKi2FoVYTlhLNIuaeaZ5fhmDY72Z4yuo5NkRPqWzZKxMH/X7sZLqF7bDBFr7sH4dNf53pm/yZTrPe5f0Tj9i3flcLPCk8KAdbsw5fxNLluJg20v+kVsjL92jCNYGZ3tz1buejz5xWytuK1TTmv84OIw6Vem5sxUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDfD0UI3EzydEPGR2x1jIqRrsC+D86uDDJmTrp98MjA=;
 b=U3iFXcBGvziyK95Szd0TtcRSMawMfTgq2P3y5RjsoMnT3+qSuM58bFYSowIVuc1PhrADb/IQKUXxBejU5tKDaUGTRlvuyrqFumdiXXh6ZyV5Ao3guJGnKWWhAaolR9plwLPk/3lggc129QMcqhKeQsnxVG07ER4EB8eBWl9N8alBd758wHnKSVOrXi4xZq+QI6mHFbZlYr1QHhGg0vIlUpaJQfhlUdGSnJe0SmaWp0+M5jN1xQQ1IIeOj9Hs7tTB9gGjJ8AiXs9ht2WL3prbap9rm5D9KbNdTCB7H1f5i0dOVsby9hg8mSrZqWHOBaiE7v3+H72M6Ihj8MziyRLSpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDfD0UI3EzydEPGR2x1jIqRrsC+D86uDDJmTrp98MjA=;
 b=AVCwUgFONOU4HiHI4Pekp8yG5Hlp+ILS+vYRrWTvhWZBPPwJbkRcUjRw4voAuO1TvYlYlX1wBzdLRxIL3QiVhOA7zboISfy1JjqdNbqB3W8N88N6O0w3rJzU2wh1nxZVh2ouPJLrjNdF5lojeVRcX3firv/p0oeJrh1WG8/jEEoZ+tUTPRJXaalYrc1UgG+7heZVghvMTnGzMq5L3hY+quamOUqJ9AsADYuvEOaSeXSjAZFKY4owmkT44xBrt+NMcT+JG+S4DANQj6t4AClMbAuwMfuAP43wO2DA6SMh3OR5Yb8DQ4YdKWvaQPxqX5kuzHw6+Yl9VYSLT+lJBeJzEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 11:47:58 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::2191:53f7:4a90:c7cc%7]) with mapi id 15.20.6134.018; Thu, 23 Feb 2023
 11:47:58 +0000
Message-ID: <140a05d7-4bf4-3b57-be8e-05d7c6fc5f25@suse.com>
Date:   Thu, 23 Feb 2023 12:47:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Content-Language: en-US
To:     Michael Wu <michael@allwinnertech.com>,
        Oliver Neukum <oneukum@suse.com>, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@amd.com,
        mario.limonciello@amd.com
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <ef80c145-e33f-4aa8-c9e8-c77f34b1bb0e@suse.com>
 <6d7c8e3f-225e-400f-f8a4-bf14c538ad8a@allwinnertech.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <6d7c8e3f-225e-400f-f8a4-bf14c538ad8a@allwinnertech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0d3949-a37a-419f-9e0f-08db1593cf28
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wbeQxazruQkEABXsxARc2RKDAQNpGSHf5DCeF7cigMNE90EvuqS8eI28Ov2HixfwB/pej/UO5sWfHpRhIVQy/ZLBRmCWd7YJKcCIYhav9K8WCKXPvD3W2BFahUTaeOkIIUwlukUwqnR/4vCPt2gizdmVxnOEXXPPQgVaMVYSYygvDJSUuPHVgoY2TMEF/aImrj/ebbaLQR83dp/NgYc+p8exlA3FBq6nhslI562gjDCS3ZkeD3tJDmjXFrMK4GEHyfkICUaOvR8xzHws+49k8Qi9giJ6gRn6lgdU7AGVqlnsuGhFKObkRXet26enrH0AGagh/iXMuOfeXyoT4ZwfFYgjcgUTCj0xKL71xrYCGM5rDyvDFdQEuummUiKiJOTBOtZyYkY80l17VaiBFpOXhgJPeJURSimz+tXuXRvR1XjuL7UyurUuVtP7MH+zndWgkqaee6+P03NaOwh6J4qZz0Yeoqe7j8sL8xmlTP3/8cSCdng119PCCjH4OBqIFqlUpt+VQcTU8g38iuc28gt/he9Czwi46CbPedG7QN97Gh1RQAFoLHt7/DSY5FcgHyhgbwg90028zDuhIwwAUhVq+rbSJ3AghSUI5zRASyS3ho8OoRVcbbex8xRmT9J6gj2jT/ljdoKlrNhoEytX7zONh5grcD/mDNoMRgt5bLpX/RSbIEea016tsdjX0PnuvqEc5wT0IIRDNVkwipUYoQa5SbIkyA9KFfi/lSOKMjQw6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(478600001)(110136005)(6512007)(186003)(6506007)(41300700001)(66556008)(66476007)(66946007)(316002)(6486002)(8676002)(4326008)(53546011)(83380400001)(8936002)(5660300002)(4744005)(2906002)(38100700002)(31696002)(86362001)(31686004)(2616005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJ2UGJXZzQxMWo1WDB2UVE5dXJpODlYY3Z0SUNOWkNGUzkzeWI5Q3NsbW0r?=
 =?utf-8?B?cHljbVZYSHJKbXBPLzJudVlwdkhOaWdjcm1NZmxLNzM1MHFXZTk1eUJBU1pX?=
 =?utf-8?B?TGJQT1d3cVBKL1VGdkNLQlZIeGJ3c1VGZ3JYdXYzb0pGNnJYS1kzdjJYcUkr?=
 =?utf-8?B?Q25XNDh5dkJuN0tUcHQwRGp6a3FaRUY4a2Y0L2ROU3R2OVl5TWRGZFUyK1Vq?=
 =?utf-8?B?Vy90OEkzbFNQTzBTTEZHMFdvRFpTTVAvTjhCcEs2akUwc0srSHF6S1B0YWQ3?=
 =?utf-8?B?MWNZcUdRU3Z5bTZJM0JTU3oxRHdZWlk4REx6NnpIaTdJM3JRMGpLaUd1MDRU?=
 =?utf-8?B?MFJzbm95cFFKOXZ2RVpJQlhnWDVOWHJqdlZkb3kvZm8vamkycjFjQTVuNHhV?=
 =?utf-8?B?d2RtTGNLMnNOTE10ZEV1eDJ3a1hFaCtJemtEY3ZoSndQZE1wZkU5YkQxV1Vm?=
 =?utf-8?B?VVFIcWsvYi9lWHNZNmVnYllpSXRBRktBNGVjUXBxRFYvQ3kwZ1RObG5VK2t2?=
 =?utf-8?B?YUx6R2J1Y3FEZ0I3KysvOWUvN2hZVFhwTlpadytWR1Z0L296UVArSURsVUhx?=
 =?utf-8?B?Zk4vcWhSV1NJVFA5ak5aOXJFZ0dtanRueGZIM0NaeHo3SnJtSUhkNWJRWlVs?=
 =?utf-8?B?N3hRajhCbFkwVFhaMmZGcG0rSlRUd1ZjZFFuZm5RbXo3N01yV2tzT2R6eEQy?=
 =?utf-8?B?cmxRa2JtVC9odnQyMVpHOGJXWC9LZjNod24rSTdrbXQ1d2RCdEFia1pRdjVw?=
 =?utf-8?B?bkxIOG9FOEl2dENJRlBIMy8xQkZCU3F6RjNReGd3Y25HY0VBcGIxM2cvcjc3?=
 =?utf-8?B?ZHFzeW9zMXpEUDc3LzdmSGsrUUlOYnUvdTA1aVc5RmpESmJ3SlpHeEVoTThj?=
 =?utf-8?B?YWhCV2hDNjBSQW1WaHJlNHFsS1dFQWpaSVBxZzRUYzhaZGsvb3IySEJrK0Q5?=
 =?utf-8?B?a2dONjQvZWpjVWM2aDFlODQzS1pxbzZlSFRYeUI4NnFiL2svK01uMTk3UHV3?=
 =?utf-8?B?VkFaY0o5UFNNRUowZVduVjI5WklwT1Z6cDY3VTkxSmw1YU4wdkdWWHVJai9n?=
 =?utf-8?B?Rk1xRW5qZENNQzFRNE0rTlhjOXk3NlpabWtmOG9mVG4rVnV5UENIMXZnSmhY?=
 =?utf-8?B?V0tML0ptYTNmeFN0bk5yQjQ1WHBSZEhYam5FTjN2b3RjanNqY3NVU3N5YTVG?=
 =?utf-8?B?Nk5ZY045UVFWRm1xaGRMc0JrT2NocXlwOGt4S09YM080SmVOOUZGdEpyMU1Q?=
 =?utf-8?B?a09VNWk0ZTVjOWdKKzdvTXR0eDI5UkhqSzBUV3JNaVl1WVNVWlYrSWk0SXdX?=
 =?utf-8?B?WEdkc0dORjlHd1RwUlQ1dnBhWThkT0ZKVmRCMUZ2K1U0MHNVSjJ0WHpDQXFG?=
 =?utf-8?B?UGxUVWI0YktYL05PSXppMzhSUS9XZmdndVdLTm1tUFFwc2RaY01DdmxRMm5V?=
 =?utf-8?B?Z0lBNGFOT3ZLMm81WGRQZFUybGg1MzVLR0xEajJQR1hJUzRJdzRRZkEwNEtM?=
 =?utf-8?B?VmtZbFRPRlBMSmVhaVczNnY5WUdadldwYTUvbHhMMHlUdVFISWpkTjV0ZElH?=
 =?utf-8?B?V1JnOTcvMnBHNlNWQ1J1NG4xcWRwYXBXUzdQOUFsMnRNUU1aN0NiVTFyYml5?=
 =?utf-8?B?ZnhQenlGQ1J5bGozRndJbXZMTEdEbnlYMlRuK3BrNWxNbk5GelRaVWZxTk9Z?=
 =?utf-8?B?UFp5WVcwMi9MTzBZTzRvWHhDdG9JVWpQdkczenVOY0RFM2pLWW52VndTN3c4?=
 =?utf-8?B?SGJlSjFHV3YyVlNiWXdtazltSEZFWXBnUUI1Q2RscUxUTHFkS0U2RkJJVUlE?=
 =?utf-8?B?VFBkRmpoemY0cXY2RmVwZVZjMkQvRXBmMDV4bUYyRHVCU2J1UjZKSFBHa25V?=
 =?utf-8?B?REVYeGFYUlBVUmlEYlRManBhb3FwRHpWc1VXUXhXR1BRSE5DMnpibm1SdW50?=
 =?utf-8?B?dkhzVkEySzhJeWZaMFNMeFJhY0FtL2ZsT3JuUGl5T2NoVVBDWW5tekhPWjk2?=
 =?utf-8?B?SEdZVkJqZUo0cWlJSC93YUhiWWFHMmp5dGdsNGovSEJtUnYrdks5OWtnQTk5?=
 =?utf-8?B?TExlbG1mdDgwL2hoK0trclM4M2ZNZ2tFdzVER1JsMUFMY0xwRVg2ZVFzcytJ?=
 =?utf-8?B?ajh4L2dSU2Nma0hlQVFLWUkxZm0xVVFzamV5VExTbzVRaEl0eEsxbU1XRGlF?=
 =?utf-8?Q?7lKxjL0a1ASPgJn7WJOZxGs/AMwZ+lnCXh/R5GqbpM/f?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0d3949-a37a-419f-9e0f-08db1593cf28
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 11:47:58.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dSBOjlGHWeaDGAkanoFhS9rK3laHS301vnJ2BBIROKWpYa3sIY3vgzxBAbxv7a1WkcaPK0Ls+hR/eOhhKxcDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 12:22, Michael Wu wrote:

> Yes. I can't use any USB mouse which supports Remote Wakeup to wake up the system by default.
> If I enable the wakeup node in /sys/bus/usb/devices which is disabled by default, the mouse can wakeup the system successfully.
> Clearly, the only thing I can do is to register the wakeup source for USB Mouse devices.
> 
Hi,

thank you for answering this. I feel a long discussion coming up,
which I would avoid if I could, so it is important that we are
clear and do not discuss about a misunderstanding.

	Regards
		Oliver
