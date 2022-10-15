Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC5D5FF975
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJOJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJOJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 05:27:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DA42AC8;
        Sat, 15 Oct 2022 02:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tn1Wg+5F+3DlYtclsAE+RtPpb6Se+aLgoQmYis72Vf/J6MNIBYXIKZz0uP1jQtGdCSuS3VFK9lQ/oEnawJdMIlpMOep2dwFff+QT2M07s3RI3g9yOWqZlFmZZf2ZiL8/S+aZRjV75JJuD6ZLEcW2e229R78AVISKhK22DC969Re1QwqcV/dut/GqLc+GwWSMug2mUWsaQmetj3/Z3ZCA+t5B0q++TF091t28PYa7Q05bas4w7T1OuehWZOJKEWyBcHfVOoGWvZk7bI+pFUik+RgB1OTZyA3/n3PKS7XywKcpnGDrojK7Zi8Y47WjGtRkOXh96eKZwKEH2DsfzHfgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSXSq6qd54aOnMfM9qA4cID/nOdFG/J9g2ooYcmc2fc=;
 b=XnyJRTWzONIxcR6nElvdDQwf+w1FqXEZwrWC1X1TKo0gAbDDm5KVAp/HqJlQwyAWNMw1ilU4A4NWe4lZapOlqPP3+zRRSbRSRexwVrdjImQBZU8RYzsf5Ls+M7EHtKcg8+SMYbwjgPWJRlSxYoj4RhWCXaAq5Ipw8H5N+8gxXLKd2H/WlOIAhMeTwoT8tsX4DSV9Ge2CMGhXK39v8g9FHdwHDbQ2uXfWECXiQDN8KsyFs4jNaPCSmyY4v3xnv3VuczHiPO+ntPbncUEtRlBnNwt8ZcRSDjY3WKiEs1zRyrMIwyfunpOKCw0XulQCMSgN/fc9nK1Oit1VA7b2LIqBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSXSq6qd54aOnMfM9qA4cID/nOdFG/J9g2ooYcmc2fc=;
 b=qJtG3HlnwI+kVtAkDhFVhhoC+Al+A9Hqgz6de5zCWniEUz+sdVQEF/meTDKZ1a7Uw7oUb3EInzzjthvmCscRJukdeGHSkKN5OfBHRv0O5YehaVnmqq4DF9CO1hTbgHy2UKmW5deTkfC3WvgaLBgfjWm7RneQiQYy1hrd8O2q+RmGz/RwUSqYCKFBzCA0PjNG1qcBkQodA1onKpXC4sf9S4oHvOXdTB3zgANc8qn0GLYkWz69D7+/owYyNqmCFmpPKkKzGlLEvZh/qdIGiDD5vgQSfUe4+R7wCi9X+YkpdlUAnsXD5G0bPLbJtMUAmh4TIGWRkbD2reF2Xd1rQG6tKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16) by AM9PR04MB8668.eurprd04.prod.outlook.com
 (2603:10a6:20b:43f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Sat, 15 Oct
 2022 09:27:12 +0000
Received: from AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115]) by AM0PR0402MB3395.eurprd04.prod.outlook.com
 ([fe80::7f81:2760:2539:7115%2]) with mapi id 15.20.5723.029; Sat, 15 Oct 2022
 09:27:12 +0000
Message-ID: <aa8d9456-b260-d999-0296-8e6ab876af7a@suse.com>
Date:   Sat, 15 Oct 2022 11:27:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
 <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
From:   Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To AM0PR0402MB3395.eurprd04.prod.outlook.com
 (2603:10a6:208:1a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3395:EE_|AM9PR04MB8668:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fed6757-584c-4483-4a7f-08daae8f708c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Yt6VO5RhYEL7SR+Cf6AD2nQlpruNlhySZKqURGPgNUP3x6BO4sdoFpGIR7AkcVP8T+Eg+l7vjOichbhmePsbZgF8JHslMladGx1dyZA+k0DWjumJWHQM0QjkjDLNfXccEO1ErMX2qXB70VeQCYbCHISQLlMQR0IGCtT/MF1Igljluuds1MtRK4pUdmIxryYwCU9EXrCIbphMpu71EFRKOD7blf9mCeGwz4ZXSCvNtN7mBRW3nikvtcrBXDScCnpyrtLa/1ii6cS9pVceeuxF/ygBRA6+Kv9Ral30D9tes3oXuLRkuzNNXJxA905p0i/OCzaUUtg4RP7vIQMoOr45AjKBLxqUhvsYW8SwgPcey/ms49RshFDxqpLv1OtdC+wJuMtPzVdaVnPhdmhf/Jd0HZ0k7LNuTUeIPhLetjTbefygeBhKti9bWLBFUM8n5BLuVfCiNxySHnrV0k0Sg5ZG9npQM+uc01citfJER13rHMqsBJLqHV1BpQTtKVP6mPHif97Y1j+5U0SpJcOwYqa016fJK4mCAGOjYWZxWdtvD0LddtYOU9VxqT+XUl2QA6ZJCcXlJoSfydGO9oxhfrDWUtTLZl41mTbeiORFGWk8/LNnKbPIqBElS+dnvlQqvnnHr/wUg5IvZvvweKBcgtxeEJvaEPGBtzCB/wM2Y4Hvu2+wViGcUuL/RhYoAsEM/XZaQUF9EYIiJ6LJc7puTvDnHUdlyVjDltn+5uwIaFRZtFt9lfC5fkghYsiwOYkrwvXZT1fsUFKKZrCGFkoJdQFaYuDsyiJRjMWIkaxFFEoNGlROdI9/6oXQdWpnO9JsWDG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3395.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199015)(6486002)(8936002)(5660300002)(6506007)(966005)(36756003)(478600001)(66476007)(66556008)(66946007)(41300700001)(8676002)(6916009)(4326008)(316002)(38100700002)(31696002)(86362001)(2616005)(53546011)(55236004)(6512007)(26005)(83380400001)(186003)(31686004)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RXWFBjbnRJK1NHQ1d6UXAyQ1Bpd0NCUFJwM0Q0cytYREI5dnFlcjRmT0hP?=
 =?utf-8?B?a0h4ZFVOU2VrTFNkYkhUZUVhTmxNbDRsYzRlR0ZoNHB3bEdCWTFITGNheTZI?=
 =?utf-8?B?TzZ4V2F3LzFMMWpLbWxENGwwcUhOY0MrdmVlNncwM3hyNGREVDZhUDVVUWRU?=
 =?utf-8?B?SURUUHI5WXM5L0wzV04rdWJBdXczYmJET3RFckErSTR0ZUtpemhJcy9DaVd6?=
 =?utf-8?B?U3M5WDFWWE5NZVpleU43Wnl6YkpRN1JhL0ErUEYzRGJMaFlpYXhNVlh4YkpU?=
 =?utf-8?B?ZkF4RVFCckdQUzlvYmhLaDBkdmpRMlg3ckJDWE01K2huUUpkSml5Q0VjWE9h?=
 =?utf-8?B?a3FXREZoQ3UyOGx2V2p4QTlQSXFab082d3IxeVh1djFLSmVFOXV3VnZLaHda?=
 =?utf-8?B?TGVrdTBvTmt2VjJvMVU1Q2hLUmtDa2tPNUdFZDdOUW9sR21EalVtRmw4cEc3?=
 =?utf-8?B?eDdpQ0hWMENOMW52RFh1cWRkMGFsYUora1R5bmhsUUo4RXQxczZBcHZLQllu?=
 =?utf-8?B?ekdmY1RFbVpRZWVsb285ZGdxSnlyT1RkVENqMnNzSS8wQ2RrZzFDQ3ViN0ZJ?=
 =?utf-8?B?d20wWTNIMk9HaTUvQ2F1TjhNV1BjZVFqMDlMekZBWUdrOFJDSStiSUFpOGUw?=
 =?utf-8?B?elhRQzN5WTRneHFkNnlUWjlwSHNMWHF0QUdYVUtQcHpnWk0wRlFzUVZ2VVVY?=
 =?utf-8?B?czRlb0R0TkFDcnNqVHFmUTlROTVDalRITTMzTHlGS2txN3NoZnJNNHJVNytL?=
 =?utf-8?B?K1RmRDFqQWlGbTd2UjZ4ZVlYYUxhdVVWNW5iMjBTYVR4dEhNYk5aamwveGtl?=
 =?utf-8?B?S2c1dGZaY0NPbkhCV2NFZUUzMG9MWVF2czZQOEp5MGE2dGpUeERxM2hVdC91?=
 =?utf-8?B?MGZDVzN5VzJqT1Bmc2cyUzlOb1pIdG94L2dybG5XZ3hhcWh0SlQxVVYyTGM0?=
 =?utf-8?B?RWxGZmlqRk5RK1hkdUtqZDlvbzdiRlZES2dQcFUyYUdtWDFzTC9GcDdnc0tW?=
 =?utf-8?B?VnE5Y1NVMmM2K0hma3U3SFVWUXllbVRDd2Y1ekxSN2RHdyt0VS84eklNRWIy?=
 =?utf-8?B?RXdxdlVGa1ZucGt6WDFueHU1M09iUzlITWVDZWh6V2JDNEp5Qnl5UkVYeFJ4?=
 =?utf-8?B?MHZqM3luMG52RGJXMVJ6S1dRT3JDR1FOSVRTWC9PU0NDMTA2MCtPWWNtUTlR?=
 =?utf-8?B?NE5LMlB6YVBTbkJBdFVQM0c3K2JiVGxIRGxBbk00T1VsK2VZckpQRFNXTElt?=
 =?utf-8?B?NGFoblRPRmRUaVp1ditSUDZaTUtveTN1QjlReVlxUzJVWUF2NFA4MGFyVHRs?=
 =?utf-8?B?K2FaRzNPclMyaTlmelpKdkVYalhDS0U1L3ZIbmw3cll6UFhDSlZiWnZWVWo5?=
 =?utf-8?B?Vnh5Kzd0WU5XVHpGN3FqNHc4TmkxM2NUam9VTDhnUksyVXVGU2tFZVEyMVpE?=
 =?utf-8?B?WnA1MVFZZytZOVo4K1ZuT0s4T0tva2hIVXpEcytpamJUbGt3dHVhakJDUFZG?=
 =?utf-8?B?VmdXalZ1OHpqMnNTYVlUcU9ZNmZjNGRQWjV5NVQ2UHh6TEpVdFQwZjFuWXJ6?=
 =?utf-8?B?K1hwOUhvaWRVNGxCTzF3d2dRSGZ6emgrMDlFREhkTEpmenRnWXBScFEzNVN1?=
 =?utf-8?B?akF2Umorc21Tb3hKMmc5a2pMb2ZSWWZSaWwxb3VlV0tHSDJydU9HZzVsbjdo?=
 =?utf-8?B?d2ZQSTFIMWt5RnRSamt2cTNxR2Q2Skl6K0wxU3Zmd0tUbSt3bzIzdjg3TnBC?=
 =?utf-8?B?VzhGL3Jwc1R6Und1Z0VrUWtIQUtOWWRlTzlsSlhjRUFwaFNYVk93MUdDSFJN?=
 =?utf-8?B?OEEyNHZoNS8zOVhEL1VXTUxpT0htRzNBeVZjd21XMXVRZWl2Q0FTYUJ2Y3Bz?=
 =?utf-8?B?US9kMkh4OUNBemxlLzltSnBPVDhjaEFMZEZRcFloeStFc3RGbjFNNXpJR1lk?=
 =?utf-8?B?a0lqMWwvQzk1ZHpCK3ZsMThGZTNqWnlXNnQ3SHRmaUtXcGpicUk2NmNtazBk?=
 =?utf-8?B?dlpCc21sV3FRMlFVUFpFa1pDeXhBdXZTWm5PWjNPdGY1bWtvK0RSMnF1QlJP?=
 =?utf-8?B?aEFwUEdwalpWV3ZROHBwTHNNZGNHV0xzYzFBZklFN0ZNbDZUR2pBNFMxbjdI?=
 =?utf-8?Q?E5UvyDnIn+4xyyBGaKytZPfni?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fed6757-584c-4483-4a7f-08daae8f708c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3395.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2022 09:27:12.1581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoPghSzrU0fxI8qfhUH4/PJIdA8llgB+uXcJwExSHAfCs8nRDzDbT76jdKYl3fqp1TgA0YOGHOTeJRMTgL3V4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8668
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 22:30, Luis Chamberlain wrote:
> On Mon, Sep 19, 2022 at 02:32:33PM +0200, Petr Pavlu wrote:
>> During a system boot, it can happen that the kernel receives a burst of
>> requests to insert the same module but loading it eventually fails
>> during its init call. 
> 
> Please take a look at kmod selftest lib/test_kmod.c and the respective shell
> selftest tools/testing/selftests/kmod/kmod.sh. Can you modify it to add
> support to reproduce this issue?

It was possible for me to write some kselftests for this. I will post them as
a separate patch in v3.

>> For instance, udev can make a request to insert
>> a frequency module for each individual CPU 
> 
> That seems stupid indeed, it would seem we should be able for sure to prevent
> such cases, it can't just be happening for frequency modules.

The issue was also observed with EDAC drivers which are similarly exclusive.

>> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
>> for modules that have finished loading"), the kernel already did merge
>> some of same load requests but it was more by accident and relied on
>> specific timing. The patch brings this behavior back in a more explicit
>> form.
> 
> I'm having a hard time with this, because it is not clear if you are
> suggesting this is a regression introduced by 6e6de3dee51a or not. I'd
> like you to evaluate the impact of *not* merging a fix to older kernels.
> In practice I think we'd end up with delays on boot, but is that all?
> Would boot ever fail? The commit log does not make that clear.
> 
> The commit log should make it clear if this a regression or not and the
> impact of not having these fixes merged. Please not that bots will try
> to scrape for fixes and I suspect bots will pour their heart out on this
> commit log and identify and assume this if a fix already as-is.

I touched on this somewhat in my response to review comments on v1 from Petr
Mladek [1] but it looks I failed to appropriately update the commit message
in the new version. I will try to improve it in v3.

The patch does address a regression observed after commit 6e6de3dee51a
("kernel/module.c: Only return -EEXIST for modules that have finished
loading"). I guess it can have a Fixes tag added to the patch.

To add more information, the following is a test from a machine with 288 CPUs
which I performed when preparing this patch. The system had Tumbleweed
20220829 installed on it. The boot process tried to load 288x pcc_cpufreq and
576x acpi_cpufreq modules which all failed because intel_pstate was already
active.

The test used three custom builds. The base was 6.0-rc3, 'revert' is
base + revert of 6e6de3dee51a, 'my' is base + the proposed fix. Compiled
modules were uncompressed and unsigned.

Each configuration had its boot tested 5 times. Time was measured from the
first load attempt of a given module to the last one, by simply looking at
messages such as "Inserted module 'acpi_cpufreq'" in the udev log and their
timestamps. All times are in seconds.

|      |                Configuration                        |
| Boot | base            | revert          | my              |
|   v  | pcc    | acpi   | pcc    | acpi   | pcc    | acpi   |
+------+--------+--------+--------+--------+--------+--------+
|   #1 | 45.374 | 45.462 |  1.992 |  8.509 |  2.190 |  6.931 |
|   #2 | 44.727 | 44.712 |  2.249 | 11.436 |  1.821 |  8.413 |
|   #3 | 45.450 | 45.771 |  1.685 |  8.784 |  1.964 |  6.341 |
|   #4 | 44.306 | 44.840 |  2.469 |  9.611 |  2.362 |  6.856 |
|   #5 | 45.132 | 45.216 |  2.063 |  8.782 |  1.717 |  6.405 |
+------+--------+--------+--------+--------+--------+--------+
|  Avg | 44.998 | 45.200 |  2.092 |  9.424 |  2.011 |  6.989 |

This shows the observed regression and results with the proposed fix.

> If this *is* a regression, we should try to see how perhaps we can split
> this up into a part which is mergable to stable and then a secondary
> part which  does some new fancy optimizations.

I think it is hard to split this patch into parts because the implemented
"optimization" is the fix.

[1] https://lore.kernel.org/linux-modules/0ccb384f-bbd5-f0fd-3832-c2255df505b2@suse.com/

Thanks,
Petr
