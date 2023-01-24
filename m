Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B510A679E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjAXQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAXQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:11:54 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2122.outbound.protection.outlook.com [40.107.249.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39302458A9;
        Tue, 24 Jan 2023 08:11:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd5k32Zx0vg6C/gziaAoQpSwkByJTHTpH5mF7ndZenIKBfWm6bA+FI7L5OWAUU1CdfXRNwmHMYdvWVZ8jVTTYMA4ckFJMFEmPGrYTMFTGSKJohNEh95tDr6REL+XF9hylQGT2a3Z7aaC9DFucnueUU8cbFhlxgO7O93mQ4nTaWepShQHAOILrZd36zP0xJO7LR1V6HNsJwR7NnVGyrwliUEBVaOsY2hO+z1oARPOQgxk1ykXHgcGzlJ5nd23yc9nUoekYmMcMVjc+Vs9qLood0nXsLoBLjxhvQi/oiqvuLyZhgAD6CLJCJ0TMuUQZtOs4CrkE/x4KdcgGg1WDUbPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaFfoVMsH/pGYuq43r2LXrV0756ldN83sNHDVX81UeE=;
 b=aT0z/q/4t3BSSvwQPdeW3HX/k2KVBKAJVFYQl2vko8HeiqLRUFYttP6LSUsOE74kw21UYWoZmKQKYwiFBEOiruVytjq/3cuaSUhXbtHtjMLrHx0HN6aRxokmDGciGYn0JKIxONpYeWtBePVXbVwwe6UBl4D6MZFw9qFJtfU/Mf02416sGkic6LQ3dZMruiMZHcDbrPhB7A4sIhKQLDBWN7tq2bhUvrBERM6UZgvRe4mtocalt/45pkwnja9aUCGu8DqrOIsuHjOhuqwHHUTY7zcJ1tRNzH+flJOxYu5hvRaskXFV+akCUjHl+wXzeDEso9kK9DKrdq0zQb+nCfP1xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaFfoVMsH/pGYuq43r2LXrV0756ldN83sNHDVX81UeE=;
 b=JggTT63f6nuftBwpuzws+3ItJ1Bj5QXgbmMFYznEWjD9gGC4E5GJ1ZAHpKCdCqPKmt0DydRUl6IXkjw2RJh+2Mu0HH7rpqCQMRfWCo9tdjcEcRhy6R+ez6+C6yEzpQzStmA5M94agOgBkxlZY32ExtpzaElUJauIXZU+Ju6TlnjEzsbN1wU8rorwa1hPMlvQtOsUO/IQxH3OoYBLQDwPfVJae/P1ZzZBzfTpGqspMrk8E2aJ87Ur+qR0r5G5hpLAlMfC8Mqk7Mpd1WHEsr0HSfvyOjKoDHjQV0mHIY6w4sXciEwFvuEd/n09Nr0JhsXvClkhwpHg83ObuVnPYDMU7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AM0PR03MB6290.eurprd03.prod.outlook.com (2603:10a6:20b:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:11:51 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:11:51 +0000
Date:   Tue, 24 Jan 2023 17:11:49 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org
Subject: Re: EXTERNAL - [PATCH 2/3 v6] input: pwm-beeper: add feature to set
 volume level
Message-ID: <Y9ADRd+WbGeJhSoZ@mt.com>
References: <Y8+8824hy/fWkpEk@mt.com>
 <Y8+9WRP51u+dof8p@mt.com>
 <907da24c-1619-a75b-b6b6-66c8ae86df6d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <907da24c-1619-a75b-b6b6-66c8ae86df6d@kernel.org>
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AM0PR03MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 352c967c-2e99-4823-5a30-08dafe25b3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wvk4MMTwYrDBfnzpsKHj5nXN+q+nzlEeuyFOP8mnswgDqsZ3SKDU9Gl+YsDcLslbbS1dnm/e8vSSAVU4DI956JjFY+moPRk4llXUKeNrYGkj4xqmmM4MgBtr9TChrLsIFNpLea5SwJWm9rVu8BkWnZQwe6nCpiajHTN76qzJcvCDUWvfU6D6cdfoYt+YGC1Fcx7oJ8TsYJzuMjGDrtn3DjivYKvdhCYwlsriGQUfU7ZHlvh0o64Fmnxf2xdycjQEZfjLkvzHBXh0/8MCM3PHiVBQFq/5hJ8K1AOnvI9t/vSF9iWmQo/GY173Q4qTZvhoL4hdacSTUwkB78zI1xkhekTk0KL8rKoFZlzCcR0Nu/5+oQtmtDIvRSI7saKx1AQNlO+uGFhJlACwqTyWx++JkUANNsl27D0ZUkjqNGhcM3fzrgm1YcMosIoJ2+s03W/GtvAF8ywBVeuXlTFX3FLYZ9FXI2ciJgMnswHlRRx+hiFDcaH4YdmMfLCxqR1RZN7MnuF4QYYnvB/P2QHiGnJdrN17uBV0k4aOH22X03QPB3EqMQltRj9zW+3PgWRjg1ObMbVDS/tYVGAq3AhDijW23kOzVlXSlvBejxt8WsjQpv718tRRvcBPnk85mRwoIjKyNG5dzXgeoR1Jw/btZo+S1O4FN6aOHo7lqHvxO4K+nSrl93/c9k5HdnVjMIZMUalJU2X5C53idvv8k8DW07wzn4xQ7VSMNdHSqhWCGFi6fX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199015)(38100700002)(38350700002)(2906002)(86362001)(44832011)(8936002)(5660300002)(41300700001)(4326008)(4744005)(186003)(6916009)(8676002)(6512007)(26005)(6506007)(316002)(66556008)(53546011)(2616005)(66476007)(54906003)(66946007)(478600001)(6486002)(52116002)(36756003)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmNrK3FwQlRFdUZQQ1NGY2xpT2lBOUJRM1o3aUtmckgvSHJSQUttNFRQMWgx?=
 =?utf-8?B?OXFXWE1lbXh4YkhxeGE1U0hqeGNpS1VkQkVndndhUloweVJidXVkenZBc3hB?=
 =?utf-8?B?SithSGtBMVNNUnFiSm1lVTVmUEdQZGsvZzVzVWwwVG43Z3dXeXNVeCtsV2sv?=
 =?utf-8?B?MFBLV252MWduVk03aUVXRWd6VmxuU3BSWEMrNDhmUFNGVVVENGxuT3gyVEU4?=
 =?utf-8?B?M3BzbzkycVRUTXhvbHh3OFk1Z0krdFFnSjdDcFgyRUNPUjFkckJiZjRMSXcr?=
 =?utf-8?B?U1EzeElmdkgrZjlCbVRZNE5sNFhzbnNtOTdtV1FDSHN3V2tLSGJ4VmZPeklG?=
 =?utf-8?B?WFRaNXVzaDRiaE9LVzNNQURQUkFjcVYwQSthR252bEhNdm1LNEhpMXN4cGtw?=
 =?utf-8?B?ZXNWQTFyelZEVWNiaitXenZhd3hZb0orOHZ2TlNoSUw1Z1lpSi9SYi81T05u?=
 =?utf-8?B?QURFYVBFcXFpakRRZ1lLUHpRQW1kWkVMUUxTWC9MQ1FUNDdWWEVlTllnUzE1?=
 =?utf-8?B?c0l0OGZtZXJyTnh2RXl2NXBSUUpqam1QOWxzV2tnMi80bEVPSUl0NFUrSVEw?=
 =?utf-8?B?a0M3NnB0K1VlcklPYUVabmNnK01DSWg3RXBKS1FMU2ZPeGZBQ2d0MUs5aWRk?=
 =?utf-8?B?M3M4cDBmQ29PZmxLTzlrMWI4QThnVWJYSWxaWWJlTHc1czd4NkRFZ2FiNU56?=
 =?utf-8?B?NkdvMTBlYVdabDFSd1JXMWwxTkU4cGNOWnI1U216eGhUUEhjTWxHOUlid1Mw?=
 =?utf-8?B?VDRydFBmVW1rZlBiL2xsdDc2QldFMmxweDFEZCtQNkpRdDNkSklnQjNsV0VG?=
 =?utf-8?B?SENXVzRmdUJhcmhtWFQ3RTFoZCtGMGhuQjlYU0VTUzVHZzZkQWFqbzR6L0hz?=
 =?utf-8?B?MnJNZ3hYVTRKOVZzaGZsQkZmN0ZEeFVodHZ6VDVHQUVuaVU5bDZqd1A0Sm5o?=
 =?utf-8?B?SjZMa0g1dFN2WHdjeW94eUpRaU9pczJHSXNKWEtBdUo1N2lxUXVlZVpWSlZT?=
 =?utf-8?B?Z016UkpKRHR4MiswOVZOdi90REUxSmh4RXA5L1B0SDZZYk03UDFhVlhrY1Ri?=
 =?utf-8?B?aUt3SEE1OXhLY2o1OUFnbTlMQ3lGelFKNEhvcDNnT1FHdERFeENHTnliN1pJ?=
 =?utf-8?B?bXN6OVJaSWFyVlhrYkl0SjRkV08vOUI4ZzE1ZzNwL1Zndm1qaitrcXViSWZl?=
 =?utf-8?B?ZmJlZ0R3eStDdVdaMm9tWWNTOGo5eGlEbXdlRXRQcG83eklwcmdxZVNjVWFX?=
 =?utf-8?B?SnB6WEZBNHhqeUEvNXFURGR5WlJCNVB1K2Irb3N2T0twVlFTcS8xSHpDSVF5?=
 =?utf-8?B?cU5QRkcyeGMxVlFIUyt2OHRtYlFTNE9kM3FhcTJkN3NSR3ViQ21vbmZxc3Uw?=
 =?utf-8?B?VCszbWRJejRQd0JLZTVLNTQ4c0FCVWVlL1YyNi94RGk2RGs0RmloK1pSamFF?=
 =?utf-8?B?RGFMVG9lZ1FCQ0N2Y2thVkVMNkVRbUZjMkxPSk9jbTFCV3hnMnppcnNNd0dI?=
 =?utf-8?B?Q0NsSUlaRFRSQXN6OGtYWS93eTFPZXhWdEU5ZVp0Y3l2Z3ppSVlWUVREVlRF?=
 =?utf-8?B?SFBHTkJWeGxKVTFxTGoxUno0Q2loamcvZEliS0g0NjVoUi9TU1l6d2dzai9R?=
 =?utf-8?B?b3JnRFROUVBvL3JUZW95bHpsWHMxR2IzZ2RPbjcva1M0L3kzRjdiZC9MMXRa?=
 =?utf-8?B?d2dZSVFXdnBLVTJpM25FalNISWZ5OTc0WHVRRVl2bVR6YmxXeUFvK3VlcTNX?=
 =?utf-8?B?bFJjVG5lMmlyR1VXeXlxZllJYnB2TDBURVhKQUJjVG9sNGZ1dVBhR1h0Wmxi?=
 =?utf-8?B?SFpocEU1SWRRTUorWnRNTXM0Z3ZuQ09zSVJjSy9ZakxmUjBHbXF0MEMrdzBi?=
 =?utf-8?B?S3g3NWlRNk50SEsxbHJyUGpNRWtKYkpOMUR0Q0RIc2t3ZnBHZm95elhQL1Yr?=
 =?utf-8?B?SktZTkVOTEZhTVUxeXZPWGpKN084ak1kUlE0TTRvTXdnVXkxTmcvbFBtWjF6?=
 =?utf-8?B?TEo1MEd6V0tvRDd4aWltM2NhSmpXWVFRVjJVZXNWVHhRRWZuR0U2M1NRZ08r?=
 =?utf-8?B?UDhtNHBKWFNQc0pDZ0RmZ1pIWDhPUkgxL1pPcm1OcXBvcFJNekY3ejNSUFhn?=
 =?utf-8?Q?MfQGUfplY6HNWWIxv6LW+Iff3?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352c967c-2e99-4823-5a30-08dafe25b3fa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:11:51.4214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9M98mgNJkAwIXIQfxJnAv+CMIvk7XeJp6aeD7rtdFa4dCldfnOhTI+jM1jm3lHlSwSxs4A01ANiOsQIbFPvSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6290
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Am 24.01.2023 um 12:29 hat Krzysztof Kozlowski geschrieben:
> On 24/01/2023 12:13, Manuel Traut wrote:
> > This patch adds the documentation for the devicetree bindings to set
> > the volume levels.
> > 
> > Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> 
> One more:
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).

Thanks for your feedback. I will post a v7 soon that includes your
feedback, the findings from the kernelbot and a fix that allows
unloading and loading of the module.

Best regards
Manuel
