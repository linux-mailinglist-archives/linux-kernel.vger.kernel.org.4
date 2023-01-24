Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3E679EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjAXQf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjAXQf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:35:26 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD36F4C6E9;
        Tue, 24 Jan 2023 08:34:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYhKqpUtzqIGn3gdRTwlbXpSMe2kwc8gkwWtI5IsVFYFnJShbpRltcZ4GDw6n+wJandK1eYCAXFc46Mi+of6SKLJg2fsIy+S6twoLZZ/7aqYOJnGMCuAYJ8ul7fL6k6OVarwNzsKzMiT0h64QP3WyHfmNLM1wJUC7Ae1zCj0wcIs+focFdRN5ACMGkV8YQVevG5fAuLKVZ+/zQi3DqAsKGJ/GE+wgx0heUJnDFou8UeFTwbw6PdUEU6pDhJGQgb7pmbWUghWrRwfXlUf7eU9nzfAmLl1qtwsv2iFLPOh6J6cPghGBUEhTqKSrOA3AzwiL5dRSo3p8EcTcj0kTW5EBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Tb4Sxjk2aTCP1ejwdAkFt3ENNuZYYnVam5yq+NYQE=;
 b=EQADjj7cqaRg4atuOjdeFEpIv/kOUMgtzE61+K91oonplGWU2KO3t9pd6jOgZaOf6gmuZtNym7CdFQ//uQqJFix0GgK+TZILHZoX4Zsobjweh1BZqvvvp2RH3neMN1U0ylB0by+DVmYzlo7GLFXv7mayLY4hdKV/LbL8hC1eK9d0ozp0KYhTIGp8F7K2169vk/By18ucDVGg0hw19Wz5fYqDGh2yxMaFI2orDJjL3uiOuChjawXqtBmaOGQvqWhoIyOXo2RC0xFgBqQB1qRcJnqGb1gWcNJHHnhSG9KVlRtRwQbBthh+n2yn2aKymWXWqAzDNnj6aq7kGY8GmMAu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Tb4Sxjk2aTCP1ejwdAkFt3ENNuZYYnVam5yq+NYQE=;
 b=m/irHI3UXNwobHtYJqFG/UHfL7Prx5kkOprWSoTEVr0RpZMKOD5X34Lf23eQlyg5vnHiNZaLibpiCp4LYlOtjAiggMyEruXtAEKIA9XP5imY/RbMpcmuYC9Au1/kegzdv5/fXD89oo9Ijz5W+0N8IR62AKR7XrLQiA1QUN1Et6NsJhbFZ+nouEdK0rSnFq5Q8JhL3TwccUEe1xOKNaiYqtA2kd1KuXE0wsf/kvQgvJXd/0SAu9M9DXDqLIub1iF9gvJbjqmFZQ4JpMCoNEiQLJCyYhLrirYZevHg8YS9pHkQR6P+C/Ghl288pVaP9UKFiE+Hz063H3xgsfyg+zauqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS8PR03MB7655.eurprd03.prod.outlook.com (2603:10a6:20b:34f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:34:54 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::b42f:82f8:24cb:a225%5]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:34:54 +0000
Date:   Tue, 24 Jan 2023 17:34:51 +0100
From:   Manuel Traut <manuel.traut@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org
Subject: [PATCH 0/5 v7] input: pwm-beeper: add feature to set volume
Message-ID: <Y9AIq3cSNzI9T/dU@mt.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To AS8PR03MB7621.eurprd03.prod.outlook.com
 (2603:10a6:20b:345::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB7621:EE_|AS8PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 15764956-e06b-4608-a157-08dafe28ec0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4OkLwFJjl8qMVxGE33EESScInjttM6QwegqslxIjh8A6TKgdv8R079zq/vjbvwveemSFqFpzUgr4izlYbvVrVKOCriZJBJMoY872VqnCYQDZht2Z6zgQGxcm8LS4VF39ETa87rtLsLX4rpi3HLC1BCOBOCt4er8GPDYTpLuisJlZ0oBBFEAqVW5EmzlHZ+XmLlz7UwqeNLSAvLViaKbanhq9VqZ7Mjcd4zU0/hOu1T9YrA1gcuKWjMFW+N8GkH1q2wssZoPJhVFVQ6kqqd26RE7ESp3/vS5CzrB490To8vVuBm8eyMtzwqNz6VIwz5h6rnNZxXTdi/3Yxnbz8rXVlefzEKPz/dPReupzZkUBszgOV6tU20o0HxJBH4rJ3PISC9FTod5OvicSKVcDtj19bpRiLrpPQy1NZ4xXFlDgdeH9KeHK4kv4TK1tkooPiOctNuM7aD868pmT2z2y7ur1b99PLoV8/sLYeNSIt6uStmZeOiSY9ysyuvTXC282whU/xWmSR/2RCjeVnAjkuLNY650vwdrs/oJfA9ReWjLr5vghRoxEGM9DHAp/wYk0s0w70bpoMDXq9FRYqB/3ZdcAf4SKH+Zk8aHxApIW1y8j9Vu+aJhzIvO/hq2pJqIftqeItbCVlNbHfYT0/t4iZgM90wMYNjoTQTelFIYFmcguYHwjbR6arjNJHDSv1GOLzuXFMYNhP5CUR1kCpvulpu51mnZbO1pG2WPRr1hQ+sb5vpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(86362001)(6666004)(2906002)(478600001)(186003)(6512007)(966005)(52116002)(38350700002)(26005)(6486002)(38100700002)(2616005)(44832011)(4326008)(6916009)(4744005)(66476007)(66946007)(83380400001)(54906003)(6506007)(36756003)(8936002)(41300700001)(5660300002)(316002)(66556008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpTb3EzaTEvUklySE5XUkxLemdEQ2ZzUld6dTVXQzVDRlVEM3daTDZQcTl1?=
 =?utf-8?B?ODl3ZUJuUlIyTEVqcFd2d21YRGd6YVFSRmhmMHAwdVQ0anh6Z21pbFVWbXdZ?=
 =?utf-8?B?QVJnOTFrTHBSaGlYUHNkcWVqdGxGZHFTeHlCMmVwQnZyQmRtb1NuL2hRd1c3?=
 =?utf-8?B?MG9kelNsNmVuak1BMjd4RmRDdVVRTWltUlN1TzRVY24rRDZ2NFBadlF6QWx1?=
 =?utf-8?B?NGtVT09SU3NjKytEM3JjMnhOc3B4UHQxQTkwWlF5NmVkekFvWVg2dXNRMk5F?=
 =?utf-8?B?TldXbFhzbnNYcTZpbDEzeW1SUTUvczEySEFJdnBJQzRaVU04SWc5Y3BESTRT?=
 =?utf-8?B?bExSM0pzUEFzSmEvYlBwbHdIcTB2NzJBM2x1Tkk1ejdmeDRKZFE3SStZVS9P?=
 =?utf-8?B?T3V5UkJTMkJRTnMrWUJ6eG9GdVkwczR3T24wN2RkdTZQYWFVY1FVNzFSOVM1?=
 =?utf-8?B?YmRJUitjTSt0OHZRcmJZcXpSK29abGNKY1VHVDJxT25SUGdPVDRnYis1YUZQ?=
 =?utf-8?B?UEE3WjlvSUZrY3E1Mlh3cXZNZEJDTUtYeFFYUitzYVNpUUZxUEV1R0pRUStl?=
 =?utf-8?B?SWRaQi9VemdMUGtzZ3U5TFRFUXU3NW1jK0Faa3EzUENGN2tJdlVNeGZuczFp?=
 =?utf-8?B?ZGdLU2ptZWRhNjZSSHBJaSsrMmRSSnVHNzlTME1BSitjaGVaVnBMd0VadXhF?=
 =?utf-8?B?RUwvSzRlYXBKYTdvejVXTWQ5bWh6dDZxWGVTejl4SGJsSEx3QXQ4VVFIbk43?=
 =?utf-8?B?T08wd3o4T0hDYTRSUHFVWmM3YUNnNUhMWmYzNkxlSG5nU1NKYURpTjFnMGFt?=
 =?utf-8?B?cEtIcGMwVWNBTVVoZVl3RFVvUmZ5ak1rV3krelh3QzJSR0NvT0U4S2xkcU9D?=
 =?utf-8?B?RWxnbmNndUNuMVFYaUQrZG0zeldOQmR5bXhSUFR6R3N6ZndESDV1TWl3dW11?=
 =?utf-8?B?b2hxK0drWmp4aTRsOGtNZmFQRDlDVVE4OUdJSEdkRXBxR2pHUW1yY2Q0dHpI?=
 =?utf-8?B?QzN4UTdpanZReUpyc2RyOGoyUXFGeVg4UCtuYjFNTlJrVCtKeG0yYnJLam1t?=
 =?utf-8?B?SEhGRUVPTWFjMUxYbC8vYitFSVJETDNRWVhSbjR1UWV1aHhEK1hzWGhxMnVM?=
 =?utf-8?B?QkxaUWxhd1g3Nkc4bXEvTWVkVUhSNUJscnV4ekY2SVB6cEsyMUQvUFFQY1RV?=
 =?utf-8?B?WnNsUGRQeWpQenFUVXlSNTVseVlYMmhvL0JFc3lsYjM0QXlxL2hKdmNXVU1i?=
 =?utf-8?B?alRTQlozS0xoQ2c1NWhSSnNDdzl5QkNOVE1ibEViNDFXUmVOTXJnck5TOHlV?=
 =?utf-8?B?ZmJuSnplNURiREwrZ2J3a3hYMVd1NnZIRUl1TmxuWENEelNxaDkyUUtSY3RH?=
 =?utf-8?B?ZlRWdHlsVy9OV1ZlMmUxcllsd2NMdmgrSldxRHplRHlGVEh4WDltWEE1S3Fy?=
 =?utf-8?B?SWVyQ3U5R2pZTTNuYmxvTFBSTTVNZEZpczNJdHFRVDVPeVMxWVRYWVdyM0xo?=
 =?utf-8?B?QytodHQyOWFZTFE4VmlLdkxuQU9hUGJDNXBaN2ZTTlBtbnIySDdOclVUY2tI?=
 =?utf-8?B?V0xEbEJzM0xrQi9waTBkb3dwMzdYRkJUVUVZMG9IdjFoTFQ5RGVrNEJSYitn?=
 =?utf-8?B?djNycExoZlRMUG8wTmRGWmpUT1ZlblVUZ3A3TnlIQi9LR3pQT2VrNU5EUlVM?=
 =?utf-8?B?dGk4SjEwNFNET09DZXdRdkRodTZHb1l3UnZLd2ViQmZxa1IwVE5ZUk9adThm?=
 =?utf-8?B?aTZrNEJ2ZE02aVpJMy9KVkVSNGhydDRnUUVRQ1RCRGE0aWxZQUJFYzFZeTRs?=
 =?utf-8?B?M3VHWXB4S0tjN081TVA0bFByV0lkRVcwWmpEc2d1ZERzSFArQ1p2RVJIdjBt?=
 =?utf-8?B?NXRVNEpPU3RoSXdsOTI5L216bFhkaUJOQnRudVlZcW1JZzhDNDV0TUx0OFRm?=
 =?utf-8?B?OFJtUW5XZFJrUEd0T1lsSU9vckNIbkRKcWd0WlJta1h3cWF6OGt6eDFGOUNJ?=
 =?utf-8?B?ZGlUR2VndU1TUnNlUlJrZGswZDgyZHp3RXBTd1dRY0EyZzJpZjkvVjI1SG1I?=
 =?utf-8?B?bGkybThEdkdFT2VqdlRTUldkeXduSHNEbmRLaFVodjhoWmowclh3azFXQUlH?=
 =?utf-8?Q?HVJkbEi+yj9s87qrospc7uz7L?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15764956-e06b-4608-a157-08dafe28ec0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:34:53.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDjzHBczDpmIeACCrbj4KkowRcZI53AJDlYfhtcmn/5us9WI0E3r574FtSHzL59C4xGlNsz7zlAUgAM0FO/pzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements volume control for the pwm-beeper via sysfs.

The first patch changes the devicetree documentation from txt to yaml.

The original author of the following patches is Frieder Schrempf.
I picked them from this [0] LKML thread from 2017. Since it looks like
his email address changed in the meantime I changed it in the Author
and Signed-off-by, as well as in the copyright statements.
I did some minor changes on the patches that they apply and work with
the current kernel.

The last patch was added to fix loading/unloading of the driver.

I recently posted a v6 [1], changes since v6:

 * Convert devicetree binding documentation from txt to yaml
 * Use DEVICE_ATTR_[RO|RW] properly
 * Change Frieders Mail address
 * Added Signed-off and Tested-by statements
 * Fix module unloading

Regards
Manuel

[0] https://lore.kernel.org/all/cover.1487323753.git.frieder.schrempf@exceet.de/
[1] https://lkml.org/lkml/2023/1/24/379
