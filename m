Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A986C724077
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjFFLEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjFFLD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:03:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519210D7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMsdMAQnZTbHMa5oYL41JGD8GnQPnpStX2rmZHQcv5xDEjHEZYkTZh+wyZV/Jh9Ltu5VG2h+TmO1YxE67+4UulDwIqXVp2N3gcYhcZywN5+2sK72Xln0jJoPYvq34lMwhqeNU26yzRk8KcwjCt0bMOugI4OvcdLhEb6yrADyI0BFmlW2GWxEzd9ALqjpK3HRK8l2tWedJf2wDSPXrLXJOT2wLSMb+5dLpoM1UCqGQAmWTmJK7t1GYJs5kC+1lDmaGKsEK9XFJCOSgL1PXNyG5e6vLqA4fy8mW5gNDUEhHnYJkOR0krYbA8hO0E/ic8yGuaONndQ4HvB/QFnlqRjvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v/Mc0KK7tDHCTNZrkW1gls2KiLO0p7VEJ0StWZOvYM=;
 b=DN2oPp3z39ebzV3GrnXhRyruAtHn2OXWoQ8iUJT1bV4TMQsDkc4U6jRU0lUmnbVwkpfNA1pbOH950cVcqZhvc5UAqTr7FsxXT5iSgMgQSGcCzCYCUlZI0SSfsFxUBJWKUcot6tNaP4umPqMX2U2vRA0cwXlcbWuTbGuMP+JKlj9sjNwmsl+qU5N9rU7Y2THqI2CDtTHrDzM/mCNifZBOaTR7vbZK5OMsVrKQ/L45uZxSExn2r9b82qyLcKhQ3l3USbUccQ5tYoCt1yeHYzUVGzQ56Hr7BlPZjqRih/eXGMbue3/FoBgli+YgSN6cb3aBPZ+wAsQUTw/U2/YEII5vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v/Mc0KK7tDHCTNZrkW1gls2KiLO0p7VEJ0StWZOvYM=;
 b=PPFuowd+g3coB7botapoYf6RxToIcihC5J0mqll7ofChKsxJWD3zlgFrzRoMGoHnfps/KxojH2H7gG+f+MIkUo2EE0vDAc3ki27g0yayyyzkQDq0F9xTh3VnY2dZH8Mgvlg0OEDhNMRzOM+uOjAtrcbzTtnvP72lZ5G8zIg3/1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:03:05 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e452:1914:1054:de79%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:03:05 +0000
Message-ID: <ffb49486-4e29-a44d-97f6-18fea5386ba1@amd.com>
Date:   Tue, 6 Jun 2023 16:32:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     gregkh@linuxfoundation.org, maz@kernel.org, tglx@linutronix.de,
        jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc:     git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com
References: <20230518114418.18025-1-nipun.gupta@amd.com>
From:   Nipun Gupta <nipun.gupta@amd.com>
In-Reply-To: <20230518114418.18025-1-nipun.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: a62d3639-4744-42d1-f49b-08db667d9a4e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jyxgZHTGtBPbuxkf4OlFmq0vyV8vzg6NlUqB5paZJNoEtA3rgn6wcccoVduI0x5cvSt3i3oGFlLkMY/2BKuiW2eNeWSe4nxrZXj0cmgNyzxLQRTwjCGJGuzBGDTCdzYaDsA8i0h1wmcM4XQgUKLzKrud4aPt96eoJFK/5uGbDnBTyjpnc0A/wlL6RkZJiT7mEwAE8V/KLvaN8Tpe8CP+BMBh31tFYP9nv82yK7vxEtKNFwZdMbmmxAJKgJFrTq9yL1eurohDTWPg4PKefiUl3vrtdyRtrd+2kCoCEbkUwLecTlsp2b0AN/Rs46hy71gB/82JoEQTcIbrJTVGB8wStRhmCMPDvq/Z26YmW/Nl1fsn/s58GY86FJo2xnppU1GTeYYVRw+DWNLw6fH4N+oTONc8dezI5ukwXOBF9K+KuVDNhWB2MgMP7fD/tc+3VyYGOKbwFVZroO+97KX4O2D0X+5KyDbv0KZqvS++O4CcAe5WJtxaeg7WnOBvwPvqL8LYtn+8svGdrl/AuEWFyZNWQxI0nQAAjfriVAKq0wB9E8A5mny4biqWYIgnTJ83i5wuruHDoBoTUufqk3k9OQLyfChOXjBnlde7QjsdnRZxXDDWnCYcYhznrjla26tmh35DWUJfoxDxslt1eQjORtAT1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(478600001)(2906002)(6486002)(36756003)(6666004)(83380400001)(2616005)(6506007)(53546011)(86362001)(26005)(31696002)(186003)(38100700002)(6512007)(5660300002)(31686004)(316002)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pSRzVmOHJyNXhSdkRIMmdKUFZzcmNvR1Q2cmdnVGc0Q0JycmI1WGNEVkZF?=
 =?utf-8?B?eVhPRTBuVEJ3aW5kUFpZc1NLR0gxcWFyTGxhbjN5RFJEbVg3WEFUWWtkOWMz?=
 =?utf-8?B?MTVSLzFLVTI1Q2x5akNIREhmcGtRM2tjZXNOTkRPTlM0ZjVNMTBRWE9sSGdU?=
 =?utf-8?B?STdzMWQ3SlBGTFk3TVJITzhVNTN4UHBJYklQOGo2VUpPekQzc1Frd2dMUmls?=
 =?utf-8?B?WWdCS1BuOVZ1bnhWbXNrT0oyaGQva3JNc1hpU3hLSU5QRzJRd0RncGdVb1RK?=
 =?utf-8?B?WjVULzdUTHhDelp6L1ZnUW9ZVXRDTm1qMDgzTDZZT3VUQnZNNFBSSm12R3p1?=
 =?utf-8?B?S1BHYUM2NFBKeW5ZSWhzbXFRbU1WSjcvSkt3cEpBalRGRFRya0RLZG8ySG12?=
 =?utf-8?B?V2U4SXRuSnB5N2IvTGNEa2xWZWZNV1NpQlJYTTFmZ1FEdmh1N0VFQ2ZJN0h0?=
 =?utf-8?B?VFJySksweFVDakk0TG8zdjhGeG9ZcFZwUmZXc1hmbTVUT3VYdkVVK2J5WkJF?=
 =?utf-8?B?Ymtadk0xNDMwTDl4TXNmZmJQTUtRWlBHbVhwT1pvNGVwcjMrUlo4bWo0eFpO?=
 =?utf-8?B?dWhWcVZjYWtMZjAwVU96b0VlREx0K3F5SE5HbXAraWZYSGgyZ3g3dklGR29Y?=
 =?utf-8?B?Zk8vMmpxYUtkaFFsMWhXM3lrVlNmcE83SnB3VlBpV2xySWVwbkhRWGNQeFNr?=
 =?utf-8?B?YUJiVnJlZXdDVGJwaVV0U3diZitIZlBXMkIzL1Rudk0rOE80ZldEUXJQZDVZ?=
 =?utf-8?B?bGh3bVlva3JMREhYVGphb2ZVSXJDNGpndzVYRTVzZDY3VmtPM0Y1eFdtQWYy?=
 =?utf-8?B?WDl6RHBOb1g4dmMzamQrVGJUdnRNRnc0Ky9Za0tRUUFaQUtORUFPUzB6R0pY?=
 =?utf-8?B?bVBscjgyTW1EbFVsblQ5cktIYTdOS1NuVVVWcTMyOHc5YkU3TDBwMkg0bW1i?=
 =?utf-8?B?ZWd0blpvV1hqVE93WEZIQWpLSkY5bStmQ2l0V25KdlRwY2ZwK25TemJtZXJj?=
 =?utf-8?B?WlhRZi9mcHVPUnpJWndEYlRJU2EraHYwamlQaEJGRWs5L3ZGcnFFRlVXdHBW?=
 =?utf-8?B?VlZyLzRYMmV6NHlFK3ZXUGVVd1VHTEdQWmJqUXJVazNuNXBVSVVFd3N4NEFS?=
 =?utf-8?B?M3NRcm9jVEpEdzU0MmpBWW14RW1LdGZDSjZ1d2RUY05TQm5NVlAvVkhlZ0lw?=
 =?utf-8?B?UmdZRzNpY3VSNGM3WTlTTDNQSUh3Y1lvQ0JmY0RWb0EvNHJONXIxSmFKT0oz?=
 =?utf-8?B?MUJNbmk4SEVqeVVIa2dOclpwL0VhdkNnd29GdlkzMWxpWkxjRVhDWWlTNWdS?=
 =?utf-8?B?Z01BUXJXNVJvbXJzcCszVkR4V0NtLy92N01VdkgxSjcvT2R6bkhSZnZ4YmNq?=
 =?utf-8?B?M2FJNTNqdGp6OFM5YWw5RlRueW9SaGpiQ3dadS9seU5XUkd6a21CTyszSnhO?=
 =?utf-8?B?MU9MeUROVDZ3RTB4UlNNZHRmbzBNdEJTVVFVaHpId0djY2xjK2RqaFZCN0pS?=
 =?utf-8?B?WFlFQVpLb2NNQkowcWhnQlZtcVE4cDhCOEM3TW00Mkhib2hUeVl3a3gyUTZS?=
 =?utf-8?B?WnVVaDhsQkNZZ1p5d0hiUXp1bU1GWEV0K1JxU3pyd1NaS2F2cWZDbDV6aEsy?=
 =?utf-8?B?alp3aitPWUJWeUFkc215Wkd6WlQ0RWtvYVY4M2hRRFUzcmhydWhHbkxlOXlC?=
 =?utf-8?B?a3V0VDk3SHlHVysrZ0VvaHFldWVMSDRtUUtYdFc0YzlsNzlLT1k3T3piRjN3?=
 =?utf-8?B?Y0hBL3hIRU5UWit6QWRsdVJzcFpyQjNpS1BRbmc1Z3c2TUIyM0h3RVM2ZDRs?=
 =?utf-8?B?T1ZnQmUvWUtvcFFpVWZnR2lJOFNQY0tQVHFQQXBNMUFSMVJqUCtmRHpEZHkw?=
 =?utf-8?B?UEFqcVpPajdFbUhBK0RBVE5RVVQ5QktwTlBEdHA5VVBCZU95akRqd0p1L1lx?=
 =?utf-8?B?UHlpTnh6cmo3VmNYRFIxYUZsZFkvSGlSbDY2RVVrUzA3VW5jeHBWdisrK1Rq?=
 =?utf-8?B?WHR6dDBaTkcvWG4wTU5ScUZlRXcyeWgrTGdMbHRPbnlHakU3b0J2clE5ejc4?=
 =?utf-8?B?STJ1dExtRTNLSnhKNUp2dktRWC8ydWIvek1GaE1hcXppb0FtdG9OeEJEOWhi?=
 =?utf-8?Q?K2sLN5cYail0Zltb72MOuL7G0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62d3639-4744-42d1-f49b-08db667d9a4e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:03:05.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kz5vHu9hYguWLzEiPceh4Ra/sGLqT9i4sxlK2InHQmZBNUFGZQDYsGdjVMJ5j9G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 5:14 PM, Nipun Gupta wrote:
> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
> 
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
> 
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
> 
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v1->v2:
> - fixed scenario where msi write was called asyncronously in
>    an atomic context, by using irq_chip_(un)lock, and using sync
>    MCDI API for write MSI message.
> - fixed broken Signed-off-by chain.

Hi Thomas,

Did you had a chance to look at patch v2. Please let me know in case 
anything else is required to be updated.

Thanks,
Nipun
